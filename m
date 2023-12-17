Return-Path: <linux-kernel+bounces-2440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305F815D35
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A845D1F22289
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079C10F2;
	Sun, 17 Dec 2023 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR0SnXIm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A488A32
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702779976; x=1734315976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vKn6vctbU8U/iPOCJrNJkFIWAmLMIABwf719opRmtSs=;
  b=UR0SnXImn7cqppSYA5nHDTrZyq/CqiCOs41jPnsMq1cy8W1OhRz9ziyo
   1eeLpMxIbGOOfdtU51cKFU/hxq0yxpr9XXicGkFkVEzwllTLqHS7HFq+Z
   csL7K+EdDjgjFpeVl+6HmFVhj9rS3KSW9Id3RcxbdPtSnJ0HwGphuGqnq
   kYK1QgoJRSEr1884IGMxc01b0mDtDXadnCCNrdEBwWzgdOmkARL1Za02Y
   NJtC33zDuEqmsFCyyyKAbp5rHRaf86qXnXC+0srMlhwv9BhJv1EskR3gv
   bCRtd0cXnSAgWoBPxGN39BcSwTA1PZ9lI8iD2yrPfNQgHKDUsuik8Jqn1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="426529146"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="426529146"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 18:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="865827626"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="865827626"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2023 18:26:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEgr6-0002WJ-0l;
	Sun, 17 Dec 2023 02:26:12 +0000
Date: Sun, 17 Dec 2023 10:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312171050.VRjziNZK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 59c1ad914ef2d3470f74c626ece9521dbc9645a3 video: fbdev: atmel_lcdfb: add COMPILE_TEST support
date:   4 years, 6 months ago
config: arc-randconfig-r111-20231107 (https://download.01.org/0day-ci/archive/20231217/202312171050.VRjziNZK-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231217/202312171050.VRjziNZK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171050.VRjziNZK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:     got void *
>> drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:     expected void *ptr
   drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     got char [noderef] __iomem *screen_base

vim +362 drivers/video/fbdev/atmel_lcdfb.c

14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  336  
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  337  /**
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  338   *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  339   *	@sinfo: the frame buffer to allocate memory for
1d01e83557105e7 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  340   * 	
1d01e83557105e7 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  341   * 	This function is called only from the atmel_lcdfb_probe()
1d01e83557105e7 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  342   * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  343   */
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  344  static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  345  {
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  346  	struct fb_info *info = sinfo->info;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  347  	struct fb_var_screeninfo *var = &info->var;
ea757acad5a5183 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  348  	unsigned int smem_len;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  349  
ea757acad5a5183 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  350  	smem_len = (var->xres_virtual * var->yres_virtual
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  351  		    * ((var->bits_per_pixel + 7) / 8));
ea757acad5a5183 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  352  	info->fix.smem_len = max(smem_len, sinfo->smem_len);
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  353  
f6e45661f9be546 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  354  	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
f6e45661f9be546 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  355  					 (dma_addr_t *)&info->fix.smem_start,
f6e45661f9be546 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  356  					 GFP_KERNEL);
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  357  
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  358  	if (!info->screen_base) {
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  359  		return -ENOMEM;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  360  	}
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  361  
01d3a5e7fab7732 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28 @362  	memset(info->screen_base, 0, info->fix.smem_len);
01d3a5e7fab7732 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28  363  
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  364  	return 0;
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  365  }
14340586148e7c8 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  366  

:::::: The code at line 362 was first introduced by commit
:::::: 01d3a5e7fab7732cfc5d5d4533e9378ea435295a atmel_lcdfb: don't initialize a pre-allocated framebuffer

:::::: TO: Haavard Skinnemoen <hskinnemoen@atmel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

