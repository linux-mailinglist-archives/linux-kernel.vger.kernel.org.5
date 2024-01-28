Return-Path: <linux-kernel+bounces-41962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B183FA13
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A366B1F22648
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514203C490;
	Sun, 28 Jan 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S7KfZAk6"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE733BB55
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477137; cv=none; b=DRBP2QmyIQ+LaI/Iy0risyvl2NS0JJlK9r3YSngzhyPtriCy2bjOYhmGuJUGA2usHZiXnmJs3uGsvZ0bc+0o3qU5ySvaEuS5xdSS0KzVKKMJC9LCPx7ONufR9jSBP1ig/bIA/a1Wy/HvrGCxc6+Do/tK32Axm/Ik7xVthQ0uhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477137; c=relaxed/simple;
	bh=6aseg8pQNv9s+045XPcUEfmL9lSlz2G0UyDGQsX9IuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOS0OTD4G4AEF3kw6+kqguBCQJtD3LiUngaCVbQfD6QKBWAdywWUTKOGYUUiWNYteBhXjpF1Lrb9hLkpVnROG7px8kHjxFTJE8oBjOWIopN7wBXa0q34rH1gdgW6CiAiPtv3iTW9DnOOBPc3BC6bFr4qG+i6vx/Rm3YS5rmlY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S7KfZAk6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vd0mVTNXzfHuXUFfadbZXfKYles0h4ec84FJE+8qleI=; b=S7KfZAk6X3bGfxhdkBWvrpqBNq
	xNiKjza85wxFVmsejpXtaVh/dhGHDFPdqJuYxGWpm7tslHr8yIBxlyjaT5bgMpLZEDE8VKYS7r5CX
	4qo00dJU+SLakI0DCvsSaMLYytK3bI686YvOkhde4cObFlQfoocS6YXTtGdzDBfVMJPEaOMB2joN+
	mJaVJuJ5Gu7n5Eq18o6ZX1hipWvF6RxtBs03nzvTPSXSSQQDygDKoRTwb/8qja8jPpu+xUI3qtltP
	/9SPSQOX5/Jm3y9M+SOhhoL2wlcDBhDshUuyGBru3EvYjDRMsiNd1it4a3D4u/QW08Mliz4r9Q/pl
	IIlFFZTw==;
Received: from 201-42-129-61.dsl.telesp.net.br ([201.42.129.61] helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rUCec-00B1M8-Ij; Sun, 28 Jan 2024 22:25:26 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 1/3] drm/atomic: Allow drivers to write their own plane check for async flips
Date: Sun, 28 Jan 2024 18:25:13 -0300
Message-ID: <20240128212515.630345-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128212515.630345-1-andrealmeid@igalia.com>
References: <20240128212515.630345-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some hardware are more flexible on what they can flip asynchronously, so
rework the plane check so drivers can implement their own check, lifting
up some of the restrictions.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v3: no changes

 drivers/gpu/drm/drm_atomic_uapi.c | 62 ++++++++++++++++++++++---------
 include/drm/drm_atomic_uapi.h     | 12 ++++++
 include/drm/drm_plane.h           |  5 +++
 3 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index aee4a65d4959..6d5b9fec90c7 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -620,7 +620,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 	return 0;
 }
 
-static int
+int
 drm_atomic_plane_get_property(struct drm_plane *plane,
 		const struct drm_plane_state *state,
 		struct drm_property *property, uint64_t *val)
@@ -683,6 +683,7 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 
 	return 0;
 }
+EXPORT_SYMBOL(drm_atomic_plane_get_property);
 
 static int drm_atomic_set_writeback_fb_for_connector(
 		struct drm_connector_state *conn_state,
@@ -1026,18 +1027,54 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 	return ret;
 }
 
