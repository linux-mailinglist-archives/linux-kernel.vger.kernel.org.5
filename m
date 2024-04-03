Return-Path: <linux-kernel+bounces-130553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20F8979E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131E7283A87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575FA15686F;
	Wed,  3 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9a8QYZf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59615624D;
	Wed,  3 Apr 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176600; cv=none; b=rChkMfWLVWXFvZCA9NzJMc8eq+lLySIV2TJqjQEt19k0fmlFXLlUt1MQqVS+oi+iFTW2YeX9+pP8V0M8l9VIg+bnRkK+3pSgviWGdbuRVeYW7s7BJLx0ZL7daZbuINFlIs6anwM+zKhombGRWEWK4guNCZhNza/g1NSaHWnfKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176600; c=relaxed/simple;
	bh=hFKgKVrB1AidEDoxKG+9022wXbGql1b6cmLTVCOs+N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbwNY1MXSbSGpS3feiuCk7H6XaGusabcMI1qQ1rHxtaiEy9Xkfz6rtl4EXZKcfoBR46DILjRxk4EXfDWx2Gft5UwK/hx5ryqLyBEbIjTpxGbJSfWWmJIcCbDjWs6qrnwNLRA5rNW0ItPInFGiLPWhFOcahq1Y96C4Ty+n3wU51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9a8QYZf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4156a29ff70so1686705e9.3;
        Wed, 03 Apr 2024 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176596; x=1712781396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMv83C9HZj+2SogqW00zXdzxUFZuc3kgXWuJykzdMro=;
        b=A9a8QYZfXrhlNi5XPhYYGnaml/Tx8nkwavbbI6qKoDWydNBcPMetFaLp/BTf1aXsK2
         hk6u4HjN/1LnTL9SVg6HosqWpAOTuP9zJStHILZzWAiBbH8UiOHd5P5ttdRITMpleUh5
         n5Q0aI9hFB63zrgSU6XgR8OoBPSYd2BAkPQA/6k6rgJcCo6kmoqwtE7PKRu/yBi5/0Q6
         nhZJ89yPrEIX/ayHz7kGf6BpCuzEMFY3NX7BlW/fgoa1yp+3Z5eGpP++niyEuoAnmaEx
         QgV5sAMSb7EZRdz+g9fD1WLNZhWhQUAWUgcs2U8MH+/aW+wQTGvze7Dj0190Pyxr2E+G
         sUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176596; x=1712781396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMv83C9HZj+2SogqW00zXdzxUFZuc3kgXWuJykzdMro=;
        b=Iw6bW39LXryrCqfD4rHFDvT3jUSUjsBRqrO8nqaRvjLuvGKgWHlWGwLgV8TOKfHIhc
         BmeDJa7ErVyYhWNglDlHn5YSot3gC6tL4im0R6ANeFM0PNmK6Z4pCQ5vkm3M5zA/KaNl
         0qPWFtRI7qx2nKbIlCwiWe9XqsbLqirTn+ROAeExf6mS4yKSjYmHVHV7gn4uIo+sC5ig
         ZIinCs6IHn8tMXlVLD+X3PtnEfNuuImZ0jAyq+Sk9rUoHCJONzuG2TzOJABb+5e75GHX
         zialmWb1yB9jiIEHfJ/p7HLwkcTFgZkm6T66w6pu4Hr/mJcahPio12QWN5KPnfaVxZvJ
         mBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdIK68hz6QHwzjeNAZRANjozi9SUZZ/C/UsjaTNdfy1BXC+sz9TGIfqmjxNDfpi1gZLri8tjsLVasj3a7fZ1Me6pzsp1Im9lfLDjvW0a8jD27+5HFcdW8oSzdBNPTNe6E/evPvbRMd/ibiOFIl
X-Gm-Message-State: AOJu0Yzha+pm4HH/ViAQncPg56rJYWI9ma6pvD3KuKPq+zu1u03lVvDw
	1mqzt25X+mIZEVhW1ufisdG+8oi8ChMYWcld/MKlORNXxAOj0YdT
X-Google-Smtp-Source: AGHT+IEiuoPlj2zo+VYIZTCevGavSKbOjyHDcIEW9nRIyqTbej1LKgxI7SRDzlI8L9bXy0Dm2IMGXg==
X-Received: by 2002:a05:600c:2285:b0:415:4853:f722 with SMTP id 5-20020a05600c228500b004154853f722mr522642wmf.10.1712176595776;
        Wed, 03 Apr 2024 13:36:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b00415f496b9b7sm244910wmo.39.2024.04.03.13.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:36:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
