Return-Path: <linux-kernel+bounces-121001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4988E15E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A27A295CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE171581E2;
	Wed, 27 Mar 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIVqQVpK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FB157E93;
	Wed, 27 Mar 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541807; cv=none; b=LD/5VevITmuF/fR+lg94l7MxVRCwLIZDE1GVsJhcrlc+Xt62MafdZIKxlEfNcJsqo7VGNAJZVwaqVkE+9gvh9i4zzGkigybo8uyzSyLnAjs/DYtZrtaKdQtPPqRHggR6R7CebGDevBpdxsGpDOsPubqgHW5ECQXpdH4HNp12TOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541807; c=relaxed/simple;
	bh=vfDUrXybSkY/QWqY5P95oYCYR4B4UmVr67bdaQS3lYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NhyCJ+cEj/ZhT2s7AUqYXMvMavXp93bgHfdsqsIXdx2ytqT4+BfKXTE2ZlmvZE0YT4f+TN0HbvVCh5FyvJNn8E7So6LCR5s4YZha5iogbVr5bNTg2bMh6OLP0sILJ4PUBT6R0U2s/bpMX4dHEZ4i5g5S+zm5ABVBhzomeEwPZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIVqQVpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F284C433C7;
	Wed, 27 Mar 2024 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541806;
	bh=vfDUrXybSkY/QWqY5P95oYCYR4B4UmVr67bdaQS3lYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VIVqQVpKCWdt52PE3AfUC/8rIDmOnO5+HaLT0/M8pD0QdWAA2AYOAiwNnsEY5o9pE
	 MXTSEjOo3IrRmHcprpG3BzgRCDf4eCYKgYInXqiQMuYrWBle8YzYll0gi8G1OiU9sB
	 9N4afVF8gIiBF0guIsmjoySK+WX6EVnjsPFPMsf/9PtlFx2Ow2OwJ0dfgh727zFHgd
	 m2o+PgQiMwFZntzm8/1YhMpDNCipruiDZ5FihxLgKZC+U7HNymkbAU/VU4AWxOL2hP
	 lUq8TrIafhO+tvJD7aQAAMhq4z6CSV4qkeeuPaaN31kxRa7B1iH8TOUKSMTIBn1lld
	 LxKnro5y2jwFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zack.rusin@broadcom.com
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/ttm: Make sure the mapped tt pages are decrypted when needed" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:44 -0400
Message-ID: <20240327121644.2832952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 71ce046327cfd3aef3f93d1c44e091395eb03f8f Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 5 Jan 2024 08:51:05 -0500
Subject: [PATCH] drm/ttm: Make sure the mapped tt pages are decrypted when
 needed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some drivers require the mapped tt pages to be decrypted. In an ideal
world this would have been handled by the dma layer, but the TTM page
fault handling would have to be rewritten to able to do that.

A side-effect of the TTM page fault handling is using a dma allocation
per order (via ttm_pool_alloc_page) which makes it impossible to just
trivially use dma_mmap_attrs. As a result ttm has to be very careful
about trying to make its pgprot for the mapped tt pages match what
the dma layer thinks it is. At the ttm layer it's possible to
deduce the requirement to have tt pages decrypted by checking
whether coherent dma allocations have been requested and the system
is running with confidential computing technologies.

This approach isn't ideal but keeping TTM matching DMAs expectations
for the page properties is in general fragile, unfortunately proper
fix would require a rewrite of TTM's page fault handling.

Fixes vmwgfx with SEV enabled.

v2: Explicitly include cc_platform.h
v3: Use CC_ATTR_GUEST_MEM_ENCRYPT instead of CC_ATTR_MEM_ENCRYPT to
limit the scope to guests and log when memory decryption is enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for page-based iomem")
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v5.14+
Link: https://patchwork.freedesktop.org/patch/msgid/20230926040359.3040017-1-zack@kde.org
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 13 +++++++++++--
 drivers/gpu/drm/ttm/ttm_tt.c      | 12 ++++++++++++
 include/drm/ttm/ttm_tt.h          |  9 ++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fd9fd3d15101c..0b3f4267130c4 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -294,7 +294,13 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, struct ttm_resource *res,
 	enum ttm_caching caching;
 
 	man = ttm_manager_type(bo->bdev, res->mem_type);
