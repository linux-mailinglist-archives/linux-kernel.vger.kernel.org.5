Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586BE76A8B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHAGJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHAGJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:09:47 -0400
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537D10C1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:09:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1864641|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0136917-0.000435556-0.985873;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5fuMlm_1690870177;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5fuMlm_1690870177)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 14:09:39 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega12_baco.c
Date:   Tue,  1 Aug 2023 06:09:37 +0000
Message-Id: <20230801060937.6178-1-sunran001@208suo.com>
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

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
index bc53cce4f32d..32cc8de296e4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
@@ -29,16 +29,14 @@
 #include "vega12_ppsmc.h"
 #include "vega12_baco.h"
 
-static const struct soc15_baco_cmd_entry  pre_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry  pre_baco_tbl[] = {
 	{ CMD_READMODIFYWRITE, NBIF_HWID, 0, mmBIF_DOORBELL_CNTL_BASE_IDX, mmBIF_DOORBELL_CNTL, BIF_DOORBELL_CNTL__DOORBELL_MONITOR_EN_MASK, BIF_DOORBELL_CNTL__DOORBELL_MONITOR_EN__SHIFT, 0, 0 },
 	{ CMD_WRITE, NBIF_HWID, 0, mmBIF_FB_EN_BASE_IDX, mmBIF_FB_EN, 0, 0, 0, 0 },
 	{ CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_DSTATE_BYPASS_MASK, BACO_CNTL__BACO_DSTATE_BYPASS__SHIFT, 0, 1 },
 	{ CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_RST_INTR_MASK_MASK, BACO_CNTL__BACO_RST_INTR_MASK__SHIFT, 0, 1 }
 };
 
-static const struct soc15_baco_cmd_entry enter_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry enter_baco_tbl[] = {
 	{ CMD_WAITFOR, THM_HWID, 0, mmTHM_BACO_CNTL_BASE_IDX, mmTHM_BACO_CNTL, THM_BACO_CNTL__SOC_DOMAIN_IDLE_MASK, THM_BACO_CNTL__SOC_DOMAIN_IDLE__SHIFT, 0xffffffff, 0x80000000 },
 	{ CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 1 },
 	{ CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_BIF_LCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0, 1 },
@@ -56,8 +54,7 @@ static const struct soc15_baco_cmd_entry enter_baco_tbl[] =
 	{ CMD_WAITFOR, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, BACO_CNTL__BACO_MODE__SHIFT, 0xffffffff, 0x100 }
 };
 
-static const struct soc15_baco_cmd_entry exit_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry exit_baco_tbl[] = {
 	{ CMD_READMODIFYWRITE, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0 },
 	{ CMD_DELAY_MS, 0, 0, 0, 0, 0, 0, 10, 0 },
 	{ CMD_READMODIFYWRITE, THM_HWID, 0, mmTHM_BACO_CNTL_BASE_IDX, mmTHM_BACO_CNTL, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF__SHIFT, 0, 0 },
@@ -77,8 +74,7 @@ static const struct soc15_baco_cmd_entry exit_baco_tbl[] =
 	{ CMD_WAITFOR, NBIF_HWID, 0, mmRCC_BACO_CNTL_MISC_BASE_IDX, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0 }
 };
 
-static const struct soc15_baco_cmd_entry clean_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{ CMD_WRITE, NBIF_HWID, 0, mmBIOS_SCRATCH_6_BASE_IDX, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
 	{ CMD_WRITE, NBIF_HWID, 0, mmBIOS_SCRATCH_7_BASE_IDX, mmBIOS_SCRATCH_7, 0, 0, 0, 0 }
 };
-- 
2.17.1

