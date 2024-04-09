Return-Path: <linux-kernel+bounces-137713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF289E647
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8791F213D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5E815B0ED;
	Tue,  9 Apr 2024 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8kZ+nQS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF91598F0;
	Tue,  9 Apr 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706123; cv=none; b=EooSGyNjYYImsGegE9SoHtU19h3Xxib50tafy9Mh0HoE+wDP3/nvwx/w/2hje4wzYIoJ6xNEXJBQNVRuaGib+CKmUlzJ1JSba2p6LoQuLPphE1Laru70gZ4Kqq9B00htPUgG2pvkUkomY4A44bEbrI0dFa7flr40PZmzNLwD/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706123; c=relaxed/simple;
	bh=csIJLY5zu5c5qW4eASsNF58FWry7LrgtvPCUOjmWdh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecmTKGi5sJ02idI9O6KbNcaQOBZJLxMlzmFRYiRbsCRkiYkN4kyGRAZDEKGg2IKGYeUxyDxllxOA9OKboULaF7bGyoicdqRFWCSNidwYXeA6DeBLvgbq2PCdTPjrnsAYMmxFMJof+fLWeoF0FARvFSuOlDJERPz6OvytJg1Xd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8kZ+nQS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706121; x=1744242121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csIJLY5zu5c5qW4eASsNF58FWry7LrgtvPCUOjmWdh4=;
  b=M8kZ+nQS2G91J2v1w2R3jZ7X5mZk9JyRGPAcU1VuW0uMeT3fFLQrw0Ks
   76M4+x7x2Orbs7msyFQ/cG9VcbUN6pV/LblxK04zJvcpjMfow8Px9CHIu
   +NEBLwtj5ohq8fnW8OoncZCgKIVsucqe+aI5JHi6/PcELEQc4CYi3UUo4
   tel9KoeTQeVoqTb6ozuseaKgA9dJFdJDUZDOpgP+fgGZEUwmWEjR34cRY
   hzUQ6hLW8bOT7N8CkImi6vwIIs6UYNdOb9ZULAsz8qPSE6+wpMX4NnGrv
   YJumMF12NeoYuExi5A+nISizGzuqWB6qwtDgd3Cxpz7drvVVpZVkVd6hX
   g==;
X-CSE-ConnectionGUID: tcfhd2nLTGWFKn3Igotykw==
X-CSE-MsgGUID: 6eCX/xPZRHOXeFNpjyijtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455125"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455125"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:42:00 -0700
X-CSE-ConnectionGUID: tIq7xIcMSiyKxjvZsl57pw==
X-CSE-MsgGUID: cv5H5s2LSMmogkUmpSrtSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261825"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:42:00 -0700
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
Subject: [RFC PATCH v2 8/9] fpga: dfl: migrate dfl_get_feature_by_id() to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:41 -0400
Message-ID: <20240409233942.828440-9-peter.colberg@intel.com>
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
patch series for the function: dfl_get_feature_by_id(). This is done to
split a single monolithic change into multiple, smaller patches at the
request of the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
---
 drivers/fpga/dfl-afu-error.c |  59 +++++++------
 drivers/fpga/dfl-afu-main.c  | 166 ++++++++++++++++++-----------------
 drivers/fpga/dfl-afu.h       |  26 +++---
 drivers/fpga/dfl-fme-error.c |  98 +++++++++++----------
 drivers/fpga/dfl-fme-main.c  |  18 ++--
 drivers/fpga/dfl-fme-pr.c    |   6 +-
 drivers/fpga/dfl.c           |   3 +-
 drivers/fpga/dfl.h           |  13 ++-
 8 files changed, 203 insertions(+), 186 deletions(-)

diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index ab7be6217368..0f392d1f6d45 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -28,37 +28,36 @@
 #define ERROR_MASK		GENMASK_ULL(63, 0)
 
 /* mask or unmask port errors by the error mask register. */
-static void __afu_port_err_mask(struct device *dev, bool mask)
+static void __afu_port_err_mask(struct dfl_feature_dev_data *fdata, bool mask)
 {
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
 	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
 }
 
 static void afu_port_err_mask(struct device *dev, bool mask)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 
