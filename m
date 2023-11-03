Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1487F7DFE85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKCEGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCEGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:06:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420D1A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 21:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698984397; x=1730520397;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rs/FkRKFWNy3RiYgqJIggDY5uEverRB34C+bQ1T702Y=;
  b=HBW5P0F6ZimTsHot235rBXcTT2t8/OAQKhfF6te1Nr7hS8vlQCtovn6j
   0UbVQpDWBRFDzdTaTV6dN+fiOJ3wyBd71ptLMflA2+daJ2nt7LiiB8FJL
   5/fjUlj0uZ8UTnQZwrkDRv4XT2MYMNKKv39HA4XHKo6mNvK+eQLClSrQr
   Jx5EOIOcGeFE25L72/hE8KBVbH5ZGSWiPjAv5eoOEwUTK0g5xmqjaRwyO
   yujB0aIMzd5kavP8TrhctnZnGXk2NnmBR/ltOn4f1JzhX0liR/YMrRnpn
   vA6KuX8HFXD3sEifTJCZPH1pBVXrVDivvbkOSFM3wfGuH8NYlenUrNzAk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391744169"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391744169"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 21:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="831917908"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="831917908"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2023 21:06:34 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qylS4-0002CK-02;
        Fri, 03 Nov 2023 04:06:32 +0000
Date:   Fri, 3 Nov 2023 12:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.c:254:17:
 warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1
Message-ID: <202311031119.NVzPwvI8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
commit: 5aa4ac64e6add3e40d5049e31275b2822daf885d LoongArch: Add KASAN (Kernel Address Sanitizer) support
date:   8 weeks ago
config: loongarch-randconfig-002-20231102 (https://download.01.org/0day-ci/archive/20231103/202311031119.NVzPwvI8-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031119.NVzPwvI8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031119.NVzPwvI8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.c: In function 'perform_8b_10b_clock_recovery_sequence':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.c:254:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
     254 |                 dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     255 |                                 lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.c:254:17: note: referencing argument 4 of type 'union dpcd_training_lane[4]'
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.c:30:
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:110:6: note: in a call to function 'dp_decide_lane_settings'
     110 | void dp_decide_lane_settings(
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dp_decide_lane_settings +254 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_8b_10b.c

630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  153  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  154  enum link_training_result perform_8b_10b_clock_recovery_sequence(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  155  	struct dc_link *link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  156  	const struct link_resource *link_res,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  157  	struct link_training_settings *lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  158  	uint32_t offset)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  159  {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  160  	uint32_t retries_cr;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  161  	uint32_t retry_count;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  162  	uint32_t wait_time_microsec;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  163  	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  164  	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  165  	union lane_align_status_updated dpcd_lane_status_updated;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  166  	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  167  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  168  	retries_cr = 0;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  169  	retry_count = 0;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  170  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  171  	memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  172  	memset(&dpcd_lane_status_updated, '\0',
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  173  	sizeof(dpcd_lane_status_updated));
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  174  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  175  	if (!link->ctx->dc->work_arounds.lt_early_cr_pattern)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  176  		dp_set_hw_training_pattern(link, link_res, lt_settings->pattern_for_cr, offset);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  177  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  178  	/* najeeb - The synaptics MST hub can put the LT in
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  179  	* infinite loop by switching the VS
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  180  	*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  181  	/* between level 0 and level 1 continuously, here
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  182  	* we try for CR lock for LinkTrainingMaxCRRetry count*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  183  	while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  184  		(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  185  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  186  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  187  		/* 1. call HWSS to set lane settings*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  188  		dp_set_hw_lane_settings(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  189  				link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  190  				link_res,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  191  				lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  192  				offset);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  193  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  194  		/* 2. update DPCD of the receiver*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  195  		if (!retry_count)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  196  			/* EPR #361076 - write as a 5-byte burst,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  197  			 * but only for the 1-st iteration.*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  198  			dpcd_set_lt_pattern_and_lane_settings(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  199  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  200  					lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  201  					lt_settings->pattern_for_cr,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  202  					offset);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  203  		else
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  204  			dpcd_set_lane_settings(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  205  					link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  206  					lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  207  					offset);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  208  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  209  		/* 3. wait receiver to lock-on*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  210  		wait_time_microsec = lt_settings->cr_pattern_time;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  211  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  212  		dp_wait_for_training_aux_rd_interval(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  213  				link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  214  				wait_time_microsec);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  215  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  216  		/* 4. Read lane status and requested drive
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  217  		* settings as set by the sink
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  218  		*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  219  		dp_get_lane_status_and_lane_adjust(
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  220  				link,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  221  				lt_settings,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  222  				dpcd_lane_status,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  223  				&dpcd_lane_status_updated,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  224  				dpcd_lane_adjust,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  225  				offset);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  226  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  227  		/* 5. check CR done*/
88c7ad91e378775 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c Srinivasan Shanmugam 2023-04-14  228  		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
88c7ad91e378775 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c Srinivasan Shanmugam 2023-04-14  229  			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  230  			return LINK_TRAINING_SUCCESS;
88c7ad91e378775 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c Srinivasan Shanmugam 2023-04-14  231  		}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  232  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  233  		/* 6. max VS reached*/
d5a43956b73bd78 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-15  234  		if ((link_dp_get_encoding_format(&lt_settings->link_settings) ==
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  235  				DP_8b_10b_ENCODING) &&
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  236  				dp_is_max_vs_reached(lt_settings))
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  237  			break;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  238  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  239  		/* 7. same lane settings*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  240  		/* Note: settings are the same for all lanes,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  241  		 * so comparing first lane is sufficient*/
d5a43956b73bd78 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-15  242  		if ((link_dp_get_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING) &&
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  243  				lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  244  						dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  245  			retries_cr++;
d5a43956b73bd78 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-15  246  		else if ((link_dp_get_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  247  				lt_settings->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE ==
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  248  						dpcd_lane_adjust[0].tx_ffe.PRESET_VALUE)
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  249  			retries_cr++;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  250  		else
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  251  			retries_cr = 0;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  252  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  253  		/* 8. update VS/PE/PC2 in lt_settings*/
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14 @254  		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  255  				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  256  		retry_count++;
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  257  	}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  258  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  259  	if (retry_count >= LINK_TRAINING_MAX_CR_RETRY) {
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  260  		ASSERT(0);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  261  		DC_LOG_ERROR("%s: Link Training Error, could not get CR after %d tries. Possibly voltage swing issue",
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  262  			__func__,
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  263  			LINK_TRAINING_MAX_CR_RETRY);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  264  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  265  	}
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  266  
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  267  	return dp_get_cr_failure(lane_count, dpcd_lane_status);
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  268  }
630168a97314a8f drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c           Wenjing Liu          2022-12-14  269  

:::::: The code at line 254 was first introduced by commit
:::::: 630168a97314a8f6da9c09d73f5e78c3c1fe3eee drm/amd/display: move dp link training logic to link_dp_training

:::::: TO: Wenjing Liu <wenjing.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
