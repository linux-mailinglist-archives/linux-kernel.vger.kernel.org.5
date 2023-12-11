Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2723180C844
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjLKLmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjLKLmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:42:18 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA2DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:42:19 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231211114218epoutp014a24c097baa55bdd2a45e0272aab37d6~fxDorjWAx1703117031epoutp017
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:42:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231211114218epoutp014a24c097baa55bdd2a45e0272aab37d6~fxDorjWAx1703117031epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702294938;
        bh=eteBMel/iVTvKnU0KxrtedP/DbkAgBM9KMl9hZr2tKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMR4JwlWg+a5dEEHs1pswH4Q1lL7YV+LgEX85RwGDMKpf5Mbi537zNIfYp4sML+mR
         mUl7dQlytzCSVWue1mmm+Ya+uC6ppX5SXKUfl0smP+EggoAjdjWlJccqDws2jlGRmH
         KYiXOge91DhkWTCJIa8e6DsWiPdd/jvkQllYITP4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231211114217epcas2p4f1c0b66b7d191c04a8aad4fd38ba1e45~fxDnxhbnm1077110771epcas2p4w;
        Mon, 11 Dec 2023 11:42:17 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Spfx45YJZz4x9Ps; Mon, 11 Dec
        2023 11:42:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.5D.18994.895F6756; Mon, 11 Dec 2023 20:42:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231211114215epcas2p21c9a1c2157cd1650f5ec12487eddb576~fxDmiZv8S2599325993epcas2p2Q;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231211114215epsmtrp1ec8a96ce034c2fa515fff16149cad830~fxDmgr6Oy0416704167epsmtrp1X;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-34-6576f598909e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.A9.18939.795F6756; Mon, 11 Dec 2023 20:42:15 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231211114215epsmtip21c79ddad8999fb22f30cfb65282bdb51~fxDmOr3tF0445204452epsmtip2U;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v4 1/2] pinctrl: samsung: support ExynosAuto GPIO structure
Date:   Mon, 11 Dec 2023 20:41:44 +0900
Message-ID: <20231211114145.106255-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211114145.106255-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmhe6Mr2WpBl+2a1g8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjL3929gLjgRVLHl6kL2B8aBTFyMnh4SAicSNNZ0s
        ILaQwB5GiVvvYyDsT4wSU7cA2VwQ9v9fr1lhGk58W8wCkdjJKPHk3y1mCOcjo8SEy6vBqtgE
        tCW+r18MZosI3GeWeN1WDVLELNDOJDHv20uwfcIC3hK/Fr5iBrFZBFQlbr2aDBbnFbCT6Dv1
        CWqdvMTiHcvBajgF7CVObnzEBFEjKHFy5hOwemagmuats8GukBC4wCGxuucjkMMB5LhIfNpj
        AjFHWOLV8S3sELaUxMv+Nig7X6Ltyhkou0Zi44JLjBC2vcSiMz/ZQcYwC2hKrN+lDzFRWeLI
        LaitfBIdh/+yQ4R5JTrahCAa1STuTz3HBmHLSEw6spIJwvaQuPngARMkqCYxSlw5e4RxAqPC
        LCTPzELyzCyExQsYmVcxSqUWFOempyYbFRjq5qWWw+M4OT93EyM4gWv57mB8vf6v3iFGJg7G
        Q4wSHMxKIrwyR4pThXhTEiurUovy44tKc1KLDzGaAoN7IrOUaHI+MIfklcQbmlgamJiZGZob
        mRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAJKYqZXJNxNpAU6/jSn7Z5HdOJ+5tX5HW
        LTdlU6jQJrmM/IbT7hd2L3qZxbmsZ93BS8+V7EQusPoeTl1rydB4TikyZsUfE6Gut+nacyq2
        GDrcUZi+YXn0pbdrb718m5fxri/24qd3XiX5LsEV3i92/LDaEOLWMH/jUi177sj0HJP7q3v2
        qjdWngtXPd37RKtGI3x1eNCmSdyXrjZMX87mlSXs+URP4fEToeVvlStZg06fF1k5JWx1q1VA
        8O62pMiAoui8OR7erJ1Nn25vM7Rr3NjQtqjxpMuCF3Zyv+/cY/ab97BzNt/10jt/lu3VsSxh
        75y6JFQgtHld8LXMxctMWRmtG+aURDocKvvBf+6wEktxRqKhFnNRcSIAoAV8VGkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXnf617JUg+uvDSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStjb/829oIjQRVLnh5kb2A8
        6NTFyMkhIWAiceLbYpYuRi4OIYHtjBL3bz9ghkjISCx/1scGYQtL3G85wgpiCwm8Z5TY8KIA
        xGYT0Jb4vn4xK0iziMBzZomzfx6BNTML9DNJXN+UAGILC3hL/Fr4CizOIqAqcevVZBYQm1fA
        TqLv1CdWiAXyEot3LAer4RSwlzi58RETxDI7iXkfd7NC1AtKnJz5hAVivrxE89bZzBMYBWYh
        Sc1CklrAyLSKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzi+tIJ2MC5b/1fvECMTB+MhRgkO
        ZiURXpkjxalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFIN
        TJKrea8ZrxX2kz6zTGGtSX5Z7oo/9Te1p168I2HScuHVLfMdjpK8L4J+/RKM/tsx2XDx8o81
        95X+lJ9+ILfip5tZwatbm2VnfirYcufFyaw6pstcta8FLrNpHlA4ob9Ua909zvkX/1dblT9O
        +sjB+05Pumll1ZeznecjbZx0n/Kzqt7tTvjy0Tnavl4jcuKHTTPZpXl500qWTOBlOB22fKfw
        M/kdrbkd8wMNP6jGK7HsvnTx8FSvf70LS27+107q8XhzS6ZixufWQC+j9uMxMw5+u8Lv+0tu
        V8/R58tX7i34nen3OPoYy2OdysQJJyNtv8V3Sc9zqPLJPCd4MijJYMefiS9NA82lfq4MTGYy
        4VJiKc5INNRiLipOBAAxU6eNHgMAAA==
