Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D2784F78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjHWDyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjHWDye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:54:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F56E4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692762870; x=1724298870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=On52AmbL/QsLKcKtN/L8DcA4vlRaiOzmCW8nK+9YGuo=;
  b=n5l6fEpmyiFSDjUapzAqJuVPuGrrlndvpsmdLA1oSfV4UPNFp6FrMmOi
   /yy9NXDGRFOzTI5qTLcbnXG9EcXkHwk1DkLqj8oXBXMqnYbdGaY4ovi60
   RJj3B9Tmp2rT3FzCR9DL5V7h3yOTln9C5Pffu8ZfBfQOJh7Kr1dNbtlx0
   mI2HpiDMeff1U+7mwF2pbIbf3PnbbeRd9jvJU5YPQHA2eACpBFM7ms75F
   MPYf2IFDoM138rlNz8RmHwrowV2TuSXNsbyVtIY7yLggeuiPAzwHc84vU
   cq8E6dK4rJvaBJMejCy16as9kwgjo8LZPSmQIc4ODlUTy+y97rAqIc+I+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372944837"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="372944837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 20:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="771567110"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="771567110"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 20:54:27 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYews-0000pL-1X;
        Wed, 23 Aug 2023 03:54:26 +0000
Date:   Wed, 23 Aug 2023 11:53:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:2072:13:
 warning: stack frame size (2168) exceeds limit (2048) in
 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation'
