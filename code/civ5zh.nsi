# Auto-generated by EclipseNSIS Script Wizard
# 2013/04/24 上午 10:21:09

!define NAME "civ5zh"
!define FULLNAME "Civilization V 正簡雙漢化"
!define VERSION "1.0.2.44b6"

Name "${FULLNAME} ${VERSION}"

# General Symbol Definitions
#!define REGKEY "SOFTWARE\$(^Name)"
!define REGKEY "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 8930"

# MUI Symbol Definitions
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_SHOWREADME $INSTDIR\civ5zh_readme.txt
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE
!define MUI_LANGDLL_REGISTRY_ROOT HKLM
!define MUI_LANGDLL_REGISTRY_KEY ${REGKEY}
!define MUI_LANGDLL_REGISTRY_VALUENAME InstallerLanguage

# Included files
!include Sections.nsh
!include MUI2.nsh

# Reserved Files
!insertmacro MUI_RESERVEFILE_LANGDLL

# Installer pages
!insertmacro MUI_PAGE_WELCOME       # 歡迎頁面
!insertmacro MUI_PAGE_DIRECTORY     # 路徑選擇頁面
!insertmacro MUI_PAGE_INSTFILES     # 執行安裝頁面
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM     # 移除確認頁面
!insertmacro MUI_UNPAGE_INSTFILES   # 執行移除頁面

# Installer languages
!insertmacro MUI_LANGUAGE English
!insertmacro MUI_LANGUAGE TradChinese
!insertmacro MUI_LANGUAGE SimpChinese

# Installer attributes
OutFile "${NAME}_setup-${VERSION}.exe"
InstallDir "$PROGRAMFILES\sid meier's civilization v\"
CRCCheck on
XPStyle on
ShowInstDetails show
InstallDirRegKey HKLM "${REGKEY}" InstallLocation
ShowUninstDetails show


!macro COPY_TO_DLC DLC_NAME
    IfFileExists "$INSTDIR\assets\DLC\${DLC_NAME}" 0 +3
        SetOutPath "$INSTDIR\assets\DLC\${DLC_NAME}\Gameplay\XML\Text"
        File /r "output\Assets\DLC\${DLC_NAME}\Gameplay\XML\Text\*"
!macroend

!macro REMOVE_FROM_DLC DLC_NAME
    IfFileExists "$INSTDIR\assets\DLC\${DLC_NAME}" 0 +3
        RMDir /r "$INSTDIR\assets\DLC\${DLC_NAME}\Gameplay\XML\Text\zh_CN"
        RMDir /r "$INSTDIR\assets\DLC\${DLC_NAME}\Gameplay\XML\Text\zh_TW"
!macroend


# Installer sections
Section -Main SEC0000
    SetOutPath $INSTDIR
    SetOverwrite on
    # 備份檔案
    CreateDirectory "$INSTDIR\${NAME}\assets\UI\Fonts\Tw Cent MT"
    CreateDirectory "$INSTDIR\${NAME}\assets\UI\Options"
    CreateDirectory "$INSTDIR\${NAME}\assets\DLC\Expansion\UI\Options"
    Rename "$INSTDIR\assets\UI\Fonts\Tw Cent MT\TwCenMT14.ggxml" "$INSTDIR\${NAME}\assets\UI\Fonts\Tw Cent MT\TwCenMT14.ggxml"
    Rename "$INSTDIR\assets\UI\Options\OptionsMenu.xml" "$INSTDIR\${NAME}\assets\UI\Options\OptionsMenu.xml"
    Rename "$INSTDIR\assets\DLC\Expansion\UI\Options\OptionsMenu.xml" "$INSTDIR\${NAME}\assets\DLC\Expansion\UI\Options\OptionsMenu.xml"
    CreateDirectory "$INSTDIR\${NAME}\assets\SQL"
    Rename "$INSTDIR\assets\SQL\Civ5DlcLocalizationDatabaseSchema.sql" "$INSTDIR\${NAME}\assets\SQL\Civ5DlcLocalizationDatabaseSchema.sql"
    Rename "$INSTDIR\assets\SQL\Civ5LocalizationDatabaseSchema.sql" "$INSTDIR\${NAME}\assets\SQL\Civ5LocalizationDatabaseSchema.sql"
    # 複製需覆蓋的檔案
    SetOutPath "$INSTDIR\assets\UI\Fonts\Tw Cent MT"
    File "output\Assets\UI\Fonts\Tw Cent MT\TwCenMT14.ggxml"
    SetOutPath "$INSTDIR\assets\UI\Options"
    File "output\Assets\UI\Options\OptionsMenu.xml"
    SetOutPath "$INSTDIR\assets\DLC\Expansion\UI\Options"
    File "output\Assets\DLC\Expansion\UI\Options\OptionsMenu.xml"
    SetOutPath "$INSTDIR\${NAME}"
    File "readme.txt"
    SetOutPath "$INSTDIR\assets\SQL"
    File "output\Assets\SQL\Civ5DlcLocalizationDatabaseSchema.sql"
    File "output\Assets\SQL\Civ5LocalizationDatabaseSchema.sql"
    # 複製遊戲主要文字
    SetOutPath "$INSTDIR\assets\Gameplay\XML\NewText"
    File /r "output\Assets\Gameplay\XML\NewText\*"
    # 複製 DLC 文字
    !insertmacro COPY_TO_DLC DLC_01
    !insertmacro COPY_TO_DLC DLC_02
    !insertmacro COPY_TO_DLC DLC_03
    !insertmacro COPY_TO_DLC DLC_04
    !insertmacro COPY_TO_DLC DLC_05
    !insertmacro COPY_TO_DLC DLC_06
    !insertmacro COPY_TO_DLC DLC_Deluxe
    !insertmacro COPY_TO_DLC Expansion
    !insertmacro COPY_TO_DLC Expansion\DLC\DLC_01
    !insertmacro COPY_TO_DLC Expansion\DLC\DLC_02
    !insertmacro COPY_TO_DLC Expansion\DLC\DLC_03
    !insertmacro COPY_TO_DLC Expansion\DLC\DLC_04
    !insertmacro COPY_TO_DLC Expansion\DLC\DLC_05
    !insertmacro COPY_TO_DLC Expansion\DLC\DLC_Deluxe
    !insertmacro COPY_TO_DLC Shared
    # 複製其他檔案
    SetOutPath $INSTDIR
    File civ5zh_readme.txt