X-CMS-MailID: 20231211114215epcas2p21c9a1c2157cd1650f5ec12487eddb576
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231211114215epcas2p21c9a1c2157cd1650f5ec12487eddb576
References: <20231211114145.106255-1-jaewon02.kim@samsung.com>
        <CGME20231211114215epcas2p21c9a1c2157cd1650f5ec12487eddb576@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New ExynosAuto series GPIO have a different register structure.
In the existing Exynos series, EINT control register is enumerated after
a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET, EXYNOS_GPIO_EMASK_OFFSET).
However, from ExynosAutov920 SoC, the register that controls EINT belongs
to each GPIO bank, and each GPIO bank has 0x1000 align.

This is a structure to protect the GPIO bank using S2MPU in VM environment,
and will only be applied in ExynosAuto series SoCs.

--------------------------------------------------------------
| Original Exynos            | ExynosAuto                    |
|------------------------------------------------------------|
| 0x0   GPIO_CON             | 0x0   GPIO_CON                |
| 0x4   GPIO_DAT             | 0x4   GPIO_DAT                |
| 0x8   GPIO_PUD             | 0x8   GPIO_PUD                |
| 0xc   GPIO_DRV             | 0xc   GPIO_DRV                |
| 0x10  GPIO_CONPDN          | 0x10  GPIO_CONPDN             |
| 0x14  GPIO_PUDPDN          | 0x14  GPIO_PUDPDN             |
|----------------------------| 0x18  EINT_CON (per_bank)     |
| ...                        | 0x1c  EINT_FLTCON0 (per_bank) |
| ...                        | 0x20  EINT_FLTCON1 (per_bank) |
| ...                        | 0x24  EINT_MASK (per_bank)    |
| ...                        | 0x28  EINT_PEND (per_bank)    |
|----------------------------|-------------------------------|
| 0x700 EINT_CON (global)    | ...                           |
| 0x800 EINT_FLTCON (global) | ...                           |
| 0x900 EINT_MASK (global)   | ...                           |
| 0xa00 EINT_FEND (global)   | ...                           |
--------------------------------------------------------------

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 72 ++++++++++++++++++++---
 drivers/pinctrl/samsung/pinctrl-samsung.c |  3 +
 drivers/pinctrl/samsung/pinctrl-samsung.h | 12 ++++
 3 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 6b58ec84e34b..77f747e629f7 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -52,10 +52,15 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
+	unsigned long reg_mask;
 	unsigned int mask;
 	unsigned long flags;
 
+	if (bank->eint_mask_offset)
+		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
+	else
+		reg_mask = our_chip->eint_mask + bank->eint_offset;
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -70,7 +75,12 @@ static void exynos_irq_ack(struct irq_data *irqd)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
+	unsigned long reg_pend;
+
+	if (bank->eint_pend_offset)
+		reg_pend = bank->pctl_offset + bank->eint_pend_offset;
+	else
+		reg_pend = our_chip->eint_pend + bank->eint_offset;
 
 	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
 }
@@ -80,7 +90,7 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct exynos_irq_chip *our_chip = to_exynos_irq_chip(chip);
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
-	unsigned long reg_mask = our_chip->eint_mask + bank->eint_offset;
+	unsigned long reg_mask;
 	unsigned int mask;
 	unsigned long flags;
 
@@ -95,6 +105,11 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
 		exynos_irq_ack(irqd);
 
+	if (bank->eint_mask_offset)
+		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
+	else
+		reg_mask = our_chip->eint_mask + bank->eint_offset;
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -111,7 +126,7 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned int shift = EXYNOS_EINT_CON_LEN * irqd->hwirq;
 	unsigned int con, trig_type;
