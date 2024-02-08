Return-Path: <linux-kernel+bounces-58694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B384EA11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E78D1F22BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBF4F1E3;
	Thu,  8 Feb 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hvr/cR0O"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710304C3BB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426371; cv=none; b=brvODFhfqh2KVg1zXkAAGORv3Vwf2A7UXNPHEqmVi8rYX5t4hMtpSrU+8JVzDuzv+P+YHhDxU4LNMl9xMr1Z38+bh+PfqP5lBRxs4WrdXYt6NjWhETri9uC/WshbaW7AqE8C5yefYX9aXib0AwPXUt5qk8F9EAwc4eBT+tbUbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426371; c=relaxed/simple;
	bh=5ThtQbWLBgHmpYKWBlCX/ig9OsKqfKuNyKhycD5kgVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNFkFzCOx/ukhm+q8J1iOYfp5VKjNuUjh5h/TyyAOfERmA0Dgqn0VLVvl1OhehrvtZYQmSuPTG2HmiAZny/pxvzU1QwSmsoS0nlp37QNiXfOBn5yXWDesSk0/R9YrN/t2Ls0p5hN8HLouT1NrFWxdmFPBLDhRr5Y+WbN6G4/1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hvr/cR0O; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=krDIRYgU1uLFsIvNtqFMjTjuXBLodI3PgcqmjvYIA64=; b=hvr/cR0OHf6P3tXchCv2gDE5aR
	PVtyfC8SHe/BPtOuviR8yFT02FG/43kEbAnTlNU5BxEqQjOkgPs7iorjBv1dfuFiNwpel9TR20pDn
	nzqrLugDg5OIAhtBj3CBhIO45J+Mge9L605ebRtZY3wAOyJnbJSTI2ZEKUcqlyYeB++k8+K592jfH
	Kr0QG+L0fbMxxJIo5XvZ5LqPrMKo/FSML27ad/kxcGHSTOYIjGnpY8QkoM/s1EOYbM7ERCsrchhOY
	1wsj4MU3d17wuKKAt1z4vG0lUhaK/05C67sJ0Y20gxnR6LiKutb5yjbQNatTw4YcY/JUij+OSkHAC
	zFsE88YQ==;
Received: from [177.45.63.184] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rYBat-00FMBk-2a; Thu, 08 Feb 2024 22:06:03 +0100
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
Subject: [PATCH v4 2/3] drm: Allow drivers to choose plane types to async flip
Date: Thu,  8 Feb 2024 18:05:41 -0300
Message-ID: <20240208210542.550626-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208210542.550626-1-andrealmeid@igalia.com>
References: <20240208210542.550626-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Different planes may have different capabilities of doing async flips,
so create a field to let drivers allow async flip per plane type.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: new patch

 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 drivers/gpu/drm/drm_plane.c       | 3 +++
 include/drm/drm_plane.h           | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eecfb9e240d..5c66289188be 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1075,9 +1075,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+		if (async_flip && !plane_state->plane->async_flip) {
 			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
+				       "[OBJECT:%d] This type of plane cannot be changed during async flip\n",
 				       obj->id);
 			ret = -EINVAL;
 			break;
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 672c655c7a8e..71ada690222a 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -366,6 +366,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 
 	drm_modeset_lock_init(&plane->mutex);
 
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		plane->async_flip = true;
+
 	plane->base.properties = &plane->properties;
 	plane->dev = dev;
 	plane->funcs = funcs;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 641fe298052d..5e9efb7321ac 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -779,6 +779,11 @@ struct drm_plane {
 	 * @hotspot_y_property: property to set mouse hotspot y offset.
 	 */
 	struct drm_property *hotspot_y_property;
+
+	/**
+	 * @async_flip: indicates if a plane can do async flips
+	 */
+	bool async_flip;
 };
 
 #define obj_to_plane(x) container_of(x, struct drm_plane, base)
-- 
2.43.0


