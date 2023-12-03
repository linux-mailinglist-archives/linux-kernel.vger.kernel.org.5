Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028DD802614
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjLCRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:52:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51777DB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701625972; x=1733161972;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nWBvlusC98EktzBDstT5ilLk6AvLsU6nXk4xGMIjfSs=;
  b=B/ZvRc58cF1ei45AFJYFm39hD5lAFtT9J7uq/qBQWsh+aliNF/4+NUVZ
   JDLis42lVrfwkO0TiJbiYsn2WNEynvevpOO28Ve1h1MBveoopfXWiY+uM
   u3qF/Ixd3lQ/GGxAjAw9kSvfJ68WoMVQ90EE1UaWdQTBbCXDYhu1YMG1p
   N0lOzo4z9QNh7+PSHcyxFUmnIF+WEzgh6IWsMlnjEmNj0kEeo8LB/H5lz
   s0jP66kmv+Eyb4ikU7a3/TvnrF2SycmEx2XQhEs7m6qIQLOmIld6hxMM5
   OMa9Tn1dr6tI3igEUuQE6oa+iUbpI9QmHMpbKfA4BNV0R7KkiJs1g2d7/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="397540396"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="397540396"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 09:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="943650367"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="943650367"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2023 09:52:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9qe8-0006wJ-0V;
        Sun, 03 Dec 2023 17:52:48 +0000
Date:   Mon, 4 Dec 2023 01:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Pargmann <mpa@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/accel/bmc150-accel-i2c.c:64:36: warning:
 'bmc150_accel_acpi_match' defined but not used
Message-ID: <202312040109.Csnmqnb2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 55637c38377a301cd0768cee73021e43d05de543 iio: bmc150: Split the driver into core and i2c
date:   8 years ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231204/202312040109.Csnmqnb2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312040109.Csnmqnb2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040109.Csnmqnb2-lkp@intel.com/

All warnings (new ones prefixed by >>):

     806 |         PVOP_VCALLEE1(pv_irq_ops.restore_fl, f);
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h: In function 'arch_local_irq_disable':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   arch/x86/include/asm/paravirt_types.h:542:33: note: in expansion of macro 'BUG_ON'
     542 | #define PVOP_TEST_NULL(op)      BUG_ON(op == NULL)
         |                                 ^~~~~~
   arch/x86/include/asm/paravirt_types.h:592:17: note: in expansion of macro 'PVOP_TEST_NULL'
     592 |                 PVOP_TEST_NULL(op);                                     \
         |                 ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:609:9: note: in expansion of macro '____PVOP_VCALL'
     609 |         ____PVOP_VCALL(op.func, CLBR_RET_REG,                           \
         |         ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:623:9: note: in expansion of macro '__PVOP_VCALLEESAVE'
     623 |         __PVOP_VCALLEESAVE(op, "", "")
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:811:9: note: in expansion of macro 'PVOP_VCALLEE0'
     811 |         PVOP_VCALLEE0(pv_irq_ops.irq_disable);
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h: In function 'arch_local_irq_enable':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   arch/x86/include/asm/paravirt_types.h:542:33: note: in expansion of macro 'BUG_ON'
     542 | #define PVOP_TEST_NULL(op)      BUG_ON(op == NULL)
         |                                 ^~~~~~
   arch/x86/include/asm/paravirt_types.h:592:17: note: in expansion of macro 'PVOP_TEST_NULL'
     592 |                 PVOP_TEST_NULL(op);                                     \
         |                 ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:609:9: note: in expansion of macro '____PVOP_VCALL'
     609 |         ____PVOP_VCALL(op.func, CLBR_RET_REG,                           \
         |         ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:623:9: note: in expansion of macro '__PVOP_VCALLEESAVE'
     623 |         __PVOP_VCALLEESAVE(op, "", "")
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:816:9: note: in expansion of macro 'PVOP_VCALLEE0'
     816 |         PVOP_VCALLEE0(pv_irq_ops.irq_enable);
         |         ^~~~~~~~~~~~~
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   include/asm-generic/fixmap.h: In function 'virt_to_fix':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/asm-generic/fixmap.h:37:9: note: in expansion of macro 'BUG_ON'
      37 |         BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
         |         ^~~~~~
   drivers/iio/accel/bmc150-accel-i2c.c: At top level:
   drivers/iio/accel/bmc150-accel-i2c.c:65:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      65 |         {"BSBA0150",    bmc150},
         |         ^
   In file included from drivers/iio/accel/bmc150-accel-i2c.c:23:
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-i2c.c:66:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      66 |         {"BMC150A",     bmc150},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-i2c.c:67:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      67 |         {"BMI055A",     bmi055},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-i2c.c:68:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      68 |         {"BMA0255",     bma255},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-i2c.c:69:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      69 |         {"BMA250E",     bma250e},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-i2c.c:70:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      70 |         {"BMA222E",     bma222e},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/accel/bmc150-accel-i2c.c:71:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      71 |         {"BMA0280",     bma280},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
>> drivers/iio/accel/bmc150-accel-i2c.c:64:36: warning: 'bmc150_accel_acpi_match' defined but not used [-Wunused-const-variable=]
      64 | static const struct acpi_device_id bmc150_accel_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +/bmc150_accel_acpi_match +64 drivers/iio/accel/bmc150-accel-i2c.c

    63	
  > 64	static const struct acpi_device_id bmc150_accel_acpi_match[] = {
    65		{"BSBA0150",	bmc150},
    66		{"BMC150A",	bmc150},
    67		{"BMI055A",	bmi055},
    68		{"BMA0255",	bma255},
    69		{"BMA250E",	bma250e},
    70		{"BMA222E",	bma222e},
    71		{"BMA0280",	bma280},
    72		{ },
    73	};
    74	MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
    75	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
