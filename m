Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2B80001F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377510AbjLAAPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377456AbjLAAPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEE19B2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701389704; x=1732925704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+71IvnESzL1EyuNy3YYDMALMxOT4XHztKHk9wMNBYCY=;
  b=OEFfJg16sXw5fuTFZO4bFJysaNuUJoqEFXGUWkEQFYf0kmFgNcyVaJJQ
   SjEGr+J59JUZaoMKfv4Z51MVWtVcPECeQxQYaUogFvCi2LPLm65yUmcvv
   z0Cj7sF73R36SX/hpLpnGO10qxkE1m5Meb0WOi5v04y7HyBwWrGWC7d6i
   xk4NfyM7qjZb0ixBO4EOh3iFySR+hQQFDlxKwtqQrxDiWUX0MGHfBdjBh
   ahSwVXgP7woZjrkdQA9cfoysgqxXnytkluoF0IMfsC1mhv6+JRp5rNUgK
   xQpJSzhttWNThABVo+NZvUBoAOdyOAvVu8G+1Pu/HsFjGPktpBmqG9Y0z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="393147310"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="393147310"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 16:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769475134"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="769475134"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2023 16:15:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8rBL-0002qI-0E;
        Fri, 01 Dec 2023 00:14:59 +0000
Date:   Fri, 1 Dec 2023 08:14:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenjing Liu <wenjing.liu@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        George Shen <George.Shen@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:425:17:
 warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1
Message-ID: <202312010801.25fDrji3-lkp@intel.com>
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

