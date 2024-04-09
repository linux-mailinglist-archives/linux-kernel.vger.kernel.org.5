Return-Path: <linux-kernel+bounces-137710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7205E89E641
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9501C1C21275
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00422159595;
	Tue,  9 Apr 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS1DOqTf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D8159560;
	Tue,  9 Apr 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706118; cv=none; b=svs+7WURfsjWNp9LGUOFnpFx8W7kBWZnoeYqFjTcpG4tHhRLbMHg7e7tsib89/ottGwfmHbGOMdpnIHI7/MuCW7hFLZ4BZp5WkvgYVhSRsiE2uUTvnix5TjH1COzmMMAtHJGLUngFFQNMz/qIcQSOHn9N90sGu2Tl5dg4VtLEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706118; c=relaxed/simple;
	bh=iKaSrf5zwPLA+q9IhwN1kJrQgT5cbqfZxW7V8J6yr24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhOxH7Fg+Eh4AU/2my42SnmaQCayltck9huw576izlJljdxFudv1HKN/f5me4NMwy/Dli4XTS88zk0ChdnIDgKaw17vZdc+UFiC2AuAKSEjVbuSkfNhETy/UxXjiQT3pR9kKTzaRZ+TbS8THRXAuSTFxa/xSl4ZNKu/D3qgpPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS1DOqTf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706117; x=1744242117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKaSrf5zwPLA+q9IhwN1kJrQgT5cbqfZxW7V8J6yr24=;
  b=bS1DOqTfhp5yS11Xvi/l4qcOMiE43qTjwVeR7VNMrtCntLOKZu9H6fB+
   wVxaguElj0P+DgvE6jgkeJAZwetU4WdEohzMc8iIxlv1O/VERn0YBM/Yg
   nTgkb5e7Qtarfbeh+1zE2dI5HFsKRJpwbyLnd+Gs/N8dF+gBdam+XHxkV
   JuuzfjhwS+7hmbrTXaRKzBXjf2vm4c0EvUng0UNO3VwJfO/VpMZIKumuv
   yDOWWXEAiSr73ylqRypWGnIBrzKSH2B/mDqmk+p+GUSaP6TbmVyXivQax
   NrDMNxfB+MLpdSZzZq7Lb4nltZcDD7G1An3L3UgSHoHU4k9xy3K82r/gv
   g==;
X-CSE-ConnectionGUID: Yxcdq0TLSJCKULxvoQHEIQ==
X-CSE-MsgGUID: YYfbsVUATu6RUxby5+mHcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455103"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455103"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:57 -0700
X-CSE-ConnectionGUID: TekG6ouoQf670rncSnjYuQ==
X-CSE-MsgGUID: 410dKT+yQ+WzkwRq7mosDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261804"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:56 -0700
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
Subject: [RFC PATCH v2 5/9] fpga: dfl: migrate FME partial reconfiguration driver to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:38 -0400
Message-ID: <20240409233942.828440-6-peter.colberg@intel.com>
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
patch series for the file: drivers/fpga/dfl-fme-pr.c. This is done to split
a single monolithic change into multiple, smaller patches at the request of
the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
- Substitute @fdata for @pdata in kernel-doc comments for
  dfl_fme_create_mgr() and dfl_fme_destroy_mgr().
---
 drivers/fpga/dfl-fme-pr.c | 82 ++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index cdcf6dea4cc9..f4c95c4b88d9 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -65,7 +65,7 @@ static struct fpga_region *dfl_fme_region_find(struct dfl_fme *fme, int port_id)
 
 static int fme_pr(struct platform_device *pdev, unsigned long arg)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	void __user *argp = (void __user *)arg;
 	struct dfl_fpga_fme_port_pr port_pr;
 	struct fpga_image_info *info;
@@ -123,8 +123,8 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
 