-	caching = man->use_tt ? bo->ttm->caching : res->bus.caching;
+	if (man->use_tt) {
+		caching = bo->ttm->caching;
+		if (bo->ttm->page_flags & TTM_TT_FLAG_DECRYPTED)
+			tmp = pgprot_decrypted(tmp);
+	} else  {
+		caching = res->bus.caching;
+	}
 
 	return ttm_prot_from_caching(caching, tmp);
 }
@@ -337,6 +343,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 		.no_wait_gpu = false
 	};
 	struct ttm_tt *ttm = bo->ttm;
+	struct ttm_resource_manager *man =
+			ttm_manager_type(bo->bdev, bo->resource->mem_type);
 	pgprot_t prot;
 	int ret;
 
@@ -346,7 +354,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
-	if (num_pages == 1 && ttm->caching == ttm_cached) {
+	if (num_pages == 1 && ttm->caching == ttm_cached &&
+	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
 		 * We're mapping a single page, and the desired
 		 * page protection is consistent with the bo.
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index d978dc539a9b9..578a7c37f00bd 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -31,11 +31,13 @@
 
 #define pr_fmt(fmt) "[TTM] " fmt
 
+#include <linux/cc_platform.h>
 #include <linux/sched.h>
 #include <linux/shmem_fs.h>
 #include <linux/file.h>
 #include <linux/module.h>
 #include <drm/drm_cache.h>
+#include <drm/drm_device.h>
 #include <drm/drm_util.h>
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_tt.h>
@@ -61,6 +63,7 @@ static atomic_long_t ttm_dma32_pages_allocated;
 int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 {
 	struct ttm_device *bdev = bo->bdev;
+	struct drm_device *ddev = bo->base.dev;
 	uint32_t page_flags = 0;
 
 	dma_resv_assert_held(bo->base.resv);
@@ -82,6 +85,15 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 		pr_err("Illegal buffer object type\n");
 		return -EINVAL;
 	}
+	/*
+	 * When using dma_alloc_coherent with memory encryption the
+	 * mapped TT pages need to be decrypted or otherwise the drivers
+	 * will end up sending encrypted mem to the gpu.
+	 */
+	if (bdev->pool.use_dma_alloc && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		page_flags |= TTM_TT_FLAG_DECRYPTED;
+		drm_info(ddev, "TT memory decryption enabled.");
+	}
 
 	bo->ttm = bdev->funcs->ttm_tt_create(bo, page_flags);
 	if (unlikely(bo->ttm == NULL))
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index a4eff85b1f449..2b9d856ff388d 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -79,6 +79,12 @@ struct ttm_tt {
 	 *   page_flags = TTM_TT_FLAG_EXTERNAL |
 	 *		  TTM_TT_FLAG_EXTERNAL_MAPPABLE;
 	 *
+	 * TTM_TT_FLAG_DECRYPTED: The mapped ttm pages should be marked as
+	 * not encrypted. The framework will try to match what the dma layer
+	 * is doing, but note that it is a little fragile because ttm page
+	 * fault handling abuses the DMA api a bit and dma_map_attrs can't be
+	 * used to assure pgprot always matches.
+	 *
 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
 	 * then unset when TTM calls ttm_tt_unpopulate().
@@ -87,8 +93,9 @@ struct ttm_tt {
 #define TTM_TT_FLAG_ZERO_ALLOC		BIT(1)
 #define TTM_TT_FLAG_EXTERNAL		BIT(2)
 #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
+#define TTM_TT_FLAG_DECRYPTED		BIT(4)
 
-#define TTM_TT_FLAG_PRIV_POPULATED	BIT(4)
+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(5)
 	uint32_t page_flags;
 	/** @num_pages: Number of pages in the page array. */
 	uint32_t num_pages;
-- 
2.43.0





