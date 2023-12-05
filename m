Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE6804B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjLEHsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjLEHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:48:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77105109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701762493; x=1733298493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qZeYraXD4otGmbX0f2QSh5bcN/rmRbFgRkyMZVKVoYE=;
  b=T9+aULJLzp7WY0zUIB/FDHWNgfV3mjCw7pwmd55DefgAG1ZWUSpvTnnR
   cj/ETF62ZbDwQqR81KFzpcnUx2yo6r+jGsN8yTySCfD9ystg/Me0nQJcm
   rWfMpPQRcccOFjk6NCTRJ1YRoLMRylsryFMTszqDJcIKuu1Q6esbSEyT2
   q4ALKsbpG6mrNP+mTVu89H6kuxa2KYmviDs1XIaOCjK09rIKqT9JVH7UO
   Vl66JJAgIpseJYjgGl0f0LwHHAo4vqMs3tvLLNdrQ685vYDrsiyTlLPem
   3pgwSuZp3D4EG2tyDSh7GihmRaDr6//eLj5NwJfRimex/tL6cd7KZkJJH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12573462"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="12573462"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 23:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="18867517"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Dec 2023 23:48:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAQA3-0008Ve-2K;
        Tue, 05 Dec 2023 07:48:07 +0000
Date:   Tue, 5 Dec 2023 15:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202312051524.fOUthBRF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 90db9dbedd26ce029f3a0f8d2cbd3a142f452408 kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
date:   9 months ago
config: powerpc-randconfig-r123-20231204 (https://download.01.org/0day-ci/archive/20231205/202312051524.fOUthBRF-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051524.fOUthBRF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051524.fOUthBRF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse:     expected void const *q
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:135:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:138:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse:     got void [noderef] __iomem *irq_0x500
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse:     expected void const *q
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:157:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse:     got void [noderef] __iomem *irq_0x500
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:158:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:165:9: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse:     expected void const *
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:178:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram

vim +135 arch/powerpc/platforms/52xx/mpc52xx_pm.c

2e1ee1f76684c5 Domen Puncer 2007-05-07  114  
2e1ee1f76684c5 Domen Puncer 2007-05-07  115  int mpc52xx_pm_enter(suspend_state_t state)
2e1ee1f76684c5 Domen Puncer 2007-05-07  116  {
2e1ee1f76684c5 Domen Puncer 2007-05-07  117  	u32 clk_enables;
2e1ee1f76684c5 Domen Puncer 2007-05-07  118  	u32 msr, hid0;
2e1ee1f76684c5 Domen Puncer 2007-05-07  119  	u32 intr_main_mask;
d3e0e02804a5f4 Domen Puncer 2007-07-09  120  	void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
2e1ee1f76684c5 Domen Puncer 2007-05-07  121  	unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
741c5640a15a23 Kees Cook    2018-07-02  122  	char saved_0x500[0x600-0x500];
741c5640a15a23 Kees Cook    2018-07-02  123  
741c5640a15a23 Kees Cook    2018-07-02  124  	if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
741c5640a15a23 Kees Cook    2018-07-02  125  		return -ENOMEM;
2e1ee1f76684c5 Domen Puncer 2007-05-07  126  
2e1ee1f76684c5 Domen Puncer 2007-05-07  127  	/* disable all interrupts in PIC */
2e1ee1f76684c5 Domen Puncer 2007-05-07  128  	intr_main_mask = in_be32(&intr->main_mask);
2e1ee1f76684c5 Domen Puncer 2007-05-07  129  	out_be32(&intr->main_mask, intr_main_mask | 0x1ffff);
2e1ee1f76684c5 Domen Puncer 2007-05-07  130  
2e1ee1f76684c5 Domen Puncer 2007-05-07  131  	/* don't let DEC expire any time soon */
2e1ee1f76684c5 Domen Puncer 2007-05-07  132  	mtspr(SPRN_DEC, 0x7fffffff);
2e1ee1f76684c5 Domen Puncer 2007-05-07  133  
2e1ee1f76684c5 Domen Puncer 2007-05-07  134  	/* save SRAM */
2e1ee1f76684c5 Domen Puncer 2007-05-07 @135  	memcpy(saved_sram, sram, sram_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  136  
2e1ee1f76684c5 Domen Puncer 2007-05-07  137  	/* copy low level suspend code to sram */
2e1ee1f76684c5 Domen Puncer 2007-05-07 @138  	memcpy(sram, mpc52xx_ds_sram, mpc52xx_ds_sram_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  139  
2e1ee1f76684c5 Domen Puncer 2007-05-07  140  	out_8(&cdm->ccs_sleep_enable, 1);
2e1ee1f76684c5 Domen Puncer 2007-05-07  141  	out_8(&cdm->osc_sleep_enable, 1);
2e1ee1f76684c5 Domen Puncer 2007-05-07  142  	out_8(&cdm->ccs_qreq_test, 1);
2e1ee1f76684c5 Domen Puncer 2007-05-07  143  
2e1ee1f76684c5 Domen Puncer 2007-05-07  144  	/* disable all but SDRAM and bestcomm (SRAM) clocks */
2e1ee1f76684c5 Domen Puncer 2007-05-07  145  	clk_enables = in_be32(&cdm->clk_enables);
2e1ee1f76684c5 Domen Puncer 2007-05-07  146  	out_be32(&cdm->clk_enables, clk_enables & 0x00088000);
2e1ee1f76684c5 Domen Puncer 2007-05-07  147  
2e1ee1f76684c5 Domen Puncer 2007-05-07  148  	/* disable power management */
2e1ee1f76684c5 Domen Puncer 2007-05-07  149  	msr = mfmsr();
2e1ee1f76684c5 Domen Puncer 2007-05-07  150  	mtmsr(msr & ~MSR_POW);
2e1ee1f76684c5 Domen Puncer 2007-05-07  151  
2e1ee1f76684c5 Domen Puncer 2007-05-07  152  	/* enable sleep mode, disable others */
2e1ee1f76684c5 Domen Puncer 2007-05-07  153  	hid0 = mfspr(SPRN_HID0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  154  	mtspr(SPRN_HID0, (hid0 & ~(HID0_DOZE | HID0_NAP | HID0_DPM)) | HID0_SLEEP);
2e1ee1f76684c5 Domen Puncer 2007-05-07  155  
2e1ee1f76684c5 Domen Puncer 2007-05-07  156  	/* save original, copy our irq handler, flush from dcache and invalidate icache */
2e1ee1f76684c5 Domen Puncer 2007-05-07 @157  	memcpy(saved_0x500, irq_0x500, mpc52xx_ds_cached_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07 @158  	memcpy(irq_0x500, mpc52xx_ds_cached, mpc52xx_ds_cached_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  159  	flush_icache_range((unsigned long)irq_0x500, irq_0x500_stop);
2e1ee1f76684c5 Domen Puncer 2007-05-07  160  
2e1ee1f76684c5 Domen Puncer 2007-05-07  161  	/* call low-level sleep code */
2e1ee1f76684c5 Domen Puncer 2007-05-07  162  	mpc52xx_deep_sleep(sram, sdram, cdm, intr);
2e1ee1f76684c5 Domen Puncer 2007-05-07  163  
2e1ee1f76684c5 Domen Puncer 2007-05-07  164  	/* restore original irq handler */
2e1ee1f76684c5 Domen Puncer 2007-05-07  165  	memcpy(irq_0x500, saved_0x500, mpc52xx_ds_cached_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  166  	flush_icache_range((unsigned long)irq_0x500, irq_0x500_stop);
2e1ee1f76684c5 Domen Puncer 2007-05-07  167  
2e1ee1f76684c5 Domen Puncer 2007-05-07  168  	/* restore old power mode */
2e1ee1f76684c5 Domen Puncer 2007-05-07  169  	mtmsr(msr & ~MSR_POW);
2e1ee1f76684c5 Domen Puncer 2007-05-07  170  	mtspr(SPRN_HID0, hid0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  171  	mtmsr(msr);
2e1ee1f76684c5 Domen Puncer 2007-05-07  172  
2e1ee1f76684c5 Domen Puncer 2007-05-07  173  	out_be32(&cdm->clk_enables, clk_enables);
2e1ee1f76684c5 Domen Puncer 2007-05-07  174  	out_8(&cdm->ccs_sleep_enable, 0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  175  	out_8(&cdm->osc_sleep_enable, 0);
2e1ee1f76684c5 Domen Puncer 2007-05-07  176  
2e1ee1f76684c5 Domen Puncer 2007-05-07  177  	/* restore SRAM */
2e1ee1f76684c5 Domen Puncer 2007-05-07  178  	memcpy(sram, saved_sram, sram_size);
2e1ee1f76684c5 Domen Puncer 2007-05-07  179  
2e1ee1f76684c5 Domen Puncer 2007-05-07  180  	/* reenable interrupts in PIC */
2e1ee1f76684c5 Domen Puncer 2007-05-07  181  	out_be32(&intr->main_mask, intr_main_mask);
2e1ee1f76684c5 Domen Puncer 2007-05-07  182  
2e1ee1f76684c5 Domen Puncer 2007-05-07  183  	return 0;
2e1ee1f76684c5 Domen Puncer 2007-05-07  184  }
2e1ee1f76684c5 Domen Puncer 2007-05-07  185  

:::::: The code at line 135 was first introduced by commit
:::::: 2e1ee1f76684c5d4dd8e5a08cbf22d57f88769ed [POWERPC] mpc52xx suspend to deep-sleep

:::::: TO: Domen Puncer <domen.puncer@telargo.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
