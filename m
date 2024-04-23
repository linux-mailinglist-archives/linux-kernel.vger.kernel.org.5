Return-Path: <linux-kernel+bounces-155765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD588AF6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8708B22BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAB13F458;
	Tue, 23 Apr 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtsW7yGV"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730813E8BF;
	Tue, 23 Apr 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897981; cv=none; b=sSaDRjAAFT00BxILPCJSSKIjUBhKrqLrxxxAg1fBHJDuQIM9WWb6WPhTt18lboHfCqx7H+4yhEOnt92ai7b1n4btUr0VzoZ6egmU561ZorI4IOnV6qTk3GVr2jslOfaL0vgL9umwd8F1fy67sCtesAolzZ3ZzpjU0JQNeGs5T3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897981; c=relaxed/simple;
	bh=d/HyYNt+HcwR5qBTgkaDiIlU6r66mEwGYIlwSWKtMzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nm1cAqMusGsXoaaQalvedc/A/pSbjzfl5vM1NfZfosN45dbol+glLc1r6hH8lYd0coUt+fjqFJAE4NHtirJWwp5Bdp7euhVTYt20rRpFMicwi1Svcfban7p/QYv/lMii4IcQ6/FGGDVjqP0jBR06OepuWvDqhO3aMns74uXZ9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtsW7yGV; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70e46f3caso3542147b6e.2;
        Tue, 23 Apr 2024 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713897979; x=1714502779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MysULTgnN7k+Xud5MO2Zc39+JXGl3oEbD4FIUD15UgY=;
        b=dtsW7yGVOP9uUwYEQrYsk79M0NJHLR4GjaU/gxdw9C0ki2n5o04KmUjq7IuUcVGggd
         wZiu1E2VfP6Znb0/gj1KzFdHaGen7EXTD/yyLRMORmVIXIcvWzNhMUCduYd1yN6yZ+es
         6QiGpqYRHGEvPZlmh791BnrcT/8TolvaBJN/8KC4lVNbRc1aOHxdePkifUIVR4ibQwLv
         fLWjC9AveThJUVbwqAF5p1DPrdA4oWrKp7tVuoK/wfqxn37dNGS2HziLnmusgsSepfFt
         wFGivQVuQHlZ8K/S8NbNIf7x42zhQHYK586K6KVsllhQmHZ98X5cY+yathsSLuIyHiyd
         lC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713897979; x=1714502779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MysULTgnN7k+Xud5MO2Zc39+JXGl3oEbD4FIUD15UgY=;
        b=AfJQcRRaiZFmEl/ZnIZ9hA/NqKyrd35IXms7qVLPLzSnsngt6NgQLaBBRGiVIJHGcD
         7cFfw1ADsPL1Vz/JLg6S1k6jhKJyD/Lf9kAMfXZyOdmKogLl5iGxYiRkq2gYHLUvkece
         WqjkIoy7eTZJXaV7CDWdCv9QqeFRL2yxfiNrYmzfZasXms3wX0gD/aNX8wR6Q7da9+IX
         1NKzNkQz+cXand9XyMVhpEc2zut2xQRO3Jcskgzj5YLtjLW3MPE0u2ku8KPCttSG39ja
         oxym0++dMvytz/MdA0BxSDaKcec+NAI3aGclYaz4qiY40gd9jlBbLw6/4c+SQW0Oj9CT
         MY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdZabDMb7tjU8PFYx28jSO1qHIsNaAkTjM45G7u5mwa/MAKeQLFvKnGNx94Gxs0qOlMtstdXHKalU0ZUfuzCSk5DkPHDh2mqiYQUVtY6Intdq0awKTIh11ub8ydAT7kF8JfTpOwFLDGg==
X-Gm-Message-State: AOJu0YwfJ7CpXDj5oOStwrqwVwhXsAd8h2FRRufx9t7jWg3BIV5FnCEq
	+8KtFBT/H9oL/M35tu4nA9GCi+URusOd/l9CnwY/xxOOndoetrLX
