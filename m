Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D600809673
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjLGXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:12:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330161713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701990756; x=1733526756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PgoMFKpGxhjBEVrUUZeg6L54dIPWQGLxl4CjAsm8rxI=;
  b=jNS9cTFfBEaj+wZapPXSjNV9z44VP3bumIX+Q8KhxUWuBLZ5VLtVcLOJ
   xgPtOVnW3dp6eI40yydFrrTkxWY06v3OGPeB8rXrFjfsBc4M019OtvW2t
   WT5N1SvMosua4tVRK1qNIAmMratUX0iSSRI6qZDBVfiwOm185J80lQSip
   NdB7yXC1fFhCKWAvZ33mP9fFm/FNjsy/7wNnI087gsDdhcvC8+QLdmcCA
   ea+DputC6VG3UrdP/YpyniSMGC0HN+fDZet3pjaaS65VHDoXNFVZvxuHZ
   mx5E9XTa2R4BcUYQZWtWYrhZWNldNgdpySt6vaz5T2n+POJELRCY1kWN2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1205268"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1205268"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1019135724"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1019135724"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2023 15:12:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBNXk-000CyP-18;
        Thu, 07 Dec 2023 23:12:32 +0000
Date:   Fri, 8 Dec 2023 07:12:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/cirrusfb.c:1852:28: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312080725.XVbb9rMk-lkp@intel.com>
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
head:   9ace34a8e446c1a566f3b0a3e0c4c483987e39a6
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   1 year, 4 months ago
config: openrisc-randconfig-r112-20231116 (https://download.01.org/0day-ci/archive/20231208/202312080725.XVbb9rMk-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231208/202312080725.XVbb9rMk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080725.XVbb9rMk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/cirrusfb.c:866:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:867:38: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:871:40: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:873:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:876:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:877:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:878:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:879:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:1245:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:1246:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cirrusfb.c:1247:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/cirrusfb.c:1852:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1852:28: sparse:     expected void *dest
   drivers/video/fbdev/cirrusfb.c:1852:28: sparse:     got char [noderef] __iomem *screen_base

vim +1852 drivers/video/fbdev/cirrusfb.c

^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1809  
8503df65976d0f drivers/video/cirrusfb.c Krzysztof Helt 2007-10-16  1810  static void cirrusfb_imageblit(struct fb_info *info,
8503df65976d0f drivers/video/cirrusfb.c Krzysztof Helt 2007-10-16  1811  			       const struct fb_image *image)
^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1812  {
^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1813  	struct cirrusfb_info *cinfo = info->par;
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1814  	unsigned char op = (info->var.bits_per_pixel == 24) ? 0xc : 0x4;
^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1815  
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1816  	if (info->state != FBINFO_STATE_RUNNING)
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1817  		return;
df3aafd57d590d drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1818  	/* Alpine/SD64 does not work at 24bpp ??? */
df3aafd57d590d drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1819  	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1)
df3aafd57d590d drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1820  		cfb_imageblit(info, image);
df3aafd57d590d drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1821  	else if ((cinfo->btype == BT_ALPINE || cinfo->btype == BT_SD64) &&
df3aafd57d590d drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1822  		  op == 0xc)
^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1823  		cfb_imageblit(info, image);
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1824  	else {
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1825  		unsigned size = ((image->width + 7) >> 3) * image->height;
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1826  		int m = info->var.bits_per_pixel;
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1827  		u32 fg, bg;
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1828  
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1829  		if (info->var.bits_per_pixel == 8) {
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1830  			fg = image->fg_color;
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1831  			bg = image->bg_color;
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1832  		} else {
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1833  			fg = ((u32 *)(info->pseudo_palette))[image->fg_color];
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1834  			bg = ((u32 *)(info->pseudo_palette))[image->bg_color];
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1835  		}
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1836  		if (info->var.bits_per_pixel == 24) {
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1837  			/* clear background first */
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1838  			cirrusfb_RectFill(cinfo->regbase,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1839  					  info->var.bits_per_pixel,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1840  					  (image->dx * m) / 8, image->dy,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1841  					  (image->width * m) / 8,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1842  					  image->height,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1843  					  bg, bg,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1844  					  info->fix.line_length, 0x40);
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1845  		}
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1846  		cirrusfb_RectFill(cinfo->regbase,
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1847  				  info->var.bits_per_pixel,
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1848  				  (image->dx * m) / 8, image->dy,
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1849  				  (image->width * m) / 8, image->height,
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1850  				  fg, bg,
7cade31cabec33 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1851  				  info->fix.line_length, op);
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31 @1852  		memcpy(info->screen_base, image->data, size);
9e848062533207 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1853  	}
^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1854  }
^1da177e4c3f41 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1855  

:::::: The code at line 1852 was first introduced by commit
:::::: 9e848062533207130667f6eaa748549367ccbedf cirrusfb: add imageblit function

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
