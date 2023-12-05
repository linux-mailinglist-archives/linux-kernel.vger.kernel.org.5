Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0720E80441E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjLEBe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbjLEBex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:34:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB4109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701740099; x=1733276099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zJ48xvNV/rntOOOI8IeUqtJ7XUJw9kAvJGprZq0o640=;
  b=Nx8Zs7j5SzcxTwTcW0VtEROpzF/PDDm1E6GwRXlMDLJY0B/56AKmo6F4
   YnnEU7/yqWo6l9bMG5KdQs0Dbo9J5fwK/rTbEtSACwnjYh10HC3qQOnIL
   EW7iNHsnkRpJphuYqfJ8YNsG1yGPvOLlzE7O5303/bUoa8+nP1bUbd3jX
   P7nQYVD/2i79JAZ47b4KjKgXtrSNHBK0uqBjyFgOH1KTF4citzqh71dR2
   1QioSYC78nTW7U5mgC4HcGQRffUi4tcHhUenxEOxco7vx5U8B5S0QOyan
   WRP3qWrlcn5vbqt8xmT2PfZ8hS4F2FkImxdBmZJ/I0ewxd7aNe5J1zdsz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458147122"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="458147122"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="894190359"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="894190359"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2023 17:34:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAKKp-0008Gp-1Y;
        Tue, 05 Dec 2023 01:34:52 +0000
Date:   Tue, 5 Dec 2023 09:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312050953.VqnvoTk8-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 90db9dbedd26ce029f3a0f8d2cbd3a142f452408 kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
date:   9 months ago
config: powerpc-randconfig-r132-20231117 (https://download.01.org/0day-ci/archive/20231205/202312050953.VqnvoTk8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050953.VqnvoTk8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050953.VqnvoTk8-lkp@intel.com/

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

14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  316  
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  317  /**
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  318   *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  319   *	@sinfo: the frame buffer to allocate memory for
1d01e83557105e7 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  320   * 	
1d01e83557105e7 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  321   * 	This function is called only from the atmel_lcdfb_probe()
1d01e83557105e7 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  322   * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  323   */
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  324  static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  325  {
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  326  	struct fb_info *info = sinfo->info;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  327  	struct fb_var_screeninfo *var = &info->var;
ea757acad5a5183 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  328  	unsigned int smem_len;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  329  
ea757acad5a5183 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  330  	smem_len = (var->xres_virtual * var->yres_virtual
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  331  		    * ((var->bits_per_pixel + 7) / 8));
ea757acad5a5183 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  332  	info->fix.smem_len = max(smem_len, sinfo->smem_len);
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  333  
f6e45661f9be546 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  334  	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
f6e45661f9be546 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  335  					 (dma_addr_t *)&info->fix.smem_start,
f6e45661f9be546 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  336  					 GFP_KERNEL);
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  337  
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  338  	if (!info->screen_base) {
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  339  		return -ENOMEM;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  340  	}
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  341  
01d3a5e7fab7732 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28 @342  	memset(info->screen_base, 0, info->fix.smem_len);
01d3a5e7fab7732 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28  343  
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  344  	return 0;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  345  }
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  346  

:::::: The code at line 342 was first introduced by commit
:::::: 01d3a5e7fab7732cfc5d5d4533e9378ea435295a atmel_lcdfb: don't initialize a pre-allocated framebuffer

:::::: TO: Haavard Skinnemoen <hskinnemoen@atmel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
