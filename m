Return-Path: <linux-kernel+bounces-25919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6682D836
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02DC1C21970
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D232C1B8;
	Mon, 15 Jan 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="znoMQ/k6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B32C689
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e67e90d5aso26830735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705317468; x=1705922268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8S8U0s4SFV0rNmPaFYHhQio6T8IVGZN8p6ixEj09IG0=;
        b=znoMQ/k65I3du38Amdjjq4mBg29ymrXyRCZh3YA4k5WeOrth06LPrjgAncFIHQp958
         p29h5ggiB2+EbWNb4aM6G2OP7XRU+NBpodLMXCNI+CW12eJtYUYAtDolhJ019tiw+hqw
         Aix7RWoTXHhShpJmdyh3/fAQ6i9vir7fJIpov5ntpxJd36qVSLEaATC4NULSuxVd+yD3
         Lk9Nt95p76lamLi11Hsp+Rc68wvWXricpgzg8ynTr28/LjgyhZhdpVMreXt3AGSECHTe
         W9VV7ooevn45sgHe1a4ECLlsg60cp3hA+lc9G+Je7VMyKidfbs+CzJmNnb/vw5n9eheW
         xlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705317468; x=1705922268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8S8U0s4SFV0rNmPaFYHhQio6T8IVGZN8p6ixEj09IG0=;
        b=WoyjjgexJiABamn71imH0sgMmYRpndjhQNAwIgPWx4zY4v5m+JMW8U58KqU/OuNDpn
         9D6i7LztESe/0pbYAMSett7EPt9poT8znltsbb2VMerzcsLMV0Qz/fMNoKSEhO2jjsLi
         WYUafRU0CosfKW9+lVOtsNevaorYdT8F0GkLcK6CY1E6hVCRXCpqbVlwWaY7PhHdtl4u
         38OxOfPm47+TYK+BM0gko8k7Yme1zrrOuyVGqwAf7Pjoi+O+ZdnnJ6WrcM+ECuGqw70M
         sXvFz0wHThD/MAdFTdfLn2iQe7tGuzNNFGJ9TddgwAHF+1/FIIRragDvqV23BhJAUuP5
         RGPQ==
X-Gm-Message-State: AOJu0YwHNxxKs3JAC8HRKPDQZOyySaxIzaIbOcC/nIYDCyfusSqhSj6E
	5+r+goga+7vXoHs77zFdz+O2seivI1Jsgw==
X-Google-Smtp-Source: AGHT+IHGRd/tIISrHLXfNUI6PIf/BnRw48bIsV5qPCuYEUKdl+1kDN5sXq68ojIv8VYodpxZ9WvMuw==
X-Received: by 2002:a05:600c:3115:b0:40c:66bf:c6a2 with SMTP id g21-20020a05600c311500b0040c66bfc6a2mr2367374wmo.92.1705317468002;
        Mon, 15 Jan 2024 03:17:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b244:1a90:13e7:9f6f])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm11642260wrn.63.2024.01.15.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 03:17:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] gpiolib: revert the attempt to protect the GPIO device list with an rwsem
