Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8ED76C6F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHBHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjHBHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:34:59 -0400
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8E212B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:34:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1058688|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.732773-0.00313448-0.264092;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6cXXim_1690961680;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6cXXim_1690961680)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:34:42 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in nv.c
Date:   Wed,  2 Aug 2023 07:34:39 +0000
Message-Id: <20230802073439.13432-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/amdgpu/nv.c | 48 +++++++++++----------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 51523b27a186..414c3c85172d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -67,21 +67,18 @@
 static const struct amd_ip_funcs nv_common_ip_funcs;
 
 /* Navi */
-static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
-{
+static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 };
 
-static const struct amdgpu_video_codecs nv_video_codecs_encode =
-{
+static const struct amdgpu_video_codecs nv_video_codecs_encode = {
 	.codec_count = ARRAY_SIZE(nv_video_codecs_encode_array),
 	.codec_array = nv_video_codecs_encode_array,
 };
 
 /* Navi1x */
-static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
-{
+static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
@@ -91,8 +88,7 @@ static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codecs nv_video_codecs_decode =
-{
+static const struct amdgpu_video_codecs nv_video_codecs_decode = {
 	.codec_count = ARRAY_SIZE(nv_video_codecs_decode_array),
 	.codec_array = nv_video_codecs_decode_array,
 };
@@ -108,8 +104,7 @@ static const struct amdgpu_video_codecs sc_video_codecs_encode = {
 	.codec_array = sc_video_codecs_encode_array,
 };
 
-static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] =
-{
+static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
@@ -120,8 +115,7 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[]
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[] =
-{
+static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
@@ -131,27 +125,23 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[]
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn0 =
-{
+static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn0 = {
 	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array_vcn0),
 	.codec_array = sc_video_codecs_decode_array_vcn0,
 };
 
-static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 =
-{
+static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 = {
 	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array_vcn1),
 	.codec_array = sc_video_codecs_decode_array_vcn1,
 };
 
 /* SRIOV Sienna Cichlid, not const since data is controlled by host */
-static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
-{
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4352, 0)},
 };
 
-static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] =
-{
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
@@ -162,8 +152,7 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[]
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn1[] =
-{
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn1[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
@@ -173,20 +162,17 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn1[]
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =
-{
+static struct amdgpu_video_codecs sriov_sc_video_codecs_encode = {
 	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
 	.codec_array = sriov_sc_video_codecs_encode_array,
 };
 
-static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn0 =
-{
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn0 = {
 	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn0),
 	.codec_array = sriov_sc_video_codecs_decode_array_vcn0,
 };
 
-static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn1 =
-{
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn1 = {
 	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1),
 	.codec_array = sriov_sc_video_codecs_decode_array_vcn1,
 };
@@ -536,8 +522,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 
 }
 
-const struct amdgpu_ip_block_version nv_common_ip_block =
-{
+const struct amdgpu_ip_block_version nv_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
 	.minor = 0,
@@ -642,8 +627,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	return 0;
 }
 
-static const struct amdgpu_asic_funcs nv_asic_funcs =
-{
+static const struct amdgpu_asic_funcs nv_asic_funcs = {
 	.read_disabled_bios = &nv_read_disabled_bios,
 	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
 	.read_register = &nv_read_register,
-- 
2.17.1

