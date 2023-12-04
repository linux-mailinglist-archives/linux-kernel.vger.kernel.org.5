Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1015E802E39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjLDI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjLDI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:57:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CA8F3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:57:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso11970915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701680251; x=1702285051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmguLwHno4+ep63d/2yDufPK8h00mOPzfPbypUQQUes=;
        b=wm+D+Cr/2hpPZaNmEgfm7IBMJ5KbbNRgF4Ed85HacNnpJ+sJiYSUL9kURrJYzDBnF+
         hDDhV3IgKdjuWg+8mR/9lCtJyg5jVbeLqhB9qyx/XGfy9uw071xkAzM2UlAvrpEPDVZN
         Ih7+v0CjRjLgMp6Rx8xZVZWtZIzcgCImL7H8bXOXhdgwl6bwZCSPpFjStL00XhXmxb0/
         EhU3hZCVEZX7p8rlUC1WrSLRpsakbAGoDmXOaWSPMaK3svmQUdiTFSk1RL9oESNKTNJF
         YyApPX0FFnkOKsPIZcPYBVqe90ZXasTdOdJtnkJIPgCsBe7ADp18Tk4lC+OoTHU7BlHW
         4S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680251; x=1702285051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmguLwHno4+ep63d/2yDufPK8h00mOPzfPbypUQQUes=;
        b=QpOfHOrBAaLg2fzrgSC8HVQzWmnrmUU46y+BP9weZKPBC/mEfcsXXA5uRBjWUbsoHc
         b2ViHXwH4fJDmv9L6SE988bn5lK6lN00fxz0YeNCMIkY0LqTI4GbiNqQp9O6/92WmTtB
         C6H886qUloz0PdHa5KsYzjXPKq/NUmaF6TjGuU1nEtRa21KEoOZ3iHCk7RXEpxd46mke
         wm318k657RsA0cFjr0jiQALUU1uKTZXwFvLb66/TK4tvhxkppm1aubAdGAJN6DR5MDQY
         qcifsvz6o7NfCn6scW6P14vhORYOIQYmD4O5Mci3Qev1I+C4CGGvPr+7j2R97sWdP8Ir
         OQCQ==
X-Gm-Message-State: AOJu0YyG6k4wflT/0EbBqoZALsYnFmwdDmLbEpQvmFYZ88wZMVhmj16E
        4m/oajHzR131V+O8iCL34YiMzw==
X-Google-Smtp-Source: AGHT+IGlHrnh/zRPQHg5kwgbA5JDhMx75IzN2GwOeCmQhdS3AylUMLuQ9R6672yKnucAuT2owNf8kw==
X-Received: by 2002:a05:600c:3503:b0:40b:4b93:a369 with SMTP id h3-20020a05600c350300b0040b4b93a369mr2268142wmq.14.1701680251485;
        Mon, 04 Dec 2023 00:57:31 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0040b33222a39sm17959138wmq.45.2023.12.04.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:57:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpio: sim: implement the dbg_show() callback
Date:   Mon,  4 Dec 2023 09:57:19 +0100
Message-Id: <20231204085719.17928-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a custom implementation of the dbg_show() callback that prints
all requested lines together with their label, direction, value and
bias. This improves the code coverage of GPIOLIB.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use PTR_IF() instead of #ifdef

 drivers/gpio/gpio-sim.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 1928209491e1..49c3e51bf8e4 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
@@ -28,6 +29,7 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_helpers.h>
@@ -224,6 +226,25 @@ static void gpio_sim_free(struct gpio_chip *gc, unsigned int offset)
 	}
 }
 
+static void gpio_sim_dbg_show(struct seq_file *seq, struct gpio_chip *gc)
+{
+	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
+	const char *label;
+	int i;
+
+	guard(mutex)(&chip->lock);
+
+	for_each_requested_gpio(gc, i, label)
+		seq_printf(seq, " gpio-%-3d (%s) %s,%s\n",
+			   gc->base + i,
+			   label,
+			   test_bit(i, chip->direction_map) ? "input" :
+				test_bit(i, chip->value_map) ? "output-high" :
+							       "output-low",
+			   test_bit(i, chip->pull_map) ? "pull-up" :
+							 "pull-down");
+}
+
 static ssize_t gpio_sim_sysfs_val_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
@@ -460,6 +481,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->to_irq = gpio_sim_to_irq;
 	gc->request = gpio_sim_request;
 	gc->free = gpio_sim_free;
+	gc->dbg_show = PTR_IF(IS_ENABLED(CONFIG_DEBUG_FS), gpio_sim_dbg_show);
 	gc->can_sleep = true;
 
 	ret = devm_gpiochip_add_data(dev, gc, chip);
-- 
2.40.1

