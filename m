Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D166879DC08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjILWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjILWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:43:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88B10EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694558585; x=1726094585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PlHSU90+0N8rhEWREl04BGkk7Jzf3/BgZ0qW3gb/PFo=;
  b=NKLeCPPbpOvO6eeEZZ9v6bS2WE2qIi7RWf/kRJzAyguH/AvIgKd6PLIs
   gvRUDyfwt4oPLR0EShxjhw6OBAgjJC7XMvu9nk1NHvR3c9n8/IbSynCEa
   wTCVtuF/7UQ0WcNEZDkMG4EXEZlNWvGTaMSr2uNNE5oQuTVhKsNlDRSbm
   l1v5udWOGyqDoDP0b1CndNY1WOzhDlBoYNT1eCKUBSgmgTkl59iaVVgxU
   YeYm/J4jFoL5ybA1T6mQF77ZhKBvneJE1mQ3K7G+zg9xGFkozmLsxu3sJ
   xXFymmx1r2fzLvVC1ZB6sADgoMYuwjDfIe1qGSLX/8rdxlUZp8TuUyq34
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358784390"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="358784390"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="814007332"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="814007332"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2023 15:43:03 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgC61-0000NO-1X;
        Tue, 12 Sep 2023 22:43:01 +0000
Date:   Wed, 13 Sep 2023 06:42:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:undefined reference to
 `fb_io_read'
Message-ID: <202309130632.LS04CPWu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: 5f86367006c6a0662faaf36f753f437afe42fb63 fbdev/sh7760fb: Use fbdev I/O helpers
date:   6 weeks ago
config: sh-randconfig-r012-20230913 (https://download.01.org/0day-ci/archive/20230913/202309130632.LS04CPWu-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130632.LS04CPWu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130632.LS04CPWu-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
   sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
   sh4-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
   sh4-linux-ld: sh7760fb.c:(.text+0x39c): undefined reference to `fb_alloc_cmap'
   sh4-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
   sh4-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
   sh4-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
   sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
   sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
   sh4-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
   sh4-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
>> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
   sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
   sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
   sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
