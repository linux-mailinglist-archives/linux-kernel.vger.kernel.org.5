Return-Path: <linux-kernel+bounces-151764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CC8AB39C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654401F232C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9508137920;
	Fri, 19 Apr 2024 16:47:47 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE6130A5B;
	Fri, 19 Apr 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545266; cv=none; b=AiB4Me3VbGzxRAGwb6CUWk0nwUAxSbQ7uvrv3tN7ewkluHFncvbDNGhJLR6HeEbkk2wJFPVaAtt62GfEaVBZI/huUsxqO3/4EiAuA3JSQRscslb3BV8QTNMJmJSlI6uSBUUlJzSilENwrMkZ89WWGdMbAQGtjRPpS8N12yicyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545266; c=relaxed/simple;
	bh=FLmy9nGhpeQpzNEGELd6fb1fl1kbOZbYo1/FiZ5frWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBj/tJeq2NCNK6RbCfR7UWlCXCZ6M5JzSyfhe0DNQPLj4r59NBlTJZmAQTBSQIlmDsK4czrsZwx+0vVLiuXffGK27wh5MvjePBjzJZiLwwd0voIN8qUKcD0Z0lhWZyFTjC/i4Lnf/NO1MT/iQLFH0cPwKk2G8BnKUCfvLkuTizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgW31Gl2z6K626;
	Sat, 20 Apr 2024 00:45:35 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DB10140A70;
	Sat, 20 Apr 2024 00:47:42 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:41 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Date: Sat, 20 Apr 2024 00:47:10 +0800
Message-ID: <20240419164720.1765-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240419164720.1765-1-shiju.jose@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add scrub subsystem supports configuring the memory scrubbers
in the system. The scrub subsystem provides the interface for
registering the scrub devices. The scrub control attributes
are provided to the user in /sys/class/ras/rasX/scrub

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .../ABI/testing/sysfs-class-scrub-configure   |  47 +++
 drivers/ras/Kconfig                           |   7 +
 drivers/ras/Makefile                          |   1 +
 drivers/ras/memory_scrub.c                    | 271 ++++++++++++++++++
 include/linux/memory_scrub.h                  |  37 +++
 5 files changed, 363 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100755 drivers/ras/memory_scrub.c
 create mode 100755 include/linux/memory_scrub.h

diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
new file mode 100644
index 000000000000..3ed77dbb00ad
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
@@ -0,0 +1,47 @@
+What:		/sys/class/ras/
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The ras/ class subdirectory belongs to the
+		common ras features such as scrub subsystem.
+
+What:		/sys/class/ras/rasX/scrub/
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		The /sys/class/ras/ras{0,1,2,3,...}/scrub directories
+		correspond to each scrub device registered with the
+		scrub subsystem.
+
+What:		/sys/class/ras/rasX/scrub/name
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) name of the memory scrubber
+
+What:		/sys/class/ras/rasX/scrub/enable_background
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) Enable/Disable background(patrol) scrubbing if supported.
+
+What:		/sys/class/ras/rasX/scrub/rate_available
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RO) Supported range for the scrub rate by the scrubber.
+		The scrub rate represents in hours.
+
+What:		/sys/class/ras/rasX/scrub/rate
+Date:		March 2024
+KernelVersion:	6.9
+Contact:	linux-kernel@vger.kernel.org
+Description:
+		(RW) The scrub rate specified and it must be with in the
+		supported range by the scrubber.
+		The scrub rate represents in hours.
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..181701479564 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -46,4 +46,11 @@ config RAS_FMPM
 	  Memory will be retired during boot time and run time depending on
 	  platform-specific policies.
 
