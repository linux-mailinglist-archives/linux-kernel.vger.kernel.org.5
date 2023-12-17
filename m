Return-Path: <linux-kernel+bounces-2839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B3D8162AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CAA1F21D33
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6C4AF93;
	Sun, 17 Dec 2023 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSo3Kbk8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF49495D6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702850093; x=1734386093;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uHyQaaZSslPLnXZAcBUwwNABa4fZhUmYJ+r+YeeMVq0=;
  b=XSo3Kbk8fApTd5brXk0uhb7qq4DD0MHghNja1c7KsUUbqMCeufKRMSYF
   DsB11jU4aHjOVhFyLWr6+DrcRiVIaFJlfU9BRU7p71U6tvFliEiyQ3KW2
   rW4ihOEvNfAfxQnS+LPRpTv/3XfiZ1Zki2xOnRrd0Gy47ofJpjgdAsKlg
   yxmTkzilTQezeCYpJHCC2NTl+JHcRsAbY7i2OKoKBwBQNap0KuEBz7ZTF
   fdaFroyc2ylxsIkpw0j3hN01r0e2hyGm/NHzFm8C7FNMzgkQw16M9Dzio
   0NThdtQ2mDSqkD3cWuuVCV/KWWUUAPX0J1vj7EW0aBtzddAKUwNutq6mn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="392603619"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="392603619"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 13:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="809604904"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="809604904"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2023 13:54:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEz5y-0003Ro-2L;
	Sun, 17 Dec 2023 21:54:46 +0000
Date: Mon, 18 Dec 2023 05:53:56 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:709:34:
 sparse: sparse: dubious: !x & y
