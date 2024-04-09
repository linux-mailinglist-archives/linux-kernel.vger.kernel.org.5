Return-Path: <linux-kernel+bounces-137711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEA89E645
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1EF2832CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B2D15A496;
	Tue,  9 Apr 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2DKJgSy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF7159579;
	Tue,  9 Apr 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706120; cv=none; b=T2C896h2rQhHV81rlj1uYrWrOJZsbkbNmCzceog1j3UK2r8InKfxn5irTZPFTnL13d1niu1k87nxSmg164yz1aM/uPL8LWzUIoYmEv6pWBJHzqA1ZaBPlLvVCIMuLFFek/+6hfpUTauG8JTekSxGNx2828WyRaS2sh84R4jEZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706120; c=relaxed/simple;
	bh=hzQDyN7JoTrEgxJqWBwrgKGJ7FgKuH1Cf2277Xy2mX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le66z/ozcZBQi9dXgcmcNzEGx5fQA6GWPD53vpb9MVXLvHya2IKNB9nz0EWyc0aYY5FAWjxjeI4dWz6QqX8rsKblwRGyWogUjMkV16NOL+3uIgKQtd2qq0G1Eos5JIMlJp2vFJH9B09AUNwR0TnU3svjXxohCywtajRbYMKC3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2DKJgSy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706119; x=1744242119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzQDyN7JoTrEgxJqWBwrgKGJ7FgKuH1Cf2277Xy2mX4=;
  b=m2DKJgSynf+NZ5bEkJFlmayij54QdOmprZT3egRRwi/teJgW2tEA9Y30
   qdQFFze+F3Dedc6FjbtQr83kFJgbLgnNdnXvkXliVUtpvEgfPoOsMIsGn
   OwYuvoQUR6wOKRE9v9zvrY3xW/rQn3LtIyhKSXqa+FMPAcZEfgS1G5/aE
   EvD07XGKLhm2NNZRExhXZ30CWzIoz/HetPecd251/ZPQfZZMSoY2yZs2q
   G1ZG9PlpYSjyScsRL+R43t31l61FSxJhiNkMZ36DtpujJIaz8FCSKXK8s
   ReUqI+Sd02TgvhLlcpcrCjU/XPkS4Mno9j999tatIuXAbhTOxVnGj7w8m
   g==;
X-CSE-ConnectionGUID: I8SySbPuTKWJTuQmozLdYA==
X-CSE-MsgGUID: FMvnySxfR4mcHFMOPE7lYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455109"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455109"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:58 -0700
X-CSE-ConnectionGUID: FqbOLMFBQgK4Jngz6xHD4A==
X-CSE-MsgGUID: Yi4Wn9dQRtarM4vVcqmmXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261809"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:58 -0700
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
Subject: [RFC PATCH v2 6/9] fpga: dfl: migrate Accelerated Function Unit driver to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:39 -0400
Message-ID: <20240409233942.828440-7-peter.colberg@intel.com>
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
patch series for the file: drivers/fpga/dfl-afu-main.c. This is done to
split a single monolithic change into multiple, smaller patches at the
request of the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
- Change afu_ioctl_*() to receive dfl_feature_dev_data instead of
  dfl_feature_platform_data.
