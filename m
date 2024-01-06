Return-Path: <linux-kernel+bounces-18468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A5825E11
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5111F1F22B61
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E015CE;
	Sat,  6 Jan 2024 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTNAvLcz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEA15AB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=a/L9G46O4yhPeKVX82rAQHZm/PfK/fhGBjlWV3FYXi0=; b=TTNAvLczvr5LT3niKmQY/G7frt
	4KoWmsHpP5oImO4I+wxtgQmeL+uphRn+pFdELVw8FQOJvmeqr5jSMHyGqpPR8rS8R6jLT0Y4GlV99
	ihjQ9rE+m8dnfb9rX73v+c9lYuUhqYOFgUJ8+NIa++G1bHQx/WP8cAcMrMApbnalValBaMuwzWD4q
	2rFBlWIoVrQw0l9RN58odnuJW/CjuzZ/85i65KpwBkAaLmH9qwDy6JOxbWJaQg74QRoux/tzbnFQW
	92IIgiDnm7NpNhNeK1jvEA3YD/7v7aZNU+1XKkUlbq7wVwS6pDJ8EjOFw/mPCQ18zLUR8faZr/aEf
	j+/ZPaxA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLxNm-000fid-1A;
	Sat, 06 Jan 2024 03:29:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2] drm/vram-helper: fix kernel-doc warnings
Date: Fri,  5 Jan 2024 19:29:57 -0800
Message-ID: <20240106032957.1195-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @funcs entry from struct drm_vram_mm to quieten the kernel-doc
warning.

Use the "define" kernel-doc keyword and an '\' line continuation
to fix another kernel-doc warning.

drm_gem_vram_helper.h:129: warning: missing initial short description on line:
 * DRM_GEM_VRAM_PLANE_HELPER_FUNCS -
drm_gem_vram_helper.h:185: warning: Excess struct member 'funcs' description in 'drm_vram_mm'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
v2: Add commit description

base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a

 include/drm/drm_gem_vram_helper.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -126,7 +126,7 @@ drm_gem_vram_plane_helper_cleanup_fb(str
 				     struct drm_plane_state *old_state);
 
 /**
- * DRM_GEM_VRAM_PLANE_HELPER_FUNCS -
+ * define DRM_GEM_VRAM_PLANE_HELPER_FUNCS - \
  *	Initializes struct drm_plane_helper_funcs for VRAM handling
  *
  * Drivers may use GEM BOs as VRAM helpers for the framebuffer memory. This
@@ -170,7 +170,6 @@ void drm_gem_vram_simple_display_pipe_cl
  * @vram_base:	Base address of the managed video memory
  * @vram_size:	Size of the managed video memory in bytes
  * @bdev:	The TTM BO device.
- * @funcs:	TTM BO functions
  *
  * The fields &struct drm_vram_mm.vram_base and
  * &struct drm_vram_mm.vrm_size are managed by VRAM MM, but are

