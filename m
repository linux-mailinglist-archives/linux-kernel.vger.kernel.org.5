Return-Path: <linux-kernel+bounces-154079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FEA8AD72E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA88F282495
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4120310;
	Mon, 22 Apr 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ccv9u4GM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0QUuITKC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7C1CD37;
	Mon, 22 Apr 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824371; cv=none; b=l7HH7BXtEUdGklUa2jlW8wHjeMRu9E92GGepk2O5Jnhoy4W8jWlouS1gwv2tyEBB63A41GoqDLlwEXc8eZuD4yFWEzty4XqXbflBMAo6V09xmXjgtICTtS7+2wWnNc4VXklvVofnpXpo9GX1JtGdjB37iBNA79vxFbDk2cnIXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824371; c=relaxed/simple;
	bh=qqegLKgo/ihWw3Hceo56LWOeRytok6kI9/Ok5rMbTBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sDTR9xONKBRFmZMgrP1PXeN0z0Q5R7pFMTlamI6J8hxUJ9cUak130HpEn+wvXgEoj/7dmCnP476OdFn4eV+KwOBmnfzkKetJ6WbnsXMCD2MQ6o25OdKlAa//S8KceExdCawgeJC1eBgW7ykuRM4Nl1NRvL1ZpYlMgIVv1kFl+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ccv9u4GM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0QUuITKC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:19:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713824367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHH02xEMrDT9oI9qv+xGM49wTTtaHmdR3bOEiicwYo0=;
	b=ccv9u4GMMUZWkHCSUUrAicTR2b3SMzHAhY0YEEzXosbQb1Zi0NKeVA7aL+aNjmTtNlyEcd
	hzs70MeKOrdtCHsmCbxaGcvjoe0l4XCjcbJPqzcbaigTN8xyP7eHBTdFnXPmTW9si/9SyF
	qwyFwmpaHxJw6jdzDq83a0B+dVZbQ2Lc1QIGguif0a7edF0ojBwe2o6JwixEWfJG5+PkQG
	c7v0jmVqJ5LLclRHhtn0tFUyPN91cf4/t2ImUApAe7uRcdlU1l1gTl3ApAmgwIn4BYvs82
	7mY090rormnYL8BsfXPBWSUtq8NKaFZ2kGwaMKBsKbTX0gAwoqyWSx4kax5eDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713824367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHH02xEMrDT9oI9qv+xGM49wTTtaHmdR3bOEiicwYo0=;
	b=0QUuITKCqvZIHAxa/JynT2TpWsHSo+Te4PbLmpU4VCqcUkTKsiu8wS1+pcorqz1IOXd/ap
	fCRzfEsRLwJNUkAw==
From: "tip-bot2 for Baoqi Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-pch-pic: Update interrupt
 registration policy
Cc: Biao Dong <dongbiao@loongson.cn>,
 Tianyang Zhang <zhangtianyang@loongson.cn>,
 Baoqi Zhang <zhangbaoqi@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240422093830.27212-1-zhangtianyang@loongson.cn>
References: <20240422093830.27212-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382436603.10875.2620954465917194877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     234a557e28b9142e07eae21083a04fffef83ee8d
Gitweb:        https://git.kernel.org/tip/234a557e28b9142e07eae21083a04fffef83ee8d
Author:        Baoqi Zhang <zhangbaoqi@loongson.cn>
AuthorDate:    Mon, 22 Apr 2024 17:38:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:17:07 +02:00

irqchip/loongson-pch-pic: Update interrupt registration policy

The current code is using a fixed mapping between the LS7A interrupt source
and the HT interrupt vector. This prevents the utilization of the full
interrupt vector space and therefore limits the number of interrupt source
in a system.

Replace the fixed mapping with a dynamic mapping which allocates a
vector when an interrupt source is set up. This avoids that unused
sources prevent vectors from being used for other devices.

Introduce a mapping table in struct pch_pic, where each interrupt source
will allocate an index as a 'hwirq' number from the table in the order of
application and set table value as interrupt source number. This hwirq
number will be configured as vector in the HT interrupt controller. For an
interrupt source, the validity period of the obtained hwirq will last until
the system reset.

Co-developed-by: Biao Dong <dongbiao@loongson.cn>
Signed-off-by: Biao Dong <dongbiao@loongson.cn>
Co-developed-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240422093830.27212-1-zhangtianyang@loongson.cn

