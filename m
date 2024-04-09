Return-Path: <linux-kernel+bounces-137708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD689E63E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D711C20A86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F7159567;
	Tue,  9 Apr 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlnmNzyY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010F159211;
	Tue,  9 Apr 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706116; cv=none; b=QCCiy/+5Yq1v9cXgvo781ox0ar8hNz6JNW088aRq4tcLqfFXRAG2ejtiMa7q7BYiOvwRQb2ufbkHQ6TgzEdzInqeTXDafKytlgeuAgwm/SrAA+gXXmq7RchWDnWEyKpK3xNmqH/fbtPnmic6eAXsoJbelVRQ2kM7ETS1J3U4haM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706116; c=relaxed/simple;
	bh=fV42Klm8V51peR+/cC+IG71NY4osEXZZZUE0irhWd4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA4OkiJVWKJPZItw4jJfDBWw+iDun2WI7E9s3lUE3etTGu1UWWL139SkD5gb9mt3j3+QOAFYeEzPAZqSW/3q1uk3X96j51S4xLa2VB1jbcd9xRmd9xCnzaDKOB0l8gG7r+HMmX7LAA4iGJqmvtunQvlXreHcpl0ebJRw3q8Bql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlnmNzyY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706115; x=1744242115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fV42Klm8V51peR+/cC+IG71NY4osEXZZZUE0irhWd4s=;
  b=IlnmNzyYF8NLvOrIXtFv792H1hbho5Fuw10GwSk09w6mQw49JpPbZy8y
   5xA2GKO7kn5eEoVZ2Z76oA6omOKIKFG4FwWXf7yhtDNaIbhiO5y75nEae
   xQvmXtqsYmM2Xb9yY6rCd68lScmS8Ju9jQXei7TjwuzSlw3+YXMi2EVZP
   0rBBfGjgoj0eWPL8T+pV9/XznmpRAwVFJAxPgexnjDV2YQ7IVhSr9HiHH
   px9ADmFwtLEr5KZgF8sdY8eVFIgHsPZpfzR8hebZkY53/DDX9HxXd6zGG
   q58jcWcsRXjiCyoDsTBhsYTPbJzMpGZUBU5AQB/tyFhUdt+2kDLR8M+qW
   Q==;
X-CSE-ConnectionGUID: ud8l1UMtRnakDKCjNjyogg==
X-CSE-MsgGUID: QjMINPkZRP63Gp6JBnnbQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455091"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455091"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:55 -0700
X-CSE-ConnectionGUID: py15v8eaS66SxBPSF8GiOQ==
X-CSE-MsgGUID: aapubMLTQQiKgUO0JOSqJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261786"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:54 -0700
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
Subject: [RFC PATCH v2 3/9] fpga: dfl: migrate AFU MMIO region management driver to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:36 -0400
Message-ID: <20240409233942.828440-4-peter.colberg@intel.com>
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
patch series for the file: drivers/fpga/dfl-afu-region.c. This is done to
split a single monolithic change into multiple, smaller patches at the
request of the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
---
 drivers/fpga/dfl-afu-region.c | 51 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index 2e7b41629406..b11a5b21e666 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -12,11 +12,11 @@
 
 /**
  * afu_mmio_region_init - init function for afu mmio region support
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  */
-void afu_mmio_region_init(struct dfl_feature_platform_data *pdata)
+void afu_mmio_region_init(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 
 	INIT_LIST_HEAD(&afu->regions);
 }
@@ -39,7 +39,7 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
 /**
  * afu_mmio_region_add - add a mmio region to given feature dev.
  *
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  * @region_index: region index.
  * @region_size: region size.
  * @phys: region's physical address of this region.
@@ -47,14 +47,15 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags)
 {
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_afu_mmio_region *region;
 	struct dfl_afu *afu;
 	int ret = 0;
 
-	region = devm_kzalloc(&pdata->dev->dev, sizeof(*region), GFP_KERNEL);
+	region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
 
@@ -63,13 +64,13 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 	region->phys = phys;
 	region->flags = flags;
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
-	afu = dfl_fpga_pdata_get_private(pdata);
+	afu = dfl_fpga_fdata_get_private(fdata);
 
 	/* check if @index already exists */
 	if (get_region_by_index(afu, region_index)) {
-		mutex_unlock(&pdata->lock);
+		mutex_unlock(&fdata->lock);
 		ret = -EEXIST;
 		goto exit;
 	}
@@ -80,37 +81,37 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 
 	afu->region_cur_offset += region_size;
 	afu->num_regions++;
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 
 exit:
-	devm_kfree(&pdata->dev->dev, region);
+	devm_kfree(dev, region);
 	return ret;
 }
 
 /**
  * afu_mmio_region_destroy - destroy all mmio regions under given feature dev.
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  */
-void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata)
+void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct dfl_afu_mmio_region *tmp, *region;
 
 	list_for_each_entry_safe(region, tmp, &afu->regions, node)
-		devm_kfree(&pdata->dev->dev, region);
+		devm_kfree(&fdata->dev->dev, region);
 }
 
 /**
  * afu_mmio_region_get_by_index - find an afu region by index.
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  * @region_index: region index.
  * @pregion: ptr to region for result.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
 				 u32 region_index,
 				 struct dfl_afu_mmio_region *pregion)
 {
@@ -118,8 +119,8 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu *afu;
 	int ret = 0;
 
-	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	region = get_region_by_index(afu, region_index);
 	if (!region) {
 		ret = -EINVAL;
@@ -127,14 +128,14 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
 	}
 	*pregion = *region;
 exit:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret;
 }
 
 /**
  * afu_mmio_region_get_by_offset - find an afu mmio region by offset and size
  *
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  * @offset: region offset from start of the device fd.
  * @size: region size.
  * @pregion: ptr to region for result.
@@ -144,7 +145,7 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
 				  u64 offset, u64 size,
 				  struct dfl_afu_mmio_region *pregion)
 {
@@ -152,8 +153,8 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu *afu;
 	int ret = 0;
 
-	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	for_each_region(region, afu)
 		if (region->offset <= offset &&
 		    region->offset + region->size >= offset + size) {
@@ -162,6 +163,6 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
 		}
 	ret = -EINVAL;
 exit:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret;
 }
-- 
2.44.0