-	mutex_lock(&pdata->lock);
-	__afu_port_err_mask(dev, mask);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	__afu_port_err_mask(fdata, mask);
+	mutex_unlock(&fdata->lock);
 }
 
 /* clear port errors. */
 static int afu_port_err_clear(struct device *dev, u64 err)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev = to_platform_device(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base_err, *base_hdr;
 	int enable_ret = 0, ret = -EBUSY;
 	u64 v;
 
-	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
-	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base_err = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
+	base_hdr = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
 	/*
 	 * clear Port Errors
@@ -80,12 +79,12 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	}
 
 	/* Halt Port by keeping Port in reset */
-	ret = __afu_port_disable(pdev);
+	ret = __afu_port_disable(fdata);
 	if (ret)
 		goto done;
 
 	/* Mask all errors */
-	__afu_port_err_mask(dev, true);
+	__afu_port_err_mask(fdata, true);
 
 	/* Clear errors if err input matches with current port errors.*/
 	v = readq(base_err + PORT_ERROR);
@@ -102,28 +101,28 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	}
 
 	/* Clear mask */
-	__afu_port_err_mask(dev, false);
+	__afu_port_err_mask(fdata, false);
 
 	/* Enable the Port by clearing the reset */
-	enable_ret = __afu_port_enable(pdev);
+	enable_ret = __afu_port_enable(fdata);
 
 done:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return enable_ret ? enable_ret : ret;
 }
 
 static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 error;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	error = readq(base + PORT_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
 }
@@ -146,15 +145,15 @@ static DEVICE_ATTR_RW(errors);
 static ssize_t first_error_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 error;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	error = readq(base + PORT_FIRST_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
 }
@@ -164,16 +163,16 @@ static ssize_t first_malformed_req_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 req0, req1;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	req0 = readq(base + PORT_MALFORMED_REQ0);
 	req1 = readq(base + PORT_MALFORMED_REQ1);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%016llx%016llx\n",
 		       (unsigned long long)req1, (unsigned long long)req0);
@@ -191,12 +190,14 @@ static umode_t port_err_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 
+	fdata = to_dfl_feature_dev_data(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_ERROR))
+	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_ERROR))
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 61868cdd5b0b..42928cc7e42b 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -26,7 +26,7 @@
 
 /**
  * __afu_port_enable - enable a port by clear reset
- * @pdev: port platform device.
+ * @fdata: port feature dev data.
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
@@ -35,18 +35,17 @@
  *
  * The caller needs to hold lock for protection.
  */
-int __afu_port_enable(struct platform_device *pdev)
+int __afu_port_enable(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
 	u64 v;
 
-	WARN_ON(!pdata->disable_count);
+	WARN_ON(!fdata->disable_count);
 
-	if (--pdata->disable_count != 0)
+	if (--fdata->disable_count != 0)
 		return 0;
 
-	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	/* Clear port soft reset */
 	v = readq(base + PORT_HDR_CTRL);
@@ -60,7 +59,8 @@ int __afu_port_enable(struct platform_device *pdev)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       !(v & PORT_CTRL_SFTRST_ACK),
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(&pdev->dev, "timeout, failure to enable device\n");
+		dev_err(fdata->dfl_cdev->parent,
+			"timeout, failure to enable device\n");
 		return -ETIMEDOUT;
 	}
 
@@ -69,22 +69,21 @@ int __afu_port_enable(struct platform_device *pdev)
 
 /**
  * __afu_port_disable - disable a port by hold reset
- * @pdev: port platform device.
+ * @fdata: port feature dev data.
  *
  * Disable Port by setting the port soft reset bit, it puts the port into reset.
  *
  * The caller needs to hold lock for protection.
  */
-int __afu_port_disable(struct platform_device *pdev)
+int __afu_port_disable(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
 	u64 v;
 
-	if (pdata->disable_count++ != 0)
+	if (fdata->disable_count++ != 0)
 		return 0;
 
-	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	/* Set port soft reset */
 	v = readq(base + PORT_HDR_CTRL);
@@ -99,7 +98,8 @@ int __afu_port_disable(struct platform_device *pdev)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       v & PORT_CTRL_SFTRST_ACK,
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(&pdev->dev, "timeout, failure to disable device\n");
+		dev_err(fdata->dfl_cdev->parent,
+			"timeout, failure to disable device\n");
 		return -ETIMEDOUT;
 	}
 
@@ -118,34 +118,37 @@ int __afu_port_disable(struct platform_device *pdev)
  * (disabled). Any attempts on MMIO access to AFU while in reset, will
  * result errors reported via port error reporting sub feature (if present).
  */
