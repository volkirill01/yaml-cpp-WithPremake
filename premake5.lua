YAMLCPP_STATIC_LINKINK = true

project "yaml-cpp"
	if YAMLCPP_STATIC_LINKINK then
		kind "StaticLib"
	else
		kind "SharedLib"
	end
	language "C++"
	cppdialect "C++17"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/**.h",
		"src/**.cpp",
		
		"include/**.h"
	}

	includedirs
	{
		"include"
	}

	if YAMLCPP_STATIC_LINKINK then
		defines { "YAML_CPP_STATIC_DEFINE" }
	else
		defines { "YAML_CPP_DLL", "yaml_cpp_EXPORTS" }
	end

	filter "system:windows"
		systemversion "latest"
		
	filter "system:linux"
		pic "on"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "On"
		optimize "Off"

	filter "configurations:Release"
		runtime "Release"
		symbols "On"
		optimize "On"

	filter "configurations:Dist"
		runtime "Release"
		symbols "Off"
		optimize "Speed"
