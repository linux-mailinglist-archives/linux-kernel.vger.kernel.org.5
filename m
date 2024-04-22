Return-Path: <linux-kernel+bounces-154016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489F8AD625
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9B7283AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E51CF9C;
	Mon, 22 Apr 2024 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJQl2XIA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A41BF24;
	Mon, 22 Apr 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819077; cv=none; b=diGGXzFhKWG0gphy874tVEfU207zTvD5aUlkcDNbc0SG7ZtHjzi0F7hQPY9yExoDZx1nztx+bHX+OL4eYi1rTrgwtBjxY/8KwqeWlT9sJwMele7RG2F4pX3L5NcMgI/dHmNDdxwHZbhr1YfkvMsVDYkCJF9eGVJCnEY2RLQnSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819077; c=relaxed/simple;
	bh=o1kjyMlMHn3WuB48y807ZJ82DciQe+pDA794nI7gUMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3Su1t8C/BslclaaNQbaslW6/PAjlTA03DBpYWJAy3HqtGTBsZ+dy4mmipXov6SMExVom86as9+VY/0ibfG7XT19bzevSOvrwJ75W0P32BK9/BMWc0XTf6yDeJJEMahHf8jU/JvGJhGNBZmnbRX3rsmAHxVsgOOZkp4ejA0wkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJQl2XIA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41a7820620dso8386915e9.0;
        Mon, 22 Apr 2024 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713819074; x=1714423874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+luacCQnOhSsjSXaBqxMxOv7nVDPIvqD5Q5QGTUHpk=;
        b=NJQl2XIASpMz5AVqLfQkcWU8VQBWFSPLkctboZKFngLnud9P2klKuRAj+PPhZfS6PL
         SnfYuP1PoeSZP2lXzYHamK/TlNEIZz+IfnV90GsRqt386l7927rDUfWJozgHFI7+V8P2
         opJfxGD0HJC2v3FsMlYDnr062SyqXJwUhh5XNewjalS5flkL6DPLbhoWB1rgq9XoJ4JY
         lAzMmtUR9/DnyUbwK+z4orKZZXK3Zxh2RKonPNMbK0s4frHxAPBd6ehxBdFcekKW+qtI
         zcRnx2rVtDxE60yDhTxIb+NbnBYMQwggo1ZOlP0LYkwqDelbeTxd5vdcxlUyykT0MnG0
         zHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819074; x=1714423874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+luacCQnOhSsjSXaBqxMxOv7nVDPIvqD5Q5QGTUHpk=;
        b=SumYTyMGvNismMnqhgaNFtfjDrqcAnEujGh2cyIc63h1I4OF1yAW0KeD7yk1LHmi3C
         jSRkObjD3VVraIEaYzy+/tU2pp21OSZCq68qgFO6v1xx7t3ZdNgcFCdoemdvbYOGbI1X
         RyW4vNz68e0mgkLNXUvbAKd0oX/obQTchkiTddHzTNYj3U82MNXT10xAXDuf8gEDoONi
         E1Kww+5TJrbo/HckC0FI5xQ2f21NlrgtmePPnYTjwCANMiAoetGd1MpdfoQ6ZPKsr0kH
         jT1z4HkLkPqwMEDJ2sjJpo6UgRutUXx6zyF3XfxPZE7iE4iSb0bWDOGzSpQsC/De6BXS
         XMyg==
X-Forwarded-Encrypted: i=1; AJvYcCWua3X/96sRk4AuBMqpo/5wMvacEHpOGc7G9gkO0JQV4bMZGtBRwLWSD+5sTF7gUzXWkT+82DT5oki4fNRSUAILj300dzv6LVt17mukrtXQJkwDOeWT3o3w1+WEDDex3jtUKJCF4LxLr88bl+uY
X-Gm-Message-State: AOJu0YxUlaGWqodA6REkKWLA+S20Jzz8/+4g5H1Gov5YOGdxQTLOAbqp
	SIL9B8Bf7SQN1rjmvn1mZthdWwQgNPH8yX8BFeuVvShMD2wKPtJ8
X-Google-Smtp-Source: AGHT+IH3lDRcRXkJWYwq94Q+N/0i0VXWP/kFf1v90l3ihqFkmK7g6t3Zc03zMf1Z9CVJGddoBC23VQ==
X-Received: by 2002:adf:f28e:0:b0:349:fef8:73bb with SMTP id k14-20020adff28e000000b00349fef873bbmr7420503wro.50.1713819073479;
        Mon, 22 Apr 2024 13:51:13 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d544f000000b00349c63eb484sm12861576wrv.23.2024.04.22.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:51:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/2] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
Date: Mon, 22 Apr 2024 21:50:53 +0100
Message-Id: <20240422205053.496095-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The IX45 block on the RZ/Five SoC has additional mask registers
(NMSK/IMSK/TMSK) compared to the RZ/G2L (family) SoC.

