Return-Path: <linux-kernel+bounces-106074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B311E87E8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBBE1F229F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194C37162;
	Mon, 18 Mar 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="isITnJiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwxiPNYf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A27364A1;
	Mon, 18 Mar 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761403; cv=none; b=mfiUuQnHJlxK1zghhzGTv9PwF8PgXIGURygRNrIJcTYI4/ZHyo4fye2+JErKdvQ8oI8eOkLNBo3qQz6kQKVSur5vxI9HdTea3vPhljKpsV3icDb9RwKAWXt34NSPpHIRKQJ5LnvW/Ie+XtBJCDjMKA+WyG3QSU7Cl8WsBqKDJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761403; c=relaxed/simple;
	bh=tdcQ++P+ToDYfCBb357pG/U08ihUbMq9x08i8dYkaCo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dhfs/RfkVAlV01ehvy89Kl9OuFf571M1/qrvQhV/Wp8mMMZcKylnrROpKbkgIIqg+e5cGaC9M08q6QuQ2MOlBc968eQKrJgWI7eUDTZP53Q+HBpbcAuK1U7CBgRwqRMiWDoxTgMSyQ4hk3AeyyoGoicxLJahFK0Gh8JuumwdPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=isITnJiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwxiPNYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 11:29:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710761399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/8OqvJOiR+gUhNGjsiX0QbvBXg0qPjxmHfTidJDgSUc=;
	b=isITnJiqNFAxiGB9GJYeaphYuSgWgL4jGrKpqNPZbrReaWMg48m7wqJjEaMpqXThZiJiEM
	dyZ/6KaWvdx1nDQ4a+1E1YIRgGoQynC+eNdyWlC4Mo3/WJPCYF9ndn3xgRSnBZOzkkwtvU
	tw6W96OKVIe7/5D8cm/RNeBLOTIl3PzjX9ZpMbXJ3FvsC9wZYbfkDCCsf3cvg8STBsljjn
	C3zwCiGHZkXuwRr1O/kWHW6h/ljzaFj97VJvaD+9h2B6AuMBlF41NDTdlRfBjaInn/tUbc
	FquOMAAr8mkRhrCv0iFQzJ4LFn+GNpnzWXMmKk3R4vAspsqau3DdPR52XZSKgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710761399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/8OqvJOiR+gUhNGjsiX0QbvBXg0qPjxmHfTidJDgSUc=;
	b=ZwxiPNYf04nE4ia6tt9etjOe3X7seDkLKyZ1RDodcKgL3Lzp3NAujpqXFPFGV4B1xejVEf
	UT0KoGfcS6DWnDCA==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-rzg2l: Prevent spurious interrupts
 when setting trigger type
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171076139877.12214.14972185748812910207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     853a6030303f8a8fa54929b68e5665d9b21aa405
Gitweb:        https://git.kernel.org/tip/853a6030303f8a8fa54929b68e5665d9b21aa405
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 05 Mar 2024 18:39:21 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Mar 2024 12:20:01 +01:00

irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type

RZ/G2L interrupt chips require that the interrupt is masked before changing
the NMI, IRQ, TINT interrupt settings. Aside of that, after setting an edge
trigger type it is required to clear the interrupt status register in order
to avoid spurious interrupts.

The current implementation fails to do either of that and therefore is
prone to generate spurious interrupts when setting the trigger type.

Address this by:

  - Ensuring that the interrupt is masked at the chip level across the
    update for the TINT chip

  - Clearing the interrupt status register after updating the trigger mode
    for edge type interrupts

[ tglx: Massaged changelog and reverted the spin_lock_irqsave() change as
  	the set_type() callback is always called with interrupts disabled. ]

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 36 ++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 8133f05..8803fac 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -181,8 +181,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 iitseln = hwirq - IRQC_IRQ_START;
+	bool clear_irq_int = false;
 	u16 sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -192,14 +194,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	case IRQ_TYPE_EDGE_FALLING:
 		sense = IITSR_IITSEL_EDGE_FALLING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
 		sense = IITSR_IITSEL_EDGE_RISING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		sense = IITSR_IITSEL_EDGE_BOTH;
+		clear_irq_int = true;
 		break;
 
 	default:
@@ -208,21 +213,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&priv->lock);
 	tmp = readl_relaxed(priv->base + IITSR);
-	tmp &= ~IITSR_IITSEL_MASK(hw_irq);
-	tmp |= IITSR_IITSEL(hw_irq, sense);
+	tmp &= ~IITSR_IITSEL_MASK(iitseln);
+	tmp |= IITSR_IITSEL(iitseln, sense);
+	if (clear_irq_int)
+		rzg2l_clear_irq_int(priv, hwirq);
 	writel_relaxed(tmp, priv->base + IITSR);
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
 }
 
+static u32 rzg2l_disable_tint_and_set_tint_source(struct irq_data *d, struct rzg2l_irqc_priv *priv,
+						  u32 reg, u32 tssr_offset, u8 tssr_index)
+{
+	u32 tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	u32 tien = reg & (TIEN << TSSEL_SHIFT(tssr_offset));
+
+	/* Clear the relevant byte in reg */
+	reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+	/* Set TINT and leave TIEN clear */
+	reg |= tint << TSSEL_SHIFT(tssr_offset);
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
+
+	return reg | tien;
+}
+
 static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
+	u32 tssr_offset = TSSR_OFFSET(titseln);
+	u8 tssr_index = TSSR_INDEX(titseln);
 	u8 index, sense;
-	u32 reg;
+	u32 reg, tssr;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -244,10 +268,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	}
 
 	raw_spin_lock(&priv->lock);
+	tssr = readl_relaxed(priv->base + TSSR(tssr_index));
+	tssr = rzg2l_disable_tint_and_set_tint_source(d, priv, tssr, tssr_offset, tssr_index);
 	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
 	writel_relaxed(reg, priv->base + TITSR(index));
+	rzg2l_clear_tint_int(priv, hwirq);
+	writel_relaxed(tssr, priv->base + TSSR(tssr_index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;

