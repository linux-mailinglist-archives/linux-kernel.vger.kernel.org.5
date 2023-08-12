Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2C77A1D8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHLSgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHLSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:36:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F6A1716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:36:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so27447755e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691865400; x=1692470200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvVpB+4Uv4zzXggW6yE90kvQNKITZlFHFfSaxiHwmd8=;
        b=4h1stgiUe5JaMhjF3P5N/sH3HNwpachclYq6TJqu1Rqa3ZVQCuFuFoe8t7n5lHZsu5
         5TqvmPUicKaNVXd0xm6atKW0JuFiTJEZMOuZFLAR6AxgFIuMNHiUcOfo6diR+FrI+D9i
         pWL3kTb4j5Or717SjZtxa6JCgvKOD3Lhlroqzs9YtmjnWLVkwzdJffvDN6Y29l+J2R5R
         Aao6LI7/Q+sVK3X8gwfJ9/3w2EHWHZz33y68A5wjIdqdMmzChxZ2XO1YhCu+T9ghY4IC
         cf83/hQGw7T30s8zlFcxLLtUH8IHCGL2uxbeg06a106fFT2vmjAE8HLuu5B7h/TS0Ypp
         +U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691865400; x=1692470200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvVpB+4Uv4zzXggW6yE90kvQNKITZlFHFfSaxiHwmd8=;
        b=AiQRBxMDcH4BKatO1uG/DZQDnkysWy9ZZpDMxIGNO4xyNJWnc5pu+tXvbhli2+DE7b
         VGrHB964+UAByrHBCO7GxuTpLQzTfJiKuRbc0jgXWo3csl3Xnoq4tipvrqpAlCH7BV0R
         fSK8UsUUIdtG13OI/di1HeqkDLxf2Q9c2OytZQLhgedA6NQLXLCX59PcTjCcx4mHegIU
         hqY3hH8eBg3tD31Uv/MA5vLdOV5/CKpHd8ngLaQV2ifTvFYJynZjiZ/Fu82I7YhMjycu
         EGvprn6ALOgqHlXXyt0jAeJUo1bMajmz0+BRYNW7P3fh0CXUXEgris+G8ABAfxFDn2Gu
         EXJw==
X-Gm-Message-State: AOJu0YzjJPPMD7HJiIECTOSn05haSq+Uj6HsH6VXGX0YY/aecyA6LITV
        oA/1o4nWg6k6kO85rFJhM0Gu8g==
X-Google-Smtp-Source: AGHT+IGLh0du/OC085GfH5e5oXEUHluNananK4uxp4aHxqaP9/Q1AbXyBm+DYAns4MSNXNeQrY1b1w==
X-Received: by 2002:a05:600c:210c:b0:3fc:f9c:a3e6 with SMTP id u12-20020a05600c210c00b003fc0f9ca3e6mr4212889wml.9.1691865399959;
        Sat, 12 Aug 2023 11:36:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c114f00b003fe2bea77ccsm9127263wmz.5.2023.08.12.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 11:36:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3] gpio: sim: simplify code with cleanup helpers
Date:   Sat, 12 Aug 2023 20:36:35 +0200
Message-Id: <20230812183635.5478-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use macros defined in linux/cleanup.h to automate resource lifetime
control in gpio-sim.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v2 -> v3:
- use the non-scoped guard() in two more places where we can return the
  return value of snprintf() directly
- DON'T die on the hill of
  no-line-wrapping-for-the-price-of-more-temp-variables Andy :)

v1 -> v2:
- reorder code to return earlier from functions whenever possible, for
  instance when the last line is just returning a value from snprintf(),
  this saves us int ret; local variables
- tweak the commit message

 drivers/gpio/gpio-sim.c | 254 ++++++++++++++--------------------------
 1 file changed, 85 insertions(+), 169 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 0177b41e0d72..bb8fcf2a794c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
@@ -68,7 +69,7 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 	gc = &chip->gc;
 	desc = &gc->gpiodev->descs[offset];
 
-	mutex_lock(&chip->lock);
+	guard(mutex)(&chip->lock);
 
 	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
 	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
@@ -104,29 +105,24 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 
 set_pull:
 	__assign_bit(offset, chip->pull_map, value);
-	mutex_unlock(&chip->lock);
 	return 0;
 }
 
 static int gpio_sim_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
-	int ret;
 
-	mutex_lock(&chip->lock);
-	ret = !!test_bit(offset, chip->value_map);
-	mutex_unlock(&chip->lock);
+	guard(mutex)(&chip->lock);
 
