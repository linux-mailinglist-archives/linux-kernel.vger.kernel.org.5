Return-Path: <linux-kernel+bounces-106077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478A87E8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D02B2223E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA4381B1;
	Mon, 18 Mar 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3cQ2pUl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dNttC5sf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB3364BF;
	Mon, 18 Mar 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761404; cv=none; b=hghhl19HFw0Uq8Bdyk5qqO18XQ2lnjQU5THhl7tz+IpYjcvTz4D3Wve8CTDM0RfO0KvctwI6UspjyDLPOmLo1uY7YX46odFWYf5z7y8vKBGXbuWMg288l6yYyqOr2xn0xwryqqngkfshE6mEMJl46zRIgSh9UfECfAd1AHpvCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761404; c=relaxed/simple;
	bh=9EUikzTbB5AZPjU8MDEIPNc5i+9xHy0MeZbht+EE10U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cdxgxVUoGnncGnylFn5WxA58zQsnqDodtDeGIcDYgmIJP8FYbzujqU4AzhmOUNjgQypmcWVGoTEUsQiUvXw4746SoeOUK83/KY/NRsMeyrUdC+9dxox+DsXyY22EUkTZUjfQf/D3SqFm5NT7ajy8ronSxV5WboJANQdsGJl7lTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3cQ2pUl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dNttC5sf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 11:30:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710761401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JqxDAwUVY7wlN2hqF1fz+b6FSzNLfLPguymOh/7+2Eo=;
	b=s3cQ2pUlTOrD5+dv7TZnptrwZzl8wyr2vfXx7w2Qve96TpXznw7G97Z4s2P857xqXM3hqe
	P87ee4Ri3PnulfEOq5ox1xvT+wMUbXoGwayJYQL2FqqqLgZ5OhFONx4b+Hh+X/ZoTHQ+om
	ljijV6FTmEbhy7ml2JCAC16Ubg/ku8jSY/TkNZMtNDKWc05ANUn6BGuFVD4V1+a/7oDF+U
	PpxVMECjbJnukyAYGesbGIwHQH5DJr5Hd1qeLnZa0bwRkM18zUNr15gJq5kqP2QXGkk3rB
	gaQo5QGMSiscqQUnz1xnOx7O+s8QxCc7CbVIWS1fAaW8/BpxbVNImTv0TX0jIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710761401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JqxDAwUVY7wlN2hqF1fz+b6FSzNLfLPguymOh/7+2Eo=;
	b=dNttC5sfNm+MhmjLgoDVxxSb4WCQjR8QbArBiTT1oT/MgrBwxNlZn+YC5ERGfrNl+8n0CI
	ZYYEueQcbIcpsDDg==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171076140083.12214.646106275166279278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9eec61df55c51415409c7cc47e9a1c8de94a0522
Gitweb:        https://git.kernel.org/tip/9eec61df55c51415409c7cc47e9a1c8de94a0522
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 05 Mar 2024 18:39:18 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Mar 2024 12:20:01 +01:00

irqchip/renesas-rzg2l: Flush posted write in irq_eoi()

The irq_eoi() callback of the RZ/G2L interrupt chip clears the relevant
interrupt cause bit in the TSCR register by writing to it.

This write is not sufficient because the write is posted and therefore not
guaranteed to immediately clear the bit. Due to that delay the CPU can
raise the just handled interrupt again.

Prevent this by reading the register back which causes the posted write to
be flushed to the hardware before the read completes.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 9494fc2..5285bc8 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -99,8 +99,14 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
 	 * falling/rising-edge.
 	 */
-	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq))) {
 		writel_relaxed(iscr & ~bit, priv->base + ISCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + ISCR);
+	}
 }
 
 static void rzg2l_tint_eoi(struct irq_data *d)
@@ -111,8 +117,14 @@ static void rzg2l_tint_eoi(struct irq_data *d)
 	u32 reg;
 
 	reg = readl_relaxed(priv->base + TSCR);
-	if (reg & bit)
+	if (reg & bit) {
 		writel_relaxed(reg & ~bit, priv->base + TSCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + TSCR);
+	}
 }
 
 static void rzg2l_irqc_eoi(struct irq_data *d)

