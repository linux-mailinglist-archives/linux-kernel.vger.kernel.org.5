Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7976A728
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjHACp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHACpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:45:23 -0400
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360081FF5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:44:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1403262|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0171721-0.000360176-0.982468;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5HG1hv_1690857889;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5HG1hv_1690857889)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:44:51 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega10_baco.c
Date:   Tue,  1 Aug 2023 02:44:48 +0000
Message-Id: <20230801024448.4848-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space required after that ',' (ctx:VxV)
ERROR: space prohibited before that ',' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_baco.c  | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
index 46bb16c29cf6..6836e98d37be 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
@@ -31,24 +31,22 @@
 
 
 
-static const struct soc15_baco_cmd_entry  pre_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry  pre_baco_tbl[] = {
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIF_DOORBELL_CNTL), BIF_DOORBELL_CNTL__DOORBELL_MONITOR_EN_MASK, BIF_DOORBELL_CNTL__DOORBELL_MONITOR_EN__SHIFT, 0, 1},
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIF_FB_EN), 0, 0, 0, 0},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_DSTATE_BYPASS_MASK, BACO_CNTL__BACO_DSTATE_BYPASS__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_RST_INTR_MASK_MASK, BACO_CNTL__BACO_RST_INTR_MASK__SHIFT, 0, 1}
 };
 
-static const struct soc15_baco_cmd_entry enter_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry enter_baco_tbl[] = {
 	{CMD_WAITFOR, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__SOC_DOMAIN_IDLE_MASK, THM_BACO_CNTL__SOC_DOMAIN_IDLE__SHIFT, 0xffffffff, 0x80000000},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_BIF_LCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_DUMMY_EN_MASK, BACO_CNTL__BACO_DUMMY_EN__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SOC_VDCI_RESET_MASK, THM_BACO_CNTL__BACO_SOC_VDCI_RESET__SHIFT, 0, 1},
-	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SMNCLK_MUX_MASK, THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT,0, 1},
+	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SMNCLK_MUX_MASK, THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_ISO_EN_MASK, THM_BACO_CNTL__BACO_ISO_EN__SHIFT, 0, 1},
-	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT,0, 1},
+	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_ANA_ISO_EN_MASK, THM_BACO_CNTL__BACO_ANA_ISO_EN__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK,     THM_BACO_CNTL__BACO_SOC_REFCLK_OFF__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 1},
@@ -58,13 +56,12 @@ static const struct soc15_baco_cmd_entry enter_baco_tbl[] =
 	{CMD_WAITFOR, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_MODE_MASK, BACO_CNTL__BACO_MODE__SHIFT, 0xffffffff, 0x100}
 };
 
-static const struct soc15_baco_cmd_entry exit_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry exit_baco_tbl[] = {
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0},
-	{CMD_DELAY_MS, 0, 0, 0, 0, 0, 0, 10,0},
-	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF__SHIFT, 0,0},
+	{CMD_DELAY_MS, 0, 0, 0, 0, 0, 0, 10, 0},
+	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF__SHIFT, 0, 0},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_ANA_ISO_EN_MASK, THM_BACO_CNTL__BACO_ANA_ISO_EN__SHIFT, 0, 0},
-	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT,0, 0},
+	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT, 0, 0},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_ISO_EN_MASK, THM_BACO_CNTL__BACO_ISO_EN__SHIFT, 0, 0},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_PWROKRAW_CNTL_MASK, THM_BACO_CNTL__BACO_PWROKRAW_CNTL__SHIFT, 0, 1},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SMNCLK_MUX_MASK, THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT, 0, 0},
@@ -74,13 +71,12 @@ static const struct soc15_baco_cmd_entry exit_baco_tbl[] =
 	{CMD_WAITFOR, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_EXIT_MASK, 0, 0xffffffff, 0},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_CNTL__BACO_SB_AXI_FENCE_MASK, THM_BACO_CNTL__BACO_SB_AXI_FENCE__SHIFT, 0, 0},
 	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_DUMMY_EN_MASK, BACO_CNTL__BACO_DUMMY_EN__SHIFT,  0, 0},
-	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_BIF_LCLK_SWITCH_MASK ,BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0, 0},
-	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_EN_MASK , BACO_CNTL__BACO_EN__SHIFT, 0,0},
+	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_BIF_LCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0, 0},
+	{CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0},
 	{CMD_WAITFOR, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0}
  };
 
-static const struct soc15_baco_cmd_entry clean_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0, 0, 0, 0},
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
-- 
2.17.1