-static int __port_reset(struct platform_device *pdev)
+static int __port_reset(struct dfl_feature_dev_data *fdata)
 {
 	int ret;
 
-	ret = __afu_port_disable(pdev);
+	ret = __afu_port_disable(fdata);
 	if (ret)
 		return ret;
 
-	return __afu_port_enable(pdev);
+	return __afu_port_enable(fdata);
 }
 
 static int port_reset(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata;
 	int ret;
 
-	mutex_lock(&pdata->lock);
-	ret = __port_reset(pdev);
-	mutex_unlock(&pdata->lock);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
+
+	mutex_lock(&fdata->lock);
+	ret = __port_reset(fdata);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
 
 static int port_get_id(struct platform_device *pdev)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	return FIELD_GET(PORT_CAP_PORT_NUM, readq(base + PORT_HDR_CAP));
 }
@@ -162,15 +165,15 @@ static DEVICE_ATTR_RO(id);
 static ssize_t
 ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_CTRL);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
 }
@@ -179,7 +182,7 @@ static ssize_t
 ltr_store(struct device *dev, struct device_attribute *attr,
 	  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	bool ltr;
 	u64 v;
@@ -187,14 +190,14 @@ ltr_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtobool(buf, &ltr))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_CTRL);
 	v &= ~PORT_CTRL_LATENCY;
 	v |= FIELD_PREP(PORT_CTRL_LATENCY, ltr ? 1 : 0);
 	writeq(v, base + PORT_HDR_CTRL);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -203,15 +206,15 @@ static DEVICE_ATTR_RW(ltr);
 static ssize_t
 ap1_event_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
 }
@@ -220,18 +223,18 @@ static ssize_t
 ap1_event_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	bool clear;
 
 	if (kstrtobool(buf, &clear) || !clear)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(PORT_STS_AP1_EVT, base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -241,15 +244,15 @@ static ssize_t
 ap2_event_show(struct device *dev, struct device_attribute *attr,
 	       char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
 }
@@ -258,18 +261,18 @@ static ssize_t
 ap2_event_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	bool clear;
 
 	if (kstrtobool(buf, &clear) || !clear)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(PORT_STS_AP2_EVT, base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -278,15 +281,15 @@ static DEVICE_ATTR_RW(ap2_event);
 static ssize_t
 power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%x\n", (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
 }
@@ -296,18 +299,18 @@ static ssize_t
 userclk_freqcmd_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freq_cmd;
 	void __iomem *base;
 
 	if (kstrtou64(buf, 0, &userclk_freq_cmd))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(userclk_freq_cmd, base + PORT_HDR_USRCLK_CMD0);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -317,18 +320,18 @@ static ssize_t
 userclk_freqcntrcmd_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freqcntr_cmd;
 	void __iomem *base;
 
 	if (kstrtou64(buf, 0, &userclk_freqcntr_cmd))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(userclk_freqcntr_cmd, base + PORT_HDR_USRCLK_CMD1);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -338,15 +341,15 @@ static ssize_t
 userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freqsts;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
 }
@@ -356,15 +359,15 @@ static ssize_t
 userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freqcntrsts;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)userclk_freqcntrsts);
