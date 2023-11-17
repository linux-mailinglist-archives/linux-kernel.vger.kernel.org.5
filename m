Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D97EFC55
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbjKQX7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346345AbjKQX7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:59:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14910C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700265542; x=1731801542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HwY6nsLLE0cFQbiAF3NYHbRTmkZOKT1Cc53pBEar+LQ=;
  b=lV9fJ9oFeiSWjztpZ33+V86VgZzlcex1lr11mhkhL2CKcQxApPeVeiq4
   EU1VIMO4ieT/NPK5mMGbtGiM1pq2yr5CsXKqlXMVJbA4rNqlhXzCGuGfH
   kH7Xpm9dDuaZ82SOmfXe16HC3J+LoIUZxUej9QVKud8nnvQJNmOKtTIzl
   s2rPYMfV1trlwugICBiP5MiSiDtZ8p7ep+vwF5XEyBLA0FureUgPWcnW2
   3JAdqs5vAcyKCtgFty+5w5WCLpK5MGqfGUrLFI6LKftTtLRRuC5Fy5Abd
   jwm7mALm0O8l4gn/UYNEysYDQgLJBwTZeBWq48V71WfquJV5wN8fkWScT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="422481889"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="422481889"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 15:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="13628607"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2023 15:59:00 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r48jg-0003Jr-37;
        Fri, 17 Nov 2023 23:58:57 +0000
Date:   Sat, 18 Nov 2023 07:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311180713.L5rLtmbc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc40e44f1ddef16a787f3501b97f1fff909177c
commit: 90db9dbedd26ce029f3a0f8d2cbd3a142f452408 kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
date:   8 months ago
config: powerpc-randconfig-r132-20231117 (https://download.01.org/0day-ci/archive/20231118/202311180713.L5rLtmbc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311180713.L5rLtmbc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180713.L5rLtmbc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/atmel_lcdfb.c:334:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
   drivers/video/fbdev/atmel_lcdfb.c:334:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:334:27: sparse:     got void *
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse:     expected void const *
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse:     expected void const *
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse:     expected void *p
   drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false
   drivers/video/fbdev/atmel_lcdfb.c:313:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:313:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:313:59: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:313:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:313:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:313:59: sparse:     got char [noderef] __iomem *screen_base
--
   drivers/mtd/nand/raw/hisi504_nand.c:362:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/hisi504_nand.c:367:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     got void [noderef] __iomem *mmio
>> drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     expected void *p
   drivers/mtd/nand/raw/hisi504_nand.c:465:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     expected void *p
   drivers/mtd/nand/raw/hisi504_nand.c:477:17: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     expected void const *
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *mmio @@
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     expected void *p
   drivers/mtd/nand/raw/hisi504_nand.c:603:9: sparse:     got void [noderef] __iomem *mmio
   drivers/mtd/nand/raw/hisi504_nand.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false

vim +342 drivers/video/fbdev/atmel_lcdfb.c

14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  316  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  317  /**
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  318   *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  319   *	@sinfo: the frame buffer to allocate memory for
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  320   * 	
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  321   * 	This function is called only from the atmel_lcdfb_probe()
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  322   * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  323   */
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  324  static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  325  {
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  326  	struct fb_info *info = sinfo->info;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  327  	struct fb_var_screeninfo *var = &info->var;
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  328  	unsigned int smem_len;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  329  
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  330  	smem_len = (var->xres_virtual * var->yres_virtual
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  331  		    * ((var->bits_per_pixel + 7) / 8));
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  332  	info->fix.smem_len = max(smem_len, sinfo->smem_len);
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  333  
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  334  	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  335  					 (dma_addr_t *)&info->fix.smem_start,
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  336  					 GFP_KERNEL);
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  337  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  338  	if (!info->screen_base) {
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  339  		return -ENOMEM;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  340  	}
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  341  
01d3a5e7fab773 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28 @342  	memset(info->screen_base, 0, info->fix.smem_len);
01d3a5e7fab773 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28  343  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  344  	return 0;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  345  }
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  346  

:::::: The code at line 342 was first introduced by commit
:::::: 01d3a5e7fab7732cfc5d5d4533e9378ea435295a atmel_lcdfb: don't initialize a pre-allocated framebuffer

:::::: TO: Haavard Skinnemoen <hskinnemoen@atmel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
