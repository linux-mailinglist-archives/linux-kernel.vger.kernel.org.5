Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2484878E9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjHaKIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjHaKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:08:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8345CED;
        Thu, 31 Aug 2023 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693476527; x=1725012527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JYnmIP131W7hK/vvF16OeukR28iDI2M/l+jdaISWJ+w=;
  b=RWf8vF3GpbNCdHEHdQJrlRxStddp/pu9UaBHaB05mtgAxXCAsB59nYxb
   JoC+kQ0rg/l37J8cRx69MB1wfao6zTOuAJ+rp8Hi9uA6AeSzAfw7cNt4Z
   GkfQO0GigWwlfpfBvxl2paYi/g3oWJd6kLm+hvl2v9dZxmU+VMdyxtgle
   ebLkE+fyxE8Y9LbUVWbxjrHsNHD6LFeSK9AK5ZmU2p+JPEnh9+TuSYajz
   EekY3dgeNR7Uk0qLvVQiJ9foWeisAyFh5W8YsdgWAMFDX8BsrhyBf/dk8
   gUqr5eIUTeeDM18SBPDPIiDZlO/2dndc3yvkyGfwD9zPqNNHudsJbTEZY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="442252355"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="442252355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716284010"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="716284010"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2023 03:08:44 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbebS-00001F-0p;
        Thu, 31 Aug 2023 10:08:42 +0000
