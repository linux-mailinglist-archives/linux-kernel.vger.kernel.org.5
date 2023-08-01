Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32EA76A6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjHACBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjHACBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:01:16 -0400
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10842117
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:01:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08409528|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00368847-0.000301355-0.99601;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5DeSmo_1690855254;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5DeSmo_1690855254)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:00:56 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in aldebaran_ppt.c
Date:   Tue,  1 Aug 2023 02:00:52 +0000
Message-Id: <20230801020052.4192-1-sunran001@208suo.com>
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
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ce50ef46e73f..8f26123ac703 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -94,8 +94,7 @@
  */
 #define SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION 0x00443300
 
-static const struct smu_temperature_range smu13_thermal_policy[] =
-{
+static const struct smu_temperature_range smu13_thermal_policy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
@@ -196,7 +195,7 @@ static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEATURE_COUN
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 				FEATURE_FW_CTF_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 				FEATURE_THERMAL_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_OUT_OF_BAND_MONITOR_BIT, 	FEATURE_OUT_OF_BAND_MONITOR_BIT),
-	ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,FEATURE_XGMI_PER_LINK_PWR_DWN),
+	ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT, FEATURE_XGMI_PER_LINK_PWR_DWN),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT, 			FEATURE_DF_CSTATE),
 };
 
@@ -580,7 +579,7 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
 {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
@@ -1906,8 +1905,7 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 	smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (smu_version < 0x00440700) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
-	}
-	else {
+	} else {
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
 		if ((smu_version >= 0x00442c00) && ras &&
@@ -2116,7 +2114,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v13_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support= aldebaran_is_baco_supported,
+	.baco_is_support = aldebaran_is_baco_supported,
 	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
-- 
2.17.1