Hi Wenjing,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: bc33f5e5f05ba44e48909e2cfc5a97475ec69a4d drm/amd/display: create accessories, hwss and protocols sub folders in link
date:   10 months ago
config: x86_64-randconfig-071-20231101 (https://download.01.org/0day-ci/archive/20231201/202312010801.25fDrji3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312010801.25fDrji3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010801.25fDrji3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:142:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     142 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:139:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     139 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22: warning: 'dp_hdmi_dongle_signature_str' defined but not used [-Wunused-const-variable=]
      53 | static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c: In function 'dpia_training_cr_non_transparent.constprop':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:425:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
     425 |                 dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     426 |                                 lt_settings->hw_lane_settings,
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     427 |                                 lt_settings->dpcd_lane_settings);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:425:17: note: referencing argument 4 of type 'union dpcd_training_lane[4]'
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:110:6: note: in a call to function 'dp_decide_lane_settings'
     110 | void dp_decide_lane_settings(
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dp_decide_lane_settings +425 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c

630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  273  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  274  /* Execute clock recovery phase of link training for specified hop in display
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  275   * path.in non-transparent mode:
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  276   * - Driver issues both DPCD and SET_CONFIG transactions.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  277   * - TPS1 is transmitted for any hops downstream of DPOA.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  278   * - Drive (VS/PE) only transmitted for the hop immediately downstream of DPOA.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  279   * - CR for the first hop (DPTX-to-DPIA) is assumed to be successful.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  280   *
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  281   * @param link DPIA link being trained.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  282   * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  283   * @param hop Hop in display path. DPRX = 0.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  284   */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  285  static enum link_training_result dpia_training_cr_non_transparent(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  286  		struct dc_link *link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  287  		const struct link_resource *link_res,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  288  		struct link_training_settings *lt_settings,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  289  		uint32_t hop)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  290  {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  291  	enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  292  	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  293  	enum dc_status status;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  294  	uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  295  	uint32_t retry_count = 0;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  296  	uint32_t wait_time_microsec = TRAINING_AUX_RD_INTERVAL; /* From DP spec, CR read interval is always 100us. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  297  	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  298  	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  299  	union lane_align_status_updated dpcd_lane_status_updated = {0};
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  300  	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  301  	uint8_t set_cfg_data;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  302  	enum dpia_set_config_ts ts;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  303  
d5a43956b73bd7 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-15  304  	repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  305  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  306  	/* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  307  	 * Fix inherited from perform_clock_recovery_sequence() -
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  308  	 * the DP equivalent of this function:
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  309  	 * Required for Synaptics MST hub which can put the LT in
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  310  	 * infinite loop by switching the VS between level 0 and level 1
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  311  	 * continuously.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  312  	 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  313  	while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  314  			(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  315  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  316  		/* DPTX-to-DPIA */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  317  		if (hop == repeater_cnt) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  318  			/* Send SET_CONFIG(SET_LINK:LC,LR,LTTPR) to notify DPOA that
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  319  			 * non-transparent link training has started.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  320  			 * This also enables the transmission of clk_sync packets.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  321  			 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  322  			set_cfg_data = dpia_build_set_config_data(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  323  					DPIA_SET_CFG_SET_LINK,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  324  					link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  325  					lt_settings);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  326  			status = core_link_send_set_config(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  327  					link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  328  					DPIA_SET_CFG_SET_LINK,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  329  					set_cfg_data);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  330  			/* CR for this hop is considered successful as long as
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  331  			 * SET_CONFIG message is acknowledged by DPOA.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  332  			 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  333  			if (status == DC_OK)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  334  				result = LINK_TRAINING_SUCCESS;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  335  			else
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  336  				result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  337  			break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  338  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  339  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  340  		/* DPOA-to-x */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  341  		/* Instruct DPOA to transmit TPS1 then update DPCD. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  342  		if (retry_count == 0) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  343  			status = convert_trng_ptn_to_trng_stg(lt_settings->pattern_for_cr, &ts);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  344  			if (status != DC_OK) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  345  				result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  346  				break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  347  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  348  			status = core_link_send_set_config(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  349  					link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  350  					DPIA_SET_CFG_SET_TRAINING,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  351  					ts);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  352  			if (status != DC_OK) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  353  				result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  354  				break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  355  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  356  			status = dpcd_set_lt_pattern(link, lt_settings->pattern_for_cr, hop);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  357  			if (status != DC_OK) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  358  				result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  359  				break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  360  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  361  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  362  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  363  		/* Update DPOA drive settings then DPCD. DPOA does only adjusts
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  364  		 * drive settings for hops immediately downstream.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  365  		 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  366  		if (hop == repeater_cnt - 1) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  367  			set_cfg_data = dpia_build_set_config_data(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  368  					DPIA_SET_CFG_SET_VSPE,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  369  					link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  370  					lt_settings);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  371  			status = core_link_send_set_config(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  372  					link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  373  					DPIA_SET_CFG_SET_VSPE,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  374  					set_cfg_data);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  375  			if (status != DC_OK) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  376  				result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  377  				break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  378  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  379  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  380  		status = dpcd_set_lane_settings(link, lt_settings, hop);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  381  		if (status != DC_OK) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  382  			result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  383  			break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  384  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  385  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  386  		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  387  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  388  		/* Read status and adjustment requests from DPCD. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  389  		status = dp_get_lane_status_and_lane_adjust(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  390  				link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  391  				lt_settings,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  392  				dpcd_lane_status,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  393  				&dpcd_lane_status_updated,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  394  				dpcd_lane_adjust,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  395  				hop);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  396  		if (status != DC_OK) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  397  			result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  398  			break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  399  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  400  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  401  		/* Check if clock recovery successful. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  402  		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  403  			result = LINK_TRAINING_SUCCESS;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  404  			break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  405  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  406  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  407  		result = dp_get_cr_failure(lane_count, dpcd_lane_status);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  408  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  409  		if (dp_is_max_vs_reached(lt_settings))
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  410  			break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  411  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  412  		/* Count number of attempts with same drive settings.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  413  		 * Note: settings are the same for all lanes,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  414  		 * so comparing first lane is sufficient.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  415  		 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  416  		if ((lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  417  				dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  418  				&& (lt_settings->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET ==
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  419  						dpcd_lane_adjust[0].bits.PRE_EMPHASIS_LANE))
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  420  			retries_cr++;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  421  		else
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  422  			retries_cr = 0;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  423  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  424  		/* Update VS/PE. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14 @425  		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  426  				lt_settings->hw_lane_settings,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  427  				lt_settings->dpcd_lane_settings);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  428  		retry_count++;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  429  	}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  430  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  431  	/* Abort link training if clock recovery failed due to HPD unplug. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  432  	if (link->is_hpd_pending)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  433  		result = LINK_TRAINING_ABORT;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  434  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  435  	DC_LOG_HW_LINK_TRAINING(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  436  		"%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n - status(%d)\n",
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  437  		__func__,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  438  		link->link_id.enum_id - ENUM_ID_1,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  439  		hop,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  440  		result,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  441  		retry_count,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  442  		status);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  443  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  444  	return result;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  445  }
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c Wenjing Liu 2022-12-14  446  

:::::: The code at line 425 was first introduced by commit
:::::: 630168a97314a8f6da9c09d73f5e78c3c1fe3eee drm/amd/display: move dp link training logic to link_dp_training

:::::: TO: Wenjing Liu <wenjing.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
