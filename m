Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC076C239
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHBB3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHBB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:29:13 -0400
Received: from out28-90.mail.aliyun.com (out28-90.mail.aliyun.com [115.124.28.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B52102
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:29:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743626|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.0504505-0.0256508-0.923899;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6J0HG2_1690939745;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6J0HG2_1690939745)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:29:07 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu7_fusion.h
Date:   Wed,  2 Aug 2023 01:29:03 +0000
Message-Id: <20230802012903.8589-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../drm/amd/pm/powerplay/inc/smu7_fusion.h    | 42 +++++++------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
index 78ada9ffd508..e130f52fe8d6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
@@ -36,8 +36,7 @@
 #define SMU7_NUM_NON_TES 2
 
 // All 'soft registers' should be uint32_t.
-struct SMU7_SoftRegisters
-{
+struct SMU7_SoftRegisters {
     uint32_t        RefClockFrequency;
     uint32_t        PmTimerP;
     uint32_t        FeatureEnables;
@@ -80,8 +79,7 @@ struct SMU7_SoftRegisters
 
 typedef struct SMU7_SoftRegisters SMU7_SoftRegisters;
 
-struct SMU7_Fusion_GraphicsLevel
-{
+struct SMU7_Fusion_GraphicsLevel {
     uint32_t    MinVddNb;
 
     uint32_t    SclkFrequency;
@@ -111,8 +109,7 @@ struct SMU7_Fusion_GraphicsLevel
 
 typedef struct SMU7_Fusion_GraphicsLevel SMU7_Fusion_GraphicsLevel;
 
-struct SMU7_Fusion_GIOLevel
-{
+struct SMU7_Fusion_GIOLevel {
     uint8_t     EnabledForActivity;
     uint8_t     LclkDid;
     uint8_t     Vid;
@@ -137,8 +134,7 @@ struct SMU7_Fusion_GIOLevel
 typedef struct SMU7_Fusion_GIOLevel SMU7_Fusion_GIOLevel;
 
 // UVD VCLK/DCLK state (level) definition.
-struct SMU7_Fusion_UvdLevel
-{
+struct SMU7_Fusion_UvdLevel {
     uint32_t VclkFrequency;
     uint32_t DclkFrequency;
     uint16_t MinVddNb;
@@ -155,8 +151,7 @@ struct SMU7_Fusion_UvdLevel
 typedef struct SMU7_Fusion_UvdLevel SMU7_Fusion_UvdLevel;
 
 // Clocks for other external blocks (VCE, ACP, SAMU).
-struct SMU7_Fusion_ExtClkLevel
-{
+struct SMU7_Fusion_ExtClkLevel {
     uint32_t Frequency;
     uint16_t MinVoltage;
     uint8_t  Divider;
@@ -166,8 +161,7 @@ struct SMU7_Fusion_ExtClkLevel
 };
 typedef struct SMU7_Fusion_ExtClkLevel SMU7_Fusion_ExtClkLevel;
 
-struct SMU7_Fusion_ACPILevel
-{
+struct SMU7_Fusion_ACPILevel {
     uint32_t    Flags;
     uint32_t    MinVddNb;
     uint32_t    SclkFrequency;
@@ -181,8 +175,7 @@ struct SMU7_Fusion_ACPILevel
 
 typedef struct SMU7_Fusion_ACPILevel SMU7_Fusion_ACPILevel;
 
-struct SMU7_Fusion_NbDpm
-{
+struct SMU7_Fusion_NbDpm {
     uint8_t DpmXNbPsHi;
     uint8_t DpmXNbPsLo;
     uint8_t Dpm0PgNbPsHi;
@@ -197,8 +190,7 @@ struct SMU7_Fusion_NbDpm
 
 typedef struct SMU7_Fusion_NbDpm SMU7_Fusion_NbDpm;
 
-struct SMU7_Fusion_StateInfo
-{
+struct SMU7_Fusion_StateInfo {
     uint32_t SclkFrequency;
     uint32_t LclkFrequency;
     uint32_t VclkFrequency;
@@ -214,8 +206,7 @@ struct SMU7_Fusion_StateInfo
 
 typedef struct SMU7_Fusion_StateInfo SMU7_Fusion_StateInfo;
 
-struct SMU7_Fusion_DpmTable
-{
+struct SMU7_Fusion_DpmTable {
     uint32_t                            SystemFlags;
 
     SMU7_PIDController                  GraphicsPIDController;
@@ -230,12 +221,12 @@ struct SMU7_Fusion_DpmTable
     uint8_t                            SamuLevelCount;
     uint16_t                           FpsHighT;
 
-    SMU7_Fusion_GraphicsLevel         GraphicsLevel           [SMU__NUM_SCLK_DPM_STATE];
+    SMU7_Fusion_GraphicsLevel         GraphicsLevel[SMU__NUM_SCLK_DPM_STATE];
     SMU7_Fusion_ACPILevel             ACPILevel;
-    SMU7_Fusion_UvdLevel              UvdLevel                [SMU7_MAX_LEVELS_UVD];
-    SMU7_Fusion_ExtClkLevel           VceLevel                [SMU7_MAX_LEVELS_VCE];
-    SMU7_Fusion_ExtClkLevel           AcpLevel                [SMU7_MAX_LEVELS_ACP];
-    SMU7_Fusion_ExtClkLevel           SamuLevel               [SMU7_MAX_LEVELS_SAMU];
+    SMU7_Fusion_UvdLevel              UvdLevel[SMU7_MAX_LEVELS_UVD];
+    SMU7_Fusion_ExtClkLevel           VceLevel[SMU7_MAX_LEVELS_VCE];
+    SMU7_Fusion_ExtClkLevel           AcpLevel[SMU7_MAX_LEVELS_ACP];
+    SMU7_Fusion_ExtClkLevel           SamuLevel[SMU7_MAX_LEVELS_SAMU];
 
     uint8_t                           UvdBootLevel;
     uint8_t                           VceBootLevel;
@@ -266,10 +257,9 @@ struct SMU7_Fusion_DpmTable
 
 };
 
-struct SMU7_Fusion_GIODpmTable
-{
+struct SMU7_Fusion_GIODpmTable {
 
-    SMU7_Fusion_GIOLevel              GIOLevel                [SMU7_MAX_LEVELS_GIO];
+    SMU7_Fusion_GIOLevel              GIOLevel[SMU7_MAX_LEVELS_GIO];
 
     SMU7_PIDController                GioPIDController;
 
-- 
2.17.1

