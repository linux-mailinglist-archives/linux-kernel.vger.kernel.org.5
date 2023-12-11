Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256DE80DDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjLKVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:54:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C21BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702331650; x=1733867650;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZlZAFvQjqOhfssyHtpjNDK/wGZ9SY9AXu/xWQtGN1Fo=;
  b=JJBZA+rZ1D44knRUiG1m4zsq8EQTe3MxMJhoFnUm1+vTyLa3n5sk2gNE
   hwDhA6P7cAj8CnYmMsg935Qgiua/rWhwjDvQejRXjTGvVRsD7Gt67vCVC
   LorqbyudqkqjqsykG7rxZ2Yd1hdl609VHzpKFRXtNPrYIBr7G6cc1KBwK
   Vb24wCCvrfI3173OAws4FSruEk2YA/I0DTZJKDLH/nSj0CWjbftr6/eCA
   rFJZq8H3UmVNpm4q95smqDfojzSv3UBJdHjgQBquUoyNQqD2W2VDf1A8E
   NLbaDrtQ7RdEUzWDZyJ1aViOxZTGyxCoAV1mFPs8pCpYFyKvzKnC/a9A9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8077195"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8077195"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="21249696"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2023 13:54:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCoE1-000IVe-09;
        Mon, 11 Dec 2023 21:54:05 +0000
Date:   Tue, 12 Dec 2023 05:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>
Subject: drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202312120556.xUDl8cXT-lkp@intel.com>
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

Hi Sam,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: 156bdac99061b4013c8e47799c6e574f7f84e9f4 drm/exynos: trigger build of all modules
date:   4 years, 6 months ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231212/202312120556.xUDl8cXT-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120556.xUDl8cXT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120556.xUDl8cXT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *timing_base @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse:     expected void *timing_base
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *timing_base @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse:     expected void *timing_base
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/rwsem.h, ...):
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:464:1: sparse: sparse: cast to restricted __le32

vim +470 drivers/gpu/drm/exynos/exynos_drm_fimd.c

