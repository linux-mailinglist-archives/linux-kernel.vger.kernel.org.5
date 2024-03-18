Return-Path: <linux-kernel+bounces-106075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1587E8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCCC1C21338
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E337165;
	Mon, 18 Mar 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOSQeZ7L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZJIJrz6V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824C364A5;
	Mon, 18 Mar 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761403; cv=none; b=rwxiriPmNLb2FPk1d3xAMsmvoII09JZWgew+rTxNqTXeZw5QygQGr/R7vGzTm77i9B6oWDi7gdgYqYqgI4fUYFmOtA/xNGUixhoVkcVif16hoDfCv1KZdVIU4EFQeqzF+OVX9+FGJ+en20nGYj15xxjr3X7M6dETZpQzYcVr4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761403; c=relaxed/simple;
	bh=Cc+Y2s39wTbCc9QtugqFeqigRiQlpu/M+4LyuNvXYyw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tudhxJhz/URtfY8RxPO5NFhUbIE+EYmfCHeybMXNtE6EpLyIJZ/ZkzLnlbzrvoUJySDUCexbLjEz1tMXNz07FvXSmzUSYPLqMSrOEkHIM1U4hrrdcE7DPlW24aJnXeoU37QE8lz3Oa3yDPMcx3tq4SnlgTnQUfNDuEhKTXNv320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOSQeZ7L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZJIJrz6V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 11:29:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710761400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lHv+hOuyeAed1zWZqJcAd8UUxUGKXXKvj75zinnX3Vs=;
	b=tOSQeZ7L6D7fYlhDjajjmje1QUcDgd0afYgnjnv6lRD7uLFmmHBfBz60cOLCt88uKOUGC2
	yMPHwWi7e0ejKWlsFf2/p65LHZsyzzTrZX1S3dh940jVAKX7cJYu96fq9nSvX2bvc/1t/t
	yfc9UxCkKaefmBPm/F9bmlHOYpyTfAfwoxIjYccJe5o8K/IAcLLTzUMTB05ie0dEeCC1ag
	NaaxRiH7jj+tWg6gha5zMukv/wOCxnZMqAzIgP8qZ1e96mCGuQoY1W5VSOqfuC44y1eotp
	iBFOY+cn6RoT5krnyRNn1occ8dHub8smL1PfgBLl5IFoFuWl18T7WZMF/7OabA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710761400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lHv+hOuyeAed1zWZqJcAd8UUxUGKXXKvj75zinnX3Vs=;
	b=ZJIJrz6VtREtRwlBoUdrdSIpwG4QfEqUgUAza5MFCmCUj7ELkrYHnpXGUN9XSaWkjbewun
	gDyE92T+W5EdN/CQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Biju Das <biju.das.jz@bp.renesas.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171076139948.12214.17282697415452486662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b4b5cd61a6fdd92ede0dc39f0850a182affd1323
Gitweb:        https://git.kernel.org/tip/b4b5cd61a6fdd92ede0dc39f0850a182affd1323
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 05 Mar 2024 18:39:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Mar 2024 12:20:01 +01:00

irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()

Rename rzg2l_irq_eoi()->rzg2l_clear_irq_int() and simplify the code by
removing redundant priv local variable.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-renesas-rzg2l.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 599e0ab..8133f05 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -85,10 +85,9 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 	return data->domain->host_data;
 }
 
-static void rzg2l_irq_eoi(struct irq_data *d)
+static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = hwirq - IRQC_IRQ_START;
 	u32 bit = BIT(hw_irq);
 	u32 iitsr, iscr;
 
@@ -132,7 +131,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
-		rzg2l_irq_eoi(d);
+		rzg2l_clear_irq_int(priv, hw_irq);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
 		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);