+config SCRUB
+	tristate "Memory scrub driver"
+	help
+	  This option selects the memory scrub subsystem, supports
+	  configuring the parameters of underlying scrubbers in the
+	  system for the DRAM memories.
+
 endif
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..89bcf0d84355 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+obj-$(CONFIG_SCRUB)	+= memory_scrub.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/memory_scrub.c b/drivers/ras/memory_scrub.c
new file mode 100755
index 000000000000..7e995380ec3a
--- /dev/null
+++ b/drivers/ras/memory_scrub.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory scrub subsystem supports configuring the registered
+ * memory scrubbers.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#define pr_fmt(fmt)     "MEM SCRUB: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kfifo.h>
+#include <linux/memory_scrub.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/* memory scrubber config definitions */
+#define SCRUB_ID_PREFIX "ras"
+#define SCRUB_ID_FORMAT SCRUB_ID_PREFIX "%d"
+
+static DEFINE_IDA(scrub_ida);
+
+struct scrub_device {
+	int id;
+	struct device dev;
+	const struct scrub_ops *ops;
+};
+
+#define to_scrub_device(d) container_of(d, struct scrub_device, dev)
+static ssize_t enable_background_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->set_enabled_bg(dev, enable);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t enable_background_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	bool enable;
+	int ret;
+
+	ret = scrub_dev->ops->get_enabled_bg(dev, &enable);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", enable);
+}
+
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	int ret;
+
+	ret = scrub_dev->ops->get_name(dev, buf);
+	if (ret)
+		return ret;
+
+	return strlen(buf);
+}
+
+static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	u64 val;
+	int ret;
+
+	ret = scrub_dev->ops->rate_read(dev, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx\n", val);
+}
+
+static ssize_t rate_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub_dev->ops->rate_write(dev, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t rate_available_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	u64 min_sr, max_sr;
+	int ret;
+
+	ret = scrub_dev->ops->rate_avail_range(dev, &min_sr, &max_sr);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%llx-0x%llx\n", min_sr, max_sr);
+}
+
+DEVICE_ATTR_RW(enable_background);
+DEVICE_ATTR_RO(name);
+DEVICE_ATTR_RW(rate);
+DEVICE_ATTR_RO(rate_available);
+
+static struct attribute *scrub_attrs[] = {
+	&dev_attr_enable_background.attr,
+	&dev_attr_name.attr,
+	&dev_attr_rate.attr,
+	&dev_attr_rate_available.attr,
+	NULL
+};
+
+static umode_t scrub_attr_visible(struct kobject *kobj,
+				  struct attribute *a, int attr_id)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+	const struct scrub_ops *ops = scrub_dev->ops;
+
+	if (a == &dev_attr_enable_background.attr) {
+		if (ops->set_enabled_bg && ops->get_enabled_bg)
+			return a->mode;
+		if (ops->get_enabled_bg)
+			return 0444;
+		return 0;
+	}
+	if (a == &dev_attr_name.attr)
+		return ops->get_name ? a->mode : 0;
+	if (a == &dev_attr_rate_available.attr)
+		return ops->rate_avail_range ? a->mode : 0;
+	if (a == &dev_attr_rate.attr) { /* Write only makes little sense */
+		if (ops->rate_read && ops->rate_write)
+			return a->mode;
+		if (ops->rate_read)
+			return 0444;
+		return 0;
+	}
+
+	return 0;
+}
+
+static const struct attribute_group scrub_attr_group = {
+	.name		= "scrub",
+	.attrs		= scrub_attrs,
+	.is_visible	= scrub_attr_visible,
+};
+
+static const struct attribute_group *scrub_attr_groups[] = {
+	&scrub_attr_group,
+	NULL
+};
+
+static void scrub_dev_release(struct device *dev)
+{
+	struct scrub_device *scrub_dev = to_scrub_device(dev);
+
+	ida_free(&scrub_ida, scrub_dev->id);
+	kfree(scrub_dev);
+}
+
+static struct class scrub_class = {
+	.name = "ras",
+	.dev_groups = scrub_attr_groups,
+	.dev_release = scrub_dev_release,
+};
+
+static struct device *
+scrub_device_register(struct device *parent, void *drvdata,
+		      const struct scrub_ops *ops)
+{
+	struct scrub_device *scrub_dev;
+	struct device *hdev;
+	int err;
+
+	scrub_dev = kzalloc(sizeof(*scrub_dev), GFP_KERNEL);
+	if (!scrub_dev)
+		return ERR_PTR(-ENOMEM);
+	hdev = &scrub_dev->dev;
+
+	scrub_dev->id = ida_alloc(&scrub_ida, GFP_KERNEL);
+	if (scrub_dev->id < 0) {
+		kfree(scrub_dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	scrub_dev->ops = ops;
+	hdev->class = &scrub_class;
+	hdev->parent = parent;
+	dev_set_drvdata(hdev, drvdata);
+	dev_set_name(hdev, SCRUB_ID_FORMAT, scrub_dev->id);
+	err = device_register(hdev);
+	if (err) {
+		put_device(hdev);
+		return ERR_PTR(err);
+	}
+
+	return hdev;
+}
+
+static void devm_scrub_release(void *dev)
+{
+	device_unregister(dev);
+}
+
+/**
+ * devm_scrub_device_register - register scrubber device
+ * @dev: the parent device
+ * @drvdata: driver data to attach to the scrub device
+ * @ops: pointer to scrub_ops structure (optional)
+ *
+ * Returns the pointer to the new device on success, ERR_PTR() otherwise.
+ * The new device would be automatically unregistered with the parent device.
+ */
+struct device *
+devm_scrub_device_register(struct device *dev, void *drvdata,
+			   const struct scrub_ops *ops)
+{
+	struct device *hdev;
+	int ret;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	hdev = scrub_device_register(dev, drvdata, ops);
+	if (IS_ERR(hdev))
+		return hdev;
+
+	ret = devm_add_action_or_reset(dev, devm_scrub_release, hdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hdev;
+}
+EXPORT_SYMBOL_GPL(devm_scrub_device_register);
+
+static int __init memory_scrub_control_init(void)
+{
+	return class_register(&scrub_class);
+}
+subsys_initcall(memory_scrub_control_init);
+
+static void memory_scrub_control_exit(void)
+{
+	class_unregister(&scrub_class);
+}
+module_exit(memory_scrub_control_exit);
diff --git a/include/linux/memory_scrub.h b/include/linux/memory_scrub.h
new file mode 100755
index 000000000000..f0e1657a5072
--- /dev/null
+++ b/include/linux/memory_scrub.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Memory scrub subsystem driver supports controlling
+ * the memory scrubbers in the system.
+ *
+ * Copyright (c) 2024 HiSilicon Limited.
+ */
+
+#ifndef __MEMORY_SCRUB_H
+#define __MEMORY_SCRUB_H
+
+#include <linux/types.h>
+
+struct device;
+
+/**
+ * struct scrub_ops - scrub device operations (all elements optional)
+ * @get_enabled_bg: check if currently performing background scrub.
+ * @set_enabled_bg: start or stop a bg-scrub.
+ * @get_name: get the memory scrubber name.
+ * @rate_avail_range: retrieve limits on supported rates.
+ * @rate_read: read the scrub rate
+ * @rate_write: set the scrub rate
+ */
+struct scrub_ops {
+	int (*get_enabled_bg)(struct device *dev, bool *enable);
+	int (*set_enabled_bg)(struct device *dev, bool enable);
+	int (*get_name)(struct device *dev, char *buf);
+	int (*rate_avail_range)(struct device *dev, u64 *min, u64 *max);
+	int (*rate_read)(struct device *dev, u64 *rate);
+	int (*rate_write)(struct device *dev, u64 rate);
+};
+
+struct device *
+devm_scrub_device_register(struct device *dev, void *drvdata,
+			   const struct scrub_ops *ops);
+#endif /* __MEMORY_SCRUB_H */
-- 
2.34.1