---
 drivers/irqchip/irq-loongson-pch-pic.c | 76 +++++++++++++++++++------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 63db8e2..cbaef65 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -33,6 +33,7 @@
 #define PIC_COUNT		(PIC_COUNT_PER_REG * PIC_REG_COUNT)
 #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
 #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
+#define PIC_UNDEF_VECTOR	255
 
 static int nr_pics;
 
@@ -46,12 +47,19 @@ struct pch_pic {
 	u32			saved_vec_en[PIC_REG_COUNT];
 	u32			saved_vec_pol[PIC_REG_COUNT];
 	u32			saved_vec_edge[PIC_REG_COUNT];
+	u8			table[PIC_COUNT];
+	int			inuse;
 };
 
 static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
 
 struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
+static inline u8 hwirq_to_bit(struct pch_pic *priv, int hirq)
+{
+	return priv->table[hirq];
+}
+
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -80,45 +88,47 @@ static void pch_pic_mask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
 
-	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
+	pch_pic_bitset(priv, PCH_PIC_MASK, hwirq_to_bit(priv, d->hwirq));
 	irq_chip_mask_parent(d);
 }
 
 static void pch_pic_unmask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+	int bit = hwirq_to_bit(priv, d->hwirq);
 
-	writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	writel(BIT(PIC_REG_BIT(bit)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
 
 	irq_chip_unmask_parent(d);
-	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
+	pch_pic_bitclr(priv, PCH_PIC_MASK, bit);
 }
 
 static int pch_pic_set_type(struct irq_data *d, unsigned int type)
 {
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+	int bit = hwirq_to_bit(priv, d->hwirq);
 	int ret = 0;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitclr(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitset(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitclr(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitset(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	default:
@@ -133,11 +143,12 @@ static void pch_pic_ack_irq(struct irq_data *d)
 {
 	unsigned int reg;
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+	int bit = hwirq_to_bit(priv, d->hwirq);
 
-	reg = readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) * 4);
-	if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
-		writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	reg = readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(bit) * 4);
+	if (reg & BIT(PIC_REG_BIT(bit))) {
+		writel(BIT(PIC_REG_BIT(bit)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
 	}
 	irq_chip_ack_parent(d);
 }
@@ -159,6 +170,8 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 {
 	struct pch_pic *priv = d->host_data;
 	struct device_node *of_node = to_of_node(fwspec->fwnode);
+	unsigned long flags;
+	int i;
 
 	if (of_node) {
 		if (fwspec->param_count < 2)
@@ -171,12 +184,33 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 			return -EINVAL;
 
 		*hwirq = fwspec->param[0] - priv->gsi_base;
+
 		if (fwspec->param_count > 1)
 			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 		else
 			*type = IRQ_TYPE_NONE;
 	}
 
+	raw_spin_lock_irqsave(&priv->pic_lock, flags);
+	/* Check pic-table to confirm if the hwirq has been assigned */
+	for (i = 0; i < priv->inuse; i++) {
+		if (priv->table[i] == *hwirq) {
+			*hwirq = i;
+			break;
+		}
+	}
+	if (i == priv->inuse) {
+		/* Assign a new hwirq in pic-table */
+		if (priv->inuse >= PIC_COUNT) {
+			pr_err("pch-pic domain has no free vectors\n");
+			raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
+			return -EINVAL;
+		}
+		priv->table[priv->inuse] = *hwirq;
+		*hwirq = priv->inuse++;
+	}
+	raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
+
 	return 0;
 }
 
@@ -194,6 +228,9 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		return err;
 
+	/* Write vector ID */
+	writeb(priv->ht_vec_base + hwirq, priv->base + PCH_INT_HTVEC(hwirq_to_bit(priv, hwirq)));
+
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param_count = 1;
 	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
@@ -222,7 +259,7 @@ static void pch_pic_reset(struct pch_pic *priv)
 
 	for (i = 0; i < PIC_COUNT; i++) {
 		/* Write vector ID */
-		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
+		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(hwirq_to_bit(priv, i)));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
 	}
@@ -284,6 +321,7 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 			u32 gsi_base)
 {
 	struct pch_pic *priv;
+	int i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -294,6 +332,10 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 	if (!priv->base)
 		goto free_priv;
 
+	priv->inuse = 0;
+	for (i = 0; i < PIC_COUNT; i++)
+		priv->table[i] = PIC_UNDEF_VECTOR;
+
 	priv->ht_vec_base = vec_base;
 	priv->vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
 	priv->gsi_base = gsi_base;

