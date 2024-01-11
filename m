Return-Path: <linux-kernel+bounces-23328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C222E82AB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C561B1C224EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3A11704;
	Thu, 11 Jan 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AYHdkLOw"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E110A2F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=iz9UOzRHdTaijoax5t
	rZJe5y011J0dv7M21KuYSpJpg=; b=AYHdkLOwn6mAA96ry0PtHnzosLx5znLfr5
	MsP5Ue4xiY9pwHd2+ORbZsJX6syfdIqPwU33z0BnRimA1ZM/EqrAhSCspsCy1A/S
	zgdqaPQi2xCf2PO0gS/XZ4yS5OjAkVbcTwXy7VAEdmmg8c6v2ofgCEHeRfyeEH6s
	tl4nzuRmQ=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDXv_L_tp9l2bOlAA--.1501S2;
	Thu, 11 Jan 2024 17:38:08 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] drm/radeon: Clean up errors in si.c
Date: Thu, 11 Jan 2024 09:38:01 +0000
Message-Id: <20240111093801.14260-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXv_L_tp9l2bOlAA--.1501S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFyUGw4fZr1xtFyDKw4fGrg_yoWxZw4xpF
	nxXr4YkF4rGF45Zay3Jr1rAF1YkFnFkas0yw4UKr4xZF98CFyDXF47JayIyas8J3y8A3y7
	tF1DXrWUta18Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRylkfUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQFixWVLYUR98wAAs6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: trailing statements should be on next lineo

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/si.c | 63 +++++++++++++------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 85e9cba49cec..93f197d96d8f 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -138,8 +138,7 @@ static void si_fini_pg(struct radeon_device *rdev);
 static void si_fini_cg(struct radeon_device *rdev);
 static void si_rlc_stop(struct radeon_device *rdev);
 
