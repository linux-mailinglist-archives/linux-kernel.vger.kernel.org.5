Return-Path: <linux-kernel+bounces-108605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B7880CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F661C21FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A436AE4;
	Wed, 20 Mar 2024 08:18:26 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFF2E415;
	Wed, 20 Mar 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922705; cv=none; b=Z+rx8NiW9db9Kn0Rg9smErT2+vp4YsrK/WbWAzJLLy84y6WLAjfEn+q9tQVtTneEUN9ojGXj5RwrQqpvQ4T+3vrsNIe9z0H+nypD4iJw9bbkOQyQehhQpRrooidSCvdtDH3cQownV48EnnyfL4DcrKTsi5zmSK6L9qzI0qhmfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922705; c=relaxed/simple;
	bh=DmKs3e4zlQ7NWrEdlgBL3DpFXanS7F+Efu0o5r9ztRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BjlA0oTG/07lFrRyIPa6m9bGQCNdKKsZINyu74wmZ2temBiXO0Depo1LQnGd6GpuonSYdkSwQbytRoIeaaDVjU6edkALBOJph+4txPoC2tUtoKeQMRYDs2O0EwlSSOoyNL9WrOuTJ0D3frGk3DXZE7HF0tLW2iCpYtP/BKJOhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 86afe358aaf04218abce635c4aaaba53-20240320
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:34d80284-f5a6-4c55-a19e-59cde2e88d39,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:34d80284-f5a6-4c55-a19e-59cde2e88d39,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:641db781-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240320161813F21B4QA9,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 86afe358aaf04218abce635c4aaaba53-20240320
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1993724695; Wed, 20 Mar 2024 16:18:10 +0800
From: Ai Chao <aichao@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v10] platform/x86: add lenovo wmi camera button driver
Date: Wed, 20 Mar 2024 16:17:40 +0800
Message-Id: <20240320081740.818344-1-aichao@kylinos.cn>
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
v10: Add lenovo_wmi_remove and mutex_destroy.
v9: Add mutex for wmi notify.
v8: Dev_deb convert to dev_err.
v7: Add dev_dbg and remove unused dev in struct.
v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
v3: Remove lenovo_wmi_remove function.
v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.

 drivers/platform/x86/Kconfig             |  12 +++
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/lenovo-wmi-camera.c | 123 +++++++++++++++++++++++
 3 files changed, 136 insertions(+)
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
index 000000000000..4b1bd81cc581
--- /dev/null
+++ b/drivers/platform/x86/lenovo-wmi-camera.c
@@ -0,0 +1,123 @@
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
+#include <linux/mutex.h>
+#include <linux/wmi.h>
+
+#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
+
+struct lenovo_wmi_priv {
+	struct input_dev *idev;
+	struct mutex notify_lock;	/* lenovo wmi camera button notify lock */
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
+	unsigned int keycode;
+	u8 camera_mode;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
+		return;
+	}
+
+	if (obj->buffer.length != 1) {
+		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
+		return;
+	}
+
+	/* obj->buffer.pointer[0] is camera mode:
+	 *      0 camera close
+	 *      1 camera open
+	 */
+	camera_mode = obj->buffer.pointer[0];
+	if (camera_mode > SW_CAMERA_ON) {
+		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
+		return;
+	}
+
+	mutex_lock(&priv->notify_lock);
+
+	keycode = (camera_mode == SW_CAMERA_ON ?
+		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
+	input_report_key(priv->idev, keycode, 1);
+	input_sync(priv->idev);
+	input_report_key(priv->idev, keycode, 0);
+	input_sync(priv->idev);
+
+	mutex_unlock(&priv->notify_lock);
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
+	mutex_init(&priv->notify_lock);
+	priv->idev = devm_input_allocate_device(&wdev->dev);
+	if (!priv->idev) {
+		mutex_destroy(&priv->notify_lock);
+		return -ENOMEM;
+	}
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
+static void lenovo_wmi_remove(struct wmi_device *wdev)
+{
+	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	mutex_destroy(&priv->notify_lock);
+	input_unregister_device(priv->idev);
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
+	.remove = lenovo_wmi_remove,
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


