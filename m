Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC91C76AFA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjHAJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHAJtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:49:16 -0400
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228A2D65
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:47:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07778209|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00228266-0.000301776-0.997416;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5t4Bqw_1690883263;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5t4Bqw_1690883263)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:47:46 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in polaris_baco.c
Date:   Tue,  1 Aug 2023 09:47:42 +0000
Message-Id: <20230801094742.8032-1-sunran001@208suo.com>
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
 .../drm/amd/pm/powerplay/hwmgr/polaris_baco.c | 30 +++++++------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
index 8f8e296f2fe9..a6a6d43b09f8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
@@ -35,8 +35,7 @@
 #include "smu/smu_7_1_3_d.h"
 #include "smu/smu_7_1_3_sh_mask.h"
 
-static const struct baco_cmd_entry gpio_tbl[] =
-{
+static const struct baco_cmd_entry gpio_tbl[] = {
 	{ CMD_WRITE, mmGPIOPAD_EN, 0, 0, 0, 0x0 },
 	{ CMD_WRITE, mmGPIOPAD_PD_EN, 0, 0, 0, 0x0 },
 	{ CMD_WRITE, mmGPIOPAD_PU_EN, 0, 0, 0, 0x0 },
@@ -49,15 +48,13 @@ static const struct baco_cmd_entry gpio_tbl[] =
 	{ CMD_READMODIFYWRITE, mmDC_GPIO_SYNCA_MASK, 0, 0, 0, 0x00001111 }
 };
 
-static const struct baco_cmd_entry enable_fb_req_rej_tbl[] =
-{
+static const struct baco_cmd_entry enable_fb_req_rej_tbl[] = {
 	{ CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, 0xC0300024 },
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, 0x1, 0x0, 0, 0x1 },
 	{ CMD_WRITE, mmBIF_FB_EN, 0, 0, 0, 0x0 }
 };
 
-static const struct baco_cmd_entry use_bclk_tbl[] =
-{
+static const struct baco_cmd_entry use_bclk_tbl[] = {
 	{ CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL },
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPLL_BYPASS_EN_MASK, CG_SPLL_FUNC_CNTL__SPLL_BYPASS_EN__SHIFT, 0, 0x1 },
 	{ CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, 0xC0500170 },
@@ -70,8 +67,7 @@ static const struct baco_cmd_entry use_bclk_tbl[] =
 	{ CMD_READMODIFYWRITE, mmMPLL_CNTL_MODE, MPLL_CNTL_MODE__MPLL_MCLK_SEL_MASK, MPLL_CNTL_MODE__MPLL_MCLK_SEL__SHIFT, 0, 0x0 }
 };
 
-static const struct baco_cmd_entry turn_off_plls_tbl[] =
-{
+static const struct baco_cmd_entry turn_off_plls_tbl[] = {
 	{ CMD_READMODIFYWRITE, mmDC_GPIO_PAD_STRENGTH_1, DC_GPIO_PAD_STRENGTH_1__GENLK_STRENGTH_SP_MASK, DC_GPIO_PAD_STRENGTH_1__GENLK_STRENGTH_SP__SHIFT, 0, 0x1 },
 	{ CMD_DELAY_US, 0, 0, 0, 1, 0x0 },
 	{ CMD_READMODIFYWRITE, mmMC_SEQ_DRAM, MC_SEQ_DRAM__RST_CTL_MASK, MC_SEQ_DRAM__RST_CTL__SHIFT, 0, 0x1 },
@@ -92,8 +88,7 @@ static const struct baco_cmd_entry turn_off_plls_tbl[] =
 	{ CMD_DELAY_US, 0, 0, 0, 5, 0x0 }
 };
 
-static const struct baco_cmd_entry clk_req_b_tbl[] =
-{
+static const struct baco_cmd_entry clk_req_b_tbl[] = {
 	{ CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixTHM_CLK_CNTL },
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, THM_CLK_CNTL__CMON_CLK_SEL_MASK, THM_CLK_CNTL__CMON_CLK_SEL__SHIFT, 0, 0x1 },
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, THM_CLK_CNTL__TMON_CLK_SEL_MASK, THM_CLK_CNTL__TMON_CLK_SEL__SHIFT, 0, 0x1 },
@@ -108,8 +103,7 @@ static const struct baco_cmd_entry clk_req_b_tbl[] =
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL_MASK, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL__SHIFT, 0,     0x4 }
 };
 
-static const struct baco_cmd_entry enter_baco_tbl[] =
-{
+static const struct baco_cmd_entry enter_baco_tbl[] = {
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x01 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BIF_SCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_SCLK_SWITCH__SHIFT, 0, 0x01 },
 	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_BIF_SCLK_SWITCH_MASK, 0, 5, 0x40000 },
@@ -126,8 +120,7 @@ static const struct baco_cmd_entry enter_baco_tbl[] =
 
 #define BACO_CNTL__PWRGOOD_MASK  BACO_CNTL__PWRGOOD_GPIO_MASK+BACO_CNTL__PWRGOOD_MEM_MASK+BACO_CNTL__PWRGOOD_DVO_MASK
 
-static const struct baco_cmd_entry exit_baco_tbl[] =
-{
+static const struct baco_cmd_entry exit_baco_tbl[] = {
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x01 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK, BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
@@ -142,14 +135,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
 	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0x00 }
 };
 
-static const struct baco_cmd_entry clean_baco_tbl[] =
-{
+static const struct baco_cmd_entry clean_baco_tbl[] = {
 	{ CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
 	{ CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 }
 };
 
-static const struct baco_cmd_entry use_bclk_tbl_vg[] =
-{
+static const struct baco_cmd_entry use_bclk_tbl_vg[] = {
 	{ CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, ixCG_SPLL_FUNC_CNTL },
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, CG_SPLL_FUNC_CNTL__SPLL_BYPASS_EN_MASK, CG_SPLL_FUNC_CNTL__SPLL_BYPASS_EN__SHIFT, 0, 0x1 },
 	{ CMD_WRITE, mmGCK_SMC_IND_INDEX, 0, 0, 0, 0xC0500170 },
@@ -160,8 +151,7 @@ static const struct baco_cmd_entry use_bclk_tbl_vg[] =
 	{ CMD_READMODIFYWRITE, mmGCK_SMC_IND_DATA, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL_MASK, MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL__SHIFT, 0, 0x2 }
 };
 
-static const struct baco_cmd_entry turn_off_plls_tbl_vg[] =
-{
+static const struct baco_cmd_entry turn_off_plls_tbl_vg[] = {
 	{ CMD_READMODIFYWRITE, mmDC_GPIO_PAD_STRENGTH_1, DC_GPIO_PAD_STRENGTH_1__GENLK_STRENGTH_SP_MASK, DC_GPIO_PAD_STRENGTH_1__GENLK_STRENGTH_SP__SHIFT, 0, 0x1 },
 	{ CMD_DELAY_US, 0, 0, 0, 1, 0x0 },
 	{ CMD_READMODIFYWRITE, mmMC_SEQ_DRAM, MC_SEQ_DRAM__RST_CTL_MASK, MC_SEQ_DRAM__RST_CTL__SHIFT, 0, 0x1 },
-- 
2.17.1

