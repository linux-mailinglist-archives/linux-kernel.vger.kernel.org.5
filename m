Return-Path: <linux-kernel+bounces-1800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA6815452
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA381F25331
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A418EC2;
	Fri, 15 Dec 2023 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorolasolutions.com header.i=@motorolasolutions.com header.b="SNpkuaKa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0019e102.pphosted.com (mx0a-0019e102.pphosted.com [67.231.149.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13918EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=motorolasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorolasolutions.com
Received: from pps.filterd (m0120855.ppops.net [127.0.0.1])
	by mx0b-0019e102.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFINYRc019545
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorolasolutions.com; h=from : to
 : cc : subject : date : message-id : mime-version : content-type;
 s=PPS--2020-03-17; bh=r1LfhbUKUEkZSwYiKXzBUI0udw8QUMBl/NtgK61IOSQ=;
 b=SNpkuaKatV3Kp79GSO7UF5iv9yAt6Pu5n0Jkbpdh8S8dfuBM1/TZfaClPqXONQN2llTe
 PPOudlSC5EyQ4fJG+WOJVMFgIrhmv5W57ZpvcW5ukmYMTm/bUtdi/8OyX2oQyhl0SIqA
 O2WPv4N5AQEHycdLiSJ7CGuhlL7r1IwvTM1orJjGOFlSLSHqj2l/TzuNPjucsDwU0jFU
 yiBJFt+SRe+KjO3teCi5j2BCckBgEPGAGRP/ujeHBqUAFYkMDcowyMd4j5DMO9bIio0J
 VfleTSI/JTyJjKiqXEsuRxaUWy/uZXytmPhpH3NqsQO306cGUW0xlVn1nIoN5pleLmoF Yw== 
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	by mx0b-0019e102.pphosted.com (PPS) with ESMTPS id 3v0071xcq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:12:28 +0000
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7a9f90e86so88877839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:12:28 -0800 (PST)
X-Gm-Message-State: AOJu0YwKAI/3HJlDZ7HrPCMRgULG4wrWzHQvL6lNwDoFPtRbRiKpmuFj
	FSm3jS9VVbKQgjjomJHxXBuHmIZIrTPBWO0lJwUoRBCewLtDTUYCpouPgC1rcwD+AGTH3Ucub5I
	CTZaZe1VLz09fkJeww9CAN71b
X-Received: by 2002:a5e:a715:0:b0:7b6:ee98:5f7 with SMTP id b21-20020a5ea715000000b007b6ee9805f7mr12714386iod.36.1702674747312;
        Fri, 15 Dec 2023 13:12:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0UJh9hsT4n7mcukTaWcdW3QyjYBJJTNb41YaPkb5to4bwt1PRFjYjUDNuhrUmfT24Kn4Dxg==
X-Received: by 2002:a5e:a715:0:b0:7b6:ee98:5f7 with SMTP id b21-20020a5ea715000000b007b6ee9805f7mr12714362iod.36.1702674746770;
        Fri, 15 Dec 2023 13:12:26 -0800 (PST)
Received: from spgdx3.am.mot.com ([140.101.127.251])
        by smtp.googlemail.com with ESMTPSA id v25-20020a5ed719000000b007b39670c070sm4495767iom.52.2023.12.15.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 13:12:26 -0800 (PST)
From: Yinghua Yang <yinghua.yang@motorolasolutions.com>
X-Google-Original-From: Yinghua Yang <Yinghua.Yang@motorolasolutions.com>
To: gregkh@linuxfoundation.org
Cc: zachary.zuzzio@motorolasolutions.com,
        Yinghua Yang <Yinghua.Yang@motorolasolutions.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Wentong Wu <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: misc: Add driver for Motorola Solutions security accessories
Date: Fri, 15 Dec 2023 15:12:10 -0600
Message-Id: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: _OKXqMTnf_J_zUZCWrjNjmARHfm3ia4_
X-Proofpoint-ORIG-GUID: _OKXqMTnf_J_zUZCWrjNjmARHfm3ia4_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150147

New USB driver that sets power/control to autosuspend for Motorola
Solutions security accessories. The new driver only changes the power
control for specific USB devices, normal read/write/ioctl of the usb
device uses the unmodified usbfs.

The rationale for a vendor specific driver was to allow for autosuspend
behavior on Linux installations that are battery powered and do not
allow user modifications to udev settings (e.g. embedded Linux, Android,
etc.). The idealistic generic approach that would allow any USB device
that supports autosuspend to change the power control could not be found
without a change to the USB standard or substantial change to the usbfs
architecture.

