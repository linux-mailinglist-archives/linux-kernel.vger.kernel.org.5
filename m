Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9747280DB43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344950AbjLKUHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344918AbjLKUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:07:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E7DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702325244; x=1733861244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eV6ALv9dJ4aLcyW2f7YpkBkOH9jP5pA35o2amRmGxg8=;
  b=DKgpF5/BRqYh8Ks+VnoUi2uT0HvjTJfr7fdvRAmeuMSFKy+yKneWkIGR
   wh/vMwFZq18qwFxtxd+8FF7kRFisXicgP35CR5hAJ35ZGuuyR9XlbkWcG
   0IaT8GB1LtUv+wfRpES8ZlOITeD2WX1mJ5t9hDXF/1a1hkv90lttCp3J9
   qvc1Z4B7DtOdRDERuQ595y98sWU4TKbYc8jq0wzre8wpF7bIEKR56cgp8
   TiKaj6Bhx+Id3YQeEOXdzKClWQbVSrlAp9jabsv2mgI9nvDjg53ppqAHM
   LzFXxCnfQyO8HhW27yPImkq3yKvX659/d2+C7kRKkgHhzN3NDs8y4kzCm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="13397885"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="13397885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 12:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104605231"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104605231"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2023 12:07:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCmYf-000IRf-1D;
        Mon, 11 Dec 2023 20:07:17 +0000
