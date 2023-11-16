Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321047ED87D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjKPAXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPAXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:23:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B0125
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700094225; x=1731630225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LyAewazbA4GTUSbI6VbeyR0a0sQSdPamE6BpBjSIxAo=;
  b=ieH3kj9tvJnpfBXWVRT4G8Ezl7IZT/nsvqFaX1oQCsZKjH8mCBxrXpx0
   cKxrtRxqWxOPpI/rnGDfBYwNpgwvCBWfwIrX/AEjUwGp5bk4yvwVug1sb
   HXkEtTWqxYxxnjm1CdH0uY6ir/FBJSrrPeC2rNUkrVs4f4GYAsnJQWUqx
   AlBZLDSFJft9M43qNZFdhKVyv5u4YJYsOcetxTd3NNTyiuCSR4U+jX+Db
   AlY4a55f9B4iLrbSrp5WiMUE5ZZVBILnYURDaGZ9zVOXl0eKR2S7CaOoJ
   tbgt+SGKUS4NwwFHHlwpknizMPrfoyH+290zt4GNo6Vqn4u6pyKNysEyS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422075792"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="422075792"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 16:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831094767"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="831094767"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2023 16:23:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3QAX-00011t-22;
        Thu, 16 Nov 2023 00:23:41 +0000
Date:   Thu, 16 Nov 2023 08:22:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adriana Reus <adriana.reus@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/light/pa12203001.c:454:36: warning:
 'pa12203001_acpi_match' defined but not used
Message-ID: <202311160851.FDA4CDVE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 8ab6abfca09c1800dccb753775f6ce8ee82f50dd iio: light: Add support for TXC PA12 als and proximity sensor
date:   8 years ago
config: x86_64-buildonly-randconfig-004-20230906 (https://download.01.org/0day-ci/archive/20231116/202311160851.FDA4CDVE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160851.FDA4CDVE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160851.FDA4CDVE-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |         ^~~~~~~~~~~~
   arch/x86/include/asm/paravirt.h:735:9: note: in expansion of macro 'PVOP_VCALL1'
     735 |         PVOP_VCALL1(pv_lock_ops.kick, cpu);
         |         ^~~~~~~~~~~
   arch/x86/include/asm/paravirt.h: In function 'arch_local_save_flags':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
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
                    from include/linux/module.h:16:
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
   drivers/iio/light/pa12203001.c: At top level:
>> drivers/iio/light/pa12203001.c:454:36: warning: 'pa12203001_acpi_match' defined but not used [-Wunused-const-variable=]
     454 | static const struct acpi_device_id pa12203001_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~


vim +/pa12203001_acpi_match +454 drivers/iio/light/pa12203001.c

   453	
 > 454	static const struct acpi_device_id pa12203001_acpi_match[] = {
   455		{ "TXCPA122", 0},
   456		{}
   457	};
   458	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