#    WriteRegStr HKLM "${REGKEY}\Components" Main 1
SectionEnd

Section -post SEC0001
#    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    SetOutPath $INSTDIR
    WriteUninstaller $INSTDIR\${NAME}_uninstall.exe
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section -un.Main UNSEC0000
    # 移除其他檔案
    Delete /REBOOTOK "$INSTDIR\civ5zh_readme.txt"
    # 移除 DLC 文字
    !insertmacro REMOVE_FROM_DLC DLC_01
    !insertmacro REMOVE_FROM_DLC DLC_02
    !insertmacro REMOVE_FROM_DLC DLC_03
    !insertmacro REMOVE_FROM_DLC DLC_04
    !insertmacro REMOVE_FROM_DLC DLC_05
    !insertmacro REMOVE_FROM_DLC DLC_06
    !insertmacro REMOVE_FROM_DLC DLC_Deluxe
    !insertmacro REMOVE_FROM_DLC Expansion
    !insertmacro REMOVE_FROM_DLC Expansion\DLC\DLC_01
    !insertmacro REMOVE_FROM_DLC Expansion\DLC\DLC_02
    !insertmacro REMOVE_FROM_DLC Expansion\DLC\DLC_03
    !insertmacro REMOVE_FROM_DLC Expansion\DLC\DLC_04
    !insertmacro REMOVE_FROM_DLC Expansion\DLC\DLC_05
    !insertmacro REMOVE_FROM_DLC Expansion\DLC\DLC_Deluxe
    !insertmacro REMOVE_FROM_DLC Shared
    # 移除遊戲主要文字
    RMDir /r "$INSTDIR\assets\Gameplay\XML\NewText\zh_CN"
    RMDir /r "$INSTDIR\assets\Gameplay\XML\NewText\zh_TW"
    Delete "$INSTDIR\assets\Gameplay\XML\NewText\ChineseSimp.xml"
    Delete "$INSTDIR\assets\Gameplay\XML\NewText\ChineseTrad.xml"
    Delete "$INSTDIR\assets\Gameplay\XML\NewText\CIV5Credits_zh_CN.txt"
    Delete "$INSTDIR\assets\Gameplay\XML\NewText\CIV5Credits_zh_TW.txt"
    # 還原備份與刪除備份
    Delete "$INSTDIR\assets\UI\Fonts\Tw Cent MT\TwCenMT14.ggxml"
    Delete "$INSTDIR\assets\UI\Options\OptionsMenu.xml"
    Delete "$INSTDIR\assets\DLC\Expansion\UI\Options\OptionsMenu.xml"
    Rename "$INSTDIR\${NAME}\assets\UI\Fonts\Tw Cent MT\TwCenMT14.ggxml" "$INSTDIR\assets\UI\Fonts\Tw Cent MT\TwCenMT14.ggxml"
    Rename "$INSTDIR\${NAME}\assets\UI\Options\OptionsMenu.xml" "$INSTDIR\assets\UI\Options\OptionsMenu.xml"
    Rename "$INSTDIR\${NAME}\assets\DLC\Expansion\UI\Options\OptionsMenu.xml" "$INSTDIR\assets\DLC\Expansion\UI\Options\OptionsMenu.xml"
    #Delete and Rename SQLs
    Delete "$INSTDIR\assets\SQL\Civ5LocalizationDatabaseSchema.sql"
    Delete "$INSTDIR\assets\SQL\Civ5DlcLocalizationDatabaseSchema.sql"
    Rename "$INSTDIR\${NAME}\assets\SQL\Civ5LocalizationDatabaseSchema.sql" "$INSTDIR\assets\SQL\Civ5LocalizationDatabaseSchema.sql"
    Rename "$INSTDIR\${NAME}\assets\SQL\Civ5DlcLocalizationDatabaseSchema.sql" "$INSTDIR\assets\SQL\Civ5DlcLocalizationDatabaseSchema.sql"
    RmDir /r "$INSTDIR\${NAME}"
    # 移除自身
    Delete /REBOOTOK "$INSTDIR\${NAME}_uninstall.exe"
#    RmDir /r /REBOOTOK $INSTDIR
#    DeleteRegValue HKLM "${REGKEY}\Components" Main
SectionEnd

Section -un.post UNSEC0001
    Delete /REBOOTOK "$EXEDIR\${NAME}_uninstall.exe"
#    DeleteRegValue HKLM "${REGKEY}" Path
#    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
#    DeleteRegKey /IfEmpty HKLM "${REGKEY}"
#    RmDir /REBOOTOK $INSTDIR
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
    !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

# Uninstaller functions
Function un.onInit
#    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    !insertmacro MUI_UNGETLANGUAGE
#    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd

