Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6476A73A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHAC5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHAC5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:57:16 -0400
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A6A114
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:57:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09616855|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0129007-0.000684149-0.986415;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5ISByU_1690858625;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5ISByU_1690858625)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:57:07 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega12_hwmgr.c
Date:   Tue,  1 Aug 2023 02:57:03 +0000
Message-Id: <20230801025703.4979-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: need consistent spacing around '/' (ctx:WxV)
ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 1937be1cf5b4..4bd573d815ff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1623,13 +1623,13 @@ static int vega12_notify_smc_display_config_after_ps_adjustment(
 
 	if (data->smu_features[GNLD_DPM_DCEFCLK].supported) {
 		clock_req.clock_type = amd_pp_dcef_clock;
-		clock_req.clock_freq_in_khz = min_clocks.dcefClock/10;
+		clock_req.clock_freq_in_khz = min_clocks.dcefClock / 10;
 		if (!vega12_display_clock_voltage_request(hwmgr, &clock_req)) {
 			if (data->smu_features[GNLD_DS_DCEFCLK].supported)
 				PP_ASSERT_WITH_CODE(
 					!smum_send_msg_to_smc_with_parameter(
 					hwmgr, PPSMC_MSG_SetMinDeepSleepDcefclk,
-					min_clocks.dcefClockInSR /100,
+					min_clocks.dcefClockInSR / 100,
 					NULL),
 					"Attempt to set divider for DCEFCLK Failed!",
 					return -1);
@@ -2354,8 +2354,8 @@ static int vega12_apply_clocks_adjust_rules(struct pp_hwmgr *hwmgr)
 	uint32_t i, latency;
 
 	disable_mclk_switching = ((1 < hwmgr->display_config->num_display) &&
-			          !hwmgr->display_config->multi_monitor_in_sync) ||
-			          vblank_too_short;
+				!hwmgr->display_config->multi_monitor_in_sync) ||
+				vblank_too_short;
 	latency = hwmgr->display_config->dce_tolerable_mclk_in_active_latency;
 
 	/* gfxclk */
@@ -2522,7 +2522,7 @@ static int vega12_set_uclk_to_highest_dpm_level(struct pp_hwmgr *hwmgr,
 		dpm_table->dpm_state.hard_min_level = dpm_table->dpm_levels[dpm_table->count - 1].value;
 		PP_ASSERT_WITH_CODE(!(ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetHardMinByFreq,
-				(PPCLK_UCLK << 16 ) | dpm_table->dpm_state.hard_min_level,
+				(PPCLK_UCLK << 16) | dpm_table->dpm_state.hard_min_level,
 				NULL)),
 				"[SetUclkToHightestDpmLevel] Set hard min uclk failed!",
 				return ret);
-- 
2.17.1