Date: Wed,  3 Apr 2024 21:35:00 +0100
Message-Id: <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compared
to the RZ/G2L (family) SoC.

Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC
controller driver. Two new registers, IMSK and TMSK, are defined to
handle masking on RZ/Five SoC. The implementation utilizes a new data
structure, `struct rzg2l_irqc_data`, to determine mask support for a
specific controller instance.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Added IRQCHIP_MATCH() for RZ/Five
- Retaining a copy of OF data in priv
- Rebased the changes
---
 drivers/irqchip/irq-renesas-rzg2l.c | 137 +++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index f6484bf15e0b..6fa8d65605dc 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -37,6 +37,8 @@
 #define TSSEL_SHIFT(n)			(8 * (n))
 #define TSSEL_MASK			GENMASK(7, 0)
 #define IRQ_MASK			0x3
+#define IMSK				0x10010
+#define TMSK				0x10020
 
 #define TSSR_OFFSET(n)			((n) % 4)
 #define TSSR_INDEX(n)			((n) / 4)
@@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
 	u32	titsr[2];
 };
 
+/**
+ * struct rzg2l_irqc_of_data - OF data structure
+ * @mask_supported: Indicates if mask registers are available
+ */
+struct rzg2l_irqc_of_data {
+	bool	mask_supported;
+};
+
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
+ * @data:	OF data pointer
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
+	const struct rzg2l_irqc_of_data	*data;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
@@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
+static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					  unsigned int hwirq)
+{
+	u32 imsk = readl_relaxed(priv->base + IMSK);
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(imsk | bit, priv->base + IMSK);
+}
+
+static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					    unsigned int hwirq)
+{
+	u32 imsk = readl_relaxed(priv->base + IMSK);
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(imsk & ~bit, priv->base + IMSK);
+}
+
+static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					   unsigned int hwirq)
+{
+	u32 tmsk = readl_relaxed(priv->base + TMSK);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(tmsk | bit, priv->base + TMSK);
+}
+
+static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					     unsigned int hwirq)
+{
+	u32 tmsk = readl_relaxed(priv->base + TMSK);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(tmsk & ~bit, priv->base + TMSK);
+}
+
+/* Must be called while priv->lock is held */
+static void rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
+{
+	if (!priv->data->mask_supported)
+		return;
+
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzg2l_irqc_mask_tint_interrupt(priv, hwirq);
+}
+
+static void rzg2l_irqc_mask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+
+	raw_spin_lock(&priv->lock);
+	rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
+	raw_spin_unlock(&priv->lock);
+	irq_chip_mask_parent(d);
+}
+
+/* Must be called while priv->lock is held */
+static void rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
+{
+	if (!priv->data->mask_supported)
+		return;
+
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzg2l_irqc_unmask_tint_interrupt(priv, hwirq);
+}
+
+static void rzg2l_irqc_unmask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+
+	raw_spin_lock(&priv->lock);
+	rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
+	raw_spin_unlock(&priv->lock);
+	irq_chip_unmask_parent(d);
+}
+
 static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
 		u32 reg;
 
 		raw_spin_lock(&priv->lock);
+		if (enable)
+			rzg2l_irqc_unmask_once(priv, hw_irq);
+		else
+			rzg2l_irqc_mask_once(priv, hw_irq);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
 		if (enable)
 			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
@@ -157,6 +253,13 @@ static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
+	} else {
+		raw_spin_lock(&priv->lock);
+		if (enable)
+			rzg2l_irqc_unmask_once(priv, hw_irq);
+		else
+			rzg2l_irqc_mask_once(priv, hw_irq);
+		raw_spin_unlock(&priv->lock);
 	}
 }
 
@@ -324,8 +427,8 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 static const struct irq_chip irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_mask		= rzg2l_irqc_mask,
+	.irq_unmask		= rzg2l_irqc_unmask,
 	.irq_disable		= rzg2l_irqc_irq_disable,
 	.irq_enable		= rzg2l_irqc_irq_enable,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
@@ -401,7 +504,16 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	return 0;
 }
 
-static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
+static const struct rzg2l_irqc_of_data rzg2l_irqc_mask_supported_data = {
+	.mask_supported = true,
+};
+
+static const struct rzg2l_irqc_of_data rzg2l_irqc_default_data = {
+	.mask_supported = false,
+};
+
+static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent,
+			   const struct rzg2l_irqc_of_data *of_data)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
@@ -422,6 +534,8 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
+	rzg2l_irqc_data->data = of_data;
+
 	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
@@ -472,8 +586,21 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
+static int __init rzg2l_irqc_default_init(struct device_node *node,
+					  struct device_node *parent)
+{
+	return rzg2l_irqc_init(node, parent, &rzg2l_irqc_default_data);
+}
+
+static int __init rzg2l_irqc_mask_supported_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	return rzg2l_irqc_init(node, parent, &rzg2l_irqc_mask_supported_data);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
-IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_default_init)
+IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzg2l_irqc_mask_supported_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-- 
2.34.1


