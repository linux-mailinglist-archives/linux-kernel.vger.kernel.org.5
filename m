Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814A7FF0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjK3NrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbjK3Nqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2319F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so7714635e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352007; x=1701956807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1Jm7DZtmPUI+tkjKaFM9ATO3Ta/nvLDLxNBysClivQ=;
        b=rZ0hzX8DL/w4ofgdyAKw05NRnXAh3WfKF/i92JxrjSdCSEbeP20De8vn/ZyfI6qx7v
         /VOPVgXWnKDAVb0dujZBwXRnyRYc6FjdA92jeh0rL2TrPk2yWzySVk7T5EQja3HTzQN5
         LDIIvg3T//aNV0hNOYOkjQdaLWGfe3cuPLnqbT66h+LzaRmmU1CjvLquivalVyVwISzB
         4KedLcpic7A/6C8Nfl4SBaAnNxyyhDZlii0QwwukYc8JZthuO++wdVS9Q9Q3SspeyZXM
         vPEb34uuWqu5Of1ne7RyLjkG+kZMGnbt3ZpELSeKocsTZCciib7HMrJyeIky7Pz+HLOc
         0OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352007; x=1701956807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1Jm7DZtmPUI+tkjKaFM9ATO3Ta/nvLDLxNBysClivQ=;
        b=ab9OU/zq5Oxgzz0Ea/5daGw9arFrDhvHv7fRg65u+738ooz7bgG+hteDAW7XzTFtPX
         Rt4u5AN/de6WC0kYISumBpjpbOL2F8UAbTHB6eeLD2vXqM6szNA7GUL27faejF1zWi2N
         VmE7Plt5dff8axQizk//EvhEkSLWm/Pf287AzdHXFYefO2rp0F56N1yYzrin94ZxjWwy
         h0YnzAYtAoW8E951pYXcHSWD1W97YDkXE6jDwvJlzliP++2SftCFVfww52UeiLJc0Jo+
         nkYi9IPFHZL7PG8s8+ckrlGcYahoc305MZKL/OinKicd8TZ7oY/+VRQjMG7kWthF5Mni
         /ZxA==
X-Gm-Message-State: AOJu0YxoQSBkBePhUVC7A1IVylPgltLkcSpFDHdmY4MznwzXb8LRwcQL
        Dqj7qh5yXOjv3odRfnEB8NilPA==
X-Google-Smtp-Source: AGHT+IEAj1farO/m8WTaPZy/0DRdVPSgaZ/tTSVTZIibBXNvNig5A36Zldn7TIaNUdtS3M0Pnn/seQ==
X-Received: by 2002:adf:f283:0:b0:333:273f:1cd with SMTP id k3-20020adff283000000b00333273f01cdmr811971wro.36.1701352007562;
        Thu, 30 Nov 2023 05:46:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 10/10] gpiolib: remove gpiochip_is_requested()
Date:   Thu, 30 Nov 2023 14:46:30 +0100
Message-Id: <20231130134630.18198-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have no external users of gpiochip_is_requested(). Let's remove it
and replace its internal calls with direct testing of the REQUESTED flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 46 ++++++++++---------------------------
 include/linux/gpio/driver.h |  1 -
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8e932e6a6a8d..3070a4f7bbb1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1085,7 +1085,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	spin_lock_irqsave(&gpio_lock, flags);
 	for (i = 0; i < gdev->ngpio; i++) {
-		if (gpiochip_is_requested(gc, i))
+		if (test_bit(FLAG_REQUESTED, &gdev->descs[i].flags))
 			break;
 	}
 	spin_unlock_irqrestore(&gpio_lock, flags);
@@ -2373,33 +2373,6 @@ void gpiod_free(struct gpio_desc *desc)
 	gpio_device_put(desc->gdev);
 }
 
-/**
- * gpiochip_is_requested - return string iff signal was requested
- * @gc: controller managing the signal
- * @offset: of signal within controller's 0..(ngpio - 1) range
- *
- * Returns NULL if the GPIO is not currently requested, else a string.
- * The string returned is the label passed to gpio_request(); if none has been
- * passed it is a meaningless, non-NULL constant.
- *
- * This function is for use by GPIO controller drivers.  The label can
- * help with diagnostics, and knowing that the signal is used as a GPIO
- * can help avoid accidentally multiplexing it to another controller.
- */
-const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset)
-{
-	struct gpio_desc *desc;
-
-	desc = gpiochip_get_desc(gc, offset);
-	if (IS_ERR(desc))
-		return NULL;
-
-	if (test_bit(FLAG_REQUESTED, &desc->flags) == 0)
-		return NULL;
-	return desc->label;
-}
-EXPORT_SYMBOL_GPL(gpiochip_is_requested);
-
 /**
  * gpiochip_dup_line_label - Get a copy of the consumer label.
  * @gc: GPIO chip controlling this line.
@@ -2414,16 +2387,21 @@ EXPORT_SYMBOL_GPL(gpiochip_is_requested);
  */
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 {
-	const char *label;
+	struct gpio_desc *desc;
 	char *cpy;
 
-	label = gpiochip_is_requested(gc, offset);
-	if (!label)
+	desc = gpiochip_get_desc(gc, offset);
+	if (IS_ERR(desc))
 		return NULL;
 
-	cpy = kstrdup(label, GFP_KERNEL);
-	if (!cpy)
-		return ERR_PTR(-ENOMEM);
+	scoped_guard(spinlock_irqsave, &gpio_lock) {
+		if (!test_bit(FLAG_REQUESTED, &desc->flags))
+			return NULL;
+
+		cpy = kstrdup(desc->label, GFP_KERNEL);
+		if (!cpy)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	return cpy;
 }
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b1ed501e9ee0..9a44016789c8 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -531,7 +531,6 @@ struct gpio_chip {
 #endif /* CONFIG_OF_GPIO */
 };
 
-const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
 
 
-- 
2.40.1

