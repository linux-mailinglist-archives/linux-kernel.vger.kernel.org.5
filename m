Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BFE76C221
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHBBXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHBBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:23:12 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2533C139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:23:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436496|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00356363-8.25022e-05-0.996354;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6IxzhY_1690939383;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6IxzhY_1690939383)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:23:05 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu71.h
Date:   Wed,  2 Aug 2023 01:23:02 +0000
Message-Id: <20230802012302.8498-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
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
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h | 22 +++++++-------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
index 71c9b2d28640..b5f177412769 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
@@ -118,8 +118,7 @@ typedef struct {
 
 #endif
 
-struct SMU71_PIDController
-{
+struct SMU71_PIDController {
     uint32_t Ki;
     int32_t LFWindupUpperLim;
     int32_t LFWindupLowerLim;
@@ -133,8 +132,7 @@ struct SMU71_PIDController
 
 typedef struct SMU71_PIDController SMU71_PIDController;
 
-struct SMU7_LocalDpmScoreboard
-{
+struct SMU7_LocalDpmScoreboard {
     uint32_t PercentageBusy;
 
     int32_t  PIDError;
@@ -179,8 +177,8 @@ struct SMU7_LocalDpmScoreboard
     uint8_t  DteClampMode;
     uint8_t  FpsClampMode;
 
-    uint16_t LevelResidencyCounters [SMU71_MAX_LEVELS_GRAPHICS];
-    uint16_t LevelSwitchCounters [SMU71_MAX_LEVELS_GRAPHICS];
+    uint16_t LevelResidencyCounters[SMU71_MAX_LEVELS_GRAPHICS];
+    uint16_t LevelSwitchCounters[SMU71_MAX_LEVELS_GRAPHICS];
 
     void     (*TargetStateCalculator)(uint8_t);
     void     (*SavedTargetStateCalculator)(uint8_t);
@@ -200,8 +198,7 @@ typedef struct SMU7_LocalDpmScoreboard SMU7_LocalDpmScoreboard;
 
 #define SMU7_MAX_VOLTAGE_CLIENTS 12
 
-struct SMU7_VoltageScoreboard
-{
+struct SMU7_VoltageScoreboard {
     uint16_t CurrentVoltage;
     uint16_t HighestVoltage;
     uint16_t MaxVid;
@@ -325,8 +322,7 @@ typedef struct SMU7_PowerScoreboard SMU7_PowerScoreboard;
 
 // --------------------------------------------------------------------------------------------------
 
-struct SMU7_ThermalScoreboard
-{
+struct SMU7_ThermalScoreboard {
    int16_t  GpuLimit;
    int16_t  GpuHyst;
    uint16_t CurrGnbTemp;
@@ -360,8 +356,7 @@ typedef struct SMU7_ThermalScoreboard SMU7_ThermalScoreboard;
 #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
 
 // All 'soft registers' should be uint32_t.
-struct SMU71_SoftRegisters
-{
+struct SMU71_SoftRegisters {
     uint32_t        RefClockFrequency;
     uint32_t        PmTimerPeriod;
     uint32_t        FeatureEnables;
@@ -413,8 +408,7 @@ struct SMU71_SoftRegisters
 
 typedef struct SMU71_SoftRegisters SMU71_SoftRegisters;
 
-struct SMU71_Firmware_Header
-{
+struct SMU71_Firmware_Header {
     uint32_t Digest[5];
     uint32_t Version;
     uint32_t HeaderSize;
-- 
2.17.1

