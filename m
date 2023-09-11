Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D379AFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjIKVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjIKLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:07:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB7CDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:07:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so4283528f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694430464; x=1695035264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xm/XvHIaXfTZZB2GeDKFP8ttNrQxIuqNDAWSLgDUamU=;
        b=tChjVYOplOSs2pKiZh9At1aFH5TAuSabtJgHKB2wK+wS+4mhlEtR/2HKVjZfoATAg0
         ie1s0wRfEBFY8FOx7batNCs2d3MOhii4/D+EVZX6Vf81LK1UVkvJCMffqibn7a72dMKD
         o9l32qoZknfY1pLQ9gopMhbiqObH49u8mZGhQpfp7q/ai4iwKDXt2qHmaH8jrO0RewGk
         nuQuq0NOXIHusoeCz7Qkz/1vkatDyufINNgMwZIs1pdjMC0fpMPQ0nXo+uiYW5aErfWH
         YMalxm3Rzqrq5z0tQqCutmwH2OE1jYPIGSFhqhoYVcZTz4iychdxfyLqs10sEnJ5Izgv
         9W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430464; x=1695035264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xm/XvHIaXfTZZB2GeDKFP8ttNrQxIuqNDAWSLgDUamU=;
        b=Al9TAWkC0gJ7VSEjZSHYOAA2fXVFLZHVjVxuTzUwLXhypWldlAur4qVQz/ZwRo63yq
         4lGMA0S7CUNNr4kRlv5iCq3jOnhLt1vilBauox8Y1GruQcYYexFbUNWmdRWi871nwbV3
         OBi3KPq93k4ZAhMv1rhBU2uq4rWwWB6dbdN4k7NtTohlTEWepy6s9DvzT/adVEMfaNVo
         iJB2BeAksqd8oIXXORVm17epMiMqBsLatjx82pZIhVuqjjPkL4f4BkYD5yZNXOQ5q37Y
         sc/Xu3uecWn3If284nU2jDTifj+jXijYl6ESJHmf5l2+TF4r4IdDQlXyGo1obMKuY844
         TchA==
X-Gm-Message-State: AOJu0YzCvRTaLNByA93TDDyNoexB0CMl3yhVOcrQllphdy0+gwcPgyCw
        t3HYv9x34yppp/z8E8WaYRvt9g==
X-Google-Smtp-Source: AGHT+IFKnQ3ehacxh8x5sp0+cO9MVpN1I81oxpW9TVLRWQV8nh0/kBCB1vz6i5OZ2JrCdjU9LYBLDA==
X-Received: by 2002:a5d:6acc:0:b0:314:327:2edb with SMTP id u12-20020a5d6acc000000b0031403272edbmr8302489wrw.0.1694430463702;
        Mon, 11 Sep 2023 04:07:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c2b1:675e:119e:2497])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b0031f5f0d0be0sm9693736wrr.31.2023.09.11.04.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:07:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5] gpio: sim: don't fiddle with GPIOLIB private members
Date:   Mon, 11 Sep 2023 13:07:40 +0200
Message-Id: <20230911110740.16284-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We access internals of struct gpio_device and struct gpio_desc because
it's easier but it can actually be avoided and we're working towards a
better encapsulation of GPIO data structures across the kernel so let's
start at home.

Instead of checking gpio_desc flags, let's just track the requests of
GPIOs in the driver. We also already store the information about
direction of simulated lines.

For kobjects needed by sysfs callbacks: we can iterate over the children
devices of the top-level platform device and compare their fwnodes
against the one passed to the init function from probe.

While at it: fix one line break and remove the untrue part about
configfs callbacks using dev_get_drvdata() from a comment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use get_dev_from_fwnode() instead of dereferencing fwnode directly

v2 -> v3:
- don't use fwnode internal fields, instead: iterate over the platform
  device's children and locate the GPIO device

v3 -> v4:
- use device_find_child() (not bus_device_find_by_fwnode() as it's
  pointless to iterate over all platform devices)
- use device_match_fwnode() for matching the device by fwnode

v4 -> v5:
- don't include linux/device/bus.h, rely on device.h already pulling it
- drop a comment about pointer mismatch for the callback function pointer
  in device_find_child

 drivers/gpio/gpio-sim.c | 70 ++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 271db3639a78..2b9d9e172d5d 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
@@ -30,8 +31,6 @@
 #include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 
