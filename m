Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73792811464
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441858AbjLMOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379150AbjLMOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:14:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF609C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702476876; x=1734012876;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zUF0yPw2ARlvkVoYpzdLpayt7rJm97a+UnrLZm7H+ZA=;
  b=QT6EwhQfU5pcbrgNIdkdP0XAbxJGPMDZMos+2VEENC8u01RV+DYeRuKs
   0XzlolGJhsGthMRCnwkzUPw7wh8MkOqtZ8JPYX3f4nhIuq+jmJ7HKGXEN
   J50UFkEbNHvkal1E+Ph/KpS9LZH69TeFMJMERa+HYGmJKcm4sAwVJKydA
   Z5SFwvlbuqiCmijhKnZMcuM+lVHEqoX1wVbs+F+8PDQTR3uPFY6RV5GCG
   zq2ux2gUUT+4p4ZSp4m4SyKENc7kpNjL5j7Y3xifXIi5wecQ651LZ/w72
   jGS7fFcdrqcwjHdP8DWyL95Du9E0fpo9QncROn5V9oi54VPSMs3hvcME+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8329629"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8329629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:14:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897342389"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="897342389"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2023 06:14:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDQ0F-000Kf9-0I;
        Wed, 13 Dec 2023 14:14:23 +0000
Date:   Wed, 13 Dec 2023 22:13:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: fs/pstore/ram_core.c:532:36: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312132232.faZpeGsh-lkp@intel.com>
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
head:   88035e5694a86a7167d490bb95e9df97a9bb162b
commit: a811c05c16b53ff89e9cfc029ec77a0aae846881 nios2: use generic early_init_dt_add_memory_arch
date:   5 years ago
config: nios2-randconfig-r113-20231116 (https://download.01.org/0day-ci/archive/20231213/202312132232.faZpeGsh-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312132232.faZpeGsh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312132232.faZpeGsh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/pstore/ram_core.c:277:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   fs/pstore/ram_core.c:277:34: sparse:     expected void volatile [noderef] __iomem *addr
   fs/pstore/ram_core.c:277:34: sparse:     got unsigned char *
   fs/pstore/ram_core.c:310:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char * @@
   fs/pstore/ram_core.c:310:50: sparse:     expected void const volatile [noderef] __iomem *addr
   fs/pstore/ram_core.c:310:50: sparse:     got unsigned char *
   fs/pstore/ram_core.c:311:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char * @@
   fs/pstore/ram_core.c:311:65: sparse:     expected void const volatile [noderef] __iomem *addr
   fs/pstore/ram_core.c:311:65: sparse:     got unsigned char *
   fs/pstore/ram_core.c:452:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:452:20: sparse:     expected void *va
   fs/pstore/ram_core.c:452:20: sparse:     got void [noderef] __iomem *
   fs/pstore/ram_core.c:454:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:454:20: sparse:     expected void *va
   fs/pstore/ram_core.c:454:20: sparse:     got void [noderef] __iomem *
>> fs/pstore/ram_core.c:532:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *vaddr @@
   fs/pstore/ram_core.c:532:36: sparse:     expected void [noderef] __iomem *addr
   fs/pstore/ram_core.c:532:36: sparse:     got void *vaddr
   fs/pstore/ram_core.c: note: in included file (through include/linux/irqflags.h, include/asm-generic/bitops.h, arch/nios2/include/generated/asm/bitops.h, ...):
   arch/nios2/include/asm/irqflags.h:25:16: sparse: sparse: undefined identifier '__builtin_rdctl'
   arch/nios2/include/asm/irqflags.h:34:9: sparse: sparse: undefined identifier '__builtin_wrctl'
   fs/pstore/ram_core.c: In function 'persistent_ram_save_old':
   fs/pstore/ram_core.c:310:37: warning: array subscript <unknown> is outside array bounds of 'uint8_t[0]' {aka 'unsigned char[]'} [-Warray-bounds=]
     310 |         memcpy_fromio(prz->old_log, &buffer->data[start], size - start);
         |                                     ^~~~~~~~~~~~~~~~~~~~
   fs/pstore/ram_core.c:36:21: note: while referencing 'data'
      36 |         uint8_t     data[0];
         |                     ^~~~
   fs/pstore/ram_core.c:311:52: warning: array subscript 0 is outside array bounds of 'uint8_t[0]' {aka 'unsigned char[]'} [-Warray-bounds=]
     311 |         memcpy_fromio(prz->old_log + size - start, &buffer->data[0], start);
         |                                                    ^~~~~~~~~~~~~~~~
   fs/pstore/ram_core.c:36:21: note: while referencing 'data'
      36 |         uint8_t     data[0];
         |                     ^~~~

vim +532 fs/pstore/ram_core.c

bb4206f2042d95 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  521  
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  522  void persistent_ram_free(struct persistent_ram_zone *prz)
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  523  {
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  524  	if (!prz)
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  525  		return;
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  526  
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  527  	if (prz->vaddr) {
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  528  		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
831b624df1b420 fs/pstore/ram_core.c                     Bin Yang        2018-09-12  529  			/* We must vunmap() at page-granularity. */
831b624df1b420 fs/pstore/ram_core.c                     Bin Yang        2018-09-12  530  			vunmap(prz->vaddr - offset_in_page(prz->paddr));
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  531  		} else {
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11 @532  			iounmap(prz->vaddr);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  533  			release_mem_region(prz->paddr, prz->size);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  534  		}
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  535  		prz->vaddr = NULL;
beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  536  	}
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  537  	if (prz->rs_decoder) {
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  538  		free_rs(prz->rs_decoder);
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  539  		prz->rs_decoder = NULL;
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  540  	}
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  541  	kfree(prz->ecc_info.par);
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  542  	prz->ecc_info.par = NULL;
f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  543  
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  544  	persistent_ram_free_old(prz);
1227daa43bce13 fs/pstore/ram_core.c                     Kees Cook       2018-10-17  545  	kfree(prz->label);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  546  	kfree(prz);
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  547  }
d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  548  

:::::: The code at line 532 was first introduced by commit
:::::: d3b487695120b5342067244253697eabb121436d staging: android: persistent_ram: Introduce persistent_ram_free()

:::::: TO: Anton Vorontsov <anton.vorontsov@linaro.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
