Return-Path: <linux-kernel+bounces-21262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAB828CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02FB28879B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4453C468;
	Tue,  9 Jan 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAA9ueKr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC81E492
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336788cb261so2959363f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704825107; x=1705429907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XFtGICw0ZOYP1KaZFQnHRK8o8vGVTmy1dPmwlRy2FE=;
        b=JAA9ueKrYZBKC2j/xDt9WZhUt2AKvwYHQeSZCmzkop+/3KUqDfgL00t/cCOVF5zaBi
         mw546brP0AKuO6mzY+HPBVITiDSDlnBQkZX55Lb5gwzCWumrJjjKXL4vlrgLOuJuRtQr
         hpmrAS+yrMHpk2RD85wpkwQmxeBGaIdsJSRajSvFZ9p+nJqmLTXVeZIX6YK4BrUpwT1f
         M1GH73Hs8oqgqTUO8vFnEkoGREJhJo5llgfMGybKW9ViwaW4LkDy0BoeFLEiwqJ5UEwD
         mbDaVF5Kz0S6mC0JdW+yIU7SG0Yli1FegHuZX5lgUs/33d/LuDNaaZdGbL2rIvC19+9l
         uFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825107; x=1705429907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XFtGICw0ZOYP1KaZFQnHRK8o8vGVTmy1dPmwlRy2FE=;
        b=iDBKVN/e1VQU/mK5E3oUb6qqKKexaqIuuYYvOjL+RpkmwNXGzFns6susUmuzhsdHsI
         mHfuKQ2rAT6UEAPGLJfW6/6GlQ4x+Cs5BlNlgBJyi/PaAvIPIX4QJMRGkKAHZn9ysiVw
         WQpkKNPkBs5fAleeVv4Ut9kAMHkehDdel5H2UKCHl/7sX5u7TBDeAZeGOXkpijkwVG6C
         U5CP05CIA5B/Pj0Y2NjVNKuKfKqutxdRHC7jkl14qt4L6Ron97c9jDx2SvKcvchaMqvp
         XHwL4orAo03ieWBNEWeR7RpDEmpGhaH3mSJX4MzZ5ETZEtC95MJ8YE1I+yDHJhjwaNoQ
         O/ZQ==
X-Gm-Message-State: AOJu0Yy01DccdrtF1l9aekNaB69SwmpE9fqk+ZlHe38PLwKM40ThRDqq
	Tu0IejlRn3+KmTiXIr5CPK8=
X-Google-Smtp-Source: AGHT+IFZ4AzApNWClmEutZip6HiuDvW/c+sSPmo7DJau1xq5iTK1B1Ps9CIi7CX59E4NeJQg4oPg4w==
X-Received: by 2002:adf:f605:0:b0:336:c5e2:fc9e with SMTP id t5-20020adff605000000b00336c5e2fc9emr838902wrp.35.1704825106616;
        Tue, 09 Jan 2024 10:31:46 -0800 (PST)
Received: from EPUAKYIW03DD.. ([91.123.150.198])
        by smtp.gmail.com with ESMTPSA id j17-20020adfea51000000b0033660f75d08sm2998540wrn.116.2024.01.09.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:31:45 -0800 (PST)
From: Oleksandr Tyshchenko <olekstysh@gmail.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3] xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import
Date: Tue,  9 Jan 2024 20:31:25 +0200
Message-Id: <20240109183125.2654368-1-olekstysh@gmail.com>
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
Acked-by: Daniel Vetter <daniel@ffwll.ch>
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

  V2:
   - add R-b and A-b
   - fix build warning noticed by kernel test robot by initializing
     "ret" in case of error
     https://lore.kernel.org/oe-kbuild-all/202401062122.it6zvLG0-lkp@intel.com/

  V3:
   - add A-b
   - add in-code comment
---
---
 drivers/xen/gntdev-dmabuf.c | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 4440e626b797..42adc2c1e06b 100644
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
@@ -624,26 +619,31 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	gntdev_dmabuf->u.imp.sgt = sgt;
 
-	/* Now convert sgt to array of pages and check for page validity. */
+	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
+	if (!gfns) {
+		ret = ERR_PTR(-ENOMEM);
+		goto fail_unmap;
+	}
+
+	/*
+	 * Now convert sgt to array of gfns without accessing underlying pages.
+	 * It is not allowed to access the underlying struct page of an sg table
+	 * exported by DMA-buf, but since we deal with special Xen dma device here
+	 * (not a normal physical one) look at the dma addresses in the sg table
+	 * and then calculate gfns directly from them.
+	 */
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


