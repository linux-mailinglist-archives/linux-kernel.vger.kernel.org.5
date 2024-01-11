Return-Path: <linux-kernel+bounces-23216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F3D82A90B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D05B268B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1C0FBEB;
	Thu, 11 Jan 2024 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lUOzuGBx"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3155FBE4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=6CAROB1lD1HLjhO4c1
	5hoRYXMOhnvVtgCZbVS+d/YhU=; b=lUOzuGBxHNPn6+7nV+zNlU8NYwUEJKXFm1
	K7pwUJ4Gf1fJPPncmxA2rFzDk8hifpRegxJE7VMOM5Sw2lE8c/nndw3UVuByDDcs
	wZT2a6RyISLg8wMYkflXbK5P1tgLU5C9H2bBfWtf7vym+zlOcBMp9ze7fjQq7Y8u
	tZTxzCUlY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDnT_OXpZ9l8XqUAA--.19048S2;
	Thu, 11 Jan 2024 16:23:51 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in radeon_display.c
Date: Thu, 11 Jan 2024 08:23:49 +0000
Message-Id: <20240111082349.11806-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnT_OXpZ9l8XqUAA--.19048S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWxtr18JFyrAr47Xr15twb_yoW8tF1DpF
	sxuw1vgw13tF4agryUJF4xuw1rua1kWaySkr17G39ruws0yrWxXFZIyFZFkw1rZry8GrW5
	tryxCw17WF40yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFdgAUUUUU=
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBxi1mVOBlCRhgAAsq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index a44f78bdd4e5..94dc4f92587f 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1365,8 +1365,8 @@ static const struct drm_prop_enum_list radeon_tmds_pll_enum_list[] = {
 	{ 1, "bios" },
 };
 
-static const struct drm_prop_enum_list radeon_tv_std_enum_list[] =
-{	{ TV_STD_NTSC, "ntsc" },
+static const struct drm_prop_enum_list radeon_tv_std_enum_list[] = {
+	{ TV_STD_NTSC, "ntsc" },
 	{ TV_STD_PAL, "pal" },
 	{ TV_STD_PAL_M, "pal-m" },
 	{ TV_STD_PAL_60, "pal-60" },
@@ -1376,25 +1376,25 @@ static const struct drm_prop_enum_list radeon_tv_std_enum_list[] =
 	{ TV_STD_SECAM, "secam" },
 };
 
-static const struct drm_prop_enum_list radeon_underscan_enum_list[] ={
+static const struct drm_prop_enum_list radeon_underscan_enum_list[] = {
 	{ UNDERSCAN_OFF, "off" },
 	{ UNDERSCAN_ON, "on" },
 	{ UNDERSCAN_AUTO, "auto" },
 };
 
-static const struct drm_prop_enum_list radeon_audio_enum_list[] ={
+static const struct drm_prop_enum_list radeon_audio_enum_list[] = {
 	{ RADEON_AUDIO_DISABLE, "off" },
 	{ RADEON_AUDIO_ENABLE, "on" },
 	{ RADEON_AUDIO_AUTO, "auto" },
 };
 
 /* XXX support different dither options? spatial, temporal, both, etc. */
-static const struct drm_prop_enum_list radeon_dither_enum_list[] ={
+static const struct drm_prop_enum_list radeon_dither_enum_list[] = {
 	{ RADEON_FMT_DITHER_DISABLE, "off" },
 	{ RADEON_FMT_DITHER_ENABLE, "on" },
 };
 
-static const struct drm_prop_enum_list radeon_output_csc_enum_list[] ={
+static const struct drm_prop_enum_list radeon_output_csc_enum_list[] = {
 	{ RADEON_OUTPUT_CSC_BYPASS, "bypass" },
 	{ RADEON_OUTPUT_CSC_TVRGB, "tvrgb" },
 	{ RADEON_OUTPUT_CSC_YCBCR601, "ycbcr601" },
-- 
2.17.1