-#include "gpiolib.h"
-
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
@@ -40,6 +39,8 @@ static DEFINE_IDA(gpio_sim_ida);
 
 struct gpio_sim_chip {
 	struct gpio_chip gc;
+	struct device *dev;
+	unsigned long *request_map;
 	unsigned long *direction_map;
 	unsigned long *value_map;
 	unsigned long *pull_map;
@@ -63,16 +64,11 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 			       unsigned int offset, int value)
 {
 	int irq, irq_type, ret;
-	struct gpio_desc *desc;
-	struct gpio_chip *gc;
-
-	gc = &chip->gc;
-	desc = &gc->gpiodev->descs[offset];
 
 	guard(mutex)(&chip->lock);
 
-	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
-	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
+	if (test_bit(offset, chip->request_map) &&
+	    test_bit(offset, chip->direction_map)) {
 		if (value == !!test_bit(offset, chip->value_map))
 			goto set_pull;
 
@@ -99,8 +95,8 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 
 set_value:
 	/* Change the value unless we're actively driving the line. */
-	if (!test_bit(FLAG_REQUESTED, &desc->flags) ||
-	    !test_bit(FLAG_IS_OUT, &desc->flags))
+	if (!test_bit(offset, chip->request_map) ||
+	    test_bit(offset, chip->direction_map))
 		__assign_bit(offset, chip->value_map, value);
 
 set_pull:
@@ -180,8 +176,8 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 	return direction ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
 }
 
-static int gpio_sim_set_config(struct gpio_chip *gc,
-				  unsigned int offset, unsigned long config)
+static int gpio_sim_set_config(struct gpio_chip *gc, unsigned int offset,
+			       unsigned long config)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
@@ -204,13 +200,25 @@ static int gpio_sim_to_irq(struct gpio_chip *gc, unsigned int offset)
 	return irq_create_mapping(chip->irq_sim, offset);
 }
 
-static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
+static int gpio_sim_request(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
 	scoped_guard(mutex, &chip->lock)
+		__set_bit(offset, chip->request_map);
+
+	return 0;
+}
+
+static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+
+	scoped_guard(mutex, &chip->lock) {
 		__assign_bit(offset, chip->value_map,
 			     !!test_bit(offset, chip->pull_map));
+		__clear_bit(offset, chip->request_map);
+	}
 }
 
 static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
@@ -282,6 +290,13 @@ static void gpio_sim_mutex_destroy(void *data)
 	mutex_destroy(lock);
 }
 
+static void gpio_sim_put_device(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static void gpio_sim_dispose_mappings(void *data)
 {
 	struct gpio_sim_chip *chip = data;
@@ -295,7 +310,7 @@ static void gpio_sim_sysfs_remove(void *data)
 {
 	struct gpio_sim_chip *chip = data;
 
-	sysfs_remove_groups(&chip->gc.gpiodev->dev.kobj, chip->attr_groups);
+	sysfs_remove_groups(&chip->dev->kobj, chip->attr_groups);
 }
 
 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
@@ -352,14 +367,18 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 		chip->attr_groups[i] = attr_group;
 	}
 
-	ret = sysfs_create_groups(&chip->gc.gpiodev->dev.kobj,
-				  chip->attr_groups);
+	ret = sysfs_create_groups(&chip->dev->kobj, chip->attr_groups);
 	if (ret)
 		return ret;
 
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
+static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
+{
+	return device_match_fwnode(dev, data);
+}
+
 static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 {
 	struct gpio_sim_chip *chip;
@@ -387,6 +406,10 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->request_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->request_map)
+		return -ENOMEM;
+
 	chip->direction_map = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
 	if (!chip->direction_map)
 		return -ENOMEM;
@@ -432,6 +455,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->get_direction = gpio_sim_get_direction;
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
+	gc->request = gpio_sim_request;
 	gc->free = gpio_sim_free;
 	gc->can_sleep = true;
 
@@ -439,8 +463,16 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Used by sysfs and configfs callbacks. */
-	dev_set_drvdata(&gc->gpiodev->dev, chip);
+	chip->dev = device_find_child(dev, swnode, gpio_sim_dev_match_fwnode);
+	if (!chip->dev)
+		return -ENODEV;
+
+	ret = devm_add_action_or_reset(dev, gpio_sim_put_device, chip->dev);
+	if (ret)
+		return ret;
+
+	/* Used by sysfs callbacks. */
+	dev_set_drvdata(chip->dev, chip);
 
 	return gpio_sim_setup_sysfs(chip);
 }
-- 
2.39.2

