Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345977E5BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjKHQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjKHQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:50:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A11FF1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699462219; x=1730998219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w4UecrG/xe8Gp2x6WkT7Z6cLoxSuMPKXewORdOV6Lk4=;
  b=HQxI+Z2EL4dQaKojqCmzHVvoodMtj7bCxJccTp+1lV7oCmk9WEhzV4+j
   I5EhmoZrdjuQKzYYdYSWfGQVZU3T34AOx2HghDiHJ7vlrAF0S88OtWdJx
   AcZEVGG4JUtuMUyEIac73bBDblW2iwuJBRf+EXhI0oPbB3ahPWWE//Rur
   1hjWlcaO5K8e30PT+X/BIxChTP02C/oP/R5nP5QlixcnF8YUBPNTQ2E36
   mF/00+ftptw46azvqgSG8Yf8ABQxLS8qsrT/idhCtPAuErH2IM17IWWbV
   j74hNm3ByaY1CVbSbFRl0szVrguZxtEenAjgT8LAxRCZh2rPycCgOTPKh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="380199977"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="380199977"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 08:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="833536645"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="833536645"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2023 08:50:16 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0lkt-000838-0s;
        Wed, 08 Nov 2023 16:50:15 +0000
Date:   Thu, 9 Nov 2023 00:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jun Yi <yijun@loongson.cn>
Subject: drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311090011.Vf8aIXTo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   305230142ae0637213bf6e04f6d9f10bbcb74af8
commit: a275a82dcd4024c75337db15d59ed039c31e21da LoongArch: Use alternative to optimize libraries
date:   11 months ago
config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231109/202311090011.Vf8aIXTo-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231109/202311090011.Vf8aIXTo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090011.Vf8aIXTo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:     got void *
>> drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:     expected void *__s
   drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     got char [noderef] __iomem *screen_base

vim +362 drivers/video/fbdev/atmel_lcdfb.c

14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  336  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  337  /**
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  338   *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  339   *	@sinfo: the frame buffer to allocate memory for
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  340   * 	
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  341   * 	This function is called only from the atmel_lcdfb_probe()
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  342   * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  343   */
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  344  static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  345  {
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  346  	struct fb_info *info = sinfo->info;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  347  	struct fb_var_screeninfo *var = &info->var;
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  348  	unsigned int smem_len;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  349  
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  350  	smem_len = (var->xres_virtual * var->yres_virtual
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  351  		    * ((var->bits_per_pixel + 7) / 8));
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  352  	info->fix.smem_len = max(smem_len, sinfo->smem_len);
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  353  
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  354  	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  355  					 (dma_addr_t *)&info->fix.smem_start,
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  356  					 GFP_KERNEL);
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  357  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  358  	if (!info->screen_base) {
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  359  		return -ENOMEM;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  360  	}
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  361  
01d3a5e7fab773 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28 @362  	memset(info->screen_base, 0, info->fix.smem_len);
01d3a5e7fab773 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28  363  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  364  	return 0;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  365  }
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  366  

:::::: The code at line 362 was first introduced by commit
:::::: 01d3a5e7fab7732cfc5d5d4533e9378ea435295a atmel_lcdfb: don't initialize a pre-allocated framebuffer

:::::: TO: Haavard Skinnemoen <hskinnemoen@atmel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
