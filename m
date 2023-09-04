Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0421A791722
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbjIDMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjIDMdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:33:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3601A7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:33:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so13747325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693830808; x=1694435608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQvLgCuAgqbziPJyI5AF10Ce3IdzqK5TyvrPpNOUCxQ=;
        b=pmh0iM6Ic7wbAnHbGU8j1qoZT9v0l8/4CsqZGSN3SdHPuSeP/r1hcDSTxvvpd60ibz
         9dr2H61GT0/FNb+hLdOI/Kl+fo4N6djej0lreu8eqrTi2ZpCEacPD/ugEwo+Ktddey71
         W3zyLlLGv3cXNpm4XhYHB7WgzyEj1jYE+AObxv8A8jUDrrvjI7Bg6lulUsRK6exYJ1fc
         FXMViW33G5NdAx7wvM2RcR148/2PuTIUMTAserXFSwl7KwrcoP89N6P/7cX6H8R2yE+w
         naFHxAfMVSn/+CAIxVHtgyxp3qkEwnbja/7wwTsmykkEk81jyV92UmStt6kJYYc6QC7W
         b9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693830808; x=1694435608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQvLgCuAgqbziPJyI5AF10Ce3IdzqK5TyvrPpNOUCxQ=;
        b=ZlTkO8bpvVjl1rtTMrG+kb8itMFMmYrdqVMhlTwDaO7p9AGr4HuNta8vi6YPmjXJNP
         JoCSBRaX0ES54FmMF+dlIfSLSeatZQYFP8dPDlhyvPcJwx2E2YLZoqsZBRe0jxJ8xHj2
         GcHHXyM3Chrt7dOj0MflRT84LaYjtEwVz1Oj8f6oQgvqRx4Ci37oBS5/HOXeToZvjU9s
         ikjwsr151pTzA6ZSEzUUUvsOX8KNUziGIdupojLw/XFJksO/O2ELNoi4D7TQ49yjvG9j
         9SzFO4l1UHclnIr8wrZ1sSN9n14MHOfS5rKtqPZDuox3kn4ICP2GpnMXqLqVj9cTQAUk
         40dA==
X-Gm-Message-State: AOJu0Yxxi4r8lQedpwbYDzXjwNujGQAmir3magYSWGVYbXT37gr3qwbg
        qGv59M/A6sj78lJ1w7+utLW/zQ==
X-Google-Smtp-Source: AGHT+IHVLkQLsjuX/lX2Jwzd6g9At3xYqiksd0MFKCcLfVDOApuXdlhZ2xpyZm74o48zpFztMZp+7w==
X-Received: by 2002:adf:f144:0:b0:31a:d6cb:7f9d with SMTP id y4-20020adff144000000b0031ad6cb7f9dmr6793726wro.24.1693830807807;
        Mon, 04 Sep 2023 05:33:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7663:60b7:3a19:b5c4])
        by smtp.gmail.com with ESMTPSA id q12-20020adffecc000000b00316eb7770b8sm14518255wrs.5.2023.09.04.05.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:33:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH] gpio: eic-sprd: use atomic notifiers to notify all chips about irqs
Date:   Mon,  4 Sep 2023 14:33:20 +0200
Message-Id: <20230904123320.93980-1-brgl@bgdev.pl>
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

Calling gpiochip_find() from interrupt handler in this driver is an
abuse of the GPIO API. It only happens to work because nobody added a
might_sleep() to it and the lock used by GPIOLIB is a spinlock.

Both will soon be changed as we're limiting both the number of
interfaces allowed to be called from atomic context as well as making
struct gpio_chip private to the GPIO code that owns it. We'll also
switch to protecting the global GPIO device list with a mutex as there
is no reason to allow changes to it from interrupt handlers.

Instead of iterating over all SPRD chips and looking up each
corresponding GPIO chip, let's make each SPRD GPIO controller register
with a notifier chain. The chain will be called at interrupt so that
every chip that already probed will be notified. The rest of the
interrupt handling remains the same. This should result in faster code as
we're avoiding iterating over the list of all GPIO devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
I only build-tested it. Please take it for a ride, I hope this works.

 drivers/gpio/gpio-eic-sprd.c | 44 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 5320cf1de89c..21a1afe358d6 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -91,12 +92,20 @@ enum sprd_eic_type {
 
 struct sprd_eic {
 	struct gpio_chip chip;
+	struct notifier_block irq_nb;
 	void __iomem *base[SPRD_EIC_MAX_BANK];
 	enum sprd_eic_type type;
 	spinlock_t lock;
 	int irq;
 };
 
+static ATOMIC_NOTIFIER_HEAD(sprd_eic_irq_notifier);
+
+static struct sprd_eic *to_sprd_eic(struct notifier_block *nb)
+{
+	return container_of(nb, struct sprd_eic, irq_nb);
+}
+
 struct sprd_eic_variant_data {
 	enum sprd_eic_type type;
 	u32 num_eics;
@@ -494,13 +503,6 @@ static void sprd_eic_toggle_trigger(struct gpio_chip *chip, unsigned int irq,
 	sprd_eic_irq_unmask(data);
 }
 
-static int sprd_eic_match_chip_by_type(struct gpio_chip *chip, void *data)
-{
-	enum sprd_eic_type type = *(enum sprd_eic_type *)data;
-
-	return !strcmp(chip->label, sprd_eic_label_name[type]);
-}
-
 static void sprd_eic_handle_one_type(struct gpio_chip *chip)
 {
 	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
@@ -546,27 +548,29 @@ static void sprd_eic_handle_one_type(struct gpio_chip *chip)
 static void sprd_eic_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *ic = irq_desc_get_chip(desc);
-	struct gpio_chip *chip;
-	enum sprd_eic_type type;
 
 	chained_irq_enter(ic, desc);
 
 	/*
 	 * Since the digital-chip EIC 4 sub-modules (debounce, latch, async
-	 * and sync) share one same interrupt line, we should iterate each
-	 * EIC module to check if there are EIC interrupts were triggered.
+	 * and sync) share one same interrupt line, we should notify all of
+	 * them to let them check if there are EIC interrupts were triggered.
 	 */
-	for (type = SPRD_EIC_DEBOUNCE; type < SPRD_EIC_MAX; type++) {
-		chip = gpiochip_find(&type, sprd_eic_match_chip_by_type);
-		if (!chip)
-			continue;
-
-		sprd_eic_handle_one_type(chip);
-	}
+	atomic_notifier_call_chain(&sprd_eic_irq_notifier, 0, NULL);
 
 	chained_irq_exit(ic, desc);
 }
 
+static int sprd_eic_irq_notify(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	struct sprd_eic *sprd_eic = to_sprd_eic(nb);
+
+	sprd_eic_handle_one_type(&sprd_eic->chip);
+
+	return NOTIFY_OK;
+}
+
 static const struct irq_chip sprd_eic_irq = {
 	.name		= "sprd-eic",
 	.irq_ack	= sprd_eic_irq_ack,
@@ -653,7 +657,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return 0;
+	sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
+	return atomic_notifier_chain_register(&sprd_eic_irq_notifier,
+					      &sprd_eic->irq_nb);
 }
 
 static const struct of_device_id sprd_eic_of_match[] = {
-- 
2.39.2

