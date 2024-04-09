Return-Path: <linux-kernel+bounces-137709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11C89E63F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FC61F22BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF8159578;
	Tue,  9 Apr 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akCryv6f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321F158DCB;
	Tue,  9 Apr 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706117; cv=none; b=q12cAPmswx04S7DCiFp63iKJJ81KzhfZICvcwK7nr2dRcr6m4+ugZygJ6NpqyDwMbE7yKXui38CFT8xoarE+Za6MlY2UeEN2sMzHGCcGumV9qS7FOf3HZDNdSGRjTJlBh38IZu50q2J49K9PrMqK7zJQzmL+7XZTuHpK4rYP//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706117; c=relaxed/simple;
	bh=f7e/oyVMdbTdINlF0aMs9BPxj2KwRBufaHG15Gly+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl4Wd4lLKkWF7f+240qHCin6/l0+ARvDjxZ3M0k35z6BlijusaFAMqBmjfsaBS6kEQe/9ccWqh+GyhxEgejNWRTQTtssS8zkYpsMvxD1ChjDanxeqIhlAVtndJrzcEF/vioJ6SnQ0KAy5XPQvpKGtYNBa+rvYzXhPKGHnyxPOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akCryv6f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706116; x=1744242116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f7e/oyVMdbTdINlF0aMs9BPxj2KwRBufaHG15Gly+mQ=;
  b=akCryv6fLO7lPPcYRZeJZbUb03+dMWhPGKtRLYP9FVeteBhf5HxMAL4m
   jIqtHH28mr1o51eajlChFAQNdiWbZwt4ZLYI85+bT7dFmMlyKtJTgUhxI
   YTGSCRZTUS9O+rEJWgoCRVAFyDWOg5WfxPc6hlJmtU1zd3fBKQHn0yOIa
   psO3UsUfWfvisUTddd/20VlNSM44NjeRfmNAYGb6qKL1aPsnWC5SC2jkg
   mvLewY37zhyrWWTE4NEZozQrRRDs98lsaaqPo0LgPnywBTwluRspDId+r
   lnSjeiG++MfA6JxfYsTNXn0kujBtuflzV77ZbVg4KY2J4DkrBDUU94BjE
   g==;
X-CSE-ConnectionGUID: LiNX/LDyTcG9qP1RabOkyw==
X-CSE-MsgGUID: wg6mm0QoRuybYHmmq1qGwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455099"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455099"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:56 -0700
X-CSE-ConnectionGUID: TUQJzVCnRWyi9ZLk2zz8ew==
X-CSE-MsgGUID: yTAKyI7FSXG1fzTeHDKRvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261793"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:55 -0700
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
Subject: [RFC PATCH v2 4/9] fpga: dfl: migrate FPGA Management Engine driver to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:37 -0400
Message-ID: <20240409233942.828440-5-peter.colberg@intel.com>
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
patch series for the file: drivers/fpga/dfl-fme-main.c. This is done to
split a single monolithic change into multiple, smaller patches at the
request of the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
- Change fme_hdr_ioctl_*() to receive dfl_feature_dev_data instead of
  dfl_feature_platform_data.
- Remove unused local variable pdata in fme_dev_{init,destroy}().
---
 drivers/fpga/dfl-fme-main.c | 68 ++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 864924f68f5e..7f119b09b54e 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -135,10 +135,10 @@ static const struct attribute_group fme_hdr_group = {
 	.attrs = fme_hdr_attrs,
 };
 
-static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
+static long fme_hdr_ioctl_release_port(struct dfl_feature_dev_data *fdata,
 				       unsigned long arg)
 {
-	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
+	struct dfl_fpga_cdev *cdev = fdata->dfl_cdev;
 	int port_id;
 
 	if (get_user(port_id, (int __user *)arg))
@@ -147,10 +147,10 @@ static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
 	return dfl_fpga_cdev_release_port(cdev, port_id);
 }
 
