Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43BD76C60F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjHBHED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHBHEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:04:01 -0400
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ADF1985
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:03:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08088165|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.365273-0.011224-0.623503;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Zm35v_1690959829;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Zm35v_1690959829)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:03:51 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in dce_v10_0.c
Date:   Wed,  2 Aug 2023 07:03:48 +0000
Message-Id: <20230802070348.12538-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 30 +++++++++-----------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 9a24ed463abd..584cd5277f92 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -52,8 +52,7 @@
 static void dce_v10_0_set_display_funcs(struct amdgpu_device *adev);
 static void dce_v10_0_set_irq_funcs(struct amdgpu_device *adev);
 
-static const u32 crtc_offsets[] =
-{
+static const u32 crtc_offsets[] = {
 	CRTC0_REGISTER_OFFSET,
 	CRTC1_REGISTER_OFFSET,
 	CRTC2_REGISTER_OFFSET,
@@ -63,8 +62,7 @@ static const u32 crtc_offsets[] =
 	CRTC6_REGISTER_OFFSET
 };
 
-static const u32 hpd_offsets[] =
-{
+static const u32 hpd_offsets[] = {
 	HPD0_REGISTER_OFFSET,
 	HPD1_REGISTER_OFFSET,
 	HPD2_REGISTER_OFFSET,
@@ -121,30 +119,26 @@ static const struct {
 	.hpd = DISP_INTERRUPT_STATUS_CONTINUE5__DC_HPD6_INTERRUPT_MASK
 } };
 
-static const u32 golden_settings_tonga_a11[] =
-{
+static const u32 golden_settings_tonga_a11[] = {
 	mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
 	mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
 	mmFBC_MISC, 0x1f311fff, 0x12300000,
 	mmHDMI_CONTROL, 0x31000111, 0x00000011,
 };
 
-static const u32 tonga_mgcg_cgcg_init[] =
-{
+static const u32 tonga_mgcg_cgcg_init[] = {
 	mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
 	mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
 };
 
-static const u32 golden_settings_fiji_a10[] =
-{
+static const u32 golden_settings_fiji_a10[] = {
 	mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
 	mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
 	mmFBC_MISC, 0x1f311fff, 0x12300000,
 	mmHDMI_CONTROL, 0x31000111, 0x00000011,
 };
 
-static const u32 fiji_mgcg_cgcg_init[] =
-{
+static const u32 fiji_mgcg_cgcg_init[] = {
 	mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
 	mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
 };
@@ -1425,8 +1419,7 @@ static void dce_v10_0_audio_enable(struct amdgpu_device *adev,
 			   enable ? AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AUDIO_ENABLED_MASK : 0);
 }
 
-static const u32 pin_offsets[] =
-{
+static const u32 pin_offsets[] = {
 	AUD0_REGISTER_OFFSET,
 	AUD1_REGISTER_OFFSET,
 	AUD2_REGISTER_OFFSET,
@@ -1811,8 +1804,7 @@ static void dce_v10_0_afmt_fini(struct amdgpu_device *adev)
 	}
 }
 
-static const u32 vga_control_regs[6] =
-{
+static const u32 vga_control_regs[6] = {
 	mmD1VGA_CONTROL,
 	mmD2VGA_CONTROL,
 	mmD3VGA_CONTROL,
@@ -3651,8 +3643,7 @@ static void dce_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->hpd_irq.funcs = &dce_v10_0_hpd_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version dce_v10_0_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v10_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 10,
 	.minor = 0,
@@ -3660,8 +3651,7 @@ const struct amdgpu_ip_block_version dce_v10_0_ip_block =
 	.funcs = &dce_v10_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version dce_v10_1_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v10_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 10,
 	.minor = 1,
-- 
2.17.1