Signed-off-by: Yinghua Yang <Yinghua.Yang@motorolasolutions.com>
---
 MAINTAINERS                 |   6 +++
 drivers/usb/misc/Kconfig    |  10 ++++
 drivers/usb/misc/Makefile   |   1 +
 drivers/usb/misc/motsolsa.c | 100 ++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 drivers/usb/misc/motsolsa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac8..eb9ad6ab9c20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22423,6 +22423,12 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/usb/midi.*
 
+USB MOTOROLA SOLUTIONS SECURITY ACCESSORIES DRIVER
+M:	Yinghua Yang <Yinghua.Yang@motorolasolutions.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/misc/motsolsa.c
+
 USB NETWORKING DRIVERS
 L:	linux-usb@vger.kernel.org
 S:	Odd Fixes
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index c510af7baa0d..cb1fa63cc0d1 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -331,3 +331,13 @@ config USB_ONBOARD_HUB
 	  this config will enable the driver and it will automatically
 	  match the state of the USB subsystem. If this driver is a
 	  module it will be called onboard_usb_hub.
+
+config USB_MOTSOL_SA
+	tristate "Motorola Solutions Security Accessories Driver"
+	help
+	  Say Y here if you want to enables auto suspend mode for
+	  Motorola Solutions Security Accessory devices.
+
+	  The new driver only changes the power control for specific
+	  USB devices, normal read/write/ioctl of the usb device uses
+	  the unmodified usbfs.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 0bc732bcb162..4e639693b8c5 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
 obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
 obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
+obj-$(CONFIG_USB_MOTSOL_SA)		+= motsolsa.o
diff --git a/drivers/usb/misc/motsolsa.c b/drivers/usb/misc/motsolsa.c
new file mode 100644
index 000000000000..69f6be9bd8d1
--- /dev/null
+++ b/drivers/usb/misc/motsolsa.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for setting auto suspend mode for Motorola Solutions security accessories
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#define DRIVER_DESC "Motorola Solutions security accessory driver"
+
+static int motsol_sa_probe(struct usb_interface *interface,
+			 const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(interface);
+
+	dev_dbg(&(interface)->dev, "probe (%04X:%04X)\n", id->idVendor,
+		id->idProduct);
+	usb_enable_autosuspend(udev);
+	return 0;
+}
+
+static void motsol_sa_disconnect(struct usb_interface *interface)
+{
+	dev_dbg(&(interface)->dev, "disconnect\n");
+}
+
+#define MOTSOL_VENDOR_ID 0x0cad
+#define MOTSOL_SA_PRODUCT_ID 0x01901
+
+static struct usb_device_id motsol_sa_table[] = {
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 1) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 2) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 3) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 4) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 5) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 6) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 7) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 8) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 9) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 10) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 11) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 12) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 13) },
+	{ USB_DEVICE(MOTSOL_VENDOR_ID, MOTSOL_SA_PRODUCT_ID + 14) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, motsol_sa_table);
+
+#ifdef CONFIG_PM
+static int motsol_sa_suspend(struct usb_interface *interface,
+			   pm_message_t message)
+{
+	dev_dbg(&(interface)->dev, "suspend");
+	return 0;
+}
+
+static int motsol_sa_resume(struct usb_interface *interface)
+{
+	dev_dbg(&(interface)->dev, "resume");
+	return 0;
+}
+#else
+#define motsol_sa_suspend NULL
+#define motsol_sa_resume NULL
+#endif
+
+static struct usb_driver motsol_sa_driver = {
+	.name = "motsol_sa",
+	.id_table = motsol_sa_table,
+	.probe = motsol_sa_probe,
+	.suspend = motsol_sa_suspend,
+	.resume = motsol_sa_resume,
+	.reset_resume = motsol_sa_resume,
+	.supports_autosuspend = 1,
+	.disconnect = motsol_sa_disconnect,
+};
+
+static int __init motsol_sa_init(void)
+{
+	int ret = -1;
+
+	ret = usb_register(&motsol_sa_driver);
+	pr_debug("%s: %s\n", KBUILD_MODNAME, DRIVER_DESC);
+	return ret;
+}
+
+static void __exit motsol_sa_exit(void)
+{
+	usb_deregister(&motsol_sa_driver);
+	pr_debug("%s driver deregistered\n", motsol_sa_driver.name);
+}
+
+module_init(motsol_sa_init);
+module_exit(motsol_sa_exit);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
-- 
2.34.1


-- 


*For more information on how and why we collect your personal 
information, please visit our Privacy Policy 
<https://www.motorolasolutions.com/en_us/about/privacy-policy.html?elqTrackId=8980d888905940e39a2613a7a3dcb0a7&elqaid=2786&elqat=2#privacystatement>.*