Date:   Thu, 31 Aug 2023 18:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] hwmon: add POWER-Z driver
Message-ID: <202308311825.k4rhexnc-lkp@intel.com>
References: <20230831-powerz-v1-1-03979e519f52@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-powerz-v1-1-03979e519f52@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on b97d64c722598ffed42ece814a2cb791336c6679]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/hwmon-add-POWER-Z-driver/20230831-164650
base:   b97d64c722598ffed42ece814a2cb791336c6679
patch link:    https://lore.kernel.org/r/20230831-powerz-v1-1-03979e519f52%40weissschuh.net
patch subject: [PATCH] hwmon: add POWER-Z driver
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308311825.k4rhexnc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308311825.k4rhexnc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/Kconfig:844: syntax error
   drivers/hwmon/Kconfig:843:warning: ignoring unsupported character ';'
   drivers/hwmon/Kconfig:843: invalid statement
   drivers/hwmon/Kconfig:844: invalid statement
   drivers/hwmon/Kconfig:845: invalid statement
   drivers/hwmon/Kconfig:846: unknown statement "If"
   drivers/hwmon/Kconfig:847:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:847: unknown statement "USB-C"
   drivers/hwmon/Kconfig:849:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:849:warning: ignoring unsupported character ','
   drivers/hwmon/Kconfig:849: unknown statement "This"
   drivers/hwmon/Kconfig:850:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:850: unknown statement "will"
   make[3]: *** [scripts/kconfig/Makefile:77: allmodconfig] Error 1
   make[2]: *** [Makefile:706: allmodconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'allmodconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'allmodconfig' not remade because of errors.
--
>> drivers/hwmon/Kconfig:844: syntax error
   drivers/hwmon/Kconfig:843:warning: ignoring unsupported character ';'
   drivers/hwmon/Kconfig:843: invalid statement
   drivers/hwmon/Kconfig:844: invalid statement
   drivers/hwmon/Kconfig:845: invalid statement
   drivers/hwmon/Kconfig:846: unknown statement "If"
   drivers/hwmon/Kconfig:847:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:847: unknown statement "USB-C"
   drivers/hwmon/Kconfig:849:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:849:warning: ignoring unsupported character ','
   drivers/hwmon/Kconfig:849: unknown statement "This"
   drivers/hwmon/Kconfig:850:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:850: unknown statement "will"
   make[3]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[2]: *** [Makefile:706: oldconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> drivers/hwmon/Kconfig:844: syntax error
   drivers/hwmon/Kconfig:843:warning: ignoring unsupported character ';'
   drivers/hwmon/Kconfig:843: invalid statement
   drivers/hwmon/Kconfig:844: invalid statement
   drivers/hwmon/Kconfig:845: invalid statement
   drivers/hwmon/Kconfig:846: unknown statement "If"
   drivers/hwmon/Kconfig:847:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:847: unknown statement "USB-C"
   drivers/hwmon/Kconfig:849:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:849:warning: ignoring unsupported character ','
   drivers/hwmon/Kconfig:849: unknown statement "This"
   drivers/hwmon/Kconfig:850:warning: ignoring unsupported character '.'
   drivers/hwmon/Kconfig:850: unknown statement "will"
   make[3]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[2]: *** [Makefile:706: olddefconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +844 drivers/hwmon/Kconfig

    40	
    41	config SENSORS_ABITUGURU
    42		tristate "Abit uGuru (rev 1 & 2)"
    43		depends on X86 && DMI
    44		help
    45		  If you say yes here you get support for the sensor part of the first
    46		  and second revision of the Abit uGuru chip. The voltage and frequency
    47		  control parts of the Abit uGuru are not supported. The Abit uGuru
    48		  chip can be found on Abit uGuru featuring motherboards (most modern
    49		  Abit motherboards from before end 2005). For more info and a list
    50		  of which motherboards have which revision see
    51		  Documentation/hwmon/abituguru.rst
    52	
    53		  This driver can also be built as a module. If so, the module
    54		  will be called abituguru.
    55	
    56	config SENSORS_ABITUGURU3
    57		tristate "Abit uGuru (rev 3)"
    58		depends on X86 && DMI
    59		help
    60		  If you say yes here you get support for the sensor part of the
    61		  third revision of the Abit uGuru chip. Only reading the sensors
    62		  and their settings is supported. The third revision of the Abit
    63		  uGuru chip can be found on recent Abit motherboards (since end
    64		  2005). For more info and a list of which motherboards have which
    65		  revision see Documentation/hwmon/abituguru3.rst
    66	
    67		  This driver can also be built as a module. If so, the module
    68		  will be called abituguru3.
    69	
    70	config SENSORS_SMPRO
    71		tristate "Ampere's Altra SMpro hardware monitoring driver"
    72		depends on MFD_SMPRO
    73		help
    74		  If you say yes here you get support for the thermal, voltage,
    75		  current and power sensors of Ampere's Altra processor family SoC
    76		  with SMpro co-processor.
    77	
    78	config SENSORS_AD7314
    79		tristate "Analog Devices AD7314 and compatibles"
    80		depends on SPI
    81		help
    82		  If you say yes here you get support for the Analog Devices
    83		  AD7314, ADT7301 and ADT7302 temperature sensors.
    84	
    85		  This driver can also be built as a module. If so, the module
    86		  will be called ad7314.
    87	
    88	config SENSORS_AD7414
    89		tristate "Analog Devices AD7414"
    90		depends on I2C
    91		help
    92		  If you say yes here you get support for the Analog Devices
    93		  AD7414 temperature monitoring chip.
    94	
    95		  This driver can also be built as a module. If so, the module
    96		  will be called ad7414.
    97	
    98	config SENSORS_AD7418
    99		tristate "Analog Devices AD7416, AD7417 and AD7418"
   100		depends on I2C
   101		help
   102		  If you say yes here you get support for the Analog Devices
   103		  AD7416, AD7417 and AD7418 temperature monitoring chips.
   104	
   105		  This driver can also be built as a module. If so, the module
   106		  will be called ad7418.
   107	
   108	config SENSORS_ADM1021
   109		tristate "Analog Devices ADM1021 and compatibles"
   110		depends on I2C
   111		depends on SENSORS_LM90=n
   112		help
   113		  If you say yes here you get support for Analog Devices ADM1021
   114		  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
   115		  Genesys Logic GL523SM, National Semiconductor LM84 and TI THMC10.
   116	
   117		  This driver can also be built as a module. If so, the module
   118		  will be called adm1021.
   119	
   120	config SENSORS_ADM1025
   121		tristate "Analog Devices ADM1025 and compatibles"
   122		depends on I2C
   123		select HWMON_VID
   124		help
   125		  If you say yes here you get support for Analog Devices ADM1025
   126		  and Philips NE1619 sensor chips.
   127	
   128		  This driver can also be built as a module. If so, the module
   129		  will be called adm1025.
   130	
   131	config SENSORS_ADM1026
   132		tristate "Analog Devices ADM1026 and compatibles"
   133		depends on I2C
   134		select HWMON_VID
   135		help
   136		  If you say yes here you get support for Analog Devices ADM1026
   137		  sensor chip.
   138	
   139		  This driver can also be built as a module. If so, the module
   140		  will be called adm1026.
   141	
   142	config SENSORS_ADM1029
   143		tristate "Analog Devices ADM1029"
   144		depends on I2C
   145		help
   146		  If you say yes here you get support for Analog Devices ADM1029
   147		  sensor chip.
   148		  Very rare chip, please let us know you use it.
   149	
   150		  This driver can also be built as a module. If so, the module
   151		  will be called adm1029.
   152	
   153	config SENSORS_ADM1031
   154		tristate "Analog Devices ADM1031 and compatibles"
   155		depends on I2C
   156		help
   157		  If you say yes here you get support for Analog Devices ADM1031
   158		  and ADM1030 sensor chips.
   159	
   160		  This driver can also be built as a module. If so, the module
   161		  will be called adm1031.
   162	
   163	config SENSORS_ADM1177
   164		tristate "Analog Devices ADM1177 and compatibles"
   165		depends on I2C
   166		help
   167		  If you say yes here you get support for Analog Devices ADM1177
   168		  sensor chips.
   169	
   170		  This driver can also be built as a module.  If so, the module
   171		  will be called adm1177.
   172	
   173	config SENSORS_ADM9240
   174		tristate "Analog Devices ADM9240 and compatibles"
   175		depends on I2C
   176		select HWMON_VID
   177		help
   178		  If you say yes here you get support for Analog Devices ADM9240,
   179		  Dallas DS1780, National Semiconductor LM81 sensor chips.
   180	
   181		  This driver can also be built as a module. If so, the module
   182		  will be called adm9240.
   183	
   184	config SENSORS_ADT7X10
   185		tristate
   186		select REGMAP
   187		help
   188		  This module contains common code shared by the ADT7310/ADT7320 and
   189		  ADT7410/ADT7420 temperature monitoring chip drivers.
   190	
   191		  If built as a module, the module will be called adt7x10.
   192	
   193	config SENSORS_ADT7310
   194		tristate "Analog Devices ADT7310/ADT7320"
   195		depends on SPI_MASTER
   196		select SENSORS_ADT7X10
   197		help
   198		  If you say yes here you get support for the Analog Devices
   199		  ADT7310 and ADT7320 temperature monitoring chips.
   200	
   201		  This driver can also be built as a module. If so, the module
   202		  will be called adt7310.
   203	
   204	config SENSORS_ADT7410
   205		tristate "Analog Devices ADT7410/ADT7420"
   206		depends on I2C
   207		select SENSORS_ADT7X10
   208		help
   209		  If you say yes here you get support for the Analog Devices
   210		  ADT7410 and ADT7420 temperature monitoring chips.
   211	
   212		  This driver can also be built as a module. If so, the module
   213		  will be called adt7410.
   214	
   215	config SENSORS_ADT7411
   216		tristate "Analog Devices ADT7411"
   217		depends on I2C
   218		help
   219		  If you say yes here you get support for the Analog Devices
   220		  ADT7411 voltage and temperature monitoring chip.
   221	
   222		  This driver can also be built as a module. If so, the module
   223		  will be called adt7411.
   224	
   225	config SENSORS_ADT7462
   226		tristate "Analog Devices ADT7462"
   227		depends on I2C
   228		help
   229		  If you say yes here you get support for the Analog Devices
   230		  ADT7462 temperature monitoring chips.
   231	
   232		  This driver can also be built as a module. If so, the module
   233		  will be called adt7462.
   234	
   235	config SENSORS_ADT7470
   236		tristate "Analog Devices ADT7470"
   237		depends on I2C
   238		help
   239		  If you say yes here you get support for the Analog Devices
   240		  ADT7470 temperature monitoring chips.
   241	
   242		  This driver can also be built as a module. If so, the module
   243		  will be called adt7470.
   244	
   245	config SENSORS_ADT7475
   246		tristate "Analog Devices ADT7473, ADT7475, ADT7476 and ADT7490"
   247		depends on I2C
   248		select HWMON_VID
   249		help
   250		  If you say yes here you get support for the Analog Devices
   251		  ADT7473, ADT7475, ADT7476 and ADT7490 hardware monitoring
   252		  chips.
   253	
   254		  This driver can also be built as a module. If so, the module
   255		  will be called adt7475.
   256	
   257	config SENSORS_AHT10
   258		tristate "Aosong AHT10, AHT20"
   259		depends on I2C
   260		select CRC8
   261		help
   262		  If you say yes here, you get support for the Aosong AHT10 and AHT20
   263		  temperature and humidity sensors
   264	
   265		  This driver can also be built as a module. If so, the module
   266		  will be called aht10.
   267	
   268	config SENSORS_AQUACOMPUTER_D5NEXT
   269		tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, Farbwerk 360, High Flow Next"
   270		depends on USB_HID
   271		select CRC16
   272		help
   273		  If you say yes here you get support for sensors and fans of
   274		  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
   275		  controllers, Farbwerk and Farbwerk 360 RGB controllers, High Flow
   276		  Next sensor, where available.
   277	
   278		  This driver can also be built as a module. If so, the module
   279		  will be called aquacomputer_d5next.
   280	
   281	config SENSORS_AS370
   282		tristate "Synaptics AS370 SoC hardware monitoring driver"
   283		help
   284		  If you say yes here you get support for the PVT sensors of
   285		  the Synaptics AS370 SoC
   286	
   287		  This driver can also be built as a module. If so, the module
   288		  will be called as370-hwmon.
   289	
   290	
   291	config SENSORS_ASC7621
   292		tristate "Andigilog aSC7621"
   293		depends on I2C
   294		help
   295		  If you say yes here you get support for the aSC7621
   296		  family of SMBus sensors chip found on most Intel X38, X48, X58,
   297		  945, 965 and 975 desktop boards.  Currently supported chips:
   298		  aSC7621
   299		  aSC7621a
   300	
   301		  This driver can also be built as a module. If so, the module
   302		  will be called asc7621.
   303	
   304	config SENSORS_AXI_FAN_CONTROL
   305		tristate "Analog Devices FAN Control HDL Core driver"
   306		help
   307		  If you say yes here you get support for the Analog Devices
   308		  AXI HDL FAN monitoring core.
   309	
   310		  This driver can also be built as a module. If so, the module
   311		  will be called axi-fan-control
   312	
   313	config SENSORS_K8TEMP
   314		tristate "AMD Athlon64/FX or Opteron temperature sensor"
   315		depends on X86 && PCI
   316		help
   317		  If you say yes here you get support for the temperature
   318		  sensor(s) inside your CPU. Supported is whole AMD K8
   319		  microarchitecture. Please note that you will need at least
   320		  lm-sensors 2.10.1 for proper userspace support.
   321	
   322		  This driver can also be built as a module. If so, the module
   323		  will be called k8temp.
   324	
   325	config SENSORS_K10TEMP
   326		tristate "AMD Family 10h+ temperature sensor"
   327		depends on X86 && PCI && AMD_NB
   328		help
   329		  If you say yes here you get support for the temperature
   330		  sensor(s) inside your CPU. Supported are later revisions of
   331		  the AMD Family 10h and all revisions of the AMD Family 11h,
   332		  12h (Llano), 14h (Brazos), 15h (Bulldozer/Trinity/Kaveri/Carrizo)
   333		  and 16h (Kabini/Mullins) microarchitectures.
   334	
   335		  This driver can also be built as a module. If so, the module
   336		  will be called k10temp.
   337	
   338	config SENSORS_FAM15H_POWER
   339		tristate "AMD Family 15h processor power"
   340		depends on X86 && PCI && CPU_SUP_AMD
   341		help
   342		  If you say yes here you get support for processor power
   343		  information of your AMD family 15h CPU.
   344	
   345		  This driver can also be built as a module. If so, the module
   346		  will be called fam15h_power.
   347	
   348	config SENSORS_APPLESMC
   349		tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
   350		depends on INPUT && X86
   351		select NEW_LEDS
   352		select LEDS_CLASS
   353		help
   354		  This driver provides support for the Apple System Management
   355		  Controller, which provides an accelerometer (Apple Sudden Motion
   356		  Sensor), light sensors, temperature sensors, keyboard backlight
   357		  control and fan control.
   358	
   359		  Only Intel-based Apple's computers are supported (MacBook Pro,
   360		  MacBook, MacMini).
   361	
   362		  Data from the different sensors, keyboard backlight control and fan
   363		  control are accessible via sysfs.
   364	
   365		  This driver also provides an absolute input class device, allowing
   366		  the laptop to act as a pinball machine-esque joystick.
   367	
   368		  Say Y here if you have an applicable laptop and want to experience
   369		  the awesome power of applesmc.
   370	
   371	config SENSORS_ARM_SCMI
   372		tristate "ARM SCMI Sensors"
   373		depends on ARM_SCMI_PROTOCOL
   374		depends on THERMAL || !THERMAL_OF
   375		help
   376		  This driver provides support for temperature, voltage, current
   377		  and power sensors available on SCMI based platforms. The actual
   378		  number and type of sensors exported depend on the platform.
   379	
   380		  This driver can also be built as a module. If so, the module
   381		  will be called scmi-hwmon.
   382	
   383	config SENSORS_ARM_SCPI
   384		tristate "ARM SCPI Sensors"
   385		depends on ARM_SCPI_PROTOCOL
   386		depends on THERMAL || !THERMAL_OF
   387		help
   388		  This driver provides support for temperature, voltage, current
   389		  and power sensors available on ARM Ltd's SCP based platforms. The
   390		  actual number and type of sensors exported depend on the platform.
   391	
   392	config SENSORS_ASB100
   393		tristate "Asus ASB100 Bach"
   394		depends on (X86 || COMPILE_TEST) && I2C
   395		select HWMON_VID
   396		help
   397		  If you say yes here you get support for the ASB100 Bach sensor
   398		  chip found on some Asus mainboards.
   399	
   400		  This driver can also be built as a module. If so, the module
   401		  will be called asb100.
   402	
   403	config SENSORS_ASPEED
   404		tristate "ASPEED AST2400/AST2500 PWM and Fan tach driver"
   405		depends on ARCH_ASPEED || COMPILE_TEST
   406		depends on THERMAL || THERMAL=n
   407		select REGMAP
   408		help
   409		  This driver provides support for ASPEED AST2400/AST2500 PWM
   410		  and Fan Tacho controllers.
   411	
   412		  This driver can also be built as a module. If so, the module
   413		  will be called aspeed_pwm_tacho.
   414	
   415	config SENSORS_ATXP1
   416		tristate "Attansic ATXP1 VID controller"
   417		depends on I2C
   418		select HWMON_VID
   419		help
   420		  If you say yes here you get support for the Attansic ATXP1 VID
   421		  controller.
   422	
   423		  If your board have such a chip, you are able to control your CPU
   424		  core and other voltages.
   425	
   426		  This driver can also be built as a module. If so, the module
   427		  will be called atxp1.
   428	
   429	config SENSORS_BT1_PVT
   430		tristate "Baikal-T1 Process, Voltage, Temperature sensor driver"
   431		depends on MIPS_BAIKAL_T1 || COMPILE_TEST
   432		select POLYNOMIAL
   433		help
   434		  If you say yes here you get support for Baikal-T1 PVT sensor
   435		  embedded into the SoC.
   436	
   437		  This driver can also be built as a module. If so, the module will be
   438		  called bt1-pvt.
   439	
   440	config SENSORS_BT1_PVT_ALARMS
   441		bool "Enable Baikal-T1 PVT sensor alarms"
   442		depends on SENSORS_BT1_PVT
   443		help
   444		  Baikal-T1 PVT IP-block provides threshold registers for each
   445		  supported sensor. But the corresponding interrupts might be
   446		  generated by the thresholds comparator only in synchronization with
   447		  a data conversion. Additionally there is only one sensor data can
   448		  be converted at a time. All of these makes the interface impossible
   449		  to be used for the hwmon alarms implementation without periodic
   450		  switch between the PVT sensors. By default the data conversion is
   451		  performed on demand from the user-space. If this config is enabled
   452		  the data conversion will be periodically performed and the data will be
   453		  saved in the internal driver cache.
   454	
   455	config SENSORS_CORSAIR_CPRO
   456		tristate "Corsair Commander Pro controller"
   457		depends on HID
   458		help
   459		  If you say yes here you get support for the Corsair Commander Pro
   460		  controller.
   461	
   462		  This driver can also be built as a module. If so, the module
   463		  will be called corsair-cpro.
   464	
   465	config SENSORS_CORSAIR_PSU
   466		tristate "Corsair PSU HID controller"
   467		depends on HID
   468		help
   469		  If you say yes here you get support for Corsair PSUs with a HID
   470		  interface.
   471		  Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
   472		  (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
   473		  by Corsair.
   474	
   475		  This driver can also be built as a module. If so, the module
   476		  will be called corsair-psu.
   477	
   478	config SENSORS_DRIVETEMP
   479		tristate "Hard disk drives with temperature sensors"
   480		depends on SCSI && ATA
   481		help
   482		  If you say yes you get support for the temperature sensor on
   483		  hard disk drives.
   484	
   485		  This driver can also be built as a module. If so, the module
   486		  will be called drivetemp.
   487	
   488	config SENSORS_DS620
   489		tristate "Dallas Semiconductor DS620"
   490		depends on I2C
   491		help
   492		  If you say yes here you get support for Dallas Semiconductor
   493		  DS620 sensor chip.
   494	
   495		  This driver can also be built as a module. If so, the module
   496		  will be called ds620.
   497	
   498	config SENSORS_DS1621
   499		tristate "Dallas Semiconductor DS1621 and compatibles"
   500		depends on I2C
   501		help
   502		  If you say yes here you get support for Dallas Semiconductor/Maxim
   503		  Integrated DS1621 sensor chips and compatible models including:
   504	
   505		  - Dallas Semiconductor DS1625
   506		  - Maxim Integrated DS1631
   507		  - Maxim Integrated DS1721
   508		  - Maxim Integrated DS1731
   509	
   510		  This driver can also be built as a module. If so, the module
   511		  will be called ds1621.
   512	
   513	config SENSORS_DELL_SMM
   514		tristate "Dell laptop SMM BIOS hwmon driver"
   515		depends on X86
   516		imply THERMAL
   517		help
   518		  This hwmon driver adds support for reporting temperature of different
   519		  sensors and controls the fans on Dell laptops via System Management
   520		  Mode provided by Dell BIOS.
   521	
   522		  When option I8K is also enabled this driver provides legacy /proc/i8k
   523		  userspace interface for i8kutils package.
   524	
   525	config I8K
   526		bool "Legacy /proc/i8k interface of Dell laptop SMM BIOS hwmon driver"
   527		depends on SENSORS_DELL_SMM
   528		depends on PROC_FS
   529		help
   530		  This option enables the legacy /proc/i8k userspace interface of the
   531		  dell-smm-hwmon driver. The character file /proc/i8k exposes the BIOS
   532		  version, temperatures and allows control of fan speeds of some Dell
   533		  laptops. Sometimes it also reports power and hotkey status.
   534	
   535		  This interface is required to run programs from the i8kutils package.
   536	
   537		  Say Y if you intend to run userspace programs that use this interface.
   538		  Say N otherwise.
   539	
   540	config SENSORS_DA9052_ADC
   541		tristate "Dialog DA9052/DA9053 ADC"
   542		depends on PMIC_DA9052
   543		help
   544		  Say y here to support the ADC found on Dialog Semiconductor
   545		  DA9052-BC and DA9053-AA/Bx PMICs.
   546	
   547		  This driver can also be built as module. If so, the module
   548		  will be called da9052-hwmon.
   549	
   550	config SENSORS_DA9055
   551		tristate "Dialog Semiconductor DA9055 ADC"
   552		depends on MFD_DA9055
   553		help
   554		  If you say yes here you get support for ADC on the Dialog
   555		  Semiconductor DA9055 PMIC.
   556	
   557		  This driver can also be built as a module. If so, the module
   558		  will be called da9055-hwmon.
   559	
   560	config SENSORS_I5K_AMB
   561		tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
   562		depends on PCI
   563		help
   564		  If you say yes here you get support for FB-DIMM AMB temperature
   565		  monitoring chips on systems with the Intel 5000 series chipset.
   566	
   567		  This driver can also be built as a module. If so, the module
   568		  will be called i5k_amb.
   569	
   570	config SENSORS_SPARX5
   571		tristate "Sparx5 SoC temperature sensor"
   572		depends on ARCH_SPARX5 || COMPILE_TEST
   573		help
   574		  If you say yes here you get support for temperature monitoring
   575		  with the Microchip Sparx5 SoC.
   576	
   577		  This driver can also be built as a module. If so, the module
   578		  will be called sparx5-temp.
   579	
   580	config SENSORS_F71805F
   581		tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
   582		depends on !PPC
   583		help
   584		  If you say yes here you get support for hardware monitoring
   585		  features of the Fintek F71805F/FG, F71806F/FG and F71872F/FG
   586		  Super-I/O chips.
   587	
   588		  This driver can also be built as a module. If so, the module
   589		  will be called f71805f.
   590	
   591	config SENSORS_F71882FG
   592		tristate "Fintek F71882FG and compatibles"
   593		depends on !PPC
   594		help
   595		  If you say yes here you get support for hardware monitoring
   596		  features of many Fintek Super-I/O (LPC) chips. The currently
   597		  supported chips are:
   598		    F71808E/A
   599		    F71858FG
   600		    F71862FG
   601		    F71863FG
   602		    F71869F/E/A
   603		    F71882FG
   604		    F71883FG
   605		    F71889FG/ED/A
   606		    F8000
   607		    F81801U
   608		    F81865F
   609	
   610		  This driver can also be built as a module. If so, the module
   611		  will be called f71882fg.
   612	
   613	config SENSORS_F75375S
   614		tristate "Fintek F75375S/SP, F75373 and F75387"
   615		depends on I2C
   616		help
   617		  If you say yes here you get support for hardware monitoring
   618		  features of the Fintek F75375S/SP, F75373 and F75387
   619	
   620		  This driver can also be built as a module. If so, the module
   621		  will be called f75375s.
   622	
   623	config SENSORS_GSC
   624		tristate "Gateworks System Controller ADC"
   625		depends on MFD_GATEWORKS_GSC
   626		help
   627		  Support for the Gateworks System Controller A/D converters.
   628	
   629		  To compile this driver as a module, choose M here:
   630		  the module will be called gsc-hwmon.
   631	
   632	config SENSORS_MC13783_ADC
   633	        tristate "Freescale MC13783/MC13892 ADC"
   634	        depends on MFD_MC13XXX
   635	        help
   636	          Support for the A/D converter on MC13783 and MC13892 PMIC.
   637	
   638	config SENSORS_FSCHMD
   639		tristate "Fujitsu Siemens Computers sensor chips"
   640		depends on (X86 || COMPILE_TEST) && I2C
   641		help
   642		  If you say yes here you get support for the following Fujitsu
   643		  Siemens Computers (FSC) sensor chips: Poseidon, Scylla, Hermes,
   644		  Heimdall, Heracles, Hades and Syleus including support for the
   645		  integrated watchdog.
   646	
   647		  This is a merged driver for FSC sensor chips replacing the fscpos,
   648		  fscscy and fscher drivers and adding support for several other FSC
   649		  sensor chips.
   650	
   651		  This driver can also be built as a module. If so, the module
   652		  will be called fschmd.
   653	
   654	config SENSORS_FTSTEUTATES
   655		tristate "Fujitsu Technology Solutions sensor chip Teutates"
   656		depends on I2C && WATCHDOG
   657		select WATCHDOG_CORE
   658		help
   659		  If you say yes here you get support for the Fujitsu Technology
   660		  Solutions (FTS) sensor chip "Teutates" including support for
   661		  the integrated watchdog.
   662	
   663		  This driver can also be built as a module. If so, the module
   664		  will be called ftsteutates.
   665	
   666	config SENSORS_GL518SM
   667		tristate "Genesys Logic GL518SM"
   668		depends on I2C
   669		help
   670		  If you say yes here you get support for Genesys Logic GL518SM
   671		  sensor chips.
   672	
   673		  This driver can also be built as a module. If so, the module
   674		  will be called gl518sm.
   675	
   676	config SENSORS_GL520SM
   677		tristate "Genesys Logic GL520SM"
   678		depends on I2C
   679		select HWMON_VID
   680		help
   681		  If you say yes here you get support for Genesys Logic GL520SM
   682		  sensor chips.
   683	
   684		  This driver can also be built as a module. If so, the module
   685		  will be called gl520sm.
   686	
   687	config SENSORS_G760A
   688		tristate "GMT G760A"
   689		depends on I2C
   690		help
   691		  If you say yes here you get support for Global Mixed-mode
   692		  Technology Inc G760A fan speed PWM controller chips.
   693	
   694		  This driver can also be built as a module. If so, the module
   695		  will be called g760a.
   696	
   697	config SENSORS_G762
   698		tristate "GMT G762 and G763"
   699		depends on I2C
   700		help
   701		  If you say yes here you get support for Global Mixed-mode
   702		  Technology Inc G762 and G763 fan speed PWM controller chips.
   703	
   704		  This driver can also be built as a module. If so, the module
   705		  will be called g762.
   706	
   707	config SENSORS_GPIO_FAN
   708		tristate "GPIO fan"
   709		depends on OF_GPIO
   710		depends on GPIOLIB || COMPILE_TEST
   711		depends on THERMAL || THERMAL=n
   712		help
   713		  If you say yes here you get support for fans connected to GPIO lines.
   714	
   715		  This driver can also be built as a module. If so, the module
   716		  will be called gpio-fan.
   717	
   718	config SENSORS_GXP_FAN_CTRL
   719		tristate "HPE GXP fan controller"
   720		depends on ARCH_HPE_GXP || COMPILE_TEST
   721		help
   722		  If you say yes here you get support for GXP fan control functionality.
   723	
   724		  The GXP controls fan function via the CPLD through the use of PWM
   725		  registers. This driver reports status and pwm setting of the fans.
   726	
   727	config SENSORS_HIH6130
   728		tristate "Honeywell Humidicon HIH-6130 humidity/temperature sensor"
   729		depends on I2C
   730		help
   731		  If you say yes here you get support for Honeywell Humidicon
   732		  HIH-6130 and HIH-6131 Humidicon humidity sensors.
   733	
   734		  This driver can also be built as a module. If so, the module
   735		  will be called hih6130.
   736	
   737	config SENSORS_HS3001
   738		tristate "Renesas HS3001 humidity and temperature sensors"
   739		depends on I2C
   740		help
   741		  If you say yes here you get support for the Renesas HS3001,
   742		  to HS3004 humidity and temperature sensors.
   743	
   744		  This driver can also be built as a module. If so, the module
   745		  will be called hs3001.
   746	
   747	config SENSORS_IBMAEM
   748		tristate "IBM Active Energy Manager temperature/power sensors and control"
   749		select IPMI_SI
   750		depends on IPMI_HANDLER
   751		help
   752		  If you say yes here you get support for the temperature and
   753		  power sensors and capping hardware in various IBM System X
   754		  servers that support Active Energy Manager.  This includes
   755		  the x3350, x3550, x3650, x3655, x3755, x3850 M2, x3950 M2,
   756		  and certain HC10/HS2x/LS2x/QS2x blades.
   757	
   758		  This driver can also be built as a module. If so, the module
   759		  will be called ibmaem.
   760	
   761	config SENSORS_IBMPEX
   762		tristate "IBM PowerExecutive temperature/power sensors"
   763		select IPMI_SI
   764		depends on IPMI_HANDLER
   765		help
   766		  If you say yes here you get support for the temperature and
   767		  power sensors in various IBM System X servers that support
   768		  PowerExecutive.  So far this includes the x3350, x3550, x3650,
   769		  x3655, and x3755; the x3800, x3850, and x3950 models that have
   770		  PCI Express; and some of the HS2x, LS2x, and QS2x blades.
   771	
   772		  This driver can also be built as a module. If so, the module
   773		  will be called ibmpex.
   774	
   775	config SENSORS_IBMPOWERNV
   776		tristate "IBM POWERNV platform sensors"
   777		depends on PPC_POWERNV
   778		default y
   779		help
   780		  If you say yes here you get support for the temperature/fan/power
   781		  sensors on your PowerNV platform.
   782	
   783		  This driver can also be built as a module. If so, the module
   784		  will be called ibmpowernv.
   785	
   786	config SENSORS_IIO_HWMON
   787		tristate "Hwmon driver that uses channels specified via iio maps"
   788		depends on IIO
   789		help
   790		  This is a platform driver that in combination with a suitable
   791		  map allows IIO devices to provide basic hwmon functionality
   792		  for those channels specified in the map.  This map can be provided
   793		  either via platform data or the device tree bindings.
   794	
   795	config SENSORS_I5500
   796		tristate "Intel 5500/5520/X58 temperature sensor"
   797		depends on X86 && PCI
   798		help
   799		  If you say yes here you get support for the temperature
   800		  sensor inside the Intel 5500, 5520 and X58 chipsets.
   801	
   802		  This driver can also be built as a module. If so, the module
   803		  will be called i5500_temp.
   804	
   805	config SENSORS_CORETEMP
   806		tristate "Intel Core/Core2/Atom temperature sensor"
   807		depends on X86
   808		help
   809		  If you say yes here you get support for the temperature
   810		  sensor inside your CPU. Most of the family 6 CPUs
   811		  are supported. Check Documentation/hwmon/coretemp.rst for details.
   812	
   813	config SENSORS_IT87
   814		tristate "ITE IT87xx and compatibles"
   815		depends on !PPC
   816		select HWMON_VID
   817		help
   818		  If you say yes here you get support for ITE IT8705F, IT8712F, IT8716F,
   819		  IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8732F, IT8758E,
   820		  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E,
   821		  IT8603E, IT8620E, IT8623E, and IT8628E sensor chips, and the SiS950
   822		  clone.
   823	
   824		  This driver can also be built as a module. If so, the module
   825		  will be called it87.
   826	
   827	config SENSORS_JC42
   828		tristate "JEDEC JC42.4 compliant memory module temperature sensors"
   829		depends on I2C
   830		select REGMAP_I2C
   831		help
   832		  If you say yes here, you get support for JEDEC JC42.4 compliant
   833		  temperature sensors, which are used on many DDR3 memory modules for
   834		  mobile devices and servers.  Support will include, but not be limited
   835		  to, ADT7408, AT30TS00, CAT34TS02, CAT6095, MAX6604, MCP9804, MCP9805,
   836		  MCP9808, MCP98242, MCP98243, MCP98244, MCP9843, SE97, SE98,
   837		  STTS424(E), STTS2002, STTS3000, TSE2002, TSE2004, TS3000, and TS3001.
   838	
   839		  This driver can also be built as a module. If so, the module
   840		  will be called jc42.
   841	
   842	config SENSORS_POWERZ
   843		tristate "ChargerLAB POWER-Z USB-C tester");
 > 844		depends on USB
   845		help
   846		  If you say yes here you get support for ChargerLAB POWER-Z series of
   847		  USB-C charging testers.
   848	
   849		  This driver can also be built as a module. If so, the module
   850		  will be called powerz.
   851	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
