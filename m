Return-Path: <linux-kernel+bounces-36774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8483A65A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112641C22E72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4EE182DA;
	Wed, 24 Jan 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YiDN0MLX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4A18627
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090773; cv=none; b=tBAt4ie2GS+sGZ+S6lDV7Yy3wlNp6yFFduR77HKClXSUpxf0Z6FJkF4edKQvkSz/LZEhA6sMHutl6DFIZ+f6auNk5TptlJo98rO2FIyPMHlblnz7CXzM7HTYrX8H45aJB51MOo7g33ddVOn8RIv1pBsb2Xpw1VAXQUxkHFICt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090773; c=relaxed/simple;
	bh=8Ax/Uoo3/XLfUjHoKDYZY5j6g/7lAxXQdhxsIo1C2EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h0PuxzEQUNZhrM+NZ4l+rd5mIQH8n2II3k/qSa21Ng0p/ofxTdW1vwipQ929gzobzpYtK162ZD5vq+0JKGAlTBnJjsuFKLunIdoIX0sV42U9rmxz774rWWY1HkIOrXYWNl2vFrbWmttXqknBzIyuMUeEoJq372gN3WMJFq5VQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YiDN0MLX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-338aca547d9so4240850f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706090769; x=1706695569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ZL/2lSpva4wbfacwvfZlkqpZ4glNpNOBF1JJbBQIs=;
        b=YiDN0MLXxK7kOAsDHOVKG70FticpiIWNuhXPXuVJgkW8RpKAnH+N1HVK1ATvUOGfSF
         DOhLnfcTJltLMrR6slzq985UdI1WOD6/XwSnRtmFiLfHIUsaJWWjYeki3Gs8l6jQ29YZ
         yjiL3gsPPG8zotktYLjtU58NOk9iB7yyebTxg+98zJg20mt6NzMP18Q+el8QB7+a5fvL
         JjBW/JEQfyHOoCW5p4HfFSOpMjiAmzsDXGKf0AONeJAS5Qd0deWxyDuW3c0EZjL/VpOF
         I3s+YysLyylDA92MRu5puXfeIRH0A5j5AjFKZdctMYjFriGF+nkUG2zgCTIArzCKW5Mb
         sx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090769; x=1706695569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8ZL/2lSpva4wbfacwvfZlkqpZ4glNpNOBF1JJbBQIs=;
        b=c34wxVTisj6BT1OcJ5ZT/RWSUuqqDHj2pqw+y80n9VmPuo7iYfzLgYVGa7xstt8rj7
         mxLGOFqDUoWfw9bbOVjCiTvvBTV/iCSYtxXZwg0u9RLpgno0RyauhKxJskiRdzHiaUcm
         tQLqgC64sw6iCPg9kRDuIrFZ6zCAzzU9yEgdQ3DaezvtCSIjX4Jnr0d2aMHw0aa+2+mg
         /hgp2ailqP6OsBE5PbJsttJzgvzOkUusMJs1yOoKSH3sa5k3LMmcA15uuYCWNZgZPCCX
         rtj41wJZyJzfo1Cnn9ltqzbiMTZ4UMeV3cEbMrblPw4D7BSj7VPEj9ae7CcNvtKjPB4J
         ndgA==
X-Gm-Message-State: AOJu0YyU1nLhVhxdiU6/HtzPJ8mMJe8KvqFVOBhq4QCzzWW5x+yyDqtS
	FriO4HIzdalBtPhOnLUyE6CHc9U5Y5ktpPTc7U9aAW00ef5uofMSqTdvQZx8aNEwBY9wU4oVVVd
	u
X-Google-Smtp-Source: AGHT+IHUexzrojnzjyp31biWMdZQVLr6Ap4bElk2KfCqHe+GPLzfetl5OZRlp7JcdXwLST2E1XjKHw==
X-Received: by 2002:a5d:5044:0:b0:337:bcb3:2c53 with SMTP id h4-20020a5d5044000000b00337bcb32c53mr181061wrt.226.1706090768993;
        Wed, 24 Jan 2024 02:06:08 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e737:cf8b:25f7:e0ad])
        by smtp.gmail.com with ESMTPSA id s8-20020adff808000000b0033905a60689sm13419064wrp.45.2024.01.24.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 02:06:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: unexport GPIO irq domain functions only used internally
Date: Wed, 24 Jan 2024 11:06:06 +0100
Message-Id: <20240124100606.22700-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no external users for the irq domain helpers so unexport them
and remove the prototypes from the driver header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 93 +++++++++++++++++--------------------
 include/linux/gpio/driver.h | 12 -----
 2 files changed, 42 insertions(+), 63 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 44c8f5743a24..d50a786f8176 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1254,8 +1254,8 @@ static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc)
 	gpiochip_free_mask(&gc->irq.valid_mask);
 }
 
-bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
-				unsigned int offset)
+static bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
+				       unsigned int offset)
 {
 	if (!gpiochip_line_is_valid(gc, offset))
 		return false;
@@ -1264,7 +1264,6 @@ bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
 		return true;
 	return test_bit(offset, gc->irq.valid_mask);
 }
-EXPORT_SYMBOL_GPL(gpiochip_irqchip_irq_valid);
 
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 
@@ -1439,6 +1438,43 @@ static unsigned int gpiochip_child_offset_to_irq_noop(struct gpio_chip *gc,
 	return offset;
 }
 
