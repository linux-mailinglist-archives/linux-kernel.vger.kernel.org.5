Return-Path: <linux-kernel+bounces-158865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE48B25F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4965282DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2F14D6FD;
	Thu, 25 Apr 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuTNFvjo"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90714D290
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061035; cv=none; b=fEs4U4mMDfRakQ6Z+v8U2Fqsbtj8hXNrlB3LrbM1yB7Rl2H+Sxtfz6HEveidO6HCg65hsv6pQezg3XYbkRKWWYtv2T3JtLC7GsvnYuVFGxCjHzcV6qBHlwOo3ntEJtgONYda/FfS3YVNhMgi9Fmm/JcYv5x6Zp5M4PCcP5ittdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061035; c=relaxed/simple;
	bh=EGir2EDt2n1eyZpIdv4Fkr4bconE/1CQyWEMEYxiMZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IT1/PinKlbcGD9K7ja3L70EXukXXPrGPtfg1KI6D1nLGsAaOswacx8qXYSIYiNhH19M6fGfCHYqfbySJOJxQanjG21XNz9NqWeRqk3LYLqeAyPTjIOmHcz+1nF7i0MQCcuOmhW5zf1Pu6TBUyWkrF+hEYWp+sEQ1zPG9ibJdsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuTNFvjo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2100095e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714061031; x=1714665831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArRFcwbSGE5KriuGhAYuKxWGlaznKDFOE6RNc9h6uy8=;
        b=AuTNFvjoGrfXhTSdg+susdNWbxVsL5jxGAEyvN9EKJKZQba9pRdSNuK5ifFXqcmNnH
         QaRIHBhK25HvSe0brnoaU9TSgK/Bk/cc9Kh5wx1SkMkfNs8AFI3hC0ekfz3zAdx8J2iO
         E/Ok3aJzaALCFWReU2ABqQME0wv4BF6QQ0je6Pv3llahsAYdJlyeTMNUNrIuRmHhcZCo
         7TK9gluEzKyUi5zh2Xa+MRI1dyUOfdNhBQxvUkbcSfGA1Sdtx5Vxr0Y7PEQuVupyhSTP
         LJRIPy24EV9wtszFVuiV/H76ocz8xGIQAROD61uegTdle4wsIXLA+o87tv1isNiAyTIe
         uOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061031; x=1714665831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArRFcwbSGE5KriuGhAYuKxWGlaznKDFOE6RNc9h6uy8=;
        b=KKNnczxsKks6cp92iSIW3Hd0JgBuwisdfLHmudlTjNkljdUa3jwPCUe9qI9HAxkI7W
         YzyHLvoAlI7zTVpGb/NrZ1iS0dBa+HUY6NHNdv0KzAlIdCuYKnX8A8AZ7slFnsWmA1Rz
         AWmo66Qb8O3olflcRWu0uvW88cpzQcL21MqkwmKNimF7jeLjWB22uIb9x4TOEXJoxzlN
         lkOHTLtMmaJPIDklDs8cASS22stWOElt2M+19CEpTzjF3cOzeZZUHKhL+hoQDS4ASGnZ
         Oobj8eGEwLByOBXF4Ctd3zomERYk6NDsaxuCOCK5mqVKmPfq8a5SXppbSAUyBfbZO41d
         3QXA==
X-Forwarded-Encrypted: i=1; AJvYcCXY4jxZlksbmGI6yWwWbOjaydFHqdrfAuSIPYbTw8YgALLSRKg2DdD/ntT7FiS0/4Y92vWZMVCEY0Dn1cJaE4efMxXQDp3rCDhX/lI5
X-Gm-Message-State: AOJu0YxTa3VBwLLxbBUG+396LhyGN7lUueCwmsPf6Kfmj/Q6KUtj5CqF
	jjlvWmEZbphkBP4gOp/kVsFQ3Kxb8Bg34LT9o9cpfLXgdPQ1H8mBMTMmlmFPtDo=
