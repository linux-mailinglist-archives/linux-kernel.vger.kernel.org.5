Return-Path: <linux-kernel+bounces-137714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E789E64A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22349B22A9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57F15B107;
	Tue,  9 Apr 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPqUC/El"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11811591FB;
	Tue,  9 Apr 2024 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706128; cv=none; b=f91gPaaRJ6KHqpcKas4mGn1bLqnJEVf9AHZR8fsKUkLP6Q6Dy3eWYEM42WNIv6PNkMStRSpRgFXZgnVvgHnRXiDBX5eastTWcu6C6y29pk7E/Bdnj9uqaI2oR9UCUwJfF7HzPsm3n1o1OSoMpCfLafVo9fEWCmvnXhQseLOFX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706128; c=relaxed/simple;
	bh=3Y99arneMJVfMQm6s8x8tYzykQEmu0Y2RJQmQarRruE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbkCAsRIhcbYYCnlKf0UjlmeIT4+lZa7x/2BfgJ2JgSd/WFkkpf85m9vjOyu3QJbn8EjIflFVkxBBU2IhjlTFkY5MQQIyyAKIcJp/+KEgqvJogCoRHJVPJDDAcVGjQc2IDpQtbuwbf09fAu0vRy/PIvwXLuu2Q2xnPYN4DVO1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPqUC/El; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706126; x=1744242126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Y99arneMJVfMQm6s8x8tYzykQEmu0Y2RJQmQarRruE=;
  b=XPqUC/Elpaq3kKxVkwjq3Iv8IM2KIfercbzdeq41SfoAcCC2/niLQEll
   Zrywi3lJFydswx7EKfKDmqXVPl6WHRnI8NBy9kliRc+AJvM6wDtGiegav
   ZG10qflWTLXfeDc0YVp5A9UIZ4D80Zw1KrkeMDHwdIGHHzZU+MTsbH4bL
   DzQ5MYKe9LHL8lU+0quyXJNcE6J4TXVMoTJo4HcAnR/98sJGtdUewyib6
   fJCQzMeWRS8SDBKixcpj43Gz7ik8BQlSF0a74OVs8zbGCc2+o1skr5JWZ
   uq8RSoS0VlJ5trhrLUwi1Eo5xH+PygEo66Eneyjf/vmylAoT1erYyEwGJ
   A==;
X-CSE-ConnectionGUID: fuH86J3UQQCatCutnVE5Eg==
X-CSE-MsgGUID: QIUd0aS7SVS6e7uiqktqxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455130"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455130"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:42:02 -0700
X-CSE-ConnectionGUID: +Hl+AmQ1Rne1xW7z1Q/XPw==
X-CSE-MsgGUID: lmg332V6QAqCY3yxx5DLIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261851"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:42:01 -0700
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
	Russ Weight <russell.h.weight@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [RFC PATCH v2 9/9] fpga: dfl: fix kernel warning on port release/assign for SRIOV
Date: Tue,  9 Apr 2024 19:39:42 -0400
Message-ID: <20240409233942.828440-10-peter.colberg@intel.com>
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

From: Xu Yilun <yilun.xu@intel.com>

DFL ports are registered as platform devices in PF mode. The port device
should be removed from the host when the user wants to configure the
port as a VF and pass through to a virtual machine. The FME device
ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are designed for this purpose.

In the previous implementation, the port platform device is not completely
destroyed on port release: it is removed from the system by
platform_device_del(), but the platform device instance is retained.
When the port assign ioctl is called, the platform device is added back by
platform_device_add(), which conflicts with this comment of device_add():
"Do not call this routine more than once for any device structure", and
will cause a kernel warning at runtime.

This patch tries to completely unregister the port platform device on
release and registers a new one on assign. But the main work is to remove
the dependency on struct dfl_feature_platform_data for many internal DFL
APIs. This structure holds many DFL enumeration infos for feature devices.
Many DFL APIs are expected to work with these info even when the port
platform device is unregistered. But with the change the platform_data will
be freed in this case. So this patch introduces a new structure
dfl_feature_dev_data for these APIs, which acts similarly to the previous
dfl_feature_platform_data. The dfl_feature_platform_data then only needs a
pointer to dfl_feature_dev_data to make the feature device driver work.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
- Substitute binfo->type for removed function feature_dev_id_type() in
  parse_feature_irqs().
- Return ERR_PTR(-ENOMEM) on !feature->params in
  binfo_create_feature_dev_data().
- Reorder cdev as first member of struct dfl_feature_platform_data
  such that container_of() to obtain pdata evaluates to a no-op.
- Align kernel-doc function name for __dfl_fpga_cdev_find_port_data().
---
 drivers/fpga/dfl-afu-main.c |   9 +-
 drivers/fpga/dfl-fme-br.c   |  24 +-
 drivers/fpga/dfl-fme-main.c |   6 +-
 drivers/fpga/dfl.c          | 430 +++++++++++++++++-------------------
 drivers/fpga/dfl.h          |  86 +++++---
 5 files changed, 281 insertions(+), 274 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 42928cc7e42b..ead03b7aea70 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -143,9 +143,8 @@ static int port_reset(struct platform_device *pdev)
 	return ret;
 }
 
