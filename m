Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13725809D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573347AbjLHHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573305AbjLHHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:50:23 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39330172D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:50:24 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231208075022epoutp0358bf20ec5204384d7a671f94f72b680e~ey9Ri5eRQ2153921539epoutp03i
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231208075022epoutp0358bf20ec5204384d7a671f94f72b680e~ey9Ri5eRQ2153921539epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702021822;
        bh=QFjoD3QgD7GkST6P/zXBRiPeNUWTkXr/ft3vaUHSbJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1l/SufG1UFoLrqRNhbGdk/9mHWWQFzj6TcXYe4Ka+iASaCtopPsrLdiCe2TBLYby
         8JYmrbXFTbwMkrcSWoi0lw/UqdMejEaXYcDtNNtK/RfrhcpoebMwu0VkPOxPna6hAk
         17sA3U3g6GO9LgFRfcXIaLj68wI5IyWAE/J2FoDs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231208075021epcas2p339482a9dfb7ec919af838a87387bc412~ey9QrwAmv0598705987epcas2p3l;
        Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Smjwr5PtFz4x9Pw; Fri,  8 Dec
        2023 07:50:20 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.25.08648.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d~ey9Pxcta22154621546epcas2p2f;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231208075020epsmtrp123bb9b1fef73babf3c96f735d51a744b~ey9PwiFOX0200802008epsmtrp18;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-3d-6572cabc9b31
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.AB.08817.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075020epsmtip22a4623a357ef33f51f7d7eb3779fa277~ey9PegR_w1657616576epsmtip2D;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
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
Subject: [PATCH v3 3/4] pinctrl: samsung: support ExynosAuto GPIO structure
Date:   Fri,  8 Dec 2023 16:45:26 +0900
Message-ID: <20231208074527.50840-4-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208074527.50840-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc+5tby/Ewl2Z88iYYs2YYGAtA3p4dJqxkTpMxBoTJSbQwbEQ
        Sm9ty9zcEnDIw+JGOzaH3aA4hKUNGVJgKy/noIIbSxFdIJGXBnBhzAmMgShbbLmo++97fufz
        /T3OgyZFw1Qwnas1Yr1WpRFT/rwrfeGyyO6beiypdoSjX2qvUKipx0Mgm9vDR8X1zRRyFbn5
        6H5NCOqZbxegM+uXCOScHuGjVts6QD91XqDQxIQDoOqhbwh0q/6kAJX0uAWo714ZH6111vKQ
        o9PLjVmqwKtBig7rhEDhdHxKKcZHuinFtZomgaL1q0JF5SOJ4lSbAygeOJ9Lo9PzknKwKhvr
        Q7E2i83O1arl4tS3MpIzYuMk0khpPJKJQ7WqfCwX7389LTIlV+MdRxx6WKUp8IbSVAaDePfe
        JD1bYMShOazBKBdjXbZGJ9NFGVT5hgKtOkqLjQlSiSQ61gtm5uU0zpcQuinlEbP9S6oIVBww
        AT8aMjHQ099BmIA/LWJcAPZMmPncYglAy0IT30eJmBUAzaVBJkBvOL7uwxzTA6DzxMKmYRHA
        qWKXwGegmJfhanP9hnkrM0XC+dJjPohkyghYuzLH820EManw1GA7z5eVx+yE505TvrCQkUPH
        jWo+197zsN51ifRpP2YvrDvpIjlmC7zxxcxGGtLLFLefJ335IfMDDcsG5nmceT/sXJ4lOB0E
        7w60CTgdDOcqSzc1C0tv39rUx2FL3Y+A069A699tfF9vJBMOmzt3c8O/CN0/b5YNgOV9jwRc
        WAjLS0WcMQxOnfVQnA6Bp912gkMU8PtGxJ2UBcCKwQ5gBqHWJ4axPjGM9f+6dYB0gG1YZ8hX
        46xonfS/681i851g421HJLvAbdvjqF5A0KAXQJoUbxVqhlgsEmarjn6E9WyGvkCDDb0g1nvS
        FjL46SzW+zm0xgxpTLwkJi5OKouOlcjEzwgnS2qyRYxaZcR5GOuw/l8fQfsFFxGeA8eDqtT6
        7alJWwKHP4hfbo3cZ3cO39t5sGBmhdyVsvjJyJk7kjF7v3/d3Inrd3mHjwxGjSaxNncL9d37
        e1ICryb+NTk98/nRqx8un6XTTA5PWJs9OHpID1qefaBMRpNjgdunZW8v/RpxP/Cz5HdGE+1h
        N9/M3NfQnmFMOaZcv97VcLFkbQcr/L0p03bZPJKQGMauTk909/22cGghoPpCl3vXnrrK0ZC1
        kfX0hot3TNeWzPmPlUyq9j3UP/5ueOGO1TeEl7/NsyQ+PGR74c+YP6SzCcox5cevLZTL/XIG
        TWT6QPRTeY0Pu2oWK9XYuk1WGFB4LnZcWtUsn8UV7YtTrcqXxDxDjkoaQeoNqn8Aq5NtPWQE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXnfPqaJUg2XbeSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStj2etWpoL7QRUTVi5ka2Ds
        du1i5OCQEDCR2HA4tYuRi0NIYDejRMunTYxdjJxAcRmJ5c/62CBsYYn7LUdYIYreM0pMaDoP
        lmAT0Jb4vn4xWEJE4DmzxNk/j5hBEswC/UwS1zclgNjCAt4Sfae3soBsYxFQlZg+CayXV8BW
        YtXJGawQC+QlFu9YDtbKKWAnsaB3B5gtBFSzZmsHO0S9oMTJmU9YIMbLSzRvnc08gVFgFpLU
        LCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNMS2sH455VH/QOMTJxMB5i
        lOBgVhLhzTmfnyrEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMH
        p1QD0+HqV6f6Us4LT9joV2TK1yj7UeIx31arN1u2q4i7mi77kMSjWaC7fcPMRrGvFdNfX/t7
        KPfyhkXyK5Z52dt3OqpqZDFc2lnTcCrfaG/OxBjmmLLyxl3tm2+pTwppVXTu4tvW1fTT5bec
        yfQSfmX/c6/9XsoLrOdY8SJoGVsoI/Olo5bXjk90L43KMri0bN3efn/tpzHaOax7ma5vW12h
        7JL1Vv2u+cLJTKLT7fRvfti/xFFtY0bWem7T0x4FMXsljlSaTnNVbX7zjG3yzBWzHCa+rtbS
        T6hxmZE6P/iNSvkkLs7l6w8d8ChYxbJz5e/vdyO02b+dUFmqZXH4p9JGOeXpYiwJ07MWGOXJ
        NlUyK7EUZyQaajEXFScCAAUTH80hAwAA