X-Google-Smtp-Source: AGHT+IFNPQTMWqC6vi+FKfSqneB6UBtETV3r7joKdRzNgHGYkWkBtEvnWrq0n5MsCARUlaoZk6BbUQ==
X-Received: by 2002:a05:6512:3d0d:b0:51c:66fb:cda with SMTP id d13-20020a0565123d0d00b0051c66fb0cdamr2026971lfv.25.1714061031121;
        Thu, 25 Apr 2024 09:03:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a58a44a4419sm1329562ejb.57.2024.04.25.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:03:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 25 Apr 2024 17:03:32 +0100
Subject: [PATCH 2/2] pinctrl: samsung: support a bus clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240425-samsung-pinctrl-busclock-v1-2-898a200abe68@linaro.org>
References: <20240425-samsung-pinctrl-busclock-v1-0-898a200abe68@linaro.org>
In-Reply-To: <20240425-samsung-pinctrl-busclock-v1-0-898a200abe68@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

On some Samsung-based SoCs there are separate bus clocks / gates each
for each pinctrl instance. To be able to access each pinctrl instance's
registers, this bus clock needs to be running, otherwise register
access will hang. Google Tensor gs101 is one example for such an
implementation.

Update the driver to handle this optional bus clock:
* handle an optional bus clock from DT
* prepare it during driver probe
* enclose all relevant register accesses with a clock enable & disable

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 111 ++++++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c |  74 ++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.h |   2 +
 3 files changed, 187 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 871c1eb46ddf..857d631132f9 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -13,6 +13,7 @@
 // the Samsung pinctrl/gpiolib driver. It also includes the implementation of
 // external gpio and wakeup interrupt support.
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -61,6 +62,12 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	else
 		reg_mask = our_chip->eint_mask + bank->eint_offset;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for masking IRQ\n");
+		return;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -68,6 +75,8 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	writel(mask, bank->eint_base + reg_mask);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 static void exynos_irq_ack(struct irq_data *irqd)
@@ -82,7 +91,15 @@ static void exynos_irq_ack(struct irq_data *irqd)
 	else
 		reg_pend = our_chip->eint_pend + bank->eint_offset;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock to ack IRQ\n");
+		return;
+	}
+
 	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 static void exynos_irq_unmask(struct irq_data *irqd)
@@ -110,6 +127,12 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	else
 		reg_mask = our_chip->eint_mask + bank->eint_offset;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for unmasking IRQ\n");
+		return;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -117,6 +140,8 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	writel(mask, bank->eint_base + reg_mask);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
@@ -127,6 +152,7 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned int con, trig_type;
 	unsigned long reg_con;
+	int ret;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -159,11 +185,20 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	else
 		reg_con = our_chip->eint_con + bank->eint_offset;
 
+	ret = clk_enable(bank->drvdata->pclk);
+	if (ret) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for configuring IRQ type\n");
+		return ret;
+	}
+
 	con = readl(bank->eint_base + reg_con);
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
 	writel(con, bank->eint_base + reg_con);
 
+	clk_disable(bank->drvdata->pclk);
+
 	return 0;
 }
 
@@ -200,6 +235,14 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
 	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
+	ret = clk_enable(bank->drvdata->pclk);
+	if (ret) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for configuring pin %s-%lu\n",
+			bank->name, irqd->hwirq);
+		return ret;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	con = readl(bank->pctl_base + reg_con);
@@ -209,6 +252,8 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
+	clk_disable(bank->drvdata->pclk);
+
 	return 0;
 }
 
@@ -223,6 +268,13 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
 	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for deconfiguring pin %s-%lu\n",
+			bank->name, irqd->hwirq);
+		return;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	con = readl(bank->pctl_base + reg_con);
@@ -232,6 +284,8 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
+	clk_disable(bank->drvdata->pclk);
+
 	gpiochip_unlock_as_irq(&bank->gpio_chip, irqd->hwirq);
 }
 
@@ -281,10 +335,19 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	unsigned int svc, group, pin;
 	int ret;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for handling IRQ\n");
+		return IRQ_NONE;
+	}
+
 	if (bank->eint_con_offset)
 		svc = readl(bank->eint_base + EXYNOSAUTO_SVC_OFFSET);
 	else
 		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
