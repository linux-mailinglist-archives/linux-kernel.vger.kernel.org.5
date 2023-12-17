Return-Path: <linux-kernel+bounces-2587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8EC815F25
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7487E283010
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF9C4314E;
	Sun, 17 Dec 2023 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwrMEAKL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D742AB8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702818312; x=1734354312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qVVxHAz0775cJtGVIJqaGSM55in7iyGv042rjtczA1Y=;
  b=IwrMEAKLpgs8Ww8OQl4wfNwenyICSYe6DauA5GNUVUd5DUbFH9ccT8FV
   Eht2bFPqNbWicrrfOlvSIHBZjqWjph8BUtlJiUv/obnY7dQzejlTsCfUa
   ok8tQ0M4qoZ2J96WgbBsF6OxV2QkJ9ffIydUaoaS+2aWJv+1xVlLXLfYa
   zuMIbqbwDJAxSz1Herr8b57FCjHzaCdlXKPlnZcKwFFEL6CupZBWx0FvR
   P59ULOWyDKJNUaxHlXKe50lJGdviQ5WSSVp35jNIjVz1qolTX+jCrzdUe
   zl22Gmv0uGi5pjzlFUBuhjdzzsXe+vkGYOntgqni1gTT1Pu9I9BVoVrM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="374913928"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="374913928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 05:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="918972933"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="918972933"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2023 05:05:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEqpP-00033S-1g;
	Sun, 17 Dec 2023 13:05:07 +0000
Date: Sun, 17 Dec 2023 21:04:50 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:700:34:
 sparse: sparse: dubious: !x & y
