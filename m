Return-Path: <linux-kernel+bounces-22954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA882A5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593AF1C227F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089F809;
	Thu, 11 Jan 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RTI1FQHL"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254C7EA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=IqMfAJKFYt6J+qstwg
	7rkqilU4HK/21NbhnZgMySj/E=; b=RTI1FQHLypmfWGLAY7ZqcpRrxF3YQq8VzK
	H1bOFKnOlWspRfCs5SM59xIyKpYM4GSmSAnnt8U4LPysJGWy6U+VzCD2p1IowMb1
	nFWXffRHqXpp5IEYt2AkHIBolwvREI9u/9iNFyyaBNPwhvVgVUyI/efKebkbsugx
	diIKSccV0=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3_3FKTZ9lOOObAA--.54228S2;
	Thu, 11 Jan 2024 10:07:06 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: alexander.deucher@amd.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd: Clean up errors in sdma_v2_4.c
Date: Thu, 11 Jan 2024 02:07:05 +0000
Message-Id: <20240111020705.5699-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3_3FKTZ9lOOObAA--.54228S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4kGw1fWFyfJw1UJryxZrb_yoW8ur1rpF
	Z5Zr98uFsYyF13K34UX3WkXrn5Kw1Uuayjyr4jg34I9w15Ar9xXr1xtrWfu345JFWfZrWI
	qFy7Kry7ZF1jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjtC7UUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhpixWVEuXmeagABsT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: trailing statements should be on next line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 8d5d86675a7f..07e19caf2bc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -57,22 +57,19 @@ static void sdma_v2_4_set_irq_funcs(struct amdgpu_device *adev);
 MODULE_FIRMWARE("amdgpu/topaz_sdma.bin");
 MODULE_FIRMWARE("amdgpu/topaz_sdma1.bin");
 
-static const u32 sdma_offsets[SDMA_MAX_INSTANCE] =
-{
+static const u32 sdma_offsets[SDMA_MAX_INSTANCE] = {
 	SDMA0_REGISTER_OFFSET,
 	SDMA1_REGISTER_OFFSET
 };
 
-static const u32 golden_settings_iceland_a11[] =
-{
+static const u32 golden_settings_iceland_a11[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_CLK_CTRL, 0xff000fff, 0x00000000,
 };
 
-static const u32 iceland_mgcg_cgcg_init[] =
-{
+static const u32 iceland_mgcg_cgcg_init[] = {
 	mmSDMA0_CLK_CTRL, 0xff000ff0, 0x00000100,
 	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100
 };
@@ -142,7 +139,8 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 	case CHIP_TOPAZ:
 		chip_name = "topaz";
 		break;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -1258,8 +1256,7 @@ static void sdma_v2_4_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 }
 
-const struct amdgpu_ip_block_version sdma_v2_4_ip_block =
-{
+const struct amdgpu_ip_block_version sdma_v2_4_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 2,
 	.minor = 4,
-- 
2.17.1


