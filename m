Return-Path: <linux-kernel+bounces-102704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D387B63A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7BB238AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7115256;
	Thu, 14 Mar 2024 01:57:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09346B5;
	Thu, 14 Mar 2024 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381455; cv=none; b=ayCzln7wLY8gxBS9aLb6wuenTx3V2drhXRlsIpAdkillkMi2ZntI9bAH+1dLRkBSbsGQsJSMmqrmZQAml6dBiQsRoILo00pkVHFdkxYvvfj43oCq4++dNfOO8Op8scAc6F6TG22bC+HOOiqIzy/bj7ZyYlGOSaGxOPvpvokhEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381455; c=relaxed/simple;
	bh=T9gpuNMpq9UU15JKOLISdZH4W+VgL6cQXt3cXyCQ+90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J7JPteeNQbyRh8Xy2dAgsdoHmMCg4+wcvmwY7JQ8hmRYdUTjUmJc1DsxlWXjkpQxNAMZm0seCIdtHY3olDTSMlvND76iIEJxCEgu5X/Gmt7VwKp4puVGsVMJMmEMNQbswjHYr8i+2TuchHCo+yTHU9PYMVq6/hKw8mXbEhky2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 884f110930c94cf48d08e0515ba12720-20240314
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:88922ec1-cbb7-41df-b58d-6bfb1f21b071,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:88922ec1-cbb7-41df-b58d-6bfb1f21b071,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:21bc7981-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240314095720TCR1FRGZ,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 884f110930c94cf48d08e0515ba12720-20240314
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2095711009; Thu, 14 Mar 2024 09:57:19 +0800
From: Ai Chao <aichao@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v7] platform/x86: add lenovo wmi camera button driver
Date: Thu, 14 Mar 2024 09:57:11 +0800
Message-Id: <20240314015711.62433-1-aichao@kylinos.cn>
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
when the camera button is switched on/off. This driver is used in
Lenovo A70, it is a Computer integrated machine.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
v7: Add dev_dbg and remove unused dev in struct.
v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
v3: Remove lenovo_wmi_remove function.
v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.

 drivers/platform/x86/Kconfig             |  12 +++
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/lenovo-wmi-camera.c | 108 +++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bdd302274b9a..9506a455b547 100644
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
+	  camera button is switched on/off.
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
index 000000000000..c11a74d04bf9
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-camera.c
@@ -0,0 +1,108 @@
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
+};
+
+enum {
+	SW_CAMERA_OFF	= 0,
+	SW_CAMERA_ON	= 1,
+};
+
+static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
+{
+	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	u8 camera_mode;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		dev_dbg(&wdev->dev, "Bad response type %u\n", obj->type);
+		return;
+	}
+
+	if (obj->buffer.length != 1) {
+		dev_dbg(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
+		return;
+	}
+
+	/* obj->buffer.pointer[0] is camera mode:
+	 *      0 camera close
+	 *      1 camera open
+	 */
+	camera_mode = obj->buffer.pointer[0];
+	if (camera_mode > SW_CAMERA_ON) {
+		dev_dbg(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
+		return;
+	}
+
+	if (camera_mode == SW_CAMERA_ON) {
+		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
+		input_sync(priv->idev);
+		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
+	} else {
+		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
+		input_sync(priv->idev);
+		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
+	}
+	input_sync(priv->idev);
+}
+
+static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct lenovo_wmi_priv *priv;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
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
+	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_ENABLE);
+	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_DISABLE);
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
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = lenovo_wmi_id_table,
+	.no_singleton = true,
+	.probe = lenovo_wmi_probe,
+	.notify = lenovo_wmi_notify,
+};
+
+module_wmi_driver(lenovo_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
+MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
+MODULE_DESCRIPTION("Lenovo WMI Camera Button Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