@@ -388,10 +391,12 @@ static umode_t port_hdr_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 	umode_t mode = attr->mode;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+	fdata = to_dfl_feature_dev_data(dev);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	if (dfl_feature_revision(base) > 0) {
 		/*
@@ -456,21 +461,21 @@ static const struct dfl_feature_ops port_hdr_ops = {
 static ssize_t
 afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 guidl, guidh;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_AFU);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_AFU);
 
-	mutex_lock(&pdata->lock);
-	if (pdata->disable_count) {
-		mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	if (fdata->disable_count) {
+		mutex_unlock(&fdata->lock);
 		return -EBUSY;
 	}
 
 	guidl = readq(base + GUID_L);
 	guidh = readq(base + GUID_H);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
 }
@@ -485,12 +490,15 @@ static umode_t port_afu_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
+
+	fdata = to_dfl_feature_dev_data(dev);
 
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_AFU))
+	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_AFU))
 		return 0;
 
 	return attr->mode;
@@ -634,7 +642,7 @@ static int afu_release(struct inode *inode, struct file *filp)
 		dfl_fpga_dev_for_each_feature(fdata, feature)
 			dfl_fpga_set_irq_triggers(feature, 0,
 						  feature->nr_irqs, NULL);
-		__port_reset(pdev);
+		__port_reset(fdata);
 		afu_dma_region_destroy(fdata);
 	}
 	mutex_unlock(&fdata->lock);
@@ -884,15 +892,15 @@ static int afu_dev_destroy(struct platform_device *pdev)
 
 static int port_enable_set(struct platform_device *pdev, bool enable)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	int ret;
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	if (enable)
-		ret = __afu_port_enable(pdev);
+		ret = __afu_port_enable(fdata);
 	else
-		ret = __afu_port_disable(pdev);
-	mutex_unlock(&pdata->lock);
+		ret = __afu_port_disable(fdata);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 7bef3e300aa2..03be4f0969c7 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -76,27 +76,27 @@ struct dfl_afu {
 	struct rb_root dma_regions;
 };
 
-/* hold pdata->lock when call __afu_port_enable/disable */
-int __afu_port_enable(struct platform_device *pdev);
-int __afu_port_disable(struct platform_device *pdev);
+/* hold fdata->lock when call __afu_port_enable/disable */
+int __afu_port_enable(struct dfl_feature_dev_data *fdata);
+int __afu_port_disable(struct dfl_feature_dev_data *fdata);
 
-void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
-int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
+void afu_mmio_region_init(struct dfl_feature_dev_data *fdata);
+int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags);
-void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata);
-int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
+void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata);
+int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
 				 u32 region_index,
 				 struct dfl_afu_mmio_region *pregion);
-int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
 				  u64 offset, u64 size,
 				  struct dfl_afu_mmio_region *pregion);
-void afu_dma_region_init(struct dfl_feature_platform_data *pdata);
-void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata);
-int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
+void afu_dma_region_init(struct dfl_feature_dev_data *fdata);
+void afu_dma_region_destroy(struct dfl_feature_dev_data *fdata);
+int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
 		       u64 user_addr, u64 length, u64 *iova);
-int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova);
+int afu_dma_unmap_region(struct dfl_feature_dev_data *fdata, u64 iova);
 struct dfl_afu_dma_region *
