Return-Path: <linux-kernel+bounces-22941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823C82A5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2675A28B40F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A601EA3;
	Thu, 11 Jan 2024 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="i7ETgvLp"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892AA3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=MqvsdNpdgdevTDXLx/
	3wHJ+fUvPHE2tkCRPaSkqqFnc=; b=i7ETgvLpkj+Tbbo+l+WL6t6bbaDDejUXEj
	qCENh2JYuyyi9iPi/mULh1o3ePit2vHRLu0f9N5zNh+NcldamrNkmOPSYuZwBQNk
	M5hxqckrQTUEXkEM7fYH3jZPlihxQmmm+EHnAX12MGTuYsReP1trzYKBTLppTdqo
	SAaCtkOt0=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDXH75oS59l9eMsAA--.11769S2;
	Thu, 11 Jan 2024 09:59:05 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	Xinhui.Pan@amd.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in clearstate_gfx9.h
Date: Thu, 11 Jan 2024 01:59:03 +0000
Message-Id: <20240111015903.5433-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXH75oS59l9eMsAA--.11769S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4rXF48CFyUJFWrJrWkWFg_yoW5tFWxpF
	1DAr1Ig3yxJ3WaqrWxtFs8KF1fGrZFv3Z2yr47K3WxG3Z5XayDXa4DJ3yrCrWUtFykZF1q
	yF4vqrWUKay8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbF4iUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQtixWVLYT1tUwAAs5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h | 27 +++++++-------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
index 567a904804bc..9c85ca6358c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
@@ -21,8 +21,7 @@
  *
  */
 
-static const unsigned int gfx9_SECT_CONTEXT_def_1[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_1[] = {
     0x00000000, // DB_RENDER_CONTROL
     0x00000000, // DB_COUNT_CONTROL
     0x00000000, // DB_DEPTH_VIEW
@@ -236,8 +235,7 @@ static const unsigned int gfx9_SECT_CONTEXT_def_1[] =
     0x00000000, // PA_SC_VPORT_ZMIN_15
     0x3f800000, // PA_SC_VPORT_ZMAX_15
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_2[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_2[] = {
     0x00000000, // PA_SC_SCREEN_EXTENT_CONTROL
     0x00000000, // PA_SC_TILE_STEERING_OVERRIDE
     0x00000000, // CP_PERFMON_CNTX_CNTL
@@ -521,15 +519,13 @@ static const unsigned int gfx9_SECT_CONTEXT_def_2[] =
     0x00000000, // CB_MRT6_EPITCH
     0x00000000, // CB_MRT7_EPITCH
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_3[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_3[] = {
     0x00000000, // PA_CL_POINT_X_RAD
     0x00000000, // PA_CL_POINT_Y_RAD
     0x00000000, // PA_CL_POINT_SIZE
     0x00000000, // PA_CL_POINT_CULL_RAD
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_4[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_4[] = {
     0x00000000, // DB_DEPTH_CONTROL
     0x00000000, // DB_EQAA
     0x00000000, // CB_COLOR_CONTROL
@@ -688,17 +684,14 @@ static const unsigned int gfx9_SECT_CONTEXT_def_4[] =
     0x00000000, // VGT_GS_OUT_PRIM_TYPE
     0x00000000, // IA_ENHANCE
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_5[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_5[] = {
     0x00000000, // WD_ENHANCE
     0x00000000, // VGT_PRIMITIVEID_EN
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_6[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_6[] = {
     0x00000000, // VGT_PRIMITIVEID_RESET
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_7[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_7[] = {
     0x00000000, // VGT_GS_MAX_PRIMS_PER_SUBGROUP
     0x00000000, // VGT_DRAW_PAYLOAD_CNTL
     0, // HOLE
@@ -766,8 +759,7 @@ static const unsigned int gfx9_SECT_CONTEXT_def_7[] =
     0x00000000, // VGT_STRMOUT_CONFIG
     0x00000000, // VGT_STRMOUT_BUFFER_CONFIG
 };
-static const unsigned int gfx9_SECT_CONTEXT_def_8[] =
-{
+static const unsigned int gfx9_SECT_CONTEXT_def_8[] = {
     0x00000000, // PA_SC_CENTROID_PRIORITY_0
     0x00000000, // PA_SC_CENTROID_PRIORITY_1
     0x00001000, // PA_SC_LINE_CNTL
@@ -924,8 +916,7 @@ static const unsigned int gfx9_SECT_CONTEXT_def_8[] =
     0x00000000, // CB_COLOR7_DCC_BASE
     0x00000000, // CB_COLOR7_DCC_BASE_EXT
 };
-static const struct cs_extent_def gfx9_SECT_CONTEXT_defs[] =
-{
+static const struct cs_extent_def gfx9_SECT_CONTEXT_defs[] = {
     {gfx9_SECT_CONTEXT_def_1, 0x0000a000, 212 },
     {gfx9_SECT_CONTEXT_def_2, 0x0000a0d6, 282 },
     {gfx9_SECT_CONTEXT_def_3, 0x0000a1f5, 4 },
-- 
2.17.1


