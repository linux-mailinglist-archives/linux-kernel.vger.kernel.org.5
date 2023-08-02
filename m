Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C330776C2DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjHBCZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjHBCZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:25:36 -0400
Received: from out28-133.mail.aliyun.com (out28-133.mail.aliyun.com [115.124.28.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816412689
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:25:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436259|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.00153503-0.000261432-0.998204;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6M3eIS_1690943127;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6M3eIS_1690943127)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:25:28 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in sislands_smc.h
Date:   Wed,  2 Aug 2023 02:25:25 +0000
Message-Id: <20230802022525.9814-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/legacy-dpm/sislands_smc.h  | 63 +++++++------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
index c7dc117a688c..90ec411c5029 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
@@ -29,8 +29,7 @@
 
 #define SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE 16
 
-struct PP_SIslands_Dpm2PerfLevel
-{
+struct PP_SIslands_Dpm2PerfLevel {
     uint8_t MaxPS;
     uint8_t TgtAct;
     uint8_t MaxPS_StepInc;
@@ -47,8 +46,7 @@ struct PP_SIslands_Dpm2PerfLevel
 
 typedef struct PP_SIslands_Dpm2PerfLevel PP_SIslands_Dpm2PerfLevel;
 
-struct PP_SIslands_DPM2Status
-{
+struct PP_SIslands_DPM2Status {
     uint32_t    dpm2Flags;
     uint8_t     CurrPSkip;
     uint8_t     CurrPSkipPowerShift;
@@ -68,8 +66,7 @@ struct PP_SIslands_DPM2Status
 
 typedef struct PP_SIslands_DPM2Status PP_SIslands_DPM2Status;
 
-struct PP_SIslands_DPM2Parameters
-{
+struct PP_SIslands_DPM2Parameters {
     uint32_t    TDPLimit;
     uint32_t    NearTDPLimit;
     uint32_t    SafePowerLimit;
@@ -78,8 +75,7 @@ struct PP_SIslands_DPM2Parameters
 };
 typedef struct PP_SIslands_DPM2Parameters PP_SIslands_DPM2Parameters;
 
-struct PP_SIslands_PAPMStatus
-{
+struct PP_SIslands_PAPMStatus {
     uint32_t    EstimatedDGPU_T;
     uint32_t    EstimatedDGPU_P;
     uint32_t    EstimatedAPU_T;
@@ -89,8 +85,7 @@ struct PP_SIslands_PAPMStatus
 };
 typedef struct PP_SIslands_PAPMStatus PP_SIslands_PAPMStatus;
 
-struct PP_SIslands_PAPMParameters
-{
+struct PP_SIslands_PAPMParameters {
     uint32_t    NearTDPLimitTherm;
     uint32_t    NearTDPLimitPAPM;
     uint32_t    PlatformPowerLimit;
@@ -100,8 +95,7 @@ struct PP_SIslands_PAPMParameters
 };
 typedef struct PP_SIslands_PAPMParameters PP_SIslands_PAPMParameters;
 
-struct SISLANDS_SMC_SCLK_VALUE
-{
+struct SISLANDS_SMC_SCLK_VALUE {
     uint32_t    vCG_SPLL_FUNC_CNTL;
     uint32_t    vCG_SPLL_FUNC_CNTL_2;
     uint32_t    vCG_SPLL_FUNC_CNTL_3;
@@ -113,8 +107,7 @@ struct SISLANDS_SMC_SCLK_VALUE
 
 typedef struct SISLANDS_SMC_SCLK_VALUE SISLANDS_SMC_SCLK_VALUE;
 
-struct SISLANDS_SMC_MCLK_VALUE
-{
+struct SISLANDS_SMC_MCLK_VALUE {
     uint32_t    vMPLL_FUNC_CNTL;
     uint32_t    vMPLL_FUNC_CNTL_1;
     uint32_t    vMPLL_FUNC_CNTL_2;
@@ -129,8 +122,7 @@ struct SISLANDS_SMC_MCLK_VALUE
 
 typedef struct SISLANDS_SMC_MCLK_VALUE SISLANDS_SMC_MCLK_VALUE;
 
-struct SISLANDS_SMC_VOLTAGE_VALUE
-{
+struct SISLANDS_SMC_VOLTAGE_VALUE {
     uint16_t    value;
     uint8_t     index;
     uint8_t     phase_settings;
@@ -138,8 +130,7 @@ struct SISLANDS_SMC_VOLTAGE_VALUE
 
 typedef struct SISLANDS_SMC_VOLTAGE_VALUE SISLANDS_SMC_VOLTAGE_VALUE;
 
-struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
-{
+struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL {
     uint8_t                     ACIndex;
     uint8_t                     displayWatermark;
     uint8_t                     gen2PCIE;
@@ -180,8 +171,7 @@ struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL
 
 typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PERFORMANCE_LEVEL;
 
-struct SISLANDS_SMC_SWSTATE
-{
+struct SISLANDS_SMC_SWSTATE {
 	uint8_t                             flags;
 	uint8_t                             levelCount;
 	uint8_t                             padding2;
@@ -205,8 +195,7 @@ struct SISLANDS_SMC_SWSTATE_SINGLE {
 #define SISLANDS_SMC_VOLTAGEMASK_VDDC_PHASE_SHEDDING 3
 #define SISLANDS_SMC_VOLTAGEMASK_MAX   4
 
-struct SISLANDS_SMC_VOLTAGEMASKTABLE
-{
+struct SISLANDS_SMC_VOLTAGEMASKTABLE {
     uint32_t lowMask[SISLANDS_SMC_VOLTAGEMASK_MAX];
 };
 
@@ -214,8 +203,7 @@ typedef struct SISLANDS_SMC_VOLTAGEMASKTABLE SISLANDS_SMC_VOLTAGEMASKTABLE;
 
 #define SISLANDS_MAX_NO_VREG_STEPS 32
 
-struct SISLANDS_SMC_STATETABLE
-{
+struct SISLANDS_SMC_STATETABLE {
 	uint8_t					thermalProtectType;
 	uint8_t					systemFlags;
 	uint8_t					maxVDDCIndexInPPTable;
@@ -254,8 +242,7 @@ typedef struct SISLANDS_SMC_STATETABLE SISLANDS_SMC_STATETABLE;
 #define SI_SMC_SOFT_REGISTER_svi_rework_gpio_id_svd   0x11c
 #define SI_SMC_SOFT_REGISTER_svi_rework_gpio_id_svc   0x120
 
-struct PP_SIslands_FanTable
-{
+struct PP_SIslands_FanTable {
 	uint8_t  fdo_mode;
 	uint8_t  padding;
 	int16_t  temp_min;
@@ -285,8 +272,7 @@ typedef struct PP_SIslands_FanTable PP_SIslands_FanTable;
 #define SMC_SISLANDS_SCALE_I  7
 #define SMC_SISLANDS_SCALE_R 12
 
-struct PP_SIslands_CacConfig
-{
+struct PP_SIslands_CacConfig {
     uint16_t   cac_lkge_lut[SMC_SISLANDS_LKGE_LUT_NUM_OF_TEMP_ENTRIES][SMC_SISLANDS_LKGE_LUT_NUM_OF_VOLT_ENTRIES];
     uint32_t   lkge_lut_V0;
     uint32_t   lkge_lut_Vstep;
@@ -308,23 +294,20 @@ typedef struct PP_SIslands_CacConfig PP_SIslands_CacConfig;
 #define SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE 16
 #define SMC_SISLANDS_MC_REGISTER_ARRAY_SET_COUNT 20
 
-struct SMC_SIslands_MCRegisterAddress
-{
+struct SMC_SIslands_MCRegisterAddress {
     uint16_t s0;
     uint16_t s1;
 };
 
 typedef struct SMC_SIslands_MCRegisterAddress SMC_SIslands_MCRegisterAddress;
 
-struct SMC_SIslands_MCRegisterSet
-{
+struct SMC_SIslands_MCRegisterSet {
     uint32_t value[SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE];
 };
 
 typedef struct SMC_SIslands_MCRegisterSet SMC_SIslands_MCRegisterSet;
 
-struct SMC_SIslands_MCRegisters
-{
+struct SMC_SIslands_MCRegisters {
     uint8_t                             last;
     uint8_t                             reserved[3];
     SMC_SIslands_MCRegisterAddress      address[SMC_SISLANDS_MC_REGISTER_ARRAY_SIZE];
@@ -333,8 +316,7 @@ struct SMC_SIslands_MCRegisters
 
 typedef struct SMC_SIslands_MCRegisters SMC_SIslands_MCRegisters;
 
-struct SMC_SIslands_MCArbDramTimingRegisterSet
-{
+struct SMC_SIslands_MCArbDramTimingRegisterSet {
     uint32_t mc_arb_dram_timing;
     uint32_t mc_arb_dram_timing2;
     uint8_t  mc_arb_rfsh_rate;
@@ -344,8 +326,7 @@ struct SMC_SIslands_MCArbDramTimingRegisterSet
 
 typedef struct SMC_SIslands_MCArbDramTimingRegisterSet SMC_SIslands_MCArbDramTimingRegisterSet;
 
-struct SMC_SIslands_MCArbDramTimingRegisters
-{
+struct SMC_SIslands_MCArbDramTimingRegisters {
     uint8_t                                     arb_current;
     uint8_t                                     reserved[3];
     SMC_SIslands_MCArbDramTimingRegisterSet     data[16];
@@ -353,8 +334,7 @@ struct SMC_SIslands_MCArbDramTimingRegisters
 
 typedef struct SMC_SIslands_MCArbDramTimingRegisters SMC_SIslands_MCArbDramTimingRegisters;
 
-struct SMC_SISLANDS_SPLL_DIV_TABLE
-{
+struct SMC_SISLANDS_SPLL_DIV_TABLE {
     uint32_t    freq[256];
     uint32_t    ss[256];
 };
@@ -374,8 +354,7 @@ typedef struct SMC_SISLANDS_SPLL_DIV_TABLE SMC_SISLANDS_SPLL_DIV_TABLE;
 
 #define SMC_SISLANDS_DTE_MAX_TEMPERATURE_DEPENDENT_ARRAY_SIZE 16
 
-struct Smc_SIslands_DTE_Configuration
-{
+struct Smc_SIslands_DTE_Configuration {
     uint32_t tau[SMC_SISLANDS_DTE_MAX_FILTER_STAGES];
     uint32_t R[SMC_SISLANDS_DTE_MAX_FILTER_STAGES];
     uint32_t K;
-- 
2.17.1