-static int port_get_id(struct platform_device *pdev)
+static int port_get_id(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	void __iomem *base;
 
 	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
@@ -156,7 +155,8 @@ static int port_get_id(struct platform_device *pdev)
 static ssize_t
 id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	int id = port_get_id(to_platform_device(dev));
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
+	int id = port_get_id(fdata);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
 }
@@ -890,9 +890,8 @@ static int afu_dev_destroy(struct platform_device *pdev)
 	return 0;
 }
 
-static int port_enable_set(struct platform_device *pdev, bool enable)
+static int port_enable_set(struct dfl_feature_dev_data *fdata, bool enable)
 {
-	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	int ret;
 
 	mutex_lock(&fdata->lock);
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 0b01b3895277..a298a041877b 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -22,34 +22,34 @@
 struct fme_br_priv {
 	struct dfl_fme_br_pdata *pdata;
 	struct dfl_fpga_port_ops *port_ops;
-	struct platform_device *port_pdev;
+	struct dfl_feature_dev_data *port_fdata;
 };
 
 static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
 {
 	struct fme_br_priv *priv = bridge->priv;
-	struct platform_device *port_pdev;
+	struct dfl_feature_dev_data *port_fdata;
 	struct dfl_fpga_port_ops *ops;
 
-	if (!priv->port_pdev) {
-		port_pdev = dfl_fpga_cdev_find_port(priv->pdata->cdev,
-						    &priv->pdata->port_id,
-						    dfl_fpga_check_port_id);
-		if (!port_pdev)
+	if (!priv->port_fdata) {
+		port_fdata = dfl_fpga_cdev_find_port_data(priv->pdata->cdev,
+							  &priv->pdata->port_id,
+							  dfl_fpga_check_port_id);
+		if (!port_fdata)
 			return -ENODEV;
 
-		priv->port_pdev = port_pdev;
+		priv->port_fdata = port_fdata;
 	}
 
-	if (priv->port_pdev && !priv->port_ops) {
-		ops = dfl_fpga_port_ops_get(priv->port_pdev);
+	if (priv->port_fdata && !priv->port_ops) {
+		ops = dfl_fpga_port_ops_get(priv->port_fdata);
 		if (!ops || !ops->enable_set)
 			return -ENOENT;
 
 		priv->port_ops = ops;
 	}
 
-	return priv->port_ops->enable_set(priv->port_pdev, enable);
+	return priv->port_ops->enable_set(priv->port_fdata, enable);
 }
 
 static const struct fpga_bridge_ops fme_bridge_ops = {
@@ -85,8 +85,6 @@ static void fme_br_remove(struct platform_device *pdev)
 
 	fpga_bridge_unregister(br);
 
-	if (priv->port_pdev)
-		put_device(&priv->port_pdev->dev);
 	if (priv->port_ops)
 		dfl_fpga_port_ops_put(priv->port_ops);
 }
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index d271d1e60efd..e0a35c701121 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -612,7 +612,7 @@ static int fme_open(struct inode *inode, struct file *filp)
 	if (WARN_ON(!pdata))
 		return -ENODEV;
 
-	fdata = pdata;
+	fdata = pdata->fdata;
 	mutex_lock(&fdata->lock);
 	ret = dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
 	if (!ret) {
@@ -628,7 +628,7 @@ static int fme_open(struct inode *inode, struct file *filp)
 static int fme_release(struct inode *inode, struct file *filp)
 {
 	struct dfl_feature_platform_data *pdata = filp->private_data;
-	struct dfl_feature_dev_data *fdata = pdata;
+	struct dfl_feature_dev_data *fdata = pdata->fdata;
 	struct platform_device *pdev = fdata->dev;
 	struct dfl_feature *feature;
 
@@ -649,7 +649,7 @@ static int fme_release(struct inode *inode, struct file *filp)
 static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct dfl_feature_platform_data *pdata = filp->private_data;
-	struct dfl_feature_dev_data *fdata = pdata;
+	struct dfl_feature_dev_data *fdata = pdata->fdata;
 	struct platform_device *pdev = fdata->dev;
 	struct dfl_feature *f;
 	long ret;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 219d52cce924..916db9960fa0 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -119,17 +119,6 @@ static void dfl_id_free(enum dfl_id_type type, int id)
 	mutex_unlock(&dfl_id_mutex);
 }
 
-static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dfl_devs); i++)
-		if (!strcmp(dfl_devs[i].name, pdev->name))
-			return i;
-
-	return DFL_ID_MAX;
-}
-
 static enum dfl_id_type dfh_id_to_type(u16 id)
 {
 	int i;
@@ -161,7 +150,8 @@ static LIST_HEAD(dfl_port_ops_list);
  *
  * Please note that must dfl_fpga_port_ops_put after use the port_ops.
  */
-struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev)
+struct dfl_fpga_port_ops *
+dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_fpga_port_ops *ops = NULL;
 
@@ -171,7 +161,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev)
 
 	list_for_each_entry(ops, &dfl_port_ops_list, node) {
 		/* match port_ops using the name of platform device */
-		if (!strcmp(pdev->name, ops->name)) {
+		if (!strcmp(fdata->pdev_name, ops->name)) {
 			if (!try_module_get(ops->owner))
 				ops = NULL;
 			goto done;
@@ -227,22 +217,21 @@ EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
  *
  * Return: 1 if port device matches with given port id, otherwise 0.
  */
-int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
+int dfl_fpga_check_port_id(struct dfl_feature_dev_data *fdata, void *pport_id)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct dfl_fpga_port_ops *port_ops;
 
-	if (pdata->id != FEATURE_DEV_ID_UNUSED)
-		return pdata->id == *(int *)pport_id;
+	if (fdata->id != FEATURE_DEV_ID_UNUSED)
+		return fdata->id == *(int *)pport_id;
 
-	port_ops = dfl_fpga_port_ops_get(pdev);
+	port_ops = dfl_fpga_port_ops_get(fdata);
 	if (!port_ops || !port_ops->get_id)
 		return 0;
 
-	pdata->id = port_ops->get_id(pdev);
+	fdata->id = port_ops->get_id(fdata);
 	dfl_fpga_port_ops_put(port_ops);
 
-	return pdata->id == *(int *)pport_id;
+	return fdata->id == *(int *)pport_id;
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
 
@@ -351,10 +340,10 @@ static void release_dfl_dev(struct device *dev)
 }
 
 static struct dfl_device *
-dfl_dev_add(struct dfl_feature_platform_data *pdata,
+dfl_dev_add(struct dfl_feature_dev_data *fdata,
 	    struct dfl_feature *feature)
 {
-	struct platform_device *pdev = pdata->dev;
+	struct platform_device *pdev = fdata->dev;
 	struct resource *parent_res;
 	struct dfl_device *ddev;
 	int id, i, ret;
@@ -380,11 +369,11 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	if (ret)
 		goto put_dev;
 
-	ddev->type = feature_dev_id_type(pdev);
+	ddev->type = fdata->type;
 	ddev->feature_id = feature->id;
 	ddev->revision = feature->revision;
 	ddev->dfh_version = feature->dfh_version;
-	ddev->cdev = pdata->dfl_cdev;
+	ddev->cdev = fdata->dfl_cdev;
 	if (feature->param_size) {
 		ddev->params = kmemdup(feature->params, feature->param_size, GFP_KERNEL);
 		if (!ddev->params) {
@@ -435,11 +424,11 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	return ERR_PTR(ret);
 }
 
-static void dfl_devs_remove(struct dfl_feature_platform_data *pdata)
+static void dfl_devs_remove(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_feature *feature;
 
-	dfl_fpga_dev_for_each_feature(pdata, feature) {
+	dfl_fpga_dev_for_each_feature(fdata, feature) {
 		if (feature->ddev) {
 			device_unregister(&feature->ddev->dev);
 			feature->ddev = NULL;
@@ -447,13 +436,13 @@ static void dfl_devs_remove(struct dfl_feature_platform_data *pdata)
 	}
 }
 
-static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
+static int dfl_devs_add(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_feature *feature;
 	struct dfl_device *ddev;
 	int ret;
 
-	dfl_fpga_dev_for_each_feature(pdata, feature) {
+	dfl_fpga_dev_for_each_feature(fdata, feature) {
 		if (feature->ioaddr)
 			continue;
 
@@ -462,7 +451,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 			goto err;
 		}
 
-		ddev = dfl_dev_add(pdata, feature);
+		ddev = dfl_dev_add(fdata, feature);
 		if (IS_ERR(ddev)) {
 			ret = PTR_ERR(ddev);
 			goto err;
@@ -474,7 +463,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 	return 0;
 
 err:
-	dfl_devs_remove(pdata);
+	dfl_devs_remove(fdata);
 	return ret;
 }
 
@@ -505,11 +494,12 @@ EXPORT_SYMBOL(dfl_driver_unregister);
 void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = pdata->fdata;
 	struct dfl_feature *feature;
 
-	dfl_devs_remove(pdata);
+	dfl_devs_remove(fdata);
 
-	dfl_fpga_dev_for_each_feature(pdata, feature) {
+	dfl_fpga_dev_for_each_feature(fdata, feature) {
 		if (feature->ops) {
 			if (feature->ops->uinit)
 				feature->ops->uinit(pdev, feature);
@@ -580,12 +570,13 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 			      struct dfl_feature_driver *feature_drvs)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = pdata->fdata;
 	struct dfl_feature_driver *drv = feature_drvs;
 	struct dfl_feature *feature;
 	int ret;
 
 	while (drv->ops) {
-		dfl_fpga_dev_for_each_feature(pdata, feature) {
+		dfl_fpga_dev_for_each_feature(fdata, feature) {
 			if (dfl_feature_drv_match(feature, drv)) {
 				ret = dfl_feature_instance_init(pdev, pdata,
 								feature, drv);
@@ -596,7 +587,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 		drv++;
 	}
 
-	ret = dfl_devs_add(pdata);
+	ret = dfl_devs_add(fdata);
 	if (ret)
 		goto exit;
 
@@ -695,7 +686,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
  * @nr_irqs: number of irqs for all feature devices.
  * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
  *	       this device.
- * @feature_dev: current feature device.
+ * @type: the current FIU type.
  * @ioaddr: header register region address of current FIU in enumeration.
  * @start: register resource start of current FIU.
  * @len: max register resource length of current FIU.
@@ -708,7 +699,7 @@ struct build_feature_devs_info {
 	unsigned int nr_irqs;
 	int *irq_table;
 
-	struct platform_device *feature_dev;
+	enum dfl_id_type type;
 	void __iomem *ioaddr;
 	resource_size_t start;
 	resource_size_t len;
@@ -743,50 +734,51 @@ struct dfl_feature_info {
 	u64 params[];
 };
 
-static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
-				       struct platform_device *port)
+static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
+					struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&port->dev);
-
 	mutex_lock(&cdev->lock);
-	list_add(&pdata->node, &cdev->port_dev_list);
-	get_device(&pdata->dev->dev);
+	list_add(&fdata->node, &cdev->port_dev_list);
 	mutex_unlock(&cdev->lock);
 }
 
-/*
- * register current feature device, it is called when we need to switch to
- * another feature parsing or we have parsed all features on given device
- * feature list.
- */
-static int build_info_commit_dev(struct build_feature_devs_info *binfo)
+static struct dfl_feature_dev_data *
+binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
-	struct platform_device *fdev = binfo->feature_dev;
-	struct dfl_feature_platform_data *pdata;
+	enum dfl_id_type type = binfo->type;
 	struct dfl_feature_info *finfo, *p;
-	enum dfl_id_type type;
+	struct dfl_feature_dev_data *fdata;
 	int ret, index = 0, res_idx = 0;
 
-	type = feature_dev_id_type(fdev);
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
-	/*
-	 * we do not need to care for the memory which is associated with
-	 * the platform device. After calling platform_device_unregister(),
-	 * it will be automatically freed by device's release() callback,
-	 * platform_device_release().
-	 */
-	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
+	fdata = devm_kzalloc(binfo->dev, sizeof(*fdata), GFP_KERNEL);
+	if (!fdata)
+		return ERR_PTR(-ENOMEM);
+
+	fdata->features = devm_kcalloc(binfo->dev, binfo->feature_num,
+				       sizeof(*fdata->features), GFP_KERNEL);
+	if (!fdata->features)
+		return ERR_PTR(-ENOMEM);
+
+	fdata->resources = devm_kcalloc(binfo->dev, binfo->feature_num,
+					sizeof(*fdata->resources), GFP_KERNEL);
+	if (!fdata->resources)
+		return ERR_PTR(-ENOMEM);
+
+	fdata->type = type;
+
+	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
+	if (fdata->pdev_id < 0)
+		return ERR_PTR(fdata->pdev_id);
 
-	pdata->dev = fdev;
-	pdata->num = binfo->feature_num;
-	pdata->dfl_cdev = binfo->cdev;
-	pdata->id = FEATURE_DEV_ID_UNUSED;
-	mutex_init(&pdata->lock);
-	lockdep_set_class_and_name(&pdata->lock, &dfl_pdata_keys[type],
+	fdata->pdev_name = dfl_devs[type].name;
+	fdata->num = binfo->feature_num;
+	fdata->dfl_cdev = binfo->cdev;
+	fdata->id = FEATURE_DEV_ID_UNUSED;
+	mutex_init(&fdata->lock);
+	lockdep_set_class_and_name(&fdata->lock, &dfl_pdata_keys[type],
 				   dfl_pdata_key_strings[type]);
 
 	/*
@@ -795,25 +787,15 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	 * works properly for port device.
 	 * and it should always be 0 for fme device.
 	 */
-	WARN_ON(pdata->disable_count);
-
-	fdev->dev.platform_data = pdata;
-
-	/* each sub feature has one MMIO resource */
-	fdev->num_resources = binfo->feature_num;
-	fdev->resource = kcalloc(binfo->feature_num, sizeof(*fdev->resource),
-				 GFP_KERNEL);
-	if (!fdev->resource)
-		return -ENOMEM;
+	WARN_ON(fdata->disable_count);
 
 	/* fill features and resource information for feature dev */
 	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-		struct dfl_feature *feature = &pdata->features[index++];
+		struct dfl_feature *feature = &fdata->features[index++];
 		struct dfl_feature_irq_ctx *ctx;
 		unsigned int i;
 
 		/* save resource information for each feature */
-		feature->dev = fdev;
 		feature->id = finfo->fid;
 		feature->revision = finfo->revision;
 		feature->dfh_version = finfo->dfh_version;
@@ -823,7 +805,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 						       finfo->params, finfo->param_size,
 						       GFP_KERNEL);
 			if (!feature->params)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			feature->param_size = finfo->param_size;
 		}
@@ -839,19 +821,22 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 			feature->ioaddr =
 				devm_ioremap_resource(binfo->dev,
 						      &finfo->mmio_res);
-			if (IS_ERR(feature->ioaddr))
-				return PTR_ERR(feature->ioaddr);
+			if (IS_ERR(feature->ioaddr)) {
+				ret = PTR_ERR(feature->ioaddr);
+				goto err_free_id;
+			}
 		} else {
 			feature->resource_index = res_idx;
-			fdev->resource[res_idx++] = finfo->mmio_res;
+			fdata->resources[res_idx++] = finfo->mmio_res;
 		}
 
 		if (finfo->nr_irqs) {
 			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
 					   sizeof(*ctx), GFP_KERNEL);
-			if (!ctx)
-				return -ENOMEM;
-
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_free_id;
+			}
 			for (i = 0; i < finfo->nr_irqs; i++)
 				ctx[i].irq =
 					binfo->irq_table[finfo->irq_base + i];
@@ -864,55 +849,90 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
-	ret = platform_device_add(binfo->feature_dev);
-	if (!ret) {
-		if (type == PORT_ID)
-			dfl_fpga_cdev_add_port_dev(binfo->cdev,
-						   binfo->feature_dev);
-		else
-			binfo->cdev->fme_dev =
-					get_device(&binfo->feature_dev->dev);
-		/*
-		 * reset it to avoid build_info_free() freeing their resource.
-		 *
-		 * The resource of successfully registered feature devices
-		 * will be freed by platform_device_unregister(). See the
-		 * comments in build_info_create_dev().
-		 */
-		binfo->feature_dev = NULL;
-	}
+	fdata->resource_num = res_idx;
 
-	return ret;
+	return fdata;
+
+err_free_id:
+	dfl_id_free(type, fdata->pdev_id);
+
+	return ERR_PTR(ret);
 }
 
-static int
-build_info_create_dev(struct build_feature_devs_info *binfo,
-		      enum dfl_id_type type)
+/*
+ * register current feature device, it is called when we need to switch to
+ * another feature parsing or we have parsed all features on given device
+ * feature list.
+ */
+static int feature_dev_register(struct dfl_feature_dev_data *fdata)
 {
+	struct dfl_feature_platform_data pdata = { 0 };
 	struct platform_device *fdev;
+	struct dfl_feature *feature;
+	int ret;
 
-	if (type >= DFL_ID_MAX)
-		return -EINVAL;
-
-	/*
-	 * we use -ENODEV as the initialization indicator which indicates
-	 * whether the id need to be reclaimed
-	 */
-	fdev = platform_device_alloc(dfl_devs[type].name, -ENODEV);
+	fdev = platform_device_alloc(fdata->pdev_name, fdata->pdev_id);
 	if (!fdev)
 		return -ENOMEM;
 
-	binfo->feature_dev = fdev;
-	binfo->feature_num = 0;
+	fdata->dev = fdev;
 
-	INIT_LIST_HEAD(&binfo->sub_features);
+	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
+	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type,
+				      fdev->id);
+
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		feature->dev = fdev;
 
-	fdev->id = dfl_id_alloc(type, &fdev->dev);
-	if (fdev->id < 0)
-		return fdev->id;
+	ret = platform_device_add_resources(fdev, fdata->resources,
+					    fdata->resource_num);
+	if (ret)
+		goto err_put_dev;
+
+	pdata.fdata = fdata;
+	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
+	if (ret)
+		goto err_put_dev;
 
-	fdev->dev.parent = &binfo->cdev->region->dev;
-	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
+	ret = platform_device_add(fdev);
+	if (ret)
+		goto err_put_dev;
+
+	return 0;
+
+err_put_dev:
+	platform_device_put(fdev);
+	fdata->dev = NULL;
+
+	return ret;
+}
+
+static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
+{
+	platform_device_unregister(fdata->dev);
+	fdata->dev = NULL;
+}
+
+static int build_info_commit_dev(struct build_feature_devs_info *binfo)
+{
+	struct dfl_feature_dev_data *fdata;
+	int ret;
+
+	fdata = binfo_create_feature_dev_data(binfo);
+	if (IS_ERR(fdata))
+		return PTR_ERR(fdata);
+
+	ret = feature_dev_register(fdata);
+	if (ret)
+		return ret;
+
+	if (binfo->type == PORT_ID)
+		dfl_fpga_cdev_add_port_data(binfo->cdev, fdata);
+	else
+		binfo->cdev->fme_dev = get_device(&fdata->dev->dev);
+
+	/* reset the binfo for next FIU */
+	binfo->type = DFL_ID_MAX;
 
 	return 0;
 }
@@ -921,22 +941,11 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_info *finfo, *p;
 
-	/*
-	 * it is a valid id, free it. See comments in
-	 * build_info_create_dev()
-	 */
-	if (binfo->feature_dev && binfo->feature_dev->id >= 0) {
-		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
-			    binfo->feature_dev->id);
-
-		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-			list_del(&finfo->node);
-			kfree(finfo);
-		}
+	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
+		list_del(&finfo->node);
+		kfree(finfo);
 	}
 
-	platform_device_put(binfo->feature_dev);
-
 	devm_kfree(binfo->dev, binfo);
 }
 
@@ -1025,7 +1034,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		 * Instead, features with interrupt functionality provide
 		 * the information in feature specific registers.
 		 */
-		type = feature_dev_id_type(binfo->feature_dev);
+		type = binfo->type;
 		if (type == PORT_ID) {
 			switch (fid) {
 			case PORT_FEATURE_ID_UINT:
@@ -1217,7 +1226,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
 	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
 }
 
-#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
+#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)
 
 static int parse_feature_afu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
@@ -1227,12 +1236,11 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
 		return -EINVAL;
 	}
 
-	switch (feature_dev_id_type(binfo->feature_dev)) {
+	switch (binfo->type) {
 	case PORT_ID:
 		return parse_feature_port_afu(binfo, ofst);
 	default:
-		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
-			 binfo->feature_dev->name);
+		dev_info(binfo->dev, "AFU belonging to FIU is not supported yet.\n");
 	}
 
 	return 0;
@@ -1273,6 +1281,7 @@ static void build_info_complete(struct build_feature_devs_info *binfo)
 static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
 {
+	enum dfl_id_type type;
 	int ret = 0;
 	u32 offset;
 	u16 id;
@@ -1294,10 +1303,13 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 	v = readq(binfo->ioaddr + DFH);
 	id = FIELD_GET(DFH_ID, v);
 
-	/* create platform device for dfl feature dev */
-	ret = build_info_create_dev(binfo, dfh_id_to_type(id));
-	if (ret)
-		return ret;
+	type = dfh_id_to_type(id);
+	if (type >= DFL_ID_MAX)
+		return -EINVAL;
+
+	binfo->type = type;
+	binfo->feature_num = 0;
+	INIT_LIST_HEAD(&binfo->sub_features);
 
 	ret = create_feature_instance(binfo, 0, 0, 0);
 	if (ret)
@@ -1515,13 +1527,10 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
 
 static int remove_feature_dev(struct device *dev, void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	enum dfl_id_type type = feature_dev_id_type(pdev);
-	int id = pdev->id;
-
-	platform_device_unregister(pdev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 
-	dfl_id_free(type, id);
+	feature_dev_unregister(fdata);
+	dfl_id_free(fdata->type, fdata->pdev_id);
 
 	return 0;
 }
@@ -1573,6 +1582,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 		goto unregister_region_exit;
 	}
 
+	binfo->type = DFL_ID_MAX;
 	binfo->dev = info->dev;
 	binfo->cdev = cdev;
 
@@ -1614,25 +1624,10 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_enumerate);
  */
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 {
-	struct dfl_feature_platform_data *pdata, *ptmp;
-
 	mutex_lock(&cdev->lock);
 	if (cdev->fme_dev)
 		put_device(cdev->fme_dev);
 
-	list_for_each_entry_safe(pdata, ptmp, &cdev->port_dev_list, node) {
-		struct platform_device *port_dev = pdata->dev;
-
-		/* remove released ports */
-		if (!device_is_registered(&port_dev->dev)) {
-			dfl_id_free(feature_dev_id_type(port_dev),
-				    port_dev->id);
-			platform_device_put(port_dev);
-		}
-
-		list_del(&pdata->node);
-		put_device(&port_dev->dev);
-	}
 	mutex_unlock(&cdev->lock);
 
 	remove_feature_devs(cdev);
@@ -1643,7 +1638,7 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_remove);
 
 /**
- * __dfl_fpga_cdev_find_port - find a port under given container device
+ * __dfl_fpga_cdev_find_port_data - find a port under given container device
  *
  * @cdev: container device
  * @data: data passed to match function
@@ -1656,23 +1651,21 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_remove);
  *
  * NOTE: you will need to drop the device reference with put_device() after use.
  */
-struct platform_device *
-__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
-			  int (*match)(struct platform_device *, void *))
+struct dfl_feature_dev_data *
+__dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
+			       int (*match)(struct dfl_feature_dev_data *,
+					    void *))
 {
-	struct dfl_feature_platform_data *pdata;
-	struct platform_device *port_dev;
-
-	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		port_dev = pdata->dev;
+	struct dfl_feature_dev_data *fdata;
 
-		if (match(port_dev, data) && get_device(&port_dev->dev))
-			return port_dev;
+	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
+		if (match(fdata, data))
+			return fdata;
 	}
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port);
+EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port_data);
 
 static int __init dfl_fpga_init(void)
 {
@@ -1706,33 +1699,29 @@ static int __init dfl_fpga_init(void)
  */
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 {
-	struct dfl_feature_platform_data *pdata;
-	struct platform_device *port_pdev;
+	struct dfl_feature_dev_data *fdata;
 	int ret = -ENODEV;
 
 	mutex_lock(&cdev->lock);
-	port_pdev = __dfl_fpga_cdev_find_port(cdev, &port_id,
-					      dfl_fpga_check_port_id);
-	if (!port_pdev)
+	fdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
+					       dfl_fpga_check_port_id);
+	if (!fdata)
 		goto unlock_exit;
 
-	if (!device_is_registered(&port_pdev->dev)) {
+	if (!fdata->dev) {
 		ret = -EBUSY;
-		goto put_dev_exit;
+		goto unlock_exit;
 	}
 
-	pdata = dev_get_platdata(&port_pdev->dev);
-
-	mutex_lock(&pdata->lock);
-	ret = dfl_feature_dev_use_begin(pdata, true);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	ret = dfl_feature_dev_use_begin(fdata, true);
+	mutex_unlock(&fdata->lock);
 	if (ret)
-		goto put_dev_exit;
+		goto unlock_exit;
 
-	platform_device_del(port_pdev);
+	feature_dev_unregister(fdata);
 	cdev->released_port_num++;
-put_dev_exit:
-	put_device(&port_pdev->dev);
+
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1752,34 +1741,30 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_release_port);
  */
 int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 {
-	struct dfl_feature_platform_data *pdata;
-	struct platform_device *port_pdev;
+	struct dfl_feature_dev_data *fdata;
 	int ret = -ENODEV;
 
 	mutex_lock(&cdev->lock);
-	port_pdev = __dfl_fpga_cdev_find_port(cdev, &port_id,
-					      dfl_fpga_check_port_id);
-	if (!port_pdev)
+	fdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
+					       dfl_fpga_check_port_id);
+	if (!fdata)
 		goto unlock_exit;
 
-	if (device_is_registered(&port_pdev->dev)) {
+	if (fdata->dev) {
 		ret = -EBUSY;
-		goto put_dev_exit;
+		goto unlock_exit;
 	}
 
-	ret = platform_device_add(port_pdev);
+	ret = feature_dev_register(fdata);
 	if (ret)
-		goto put_dev_exit;
-
-	pdata = dev_get_platdata(&port_pdev->dev);
+		goto unlock_exit;
 
-	mutex_lock(&pdata->lock);
-	dfl_feature_dev_use_end(pdata);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_feature_dev_use_end(fdata);
+	mutex_unlock(&fdata->lock);
 
 	cdev->released_port_num--;
-put_dev_exit:
-	put_device(&port_pdev->dev);
+
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1817,14 +1802,14 @@ static void config_port_access_mode(struct device *fme_dev, int port_id,
  */
 void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 
 	mutex_lock(&cdev->lock);
-	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&pdata->dev->dev))
+	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
+		if (fdata->dev)
 			continue;
 
-		config_port_pf_mode(cdev->fme_dev, pdata->id);
+		config_port_pf_mode(cdev->fme_dev, fdata->id);
 	}
 	mutex_unlock(&cdev->lock);
 }
