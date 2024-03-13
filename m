Return-Path: <linux-kernel+bounces-102297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E087B044
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC051C27553
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451466B4E;
	Wed, 13 Mar 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RzvU2j9e"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00525664B3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351939; cv=none; b=rRknyPxu92gwMf1z4BVvyp3+OTrJ20ZtHwCUHZFl8u7Ckzr4+E7z0wWQ8f06AvU663igRlBMF0RKtQ6+rw+ysHebgea7+zLHbmnQ5zfwa2LWFmQuVufx/VYelTMME83qFLQoWVzONNqhAVC25ZMqeSr9oo6XmZTWMpdvhlPg1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351939; c=relaxed/simple;
	bh=jQLWVvGHX0RwVHU0wEm+ZMMYBxMzOtg605EU0kzKs58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ox+kAn+hb2z71gvOXrhjp6SvZkS2WHKi4GUKAeiIsKNHckkcdGozSO2MGbT+rVDSrcQzD1ak1cEGpOSU4SfSos74hRSdQJPC8x7VHamLPzl5BhUAmIrdg99+hYGzuUKtEofYva54IM29ZsslaIaSkfpbtTnWN8HKKaSmhsAtPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RzvU2j9e; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D227B40006;
	Wed, 13 Mar 2024 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710351928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hht86WDYBmmd5HJ0kBTByD9xXyq+2Qqfx093Hdq4g/E=;
	b=RzvU2j9ednDvi05rgHjzsJqaAuVItoKYmuA3s5iUHB0uH8j0tdwfpVQC8PFfwBfJloIHMj
	t7e1jdeV3JSOWespI/46pzDcKn7YBvuI7vKBfoGsWdSwfp8IAeMCNNNsREYlVMEoMu/Ruw
	HWqzQ70IrlI67DFcn14chPcTpPBYdu3Ggzo8fgkjFsxM0+tAGMVtcRzvJ7JjYvuWFcecnl
	50Z8Ix92JKo3RN24zKomQolYFY49UbXa0RjbvQoBWuyTK0Pf+hELtPhPwQKkKKCA2OE7LV
	L36POivdLM6cyAujZ0PWvquYB+XN9lIKoZfc2Jqn9DhXOY+ohPab/ND+IfjBuA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 13 Mar 2024 18:44:55 +0100
Subject: [PATCH v5 01/16] drm/vkms: Code formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-yuv-v5-1-e610cbd03f52@bootlin.com>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
In-Reply-To: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4834;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=jQLWVvGHX0RwVHU0wEm+ZMMYBxMzOtg605EU0kzKs58=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl8eYySTdGDiGsC4TKrC39rnaeps9U2aZvyemtyyJ9
 PcfpYymJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZfHmMgAKCRAgrS7GWxAs4nSYEA
 CrP5hBlCAjtLqxs7yD1pwcwqDUzuT5hW3csVlGRQK1bDO6YSdgHwytECLDNTjBgPoPAJiPlH2N0pZq
 8JsyJ5bmpaCnnGiVuwyBiAz/NOi99C5IHXB5NAWkU64AopcactmBc+qPyCHzFffTmg/ct5zUSXA3ou
 VX0cXn8vI4CTdIw/0095THcibqISo63Gp1DN3WQdoxXy01w3ihJEPIg/zgNKmR5FxW0q5b1sCfoA1e
 xSwKf9JMTQD/+LadNSOKfSmsSsVSfqrj68z9pCsqUo+/gjyyHRKgVd56HY1HPIDhO7Q/kCAqv/0WfX
 bX2G5xLWcrU7ynb0kgBJrX+1mfsr1FJhZo/muh7wj9NKjcYH0buvbRDQD/8dUU//eo3yYp+7NuT2Sn
 EXDBDAkRs7rmTb7xYg/Hh9SLylHU+BC3L5BDSs01H3YUmYIUtOXDtDMbxsu+ca/FAurmlITgvUYpR1
 qxWmGXPn+FF6x4qyZdobbnFirSCmD/wTRM7SWNnqH1+dZyxJ6gCkQD8lwr5hjdBm3y8IiVpHsEc7at
 L2syLfuUFTCU9+qaG5VdqcJX681DiQlrZ77dR70GLQ3UXuLFiBnP16o7qOIpEBKnzE75jXN/ycMHBF
 46deNfHZ/5smVwB//BdBJRchTBelHhyjvTVN+T6DmpY+vZ8lGiBsHSJG5niw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Few no-op changes to remove double spaces and fix wrong alignments.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 10 +++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c     |  6 ++----
 drivers/gpu/drm/vkms/vkms_drv.c      |  3 +--
 drivers/gpu/drm/vkms/vkms_plane.c    |  8 ++++----
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index e7441b227b3c..c6d9b4a65809 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -96,7 +96,7 @@ static u16 lerp_u16(u16 a, u16 b, s64 t)
 	s64 a_fp = drm_int2fixp(a);
 	s64 b_fp = drm_int2fixp(b);
 
-	s64 delta = drm_fixp_mul(b_fp - a_fp,  t);
+	s64 delta = drm_fixp_mul(b_fp - a_fp, t);
 
 	return drm_fixp2int(a_fp + delta);
 }
@@ -302,8 +302,8 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 void vkms_composer_worker(struct work_struct *work)
 {
 	struct vkms_crtc_state *crtc_state = container_of(work,
-						struct vkms_crtc_state,
-						composer_work);
+							  struct vkms_crtc_state,
+							  composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
@@ -328,7 +328,7 @@ void vkms_composer_worker(struct work_struct *work)
 		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
 			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
-		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length  - 1);
+		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
 		crtc_state->gamma_lut.channel_value2index_ratio = drm_fixp_div(max_lut_index_fp,
 									       u16_max_fp);
 
@@ -367,7 +367,7 @@ void vkms_composer_worker(struct work_struct *work)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 }
 
-static const char * const pipe_crc_sources[] = {"auto"};
+static const char *const pipe_crc_sources[] = { "auto" };
 
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
 					size_t *count)
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 61e500b8c9da..7586ae2e1dd3 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -191,8 +191,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		return ret;
 
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
-		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
-								  plane);
+		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state, plane);
 		WARN_ON(!plane_state);
 
 		if (!plane_state->visible)
@@ -208,8 +207,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 
 	i = 0;
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
-		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
-								  plane);
+		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state, plane);
 
 		if (!plane_state->visible)
 			continue;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index dd0af086e7fa..83e6c9b9ff46 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -81,8 +81,7 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_wait_for_flip_done(dev, old_state);
 
 	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i) {
-		struct vkms_crtc_state *vkms_state =
-			to_vkms_crtc_state(old_crtc_state);
+		struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(old_crtc_state);
 
 		flush_work(&vkms_state->composer_work);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e5c625ab8e3e..5a8d295e65f2 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -117,10 +117,10 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
 	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-						     DRM_MODE_ROTATE_90 |
-						     DRM_MODE_ROTATE_270 |
-						     DRM_MODE_REFLECT_X |
-						     DRM_MODE_REFLECT_Y);
+									  DRM_MODE_ROTATE_90 |
+									  DRM_MODE_ROTATE_270 |
+									  DRM_MODE_REFLECT_X |
+									  DRM_MODE_REFLECT_Y);
 
 	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
 			drm_rect_height(&frame_info->rotated), frame_info->rotation);

-- 
2.43.0


