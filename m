Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0964F75768E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGRIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGRIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:32:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99C115
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689669117; x=1721205117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q30+seFw+4eenXaJNG8nbUBfRsSOd1o4oiM6qt7SAxk=;
  b=DkfEZ8QYoJ7OylZDe7L9+jMqacHLFlEk2V5n5DCaT0n9TcEC4BPiH+8r
   YSiEZYAY9bvoCKdfg/rRks1H0JsmzxLgW+nNJm0VIYHepgcRVjklc914Y
   kHgYsq1eR5ySCTOf6F4lMlUMW5dEBKT3PMl+bSLpQNLZUUXN+4DmhjGA/
   kwf0p/R04HfRe+Pr4q7tswZJUDIty5EppveDawl+m9RUONOlG6pOvXX+D
   XUVQaiXiZj1tEJ9ORr/M2I+sziYm0SNmL83Kfh1HMZ6JRBMM8igVR2egU
   ZWyxajKEqpfTUPxXSZrzsDECpUwAVeffDpmdXBGlSiP4Ly1S1+Ao7dMkJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="365021561"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="365021561"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 01:31:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="970160595"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="970160595"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2023 01:31:55 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLg7e-0000MR-2N;
        Tue, 18 Jul 2023 08:31:54 +0000
Date:   Tue, 18 Jul 2023 16:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230717 1/5]
 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17:
 error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1
