Return-Path: <linux-kernel+bounces-23150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5B82A850
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86791C23457
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33CD2F1;
	Thu, 11 Jan 2024 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OLM3nEJK"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B32D2E2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=VpIczU8eqIB7d5YSOI
	rPozjjZBz+2KSAjKt2ZpU6HC0=; b=OLM3nEJKreWwpVg/fnV2EJ/nDVx1wTazAG
	lKQ9zNqAwq+vVlo2uvLh2+pPsTEPuOCtqUPKkMm0Y9wW4TSIPacWKWfue57O+wBI
	MGlfvHjwbotJF3KNU8jENjCGt7eaz0oDCyMs7qIybbhtER0FRhg0B6dTIiinRkal
	EDixCQaOw=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3P5SimJ9lPviRAA--.21069S2;
	Thu, 11 Jan 2024 15:28:34 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon/trinity_dpm: Clean up errors in trinity_dpm.c
Date: Thu, 11 Jan 2024 07:28:33 +0000
Message-Id: <20240111072833.10316-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P5SimJ9lPviRAA--.21069S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1xCF4fAw4xGF4xJFWkZwb_yoW5ur4Upr
	WDCrs8Kr4FqFy5ZrW3C3Z8JryUKryvva40krWUGFs7CFn8CF1DZrsYk3yrury0yFWj9Fy3
	tFn2grWjvFW7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFtC7UUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEh9i1mVOBk5iCQAAsx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space required before the open parenthesis '('
ERROR: space prohibited before that close parenthesis ')'
ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/trinity_dpm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeon/trinity_dpm.c
index ef1cc7bad20a..b9a2c7ccc881 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.c
+++ b/drivers/gpu/drm/radeon/trinity_dpm.c
@@ -39,8 +39,7 @@
 #ifndef TRINITY_MGCG_SEQUENCE
 #define TRINITY_MGCG_SEQUENCE  100
 
-static const u32 trinity_mgcg_shls_default[] =
-{
+static const u32 trinity_mgcg_shls_default[] = {
 	/* Register, Value, Mask */
 	0x0000802c, 0xc0000000, 0xffffffff,
 	0x00003fc4, 0xc0000000, 0xffffffff,
@@ -122,8 +121,7 @@ static const u32 trinity_mgcg_shls_default[] =
 #ifndef TRINITY_SYSLS_SEQUENCE
 #define TRINITY_SYSLS_SEQUENCE  100
 
-static const u32 trinity_sysls_disable[] =
-{
+static const u32 trinity_sysls_disable[] = {
 	/* Register, Value, Mask */
 	0x0000d0c0, 0x00000000, 0xffffffff,
 	0x0000d8c0, 0x00000000, 0xffffffff,
@@ -146,8 +144,7 @@ static const u32 trinity_sysls_disable[] =
 	0x00006dfc, 0x0000007f, 0xffffffff
 };
 
-static const u32 trinity_sysls_enable[] =
-{
+static const u32 trinity_sysls_enable[] = {
 	/* Register, Value, Mask */
 	0x000055e8, 0x00000001, 0xffffffff,
 	0x0000d0bc, 0x00000100, 0xffffffff,
@@ -169,8 +166,7 @@ static const u32 trinity_sysls_enable[] =
 };
 #endif
 
-static const u32 trinity_override_mgpg_sequences[] =
-{
+static const u32 trinity_override_mgpg_sequences[] = {
 	/* Register, Value */
 	0x00000200, 0xE030032C,
 	0x00000204, 0x00000FFF,
@@ -366,9 +362,9 @@ static void trinity_mg_clockgating_enable(struct radeon_device *rdev,
 		local1 = RREG32_CG(CG_CGTT_LOCAL_1);
 
 		WREG32_CG(CG_CGTT_LOCAL_0,
-			  (0x00380000 & CGCG_CGTT_LOCAL0_MASK) | (local0 & ~CGCG_CGTT_LOCAL0_MASK) );
+			  (0x00380000 & CGCG_CGTT_LOCAL0_MASK) | (local0 & ~CGCG_CGTT_LOCAL0_MASK));
 		WREG32_CG(CG_CGTT_LOCAL_1,
-			  (0x0E000000 & CGCG_CGTT_LOCAL1_MASK) | (local1 & ~CGCG_CGTT_LOCAL1_MASK) );
+			  (0x0E000000 & CGCG_CGTT_LOCAL1_MASK) | (local1 & ~CGCG_CGTT_LOCAL1_MASK));
 
 		WREG32(CGTS_SM_CTRL_REG, CGTS_SM_CTRL_REG_ENABLE);
 	} else {
@@ -378,9 +374,9 @@ static void trinity_mg_clockgating_enable(struct radeon_device *rdev,
 		local1 = RREG32_CG(CG_CGTT_LOCAL_1);
 
 		WREG32_CG(CG_CGTT_LOCAL_0,
-			  CGCG_CGTT_LOCAL0_MASK | (local0 & ~CGCG_CGTT_LOCAL0_MASK) );
+			  CGCG_CGTT_LOCAL0_MASK | (local0 & ~CGCG_CGTT_LOCAL0_MASK));
 		WREG32_CG(CG_CGTT_LOCAL_1,
-			  CGCG_CGTT_LOCAL1_MASK | (local1 & ~CGCG_CGTT_LOCAL1_MASK) );
+			  CGCG_CGTT_LOCAL1_MASK | (local1 & ~CGCG_CGTT_LOCAL1_MASK));
 	}
 }
 
@@ -1434,7 +1430,7 @@ static void trinity_adjust_uvd_state(struct radeon_device *rdev,
 	if (pi->uvd_dpm && r600_is_uvd_state(rps->class, rps->class2)) {
 		high_index = trinity_get_uvd_clock_index(rdev, rps);
 
-		switch(high_index) {
+		switch (high_index) {
 		case 3:
 		case 2:
 			low_index = 1;
-- 
2.17.1


