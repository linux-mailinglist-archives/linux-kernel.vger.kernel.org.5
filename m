Return-Path: <linux-kernel+bounces-12494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005481F599
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFF9283B62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4746AA;
	Thu, 28 Dec 2023 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hcf+Qzjt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6E4401
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd6e37a9bso19354b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703749609; x=1704354409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TawasIE0Azwn68crHMEZplZs8B1uSGybMR0g+qgO6Sc=;
        b=hcf+QzjtpIk8qUx3KSUXCOwQzGQnh306L0krryLZCVh7/nEyrBmMjKacwMbt8RfevM
         WDT5fhce0D3a+LcrWcPthDYecMx8zscgoJ/WG6uW1n50WGE+JMq2h6LKOyrltqk6qlr/
         c52vS8Mdb1Fadar/FawNSW0QXsecU+SVDHoj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703749609; x=1704354409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TawasIE0Azwn68crHMEZplZs8B1uSGybMR0g+qgO6Sc=;
        b=a7B3cA/G3FDQ9WFVm7ZrodGJGJ+O7HD4lhVywLfQP/2PQydJyjvCuRXZWwIGvwc7om
         ScepF6KRc2bXuLuay4KUCyDTHFsYZtyYgvvA+bT0OQmcMrvvn86SbiXs+z9Cwi1hyeiU
         Bw6riDvmT1gGSHuAmkX2WgCqoNHS6uJYfZSTtjVHICA/CbPaiUFSdV2FXUxFpSNiMi7+
         tF1jSU91IKGj3m05bEkxtG1ZuTU5zY7FlawqKCGtlNOnnc/hRbi3Ao05Tb2gJHhFJ7U2
         JhEbHJ9emCR6mSMYpV/g+PixC1UBUqMPRUDw7oUDLMK4pnTffJtktqEDIub037Y3dpjW
         RJ9Q==
X-Gm-Message-State: AOJu0YxnDzlAjpSoyQAqXJhGBN0XHAbwIzPhik7hRUOgeb+B+QDucZNc
	vnQB9EJje3iCAp95c4yjvkhx8NJxZZNw
X-Google-Smtp-Source: AGHT+IEVwh4IKS7r4CUgeDW4LuozzBlcuB9u0r442VWTZuyuTe9HBV6SDZvF1FxlFMvgg2uEGPTsjQ==
X-Received: by 2002:a05:6358:5f01:b0:175:13f0:a5bf with SMTP id y1-20020a0563585f0100b0017513f0a5bfmr128131rwn.62.1703749609599;
        Wed, 27 Dec 2023 23:46:49 -0800 (PST)
Received: from chromium.org (112.157.221.35.bc.googleusercontent.com. [35.221.157.112])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006d9a6953f08sm8725633pfh.103.2023.12.27.23.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 23:46:49 -0800 (PST)
Date: Thu, 28 Dec 2023 16:46:45 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Fang Hui <hui.fang@nxp.com>, m.szyprowski@samsung.com,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, anle.pan@nxp.com, xuegang.liu@nxp.com,
	senozhatsky@chromium.org
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Message-ID: <20231228074645.765yytb2a7hvz7ti@chromium.org>
References: <20230914145812.12851-1-hui.fang@nxp.com>
 <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
 <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com>
 <20230926065143.GB5606@lst.de>
 <4d0f3de5-1d34-d998-cb55-7ce7bfaf3f49@arm.com>
 <20230926094616.GA14877@lst.de>
 <06d476e5-ba85-1504-d69b-a8c1cf617d54@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d476e5-ba85-1504-d69b-a8c1cf617d54@arm.com>

