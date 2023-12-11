Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D680BFAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjLKC60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjLKC6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:58:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF3DA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702263510; x=1733799510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xirg3iVKLP98IJEWKpiz8nFvxlHWdkdRaPwoaJggaww=;
  b=CduVaBxQY0YABYUQDwlqa6l4u2lnxZ9kUcJH1KEIdy1Sq/f6P1NyQ94D
   daKygwOhrnAKZ13IBWbwb5c+AcPlceXVGX+QYKTvQBe/YAIPKGjbE1RZa
   3RAMfUP5CQS4YI0JoJaHKq9nLaveFlDNxKE68NEVAP6NvtXcKCbSMzc0l
   gULLvyxjBixoWJAmGcuioInGsokAunriOY48kQ1Xmp1GHstEx9jUh+rpK
   vZQWtLwFCt2wo1bWScetLL1LC55UBfk2iqWgDhKmQw8j8wywiGOr89C/E
   6A4a+ysMy8a+g4641hLnMZ73Ug/QlwdeqCp8xnCxC1xp4TyOGcXikU0gT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="379583322"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="379583322"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 18:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="772871275"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="772871275"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2023 18:58:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCWUz-000HZe-1a;
        Mon, 11 Dec 2023 02:58:25 +0000
Date:   Mon, 11 Dec 2023 10:57:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>
Subject: drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c:5421:19-20:
 WARNING comparing pointer to 0
