Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA07A11B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjINX3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjINX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:29:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E2270E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:29:02 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A1E66607354;
        Fri, 15 Sep 2023 00:28:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694734141;
        bh=21lEqDbncYmn6x++Y7957tMuiAQZiHCpmJysA2qwmVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMYNsP7pUhTi9bRMJn1j+9AuwcPN+R7BQkB/NbRkcZMXhbUnZ194qJ/Tf7YXQJeOL
         vg4JJ9y+02JTffMwRPsFEi5Vv4ZhuzREAihjg4Vxmoz8ygrFjilYn/ZwEYuUloF0hl
         +5UshVz1HfUyclkxO44uDsSXpUJ+UCS8dR4t4DE+cYaw0IJFjVOKV6IWoa420HM7ST
         tJq/erJKx/qwnE3VpZMwsiYO6+/+4FRud5Gkx6XcQ7x4TX7qZuXpJFd2HEjUwZjtjb
         n44DRTaz86t/+Z4DDuszjpWBSYFu2FfHMuJXvW5jqrr9TsK7yU+1RNpSNCFsc8LunN
         WCa5w3OMl7eRQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v17 03/18] drm/shmem-helper: Make all exported symbols GPL
Date:   Fri, 15 Sep 2023 02:27:06 +0300
Message-ID: <20230914232721.408581-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all drm-shmem exported symbols GPL to make them consistent with
the rest of drm-shmem symbols.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e435f986cd13..0d61f2b3e213 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -226,7 +226,7 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
 			  shmem->pages_mark_accessed_on_put);
 	shmem->pages = NULL;
 }
-EXPORT_SYMBOL(drm_gem_shmem_put_pages);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages);
 
 static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 {
@@ -271,7 +271,7 @@ int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_gem_shmem_pin);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_pin);
 
 /**
  * drm_gem_shmem_unpin - Unpin backing pages for a shmem GEM object
@@ -290,7 +290,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 	drm_gem_shmem_unpin_locked(shmem);
 	dma_resv_unlock(shmem->base.resv);
 }
-EXPORT_SYMBOL(drm_gem_shmem_unpin);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
 
 /*
  * drm_gem_shmem_vmap - Create a virtual mapping for a shmem GEM object
@@ -360,7 +360,7 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_gem_shmem_vmap);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_vmap);
 
 /*
  * drm_gem_shmem_vunmap - Unmap a virtual mapping for a shmem GEM object
@@ -396,7 +396,7 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
 
 	shmem->vaddr = NULL;
 }
-EXPORT_SYMBOL(drm_gem_shmem_vunmap);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_vunmap);
 
 static int
 drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
@@ -435,7 +435,7 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
 
 	return (madv >= 0);
 }
-EXPORT_SYMBOL(drm_gem_shmem_madvise);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_madvise);
 
 void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
 {
@@ -467,7 +467,7 @@ void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
 
 	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping, 0, (loff_t)-1);
 }
-EXPORT_SYMBOL(drm_gem_shmem_purge);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_purge);
 
 /**
  * drm_gem_shmem_dumb_create - Create a dumb shmem buffer object
@@ -642,7 +642,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
 }
-EXPORT_SYMBOL(drm_gem_shmem_print_info);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_print_info);
 
 /**
  * drm_gem_shmem_get_sg_table - Provide a scatter/gather table of pinned
-- 
2.41.0

