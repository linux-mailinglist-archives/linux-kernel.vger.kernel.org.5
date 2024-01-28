Return-Path: <linux-kernel+bounces-41964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3183FA19
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6101F22458
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1DB446C8;
	Sun, 28 Jan 2024 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sTdTnV8K"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191D3C480
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477140; cv=none; b=eGlniGVTWsRNdflqzVsahgKrppVAbjHL3MXzSXP3DpolTellMVtTRY3HrpDwleUr11UCppSHBAvuZDfB/sH52cott6gJd1gzjRhglxfWQxYYogpnohsxszxtl9KQQgsMGptpjLMQOqKXdiLiuTkS7pdU2RmyC9V/xi+AlndotDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477140; c=relaxed/simple;
	bh=q2o1SfbPZrT5U3Oc3x3XPvH3UQjxmd9gBQstr09RxAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQxQyUjK9NNwCbpb1CHa3NVXKtE+Yc/nKe1qMJmAIakDe3k6p0KsUzrHivKx4fHOYZuCRUnTjbw4yDW6/vGybgYEs5OhoKXumNZVnIFr8b/2v+Pr0rRmZ5Y4tT7lpz8FQs7JJapaTNVADgZ23hWqKP/h5pLztOFMkFVqik0uGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sTdTnV8K; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZabLYiK1CYMel8JukYGi2S/lIUCPgU/oF9HydEUjizI=; b=sTdTnV8KGZYjh/k/J0CAcEaB+f
	N+u1qMUI4AKBfpjYRhut8fxG8FOpeB02fQ7ai+fnzPn11XMuEH2ZQdHNtDrdi/pDYDBGYX9bua03n
	UYp3F5gcke50iXJrtPwkRG2OuEynoW83lLc8u9llPAieTketeDqLDME7eL8pZw9zX+zpnkiXSt01Z
	sofkQ71aBbylnAPbhtNmRhMrseYrXuLpw1QVv0Ct9Kj3Ey+EzH7Z4bCGb8Zjf0Pz5QZv1tx69BAxo
	OKEPVMghNpyCIVyfMXROq8LtZnYTXsxV3FLs7oWfyszRX/UQDOeO+n7SgtIvf77K8jbbZp0mdVcnx
	p4X8xgkg==;
Received: from 201-42-129-61.dsl.telesp.net.br ([201.42.129.61] helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rUCek-00B1M8-Mr; Sun, 28 Jan 2024 22:25:35 +0100
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
Subject: [PATCH v3 3/3] drm/amdgpu: Implement check_async_props for planes
Date: Sun, 28 Jan 2024 18:25:15 -0300
Message-ID: <20240128212515.630345-4-andrealmeid@igalia.com>
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

AMD GPUs can do async flips with changes on more properties than just
the FB ID, so implement a custom check_async_props for AMD planes.

Allow amdgpu to do async flips with overlay planes as well.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v3: allow overlay planes

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 116121e647ca..ed75b69636b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -25,6 +25,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
@@ -1430,6 +1431,33 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 	drm_atomic_helper_plane_destroy_state(plane, state);
 }
 
+static int amdgpu_dm_plane_check_async_props(struct drm_property *prop,
+					  struct drm_plane *plane,
+					  struct drm_plane_state *plane_state,
+					  struct drm_mode_object *obj,
+					  u64 prop_value, u64 old_val)
+{
+	struct drm_mode_config *config = &plane->dev->mode_config;
+	int ret;
+
+	if (prop != config->prop_fb_id &&
+	    prop != config->prop_in_fence_fd) {
+		ret = drm_atomic_plane_get_property(plane, plane_state,
+						    prop, &old_val);
+		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+	}
+
+	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY &&
+	    plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY) {
+		drm_dbg_atomic(prop->dev,
+			       "[OBJECT:%d] Only primary or overlay planes can be changed during async flip\n",
+			       obj->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct drm_plane_funcs dm_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
@@ -1438,6 +1466,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
 	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
 	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
+	.check_async_props = amdgpu_dm_plane_check_async_props,
 };
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
-- 
2.43.0


