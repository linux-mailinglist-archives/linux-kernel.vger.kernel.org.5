Return-Path: <linux-kernel+bounces-18836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE198263C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C1B2144E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322E12E7F;
	Sun,  7 Jan 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5863fKo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB14134A6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a997f3dfso65236566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 02:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704623722; x=1705228522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ghpvrm/3AEBdzbWk8YZiHGiX3pwaQb2AEZTDUC3tmOs=;
        b=g5863fKofSd739lSQdUBfc7ZkXwvjxbfrctCDAWPUhTB8FK0CMBJvqDmvbQED5INOd
         X+pQC+9YdFOBrXG1mozha59apSLU8zHjjuHMsBx6Amo35b1ruCGeHYXZ5s3BXTF9L7xu
         PlBMqPVwe3NVKeoeRf+unOFEj02wvKoS7nopSnnHipLshmxWGD4uy9dvDl7ei46vnnd1
         s8tRHljc1lQgqf+iE9YGsC+9SuDwhbMkzBEIw0Rwa0t2MyBRl7LrS72PaS9y5g30au1T
         nwroHIhGX4LAohRVpJnBL5sSaeOb9KZS9Q0ramIxSbKFkFbO36cZP8svdRrdrjjlKyIv
         yyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704623722; x=1705228522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ghpvrm/3AEBdzbWk8YZiHGiX3pwaQb2AEZTDUC3tmOs=;
        b=h4vQiyGs25C+DbzT7KaOYKXNEpWre7nawFNnTkV0L7UB6fanhud9A6P6bZBqLhbvH4
         icYJDBtgwgUiTUE1ReKl4pEd5JTylOoPn/P13mVlZa7Mrie3BnGYvRRWl8qGgiZkueYD
         xb7/HdxhAkIJDfG+n83c8Wfyqp7BWLg6kdX6sXySVtc2OkGgAzgDXXm0LItKN/r0ku23
         QexSzSi1ipiejwloY9oHABOBxJlNVmMHTv/DjRXzZ43f5NE9/tnzJ+602C9hHTwJtP3z
         aAs7Aerw35R6lw3sWSITbMxIi/mIn5EKLtHQZz6w0RkVlI4aJkE+Yk3RgaiVy7UQgrxf
         seyA==
X-Gm-Message-State: AOJu0YyA8tNMrYAHj4q7efTd2ZWu79bKG498WVU0nC6i3H6US7NM/JnZ
	t5oB4qGivAP1NbY3bmwAKW6fUVxobm0=
X-Google-Smtp-Source: AGHT+IEgl8h6+zpl6SUHiSqK5XScqK44QOXbHAyVzXhGtFSD7Qn2O6AOXZtqoHyFcj41HGl+ut3zuw==
X-Received: by 2002:a17:906:711b:b0:a27:32a0:b836 with SMTP id x27-20020a170906711b00b00a2732a0b836mr999374ejj.40.1704623721850;
        Sun, 07 Jan 2024 02:35:21 -0800 (PST)
Received: from EPUAKYIW03DD.. ([91.123.150.198])
        by smtp.gmail.com with ESMTPSA id lk16-20020a170906cb1000b00a26afb7fd54sm2930074ejb.15.2024.01.07.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 02:35:21 -0800 (PST)
From: Oleksandr Tyshchenko <olekstysh@gmail.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2] xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import
Date: Sun,  7 Jan 2024 12:34:26 +0200
Message-Id: <20240107103426.2038075-1-olekstysh@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

DO NOT access the underlying struct page of an sg table exported
by DMA-buf in dmabuf_imp_to_refs(), this is not allowed.
Please see drivers/dma-buf/dma-buf.c:mangle_sg_table() for details.

Fortunately, here (for special Xen device) we can avoid using
pages and calculate gfns directly from dma addresses provided by
the sg table.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Please note, I didn't manage to test the patch against the latest master branch
on real HW (patch was only build tested there). Patch was tested on Arm64
guests using Linux v5.10.41 from vendor's BSP, this is the environment where
running this use-case is possible and to which I have an access (Xen PV display
with zero-copy and backend domain as a buffer provider - be-alloc=1, so dma-buf
import part was involved). A little bit old, but the dma-buf import code
in gntdev-dmabuf.c hasn't been changed much since that time, all context
remains allmost the same according to my code inspection.

  v2:
   - add R-b and A-b
   - fix build warning noticed by kernel test robot by initializing
     "ret" in case of error
     https://lore.kernel.org/oe-kbuild-all/202401062122.it6zvLG0-lkp@intel.com/
---
---
 drivers/xen/gntdev-dmabuf.c | 44 ++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 4440e626b797..272c0ab01ef5 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-direct.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -50,7 +51,7 @@ struct gntdev_dmabuf {
 
 	/* Number of pages this buffer has. */
 	int nr_pages;
-	/* Pages of this buffer. */
+	/* Pages of this buffer (only for dma-buf export). */
 	struct page **pages;
 };
 
@@ -484,7 +485,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
 /* DMA buffer import support. */
 
 static int
-dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
+dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
 				int count, int domid)
 {
 	grant_ref_t priv_gref_head;
@@ -507,7 +508,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
 		}
 
 		gnttab_grant_foreign_access_ref(cur_ref, domid,
-						xen_page_to_gfn(pages[i]), 0);
+						gfns[i], 0);
 		refs[i] = cur_ref;
 	}
 
@@ -529,7 +530,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
 
 static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
 {
-	kfree(gntdev_dmabuf->pages);
 	kfree(gntdev_dmabuf->u.imp.refs);
 	kfree(gntdev_dmabuf);
 }
@@ -549,12 +549,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 	if (!gntdev_dmabuf->u.imp.refs)
 		goto fail;
 
-	gntdev_dmabuf->pages = kcalloc(count,
-				       sizeof(gntdev_dmabuf->pages[0]),
-				       GFP_KERNEL);
-	if (!gntdev_dmabuf->pages)
-		goto fail;
-
 	gntdev_dmabuf->nr_pages = count;
 
 	for (i = 0; i < count; i++)
@@ -576,7 +570,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 	struct dma_buf *dma_buf;
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
-	struct sg_page_iter sg_iter;
+	struct sg_dma_page_iter sg_iter;
+	unsigned long *gfns;
 	int i;
 
 	dma_buf = dma_buf_get(fd);
@@ -624,26 +619,25 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	gntdev_dmabuf->u.imp.sgt = sgt;
 
-	/* Now convert sgt to array of pages and check for page validity. */
+	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
+	if (!gfns) {
+		ret = ERR_PTR(-ENOMEM);
+		goto fail_unmap;
+	}
+
+	/* Now convert sgt to array of gfns without accessing underlying pages. */
 	i = 0;
-	for_each_sgtable_page(sgt, &sg_iter, 0) {
-		struct page *page = sg_page_iter_page(&sg_iter);
-		/*
-		 * Check if page is valid: this can happen if we are given
-		 * a page from VRAM or other resources which are not backed
-		 * by a struct page.
-		 */
-		if (!pfn_valid(page_to_pfn(page))) {
-			ret = ERR_PTR(-EINVAL);
-			goto fail_unmap;
-		}
+	for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
+		dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
+		unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
 
-		gntdev_dmabuf->pages[i++] = page;
+		gfns[i++] = pfn_to_gfn(pfn);
 	}
 
-	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
+	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
 						      gntdev_dmabuf->u.imp.refs,
 						      count, domid));
+	kfree(gfns);
 	if (IS_ERR(ret))
 		goto fail_end_access;
 
-- 
2.34.1


