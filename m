Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83DC7EFF2E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjKRLNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:13:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BED4B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700306010; x=1731842010;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Oy4WM8STg6mHyrvgUdfedhz06G8DR9Lkz2Ullp7dju4=;
  b=emN+FkuAKjS8JvGCm90mupTznpfKeikqDhL4goomeO26mD9HewzHIt7r
   wHJssz3Ql2tTN/TxMkusQ3y7CMlJ1AposcJb38eIZobtKYeyCKDWdMK2t
   APyWGE9noUwBYMiqUJeo5Wjf2/W2SGsF7lmz73T5zZ8fdRjUytAUeBKRo
   gxroNG5NH/arguUavbgGTcNCE2SfRtUd292va2BGk3B2+vadMq+MZWgGo
   bQbW4OfbmN7Vp9Cy3ZuMiwzQxomzcjLNh2G6bIinKdRZFCO3QUvvLxtki
   3oY/ngCS2HFpjc8KT8g0AJ00kUpfUibbmUEq9IkPVBy4uG1mh7EMb335/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="457922963"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="457922963"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 03:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="765835646"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="765835646"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2023 03:13:28 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4JGP-0003qN-2z;
        Sat, 18 Nov 2023 11:13:25 +0000
Date:   Sat, 18 Nov 2023 19:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Teodora Baluta <teodora.baluta@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/accel/mxc4005.c:328:36: warning: 'mxc4005_acpi_match'
 defined but not used
Message-ID: <202311181952.1usxCcup-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   791c8ab095f71327899023223940dd52257a4173
commit: 077377fc4f74899c58e946e47352216412d0bb3a iio: accel: add support for mxc4005 accelerometer
date:   8 years ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231118/202311181952.1usxCcup-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311181952.1usxCcup-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181952.1usxCcup-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/include/asm/paravirt_types.h:545:33: note: in expansion of macro 'BUG_ON'
     545 | #define PVOP_TEST_NULL(op)      BUG_ON(op == NULL)
         |                                 ^~~~~~
   arch/x86/include/asm/paravirt_types.h:555:17: note: in expansion of macro 'PVOP_TEST_NULL'
     555 |                 PVOP_TEST_NULL(op);                                     \
         |                 ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:587:9: note: in expansion of macro '____PVOP_CALL'
     587 |         ____PVOP_CALL(rettype, op.func, CLBR_RET_REG,                   \
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:624:9: note: in expansion of macro '__PVOP_CALLEESAVE'
     624 |         __PVOP_CALLEESAVE(rettype, op, "", "")
         |         ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:831:16: note: in expansion of macro 'PVOP_CALLEE0'
     831 |         return PVOP_CALLEE0(unsigned long, pv_irq_ops.save_fl);
         |                ^~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h: In function 'arch_local_irq_restore':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   arch/x86/include/asm/paravirt_types.h:545:33: note: in expansion of macro 'BUG_ON'
     545 | #define PVOP_TEST_NULL(op)      BUG_ON(op == NULL)
         |                                 ^~~~~~
   arch/x86/include/asm/paravirt_types.h:595:17: note: in expansion of macro 'PVOP_TEST_NULL'
     595 |                 PVOP_TEST_NULL(op);                                     \
         |                 ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:612:9: note: in expansion of macro '____PVOP_VCALL'
     612 |         ____PVOP_VCALL(op.func, CLBR_RET_REG,                           \
         |         ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:637:9: note: in expansion of macro '__PVOP_VCALLEESAVE'
     637 |         __PVOP_VCALLEESAVE(op, "", "", PVOP_CALL_ARG1(arg1))
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:836:9: note: in expansion of macro 'PVOP_VCALLEE1'
     836 |         PVOP_VCALLEE1(pv_irq_ops.restore_fl, f);
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h: In function 'arch_local_irq_disable':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   arch/x86/include/asm/paravirt_types.h:545:33: note: in expansion of macro 'BUG_ON'
     545 | #define PVOP_TEST_NULL(op)      BUG_ON(op == NULL)
         |                                 ^~~~~~
   arch/x86/include/asm/paravirt_types.h:595:17: note: in expansion of macro 'PVOP_TEST_NULL'
     595 |                 PVOP_TEST_NULL(op);                                     \
         |                 ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:612:9: note: in expansion of macro '____PVOP_VCALL'
     612 |         ____PVOP_VCALL(op.func, CLBR_RET_REG,                           \
         |         ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:626:9: note: in expansion of macro '__PVOP_VCALLEESAVE'
     626 |         __PVOP_VCALLEESAVE(op, "", "")
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:841:9: note: in expansion of macro 'PVOP_VCALLEE0'
     841 |         PVOP_VCALLEE0(pv_irq_ops.irq_disable);
         |         ^~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h: In function 'arch_local_irq_enable':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   arch/x86/include/asm/paravirt_types.h:545:33: note: in expansion of macro 'BUG_ON'
     545 | #define PVOP_TEST_NULL(op)      BUG_ON(op == NULL)
         |                                 ^~~~~~
   arch/x86/include/asm/paravirt_types.h:595:17: note: in expansion of macro 'PVOP_TEST_NULL'
     595 |                 PVOP_TEST_NULL(op);                                     \
         |                 ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:612:9: note: in expansion of macro '____PVOP_VCALL'
     612 |         ____PVOP_VCALL(op.func, CLBR_RET_REG,                           \
         |         ^~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt_types.h:626:9: note: in expansion of macro '__PVOP_VCALLEESAVE'
     626 |         __PVOP_VCALLEESAVE(op, "", "")
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:846:9: note: in expansion of macro 'PVOP_VCALLEE0'
     846 |         PVOP_VCALLEE0(pv_irq_ops.irq_enable);
         |         ^~~~~~~~~~~~~
   include/asm-generic/fixmap.h: In function 'virt_to_fix':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/asm-generic/fixmap.h:37:9: note: in expansion of macro 'BUG_ON'
      37 |         BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
         |         ^~~~~~
   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:424:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     424 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/iio/accel/mxc4005.c: At top level:
   drivers/iio/accel/mxc4005.c:329:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
     329 |         {"MXC4005",     0},
         |         ^
   In file included from include/linux/i2c.h:29,
                    from drivers/iio/accel/mxc4005.c:17:
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
>> drivers/iio/accel/mxc4005.c:328:36: warning: 'mxc4005_acpi_match' defined but not used [-Wunused-const-variable=]
     328 | static const struct acpi_device_id mxc4005_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~


vim +/mxc4005_acpi_match +328 drivers/iio/accel/mxc4005.c

   327	
 > 328	static const struct acpi_device_id mxc4005_acpi_match[] = {
 > 329		{"MXC4005",	0},
   330		{ },
   331	};
   332	MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
   333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
