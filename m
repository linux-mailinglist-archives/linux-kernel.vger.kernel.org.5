Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4350F76B036
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHAKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjHAKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:00:47 -0400
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16371BD3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:00:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0317584-1.51847e-05-0.968226;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5tYPZM_1690884025;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5tYPZM_1690884025)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 18:00:27 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu73_discrete.h
Date:   Tue,  1 Aug 2023 10:00:24 +0000
Message-Id: <20230801100024.8215-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line
ERROR: trailing whitespace
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../drm/amd/pm/powerplay/inc/smu73_discrete.h | 73 ++++++++-----------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
index 5916be08a7fe..fd0964ac465e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
@@ -27,8 +27,7 @@
 
 #pragma pack(push, 1)
 
-struct SMIO_Pattern
-{
+struct SMIO_Pattern {
   uint16_t Voltage;
   uint8_t  Smio;
   uint8_t  padding;
@@ -36,8 +35,7 @@ struct SMIO_Pattern
 
 typedef struct SMIO_Pattern SMIO_Pattern;
 
-struct SMIO_Table
-{
+struct SMIO_Table {
   SMIO_Pattern Pattern[SMU_MAX_SMIO_LEVELS];
 };
 
@@ -100,8 +98,7 @@ struct SMU73_Discrete_Ulv {
 
 typedef struct SMU73_Discrete_Ulv SMU73_Discrete_Ulv;
 
-struct SMU73_Discrete_MemoryLevel
-{
+struct SMU73_Discrete_MemoryLevel {
     uint32_t MinVoltage;
     uint32_t    MinMvdd;
 
@@ -124,10 +121,9 @@ struct SMU73_Discrete_MemoryLevel
 
 typedef struct SMU73_Discrete_MemoryLevel SMU73_Discrete_MemoryLevel;
 
-struct SMU73_Discrete_LinkLevel
-{
+struct SMU73_Discrete_LinkLevel {
     uint8_t     PcieGenSpeed;           ///< 0:PciE-gen1 1:PciE-gen2 2:PciE-gen3
-    uint8_t     PcieLaneCount;          ///< 1=x1, 2=x2, 3=x4, 4=x8, 5=x12, 6=x16 
+    uint8_t     PcieLaneCount;          ///< 1=x1, 2=x2, 3=x4, 4=x8, 5=x12, 6=x16
     uint8_t     EnabledForActivity;
     uint8_t     SPC;
     uint32_t    DownThreshold;
@@ -139,8 +135,7 @@ typedef struct SMU73_Discrete_LinkLevel SMU73_Discrete_LinkLevel;
 
 
 // MC ARB DRAM Timing registers.
-struct SMU73_Discrete_MCArbDramTimingTableEntry
-{
+struct SMU73_Discrete_MCArbDramTimingTableEntry {
     uint32_t McArbDramTiming;
     uint32_t McArbDramTiming2;
     uint8_t  McArbBurstTime;
@@ -151,16 +146,14 @@ struct SMU73_Discrete_MCArbDramTimingTableEntry
 
 typedef struct SMU73_Discrete_MCArbDramTimingTableEntry SMU73_Discrete_MCArbDramTimingTableEntry;
 
-struct SMU73_Discrete_MCArbDramTimingTable
-{
+struct SMU73_Discrete_MCArbDramTimingTable {
     SMU73_Discrete_MCArbDramTimingTableEntry entries[SMU__NUM_SCLK_DPM_STATE][SMU__NUM_MCLK_DPM_LEVELS];
 };
 
 typedef struct SMU73_Discrete_MCArbDramTimingTable SMU73_Discrete_MCArbDramTimingTable;
 
 // UVD VCLK/DCLK state (level) definition.
-struct SMU73_Discrete_UvdLevel
-{
+struct SMU73_Discrete_UvdLevel {
     uint32_t VclkFrequency;
     uint32_t DclkFrequency;
     uint32_t MinVoltage;
@@ -172,8 +165,7 @@ struct SMU73_Discrete_UvdLevel
 typedef struct SMU73_Discrete_UvdLevel SMU73_Discrete_UvdLevel;
 
 // Clocks for other external blocks (VCE, ACP, SAMU).
-struct SMU73_Discrete_ExtClkLevel
-{
+struct SMU73_Discrete_ExtClkLevel {
     uint32_t Frequency;
     uint32_t MinVoltage;
     uint8_t  Divider;
@@ -182,8 +174,7 @@ struct SMU73_Discrete_ExtClkLevel
 
 typedef struct SMU73_Discrete_ExtClkLevel SMU73_Discrete_ExtClkLevel;
 
-struct SMU73_Discrete_StateInfo
-{
+struct SMU73_Discrete_StateInfo {
     uint32_t SclkFrequency;
     uint32_t MclkFrequency;
     uint32_t VclkFrequency;
@@ -206,8 +197,7 @@ struct SMU73_Discrete_StateInfo
 
 typedef struct SMU73_Discrete_StateInfo SMU73_Discrete_StateInfo;
 
-struct SMU73_Discrete_DpmTable
-{
+struct SMU73_Discrete_DpmTable {
     // Multi-DPM controller settings
     SMU73_PIDController                  GraphicsPIDController;
     SMU73_PIDController                  MemoryPIDController;
@@ -225,9 +215,9 @@ struct SMU73_Discrete_DpmTable
     uint32_t                            MvddLevelCount;
 
 
-    uint8_t                             BapmVddcVidHiSidd        [SMU73_MAX_LEVELS_VDDC];
-    uint8_t                             BapmVddcVidLoSidd        [SMU73_MAX_LEVELS_VDDC];
-    uint8_t                             BapmVddcVidHiSidd2       [SMU73_MAX_LEVELS_VDDC];
+    uint8_t                             BapmVddcVidHiSidd[SMU73_MAX_LEVELS_VDDC];
+    uint8_t                             BapmVddcVidLoSidd[SMU73_MAX_LEVELS_VDDC];
+    uint8_t                             BapmVddcVidHiSidd2[SMU73_MAX_LEVELS_VDDC];
 
     uint8_t                             GraphicsDpmLevelCount;
     uint8_t                             MemoryDpmLevelCount;
@@ -246,19 +236,19 @@ struct SMU73_Discrete_DpmTable
     uint32_t                            Reserved[4];
 
     // State table entries for each DPM state
-    SMU73_Discrete_GraphicsLevel        GraphicsLevel           [SMU73_MAX_LEVELS_GRAPHICS];
+    SMU73_Discrete_GraphicsLevel        GraphicsLevel[SMU73_MAX_LEVELS_GRAPHICS];
     SMU73_Discrete_MemoryLevel          MemoryACPILevel;
-    SMU73_Discrete_MemoryLevel          MemoryLevel             [SMU73_MAX_LEVELS_MEMORY];
-    SMU73_Discrete_LinkLevel            LinkLevel               [SMU73_MAX_LEVELS_LINK];
+    SMU73_Discrete_MemoryLevel          MemoryLevel[SMU73_MAX_LEVELS_MEMORY];
+    SMU73_Discrete_LinkLevel            LinkLevel[SMU73_MAX_LEVELS_LINK];
     SMU73_Discrete_ACPILevel            ACPILevel;
-    SMU73_Discrete_UvdLevel             UvdLevel                [SMU73_MAX_LEVELS_UVD];
-    SMU73_Discrete_ExtClkLevel          VceLevel                [SMU73_MAX_LEVELS_VCE];
-    SMU73_Discrete_ExtClkLevel          AcpLevel                [SMU73_MAX_LEVELS_ACP];
-    SMU73_Discrete_ExtClkLevel          SamuLevel               [SMU73_MAX_LEVELS_SAMU];
+    SMU73_Discrete_UvdLevel             UvdLevel[SMU73_MAX_LEVELS_UVD];
+    SMU73_Discrete_ExtClkLevel          VceLevel[SMU73_MAX_LEVELS_VCE];
+    SMU73_Discrete_ExtClkLevel          AcpLevel[SMU73_MAX_LEVELS_ACP];
+    SMU73_Discrete_ExtClkLevel          SamuLevel[SMU73_MAX_LEVELS_SAMU];
     SMU73_Discrete_Ulv                  Ulv;
 
     uint32_t                            SclkStepSize;
-    uint32_t                            Smio                    [SMU73_MAX_ENTRIES_SMIO];
+    uint32_t                            Smio[SMU73_MAX_ENTRIES_SMIO];
 
     uint8_t                             UvdBootLevel;
     uint8_t                             VceBootLevel;
@@ -368,8 +358,7 @@ typedef struct SMU73_Discrete_DpmTable SMU73_Discrete_DpmTable;
 
 
 // --------------------------------------------------- Fan Table -----------------------------------------------------------
-struct SMU73_Discrete_FanTable
-{
+struct SMU73_Discrete_FanTable {
     uint16_t FdoMode;
     int16_t  TempMin;
     int16_t  TempMed;
@@ -397,8 +386,7 @@ typedef struct SMU73_Discrete_FanTable SMU73_Discrete_FanTable;
 
 
 
-struct SMU7_MclkDpmScoreboard
-{
+struct SMU7_MclkDpmScoreboard {
 
     uint32_t PercentageBusy;
 
@@ -448,8 +436,8 @@ struct SMU7_MclkDpmScoreboard
     uint8_t  VbiWaitCounter;
     uint8_t  EnabledLevelsChange;
 
-    uint16_t LevelResidencyCounters [SMU73_MAX_LEVELS_MEMORY];
-    uint16_t LevelSwitchCounters [SMU73_MAX_LEVELS_MEMORY];
+    uint16_t LevelResidencyCounters[SMU73_MAX_LEVELS_MEMORY];
+    uint16_t LevelSwitchCounters[SMU73_MAX_LEVELS_MEMORY];
 
     void     (*TargetStateCalculator)(uint8_t);
     void     (*SavedTargetStateCalculator)(uint8_t);
@@ -469,8 +457,7 @@ struct SMU7_MclkDpmScoreboard
 
 typedef struct SMU7_MclkDpmScoreboard SMU7_MclkDpmScoreboard;
 
-struct SMU7_UlvScoreboard
-{
+struct SMU7_UlvScoreboard {
     uint8_t     EnterUlv;
     uint8_t     ExitUlv;
     uint8_t     UlvActive;
@@ -485,8 +472,7 @@ struct SMU7_UlvScoreboard
 
 typedef struct SMU7_UlvScoreboard SMU7_UlvScoreboard;
 
-struct VddgfxSavedRegisters
-{
+struct VddgfxSavedRegisters {
   uint32_t GPU_DBG[3];
   uint32_t MEC_BaseAddress_Hi;
   uint32_t MEC_BaseAddress_Lo;
@@ -497,8 +483,7 @@ struct VddgfxSavedRegisters
 
 typedef struct VddgfxSavedRegisters VddgfxSavedRegisters;
 
-struct SMU7_VddGfxScoreboard
-{
+struct SMU7_VddGfxScoreboard {
     uint8_t     VddGfxEnable;
     uint8_t     VddGfxActive;
     uint8_t     VPUResetOccured;
-- 
2.17.1