@@ -1843,7 +1828,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
  */
 int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	int ret = 0;
 
 	mutex_lock(&cdev->lock);
@@ -1857,11 +1842,11 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 		goto done;
 	}
 
-	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&pdata->dev->dev))
+	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
+		if (fdata->dev)
 			continue;
 
-		config_port_vf_mode(cdev->fme_dev, pdata->id);
+		config_port_vf_mode(cdev->fme_dev, fdata->id);
 	}
 done:
 	mutex_unlock(&cdev->lock);
@@ -1995,6 +1980,7 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 			       unsigned long arg)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = pdata->fdata;
 	struct dfl_fpga_irq_set hdr;
 	s32 *fds;
 	long ret;
@@ -2014,9 +2000,9 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 	if (IS_ERR(fds))
 		return PTR_ERR(fds);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	ret = dfl_fpga_set_irq_triggers(feature, hdr.start, hdr.count, fds);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	kfree(fds);
 	return ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 7ea96788a969..612592f374e6 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
+#include <linux/dfl.h>
 #include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -206,7 +207,7 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
-#define dfl_feature_dev_data dfl_feature_platform_data
+struct dfl_feature_dev_data;
 
 /**
  * struct dfl_fpga_port_ops - port ops
@@ -221,15 +222,16 @@ struct dfl_fpga_port_ops {
 	const char *name;
 	struct module *owner;
 	struct list_head node;
-	int (*get_id)(struct platform_device *pdev);
-	int (*enable_set)(struct platform_device *pdev, bool enable);
+	int (*get_id)(struct dfl_feature_dev_data *fdata);
+	int (*enable_set)(struct dfl_feature_dev_data *fdata, bool enable);
 };
 
 void dfl_fpga_port_ops_add(struct dfl_fpga_port_ops *ops);
 void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops);
-struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev);
+struct dfl_fpga_port_ops *
+	dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fdata);
 void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
-int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
+int dfl_fpga_check_port_id(struct dfl_feature_dev_data *fdata, void *pport_id);
 
 /**
  * struct dfl_feature_id - dfl private feature id
@@ -302,26 +304,32 @@ struct dfl_feature {
 #define FEATURE_DEV_ID_UNUSED	(-1)
 
 /**
- * struct dfl_feature_platform_data - platform data for feature devices
+ * struct dfl_feature_dev_data - dfl enumeration data for dfl feature dev.
  *
- * @node: node to link feature devs to container device's port_dev_list.
- * @lock: mutex to protect platform data.
- * @cdev: cdev of feature dev.
- * @dev: ptr to platform device linked with this platform data.
+ * @node: node to link the data structure to container device's port_dev_list.
+ * @lock: mutex to protect feature dev data.
+ * @dev: ptr to the feature's platform device linked with this structure.
+ * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
+ * @pdev_id: platform device id for the feature dev.
+ * @pdev_name: platform device name for the feature dev.
  * @dfl_cdev: ptr to container device.
- * @id: id used for this feature device.
+ * @id: id used for the feature device.
  * @disable_count: count for port disable.
  * @excl_open: set on feature device exclusive open.
  * @open_count: count for feature device open.
  * @num: number for sub features.
  * @private: ptr to feature dev private data.
- * @features: sub features of this feature dev.
+ * @features: sub features for the feature dev.
+ * @resource_num: number of resources for the feature dev.
+ * @resources: resources for the feature dev.
  */
