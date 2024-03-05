Return-Path: <linux-kernel+bounces-92334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C6871EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981F71C24466
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CCF5A114;
	Tue,  5 Mar 2024 12:13:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFA7484;
	Tue,  5 Mar 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640811; cv=none; b=GK5Fyz942/W6HZRqmeXjh7VcmjkExrTKZdHne0wxc9+P29vEzAxYiOOLl8nYDQCmHfio4BfxFZzyP5cTxVQrrfSx/ICLX61YRHioEJzVsn3atF+RntBAsEuJTq/3W0t78UNCOfrIKDjMWpw4bOLpelsAUneCe9Akhoz2IbiGBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640811; c=relaxed/simple;
	bh=975p/LAtss40Fs1TYpzkZDZadS0gywjbOpZMyMCRPlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnvcHqzCQwrW2BROu7Al+4okL0XjPi60Q28auL3p1vXvtRADOD7JN3WABSABM64zSIYLombi778HVzQuZm9pVQHDy0am2l/PMBneML52UYR9CUd0It+T/y2NR39iilmLXvnwfTBR1bZdHObE4R9SdIG2ehBHnMrfUq0aYzrFd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed0630d6980c4288b0c809be576385ba-20240305
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:64c0f35d-0956-48f8-a695-6a6fe2a79fd2,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-30
X-CID-INFO: VERSION:1.1.37,REQID:64c0f35d-0956-48f8-a695-6a6fe2a79fd2,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:6f7d88ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240305201320VGWXLOSY,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ed0630d6980c4288b0c809be576385ba-20240305
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1069726408; Tue, 05 Mar 2024 20:13:17 +0800
From: Ai Chao <aichao@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v4] platform/x86: add lenovo generic wmi driver
Date: Tue,  5 Mar 2024 20:13:15 +0800
Message-Id: <20240305121315.1744363-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add lenovo generic wmi driver to support camera button.
The Camera button is a GPIO device. This driver receives ACPI notifyi
 when the button pressed.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
v3: Remove lenovo_wmi_remove function.
v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.

 drivers/platform/x86/Kconfig             |  12 +++
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/lenovo-wmi-camera.c | 118 +++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bdd302274b9a..079f5aa5910c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
 	To compile this driver as a module, choose M here: the module
 	will be called inspur-platform-profile.
 
+config LENOVO_WMI_CAMERA
+	tristate "Lenovo WMI Camera Button driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	help
+	  This driver provides support for Lenovo camera button. The Camera
+	  button is a GPIO device. This driver receives ACPI notify when the
+	  button pressed.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called lenovo-wmi-camera.
+
 source "drivers/platform/x86/x86-android-tablets/Kconfig"
 
 config FW_ATTR_CLASS
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1de432e8861e..217e94d7c877 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
 obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
+obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platform/x86/lenovo-wmi-camera.c
new file mode 100644
index 000000000000..77084266829c
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-camera.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lenovo WMI Camera Button Driver
+ *
+ * Author: Ai Chao <aichao@kylinos.cn>
+ * Copyright (C) 2024 KylinSoft Corporation.
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
+struct lenovo_wmi_priv {
+	struct input_dev *idev;
+	struct device *dev;
+	u8 camera_mode;
+};
+
+enum {
+	CAMERA_BUTTON_PRESSED = 1,
+};
+
+static ssize_t camerabutton_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct lenovo_wmi_priv *priv = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", priv->camera_mode);
+}
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
+	if (obj->type == ACPI_TYPE_BUFFER &&
+	    obj->buffer.pointer[0] <= CAMERA_BUTTON_PRESSED) {
+		/* Camera mode:
+		 *      0 camera close
+		 *      1 camera open
+		 */
+		priv->camera_mode = obj->buffer.pointer[0];
+
+		input_report_key(priv->idev, KEY_CAMERA, 1);
+		input_sync(priv->idev);
+		input_report_key(priv->idev, KEY_CAMERA, 0);
+		input_sync(priv->idev);
+	} else {
+		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
+	}
+}
+
+static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct lenovo_wmi_priv *priv;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, priv);
+
+	priv->idev = devm_input_allocate_device(&wdev->dev);
+	if (!priv->idev)
+		return -ENOMEM;
+
+	priv->idev->name = "Lenovo WMI Camera Button";
+	priv->idev->phys = "wmi/input0";
+	priv->idev->id.bustype = BUS_HOST;
+	priv->idev->dev.parent = &wdev->dev;
+	set_bit(EV_KEY, priv->idev->evbit);
+	set_bit(KEY_CAMERA, priv->idev->keybit);
+
+	return input_register_device(priv->idev);
+}
+
+static const struct wmi_device_id lenovo_wmi_id_table[] = {
+	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
+	{  }
+};
+
+static struct wmi_driver lenovo_wmi_driver = {
+	.driver = {
+		.name = "lenovo-wmi-camera",
+		.dev_groups = lenovo_wmi_groups,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = lenovo_wmi_id_table,
+	.no_singleton = false,
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


