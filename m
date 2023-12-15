Return-Path: <linux-kernel+bounces-1837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A386A8154A6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7851F2574E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D5381B2;
	Fri, 15 Dec 2023 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B41yBLg/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF12C699
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702684354; x=1734220354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f6mgmDd8mNTiEm32iKDnHxjpSFzal8h3KsCy90lEEXc=;
  b=B41yBLg/WPg/Rr37B+wTT5K3fRc32R8BwajmB4SdsQ+bBaAT0YNTkK//
   txmB3MxjIrw8ZQ/J3Hwh1OPNpBfZZnwOt4c7Q3QutG3pvQa2cd87FV1gD
   8YCUzHNhctbLtk6eoZa0dkuV6pZC3gv18SZHxqSv1YHa8bYgIy74/2khx
   PmzsBF1qDdF0zU/dU6pRFZCZZlYL6PoGdgXwBBstQvoQIcAwA2M4b7Dl9
   NazOd/trRwhazSR91v65E+/ISQ7m2VJbpbmurJ2zBrYqbyrTCRh6I4z2U
   CvXCSk8yuztkkM7Lr3PynND1XHfeb3Cx62PUi3en7pl9Arp/NEW/yC0jL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="426470541"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="426470541"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948124845"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="948124845"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2023 15:52:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEHym-0000uk-12;
	Fri, 15 Dec 2023 23:52:28 +0000
Date: Sat, 16 Dec 2023 07:51:59 +0800
From: kernel test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/drm/tegra/hub.c:536:(.text+0x1266): relocation truncated
 to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <202312160759.X3dEVpgd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: f75d19827b731c6f24930ef77e5a46cf2242bc68 drm/tegra: Allow compile test on !ARM v2