+
+	clk_disable(bank->drvdata->pclk);
+
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -563,6 +626,19 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
+	/* just enable the clock once here, to avoid an enable/disable dance for
+	 * each bank.
+	 */
+	if (eintd->nr_banks) {
+		struct samsung_pin_bank *b = eintd->banks[0];
+
+		if (clk_enable(b->drvdata->pclk)) {
+			dev_err(b->gpio_chip.parent,
+				"unable to enable clock for pending IRQs\n");
+			return;
+		}
+	}
+
 	for (i = 0; i < eintd->nr_banks; ++i) {
 		struct samsung_pin_bank *b = eintd->banks[i];
 		pend = readl(b->eint_base + b->irq_chip->eint_pend
@@ -572,6 +648,9 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
 
+	if (eintd->nr_banks)
+		clk_disable(eintd->banks[0]->drvdata->pclk);
+
 	chained_irq_exit(chip, desc);
 }
 
@@ -695,6 +774,12 @@ static void exynos_pinctrl_suspend_bank(
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	const void __iomem *regs = bank->eint_base;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for saving state\n");
+		return;
+	}
+
 	save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
 						+ bank->eint_offset);
 	save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
@@ -704,6 +789,8 @@ static void exynos_pinctrl_suspend_bank(
 	save->eint_mask = readl(regs + bank->irq_chip->eint_mask
 						+ bank->eint_offset);
 
+	clk_disable(bank->drvdata->pclk);
+
 	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
 	pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltcon0);
 	pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
@@ -716,9 +803,17 @@ static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drv
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	const void __iomem *regs = bank->eint_base;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for saving state\n");
+		return;
+	}
+
 	save->eint_con = readl(regs + bank->pctl_offset + bank->eint_con_offset);
 	save->eint_mask = readl(regs + bank->pctl_offset + bank->eint_mask_offset);
 
+	clk_disable(bank->drvdata->pclk);
+
 	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
 	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
@@ -753,6 +848,12 @@ static void exynos_pinctrl_resume_bank(
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	void __iomem *regs = bank->eint_base;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for restoring state\n");
+		return;
+	}
+
 	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
 			readl(regs + EXYNOS_GPIO_ECON_OFFSET
 			+ bank->eint_offset), save->eint_con);
@@ -774,6 +875,8 @@ static void exynos_pinctrl_resume_bank(
 						+ 2 * bank->eint_offset + 4);
 	writel(save->eint_mask, regs + bank->irq_chip->eint_mask
 						+ bank->eint_offset);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
@@ -782,6 +885,12 @@ static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvd
 	struct exynos_eint_gpio_save *save = bank->soc_priv;
 	void __iomem *regs = bank->eint_base;
 
+	if (clk_enable(bank->drvdata->pclk)) {
+		dev_err(bank->gpio_chip.parent,
+			"unable to enable clock for restoring state\n");
+		return;
+	}
+
 	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
 		 readl(regs + bank->pctl_offset + bank->eint_con_offset), save->eint_con);
 	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
@@ -789,6 +898,8 @@ static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvd
 
 	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
 	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ed07e23e0912..8e4742d3655c 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -15,6 +15,7 @@
 // but provides extensions to which platform specific implementation of the gpio
 // and wakeup interrupts can be hooked to.
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
@@ -397,6 +398,11 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 		reg += 4;
 	}
 
+	if (clk_enable(drvdata->pclk)) {
+		dev_err(pctldev->dev, "failed to enable clock for setup\n");
+		return;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_FUNC]);
@@ -405,6 +411,8 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	writel(data, reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	clk_disable(drvdata->pclk);
 }
 
 /* enable a specified pinmux by writing to registers */
@@ -436,6 +444,7 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	u32 data, width, pin_offset, mask, shift;
 	u32 cfg_value, cfg_reg;
 	unsigned long flags;
+	int ret;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 	pin_to_reg_bank(drvdata, pin, &reg_base, &pin_offset, &bank);
@@ -447,6 +456,12 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	width = type->fld_width[cfg_type];
 	cfg_reg = type->reg_offset[cfg_type];
 
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return ret;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = (1 << width) - 1;
@@ -466,6 +481,8 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
+	clk_disable(drvdata->pclk);
+
 	return 0;
 }
 
