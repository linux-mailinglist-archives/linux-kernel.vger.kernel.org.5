Return-Path: <linux-kernel+bounces-1236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53006814C24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B665281F51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576153BB30;
	Fri, 15 Dec 2023 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sRCMROUq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A739FC9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c6a71e88cso10099535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702655587; x=1703260387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Drn2MP92GfxGHY+b7s7XFIx1YXY2oN3ER8r+Hc85sys=;
        b=sRCMROUqehpEE+flhCIFj2KK5G0m07X5NOA9lFL41XdYZklFVKaaLNJaFyN5d7COID
         VIXiqA3M65IyF/mjzaQvEhaPwqKIsWc/FvFvSl/DbLCL7148xO10b7GM4hlD6RdK39Or
         l15B8QkaJj5qhVVx07VaI0y4UG6+y1nZUpt2zS5puHidxP6P/lk3Mi6/QeFBBaXrukvm
         H5yf0JAn3IoHAElREKB2wc7ljlfNq7dZ3oPzptwCZvHR4ifLo4/IGnRndhzevA4Z09fv
         v1I+fUMsIcPVEsRzOcvujI6GR4YKrUwCddrrm1aKB5wwAqaoezu+tb2dPsBrgAvXDump
         sw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655587; x=1703260387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Drn2MP92GfxGHY+b7s7XFIx1YXY2oN3ER8r+Hc85sys=;
        b=XqGVSdCYTWEE5Baf2yVij1mt9MBLwZEvEud6xiGQ6qTDv04TkDGWgZlXnyLWHFBGAW
         g8J/K/XsFUfP2HcxPy7HVy08diJqtdTLjW48eSjTjqbXFge65nyuNepkHzV9bv/A8cM+
         NuHO6UggYbN3cM7Q3L25f0wAcoOhXGcOd5z1WBvO3imhZBIZO5r7V1uRoLeigcKwKcGb
         EAviTywuPk67/3hDaxa/teDdJ4oXC0HOPXfUCA8I1OE1CSl3v2KPrmUIhbw3ADXfJI6Y
         m+aOuvtIkREXOJVzrEEepDArMIiMqoZEcHEsF2xWw4Y/GhDuL9CO7Kds2WKHZSt8/xRu
         rFhQ==
X-Gm-Message-State: AOJu0YyhOuU5zbeXFQXp7h5PsuHAqALGRngmV51s7QeDd8J4Ry4mggBi
	rrK7AZAl22Fkogv+in92saeLxA==
X-Google-Smtp-Source: AGHT+IFajkiTdvbtCRDeY4Wek8lHsC4HobjWKwXNrjeRfqG03wpTLS1gV+uqfiTNFvNCl5/GXvJ5vw==
X-Received: by 2002:a05:600c:2a18:b0:40c:2671:2c52 with SMTP id w24-20020a05600c2a1800b0040c26712c52mr7158602wme.99.1702655587094;
        Fri, 15 Dec 2023 07:53:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8672:e2c5:37d9:3743])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b0040c6ab53cd2sm3110484wmb.10.2023.12.15.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:53:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 2/2] gpiolib: use a mutex to protect the list of GPIO devices
Date: Fri, 15 Dec 2023 16:53:00 +0100
Message-Id: <20231215155300.21186-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215155300.21186-1-brgl@bgdev.pl>
References: <20231215155300.21186-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The global list of GPIO devices is never modified or accessed from
atomic context so it's fine to protect it using a mutex. Add a new
global lock dedicated to the gpio_devices list and use it whenever
accessing or modifying it.

While at it: fold the sysfs registering of existing devices into
gpiolib.c and make gpio_devices static within its compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c |  45 ++++++------
 drivers/gpio/gpiolib-sysfs.h |   6 ++
 drivers/gpio/gpiolib.c       | 139 ++++++++++++++++-------------------
 drivers/gpio/gpiolib.h       |   2 +
 4 files changed, 91 insertions(+), 101 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 6f309a3b2d9a..ae4fc013b675 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -766,6 +766,25 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
