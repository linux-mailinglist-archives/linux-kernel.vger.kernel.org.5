Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637507EFDDE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjKRFWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 00:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRFV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 00:21:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007CC10D0;
        Fri, 17 Nov 2023 21:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700284915; x=1731820915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yEreUHMKYBFFkEB3u/u/R/cCq3R3tX2VCM4VmFEVxYA=;
  b=KX/vs6zF1ZNDxhSICsi/JLSz08C3EA6MjqAxLesr2wPFei/k+f9ZnJBK
   9Vo0Wng5f1V4GgltZpeI6Ovkga6IfKGOEVX4JUyPt6DMoQCE1yXg3gR50
   XGlfANZAFnxEAf+ILIdgXuC78hZ1BGOGS5bea6L0P65B13ZVtn9ltWi8d
   cd8SdvTNU8tWfnsnsEFnFark1nWmWMnnsap6dCYEZa+qX64FmdLYHpMf6
   YmWneRSs099xuCH/m6cVYByq3P7mWI38jwT0s4mpqf8G8El2Y+tZtHFLV
   rjCKQPXT30iQzhDvRhspTe7hJD/AgaBAVVO49rLgoVvJ0vJdjMOfK/zQt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="395334557"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="395334557"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 21:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097293092"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="1097293092"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2023 21:21:51 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Dm8-0003YN-2N;
        Sat, 18 Nov 2023 05:21:48 +0000