Message-ID: <202312172053.xbjFdzIY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 20f2ffe504728612d7b0c34e4f8280e34251e704 drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v3)
date:   3 years, 1 month ago
config: x86_64-randconfig-121-20231101 (https://download.01.org/0day-ci/archive/20231217/202312172053.xbjFdzIY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312172053.xbjFdzIY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172053.xbjFdzIY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:700:34: sparse: sparse: dubious: !x & y

vim +700 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c

6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  349  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  350  static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  351  	display_data_rq_dlg_params_st *rq_dlg_param,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  352  	display_data_rq_misc_params_st *rq_misc_param,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  353  	display_data_rq_sizing_params_st *rq_sizing_param,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  354  	unsigned int vp_width,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  355  	unsigned int vp_height,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  356  	unsigned int data_pitch,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  357  	unsigned int meta_pitch,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  358  	unsigned int source_format,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  359  	unsigned int tiling,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  360  	unsigned int macro_tile_size,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  361  	unsigned int source_scan,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  362  	unsigned int hostvm_enable,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  363  	unsigned int is_chroma,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  364  	unsigned int surface_height)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  365  {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  366  	bool surf_linear = (tiling == dm_sw_linear);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  367  	bool surf_vert = (source_scan == dm_vert);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  368  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  369  	unsigned int bytes_per_element = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  370  	unsigned int bytes_per_element_y = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  371  	unsigned int bytes_per_element_c = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  372  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  373  	unsigned int blk256_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  374  	unsigned int blk256_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  375  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  376  	unsigned int blk256_width_y = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  377  	unsigned int blk256_height_y = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  378  	unsigned int blk256_width_c = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  379  	unsigned int blk256_height_c = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  380  	unsigned int log2_bytes_per_element = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  381  	unsigned int log2_blk256_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  382  	unsigned int log2_blk256_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  383  	unsigned int blk_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  384  	unsigned int log2_blk_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  385  	unsigned int log2_blk_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  386  	unsigned int log2_blk_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  387  	unsigned int log2_meta_req_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  388  	unsigned int log2_meta_req_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  389  	unsigned int log2_meta_req_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  390  	unsigned int meta_req_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  391  	unsigned int meta_req_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  392  	unsigned int log2_meta_row_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  393  	unsigned int meta_row_width_ub = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  394  	unsigned int log2_meta_chunk_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  395  	unsigned int log2_meta_chunk_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  396  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  397  	//full sized meta chunk width in unit of data elements
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  398  	unsigned int log2_meta_chunk_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  399  	unsigned int log2_min_meta_chunk_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  400  	unsigned int min_meta_chunk_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  401  	unsigned int meta_chunk_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  402  	unsigned int meta_chunk_per_row_int = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  403  	unsigned int meta_row_remainder = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  404  	unsigned int meta_chunk_threshold = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  405  	unsigned int meta_blk_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  406  	unsigned int meta_blk_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  407  	unsigned int meta_blk_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  408  	unsigned int meta_surface_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  409  	unsigned int vmpg_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  410  	unsigned int meta_pte_req_per_frame_ub = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  411  	unsigned int meta_pte_bytes_per_frame_ub = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  412  	const unsigned int log2_vmpg_bytes = dml_log2(mode_lib->soc.gpuvm_min_page_size_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  413  	const bool dual_plane_en = is_dual_plane((enum source_format_class)(source_format));
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  414  	const unsigned int dpte_buf_in_pte_reqs = dual_plane_en ?
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  415  		(is_chroma ? mode_lib->ip.dpte_buffer_size_in_pte_reqs_chroma : mode_lib->ip.dpte_buffer_size_in_pte_reqs_luma)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  416  		: (mode_lib->ip.dpte_buffer_size_in_pte_reqs_luma + mode_lib->ip.dpte_buffer_size_in_pte_reqs_chroma);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  417  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  418  	unsigned int log2_vmpg_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  419  	unsigned int log2_vmpg_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  420  	unsigned int log2_dpte_req_height_ptes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  421  	unsigned int log2_dpte_req_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  422  	unsigned int log2_dpte_req_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  423  	unsigned int log2_dpte_row_height_linear = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  424  	unsigned int log2_dpte_row_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  425  	unsigned int log2_dpte_group_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  426  	unsigned int dpte_row_width_ub = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  427  	unsigned int dpte_req_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  428  	unsigned int dpte_req_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  429  	unsigned int dpte_group_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  430  	unsigned int log2_dpte_group_bytes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  431  	unsigned int log2_dpte_group_length = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  432  	double byte_per_pixel_det_y = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  433  	double byte_per_pixel_det_c = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  434  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  435  	CalculateBytePerPixelAnd256BBlockSizes((enum source_format_class)(source_format),
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  436  		(enum dm_swizzle_mode)(tiling),
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  437  		&bytes_per_element_y,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  438  		&bytes_per_element_c,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  439  		&byte_per_pixel_det_y,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  440  		&byte_per_pixel_det_c,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  441  		&blk256_height_y,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  442  		&blk256_height_c,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  443  		&blk256_width_y,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  444  		&blk256_width_c);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  445  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  446  	if (!is_chroma) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  447  		blk256_width = blk256_width_y;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  448  		blk256_height = blk256_height_y;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  449  		bytes_per_element = bytes_per_element_y;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  450  	} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  451  		blk256_width = blk256_width_c;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  452  		blk256_height = blk256_height_c;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  453  		bytes_per_element = bytes_per_element_c;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  454  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  455  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  456  	log2_bytes_per_element = dml_log2(bytes_per_element);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  457  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  458  	dml_print("DML_DLG: %s: surf_linear        = %d\n", __func__, surf_linear);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  459  	dml_print("DML_DLG: %s: surf_vert          = %d\n", __func__, surf_vert);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  460  	dml_print("DML_DLG: %s: blk256_width       = %d\n", __func__, blk256_width);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  461  	dml_print("DML_DLG: %s: blk256_height      = %d\n", __func__, blk256_height);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  462  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  463  	log2_blk256_width = dml_log2((double)blk256_width);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  464  	log2_blk256_height = dml_log2((double)blk256_height);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  465  	blk_bytes = surf_linear ?
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  466  		256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  467  	log2_blk_bytes = dml_log2((double)blk_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  468  	log2_blk_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  469  	log2_blk_width = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  470  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  471  	// remember log rule
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  472  	// "+" in log is multiply
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  473  	// "-" in log is divide
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  474  	// "/2" is like square root
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  475  	// blk is vertical biased
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  476  	if (tiling != dm_sw_linear)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  477  		log2_blk_height = log2_blk256_height
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  478  		+ dml_ceil((double)(log2_blk_bytes - 8) / 2.0, 1);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  479  	else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  480  		log2_blk_height = 0;  // blk height of 1
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  481  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  482  	log2_blk_width = log2_blk_bytes - log2_bytes_per_element - log2_blk_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  483  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  484  	if (!surf_vert) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  485  		int unsigned temp = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  486  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  487  		temp = dml_round_to_multiple(vp_width - 1, blk256_width, 1) + blk256_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  488  		if (data_pitch < blk256_width) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  489  			dml_print("WARNING: DML_DLG: %s: swath_size calculation ignoring data_pitch=%u < blk256_width=%u\n", __func__, data_pitch, blk256_width);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  490  		} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  491  			if (temp > data_pitch) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  492  				if (data_pitch >= vp_width)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  493  					temp = data_pitch;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  494  				else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  495  					dml_print("WARNING: DML_DLG: %s: swath_size calculation ignoring data_pitch=%u < vp_width=%u\n", __func__, data_pitch, vp_width);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  496  			}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  497  		}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  498  		rq_dlg_param->swath_width_ub = temp;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  499  		rq_dlg_param->req_per_swath_ub = temp >> log2_blk256_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  500  	} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  501  		int unsigned temp = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  502  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  503  		temp = dml_round_to_multiple(vp_height - 1, blk256_height, 1) + blk256_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  504  		if (surface_height < blk256_height) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  505  			dml_print("WARNING: DML_DLG: %s swath_size calculation ignored surface_height=%u < blk256_height=%u\n", __func__, surface_height, blk256_height);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  506  		} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  507  			if (temp > surface_height) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  508  				if (surface_height >= vp_height)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  509  					temp = surface_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  510  				else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  511  					dml_print("WARNING: DML_DLG: %s swath_size calculation ignored surface_height=%u < vp_height=%u\n", __func__, surface_height, vp_height);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  512  			}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  513  		}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  514  		rq_dlg_param->swath_width_ub = temp;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  515  		rq_dlg_param->req_per_swath_ub = temp >> log2_blk256_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  516  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  517  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  518  	if (!surf_vert)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  519  		rq_misc_param->full_swath_bytes = rq_dlg_param->swath_width_ub * blk256_height
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  520  		* bytes_per_element;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  521  	else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  522  		rq_misc_param->full_swath_bytes = rq_dlg_param->swath_width_ub * blk256_width
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  523  		* bytes_per_element;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  524  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  525  	rq_misc_param->blk256_height = blk256_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  526  	rq_misc_param->blk256_width = blk256_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  527  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  528  	// -------
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  529  	// meta
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  530  	// -------
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  531  	log2_meta_req_bytes = 6; // meta request is 64b and is 8x8byte meta element
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  532  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  533  				 // each 64b meta request for dcn is 8x8 meta elements and
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  534  				 // a meta element covers one 256b block of the the data surface.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  535  	log2_meta_req_height = log2_blk256_height + 3; // meta req is 8x8 byte, each byte represent 1 blk256
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  536  	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  537  		- log2_meta_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  538  	meta_req_width = 1 << log2_meta_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  539  	meta_req_height = 1 << log2_meta_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  540  	log2_meta_row_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  541  	meta_row_width_ub = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  542  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  543  	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  544  	// calculate upper bound of the meta_row_width
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  545  	if (!surf_vert) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  546  		log2_meta_row_height = log2_meta_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  547  		meta_row_width_ub = dml_round_to_multiple(vp_width - 1, meta_req_width, 1)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  548  			+ meta_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  549  		rq_dlg_param->meta_req_per_row_ub = meta_row_width_ub / meta_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  550  	} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  551  		log2_meta_row_height = log2_meta_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  552  		meta_row_width_ub = dml_round_to_multiple(vp_height - 1, meta_req_height, 1)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  553  			+ meta_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  554  		rq_dlg_param->meta_req_per_row_ub = meta_row_width_ub / meta_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  555  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  556  	rq_dlg_param->meta_bytes_per_row_ub = rq_dlg_param->meta_req_per_row_ub * 64;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  557  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  558  	rq_dlg_param->meta_row_height = 1 << log2_meta_row_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  559  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  560  	log2_meta_chunk_bytes = dml_log2(rq_sizing_param->meta_chunk_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  561  	log2_meta_chunk_height = log2_meta_row_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  562  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  563  	//full sized meta chunk width in unit of data elements
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  564  	log2_meta_chunk_width = log2_meta_chunk_bytes + 8 - log2_bytes_per_element
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  565  		- log2_meta_chunk_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  566  	log2_min_meta_chunk_bytes = dml_log2(rq_sizing_param->min_meta_chunk_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  567  	min_meta_chunk_width = 1
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  568  		<< (log2_min_meta_chunk_bytes + 8 - log2_bytes_per_element
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  569  			- log2_meta_chunk_height);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  570  	meta_chunk_width = 1 << log2_meta_chunk_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  571  	meta_chunk_per_row_int = (unsigned int)(meta_row_width_ub / meta_chunk_width);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  572  	meta_row_remainder = meta_row_width_ub % meta_chunk_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  573  	meta_chunk_threshold = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  574  	meta_blk_bytes = 4096;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  575  	meta_blk_height = blk256_height * 64;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  576  	meta_blk_width = meta_blk_bytes * 256 / bytes_per_element / meta_blk_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  577  	meta_surface_bytes = meta_pitch
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  578  		* (dml_round_to_multiple(vp_height - 1, meta_blk_height, 1) + meta_blk_height)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  579  		* bytes_per_element / 256;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  580  	vmpg_bytes = mode_lib->soc.gpuvm_min_page_size_bytes;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  581  	meta_pte_req_per_frame_ub = (dml_round_to_multiple(meta_surface_bytes - vmpg_bytes,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  582  		8 * vmpg_bytes,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  583  		1) + 8 * vmpg_bytes) / (8 * vmpg_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  584  	meta_pte_bytes_per_frame_ub = meta_pte_req_per_frame_ub * 64; //64B mpte request
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  585  	rq_dlg_param->meta_pte_bytes_per_frame_ub = meta_pte_bytes_per_frame_ub;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  586  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  587  	dml_print("DML_DLG: %s: meta_blk_height             = %d\n", __func__, meta_blk_height);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  588  	dml_print("DML_DLG: %s: meta_blk_width              = %d\n", __func__, meta_blk_width);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  589  	dml_print("DML_DLG: %s: meta_surface_bytes          = %d\n", __func__, meta_surface_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  590  	dml_print("DML_DLG: %s: meta_pte_req_per_frame_ub   = %d\n",
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  591  		__func__,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  592  		meta_pte_req_per_frame_ub);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  593  	dml_print("DML_DLG: %s: meta_pte_bytes_per_frame_ub = %d\n",
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  594  		__func__,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  595  		meta_pte_bytes_per_frame_ub);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  596  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  597  	if (!surf_vert)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  598  		meta_chunk_threshold = 2 * min_meta_chunk_width - meta_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  599  	else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  600  		meta_chunk_threshold = 2 * min_meta_chunk_width - meta_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  601  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  602  	if (meta_row_remainder <= meta_chunk_threshold)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  603  		rq_dlg_param->meta_chunks_per_row_ub = meta_chunk_per_row_int + 1;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  604  	else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  605  		rq_dlg_param->meta_chunks_per_row_ub = meta_chunk_per_row_int + 2;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  606  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  607  	// ------
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  608  	// dpte
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  609  	// ------
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  610  	if (surf_linear) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  611  		log2_vmpg_height = 0;   // one line high
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  612  	} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  613  		log2_vmpg_height = (log2_vmpg_bytes - 8) / 2 + log2_blk256_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  614  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  615  	log2_vmpg_width = log2_vmpg_bytes - log2_bytes_per_element - log2_vmpg_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  616  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  617  	// only 3 possible shapes for dpte request in dimensions of ptes: 8x1, 4x2, 2x4.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  618  	if (surf_linear) { //one 64B PTE request returns 8 PTEs
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  619  		log2_dpte_req_height_ptes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  620  		log2_dpte_req_width = log2_vmpg_width + 3;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  621  		log2_dpte_req_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  622  	} else if (log2_blk_bytes == 12) { //4KB tile means 4kB page size
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  623  					 //one 64B req gives 8x1 PTEs for 4KB tile
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  624  		log2_dpte_req_height_ptes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  625  		log2_dpte_req_width = log2_blk_width + 3;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  626  		log2_dpte_req_height = log2_blk_height + 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  627  	} else if ((log2_blk_bytes >= 16) && (log2_vmpg_bytes == 12)) { // tile block >= 64KB
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  628  									  //two 64B reqs of 2x4 PTEs give 16 PTEs to cover 64KB
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  629  		log2_dpte_req_height_ptes = 4;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  630  		log2_dpte_req_width = log2_blk256_width + 4; // log2_64KB_width
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  631  		log2_dpte_req_height = log2_blk256_height + 4; // log2_64KB_height
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  632  	} else { //64KB page size and must 64KB tile block
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  633  		   //one 64B req gives 8x1 PTEs for 64KB tile
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  634  		log2_dpte_req_height_ptes = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  635  		log2_dpte_req_width = log2_blk_width + 3;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  636  		log2_dpte_req_height = log2_blk_height + 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  637  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  638  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  639  	// The dpte request dimensions in data elements is dpte_req_width x dpte_req_height
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  640  	// log2_vmpg_width is how much 1 pte represent, now calculating how much a 64b pte req represent
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  641  	// That depends on the pte shape (i.e. 8x1, 4x2, 2x4)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  642  	//log2_dpte_req_height	= log2_vmpg_height + log2_dpte_req_height_ptes;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  643  	//log2_dpte_req_width	 = log2_vmpg_width + log2_dpte_req_width_ptes;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  644  	dpte_req_height = 1 << log2_dpte_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  645  	dpte_req_width = 1 << log2_dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  646  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  647  	// calculate pitch dpte row buffer can hold
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  648  	// round the result down to a power of two.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  649  	if (surf_linear) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  650  		unsigned int dpte_row_height = 0;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  651  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  652  		log2_dpte_row_height_linear = dml_floor(dml_log2(dpte_buf_in_pte_reqs * dpte_req_width / data_pitch), 1);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  653  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  654  		dml_print("DML_DLG: %s: is_chroma                   = %d\n", __func__, is_chroma);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  655  		dml_print("DML_DLG: %s: dpte_buf_in_pte_reqs        = %d\n", __func__, dpte_buf_in_pte_reqs);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  656  		dml_print("DML_DLG: %s: log2_dpte_row_height_linear = %d\n", __func__, log2_dpte_row_height_linear);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  657  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  658  		ASSERT(log2_dpte_row_height_linear >= 3);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  659  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  660  		if (log2_dpte_row_height_linear > 7)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  661  			log2_dpte_row_height_linear = 7;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  662  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  663  		log2_dpte_row_height = log2_dpte_row_height_linear;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  664  		// For linear, the dpte row is pitch dependent and the pte requests wrap at the pitch boundary.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  665  		// the dpte_row_width_ub is the upper bound of data_pitch*dpte_row_height in elements with this unique buffering.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  666  		dpte_row_height = 1 << log2_dpte_row_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  667  		dpte_row_width_ub = dml_round_to_multiple(data_pitch * dpte_row_height - 1,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  668  			dpte_req_width,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  669  			1) + dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  670  		rq_dlg_param->dpte_req_per_row_ub = dpte_row_width_ub / dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  671  	} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  672  		// the upper bound of the dpte_row_width without dependency on viewport position follows.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  673  		// for tiled mode, row height is the same as req height and row store up to vp size upper bound
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  674  		if (!surf_vert) {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  675  			log2_dpte_row_height = log2_dpte_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  676  			dpte_row_width_ub = dml_round_to_multiple(vp_width - 1, dpte_req_width, 1)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  677  				+ dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  678  			rq_dlg_param->dpte_req_per_row_ub = dpte_row_width_ub / dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  679  		} else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  680  			log2_dpte_row_height =
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  681  				(log2_blk_width < log2_dpte_req_width) ?
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  682  				log2_blk_width : log2_dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  683  			dpte_row_width_ub = dml_round_to_multiple(vp_height - 1, dpte_req_height, 1)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  684  				+ dpte_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  685  			rq_dlg_param->dpte_req_per_row_ub = dpte_row_width_ub / dpte_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  686  		}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  687  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  688  	if (log2_blk_bytes >= 16 && log2_vmpg_bytes == 12) // tile block >= 64KB
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  689  		rq_dlg_param->dpte_bytes_per_row_ub = rq_dlg_param->dpte_req_per_row_ub * 128; //2*64B dpte request
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  690  	else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  691  		rq_dlg_param->dpte_bytes_per_row_ub = rq_dlg_param->dpte_req_per_row_ub * 64; //64B dpte request
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  692  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  693  	rq_dlg_param->dpte_row_height = 1 << log2_dpte_row_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  694  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  695  	// the dpte_group_bytes is reduced for the specific case of vertical
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  696  	// access of a tile surface that has dpte request of 8x1 ptes.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  697  	if (hostvm_enable)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  698  		rq_sizing_param->dpte_group_bytes = 512;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  699  	else {
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21 @700  		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  701  			rq_sizing_param->dpte_group_bytes = 512;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  702  		else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  703  			rq_sizing_param->dpte_group_bytes = 2048;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  704  	}
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  705  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  706  	//since pte request size is 64byte, the number of data pte requests per full sized group is as follows.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  707  	log2_dpte_group_bytes = dml_log2(rq_sizing_param->dpte_group_bytes);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  708  	log2_dpte_group_length = log2_dpte_group_bytes - 6; //length in 64b requests
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  709  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  710  								// full sized data pte group width in elements
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  711  	if (!surf_vert)
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  712  		log2_dpte_group_width = log2_dpte_group_length + log2_dpte_req_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  713  	else
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  714  		log2_dpte_group_width = log2_dpte_group_length + log2_dpte_req_height;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  715  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  716  	//But if the tile block >=64KB and the page size is 4KB, then each dPTE request is 2*64B
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  717  	if ((log2_blk_bytes >= 16) && (log2_vmpg_bytes == 12)) // tile block >= 64KB
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  718  		log2_dpte_group_width = log2_dpte_group_width - 1;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  719  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  720  	dpte_group_width = 1 << log2_dpte_group_width;
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  721  
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  722  	// since dpte groups are only aligned to dpte_req_width and not dpte_group_width,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  723  	// the upper bound for the dpte groups per row is as follows.
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  724  	rq_dlg_param->dpte_groups_per_row_ub = dml_ceil((double)dpte_row_width_ub / dpte_group_width,
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  725  		1);
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  726  }
6725a88f88a7e9 Bhawanpreet Lakha 2020-05-21  727  

:::::: The code at line 700 was first introduced by commit
:::::: 6725a88f88a7e922e91c45bf83d320487810c192 drm/amd/display: Add DCN3 DML

:::::: TO: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