Date:   Tue, 12 Dec 2023 04:06:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: drivers/video/fbdev/ffb.c:938:27: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202312120413.oh2xnDJm-lkp@intel.com>
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
commit: aa5222e92f8000ed3c1c38dddf11c83222aadfb3 sched/deadline: Don't use dubious signed bitfields
date:   6 years ago
config: sparc-randconfig-r122-20231116 (https://download.01.org/0day-ci/archive/20231212/202312120413.oh2xnDJm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120413.oh2xnDJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120413.oh2xnDJm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/ffb.c:938:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got char * @@
   drivers/video/fbdev/ffb.c:938:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/ffb.c:938:27: sparse:     got char *
   In file included from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:780,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from drivers/video/fbdev/ffb.c:9:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:159:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     159 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:126:39: note: in definition of macro '__setup_timer'
     126 |                 (_timer)->function = (_fn);                             20-      |                                       ^~~
   include/linux/timer.h: In function 'timer_setup_on_stack':
   include/linux/timer.h:167:39: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     167 |         __setup_timer_on_stack(timer, (TIMER_FUNC_TYPE)callback,
         |                                       ^
   include/linux/timer.h:133:39: note: in definition of macro '__setup_timer_on_stack'
     133 |                 (_timer)->function = (_fn);                             27-      |                                       ^~~
   drivers/video/fbdev/ffb.c:673: warning: Function parameter or member 'blank' not described in 'ffb_blank'
   drivers/video/fbdev/ffb.c:673: warning: Excess function parameter 'blank_mode' description in 'ffb_blank'

vim +938 drivers/video/fbdev/ffb.c

^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   895  
48c68c4f1b5424 drivers/video/ffb.c       Greg Kroah-Hartman 2012-12-21   896  static int ffb_probe(struct platform_device *op)
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   897  {
61c7a080a5a061 drivers/video/ffb.c       Grant Likely       2010-04-13   898  	struct device_node *dp = op->dev.of_node;
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29   899  	struct ffb_fbc __iomem *fbc;
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29   900  	struct ffb_dac __iomem *dac;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   901  	struct fb_info *info;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   902  	struct ffb_par *par;
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   903  	u32 dac_pnum, dac_rev, dac_mrev;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   904  	int err;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   905  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   906  	info = framebuffer_alloc(sizeof(struct ffb_par), &op->dev);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   907  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   908  	err = -ENOMEM;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   909  	if (!info)
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   910  		goto out_err;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   911  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   912  	par = info->par;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   913  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   914  	spin_lock_init(&par->lock);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   915  	par->fbc = of_ioremap(&op->resource[2], 0,
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29   916  			      sizeof(struct ffb_fbc), "ffb fbc");
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   917  	if (!par->fbc)
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   918  		goto out_release_fb;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   919  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   920  	par->dac = of_ioremap(&op->resource[1], 0,
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29   921  			      sizeof(struct ffb_dac), "ffb dac");
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   922  	if (!par->dac)
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   923  		goto out_unmap_fbc;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   924  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   925  	par->rop_cache = FFB_ROP_NEW;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   926  	par->physbase = op->resource[0].start;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   927  
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   928  	/* Don't mention copyarea, so SCROLL_REDRAW is always
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   929  	 * used.  It is the fastest on this chip.
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   930  	 */
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   931  	info->flags = (FBINFO_DEFAULT |
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   932  		       /* FBINFO_HWACCEL_COPYAREA | */
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   933  		       FBINFO_HWACCEL_FILLRECT |
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   934  		       FBINFO_HWACCEL_IMAGEBLIT);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   935  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   936  	info->fbops = &ffb_ops;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   937  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  @938  	info->screen_base = (char *) par->physbase + FFB_DFB24_POFF;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   939  	info->pseudo_palette = par->pseudo_palette;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   940  
6cd5a86b56ec8f drivers/video/ffb.c       Robert Reif        2008-05-08   941  	sbusfb_fill_var(&info->var, dp, 32);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   942  	par->fbsize = PAGE_ALIGN(info->var.xres * info->var.yres * 4);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   943  	ffb_fixup_var_rgb(&info->var);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   944  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   945  	info->var.accel_flags = FB_ACCELF_TEXT;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   946  
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29   947  	if (!strcmp(dp->name, "SUNW,afb"))
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   948  		par->flags |= FFB_FLAG_AFB;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   949  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   950  	par->board_type = of_getintprop_default(dp, "board_type", 0);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   951  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   952  	fbc = par->fbc;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   953  	if ((upa_readl(&fbc->ucsr) & FFB_UCSR_ALL_ERRORS) != 0)
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   954  		upa_writel(FFB_UCSR_ALL_ERRORS, &fbc->ucsr);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   955  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   956  	dac = par->dac;
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   957  	upa_writel(FFB_DAC_DID, &dac->type);
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   958  	dac_pnum = upa_readl(&dac->value);
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   959  	dac_rev = (dac_pnum & FFB_DAC_DID_REV) >> FFB_DAC_DID_REV_SHIFT;
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   960  	dac_pnum = (dac_pnum & FFB_DAC_DID_PNUM) >> FFB_DAC_DID_PNUM_SHIFT;
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   961  
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   962  	upa_writel(FFB_DAC_UCTRL, &dac->type);
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   963  	dac_mrev = upa_readl(&dac->value);
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   964  	dac_mrev = (dac_mrev & FFB_DAC_UCTRL_MANREV) >>
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   965  		FFB_DAC_UCTRL_MANREV_SHIFT;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   966  
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   967  	/* Elite3D has different DAC revision numbering, and no DAC revisions
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   968  	 * have the reversed meaning of cursor enable.  Otherwise, Pacifica 1
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   969  	 * ramdacs with manufacturing revision less than 3 have inverted
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   970  	 * cursor logic.  We identify Pacifica 1 as not Pacifica 2, the
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   971  	 * latter having a part number value of 0x236e.
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   972  	 */
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   973  	if ((par->flags & FFB_FLAG_AFB) || dac_pnum == 0x236e) {
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   974  		par->flags &= ~FFB_FLAG_INVCURSOR;
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   975  	} else {
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   976  		if (dac_mrev < 3)
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   977  			par->flags |= FFB_FLAG_INVCURSOR;
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   978  	}
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26   979  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   980  	ffb_switch_from_graph(par);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   981  
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   982  	/* Unblank it just to be sure.  When there are multiple
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   983  	 * FFB/AFB cards in the system, or it is not the OBP
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   984  	 * chosen console, it will have video outputs off in
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   985  	 * the DAC.
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   986  	 */
59f7137a1369c2 drivers/video/ffb.c       Robert Reif        2008-05-03   987  	ffb_blank(FB_BLANK_UNBLANK, info);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   988  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   989  	if (fb_alloc_cmap(&info->cmap, 256, 0))
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   990  		goto out_unmap_dac;
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   991  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   992  	ffb_init_fix(info);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   993  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   994  	err = register_framebuffer(info);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   995  	if (err < 0)
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   996  		goto out_dealloc_cmap;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   997  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27   998  	dev_set_drvdata(&op->dev, info);
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16   999  
6d7e653300e30f drivers/video/fbdev/ffb.c Rob Herring        2017-08-07  1000  	printk(KERN_INFO "%pOF: %s at %016lx, type %d, "
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26  1001  	       "DAC pnum[%x] rev[%d] manuf_rev[%d]\n",
6d7e653300e30f drivers/video/fbdev/ffb.c Rob Herring        2017-08-07  1002  	       dp,
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1003  	       ((par->flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1004  	       par->physbase, par->board_type,
37db9a348ad425 drivers/video/ffb.c       David S. Miller    2007-03-26  1005  	       dac_pnum, dac_rev, dac_mrev);
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29  1006  
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29  1007  	return 0;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16  1008  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1009  out_dealloc_cmap:
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1010  	fb_dealloc_cmap(&info->cmap);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1011  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1012  out_unmap_dac:
7b0e278519eba8 drivers/video/ffb.c       Axel Lin           2011-02-08  1013  	of_iounmap(&op->resource[1], par->dac, sizeof(struct ffb_dac));
50312ce9dd794e drivers/video/ffb.c       David S. Miller    2006-06-29  1014  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1015  out_unmap_fbc:
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1016  	of_iounmap(&op->resource[2], par->fbc, sizeof(struct ffb_fbc));
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1017  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1018  out_release_fb:
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1019  	framebuffer_release(info);
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1020  
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1021  out_err:
c7f439b99efbea drivers/video/ffb.c       David S. Miller    2007-07-27  1022  	return err;
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16  1023  }
^1da177e4c3f41 drivers/video/ffb.c       Linus Torvalds     2005-04-16  1024  

:::::: The code at line 938 was first introduced by commit
:::::: c7f439b99efbea74c70a5531f92566db5a6731f2 [VIDEO]: Fix OOPS in all SBUS framebuffer drivers.

:::::: TO: David S. Miller <davem@sunset.davemloft.net>
:::::: CC: David S. Miller <davem@sunset.davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