Date: Mon, 15 Jan 2024 12:17:43 +0100
Message-Id: <20240115111743.28512-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commits 1979a2807547 ("gpiolib: replace the GPIO device
mutex with a read-write semaphore") and 65a828bab158 ("gpiolib: use
a mutex to protect the list of GPIO devices").

Unfortunately the legacy GPIO API that's still used in older code has to
translate numbers from the global GPIO numberspace to descriptors. This
results in a GPIO device lookup in every call to legacy functions. Some
of those functions - like gpio_set/get_value() - can be called from
atomic context so taking a sleeping lock that is an RW semaphore results
in an error.

We'll probably have to protect this list with SRCU.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/f7b5ff1e-8f34-4d98-a7be-b826cb897dc8@moroto.mountain/
Fixes: 1979a2807547 ("gpiolib: replace the GPIO device mutex with a read-write semaphore")
Fixes: 65a828bab158 ("gpiolib: use a mutex to protect the list of GPIO devices")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c |  45 ++++++------
 drivers/gpio/gpiolib-sysfs.h |   6 --
 drivers/gpio/gpiolib.c       | 135 +++++++++++++++++++----------------
 drivers/gpio/gpiolib.h       |   2 -
 4 files changed, 98 insertions(+), 90 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 4dbf298bb5dd..6bf5332136e5 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -768,25 +768,6 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
-int gpiochip_sysfs_register_all(void)
-{
-	struct gpio_device *gdev;
-	int ret;
-
-	guard(rwsem_read)(&gpio_devices_sem);
-
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (gdev->mockdev)
-			continue;
-
-		ret = gpiochip_sysfs_register(gdev);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 	struct gpio_desc *desc;
@@ -811,7 +792,9 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 
 static int __init gpiolib_sysfs_init(void)
 {
-	int status;
+	int		status;
+	unsigned long	flags;
+	struct gpio_device *gdev;
 
 	status = class_register(&gpio_class);
 	if (status < 0)
@@ -823,6 +806,26 @@ static int __init gpiolib_sysfs_init(void)
 	 * We run before arch_initcall() so chip->dev nodes can have
 	 * registered, and so arch_initcall() can always gpiod_export().
 	 */
-	return gpiochip_sysfs_register_all();
+	spin_lock_irqsave(&gpio_lock, flags);
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (gdev->mockdev)
+			continue;
+
+		/*
+		 * TODO we yield gpio_lock here because
+		 * gpiochip_sysfs_register() acquires a mutex. This is unsafe
+		 * and needs to be fixed.
+		 *
+		 * Also it would be nice to use gpio_device_find() here so we
+		 * can keep gpio_chips local to gpiolib.c, but the yield of
+		 * gpio_lock prevents us from doing this.
+		 */
+		spin_unlock_irqrestore(&gpio_lock, flags);
+		status = gpiochip_sysfs_register(gdev);
+		spin_lock_irqsave(&gpio_lock, flags);
+	}
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return status;
 }
 postcore_initcall(gpiolib_sysfs_init);
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index ab157cec0b4b..b794b396d6a5 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -8,7 +8,6 @@ struct gpio_device;
 #ifdef CONFIG_GPIO_SYSFS
 
 int gpiochip_sysfs_register(struct gpio_device *gdev);
-int gpiochip_sysfs_register_all(void);
 void gpiochip_sysfs_unregister(struct gpio_device *gdev);
 
 #else
@@ -18,11 +17,6 @@ static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
-static inline int gpiochip_sysfs_register_all(void)
-{
-	return 0;
-}
-
 static inline void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4c93cf73a826..44c8f5743a24 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2,7 +2,6 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
-#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -16,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/seq_file.h>
@@ -83,9 +81,7 @@ DEFINE_SPINLOCK(gpio_lock);
 
 static DEFINE_MUTEX(gpio_lookup_lock);
 static LIST_HEAD(gpio_lookup_list);
-
 LIST_HEAD(gpio_devices);
-DECLARE_RWSEM(gpio_devices_sem);
 
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
@@ -117,15 +113,20 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
 struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
 	struct gpio_device *gdev;
+	unsigned long flags;
 
-	scoped_guard(rwsem_read, &gpio_devices_sem) {
-		list_for_each_entry(gdev, &gpio_devices, list) {
-			if (gdev->base <= gpio &&
-			    gdev->base + gdev->ngpio > gpio)
-				return &gdev->descs[gpio - gdev->base];
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (gdev->base <= gpio &&
+		    gdev->base + gdev->ngpio > gpio) {
+			spin_unlock_irqrestore(&gpio_lock, flags);
+			return &gdev->descs[gpio - gdev->base];
 		}
 	}
 
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
 	if (!gpio_is_valid(gpio))
 		pr_warn("invalid GPIO %d\n", gpio);
 
@@ -398,21 +399,26 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 static struct gpio_desc *gpio_name_to_desc(const char * const name)
 {
 	struct gpio_device *gdev;
+	unsigned long flags;
 
 	if (!name)
 		return NULL;
 
-	guard(rwsem_read)(&gpio_devices_sem);
+	spin_lock_irqsave(&gpio_lock, flags);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		struct gpio_desc *desc;
 
 		for_each_gpio_desc(gdev->chip, desc) {
-			if (desc->name && !strcmp(desc->name, name))
+			if (desc->name && !strcmp(desc->name, name)) {
+				spin_unlock_irqrestore(&gpio_lock, flags);
 				return desc;
+			}
 		}
 	}
 
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
 	return NULL;
 }
 
@@ -807,6 +813,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
+	unsigned long flags;
 	unsigned int i;
 	int base = 0;
 	int ret = 0;
@@ -871,45 +878,48 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	gdev->ngpio = gc->ngpio;
 
-	scoped_guard(rwsem_write, &gpio_devices_sem) {
-		/*
-		 * TODO: this allocates a Linux GPIO number base in the global
-		 * GPIO numberspace for this chip. In the long run we want to
-		 * get *rid* of this numberspace and use only descriptors, but
-		 * it may be a pipe dream. It will not happen before we get rid
-		 * of the sysfs interface anyways.
-		 */
-		base = gc->base;
+	spin_lock_irqsave(&gpio_lock, flags);
 
+	/*
+	 * TODO: this allocates a Linux GPIO number base in the global
+	 * GPIO numberspace for this chip. In the long run we want to
+	 * get *rid* of this numberspace and use only descriptors, but
+	 * it may be a pipe dream. It will not happen before we get rid
+	 * of the sysfs interface anyways.
+	 */
+	base = gc->base;
+	if (base < 0) {
+		base = gpiochip_find_base_unlocked(gc->ngpio);
 		if (base < 0) {
-			base = gpiochip_find_base_unlocked(gc->ngpio);
-			if (base < 0) {
-				ret = base;
-				base = 0;
-				goto err_free_label;
-			}
-			/*
-			 * TODO: it should not be necessary to reflect the assigned
-			 * base outside of the GPIO subsystem. Go over drivers and
-			 * see if anyone makes use of this, else drop this and assign
-			 * a poison instead.
-			 */
-			gc->base = base;
-		} else {
-			dev_warn(&gdev->dev,
-				 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
-		}
-		gdev->base = base;
-
-		ret = gpiodev_add_to_list_unlocked(gdev);
-		if (ret) {
-			chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
+			spin_unlock_irqrestore(&gpio_lock, flags);
+			ret = base;
+			base = 0;
 			goto err_free_label;
 		}
-
-		for (i = 0; i < gc->ngpio; i++)
-			gdev->descs[i].gdev = gdev;
+		/*
+		 * TODO: it should not be necessary to reflect the assigned
+		 * base outside of the GPIO subsystem. Go over drivers and
+		 * see if anyone makes use of this, else drop this and assign
+		 * a poison instead.
+		 */
+		gc->base = base;
+	} else {
+		dev_warn(&gdev->dev,
+			 "Static allocation of GPIO base is deprecated, use dynamic allocation.\n");
 	}
+	gdev->base = base;
+
+	ret = gpiodev_add_to_list_unlocked(gdev);
+	if (ret) {
+		spin_unlock_irqrestore(&gpio_lock, flags);
+		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
+		goto err_free_label;
+	}
+
+	for (i = 0; i < gc->ngpio; i++)
+		gdev->descs[i].gdev = gdev;
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
@@ -1001,8 +1011,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_print_message;
 	}
 err_remove_from_list:
-	scoped_guard(rwsem_write, &gpio_devices_sem)
-		list_del(&gdev->list);
+	spin_lock_irqsave(&gpio_lock, flags);
+	list_del(&gdev->list);
+	spin_unlock_irqrestore(&gpio_lock, flags);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
@@ -1065,7 +1076,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 		dev_crit(&gdev->dev,
 			 "REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED\n");
 
-	scoped_guard(rwsem_write, &gpio_devices_sem)
+	scoped_guard(spinlock_irqsave, &gpio_lock)
 		list_del(&gdev->list);
 
 	/*
@@ -1114,7 +1125,7 @@ struct gpio_device *gpio_device_find(void *data,
 	 */
 	might_sleep();
 
-	guard(rwsem_read)(&gpio_devices_sem);
+	guard(spinlock_irqsave)(&gpio_lock);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		if (gdev->chip && match(gdev->chip, data))
@@ -4725,33 +4736,35 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
 static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 {
+	unsigned long flags;
 	struct gpio_device *gdev = NULL;
 	loff_t index = *pos;
 
 	s->private = "";
 
-	guard(rwsem_read)(&gpio_devices_sem);
-
-	list_for_each_entry(gdev, &gpio_devices, list) {
-		if (index-- == 0)
+	spin_lock_irqsave(&gpio_lock, flags);
+	list_for_each_entry(gdev, &gpio_devices, list)
+		if (index-- == 0) {
+			spin_unlock_irqrestore(&gpio_lock, flags);
 			return gdev;
-	}
+		}
+	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	return NULL;
 }
 
 static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
+	unsigned long flags;
 	struct gpio_device *gdev = v;
 	void *ret = NULL;
 
-	scoped_guard(rwsem_read, &gpio_devices_sem) {
-		if (list_is_last(&gdev->list, &gpio_devices))
-			ret = NULL;
-		else
-			ret = list_first_entry(&gdev->list, struct gpio_device,
-					       list);
-	}
+	spin_lock_irqsave(&gpio_lock, flags);
+	if (list_is_last(&gdev->list, &gpio_devices))
+		ret = NULL;
+	else
+		ret = list_first_entry(&gdev->list, struct gpio_device, list);
+	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	s->private = "\n";
 	++*pos;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 97df54abf57a..a4a2520b5f31 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -15,7 +15,6 @@
 #include <linux/gpio/consumer.h> /* for enum gpiod_flags */
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 
@@ -137,7 +136,6 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 
 extern spinlock_t gpio_lock;
 extern struct list_head gpio_devices;
-extern struct rw_semaphore gpio_devices_sem;
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
 
-- 
2.40.1


