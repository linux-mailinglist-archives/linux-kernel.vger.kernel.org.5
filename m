Return-Path: <linux-kernel+bounces-88066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582DC86DCF5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D3E1F26FB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC069D37;
	Fri,  1 Mar 2024 08:22:26 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BEA69E0A;
	Fri,  1 Mar 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281346; cv=none; b=tPAneZkb5ybP0AV9N6+/gKaMzY9igl6au9OLlSFJgPb5O5AquzUIBYlwGpUyTPc0y+1O6cRqS/n5YAZhElike7Cc86pkQLMM5gODqfRtgy6mPW6tQfeAfJmEpqMmjAKwE4TKnAj62XZ1eMYNvbA2jaOK1aJKAF8Muo0vGGx0DEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281346; c=relaxed/simple;
	bh=h6FtoEcIUz3yIkRmQPdlDZucxbkkGkvHrXaGeCM1nEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0dT4sj6uLgn36zIrqiX/bEyA0ogPU8YeEHhXTOW36d3RYfIcDbkK28lzUZUozySwevOkcwLr88lD8ZuXGQYQmATarPAXQO7f9uBEiYAF7ywkO13wgpWf88TVxuKrXdkQ31zkhtCvMz4j8gr//A3MSqm0muYYQmgawS76vNyXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 05f06a440549480886f5d1928f357437-20240301
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3aa1627a-5245-4c43-a2b5-b2ef66fe2ba0,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-30
X-CID-INFO: VERSION:1.1.37,REQID:3aa1627a-5245-4c43-a2b5-b2ef66fe2ba0,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:c9637e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2403011616558IO7NRVB,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 05f06a440549480886f5d1928f357437-20240301
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1055854772; Fri, 01 Mar 2024 16:16:55 +0800
From: Ai Chao <aichao@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v3] platform/x86: add lenovo generic wmi driver
Date: Fri,  1 Mar 2024 16:16:48 +0800
Message-Id: <20240301081648.265907-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add lenovo generic wmi driver to support camera button.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---

v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
v3: Remove lenovo_wmi_remove function.

 drivers/platform/x86/Kconfig      |  10 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/lenovo-wmi.c | 113 ++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bdd302274b9a..fbbb8fb843d7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1001,6 +1001,16 @@ config INSPUR_PLATFORM_PROFILE
 	To compile this driver as a module, choose M here: the module
 	will be called inspur-platform-profile.
 
+config LENOVO_WMI
+	tristate "Lenovo Geneirc WMI driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	help
+	This driver provides support for Lenovo WMI driver.
+
+	To compile this driver as a module, choose M here: the module
+	will be called lenovo-wmi.
+
 source "drivers/platform/x86/x86-android-tablets/Kconfig"
 
 config FW_ATTR_CLASS
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1de432e8861e..d51086552192 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
+obj-$(CONFIG_LENOVO_WMI)	+= lenovo-wmi.o
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/lenovo-wmi.c
new file mode 100644
index 000000000000..96c2ec9e6441
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Lenovo Generic WMI Driver
+ *
+ *  Copyright (C) 2024	      Ai Chao <aichao@kylinos.cn>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/wmi.h>
+
+#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
+
+static u8 camera_mode;
+
+struct lenovo_wmi_priv {
+	struct input_dev *idev;
+};
+
+static ssize_t camerabutton_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", camera_mode);
+}
+
+DEVICE_ATTR_RO(camerabutton);
+
+static struct attribute *lenovo_wmi_attrs[] = {
+	&dev_attr_camerabutton.attr,
+	NULL,
+};
+
+static const struct attribute_group lenovo_wmi_group = {
+	.attrs = lenovo_wmi_attrs,
+};
+
+const struct attribute_group *lenovo_wmi_groups[] = {
+	&lenovo_wmi_group,
+	NULL,
+};
+
+static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
+{
+	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		camera_mode = obj->buffer.pointer[0];
+		input_report_key(priv->idev, KEY_CAMERA, 1);
+		input_sync(priv->idev);
+		input_report_key(priv->idev, KEY_CAMERA, 0);
+		input_sync(priv->idev);
+	} else {
+		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
+	}
+}
+
+static int lenovo_wmi_input_setup(struct wmi_device *wdev)
+{
+	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	priv->idev = devm_input_allocate_device(&wdev->dev);
+	if (!priv->idev)
+		return -ENOMEM;
+
+	priv->idev->name = "Lenovo WMI Camera Button";
+	priv->idev->phys = "wmi/input0";
+	priv->idev->id.bustype = BUS_HOST;
+	priv->idev->dev.parent = &wdev->dev;
+	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
+	priv->idev->keybit[BIT_WORD(KEY_CAMERA)] = BIT_MASK(KEY_CAMERA);
+
+	return input_register_device(priv->idev);
+}
+
+static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct lenovo_wmi_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(struct lenovo_wmi_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, priv);
+
+	err = lenovo_wmi_input_setup(wdev);
+	return err;
+}
+
+static const struct wmi_device_id lenovo_wmi_id_table[] = {
+	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
+	{  }
+};
+
+static struct wmi_driver lenovo_wmi_driver = {
+	.driver = {
+		.name = "lenovo-wmi",
+		.dev_groups = lenovo_wmi_groups,
+	},
+	.id_table = lenovo_wmi_id_table,
+	.probe = lenovo_wmi_probe,
+	.notify = lenovo_wmi_notify,
+};
+
+module_wmi_driver(lenovo_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
+MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
+MODULE_DESCRIPTION("Lenovo Generic WMI Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


