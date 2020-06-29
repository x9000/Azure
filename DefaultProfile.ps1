Function New-RegValue
{
	[CmdletBinding()]
	Param
	(
		[String] $RegPath,
		[String] $RegValueName,
		[String] $RegValue,
		[ValidateSet("String", "DWord", "MultiString", "ExpandString")]
		[String] $RegType
	)
	If(!(Test-Path -Path $RegPath))
	{
		Try
		{
			New-Item -Path $RegPath -Force
		}
		Catch
		{
			Write-Output "Problem creating $RegPath"
		}
	}
	Try
	{
		New-ItemProperty -Path $RegPath -Name $RegValueName -Value $RegValue -PropertyType $RegType -Force
	}
	Catch
	{
		Write-Output "Problem creating $Regvalue"
	}
}

REG LOAD HKLM\TEMP C:\Users\Default\NTUSER.DAT

#Turns off "Hide file extensions"
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValueName HideFileExt -RegType DWord -RegValue 0

#Always show menus in Windows Explorer
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValueName AlwaysShowMenus -RegType DWord -RegValue 1

#Hide the "People" from the TaskBar.
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -RegValueName PeopleBand -RegType DWord -RegValue 0

#Expands the control panel icons to the full small icons view.
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -RegValueName AllItemsIconView -RegType DWord -RegValue 1
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -RegValueName StartupPage -RegType DWord -RegValue 1

#OneDrive Setup for all new user profiles
#New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\RunOnce -RegValueName OneDriveSetup -RegType String -RegValue "C:\Windows\SysWOW64\OneDriveSetup.exe /silent"
REG DELETE HKLM\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -RegValueName OneDriveSetup

#Set Cortana to Icon
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Search -RegValueName SearchboxTaskbarMode -RegType DWord -RegValue 1

#Set Taskbar to single monitor
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -RegValueName MMTaskbarEnabled -RegType DWord -RegValue 0

#Disable adding accent colour to "Title bars and windows borders".
New-RegValue -RegPath HKLM:\TEMP\Microsoft\Windows\DWM -RegValueName ColorPrevalence -RegType DWord -RegValue 0

#Disable Outlook favorites in folder pane
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Office\16.0\Outlook\Preferences -RegValueName HideMailFavorites -RegType DWord -RegValue 1

#Suppress Office "Open File" format choice
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Office\16.0\Common\General -RegValueName ShownFileFmtPrompt -RegType DWord -RegValue 1

#Disable - "Show me the Windows welcome experience after updates..."
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValueName SubscribedContent-310093Enabled -RegType DWord -RegValue 0

#Disable - "Get tips, trick and suggestions as you use Windows"
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -RegValueName SubscribedContent-338389Enabled -RegType DWord -RegValue 0

#Use Light Theme
New-RegValue -RegPath HKLM:\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -RegValueName SystemUsesLightTheme -RegType DWord -RegValue 1

#Disable Apply Accent colour to Start, taskbar and action centre
#New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -RegValueName #ColorPrevalence -RegType DWord -RegValue 0

#Enable Transparency
New-RegValue -RegPath HKLM:\TEMP\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -RegValueName EnableTransparency -RegType DWord -RegValue 0

#Change System Regional Settings to UK-English
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName Locale -RegType String -RegValue "00000809"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName LocaleName -RegType String -RegValue "en-GB"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName sCountry -RegType String -RegValue "United Kingdom"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName sLanguage -RegType String -RegValue "ENG"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName sLongDate -RegType String -RegValue "dd MMMM yyyy"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName iCountry -RegType String -RegValue "44"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName iDate -RegType String -RegValue "1"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName iMeasure -RegType String -RegValue "0"
New-RegValue -RegPath HKLM:\TEMP\Control Panel\International -RegValueName iNegCurr -RegType String -RegValue "1"

REG UNLOAD HKLM\TEMP

#Set System Locale (May be duplicated from above)
Set-WinSystemLocale -SystemLocale en-GB