On Tue, Sep 26, 2023 at 03:38:33PM +0100, Robin Murphy wrote:
> On 26/09/2023 10:46 am, Christoph Hellwig wrote:
> > On Tue, Sep 26, 2023 at 09:21:15AM +0100, Robin Murphy wrote:
> > > On 2023-09-26 07:51, Christoph Hellwig wrote:
> > > > On Wed, Sep 20, 2023 at 05:54:26PM +0100, Robin Murphy wrote:
> > > > > As I mentioned before, I think it might make the most sense to make the
> > > > > whole thing into a "proper" dma_alloc_sgtable() function, which can then be
> > > > > used with dma_sync_sgtable_*() as dma_alloc_pages() is used with
> > > > > dma_sync_single_*() (and then dma_alloc_noncontiguous() clearly falls as
> > > > > the special in-between case).
> > > > 
> > > > Why not just use dma_alloc_noncontiguous if the caller wants an sgtable
> > > > anyway?
> > > 
> > > Because we don't need the restriction of the allocation being
> > > DMA-contiguous (and thus having to fall back to physically-contiguous in
> > > the absence of an IOMMU). That's what vb2_dma_contig already does, whereas
> > > IIUC vb2_dma_sg is for devices which can handle genuine scatter-gather DMA
> > > (and so are less likely to have an IOMMU, and more likely to need the best
> > > shot at piecing together large allocations).
> > 
> > Let's just extent dma_alloc_noncontiguous with a max_dma_segments
> > parameter instead of adding yet another API.
> 
> Sure, that could work equally well, and might even help make its existing
> usage a bit clearer.

I have a crude (and untested) series of patches that extend
dma_alloc_noncontiguous() with scatter-gather allocations according to
the new max_dma_segments parameter.

Things that I don't like about it:

1) It adds more code than it removes (even if I factor in the custom
allocation code removed from V4L2 vb2-dma-sg and dma-iommu).

2) The allocation scheme follows the current dma-iommu allocation code,
which uses __GFP_NORETRY for allocation orders higher than the minimum
allowed, which means that it's more likely to end up with smaller
segments than the current vb2-dma-sg allocation code. However, I made it
calculate the minimum order based on the allocation size and
max_dma_segments, so it should still be able to satisfy the hardware
constraints.

3) For platforms which use neither dma-direct nor dma-iommu (i.e. some
custom platform-specific dma_map_ops), we don't have much of an idea on
how to allocate the memory (but then neither vb2-dma-sg had), so it's
assumed that plain alloc_pages_node() will just work.

4) ...and, some of those platforms (like ARM) may have their own IOMMU
integration, which we have no idea about and we will unnecessarily
allocate physically-contiguous memory.

Things that I like about it:

a) It basically reuses the allocation code from dma-iommu. (dma-iommu
can be changed to call into dma_common_alloc_pages_noncontig().)

b) It handles most of the DMA constraints (GFP_DMA/32, max number of
segments, max segment size), so one can use it quite confidently to
allocate something that would work with their DMA engine without the
need for swiotlb.

c) With it, I could remove the custom allocation from V4L2 vb2-dma-sg.

The following is just a snippet of the core code so you can tell me if
it really makes sense going this way. If so, I can send a proper RFC
with all the bits and also changes in the API users.

8<---

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 73c95815789a..9c7b5b5ef53e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -7,6 +7,7 @@
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/export.h>
 #include <linux/mm.h>
+#include <linux/dma-mapping.h>
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/pfn.h>
@@ -392,6 +393,24 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	__dma_direct_free_pages(dev, page, size);
 }
 
+struct sg_table *dma_direct_alloc_noncontiguous(struct device *dev, size_t size,
+		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs,
+		unsigned int max_dma_segments)
+{
+	u64 phys_limit;
+
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
+
+	return dma_common_alloc_noncontiguous(dev, size, dir, gfp, attrs,
+					      max_dma_segments, phys_limit);
+}
+
+void dma_direct_free_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt, enum dma_data_direction dir)
+{
+	dma_common_free_noncontiguous(dev, size, sgt, dir);
+}
+
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
 void dma_direct_sync_sg_for_device(struct device *dev,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..dcfbe8af6521 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -619,32 +619,9 @@ int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(dma_mmap_pages);
 
-static struct sg_table *alloc_single_sgt(struct device *dev, size_t size,
-		enum dma_data_direction dir, gfp_t gfp)
-{
-	struct sg_table *sgt;
-	struct page *page;
-
-	sgt = kmalloc(sizeof(*sgt), gfp);
-	if (!sgt)
-		return NULL;
-	if (sg_alloc_table(sgt, 1, gfp))
-		goto out_free_sgt;
-	page = __dma_alloc_pages(dev, size, &sgt->sgl->dma_address, dir, gfp);
-	if (!page)
-		goto out_free_table;
-	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	sg_dma_len(sgt->sgl) = sgt->sgl->length;
-	return sgt;
-out_free_table:
-	sg_free_table(sgt);
-out_free_sgt:
-	kfree(sgt);
-	return NULL;
-}
-
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
-		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
+		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs,
+		unsigned int max_dma_segments)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct sg_table *sgt;
@@ -655,27 +632,20 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		return NULL;
 
 	if (ops && ops->alloc_noncontiguous)
