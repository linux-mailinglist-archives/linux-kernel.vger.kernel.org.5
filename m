Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829207691BB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGaJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGaJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:30:25 -0400
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73A12A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:30:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07457395|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.101045-0.00203573-0.896919;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U4m6pBV_1690795811;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U4m6pBV_1690795811)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 17:30:13 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in amdgpu_smu.h
Date:   Mon, 31 Jul 2023 09:30:09 +0000
Message-Id: <20230731093009.3243-1-sunran001@208suo.com>
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

ERROR: open brace '{' following enum go on the same line
ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 36 +++++++------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9..190a90b24d74 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -200,29 +200,25 @@ struct smu_power_state {
 	struct smu_hw_power_state                     hardware;
 };
 
-enum smu_power_src_type
-{
+enum smu_power_src_type {
 	SMU_POWER_SOURCE_AC,
 	SMU_POWER_SOURCE_DC,
 	SMU_POWER_SOURCE_COUNT,
 };
 
-enum smu_ppt_limit_type
-{
+enum smu_ppt_limit_type {
 	SMU_DEFAULT_PPT_LIMIT = 0,
 	SMU_FAST_PPT_LIMIT,
 };
 
-enum smu_ppt_limit_level
-{
+enum smu_ppt_limit_level {
 	SMU_PPT_LIMIT_MIN = -1,
 	SMU_PPT_LIMIT_CURRENT,
 	SMU_PPT_LIMIT_DEFAULT,
 	SMU_PPT_LIMIT_MAX,
 };
 
-enum smu_memory_pool_size
-{
+enum smu_memory_pool_size {
     SMU_MEMORY_POOL_SIZE_ZERO   = 0,
     SMU_MEMORY_POOL_SIZE_256_MB = 0x10000000,
     SMU_MEMORY_POOL_SIZE_512_MB = 0x20000000,
@@ -282,8 +278,7 @@ struct smu_clock_info {
 	uint32_t max_bus_bandwidth;
 };
 
-struct smu_bios_boot_up_values
-{
+struct smu_bios_boot_up_values {
 	uint32_t			revision;
 	uint32_t			gfxclk;
 	uint32_t			uclk;
@@ -305,8 +300,7 @@ struct smu_bios_boot_up_values
 	uint32_t			firmware_caps;
 };
 
-enum smu_table_id
-{
+enum smu_table_id {
 	SMU_TABLE_PPTABLE = 0,
 	SMU_TABLE_WATERMARKS,
 	SMU_TABLE_CUSTOM_DPM,
@@ -326,8 +320,7 @@ enum smu_table_id
 	SMU_TABLE_COUNT,
 };
 
-struct smu_table_context
-{
+struct smu_table_context {
 	void				*power_play_table;
 	uint32_t			power_play_table_size;
 	void				*hardcode_pptable;
@@ -390,8 +383,7 @@ struct smu_power_context {
 };
 
 #define SMU_FEATURE_MAX	(64)
-struct smu_feature
-{
+struct smu_feature {
 	uint32_t feature_num;
 	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
 	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
@@ -416,21 +408,18 @@ struct mclock_latency_table {
 	struct mclk_latency_entries  entries[MAX_REGULAR_DPM_NUM];
 };
 
-enum smu_reset_mode
-{
+enum smu_reset_mode {
     SMU_RESET_MODE_0,
     SMU_RESET_MODE_1,
     SMU_RESET_MODE_2,
 };
 
-enum smu_baco_state
-{
+enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
 };
 
-struct smu_baco_context
-{
+struct smu_baco_context {
 	uint32_t state;
 	bool platform_support;
 	bool maco_support;
@@ -478,8 +467,7 @@ struct stb_context {
 
 #define WORKLOAD_POLICY_MAX 7
 
-struct smu_context
-{
+struct smu_context {
 	struct amdgpu_device            *adev;
 	struct amdgpu_irq_src		irq_source;
 
-- 
2.17.1