+int gpiochip_sysfs_register_all(void)
+{
+	struct gpio_device *gdev;
+	int ret;
+
+	guard(mutex)(&gpio_devices_lock);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (gdev->mockdev)
+			continue;
+
+		ret = gpiochip_sysfs_register(gdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 	struct gpio_desc *desc;
@@ -790,9 +809,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 
 static int __init gpiolib_sysfs_init(void)
 {
-	int		status;
-	unsigned long	flags;
-	struct gpio_device *gdev;
+	int status;
 
 	status = class_register(&gpio_class);
 	if (status < 0)
@@ -804,26 +821,6 @@ static int __init gpiolib_sysfs_init(void)
 	 * We run before arch_initcall() so chip->dev nodes can have
 	 * registered, and so arch_initcall() can always gpiod_export().
 	 */
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->mockdev)
-			continue;
-
-		/*
-		 * TODO we yield gpio_lock here because
-		 * gpiochip_sysfs_register() acquires a mutex. This is unsafe
-		 * and needs to be fixed.
-		 *
-		 * Also it would be nice to use gpio_device_find() here so we
-		 * can keep gpio_chips local to gpiolib.c, but the yield of
-		 * gpio_lock prevents us from doing this.
-		 */
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		status = gpiochip_sysfs_register(gdev);
-		spin_lock_irqsave(&gpio_lock, flags);
-	}
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	return status;
+	return gpiochip_sysfs_register_all();
 }
 postcore_initcall(gpiolib_sysfs_init);
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index b794b396d6a5..ab157cec0b4b 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -8,6 +8,7 @@ struct gpio_device;
 #ifdef CONFIG_GPIO_SYSFS
 
 int gpiochip_sysfs_register(struct gpio_device *gdev);
+int gpiochip_sysfs_register_all(void);
 void gpiochip_sysfs_unregister(struct gpio_device *gdev);
 
 #else
@@ -17,6 +18,11 @@ static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
+static inline int gpiochip_sysfs_register_all(void)
+{
+	return 0;
+}
+
 static inline void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5b744d1f31f6..9508396c967e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2,6 +2,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -15,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/seq_file.h>
@@ -94,7 +96,9 @@ DEFINE_SPINLOCK(gpio_lock);
 
 static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
+
 LIST_HEAD(gpio_devices);
+DEFINE_MUTEX(gpio_devices_lock);
 
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
@@ -126,20 +130,15 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
 struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->base <= gpio &&
-		    gdev->base + gdev->ngpio > gpio) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
-			return &gdev->descs[gpio - gdev->base];
+	scoped_guard(mutex, &gpio_devices_lock) {
+		list_for_each_entry(gdev, &gpio_devices, list) {
+			if (gdev->base <= gpio &&
+			    gdev->base + gdev->ngpio > gpio)
+				return &gdev->descs[gpio - gdev->base];
 		}
 	}
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	if (!gpio_is_valid(gpio))
 		pr_warn("invalid GPIO %d\n", gpio);
 
@@ -412,26 +411,21 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 static struct gpio_desc *gpio_name_to_desc(const char * const name)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 
 	if (!name)
 		return NULL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
+	guard(mutex)(&gpio_devices_lock);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		struct gpio_desc *desc;
 
 		for_each_gpio_desc(gdev->chip, desc) {
-			if (desc->name && !strcmp(desc->name, name)) {
-				spin_unlock_irqrestore(&gpio_lock, flags);
+			if (desc->name && !strcmp(desc->name, name))
 				return desc;
-			}
 		}
 	}
 
-	spin_unlock_irqrestore(&gpio_lock, flags);
-
 	return NULL;
 }
 
