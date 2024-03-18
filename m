Return-Path: <linux-kernel+bounces-106617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C987F105
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5221C284695
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AD57866;
	Mon, 18 Mar 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x34RSSk9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fjKECsEt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972D5787B;
	Mon, 18 Mar 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792895; cv=none; b=EMZdTKt2IssEYcf8w+zXQW/zBgXeUXqJmIBZAzdCKL5LxFUA+KxZEbNygptsdPQy4fs9EcSl+CYO3rEAnUcNjeFJj8p8X4gE8aYi3Jv9hbr8ngsoPUsZ7H63iASY6WnikU92IaXRRMqF/wH4xQWWoQLG0a9jX0UfIqX9V1RsS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792895; c=relaxed/simple;
	bh=VTT+EYQa5xyYiHELKKQlC+hM2bKjlq79yK4S9abZCBk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pWwTGj1nQ37XPEEUYQNZUE7jiuIjWI2rAsIHiwnNmLzc+xbfLmzXd/9FfraB9rNSYTZCjzNemApCcxxI6wBDPRSlMjJp5fbhikeACLjppDprwADENUy4SiyiVMuEEDXrxTrte9jKxYTz87e1I5jnBpBWo33FZKxI/QFq2Is3h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x34RSSk9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fjKECsEt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 20:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710792891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=E7ARMqLvSPPFaO6OAB9+eIo33ZYK9A92oxpgVLqg1fY=;
	b=x34RSSk9vNatyJKEG4+eruW5z73H9kaSHkqZnRi5dAkFdXDTIxnhALJSefTbIslkC3MLoF
	Gy/xCmslSOpCVyWM0NUFdxlt/AEmreYPyGDzXjOpxW2zuYlKHwJVY/4mGwqDF0zOnMWZn3
	/4NegsJm3i4dvzUdti+sI7iAO7bnoR306N7WnxU1GYwNG2ZudfcNQO5S/1kRvahBK/JZD3
	sm8cj/W62Og47kLE77ZtW/VbSZ84+ssZ24uwL7HfUwI3M+DhnN+KDyb/AMX6xERVAJaeCn
	9tS+81a/OnsV82QA4cVxRkegvRUK5Hp5r9mhP+KlUt8fzVbjQszOOOWSNU0vAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710792891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=E7ARMqLvSPPFaO6OAB9+eIo33ZYK9A92oxpgVLqg1fY=;
	b=fjKECsEtOqAstJZe6OTE+5NWXTAGr96wE7x0C+9o/oA2dr4hdWPV4yq9oKetIvOKN/9x1B
	UK3t3i2Iqikm8dBg==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-rzg2l: Do not set TIEN and TINT
 source at the same time
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171079288966.10875.228901571490481295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     dce0919c83c325ac9dec5bc8838d5de6d32c01b1
Gitweb:        https://git.kernel.org/tip/dce0919c83c325ac9dec5bc8838d5de6d32c01b1
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 18 Mar 2024 08:50:40 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Mar 2024 21:09:02 +01:00

irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time

As per the hardware team, TIEN and TINT source should not set at the same
time due to a possible hardware race leading to spurious IRQ.

Currently on some scenarios hardware settings for TINT detection is not in
sync with TINT source as the enable/disable overrides source setting value
leading to hardware inconsistent state. For eg: consider the case GPIOINT0
is used as TINT interrupt and configuring GPIOINT5 as edge type. During
rzg2l_irq_set_type(), TINT source for GPIOINT5 is set. On disable(),
clearing of the entire bytes of TINT source selection for GPIOINT5 is same
as GPIOINT0 with TIEN disabled. Apart from this during enable(), the
setting of GPIOINT5 with TIEN results in spurious IRQ as due to a HW race,
it is possible that IP can use the TIEN with previous source value
(GPIOINT0).

So, just update TIEN during enable/disable as TINT source is already set
during rzg2l_irq_set_type(). This will make the consistent hardware
settings for detection method tied with TINT source and allows to simplify
the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 8803fac..ae67fec 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -151,7 +151,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -163,7 +163,6 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
@@ -172,7 +171,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}