-struct dfl_feature_platform_data {
+struct dfl_feature_dev_data {
 	struct list_head node;
 	struct mutex lock;
-	struct cdev cdev;
 	struct platform_device *dev;
+	enum dfl_id_type type;
+	int pdev_id;
+	const char *pdev_name;
 	struct dfl_fpga_cdev *dfl_cdev;
 	int id;
 	unsigned int disable_count;
@@ -329,7 +337,20 @@ struct dfl_feature_platform_data {
 	int open_count;
 	void *private;
 	int num;
-	struct dfl_feature features[];
+	struct dfl_feature *features;
+	int resource_num;
+	struct resource *resources;
+};
+
+/**
+ * struct dfl_feature_platform_data - platform data for feature devices
+ *
+ * @cdev: cdev of feature dev.
+ * @fdata: dfl enumeration data for the dfl feature device.
+ */
+struct dfl_feature_platform_data {
+	struct cdev cdev;
+	struct dfl_feature_dev_data *fdata;
 };
 
 static inline
@@ -407,7 +428,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
 
 	pdata = container_of(inode->i_cdev, struct dfl_feature_platform_data,
 			     cdev);
-	return pdata->dev;
+	return pdata->fdata->dev;
 }
 
 #define dfl_fpga_dev_for_each_feature(fdata, feature)			    \
@@ -438,7 +459,13 @@ dfl_get_feature_ioaddr_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 	return NULL;
 }
 