@@ -669,11 +663,9 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev = to_gpio_device(dev);
-	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_del(&gdev->list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del(&gdev->list);
 
 	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
@@ -831,7 +823,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned long flags;
 	unsigned int i;
 	int base = 0;
 	int ret = 0;
@@ -896,48 +887,45 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	gdev->ngpio = gc->ngpio;
 
-	spin_lock_irqsave(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock) {
+		/*
+		 * TODO: this allocates a Linux GPIO number base in the global
+		 * GPIO numberspace for this chip. In the long run we want to
+		 * get *rid* of this numberspace and use only descriptors, but
+		 * it may be a pipe dream. It will not happen before we get rid
+		 * of the sysfs interface anyways.
+		 */
+		base = gc->base;
 
-	/*
-	 * TODO: this allocates a Linux GPIO number base in the global
-	 * GPIO numberspace for this chip. In the long run we want to
-	 * get *rid* of this numberspace and use only descriptors, but
-	 * it may be a pipe dream. It will not happen before we get rid
-	 * of the sysfs interface anyways.
-	 */
-	base = gc->base;
-	if (base < 0) {
-		base = gpiochip_find_base_unlocked(gc->ngpio);
 		if (base < 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
-			ret = base;
-			base = 0;
+			base = gpiochip_find_base_unlocked(gc->ngpio);
+			if (base < 0) {
+				ret = base;
+				base = 0;
+				goto err_free_label;
+			}
+			/*
+			 * TODO: it should not be necessary to reflect the assigned
+			 * base outside of the GPIO subsystem. Go over drivers and
+			 * see if anyone makes use of this, else drop this and assign
+			 * a poison instead.
+			 */
+			gc->base = base;
+		} else {
+			dev_warn(&gdev->dev,
+				 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
+		}
+		gdev->base = base;
+
+		ret = gpiodev_add_to_list_unlocked(gdev);
+		if (ret) {
+			chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
 			goto err_free_label;
 		}
-		/*
-		 * TODO: it should not be necessary to reflect the assigned
-		 * base outside of the GPIO subsystem. Go over drivers and
-		 * see if anyone makes use of this, else drop this and assign
-		 * a poison instead.
-		 */
-		gc->base = base;
-	} else {
-		dev_warn(&gdev->dev,
-			 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
+
+		for (i = 0; i < gc->ngpio; i++)
+			gdev->descs[i].gdev = gdev;
 	}
-	gdev->base = base;
-
-	ret = gpiodev_add_to_list_unlocked(gdev);
-	if (ret) {
-		spin_unlock_irqrestore(&gpio_lock, flags);
-		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-		goto err_free_label;
-	}
-
-	for (i = 0; i < gc->ngpio; i++)
-		gdev->descs[i].gdev = gdev;
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
@@ -1029,9 +1017,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_print_message;
 	}
 err_remove_from_list:
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_del(&gdev->list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock)
+		list_del(&gdev->list);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
@@ -1140,7 +1127,7 @@ struct gpio_device *gpio_device_find(void *data,
 	 */
 	might_sleep();
 
-	guard(spinlock_irqsave)(&gpio_lock);
+	guard(mutex)(&gpio_devices_lock);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		if (gdev->chip && match(gdev->chip, data))
@@ -4756,35 +4743,33 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 {
-	unsigned long flags;
 	struct gpio_device *gdev = NULL;
 	loff_t index = *pos;
 
 	s->private = "";
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list)
-		if (index-- == 0) {
-			spin_unlock_irqrestore(&gpio_lock, flags);
+	guard(mutex)(&gpio_devices_lock);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (index-- == 0)
 			return gdev;
-		}
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	}
 
 	return NULL;
 }
 
 static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	unsigned long flags;
 	struct gpio_device *gdev = v;
 	void *ret = NULL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	if (list_is_last(&gdev->list, &gpio_devices))
-		ret = NULL;
-	else
-		ret = list_first_entry(&gdev->list, struct gpio_device, list);
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	scoped_guard(mutex, &gpio_devices_lock) {
+		if (list_is_last(&gdev->list, &gpio_devices))
+			ret = NULL;
+		else
+			ret = list_first_entry(&gdev->list, struct gpio_device,
+					       list);
+	}
 
 	s->private = "\n";
 	++*pos;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3ccacf3c1288..8142b5cbc395 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h> /* for enum gpiod_flags */
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 
@@ -136,6 +137,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 
 extern spinlock_t gpio_lock;
 extern struct list_head gpio_devices;
+extern struct mutex gpio_devices_lock;
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
-- 
2.40.1


