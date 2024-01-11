Return-Path: <linux-kernel+bounces-22982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CB82A608
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312F01C22FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195AEC8;
	Thu, 11 Jan 2024 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZO5jHrfc"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19736EA3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=AOzGKHt46QvNHfyAsE
	g+vgxMfngoEk7dNjwEPlS5T4Y=; b=ZO5jHrfcpWEtByXtvuzg9f/6M8vnoKFdkF
	5Vvfk0DwcLyjcollw3yB8/7Y08W0Zu1AJ+2aSpEB7csx1GhU2AlnirTBvpgQZw85
	t/hX1CTCzfb3KRqXNpk1W6Xje0mi7g0xWzMO0hnYtRvBCEg3avn6mRslvnJDqu4i
	CdPkLyfiE=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wB3tBUiU59l77CcAA--.9723S2;
	Thu, 11 Jan 2024 10:32:02 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in clearstate_si.h
Date: Thu, 11 Jan 2024 02:32:00 +0000
Message-Id: <20240111023200.6506-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wB3tBUiU59l77CcAA--.9723S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF48Xw1UWFW8KFWrZFWxCrg_yoW5Wry3pF
	nrXr1xCw48G3W3XryIq3WDGryrGa92vFZFyryUKw1xA3WkJ397W34DJ3y8AryYqFy8Ar1v
	yF4vqryUtayxCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRijjPUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQRixWVLYT4k0AAAs-
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/clearstate_si.h | 24 ++++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_si.h b/drivers/gpu/drm/amd/amdgpu/clearstate_si.h
index 66e39cdb5cb0..5fd96ddd7f0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/clearstate_si.h
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_si.h
@@ -21,8 +21,7 @@
  *
  */
 
-static const u32 si_SECT_CONTEXT_def_1[] =
-{
+static const u32 si_SECT_CONTEXT_def_1[] = {
     0x00000000, // DB_RENDER_CONTROL
     0x00000000, // DB_COUNT_CONTROL
     0x00000000, // DB_DEPTH_VIEW
@@ -236,8 +235,7 @@ static const u32 si_SECT_CONTEXT_def_1[] =
     0x00000000, // PA_SC_VPORT_ZMIN_15
     0x3f800000, // PA_SC_VPORT_ZMAX_15
 };
-static const u32 si_SECT_CONTEXT_def_2[] =
-{
+static const u32 si_SECT_CONTEXT_def_2[] = {
     0x00000000, // CP_PERFMON_CNTX_CNTL
     0x00000000, // CP_RINGID
     0x00000000, // CP_VMID
@@ -511,8 +509,7 @@ static const u32 si_SECT_CONTEXT_def_2[] =
     0x00000000, // CB_BLEND6_CONTROL
     0x00000000, // CB_BLEND7_CONTROL
 };
-static const u32 si_SECT_CONTEXT_def_3[] =
-{
+static const u32 si_SECT_CONTEXT_def_3[] = {
     0x00000000, // PA_CL_POINT_X_RAD
     0x00000000, // PA_CL_POINT_Y_RAD
     0x00000000, // PA_CL_POINT_SIZE
@@ -520,8 +517,7 @@ static const u32 si_SECT_CONTEXT_def_3[] =
     0x00000000, // VGT_DMA_BASE_HI
     0x00000000, // VGT_DMA_BASE
 };
-static const u32 si_SECT_CONTEXT_def_4[] =
-{
+static const u32 si_SECT_CONTEXT_def_4[] = {
     0x00000000, // DB_DEPTH_CONTROL
     0x00000000, // DB_EQAA
     0x00000000, // CB_COLOR_CONTROL
@@ -680,16 +676,13 @@ static const u32 si_SECT_CONTEXT_def_4[] =
     0x00000000, // VGT_GS_OUT_PRIM_TYPE
     0x00000000, // IA_ENHANCE
 };
-static const u32 si_SECT_CONTEXT_def_5[] =
-{
+static const u32 si_SECT_CONTEXT_def_5[] = {
     0x00000000, // VGT_PRIMITIVEID_EN
 };
-static const u32 si_SECT_CONTEXT_def_6[] =
-{
+static const u32 si_SECT_CONTEXT_def_6[] = {
     0x00000000, // VGT_PRIMITIVEID_RESET
 };
-static const u32 si_SECT_CONTEXT_def_7[] =
-{
+static const u32 si_SECT_CONTEXT_def_7[] = {
     0x00000000, // VGT_MULTI_PRIM_IB_RESET_EN
     0, // HOLE
     0, // HOLE
@@ -924,8 +917,7 @@ static const u32 si_SECT_CONTEXT_def_7[] =
     0x00000000, // CB_COLOR7_CLEAR_WORD0
     0x00000000, // CB_COLOR7_CLEAR_WORD1
 };
-static const struct cs_extent_def si_SECT_CONTEXT_defs[] =
-{
+static const struct cs_extent_def si_SECT_CONTEXT_defs[] = {
     {si_SECT_CONTEXT_def_1, 0x0000a000, 212 },
     {si_SECT_CONTEXT_def_2, 0x0000a0d8, 272 },
     {si_SECT_CONTEXT_def_3, 0x0000a1f5, 6 },
-- 
2.17.1


