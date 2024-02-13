Return-Path: <linux-kernel+bounces-63284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8473D852D40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F8E1C22316
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6037179;
	Tue, 13 Feb 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9WEYjzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="udrctsrV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E862C69A;
	Tue, 13 Feb 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818224; cv=none; b=AqyLV/4NypOBYvf+7o+rBj7y1+ev1W7hDmw10YLOqubNMhyTCOAtJxgcaugnROelND0sJFH5jCvd644+TDCyA4ZA+oC4lZ2+3W/ZoptxcY1i4jI6XZ4UZbiE9zUP+B4N0pXzGbqEGuBuP5BtKXQQTXXBN6fKJ1sCCzE0IIVPNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818224; c=relaxed/simple;
	bh=DT5Oz0ddq0A6814n/Id9rTOGVREUufiivj3OBaXGdwg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C54+0n9Y3zq+HnkUAfN4ZZKAKm43mcf8AcymES1JSdZFFek2gXLvrSpH6qQRX9VVtJGDSRXAbdB2eDHuQyIr7StQS8twuBIqUjLGLB4gvis3ZKtWKd/HKwEsX0Pip7MTV02Z60qXrrw+F2BrubBcALGA8KwUT83K0biFt8xqsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9WEYjzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=udrctsrV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 09:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707818221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViPAHRtvPOjXBMZBHTrl44RxxnL8Z+bRUcZYuXKYh3c=;
	b=c9WEYjzLrW1EhVSnslpl+dsZC6Gf5bFH0ZlVCgeUcv0CPQVzgbnVu7eHiYePIuNoJIF+bF
	FHoVhpAtbe/PZski91pHMUOdCYnU/Z30EhFtTmv+SJqN85U0eF0KiROHrPiGcWZ8ibOGJ7
	YvEZS1h5STnAfjsCUkotDZ69yqLgtfI/Xgvs9Dacj07xOXsfhf3/++TuvZUJWqneWSPh8Z
	mfyF6RAVfYu9Tc7p4czcbm6kRbmSkuylQgPn5Vl722HPdB25aJ5eRzWlp6WVnBrUwTms03
	w9wrLhDWfSLuneBYQ2e8JSewK/0qUj7io9wG0V1sbwH6W6YSsem/RCi3ioN6Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707818221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViPAHRtvPOjXBMZBHTrl44RxxnL8Z+bRUcZYuXKYh3c=;
	b=udrctsrVdbozIsKP3X2QbVvKvoY/FiDCL4uP9e5NcKPwFeJN4qwJxADXN6+FTZLXgKqmaY
	bua9M08B+udNuEBw==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-eiointc: Skip handling if there is
 no pending interrupt
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Huacai Chen <chenhuacai@loongson.cn>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240130082722.2912576-3-maobibo@loongson.cn>
References: <20240130082722.2912576-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781822030.398.1776508583120983829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3eece72ded7f67776731709702f3d1b9893b6a4f
Gitweb:        https://git.kernel.org/tip/3eece72ded7f67776731709702f3d1b9893b6a4f
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Tue, 30 Jan 2024 16:27:21 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 10:53:14 +01:00

irqchip/loongson-eiointc: Skip handling if there is no pending interrupt

eiointc_irq_dispatch() iterates over the pending bit registers of the
interrupt controller and evaluates the result even if there is no interrupt
pending in a particular 64bit chunk.

Skip handling and especially the pointless write back for clearing the
non-pending bits if a chunk is empty.

[ tglx: Massaged changelog ]

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/r/20240130082722.2912576-3-maobibo@loongson.cn

---
 drivers/irqchip/irq-loongson-eiointc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1623cd7..fad22e2 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -198,6 +198,12 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 
 	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+
+		/* Skip handling if pending bitmap is zero */
+		if (!pending)
+			continue;
+
+		/* Clear the IRQs */
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
 			int bit = __ffs(pending);

