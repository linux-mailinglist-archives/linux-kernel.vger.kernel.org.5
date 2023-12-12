Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817BF80E0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbjLLBma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjLLBm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:42:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A414CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702345355; x=1733881355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L/gJYQh3vkVByJTJ9gcevsmOjIhbT2UnPUYs6fdBNPU=;
  b=cY97ACaWo+cz7xA5dZWHV6RQmmcJ/GB7LrPh5jGyQpmff+7Bsrq1Zgq9
   O/dcvtfw2uA2DgcfgxzubyUXKDo6I0fJlWTxM9UqOL5jSwhXJAO7lwM6v
   qxqVwTocaTjIP38L6gTioEQynA+/SvUfbEV2s2F9xAQo9LworlShABp5r
   J9OZ/zBGNdQy/aZZiQYJ5TIcxf8rLXPWcWGMo0yHinQPCaWE+4ng9lh8C
   CUVXl9rNNG967fBV86SHMmsPETNeNZF+Lc/RTIGzfELAVvzCHrvDVav7U
   kZR/4Ifv8j+c6+0dha0smFHlMD2M+ygiaMifSBgKcAyWzlJnj945iQovm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8101563"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="8101563"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="843729122"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="843729122"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2023 17:42:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCrn2-000IeV-21;
        Tue, 12 Dec 2023 01:42:29 +0000
Date:   Tue, 12 Dec 2023 09:40:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/cirrusfb.c:1852:28: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312120922.hQZ8Qe8k-lkp@intel.com>
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
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   1 year, 4 months ago
config: openrisc-randconfig-r112-20231116 (https://download.01.org/0day-ci/archive/20231212/202312120922.hQZ8Qe8k-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120922.hQZ8Qe8k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120922.hQZ8Qe8k-lkp@intel.com/

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

^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1809  
8503df65976d0f8 drivers/video/cirrusfb.c Krzysztof Helt 2007-10-16  1810  static void cirrusfb_imageblit(struct fb_info *info,
8503df65976d0f8 drivers/video/cirrusfb.c Krzysztof Helt 2007-10-16  1811  			       const struct fb_image *image)
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1812  {
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1813  	struct cirrusfb_info *cinfo = info->par;
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1814  	unsigned char op = (info->var.bits_per_pixel == 24) ? 0xc : 0x4;
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1815  
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1816  	if (info->state != FBINFO_STATE_RUNNING)
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1817  		return;
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1818  	/* Alpine/SD64 does not work at 24bpp ??? */
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1819  	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1)
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1820  		cfb_imageblit(info, image);
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1821  	else if ((cinfo->btype == BT_ALPINE || cinfo->btype == BT_SD64) &&
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1822  		  op == 0xc)
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1823  		cfb_imageblit(info, image);
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1824  	else {
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1825  		unsigned size = ((image->width + 7) >> 3) * image->height;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1826  		int m = info->var.bits_per_pixel;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1827  		u32 fg, bg;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1828  
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1829  		if (info->var.bits_per_pixel == 8) {
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1830  			fg = image->fg_color;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1831  			bg = image->bg_color;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1832  		} else {
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1833  			fg = ((u32 *)(info->pseudo_palette))[image->fg_color];
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1834  			bg = ((u32 *)(info->pseudo_palette))[image->bg_color];
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1835  		}
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1836  		if (info->var.bits_per_pixel == 24) {
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1837  			/* clear background first */
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1838  			cirrusfb_RectFill(cinfo->regbase,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1839  					  info->var.bits_per_pixel,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1840  					  (image->dx * m) / 8, image->dy,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1841  					  (image->width * m) / 8,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1842  					  image->height,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1843  					  bg, bg,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1844  					  info->fix.line_length, 0x40);
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1845  		}
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1846  		cirrusfb_RectFill(cinfo->regbase,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1847  				  info->var.bits_per_pixel,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1848  				  (image->dx * m) / 8, image->dy,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1849  				  (image->width * m) / 8, image->height,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1850  				  fg, bg,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1851  				  info->fix.line_length, op);
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31 @1852  		memcpy(info->screen_base, image->data, size);
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1853  	}
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1854  }
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1855  

:::::: The code at line 1852 was first introduced by commit
:::::: 9e848062533207130667f6eaa748549367ccbedf cirrusfb: add imageblit function

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