-static long fme_hdr_ioctl_assign_port(struct dfl_feature_platform_data *pdata,
+static long fme_hdr_ioctl_assign_port(struct dfl_feature_dev_data *fdata,
 				      unsigned long arg)
 {
-	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
+	struct dfl_fpga_cdev *cdev = fdata->dfl_cdev;
 	int port_id;
 
 	if (get_user(port_id, (int __user *)arg))
@@ -163,13 +163,13 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 			  struct dfl_feature *feature,
 			  unsigned int cmd, unsigned long arg)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
 	switch (cmd) {
 	case DFL_FPGA_FME_PORT_RELEASE:
-		return fme_hdr_ioctl_release_port(pdata, arg);
+		return fme_hdr_ioctl_release_port(fdata, arg);
 	case DFL_FPGA_FME_PORT_ASSIGN:
-		return fme_hdr_ioctl_assign_port(pdata, arg);
+		return fme_hdr_ioctl_assign_port(fdata, arg);
 	}
 
 	return -ENODEV;
@@ -411,14 +411,14 @@ static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 			     u32 attr, int channel, long val)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	struct dfl_feature *feature = dev_get_drvdata(dev);
 	int ret = 0;
 	u64 v;
 
 	val = clamp_val(val / MICRO, 0, PWR_THRESHOLD_MAX);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
 	switch (attr) {
 	case hwmon_power_max:
@@ -438,7 +438,7 @@ static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 		break;
 	}
 
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
@@ -589,7 +589,7 @@ static struct dfl_feature_driver fme_feature_drvs[] = {
 	},
 };
 
-static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+static long fme_ioctl_check_extension(struct dfl_feature_dev_data *fdata,
 				      unsigned long arg)
 {
 	/* No extension support for now */
@@ -600,19 +600,21 @@ static int fme_open(struct inode *inode, struct file *filp)
 {
 	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
+	struct dfl_feature_dev_data *fdata;
 	int ret;
 
 	if (WARN_ON(!pdata))
 		return -ENODEV;
 
-	mutex_lock(&pdata->lock);
-	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
+	fdata = pdata;
+	mutex_lock(&fdata->lock);
+	ret = dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
 	if (!ret) {
 		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
-			dfl_feature_dev_use_count(pdata));
+			dfl_feature_dev_use_count(fdata));
 		filp->private_data = pdata;
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
@@ -620,19 +622,20 @@ static int fme_open(struct inode *inode, struct file *filp)
 static int fme_release(struct inode *inode, struct file *filp)
 {
 	struct dfl_feature_platform_data *pdata = filp->private_data;
-	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature_dev_data *fdata = pdata;
+	struct platform_device *pdev = fdata->dev;
 	struct dfl_feature *feature;
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
-	mutex_lock(&pdata->lock);
-	dfl_feature_dev_use_end(pdata);
+	mutex_lock(&fdata->lock);
+	dfl_feature_dev_use_end(fdata);
 
-	if (!dfl_feature_dev_use_count(pdata))
-		dfl_fpga_dev_for_each_feature(pdata, feature)
+	if (!dfl_feature_dev_use_count(fdata))
+		dfl_fpga_dev_for_each_feature(fdata, feature)
 			dfl_fpga_set_irq_triggers(feature, 0,
 						  feature->nr_irqs, NULL);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
@@ -640,7 +643,8 @@ static int fme_release(struct inode *inode, struct file *filp)
 static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct dfl_feature_platform_data *pdata = filp->private_data;
-	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature_dev_data *fdata = pdata;
+	struct platform_device *pdev = fdata->dev;
 	struct dfl_feature *f;
 	long ret;
 
@@ -650,7 +654,7 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case DFL_FPGA_GET_API_VERSION:
 		return DFL_FPGA_API_VERSION;
 	case DFL_FPGA_CHECK_EXTENSION:
-		return fme_ioctl_check_extension(pdata, arg);
+		return fme_ioctl_check_extension(fdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd.
@@ -658,7 +662,7 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * handled in this sub feature, and returns 0 or other
 		 * error code if cmd is handled.
 		 */
-		dfl_fpga_dev_for_each_feature(pdata, f) {
+		dfl_fpga_dev_for_each_feature(fdata, f) {
 			if (f->ops && f->ops->ioctl) {
 				ret = f->ops->ioctl(pdev, f, cmd, arg);
 				if (ret != -ENODEV)
@@ -672,27 +676,27 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static int fme_dev_init(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_fme *fme;
 
 	fme = devm_kzalloc(&pdev->dev, sizeof(*fme), GFP_KERNEL);
 	if (!fme)
 		return -ENOMEM;
 
-	mutex_lock(&pdata->lock);
-	dfl_fpga_pdata_set_private(pdata, fme);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_fpga_fdata_set_private(fdata, fme);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
 static void fme_dev_destroy(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
-	dfl_fpga_pdata_set_private(pdata, NULL);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_fpga_fdata_set_private(fdata, NULL);
+	mutex_unlock(&fdata->lock);
 }
 
 static const struct file_operations fme_fops = {
-- 
2.44.0


