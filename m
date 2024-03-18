Return-Path: <linux-kernel+bounces-106076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E058987E8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9142826D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C4376F4;
	Mon, 18 Mar 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsw+ie/O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10EHCQ4H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E7364BA;
	Mon, 18 Mar 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761404; cv=none; b=BV84gebu5cl6HHm2c1qpsXlegkWibPgccjApWfjFAjUfBRdju/LE03uFv5O21sBYginkQ+7F4tJvb93CI9acHRGtI7zcJJD8IPhwtVRIZZwWTO6nnxrstnDjTSzezoV3QTFprcu9ibieDTCeCfnYgX76MhCRR1MluygjVADn524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761404; c=relaxed/simple;
	bh=9dtvIqUxii3KjFGL0WlAd2yNhKPva3ctV9h6ZsKCn9U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NnQ7tVj/JMZi1BB1RUh2JnEzSiULDe0ZYSgBYUAvlCfDfNIgaa/0+lCslDSx7qxKvl/IQNvT3FfLttsUyeYmyVAG7kvqMlGDh6FNWmA6u2Kp2ACnhLKXt+XdYA8L4whNgnkKbEpj+gNmzgqqBvc+TE+rREaPyTtguikbkeXRZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bsw+ie/O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10EHCQ4H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 11:30:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710761401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YhInGbyk7L3x92nSWGcdTv/1YgehJ+r5pZC7geBgmtk=;
	b=bsw+ie/OdOLNXMKmbIzuHrpGcLwj9VSZyIPfJQgPX9ITeNIH6k3nPYE0aoyeoVkDBXAG2J
	PthIIT6gMZWGwUgilWN+rMUUisuZRaSFEbf8qP3eWePn6bHJo+bn3bmvGFKgUZ3Jk1yj0C
	TutS+BlhfQizuotOTJkWX+GJgDmg4JJbXzsRnrFJ8AiN2jCMC1QiGE1L2D514xAcOe7t5u
	q0PuMSLO4YbbBnYVt3FryIDA7iXtiY0nsXIiO1VKvHiKFRvoUMGrhwJeu1YBDg4jZdCwWo
	6045g6QkMZKCi1dB5Djb7Cbpm3bRiyCi5F1p9obTUgA1ULx+h5rU4FUMyrPaLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710761401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YhInGbyk7L3x92nSWGcdTv/1YgehJ+r5pZC7geBgmtk=;
	b=10EHCQ4HwltLZNbzPmlyyvBFYGfc6hIygztltWClP7H9Tbb7eJhKBxyS+LEJxOLcwq0s8t
	rA5QQEfts6EfjJBA==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171076140013.12214.1453479926664332491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7cb6362c63df233172eaecddaf9ce2ce2f769112
Gitweb:        https://git.kernel.org/tip/7cb6362c63df233172eaecddaf9ce2ce2f769112
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 05 Mar 2024 18:39:19 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Mar 2024 12:20:01 +01:00

irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()

Rename rzg2l_tint_eoi()->rzg2l_clear_tint_int() and simplify the code by
removing redundant priv and hw_irq local variables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
 drivers/irqchip/irq-renesas-rzg2l.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 5285bc8..599e0ab 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -109,11 +109,9 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	}
 }
 
-static void rzg2l_tint_eoi(struct irq_data *d)
+static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-	u32 bit = BIT(hw_irq);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
 	u32 reg;
 
 	reg = readl_relaxed(priv->base + TSCR);
@@ -136,7 +134,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
 		rzg2l_irq_eoi(d);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
-		rzg2l_tint_eoi(d);
+		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
 	irq_chip_eoi_parent(d);
 }

