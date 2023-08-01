Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300DA76A78D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHADh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHADhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:37:54 -0400
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452EAD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:37:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07608756|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00974679-0.00027722-0.989976;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5KM4oz_1690861062;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5KM4oz_1690861062)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 11:37:44 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega10_powertune.c
Date:   Tue,  1 Aug 2023 03:37:41 +0000
Message-Id: <20230801033741.5664-1-sunran001@208suo.com>
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
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_powertune.c | 89 +++++++------------
 1 file changed, 31 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
index 309a9d3bc1b7..3007b054c873 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
@@ -30,8 +30,7 @@
 #include "pp_debug.h"
 #include "soc15_common.h"
 
-static const struct vega10_didt_config_reg SEDiDtTuningCtrlConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtTuningCtrlConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -55,8 +54,7 @@ static const struct vega10_didt_config_reg SEDiDtTuningCtrlConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEDiDtCtrl3Config_vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtCtrl3Config_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset               Mask                                                     Shift                                                            Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -120,8 +118,7 @@ static const struct vega10_didt_config_reg SEDiDtCtrl3Config_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEDiDtCtrl2Config_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtCtrl2Config_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                            Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -149,8 +146,7 @@ static const struct vega10_didt_config_reg SEDiDtCtrl2Config_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEDiDtCtrl1Config_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtCtrl1Config_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -172,8 +168,7 @@ static const struct vega10_didt_config_reg SEDiDtCtrl1Config_Vega10[] =
 };
 
 
-static const struct vega10_didt_config_reg SEDiDtWeightConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtWeightConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                  Shift                                                 Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -201,8 +196,7 @@ static const struct vega10_didt_config_reg SEDiDtWeightConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEDiDtCtrl0Config_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtCtrl0Config_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -260,8 +254,7 @@ static const struct vega10_didt_config_reg SEDiDtCtrl0Config_Vega10[] =
 };
 
 
-static const struct vega10_didt_config_reg SEDiDtStallCtrlConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtStallCtrlConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                   Mask                                                     Shift                                                      Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -293,8 +286,7 @@ static const struct vega10_didt_config_reg SEDiDtStallCtrlConfig_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEDiDtStallPatternConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg SEDiDtStallPatternConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                        Mask                                                      Shift                                                    Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -362,8 +354,7 @@ static const struct vega10_didt_config_reg SEDiDtStallPatternConfig_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SELCacConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SELCacConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -401,8 +392,7 @@ static const struct vega10_didt_config_reg SELCacConfig_Vega10[] =
 };
 
 
-static const struct vega10_didt_config_reg SEEDCStallPatternConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCStallPatternConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -431,8 +421,7 @@ static const struct vega10_didt_config_reg SEEDCStallPatternConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEEDCForceStallPatternConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCForceStallPatternConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -451,8 +440,7 @@ static const struct vega10_didt_config_reg SEEDCForceStallPatternConfig_Vega10[]
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEEDCStallDelayConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCStallDelayConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -478,8 +466,7 @@ static const struct vega10_didt_config_reg SEEDCStallDelayConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEEDCThresholdConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCThresholdConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -492,8 +479,7 @@ static const struct vega10_didt_config_reg SEEDCThresholdConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEEDCCtrlResetConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCCtrlResetConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -514,8 +500,7 @@ static const struct vega10_didt_config_reg SEEDCCtrlResetConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEEDCCtrlConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCCtrlConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -536,8 +521,7 @@ static const struct vega10_didt_config_reg SEEDCCtrlConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg SEEDCCtrlForceStallConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg SEEDCCtrlForceStallConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -571,8 +555,7 @@ static const struct vega10_didt_config_reg SEEDCCtrlForceStallConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg    GCDiDtDroopCtrlConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg    GCDiDtDroopCtrlConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -586,8 +569,7 @@ static const struct vega10_didt_config_reg    GCDiDtDroopCtrlConfig_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg    GCDiDtCtrl0Config_vega10[] =
-{
+static const struct vega10_didt_config_reg    GCDiDtCtrl0Config_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -601,8 +583,7 @@ static const struct vega10_didt_config_reg    GCDiDtCtrl0Config_vega10[] =
 };
 
 
-static const struct vega10_didt_config_reg   PSMSEEDCStallPatternConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMSEEDCStallPatternConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -621,8 +602,7 @@ static const struct vega10_didt_config_reg   PSMSEEDCStallPatternConfig_Vega10[]
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMSEEDCStallDelayConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMSEEDCStallDelayConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -651,8 +631,7 @@ static const struct vega10_didt_config_reg   PSMSEEDCStallDelayConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMSEEDCCtrlResetConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMSEEDCCtrlResetConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -673,8 +652,7 @@ static const struct vega10_didt_config_reg   PSMSEEDCCtrlResetConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMSEEDCCtrlConfig_Vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMSEEDCCtrlConfig_Vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -695,8 +673,7 @@ static const struct vega10_didt_config_reg   PSMSEEDCCtrlConfig_Vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMGCEDCDroopCtrlConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMGCEDCDroopCtrlConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -710,8 +687,7 @@ static const struct vega10_didt_config_reg   PSMGCEDCDroopCtrlConfig_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMGCEDCCtrlResetConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMGCEDCCtrlResetConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -726,8 +702,7 @@ static const struct vega10_didt_config_reg   PSMGCEDCCtrlResetConfig_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg   PSMGCEDCCtrlConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg   PSMGCEDCCtrlConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -742,8 +717,7 @@ static const struct vega10_didt_config_reg   PSMGCEDCCtrlConfig_vega10[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg    AvfsPSMResetConfig_vega10[]=
-{
+static const struct vega10_didt_config_reg    AvfsPSMResetConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -756,8 +730,7 @@ static const struct vega10_didt_config_reg    AvfsPSMResetConfig_vega10[]=
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct vega10_didt_config_reg    AvfsPSMInitConfig_vega10[] =
-{
+static const struct vega10_didt_config_reg    AvfsPSMInitConfig_vega10[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                 Shift                                                  Value
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -919,7 +892,7 @@ static int vega10_enable_cac_driving_se_didt_config(struct pp_hwmgr *hwmgr)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
-		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
+		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | (count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 
 		result =  vega10_program_didt_config_registers(hwmgr, SEDiDtStallCtrlConfig_vega10, VEGA10_CONFIGREG_DIDT);
@@ -970,7 +943,7 @@ static int vega10_enable_psm_gc_didt_config(struct pp_hwmgr *hwmgr)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
-		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
+		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | (count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 
 		result = vega10_program_didt_config_registers(hwmgr, SEDiDtStallCtrlConfig_vega10, VEGA10_CONFIGREG_DIDT);
@@ -1031,7 +1004,7 @@ static int vega10_enable_se_edc_config(struct pp_hwmgr *hwmgr)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
-		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
+		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | (count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 		result = vega10_program_didt_config_registers(hwmgr, SEDiDtWeightConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 		result |= vega10_program_didt_config_registers(hwmgr, SEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
@@ -1081,7 +1054,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
-		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
+		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | (count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 		result = vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);
-- 
2.17.1

