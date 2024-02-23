Return-Path: <linux-kernel+bounces-78052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF292860E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64660287030
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06945D732;
	Fri, 23 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yylbvwLu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="30kf3p2a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795F5CDC0;
	Fri, 23 Feb 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681444; cv=none; b=mrEoZ14vnXu3MI59zy+LcsQsPbldQ4S7ohJXZ04IN4+YC3lT8OYtjG7RDoouYzTXv7ieGsVSy1MKjiVEWWk7fh3QjFpeBFFtirhKnjtWuX1KSctXBk/S8GVSP7CgtqaDX3Cp0ehBtztBvZdFPYlY9xH+h/hUEaWScWlLBK1oDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681444; c=relaxed/simple;
	bh=8feJWVA7p/+z8RsG5iMN/dzMMMUdnlPOTNO9Crw6kl8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R3mcfeY2h6Z2tmsoxC2kAvy9IXu5CYPDTJtXr+x8wjsK9UoHZI0nDp1vA7czbnsIE0aFYXgC68XxY4cYp4+l+sGsQhFSjNmgbnKe5h41y+Hrb8DQJqqvSbVdTYpaOMuF2UNzY6D8o7QBxgRLGdlYwSevA/2WCSR1M+PJlqIRWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yylbvwLu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=30kf3p2a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYvcA3L3zb8ljbTPM4WuVk9ouPcZlIpmvcUp9ql5yrY=;
	b=yylbvwLu+WbJ5r9vtxXALuoP/S2H5r04mRX3/athaTd76qBaj4QwqNHsBLkcCWTuOEZWyG
	/4MAUL/hXxcOeY6LrSpHaMkq75hg4FkKBMKrJDagHfrSunkddR2TMQddxoc+aSFJzHPiZz
	LAyFTNoGb+XHz6YvYx3h0Ki1x7o6hbUnmjPBAP30HuTHr5ZKeyLOoLLMnk7mUts6YL7HTS
	ZCUFq4cZaDtjKmLZfdleVbS1ytwpqlrYp3MiQZ4tg43dseUS/lo0fMTL0fBR3wyU9U3oIo
	9qd+J728ju8tBR+d7of7tfftQ9iSfa3vZ8XE7ONW9JEvF5O2XMHZ0TSnsXUrbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYvcA3L3zb8ljbTPM4WuVk9ouPcZlIpmvcUp9ql5yrY=;
	b=30kf3p2a4KmA/W8+alFkulu+pxreIaeqxjRQ9r8Ev7D/yELWvXY4M2pKlyP4GsXtkJKsJN
	XARNTjXr78442oAQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/sifive-plic: Use riscv_get_intc_hwnode() to
 get parent fwnode
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-5-apatel@ventanamicro.com>
References: <20240222094006.1030709-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143581.398.2923102025107113775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     6c725f33d67b53f2d302c2c4509deae953fc6ade
Gitweb:        https://git.kernel.org/tip/6c725f33d67b53f2d302c2c4509deae953fc6ade
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:52 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:44 +01:00

irqchip/sifive-plic: Use riscv_get_intc_hwnode() to get parent fwnode

The RISC-V INTC irqdomain is always the parent irqdomain of SiFive PLIC
so use riscv_get_intc_hwnode() to get the parent fwnode similar to other
RISC-V drivers which use local interrupts.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-5-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 299feef..208fad7 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -423,6 +423,7 @@ static int plic_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
+	struct irq_domain *domain;
 	struct plic_priv *priv;
 	bool cpuhp_setup;
 	unsigned int cpu;
@@ -502,11 +503,11 @@ static int plic_probe(struct platform_device *pdev)
 		}
 
 		/* Find parent domain and register chained handler */
-		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(to_of_node(dev->fwnode), i);
+		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+		if (!plic_parent_irq && domain) {
+			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq,
-							plic_handle_irq);
+				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
 		}
 
 		/*