-afu_dma_region_find(struct dfl_feature_platform_data *pdata,
+afu_dma_region_find(struct dfl_feature_dev_data *fdata,
 		    u64 iova, u64 size);
 
 extern const struct dfl_feature_ops port_err_ops;
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 51c2892ec06d..f00d949efe69 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -42,15 +42,15 @@
 static ssize_t pcie0_errors_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + PCIE0_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -59,7 +59,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	int ret = 0;
 	u64 v, val;
@@ -67,9 +67,9 @@ static ssize_t pcie0_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
 
 	v = readq(base + PCIE0_ERROR);
@@ -79,7 +79,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
 		ret = -EINVAL;
 
 	writeq(0ULL, base + PCIE0_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(pcie0_errors);
@@ -87,15 +87,15 @@ static DEVICE_ATTR_RW(pcie0_errors);
 static ssize_t pcie1_errors_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + PCIE1_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -104,7 +104,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	int ret = 0;
 	u64 v, val;
@@ -112,9 +112,9 @@ static ssize_t pcie1_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
 
 	v = readq(base + PCIE1_ERROR);
@@ -124,7 +124,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
 		ret = -EINVAL;
 
 	writeq(0ULL, base + PCIE1_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(pcie1_errors);
@@ -132,9 +132,10 @@ static DEVICE_ATTR_RW(pcie1_errors);
 static ssize_t nonfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
@@ -144,9 +145,10 @@ static DEVICE_ATTR_RO(nonfatal_errors);
 static ssize_t catfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
@@ -156,15 +158,15 @@ static DEVICE_ATTR_RO(catfatal_errors);
 static ssize_t inject_errors_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
@@ -174,7 +176,7 @@ static ssize_t inject_errors_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u8 inject_error;
 	u64 v;
@@ -185,14 +187,14 @@ static ssize_t inject_errors_store(struct device *dev,
 	if (inject_error & ~INJECT_ERROR_MASK)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
 	v &= ~INJECT_ERROR_MASK;
 	v |= FIELD_PREP(INJECT_ERROR_MASK, inject_error);
 	writeq(v, base + RAS_ERROR_INJECT);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -201,15 +203,15 @@ static DEVICE_ATTR_RW(inject_errors);
 static ssize_t fme_errors_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + FME_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -218,7 +220,7 @@ static ssize_t fme_errors_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v, val;
 	int ret = 0;
@@ -226,9 +228,9 @@ static ssize_t fme_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
 
 	v = readq(base + FME_ERROR);
@@ -240,7 +242,7 @@ static ssize_t fme_errors_store(struct device *dev,
 	/* Workaround: disable MBP_ERROR if feature revision is 0 */
 	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
 	       base + FME_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(fme_errors);
@@ -248,15 +250,15 @@ static DEVICE_ATTR_RW(fme_errors);
 static ssize_t first_error_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + FME_FIRST_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -265,15 +267,15 @@ static DEVICE_ATTR_RO(first_error);
 static ssize_t next_error_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + FME_NEXT_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -295,12 +297,14 @@ static umode_t fme_global_err_attrs_visible(struct kobject *kobj,
 					    struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 
+	fdata = to_dfl_feature_dev_data(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR))
+	if (!dfl_get_feature_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR))
 		return 0;
 
 	return attr->mode;
@@ -314,12 +318,12 @@ const struct attribute_group fme_global_err_group = {
 
 static void fme_err_mask(struct device *dev, bool mask)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
 	/* Workaround: keep MBP_ERROR always masked if revision is 0 */
 	if (dfl_feature_revision(base))
@@ -332,7 +336,7 @@ static void fme_err_mask(struct device *dev, bool mask)
 	writeq(mask ? ERROR_MASK : 0, base + RAS_NONFAT_ERROR_MASK);
 	writeq(mask ? ERROR_MASK : 0, base + RAS_CATFAT_ERROR_MASK);
 
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 }
 
 static int fme_global_err_init(struct platform_device *pdev,
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 7f119b09b54e..d271d1e60efd 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -28,10 +28,11 @@
 static ssize_t ports_num_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -47,10 +48,11 @@ static DEVICE_ATTR_RO(ports_num);
 static ssize_t bitstream_id_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_BITSTREAM_ID);
 
@@ -65,10 +67,11 @@ static DEVICE_ATTR_RO(bitstream_id);
 static ssize_t bitstream_metadata_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_BITSTREAM_MD);
 
@@ -79,10 +82,11 @@ static DEVICE_ATTR_RO(bitstream_metadata);
 static ssize_t cache_size_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -94,10 +98,11 @@ static DEVICE_ATTR_RO(cache_size);
 static ssize_t fabric_version_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -109,10 +114,11 @@ static DEVICE_ATTR_RO(fabric_version);
 static ssize_t socket_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index f4c95c4b88d9..7cc591df3ebb 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -87,8 +87,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		return -EINVAL;
 
 	/* get fme header region */
-	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
-					       FME_FEATURE_ID_HEADER);
+	fme_hdr = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	/* check port id */
 	v = readq(fme_hdr + FME_HDR_CAP);
@@ -379,8 +378,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 	int ret = -ENODEV, i = 0;
 	u64 fme_cap, port_offset;
 
-	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
-					       FME_FEATURE_ID_HEADER);
+	fme_hdr = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	mutex_lock(&fdata->lock);
 	priv = dfl_fpga_fdata_get_private(fdata);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 094ee97ea26c..219d52cce924 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1789,10 +1789,11 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_assign_port);
 static void config_port_access_mode(struct device *fme_dev, int port_id,
 				    bool is_vf)
 {
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(fme_dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_PORT_OFST(port_id));
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index b700f5bb7be7..7ea96788a969 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -414,23 +414,22 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
 	for ((feature) = (fdata)->features;				    \
 	   (feature) < (fdata)->features + (fdata)->num; (feature)++)
 
-static inline
-struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
+static inline struct dfl_feature *
+dfl_get_feature_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct dfl_feature *feature;
 
-	dfl_fpga_dev_for_each_feature(pdata, feature)
+	dfl_fpga_dev_for_each_feature(fdata, feature)
 		if (feature->id == id)
 			return feature;
 
 	return NULL;
 }
 
-static inline
-void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
+static inline void __iomem *
+dfl_get_feature_ioaddr_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 {
-	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
+	struct dfl_feature *feature = dfl_get_feature_by_id(fdata, id);
 
 	if (feature && feature->ioaddr)
 		return feature->ioaddr;
-- 
2.44.0