-		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
+		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs, max_dma_segments);
+	else if (dma_alloc_direct(dev, ops))
+		sgt = dma_direct_alloc_noncontiguous(dev, size, dir, gfp, attrs, max_dma_segments);
 	else
-		sgt = alloc_single_sgt(dev, size, dir, gfp);
+		sgt = dma_common_alloc_noncontiguous(dev, size, dir, gfp,
+						     attrs, max_dma_segments,
+						     DMA_BIT_MASK(64));
 
-	if (sgt) {
-		sgt->nents = 1;
-		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
-	}
+	if (sgt)
+		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, sgt->nents, dir, attrs);
 	return sgt;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_noncontiguous);
 
-static void free_single_sgt(struct device *dev, size_t size,
-		struct sg_table *sgt, enum dma_data_direction dir)
-{
-	__dma_free_pages(dev, size, sg_page(sgt->sgl), sgt->sgl->dma_address,
-			 dir);
-	sg_free_table(sgt);
-	kfree(sgt);
-}
-
 void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
@@ -684,8 +654,10 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
 	if (ops && ops->free_noncontiguous)
 		ops->free_noncontiguous(dev, size, sgt, dir);
+	else if (dma_alloc_direct(dev, ops))
+		dma_direct_free_noncontiguous(dev, size, sgt, dir);
 	else
-		free_single_sgt(dev, size, sgt, dir);
+		dma_common_free_noncontiguous(dev, size, sgt, dir);
 }
 EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
 
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index af4a6ef48ce0..652774f9eeb7 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -3,7 +3,9 @@
  * Helpers for DMA ops implementations.  These generally rely on the fact that
  * the allocated memory contains normal pages in the direct kernel mapping.
  */
+#include <linux/dma-mapping.h>
 #include <linux/dma-map-ops.h>
+#include <linux/gfp.h>
 
 static struct page *dma_common_vaddr_to_page(void *cpu_addr)
 {
@@ -91,3 +93,204 @@ void dma_common_free_pages(struct device *dev, size_t size, struct page *page,
 				DMA_ATTR_SKIP_CPU_SYNC);
 	dma_free_contiguous(dev, page, size);
 }
