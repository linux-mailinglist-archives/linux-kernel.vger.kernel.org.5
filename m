Return-Path: <linux-kernel+bounces-160026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C38B3804
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC80D1F22E06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BBA146D62;
	Fri, 26 Apr 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paC3R4tL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25286146D6B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137055; cv=none; b=SlrCD+9e9KM0fuWN+dywM3I78s8xehqnBNhACTDmr7F1ttA8M6bunY0NBRR4wkpGOhhmAgJ+udxUa18PBLcGQfle7KasM0r74+16KtoxLgKt+OQInLGZdpxgWdr2y/56taOuC9RwwkKx/nbuzYa8QTk1M7+Tjm4Q30ZNNwLT8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137055; c=relaxed/simple;
	bh=mwFsyIFVInmmVw0ifFWX9WCQpqskJD34qrtcrTlVpKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQ/IhwOPqIS0wcVSY/3/RKevROW+ouoNYBTXURHAHDaWNxg5L/Gu3q+iZwxrygubj9vGZMFFpU2KYxoGsxPPQ+dC0UpuaW5mKHRc3fLeNYUW7zmGdyiDxtKQxkQQF7K9D74NV2f27vtj5iRRs7MymI6kdy71U13x4j0rFT2IynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=paC3R4tL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a55911bff66so276548166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714137051; x=1714741851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9Qwvd6hs9zicHZIfahxQLk96QTDqsG31aYfRw5jOvY=;
        b=paC3R4tLqBtLcxijwQNtyzEULhoXFiAsO1rzuxcGwrtC81IaXyRenKEf7fE753OKBA
         NGT2IGx88JqXR+PlgQx6fuNNxRM2sOel6NRlXktPIy6J4bFnDa7RJ0Lmz1Nrb2gepSj6
         OXLqweBVA86rUusiHLH7e7Mkb7xZhcZGFkVZiJg1pKnrF2Yf0TnPz4WJ5g1YVyXpQcd5
         S2XSrrDqTBZdVV4vY/krb4RodiWlSY3/lrq6SuJQalvizwjfofgA7FPssRe+QUje1345
         kMEIpRHWohz90vDa13ZbDgM+0i3f3MBBdCEwKmLtRlUdlbcEHZzq04Npq0farBPnXCjT
         OPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137051; x=1714741851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9Qwvd6hs9zicHZIfahxQLk96QTDqsG31aYfRw5jOvY=;
        b=dAhX+iK4P3oqUPcK5jWyQrwmfU9NkT3MCFazQak4xNWkRDwvwo9RmAO16FNcioMRUe
         3JTg61WEEmckqrz/GovlMX7DytM1ON6/ldq2EyHQQIyAe/Y2gFcfB3Mc01MLLdTkyoqX
         VN3tRrT7fM1E2QXpTJ+Qzfs9YVJJ73JXWQ6Q7r9aam3kimTQ10YadcKYONe2U79SZ5RT
         FjDelAaglE18ccjzUO39bkDWTCBj2wYfLShmjnPpLtyyxyN/7iiDvBjBiawIFIDtjQc4
         HMSUn3HqMRXJcMHacEkoXKFPd4NV5kUBGAPclOnxeR7HIWGZ8bPVVzNfY3RUZTfoEIW4
         HrMA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqXIS3LUtn5a0S9rLxJ0smdJsEdWG5U0wSGgRhaDe6uwP4DQm4mlRRhuRAwFOEGXEKC3cPyAyoZdps30abeeTZ3RkKWkwrpS0TnzH
X-Gm-Message-State: AOJu0Ywr+506gg0nPprnhtpJiPCv/VJeIdCKAN81PDDnSkLLLvlOXeGI
	ImdmJU5Fwl/9h8rb0KF09UCLOfbD3D/4Hi52Ghe5jArowuO8NqddUmDEykx5/SQ=
X-Google-Smtp-Source: AGHT+IFSOiz9rRsJTgrW9U2HDcEazy/PcTJg277ufvRSlfrOXfldfE2Gty+LDpIJur7Hq05qn7kHbQ==
X-Received: by 2002:a17:906:b292:b0:a58:be00:7e7f with SMTP id q18-20020a170906b29200b00a58be007e7fmr2031703ejz.57.1714137051150;
        Fri, 26 Apr 2024 06:10:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906c41200b00a58bec2ae2bsm1396948ejz.39.2024.04.26.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:10:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 26 Apr 2024 14:10:47 +0100
Subject: [PATCH v2 2/2] pinctrl: samsung: support a bus clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-samsung-pinctrl-busclock-v2-2-8dfecaabf020@linaro.org>
References: <20240426-samsung-pinctrl-busclock-v2-0-8dfecaabf020@linaro.org>
In-Reply-To: <20240426-samsung-pinctrl-busclock-v2-0-8dfecaabf020@linaro.org>
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