-#define to_dfl_feature_dev_data dev_get_platdata
+static inline struct dfl_feature_dev_data *
+to_dfl_feature_dev_data(struct device *dev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+
+	return pdata->fdata;
+}
 
 static inline
 struct device *dfl_fpga_fdata_to_parent(struct dfl_feature_dev_data *fdata)
@@ -525,26 +552,23 @@ struct dfl_fpga_cdev *
 dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info);
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
 
-/*
- * need to drop the device reference with put_device() after use port platform
- * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_port
- * functions.
- */
-struct platform_device *
-__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
-			  int (*match)(struct platform_device *, void *));
+struct dfl_feature_dev_data *
+__dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
+			       int (*match)(struct dfl_feature_dev_data *,
+					    void *));
 
-static inline struct platform_device *
-dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
-			int (*match)(struct platform_device *, void *))
+static inline struct dfl_feature_dev_data *
+dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
+			     int (*match)(struct dfl_feature_dev_data *,
+					  void *))
 {
-	struct platform_device *pdev;
+	struct dfl_feature_dev_data *fdata;
 
 	mutex_lock(&cdev->lock);
-	pdev = __dfl_fpga_cdev_find_port(cdev, data, match);
+	fdata = __dfl_fpga_cdev_find_port_data(cdev, data, match);
 	mutex_unlock(&cdev->lock);
 
-	return pdev;
+	return fdata;
 }
 
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id);
-- 
2.44.0