X-CMS-MailID: 20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d@epcas2p2.samsung.com>
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
In the existing Exynos series, EINT control register enumerated after
a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET, EXYNOS_GPIO_EMASK_OFFSET).
However, from ExynosAutov920 SoC, the register that controls EINT belongs
to each GPIO bank, and each GPIO bank has 0x1000 align.

This is a structure to protect the GPIO bank using S2MPU in VM environment,
and will only be applied in ExynosAuto series SoCs.

-------------------------------------------------
| original		| ExynosAutov920	|
|-----------------------------------------------|
| 0x0	GPIO_CON	| 0x0	GPIO_CON	|
| 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
| 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
| 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
| 0x10	GPIO_CONPDN	| 0x10	GPIO_CONPDN	|
| 0x14	GPIO_PUDPDN	| 0x14	GPIO_PUDPDN	|
| 0x700	EINT_CON	| 0x18	EINT_CON	|
| 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
| 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
| 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
|			| 0x28	EINT_PEND	|
-------------------------------------------------

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 81 +++++++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-exynos.h  |  1 +
 drivers/pinctrl/samsung/pinctrl-samsung.c |  3 +
 drivers/pinctrl/samsung/pinctrl-samsung.h | 12 ++++
 4 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 6b58ec84e34b..f798f64b1122 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -56,6 +56,9 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	unsigned int mask;
 	unsigned long flags;
 
+	if (bank->eint_mask_offset)
+		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -72,6 +75,9 @@ static void exynos_irq_ack(struct irq_data *irqd)
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
 
+	if (bank->eint_pend_offset)
+		reg_pend = bank->pctl_offset + bank->eint_pend_offset;
+
 	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
 }
 
@@ -95,6 +101,9 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
 		exynos_irq_ack(irqd);
 
+	if (bank->eint_mask_offset)
+		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -139,6 +148,9 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	else
 		irq_set_handler_locked(irqd, handle_level_irq);
 
+	if (bank->eint_con_offset)
+		reg_con = bank->pctl_offset + bank->eint_con_offset;
+
 	con = readl(bank->eint_base + reg_con);
 	con &= ~(EXYNOS_EINT_CON_MASK << shift);
 	con |= trig_type << shift;
@@ -221,6 +233,18 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
 	/* eint_wake_mask_value not used */
 };
 
+static const struct exynos_irq_chip exynosauto_gpio_irq_chip __initconst = {
+	.chip = {
+		.name = "exynosauto_gpio_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_request_resources = exynos_irq_request_resources,
+		.irq_release_resources = exynos_irq_release_resources,
+	},
+};
+
 static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
@@ -247,7 +271,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	unsigned int svc, group, pin;
 	int ret;
 
-	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
+	if (bank->eint_con_offset)
+		svc = readl(bank->eint_base + EXYNOSAUTO_SVC_OFFSET);
+	else
+		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -297,8 +324,12 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 		if (bank->eint_type != EINT_TYPE_GPIO)
 			continue;
 
-		bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
-					   sizeof(*bank->irq_chip), GFP_KERNEL);
+		if (bank->eint_con_offset)
+			bank->irq_chip = devm_kmemdup(dev, &exynosauto_gpio_irq_chip,
+						      sizeof(*bank->irq_chip), GFP_KERNEL);
+		else
+			bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
+						      sizeof(*bank->irq_chip), GFP_KERNEL);
 		if (!bank->irq_chip) {
 			ret = -ENOMEM;
 			goto err_domains;
@@ -655,6 +686,19 @@ static void exynos_pinctrl_suspend_bank(
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
@@ -662,8 +706,12 @@ void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
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
@@ -704,14 +752,33 @@ static void exynos_pinctrl_resume_bank(
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
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 3ac52c2cf998..5049c170e958 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -31,6 +31,7 @@
 #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
 #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
 #define EXYNOS_SVC_OFFSET		0xB08
+#define EXYNOSAUTO_SVC_OFFSET		0xF008
 
 /* helpers to access interrupt service register */
 #define EXYNOS_SVC_GROUP_SHIFT		3
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