Message-ID: <202312111026.2UUri4V7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: 7966f319c66d9468623c6a6a017ecbc0dd79be75 drm/amd/display: Introduce DML2
date:   9 weeks ago
config: loongarch-randconfig-r061-20231211 (https://download.01.org/0day-ci/archive/20231211/202312111026.2UUri4V7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231211/202312111026.2UUri4V7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312111026.2UUri4V7-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c:5421:19-20: WARNING comparing pointer to 0

vim +5421 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c

  5335	
  5336	static void CalculateOutputLink(
  5337			dml_float_t PHYCLKPerState,
  5338			dml_float_t PHYCLKD18PerState,
  5339			dml_float_t PHYCLKD32PerState,
  5340			dml_float_t Downspreading,
  5341			dml_bool_t IsMainSurfaceUsingTheIndicatedTiming,
  5342			enum dml_output_encoder_class Output,
  5343			enum dml_output_format_class OutputFormat,
  5344			dml_uint_t HTotal,
  5345			dml_uint_t HActive,
  5346			dml_float_t PixelClockBackEnd,
  5347			dml_float_t ForcedOutputLinkBPP,
  5348			dml_uint_t DSCInputBitPerComponent,
  5349			dml_uint_t NumberOfDSCSlices,
  5350			dml_float_t AudioSampleRate,
  5351			dml_uint_t AudioSampleLayout,
  5352			enum dml_odm_mode ODMModeNoDSC,
  5353			enum dml_odm_mode ODMModeDSC,
  5354			enum dml_dsc_enable DSCEnable,
  5355			dml_uint_t OutputLinkDPLanes,
  5356			enum dml_output_link_dp_rate OutputLinkDPRate,
  5357	
  5358			// Output
  5359			dml_bool_t *RequiresDSC,
  5360			dml_bool_t *RequiresFEC,
  5361			dml_float_t *OutBpp,
  5362			enum dml_output_type_and_rate__type *OutputType,
  5363			enum dml_output_type_and_rate__rate *OutputRate,
  5364			dml_uint_t *RequiredSlots)
  5365	{
  5366		dml_bool_t LinkDSCEnable;
  5367		dml_uint_t dummy;
  5368		*RequiresDSC = false;
  5369		*RequiresFEC = false;
  5370		*OutBpp = 0;
  5371	
  5372		*OutputType = dml_output_type_unknown;
  5373		*OutputRate = dml_output_rate_unknown;
  5374	
  5375		if (IsMainSurfaceUsingTheIndicatedTiming) {
  5376			if (Output == dml_hdmi) {
  5377				*RequiresDSC = false;
  5378				*RequiresFEC = false;
  5379				*OutBpp = TruncToValidBPP(dml_min(600, PHYCLKPerState) * 10, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, false, Output,
  5380										OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
  5381				//OutputTypeAndRate = "HDMI";
  5382				*OutputType = dml_output_type_hdmi;
  5383	
  5384			} else if (Output == dml_dp || Output == dml_dp2p0 || Output == dml_edp) {
  5385				if (DSCEnable == dml_dsc_enable) {
  5386					*RequiresDSC = true;
  5387					LinkDSCEnable = true;
  5388					if (Output == dml_dp || Output == dml_dp2p0) {
  5389						*RequiresFEC = true;
  5390					} else {
  5391						*RequiresFEC = false;
  5392					}
  5393				} else {
  5394					*RequiresDSC = false;
  5395					LinkDSCEnable = false;
  5396					if (Output == dml_dp2p0) {
  5397						*RequiresFEC = true;
  5398					} else {
  5399						*RequiresFEC = false;
  5400					}
  5401				}
  5402				if (Output == dml_dp2p0) {
  5403					*OutBpp = 0;
  5404					if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr10) && PHYCLKD32PerState >= 10000 / 32) {
  5405						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5406													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5407						if (*OutBpp == 0 && PHYCLKD32PerState < 13500 / 32 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
  5408							*RequiresDSC = true;
  5409							LinkDSCEnable = true;
  5410							*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5411														OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5412						}
  5413						//OutputTypeAndRate = Output & " UHBR10";
  5414						*OutputType = dml_output_type_dp2p0;
  5415						*OutputRate = dml_output_rate_dp_rate_uhbr10;
  5416					}
  5417					if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32PerState >= 13500 / 32) {
  5418						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5419													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5420	
> 5421						if (OutBpp == 0 && PHYCLKD32PerState < 20000 / 32 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
  5422							*RequiresDSC = true;
  5423							LinkDSCEnable = true;
  5424							*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5425													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5426						}
  5427						//OutputTypeAndRate = Output & " UHBR13p5";
  5428						*OutputType = dml_output_type_dp2p0;
  5429						*OutputRate = dml_output_rate_dp_rate_uhbr13p5;
  5430					}
  5431					if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr20) && *OutBpp == 0 && PHYCLKD32PerState >= 20000 / 32) {
  5432						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 20000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5433												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5434						if (*OutBpp == 0 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
  5435							*RequiresDSC = true;
  5436							LinkDSCEnable = true;
  5437							*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 20000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5438													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5439						}
  5440						//OutputTypeAndRate = Output & " UHBR20";
  5441						*OutputType = dml_output_type_dp2p0;
  5442						*OutputRate = dml_output_rate_dp_rate_uhbr20;
  5443					}
  5444				} else { // output is dp or edp
  5445					*OutBpp = 0;
  5446					if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_hbr) && PHYCLKPerState >= 270) {
  5447						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 2700, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5448												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5449						if (*OutBpp == 0 && PHYCLKPerState < 540 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
  5450							*RequiresDSC = true;
  5451							LinkDSCEnable = true;
  5452							if (Output == dml_dp) {
  5453								*RequiresFEC = true;
  5454							}
  5455							*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 2700, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5456													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5457						}
  5458						//OutputTypeAndRate = Output & " HBR";
  5459						*OutputType = (Output == dml_dp) ? dml_output_type_dp : dml_output_type_edp;
  5460						*OutputRate = dml_output_rate_dp_rate_hbr;
  5461					}
  5462					if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_hbr2) && *OutBpp == 0 && PHYCLKPerState >= 540) {
  5463						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 5400, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5464												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5465	
  5466						if (*OutBpp == 0 && PHYCLKPerState < 810 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
  5467							*RequiresDSC = true;
  5468							LinkDSCEnable = true;
  5469							if (Output == dml_dp) {
  5470								*RequiresFEC = true;
  5471							}
  5472							*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 5400, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5473													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5474						}
  5475						//OutputTypeAndRate = Output & " HBR2";
  5476						*OutputType = (Output == dml_dp) ? dml_output_type_dp : dml_output_type_edp;
  5477						*OutputRate = dml_output_rate_dp_rate_hbr2;
  5478					}
  5479					if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_hbr3) && *OutBpp == 0 && PHYCLKPerState >= 810) { // VBA_ERROR, vba code doesn't have hbr3 check
  5480						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 8100, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5481												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5482	
  5483						if (*OutBpp == 0 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
  5484							*RequiresDSC = true;
  5485							LinkDSCEnable = true;
  5486							if (Output == dml_dp) {
  5487								*RequiresFEC = true;
  5488							}
  5489							*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 8100, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
  5490													OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
  5491						}
  5492						//OutputTypeAndRate = Output & " HBR3";
  5493						*OutputType = (Output == dml_dp) ? dml_output_type_dp : dml_output_type_edp;
  5494						*OutputRate = dml_output_rate_dp_rate_hbr3;
  5495					}
  5496				}
  5497			}
  5498		}
  5499	}
  5500	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