+/**
+ * gpiochip_irq_domain_activate() - Lock a GPIO to be used as an IRQ
+ * @domain: The IRQ domain used by this IRQ chip
+ * @data: Outermost irq_data associated with the IRQ
+ * @reserve: If set, only reserve an interrupt vector instead of assigning one
+ *
+ * This function is a wrapper that calls gpiochip_lock_as_irq() and is to be
+ * used as the activate function for the &struct irq_domain_ops. The host_data
+ * for the IRQ domain must be the &struct gpio_chip.
+ */
+static int gpiochip_irq_domain_activate(struct irq_domain *domain,
+					struct irq_data *data, bool reserve)
+{
+	struct gpio_chip *gc = domain->host_data;
+	unsigned int hwirq = irqd_to_hwirq(data);
+
+	return gpiochip_lock_as_irq(gc, hwirq);
+}
+
+/**
+ * gpiochip_irq_domain_deactivate() - Unlock a GPIO used as an IRQ
+ * @domain: The IRQ domain used by this IRQ chip
+ * @data: Outermost irq_data associated with the IRQ
+ *
+ * This function is a wrapper that will call gpiochip_unlock_as_irq() and is to
+ * be used as the deactivate function for the &struct irq_domain_ops. The
+ * host_data for the IRQ domain must be the &struct gpio_chip.
+ */
+static void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
+					   struct irq_data *data)
+{
+	struct gpio_chip *gc = domain->host_data;
+	unsigned int hwirq = irqd_to_hwirq(data);
+
+	return gpiochip_unlock_as_irq(gc, hwirq);
+}
+
 static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
 {
 	ops->activate = gpiochip_irq_domain_activate;
@@ -1556,7 +1592,8 @@ static bool gpiochip_hierarchy_is_hierarchical(struct gpio_chip *gc)
  * gpiochip by assigning the gpiochip as chip data, and using the irqchip
  * stored inside the gpiochip.
  */
-int gpiochip_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwirq)
+static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
+			    irq_hw_number_t hwirq)
 {
 	struct gpio_chip *gc = d->host_data;
 	int ret = 0;
@@ -1593,9 +1630,8 @@ int gpiochip_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwi
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(gpiochip_irq_map);
 
-void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq)
+static void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq)
 {
 	struct gpio_chip *gc = d->host_data;
 
@@ -1604,7 +1640,6 @@ void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq)
 	irq_set_chip_and_handler(irq, NULL, NULL);
 	irq_set_chip_data(irq, NULL);
 }
-EXPORT_SYMBOL_GPL(gpiochip_irq_unmap);
 
 static const struct irq_domain_ops gpiochip_domain_ops = {
 	.map	= gpiochip_irq_map,
@@ -1626,50 +1661,6 @@ static struct irq_domain *gpiochip_simple_create_domain(struct gpio_chip *gc)
 	return domain;
 }
 
-/*
- * TODO: move these activate/deactivate in under the hierarchicial
- * irqchip implementation as static once SPMI and SSBI (all external
- * users) are phased over.
- */
-/**
- * gpiochip_irq_domain_activate() - Lock a GPIO to be used as an IRQ
- * @domain: The IRQ domain used by this IRQ chip
- * @data: Outermost irq_data associated with the IRQ
- * @reserve: If set, only reserve an interrupt vector instead of assigning one
- *
- * This function is a wrapper that calls gpiochip_lock_as_irq() and is to be
- * used as the activate function for the &struct irq_domain_ops. The host_data
- * for the IRQ domain must be the &struct gpio_chip.
- */
-int gpiochip_irq_domain_activate(struct irq_domain *domain,
-				 struct irq_data *data, bool reserve)
-{
-	struct gpio_chip *gc = domain->host_data;
-	unsigned int hwirq = irqd_to_hwirq(data);
-
-	return gpiochip_lock_as_irq(gc, hwirq);
-}
-EXPORT_SYMBOL_GPL(gpiochip_irq_domain_activate);
-
-/**
- * gpiochip_irq_domain_deactivate() - Unlock a GPIO used as an IRQ
- * @domain: The IRQ domain used by this IRQ chip
- * @data: Outermost irq_data associated with the IRQ
- *
- * This function is a wrapper that will call gpiochip_unlock_as_irq() and is to
- * be used as the deactivate function for the &struct irq_domain_ops. The
- * host_data for the IRQ domain must be the &struct gpio_chip.
- */
-void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
-				    struct irq_data *data)
-{
-	struct gpio_chip *gc = domain->host_data;
-	unsigned int hwirq = irqd_to_hwirq(data);
-
-	return gpiochip_unlock_as_irq(gc, hwirq);
-}
-EXPORT_SYMBOL_GPL(gpiochip_irq_domain_deactivate);
-
 static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct irq_domain *domain = gc->irq.domain;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9a5c6c76e653..363d06c7b637 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -704,18 +704,6 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 #define BGPIOF_NO_OUTPUT		BIT(5) /* only input */
 #define BGPIOF_NO_SET_ON_INPUT		BIT(6)
 
-int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
-		     irq_hw_number_t hwirq);
-void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq);
-
-int gpiochip_irq_domain_activate(struct irq_domain *domain,
-				 struct irq_data *data, bool reserve);
-void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
-				    struct irq_data *data);
-
-bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
-				unsigned int offset);
-
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain);
-- 
2.40.1


