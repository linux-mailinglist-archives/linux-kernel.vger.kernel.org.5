Return-Path: <linux-kernel+bounces-160053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9B8B3867
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25F61F234FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9EB14831E;
	Fri, 26 Apr 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqAK+lx5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4A147C63
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137946; cv=none; b=U+z03kCWNjpC9pzSZicPCo5PmA3Qn4DZpf4O4fTWnFFCIkqhX5tfNAKg/LqflXMbWQoZnKzmN9wmzctcizzAGQZ/Jt2Cno3N2Lm4UCia3k5kvKqjJbmc8rrCDOY0PAk7ZXaR/J00fZ0cbGicoTlJxoWoFc9U675R1Fd5BtDHeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137946; c=relaxed/simple;
	bh=mwFsyIFVInmmVw0ifFWX9WCQpqskJD34qrtcrTlVpKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+pKLbi/rH0pDIr033zExLe5McrjPQ2dGPyGTTKOid52feJ0c0oSaxPkzSlEdR2wRG5lMk0NBeykeRv1DVYG8WGgqY9It/2LM2uX3yvidiESvudhtm2rY5n8vRmeEXq3/4uNLsK3cp3byhpp5ZfBWtvy+NpOjtJJ5H0WZ9I96mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sqAK+lx5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso2618269a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714137942; x=1714742742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9Qwvd6hs9zicHZIfahxQLk96QTDqsG31aYfRw5jOvY=;
        b=sqAK+lx5QTXDbkCWgBiUFXt59GJBK8C6nUSV+xzH/VyNQ8fEIWlWu0KaQD7VaNwWpK
         NxoER47RFk6GlYsCg4Gz70MbP678DnMY2YNIc1CFRmJprZzkKhbY2GVHuRjNSfG/h4ME
         34q0HFThmrC8rYn8PUd2MFUGLX1nc9aOvot1vuV9joT2TR2HN8obSY+Mxnna9d5pUznL
         CXBwgSVrmXjpWlggyxq8aMIc6NB4J4Xs4v/U2j2MT1LABDcVEMRRcPS122R8DJz/cIwr
         iKDNTD/qtLp73Gs+7bPCjnjqIUNThcay0YWtdDyV0ZuXlM82eMEQ3BeR7NsWL27KQawb
         YyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137942; x=1714742742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9Qwvd6hs9zicHZIfahxQLk96QTDqsG31aYfRw5jOvY=;
        b=lnKoymEobr9o5wet86oe/Qo+XR1L7WqnBFr8ZwRVIuEPU0jugomGXl38nJYE0krsjp
         09dxDhpz9a8JIaAKZ3HIJiitoc+6CYMLkUTTkfnRJ76mymiL/4Tz0xJ4v34/ZVaoHJWW
         uSmLUqXSAesU0TEKlvJ/7faBldN4zmRS7DiB0CP5QBJX5uVaKKIdvWAuECoPRowBNyHI
         WwaXZB0FkYitwpvzFaFofwuvjNd4q8MPKciG432NRKKEJqeK9DiXjM0fABE2bLoc+ZiX
         f+fMtdAaiAwsMAeecsXuEF6UaWF/zVMlFEEGIfg/wkllrkQTp1OqNzjJbo1K8h1zL/EF
         +Jng==
X-Forwarded-Encrypted: i=1; AJvYcCU12jVHYi19B/6iKfvOHljVTe+FT/7Y3jgw3KZygbm8rNWdCedAcgLYnxQj65VEssMUXq+R4O6cDNyti7+PnwzGoq+rAe+HN/4JQFqJ
X-Gm-Message-State: AOJu0Yw4q4hm/FY6LsS7yP7b2r7iSLXxfsm4VNDY/XUuZ5SKhxVf9XpE
	aFUEANIkzg12spuHa5S5nzCHmEa6NGrCVEMIi3aOpHgM1EUojH2d7r2TB6SmYfM=
X-Google-Smtp-Source: AGHT+IFPgQrAIUQP20yEu4oO7js9vKFb4DNMdww69vNskf8NztZKPbb+J0sFVmxmMre3HcBA1Sw7gw==
X-Received: by 2002:a50:cd15:0:b0:56e:64a:2a47 with SMTP id z21-20020a50cd15000000b0056e064a2a47mr1787949edi.42.1714137942138;
        Fri, 26 Apr 2024 06:25:42 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id q25-20020aa7cc19000000b0057203242f31sm6187837edt.11.2024.04.26.06.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:25:41 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 26 Apr 2024 14:25:15 +0100
Subject: [PATCH v3 2/2] pinctrl: samsung: support a bus clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-samsung-pinctrl-busclock-v3-2-adb8664b8a7e@linaro.org>
References: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
In-Reply-To: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
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
v2:
- propagate clk_enable() errors in samsung_pinmux_setup(), i.e.
  struct pinmux_ops::set_mux()
- move clk_enable()/disable() outside bank->slock lock, to avoid
  possible deadlocks due to locking inversion
- fix some comments
- use 'ret' instead of 'i' in samsung_pinctrl_resume()
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 112 ++++++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c |  95 ++++++++++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h |   2 +
 3 files changed, 206 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 871c1eb46ddf..ce5e6783b5b9 100644
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
 
