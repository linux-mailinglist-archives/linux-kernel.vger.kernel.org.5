Return-Path: <linux-kernel+bounces-23161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6882A87D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69763B25173
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B777D299;
	Thu, 11 Jan 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UeGsx9QK"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BDD287
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+DHDA/okFd5/zQjOlF
	eYU+44Mfp5VcM5q+2X+PDnePE=; b=UeGsx9QKL1ErG0fgK8ko2xxlzJGWWwj4s3
	QKzCuom2iJWXDR8bJuCXqdNMEgB8bVN32ECJ37yQ6ry7gujPv8gWnbfXnnzWHXbe
	qHlpBTqQaaT1ow6anrliJb5BX9C/S9gEXlH8aNWAurAqudaSOuDpUIc9YF9nImvp
	xjDHfM57w=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDXX5Som59lDeKSAA--.13761S2;
	Thu, 11 Jan 2024 15:41:28 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in ni.c
Date: Thu, 11 Jan 2024 07:41:27 +0000
Message-Id: <20240111074127.10749-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXX5Som59lDeKSAA--.13761S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr43Gw4DArW8Ar13tFW3GFg_yoW5Jw1DpF
	45J34YkFZ5JFsxZa17Jw15AFyYk3Z2ka92ya1UGw4xXF1qkrykXFsrtayrAF98J3y8A3y7
	tF1kXrWI9F4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFdgAUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBVi1mVOBk9-GgABsP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: trailing statements should be on next line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/ni.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 927e5f42e97d..6f231a740ba5 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -66,8 +66,7 @@ void tn_smc_wreg(struct radeon_device *rdev, u32 reg, u32 v)
 	spin_unlock_irqrestore(&rdev->smc_idx_lock, flags);
 }
 
-static const u32 tn_rlc_save_restore_register_list[] =
-{
+static const u32 tn_rlc_save_restore_register_list[] = {
 	0x98fc,
 	0x98f0,
 	0x9834,
@@ -216,8 +215,7 @@ MODULE_FIRMWARE("radeon/ARUBA_me.bin");
 MODULE_FIRMWARE("radeon/ARUBA_rlc.bin");
 
 
-static const u32 cayman_golden_registers2[] =
-{
+static const u32 cayman_golden_registers2[] = {
 	0x3e5c, 0xffffffff, 0x00000000,
 	0x3e48, 0xffffffff, 0x00000000,
 	0x3e4c, 0xffffffff, 0x00000000,
@@ -226,8 +224,7 @@ static const u32 cayman_golden_registers2[] =
 	0x3e60, 0xffffffff, 0x00000000
 };
 
-static const u32 cayman_golden_registers[] =
-{
+static const u32 cayman_golden_registers[] = {
 	0x5eb4, 0xffffffff, 0x00000002,
 	0x5e78, 0x8f311ff1, 0x001000f0,
 	0x3f90, 0xffff0000, 0xff000000,
@@ -267,16 +264,14 @@ static const u32 cayman_golden_registers[] =
 	0x8974, 0xffffffff, 0x00000000
 };
 
-static const u32 dvst_golden_registers2[] =
-{
+static const u32 dvst_golden_registers2[] = {
 	0x8f8, 0xffffffff, 0,
 	0x8fc, 0x00380000, 0,
 	0x8f8, 0xffffffff, 1,
 	0x8fc, 0x0e000000, 0
 };
 
-static const u32 dvst_golden_registers[] =
-{
+static const u32 dvst_golden_registers[] = {
 	0x690, 0x3fff3fff, 0x20c00033,
 	0x918c, 0x0fff0fff, 0x00010006,
 	0x91a8, 0x0fff0fff, 0x00010006,
@@ -333,8 +328,7 @@ static const u32 dvst_golden_registers[] =
 	0x8974, 0xffffffff, 0x00000000
 };
 
-static const u32 scrapper_golden_registers[] =
-{
+static const u32 scrapper_golden_registers[] = {
 	0x690, 0x3fff3fff, 0x20c00033,
 	0x918c, 0x0fff0fff, 0x00010006,
 	0x918c, 0x0fff0fff, 0x00010006,
@@ -754,7 +748,8 @@ int ni_init_microcode(struct radeon_device *rdev)
 		rlc_req_size = ARUBA_RLC_UCODE_SIZE * 4;
 		mc_req_size = 0;
 		break;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	DRM_INFO("Loading %s Microcode\n", chip_name);
-- 
2.17.1


