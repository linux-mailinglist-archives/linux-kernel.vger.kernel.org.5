Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D21803889
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjLDPTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjLDPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:19:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FBA5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701703156; x=1733239156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HrPuf3RtcFKj+a3zVlizOd1McaTeRaEp1C41H0DqCdo=;
  b=V1RNqtgc+TVrOmBOJz+7/eLESC8TGXARyap7AAoYRCV3C+DMrJHhTjUv
   GSxHGq5LFjNuujnGONEiRZpykO3QL4BMV3f4E36M77Bu+2PcZn4xDS1bW
   nTQUKcP2v308AzztNxAxgf867Xuyq5Oh9kYE33T1UX50IJwNEX7gO+EJv
   2eZ4m6D1do4B/XUKVqCjpP0/DKVpiTw/P12gawXEScRB55PlnBkRZvWbc
   58X35zV3wdXZn8NxxRulAakmQl94CNQKQgiJIlPbsgAO+tHVIuK/f7dHD
   tESxJCw0mMkqXtpldTRyEK3ay7G00bjKpkN8FBQFxS86hZPwBLmf7i5kL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="801135"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="801135"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861405026"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="861405026"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 07:19:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAAj1-0007pu-0i;
        Mon, 04 Dec 2023 15:19:11 +0000
Date:   Mon, 4 Dec 2023 23:18:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/omap/lcdc.c:642:23: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202312042207.lG7YN0oe-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b fbdev: omap: avoid using mach/*.h files
date:   1 year, 7 months ago
config: arm-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231204/202312042207.lG7YN0oe-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312042207.lG7YN0oe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312042207.lG7YN0oe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/omap/lcdc.c:642:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *vaddr @@     got void *static [addressable] [assigned] [toplevel] vram_virt @@
   drivers/video/fbdev/omap/lcdc.c:642:23: sparse:     expected void [noderef] __iomem *vaddr
   drivers/video/fbdev/omap/lcdc.c:642:23: sparse:     got void *static [addressable] [assigned] [toplevel] vram_virt
   drivers/video/fbdev/omap/lcdc.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:258:46: sparse: sparse: self-comparison always evaluates to false
--
>> drivers/video/fbdev/omap/omapfb_main.c:1027:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/omap/omapfb_main.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/radix-tree.h, ...):
   include/linux/page-flags.h:258:46: sparse: sparse: self-comparison always evaluates to false
--
>> drivers/video/fbdev/omap/lcd_mipid.c:451:23: sparse: sparse: cast to restricted __be32
   drivers/video/fbdev/omap/lcd_mipid.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/radix-tree.h, ...):
   include/linux/page-flags.h:258:46: sparse: sparse: self-comparison always evaluates to false

vim +642 drivers/video/fbdev/omap/lcdc.c

569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  620  
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  621  static int alloc_fbmem(struct omapfb_mem_region *region)
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  622  {
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  623  	int bpp;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  624  	int frame_size;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  625  	struct lcd_panel *panel = lcdc.fbdev->panel;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  626  
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  627  	bpp = panel->bpp;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  628  	if (bpp == 12)
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  629  		bpp = 16;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  630  	frame_size = PAGE_ALIGN(panel->x_res * bpp / 8 * panel->y_res);
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  631  	if (region->size > frame_size)
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  632  		frame_size = region->size;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  633  	lcdc.vram_size = frame_size;
f6e45661f9be54 drivers/video/fbdev/omap/lcdc.c Luis R. Rodriguez 2016-01-22  634  	lcdc.vram_virt = dma_alloc_wc(lcdc.fbdev->dev, lcdc.vram_size,
f6e45661f9be54 drivers/video/fbdev/omap/lcdc.c Luis R. Rodriguez 2016-01-22  635  				      &lcdc.vram_phys, GFP_KERNEL);
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  636  	if (lcdc.vram_virt == NULL) {
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  637  		dev_err(lcdc.fbdev->dev, "unable to allocate FB DMA memory\n");
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  638  		return -ENOMEM;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  639  	}
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  640  	region->size = frame_size;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  641  	region->paddr = lcdc.vram_phys;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17 @642  	region->vaddr = lcdc.vram_virt;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  643  	region->alloc = 1;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  644  
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  645  	memset(lcdc.vram_virt, 0, lcdc.vram_size);
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  646  
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  647  	return 0;
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  648  }
569755c706f0f9 drivers/video/omap/lcdc.c       Imre Deak         2007-07-17  649  

:::::: The code at line 642 was first introduced by commit
:::::: 569755c706f0f94409edd2ae60b9878cb420844f OMAP: add TI OMAP1 internal LCD controller

:::::: TO: Imre Deak <imre.deak@solidboot.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