-	unsigned long reg_con = our_chip->eint_con + bank->eint_offset;
+	unsigned long reg_con;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -139,6 +154,11 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	else
 		irq_set_handler_locked(irqd, handle_level_irq);
 
+	if (bank->eint_con_offset)
+		reg_con = bank->pctl_offset + bank->eint_con_offset;
+	else
+		reg_con = our_chip->eint_con + bank->eint_offset;
+
 	con = readl(bank->eint_base + reg_con);
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
@@ -655,6 +675,19 @@ static void exynos_pinctrl_suspend_bank(
 	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
 
+static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drvdata,
+					    struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = bank->eint_base;
+
+	save->eint_con = readl(regs + bank->pctl_offset + bank->eint_con_offset);
+	save->eint_mask = readl(regs + bank->pctl_offset + bank->eint_mask_offset);
+
+	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
+	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
+}
+
 void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
@@ -662,8 +695,12 @@ void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
-		if (bank->eint_type == EINT_TYPE_GPIO)
-			exynos_pinctrl_suspend_bank(drvdata, bank);
+		if (bank->eint_type == EINT_TYPE_GPIO) {
+			if (bank->eint_con_offset)
+				exynosauto_pinctrl_suspend_bank(drvdata, bank);
+			else
+				exynos_pinctrl_suspend_bank(drvdata, bank);
+		}
 		else if (bank->eint_type == EINT_TYPE_WKUP) {
 			if (!irq_chip) {
 				irq_chip = bank->irq_chip;
@@ -704,14 +741,33 @@ static void exynos_pinctrl_resume_bank(
 						+ bank->eint_offset);
 }
 
+static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
+					   struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = bank->eint_base;
+
+	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+		 readl(regs + bank->pctl_offset + bank->eint_con_offset), save->eint_con);
+	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+		 readl(regs + bank->pctl_offset + bank->eint_mask_offset), save->eint_mask);
+
+	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
+	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
+}
+
 void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
-		if (bank->eint_type == EINT_TYPE_GPIO)
-			exynos_pinctrl_resume_bank(drvdata, bank);
+		if (bank->eint_type == EINT_TYPE_GPIO) {
+			if (bank->eint_con_offset)
+				exynosauto_pinctrl_resume_bank(drvdata, bank);
+			else
+				exynos_pinctrl_resume_bank(drvdata, bank);
+		}
 }
 
 static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 79babbb39ced..362e99566919 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1106,6 +1106,9 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		bank->eint_type = bdata->eint_type;
 		bank->eint_mask = bdata->eint_mask;
 		bank->eint_offset = bdata->eint_offset;
+		bank->eint_con_offset = bdata->eint_con_offset;
+		bank->eint_mask_offset = bdata->eint_mask_offset;
+		bank->eint_pend_offset = bdata->eint_pend_offset;
 		bank->name = bdata->name;
 
 		raw_spin_lock_init(&bank->slock);
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 9b3db50adef3..789358bcd9c5 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -122,6 +122,9 @@ struct samsung_pin_bank_type {
  * @eint_type: type of the external interrupt supported by the bank.
  * @eint_mask: bit mask of pins which support EINT function.
  * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
+ * @eint_con_offset: ExynosAuto SoC-specific EINT control register offset of bank.
+ * @eint_mask_offset: ExynosAuto SoC-specific EINT mask register offset of bank.
+ * @eint_pend_offset: ExynosAuto SoC-specific EINT pend register offset of bank.
  * @name: name to be prefixed for each pin in this pin bank.
  */
 struct samsung_pin_bank_data {
@@ -133,6 +136,9 @@ struct samsung_pin_bank_data {
 	enum eint_type	eint_type;
 	u32		eint_mask;
 	u32		eint_offset;
+	u32		eint_con_offset;
+	u32		eint_mask_offset;
+	u32		eint_pend_offset;
 	const char	*name;
 };
 
@@ -147,6 +153,9 @@ struct samsung_pin_bank_data {
  * @eint_type: type of the external interrupt supported by the bank.
  * @eint_mask: bit mask of pins which support EINT function.
  * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
+ * @eint_con_offset: ExynosAuto SoC-specific EINT register or interrupt offset of bank.
+ * @eint_mask_offset: ExynosAuto SoC-specific EINT mask register offset of bank.
+ * @eint_pend_offset: ExynosAuto SoC-specific EINT pend register offset of bank.
  * @name: name to be prefixed for each pin in this pin bank.
  * @id: id of the bank, propagated to the pin range.
  * @pin_base: starting pin number of the bank.
@@ -170,6 +179,9 @@ struct samsung_pin_bank {
 	enum eint_type	eint_type;
 	u32		eint_mask;
 	u32		eint_offset;
+	u32		eint_con_offset;
+	u32		eint_mask_offset;
+	u32		eint_pend_offset;
 	const char	*name;
 	u32		id;
 
-- 
2.43.0

