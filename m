Return-Path: <linux-kernel+bounces-137707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC089E63B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C9C283346
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63E15921A;
	Tue,  9 Apr 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jo7kjNLv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDC159207;
	Tue,  9 Apr 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706115; cv=none; b=SK4RQ4oKc6bFf/oIS7rlF/KN+S/fPvcLkSAz0PC26UXUVqXfjh9vcpP0AqTkPPmxkovd4XThxkZzyIS0J5ytFzPDOZn+VPvfYXchCw3nNe5XmcNjpgf7EFAFAoPioO3gFz8CiU1L5+gGFmVb2FASvQfS/bUOjeeVOUU2x3Z10r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706115; c=relaxed/simple;
	bh=/Z3TpKA0F/NyFsAdIs+s/LCa8zVboq9gXb9Kuii1q3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1hEoDeKEKTCCUoRDqYg8fJQXCoUWGzrOr7pmERPt+mMXAMg/JoQMMJxsXZ0+gnzrWYrYA9CtQ8lm3NPt9hDV5kNbhEnypKXHXxJZK+Qzr6lkHGhHSISaSWD4Tb9sH4bq48v5tiL+OhHn9dVgt/uanTnNX4lx9DNbrt+kAYSWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jo7kjNLv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706113; x=1744242113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Z3TpKA0F/NyFsAdIs+s/LCa8zVboq9gXb9Kuii1q3k=;
  b=jo7kjNLvN4sCzxxhf4g25+N6q/kEvWwYXFNItoyxnrKkVyNmljGuvlXN
   Uc7Gp8epUNZ9Bz/qCoCXKW/FTufymvMdxF3NEBxtCagq/sSis3LQvIkbF
   84oMatXEmiwzFzdOZgDjadQyT2JtfUtBdhsIKjUekSuG0W/vEYy2jCMXY
   i76F/i98lxnxpA/ut+t2kSm7smFzXouHHpFiEyYIV476mGOJYhxHtvCBX
   e4rZiHdTG/HgsUk/blWbFQgwwA6a2IaIEYzvL7hGVy6KndoFHghA9bm+i
   xuRLl+5pCxoccCZeTptJiBUfFuVvwdfTB4h7VW033FKrHK617UI9HtSpF
   g==;
X-CSE-ConnectionGUID: OmVdfndJSD+UsbXqONv7Og==
X-CSE-MsgGUID: YfRkVtiKQ266IdjXIN8XTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455084"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:53 -0700
X-CSE-ConnectionGUID: yVzSxDzETp6o7TrLIRrWiw==
X-CSE-MsgGUID: X3S1ZMCGT0uBR2KVc2oHsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261759"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:53 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [RFC PATCH v2 2/9] fpga: dfl: migrate AFU DMA region management driver to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:35 -0400
Message-ID: <20240409233942.828440-3-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409233942.828440-1-peter.colberg@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change separates out most of the symbol name changes required by this
patch series for the file: drivers/fpga/dfl-afu-dma-region.c. This is done
to split a single monolithic change into multiple, smaller patches at the
request of the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
- Reorder local variables in afu_dma_unpin_pages() to reverse Christmas
  tree order.
---
 drivers/fpga/dfl-afu-dma-region.c | 119 +++++++++++++++---------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 02b60fde0430..fb45e51b12af 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -16,26 +16,26 @@
 
 #include "dfl-afu.h"
 
-void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
+void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 
 	afu->dma_regions = RB_ROOT;
 }
 
 /**
  * afu_dma_pin_pages - pin pages of given dma memory region
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma memory region to be pinned
  *
  * Pin all the pages of given dfl_afu_dma_region.
  * Return 0 for success or negative error code.
  */
