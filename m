Return-Path: <linux-kernel+bounces-5222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E4818824
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9535628D8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725BC18E10;
	Tue, 19 Dec 2023 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zl/WnuSJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7A18E36
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336672406f0so2012433f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702990633; x=1703595433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYHstZ7DJyRwFTy0VAWhYMgjrdwXsEjgu4laOEmIlZI=;
        b=zl/WnuSJg4ikU8pYqzgwmUEuCzAovb127QdUkiZcDP+NiB7Jbp8n0sa7FIcTShyGfX
         9ET1xYOno/75P0tOvijDOnDs+5+J+t0IEv1FMMlfHs+HWPmfwIH60v0M0HPLtekIDlxH
         BXxKe6N510uyYSriaG7tN1qWQjEpx2XB8IQCmfQPFGiJH1eSIb8uTXobL3agKv9vK1Az
         LZHwBFS3c6NJCF795Uqufx2UgEl6RH4v/VMlTCxk1pelGhuLge5RNTrmAUZwFalfJ0UQ
         mmNEeog5KfEzNgmcmDc6ZI6hio2NiqSWEwXaU5PpBX4owQDPP6HuDIqAWLnY2VGj/Sud
         Ldpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990633; x=1703595433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYHstZ7DJyRwFTy0VAWhYMgjrdwXsEjgu4laOEmIlZI=;
        b=WzbtdzOMWyJc8zx8G9Wo0RCmN5rcZfTF3gXoIBKKxFZrFn9uftJjY9ad9AE4TbtOP3
         EJSnMJy4ZpEV9KaaIcsG88A0fYgwWHnTVIJj8e0g45CE3oMzKuLRDCpC/3xoDUzYnIsV
         MmkemkQBHNGPdlDL0exnfK+fGbqiYeWQ9bG9EYMWKH8nh8N+dfgN89cW94vQ7lKKsfRa
         D80wUdzu9bEDnGMQQrjdP/WasT73zm9YrUAtTJGeMR6/18xyuYoouPP8HPv/wlt7vgAt
         tmQvWh6f+r+xiWMoCQ9x+ZueqdLrKvq+DXwhOdAbD0qovTf7kQHgXsYvcSIL+o4+tp6n
         Nl+A==
X-Gm-Message-State: AOJu0YxZkUMLOvYIP03/Vfo+j3iBRV5GOPucCDx5i8InVARxh88dO4DO
	s+LnbS23HPkUyxA5+0tlYOCfDA==
X-Google-Smtp-Source: AGHT+IF7sHcxswXf1ong/94KQXP83mbBDgSXGIAbu+2o6haRW1hkhZI7gait1LflE1BudWdwNjLP2A==
X-Received: by 2002:a05:600c:a05:b0:40d:1744:6cf9 with SMTP id z5-20020a05600c0a0500b0040d17446cf9mr2378201wmp.114.1702990633363;
        Tue, 19 Dec 2023 04:57:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bfd0:6ab0:50e2:7f18])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b004064e3b94afsm2844403wms.4.2023.12.19.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:57:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: use __counted_by() for GPIO descriptors
Date: Tue, 19 Dec 2023 13:57:06 +0100
Message-Id: <20231219125706.23284-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Pull the array of GPIO descriptors into struct gpio_device as a flexible
array and use __counted_by() to control its size.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 14 ++----
 drivers/gpio/gpiolib.h | 98 +++++++++++++++++++++---------------------
 2 files changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c9ca809b55de..7ebeb5bb7918 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -669,7 +670,6 @@ static void gpiodev_release(struct device *dev)
 
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
-	kfree(gdev->descs);
 	kfree(gdev);
 }
 
@@ -831,7 +831,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
 	 */
