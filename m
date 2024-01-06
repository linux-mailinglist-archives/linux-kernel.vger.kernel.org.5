Return-Path: <linux-kernel+bounces-18465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8161825E0B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711171C23B7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2115C4;
	Sat,  6 Jan 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WTqQUqF2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759915A5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZnpNf4N7Jvohz0Y08QWu6pDVJuLwf1TN9JQTct6IR+8=; b=WTqQUqF2+CqA8gN2jZcWSp6ILJ
	eOrya0LfGWdme9a0jlm0M5KEl8c6p0KS6qRUWeuDUhGX2Qjh+8t77rKECPifddpXiNFVE2hn25TOM
	N6wCI04m0ULoYicD/WytJa/rdb5JPLO9B46xtBuycfNTFmq95M/Hmx0wjXMZ3joJHRFf6UTghrXWC
	zVUnCY+sXyyVY/Fz88b4mdqLamK91qXgM//BOY3Lttk0QbOeadojqBq1ylmcslf4OVw9rV4z6s/zG
	r/FbKBNwoKuxZF2tcUNx3NjAlJBwgtMTEDuAwIz2dcLUd/pZd0/w456n/l8iAmENiNmlVcZMrzPdH
	WslE5CSA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLxHA-000fG6-2V;
	Sat, 06 Jan 2024 03:23:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/vram-helper: fix kernel-doc warnings
Date: Fri,  5 Jan 2024 19:23:08 -0800
Message-ID: <20240106032308.27899-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


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

