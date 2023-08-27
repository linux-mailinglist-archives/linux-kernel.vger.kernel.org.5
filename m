Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A878A0D0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjH0R4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjH0R4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:56:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFD102
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:56:03 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE05E660729C;
        Sun, 27 Aug 2023 18:56:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693158962;
        bh=BNTmxQOM46+HQ6UEvSllq5xIsj79DPU82tEdZSTZezY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYecb6u32QyVdmEn/TuqovooYrq44AV5SNVKdiUSr3E/pzfUYVtffhwMb4FOe6j70
         q6PFDw9sQ77nyeMiF6uby3VhRUksKiMoT5XsX86W1N5QL5rvEAAFCr9cTqxXUOiZM4
         54GMfxmqbVW+V1IKiIUanDcVdJoDUJSPO5a/Txi42wRjzKQhAhIoNZxWEoFo7jtK9L
         zmQgQqeFCYe2yOmiQVHQFxhS0GDD8JVS9tL4nkQQE/Po9HGstXhDPmI2OV5uJ20Q2n
         N2c/NhjWWY8hy+l1eLFnWzv4ag8cnJMRjWcLbKN5wtUeMieiV7wsjM2LJUh/dkHY8/
         OpOMladm7edxg==
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
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v15 07/23] drm/shmem-helper: Make all exported symbols GPL
Date:   Sun, 27 Aug 2023 20:54:33 +0300
Message-ID: <20230827175449.1766701-8-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all drm-shmem exported symbols GPL to make them consistent with
the rest of drm-shmem symbols.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index db20b9123891..575704f38808 100644
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
@@ -636,7 +636,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
 }
-EXPORT_SYMBOL(drm_gem_shmem_print_info);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_print_info);
 
 /**
  * drm_gem_shmem_get_sg_table - Provide a scatter/gather table of pinned
-- 
2.41.0