Message-ID: <202312180525.2zRaMHSQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e389834672c723435a44818ed2cabc4dad24429
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   2 years, 6 months ago
config: x86_64-randconfig-121-20231101 (https://download.01.org/0day-ci/archive/20231218/202312180525.2zRaMHSQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180525.2zRaMHSQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180525.2zRaMHSQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:709:34: sparse: sparse: dubious: !x & y

vim +709 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c

74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  385  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  386  static void get_meta_and_pte_attr(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  387  		struct display_mode_lib *mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  388  		display_data_rq_dlg_params_st *rq_dlg_param,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  389  		display_data_rq_misc_params_st *rq_misc_param,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  390  		display_data_rq_sizing_params_st *rq_sizing_param,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  391  		unsigned int vp_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  392  		unsigned int vp_height,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  393  		unsigned int data_pitch,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  394  		unsigned int meta_pitch,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  395  		unsigned int source_format,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  396  		unsigned int tiling,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  397  		unsigned int macro_tile_size,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  398  		unsigned int source_scan,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  399  		unsigned int hostvm_enable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  400  		unsigned int is_chroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  401  		unsigned int surface_height)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  402  {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  403  	bool surf_linear = (tiling == dm_sw_linear);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  404  	bool surf_vert = (source_scan == dm_vert);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  405  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  406  	unsigned int bytes_per_element;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  407  	unsigned int bytes_per_element_y;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  408  	unsigned int bytes_per_element_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  409  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  410  	unsigned int blk256_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  411  	unsigned int blk256_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  412  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  413  	unsigned int blk256_width_y = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  414  	unsigned int blk256_height_y = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  415  	unsigned int blk256_width_c = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  416  	unsigned int blk256_height_c = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  417  	unsigned int log2_bytes_per_element;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  418  	unsigned int log2_blk256_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  419  	unsigned int log2_blk256_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  420  	unsigned int blk_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  421  	unsigned int log2_blk_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  422  	unsigned int log2_blk_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  423  	unsigned int log2_blk_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  424  	unsigned int log2_meta_req_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  425  	unsigned int log2_meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  426  	unsigned int log2_meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  427  	unsigned int meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  428  	unsigned int meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  429  	unsigned int log2_meta_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  430  	unsigned int meta_row_width_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  431  	unsigned int log2_meta_chunk_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  432  	unsigned int log2_meta_chunk_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  433  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  434  	//full sized meta chunk width in unit of data elements
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  435  	unsigned int log2_meta_chunk_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  436  	unsigned int log2_min_meta_chunk_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  437  	unsigned int min_meta_chunk_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  438  	unsigned int meta_chunk_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  439  	unsigned int meta_chunk_per_row_int;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  440  	unsigned int meta_row_remainder;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  441  	unsigned int meta_chunk_threshold;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  442  	unsigned int meta_blk_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  443  	unsigned int meta_surface_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  444  	unsigned int vmpg_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  445  	unsigned int meta_pte_req_per_frame_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  446  	unsigned int meta_pte_bytes_per_frame_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  447  	const unsigned int log2_vmpg_bytes = dml_log2(mode_lib->soc.gpuvm_min_page_size_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  448  	const bool dual_plane_en = is_dual_plane((enum source_format_class) (source_format));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  449  	const unsigned int dpte_buf_in_pte_reqs =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  450  			dual_plane_en ? (is_chroma ? mode_lib->ip.dpte_buffer_size_in_pte_reqs_chroma : mode_lib->ip.dpte_buffer_size_in_pte_reqs_luma) : (mode_lib->ip.dpte_buffer_size_in_pte_reqs_luma
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  451  							+ mode_lib->ip.dpte_buffer_size_in_pte_reqs_chroma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  452  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  453  	unsigned int log2_vmpg_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  454  	unsigned int log2_vmpg_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  455  	unsigned int log2_dpte_req_height_ptes = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  456  	unsigned int log2_dpte_req_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  457  	unsigned int log2_dpte_req_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  458  	unsigned int log2_dpte_row_height_linear = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  459  	unsigned int log2_dpte_row_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  460  	unsigned int log2_dpte_group_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  461  	unsigned int dpte_row_width_ub = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  462  	unsigned int dpte_req_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  463  	unsigned int dpte_req_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  464  	unsigned int dpte_group_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  465  	unsigned int log2_dpte_group_bytes = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  466  	unsigned int log2_dpte_group_length = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  467  	double byte_per_pixel_det_y;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  468  	double byte_per_pixel_det_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  469  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  470  	CalculateBytePerPixelAnd256BBlockSizes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  471  			(enum source_format_class) (source_format),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  472  			(enum dm_swizzle_mode) (tiling),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  473  			&bytes_per_element_y,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  474  			&bytes_per_element_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  475  			&byte_per_pixel_det_y,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  476  			&byte_per_pixel_det_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  477  			&blk256_height_y,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  478  			&blk256_height_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  479  			&blk256_width_y,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  480  			&blk256_width_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  481  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  482  	if (!is_chroma) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  483  		blk256_width = blk256_width_y;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  484  		blk256_height = blk256_height_y;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  485  		bytes_per_element = bytes_per_element_y;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  486  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  487  		blk256_width = blk256_width_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  488  		blk256_height = blk256_height_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  489  		bytes_per_element = bytes_per_element_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  490  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  491  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  492  	log2_bytes_per_element = dml_log2(bytes_per_element);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  493  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  494  	dml_print("DML_DLG: %s: surf_linear        = %d\n", __func__, surf_linear);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  495  	dml_print("DML_DLG: %s: surf_vert          = %d\n", __func__, surf_vert);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  496  	dml_print("DML_DLG: %s: blk256_width       = %d\n", __func__, blk256_width);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  497  	dml_print("DML_DLG: %s: blk256_height      = %d\n", __func__, blk256_height);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  498  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  499  	log2_blk256_width = dml_log2((double) blk256_width);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  500  	log2_blk256_height = dml_log2((double) blk256_height);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  501  	blk_bytes = surf_linear ? 256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  502  	log2_blk_bytes = dml_log2((double) blk_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  503  	log2_blk_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  504  	log2_blk_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  505  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  506  	// remember log rule
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  507  	// "+" in log is multiply
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  508  	// "-" in log is divide
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  509  	// "/2" is like square root
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  510  	// blk is vertical biased
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  511  	if (tiling != dm_sw_linear)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  512  		log2_blk_height = log2_blk256_height + dml_ceil((double) (log2_blk_bytes - 8) / 2.0, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  513  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  514  		log2_blk_height = 0;	// blk height of 1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  515  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  516  	log2_blk_width = log2_blk_bytes - log2_bytes_per_element - log2_blk_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  517  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  518  	if (!surf_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  519  		int unsigned temp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  520  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  521  		temp = dml_round_to_multiple(vp_width - 1, blk256_width, 1) + blk256_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  522  		if (data_pitch < blk256_width) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  523  			dml_print("WARNING: DML_DLG: %s: swath_size calculation ignoring data_pitch=%u < blk256_width=%u\n", __func__, data_pitch, blk256_width);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  524  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  525  			if (temp > data_pitch) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  526  				if (data_pitch >= vp_width)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  527  					temp = data_pitch;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  528  				else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  529  					dml_print("WARNING: DML_DLG: %s: swath_size calculation ignoring data_pitch=%u < vp_width=%u\n", __func__, data_pitch, vp_width);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  530  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  531  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  532  		rq_dlg_param->swath_width_ub = temp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  533  		rq_dlg_param->req_per_swath_ub = temp >> log2_blk256_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  534  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  535  		int unsigned temp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  536  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  537  		temp = dml_round_to_multiple(vp_height - 1, blk256_height, 1) + blk256_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  538  		if (surface_height < blk256_height) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  539  			dml_print("WARNING: DML_DLG: %s swath_size calculation ignored surface_height=%u < blk256_height=%u\n", __func__, surface_height, blk256_height);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  540  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  541  			if (temp > surface_height) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  542  				if (surface_height >= vp_height)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  543  					temp = surface_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  544  				else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  545  					dml_print("WARNING: DML_DLG: %s swath_size calculation ignored surface_height=%u < vp_height=%u\n", __func__, surface_height, vp_height);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  546  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  547  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  548  		rq_dlg_param->swath_width_ub = temp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  549  		rq_dlg_param->req_per_swath_ub = temp >> log2_blk256_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  550  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  551  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  552  	if (!surf_vert)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  553  		rq_misc_param->full_swath_bytes = rq_dlg_param->swath_width_ub * blk256_height * bytes_per_element;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  554  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  555  		rq_misc_param->full_swath_bytes = rq_dlg_param->swath_width_ub * blk256_width * bytes_per_element;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  556  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  557  	rq_misc_param->blk256_height = blk256_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  558  	rq_misc_param->blk256_width = blk256_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  559  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  560  	// -------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  561  	// meta
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  562  	// -------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  563  	log2_meta_req_bytes = 6;	// meta request is 64b and is 8x8byte meta element
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  564  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  565  	// each 64b meta request for dcn is 8x8 meta elements and
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  566  	// a meta element covers one 256b block of the the data surface.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  567  	log2_meta_req_height = log2_blk256_height + 3;	// meta req is 8x8 byte, each byte represent 1 blk256
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  568  	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element - log2_meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  569  	meta_req_width = 1 << log2_meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  570  	meta_req_height = 1 << log2_meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  571  	log2_meta_row_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  572  	meta_row_width_ub = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  573  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  574  	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  575  	// calculate upper bound of the meta_row_width
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  576  	if (!surf_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  577  		log2_meta_row_height = log2_meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  578  		meta_row_width_ub = dml_round_to_multiple(vp_width - 1, meta_req_width, 1) + meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  579  		rq_dlg_param->meta_req_per_row_ub = meta_row_width_ub / meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  580  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  581  		log2_meta_row_height = log2_meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  582  		meta_row_width_ub = dml_round_to_multiple(vp_height - 1, meta_req_height, 1) + meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  583  		rq_dlg_param->meta_req_per_row_ub = meta_row_width_ub / meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  584  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  585  	rq_dlg_param->meta_bytes_per_row_ub = rq_dlg_param->meta_req_per_row_ub * 64;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  586  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  587  	rq_dlg_param->meta_row_height = 1 << log2_meta_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  588  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  589  	log2_meta_chunk_bytes = dml_log2(rq_sizing_param->meta_chunk_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  590  	log2_meta_chunk_height = log2_meta_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  591  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  592  	//full sized meta chunk width in unit of data elements
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  593  	log2_meta_chunk_width = log2_meta_chunk_bytes + 8 - log2_bytes_per_element - log2_meta_chunk_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  594  	log2_min_meta_chunk_bytes = dml_log2(rq_sizing_param->min_meta_chunk_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  595  	min_meta_chunk_width = 1 << (log2_min_meta_chunk_bytes + 8 - log2_bytes_per_element - log2_meta_chunk_height);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  596  	meta_chunk_width = 1 << log2_meta_chunk_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  597  	meta_chunk_per_row_int = (unsigned int) (meta_row_width_ub / meta_chunk_width);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  598  	meta_row_remainder = meta_row_width_ub % meta_chunk_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  599  	meta_chunk_threshold = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  600  	meta_blk_height = blk256_height * 64;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  601  	meta_surface_bytes = meta_pitch * (dml_round_to_multiple(vp_height - 1, meta_blk_height, 1) + meta_blk_height) * bytes_per_element / 256;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  602  	vmpg_bytes = mode_lib->soc.gpuvm_min_page_size_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  603  	meta_pte_req_per_frame_ub = (dml_round_to_multiple(meta_surface_bytes - vmpg_bytes, 8 * vmpg_bytes, 1) + 8 * vmpg_bytes) / (8 * vmpg_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  604  	meta_pte_bytes_per_frame_ub = meta_pte_req_per_frame_ub * 64;	//64B mpte request
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  605  	rq_dlg_param->meta_pte_bytes_per_frame_ub = meta_pte_bytes_per_frame_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  606  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  607  	dml_print("DML_DLG: %s: meta_blk_height             = %d\n", __func__, meta_blk_height);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  608  	dml_print("DML_DLG: %s: meta_surface_bytes          = %d\n", __func__, meta_surface_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  609  	dml_print("DML_DLG: %s: meta_pte_req_per_frame_ub   = %d\n", __func__, meta_pte_req_per_frame_ub);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  610  	dml_print("DML_DLG: %s: meta_pte_bytes_per_frame_ub = %d\n", __func__, meta_pte_bytes_per_frame_ub);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  611  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  612  	if (!surf_vert)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  613  		meta_chunk_threshold = 2 * min_meta_chunk_width - meta_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  614  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  615  		meta_chunk_threshold = 2 * min_meta_chunk_width - meta_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  616  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  617  	if (meta_row_remainder <= meta_chunk_threshold)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  618  		rq_dlg_param->meta_chunks_per_row_ub = meta_chunk_per_row_int + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  619  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  620  		rq_dlg_param->meta_chunks_per_row_ub = meta_chunk_per_row_int + 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  621  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  622  	// ------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  623  	// dpte
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  624  	// ------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  625  	if (surf_linear) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  626  		log2_vmpg_height = 0;   // one line high
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  627  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  628  		log2_vmpg_height = (log2_vmpg_bytes - 8) / 2 + log2_blk256_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  629  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  630  	log2_vmpg_width = log2_vmpg_bytes - log2_bytes_per_element - log2_vmpg_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  631  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  632  	// only 3 possible shapes for dpte request in dimensions of ptes: 8x1, 4x2, 2x4.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  633  	if (surf_linear) { //one 64B PTE request returns 8 PTEs
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  634  		log2_dpte_req_height_ptes = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  635  		log2_dpte_req_width = log2_vmpg_width + 3;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  636  		log2_dpte_req_height = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  637  	} else if (log2_blk_bytes == 12) { //4KB tile means 4kB page size
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  638  		//one 64B req gives 8x1 PTEs for 4KB tile
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  639  		log2_dpte_req_height_ptes = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  640  		log2_dpte_req_width = log2_blk_width + 3;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  641  		log2_dpte_req_height = log2_blk_height + 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  642  	} else if ((log2_blk_bytes >= 16) && (log2_vmpg_bytes == 12)) { // tile block >= 64KB
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  643  		//two 64B reqs of 2x4 PTEs give 16 PTEs to cover 64KB
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  644  		log2_dpte_req_height_ptes = 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  645  		log2_dpte_req_width = log2_blk256_width + 4;		// log2_64KB_width
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  646  		log2_dpte_req_height = log2_blk256_height + 4;		// log2_64KB_height
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  647  	} else { //64KB page size and must 64KB tile block
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  648  		 //one 64B req gives 8x1 PTEs for 64KB tile
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  649  		log2_dpte_req_height_ptes = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  650  		log2_dpte_req_width = log2_blk_width + 3;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  651  		log2_dpte_req_height = log2_blk_height + 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  652  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  653  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  654  	// The dpte request dimensions in data elements is dpte_req_width x dpte_req_height
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  655  	// log2_vmpg_width is how much 1 pte represent, now calculating how much a 64b pte req represent
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  656  	// That depends on the pte shape (i.e. 8x1, 4x2, 2x4)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  657  	//log2_dpte_req_height    = log2_vmpg_height + log2_dpte_req_height_ptes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  658  	//log2_dpte_req_width     = log2_vmpg_width + log2_dpte_req_width_ptes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  659  	dpte_req_height = 1 << log2_dpte_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  660  	dpte_req_width = 1 << log2_dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  661  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  662  	// calculate pitch dpte row buffer can hold
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  663  	// round the result down to a power of two.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  664  	if (surf_linear) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  665  		unsigned int dpte_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  666  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  667  		log2_dpte_row_height_linear = dml_floor(dml_log2(dpte_buf_in_pte_reqs * dpte_req_width / data_pitch), 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  668  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  669  		dml_print("DML_DLG: %s: is_chroma                   = %d\n", __func__, is_chroma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  670  		dml_print("DML_DLG: %s: dpte_buf_in_pte_reqs        = %d\n", __func__, dpte_buf_in_pte_reqs);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  671  		dml_print("DML_DLG: %s: log2_dpte_row_height_linear = %d\n", __func__, log2_dpte_row_height_linear);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  672  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  673  		ASSERT(log2_dpte_row_height_linear >= 3);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  674  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  675  		if (log2_dpte_row_height_linear > 7)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  676  			log2_dpte_row_height_linear = 7;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  677  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  678  		log2_dpte_row_height = log2_dpte_row_height_linear;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  679  		// For linear, the dpte row is pitch dependent and the pte requests wrap at the pitch boundary.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  680  		// the dpte_row_width_ub is the upper bound of data_pitch*dpte_row_height in elements with this unique buffering.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  681  		dpte_row_height = 1 << log2_dpte_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  682  		dpte_row_width_ub = dml_round_to_multiple(data_pitch * dpte_row_height - 1, dpte_req_width, 1) + dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  683  		rq_dlg_param->dpte_req_per_row_ub = dpte_row_width_ub / dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  684  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  685  		// the upper bound of the dpte_row_width without dependency on viewport position follows.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  686  		// for tiled mode, row height is the same as req height and row store up to vp size upper bound
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  687  		if (!surf_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  688  			log2_dpte_row_height = log2_dpte_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  689  			dpte_row_width_ub = dml_round_to_multiple(vp_width - 1, dpte_req_width, 1) + dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  690  			rq_dlg_param->dpte_req_per_row_ub = dpte_row_width_ub / dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  691  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  692  			log2_dpte_row_height = (log2_blk_width < log2_dpte_req_width) ? log2_blk_width : log2_dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  693  			dpte_row_width_ub = dml_round_to_multiple(vp_height - 1, dpte_req_height, 1) + dpte_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  694  			rq_dlg_param->dpte_req_per_row_ub = dpte_row_width_ub / dpte_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  695  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  696  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  697  	if (log2_blk_bytes >= 16 && log2_vmpg_bytes == 12) // tile block >= 64KB
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  698  		rq_dlg_param->dpte_bytes_per_row_ub = rq_dlg_param->dpte_req_per_row_ub * 128; //2*64B dpte request
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  699  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  700  		rq_dlg_param->dpte_bytes_per_row_ub = rq_dlg_param->dpte_req_per_row_ub * 64; //64B dpte request
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  701  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  702  	rq_dlg_param->dpte_row_height = 1 << log2_dpte_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  703  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  704  	// the dpte_group_bytes is reduced for the specific case of vertical
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  705  	// access of a tile surface that has dpte request of 8x1 ptes.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  706  	if (hostvm_enable)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  707  		rq_sizing_param->dpte_group_bytes = 512;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  708  	else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19 @709  		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  710  			rq_sizing_param->dpte_group_bytes = 512;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  711  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  712  			rq_sizing_param->dpte_group_bytes = 2048;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  713  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  714  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  715  	//since pte request size is 64byte, the number of data pte requests per full sized group is as follows.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  716  	log2_dpte_group_bytes = dml_log2(rq_sizing_param->dpte_group_bytes);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  717  	log2_dpte_group_length = log2_dpte_group_bytes - 6; //length in 64b requests
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  718  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  719  	// full sized data pte group width in elements
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  720  	if (!surf_vert)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  721  		log2_dpte_group_width = log2_dpte_group_length + log2_dpte_req_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  722  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  723  		log2_dpte_group_width = log2_dpte_group_length + log2_dpte_req_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  724  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  725  	//But if the tile block >=64KB and the page size is 4KB, then each dPTE request is 2*64B
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  726  	if ((log2_blk_bytes >= 16) && (log2_vmpg_bytes == 12)) // tile block >= 64KB
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  727  		log2_dpte_group_width = log2_dpte_group_width - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  728  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  729  	dpte_group_width = 1 << log2_dpte_group_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  730  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  731  	// since dpte groups are only aligned to dpte_req_width and not dpte_group_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  732  	// the upper bound for the dpte groups per row is as follows.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  733  	rq_dlg_param->dpte_groups_per_row_ub = dml_ceil((double) dpte_row_width_ub / dpte_group_width, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  734  }
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  735  

:::::: The code at line 709 was first introduced by commit
:::::: 74458c081fcfb0423877e630de2746daefdb16e4 drm/amd/display: Add DCN3.1 DML calculation support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