date:   9 months ago
config: csky-randconfig-r025-20230713 (https://download.01.org/0day-ci/archive/20231216/202312160759.X3dEVpgd-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160759.X3dEVpgd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160759.X3dEVpgd-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tegra/hub.o: in function `tegra_shared_plane_atomic_update':
>> drivers/gpu/drm/tegra/hub.c:536:(.text+0x1266): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/gpu/drm/tegra/hub.c:559:(.text+0x129a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/gpu/drm/tegra/hub.c:565:(.text+0x12aa): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/gpu/drm/tegra/hub.c:567:(.text+0x12b4): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/gpu/drm/tegra/hub.c:606:(.text+0x13c8): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/gpu/drm/tegra/hub.c:617:(.text+0x1436): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'


vim +536 drivers/gpu/drm/tegra/hub.c

ecc583e22d4689 Thierry Reding 2021-05-27  533  
c4755fb9064f64 Thierry Reding 2017-11-13  534  static void tegra_shared_plane_atomic_update(struct drm_plane *plane,
977697e20b3d75 Maxime Ripard  2021-02-19  535  					     struct drm_atomic_state *state)
c4755fb9064f64 Thierry Reding 2017-11-13 @536  {
37418bf14c1392 Maxime Ripard  2021-02-19  537  	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
37418bf14c1392 Maxime Ripard  2021-02-19  538  									   plane);
41016fe1028e4b Maxime Ripard  2021-02-19  539  	struct tegra_plane_state *tegra_plane_state = to_tegra_plane_state(new_state);
e05162c017e2e1 Maxime Ripard  2021-02-19  540  	struct tegra_dc *dc = to_tegra_dc(new_state->crtc);
e05162c017e2e1 Maxime Ripard  2021-02-19  541  	unsigned int zpos = new_state->normalized_zpos;
e05162c017e2e1 Maxime Ripard  2021-02-19  542  	struct drm_framebuffer *fb = new_state->fb;
1087fac18b8e3e Thierry Reding 2017-12-14  543  	struct tegra_plane *p = to_tegra_plane(plane);
ecc583e22d4689 Thierry Reding 2021-05-27  544  	u32 value, min_width, bypass = 0;
e16efff4e5f490 Thierry Reding 2021-05-27  545  	dma_addr_t base, addr_flag = 0;
a649b133c3154f Thierry Reding 2022-01-12  546  	unsigned int bpc, planes;
a649b133c3154f Thierry Reding 2022-01-12  547  	bool yuv;
fd67e9c6ed5af2 Thierry Reding 2019-12-02  548  	int err;
c4755fb9064f64 Thierry Reding 2017-11-13  549  
c4755fb9064f64 Thierry Reding 2017-11-13  550  	/* rien ne va plus */
e05162c017e2e1 Maxime Ripard  2021-02-19  551  	if (!new_state->crtc || !new_state->fb)
c4755fb9064f64 Thierry Reding 2017-11-13  552  		return;
c4755fb9064f64 Thierry Reding 2017-11-13  553  
e05162c017e2e1 Maxime Ripard  2021-02-19  554  	if (!new_state->visible) {
977697e20b3d75 Maxime Ripard  2021-02-19  555  		tegra_shared_plane_atomic_disable(plane, state);
c4755fb9064f64 Thierry Reding 2017-11-13  556  		return;
c4755fb9064f64 Thierry Reding 2017-11-13  557  	}
c4755fb9064f64 Thierry Reding 2017-11-13  558  
fd67e9c6ed5af2 Thierry Reding 2019-12-02  559  	err = host1x_client_resume(&dc->client);
fd67e9c6ed5af2 Thierry Reding 2019-12-02  560  	if (err < 0) {
fd67e9c6ed5af2 Thierry Reding 2019-12-02  561  		dev_err(dc->dev, "failed to resume: %d\n", err);
fd67e9c6ed5af2 Thierry Reding 2019-12-02  562  		return;
fd67e9c6ed5af2 Thierry Reding 2019-12-02  563  	}
c4755fb9064f64 Thierry Reding 2017-11-13  564  
a649b133c3154f Thierry Reding 2022-01-12  565  	yuv = tegra_plane_format_is_yuv(tegra_plane_state->format, &planes, &bpc);
e16efff4e5f490 Thierry Reding 2021-05-27  566  
c4755fb9064f64 Thierry Reding 2017-11-13  567  	tegra_dc_assign_shared_plane(dc, p);
c4755fb9064f64 Thierry Reding 2017-11-13  568  
c4755fb9064f64 Thierry Reding 2017-11-13  569  	tegra_plane_writel(p, VCOUNTER, DC_WIN_CORE_ACT_CONTROL);
c4755fb9064f64 Thierry Reding 2017-11-13  570  
c4755fb9064f64 Thierry Reding 2017-11-13  571  	/* blending */
c4755fb9064f64 Thierry Reding 2017-11-13  572  	value = BLEND_FACTOR_DST_ALPHA_ZERO | BLEND_FACTOR_SRC_ALPHA_K2 |
c4755fb9064f64 Thierry Reding 2017-11-13  573  		BLEND_FACTOR_DST_COLOR_NEG_K1_TIMES_SRC |
c4755fb9064f64 Thierry Reding 2017-11-13  574  		BLEND_FACTOR_SRC_COLOR_K1_TIMES_SRC;
c4755fb9064f64 Thierry Reding 2017-11-13  575  	tegra_plane_writel(p, value, DC_WIN_BLEND_MATCH_SELECT);
c4755fb9064f64 Thierry Reding 2017-11-13  576  
c4755fb9064f64 Thierry Reding 2017-11-13  577  	value = BLEND_FACTOR_DST_ALPHA_ZERO | BLEND_FACTOR_SRC_ALPHA_K2 |
c4755fb9064f64 Thierry Reding 2017-11-13  578  		BLEND_FACTOR_DST_COLOR_NEG_K1_TIMES_SRC |
c4755fb9064f64 Thierry Reding 2017-11-13  579  		BLEND_FACTOR_SRC_COLOR_K1_TIMES_SRC;
c4755fb9064f64 Thierry Reding 2017-11-13  580  	tegra_plane_writel(p, value, DC_WIN_BLEND_NOMATCH_SELECT);
c4755fb9064f64 Thierry Reding 2017-11-13  581  
ab7d3f5826c55a Thierry Reding 2017-12-14  582  	value = K2(255) | K1(255) | WINDOW_LAYER_DEPTH(255 - zpos);
c4755fb9064f64 Thierry Reding 2017-11-13  583  	tegra_plane_writel(p, value, DC_WIN_BLEND_LAYER_CONTROL);
c4755fb9064f64 Thierry Reding 2017-11-13  584  
ecc583e22d4689 Thierry Reding 2021-05-27  585  	/* scaling */
ecc583e22d4689 Thierry Reding 2021-05-27  586  	min_width = min(new_state->src_w >> 16, new_state->crtc_w);
ecc583e22d4689 Thierry Reding 2021-05-27  587  
ecc583e22d4689 Thierry Reding 2021-05-27  588  	value = tegra_plane_readl(p, DC_WINC_PRECOMP_WGRP_PIPE_CAPC);
ecc583e22d4689 Thierry Reding 2021-05-27  589  
ecc583e22d4689 Thierry Reding 2021-05-27  590  	if (min_width < MAX_PIXELS_5TAP444(value)) {
ecc583e22d4689 Thierry Reding 2021-05-27  591  		value = HORIZONTAL_TAPS_5 | VERTICAL_TAPS_5;
ecc583e22d4689 Thierry Reding 2021-05-27  592  	} else {
ecc583e22d4689 Thierry Reding 2021-05-27  593  		value = tegra_plane_readl(p, DC_WINC_PRECOMP_WGRP_PIPE_CAPE);
ecc583e22d4689 Thierry Reding 2021-05-27  594  
ecc583e22d4689 Thierry Reding 2021-05-27  595  		if (min_width < MAX_PIXELS_2TAP444(value))
ecc583e22d4689 Thierry Reding 2021-05-27  596  			value = HORIZONTAL_TAPS_2 | VERTICAL_TAPS_2;
ecc583e22d4689 Thierry Reding 2021-05-27  597  		else
ecc583e22d4689 Thierry Reding 2021-05-27  598  			dev_err(dc->dev, "invalid minimum width: %u\n", min_width);
ecc583e22d4689 Thierry Reding 2021-05-27  599  	}
ecc583e22d4689 Thierry Reding 2021-05-27  600  
c4755fb9064f64 Thierry Reding 2017-11-13  601  	value = HORIZONTAL_TAPS_5 | VERTICAL_TAPS_5;
c4755fb9064f64 Thierry Reding 2017-11-13  602  	tegra_plane_writel(p, value, DC_WIN_WINDOWGROUP_SET_CONTROL_INPUT_SCALER);
c4755fb9064f64 Thierry Reding 2017-11-13  603  
ecc583e22d4689 Thierry Reding 2021-05-27  604  	if (new_state->src_w != new_state->crtc_w << 16) {
ecc583e22d4689 Thierry Reding 2021-05-27  605  		fixed20_12 width = dfixed_init(new_state->src_w >> 16);
ecc583e22d4689 Thierry Reding 2021-05-27  606  		u32 incr = compute_phase_incr(width, new_state->crtc_w) & ~0x1;
ecc583e22d4689 Thierry Reding 2021-05-27  607  		u32 init = (1 << (NFB - 1)) + (incr >> 1);
ecc583e22d4689 Thierry Reding 2021-05-27  608  
ecc583e22d4689 Thierry Reding 2021-05-27  609  		tegra_plane_writel(p, incr, DC_WIN_SET_INPUT_SCALER_HPHASE_INCR);
ecc583e22d4689 Thierry Reding 2021-05-27  610  		tegra_plane_writel(p, init, DC_WIN_SET_INPUT_SCALER_H_START_PHASE);
ecc583e22d4689 Thierry Reding 2021-05-27  611  	} else {
ecc583e22d4689 Thierry Reding 2021-05-27  612  		bypass |= INPUT_SCALER_HBYPASS;
ecc583e22d4689 Thierry Reding 2021-05-27  613  	}
ecc583e22d4689 Thierry Reding 2021-05-27  614  
ecc583e22d4689 Thierry Reding 2021-05-27  615  	if (new_state->src_h != new_state->crtc_h << 16) {
ecc583e22d4689 Thierry Reding 2021-05-27  616  		fixed20_12 height = dfixed_init(new_state->src_h >> 16);
ecc583e22d4689 Thierry Reding 2021-05-27  617  		u32 incr = compute_phase_incr(height, new_state->crtc_h) & ~0x1;
ecc583e22d4689 Thierry Reding 2021-05-27  618  		u32 init = (1 << (NFB - 1)) + (incr >> 1);
ecc583e22d4689 Thierry Reding 2021-05-27  619  
ecc583e22d4689 Thierry Reding 2021-05-27  620  		tegra_plane_writel(p, incr, DC_WIN_SET_INPUT_SCALER_VPHASE_INCR);
ecc583e22d4689 Thierry Reding 2021-05-27  621  		tegra_plane_writel(p, init, DC_WIN_SET_INPUT_SCALER_V_START_PHASE);
ecc583e22d4689 Thierry Reding 2021-05-27  622  	} else {
ecc583e22d4689 Thierry Reding 2021-05-27  623  		bypass |= INPUT_SCALER_VBYPASS;
ecc583e22d4689 Thierry Reding 2021-05-27  624  	}
ecc583e22d4689 Thierry Reding 2021-05-27  625  
ecc583e22d4689 Thierry Reding 2021-05-27  626  	tegra_plane_writel(p, bypass, DC_WIN_WINDOWGROUP_SET_INPUT_SCALER_USAGE);
c4755fb9064f64 Thierry Reding 2017-11-13  627  
c4755fb9064f64 Thierry Reding 2017-11-13  628  	/* disable compression */
c4755fb9064f64 Thierry Reding 2017-11-13  629  	tegra_plane_writel(p, 0, DC_WINBUF_CDE_CONTROL);
c4755fb9064f64 Thierry Reding 2017-11-13  630  

:::::: The code at line 536 was first introduced by commit
:::::: c4755fb9064f64083fe559e92a46df817fc5e07b drm/tegra: Add Tegra186 display hub support

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

