Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77AB7CD9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJRLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:01:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17392
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697626871; x=1729162871;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dTDdGpzlXb3ERKytdmOV1XkKeASL3B8yeKq3HAH4osI=;
  b=aoRg5GwbVVKXAWiugIlQx5ANWT4/XmkGgGrt5k5xWzIDH3xVA3YTAYaC
   WHjPtrM4O0Z5R9/OUppIign4jIll5Szn9ztlPVMIPqnXuTd+rNR0bBw3Q
   pe0Hy1BsRf965ZVpLD1NJbQptTXiyQ+CrE9rRTyPpw8R4PUhz0VLXqGBT
   yiP/MHIbL7v4P6pEl716p0tTYzqCK6nxkCToAW5Ro/hXwByCikHrI99ki
   /Y1QiFd0C7tCfnT9XVZOw7NvfXP7cV57R5gwPSbo4otC4zqxtTOWvHvrd
   20yliQALImXRr6pH8sD9okqzVyB6zllVpv3H0BEGzHUu7ZBHTJq961yh0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452457517"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="452457517"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="847236138"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="847236138"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2023 04:00:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt4Hw-0000Ga-2s;
        Wed, 18 Oct 2023 11:00:32 +0000
Date:   Wed, 18 Oct 2023 18:59:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/sysdev/xive/common.c:1845:50: warning: '%ld' directive
 output may be truncated writing between 1 and 20 bytes into a region of size
 13
Message-ID: <202310181858.EyyD4USk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 33e67710beda78aed38a2fe10be6088d4aeb1c53 cpumask: switch for_each_cpu{,_not} to use for_each_bit()
date:   1 year, 1 month ago
config: powerpc64-randconfig-r003-20230828 (https://download.01.org/0day-ci/archive/20231018/202310181858.EyyD4USk-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181858.EyyD4USk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181858.EyyD4USk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/sysdev/xive/common.c: In function 'xive_core_debug_init':
>> arch/powerpc/sysdev/xive/common.c:1845:50: warning: '%ld' directive output may be truncated writing between 1 and 20 bytes into a region of size 13 [-Wformat-truncation=]
    1845 |                 snprintf(name, sizeof(name), "cpu%ld", cpu);
         |                                                  ^~~
   In function 'xive_core_debugfs_create',
       inlined from 'xive_core_debug_init' at arch/powerpc/sysdev/xive/common.c:1861:3:
   arch/powerpc/sysdev/xive/common.c:1845:46: note: directive argument in the range [-9223372036854775808, 4294967294]
    1845 |                 snprintf(name, sizeof(name), "cpu%ld", cpu);
         |                                              ^~~~~~~~
   arch/powerpc/sysdev/xive/common.c:1845:17: note: 'snprintf' output between 5 and 24 bytes into a destination of size 16
    1845 |                 snprintf(name, sizeof(name), "cpu%ld", cpu);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   arch/powerpc/platforms/pseries/lpar.c: In function '__machine_initcall_pseries_vpa_debugfs_init':
>> arch/powerpc/platforms/pseries/lpar.c:2032:36: warning: '%ld' directive writing between 1 and 20 bytes into a region of size 12 [-Wformat-overflow=]
    2032 |                 sprintf(name, "cpu-%ld", i);
         |                                    ^~~
   In function 'vpa_debugfs_init',
       inlined from '__machine_initcall_pseries_vpa_debugfs_init' at arch/powerpc/platforms/pseries/lpar.c:2038:1:
   arch/powerpc/platforms/pseries/lpar.c:2032:31: note: directive argument in the range [-9223372036854775808, 4294967294]
    2032 |                 sprintf(name, "cpu-%ld", i);
         |                               ^~~~~~~~~
   arch/powerpc/platforms/pseries/lpar.c:2032:17: note: 'sprintf' output between 6 and 25 bytes into a destination of size 16
    2032 |                 sprintf(name, "cpu-%ld", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1845 arch/powerpc/sysdev/xive/common.c

08f3f610214f39 Cédric Le Goater 2021-11-05  1827  
412877dfae3dc1 Cédric Le Goater 2021-11-05  1828  static void xive_core_debugfs_create(void)
930914b7d528fc Cédric Le Goater 2020-03-06  1829  {
baed14de78b5ee Cédric Le Goater 2021-11-05  1830  	struct dentry *xive_dir;
08f3f610214f39 Cédric Le Goater 2021-11-05  1831  	struct dentry *xive_eq_dir;
08f3f610214f39 Cédric Le Goater 2021-11-05  1832  	long cpu;
08f3f610214f39 Cédric Le Goater 2021-11-05  1833  	char name[16];
baed14de78b5ee Cédric Le Goater 2021-11-05  1834  
baed14de78b5ee Cédric Le Goater 2021-11-05  1835  	xive_dir = debugfs_create_dir("xive", arch_debugfs_dir);
baed14de78b5ee Cédric Le Goater 2021-11-05  1836  	if (IS_ERR(xive_dir))
baed14de78b5ee Cédric Le Goater 2021-11-05  1837  		return;
baed14de78b5ee Cédric Le Goater 2021-11-05  1838  
33e1d4a152ce55 Cédric Le Goater 2021-11-05  1839  	debugfs_create_file("ipis", 0400, xive_dir,
33e1d4a152ce55 Cédric Le Goater 2021-11-05  1840  			    NULL, &xive_ipi_debug_fops);
baed14de78b5ee Cédric Le Goater 2021-11-05  1841  	debugfs_create_file("interrupts", 0400, xive_dir,
baed14de78b5ee Cédric Le Goater 2021-11-05  1842  			    NULL, &xive_irq_debug_fops);
08f3f610214f39 Cédric Le Goater 2021-11-05  1843  	xive_eq_dir = debugfs_create_dir("eqs", xive_dir);
08f3f610214f39 Cédric Le Goater 2021-11-05  1844  	for_each_possible_cpu(cpu) {
08f3f610214f39 Cédric Le Goater 2021-11-05 @1845  		snprintf(name, sizeof(name), "cpu%ld", cpu);
08f3f610214f39 Cédric Le Goater 2021-11-05  1846  		debugfs_create_file(name, 0400, xive_eq_dir, (void *)cpu,
08f3f610214f39 Cédric Le Goater 2021-11-05  1847  				    &xive_eq_debug_fops);
08f3f610214f39 Cédric Le Goater 2021-11-05  1848  	}
d7bc1e376cb786 Cédric Le Goater 2021-11-05  1849  	debugfs_create_bool("store-eoi", 0600, xive_dir, &xive_store_eoi);
2a2ac8a7018b95 Cédric Le Goater 2021-12-01  1850  
2a2ac8a7018b95 Cédric Le Goater 2021-12-01  1851  	if (xive_ops->debug_create)
2a2ac8a7018b95 Cédric Le Goater 2021-12-01  1852  		xive_ops->debug_create(xive_dir);
412877dfae3dc1 Cédric Le Goater 2021-11-05  1853  }
412877dfae3dc1 Cédric Le Goater 2021-11-05  1854  #else
412877dfae3dc1 Cédric Le Goater 2021-11-05  1855  static inline void xive_core_debugfs_create(void) { }
412877dfae3dc1 Cédric Le Goater 2021-11-05  1856  #endif /* CONFIG_DEBUG_FS */
412877dfae3dc1 Cédric Le Goater 2021-11-05  1857  

:::::: The code at line 1845 was first introduced by commit
:::::: 08f3f610214f395561bbda03344e641579f6e917 powerpc/xive: Add a debugfs file to dump EQs

:::::: TO: Cédric Le Goater <clg@kaod.org>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