X-Google-Smtp-Source: AGHT+IHVrjJnk12Cra/vApgCck0OQK7U/htDoLVGpch/iM6o+qAWkpg7ZBWU6UKE5uG8o5Oqw0+BUw==
X-Received: by 2002:a05:6808:14d1:b0:3c4:e208:b784 with SMTP id f17-20020a05680814d100b003c4e208b784mr227117oiw.27.1713897979242;
        Tue, 23 Apr 2024 11:46:19 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g7-20020a0ce4c7000000b0069b7aca529esm4214773qvm.14.2024.04.23.11.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:46:18 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH v2] gpio: brcmstb: Use dynamic GPIO base numbers
Date: Tue, 23 Apr 2024 11:46:05 -0700
Message-Id: <20240423184605.2094376-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forcing a gpiochip to have a fixed base number now leads to a warning
message. Remove the need to do so by using the offset value of the
gpiochip.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
change in v2:
  gc->base is already initialized to -1 by bgpio_init() so the
  redundant initialization in this driver was removed.

 drivers/gpio/gpio-brcmstb.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index a789af4a5c85..790cb278b72a 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -50,7 +50,6 @@ struct brcmstb_gpio_priv {
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	int parent_irq;
-	int gpio_base;
 	int num_gpios;
 	int parent_wake_irq;
 };
@@ -92,7 +91,7 @@ brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
 static int brcmstb_gpio_hwirq_to_offset(irq_hw_number_t hwirq,
 					struct brcmstb_gpio_bank *bank)
 {
-	return hwirq - (bank->gc.base - bank->parent_priv->gpio_base);
+	return hwirq - bank->gc.offset;
 }
 
 static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
@@ -118,7 +117,7 @@ static int brcmstb_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
 	/* gc_offset is relative to this gpio_chip; want real offset */
-	int hwirq = offset + (gc->base - priv->gpio_base);
+	int hwirq = offset + gc->offset;
 
 	if (hwirq >= priv->num_gpios)
 		return -ENXIO;
@@ -263,7 +262,7 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 {
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
 	struct irq_domain *domain = priv->irq_domain;
-	int hwbase = bank->gc.base - priv->gpio_base;
+	int hwbase = bank->gc.offset;
 	unsigned long status;
 
 	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
@@ -412,7 +411,7 @@ static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
 	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
 		return -EINVAL;
 
-	offset = gpiospec->args[0] - (gc->base - priv->gpio_base);
+	offset = gpiospec->args[0] - bank->gc.offset;
 	if (offset >= gc->ngpio || offset < 0)
 		return -EINVAL;
 
@@ -596,8 +595,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	const __be32 *p;
 	u32 bank_width;
 	int num_banks = 0;
+	int num_gpios = 0;
 	int err;
-	static int gpio_base;
 	unsigned long flags = 0;
 	bool need_wakeup_event = false;
 
@@ -611,7 +610,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-	priv->gpio_base = gpio_base;
 	priv->reg_base = reg_base;
 	priv->pdev = pdev;
 
@@ -651,7 +649,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			dev_dbg(dev, "Width 0 found: Empty bank @ %d\n",
 				num_banks);
 			num_banks++;
-			gpio_base += MAX_GPIO_PER_BANK;
+			num_gpios += MAX_GPIO_PER_BANK;
 			continue;
 		}
 
@@ -691,7 +689,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			err = -ENOMEM;
 			goto fail;
 		}
-		gc->base = gpio_base;
 		gc->of_gpio_n_cells = 2;
 		gc->of_xlate = brcmstb_gpio_of_xlate;
 		/* not all ngpio lines are valid, will use bank width later */
@@ -713,7 +710,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 					bank->id);
 			goto fail;
 		}
-		gpio_base += gc->ngpio;
+		num_gpios += gc->ngpio;
 
 		dev_dbg(dev, "bank=%d, base=%d, ngpio=%d, width=%d\n", bank->id,
 			gc->base, gc->ngpio, bank->width);
@@ -724,7 +721,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		num_banks++;
 	}
 
-	priv->num_gpios = gpio_base - priv->gpio_base;
+	priv->num_gpios = num_gpios;
 	if (priv->parent_irq > 0) {
 		err = brcmstb_gpio_irq_setup(pdev, priv);
 		if (err)
-- 
2.34.1