- Replace local variable pdata with fdata in afu_mmap().
- Remove unused local variable pdata in afu_dev_{init,destroy}().
---
 drivers/fpga/dfl-afu-main.c | 110 ++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 6b97c073849e..61868cdd5b0b 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -504,9 +504,11 @@ static const struct attribute_group port_afu_group = {
 static int port_afu_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
+	struct dfl_feature_dev_data *fdata =
+					to_dfl_feature_dev_data(&pdev->dev);
 	struct resource *res = &pdev->resource[feature->resource_index];
 
-	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+	return afu_mmio_region_add(fdata,
 				   DFL_PORT_REGION_INDEX_AFU,
 				   resource_size(res), res->start,
 				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
@@ -525,9 +527,11 @@ static const struct dfl_feature_ops port_afu_ops = {
 static int port_stp_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
+	struct dfl_feature_dev_data *fdata =
+					to_dfl_feature_dev_data(&pdev->dev);
 	struct resource *res = &pdev->resource[feature->resource_index];
 
-	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
+	return afu_mmio_region_add(fdata,
 				   DFL_PORT_REGION_INDEX_STP,
 				   resource_size(res), res->start,
 				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
@@ -596,21 +600,19 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 static int afu_open(struct inode *inode, struct file *filp)
 {
 	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	int ret;
 
-	pdata = dev_get_platdata(&fdev->dev);
-	if (WARN_ON(!pdata))
-		return -ENODEV;
+	fdata = to_dfl_feature_dev_data(&fdev->dev);
 
-	mutex_lock(&pdata->lock);
-	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
+	mutex_lock(&fdata->lock);
+	ret = dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
 	if (!ret) {
 		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
-			dfl_feature_dev_use_count(pdata));
+			dfl_feature_dev_use_count(fdata));
 		filp->private_data = fdev;
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
@@ -618,29 +620,29 @@ static int afu_open(struct inode *inode, struct file *filp)
 static int afu_release(struct inode *inode, struct file *filp)
 {
 	struct platform_device *pdev = filp->private_data;
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	struct dfl_feature *feature;
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
-	pdata = dev_get_platdata(&pdev->dev);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
-	dfl_feature_dev_use_end(pdata);
+	mutex_lock(&fdata->lock);
+	dfl_feature_dev_use_end(fdata);
 
-	if (!dfl_feature_dev_use_count(pdata)) {
-		dfl_fpga_dev_for_each_feature(pdata, feature)
+	if (!dfl_feature_dev_use_count(fdata)) {
+		dfl_fpga_dev_for_each_feature(fdata, feature)
 			dfl_fpga_set_irq_triggers(feature, 0,
 						  feature->nr_irqs, NULL);
 		__port_reset(pdev);
-		afu_dma_region_destroy(pdata);
+		afu_dma_region_destroy(fdata);
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
-static long afu_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+static long afu_ioctl_check_extension(struct dfl_feature_dev_data *fdata,
 				      unsigned long arg)
 {
 	/* No extension support for now */
@@ -648,7 +650,7 @@ static long afu_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
 }
 
 static long
-afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user *arg)
+afu_ioctl_get_info(struct dfl_feature_dev_data *fdata, void __user *arg)
 {
 	struct dfl_fpga_port_info info;
 	struct dfl_afu *afu;
@@ -662,12 +664,12 @@ afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (info.argsz < minsz)
 		return -EINVAL;
 
-	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	info.flags = 0;
 	info.num_regions = afu->num_regions;
 	info.num_umsgs = afu->num_umsgs;
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	if (copy_to_user(arg, &info, sizeof(info)))
 		return -EFAULT;
@@ -675,7 +677,7 @@ afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user *arg)
 	return 0;
 }
 
-static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
+static long afu_ioctl_get_region_info(struct dfl_feature_dev_data *fdata,
 				      void __user *arg)
 {
 	struct dfl_fpga_port_region_info rinfo;
@@ -691,7 +693,7 @@ static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
 	if (rinfo.argsz < minsz || rinfo.padding)
 		return -EINVAL;
 
-	ret = afu_mmio_region_get_by_index(pdata, rinfo.index, &region);
+	ret = afu_mmio_region_get_by_index(fdata, rinfo.index, &region);
 	if (ret)
 		return ret;
 
@@ -706,7 +708,7 @@ static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
 }
 
 static long
-afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
+afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 {
 	struct dfl_fpga_port_dma_map map;
 	unsigned long minsz;
@@ -720,16 +722,16 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
-	ret = afu_dma_map_region(pdata, map.user_addr, map.length, &map.iova);
+	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &map, sizeof(map))) {
-		afu_dma_unmap_region(pdata, map.iova);
+		afu_dma_unmap_region(fdata, map.iova);
 		return -EFAULT;
 	}
 
-	dev_dbg(&pdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
+	dev_dbg(&fdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
 		(unsigned long long)map.user_addr,
 		(unsigned long long)map.length,
 		(unsigned long long)map.iova);
@@ -738,7 +740,7 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 }
 
 static long
-afu_ioctl_dma_unmap(struct dfl_feature_platform_data *pdata, void __user *arg)
+afu_ioctl_dma_unmap(struct dfl_feature_dev_data *fdata, void __user *arg)
 {
 	struct dfl_fpga_port_dma_unmap unmap;
 	unsigned long minsz;
@@ -751,33 +753,33 @@ afu_ioctl_dma_unmap(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (unmap.argsz < minsz || unmap.flags)
 		return -EINVAL;
 
-	return afu_dma_unmap_region(pdata, unmap.iova);
+	return afu_dma_unmap_region(fdata, unmap.iova);
 }
 
 static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct platform_device *pdev = filp->private_data;
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	struct dfl_feature *f;
 	long ret;
 
 	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
 
-	pdata = dev_get_platdata(&pdev->dev);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
 
 	switch (cmd) {
 	case DFL_FPGA_GET_API_VERSION:
 		return DFL_FPGA_API_VERSION;
 	case DFL_FPGA_CHECK_EXTENSION:
-		return afu_ioctl_check_extension(pdata, arg);
+		return afu_ioctl_check_extension(fdata, arg);
 	case DFL_FPGA_PORT_GET_INFO:
-		return afu_ioctl_get_info(pdata, (void __user *)arg);
+		return afu_ioctl_get_info(fdata, (void __user *)arg);
 	case DFL_FPGA_PORT_GET_REGION_INFO:
-		return afu_ioctl_get_region_info(pdata, (void __user *)arg);
+		return afu_ioctl_get_region_info(fdata, (void __user *)arg);
 	case DFL_FPGA_PORT_DMA_MAP:
-		return afu_ioctl_dma_map(pdata, (void __user *)arg);
+		return afu_ioctl_dma_map(fdata, (void __user *)arg);
 	case DFL_FPGA_PORT_DMA_UNMAP:
-		return afu_ioctl_dma_unmap(pdata, (void __user *)arg);
+		return afu_ioctl_dma_unmap(fdata, (void __user *)arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
@@ -785,7 +787,7 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * handled in this sub feature, and returns 0 and other
 		 * error code if cmd is handled.
 		 */
-		dfl_fpga_dev_for_each_feature(pdata, f)
+		dfl_fpga_dev_for_each_feature(fdata, f)
 			if (f->ops && f->ops->ioctl) {
 				ret = f->ops->ioctl(pdev, f, cmd, arg);
 				if (ret != -ENODEV)
@@ -805,8 +807,8 @@ static const struct vm_operations_struct afu_vma_ops = {
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct platform_device *pdev = filp->private_data;
-	struct dfl_feature_platform_data *pdata;
 	u64 size = vma->vm_end - vma->vm_start;
+	struct dfl_feature_dev_data *fdata;
 	struct dfl_afu_mmio_region region;
 	u64 offset;
 	int ret;
@@ -814,10 +816,10 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
 
 	offset = vma->vm_pgoff << PAGE_SHIFT;
-	ret = afu_mmio_region_get_by_offset(pdata, offset, size, &region);
+	ret = afu_mmio_region_get_by_offset(fdata, offset, size, &region);
 	if (ret)
 		return ret;
 
@@ -851,31 +853,31 @@ static const struct file_operations afu_fops = {
 
 static int afu_dev_init(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_afu *afu;
 
 	afu = devm_kzalloc(&pdev->dev, sizeof(*afu), GFP_KERNEL);
 	if (!afu)
 		return -ENOMEM;
 
-	mutex_lock(&pdata->lock);
-	dfl_fpga_pdata_set_private(pdata, afu);
-	afu_mmio_region_init(pdata);
-	afu_dma_region_init(pdata);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_fpga_fdata_set_private(fdata, afu);
+	afu_mmio_region_init(fdata);
+	afu_dma_region_init(fdata);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
 static int afu_dev_destroy(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
-	afu_mmio_region_destroy(pdata);
-	afu_dma_region_destroy(pdata);
-	dfl_fpga_pdata_set_private(pdata, NULL);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	afu_mmio_region_destroy(fdata);
+	afu_dma_region_destroy(fdata);
+	dfl_fpga_fdata_set_private(fdata, NULL);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
-- 
2.44.0