-	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
+	gdev = kzalloc(struct_size(gdev, descs, gc->ngpio), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 	gdev->dev.bus = &gpio_bus_type;
@@ -873,16 +873,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_free_dev_name;
 
-	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
-	if (!gdev->descs) {
-		ret = -ENOMEM;
-		goto err_free_dev_name;
-	}
-
 	gdev->label = kstrdup_const(gc->label ?: "unknown", GFP_KERNEL);
 	if (!gdev->label) {
 		ret = -ENOMEM;
-		goto err_free_descs;
+		goto err_free_dev_name;
 	}
 
 	gdev->ngpio = gc->ngpio;
@@ -1021,8 +1015,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		list_del(&gdev->list);
 err_free_label:
 	kfree_const(gdev->label);
-err_free_descs:
-	kfree(gdev->descs);
 err_free_dev_name:
 	kfree(dev_name(&gdev->dev));
 err_free_ida:
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 0ce7451a6b24..d65ee94d88f8 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -21,6 +21,53 @@
 
 #define GPIOCHIP_NAME	"gpiochip"
 
+/**
+ * struct gpio_desc - Opaque descriptor for a GPIO
+ *
+ * @gdev:		Pointer to the parent GPIO device
+ * @flags:		Binary descriptor flags
+ * @label:		Name of the consumer
+ * @name:		Line name
+ * @hog:		Pointer to the device node that hogs this line (if any)
+ *
+ * These are obtained using gpiod_get() and are preferable to the old
+ * integer-based handles.
+ *
+ * Contrary to integers, a pointer to a &struct gpio_desc is guaranteed to be
+ * valid until the GPIO is released.
+ */
+struct gpio_desc {
+	struct gpio_device	*gdev;
+	unsigned long		flags;
+/* flag symbols are bit numbers */
+#define FLAG_REQUESTED	0
+#define FLAG_IS_OUT	1
+#define FLAG_EXPORT	2	/* protected by sysfs_lock */
+#define FLAG_SYSFS	3	/* exported via /sys/class/gpio/control */
+#define FLAG_ACTIVE_LOW	6	/* value has active low */
+#define FLAG_OPEN_DRAIN	7	/* Gpio is open drain type */
+#define FLAG_OPEN_SOURCE 8	/* Gpio is open source type */
+#define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
+#define FLAG_IRQ_IS_ENABLED 10	/* GPIO is connected to an enabled IRQ */
+#define FLAG_IS_HOGGED	11	/* GPIO is hogged */
+#define FLAG_TRANSITORY 12	/* GPIO may lose value in sleep or reset */
+#define FLAG_PULL_UP    13	/* GPIO has pull up enabled */
+#define FLAG_PULL_DOWN  14	/* GPIO has pull down enabled */
+#define FLAG_BIAS_DISABLE    15	/* GPIO has pull disabled */
+#define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
+#define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
+#define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
+#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
+
+	/* Connection label */
+	const char		*label;
+	/* Name of the GPIO */
+	const char		*name;
+#ifdef CONFIG_OF_DYNAMIC
+	struct device_node	*hog;
+#endif
+};
+
 /**
  * struct gpio_device - internal state container for GPIO devices
  * @dev: the GPIO device struct
@@ -31,7 +78,6 @@
  * @owner: helps prevent removal of modules exporting active GPIOs
  * @chip: pointer to the corresponding gpiochip, holding static
  * data for this device
- * @descs: array of ngpio descriptors.
  * @ngpio: the number of GPIO lines on this GPIO device, equal to the size
  * of the @descs array.
  * @base: GPIO base in the DEPRECATED global Linux GPIO numberspace, assigned
@@ -48,6 +94,7 @@
  *       user-space operations when the device gets unregistered during
  *       a hot-unplug event
  * @pin_ranges: range of pins served by the GPIO driver
+ * @descs: array of ngpio descriptors.
  *
  * This state container holds most of the runtime variable data
  * for a GPIO device and can hold references and live on after the
@@ -61,7 +108,6 @@ struct gpio_device {
 	struct device		*mockdev;
 	struct module		*owner;
 	struct gpio_chip	*chip;
-	struct gpio_desc	*descs;
 	int			base;
 	u16			ngpio;
 	const char		*label;
@@ -80,6 +126,7 @@ struct gpio_device {
 	 */
 	struct list_head pin_ranges;
 #endif
+	struct gpio_desc	descs[] __counted_by(ngpio);
 };
 
 static inline struct gpio_device *to_gpio_device(struct device *dev)
@@ -141,53 +188,6 @@ extern struct mutex gpio_devices_lock;
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
-/**
- * struct gpio_desc - Opaque descriptor for a GPIO
- *
- * @gdev:		Pointer to the parent GPIO device
- * @flags:		Binary descriptor flags
- * @label:		Name of the consumer
- * @name:		Line name
- * @hog:		Pointer to the device node that hogs this line (if any)
- *
- * These are obtained using gpiod_get() and are preferable to the old
- * integer-based handles.
- *
- * Contrary to integers, a pointer to a &struct gpio_desc is guaranteed to be
- * valid until the GPIO is released.
- */
-struct gpio_desc {
-	struct gpio_device	*gdev;
-	unsigned long		flags;
-/* flag symbols are bit numbers */
-#define FLAG_REQUESTED	0
-#define FLAG_IS_OUT	1
-#define FLAG_EXPORT	2	/* protected by sysfs_lock */
-#define FLAG_SYSFS	3	/* exported via /sys/class/gpio/control */
-#define FLAG_ACTIVE_LOW	6	/* value has active low */
-#define FLAG_OPEN_DRAIN	7	/* Gpio is open drain type */
-#define FLAG_OPEN_SOURCE 8	/* Gpio is open source type */
-#define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
-#define FLAG_IRQ_IS_ENABLED 10	/* GPIO is connected to an enabled IRQ */
-#define FLAG_IS_HOGGED	11	/* GPIO is hogged */
-#define FLAG_TRANSITORY 12	/* GPIO may lose value in sleep or reset */
-#define FLAG_PULL_UP    13	/* GPIO has pull up enabled */
-#define FLAG_PULL_DOWN  14	/* GPIO has pull down enabled */
-#define FLAG_BIAS_DISABLE    15	/* GPIO has pull disabled */
-#define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
-#define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
-#define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
-#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
-
-	/* Connection label */
-	const char		*label;
-	/* Name of the GPIO */
-	const char		*name;
-#ifdef CONFIG_OF_DYNAMIC
-	struct device_node	*hog;
-#endif
-};
-
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
-- 
2.40.1


