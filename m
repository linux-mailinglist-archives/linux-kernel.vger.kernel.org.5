Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F576A648
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHAB0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHAB0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:26:20 -0400
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3210D;
        Mon, 31 Jul 2023 18:26:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07736829|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0982606-0.000258943-0.90148;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=sunran001@208suo.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.U5CBZxW_1690853169;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5CBZxW_1690853169)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 09:26:12 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     apw@canonical.com, joe@perches.com, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_7_ppt.c
Date:   Tue,  1 Aug 2023 01:26:08 +0000
Message-Id: <20230801012608.4003-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b1f0937ccade..26ba51ec0567 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -386,8 +386,7 @@ static int smu_v13_0_7_check_fw_status(struct smu_context *smu)
 }
 
 #ifndef atom_smc_dpm_info_table_13_0_7
-struct atom_smc_dpm_info_table_13_0_7
-{
+struct atom_smc_dpm_info_table_13_0_7 {
 	struct atom_common_table_header table_header;
 	BoardTable_t BoardTable;
 };
@@ -494,7 +493,7 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 		       sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE_SIZE,
-	               AMDGPU_GEM_DOMAIN_VRAM);
+		       AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
@@ -728,7 +727,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
 {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
 	SmuMetrics_t *metrics =
 		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
 	int ret = 0;
@@ -1635,8 +1634,7 @@ static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static const struct smu_temperature_range smu13_thermal_policy[] =
-{
+static const struct smu_temperature_range smu13_thermal_policy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
-- 
2.17.1