-static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
+static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
 			     struct dfl_afu_dma_region *region)
 {
 	int npages = region->length >> PAGE_SHIFT;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	int ret, pinned;
 
 	ret = account_locked_vm(current->mm, npages, true);
@@ -73,17 +73,17 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_dma_unpin_pages - unpin pages of given dma memory region
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma memory region to be unpinned
  *
  * Unpin all the pages of given dfl_afu_dma_region.
  * Return 0 for success or negative error code.
  */
-static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
+static void afu_dma_unpin_pages(struct dfl_feature_dev_data *fdata,
 				struct dfl_afu_dma_region *region)
 {
 	long npages = region->length >> PAGE_SHIFT;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 
 	unpin_user_pages(region->pages, npages);
 	kfree(region->pages);
@@ -133,20 +133,21 @@ static bool dma_region_check_iova(struct dfl_afu_dma_region *region,
 
 /**
  * afu_dma_region_add - add given dma region to rbtree
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma region to be added
  *
  * Return 0 for success, -EEXIST if dma region has already been added.
  *
- * Needs to be called with pdata->lock heold.
+ * Needs to be called with fdata->lock held.
  */
-static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
+static int afu_dma_region_add(struct dfl_feature_dev_data *fdata,
 			      struct dfl_afu_dma_region *region)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
+	struct device *dev = &fdata->dev->dev;
 	struct rb_node **new, *parent = NULL;
 
-	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n",
+	dev_dbg(dev, "add region (iova = %llx)\n",
 		(unsigned long long)region->iova);
 
 	new = &afu->dma_regions.rb_node;
@@ -177,50 +178,51 @@ static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_dma_region_remove - remove given dma region from rbtree
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma region to be removed
  *
- * Needs to be called with pdata->lock heold.
+ * Needs to be called with fdata->lock held.
  */
-static void afu_dma_region_remove(struct dfl_feature_platform_data *pdata,
+static void afu_dma_region_remove(struct dfl_feature_dev_data *fdata,
 				  struct dfl_afu_dma_region *region)
 {
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_afu *afu;
 
-	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
+	dev_dbg(dev, "del region (iova = %llx)\n",
 		(unsigned long long)region->iova);
 
-	afu = dfl_fpga_pdata_get_private(pdata);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	rb_erase(&region->node, &afu->dma_regions);
 }
 
 /**
  * afu_dma_region_destroy - destroy all regions in rbtree
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  *
- * Needs to be called with pdata->lock heold.
+ * Needs to be called with fdata->lock held.
  */
-void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
+void afu_dma_region_destroy(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct rb_node *node = rb_first(&afu->dma_regions);
 	struct dfl_afu_dma_region *region;
 
 	while (node) {
 		region = container_of(node, struct dfl_afu_dma_region, node);
 
-		dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
+		dev_dbg(&fdata->dev->dev, "del region (iova = %llx)\n",
 			(unsigned long long)region->iova);
 
 		rb_erase(node, &afu->dma_regions);
 
 		if (region->iova)
-			dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+			dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
 				       region->iova, region->length,
 				       DMA_BIDIRECTIONAL);
 
 		if (region->pages)
-			afu_dma_unpin_pages(pdata, region);
+			afu_dma_unpin_pages(fdata, region);
 
 		node = rb_next(node);
 		kfree(region);
@@ -229,7 +231,7 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
 
 /**
  * afu_dma_region_find - find the dma region from rbtree based on iova and size
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @iova: address of the dma memory area
  * @size: size of the dma memory area
  *
@@ -239,14 +241,14 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
  *   [@iova, @iova+size)
  * If nothing is matched returns NULL.
  *
- * Needs to be called with pdata->lock held.
+ * Needs to be called with fdata->lock held.
  */
 struct dfl_afu_dma_region *
-afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
+afu_dma_region_find(struct dfl_feature_dev_data *fdata, u64 iova, u64 size)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct rb_node *node = afu->dma_regions.rb_node;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 
 	while (node) {
 		struct dfl_afu_dma_region *region;
@@ -276,20 +278,20 @@ afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
 
 /**
  * afu_dma_region_find_iova - find the dma region from rbtree by iova
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @iova: address of the dma region
  *
- * Needs to be called with pdata->lock held.
+ * Needs to be called with fdata->lock held.
  */
 static struct dfl_afu_dma_region *
-afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 iova)
+afu_dma_region_find_iova(struct dfl_feature_dev_data *fdata, u64 iova)
 {
-	return afu_dma_region_find(pdata, iova, 0);
+	return afu_dma_region_find(fdata, iova, 0);
 }
 
 /**
  * afu_dma_map_region - map memory region for dma
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @user_addr: address of the memory region
  * @length: size of the memory region
  * @iova: pointer of iova address
@@ -298,9 +300,10 @@ afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 iova)
  * of the memory region via @iova.
  * Return 0 for success, otherwise error code.
  */
-int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
+int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
 		       u64 user_addr, u64 length, u64 *iova)
 {
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_afu_dma_region *region;
 	int ret;
 
@@ -323,47 +326,47 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	region->length = length;
 
 	/* Pin the user memory region */
-	ret = afu_dma_pin_pages(pdata, region);
+	ret = afu_dma_pin_pages(fdata, region);
 	if (ret) {
-		dev_err(&pdata->dev->dev, "failed to pin memory region\n");
+		dev_err(dev, "failed to pin memory region\n");
 		goto free_region;
 	}
 
 	/* Only accept continuous pages, return error else */
 	if (!afu_dma_check_continuous_pages(region)) {
-		dev_err(&pdata->dev->dev, "pages are not continuous\n");
+		dev_err(dev, "pages are not continuous\n");
 		ret = -EINVAL;
 		goto unpin_pages;
 	}
 
 	/* As pages are continuous then start to do DMA mapping */
-	region->iova = dma_map_page(dfl_fpga_pdata_to_parent(pdata),
+	region->iova = dma_map_page(dfl_fpga_fdata_to_parent(fdata),
 				    region->pages[0], 0,
 				    region->length,
 				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
-		dev_err(&pdata->dev->dev, "failed to map for dma\n");
+	if (dma_mapping_error(dfl_fpga_fdata_to_parent(fdata), region->iova)) {
+		dev_err(dev, "failed to map for dma\n");
 		ret = -EFAULT;
 		goto unpin_pages;
 	}
 
 	*iova = region->iova;
 
-	mutex_lock(&pdata->lock);
-	ret = afu_dma_region_add(pdata, region);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	ret = afu_dma_region_add(fdata, region);
+	mutex_unlock(&fdata->lock);
 	if (ret) {
-		dev_err(&pdata->dev->dev, "failed to add dma region\n");
+		dev_err(dev, "failed to add dma region\n");
 		goto unmap_dma;
 	}
 
 	return 0;
 
 unmap_dma:
-	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+	dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
 		       region->iova, region->length, DMA_BIDIRECTIONAL);
 unpin_pages:
-	afu_dma_unpin_pages(pdata, region);
+	afu_dma_unpin_pages(fdata, region);
 free_region:
 	kfree(region);
 	return ret;
@@ -371,34 +374,34 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_dma_unmap_region - unmap dma memory region
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @iova: dma address of the region
  *
  * Unmap dma memory region based on @iova.
  * Return 0 for success, otherwise error code.
  */
-int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova)
+int afu_dma_unmap_region(struct dfl_feature_dev_data *fdata, u64 iova)
 {
 	struct dfl_afu_dma_region *region;
 
-	mutex_lock(&pdata->lock);
-	region = afu_dma_region_find_iova(pdata, iova);
+	mutex_lock(&fdata->lock);
+	region = afu_dma_region_find_iova(fdata, iova);
 	if (!region) {
-		mutex_unlock(&pdata->lock);
+		mutex_unlock(&fdata->lock);
 		return -EINVAL;
 	}
 
 	if (region->in_use) {
-		mutex_unlock(&pdata->lock);
+		mutex_unlock(&fdata->lock);
 		return -EBUSY;
 	}
 
-	afu_dma_region_remove(pdata, region);
-	mutex_unlock(&pdata->lock);
+	afu_dma_region_remove(fdata, region);
+	mutex_unlock(&fdata->lock);
 
-	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+	dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
 		       region->iova, region->length, DMA_BIDIRECTIONAL);
-	afu_dma_unpin_pages(pdata, region);
+	afu_dma_unpin_pages(fdata, region);
 	kfree(region);
 
 	return 0;
-- 
2.44.0