Message-ID: <202308231108.6U287kWC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89bf6209cad66214d3774dac86b6bbf2aec6a30d
commit: af2f2a256e048f1b83605eaae49948e4a6811ac1 drm/amd/display: Enable dlg and vba compilation for dcn314
date:   11 months ago
config: x86_64-randconfig-x012-20230821 (https://download.01.org/0day-ci/archive/20230823/202308231108.6U287kWC-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308231108.6U287kWC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308231108.6U287kWC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:2072:13: warning: stack frame size (2168) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
   static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(struct display_mode_lib *mode_lib)
               ^
   680/2168 (31.37%) spills, 1488/2168 (68.63%) variables
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:4020:6: warning: stack frame size (2968) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   619/2968 (20.86%) spills, 2349/2968 (79.14%) variables
   2 warnings generated.


vim +/DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation +2072 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c

41529d79ce1655b Roman Li 2022-06-28  2071  
41529d79ce1655b Roman Li 2022-06-28 @2072  static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(struct display_mode_lib *mode_lib)
41529d79ce1655b Roman Li 2022-06-28  2073  {
41529d79ce1655b Roman Li 2022-06-28  2074  	struct vba_vars_st *v = &mode_lib->vba;
41529d79ce1655b Roman Li 2022-06-28  2075  	unsigned int j, k;
41529d79ce1655b Roman Li 2022-06-28  2076  	double HostVMInefficiencyFactor = 1.0;
41529d79ce1655b Roman Li 2022-06-28  2077  	bool NoChromaPlanes = true;
41529d79ce1655b Roman Li 2022-06-28  2078  	int ReorderBytes;
41529d79ce1655b Roman Li 2022-06-28  2079  	double VMDataOnlyReturnBW;
41529d79ce1655b Roman Li 2022-06-28  2080  	double MaxTotalRDBandwidth = 0;
41529d79ce1655b Roman Li 2022-06-28  2081  	int PrefetchMode = v->PrefetchModePerState[v->VoltageLevel][v->maxMpcComb];
41529d79ce1655b Roman Li 2022-06-28  2082  
41529d79ce1655b Roman Li 2022-06-28  2083  	v->WritebackDISPCLK = 0.0;
41529d79ce1655b Roman Li 2022-06-28  2084  	v->DISPCLKWithRamping = 0;
41529d79ce1655b Roman Li 2022-06-28  2085  	v->DISPCLKWithoutRamping = 0;
41529d79ce1655b Roman Li 2022-06-28  2086  	v->GlobalDPPCLK = 0.0;
41529d79ce1655b Roman Li 2022-06-28  2087  	/* DAL custom code: need to update ReturnBW in case min dcfclk is overridden */
41529d79ce1655b Roman Li 2022-06-28  2088  	{
41529d79ce1655b Roman Li 2022-06-28  2089  	double IdealFabricAndSDPPortBandwidthPerState = dml_min(
41529d79ce1655b Roman Li 2022-06-28  2090  			v->ReturnBusWidth * v->DCFCLKState[v->VoltageLevel][v->maxMpcComb],
41529d79ce1655b Roman Li 2022-06-28  2091  			v->FabricClockPerState[v->VoltageLevel] * v->FabricDatapathToDCNDataReturn);
41529d79ce1655b Roman Li 2022-06-28  2092  	double IdealDRAMBandwidthPerState = v->DRAMSpeedPerState[v->VoltageLevel] * v->NumberOfChannels * v->DRAMChannelWidth;
41529d79ce1655b Roman Li 2022-06-28  2093  
41529d79ce1655b Roman Li 2022-06-28  2094  	if (v->HostVMEnable != true) {
41529d79ce1655b Roman Li 2022-06-28  2095  		v->ReturnBW = dml_min(
41529d79ce1655b Roman Li 2022-06-28  2096  				IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
41529d79ce1655b Roman Li 2022-06-28  2097  				IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelDataOnly / 100.0);
41529d79ce1655b Roman Li 2022-06-28  2098  	} else {
41529d79ce1655b Roman Li 2022-06-28  2099  		v->ReturnBW = dml_min(
41529d79ce1655b Roman Li 2022-06-28  2100  				IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
41529d79ce1655b Roman Li 2022-06-28  2101  				IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelMixedWithVMData / 100.0);
41529d79ce1655b Roman Li 2022-06-28  2102  	}
41529d79ce1655b Roman Li 2022-06-28  2103  	}
41529d79ce1655b Roman Li 2022-06-28  2104  	/* End DAL custom code */
41529d79ce1655b Roman Li 2022-06-28  2105  
41529d79ce1655b Roman Li 2022-06-28  2106  	// DISPCLK and DPPCLK Calculation
41529d79ce1655b Roman Li 2022-06-28  2107  	//
41529d79ce1655b Roman Li 2022-06-28  2108  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2109  		if (v->WritebackEnable[k]) {
41529d79ce1655b Roman Li 2022-06-28  2110  			v->WritebackDISPCLK = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2111  					v->WritebackDISPCLK,
41529d79ce1655b Roman Li 2022-06-28  2112  					dml314_CalculateWriteBackDISPCLK(
41529d79ce1655b Roman Li 2022-06-28  2113  							v->WritebackPixelFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2114  							v->PixelClock[k],
41529d79ce1655b Roman Li 2022-06-28  2115  							v->WritebackHRatio[k],
41529d79ce1655b Roman Li 2022-06-28  2116  							v->WritebackVRatio[k],
41529d79ce1655b Roman Li 2022-06-28  2117  							v->WritebackHTaps[k],
41529d79ce1655b Roman Li 2022-06-28  2118  							v->WritebackVTaps[k],
41529d79ce1655b Roman Li 2022-06-28  2119  							v->WritebackSourceWidth[k],
41529d79ce1655b Roman Li 2022-06-28  2120  							v->WritebackDestinationWidth[k],
41529d79ce1655b Roman Li 2022-06-28  2121  							v->HTotal[k],
41529d79ce1655b Roman Li 2022-06-28  2122  							v->WritebackLineBufferSize));
41529d79ce1655b Roman Li 2022-06-28  2123  		}
41529d79ce1655b Roman Li 2022-06-28  2124  	}
41529d79ce1655b Roman Li 2022-06-28  2125  
41529d79ce1655b Roman Li 2022-06-28  2126  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2127  		if (v->HRatio[k] > 1) {
41529d79ce1655b Roman Li 2022-06-28  2128  			v->PSCL_THROUGHPUT_LUMA[k] = dml_min(
41529d79ce1655b Roman Li 2022-06-28  2129  					v->MaxDCHUBToPSCLThroughput,
41529d79ce1655b Roman Li 2022-06-28  2130  					v->MaxPSCLToLBThroughput * v->HRatio[k] / dml_ceil(v->htaps[k] / 6.0, 1));
41529d79ce1655b Roman Li 2022-06-28  2131  		} else {
41529d79ce1655b Roman Li 2022-06-28  2132  			v->PSCL_THROUGHPUT_LUMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
41529d79ce1655b Roman Li 2022-06-28  2133  		}
41529d79ce1655b Roman Li 2022-06-28  2134  
41529d79ce1655b Roman Li 2022-06-28  2135  		v->DPPCLKUsingSingleDPPLuma = v->PixelClock[k]
41529d79ce1655b Roman Li 2022-06-28  2136  				* dml_max(
41529d79ce1655b Roman Li 2022-06-28  2137  						v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
41529d79ce1655b Roman Li 2022-06-28  2138  						dml_max(v->HRatio[k] * v->VRatio[k] / v->PSCL_THROUGHPUT_LUMA[k], 1.0));
41529d79ce1655b Roman Li 2022-06-28  2139  
41529d79ce1655b Roman Li 2022-06-28  2140  		if ((v->htaps[k] > 6 || v->vtaps[k] > 6) && v->DPPCLKUsingSingleDPPLuma < 2 * v->PixelClock[k]) {
41529d79ce1655b Roman Li 2022-06-28  2141  			v->DPPCLKUsingSingleDPPLuma = 2 * v->PixelClock[k];
41529d79ce1655b Roman Li 2022-06-28  2142  		}
41529d79ce1655b Roman Li 2022-06-28  2143  
41529d79ce1655b Roman Li 2022-06-28  2144  		if ((v->SourcePixelFormat[k] != dm_420_8 && v->SourcePixelFormat[k] != dm_420_10 && v->SourcePixelFormat[k] != dm_420_12
41529d79ce1655b Roman Li 2022-06-28  2145  				&& v->SourcePixelFormat[k] != dm_rgbe_alpha)) {
41529d79ce1655b Roman Li 2022-06-28  2146  			v->PSCL_THROUGHPUT_CHROMA[k] = 0.0;
41529d79ce1655b Roman Li 2022-06-28  2147  			v->DPPCLKUsingSingleDPP[k] = v->DPPCLKUsingSingleDPPLuma;
41529d79ce1655b Roman Li 2022-06-28  2148  		} else {
41529d79ce1655b Roman Li 2022-06-28  2149  			if (v->HRatioChroma[k] > 1) {
41529d79ce1655b Roman Li 2022-06-28  2150  				v->PSCL_THROUGHPUT_CHROMA[k] = dml_min(
41529d79ce1655b Roman Li 2022-06-28  2151  						v->MaxDCHUBToPSCLThroughput,
41529d79ce1655b Roman Li 2022-06-28  2152  						v->MaxPSCLToLBThroughput * v->HRatioChroma[k] / dml_ceil(v->HTAPsChroma[k] / 6.0, 1.0));
41529d79ce1655b Roman Li 2022-06-28  2153  			} else {
41529d79ce1655b Roman Li 2022-06-28  2154  				v->PSCL_THROUGHPUT_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
41529d79ce1655b Roman Li 2022-06-28  2155  			}
41529d79ce1655b Roman Li 2022-06-28  2156  			v->DPPCLKUsingSingleDPPChroma = v->PixelClock[k]
41529d79ce1655b Roman Li 2022-06-28  2157  					* dml_max3(
41529d79ce1655b Roman Li 2022-06-28  2158  							v->VTAPsChroma[k] / 6.0 * dml_min(1.0, v->HRatioChroma[k]),
41529d79ce1655b Roman Li 2022-06-28  2159  							v->HRatioChroma[k] * v->VRatioChroma[k] / v->PSCL_THROUGHPUT_CHROMA[k],
41529d79ce1655b Roman Li 2022-06-28  2160  							1.0);
41529d79ce1655b Roman Li 2022-06-28  2161  
41529d79ce1655b Roman Li 2022-06-28  2162  			if ((v->HTAPsChroma[k] > 6 || v->VTAPsChroma[k] > 6) && v->DPPCLKUsingSingleDPPChroma < 2 * v->PixelClock[k]) {
41529d79ce1655b Roman Li 2022-06-28  2163  				v->DPPCLKUsingSingleDPPChroma = 2 * v->PixelClock[k];
41529d79ce1655b Roman Li 2022-06-28  2164  			}
41529d79ce1655b Roman Li 2022-06-28  2165  
41529d79ce1655b Roman Li 2022-06-28  2166  			v->DPPCLKUsingSingleDPP[k] = dml_max(v->DPPCLKUsingSingleDPPLuma, v->DPPCLKUsingSingleDPPChroma);
41529d79ce1655b Roman Li 2022-06-28  2167  		}
41529d79ce1655b Roman Li 2022-06-28  2168  	}
41529d79ce1655b Roman Li 2022-06-28  2169  
41529d79ce1655b Roman Li 2022-06-28  2170  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2171  		if (v->BlendingAndTiming[k] != k)
41529d79ce1655b Roman Li 2022-06-28  2172  			continue;
41529d79ce1655b Roman Li 2022-06-28  2173  		if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1) {
41529d79ce1655b Roman Li 2022-06-28  2174  			v->DISPCLKWithRamping = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2175  					v->DISPCLKWithRamping,
41529d79ce1655b Roman Li 2022-06-28  2176  					v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
41529d79ce1655b Roman Li 2022-06-28  2177  							* (1 + v->DISPCLKRampingMargin / 100));
41529d79ce1655b Roman Li 2022-06-28  2178  			v->DISPCLKWithoutRamping = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2179  					v->DISPCLKWithoutRamping,
41529d79ce1655b Roman Li 2022-06-28  2180  					v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
41529d79ce1655b Roman Li 2022-06-28  2181  		} else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1) {
41529d79ce1655b Roman Li 2022-06-28  2182  			v->DISPCLKWithRamping = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2183  					v->DISPCLKWithRamping,
41529d79ce1655b Roman Li 2022-06-28  2184  					v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
41529d79ce1655b Roman Li 2022-06-28  2185  							* (1 + v->DISPCLKRampingMargin / 100));
41529d79ce1655b Roman Li 2022-06-28  2186  			v->DISPCLKWithoutRamping = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2187  					v->DISPCLKWithoutRamping,
41529d79ce1655b Roman Li 2022-06-28  2188  					v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
41529d79ce1655b Roman Li 2022-06-28  2189  		} else {
41529d79ce1655b Roman Li 2022-06-28  2190  			v->DISPCLKWithRamping = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2191  					v->DISPCLKWithRamping,
41529d79ce1655b Roman Li 2022-06-28  2192  					v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100) * (1 + v->DISPCLKRampingMargin / 100));
41529d79ce1655b Roman Li 2022-06-28  2193  			v->DISPCLKWithoutRamping = dml_max(
41529d79ce1655b Roman Li 2022-06-28  2194  					v->DISPCLKWithoutRamping,
41529d79ce1655b Roman Li 2022-06-28  2195  					v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
41529d79ce1655b Roman Li 2022-06-28  2196  		}
41529d79ce1655b Roman Li 2022-06-28  2197  	}
41529d79ce1655b Roman Li 2022-06-28  2198  
41529d79ce1655b Roman Li 2022-06-28  2199  	v->DISPCLKWithRamping = dml_max(v->DISPCLKWithRamping, v->WritebackDISPCLK);
41529d79ce1655b Roman Li 2022-06-28  2200  	v->DISPCLKWithoutRamping = dml_max(v->DISPCLKWithoutRamping, v->WritebackDISPCLK);
41529d79ce1655b Roman Li 2022-06-28  2201  
41529d79ce1655b Roman Li 2022-06-28  2202  	ASSERT(v->DISPCLKDPPCLKVCOSpeed != 0);
41529d79ce1655b Roman Li 2022-06-28  2203  	v->DISPCLKWithRampingRoundedToDFSGranularity = RoundToDFSGranularityUp(v->DISPCLKWithRamping, v->DISPCLKDPPCLKVCOSpeed);
41529d79ce1655b Roman Li 2022-06-28  2204  	v->DISPCLKWithoutRampingRoundedToDFSGranularity = RoundToDFSGranularityUp(v->DISPCLKWithoutRamping, v->DISPCLKDPPCLKVCOSpeed);
41529d79ce1655b Roman Li 2022-06-28  2205  	v->MaxDispclkRoundedToDFSGranularity = RoundToDFSGranularityDown(
41529d79ce1655b Roman Li 2022-06-28  2206  			v->soc.clock_limits[v->soc.num_states - 1].dispclk_mhz,
41529d79ce1655b Roman Li 2022-06-28  2207  			v->DISPCLKDPPCLKVCOSpeed);
41529d79ce1655b Roman Li 2022-06-28  2208  	if (v->DISPCLKWithoutRampingRoundedToDFSGranularity > v->MaxDispclkRoundedToDFSGranularity) {
41529d79ce1655b Roman Li 2022-06-28  2209  		v->DISPCLK_calculated = v->DISPCLKWithoutRampingRoundedToDFSGranularity;
41529d79ce1655b Roman Li 2022-06-28  2210  	} else if (v->DISPCLKWithRampingRoundedToDFSGranularity > v->MaxDispclkRoundedToDFSGranularity) {
41529d79ce1655b Roman Li 2022-06-28  2211  		v->DISPCLK_calculated = v->MaxDispclkRoundedToDFSGranularity;
41529d79ce1655b Roman Li 2022-06-28  2212  	} else {
41529d79ce1655b Roman Li 2022-06-28  2213  		v->DISPCLK_calculated = v->DISPCLKWithRampingRoundedToDFSGranularity;
41529d79ce1655b Roman Li 2022-06-28  2214  	}
41529d79ce1655b Roman Li 2022-06-28  2215  	v->DISPCLK = v->DISPCLK_calculated;
41529d79ce1655b Roman Li 2022-06-28  2216  	DTRACE("   dispclk_mhz (calculated) = %f", v->DISPCLK_calculated);
41529d79ce1655b Roman Li 2022-06-28  2217  
41529d79ce1655b Roman Li 2022-06-28  2218  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2219  		v->DPPCLK_calculated[k] = v->DPPCLKUsingSingleDPP[k] / v->DPPPerPlane[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
41529d79ce1655b Roman Li 2022-06-28  2220  		v->GlobalDPPCLK = dml_max(v->GlobalDPPCLK, v->DPPCLK_calculated[k]);
41529d79ce1655b Roman Li 2022-06-28  2221  	}
41529d79ce1655b Roman Li 2022-06-28  2222  	v->GlobalDPPCLK = RoundToDFSGranularityUp(v->GlobalDPPCLK, v->DISPCLKDPPCLKVCOSpeed);
41529d79ce1655b Roman Li 2022-06-28  2223  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2224  		v->DPPCLK_calculated[k] = v->GlobalDPPCLK / 255 * dml_ceil(v->DPPCLK_calculated[k] * 255.0 / v->GlobalDPPCLK, 1);
41529d79ce1655b Roman Li 2022-06-28  2225  		DTRACE("   dppclk_mhz[%i] (calculated) = %f", k, v->DPPCLK_calculated[k]);
41529d79ce1655b Roman Li 2022-06-28  2226  	}
41529d79ce1655b Roman Li 2022-06-28  2227  
41529d79ce1655b Roman Li 2022-06-28  2228  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2229  		v->DPPCLK[k] = v->DPPCLK_calculated[k];
41529d79ce1655b Roman Li 2022-06-28  2230  	}
41529d79ce1655b Roman Li 2022-06-28  2231  
41529d79ce1655b Roman Li 2022-06-28  2232  	// Urgent and B P-State/DRAM Clock Change Watermark
41529d79ce1655b Roman Li 2022-06-28  2233  	DTRACE("   dcfclk_mhz         = %f", v->DCFCLK);
41529d79ce1655b Roman Li 2022-06-28  2234  	DTRACE("   return_bus_bw      = %f", v->ReturnBW);
41529d79ce1655b Roman Li 2022-06-28  2235  
41529d79ce1655b Roman Li 2022-06-28  2236  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2237  		CalculateBytePerPixelAnd256BBlockSizes(
41529d79ce1655b Roman Li 2022-06-28  2238  				v->SourcePixelFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2239  				v->SurfaceTiling[k],
41529d79ce1655b Roman Li 2022-06-28  2240  				&v->BytePerPixelY[k],
41529d79ce1655b Roman Li 2022-06-28  2241  				&v->BytePerPixelC[k],
41529d79ce1655b Roman Li 2022-06-28  2242  				&v->BytePerPixelDETY[k],
41529d79ce1655b Roman Li 2022-06-28  2243  				&v->BytePerPixelDETC[k],
41529d79ce1655b Roman Li 2022-06-28  2244  				&v->BlockHeight256BytesY[k],
41529d79ce1655b Roman Li 2022-06-28  2245  				&v->BlockHeight256BytesC[k],
41529d79ce1655b Roman Li 2022-06-28  2246  				&v->BlockWidth256BytesY[k],
41529d79ce1655b Roman Li 2022-06-28  2247  				&v->BlockWidth256BytesC[k]);
41529d79ce1655b Roman Li 2022-06-28  2248  	}
41529d79ce1655b Roman Li 2022-06-28  2249  
41529d79ce1655b Roman Li 2022-06-28  2250  	CalculateSwathWidth(
41529d79ce1655b Roman Li 2022-06-28  2251  			false,
41529d79ce1655b Roman Li 2022-06-28  2252  			v->NumberOfActivePlanes,
41529d79ce1655b Roman Li 2022-06-28  2253  			v->SourcePixelFormat,
41529d79ce1655b Roman Li 2022-06-28  2254  			v->SourceScan,
41529d79ce1655b Roman Li 2022-06-28  2255  			v->ViewportWidth,
41529d79ce1655b Roman Li 2022-06-28  2256  			v->ViewportHeight,
41529d79ce1655b Roman Li 2022-06-28  2257  			v->SurfaceWidthY,
41529d79ce1655b Roman Li 2022-06-28  2258  			v->SurfaceWidthC,
41529d79ce1655b Roman Li 2022-06-28  2259  			v->SurfaceHeightY,
41529d79ce1655b Roman Li 2022-06-28  2260  			v->SurfaceHeightC,
41529d79ce1655b Roman Li 2022-06-28  2261  			v->ODMCombineEnabled,
41529d79ce1655b Roman Li 2022-06-28  2262  			v->BytePerPixelY,
41529d79ce1655b Roman Li 2022-06-28  2263  			v->BytePerPixelC,
41529d79ce1655b Roman Li 2022-06-28  2264  			v->BlockHeight256BytesY,
41529d79ce1655b Roman Li 2022-06-28  2265  			v->BlockHeight256BytesC,
41529d79ce1655b Roman Li 2022-06-28  2266  			v->BlockWidth256BytesY,
41529d79ce1655b Roman Li 2022-06-28  2267  			v->BlockWidth256BytesC,
41529d79ce1655b Roman Li 2022-06-28  2268  			v->BlendingAndTiming,
41529d79ce1655b Roman Li 2022-06-28  2269  			v->HActive,
41529d79ce1655b Roman Li 2022-06-28  2270  			v->HRatio,
41529d79ce1655b Roman Li 2022-06-28  2271  			v->DPPPerPlane,
41529d79ce1655b Roman Li 2022-06-28  2272  			v->SwathWidthSingleDPPY,
41529d79ce1655b Roman Li 2022-06-28  2273  			v->SwathWidthSingleDPPC,
41529d79ce1655b Roman Li 2022-06-28  2274  			v->SwathWidthY,
41529d79ce1655b Roman Li 2022-06-28  2275  			v->SwathWidthC,
41529d79ce1655b Roman Li 2022-06-28  2276  			v->dummyinteger3,
41529d79ce1655b Roman Li 2022-06-28  2277  			v->dummyinteger4,
41529d79ce1655b Roman Li 2022-06-28  2278  			v->swath_width_luma_ub,
41529d79ce1655b Roman Li 2022-06-28  2279  			v->swath_width_chroma_ub);
41529d79ce1655b Roman Li 2022-06-28  2280  
41529d79ce1655b Roman Li 2022-06-28  2281  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2282  		v->ReadBandwidthPlaneLuma[k] = v->SwathWidthSingleDPPY[k] * v->BytePerPixelY[k] / (v->HTotal[k] / v->PixelClock[k])
41529d79ce1655b Roman Li 2022-06-28  2283  				* v->VRatio[k];
41529d79ce1655b Roman Li 2022-06-28  2284  		v->ReadBandwidthPlaneChroma[k] = v->SwathWidthSingleDPPC[k] * v->BytePerPixelC[k] / (v->HTotal[k] / v->PixelClock[k])
41529d79ce1655b Roman Li 2022-06-28  2285  				* v->VRatioChroma[k];
41529d79ce1655b Roman Li 2022-06-28  2286  		DTRACE("   read_bw[%i] = %fBps", k, v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k]);
41529d79ce1655b Roman Li 2022-06-28  2287  	}
41529d79ce1655b Roman Li 2022-06-28  2288  
41529d79ce1655b Roman Li 2022-06-28  2289  	// DCFCLK Deep Sleep
41529d79ce1655b Roman Li 2022-06-28  2290  	CalculateDCFCLKDeepSleep(
41529d79ce1655b Roman Li 2022-06-28  2291  			mode_lib,
41529d79ce1655b Roman Li 2022-06-28  2292  			v->NumberOfActivePlanes,
41529d79ce1655b Roman Li 2022-06-28  2293  			v->BytePerPixelY,
41529d79ce1655b Roman Li 2022-06-28  2294  			v->BytePerPixelC,
41529d79ce1655b Roman Li 2022-06-28  2295  			v->VRatio,
41529d79ce1655b Roman Li 2022-06-28  2296  			v->VRatioChroma,
41529d79ce1655b Roman Li 2022-06-28  2297  			v->SwathWidthY,
41529d79ce1655b Roman Li 2022-06-28  2298  			v->SwathWidthC,
41529d79ce1655b Roman Li 2022-06-28  2299  			v->DPPPerPlane,
41529d79ce1655b Roman Li 2022-06-28  2300  			v->HRatio,
41529d79ce1655b Roman Li 2022-06-28  2301  			v->HRatioChroma,
41529d79ce1655b Roman Li 2022-06-28  2302  			v->PixelClock,
41529d79ce1655b Roman Li 2022-06-28  2303  			v->PSCL_THROUGHPUT_LUMA,
41529d79ce1655b Roman Li 2022-06-28  2304  			v->PSCL_THROUGHPUT_CHROMA,
41529d79ce1655b Roman Li 2022-06-28  2305  			v->DPPCLK,
41529d79ce1655b Roman Li 2022-06-28  2306  			v->ReadBandwidthPlaneLuma,
41529d79ce1655b Roman Li 2022-06-28  2307  			v->ReadBandwidthPlaneChroma,
41529d79ce1655b Roman Li 2022-06-28  2308  			v->ReturnBusWidth,
41529d79ce1655b Roman Li 2022-06-28  2309  			&v->DCFCLKDeepSleep);
41529d79ce1655b Roman Li 2022-06-28  2310  
41529d79ce1655b Roman Li 2022-06-28  2311  	// DSCCLK
41529d79ce1655b Roman Li 2022-06-28  2312  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2313  		if ((v->BlendingAndTiming[k] != k) || !v->DSCEnabled[k]) {
41529d79ce1655b Roman Li 2022-06-28  2314  			v->DSCCLK_calculated[k] = 0.0;
41529d79ce1655b Roman Li 2022-06-28  2315  		} else {
41529d79ce1655b Roman Li 2022-06-28  2316  			if (v->OutputFormat[k] == dm_420)
41529d79ce1655b Roman Li 2022-06-28  2317  				v->DSCFormatFactor = 2;
41529d79ce1655b Roman Li 2022-06-28  2318  			else if (v->OutputFormat[k] == dm_444)
41529d79ce1655b Roman Li 2022-06-28  2319  				v->DSCFormatFactor = 1;
41529d79ce1655b Roman Li 2022-06-28  2320  			else if (v->OutputFormat[k] == dm_n422)
41529d79ce1655b Roman Li 2022-06-28  2321  				v->DSCFormatFactor = 2;
41529d79ce1655b Roman Li 2022-06-28  2322  			else
41529d79ce1655b Roman Li 2022-06-28  2323  				v->DSCFormatFactor = 1;
41529d79ce1655b Roman Li 2022-06-28  2324  			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
41529d79ce1655b Roman Li 2022-06-28  2325  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 12 / v->DSCFormatFactor
41529d79ce1655b Roman Li 2022-06-28  2326  						/ (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
41529d79ce1655b Roman Li 2022-06-28  2327  			else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1)
41529d79ce1655b Roman Li 2022-06-28  2328  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 6 / v->DSCFormatFactor
41529d79ce1655b Roman Li 2022-06-28  2329  						/ (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
41529d79ce1655b Roman Li 2022-06-28  2330  			else
41529d79ce1655b Roman Li 2022-06-28  2331  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 3 / v->DSCFormatFactor
41529d79ce1655b Roman Li 2022-06-28  2332  						/ (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
41529d79ce1655b Roman Li 2022-06-28  2333  		}
41529d79ce1655b Roman Li 2022-06-28  2334  	}
41529d79ce1655b Roman Li 2022-06-28  2335  
41529d79ce1655b Roman Li 2022-06-28  2336  	// DSC Delay
41529d79ce1655b Roman Li 2022-06-28  2337  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2338  		double BPP = v->OutputBpp[k];
41529d79ce1655b Roman Li 2022-06-28  2339  
41529d79ce1655b Roman Li 2022-06-28  2340  		if (v->DSCEnabled[k] && BPP != 0) {
41529d79ce1655b Roman Li 2022-06-28  2341  			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_disabled) {
41529d79ce1655b Roman Li 2022-06-28  2342  				v->DSCDelay[k] = dscceComputeDelay(
41529d79ce1655b Roman Li 2022-06-28  2343  						v->DSCInputBitPerComponent[k],
41529d79ce1655b Roman Li 2022-06-28  2344  						BPP,
41529d79ce1655b Roman Li 2022-06-28  2345  						dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
41529d79ce1655b Roman Li 2022-06-28  2346  						v->NumberOfDSCSlices[k],
41529d79ce1655b Roman Li 2022-06-28  2347  						v->OutputFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2348  						v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]);
41529d79ce1655b Roman Li 2022-06-28  2349  			} else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1) {
41529d79ce1655b Roman Li 2022-06-28  2350  				v->DSCDelay[k] = 2
41529d79ce1655b Roman Li 2022-06-28  2351  						* (dscceComputeDelay(
41529d79ce1655b Roman Li 2022-06-28  2352  								v->DSCInputBitPerComponent[k],
41529d79ce1655b Roman Li 2022-06-28  2353  								BPP,
41529d79ce1655b Roman Li 2022-06-28  2354  								dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
41529d79ce1655b Roman Li 2022-06-28  2355  								v->NumberOfDSCSlices[k] / 2.0,
41529d79ce1655b Roman Li 2022-06-28  2356  								v->OutputFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2357  								v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
41529d79ce1655b Roman Li 2022-06-28  2358  			} else {
41529d79ce1655b Roman Li 2022-06-28  2359  				v->DSCDelay[k] = 4
41529d79ce1655b Roman Li 2022-06-28  2360  						* (dscceComputeDelay(
41529d79ce1655b Roman Li 2022-06-28  2361  								v->DSCInputBitPerComponent[k],
41529d79ce1655b Roman Li 2022-06-28  2362  								BPP,
41529d79ce1655b Roman Li 2022-06-28  2363  								dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
41529d79ce1655b Roman Li 2022-06-28  2364  								v->NumberOfDSCSlices[k] / 4.0,
41529d79ce1655b Roman Li 2022-06-28  2365  								v->OutputFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2366  								v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
41529d79ce1655b Roman Li 2022-06-28  2367  			}
41529d79ce1655b Roman Li 2022-06-28  2368  			v->DSCDelay[k] = v->DSCDelay[k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
41529d79ce1655b Roman Li 2022-06-28  2369  		} else {
41529d79ce1655b Roman Li 2022-06-28  2370  			v->DSCDelay[k] = 0;
41529d79ce1655b Roman Li 2022-06-28  2371  		}
41529d79ce1655b Roman Li 2022-06-28  2372  	}
41529d79ce1655b Roman Li 2022-06-28  2373  
41529d79ce1655b Roman Li 2022-06-28  2374  	for (k = 0; k < v->NumberOfActivePlanes; ++k)
41529d79ce1655b Roman Li 2022-06-28  2375  		for (j = 0; j < v->NumberOfActivePlanes; ++j) // NumberOfPlanes
41529d79ce1655b Roman Li 2022-06-28  2376  			if (j != k && v->BlendingAndTiming[k] == j && v->DSCEnabled[j])
41529d79ce1655b Roman Li 2022-06-28  2377  				v->DSCDelay[k] = v->DSCDelay[j];
41529d79ce1655b Roman Li 2022-06-28  2378  
41529d79ce1655b Roman Li 2022-06-28  2379  	// Prefetch
41529d79ce1655b Roman Li 2022-06-28  2380  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2381  		unsigned int PDEAndMetaPTEBytesFrameY;
41529d79ce1655b Roman Li 2022-06-28  2382  		unsigned int PixelPTEBytesPerRowY;
41529d79ce1655b Roman Li 2022-06-28  2383  		unsigned int MetaRowByteY;
41529d79ce1655b Roman Li 2022-06-28  2384  		unsigned int MetaRowByteC;
41529d79ce1655b Roman Li 2022-06-28  2385  		unsigned int PDEAndMetaPTEBytesFrameC;
41529d79ce1655b Roman Li 2022-06-28  2386  		unsigned int PixelPTEBytesPerRowC;
41529d79ce1655b Roman Li 2022-06-28  2387  		bool PTEBufferSizeNotExceededY;
41529d79ce1655b Roman Li 2022-06-28  2388  		bool PTEBufferSizeNotExceededC;
41529d79ce1655b Roman Li 2022-06-28  2389  
41529d79ce1655b Roman Li 2022-06-28  2390  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12
41529d79ce1655b Roman Li 2022-06-28  2391  				|| v->SourcePixelFormat[k] == dm_rgbe_alpha) {
41529d79ce1655b Roman Li 2022-06-28  2392  			if ((v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) && v->SourceScan[k] != dm_vert) {
41529d79ce1655b Roman Li 2022-06-28  2393  				v->PTEBufferSizeInRequestsForLuma = (v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma) / 2;
41529d79ce1655b Roman Li 2022-06-28  2394  				v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsForLuma;
41529d79ce1655b Roman Li 2022-06-28  2395  			} else {
41529d79ce1655b Roman Li 2022-06-28  2396  				v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma;
41529d79ce1655b Roman Li 2022-06-28  2397  				v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsChroma;
41529d79ce1655b Roman Li 2022-06-28  2398  			}
41529d79ce1655b Roman Li 2022-06-28  2399  
41529d79ce1655b Roman Li 2022-06-28  2400  			PDEAndMetaPTEBytesFrameC = CalculateVMAndRowBytes(
41529d79ce1655b Roman Li 2022-06-28  2401  					mode_lib,
41529d79ce1655b Roman Li 2022-06-28  2402  					v->DCCEnable[k],
41529d79ce1655b Roman Li 2022-06-28  2403  					v->BlockHeight256BytesC[k],
41529d79ce1655b Roman Li 2022-06-28  2404  					v->BlockWidth256BytesC[k],
41529d79ce1655b Roman Li 2022-06-28  2405  					v->SourcePixelFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2406  					v->SurfaceTiling[k],
41529d79ce1655b Roman Li 2022-06-28  2407  					v->BytePerPixelC[k],
41529d79ce1655b Roman Li 2022-06-28  2408  					v->SourceScan[k],
41529d79ce1655b Roman Li 2022-06-28  2409  					v->SwathWidthC[k],
41529d79ce1655b Roman Li 2022-06-28  2410  					v->ViewportHeightChroma[k],
41529d79ce1655b Roman Li 2022-06-28  2411  					v->GPUVMEnable,
41529d79ce1655b Roman Li 2022-06-28  2412  					v->HostVMEnable,
41529d79ce1655b Roman Li 2022-06-28  2413  					v->HostVMMaxNonCachedPageTableLevels,
41529d79ce1655b Roman Li 2022-06-28  2414  					v->GPUVMMinPageSize,
41529d79ce1655b Roman Li 2022-06-28  2415  					v->HostVMMinPageSize,
41529d79ce1655b Roman Li 2022-06-28  2416  					v->PTEBufferSizeInRequestsForChroma,
41529d79ce1655b Roman Li 2022-06-28  2417  					v->PitchC[k],
41529d79ce1655b Roman Li 2022-06-28  2418  					v->DCCMetaPitchC[k],
41529d79ce1655b Roman Li 2022-06-28  2419  					&v->MacroTileWidthC[k],
41529d79ce1655b Roman Li 2022-06-28  2420  					&MetaRowByteC,
41529d79ce1655b Roman Li 2022-06-28  2421  					&PixelPTEBytesPerRowC,
41529d79ce1655b Roman Li 2022-06-28  2422  					&PTEBufferSizeNotExceededC,
41529d79ce1655b Roman Li 2022-06-28  2423  					&v->dpte_row_width_chroma_ub[k],
41529d79ce1655b Roman Li 2022-06-28  2424  					&v->dpte_row_height_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2425  					&v->meta_req_width_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2426  					&v->meta_req_height_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2427  					&v->meta_row_width_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2428  					&v->meta_row_height_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2429  					&v->dummyinteger1,
41529d79ce1655b Roman Li 2022-06-28  2430  					&v->dummyinteger2,
41529d79ce1655b Roman Li 2022-06-28  2431  					&v->PixelPTEReqWidthC[k],
41529d79ce1655b Roman Li 2022-06-28  2432  					&v->PixelPTEReqHeightC[k],
41529d79ce1655b Roman Li 2022-06-28  2433  					&v->PTERequestSizeC[k],
41529d79ce1655b Roman Li 2022-06-28  2434  					&v->dpde0_bytes_per_frame_ub_c[k],
41529d79ce1655b Roman Li 2022-06-28  2435  					&v->meta_pte_bytes_per_frame_ub_c[k]);
41529d79ce1655b Roman Li 2022-06-28  2436  
41529d79ce1655b Roman Li 2022-06-28  2437  			v->PrefetchSourceLinesC[k] = CalculatePrefetchSourceLines(
41529d79ce1655b Roman Li 2022-06-28  2438  					mode_lib,
41529d79ce1655b Roman Li 2022-06-28  2439  					v->VRatioChroma[k],
41529d79ce1655b Roman Li 2022-06-28  2440  					v->VTAPsChroma[k],
41529d79ce1655b Roman Li 2022-06-28  2441  					v->Interlace[k],
41529d79ce1655b Roman Li 2022-06-28  2442  					v->ProgressiveToInterlaceUnitInOPP,
41529d79ce1655b Roman Li 2022-06-28  2443  					v->SwathHeightC[k],
41529d79ce1655b Roman Li 2022-06-28  2444  					v->ViewportYStartC[k],
41529d79ce1655b Roman Li 2022-06-28  2445  					&v->VInitPreFillC[k],
41529d79ce1655b Roman Li 2022-06-28  2446  					&v->MaxNumSwathC[k]);
41529d79ce1655b Roman Li 2022-06-28  2447  		} else {
41529d79ce1655b Roman Li 2022-06-28  2448  			v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma;
41529d79ce1655b Roman Li 2022-06-28  2449  			v->PTEBufferSizeInRequestsForChroma = 0;
41529d79ce1655b Roman Li 2022-06-28  2450  			PixelPTEBytesPerRowC = 0;
41529d79ce1655b Roman Li 2022-06-28  2451  			PDEAndMetaPTEBytesFrameC = 0;
41529d79ce1655b Roman Li 2022-06-28  2452  			MetaRowByteC = 0;
41529d79ce1655b Roman Li 2022-06-28  2453  			v->MaxNumSwathC[k] = 0;
41529d79ce1655b Roman Li 2022-06-28  2454  			v->PrefetchSourceLinesC[k] = 0;
41529d79ce1655b Roman Li 2022-06-28  2455  		}
41529d79ce1655b Roman Li 2022-06-28  2456  
41529d79ce1655b Roman Li 2022-06-28  2457  		PDEAndMetaPTEBytesFrameY = CalculateVMAndRowBytes(
41529d79ce1655b Roman Li 2022-06-28  2458  				mode_lib,
41529d79ce1655b Roman Li 2022-06-28  2459  				v->DCCEnable[k],
41529d79ce1655b Roman Li 2022-06-28  2460  				v->BlockHeight256BytesY[k],
41529d79ce1655b Roman Li 2022-06-28  2461  				v->BlockWidth256BytesY[k],
41529d79ce1655b Roman Li 2022-06-28  2462  				v->SourcePixelFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2463  				v->SurfaceTiling[k],
41529d79ce1655b Roman Li 2022-06-28  2464  				v->BytePerPixelY[k],
41529d79ce1655b Roman Li 2022-06-28  2465  				v->SourceScan[k],
41529d79ce1655b Roman Li 2022-06-28  2466  				v->SwathWidthY[k],
41529d79ce1655b Roman Li 2022-06-28  2467  				v->ViewportHeight[k],
41529d79ce1655b Roman Li 2022-06-28  2468  				v->GPUVMEnable,
41529d79ce1655b Roman Li 2022-06-28  2469  				v->HostVMEnable,
41529d79ce1655b Roman Li 2022-06-28  2470  				v->HostVMMaxNonCachedPageTableLevels,
41529d79ce1655b Roman Li 2022-06-28  2471  				v->GPUVMMinPageSize,
41529d79ce1655b Roman Li 2022-06-28  2472  				v->HostVMMinPageSize,
41529d79ce1655b Roman Li 2022-06-28  2473  				v->PTEBufferSizeInRequestsForLuma,
41529d79ce1655b Roman Li 2022-06-28  2474  				v->PitchY[k],
41529d79ce1655b Roman Li 2022-06-28  2475  				v->DCCMetaPitchY[k],
41529d79ce1655b Roman Li 2022-06-28  2476  				&v->MacroTileWidthY[k],
41529d79ce1655b Roman Li 2022-06-28  2477  				&MetaRowByteY,
41529d79ce1655b Roman Li 2022-06-28  2478  				&PixelPTEBytesPerRowY,
41529d79ce1655b Roman Li 2022-06-28  2479  				&PTEBufferSizeNotExceededY,
41529d79ce1655b Roman Li 2022-06-28  2480  				&v->dpte_row_width_luma_ub[k],
41529d79ce1655b Roman Li 2022-06-28  2481  				&v->dpte_row_height[k],
41529d79ce1655b Roman Li 2022-06-28  2482  				&v->meta_req_width[k],
41529d79ce1655b Roman Li 2022-06-28  2483  				&v->meta_req_height[k],
41529d79ce1655b Roman Li 2022-06-28  2484  				&v->meta_row_width[k],
41529d79ce1655b Roman Li 2022-06-28  2485  				&v->meta_row_height[k],
41529d79ce1655b Roman Li 2022-06-28  2486  				&v->vm_group_bytes[k],
41529d79ce1655b Roman Li 2022-06-28  2487  				&v->dpte_group_bytes[k],
41529d79ce1655b Roman Li 2022-06-28  2488  				&v->PixelPTEReqWidthY[k],
41529d79ce1655b Roman Li 2022-06-28  2489  				&v->PixelPTEReqHeightY[k],
41529d79ce1655b Roman Li 2022-06-28  2490  				&v->PTERequestSizeY[k],
41529d79ce1655b Roman Li 2022-06-28  2491  				&v->dpde0_bytes_per_frame_ub_l[k],
41529d79ce1655b Roman Li 2022-06-28  2492  				&v->meta_pte_bytes_per_frame_ub_l[k]);
41529d79ce1655b Roman Li 2022-06-28  2493  
41529d79ce1655b Roman Li 2022-06-28  2494  		v->PrefetchSourceLinesY[k] = CalculatePrefetchSourceLines(
41529d79ce1655b Roman Li 2022-06-28  2495  				mode_lib,
41529d79ce1655b Roman Li 2022-06-28  2496  				v->VRatio[k],
41529d79ce1655b Roman Li 2022-06-28  2497  				v->vtaps[k],
41529d79ce1655b Roman Li 2022-06-28  2498  				v->Interlace[k],
41529d79ce1655b Roman Li 2022-06-28  2499  				v->ProgressiveToInterlaceUnitInOPP,
41529d79ce1655b Roman Li 2022-06-28  2500  				v->SwathHeightY[k],
41529d79ce1655b Roman Li 2022-06-28  2501  				v->ViewportYStartY[k],
41529d79ce1655b Roman Li 2022-06-28  2502  				&v->VInitPreFillY[k],
41529d79ce1655b Roman Li 2022-06-28  2503  				&v->MaxNumSwathY[k]);
41529d79ce1655b Roman Li 2022-06-28  2504  		v->PixelPTEBytesPerRow[k] = PixelPTEBytesPerRowY + PixelPTEBytesPerRowC;
41529d79ce1655b Roman Li 2022-06-28  2505  		v->PDEAndMetaPTEBytesFrame[k] = PDEAndMetaPTEBytesFrameY + PDEAndMetaPTEBytesFrameC;
41529d79ce1655b Roman Li 2022-06-28  2506  		v->MetaRowByte[k] = MetaRowByteY + MetaRowByteC;
41529d79ce1655b Roman Li 2022-06-28  2507  
41529d79ce1655b Roman Li 2022-06-28  2508  		CalculateRowBandwidth(
41529d79ce1655b Roman Li 2022-06-28  2509  				v->GPUVMEnable,
41529d79ce1655b Roman Li 2022-06-28  2510  				v->SourcePixelFormat[k],
41529d79ce1655b Roman Li 2022-06-28  2511  				v->VRatio[k],
41529d79ce1655b Roman Li 2022-06-28  2512  				v->VRatioChroma[k],
41529d79ce1655b Roman Li 2022-06-28  2513  				v->DCCEnable[k],
41529d79ce1655b Roman Li 2022-06-28  2514  				v->HTotal[k] / v->PixelClock[k],
41529d79ce1655b Roman Li 2022-06-28  2515  				MetaRowByteY,
41529d79ce1655b Roman Li 2022-06-28  2516  				MetaRowByteC,
41529d79ce1655b Roman Li 2022-06-28  2517  				v->meta_row_height[k],
41529d79ce1655b Roman Li 2022-06-28  2518  				v->meta_row_height_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2519  				PixelPTEBytesPerRowY,
41529d79ce1655b Roman Li 2022-06-28  2520  				PixelPTEBytesPerRowC,
41529d79ce1655b Roman Li 2022-06-28  2521  				v->dpte_row_height[k],
41529d79ce1655b Roman Li 2022-06-28  2522  				v->dpte_row_height_chroma[k],
41529d79ce1655b Roman Li 2022-06-28  2523  				&v->meta_row_bw[k],
41529d79ce1655b Roman Li 2022-06-28  2524  				&v->dpte_row_bw[k]);
41529d79ce1655b Roman Li 2022-06-28  2525  	}
41529d79ce1655b Roman Li 2022-06-28  2526  
41529d79ce1655b Roman Li 2022-06-28  2527  	v->TotalDCCActiveDPP = 0;
41529d79ce1655b Roman Li 2022-06-28  2528  	v->TotalActiveDPP = 0;
41529d79ce1655b Roman Li 2022-06-28  2529  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
41529d79ce1655b Roman Li 2022-06-28  2530  		v->TotalActiveDPP = v->TotalActiveDPP + v->DPPPerPlane[k];
41529d79ce1655b Roman Li 2022-06-28  2531  		if (v->DCCEnable[k])
41529d79ce1655b Roman Li 2022-06-28  2532  			v->TotalDCCActiveDPP = v->TotalDCCActiveDPP + v->DPPPerPlane[k];
41529d79ce1655b Roman Li 2022-06-28  2533  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12
41529d79ce1655b Roman Li 2022-06-28  2534  				|| v->SourcePixelFormat[k] == dm_rgbe_alpha)
41529d79ce1655b Roman Li 2022-06-28  2535  			NoChromaPlanes = false;
41529d79ce1655b Roman Li 2022-06-28  2536  	}
41529d79ce1655b Roman Li 2022-06-28  2537  
41529d79ce1655b Roman Li 2022-06-28  2538  	ReorderBytes = v->NumberOfChannels
41529d79ce1655b Roman Li 2022-06-28  2539  			* dml_max3(
41529d79ce1655b Roman Li 2022-06-28  2540  					v->UrgentOutOfOrderReturnPerChannelPixelDataOnly,
41529d79ce1655b Roman Li 2022-06-28  2541  					v->UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
41529d79ce1655b Roman Li 2022-06-28  2542  					v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
41529d79ce1655b Roman Li 2022-06-28  2543  
41529d79ce1655b Roman Li 2022-06-28  2544  	VMDataOnlyReturnBW = dml_min(
41529d79ce1655b Roman Li 2022-06-28  2545  			dml_min(v->ReturnBusWidth * v->DCFCLK, v->FabricClock * v->FabricDatapathToDCNDataReturn)
41529d79ce1655b Roman Li 2022-06-28  2546  					* v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
41529d79ce1655b Roman Li 2022-06-28  2547  			v->DRAMSpeed * v->NumberOfChannels * v->DRAMChannelWidth
41529d79ce1655b Roman Li 2022-06-28  2548  					* v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyVMDataOnly / 100.0);
41529d79ce1655b Roman Li 2022-06-28  2549  

:::::: The code at line 2072 was first introduced by commit
:::::: 41529d79ce1655bd7463c01d9813d0abb6fb08a4 drm/amd/display: Add DCN314 DML calculation support

:::::: TO: Roman Li <roman.li@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
