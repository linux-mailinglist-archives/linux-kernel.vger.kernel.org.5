Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303E7F0A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjKTCCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKTCB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:01:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3395
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700445712; x=1731981712;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=acIdsuiiK850rdFn5dP3mJw/4RpBCLvC0XpHZM8vFRY=;
  b=PT/gIsmM3aBEOourOFtSXS+Z+8wOe+hacapMWhs7+TVyDdWpw6SuOImP
   8FnZTZqohXGWDkpMBkFayN1/LI/wigPoLYfOXY0G6RROW0uzyVJtRpSna
   or9JTgAic1NtRk1q2WVGoTzR41sGNABB+TRfb09iYhWQLKPNRvtDs1UCM
   tGYBeqqqP3xQJQk4tGz1MNIlW8FOu2/VnfFqx63n7wPgf06XbBjviOIsj
   hrvyWhMUZ9gbZwqoQwvOP0SAkAG6F1AyfNZYM8cLet3qmshBcWdnLkopM
   d3bKgNfjmP7EeeT3GTGazaJEAjwyFdVNCsa2qpqDYGtthBWH/z4/M6nV1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381924847"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="381924847"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 18:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856855548"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="856855548"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2023 18:01:49 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4tbR-0005pB-3B;
        Mon, 20 Nov 2023 02:01:39 +0000
Date:   Mon, 20 Nov 2023 10:01:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
Message-ID: <202311200955.pmjdQEM1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: 7966f319c66d9468623c6a6a017ecbc0dd79be75 drm/amd/display: Introduce DML2
date:   6 weeks ago
config: x86_64-randconfig-121-20231119 (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200955.pmjdQEM1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
   warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12: warning: stack frame size (3368) exceeds limit (2048) in 'dml_core_mode_support' [-Wframe-larger-than]
   dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
              ^
   2183/3368 (64.82%) spills, 1185/3368 (35.18%) variables
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8241:6: warning: stack frame size (2232) exceeds limit (2048) in 'dml_core_mode_programming' [-Wframe-larger-than]
   void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struct dml_clk_cfg_st *clk_cfg)
        ^
   1441/2232 (64.56%) spills, 791/2232 (35.44%) variables
   4 warnings generated.


vim +/dml_core_mode_support +6193 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c

  6191	
  6192	/// @brief The Mode Support function.