Message-ID: <202307181615.iVlmV0s6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230717
head:   584ee211a23e349a6478767544c518f04b6cf2bd
commit: 1fdc6510f00eba88bc602d8a4482a7c866db4918 [1/5] Makefile: Globally enable -Wstringop-overflow
config: arm-randconfig-r063-20230716 (https://download.01.org/0day-ci/archive/20230718/202307181615.iVlmV0s6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230718/202307181615.iVlmV0s6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307181615.iVlmV0s6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c: In function 'dpia_training_cr_non_transparent.constprop':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
     427 |                 dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     428 |                                 lt_settings->hw_lane_settings,
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     429 |                                 lt_settings->dpcd_lane_settings);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17: note: referencing argument 4 of type 'union dpcd_training_lane[4]'
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:110:6: note: in a call to function 'dp_decide_lane_settings'
     110 | void dp_decide_lane_settings(
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c: In function 'dp_perform_fixed_vs_pe_training_sequence_legacy':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:472:25: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
     472 |                         dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     473 |                                         lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:472:25: note: referencing argument 4 of type 'union dpcd_training_lane[4]'
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:34:
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:110:6: note: in a call to function 'dp_decide_lane_settings'
     110 | void dp_decide_lane_settings(
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c: In function 'dp_perform_fixed_vs_pe_training_sequence':
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:835:25: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
     835 |                         dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     836 |                                         lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:835:25: note: referencing argument 4 of type 'union dpcd_training_lane[4]'
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:110:6: note: in a call to function 'dp_decide_lane_settings'
     110 | void dp_decide_lane_settings(
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/dp_decide_lane_settings +427 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c

630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  274  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  275  /* Execute clock recovery phase of link training for specified hop in display
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  276   * path.in non-transparent mode:
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  277   * - Driver issues both DPCD and SET_CONFIG transactions.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  278   * - TPS1 is transmitted for any hops downstream of DPOA.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  279   * - Drive (VS/PE) only transmitted for the hop immediately downstream of DPOA.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  280   * - CR for the first hop (DPTX-to-DPIA) is assumed to be successful.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  281   *
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  282   * @param link DPIA link being trained.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  283   * @param lt_settings link_setting and drive settings (voltage swing and pre-emphasis).
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  284   * @param hop Hop in display path. DPRX = 0.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  285   */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  286  static enum link_training_result dpia_training_cr_non_transparent(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  287  		struct dc_link *link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  288  		const struct link_resource *link_res,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  289  		struct link_training_settings *lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  290  		uint32_t hop)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  291  {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  292  	enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  293  	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  294  	enum dc_status status;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  295  	uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  296  	uint32_t retry_count = 0;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  297  	uint32_t wait_time_microsec = TRAINING_AUX_RD_INTERVAL; /* From DP spec, CR read interval is always 100us. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  298  	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  299  	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  300  	union lane_align_status_updated dpcd_lane_status_updated = {0};
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  301  	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  302  	uint8_t set_cfg_data;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  303  	enum dpia_set_config_ts ts;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  304  
d5a43956b73bd78 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-15  305  	repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  306  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  307  	/* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  308  	 * Fix inherited from perform_clock_recovery_sequence() -
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  309  	 * the DP equivalent of this function:
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  310  	 * Required for Synaptics MST hub which can put the LT in
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  311  	 * infinite loop by switching the VS between level 0 and level 1
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  312  	 * continuously.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  313  	 */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  314  	while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  315  			(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  316  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  317  		/* DPTX-to-DPIA */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  318  		if (hop == repeater_cnt) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  319  			/* Send SET_CONFIG(SET_LINK:LC,LR,LTTPR) to notify DPOA that
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  320  			 * non-transparent link training has started.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  321  			 * This also enables the transmission of clk_sync packets.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  322  			 */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  323  			set_cfg_data = dpia_build_set_config_data(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  324  					DPIA_SET_CFG_SET_LINK,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  325  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  326  					lt_settings);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  327  			status = core_link_send_set_config(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  328  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  329  					DPIA_SET_CFG_SET_LINK,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  330  					set_cfg_data);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  331  			/* CR for this hop is considered successful as long as
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  332  			 * SET_CONFIG message is acknowledged by DPOA.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  333  			 */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  334  			if (status == DC_OK)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  335  				result = LINK_TRAINING_SUCCESS;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  336  			else
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  337  				result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  338  			break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  339  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  340  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  341  		/* DPOA-to-x */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  342  		/* Instruct DPOA to transmit TPS1 then update DPCD. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  343  		if (retry_count == 0) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  344  			status = convert_trng_ptn_to_trng_stg(lt_settings->pattern_for_cr, &ts);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  345  			if (status != DC_OK) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  346  				result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  347  				break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  348  			}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  349  			status = core_link_send_set_config(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  350  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  351  					DPIA_SET_CFG_SET_TRAINING,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  352  					ts);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  353  			if (status != DC_OK) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  354  				result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  355  				break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  356  			}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  357  			status = dpcd_set_lt_pattern(link, lt_settings->pattern_for_cr, hop);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  358  			if (status != DC_OK) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  359  				result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  360  				break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  361  			}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  362  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  363  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  364  		/* Update DPOA drive settings then DPCD. DPOA does only adjusts
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  365  		 * drive settings for hops immediately downstream.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  366  		 */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  367  		if (hop == repeater_cnt - 1) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  368  			set_cfg_data = dpia_build_set_config_data(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  369  					DPIA_SET_CFG_SET_VSPE,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  370  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  371  					lt_settings);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  372  			status = core_link_send_set_config(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  373  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  374  					DPIA_SET_CFG_SET_VSPE,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  375  					set_cfg_data);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  376  			if (status != DC_OK) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  377  				result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  378  				break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  379  			}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  380  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  381  		status = dpcd_set_lane_settings(link, lt_settings, hop);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  382  		if (status != DC_OK) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  383  			result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  384  			break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  385  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  386  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  387  		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  388  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  389  		/* Read status and adjustment requests from DPCD. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  390  		status = dp_get_lane_status_and_lane_adjust(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  391  				link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  392  				lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  393  				dpcd_lane_status,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  394  				&dpcd_lane_status_updated,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  395  				dpcd_lane_adjust,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  396  				hop);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  397  		if (status != DC_OK) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  398  			result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  399  			break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  400  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  401  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  402  		/* Check if clock recovery successful. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  403  		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
88c7ad91e378775 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c Srinivasan Shanmugam 2023-04-14  404  			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  405  			result = LINK_TRAINING_SUCCESS;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  406  			break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  407  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  408  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  409  		result = dp_get_cr_failure(lane_count, dpcd_lane_status);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  410  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  411  		if (dp_is_max_vs_reached(lt_settings))
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  412  			break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  413  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  414  		/* Count number of attempts with same drive settings.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  415  		 * Note: settings are the same for all lanes,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  416  		 * so comparing first lane is sufficient.
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  417  		 */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  418  		if ((lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  419  				dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  420  				&& (lt_settings->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET ==
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  421  						dpcd_lane_adjust[0].bits.PRE_EMPHASIS_LANE))
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  422  			retries_cr++;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  423  		else
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  424  			retries_cr = 0;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  425  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  426  		/* Update VS/PE. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14 @427  		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  428  				lt_settings->hw_lane_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  429  				lt_settings->dpcd_lane_settings);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  430  		retry_count++;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  431  	}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  432  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  433  	/* Abort link training if clock recovery failed due to HPD unplug. */
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  434  	if (link->is_hpd_pending)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  435  		result = LINK_TRAINING_ABORT;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  436  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  437  	DC_LOG_HW_LINK_TRAINING(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  438  		"%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n - status(%d)\n",
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  439  		__func__,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  440  		link->link_id.enum_id - ENUM_ID_1,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  441  		hop,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  442  		result,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  443  		retry_count,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  444  		status);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  445  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  446  	return result;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  447  }
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.c           Wenjing Liu          2022-12-14  448  

:::::: The code at line 427 was first introduced by commit
:::::: 630168a97314a8f6da9c09d73f5e78c3c1fe3eee drm/amd/display: move dp link training logic to link_dp_training

:::::: TO: Wenjing Liu <wenjing.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
