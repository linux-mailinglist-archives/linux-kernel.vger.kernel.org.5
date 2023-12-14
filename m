Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB13C8123CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442858AbjLNATe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjLNATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:19:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A5DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702513179; x=1734049179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aarCVYzeHq+Ua5lNYgL0T6ML4iSUsMMnv//09P+T8cg=;
  b=HrohSlPKVtEyojvkm/RlvTqcZlRho9d5YEJZqOkBk800FsFa1KYw2QZb
   ELLPz7elk2hE904WkWI4kK1GrQDoH1L7yQkJBcbBpG8QU/ZTJ4gKzEXXQ
   QobQ2GohWf+Inx0LhNgQgzFogbJWabBkmJ/oPuLFfMnG3g9MuUK9jJSBe
   ooprpd3IoOfZ1fY83VNPaIpuNzPrd7yWcbfAFnOfyomqQwWdQt6Nfa0PC
   JBn+v0qIYXd5ja8f/ce4+ZhGsGopGJXh9VN+lVwRl8Dt412b8KJYZTBXv
   vj29DZ2O1FH0F+nrUuV0lIzT5l1IjA3Fx9Fa83J5y1Dvc8xZbRjSJqmSK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="426178792"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="426178792"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="892225296"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="892225296"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2023 16:19:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDZRv-000LKR-1O;
        Thu, 14 Dec 2023 00:19:35 +0000
Date:   Thu, 14 Dec 2023 08:19:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/video/fbdev/atmel_lcdfb.c:342:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312140845.mtTYivLr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 90db9dbedd26ce029f3a0f8d2cbd3a142f452408 kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
date:   9 months ago
config: powerpc-randconfig-r132-20231117 (https://download.01.org/0day-ci/archive/20231214/202312140845.mtTYivLr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312140845.mtTYivLr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140845.mtTYivLr-lkp@intel.com/

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
