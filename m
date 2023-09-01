Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F278FC54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349185AbjIALfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjIALfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:35:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A64E6A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:35:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1510553f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693568101; x=1694172901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sn2hopd/vHdrz3washcDfZoqKLaXsbWw0ndK3AZCoEw=;
        b=KYRayzv6dJqE6/eE1RGi0tmNs/OQY+NygmA7k5Qis+POZAF7WN8os+SXfN20qCMATh
         xiElM6WYT7Rf8FGmJHU0ipUE0cShTzvdg+S8g8+PzU8E5BsD/IXEio/BkL6S3evcEqcv
         dQZNz3DtjR5Aq43Pp4wQE+BLfHZreCRlYXie0iR8xMRaJL8HsVbygbt1b7A3wmn2IsgG
         vD5MF2irSCb1h45OlmIUuLDVhRLz7KLK9GvsGbFcAXKVJ+JrHfdJTFUnDWHxOOk2jm+N
         bZfB9HUP1NURtwnqDYAOtwRbbk2pTQT0jpisR6SWFK33K/4wgZUTnpS/IblrVrzZJpMA
         VGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568101; x=1694172901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sn2hopd/vHdrz3washcDfZoqKLaXsbWw0ndK3AZCoEw=;
        b=EQy1Sdji6JT5woreewYRy6obWESq2F7qICl42MpzoAg8avqrJKyfKJPJ7PwqOJCHMe
         Kvzo86BmsTra6wU5X0UxfUG+nU7jbRUfWxKnCmIk//NoZ8SrGpkX8sjzYn+ijECK9DvF
         bOjtyK0vJwo89vg7mpG8RQw9UlgjAGa/7XZqZZs28LLQINOfEd4bvuMlEb+rmk8hQgz8
         GlR+nJmqpOClZ+sbRg7DWlrKFeKJn7g18eCAWD0/YsoqmSiFg4S0BA4h5M5J/39Ailrd
         WkiRv+6hGa3cYs/SfA1NJbb8KT1BzfHxu3u40sdgoqWSOGI/9vqbbBJvSkUYrpbaLLR9
         sZPA==
X-Gm-Message-State: AOJu0YzhDUMCWJoQdnlFiILq4SGrsSHt9H39e62vopx6MAFLIFLakSZA
        LFu/1w9704W4nvoaaIbOJ3xXBinRgTsEVxXMQJg=
X-Google-Smtp-Source: AGHT+IEAM3VboZXhGAqxp7c2Psf1dj5N5/gDxIrBdURo4sjWBiuDofrb1E8RzVvJfw1PV81StCvwbQ==
X-Received: by 2002:adf:fa90:0:b0:317:5a3c:ed28 with SMTP id h16-20020adffa90000000b003175a3ced28mr1684183wrr.6.1693568101268;
        Fri, 01 Sep 2023 04:35:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e94b:1054:6760:aa27])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d4985000000b00319779ee691sm4928700wrq.28.2023.09.01.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:35:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: remove unnecessary extern specifiers from the driver header
Date:   Fri,  1 Sep 2023 13:34:58 +0200
Message-Id: <20230901113458.13323-1-brgl@bgdev.pl>
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

'extern' doesn't do anything for function declarations. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 8fc3ceffcbe9..c312bf3e0369 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -529,8 +529,7 @@ struct gpio_chip {
 #endif /* CONFIG_OF_GPIO */
 };
 
-extern const char *gpiochip_is_requested(struct gpio_chip *gc,
-			unsigned int offset);
+const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
 
 /**
  * for_each_requested_gpio_in_range - iterates over requested GPIOs in a given range
@@ -549,9 +548,9 @@ extern const char *gpiochip_is_requested(struct gpio_chip *gc,
 	for_each_requested_gpio_in_range(chip, i, 0, chip->ngpio, label)
 
 /* add/remove chips */
-extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
-				      struct lock_class_key *lock_key,
-				      struct lock_class_key *request_key);
+int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
+			       struct lock_class_key *lock_key,
+			       struct lock_class_key *request_key);
 
 /**
  * gpiochip_add_data() - register a gpio_chip
@@ -599,13 +598,13 @@ static inline int gpiochip_add(struct gpio_chip *gc)
 {
 	return gpiochip_add_data(gc, NULL);
 }
-extern void gpiochip_remove(struct gpio_chip *gc);
-extern int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc, void *data,
-					   struct lock_class_key *lock_key,
-					   struct lock_class_key *request_key);
+void gpiochip_remove(struct gpio_chip *gc);
+int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
+				    void *data, struct lock_class_key *lock_key,
+				    struct lock_class_key *request_key);
 
-extern struct gpio_chip *gpiochip_find(void *data,
-			      int (*match)(struct gpio_chip *gc, void *data));
+struct gpio_chip *gpiochip_find(void *data,
+				int (*match)(struct gpio_chip *gc, void *data));
 
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