-static int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
+int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
 					 struct drm_property *prop)
 {
 	if (ret != 0 || old_val != prop_value) {
 		drm_dbg_atomic(prop->dev,
-			       "[PROP:%d:%s] No prop can be changed during async flip\n",
+			       "[PROP:%d:%s] This prop cannot be changed during async flip\n",
 			       prop->base.id, prop->name);
 		return -EINVAL;
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL(drm_atomic_check_prop_changes);
+
+/* plane changes may have exceptions, so we have a special function for them */
+static int drm_atomic_check_plane_changes(struct drm_property *prop,
+					  struct drm_plane *plane,
+					  struct drm_plane_state *plane_state,
+					  struct drm_mode_object *obj,
+					  u64 prop_value, u64 old_val)
+{
+	struct drm_mode_config *config = &plane->dev->mode_config;
+	int ret;
+
+	if (plane->funcs->check_async_props)
+		return plane->funcs->check_async_props(prop, plane, plane_state,
+							     obj, prop_value, old_val);
+
+	/*
+	 * if you are trying to change something other than the FB ID, your
+	 * change will be either rejected or ignored, so we can stop the check
+	 * here
+	 */
+	if (prop != config->prop_fb_id) {
+		ret = drm_atomic_plane_get_property(plane, plane_state,
+						    prop, &old_val);
+		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+	}
+
+	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+		drm_dbg_atomic(prop->dev,
+			       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
+			       obj->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 int drm_atomic_set_property(struct drm_atomic_state *state,
 			    struct drm_file *file_priv,
@@ -1100,7 +1137,6 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 	case DRM_MODE_OBJECT_PLANE: {
 		struct drm_plane *plane = obj_to_plane(obj);
 		struct drm_plane_state *plane_state;
-		struct drm_mode_config *config = &plane->dev->mode_config;
 
 		plane_state = drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {
@@ -1108,19 +1144,11 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && prop != config->prop_fb_id) {
-			ret = drm_atomic_plane_get_property(plane, plane_state,
-							    prop, &old_val);
-			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
-			break;
-		}
-
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
-			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
-				       obj->id);
-			ret = -EINVAL;
-			break;
+		if (async_flip) {
+			ret = drm_atomic_check_plane_changes(prop, plane, plane_state,
+							     obj, prop_value, old_val);
+			if (ret)
+				break;
 		}
 
 		ret = drm_atomic_plane_set_property(plane,
diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
index 4c6d39d7bdb2..d65fa8fbbca0 100644
--- a/include/drm/drm_atomic_uapi.h
+++ b/include/drm/drm_atomic_uapi.h
@@ -29,6 +29,8 @@
 #ifndef DRM_ATOMIC_UAPI_H_
 #define DRM_ATOMIC_UAPI_H_
 
+#include <linux/types.h>
+
 struct drm_crtc_state;
 struct drm_display_mode;
 struct drm_property_blob;
@@ -37,6 +39,9 @@ struct drm_crtc;
 struct drm_connector_state;
 struct dma_fence;
 struct drm_framebuffer;
+struct drm_mode_object;
+struct drm_property;
+struct drm_plane;
 
 int __must_check
 drm_atomic_set_mode_for_crtc(struct drm_crtc_state *state,
@@ -53,4 +58,11 @@ int __must_check
 drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 				  struct drm_crtc *crtc);
 
+int drm_atomic_plane_get_property(struct drm_plane *plane,
+				  const struct drm_plane_state *state,
+				  struct drm_property *property, uint64_t *val);
+
+int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
+				  struct drm_property *prop);
+
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index c6565a6f9324..73dac8d76831 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -540,6 +540,11 @@ struct drm_plane_funcs {
 	 */
 	bool (*format_mod_supported)(struct drm_plane *plane, uint32_t format,
 				     uint64_t modifier);
+
+	int (*check_async_props)(struct drm_property *prop, struct drm_plane *plane,
+				 struct drm_plane_state *plane_state,
+				 struct drm_mode_object *obj,
+				 u64 prop_value, u64 old_val);
 };
 
 /**
-- 
2.43.0