@@ -539,16 +556,24 @@ static void samsung_gpio_set_value(struct gpio_chip *gc,
 {
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
 	const struct samsung_pin_bank_type *type = bank->type;
+	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
 	void __iomem *reg;
 	u32 data;
 
 	reg = bank->pctl_base + bank->pctl_offset;
 
+	if (clk_enable(drvdata->pclk)) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return;
+	}
+
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data &= ~(1 << offset);
 	if (value)
 		data |= 1 << offset;
 	writel(data, reg + type->reg_offset[PINCFG_TYPE_DAT]);
+
+	clk_disable(drvdata->pclk);
 }
 
 /* gpiolib gpio_set callback function */
@@ -569,12 +594,23 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
 	u32 data;
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
 	const struct samsung_pin_bank_type *type = bank->type;
+	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
+	int ret;
 
 	reg = bank->pctl_base + bank->pctl_offset;
 
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return ret;
+	}
+
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
 	data >>= offset;
 	data &= 1;
+
+	clk_disable(drvdata->pclk);
+
 	return data;
 }
 
@@ -591,9 +627,12 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	struct samsung_pin_bank *bank;
 	void __iomem *reg;
 	u32 data, mask, shift;
+	struct samsung_pinctrl_drv_data *drvdata;
+	int ret;
 
 	bank = gpiochip_get_data(gc);
 	type = bank->type;
+	drvdata = bank->drvdata;
 
 	reg = bank->pctl_base + bank->pctl_offset
 			+ type->reg_offset[PINCFG_TYPE_FUNC];
@@ -606,12 +645,20 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 		reg += 4;
 	}
 
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return ret;
+	}
+
 	data = readl(reg);
 	data &= ~(mask << shift);
 	if (!input)
 		data |= PIN_CON_FUNC_OUTPUT << shift;
 	writel(data, reg);
 
+	clk_disable(drvdata->pclk);
+
 	return 0;
 }
 
@@ -1164,6 +1211,12 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 		}
 	}
 
+	drvdata->pclk = devm_clk_get_optional_prepared(dev, "pclk");
+	if (IS_ERR(drvdata->pclk)) {
+		ret = PTR_ERR(drvdata->pclk);
+		goto err_put_banks;
+	}
+
 	ret = samsung_pinctrl_register(pdev, drvdata);
 	if (ret)
 		goto err_put_banks;
@@ -1202,6 +1255,13 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
 	int i;
 
+	i = clk_enable(drvdata->pclk);
+	if (i) {
+		dev_err(drvdata->dev,
+			"failed to enable clock for saving state\n");
+		return i;
+	}
+
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
 		const void __iomem *reg = bank->pctl_base + bank->pctl_offset;
@@ -1231,6 +1291,8 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 		}
 	}
 
+	clk_disable(drvdata->pclk);
+
 	if (drvdata->suspend)
 		drvdata->suspend(drvdata);
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
@@ -1252,6 +1314,16 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
 	int i;
 
+	/* enable clock before the callback, as we don't want to have to deal
+	 * with callback cleanup on clock failures.
+	 */
+	i = clk_enable(drvdata->pclk);
+	if (i) {
+		dev_err(drvdata->dev,
+			"failed to enable clock for restoring state\n");
+		return i;
+	}
+
 	if (drvdata->resume)
 		drvdata->resume(drvdata);
 
@@ -1286,6 +1358,8 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 				writel(bank->pm_save[type], reg + offs[type]);
 	}
 
+	clk_disable(drvdata->pclk);
+
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
 		drvdata->retention_ctrl->disable(drvdata);
 
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index ab791afaabf5..d50ba6f07d5d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -274,6 +274,7 @@ struct samsung_pin_ctrl {
  *             through samsung_pinctrl_drv_data, not samsung_pin_bank).
  * @dev: device instance representing the controller.
  * @irq: interrpt number used by the controller to notify gpio interrupts.
+ * @pclk: optional bus clock if required for accessing registers
  * @ctrl: pin controller instance managed by the driver.
  * @pctl: pin controller descriptor registered with the pinctrl subsystem.
  * @pctl_dev: cookie representing pinctrl device instance.
@@ -293,6 +294,7 @@ struct samsung_pinctrl_drv_data {
 	void __iomem			*virt_base;
 	struct device			*dev;
 	int				irq;
+	struct clk			*pclk;
 
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;

-- 
2.44.0.769.g3c40516874-goog