-static const u32 crtc_offsets[] =
-{
+static const u32 crtc_offsets[] = {
 	EVERGREEN_CRTC0_REGISTER_OFFSET,
 	EVERGREEN_CRTC1_REGISTER_OFFSET,
 	EVERGREEN_CRTC2_REGISTER_OFFSET,
@@ -148,8 +147,7 @@ static const u32 crtc_offsets[] =
 	EVERGREEN_CRTC5_REGISTER_OFFSET
 };
 
-static const u32 si_disp_int_status[] =
-{
+static const u32 si_disp_int_status[] = {
 	DISP_INTERRUPT_STATUS,
 	DISP_INTERRUPT_STATUS_CONTINUE,
 	DISP_INTERRUPT_STATUS_CONTINUE2,
@@ -162,8 +160,7 @@ static const u32 si_disp_int_status[] =
 #define DC_HPDx_INT_CONTROL(x)    (DC_HPD1_INT_CONTROL + (x * 0xc))
 #define DC_HPDx_INT_STATUS_REG(x) (DC_HPD1_INT_STATUS  + (x * 0xc))
 
-static const u32 verde_rlc_save_restore_register_list[] =
-{
+static const u32 verde_rlc_save_restore_register_list[] = {
 	(0x8000 << 16) | (0x98f4 >> 2),
 	0x00000000,
 	(0x8040 << 16) | (0x98f4 >> 2),
@@ -384,8 +381,7 @@ static const u32 verde_rlc_save_restore_register_list[] =
 	0x00000000
 };
 
-static const u32 tahiti_golden_rlc_registers[] =
-{
+static const u32 tahiti_golden_rlc_registers[] = {
 	0xc424, 0xffffffff, 0x00601005,
 	0xc47c, 0xffffffff, 0x10104040,
 	0xc488, 0xffffffff, 0x0100000a,
@@ -394,8 +390,7 @@ static const u32 tahiti_golden_rlc_registers[] =
 	0xf4a8, 0xffffffff, 0x00000000
 };
 
-static const u32 tahiti_golden_registers[] =
-{
+static const u32 tahiti_golden_registers[] = {
 	0x9a10, 0x00010000, 0x00018208,
 	0x9830, 0xffffffff, 0x00000000,
 	0x9834, 0xf00fffff, 0x00000400,
@@ -429,13 +424,11 @@ static const u32 tahiti_golden_registers[] =
 	0x15c0, 0x000c0fc0, 0x000c0400
 };
 
-static const u32 tahiti_golden_registers2[] =
-{
+static const u32 tahiti_golden_registers2[] = {
 	0xc64, 0x00000001, 0x00000001
 };
 
-static const u32 pitcairn_golden_rlc_registers[] =
-{
+static const u32 pitcairn_golden_rlc_registers[] = {
 	0xc424, 0xffffffff, 0x00601004,
 	0xc47c, 0xffffffff, 0x10102020,
 	0xc488, 0xffffffff, 0x01000020,
@@ -443,8 +436,7 @@ static const u32 pitcairn_golden_rlc_registers[] =
 	0xc30c, 0xffffffff, 0x800000a4
 };
 
-static const u32 pitcairn_golden_registers[] =
-{
+static const u32 pitcairn_golden_registers[] = {
 	0x9a10, 0x00010000, 0x00018208,
 	0x9830, 0xffffffff, 0x00000000,
 	0x9834, 0xf00fffff, 0x00000400,
@@ -474,8 +466,7 @@ static const u32 pitcairn_golden_registers[] =
 	0x15c0, 0x000c0fc0, 0x000c0400
 };
 
-static const u32 verde_golden_rlc_registers[] =
-{
+static const u32 verde_golden_rlc_registers[] = {
 	0xc424, 0xffffffff, 0x033f1005,
 	0xc47c, 0xffffffff, 0x10808020,
 	0xc488, 0xffffffff, 0x00800008,
@@ -483,8 +474,7 @@ static const u32 verde_golden_rlc_registers[] =
 	0xc30c, 0xffffffff, 0x80010014
 };
 
-static const u32 verde_golden_registers[] =
-{
+static const u32 verde_golden_registers[] = {
 	0x9a10, 0x00010000, 0x00018208,
 	0x9830, 0xffffffff, 0x00000000,
 	0x9834, 0xf00fffff, 0x00000400,
@@ -539,8 +529,7 @@ static const u32 verde_golden_registers[] =
 	0x15c0, 0x000c0fc0, 0x000c0400
 };
 
-static const u32 oland_golden_rlc_registers[] =
-{
+static const u32 oland_golden_rlc_registers[] = {
 	0xc424, 0xffffffff, 0x00601005,
 	0xc47c, 0xffffffff, 0x10104040,
 	0xc488, 0xffffffff, 0x0100000a,
@@ -548,8 +537,7 @@ static const u32 oland_golden_rlc_registers[] =
 	0xc30c, 0xffffffff, 0x800000f4
 };
 
-static const u32 oland_golden_registers[] =
-{
+static const u32 oland_golden_registers[] = {
 	0x9a10, 0x00010000, 0x00018208,
 	0x9830, 0xffffffff, 0x00000000,
 	0x9834, 0xf00fffff, 0x00000400,
@@ -579,8 +567,7 @@ static const u32 oland_golden_registers[] =
 	0x15c0, 0x000c0fc0, 0x000c0400
 };
 
-static const u32 hainan_golden_registers[] =
-{
+static const u32 hainan_golden_registers[] = {
 	0x9a10, 0x00010000, 0x00018208,
 	0x9830, 0xffffffff, 0x00000000,
 	0x9834, 0xf00fffff, 0x00000400,
@@ -608,13 +595,11 @@ static const u32 hainan_golden_registers[] =
 	0x15c0, 0x000c0fc0, 0x000c0400
 };
 
-static const u32 hainan_golden_registers2[] =
-{
+static const u32 hainan_golden_registers2[] = {
 	0x98f8, 0xffffffff, 0x02010001
 };
 
-static const u32 tahiti_mgcg_cgcg_init[] =
-{
+static const u32 tahiti_mgcg_cgcg_init[] = {
 	0xc400, 0xffffffff, 0xfffffffc,
 	0x802c, 0xffffffff, 0xe0000000,
 	0x9a60, 0xffffffff, 0x00000100,
@@ -743,8 +728,7 @@ static const u32 tahiti_mgcg_cgcg_init[] =
 	0xd8c0, 0xfffffff0, 0x00000100
 };
 
-static const u32 pitcairn_mgcg_cgcg_init[] =
-{
+static const u32 pitcairn_mgcg_cgcg_init[] = {
 	0xc400, 0xffffffff, 0xfffffffc,
 	0x802c, 0xffffffff, 0xe0000000,
 	0x9a60, 0xffffffff, 0x00000100,
@@ -841,8 +825,7 @@ static const u32 pitcairn_mgcg_cgcg_init[] =
 	0xd8c0, 0xfffffff0, 0x00000100
 };
 
-static const u32 verde_mgcg_cgcg_init[] =
-{
+static const u32 verde_mgcg_cgcg_init[] = {
 	0xc400, 0xffffffff, 0xfffffffc,
 	0x802c, 0xffffffff, 0xe0000000,
 	0x9a60, 0xffffffff, 0x00000100,
@@ -941,8 +924,7 @@ static const u32 verde_mgcg_cgcg_init[] =
 	0xd8c0, 0xfffffff0, 0x00000100
 };
 
-static const u32 oland_mgcg_cgcg_init[] =
-{
+static const u32 oland_mgcg_cgcg_init[] = {
 	0xc400, 0xffffffff, 0xfffffffc,
 	0x802c, 0xffffffff, 0xe0000000,
 	0x9a60, 0xffffffff, 0x00000100,
@@ -1021,8 +1003,7 @@ static const u32 oland_mgcg_cgcg_init[] =
 	0xd8c0, 0xfffffff0, 0x00000100
 };
 
-static const u32 hainan_mgcg_cgcg_init[] =
-{
+static const u32 hainan_mgcg_cgcg_init[] = {
 	0xc400, 0xffffffff, 0xfffffffc,
 	0x802c, 0xffffffff, 0xe0000000,
 	0x9a60, 0xffffffff, 0x00000100,
@@ -1098,8 +1079,7 @@ static const u32 hainan_mgcg_cgcg_init[] =
 	0xd8c0, 0xfffffff0, 0x00000100
 };
 
-static u32 verde_pg_init[] =
-{
+static u32 verde_pg_init[] = {
 	0x353c, 0xffffffff, 0x40000,
 	0x3538, 0xffffffff, 0x200010ff,
 	0x353c, 0xffffffff, 0x0,
@@ -1768,7 +1748,8 @@ static int si_init_microcode(struct radeon_device *rdev)
 		mc_req_size = mc2_req_size = OLAND_MC_UCODE_SIZE * 4;
 		smc_req_size = ALIGN(HAINAN_SMC_UCODE_SIZE, 4);
 		break;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	/* this memory configuration requires special firmware */
-- 
2.17.1


