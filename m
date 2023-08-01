Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E676A710
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjHAChL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHAChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:37:09 -0400
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFBAF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:37:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440288|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.241969-0.00335738-0.754673;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5Gdet3_1690857420;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5Gdet3_1690857420)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:37:01 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in amd_powerplay.c
Date:   Tue,  1 Aug 2023 02:36:58 +0000
Message-Id: <20230801023658.4667-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: spaces required around that '||' (ctx:WxO)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index ff360c699171..9e4f8a4104a3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -612,7 +612,7 @@ static int pp_dpm_get_pp_num_states(void *handle,
 
 	memset(data, 0, sizeof(*data));
 
-	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->ps)
+	if (!hwmgr || !hwmgr->pm_en || !hwmgr->ps)
 		return -EINVAL;
 
 	data->nums = hwmgr->num_ps;
@@ -644,7 +644,7 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->soft_pp_table)
+	if (!hwmgr || !hwmgr->pm_en || !hwmgr->soft_pp_table)
 		return -EINVAL;
 
 	*table = (char *)hwmgr->soft_pp_table;
@@ -1002,7 +1002,7 @@ static int pp_get_power_limit(void *handle, uint32_t *limit,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !hwmgr->pm_en ||!limit)
+	if (!hwmgr || !hwmgr->pm_en || !limit)
 		return -EINVAL;
 
 	if (power_type != PP_PWR_TYPE_SUSTAINED)
@@ -1047,7 +1047,7 @@ static int pp_get_display_power_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!output)
+	if (!hwmgr || !hwmgr->pm_en || !output)
 		return -EINVAL;
 
 	return phm_get_dal_power_level(hwmgr, output);
@@ -1120,7 +1120,7 @@ static int pp_get_clock_by_type_with_latency(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clocks)
+	if (!hwmgr || !hwmgr->pm_en || !clocks)
 		return -EINVAL;
 
 	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
@@ -1132,7 +1132,7 @@ static int pp_get_clock_by_type_with_voltage(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clocks)
+	if (!hwmgr || !hwmgr->pm_en || !clocks)
 		return -EINVAL;
 
 	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
@@ -1155,7 +1155,7 @@ static int pp_display_clock_voltage_request(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clock)
+	if (!hwmgr || !hwmgr->pm_en || !clock)
 		return -EINVAL;
 
 	return phm_display_clock_voltage_request(hwmgr, clock);
@@ -1167,7 +1167,7 @@ static int pp_get_display_mode_validation_clocks(void *handle,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clocks)
+	if (!hwmgr || !hwmgr->pm_en || !clocks)
 		return -EINVAL;
 
 	clocks->level = PP_DAL_POWERLEVEL_7;
-- 
2.17.1