a6f75aa161c5a5 Inki Dae              2016-04-18  452  
93bca243ec96f0 Gustavo Padovan       2015-01-18  453  static void fimd_commit(struct exynos_drm_crtc *crtc)
1c248b7d2960fa Inki Dae              2011-10-04  454  {
93bca243ec96f0 Gustavo Padovan       2015-01-18  455  	struct fimd_context *ctx = crtc->ctx;
020e79de265996 Joonyoung Shim        2015-06-02  456  	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
e1a7b9b40d1c0c Marek Szyprowski      2016-04-18  457  	const struct fimd_driver_data *driver_data = ctx->driver_data;
3854fab24e899c YoungJun Cho          2014-07-17  458  	void *timing_base = ctx->regs + driver_data->timing_base;
c96fdfdeca5657 Andrzej Hajda         2016-09-23  459  	u32 val;
1c248b7d2960fa Inki Dae              2011-10-04  460  
e30d4bcf79b6a3 Inki Dae              2011-12-12  461  	if (ctx->suspended)
e30d4bcf79b6a3 Inki Dae              2011-12-12  462  		return;
e30d4bcf79b6a3 Inki Dae              2011-12-12  463  
a968e72771ea19 Sean Paul             2014-01-30  464  	/* nothing to do if we haven't set the mode yet */
a968e72771ea19 Sean Paul             2014-01-30  465  	if (mode->htotal == 0 || mode->vtotal == 0)
a968e72771ea19 Sean Paul             2014-01-30  466  		return;
a968e72771ea19 Sean Paul             2014-01-30  467  
3854fab24e899c YoungJun Cho          2014-07-17  468  	if (ctx->i80_if) {
3854fab24e899c YoungJun Cho          2014-07-17  469  		val = ctx->i80ifcon | I80IFEN_ENABLE;
3854fab24e899c YoungJun Cho          2014-07-17 @470  		writel(val, timing_base + I80IFCONFAx(0));
3854fab24e899c YoungJun Cho          2014-07-17  471  
3854fab24e899c YoungJun Cho          2014-07-17  472  		/* disable auto frame rate */
3854fab24e899c YoungJun Cho          2014-07-17  473  		writel(0, timing_base + I80IFCONFBx(0));
3854fab24e899c YoungJun Cho          2014-07-17  474  
3854fab24e899c YoungJun Cho          2014-07-17  475  		/* set video type selection to I80 interface */
3c3c9c1d904dca Joonyoung Shim        2014-11-14  476  		if (driver_data->has_vtsel && ctx->sysreg &&
3c3c9c1d904dca Joonyoung Shim        2014-11-14  477  				regmap_update_bits(ctx->sysreg,
3854fab24e899c YoungJun Cho          2014-07-17  478  					driver_data->lcdblk_offset,
3854fab24e899c YoungJun Cho          2014-07-17  479  					0x3 << driver_data->lcdblk_vt_shift,
3854fab24e899c YoungJun Cho          2014-07-17  480  					0x1 << driver_data->lcdblk_vt_shift)) {
6f83d20838c099 Inki Dae              2019-04-15  481  			DRM_DEV_ERROR(ctx->dev,
6f83d20838c099 Inki Dae              2019-04-15  482  				      "Failed to update sysreg for I80 i/f.\n");
3854fab24e899c YoungJun Cho          2014-07-17  483  			return;
3854fab24e899c YoungJun Cho          2014-07-17  484  		}
3854fab24e899c YoungJun Cho          2014-07-17  485  	} else {
3854fab24e899c YoungJun Cho          2014-07-17  486  		int vsync_len, vbpd, vfpd, hsync_len, hbpd, hfpd;
3854fab24e899c YoungJun Cho          2014-07-17  487  		u32 vidcon1;
3854fab24e899c YoungJun Cho          2014-07-17  488  
1417f109a82f8a Sean Paul             2014-01-30  489  		/* setup polarity values */
1417f109a82f8a Sean Paul             2014-01-30  490  		vidcon1 = ctx->vidcon1;
1417f109a82f8a Sean Paul             2014-01-30  491  		if (mode->flags & DRM_MODE_FLAG_NVSYNC)
1417f109a82f8a Sean Paul             2014-01-30  492  			vidcon1 |= VIDCON1_INV_VSYNC;
1417f109a82f8a Sean Paul             2014-01-30  493  		if (mode->flags & DRM_MODE_FLAG_NHSYNC)
1417f109a82f8a Sean Paul             2014-01-30  494  			vidcon1 |= VIDCON1_INV_HSYNC;
1417f109a82f8a Sean Paul             2014-01-30  495  		writel(vidcon1, ctx->regs + driver_data->timing_base + VIDCON1);
1c248b7d2960fa Inki Dae              2011-10-04  496  
1c248b7d2960fa Inki Dae              2011-10-04  497  		/* setup vertical timing values. */
a968e72771ea19 Sean Paul             2014-01-30  498  		vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
8b4cad23531da4 Andrzej Hajda         2014-03-17  499  		vbpd = mode->crtc_vtotal - mode->crtc_vsync_end;
8b4cad23531da4 Andrzej Hajda         2014-03-17  500  		vfpd = mode->crtc_vsync_start - mode->crtc_vdisplay;
a968e72771ea19 Sean Paul             2014-01-30  501  
a968e72771ea19 Sean Paul             2014-01-30  502  		val = VIDTCON0_VBPD(vbpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  503  			VIDTCON0_VFPD(vfpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  504  			VIDTCON0_VSPW(vsync_len - 1);
e2e1338900208a Leela Krishna Amudala 2012-09-21  505  		writel(val, ctx->regs + driver_data->timing_base + VIDTCON0);
1c248b7d2960fa Inki Dae              2011-10-04  506  
1c248b7d2960fa Inki Dae              2011-10-04  507  		/* setup horizontal timing values.  */
a968e72771ea19 Sean Paul             2014-01-30  508  		hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
8b4cad23531da4 Andrzej Hajda         2014-03-17  509  		hbpd = mode->crtc_htotal - mode->crtc_hsync_end;
8b4cad23531da4 Andrzej Hajda         2014-03-17  510  		hfpd = mode->crtc_hsync_start - mode->crtc_hdisplay;
a968e72771ea19 Sean Paul             2014-01-30  511  
a968e72771ea19 Sean Paul             2014-01-30  512  		val = VIDTCON1_HBPD(hbpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  513  			VIDTCON1_HFPD(hfpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  514  			VIDTCON1_HSPW(hsync_len - 1);
e2e1338900208a Leela Krishna Amudala 2012-09-21  515  		writel(val, ctx->regs + driver_data->timing_base + VIDTCON1);
3854fab24e899c YoungJun Cho          2014-07-17  516  	}
3854fab24e899c YoungJun Cho          2014-07-17  517  
3854fab24e899c YoungJun Cho          2014-07-17  518  	if (driver_data->has_vidoutcon)
3854fab24e899c YoungJun Cho          2014-07-17  519  		writel(ctx->vidout_con, timing_base + VIDOUT_CON);
3854fab24e899c YoungJun Cho          2014-07-17  520  
3854fab24e899c YoungJun Cho          2014-07-17  521  	/* set bypass selection */
3854fab24e899c YoungJun Cho          2014-07-17  522  	if (ctx->sysreg && regmap_update_bits(ctx->sysreg,
3854fab24e899c YoungJun Cho          2014-07-17  523  				driver_data->lcdblk_offset,
3854fab24e899c YoungJun Cho          2014-07-17  524  				0x1 << driver_data->lcdblk_bypass_shift,
3854fab24e899c YoungJun Cho          2014-07-17  525  				0x1 << driver_data->lcdblk_bypass_shift)) {
6f83d20838c099 Inki Dae              2019-04-15  526  		DRM_DEV_ERROR(ctx->dev,
6f83d20838c099 Inki Dae              2019-04-15  527  			      "Failed to update sysreg for bypass setting.\n");
3854fab24e899c YoungJun Cho          2014-07-17  528  		return;
3854fab24e899c YoungJun Cho          2014-07-17  529  	}
1c248b7d2960fa Inki Dae              2011-10-04  530  
1feafd3afd294b Chanho Park           2016-02-12  531  	/* TODO: When MIC is enabled for display path, the lcdblk_mic_bypass
1feafd3afd294b Chanho Park           2016-02-12  532  	 * bit should be cleared.
1feafd3afd294b Chanho Park           2016-02-12  533  	 */
1feafd3afd294b Chanho Park           2016-02-12  534  	if (driver_data->has_mic_bypass && ctx->sysreg &&
1feafd3afd294b Chanho Park           2016-02-12  535  	    regmap_update_bits(ctx->sysreg,
1feafd3afd294b Chanho Park           2016-02-12  536  				driver_data->lcdblk_offset,
1feafd3afd294b Chanho Park           2016-02-12  537  				0x1 << driver_data->lcdblk_mic_bypass_shift,
1feafd3afd294b Chanho Park           2016-02-12  538  				0x1 << driver_data->lcdblk_mic_bypass_shift)) {
6f83d20838c099 Inki Dae              2019-04-15  539  		DRM_DEV_ERROR(ctx->dev,
6f83d20838c099 Inki Dae              2019-04-15  540  			      "Failed to update sysreg for bypass mic.\n");
1feafd3afd294b Chanho Park           2016-02-12  541  		return;
1feafd3afd294b Chanho Park           2016-02-12  542  	}
1feafd3afd294b Chanho Park           2016-02-12  543  
1c248b7d2960fa Inki Dae              2011-10-04  544  	/* setup horizontal and vertical display size. */
a968e72771ea19 Sean Paul             2014-01-30  545  	val = VIDTCON2_LINEVAL(mode->vdisplay - 1) |
a968e72771ea19 Sean Paul             2014-01-30  546  	       VIDTCON2_HOZVAL(mode->hdisplay - 1) |
a968e72771ea19 Sean Paul             2014-01-30  547  	       VIDTCON2_LINEVAL_E(mode->vdisplay - 1) |
a968e72771ea19 Sean Paul             2014-01-30  548  	       VIDTCON2_HOZVAL_E(mode->hdisplay - 1);
e2e1338900208a Leela Krishna Amudala 2012-09-21  549  	writel(val, ctx->regs + driver_data->timing_base + VIDTCON2);
1c248b7d2960fa Inki Dae              2011-10-04  550  
a6f75aa161c5a5 Inki Dae              2016-04-18  551  	fimd_setup_trigger(ctx);
a6f75aa161c5a5 Inki Dae              2016-04-18  552  
1d531062cdc5fc Andrzej Hajda         2014-03-20  553  	/*
1d531062cdc5fc Andrzej Hajda         2014-03-20  554  	 * fields of register with prefix '_F' would be updated
1d531062cdc5fc Andrzej Hajda         2014-03-20  555  	 * at vsync(same as dma start)
1d531062cdc5fc Andrzej Hajda         2014-03-20  556  	 */
3854fab24e899c YoungJun Cho          2014-07-17  557  	val = ctx->vidcon0;
3854fab24e899c YoungJun Cho          2014-07-17  558  	val |= VIDCON0_ENVID | VIDCON0_ENVID_F;
1c248b7d2960fa Inki Dae              2011-10-04  559  
1d531062cdc5fc Andrzej Hajda         2014-03-20  560  	if (ctx->driver_data->has_clksel)
411d9ed4486a4e Tomasz Figa           2013-05-01  561  		val |= VIDCON0_CLKSEL_LCD;
411d9ed4486a4e Tomasz Figa           2013-05-01  562  
c96fdfdeca5657 Andrzej Hajda         2016-09-23  563  	if (ctx->clkdiv > 1)
c96fdfdeca5657 Andrzej Hajda         2016-09-23  564  		val |= VIDCON0_CLKVAL_F(ctx->clkdiv - 1) | VIDCON0_CLKDIR;
1c248b7d2960fa Inki Dae              2011-10-04  565  
1c248b7d2960fa Inki Dae              2011-10-04  566  	writel(val, ctx->regs + VIDCON0);
1c248b7d2960fa Inki Dae              2011-10-04  567  }
1c248b7d2960fa Inki Dae              2011-10-04  568  

:::::: The code at line 470 was first introduced by commit
:::::: 3854fab24e899c02439657956ab1d2c85001958c drm/exynos: fimd: support LCD I80 interface

:::::: TO: YoungJun Cho <yj44.cho@samsung.com>
:::::: CC: Inki Dae <daeinki@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