@@ -563,6 +626,20 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
+	/*
+	 * just enable the clock once here, to avoid an enable/disable dance for
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
@@ -572,6 +649,9 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
 
+	if (eintd->nr_banks)
+		clk_disable(eintd->banks[0]->drvdata->pclk);
+
 	chained_irq_exit(chip, desc);
 }
 
@@ -695,6 +775,12 @@ static void exynos_pinctrl_suspend_bank(
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
@@ -704,6 +790,8 @@ static void exynos_pinctrl_suspend_bank(
 	save->eint_mask = readl(regs + bank->irq_chip->eint_mask
 						+ bank->eint_offset);
 
+	clk_disable(bank->drvdata->pclk);
+
 	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
 	pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltcon0);
 	pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
@@ -716,9 +804,17 @@ static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drv
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
@@ -753,6 +849,12 @@ static void exynos_pinctrl_resume_bank(
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
@@ -774,6 +876,8 @@ static void exynos_pinctrl_resume_bank(
 						+ 2 * bank->eint_offset + 4);
 	writel(save->eint_mask, regs + bank->irq_chip->eint_mask
 						+ bank->eint_offset);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
@@ -782,6 +886,12 @@ static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvd
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
@@ -789,6 +899,8 @@ static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvd
 
 	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
 	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
+
+	clk_disable(bank->drvdata->pclk);
 }
 
 void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ed07e23e0912..acde42983934 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -15,6 +15,7 @@
 // but provides extensions to which platform specific implementation of the gpio
 // and wakeup interrupts can be hooked to.
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
@@ -371,7 +372,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 }
 
 /* enable or disable a pinmux function */
-static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
+static int samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 					unsigned group)
 {
 	struct samsung_pinctrl_drv_data *drvdata;
@@ -382,6 +383,7 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	unsigned long flags;
 	const struct samsung_pmx_func *func;
 	const struct samsung_pin_group *grp;
+	int ret;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 	func = &drvdata->pmx_functions[selector];
@@ -397,6 +399,12 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 		reg += 4;
 	}
 
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(pctldev->dev, "failed to enable clock for setup\n");
+		return ret;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_FUNC]);
@@ -405,6 +413,10 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	writel(data, reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	clk_disable(drvdata->pclk);
+
+	return 0;
 }
 
 /* enable a specified pinmux by writing to registers */
@@ -412,8 +424,7 @@ static int samsung_pinmux_set_mux(struct pinctrl_dev *pctldev,
 				  unsigned selector,
 				  unsigned group)
 {
-	samsung_pinmux_setup(pctldev, selector, group);
-	return 0;
+	return samsung_pinmux_setup(pctldev, selector, group);
 }
 
 /* list of pinmux callbacks for the pinmux vertical in pinctrl core */
@@ -436,6 +447,7 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	u32 data, width, pin_offset, mask, shift;
 	u32 cfg_value, cfg_reg;
 	unsigned long flags;
+	int ret;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
 	pin_to_reg_bank(drvdata, pin, &reg_base, &pin_offset, &bank);
@@ -447,6 +459,12 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
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
@@ -466,6 +484,8 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
+	clk_disable(drvdata->pclk);
+
 	return 0;
 }
 
@@ -555,11 +575,19 @@ static void samsung_gpio_set_value(struct gpio_chip *gc,
 static void samsung_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 {
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
+	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
 	unsigned long flags;
 
+	if (clk_enable(drvdata->pclk)) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	samsung_gpio_set_value(gc, offset, value);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	clk_disable(drvdata->pclk);
 }
 
 /* gpiolib gpio_get callback function */
@@ -569,12 +597,23 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
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
 
@@ -591,9 +630,11 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	struct samsung_pin_bank *bank;
 	void __iomem *reg;
 	u32 data, mask, shift;
+	struct samsung_pinctrl_drv_data *drvdata;
 
 	bank = gpiochip_get_data(gc);
 	type = bank->type;
+	drvdata = bank->drvdata;
 
 	reg = bank->pctl_base + bank->pctl_offset
 			+ type->reg_offset[PINCFG_TYPE_FUNC];
@@ -619,12 +660,22 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 static int samsung_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
+	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
 	unsigned long flags;
 	int ret;
 
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return ret;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	ret = samsung_gpio_set_direction(gc, offset, true);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	clk_disable(drvdata->pclk);
+
 	return ret;
 }
 
@@ -633,14 +684,23 @@ static int samsung_gpio_direction_output(struct gpio_chip *gc, unsigned offset,
 							int value)
 {
 	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
+	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
 	unsigned long flags;
 	int ret;
 
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(drvdata->dev, "failed to enable clock\n");
+		return ret;
+	}
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	samsung_gpio_set_value(gc, offset, value);
 	ret = samsung_gpio_set_direction(gc, offset, false);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
+	clk_disable(drvdata->pclk);
+
 	return ret;
 }
 
@@ -1164,6 +1224,12 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
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
@@ -1202,6 +1268,13 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
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
@@ -1231,6 +1304,8 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 		}
 	}
 
+	clk_disable(drvdata->pclk);
+
 	if (drvdata->suspend)
 		drvdata->suspend(drvdata);
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
@@ -1250,8 +1325,20 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 {
 	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
+	int ret;
 	int i;
 
+	/*
+	 * enable clock before the callback, as we don't want to have to deal
+	 * with callback cleanup on clock failures.
+	 */
+	ret = clk_enable(drvdata->pclk);
+	if (ret) {
+		dev_err(drvdata->dev,
+			"failed to enable clock for restoring state\n");
+		return ret;
+	}
+
 	if (drvdata->resume)
 		drvdata->resume(drvdata);
 
@@ -1286,6 +1373,8 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
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


