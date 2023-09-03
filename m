Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334F790DAD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbjICTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346545AbjICTR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:17:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147A098
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:17:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4018af103bcso4541235e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693768674; x=1694373474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RBewlV8Y3c6D5oogGIYUYf4bPTuckmkgGp46yjrg5k=;
        b=uXaBb4ETW7LpgKv6VNU9DQ7xudR7+FSPuiesvnZ+XlIMf6KerYCqWTnnB62sFKHuV/
         DgM5VsNfyCGSC8eU+DsfpEautCew4ZiRo/AeM3MQaTZfXysQsVBCoSB4XXMFO6SHYYv6
         3PgPElf4WOktYOQ591KuN/3ccAwDrWBcUb6CaINN/rRq8EfNHxM1CP/hQ1WRwYzCTNQ/
         2jID2lEUxwiafZ0bHNjsv53tgOpib0zinxQwwWBaA+xN1qwf8k9TOu2LgsotgWjN7ECH
         O0cLO/SDlPWYWKrO+QIBgud8GZQnhfzZT4WljV/TTzIiltPEqHdLw7+R4u15u0PMM8DF
         4XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693768674; x=1694373474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RBewlV8Y3c6D5oogGIYUYf4bPTuckmkgGp46yjrg5k=;
        b=OTUXxSrO4sJtmwh5C5StLjbi91ywYsoreJVBMyovODmeayZNOm8xNWsmCnphOdxRNp
         5skGP8z2EIhX5AWRO2nO1/84tBHfBakPDMRBkbyWBbij7r2ENL9wgJ3qw//Jde/VTy8B
         5im8g+V0WsF5wzXAoYIIRFQThCvQ73m5mL64l3s434HZPWlgS0fNtSOGaInasb/7CD5K
         hdFbT3diGIEdaYQFl7VQjzNQRzHoIgo0oejQh126JqioJYhCotUt61mqbyk6wyCIONGK
         FE5fgETE/h/XdCQgOYZwnhtwN94PC35AN5GsOrEActBs8ODllg2xOLanLDj+tU231unQ
         DJEQ==
X-Gm-Message-State: AOJu0YyhC4R1qjqIMF47Rs98B+MGcuGD69HtOWOqmNCkTAdvKjzx9RGz
        BhJ049AnT4PDSoGTAgscT8E7Zw==
X-Google-Smtp-Source: AGHT+IGbzmNX0V2BeY9RKGQICBQ4uxCHs/dWhNbpz842xXIAzUH/nOFiEPWZOuHbOeGVb01RCP2l0Q==
X-Received: by 2002:a05:600c:2286:b0:401:b3a5:ec04 with SMTP id 6-20020a05600c228600b00401b3a5ec04mr6132584wmf.16.1693768674204;
        Sun, 03 Sep 2023 12:17:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3591:d7b7:f0c6:6e52])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0aca00b003fc0505be19sm11846149wmr.37.2023.09.03.12.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 12:17:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpio: sim: don't fiddle with GPIOLIB private members
Date:   Sun,  3 Sep 2023 21:17:48 +0200
Message-Id: <20230903191748.12535-1-brgl@bgdev.pl>
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

We access internals of struct gpio_device and struct gpio_desc because
it's easier but it can actually be avoided and we're working towards a
better encapsulation of GPIO data structures across the kernel so let's
start at home.

Instead of checking gpio_desc flags, let's just track the requests of
GPIOs in the driver. We also already store the information about
direction of simulated lines.

For kobjects needed by sysfs callbacks: we can leverage the fact that
once created for a software node, struct device is accessible from that
fwnode_handle. We don't need to dereference gpio_device.

While at it: fix one line break and remove the untrue part about
configfs callbacks using dev_get_drvdata() from a comment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use get_dev_from_fwnode() instead of dereferencing fwnode directly

 drivers/gpio/gpio-sim.c | 65 +++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 271db3639a78..7796249f9058 100644
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
@@ -181,7 +177,7 @@ static int gpio_sim_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static int gpio_sim_set_config(struct gpio_chip *gc,
-				  unsigned int offset, unsigned long config)
+			       unsigned int offset, unsigned long config)
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
@@ -291,11 +299,18 @@ static void gpio_sim_dispose_mappings(void *data)
 		irq_dispose_mapping(irq_find_mapping(chip->irq_sim, i));
 }
 
+static void gpio_sim_put_chip_device(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static void gpio_sim_sysfs_remove(void *data)
 {
 	struct gpio_sim_chip *chip = data;
 
-	sysfs_remove_groups(&chip->gc.gpiodev->dev.kobj, chip->attr_groups);
+	sysfs_remove_groups(&chip->dev->kobj, chip->attr_groups);
 }
 
 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
@@ -352,8 +367,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 		chip->attr_groups[i] = attr_group;
 	}
 
-	ret = sysfs_create_groups(&chip->gc.gpiodev->dev.kobj,
-				  chip->attr_groups);
+	ret = sysfs_create_groups(&chip->dev->kobj, chip->attr_groups);
 	if (ret)
 		return ret;
 
@@ -387,6 +401,11 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip)
 		return -ENOMEM;
 
+
+	chip->request_map = devm_bitmap_zalloc(dev, num_lines, GFP_KERNEL);
+	if (!chip->request_map)
+		return -ENOMEM;
+
 	chip->direction_map = devm_bitmap_alloc(dev, num_lines, GFP_KERNEL);
 	if (!chip->direction_map)
 		return -ENOMEM;
@@ -432,6 +451,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->get_direction = gpio_sim_get_direction;
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
+	gc->request = gpio_sim_request;
 	gc->free = gpio_sim_free;
 	gc->can_sleep = true;
 
@@ -439,8 +459,17 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Used by sysfs and configfs callbacks. */
-	dev_set_drvdata(&gc->gpiodev->dev, chip);
+	chip->dev = get_dev_from_fwnode(swnode);
+	if (!chip->dev)
+		return -ENODEV;
+
+	ret = devm_add_action_or_reset(dev, gpio_sim_put_chip_device,
+				       chip->dev);
+	if (ret)
+		return ret;
+
+	/* Used by sysfs callbacks. */
+	dev_set_drvdata(chip->dev, chip);
 
 	return gpio_sim_setup_sysfs(chip);
 }
-- 
2.39.2