-	mutex_lock(&pdata->lock);
-	fme = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	fme = dfl_fpga_fdata_get_private(fdata);
 	/* fme device has been unregistered. */
 	if (!fme) {
 		ret = -EINVAL;
@@ -156,7 +156,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 	put_device(&region->dev);
 unlock_exit:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 free_exit:
 	vfree(buf);
 	return ret;
@@ -164,16 +164,16 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 /**
  * dfl_fme_create_mgr - create fpga mgr platform device as child device
+ * @fdata: fme feature dev data
  * @feature: sub feature info
- * @pdata: fme platform_device's pdata
  *
  * Return: mgr platform device if successful, and error code otherwise.
  */
 static struct platform_device *
-dfl_fme_create_mgr(struct dfl_feature_platform_data *pdata,
+dfl_fme_create_mgr(struct dfl_feature_dev_data *fdata,
 		   struct dfl_feature *feature)
 {
-	struct platform_device *mgr, *fme = pdata->dev;
+	struct platform_device *mgr, *fme = fdata->dev;
 	struct dfl_fme_mgr_pdata mgr_pdata;
 	int ret = -ENOMEM;
 
@@ -209,11 +209,11 @@ dfl_fme_create_mgr(struct dfl_feature_platform_data *pdata,
 
 /**
  * dfl_fme_destroy_mgr - destroy fpga mgr platform device
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  */
-static void dfl_fme_destroy_mgr(struct dfl_feature_platform_data *pdata)
+static void dfl_fme_destroy_mgr(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_fme *priv = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_fme *priv = dfl_fpga_fdata_get_private(fdata);
 
 	platform_device_unregister(priv->mgr);
 }
@@ -221,15 +221,15 @@ static void dfl_fme_destroy_mgr(struct dfl_feature_platform_data *pdata)
 /**
  * dfl_fme_create_bridge - create fme fpga bridge platform device as child
  *
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  * @port_id: port id for the bridge to be created.
  *
  * Return: bridge platform device if successful, and error code otherwise.
  */
 static struct dfl_fme_bridge *
-dfl_fme_create_bridge(struct dfl_feature_platform_data *pdata, int port_id)
+dfl_fme_create_bridge(struct dfl_feature_dev_data *fdata, int port_id)
 {
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_fme_br_pdata br_pdata;
 	struct dfl_fme_bridge *fme_br;
 	int ret = -ENOMEM;
@@ -238,7 +238,7 @@ dfl_fme_create_bridge(struct dfl_feature_platform_data *pdata, int port_id)
 	if (!fme_br)
 		return ERR_PTR(ret);
 
-	br_pdata.cdev = pdata->dfl_cdev;
+	br_pdata.cdev = fdata->dfl_cdev;
 	br_pdata.port_id = port_id;
 
 	fme_br->br = platform_device_alloc(DFL_FPGA_FME_BRIDGE,
@@ -274,11 +274,11 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
 
 /**
  * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  */
-static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
+static void dfl_fme_destroy_bridges(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_fme *priv = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_fme *priv = dfl_fpga_fdata_get_private(fdata);
 	struct dfl_fme_bridge *fbridge, *tmp;
 
 	list_for_each_entry_safe(fbridge, tmp, &priv->bridge_list, node) {
@@ -290,7 +290,7 @@ static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
 /**
  * dfl_fme_create_region - create fpga region platform device as child
  *
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  * @mgr: mgr platform device needed for region
  * @br: br platform device needed for region
  * @port_id: port id
@@ -298,12 +298,12 @@ static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
  * Return: fme region if successful, and error code otherwise.
  */
 static struct dfl_fme_region *
-dfl_fme_create_region(struct dfl_feature_platform_data *pdata,
+dfl_fme_create_region(struct dfl_feature_dev_data *fdata,
 		      struct platform_device *mgr,
 		      struct platform_device *br, int port_id)
 {
 	struct dfl_fme_region_pdata region_pdata;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_fme_region *fme_region;
 	int ret = -ENOMEM;
 
@@ -353,11 +353,11 @@ static void dfl_fme_destroy_region(struct dfl_fme_region *fme_region)
 
 /**
  * dfl_fme_destroy_regions - destroy all fme regions
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  */
-static void dfl_fme_destroy_regions(struct dfl_feature_platform_data *pdata)
+static void dfl_fme_destroy_regions(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_fme *priv = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_fme *priv = dfl_fpga_fdata_get_private(fdata);
 	struct dfl_fme_region *fme_region, *tmp;
 
 	list_for_each_entry_safe(fme_region, tmp, &priv->region_list, node) {
@@ -369,7 +369,8 @@ static void dfl_fme_destroy_regions(struct dfl_feature_platform_data *pdata)
 static int pr_mgmt_init(struct platform_device *pdev,
 			struct dfl_feature *feature)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata =
+			to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_fme_region *fme_region;
 	struct dfl_fme_bridge *fme_br;
 	struct platform_device *mgr;
@@ -381,15 +382,15 @@ static int pr_mgmt_init(struct platform_device *pdev,
 	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
 					       FME_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
-	priv = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	priv = dfl_fpga_fdata_get_private(fdata);
 
 	/* Initialize the region and bridge sub device list */
 	INIT_LIST_HEAD(&priv->region_list);
 	INIT_LIST_HEAD(&priv->bridge_list);
 
 	/* Create fpga mgr platform device */
-	mgr = dfl_fme_create_mgr(pdata, feature);
+	mgr = dfl_fme_create_mgr(fdata, feature);
 	if (IS_ERR(mgr)) {
 		dev_err(&pdev->dev, "fail to create fpga mgr pdev\n");
 		goto unlock;
@@ -405,7 +406,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 			continue;
 
 		/* Create bridge for each port */
-		fme_br = dfl_fme_create_bridge(pdata, i);
+		fme_br = dfl_fme_create_bridge(fdata, i);
 		if (IS_ERR(fme_br)) {
 			ret = PTR_ERR(fme_br);
 			goto destroy_region;
@@ -414,7 +415,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 		list_add(&fme_br->node, &priv->bridge_list);
 
 		/* Create region for each port */
-		fme_region = dfl_fme_create_region(pdata, mgr,
+		fme_region = dfl_fme_create_region(fdata, mgr,
 						   fme_br->br, i);
 		if (IS_ERR(fme_region)) {
 			ret = PTR_ERR(fme_region);
@@ -423,30 +424,31 @@ static int pr_mgmt_init(struct platform_device *pdev,
 
 		list_add(&fme_region->node, &priv->region_list);
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 
 destroy_region:
-	dfl_fme_destroy_regions(pdata);
-	dfl_fme_destroy_bridges(pdata);
-	dfl_fme_destroy_mgr(pdata);
+	dfl_fme_destroy_regions(fdata);
+	dfl_fme_destroy_bridges(fdata);
+	dfl_fme_destroy_mgr(fdata);
 unlock:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret;
 }
 
 static void pr_mgmt_uinit(struct platform_device *pdev,
 			  struct dfl_feature *feature)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata =
+			to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
-	dfl_fme_destroy_regions(pdata);
-	dfl_fme_destroy_bridges(pdata);
-	dfl_fme_destroy_mgr(pdata);
-	mutex_unlock(&pdata->lock);
+	dfl_fme_destroy_regions(fdata);
+	dfl_fme_destroy_bridges(fdata);
+	dfl_fme_destroy_mgr(fdata);
+	mutex_unlock(&fdata->lock);
 }
 
 static long fme_pr_ioctl(struct platform_device *pdev,
-- 
2.44.0


