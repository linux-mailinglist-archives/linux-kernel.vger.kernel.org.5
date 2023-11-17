Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9EB7EEB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjKQD0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjKQD0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:26:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB6B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700191600; x=1731727600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=53PZKnvtpMVoxFCGNPIQU5mNR3oNNOFSWNURwr8x7G4=;
  b=knaEgLWtQw6VFuR3xCwJWu05eGQhDiau29WwSHVrTLMaekrgwJnT+7hy
   zNXq3GK+P3KS3G1dc6t1d9kHZtr2+Z6FtL58LscpRXAx1/8pam8h0xdg7
   EFIM6QJrS8A5D9g7SAuSvvYjksnUo/4BcfzxfnbQNqUZpUud//ITwypAE
   KmDt14ZCHi50Jyvi/clgfP6jFLqHKSe23mi25C/nVGr20OiBWNdwokm0G
   EWfrM0wTXRkMsFf66UKGJfsG00pm/hIv46HHA1WueDQ4eAZiTFCYC/6Ro
   rK28O8f6bWbvGDBVnDxvtWmGUw3z4CAytTxuPVuWCefJNrzKgEU1+OfMB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9888628"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="9888628"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 19:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="831483704"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="831483704"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2023 19:26:38 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3pV6-0002Jz-0U;
        Fri, 17 Nov 2023 03:26:36 +0000
Date:   Fri, 17 Nov 2023 11:26:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Pargmann <mpa@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/accel/bmc150-accel-spi.c:54:36: warning:
 'bmc150_accel_acpi_match' defined but not used
Message-ID: <202311171116.47sUbZV5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7475e51b87969e01a6812eac713a1c8310372e8a
commit: f9ab96e212808123fbd9072d580a59194e5cd410 iio: bmc150: Add SPI driver
date:   8 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231117/202311171116.47sUbZV5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311171116.47sUbZV5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311171116.47sUbZV5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from drivers/iio/accel/bmc150-accel-spi.c:19:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/iio/accel/bmc150-accel-spi.c: At top level:
   drivers/iio/accel/bmc150-accel-spi.c:55:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      55 |         {"BSBA0150",    bmc150},
         |         ^
   In file included from drivers/iio/accel/bmc150-accel-spi.c:20:
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-spi.c:56:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      56 |         {"BMC150A",     bmc150},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-spi.c:57:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      57 |         {"BMI055A",     bmi055},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-spi.c:58:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      58 |         {"BMA0255",     bma255},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-spi.c:59:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      59 |         {"BMA250E",     bma250e},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-spi.c:60:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      60 |         {"BMA222E",     bma222e},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-spi.c:61:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      61 |         {"BMA0280",     bma280},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
>> drivers/iio/accel/bmc150-accel-spi.c:54:36: warning: 'bmc150_accel_acpi_match' defined but not used [-Wunused-const-variable=]
      54 | static const struct acpi_device_id bmc150_accel_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +/bmc150_accel_acpi_match +54 drivers/iio/accel/bmc150-accel-spi.c

    53	
  > 54	static const struct acpi_device_id bmc150_accel_acpi_match[] = {
    55		{"BSBA0150",	bmc150},
    56		{"BMC150A",	bmc150},
    57		{"BMI055A",	bmi055},
    58		{"BMA0255",	bma255},
    59		{"BMA250E",	bma250e},
    60		{"BMA222E",	bma222e},
    61		{"BMA0280",	bma280},
    62		{ },
    63	};
    64	MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
    65	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