+
+void dma_common_free_pages_noncontig(struct page **pages, int count)
+{
+	while (count--)
+		__free_page(pages[count]);
+	kvfree(pages);
+}
+
+struct page **dma_common_alloc_pages_noncontig(struct device *dev,
+		unsigned int count, unsigned long order_mask, gfp_t gfp,
+		u64 phys_limit)
+{
+	struct page **pages;
+	unsigned int i = 0, nid = dev_to_node(dev);
+
+	order_mask &= GENMASK(MAX_ORDER, 0);
+	if (!order_mask)
+		return NULL;
+
+	pages = kvcalloc(count, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	gfp |= __GFP_NOWARN;
+
+	while (count) {
+		struct page *page = NULL;
+		unsigned int order_size;
+
+		/*
+		 * Higher-order allocations are a convenience rather
+		 * than a necessity, hence using __GFP_NORETRY until
+		 * falling back to minimum-order allocations.
+		 */
+		for (order_mask &= GENMASK(__fls(count), 0);
+		     order_mask; order_mask &= ~order_size) {
+			unsigned int order = __fls(order_mask);
+			gfp_t alloc_flags;
+again:
+			alloc_flags = gfp;
+			order_size = 1U << order;
+			if (order_mask > order_size)
+				alloc_flags |= __GFP_NORETRY;
+			page = alloc_pages_node(nid, alloc_flags, order);
+			if (!page)
+				continue;
+			if (page_to_phys(page) + order_size - 1 >= phys_limit) {
+				__free_pages(page, order);
+
+				if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+				    phys_limit < DMA_BIT_MASK(64) &&
+				    !(gfp & (GFP_DMA32 | GFP_DMA))) {
+					gfp |= GFP_DMA32;
+					goto again;
+				}
+
+				if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
+					gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
+					goto again;
+				}
+			}
+			if (order)
+				split_page(page, order);
+			break;
+		}
+		if (!page) {
+			dma_common_free_pages_noncontig(pages, i);
+			return NULL;
+		}
+		count -= order_size;
+		while (order_size--)
+			pages[i++] = page++;
+	}
+	return pages;
+}
+
+static struct sg_table *alloc_single_sgt(struct dma_sgt_handle *sh,
+		struct device *dev, size_t size, enum dma_data_direction dir,
+		gfp_t gfp)
+{
+	struct sg_table *sgt = &sh->sgt;
+	struct page *page;
+
+	if (sg_alloc_table(sgt, 1, gfp))
+		goto out_free_sh;
+	page = dma_alloc_pages(dev, size, &sgt->sgl->dma_address, dir, gfp);
+	if (!page)
+		goto out_free_table;
+	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	sg_dma_len(sgt->sgl) = sgt->sgl->length;
+	return sgt;
+out_free_table:
+	sg_free_table(sgt);
+out_free_sh:
+	kfree(sh);
+	return NULL;
+}
+
+static void free_single_sgt(struct device *dev, size_t size,
+		struct sg_table *sgt, enum dma_data_direction dir)
+{
+	dma_free_pages(dev, size, sg_page(sgt->sgl), sgt->sgl->dma_address,
+			 dir);
+	sg_free_table(sgt);
+	kfree(sgt);
+}
+
+struct sg_table *dma_common_alloc_noncontiguous(struct device *dev, size_t size,
+		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs,
+		unsigned int max_dma_segments, u64 phys_limit)
+{
+	unsigned int max_order, min_order = 0;
+	unsigned int count, alloc_sizes;
+	struct dma_sgt_handle *sh;
+	size_t max_seg_size;
+	struct page **pages;
+
+	sh = kzalloc(sizeof(*sh), gfp);
+	if (!sh)
+		return NULL;
+
+	if (max_dma_segments == 1) {
+		struct sg_table *sgt;
+
+		sgt = alloc_single_sgt(sh, dev, size, dir, gfp);
+		if (!sgt)
+			goto out_free_sh;
+
+		return sgt;
+	}
+
+	max_seg_size = min_not_zero(size,
+				    min_not_zero(dma_get_max_seg_size(dev),
+						 dma_max_mapping_size(dev)));
+
+	max_order = get_order(max_seg_size);
+	/*
+	 * This is the only way to guarantee that we can satisfy the request.
+	 * We could also dynamically adjust this if we succeed to allocate
+	 * bigger chunks, but that would be a lot of complexity for unlikely
+	 * cases and little gain.
+	 */
+	if (max_dma_segments)
+		min_order = get_order(DIV_ROUND_UP(size, max_dma_segments));
+
+	/* No way to fit the allocation into an sg_table supported by the device. */
+	if (max_order < min_order)
+		goto out_free_sh;
+
+	/*
+	 * Even though not necessarily single pages, allocating smallest
+	 * possible granules is still cheaper and less likely to fail.
+	 */
+	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
+		max_order = min_order;
+
+	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	alloc_sizes = GENMASK(max_order, min_order);
+	pages = dma_common_alloc_pages_noncontig(dev, count, alloc_sizes, gfp,
+						 phys_limit);
+	if (!pages)
+		goto out_free_sh;
+
+	if (sg_alloc_table_from_pages_segment(&sh->sgt, pages, count, 0, size,
+					      max_seg_size, gfp))
+		goto out_free_pages;
+
+	if (max_dma_segments && sh->sgt.nents > max_dma_segments)
+		goto out_free_table;
+
+	/* dma_alloc_noncontiguous() doesn't sync the allocated memory */
+	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	if (dma_map_sgtable(dev, &sh->sgt, dir, attrs))
+		goto out_free_table;
+
+	sh->pages = pages;
+	return &sh->sgt;
+
+out_free_table:
+	sg_free_table(&sh->sgt);
+out_free_pages:
+	dma_common_free_pages_noncontig(pages, count);
+out_free_sh:
+	kfree(sh);
+	return NULL;
+}
+
+void dma_common_free_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct dma_sgt_handle *sh = sgt_handle(sgt);
+
+	if (sh->pages) {
+		dma_unmap_sgtable(dev, sgt, dir, 0);
+		dma_common_free_pages_noncontig(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+		sg_free_table(&sh->sgt);
+	} else {
+		free_single_sgt(dev, size, &sh->sgt, dir);
+	}
+	kfree(sh);
+}

-->8

Best,
Tomasz

