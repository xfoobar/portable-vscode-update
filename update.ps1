# Stop script on error
$ErrorActionPreference = 'Stop'

# Application folder
$AppDir = $args[0]
# Latest stable version (Win32-x64)
$Url = 'https://update.code.visualstudio.com/latest/win32-x64-archive/stable'
# Downloaded zip file
$DownloadFile = [System.IO.Path]::GetTempFileName() + '.zip'
# Download and unlock file
Invoke-WebRequest -uri $Url -OutFile $DownloadFile
Unblock-File $DownloadFile
# Remove files, exclude {data,code.exe}, prevent affecting file associations and user data
Get-ChildItem -Path  $AppDir -exclude 'data', 'code.exe' | Remove-Item -force -recurse
# Unzip, overwrite code.exe
Expand-Archive -Force -Path $DownloadFile -DestinationPath $AppDir
# Remove temp file
Remove-Item -force -recurse $DownloadFile

Write-Output 'Finished.'