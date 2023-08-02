Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03476C645
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjHBHSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHBHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:18:17 -0400
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FC1734
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:18:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07484511|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.401997-0.00104817-0.596955;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6ar1OK_1690960687;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6ar1OK_1690960687)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:18:09 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in dce_v8_0.c
Date:   Wed,  2 Aug 2023 07:18:05 +0000
Message-Id: <20230802071805.12808-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line
ERROR: code indent should use tabs where possible
ERROR: space required before the open brace '{'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 37 ++++++++++-----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index d421a268c9ff..f2b3cb5ed6be 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -53,8 +53,7 @@
 static void dce_v8_0_set_display_funcs(struct amdgpu_device *adev);
 static void dce_v8_0_set_irq_funcs(struct amdgpu_device *adev);
 
-static const u32 crtc_offsets[6] =
-{
+static const u32 crtc_offsets[6] = {
 	CRTC0_REGISTER_OFFSET,
 	CRTC1_REGISTER_OFFSET,
 	CRTC2_REGISTER_OFFSET,
@@ -63,8 +62,7 @@ static const u32 crtc_offsets[6] =
 	CRTC5_REGISTER_OFFSET
 };
 
-static const u32 hpd_offsets[] =
-{
+static const u32 hpd_offsets[] = {
 	HPD0_REGISTER_OFFSET,
 	HPD1_REGISTER_OFFSET,
 	HPD2_REGISTER_OFFSET,
@@ -1345,9 +1343,9 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 				if (sad->channels > max_channels) {
 					value = (sad->channels <<
 						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
-					        (sad->byte2 <<
+						(sad->byte2 <<
 						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
-					        (sad->freq <<
+						(sad->freq <<
 						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
 					max_channels = sad->channels;
 				}
@@ -1379,8 +1377,7 @@ static void dce_v8_0_audio_enable(struct amdgpu_device *adev,
 		enable ? AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AUDIO_ENABLED_MASK : 0);
 }
 
-static const u32 pin_offsets[7] =
-{
+static const u32 pin_offsets[7] = {
 	(0x1780 - 0x1780),
 	(0x1786 - 0x1780),
 	(0x178c - 0x1780),
@@ -1740,8 +1737,7 @@ static void dce_v8_0_afmt_fini(struct amdgpu_device *adev)
 	}
 }
 
-static const u32 vga_control_regs[6] =
-{
+static const u32 vga_control_regs[6] = {
 	mmD1VGA_CONTROL,
 	mmD2VGA_CONTROL,
 	mmD3VGA_CONTROL,
@@ -1895,9 +1891,9 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 		fb_format = ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
-		             (GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
+				(GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 		fb_swap = ((GRPH_RED_SEL_B << GRPH_SWAP_CNTL__GRPH_RED_CROSSBAR__SHIFT) |
-		           (GRPH_BLUE_SEL_R << GRPH_SWAP_CNTL__GRPH_BLUE_CROSSBAR__SHIFT));
+			(GRPH_BLUE_SEL_R << GRPH_SWAP_CNTL__GRPH_BLUE_CROSSBAR__SHIFT));
 #ifdef __BIG_ENDIAN
 		fb_swap |= (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
@@ -3151,7 +3147,7 @@ static int dce_v8_0_pageflip_irq(struct amdgpu_device *adev,
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 	works = amdgpu_crtc->pflip_works;
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
 		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
 						"AMDGPU_FLIP_SUBMITTED(%d)\n",
 						amdgpu_crtc->pflip_status,
@@ -3544,8 +3540,7 @@ static void dce_v8_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->hpd_irq.funcs = &dce_v8_0_hpd_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version dce_v8_0_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v8_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 8,
 	.minor = 0,
@@ -3553,8 +3548,7 @@ const struct amdgpu_ip_block_version dce_v8_0_ip_block =
 	.funcs = &dce_v8_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version dce_v8_1_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v8_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 8,
 	.minor = 1,
@@ -3562,8 +3556,7 @@ const struct amdgpu_ip_block_version dce_v8_1_ip_block =
 	.funcs = &dce_v8_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version dce_v8_2_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v8_2_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 8,
 	.minor = 2,
@@ -3571,8 +3564,7 @@ const struct amdgpu_ip_block_version dce_v8_2_ip_block =
 	.funcs = &dce_v8_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version dce_v8_3_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v8_3_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 8,
 	.minor = 3,
@@ -3580,8 +3572,7 @@ const struct amdgpu_ip_block_version dce_v8_3_ip_block =
 	.funcs = &dce_v8_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version dce_v8_5_ip_block =
-{
+const struct amdgpu_ip_block_version dce_v8_5_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 8,
 	.minor = 5,
-- 
2.17.1