-	return ret;
+	return !!test_bit(offset, chip->value_map);
 }
 
 static void gpio_sim_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__assign_bit(offset, chip->value_map, value);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		__assign_bit(offset, chip->value_map, value);
 }
 
 static int gpio_sim_get_multiple(struct gpio_chip *gc,
@@ -134,9 +130,8 @@ static int gpio_sim_get_multiple(struct gpio_chip *gc,
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	bitmap_replace(bits, bits, chip->value_map, mask, gc->ngpio);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		bitmap_replace(bits, bits, chip->value_map, mask, gc->ngpio);
 
 	return 0;
 }
@@ -146,9 +141,9 @@ static void gpio_sim_set_multiple(struct gpio_chip *gc,
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->ngpio);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		bitmap_replace(chip->value_map, chip->value_map, bits, mask,
+			       gc->ngpio);
 }
 
 static int gpio_sim_direction_output(struct gpio_chip *gc,
@@ -156,10 +151,10 @@ static int gpio_sim_direction_output(struct gpio_chip *gc,
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__clear_bit(offset, chip->direction_map);
-	__assign_bit(offset, chip->value_map, value);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock) {
+		__clear_bit(offset, chip->direction_map);
+		__assign_bit(offset, chip->value_map, value);
+	}
 
 	return 0;
 }
@@ -168,9 +163,8 @@ static int gpio_sim_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__set_bit(offset, chip->direction_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		__set_bit(offset, chip->direction_map);
 
 	return 0;
 }
@@ -180,9 +174,8 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 	int direction;
 
-	mutex_lock(&chip->lock);
-	direction = !!test_bit(offset, chip->direction_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		direction = !!test_bit(offset, chip->direction_map);
 
 	return direction ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
 }
@@ -215,9 +208,9 @@ static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	mutex_lock(&chip->lock);
-	__assign_bit(offset, chip->value_map, !!test_bit(offset, chip->pull_map));
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		__assign_bit(offset, chip->value_map,
+			     !!test_bit(offset, chip->pull_map));
 }
 
 static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
@@ -227,9 +220,8 @@ static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
 	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
 	int val;
 
-	mutex_lock(&chip->lock);
-	val = !!test_bit(line_attr->offset, chip->value_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		val = !!test_bit(line_attr->offset, chip->value_map);
 
 	return sysfs_emit(buf, "%d\n", val);
 }
@@ -258,9 +250,8 @@ static ssize_t gpio_sim_sysfs_pull_show(struct device *dev,
 	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
 	int pull;
 
-	mutex_lock(&chip->lock);
-	pull = !!test_bit(line_attr->offset, chip->pull_map);
-	mutex_unlock(&chip->lock);
+	scoped_guard(mutex, &chip->lock)
+		pull = !!test_bit(line_attr->offset, chip->pull_map);
 
 	return sysfs_emit(buf, "%s\n", gpio_sim_sysfs_pull_strings[pull]);
 }
@@ -659,17 +650,14 @@ static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
 {
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 	struct platform_device *pdev;
-	int ret;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
+
 	pdev = dev->pdev;
 	if (pdev)
-		ret = sprintf(page, "%s\n", dev_name(&pdev->dev));
-	else
-		ret = sprintf(page, "gpio-sim.%d\n", dev->id);
-	mutex_unlock(&dev->lock);
+		return sprintf(page, "%s\n", dev_name(&pdev->dev));
 
-	return ret;
+	return sprintf(page, "gpio-sim.%d\n", dev->id);
 }
 
 CONFIGFS_ATTR_RO(gpio_sim_device_config_, dev_name);
@@ -680,9 +668,8 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 	bool live;
 
-	mutex_lock(&dev->lock);
-	live = gpio_sim_device_is_live_unlocked(dev);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		live = gpio_sim_device_is_live_unlocked(dev);
 
 	return sprintf(page, "%c\n", live ? '1' : '0');
 }
@@ -837,8 +824,7 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 {
 	struct property_entry properties[GPIO_SIM_PROP_MAX];
 	unsigned int prop_idx = 0, line_names_size = 0;
-	struct fwnode_handle *swnode;
-	char **line_names;
+	char **line_names __free(kfree) = NULL;
 
 	memset(properties, 0, sizeof(properties));
 
@@ -857,9 +843,7 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 						"gpio-line-names",
 						line_names, line_names_size);
 
-	swnode = fwnode_create_software_node(properties, parent);
-	kfree(line_names);
-	return swnode;
+	return fwnode_create_software_node(properties, parent);
 }
 
 static void gpio_sim_remove_swnode_recursive(struct fwnode_handle *swnode)
@@ -984,7 +968,7 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	if (live == gpio_sim_device_is_live_unlocked(dev))
 		ret = -EPERM;
@@ -993,8 +977,6 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	else
 		gpio_sim_device_deactivate_unlocked(dev);
 
-	mutex_unlock(&dev->lock);
-
 	return ret ?: count;
 }
 
@@ -1031,17 +1013,14 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	struct gpio_sim_chip_name_ctx ctx = { bank->swnode, page };
-	int ret;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
+
 	if (gpio_sim_device_is_live_unlocked(dev))