> 6193	dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
  6194	{
  6195		struct dml_core_mode_support_locals_st *s = &mode_lib->scratch.dml_core_mode_support_locals;
  6196		struct CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params_st *CalculateWatermarks_params = &mode_lib->scratch.CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params;
  6197		struct CalculateVMRowAndSwath_params_st *CalculateVMRowAndSwath_params = &mode_lib->scratch.CalculateVMRowAndSwath_params;
  6198		struct UseMinimumDCFCLK_params_st *UseMinimumDCFCLK_params = &mode_lib->scratch.UseMinimumDCFCLK_params;
  6199		struct CalculateSwathAndDETConfiguration_params_st *CalculateSwathAndDETConfiguration_params = &mode_lib->scratch.CalculateSwathAndDETConfiguration_params;
  6200		struct CalculatePrefetchSchedule_params_st *CalculatePrefetchSchedule_params = &mode_lib->scratch.CalculatePrefetchSchedule_params;
  6201		struct DmlPipe *myPipe;
  6202	
  6203		dml_uint_t j, k, m;
  6204	
  6205		mode_lib->ms.num_active_planes = dml_get_num_active_planes(&mode_lib->ms.cache_display_cfg);
  6206		dml_print("DML::%s: num_active_planes = %u\n", __func__, mode_lib->ms.num_active_planes);
  6207	
  6208		CalculateMaxDETAndMinCompressedBufferSize(
  6209									mode_lib->ms.ip.config_return_buffer_size_in_kbytes,
  6210									mode_lib->ms.ip.config_return_buffer_segment_size_in_kbytes,
  6211									mode_lib->ms.ip.rob_buffer_size_kbytes,
  6212									mode_lib->ms.ip.max_num_dpp,
  6213									mode_lib->ms.policy.NomDETInKByteOverrideEnable,   // VBA_DELTA
  6214									mode_lib->ms.policy.NomDETInKByteOverrideValue,    // VBA_DELTA
  6215	
  6216									/* Output */
  6217									&mode_lib->ms.MaxTotalDETInKByte,
  6218									&mode_lib->ms.NomDETInKByte,
  6219									&mode_lib->ms.MinCompressedBufferSizeInKByte);
  6220	
  6221		PixelClockAdjustmentForProgressiveToInterlaceUnit(&mode_lib->ms.cache_display_cfg, mode_lib->ms.ip.ptoi_supported);
  6222	
  6223	
  6224		/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
  6225	
  6226		/*Scale Ratio, taps Support Check*/
  6227		mode_lib->ms.support.ScaleRatioAndTapsSupport = true;
  6228		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6229			if (mode_lib->ms.cache_display_cfg.plane.ScalerEnabled[k] == false
  6230					&& ((mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_64
  6231							&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_32
  6232							&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_16
  6233							&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_mono_16
  6234							&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_mono_8
  6235							&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_rgbe
  6236							&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_rgbe_alpha)
  6237							|| mode_lib->ms.cache_display_cfg.plane.HRatio[k] != 1.0
  6238							|| mode_lib->ms.cache_display_cfg.plane.HTaps[k] != 1.0
  6239							|| mode_lib->ms.cache_display_cfg.plane.VRatio[k] != 1.0
  6240							|| mode_lib->ms.cache_display_cfg.plane.VTaps[k] != 1.0)) {
  6241				mode_lib->ms.support.ScaleRatioAndTapsSupport = false;
  6242			} else if (mode_lib->ms.cache_display_cfg.plane.VTaps[k] < 1.0 || mode_lib->ms.cache_display_cfg.plane.VTaps[k] > 8.0
  6243					|| mode_lib->ms.cache_display_cfg.plane.HTaps[k] < 1.0 || mode_lib->ms.cache_display_cfg.plane.HTaps[k] > 8.0
  6244					|| (mode_lib->ms.cache_display_cfg.plane.HTaps[k] > 1.0 && (mode_lib->ms.cache_display_cfg.plane.HTaps[k] % 2) == 1)
  6245					|| mode_lib->ms.cache_display_cfg.plane.HRatio[k] > mode_lib->ms.ip.max_hscl_ratio
  6246					|| mode_lib->ms.cache_display_cfg.plane.VRatio[k] > mode_lib->ms.ip.max_vscl_ratio
  6247					|| mode_lib->ms.cache_display_cfg.plane.HRatio[k] > mode_lib->ms.cache_display_cfg.plane.HTaps[k]
  6248					|| mode_lib->ms.cache_display_cfg.plane.VRatio[k] > mode_lib->ms.cache_display_cfg.plane.VTaps[k]
  6249					|| (mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_64
  6250						&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_32
  6251						&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_16
  6252						&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_mono_16
  6253						&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_mono_8
  6254						&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_rgbe
  6255						&& (mode_lib->ms.cache_display_cfg.plane.VTapsChroma[k] < 1 || mode_lib->ms.cache_display_cfg.plane.VTapsChroma[k] > 8 || mode_lib->ms.cache_display_cfg.plane.HTapsChroma[k] < 1 || mode_lib->ms.cache_display_cfg.plane.HTapsChroma[k] > 8 ||
  6256							(mode_lib->ms.cache_display_cfg.plane.HTapsChroma[k] > 1 && mode_lib->ms.cache_display_cfg.plane.HTapsChroma[k] % 2 == 1) ||
  6257						mode_lib->ms.cache_display_cfg.plane.HRatioChroma[k] > mode_lib->ms.ip.max_hscl_ratio ||
  6258						mode_lib->ms.cache_display_cfg.plane.VRatioChroma[k] > mode_lib->ms.ip.max_vscl_ratio ||
  6259						mode_lib->ms.cache_display_cfg.plane.HRatioChroma[k] > mode_lib->ms.cache_display_cfg.plane.HTapsChroma[k] ||
  6260						mode_lib->ms.cache_display_cfg.plane.VRatioChroma[k] > mode_lib->ms.cache_display_cfg.plane.VTapsChroma[k]))) {
  6261				mode_lib->ms.support.ScaleRatioAndTapsSupport = false;
  6262			}
  6263		}
  6264	
  6265		/*Source Format, Pixel Format and Scan Support Check*/
  6266		mode_lib->ms.support.SourceFormatPixelAndScanSupport = true;
  6267		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6268				if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear && (!(!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) || mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true)) {
  6269				mode_lib->ms.support.SourceFormatPixelAndScanSupport = false;
  6270			}
  6271		}
  6272	
  6273		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6274			CalculateBytePerPixelAndBlockSizes(
  6275									mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k],
  6276									mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k],
  6277	
  6278									/* Output */
  6279									&mode_lib->ms.BytePerPixelY[k],
  6280									&mode_lib->ms.BytePerPixelC[k],
  6281									&mode_lib->ms.BytePerPixelInDETY[k],
  6282									&mode_lib->ms.BytePerPixelInDETC[k],
  6283									&mode_lib->ms.Read256BlockHeightY[k],
  6284									&mode_lib->ms.Read256BlockHeightC[k],
  6285									&mode_lib->ms.Read256BlockWidthY[k],
  6286									&mode_lib->ms.Read256BlockWidthC[k],
  6287									&mode_lib->ms.MacroTileHeightY[k],
  6288									&mode_lib->ms.MacroTileHeightC[k],
  6289									&mode_lib->ms.MacroTileWidthY[k],
  6290									&mode_lib->ms.MacroTileWidthC[k]);
  6291		}
  6292	
  6293		/*Bandwidth Support Check*/
  6294		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6295			if (!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) {
  6296				mode_lib->ms.SwathWidthYSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportWidth[k];
  6297				mode_lib->ms.SwathWidthCSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportWidthChroma[k];
  6298			} else {
  6299				mode_lib->ms.SwathWidthYSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportHeight[k];
  6300				mode_lib->ms.SwathWidthCSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportHeightChroma[k];
  6301			}
  6302		}
  6303		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6304			mode_lib->ms.ReadBandwidthLuma[k] = mode_lib->ms.SwathWidthYSingleDPP[k] * dml_ceil(mode_lib->ms.BytePerPixelInDETY[k], 1.0) / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.cache_display_cfg.plane.VRatio[k];
  6305			mode_lib->ms.ReadBandwidthChroma[k] = mode_lib->ms.SwathWidthYSingleDPP[k] / 2 * dml_ceil(mode_lib->ms.BytePerPixelInDETC[k], 2.0) / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.cache_display_cfg.plane.VRatio[k] / 2.0;
  6306		}
  6307		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6308			if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true
  6309					&& mode_lib->ms.cache_display_cfg.writeback.WritebackPixelFormat[k] == dml_444_64) {
  6310				mode_lib->ms.WriteBandwidth[k] = mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[k]
  6311						* mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationHeight[k]
  6312						/ (mode_lib->ms.cache_display_cfg.writeback.WritebackSourceHeight[k]
  6313								* mode_lib->ms.cache_display_cfg.timing.HTotal[k]
  6314								/ mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * 8.0;
  6315			} else if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
  6316				mode_lib->ms.WriteBandwidth[k] = mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[k]
  6317						* mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationHeight[k]
  6318						/ (mode_lib->ms.cache_display_cfg.writeback.WritebackSourceHeight[k]
  6319								* mode_lib->ms.cache_display_cfg.timing.HTotal[k]
  6320								/ mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * 4.0;
  6321			} else {
  6322				mode_lib->ms.WriteBandwidth[k] = 0.0;
  6323			}
  6324		}
  6325	
  6326		/*Writeback Latency support check*/
  6327		mode_lib->ms.support.WritebackLatencySupport = true;
  6328		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6329			if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true &&
  6330				(mode_lib->ms.WriteBandwidth[k] > mode_lib->ms.ip.writeback_interface_buffer_size_kbytes * 1024 / mode_lib->ms.state.writeback_latency_us)) {
  6331				mode_lib->ms.support.WritebackLatencySupport = false;
  6332			}
  6333		}
  6334	
  6335		/*Writeback Mode Support Check*/
  6336		s->TotalNumberOfActiveWriteback = 0;
  6337		for (k = 0; k <= (dml_uint_t) mode_lib->ms.num_active_planes - 1; k++) {
  6338			if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
  6339				s->TotalNumberOfActiveWriteback = s->TotalNumberOfActiveWriteback + 1;
  6340			}
  6341	   }
  6342	
  6343		mode_lib->ms.support.EnoughWritebackUnits = 1;
  6344		if (s->TotalNumberOfActiveWriteback > (dml_uint_t) mode_lib->ms.ip.max_num_wb) {
  6345			mode_lib->ms.support.EnoughWritebackUnits = false;
  6346		}
  6347	
  6348		/*Writeback Scale Ratio and Taps Support Check*/
  6349		mode_lib->ms.support.WritebackScaleRatioAndTapsSupport = true;
  6350		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6351			if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
  6352				if (mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[k] > mode_lib->ms.ip.writeback_max_hscl_ratio
  6353					|| mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[k] > mode_lib->ms.ip.writeback_max_vscl_ratio
  6354					|| mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[k] < mode_lib->ms.ip.writeback_min_hscl_ratio
  6355					|| mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[k] < mode_lib->ms.ip.writeback_min_vscl_ratio
  6356					|| mode_lib->ms.cache_display_cfg.writeback.WritebackHTaps[k] > (dml_uint_t) mode_lib->ms.ip.writeback_max_hscl_taps
  6357					|| mode_lib->ms.cache_display_cfg.writeback.WritebackVTaps[k] > (dml_uint_t) mode_lib->ms.ip.writeback_max_vscl_taps
  6358					|| mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[k] > (dml_uint_t) mode_lib->ms.cache_display_cfg.writeback.WritebackHTaps[k]
  6359					|| mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[k] > (dml_uint_t) mode_lib->ms.cache_display_cfg.writeback.WritebackVTaps[k]
  6360					|| (mode_lib->ms.cache_display_cfg.writeback.WritebackHTaps[k] > 2.0 && ((mode_lib->ms.cache_display_cfg.writeback.WritebackHTaps[k] % 2) == 1))) {
  6361					mode_lib->ms.support.WritebackScaleRatioAndTapsSupport = false;
  6362				}
  6363				if (2.0 * mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[k] * (mode_lib->ms.cache_display_cfg.writeback.WritebackVTaps[k] - 1) * 57 > mode_lib->ms.ip.writeback_line_buffer_buffer_size) {
  6364					mode_lib->ms.support.WritebackScaleRatioAndTapsSupport = false;
  6365				}
  6366			}
  6367		}
  6368	
  6369		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6370			CalculateSinglePipeDPPCLKAndSCLThroughput(
  6371					mode_lib->ms.cache_display_cfg.plane.HRatio[k],
  6372					mode_lib->ms.cache_display_cfg.plane.HRatioChroma[k],
  6373					mode_lib->ms.cache_display_cfg.plane.VRatio[k],
  6374					mode_lib->ms.cache_display_cfg.plane.VRatioChroma[k],
  6375					mode_lib->ms.ip.max_dchub_pscl_bw_pix_per_clk,
  6376					mode_lib->ms.ip.max_pscl_lb_bw_pix_per_clk,
  6377					mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
  6378					mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k],
  6379					mode_lib->ms.cache_display_cfg.plane.HTaps[k],
  6380					mode_lib->ms.cache_display_cfg.plane.HTapsChroma[k],
  6381					mode_lib->ms.cache_display_cfg.plane.VTaps[k],
  6382					mode_lib->ms.cache_display_cfg.plane.VTapsChroma[k],
  6383					/* Output */
  6384					&mode_lib->ms.PSCL_FACTOR[k],
  6385					&mode_lib->ms.PSCL_FACTOR_CHROMA[k],
  6386					&mode_lib->ms.MinDPPCLKUsingSingleDPP[k]);
  6387		}
  6388	
  6389		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6390			if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear) {
  6391				s->MaximumSwathWidthSupportLuma = 8192;
  6392			} else if (!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k]) && mode_lib->ms.BytePerPixelC[k] > 0 && mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_rgbe_alpha) {
  6393				s->MaximumSwathWidthSupportLuma = 7680;
  6394			} else if (dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k]) && mode_lib->ms.BytePerPixelC[k] > 0 && mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_rgbe_alpha) {
  6395				s->MaximumSwathWidthSupportLuma = 4320;
  6396			} else if (mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_rgbe_alpha) {
  6397				s->MaximumSwathWidthSupportLuma = 3840;
  6398			} else if (dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k]) && mode_lib->ms.BytePerPixelY[k] == 8 && mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true) {
  6399				s->MaximumSwathWidthSupportLuma = 3072;
  6400			} else {
  6401				s->MaximumSwathWidthSupportLuma = 6144;
  6402			}
  6403	
  6404	       if (mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_420_8 || mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_420_10 || mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_420_12) {
  6405				s->MaximumSwathWidthSupportChroma = (dml_uint_t)(s->MaximumSwathWidthSupportLuma / 2.0);
  6406			} else {
  6407				s->MaximumSwathWidthSupportChroma = s->MaximumSwathWidthSupportLuma;
  6408	       }
  6409			mode_lib->ms.MaximumSwathWidthInLineBufferLuma = mode_lib->ms.ip.line_buffer_size_bits * dml_max(mode_lib->ms.cache_display_cfg.plane.HRatio[k], 1.0) / mode_lib->ms.cache_display_cfg.plane.LBBitPerPixel[k] /
  6410																(mode_lib->ms.cache_display_cfg.plane.VTaps[k] + dml_max(dml_ceil(mode_lib->ms.cache_display_cfg.plane.VRatio[k], 1.0) - 2, 0.0));
  6411			if (mode_lib->ms.BytePerPixelC[k] == 0.0) {
  6412				mode_lib->ms.MaximumSwathWidthInLineBufferChroma = 0;
  6413			} else {
  6414				mode_lib->ms.MaximumSwathWidthInLineBufferChroma =
  6415								mode_lib->ms.ip.line_buffer_size_bits
  6416										* dml_max(mode_lib->ms.cache_display_cfg.plane.HRatioChroma[k], 1.0)
  6417										/ mode_lib->ms.cache_display_cfg.plane.LBBitPerPixel[k]
  6418										/ (mode_lib->ms.cache_display_cfg.plane.VTapsChroma[k]
  6419										+ dml_max(dml_ceil(mode_lib->ms.cache_display_cfg.plane.VRatioChroma[k], 1.0) - 2, 0.0));
  6420			}
  6421			mode_lib->ms.MaximumSwathWidthLuma[k] = dml_min(s->MaximumSwathWidthSupportLuma, mode_lib->ms.MaximumSwathWidthInLineBufferLuma);
  6422			mode_lib->ms.MaximumSwathWidthChroma[k] = dml_min(s->MaximumSwathWidthSupportChroma, mode_lib->ms.MaximumSwathWidthInLineBufferChroma);
  6423		}
  6424	
  6425		/*Number Of DSC Slices*/
  6426		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6427			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
  6428				if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 4800) {
  6429					mode_lib->ms.support.NumberOfDSCSlices[k] = (dml_uint_t)(dml_ceil(mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] / 600, 4));
  6430				} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 2400) {
  6431					mode_lib->ms.support.NumberOfDSCSlices[k] = 8;
  6432				} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 1200) {
  6433					mode_lib->ms.support.NumberOfDSCSlices[k] = 4;
  6434				} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 340) {
  6435					mode_lib->ms.support.NumberOfDSCSlices[k] = 2;
  6436				} else {
  6437					mode_lib->ms.support.NumberOfDSCSlices[k] = 1;
  6438				}
  6439			} else {
  6440				mode_lib->ms.support.NumberOfDSCSlices[k] = 0;
  6441			}
  6442		}
  6443	
  6444		CalculateSwathAndDETConfiguration_params->DETSizeOverride = mode_lib->ms.cache_display_cfg.plane.DETSizeOverride;
  6445		CalculateSwathAndDETConfiguration_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
  6446		CalculateSwathAndDETConfiguration_params->ConfigReturnBufferSizeInKByte = mode_lib->ms.ip.config_return_buffer_size_in_kbytes;
  6447		CalculateSwathAndDETConfiguration_params->ROBBufferSizeInKByte = mode_lib->ms.ip.rob_buffer_size_kbytes;
  6448		CalculateSwathAndDETConfiguration_params->MaxTotalDETInKByte = mode_lib->ms.MaxTotalDETInKByte;
  6449		CalculateSwathAndDETConfiguration_params->MinCompressedBufferSizeInKByte = mode_lib->ms.MinCompressedBufferSizeInKByte;
  6450		CalculateSwathAndDETConfiguration_params->PixelChunkSizeInKByte = mode_lib->ms.ip.pixel_chunk_size_kbytes;
  6451		CalculateSwathAndDETConfiguration_params->ForceSingleDPP = 1;
  6452		CalculateSwathAndDETConfiguration_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
  6453		CalculateSwathAndDETConfiguration_params->nomDETInKByte = mode_lib->ms.NomDETInKByte;
  6454		CalculateSwathAndDETConfiguration_params->UseUnboundedRequestingFinal = mode_lib->ms.policy.UseUnboundedRequesting;
  6455		CalculateSwathAndDETConfiguration_params->ConfigReturnBufferSegmentSizeInkByte = mode_lib->ms.ip.config_return_buffer_segment_size_in_kbytes;
  6456		CalculateSwathAndDETConfiguration_params->CompressedBufferSegmentSizeInkByteFinal = mode_lib->ms.ip.compressed_buffer_segment_size_in_kbytes;
  6457		CalculateSwathAndDETConfiguration_params->Output = mode_lib->ms.cache_display_cfg.output.OutputEncoder;
  6458		CalculateSwathAndDETConfiguration_params->ReadBandwidthLuma = mode_lib->ms.ReadBandwidthLuma;
  6459		CalculateSwathAndDETConfiguration_params->ReadBandwidthChroma = mode_lib->ms.ReadBandwidthChroma;
  6460		CalculateSwathAndDETConfiguration_params->MaximumSwathWidthLuma = mode_lib->ms.MaximumSwathWidthLuma;
  6461		CalculateSwathAndDETConfiguration_params->MaximumSwathWidthChroma = mode_lib->ms.MaximumSwathWidthChroma;
  6462		CalculateSwathAndDETConfiguration_params->SourceScan = mode_lib->ms.cache_display_cfg.plane.SourceScan;
  6463		CalculateSwathAndDETConfiguration_params->ViewportStationary = mode_lib->ms.cache_display_cfg.plane.ViewportStationary;
  6464		CalculateSwathAndDETConfiguration_params->SourcePixelFormat = mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat;
  6465		CalculateSwathAndDETConfiguration_params->SurfaceTiling = mode_lib->ms.cache_display_cfg.surface.SurfaceTiling;
  6466		CalculateSwathAndDETConfiguration_params->ViewportWidth = mode_lib->ms.cache_display_cfg.plane.ViewportWidth;
  6467		CalculateSwathAndDETConfiguration_params->ViewportHeight = mode_lib->ms.cache_display_cfg.plane.ViewportHeight;
  6468		CalculateSwathAndDETConfiguration_params->ViewportXStart = mode_lib->ms.cache_display_cfg.plane.ViewportXStart;
  6469		CalculateSwathAndDETConfiguration_params->ViewportYStart = mode_lib->ms.cache_display_cfg.plane.ViewportYStart;
  6470		CalculateSwathAndDETConfiguration_params->ViewportXStartC = mode_lib->ms.cache_display_cfg.plane.ViewportXStartC;
  6471		CalculateSwathAndDETConfiguration_params->ViewportYStartC = mode_lib->ms.cache_display_cfg.plane.ViewportYStartC;
  6472		CalculateSwathAndDETConfiguration_params->SurfaceWidthY = mode_lib->ms.cache_display_cfg.surface.SurfaceWidthY;
  6473		CalculateSwathAndDETConfiguration_params->SurfaceWidthC = mode_lib->ms.cache_display_cfg.surface.SurfaceWidthC;
  6474		CalculateSwathAndDETConfiguration_params->SurfaceHeightY = mode_lib->ms.cache_display_cfg.surface.SurfaceHeightY;
  6475		CalculateSwathAndDETConfiguration_params->SurfaceHeightC = mode_lib->ms.cache_display_cfg.surface.SurfaceHeightC;
  6476		CalculateSwathAndDETConfiguration_params->Read256BytesBlockHeightY = mode_lib->ms.Read256BlockHeightY;
  6477		CalculateSwathAndDETConfiguration_params->Read256BytesBlockHeightC = mode_lib->ms.Read256BlockHeightC;
  6478		CalculateSwathAndDETConfiguration_params->Read256BytesBlockWidthY = mode_lib->ms.Read256BlockWidthY;
  6479		CalculateSwathAndDETConfiguration_params->Read256BytesBlockWidthC = mode_lib->ms.Read256BlockWidthC;
  6480		CalculateSwathAndDETConfiguration_params->ODMMode = s->dummy_odm_mode;
  6481		CalculateSwathAndDETConfiguration_params->BlendingAndTiming = mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming;
  6482		CalculateSwathAndDETConfiguration_params->BytePerPixY = mode_lib->ms.BytePerPixelY;
  6483		CalculateSwathAndDETConfiguration_params->BytePerPixC = mode_lib->ms.BytePerPixelC;
  6484		CalculateSwathAndDETConfiguration_params->BytePerPixDETY = mode_lib->ms.BytePerPixelInDETY;
  6485		CalculateSwathAndDETConfiguration_params->BytePerPixDETC = mode_lib->ms.BytePerPixelInDETC;
  6486		CalculateSwathAndDETConfiguration_params->HActive = mode_lib->ms.cache_display_cfg.timing.HActive;
  6487		CalculateSwathAndDETConfiguration_params->HRatio = mode_lib->ms.cache_display_cfg.plane.HRatio;
  6488		CalculateSwathAndDETConfiguration_params->HRatioChroma = mode_lib->ms.cache_display_cfg.plane.HRatioChroma;
  6489		CalculateSwathAndDETConfiguration_params->DPPPerSurface = s->dummy_integer_array[0];
  6490		CalculateSwathAndDETConfiguration_params->swath_width_luma_ub = s->dummy_integer_array[1];
  6491		CalculateSwathAndDETConfiguration_params->swath_width_chroma_ub = s->dummy_integer_array[2];
  6492		CalculateSwathAndDETConfiguration_params->SwathWidth = s->dummy_integer_array[3];
  6493		CalculateSwathAndDETConfiguration_params->SwathWidthChroma = s->dummy_integer_array[4];
  6494		CalculateSwathAndDETConfiguration_params->SwathHeightY = s->dummy_integer_array[5];
  6495		CalculateSwathAndDETConfiguration_params->SwathHeightC = s->dummy_integer_array[6];
  6496		CalculateSwathAndDETConfiguration_params->DETBufferSizeInKByte = s->dummy_integer_array[7];
  6497		CalculateSwathAndDETConfiguration_params->DETBufferSizeY = mode_lib->ms.DETBufferSizeY;
  6498		CalculateSwathAndDETConfiguration_params->DETBufferSizeC = mode_lib->ms.DETBufferSizeC;
  6499		CalculateSwathAndDETConfiguration_params->UnboundedRequestEnabled = &s->dummy_boolean[0];
  6500		CalculateSwathAndDETConfiguration_params->compbuf_reserved_space_64b = &s->dummy_integer[2];
  6501		CalculateSwathAndDETConfiguration_params->compbuf_reserved_space_zs = &s->dummy_integer[1];
  6502		CalculateSwathAndDETConfiguration_params->CompressedBufferSizeInkByte = &s->dummy_integer[0];
  6503		CalculateSwathAndDETConfiguration_params->ViewportSizeSupportPerSurface = mode_lib->ms.SingleDPPViewportSizeSupportPerSurface;
  6504		CalculateSwathAndDETConfiguration_params->ViewportSizeSupport = &s->dummy_boolean[1];
  6505	
  6506		CalculateSwathAndDETConfiguration(&mode_lib->scratch,
  6507		CalculateSwathAndDETConfiguration_params); /* dml_bool_t *ViewportSizeSupport */
  6508	
  6509		s->MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
  6510		s->MPCCombineMethodAsPossible = false;
  6511		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6512			if (mode_lib->ms.policy.MPCCombineUse[k] == dml_mpc_as_needed_for_pstate_and_voltage)
  6513				s->MPCCombineMethodAsNeededForPStateChangeAndVoltage = true;
  6514			if (mode_lib->ms.policy.MPCCombineUse[k] == dml_mpc_as_possible)
  6515				s->MPCCombineMethodAsPossible = true;
  6516		}
  6517		mode_lib->ms.support.MPCCombineMethodIncompatible = s->MPCCombineMethodAsNeededForPStateChangeAndVoltage && s->MPCCombineMethodAsPossible;
  6518	
  6519		for (j = 0; j < 2; j++) {
  6520			mode_lib->ms.TotalNumberOfActiveDPP[j] = 0;
  6521			mode_lib->ms.support.TotalAvailablePipesSupport[j] = true;
  6522	
  6523			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6524				CalculateODMMode(
  6525						mode_lib->ms.ip.maximum_pixels_per_line_per_dsc_unit,
  6526						mode_lib->ms.cache_display_cfg.timing.HActive[k],
  6527						mode_lib->ms.cache_display_cfg.output.OutputEncoder[k],
  6528						mode_lib->ms.cache_display_cfg.output.OutputFormat[k],
  6529						mode_lib->ms.policy.ODMUse[k],
  6530						mode_lib->ms.state.dispclk_mhz,
  6531						mode_lib->ms.max_state.dispclk_mhz,
  6532						false, // DSCEnable
  6533						mode_lib->ms.TotalNumberOfActiveDPP[j],
  6534						mode_lib->ms.ip.max_num_dpp,
  6535						mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
  6536						mode_lib->ms.soc.dcn_downspread_percent,
  6537						mode_lib->ms.ip.dispclk_ramp_margin_percent,
  6538						mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz,
  6539	
  6540						/* Output */
  6541						&s->TotalAvailablePipesSupportNoDSC,
  6542						&s->NumberOfDPPNoDSC,
  6543						&s->ODMModeNoDSC,
  6544						&s->RequiredDISPCLKPerSurfaceNoDSC);
  6545	
  6546				CalculateODMMode(
  6547						mode_lib->ms.ip.maximum_pixels_per_line_per_dsc_unit,
  6548						mode_lib->ms.cache_display_cfg.timing.HActive[k],
  6549						mode_lib->ms.cache_display_cfg.output.OutputEncoder[k],
  6550						mode_lib->ms.cache_display_cfg.output.OutputFormat[k],
  6551						mode_lib->ms.policy.ODMUse[k],
  6552						mode_lib->ms.state.dispclk_mhz,
  6553						mode_lib->ms.max_state.dispclk_mhz,
  6554						true, // DSCEnable
  6555						mode_lib->ms.TotalNumberOfActiveDPP[j],
  6556						mode_lib->ms.ip.max_num_dpp,
  6557						mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
  6558						mode_lib->ms.soc.dcn_downspread_percent,
  6559						mode_lib->ms.ip.dispclk_ramp_margin_percent,
  6560						mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz,
  6561	
  6562						/* Output */
  6563						&s->TotalAvailablePipesSupportDSC,
  6564						&s->NumberOfDPPDSC,
  6565						&s->ODMModeDSC,
  6566						&s->RequiredDISPCLKPerSurfaceDSC);
  6567	
  6568				CalculateOutputLink(
  6569						mode_lib->ms.state.phyclk_mhz,
  6570						mode_lib->ms.state.phyclk_d18_mhz,
  6571						mode_lib->ms.state.phyclk_d32_mhz,
  6572						mode_lib->ms.soc.phy_downspread_percent,
  6573						(mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k),
  6574						mode_lib->ms.cache_display_cfg.output.OutputEncoder[k],
  6575						mode_lib->ms.cache_display_cfg.output.OutputFormat[k],
  6576						mode_lib->ms.cache_display_cfg.timing.HTotal[k],
  6577						mode_lib->ms.cache_display_cfg.timing.HActive[k],
  6578						mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k],
  6579						mode_lib->ms.cache_display_cfg.output.ForcedOutputLinkBPP[k],
  6580						mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k],
  6581						mode_lib->ms.support.NumberOfDSCSlices[k],
  6582						mode_lib->ms.cache_display_cfg.output.AudioSampleRate[k],
  6583						mode_lib->ms.cache_display_cfg.output.AudioSampleLayout[k],
  6584						s->ODMModeNoDSC,
  6585						s->ODMModeDSC,
  6586						mode_lib->ms.cache_display_cfg.output.DSCEnable[k],
  6587						mode_lib->ms.cache_display_cfg.output.OutputLinkDPLanes[k],
  6588						mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k],
  6589	
  6590						/* Output */
  6591						&mode_lib->ms.RequiresDSC[k],
  6592						&mode_lib->ms.RequiresFEC[k],
  6593						&mode_lib->ms.OutputBppPerState[k],
  6594						&mode_lib->ms.OutputTypePerState[k], // VBA_DELTA, VBA uses a string to represent type and rate, but DML uses enum, don't want to rely on strng
  6595						&mode_lib->ms.OutputRatePerState[k],
  6596						&mode_lib->ms.RequiredSlots[k]);
  6597	
  6598				if (mode_lib->ms.RequiresDSC[k] == false) {
  6599					mode_lib->ms.ODMModePerState[k] = s->ODMModeNoDSC;
  6600					mode_lib->ms.RequiredDISPCLKPerSurface[j][k] = s->RequiredDISPCLKPerSurfaceNoDSC;
  6601					if (!s->TotalAvailablePipesSupportNoDSC)
  6602						mode_lib->ms.support.TotalAvailablePipesSupport[j] = false;
  6603					mode_lib->ms.TotalNumberOfActiveDPP[j] = mode_lib->ms.TotalNumberOfActiveDPP[j] + s->NumberOfDPPNoDSC;
  6604				} else {
  6605					mode_lib->ms.ODMModePerState[k] = s->ODMModeDSC;
  6606					mode_lib->ms.RequiredDISPCLKPerSurface[j][k] = s->RequiredDISPCLKPerSurfaceDSC;
  6607					if (!s->TotalAvailablePipesSupportDSC)
  6608						mode_lib->ms.support.TotalAvailablePipesSupport[j] = false;
  6609					mode_lib->ms.TotalNumberOfActiveDPP[j] = mode_lib->ms.TotalNumberOfActiveDPP[j] + s->NumberOfDPPDSC;
  6610				}
  6611			}
  6612	
  6613			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6614				if (mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_4to1) {
  6615					mode_lib->ms.MPCCombine[j][k] = false;
  6616					mode_lib->ms.NoOfDPP[j][k] = 4;
  6617				} else if (mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_2to1) {
  6618					mode_lib->ms.MPCCombine[j][k] = false;
  6619					mode_lib->ms.NoOfDPP[j][k] = 2;
  6620				} else if (mode_lib->ms.policy.MPCCombineUse[k] == dml_mpc_disabled) {
  6621					mode_lib->ms.MPCCombine[j][k] = false;
  6622					mode_lib->ms.NoOfDPP[j][k] = 1;
  6623				} else if (RoundToDFSGranularity(mode_lib->ms.MinDPPCLKUsingSingleDPP[k] * (1 + mode_lib->ms.soc.dcn_downspread_percent / 100),
  6624												1, mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz) <= mode_lib->ms.state.dppclk_mhz &&
  6625												mode_lib->ms.SingleDPPViewportSizeSupportPerSurface[k] == true) {
  6626					mode_lib->ms.MPCCombine[j][k] = false;
  6627					mode_lib->ms.NoOfDPP[j][k] = 1;
  6628				} else if (mode_lib->ms.TotalNumberOfActiveDPP[j] < (dml_uint_t) mode_lib->ms.ip.max_num_dpp) {
  6629					mode_lib->ms.MPCCombine[j][k] = true;
  6630					mode_lib->ms.NoOfDPP[j][k] = 2;
  6631					mode_lib->ms.TotalNumberOfActiveDPP[j] = (dml_uint_t) mode_lib->ms.TotalNumberOfActiveDPP[j] + 1;
  6632				} else {
  6633					mode_lib->ms.MPCCombine[j][k] = false;
  6634					mode_lib->ms.NoOfDPP[j][k] = 1;
  6635					mode_lib->ms.support.TotalAvailablePipesSupport[j] = false;
  6636				}
  6637			}
  6638	
  6639			mode_lib->ms.TotalNumberOfSingleDPPSurfaces[j] = 0;
  6640			s->NoChromaOrLinear = true;
  6641			for (k = 0; k < (dml_uint_t) mode_lib->ms.num_active_planes; ++k) {
  6642				if (mode_lib->ms.NoOfDPP[j][k] == 1)
  6643					mode_lib->ms.TotalNumberOfSingleDPPSurfaces[j] = mode_lib->ms.TotalNumberOfSingleDPPSurfaces[j] + 1;
  6644				if (mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_420_8
  6645						|| mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_420_10
  6646						|| mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_420_12
  6647						|| mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] == dml_rgbe_alpha
  6648						|| mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear) {
  6649					s->NoChromaOrLinear = false;
  6650				}
  6651			}
  6652	
  6653			if (j == 1 && !UnboundedRequest(mode_lib->ms.policy.UseUnboundedRequesting,
  6654					mode_lib->ms.TotalNumberOfActiveDPP[j], s->NoChromaOrLinear,
  6655					mode_lib->ms.cache_display_cfg.output.OutputEncoder[0])) {
  6656				while (!(mode_lib->ms.TotalNumberOfActiveDPP[j] >= (dml_uint_t) mode_lib->ms.ip.max_num_dpp || mode_lib->ms.TotalNumberOfSingleDPPSurfaces[j] == 0)) {
  6657					s->BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
  6658					s->NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
  6659					for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6660						if (mode_lib->ms.policy.MPCCombineUse[k] != dml_mpc_disabled && mode_lib->ms.policy.MPCCombineUse[k] != dml_mpc_as_needed_for_voltage &&
  6661							mode_lib->ms.ReadBandwidthLuma[k] + mode_lib->ms.ReadBandwidthChroma[k] > s->BWOfNonCombinedSurfaceOfMaximumBandwidth &&
  6662							(mode_lib->ms.ODMModePerState[k] != dml_odm_mode_combine_2to1 && mode_lib->ms.ODMModePerState[k] != dml_odm_mode_combine_4to1) &&
  6663							mode_lib->ms.MPCCombine[j][k] == false) {
  6664							s->BWOfNonCombinedSurfaceOfMaximumBandwidth = mode_lib->ms.ReadBandwidthLuma[k] + mode_lib->ms.ReadBandwidthChroma[k];
  6665							s->NumberOfNonCombinedSurfaceOfMaximumBandwidth = k;
  6666						}
  6667					}
  6668					mode_lib->ms.MPCCombine[j][s->NumberOfNonCombinedSurfaceOfMaximumBandwidth] = true;
  6669					mode_lib->ms.NoOfDPP[j][s->NumberOfNonCombinedSurfaceOfMaximumBandwidth] = 2;
  6670					mode_lib->ms.TotalNumberOfActiveDPP[j] = mode_lib->ms.TotalNumberOfActiveDPP[j] + 1;
  6671					mode_lib->ms.TotalNumberOfSingleDPPSurfaces[j] = mode_lib->ms.TotalNumberOfSingleDPPSurfaces[j] - 1;
  6672				}
  6673			}
  6674	
  6675			//DISPCLK/DPPCLK
  6676			mode_lib->ms.WritebackRequiredDISPCLK = 0;
  6677			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6678				if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k]) {
  6679					mode_lib->ms.WritebackRequiredDISPCLK = dml_max(mode_lib->ms.WritebackRequiredDISPCLK,
  6680																		CalculateWriteBackDISPCLK(mode_lib->ms.cache_display_cfg.writeback.WritebackPixelFormat[k],
  6681																								mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
  6682																								mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[k],
  6683																								mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[k],
  6684																								mode_lib->ms.cache_display_cfg.writeback.WritebackHTaps[k],
  6685																								mode_lib->ms.cache_display_cfg.writeback.WritebackVTaps[k],
  6686																								mode_lib->ms.cache_display_cfg.writeback.WritebackSourceWidth[k],
  6687																								mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[k],
  6688																								mode_lib->ms.cache_display_cfg.timing.HTotal[k],
  6689																								mode_lib->ms.ip.writeback_line_buffer_buffer_size,
  6690																								mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz));
  6691				}
  6692			}
  6693	
  6694			 mode_lib->ms.RequiredDISPCLK[j] = mode_lib->ms.WritebackRequiredDISPCLK;
  6695			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6696				mode_lib->ms.RequiredDISPCLK[j] = dml_max(mode_lib->ms.RequiredDISPCLK[j], mode_lib->ms.RequiredDISPCLKPerSurface[j][k]);
  6697			}
  6698	
  6699			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6700				mode_lib->ms.NoOfDPPThisState[k] = mode_lib->ms.NoOfDPP[j][k];
  6701			}
  6702	
  6703			CalculateDPPCLK(mode_lib->ms.num_active_planes,
  6704						mode_lib->ms.soc.dcn_downspread_percent,
  6705						mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz,
  6706						mode_lib->ms.MinDPPCLKUsingSingleDPP,
  6707						mode_lib->ms.NoOfDPPThisState,
  6708						/* Output */
  6709						&mode_lib->ms.GlobalDPPCLK,
  6710						mode_lib->ms.RequiredDPPCLKThisState);
  6711	
  6712			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6713				mode_lib->ms.RequiredDPPCLKPerSurface[j][k] = mode_lib->ms.RequiredDPPCLKThisState[k];
  6714			}
  6715	
  6716			mode_lib->ms.support.DISPCLK_DPPCLK_Support[j] = !((mode_lib->ms.RequiredDISPCLK[j] > mode_lib->ms.state.dispclk_mhz) || (mode_lib->ms.GlobalDPPCLK > mode_lib->ms.state.dppclk_mhz));
  6717	
  6718			if (mode_lib->ms.TotalNumberOfActiveDPP[j] > (dml_uint_t) mode_lib->ms.ip.max_num_dpp) {
  6719				mode_lib->ms.support.TotalAvailablePipesSupport[j] = false;
  6720			}
  6721		} // j
  6722	
  6723		/* Total Available OTG, HDMIFRL, DP Support Check */
  6724		s->TotalNumberOfActiveOTG = 0;
  6725		s->TotalNumberOfActiveHDMIFRL = 0;
  6726		s->TotalNumberOfActiveDP2p0 = 0;
  6727		s->TotalNumberOfActiveDP2p0Outputs = 0;
  6728	
  6729		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6730			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
  6731				s->TotalNumberOfActiveOTG = s->TotalNumberOfActiveOTG + 1;
  6732				if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl)
  6733					s->TotalNumberOfActiveHDMIFRL = s->TotalNumberOfActiveHDMIFRL + 1;
  6734				if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp2p0) {
  6735					s->TotalNumberOfActiveDP2p0 = s->TotalNumberOfActiveDP2p0 + 1;
  6736					if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == k || mode_lib->ms.cache_display_cfg.output.OutputMultistreamEn[k] == false) {
  6737						s->TotalNumberOfActiveDP2p0Outputs = s->TotalNumberOfActiveDP2p0Outputs + 1;
  6738					}
  6739				}
  6740			}
  6741		}
  6742	
  6743		mode_lib->ms.support.NumberOfOTGSupport      = (s->TotalNumberOfActiveOTG <= (dml_uint_t) mode_lib->ms.ip.max_num_otg);
  6744		mode_lib->ms.support.NumberOfHDMIFRLSupport  = (s->TotalNumberOfActiveHDMIFRL <= (dml_uint_t) mode_lib->ms.ip.max_num_hdmi_frl_outputs);
  6745		mode_lib->ms.support.NumberOfDP2p0Support    = (s->TotalNumberOfActiveDP2p0 <= (dml_uint_t) mode_lib->ms.ip.max_num_dp2p0_streams && s->TotalNumberOfActiveDP2p0Outputs <= (dml_uint_t) mode_lib->ms.ip.max_num_dp2p0_outputs);
  6746	
  6747		/* Display IO and DSC Support Check */
  6748		mode_lib->ms.support.NonsupportedDSCInputBPC = false;
  6749		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6750			if (mode_lib->ms.cache_display_cfg.output.OutputDisabled[k] == false &&
  6751				!(mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k] == 12.0
  6752					|| mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k] == 10.0
  6753					|| mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k] == 8.0
  6754					|| mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k] > (dml_uint_t) mode_lib->ms.ip.maximum_dsc_bits_per_component
  6755					)) {
  6756				mode_lib->ms.support.NonsupportedDSCInputBPC = true;
  6757			}
  6758		}
  6759	
  6760		mode_lib->ms.support.ExceededMultistreamSlots = false;
  6761		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6762			if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == k) {
  6763				s->TotalSlots = mode_lib->ms.RequiredSlots[k];
  6764				for (j = 0; j < mode_lib->ms.num_active_planes; ++j) {
  6765					if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[j] == k)
  6766						s->TotalSlots = s->TotalSlots + mode_lib->ms.RequiredSlots[j];
  6767				}
  6768				if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp && s->TotalSlots > 63)
  6769					mode_lib->ms.support.ExceededMultistreamSlots = true;
  6770				if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp2p0 && s->TotalSlots > 64)
  6771					mode_lib->ms.support.ExceededMultistreamSlots = true;
  6772			}
  6773		}
  6774		mode_lib->ms.support.LinkCapacitySupport = true;
  6775		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6776			if (mode_lib->ms.cache_display_cfg.output.OutputDisabled[k] == false &&
  6777				mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k && (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp2p0 || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_edp ||
  6778				mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmi || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl) && mode_lib->ms.OutputBppPerState[k] == 0) {
  6779				mode_lib->ms.support.LinkCapacitySupport = false;
  6780			}
  6781		}
  6782	
  6783		mode_lib->ms.support.P2IWith420 = false;
  6784		mode_lib->ms.support.DSCOnlyIfNecessaryWithBPP = false;
  6785		mode_lib->ms.support.DSC422NativeNotSupported = false;
  6786		mode_lib->ms.support.LinkRateDoesNotMatchDPVersion = false;
  6787		mode_lib->ms.support.LinkRateForMultistreamNotIndicated = false;
  6788		mode_lib->ms.support.BPPForMultistreamNotIndicated = false;
  6789		mode_lib->ms.support.MultistreamWithHDMIOreDP = false;
  6790		mode_lib->ms.support.MSOOrODMSplitWithNonDPLink = false;
  6791		mode_lib->ms.support.NotEnoughLanesForMSO = false;
  6792	
  6793		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6794			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k && (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp2p0 || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_edp ||
  6795															mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmi || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl)) {
  6796				if (mode_lib->ms.cache_display_cfg.output.OutputFormat[k] == dml_420 && mode_lib->ms.cache_display_cfg.timing.Interlace[k] == 1 && mode_lib->ms.ip.ptoi_supported == true)
  6797					mode_lib->ms.support.P2IWith420 = true;
  6798	
  6799				if (mode_lib->ms.cache_display_cfg.output.DSCEnable[k] == dml_dsc_enable_if_necessary && mode_lib->ms.cache_display_cfg.output.ForcedOutputLinkBPP[k] != 0)
  6800					mode_lib->ms.support.DSCOnlyIfNecessaryWithBPP = true;
  6801				if ((mode_lib->ms.cache_display_cfg.output.DSCEnable[k] == dml_dsc_enable || mode_lib->ms.cache_display_cfg.output.DSCEnable[k] == dml_dsc_enable_if_necessary) && mode_lib->ms.cache_display_cfg.output.OutputFormat[k] == dml_n422 && !mode_lib->ms.ip.dsc422_native_support)
  6802					mode_lib->ms.support.DSC422NativeNotSupported = true;
  6803	
  6804				if (((mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_hbr || mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_hbr2 || mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_hbr3) &&
  6805						mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] != dml_dp && mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] != dml_edp) ||
  6806						((mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_uhbr10 || mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_uhbr13p5 || mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_uhbr20) &&
  6807						mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] != dml_dp2p0))
  6808					mode_lib->ms.support.LinkRateDoesNotMatchDPVersion = true;
  6809	
  6810				if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamEn[k] == 1) {
  6811					if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == k && mode_lib->ms.cache_display_cfg.output.OutputLinkDPRate[k] == dml_dp_rate_na)
  6812						mode_lib->ms.support.LinkRateForMultistreamNotIndicated = true;
  6813					if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == k && mode_lib->ms.cache_display_cfg.output.ForcedOutputLinkBPP[k] == 0)
  6814						mode_lib->ms.support.BPPForMultistreamNotIndicated = true;
  6815					for (j = 0; j < mode_lib->ms.num_active_planes; ++j) {
  6816						if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == j && mode_lib->ms.cache_display_cfg.output.ForcedOutputLinkBPP[k] == 0)
  6817							mode_lib->ms.support.BPPForMultistreamNotIndicated = true;
  6818					}
  6819				}
  6820	
  6821				if ((mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_edp || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmi || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl)) {
  6822					if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamEn[k] == 1 && mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == k)
  6823						mode_lib->ms.support.MultistreamWithHDMIOreDP = true;
  6824					for (j = 0; j < mode_lib->ms.num_active_planes; ++j) {
  6825						if (mode_lib->ms.cache_display_cfg.output.OutputMultistreamEn[k] == 1 && mode_lib->ms.cache_display_cfg.output.OutputMultistreamId[k] == j)
  6826							mode_lib->ms.support.MultistreamWithHDMIOreDP = true;
  6827					}
  6828				}
  6829				if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] != dml_dp && (mode_lib->ms.policy.ODMUse[k] == dml_odm_use_policy_split_1to2 ||
  6830					mode_lib->ms.policy.ODMUse[k] == dml_odm_use_policy_mso_1to2 || mode_lib->ms.policy.ODMUse[k] == dml_odm_use_policy_mso_1to4))
  6831					mode_lib->ms.support.MSOOrODMSplitWithNonDPLink = true;
  6832	
  6833				if ((mode_lib->ms.policy.ODMUse[k] == dml_odm_use_policy_mso_1to2 && mode_lib->ms.cache_display_cfg.output.OutputLinkDPLanes[k] < 2) ||
  6834					(mode_lib->ms.policy.ODMUse[k] == dml_odm_use_policy_mso_1to4 && mode_lib->ms.cache_display_cfg.output.OutputLinkDPLanes[k] < 4))
  6835					mode_lib->ms.support.NotEnoughLanesForMSO = true;
  6836			}
  6837		}
  6838	
  6839		mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = false;
  6840		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6841			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k &&
  6842					mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl &&
  6843					RequiredDTBCLK(
  6844								mode_lib->ms.RequiresDSC[k],
  6845								mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k],
  6846								mode_lib->ms.cache_display_cfg.output.OutputFormat[k],
  6847								mode_lib->ms.OutputBppPerState[k],
  6848								mode_lib->ms.support.NumberOfDSCSlices[k],
  6849								mode_lib->ms.cache_display_cfg.timing.HTotal[k],
  6850								mode_lib->ms.cache_display_cfg.timing.HActive[k],
  6851								mode_lib->ms.cache_display_cfg.output.AudioSampleRate[k],
  6852								mode_lib->ms.cache_display_cfg.output.AudioSampleLayout[k]) > mode_lib->ms.state.dtbclk_mhz) {
  6853									mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = true;
  6854								}
  6855		}
  6856	
  6857		mode_lib->ms.support.ODMCombineTwoToOneSupportCheckOK = true;
  6858		mode_lib->ms.support.ODMCombineFourToOneSupportCheckOK = true;
  6859		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6860			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k && mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_2to1 && mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmi) {
  6861				mode_lib->ms.support.ODMCombineTwoToOneSupportCheckOK = false;
  6862			}
  6863			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k && mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_4to1 && (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp ||
  6864				mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_edp || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmi)) {
  6865				mode_lib->ms.support.ODMCombineFourToOneSupportCheckOK = false;
  6866			}
  6867		}
  6868	
  6869		mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = false;
  6870		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6871			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
  6872				if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp ||
  6873					mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp2p0 ||
  6874					mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_edp ||
  6875					mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl) {
  6876					if (mode_lib->ms.cache_display_cfg.output.OutputFormat[k] == dml_420) {
  6877						s->DSCFormatFactor = 2;
  6878					} else if (mode_lib->ms.cache_display_cfg.output.OutputFormat[k] == dml_444) {
  6879						s->DSCFormatFactor = 1;
  6880					} else if (mode_lib->ms.cache_display_cfg.output.OutputFormat[k] == dml_n422 || mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_hdmifrl) {
  6881						s->DSCFormatFactor = 2;
  6882					} else {
  6883						s->DSCFormatFactor = 1;
  6884					}
  6885	#ifdef __DML_VBA_DEBUG__
  6886					dml_print("DML::%s: k=%u, RequiresDSC = %u\n",  __func__, k, mode_lib->ms.RequiresDSC[k]);
  6887	#endif
  6888					if (mode_lib->ms.RequiresDSC[k] == true) {
  6889						if (mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_4to1) {
  6890							if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] / 12.0 / (dml_float_t)s->DSCFormatFactor > (1.0 - mode_lib->ms.soc.dcn_downspread_percent / 100.0) * mode_lib->ms.state.dscclk_mhz) {
  6891	#ifdef __DML_VBA_DEBUG__
  6892								dml_print("DML::%s: k=%u, PixelClockBackEnd     = %f\n",  __func__, k, mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k]);
  6893								dml_print("DML::%s: k=%u, DSCCLKPerState        = %f\n",  __func__, k, mode_lib->ms.state.dscclk_mhz);
  6894								dml_print("DML::%s: k=%u, DSCFormatFactor       = %u\n",  __func__, k, s->DSCFormatFactor);
  6895	#endif
  6896								mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = true;
  6897							}
  6898						} else if (mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_2to1) {
  6899							if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] / 6.0 / (dml_float_t)s->DSCFormatFactor > (1.0 - mode_lib->ms.soc.dcn_downspread_percent / 100.0) * mode_lib->ms.state.dscclk_mhz) {
  6900								mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = true;
  6901							}
  6902						} else {
  6903							if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] / 3.0 / (dml_float_t)s->DSCFormatFactor > (1.0 - mode_lib->ms.soc.dcn_downspread_percent / 100.0) * mode_lib->ms.state.dscclk_mhz) {
  6904								mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = true;
  6905							}
  6906						}
  6907					}
  6908				}
  6909			}
  6910		}
  6911	#ifdef __DML_VBA_DEBUG__
  6912		dml_print("DML::%s: DSCCLKRequiredMoreThanSupported = %u\n",  __func__, mode_lib->ms.support.DSCCLKRequiredMoreThanSupported);
  6913	#endif
  6914	
  6915		/* Check DSC Unit and Slices Support */
  6916		mode_lib->ms.support.NotEnoughDSCUnits = false;
  6917		mode_lib->ms.support.NotEnoughDSCSlices = false;
  6918		s->TotalDSCUnitsRequired = 0;
  6919		mode_lib->ms.support.PixelsPerLinePerDSCUnitSupport = true;
  6920		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6921			if (mode_lib->ms.RequiresDSC[k] == true) {
  6922				if (mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_4to1) {
  6923					if (mode_lib->ms.cache_display_cfg.timing.HActive[k] > 4 * (dml_uint_t) mode_lib->ms.ip.maximum_pixels_per_line_per_dsc_unit)
  6924						mode_lib->ms.support.PixelsPerLinePerDSCUnitSupport = false;
  6925					s->TotalDSCUnitsRequired = s->TotalDSCUnitsRequired + 4;
  6926					if (mode_lib->ms.support.NumberOfDSCSlices[k] > 16)
  6927						mode_lib->ms.support.NotEnoughDSCSlices = true;
  6928				} else if (mode_lib->ms.ODMModePerState[k] == dml_odm_mode_combine_2to1) {
  6929					if (mode_lib->ms.cache_display_cfg.timing.HActive[k] > 2 * (dml_uint_t) mode_lib->ms.ip.maximum_pixels_per_line_per_dsc_unit)
  6930						mode_lib->ms.support.PixelsPerLinePerDSCUnitSupport = false;
  6931					s->TotalDSCUnitsRequired = s->TotalDSCUnitsRequired + 2;
  6932					if (mode_lib->ms.support.NumberOfDSCSlices[k] > 8)
  6933						mode_lib->ms.support.NotEnoughDSCSlices = true;
  6934				} else {
  6935					if (mode_lib->ms.cache_display_cfg.timing.HActive[k] > (dml_uint_t) mode_lib->ms.ip.maximum_pixels_per_line_per_dsc_unit)
  6936						mode_lib->ms.support.PixelsPerLinePerDSCUnitSupport = false;
  6937					s->TotalDSCUnitsRequired = s->TotalDSCUnitsRequired + 1;
  6938					if (mode_lib->ms.support.NumberOfDSCSlices[k] > 4)
  6939						mode_lib->ms.support.NotEnoughDSCSlices = true;
  6940				}
  6941			}
  6942		}
  6943	   if (s->TotalDSCUnitsRequired > (dml_uint_t) mode_lib->ms.ip.num_dsc) {
  6944			mode_lib->ms.support.NotEnoughDSCUnits = true;
  6945		}
  6946	
  6947		/*DSC Delay per state*/
  6948		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6949			mode_lib->ms.DSCDelayPerState[k] = DSCDelayRequirement(mode_lib->ms.RequiresDSC[k],
  6950														mode_lib->ms.ODMModePerState[k],
  6951														mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k],
  6952														mode_lib->ms.OutputBppPerState[k],
  6953														mode_lib->ms.cache_display_cfg.timing.HActive[k],
  6954														mode_lib->ms.cache_display_cfg.timing.HTotal[k],
  6955														mode_lib->ms.support.NumberOfDSCSlices[k],
  6956														mode_lib->ms.cache_display_cfg.output.OutputFormat[k],
  6957														mode_lib->ms.cache_display_cfg.output.OutputEncoder[k],
  6958														mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
  6959														mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k]);
  6960		}
  6961	
  6962		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6963			for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
  6964				for (j = 0; j <= mode_lib->ms.num_active_planes - 1; j++) {
  6965					if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == m && mode_lib->ms.RequiresDSC[m] == true) {
  6966						mode_lib->ms.DSCDelayPerState[k] = mode_lib->ms.DSCDelayPerState[m];
  6967					}
  6968				}
  6969			}
  6970		}
  6971	
  6972		//Calculate Swath, DET Configuration, DCFCLKDeepSleep
  6973		//
  6974		for (j = 0; j < 2; ++j) {
  6975			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6976				mode_lib->ms.RequiredDPPCLKThisState[k] = mode_lib->ms.RequiredDPPCLKPerSurface[j][k];
  6977				mode_lib->ms.NoOfDPPThisState[k] = mode_lib->ms.NoOfDPP[j][k];
  6978				mode_lib->ms.ODMModeThisState[k] = mode_lib->ms.ODMModePerState[k];
  6979			}
  6980	
  6981			CalculateSwathAndDETConfiguration_params->DETSizeOverride = mode_lib->ms.cache_display_cfg.plane.DETSizeOverride;
  6982			CalculateSwathAndDETConfiguration_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
  6983			CalculateSwathAndDETConfiguration_params->ConfigReturnBufferSizeInKByte = mode_lib->ms.ip.config_return_buffer_size_in_kbytes;
  6984			CalculateSwathAndDETConfiguration_params->ROBBufferSizeInKByte = mode_lib->ms.ip.rob_buffer_size_kbytes;
  6985			CalculateSwathAndDETConfiguration_params->MaxTotalDETInKByte = mode_lib->ms.MaxTotalDETInKByte;
  6986			CalculateSwathAndDETConfiguration_params->MinCompressedBufferSizeInKByte = mode_lib->ms.MinCompressedBufferSizeInKByte;
  6987			CalculateSwathAndDETConfiguration_params->PixelChunkSizeInKByte = mode_lib->ms.ip.pixel_chunk_size_kbytes;
  6988			CalculateSwathAndDETConfiguration_params->ForceSingleDPP = false;
  6989			CalculateSwathAndDETConfiguration_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
  6990			CalculateSwathAndDETConfiguration_params->nomDETInKByte = mode_lib->ms.NomDETInKByte;
  6991			CalculateSwathAndDETConfiguration_params->UseUnboundedRequestingFinal = mode_lib->ms.policy.UseUnboundedRequesting;
  6992			CalculateSwathAndDETConfiguration_params->ConfigReturnBufferSegmentSizeInkByte = mode_lib->ms.ip.config_return_buffer_segment_size_in_kbytes;
  6993			CalculateSwathAndDETConfiguration_params->CompressedBufferSegmentSizeInkByteFinal = mode_lib->ms.ip.compressed_buffer_segment_size_in_kbytes;
  6994			CalculateSwathAndDETConfiguration_params->Output = mode_lib->ms.cache_display_cfg.output.OutputEncoder;
  6995			CalculateSwathAndDETConfiguration_params->ReadBandwidthLuma = mode_lib->ms.ReadBandwidthLuma;
  6996			CalculateSwathAndDETConfiguration_params->ReadBandwidthChroma = mode_lib->ms.ReadBandwidthChroma;
  6997			CalculateSwathAndDETConfiguration_params->MaximumSwathWidthLuma = mode_lib->ms.MaximumSwathWidthLuma;
  6998			CalculateSwathAndDETConfiguration_params->MaximumSwathWidthChroma = mode_lib->ms.MaximumSwathWidthChroma;
  6999			CalculateSwathAndDETConfiguration_params->SourceScan = mode_lib->ms.cache_display_cfg.plane.SourceScan;
  7000			CalculateSwathAndDETConfiguration_params->ViewportStationary = mode_lib->ms.cache_display_cfg.plane.ViewportStationary;
  7001			CalculateSwathAndDETConfiguration_params->SourcePixelFormat = mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat;
  7002			CalculateSwathAndDETConfiguration_params->SurfaceTiling = mode_lib->ms.cache_display_cfg.surface.SurfaceTiling;
  7003			CalculateSwathAndDETConfiguration_params->ViewportWidth = mode_lib->ms.cache_display_cfg.plane.ViewportWidth;
  7004			CalculateSwathAndDETConfiguration_params->ViewportHeight = mode_lib->ms.cache_display_cfg.plane.ViewportHeight;
  7005			CalculateSwathAndDETConfiguration_params->ViewportXStart = mode_lib->ms.cache_display_cfg.plane.ViewportXStart;
  7006			CalculateSwathAndDETConfiguration_params->ViewportYStart = mode_lib->ms.cache_display_cfg.plane.ViewportYStart;
  7007			CalculateSwathAndDETConfiguration_params->ViewportXStartC = mode_lib->ms.cache_display_cfg.plane.ViewportXStartC;
  7008			CalculateSwathAndDETConfiguration_params->ViewportYStartC = mode_lib->ms.cache_display_cfg.plane.ViewportYStartC;
  7009			CalculateSwathAndDETConfiguration_params->SurfaceWidthY = mode_lib->ms.cache_display_cfg.surface.SurfaceWidthY;
  7010			CalculateSwathAndDETConfiguration_params->SurfaceWidthC = mode_lib->ms.cache_display_cfg.surface.SurfaceWidthC;
  7011			CalculateSwathAndDETConfiguration_params->SurfaceHeightY = mode_lib->ms.cache_display_cfg.surface.SurfaceHeightY;
  7012			CalculateSwathAndDETConfiguration_params->SurfaceHeightC = mode_lib->ms.cache_display_cfg.surface.SurfaceHeightC;
  7013			CalculateSwathAndDETConfiguration_params->Read256BytesBlockHeightY = mode_lib->ms.Read256BlockHeightY;
  7014			CalculateSwathAndDETConfiguration_params->Read256BytesBlockHeightC = mode_lib->ms.Read256BlockHeightC;
  7015			CalculateSwathAndDETConfiguration_params->Read256BytesBlockWidthY = mode_lib->ms.Read256BlockWidthY;
  7016			CalculateSwathAndDETConfiguration_params->Read256BytesBlockWidthC = mode_lib->ms.Read256BlockWidthC;
  7017			CalculateSwathAndDETConfiguration_params->ODMMode = mode_lib->ms.ODMModeThisState;
  7018			CalculateSwathAndDETConfiguration_params->BlendingAndTiming = mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming;
  7019			CalculateSwathAndDETConfiguration_params->BytePerPixY = mode_lib->ms.BytePerPixelY;
  7020			CalculateSwathAndDETConfiguration_params->BytePerPixC = mode_lib->ms.BytePerPixelC;
  7021			CalculateSwathAndDETConfiguration_params->BytePerPixDETY = mode_lib->ms.BytePerPixelInDETY;
  7022			CalculateSwathAndDETConfiguration_params->BytePerPixDETC = mode_lib->ms.BytePerPixelInDETC;
  7023			CalculateSwathAndDETConfiguration_params->HActive = mode_lib->ms.cache_display_cfg.timing.HActive;
  7024			CalculateSwathAndDETConfiguration_params->HRatio = mode_lib->ms.cache_display_cfg.plane.HRatio;
  7025			CalculateSwathAndDETConfiguration_params->HRatioChroma = mode_lib->ms.cache_display_cfg.plane.HRatioChroma;
  7026			CalculateSwathAndDETConfiguration_params->DPPPerSurface = mode_lib->ms.NoOfDPPThisState;
  7027			CalculateSwathAndDETConfiguration_params->swath_width_luma_ub = mode_lib->ms.swath_width_luma_ub_this_state;
  7028			CalculateSwathAndDETConfiguration_params->swath_width_chroma_ub = mode_lib->ms.swath_width_chroma_ub_this_state;
  7029			CalculateSwathAndDETConfiguration_params->SwathWidth = mode_lib->ms.SwathWidthYThisState;
  7030			CalculateSwathAndDETConfiguration_params->SwathWidthChroma = mode_lib->ms.SwathWidthCThisState;
  7031			CalculateSwathAndDETConfiguration_params->SwathHeightY = mode_lib->ms.SwathHeightYThisState;
  7032			CalculateSwathAndDETConfiguration_params->SwathHeightC = mode_lib->ms.SwathHeightCThisState;
  7033			CalculateSwathAndDETConfiguration_params->DETBufferSizeInKByte = mode_lib->ms.DETBufferSizeInKByteThisState;
  7034			CalculateSwathAndDETConfiguration_params->DETBufferSizeY = mode_lib->ms.DETBufferSizeYThisState;
  7035			CalculateSwathAndDETConfiguration_params->DETBufferSizeC = mode_lib->ms.DETBufferSizeCThisState;
  7036			CalculateSwathAndDETConfiguration_params->UnboundedRequestEnabled = &mode_lib->ms.UnboundedRequestEnabledThisState;
  7037			CalculateSwathAndDETConfiguration_params->compbuf_reserved_space_64b = &s->dummy_integer[2];
  7038			CalculateSwathAndDETConfiguration_params->compbuf_reserved_space_zs = &s->dummy_integer[1];
  7039			CalculateSwathAndDETConfiguration_params->CompressedBufferSizeInkByte = &mode_lib->ms.CompressedBufferSizeInkByteThisState;
  7040			CalculateSwathAndDETConfiguration_params->ViewportSizeSupportPerSurface = s->dummy_boolean_array[0];
  7041			CalculateSwathAndDETConfiguration_params->ViewportSizeSupport = &mode_lib->ms.support.ViewportSizeSupport[j];
  7042	
  7043			CalculateSwathAndDETConfiguration(&mode_lib->scratch,
  7044			CalculateSwathAndDETConfiguration_params);
  7045	
  7046			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7047				mode_lib->ms.swath_width_luma_ub_all_states[j][k] = mode_lib->ms.swath_width_luma_ub_this_state[k];
  7048				mode_lib->ms.swath_width_chroma_ub_all_states[j][k] = mode_lib->ms.swath_width_chroma_ub_this_state[k];
  7049				mode_lib->ms.SwathWidthYAllStates[j][k] = mode_lib->ms.SwathWidthYThisState[k];
  7050				mode_lib->ms.SwathWidthCAllStates[j][k] = mode_lib->ms.SwathWidthCThisState[k];
  7051				mode_lib->ms.SwathHeightYAllStates[j][k] = mode_lib->ms.SwathHeightYThisState[k];
  7052				mode_lib->ms.SwathHeightCAllStates[j][k] = mode_lib->ms.SwathHeightCThisState[k];
  7053				mode_lib->ms.UnboundedRequestEnabledAllStates[j] = mode_lib->ms.UnboundedRequestEnabledThisState;
  7054				mode_lib->ms.CompressedBufferSizeInkByteAllStates[j] = mode_lib->ms.CompressedBufferSizeInkByteThisState;
  7055				mode_lib->ms.DETBufferSizeInKByteAllStates[j][k] = mode_lib->ms.DETBufferSizeInKByteThisState[k];
  7056				mode_lib->ms.DETBufferSizeYAllStates[j][k] = mode_lib->ms.DETBufferSizeYThisState[k];
  7057				mode_lib->ms.DETBufferSizeCAllStates[j][k] = mode_lib->ms.DETBufferSizeCThisState[k];
  7058			}
  7059		}
  7060	
  7061		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7062			mode_lib->ms.cursor_bw[k] = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k] * mode_lib->ms.cache_display_cfg.plane.CursorWidth[k] * mode_lib->ms.cache_display_cfg.plane.CursorBPP[k] / 8.0 / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.cache_display_cfg.plane.VRatio[k];
  7063		}
  7064	
  7065		CalculateSurfaceSizeInMall(
  7066				mode_lib->ms.num_active_planes,
  7067				mode_lib->ms.soc.mall_allocated_for_dcn_mbytes,
  7068				mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen,
  7069				mode_lib->ms.cache_display_cfg.surface.DCCEnable,
  7070				mode_lib->ms.cache_display_cfg.plane.ViewportStationary,
  7071				mode_lib->ms.cache_display_cfg.plane.ViewportXStart,
  7072				mode_lib->ms.cache_display_cfg.plane.ViewportYStart,
  7073				mode_lib->ms.cache_display_cfg.plane.ViewportXStartC,
  7074				mode_lib->ms.cache_display_cfg.plane.ViewportYStartC,
  7075				mode_lib->ms.cache_display_cfg.plane.ViewportWidth,
  7076				mode_lib->ms.cache_display_cfg.plane.ViewportHeight,
  7077				mode_lib->ms.BytePerPixelY,
  7078				mode_lib->ms.cache_display_cfg.plane.ViewportWidthChroma,
  7079				mode_lib->ms.cache_display_cfg.plane.ViewportHeightChroma,
  7080				mode_lib->ms.BytePerPixelC,
  7081				mode_lib->ms.cache_display_cfg.surface.SurfaceWidthY,
  7082				mode_lib->ms.cache_display_cfg.surface.SurfaceWidthC,
  7083				mode_lib->ms.cache_display_cfg.surface.SurfaceHeightY,
  7084				mode_lib->ms.cache_display_cfg.surface.SurfaceHeightC,
  7085				mode_lib->ms.Read256BlockWidthY,
  7086				mode_lib->ms.Read256BlockWidthC,
  7087				mode_lib->ms.Read256BlockHeightY,
  7088				mode_lib->ms.Read256BlockHeightC,
  7089				mode_lib->ms.MacroTileWidthY,
  7090				mode_lib->ms.MacroTileWidthC,
  7091				mode_lib->ms.MacroTileHeightY,
  7092				mode_lib->ms.MacroTileHeightC,
  7093	
  7094				/* Output */
  7095				mode_lib->ms.SurfaceSizeInMALL,
  7096				&mode_lib->ms.support.ExceededMALLSize);
  7097	
  7098		for (j = 0; j < 2; j++) {
  7099			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  7100				mode_lib->ms.swath_width_luma_ub_this_state[k] = mode_lib->ms.swath_width_luma_ub_all_states[j][k];
  7101				mode_lib->ms.swath_width_chroma_ub_this_state[k] = mode_lib->ms.swath_width_chroma_ub_all_states[j][k];
  7102				mode_lib->ms.SwathWidthYThisState[k] = mode_lib->ms.SwathWidthYAllStates[j][k];
  7103				mode_lib->ms.SwathWidthCThisState[k] = mode_lib->ms.SwathWidthCAllStates[j][k];
  7104				mode_lib->ms.SwathHeightYThisState[k] = mode_lib->ms.SwathHeightYAllStates[j][k];
  7105				mode_lib->ms.SwathHeightCThisState[k] = mode_lib->ms.SwathHeightCAllStates[j][k];
  7106				mode_lib->ms.DETBufferSizeInKByteThisState[k] = mode_lib->ms.DETBufferSizeInKByteAllStates[j][k];
  7107				mode_lib->ms.DETBufferSizeYThisState[k] = mode_lib->ms.DETBufferSizeYAllStates[j][k];
  7108				mode_lib->ms.DETBufferSizeCThisState[k] = mode_lib->ms.DETBufferSizeCAllStates[j][k];
  7109				mode_lib->ms.RequiredDPPCLKThisState[k] = mode_lib->ms.RequiredDPPCLKPerSurface[j][k];
  7110				mode_lib->ms.NoOfDPPThisState[k] = mode_lib->ms.NoOfDPP[j][k];
  7111			}
  7112	
  7113			mode_lib->ms.TotalNumberOfDCCActiveDPP[j] = 0;
  7114			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7115				if (mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true) {
  7116					mode_lib->ms.TotalNumberOfDCCActiveDPP[j] = mode_lib->ms.TotalNumberOfDCCActiveDPP[j] + mode_lib->ms.NoOfDPP[j][k];
  7117				}
  7118			}
  7119	
  7120			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7121				s->SurfParameters[k].PixelClock = mode_lib->ms.cache_display_cfg.timing.PixelClock[k];
  7122				s->SurfParameters[k].DPPPerSurface = mode_lib->ms.NoOfDPP[j][k];
  7123				s->SurfParameters[k].SourceScan = mode_lib->ms.cache_display_cfg.plane.SourceScan[k];
  7124				s->SurfParameters[k].ViewportHeight = mode_lib->ms.cache_display_cfg.plane.ViewportHeight[k];
  7125				s->SurfParameters[k].ViewportHeightChroma = mode_lib->ms.cache_display_cfg.plane.ViewportHeightChroma[k];
  7126				s->SurfParameters[k].BlockWidth256BytesY = mode_lib->ms.Read256BlockWidthY[k];
  7127				s->SurfParameters[k].BlockHeight256BytesY = mode_lib->ms.Read256BlockHeightY[k];
  7128				s->SurfParameters[k].BlockWidth256BytesC = mode_lib->ms.Read256BlockWidthC[k];
  7129				s->SurfParameters[k].BlockHeight256BytesC = mode_lib->ms.Read256BlockHeightC[k];
  7130				s->SurfParameters[k].BlockWidthY = mode_lib->ms.MacroTileWidthY[k];
  7131				s->SurfParameters[k].BlockHeightY = mode_lib->ms.MacroTileHeightY[k];
  7132				s->SurfParameters[k].BlockWidthC = mode_lib->ms.MacroTileWidthC[k];
  7133				s->SurfParameters[k].BlockHeightC = mode_lib->ms.MacroTileHeightC[k];
  7134				s->SurfParameters[k].InterlaceEnable = mode_lib->ms.cache_display_cfg.timing.Interlace[k];
  7135				s->SurfParameters[k].HTotal = mode_lib->ms.cache_display_cfg.timing.HTotal[k];
  7136				s->SurfParameters[k].DCCEnable = mode_lib->ms.cache_display_cfg.surface.DCCEnable[k];
  7137				s->SurfParameters[k].SourcePixelFormat = mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k];
  7138				s->SurfParameters[k].SurfaceTiling = mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k];
  7139				s->SurfParameters[k].BytePerPixelY = mode_lib->ms.BytePerPixelY[k];
  7140				s->SurfParameters[k].BytePerPixelC = mode_lib->ms.BytePerPixelC[k];
  7141				s->SurfParameters[k].ProgressiveToInterlaceUnitInOPP = mode_lib->ms.ip.ptoi_supported;
  7142				s->SurfParameters[k].VRatio = mode_lib->ms.cache_display_cfg.plane.VRatio[k];
  7143				s->SurfParameters[k].VRatioChroma = mode_lib->ms.cache_display_cfg.plane.VRatioChroma[k];
  7144				s->SurfParameters[k].VTaps = mode_lib->ms.cache_display_cfg.plane.VTaps[k];
  7145				s->SurfParameters[k].VTapsChroma = mode_lib->ms.cache_display_cfg.plane.VTapsChroma[k];
  7146				s->SurfParameters[k].PitchY = mode_lib->ms.cache_display_cfg.surface.PitchY[k];
  7147				s->SurfParameters[k].DCCMetaPitchY = mode_lib->ms.cache_display_cfg.surface.DCCMetaPitchY[k];
  7148				s->SurfParameters[k].PitchC = mode_lib->ms.cache_display_cfg.surface.PitchC[k];
  7149				s->SurfParameters[k].DCCMetaPitchC = mode_lib->ms.cache_display_cfg.surface.DCCMetaPitchC[k];
  7150				s->SurfParameters[k].ViewportStationary = mode_lib->ms.cache_display_cfg.plane.ViewportStationary[k];
  7151				s->SurfParameters[k].ViewportXStart = mode_lib->ms.cache_display_cfg.plane.ViewportXStart[k];
  7152				s->SurfParameters[k].ViewportYStart = mode_lib->ms.cache_display_cfg.plane.ViewportYStart[k];
  7153				s->SurfParameters[k].ViewportXStartC = mode_lib->ms.cache_display_cfg.plane.ViewportXStartC[k];
  7154				s->SurfParameters[k].ViewportYStartC = mode_lib->ms.cache_display_cfg.plane.ViewportYStartC[k];
  7155				s->SurfParameters[k].FORCE_ONE_ROW_FOR_FRAME = mode_lib->ms.cache_display_cfg.plane.ForceOneRowForFrame[k];
  7156				s->SurfParameters[k].SwathHeightY = mode_lib->ms.SwathHeightYThisState[k];
  7157				s->SurfParameters[k].SwathHeightC = mode_lib->ms.SwathHeightCThisState[k];
  7158			}
  7159	
  7160			CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
  7161			CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
  7162			CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib->ms.SurfaceSizeInMALL;
  7163			CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
  7164			CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
  7165			CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
  7166			CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
  7167			CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
  7168			CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
  7169			CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->ms.SwathWidthYThisState;
  7170			CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->ms.SwathWidthCThisState;
  7171			CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
  7172			CalculateVMRowAndSwath_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
  7173			CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
  7174			CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
  7175			CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
  7176			CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
  7177			CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
  7178			CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
  7179			CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
  7180			CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
  7181			CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s->dummy_integer_array[0];
  7182			CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s->dummy_integer_array[1];
  7183			CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib->ms.dpte_row_height;
  7184			CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib->ms.dpte_row_height_chroma;
  7185			CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s->dummy_integer_array[2]; // VBA_DELTA
  7186			CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s->dummy_integer_array[3]; // VBA_DELTA
  7187			CalculateVMRowAndSwath_params->meta_req_width = s->dummy_integer_array[4];
  7188			CalculateVMRowAndSwath_params->meta_req_width_chroma = s->dummy_integer_array[5];
  7189			CalculateVMRowAndSwath_params->meta_req_height = s->dummy_integer_array[6];
  7190			CalculateVMRowAndSwath_params->meta_req_height_chroma = s->dummy_integer_array[7];
  7191			CalculateVMRowAndSwath_params->meta_row_width = s->dummy_integer_array[8];
  7192			CalculateVMRowAndSwath_params->meta_row_width_chroma = s->dummy_integer_array[9];
  7193			CalculateVMRowAndSwath_params->meta_row_height = mode_lib->ms.meta_row_height;
  7194			CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib->ms.meta_row_height_chroma;
  7195			CalculateVMRowAndSwath_params->vm_group_bytes = s->dummy_integer_array[10];
  7196			CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
  7197			CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s->dummy_integer_array[11];
  7198			CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s->dummy_integer_array[12];
  7199			CalculateVMRowAndSwath_params->PTERequestSizeY = s->dummy_integer_array[13];
  7200			CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s->dummy_integer_array[14];
  7201			CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s->dummy_integer_array[15];
  7202			CalculateVMRowAndSwath_params->PTERequestSizeC = s->dummy_integer_array[16];
  7203			CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s->dummy_integer_array[17];
  7204			CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s->dummy_integer_array[18];
  7205			CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s->dummy_integer_array[19];
  7206			CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s->dummy_integer_array[20];
  7207			CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesYThisState;
  7208			CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesCThisState;
  7209			CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib->ms.PrefillY;
  7210			CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib->ms.PrefillC;
  7211			CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib->ms.MaxNumSwY;
  7212			CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib->ms.MaxNumSwC;
  7213			CalculateVMRowAndSwath_params->meta_row_bw = mode_lib->ms.meta_row_bandwidth_this_state;
  7214			CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib->ms.dpte_row_bandwidth_this_state;
  7215			CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRowThisState;
  7216			CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
  7217			CalculateVMRowAndSwath_params->MetaRowByte = mode_lib->ms.MetaRowBytesThisState;
  7218			CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib->ms.use_one_row_for_frame_this_state;
  7219			CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = mode_lib->ms.use_one_row_for_frame_flip_this_state;
  7220			CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s->dummy_boolean_array[0];
  7221			CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s->dummy_boolean_array[1];
  7222			CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s->dummy_integer_array[21];
  7223	
  7224			CalculateVMRowAndSwath(&mode_lib->scratch,
  7225				CalculateVMRowAndSwath_params);
  7226	
  7227			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7228				mode_lib->ms.PrefetchLinesY[j][k] = mode_lib->ms.PrefetchLinesYThisState[k];
  7229				mode_lib->ms.PrefetchLinesC[j][k] = mode_lib->ms.PrefetchLinesCThisState[k];
  7230				mode_lib->ms.meta_row_bandwidth[j][k] = mode_lib->ms.meta_row_bandwidth_this_state[k];
  7231				mode_lib->ms.dpte_row_bandwidth[j][k] = mode_lib->ms.dpte_row_bandwidth_this_state[k];
  7232				mode_lib->ms.DPTEBytesPerRow[j][k] = mode_lib->ms.DPTEBytesPerRowThisState[k];
  7233				mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k] = mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState[k];
  7234				mode_lib->ms.MetaRowBytes[j][k] = mode_lib->ms.MetaRowBytesThisState[k];
  7235				mode_lib->ms.use_one_row_for_frame[j][k] = mode_lib->ms.use_one_row_for_frame_this_state[k];
  7236				mode_lib->ms.use_one_row_for_frame_flip[j][k] = mode_lib->ms.use_one_row_for_frame_flip_this_state[k];
  7237			}
  7238	
  7239			mode_lib->ms.support.PTEBufferSizeNotExceeded[j] = true;
  7240	
  7241			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7242				if (mode_lib->ms.PTEBufferSizeNotExceededPerState[k] == false)
  7243					mode_lib->ms.support.PTEBufferSizeNotExceeded[j] = false;
  7244	#ifdef __DML_VBA_DEBUG__
  7245				dml_print("DML::%s: j=%u k=%u, PTEBufferSizeNotExceededPerState[%u] = %u\n",  __func__, j, k, k, mode_lib->ms.PTEBufferSizeNotExceededPerState[k]);
  7246	#endif
  7247			}
  7248	#ifdef __DML_VBA_DEBUG__
  7249			dml_print("DML::%s: PTEBufferSizeNotExceeded[%u] = %u\n",  __func__, j, mode_lib->ms.support.PTEBufferSizeNotExceeded[j]);
  7250	#endif
  7251	
  7252			mode_lib->ms.support.DCCMetaBufferSizeNotExceeded[j] = true;
  7253			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7254				if (mode_lib->ms.DCCMetaBufferSizeNotExceededPerState[k] == false)
  7255					mode_lib->ms.support.DCCMetaBufferSizeNotExceeded[j] = false;
  7256			}
  7257	
  7258			mode_lib->ms.UrgLatency = CalculateUrgentLatency(mode_lib->ms.state.urgent_latency_pixel_data_only_us,
  7259														mode_lib->ms.state.urgent_latency_pixel_mixed_with_vm_data_us,
  7260														mode_lib->ms.state.urgent_latency_vm_data_only_us,
  7261														mode_lib->ms.soc.do_urgent_latency_adjustment,
  7262														mode_lib->ms.state.urgent_latency_adjustment_fabric_clock_component_us,
  7263														mode_lib->ms.state.urgent_latency_adjustment_fabric_clock_reference_mhz,
  7264														mode_lib->ms.state.fabricclk_mhz);
  7265	
  7266			/* Getter functions work at mp interface so copy the urgent latency to mp*/
  7267			mode_lib->mp.UrgentLatency = mode_lib->ms.UrgLatency;
  7268	
  7269			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7270				CalculateUrgentBurstFactor(
  7271					mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k],
  7272					mode_lib->ms.swath_width_luma_ub_this_state[k],
  7273					mode_lib->ms.swath_width_chroma_ub_this_state[k],
  7274					mode_lib->ms.SwathHeightYThisState[k],
  7275					mode_lib->ms.SwathHeightCThisState[k],
  7276					(dml_float_t) mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
  7277					mode_lib->ms.UrgLatency,
  7278					mode_lib->ms.ip.cursor_buffer_size,
  7279					mode_lib->ms.cache_display_cfg.plane.CursorWidth[k],
  7280					mode_lib->ms.cache_display_cfg.plane.CursorBPP[k],
  7281					mode_lib->ms.cache_display_cfg.plane.VRatio[k],
  7282					mode_lib->ms.cache_display_cfg.plane.VRatioChroma[k],
  7283					mode_lib->ms.BytePerPixelInDETY[k],
  7284					mode_lib->ms.BytePerPixelInDETC[k],
  7285					mode_lib->ms.DETBufferSizeYThisState[k],
  7286					mode_lib->ms.DETBufferSizeCThisState[k],
  7287					/* Output */
  7288					&mode_lib->ms.UrgentBurstFactorCursor[k],
  7289					&mode_lib->ms.UrgentBurstFactorLuma[k],
  7290					&mode_lib->ms.UrgentBurstFactorChroma[k],
  7291					&mode_lib->ms.NotUrgentLatencyHiding[k]);
  7292			}
  7293	
  7294			CalculateDCFCLKDeepSleep(
  7295					mode_lib->ms.num_active_planes,
  7296					mode_lib->ms.BytePerPixelY,
  7297					mode_lib->ms.BytePerPixelC,
  7298					mode_lib->ms.cache_display_cfg.plane.VRatio,
  7299					mode_lib->ms.cache_display_cfg.plane.VRatioChroma,
  7300					mode_lib->ms.SwathWidthYThisState,
  7301					mode_lib->ms.SwathWidthCThisState,
  7302					mode_lib->ms.NoOfDPPThisState,
  7303					mode_lib->ms.cache_display_cfg.plane.HRatio,
  7304					mode_lib->ms.cache_display_cfg.plane.HRatioChroma,
  7305					mode_lib->ms.cache_display_cfg.timing.PixelClock,
  7306					mode_lib->ms.PSCL_FACTOR,
  7307					mode_lib->ms.PSCL_FACTOR_CHROMA,
  7308					mode_lib->ms.RequiredDPPCLKThisState,
  7309					mode_lib->ms.ReadBandwidthLuma,
  7310					mode_lib->ms.ReadBandwidthChroma,
  7311					mode_lib->ms.soc.return_bus_width_bytes,
  7312	
  7313					/* Output */
  7314					&mode_lib->ms.ProjectedDCFCLKDeepSleep[j]);
  7315		}
  7316	
  7317		//Calculate Return BW
  7318		for (j = 0; j < 2; ++j) {
  7319			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  7320				if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
  7321					if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
  7322						mode_lib->ms.WritebackDelayTime[k] = mode_lib->ms.state.writeback_latency_us + CalculateWriteBackDelay(
  7323										mode_lib->ms.cache_display_cfg.writeback.WritebackPixelFormat[k],
  7324										mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[k],
  7325										mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[k],
  7326										mode_lib->ms.cache_display_cfg.writeback.WritebackVTaps[k],
  7327										mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[k],
  7328										mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationHeight[k],
  7329										mode_lib->ms.cache_display_cfg.writeback.WritebackSourceHeight[k],
  7330										mode_lib->ms.cache_display_cfg.timing.HTotal[k]) / mode_lib->ms.RequiredDISPCLK[j];
  7331					} else {
  7332						mode_lib->ms.WritebackDelayTime[k] = 0.0;
  7333					}
  7334					for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
  7335						if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[m] == k && mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[m] == true) {
  7336							mode_lib->ms.WritebackDelayTime[k] = dml_max(mode_lib->ms.WritebackDelayTime[k],
  7337												mode_lib->ms.state.writeback_latency_us + CalculateWriteBackDelay(
  7338												mode_lib->ms.cache_display_cfg.writeback.WritebackPixelFormat[m],
  7339												mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[m],
  7340												mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[m],
  7341												mode_lib->ms.cache_display_cfg.writeback.WritebackVTaps[m],
  7342												mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[m],
  7343												mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationHeight[m],
  7344												mode_lib->ms.cache_display_cfg.writeback.WritebackSourceHeight[m],
  7345												mode_lib->ms.cache_display_cfg.timing.HTotal[m]) / mode_lib->ms.RequiredDISPCLK[j]);
  7346						}
  7347					}
  7348				}
  7349			}
  7350			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  7351				for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
  7352					if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == m) {
  7353						mode_lib->ms.WritebackDelayTime[k] = mode_lib->ms.WritebackDelayTime[m];
  7354					}
  7355				}
  7356			}
  7357	       s->MaxVStartupAllPlanes[j] = 0;  // max vstartup among all planes
  7358	
  7359			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  7360				s->MaximumVStartup[j][k] = CalculateMaxVStartup(k,
  7361															mode_lib->ms.ip.ptoi_supported,
  7362															mode_lib->ms.ip.vblank_nom_default_us,
  7363															&mode_lib->ms.cache_display_cfg.timing,
  7364															mode_lib->ms.WritebackDelayTime[k]);
  7365	
  7366				s->MaxVStartupAllPlanes[j] = (dml_uint_t)(dml_max(s->MaxVStartupAllPlanes[j], s->MaximumVStartup[j][k]));
  7367	#ifdef __DML_VBA_DEBUG__
  7368				dml_print("DML::%s: k=%u, MaxVStartupAllPlanes[%u] = %u\n", __func__, k, j, s->MaxVStartupAllPlanes[j]);
  7369				dml_print("DML::%s: k=%u, MaximumVStartup[%u][%u] = %u\n", __func__, k, j, k, s->MaximumVStartup[j][k]);
  7370	#endif
  7371			}
  7372		}
  7373	
  7374		s->ReorderingBytes = (dml_uint_t)(mode_lib->ms.soc.num_chans * dml_max3(mode_lib->ms.soc.urgent_out_of_order_return_per_channel_pixel_only_bytes,
  7375																	mode_lib->ms.soc.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes,
  7376																	mode_lib->ms.soc.urgent_out_of_order_return_per_channel_vm_only_bytes));
  7377	
  7378		for (j = 0; j < 2; ++j) {
  7379			mode_lib->ms.DCFCLKState[j] = mode_lib->ms.state.dcfclk_mhz;
  7380		}
  7381	
  7382		/* Immediate Flip and MALL parameters */
  7383		s->ImmediateFlipRequiredFinal = false;
  7384		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7385			s->ImmediateFlipRequiredFinal = s->ImmediateFlipRequiredFinal || (mode_lib->ms.policy.ImmediateFlipRequirement[k] == dml_immediate_flip_required);
  7386		}
  7387	
  7388		mode_lib->ms.support.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified = false;
  7389		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7390			mode_lib->ms.support.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified = mode_lib->ms.support.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified ||
  7391																								((mode_lib->ms.policy.ImmediateFlipRequirement[k] != dml_immediate_flip_required) &&
  7392																								(mode_lib->ms.policy.ImmediateFlipRequirement[k] != dml_immediate_flip_not_required));
  7393		}
  7394		mode_lib->ms.support.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified = mode_lib->ms.support.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified && s->ImmediateFlipRequiredFinal;
  7395	
  7396		mode_lib->ms.support.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe = false;
  7397		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7398			mode_lib->ms.support.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe =
  7399											mode_lib->ms.support.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe || ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == true || mode_lib->ms.policy.ImmediateFlipRequirement[k] != dml_immediate_flip_not_required) &&
  7400											(mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_full_frame || mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_phantom_pipe));
  7401		}
  7402	
  7403		mode_lib->ms.support.InvalidCombinationOfMALLUseForPStateAndStaticScreen = false;
  7404		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7405			mode_lib->ms.support.InvalidCombinationOfMALLUseForPStateAndStaticScreen = mode_lib->ms.support.InvalidCombinationOfMALLUseForPStateAndStaticScreen ||
  7406																	((mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen[k] == dml_use_mall_static_screen_enable || mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen[k] == dml_use_mall_static_screen_optimize) && (mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_phantom_pipe)) ||
  7407																	((mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen[k] == dml_use_mall_static_screen_disable || mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen[k] == dml_use_mall_static_screen_optimize) && (mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_full_frame));
  7408		}
  7409	
  7410		s->FullFrameMALLPStateMethod = false;
  7411		s->SubViewportMALLPStateMethod = false;
  7412		s->PhantomPipeMALLPStateMethod = false;
  7413		s->SubViewportMALLRefreshGreaterThan120Hz = false;
  7414		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7415			if (mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_full_frame)
  7416				s->FullFrameMALLPStateMethod = true;
  7417			if (mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_sub_viewport) {
  7418				s->SubViewportMALLPStateMethod = true;
  7419				if (mode_lib->ms.cache_display_cfg.timing.RefreshRate[k] > 120)
  7420					s->SubViewportMALLRefreshGreaterThan120Hz = true;
  7421			}
  7422			if (mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k] == dml_use_mall_pstate_change_phantom_pipe)
  7423				s->PhantomPipeMALLPStateMethod = true;
  7424		}
  7425		mode_lib->ms.support.InvalidCombinationOfMALLUseForPState = (s->SubViewportMALLPStateMethod != s->PhantomPipeMALLPStateMethod)
  7426		|| (s->SubViewportMALLPStateMethod && s->FullFrameMALLPStateMethod) || s->SubViewportMALLRefreshGreaterThan120Hz;
  7427	
  7428	    if (mode_lib->ms.policy.UseMinimumRequiredDCFCLK == true) {
  7429			UseMinimumDCFCLK_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
  7430			UseMinimumDCFCLK_params->DRRDisplay = mode_lib->ms.cache_display_cfg.timing.DRRDisplay;
  7431			UseMinimumDCFCLK_params->SynchronizeDRRDisplaysForUCLKPStateChangeFinal = mode_lib->ms.policy.SynchronizeDRRDisplaysForUCLKPStateChangeFinal;
  7432			UseMinimumDCFCLK_params->MaxInterDCNTileRepeaters = mode_lib->ms.ip.max_inter_dcn_tile_repeaters;
  7433			UseMinimumDCFCLK_params->MaxPrefetchMode = dml_prefetch_support_stutter;
  7434			UseMinimumDCFCLK_params->DRAMClockChangeLatencyFinal = mode_lib->ms.state.dram_clock_change_latency_us;
  7435			UseMinimumDCFCLK_params->FCLKChangeLatency = mode_lib->ms.state.fclk_change_latency_us;
  7436			UseMinimumDCFCLK_params->SREnterPlusExitTime = mode_lib->ms.state.sr_enter_plus_exit_time_us;
  7437			UseMinimumDCFCLK_params->ReturnBusWidth = mode_lib->ms.soc.return_bus_width_bytes;
  7438			UseMinimumDCFCLK_params->RoundTripPingLatencyCycles = mode_lib->ms.soc.round_trip_ping_latency_dcfclk_cycles;
  7439			UseMinimumDCFCLK_params->ReorderingBytes = s->ReorderingBytes;
  7440			UseMinimumDCFCLK_params->PixelChunkSizeInKByte = mode_lib->ms.ip.pixel_chunk_size_kbytes;
  7441			UseMinimumDCFCLK_params->MetaChunkSize = mode_lib->ms.ip.meta_chunk_size_kbytes;
  7442			UseMinimumDCFCLK_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
  7443			UseMinimumDCFCLK_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
  7444			UseMinimumDCFCLK_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
  7445			UseMinimumDCFCLK_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
  7446			UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
  7447			UseMinimumDCFCLK_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
  7448			UseMinimumDCFCLK_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
  7449			UseMinimumDCFCLK_params->ImmediateFlipRequirement = s->ImmediateFlipRequiredFinal;
  7450			UseMinimumDCFCLK_params->ProgressiveToInterlaceUnitInOPP = mode_lib->ms.ip.ptoi_supported;
  7451			UseMinimumDCFCLK_params->MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation = mode_lib->ms.soc.max_avg_sdp_bw_use_normal_percent;
  7452			UseMinimumDCFCLK_params->PercentOfIdealSDPPortBWReceivedAfterUrgLatency = mode_lib->ms.soc.pct_ideal_sdp_bw_after_urgent;
  7453			UseMinimumDCFCLK_params->VTotal = mode_lib->ms.cache_display_cfg.timing.VTotal;
  7454			UseMinimumDCFCLK_params->VActive = mode_lib->ms.cache_display_cfg.timing.VActive;
  7455			UseMinimumDCFCLK_params->DynamicMetadataTransmittedBytes = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataTransmittedBytes;
  7456			UseMinimumDCFCLK_params->DynamicMetadataLinesBeforeActiveRequired = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataLinesBeforeActiveRequired;
  7457			UseMinimumDCFCLK_params->Interlace = mode_lib->ms.cache_display_cfg.timing.Interlace;
  7458			UseMinimumDCFCLK_params->RequiredDPPCLKPerSurface = mode_lib->ms.RequiredDPPCLKPerSurface;
  7459			UseMinimumDCFCLK_params->RequiredDISPCLK = mode_lib->ms.RequiredDISPCLK;
  7460			UseMinimumDCFCLK_params->UrgLatency = mode_lib->ms.UrgLatency;
  7461			UseMinimumDCFCLK_params->NoOfDPP = mode_lib->ms.NoOfDPP;
  7462			UseMinimumDCFCLK_params->ProjectedDCFCLKDeepSleep = mode_lib->ms.ProjectedDCFCLKDeepSleep;
  7463			UseMinimumDCFCLK_params->MaximumVStartup = s->MaximumVStartup;
  7464			UseMinimumDCFCLK_params->TotalNumberOfActiveDPP = mode_lib->ms.TotalNumberOfActiveDPP;
  7465			UseMinimumDCFCLK_params->TotalNumberOfDCCActiveDPP = mode_lib->ms.TotalNumberOfDCCActiveDPP;
  7466			UseMinimumDCFCLK_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
  7467			UseMinimumDCFCLK_params->PrefetchLinesY = mode_lib->ms.PrefetchLinesY;
  7468			UseMinimumDCFCLK_params->PrefetchLinesC = mode_lib->ms.PrefetchLinesC;
  7469			UseMinimumDCFCLK_params->swath_width_luma_ub_all_states = mode_lib->ms.swath_width_luma_ub_all_states;
  7470			UseMinimumDCFCLK_params->swath_width_chroma_ub_all_states = mode_lib->ms.swath_width_chroma_ub_all_states;
  7471			UseMinimumDCFCLK_params->BytePerPixelY = mode_lib->ms.BytePerPixelY;
  7472			UseMinimumDCFCLK_params->BytePerPixelC = mode_lib->ms.BytePerPixelC;
  7473			UseMinimumDCFCLK_params->HTotal = mode_lib->ms.cache_display_cfg.timing.HTotal;
  7474			UseMinimumDCFCLK_params->PixelClock = mode_lib->ms.cache_display_cfg.timing.PixelClock;
  7475			UseMinimumDCFCLK_params->PDEAndMetaPTEBytesPerFrame = mode_lib->ms.PDEAndMetaPTEBytesPerFrame;
  7476			UseMinimumDCFCLK_params->DPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRow;
  7477			UseMinimumDCFCLK_params->MetaRowBytes = mode_lib->ms.MetaRowBytes;
  7478			UseMinimumDCFCLK_params->DynamicMetadataEnable = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataEnable;
  7479			UseMinimumDCFCLK_params->ReadBandwidthLuma = mode_lib->ms.ReadBandwidthLuma;
  7480			UseMinimumDCFCLK_params->ReadBandwidthChroma = mode_lib->ms.ReadBandwidthChroma;
  7481			UseMinimumDCFCLK_params->DCFCLKPerState = mode_lib->ms.state.dcfclk_mhz;
  7482			UseMinimumDCFCLK_params->DCFCLKState = mode_lib->ms.DCFCLKState;
  7483	
  7484			UseMinimumDCFCLK(&mode_lib->scratch,
  7485			UseMinimumDCFCLK_params);
  7486	
  7487		 } // UseMinimumRequiredDCFCLK == true
  7488	
  7489		for (j = 0; j < 2; ++j) {
  7490			mode_lib->ms.ReturnBWPerState[j] = dml_get_return_bw_mbps(&mode_lib->ms.soc, mode_lib->ms.state.use_ideal_dram_bw_strobe,
  7491																	mode_lib->ms.cache_display_cfg.plane.HostVMEnable, mode_lib->ms.DCFCLKState[j], mode_lib->ms.state.fabricclk_mhz,
  7492																	mode_lib->ms.state.dram_speed_mts);
  7493			mode_lib->ms.ReturnDRAMBWPerState[j] = dml_get_return_dram_bw_mbps(&mode_lib->ms.soc, mode_lib->ms.state.use_ideal_dram_bw_strobe,
  7494																	mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
  7495																	mode_lib->ms.state.dram_speed_mts);
  7496		}
  7497	
  7498		//Re-ordering Buffer Support Check
  7499		for (j = 0; j < 2; ++j) {
  7500			if ((mode_lib->ms.ip.rob_buffer_size_kbytes - mode_lib->ms.ip.pixel_chunk_size_kbytes) * 1024 / mode_lib->ms.ReturnBWPerState[j] >
  7501				(mode_lib->ms.soc.round_trip_ping_latency_dcfclk_cycles + 32) / mode_lib->ms.DCFCLKState[j] + s->ReorderingBytes / mode_lib->ms.ReturnBWPerState[j]) {
  7502				mode_lib->ms.support.ROBSupport[j] = true;
  7503			} else {
  7504				mode_lib->ms.support.ROBSupport[j] = false;
  7505			}
  7506			dml_print("DML::%s: DEBUG ROBSupport[%u] = %u (%u)\n",  __func__, j, mode_lib->ms.support.ROBSupport[j], __LINE__);
  7507		}
  7508	
  7509		//Vertical Active BW support check
  7510		s->MaxTotalVActiveRDBandwidth = 0;
  7511		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7512			s->MaxTotalVActiveRDBandwidth = s->MaxTotalVActiveRDBandwidth + mode_lib->ms.ReadBandwidthLuma[k] + mode_lib->ms.ReadBandwidthChroma[k];
  7513		}
  7514	
  7515		for (j = 0; j < 2; ++j) {
  7516			mode_lib->ms.support.MaxTotalVerticalActiveAvailableBandwidth[j] = dml_min3(mode_lib->ms.soc.return_bus_width_bytes * mode_lib->ms.DCFCLKState[j] * mode_lib->ms.soc.max_avg_sdp_bw_use_normal_percent / 100.0,
  7517																		mode_lib->ms.state.fabricclk_mhz * mode_lib->ms.soc.fabric_datapath_to_dcn_data_return_bytes * mode_lib->ms.soc.max_avg_fabric_bw_use_normal_percent / 100.0,
  7518																		mode_lib->ms.state.dram_speed_mts * mode_lib->ms.soc.num_chans * mode_lib->ms.soc.dram_channel_width_bytes *
  7519																		((mode_lib->ms.state.use_ideal_dram_bw_strobe && !mode_lib->ms.cache_display_cfg.plane.HostVMEnable) ?
  7520																		mode_lib->ms.soc.max_avg_dram_bw_use_normal_strobe_percent : mode_lib->ms.soc.max_avg_dram_bw_use_normal_percent) / 100.0);
  7521	
  7522			if (s->MaxTotalVActiveRDBandwidth <= mode_lib->ms.support.MaxTotalVerticalActiveAvailableBandwidth[j]) {
  7523				mode_lib->ms.support.TotalVerticalActiveBandwidthSupport[j] = true;
  7524			} else {
  7525				mode_lib->ms.support.TotalVerticalActiveBandwidthSupport[j] = false;
  7526			}
  7527		}
  7528	
  7529		/* Prefetch Check */
  7530	
  7531		for (j = 0; j < 2; ++j) {
  7532			mode_lib->ms.TimeCalc = 24 / mode_lib->ms.ProjectedDCFCLKDeepSleep[j];
  7533	
  7534			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  7535				mode_lib->ms.NoOfDPPThisState[k] = mode_lib->ms.NoOfDPP[j][k];
  7536				mode_lib->ms.swath_width_luma_ub_this_state[k] = mode_lib->ms.swath_width_luma_ub_all_states[j][k];
  7537				mode_lib->ms.swath_width_chroma_ub_this_state[k] = mode_lib->ms.swath_width_chroma_ub_all_states[j][k];
  7538				mode_lib->ms.SwathWidthYThisState[k] = mode_lib->ms.SwathWidthYAllStates[j][k];
  7539				mode_lib->ms.SwathWidthCThisState[k] = mode_lib->ms.SwathWidthCAllStates[j][k];
  7540				mode_lib->ms.SwathHeightYThisState[k] = mode_lib->ms.SwathHeightYAllStates[j][k];
  7541				mode_lib->ms.SwathHeightCThisState[k] = mode_lib->ms.SwathHeightCAllStates[j][k];
  7542				mode_lib->ms.UnboundedRequestEnabledThisState = mode_lib->ms.UnboundedRequestEnabledAllStates[j];
  7543				mode_lib->ms.CompressedBufferSizeInkByteThisState = mode_lib->ms.CompressedBufferSizeInkByteAllStates[j];
  7544				mode_lib->ms.DETBufferSizeInKByteThisState[k] = mode_lib->ms.DETBufferSizeInKByteAllStates[j][k];
  7545				mode_lib->ms.DETBufferSizeYThisState[k] = mode_lib->ms.DETBufferSizeYAllStates[j][k];
  7546				mode_lib->ms.DETBufferSizeCThisState[k] = mode_lib->ms.DETBufferSizeCAllStates[j][k];
  7547			}
  7548	
  7549			mode_lib->ms.support.VActiveBandwithSupport[j] = CalculateVActiveBandwithSupport(
  7550				mode_lib->ms.num_active_planes,
  7551				mode_lib->ms.ReturnBWPerState[j],
  7552				mode_lib->ms.NotUrgentLatencyHiding,
  7553				mode_lib->ms.ReadBandwidthLuma,
  7554				mode_lib->ms.ReadBandwidthChroma,
  7555				mode_lib->ms.cursor_bw,
  7556				mode_lib->ms.meta_row_bandwidth_this_state,
  7557				mode_lib->ms.dpte_row_bandwidth_this_state,
  7558				mode_lib->ms.NoOfDPPThisState,
  7559				mode_lib->ms.UrgentBurstFactorLuma,
  7560				mode_lib->ms.UrgentBurstFactorChroma,
  7561				mode_lib->ms.UrgentBurstFactorCursor);
  7562	
  7563			s->VMDataOnlyReturnBWPerState = dml_get_return_bw_mbps_vm_only(
  7564																		&mode_lib->ms.soc,
  7565																		mode_lib->ms.state.use_ideal_dram_bw_strobe,
  7566																		mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
  7567																		mode_lib->ms.DCFCLKState[j],
  7568																		mode_lib->ms.state.fabricclk_mhz,
  7569																		mode_lib->ms.state.dram_speed_mts);
  7570	
  7571			s->HostVMInefficiencyFactor = 1;
  7572			if (mode_lib->ms.cache_display_cfg.plane.GPUVMEnable && mode_lib->ms.cache_display_cfg.plane.HostVMEnable)
  7573				s->HostVMInefficiencyFactor = mode_lib->ms.ReturnBWPerState[j] / s->VMDataOnlyReturnBWPerState;
  7574	
  7575			mode_lib->ms.ExtraLatency = CalculateExtraLatency(
  7576					mode_lib->ms.soc.round_trip_ping_latency_dcfclk_cycles,
  7577					s->ReorderingBytes,
  7578					mode_lib->ms.DCFCLKState[j],
  7579					mode_lib->ms.TotalNumberOfActiveDPP[j],
  7580					mode_lib->ms.ip.pixel_chunk_size_kbytes,
  7581					mode_lib->ms.TotalNumberOfDCCActiveDPP[j],
  7582					mode_lib->ms.ip.meta_chunk_size_kbytes,
  7583					mode_lib->ms.ReturnBWPerState[j],
  7584					mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
  7585					mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
  7586					mode_lib->ms.num_active_planes,
  7587					mode_lib->ms.NoOfDPPThisState,
  7588					mode_lib->ms.dpte_group_bytes,
  7589					s->HostVMInefficiencyFactor,
  7590					mode_lib->ms.soc.hostvm_min_page_size_kbytes,
  7591					mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
  7592	
  7593			s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
  7594			s->MaxVStartup = 0;
  7595			s->AllPrefetchModeTested = true;
  7596			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  7597				CalculatePrefetchMode(mode_lib->ms.policy.AllowForPStateChangeOrStutterInVBlank[k], &s->MinPrefetchMode[k], &s->MaxPrefetchMode[k]);
  7598				s->NextPrefetchMode[k] = s->MinPrefetchMode[k];
  7599			}
  7600	
  7601			do {
  7602				s->MaxVStartup = s->NextMaxVStartup;
  7603				s->AllPrefetchModeTested = true;
  7604	
  7605				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  7606					mode_lib->ms.PrefetchMode[k] = s->NextPrefetchMode[k];
  7607					mode_lib->ms.TWait = CalculateTWait(
  7608									mode_lib->ms.PrefetchMode[k],
  7609									mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k],
  7610									mode_lib->ms.policy.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
  7611									mode_lib->ms.cache_display_cfg.timing.DRRDisplay[k],
  7612									mode_lib->ms.state.dram_clock_change_latency_us,
  7613									mode_lib->ms.state.fclk_change_latency_us,
  7614									mode_lib->ms.UrgLatency,
  7615									mode_lib->ms.state.sr_enter_plus_exit_time_us);
  7616	
  7617					myPipe = &s->myPipe;
  7618					myPipe->Dppclk = mode_lib->ms.RequiredDPPCLKPerSurface[j][k];
  7619					myPipe->Dispclk = mode_lib->ms.RequiredDISPCLK[j];
  7620					myPipe->PixelClock = mode_lib->ms.cache_display_cfg.timing.PixelClock[k];
  7621					myPipe->DCFClkDeepSleep = mode_lib->ms.ProjectedDCFCLKDeepSleep[j];
  7622					myPipe->DPPPerSurface = mode_lib->ms.NoOfDPP[j][k];
  7623					myPipe->ScalerEnabled = mode_lib->ms.cache_display_cfg.plane.ScalerEnabled[k];
  7624					myPipe->SourceScan = mode_lib->ms.cache_display_cfg.plane.SourceScan[k];
  7625					myPipe->BlockWidth256BytesY = mode_lib->ms.Read256BlockWidthY[k];
  7626					myPipe->BlockHeight256BytesY = mode_lib->ms.Read256BlockHeightY[k];
  7627					myPipe->BlockWidth256BytesC = mode_lib->ms.Read256BlockWidthC[k];
  7628					myPipe->BlockHeight256BytesC = mode_lib->ms.Read256BlockHeightC[k];
  7629					myPipe->InterlaceEnable = mode_lib->ms.cache_display_cfg.timing.Interlace[k];
  7630					myPipe->NumberOfCursors = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k];
  7631					myPipe->VBlank = mode_lib->ms.cache_display_cfg.timing.VTotal[k] - mode_lib->ms.cache_display_cfg.timing.VActive[k];
  7632					myPipe->HTotal = mode_lib->ms.cache_display_cfg.timing.HTotal[k];
  7633					myPipe->HActive = mode_lib->ms.cache_display_cfg.timing.HActive[k];
  7634					myPipe->DCCEnable = mode_lib->ms.cache_display_cfg.surface.DCCEnable[k];
  7635					myPipe->ODMMode = mode_lib->ms.ODMModePerState[k];
  7636					myPipe->SourcePixelFormat = mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k];
  7637					myPipe->BytePerPixelY = mode_lib->ms.BytePerPixelY[k];
  7638					myPipe->BytePerPixelC = mode_lib->ms.BytePerPixelC[k];
  7639					myPipe->ProgressiveToInterlaceUnitInOPP = mode_lib->ms.ip.ptoi_supported;
  7640	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