A new rzfive_irqc_chip irq_chip is introduced for RZ/Five, where function
pointers for irq_(un)mask and irq_(dis/en)able handle the (un)masking
of the interrupts. The irq_chip pointer is now passed as an init callback
and stored in the priv pointer to differentiate between RZ/G2L and RZ/Five.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
- Added RZ/Five specific irqchip instead of polluting the functions
- Fixed review comments pointed by Biju and Geert
- Updated commit message
- moved locking respective read/write functions

v1->v2
- Added IRQCHIP_MATCH() for RZ/Five
- Retaining a copy of OF data in priv
- Rebased the changes
---
 drivers/irqchip/irq-renesas-rzg2l.c | 150 +++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index f6484bf15e0b..8c454b8eb5ad 100644
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
@@ -69,12 +71,14 @@ struct rzg2l_irqc_reg_cache {
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
+ * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
+	const struct irq_chip		*irqchip;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
@@ -138,6 +142,113 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
+static void rzfive_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					   unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	raw_spin_lock(&priv->lock);
+	writel_relaxed(readl_relaxed(priv->base + IMSK) | bit, priv->base + IMSK);
+	raw_spin_unlock(&priv->lock);
+}
+
+static void rzfive_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					     unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	raw_spin_lock(&priv->lock);
+	writel_relaxed(readl_relaxed(priv->base + IMSK) & ~bit, priv->base + IMSK);
+	raw_spin_unlock(&priv->lock);
+}
+
+static void rzfive_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					    unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	raw_spin_lock(&priv->lock);
+	writel_relaxed(readl_relaxed(priv->base + TMSK) | bit, priv->base + TMSK);
+	raw_spin_unlock(&priv->lock);
+}
+
+static void rzfive_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					      unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	raw_spin_lock(&priv->lock);
+	writel_relaxed(readl_relaxed(priv->base + TMSK) & ~bit, priv->base + TMSK);
+	raw_spin_unlock(&priv->lock);
+}
+
+static void rzfive_irqc_mask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+	irq_chip_mask_parent(d);
+}
+
+static void rzfive_irqc_unmask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+	irq_chip_unmask_parent(d);
+}
+
+static void rzfive_tint_irq_endisable(struct irq_data *d, bool enable)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ) {
+		u32 offset = hwirq - IRQC_TINT_START;
+		u32 tssr_offset = TSSR_OFFSET(offset);
+		u8 tssr_index = TSSR_INDEX(offset);
+		u32 reg;
+
+		if (enable)
+			rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+		else
+			rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+		raw_spin_lock(&priv->lock);
+		reg = readl_relaxed(priv->base + TSSR(tssr_index));
+		if (enable)
+			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
+		else
+			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	} else {
+		if (enable)
+			rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+		else
+			rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+	}
+}
+
+static void rzfive_irqc_irq_disable(struct irq_data *d)
+{
+	rzfive_tint_irq_endisable(d, false);
+	irq_chip_disable_parent(d);
+}
+
+static void rzfive_irqc_irq_enable(struct irq_data *d)
+{
+	rzfive_tint_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
 static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	unsigned int hw_irq = irqd_to_hwirq(d);
@@ -321,7 +432,7 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 	.resume		= rzg2l_irqc_irq_resume,
 };
 
-static const struct irq_chip irqc_chip = {
+static const struct irq_chip rzg2l_irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
 	.irq_mask		= irq_chip_mask_parent,
@@ -338,6 +449,23 @@ static const struct irq_chip irqc_chip = {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
 
+static const struct irq_chip rzfive_irqc_chip = {
+	.name			= "rzfive-irqc",
+	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_mask		= rzfive_irqc_mask,
+	.irq_unmask		= rzfive_irqc_unmask,
+	.irq_disable		= rzfive_irqc_irq_disable,
+	.irq_enable		= rzfive_irqc_irq_enable,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
 static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 			    unsigned int nr_irqs, void *arg)
 {
@@ -369,7 +497,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (hwirq > (IRQC_NUM_IRQ - 1))
 		return -EINVAL;
 
-	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
 					    (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
@@ -401,7 +529,8 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	return 0;
 }
 
-static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
+static int rzg2l_irqc_init_helper(struct device_node *node, struct device_node *parent,
+				  const struct irq_chip *irq_chip)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
@@ -422,6 +551,8 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
+	rzg2l_irqc_data->irqchip = irq_chip;
+
 	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
@@ -472,8 +603,21 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
+static int __init rzg2l_irqc_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return rzg2l_irqc_init_helper(node, parent, &rzg2l_irqc_chip);
+}
+
+static int __init rzfive_irqc_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return rzg2l_irqc_init_helper(node, parent, &rzfive_irqc_chip);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
 IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-- 
2.34.1


