Return-Path: <linux-kernel+bounces-117504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1288AC08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B2A1F34640
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A314C586;
	Mon, 25 Mar 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xWT2khX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkCHKb17"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50E14A4F9;
	Mon, 25 Mar 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385216; cv=none; b=eDiEuJzs5sqhDFtaRd2T6R6vLqFU83dTiNvZGKLjCqPhrAd5iypVLxZJasnToOLIpO83fJgEAUJy+CMXEu/cgrzKlyMbWsrDpHCrHEVzMTGiW1rw9yU44YuWGms2f7Wo6clMqz9svZ+1HE2HImQEshAbW+wjyS8PgfJ6ihZ78DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385216; c=relaxed/simple;
	bh=J+36lp0gdXkJUsBG/bMVoEt5BGuwFPhWNWXFyIVqWZU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T6DycFmRXTxnAGWSUmZzd5824iGXiroJzK7H6p9w8vFHYhCXMj50/VAeKOsWV6cvcL+ghowefRn8Ij3gzq0lNiRcez+nbfIiTHIRTW+boNuREmFdQ3Fc6X8OfEPMkSKDleJdJUZyYCJcPuxyMwAU5RI5G8xt8bWpZKuX27VFEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xWT2khX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkCHKb17; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PSl27hYqmhD11De4k++XRL2xdjLPYz8sRLTC4lTNNmY=;
	b=4xWT2khXRV+wMvS2DS0qKvq6Jaz8rbSWEp9cJqKLrZXXsMW/gFqDLK6+rg3ITBz3m+Czkw
	7IePGCnz4wWaTsaiZi9jHMZu22DvdHbT+BiHCIkusj+oGx3wfvHZgih8lujhcBL0q44anj
	SnT/EHQsD+m6c3fxNVhhxnjpNCVCY7/9Sc9A70CWBW9VbGAX0i/9U7fovPu63ItehjNBZ+
	QydDPFgwqae1BUmJbr18yS//RNOBtN5ISSD1g6w19pX6n4Gxp7lB6T77Sa5T4i3pmkvwDJ
	4YOHG5f6Hu8RBoBKMtk8RNU5sXoSy4/PemxNy3svwCboNGrQnM4DMu2Y1jHIxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PSl27hYqmhD11De4k++XRL2xdjLPYz8sRLTC4lTNNmY=;
	b=pkCHKb177HcHjb9t1f8Ixyc0H3MxQGnV/S7YYmk0G/Unp6z1BNWpU3oPMlUxmr8Y8lqFg+
	hGqkqFODwt1ZYxCA==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138521269.10875.198902082430228575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     46efb3053f4f23357e9e29f8abaa6f801d956a0c
Gitweb:        https://git.kernel.org/tip/46efb3053f4f23357e9e29f8abaa6f801d956a0c
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 18 Mar 2024 08:50:41 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:28 +01:00

irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()

Simplify rzg2l_irqc_irq_{en,dis}able() by moving common code to
rzg2l_tint_irq_endisable().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-renesas-rzg2l.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index ae67fec..f6484bf 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -138,7 +138,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
-static void rzg2l_irqc_irq_disable(struct irq_data *d)
+static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
@@ -151,30 +151,24 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
+		if (enable)
+			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
+		else
+			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
+}
+
+static void rzg2l_irqc_irq_disable(struct irq_data *d)
+{
+	rzg2l_tint_irq_endisable(d, false);
 	irq_chip_disable_parent(d);
 }
 
 static void rzg2l_irqc_irq_enable(struct irq_data *d)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d);
-
-	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		u32 offset = hw_irq - IRQC_TINT_START;
-		u32 tssr_offset = TSSR_OFFSET(offset);
-		u8 tssr_index = TSSR_INDEX(offset);
-		u32 reg;
-
-		raw_spin_lock(&priv->lock);
-		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
-		writel_relaxed(reg, priv->base + TSSR(tssr_index));
-		raw_spin_unlock(&priv->lock);
-	}
+	rzg2l_tint_irq_endisable(d, true);
 	irq_chip_enable_parent(d);
 }
 