-		ret = device_for_each_child(&dev->pdev->dev, &ctx,
-					    gpio_sim_emit_chip_name);
-	else
-		ret = sprintf(page, "none\n");
-	mutex_unlock(&dev->lock);
+		return device_for_each_child(&dev->pdev->dev, &ctx,
+					     gpio_sim_emit_chip_name);
 
-	return ret;
+	return sprintf(page, "none\n");
 }
 
 CONFIGFS_ATTR_RO(gpio_sim_bank_config_, chip_name);
@@ -1051,13 +1030,10 @@ gpio_sim_bank_config_label_show(struct config_item *item, char *page)
 {
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
-	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%s\n", bank->label ?: "");
-	mutex_unlock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	return ret;
+	return sprintf(page, "%s\n", bank->label ?: "");
 }
 
 static ssize_t gpio_sim_bank_config_label_store(struct config_item *item,
@@ -1067,23 +1043,18 @@ static ssize_t gpio_sim_bank_config_label_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	char *trimmed;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
+	if (!trimmed)
 		return -ENOMEM;
-	}
 
 	kfree(bank->label);
 	bank->label = trimmed;
 
-	mutex_unlock(&dev->lock);
 	return count;
 }
 
@@ -1094,13 +1065,10 @@ gpio_sim_bank_config_num_lines_show(struct config_item *item, char *page)
 {
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
-	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%u\n", bank->num_lines);
-	mutex_unlock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	return ret;
+	return sprintf(page, "%u\n", bank->num_lines);
 }
 
 static ssize_t
@@ -1119,16 +1087,13 @@ gpio_sim_bank_config_num_lines_store(struct config_item *item,
 	if (num_lines == 0)
 		return -EINVAL;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	bank->num_lines = num_lines;
 
-	mutex_unlock(&dev->lock);
 	return count;
 }
 
@@ -1146,13 +1111,10 @@ gpio_sim_line_config_name_show(struct config_item *item, char *page)
 {
 	struct gpio_sim_line *line = to_gpio_sim_line(item);
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
-	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%s\n", line->name ?: "");
-	mutex_unlock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	return ret;
+	return sprintf(page, "%s\n", line->name ?: "");
 }
 
 static ssize_t gpio_sim_line_config_name_store(struct config_item *item,
@@ -1162,24 +1124,18 @@ static ssize_t gpio_sim_line_config_name_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 	char *trimmed;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
+	if (!trimmed)
 		return -ENOMEM;
-	}
 
 	kfree(line->name);
 	line->name = trimmed;
 
-	mutex_unlock(&dev->lock);
-
 	return count;
 }
 
@@ -1195,13 +1151,10 @@ static ssize_t gpio_sim_hog_config_name_show(struct config_item *item,
 {
 	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
-	int ret;
 
-	mutex_lock(&dev->lock);
-	ret = sprintf(page, "%s\n", hog->name ?: "");
-	mutex_unlock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	return ret;
+	return sprintf(page, "%s\n", hog->name ?: "");
 }
 
 static ssize_t gpio_sim_hog_config_name_store(struct config_item *item,
@@ -1211,24 +1164,18 @@ static ssize_t gpio_sim_hog_config_name_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	char *trimmed;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
+	if (!trimmed)
 		return -ENOMEM;
-	}
 
 	kfree(hog->name);
 	hog->name = trimmed;
 
-	mutex_unlock(&dev->lock);
-
 	return count;
 }
 
@@ -1242,9 +1189,8 @@ static ssize_t gpio_sim_hog_config_direction_show(struct config_item *item,
 	char *repr;
 	int dir;
 
-	mutex_lock(&dev->lock);
-	dir = hog->dir;
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		dir = hog->dir;
 
 	switch (dir) {
 	case GPIOD_IN:
@@ -1273,12 +1219,10 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	int dir;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
-	}
 
 	if (sysfs_streq(page, "input"))
 		dir = GPIOD_IN;
@@ -1287,17 +1231,10 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 	else if (sysfs_streq(page, "output-low"))
 		dir = GPIOD_OUT_LOW;
 	else
-		dir = -EINVAL;
-
-	if (dir < 0) {
-		mutex_unlock(&dev->lock);
-		return dir;
-	}
+		return -EINVAL;
 
 	hog->dir = dir;
 
-	mutex_unlock(&dev->lock);
-
 	return count;
 }
 
@@ -1315,9 +1252,8 @@ static void gpio_sim_hog_config_item_release(struct config_item *item)
 	struct gpio_sim_line *line = hog->parent;
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 
-	mutex_lock(&dev->lock);
-	line->hog = NULL;
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		line->hog = NULL;
 
 	kfree(hog->name);
 	kfree(hog);
