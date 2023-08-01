Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4088576AD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjHAJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjHAJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:29:47 -0400
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2562707
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:28:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07480418|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0163373-0.000708181-0.982955;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5rUvp6_1690882103;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5rUvp6_1690882103)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:28:25 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu/powerplay: Clean up errors in vega20_hwmgr.c
Date:   Tue,  1 Aug 2023 09:28:21 +0000
Message-Id: <20230801092821.7495-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: code indent should use tabs where possible
ERROR: space required before the open parenthesis '('
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 4e19ccbdb807..492ca33637d6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -1402,7 +1402,7 @@ static int vega20_od8_set_settings(
 			"Failed to export over drive table!",
 			return ret);
 
-	switch(index) {
+	switch (index) {
 	case OD8_SETTING_GFXCLK_FMIN:
 		od_table.GfxclkFmin = (uint16_t)value;
 		break;
@@ -2360,7 +2360,7 @@ static int vega20_notify_smc_display_config_after_ps_adjustment(
 		dpm_table->dpm_state.hard_min_level = min_clocks.memoryClock / 100;
 		PP_ASSERT_WITH_CODE(!(ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetHardMinByFreq,
-				(PPCLK_UCLK << 16 ) | dpm_table->dpm_state.hard_min_level,
+				(PPCLK_UCLK << 16) | dpm_table->dpm_state.hard_min_level,
 				NULL)),
 				"[SetHardMinFreq] Set hard min uclk failed!",
 				return ret);
@@ -3579,7 +3579,7 @@ static int vega20_set_uclk_to_highest_dpm_level(struct pp_hwmgr *hwmgr,
 		dpm_table->dpm_state.hard_min_level = dpm_table->dpm_levels[dpm_table->count - 1].value;
 		PP_ASSERT_WITH_CODE(!(ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetHardMinByFreq,
-				(PPCLK_UCLK << 16 ) | dpm_table->dpm_state.hard_min_level,
+				(PPCLK_UCLK << 16) | dpm_table->dpm_state.hard_min_level,
 				NULL)),
 				"[SetUclkToHightestDpmLevel] Set hard min uclk failed!",
 				return ret);
@@ -3605,7 +3605,7 @@ static int vega20_set_fclk_to_highest_dpm_level(struct pp_hwmgr *hwmgr)
 		dpm_table->dpm_state.soft_min_level = dpm_table->dpm_levels[dpm_table->count - 1].value;
 		PP_ASSERT_WITH_CODE(!(ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetSoftMinByFreq,
-				(PPCLK_FCLK << 16 ) | dpm_table->dpm_state.soft_min_level,
+				(PPCLK_FCLK << 16) | dpm_table->dpm_state.soft_min_level,
 				NULL)),
 				"[SetFclkToHightestDpmLevel] Set soft min fclk failed!",
 				return ret);
@@ -3727,8 +3727,8 @@ static int vega20_apply_clocks_adjust_rules(struct pp_hwmgr *hwmgr)
 	uint32_t i, latency;
 
 	disable_mclk_switching = ((1 < hwmgr->display_config->num_display) &&
-                           !hwmgr->display_config->multi_monitor_in_sync) ||
-                            vblank_too_short;
+				!hwmgr->display_config->multi_monitor_in_sync) ||
+				vblank_too_short;
 	latency = hwmgr->display_config->dce_tolerable_mclk_in_active_latency;
 
 	/* gfxclk */
-- 
2.17.1