Date:   Sat, 18 Nov 2023 13:21:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <202311181316.z2BmTZmP-lkp@intel.com>
References: <20231117164232.8474-2-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117164232.8474-2-petre.rodan@subdimension.ro>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petre,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.7-rc1]
[cannot apply to next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petre-Rodan/iio-pressure-driver-for-Honeywell-HSC-SSC-series-pressure-sensors/20231118-072654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231117164232.8474-2-petre.rodan%40subdimension.ro
patch subject: [PATCH v2 2/2] iio: pressure: driver for Honeywell HSC/SSC series pressure sensors
config: riscv-rv32_defconfig (attached as .config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311181316.z2BmTZmP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181316.z2BmTZmP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/pressure/Kconfig:120: syntax error
   drivers/iio/pressure/Kconfig:119:warning: ignoring unsupported character '.'
   drivers/iio/pressure/Kconfig:119: unknown statement "pressure"
   drivers/iio/pressure/Kconfig:121:warning: ignoring unsupported character ','
   drivers/iio/pressure/Kconfig:121:warning: ignoring unsupported character ':'
   drivers/iio/pressure/Kconfig:121: unknown statement "To"
   drivers/iio/pressure/Kconfig:122:warning: ignoring unsupported character '.'
   drivers/iio/pressure/Kconfig:122: unknown statement "called"
   make[3]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[2]: *** [Makefile:685: oldconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> drivers/iio/pressure/Kconfig:120: syntax error
   drivers/iio/pressure/Kconfig:119:warning: ignoring unsupported character '.'
   drivers/iio/pressure/Kconfig:119: unknown statement "pressure"
   drivers/iio/pressure/Kconfig:121:warning: ignoring unsupported character ','
   drivers/iio/pressure/Kconfig:121:warning: ignoring unsupported character ':'
   drivers/iio/pressure/Kconfig:121: unknown statement "To"
   drivers/iio/pressure/Kconfig:122:warning: ignoring unsupported character '.'
   drivers/iio/pressure/Kconfig:122: unknown statement "called"
   make[3]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[2]: *** [Makefile:685: olddefconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.
--
>> drivers/iio/pressure/Kconfig:120: syntax error
   drivers/iio/pressure/Kconfig:119:warning: ignoring unsupported character '.'
   drivers/iio/pressure/Kconfig:119: unknown statement "pressure"
   drivers/iio/pressure/Kconfig:121:warning: ignoring unsupported character ','
   drivers/iio/pressure/Kconfig:121:warning: ignoring unsupported character ':'
   drivers/iio/pressure/Kconfig:121: unknown statement "To"
   drivers/iio/pressure/Kconfig:122:warning: ignoring unsupported character '.'
   drivers/iio/pressure/Kconfig:122: unknown statement "called"
   make[5]: *** [scripts/kconfig/Makefile:87: defconfig] Error 1
   make[4]: *** [Makefile:685: defconfig] Error 2
   make[3]: *** [Makefile:350: __build_one_by_one] Error 2
   make[3]: Target 'defconfig' not remade because of errors.
   make[3]: Target '32-bit.config' not remade because of errors.
   make[2]: *** [arch/riscv/Makefile:190: rv32_defconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'rv32_defconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'rv32_defconfig' not remade because of errors.


vim +120 drivers/iio/pressure/Kconfig

     8	
     9	config ABP060MG
    10		tristate "Honeywell ABP pressure sensor driver"
    11		depends on I2C
    12		help
    13		  Say yes here to build support for the Honeywell ABP pressure
    14		  sensors.
    15	
    16		  To compile this driver as a module, choose M here: the module
    17		  will be called abp060mg.
    18	
    19	config ROHM_BM1390
    20		tristate "ROHM BM1390GLV-Z pressure sensor driver"
    21		depends on I2C
    22		help
    23		  Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z
    24		  can measure pressures ranging from 300 hPa to 1300 hPa with
    25		  configurable measurement averaging and internal FIFO. The
    26		  sensor does also provide temperature measurements.
    27	
    28	config BMP280
    29		tristate "Bosch Sensortec BMP180/BMP280/BMP380/BMP580 pressure sensor driver"
    30		depends on (I2C || SPI_MASTER)
    31		select REGMAP
    32		select BMP280_I2C if (I2C)
    33		select BMP280_SPI if (SPI_MASTER)
    34		help
    35		  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
    36		  and BMP580 pressure and temperature sensors. Also supports the BME280 with
    37		  an additional humidity sensor channel.
    38	
    39		  To compile this driver as a module, choose M here: the core module
    40		  will be called bmp280 and you will also get bmp280-i2c for I2C
    41		  and/or bmp280-spi for SPI support.
    42	
    43	config BMP280_I2C
    44		tristate
    45		depends on BMP280
    46		depends on I2C
    47		select REGMAP_I2C
    48	
    49	config BMP280_SPI
    50		tristate
    51		depends on BMP280
    52		depends on SPI_MASTER
    53		select REGMAP
    54	
    55	config IIO_CROS_EC_BARO
    56		tristate "ChromeOS EC Barometer Sensor"
    57		depends on IIO_CROS_EC_SENSORS_CORE
    58		help
    59		  Say yes here to build support for the Barometer sensor when
    60		  presented by the ChromeOS EC Sensor hub.
    61	
    62		  To compile this driver as a module, choose M here: the module
    63		  will be called cros_ec_baro.
    64	
    65	config DLHL60D
    66		tristate "All Sensors DLHL60D and DLHL60G low voltage digital pressure sensors"
    67		depends on I2C
    68		select IIO_BUFFER
    69		select IIO_TRIGGERED_BUFFER
    70		help
    71		  Say yes here to build support for the All Sensors DLH series
    72		  pressure sensors driver.
    73	
    74		  To compile this driver as a module, choose M here: the module
    75		  will be called dlhl60d.
    76	
    77	config DPS310
    78		tristate "Infineon DPS310 pressure and temperature sensor"
    79		depends on I2C
    80		select REGMAP_I2C
    81		help
    82		  Support for the Infineon DPS310 digital barometric pressure sensor.
    83		  It can be accessed over I2C bus.
    84	
    85		  This driver can also be built as a module.  If so, the module will be
    86		  called dps310.
    87	
    88	config HID_SENSOR_PRESS
    89		depends on HID_SENSOR_HUB
    90		select IIO_BUFFER
    91		select HID_SENSOR_IIO_COMMON
    92		select HID_SENSOR_IIO_TRIGGER
    93		tristate "HID PRESS"
    94		help
    95		  Say yes here to build support for the HID SENSOR
    96		  Pressure driver
    97	
    98		  To compile this driver as a module, choose M here: the module
    99		  will be called hid-sensor-press.
   100	
   101	config HP03
   102		tristate "Hope RF HP03 temperature and pressure sensor driver"
   103		depends on I2C
   104		select REGMAP_I2C
   105		help
   106		  Say yes here to build support for Hope RF HP03 pressure and
   107		  temperature sensor.
   108	
   109		  To compile this driver as a module, choose M here: the module
   110		  will be called hp03.
   111	
   112	config HSC030PA
   113		tristate "Honeywell HSC/SSC (TruStability pressure sensors series)"
   114		depends on (I2C || SPI_MASTER)
   115		select HSC030PA_I2C if (I2C)
   116		select HSC030PA_SPI if (SPI_MASTER)
   117		help
   118		  Say Y here to build support for the Honeywell HSC and SSC TruStability
   119	      pressure and temperature sensor series.
 > 120	
   121		  To compile this driver as a module, choose M here: the module will be
   122		  called hsc030pa.
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