@@ -1343,13 +1279,11 @@ gpio_sim_line_config_make_hog_item(struct config_group *group, const char *name)
 	if (strcmp(name, "hog") != 0)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
 	hog = kzalloc(sizeof(*hog), GFP_KERNEL);
-	if (!hog) {
-		mutex_unlock(&dev->lock);
+	if (!hog)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	config_item_init_type_name(&hog->item, name,
 				   &gpio_sim_hog_config_type);
@@ -1359,8 +1293,6 @@ gpio_sim_line_config_make_hog_item(struct config_group *group, const char *name)
 	hog->parent = line;
 	line->hog = hog;
 
-	mutex_unlock(&dev->lock);
-
 	return &hog->item;
 }
 
@@ -1369,9 +1301,8 @@ static void gpio_sim_line_config_group_release(struct config_item *item)
 	struct gpio_sim_line *line = to_gpio_sim_line(item);
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 
-	mutex_lock(&dev->lock);
-	list_del(&line->siblings);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		list_del(&line->siblings);
 
 	kfree(line->name);
 	kfree(line);
@@ -1406,18 +1337,14 @@ gpio_sim_bank_config_make_line_group(struct config_group *group,
 	if (ret != 1 || nchar != strlen(name))
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return ERR_PTR(-EBUSY);
-	}
 
 	line = kzalloc(sizeof(*line), GFP_KERNEL);
-	if (!line) {
-		mutex_unlock(&dev->lock);
+	if (!line)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	config_group_init_type_name(&line->group, name,
 				    &gpio_sim_line_config_type);
@@ -1426,8 +1353,6 @@ gpio_sim_bank_config_make_line_group(struct config_group *group,
 	line->offset = offset;
 	list_add_tail(&line->siblings, &bank->line_list);
 
-	mutex_unlock(&dev->lock);
-
 	return &line->group;
 }
 
@@ -1436,9 +1361,8 @@ static void gpio_sim_bank_config_group_release(struct config_item *item)
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 
-	mutex_lock(&dev->lock);
-	list_del(&bank->siblings);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock)
+		list_del(&bank->siblings);
 
 	kfree(bank->label);
 	kfree(bank);
@@ -1466,18 +1390,14 @@ gpio_sim_device_config_make_bank_group(struct config_group *group,
 	struct gpio_sim_device *dev = to_gpio_sim_device(&group->cg_item);
 	struct gpio_sim_bank *bank;
 
-	mutex_lock(&dev->lock);
+	guard(mutex)(&dev->lock);
 
-	if (gpio_sim_device_is_live_unlocked(dev)) {
-		mutex_unlock(&dev->lock);
+	if (gpio_sim_device_is_live_unlocked(dev))
 		return ERR_PTR(-EBUSY);
-	}
 
 	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
-	if (!bank) {
-		mutex_unlock(&dev->lock);
+	if (!bank)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	config_group_init_type_name(&bank->group, name,
 				    &gpio_sim_bank_config_group_type);
@@ -1486,8 +1406,6 @@ gpio_sim_device_config_make_bank_group(struct config_group *group,
 	INIT_LIST_HEAD(&bank->line_list);
 	list_add_tail(&bank->siblings, &dev->bank_list);
 
-	mutex_unlock(&dev->lock);
-
 	return &bank->group;
 }
 
@@ -1495,10 +1413,10 @@ static void gpio_sim_device_config_group_release(struct config_item *item)
 {
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 
-	mutex_lock(&dev->lock);
-	if (gpio_sim_device_is_live_unlocked(dev))
-		gpio_sim_device_deactivate_unlocked(dev);
-	mutex_unlock(&dev->lock);
+	scoped_guard(mutex, &dev->lock) {
+		if (gpio_sim_device_is_live_unlocked(dev))
+			gpio_sim_device_deactivate_unlocked(dev);
+	}
 
 	mutex_destroy(&dev->lock);
 	ida_free(&gpio_sim_ida, dev->id);
@@ -1523,7 +1441,7 @@ static const struct config_item_type gpio_sim_device_config_group_type = {
 static struct config_group *
 gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 {
-	struct gpio_sim_device *dev;
+	struct gpio_sim_device *dev __free(kfree) = NULL;
 	int id;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1531,10 +1449,8 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	id = ida_alloc(&gpio_sim_ida, GFP_KERNEL);
-	if (id < 0) {
-		kfree(dev);
+	if (id < 0)
 		return ERR_PTR(id);
-	}
 
 	config_group_init_type_name(&dev->group, name,
 				    &gpio_sim_device_config_group_type);
@@ -1545,7 +1461,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 	dev->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
 	init_completion(&dev->probe_completion);
 
-	return &dev->group;
+	return &no_free_ptr(dev)->group;
 }
 
 static struct configfs_group_operations gpio_sim_config_group_ops = {
-- 
2.39.2

