Return-Path: <linux-kernel+bounces-136521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A0F89D51B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5165B28477C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728817F7CF;
	Tue,  9 Apr 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bNLZ6gfa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wPYA26b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19B7E792;
	Tue,  9 Apr 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653687; cv=none; b=sViWkgBbWlUtxpZoWoyWrN+74bjD+mHIN+pHF6AJyJvWr6vO5+ccUXSlsJdPqmIZGEIUqzIDaXLEmaenkH641iQZ4PpL4AtjeKc/6fVTD7p0VoMTIkv/sffBAwjmYgZZdvlVTlzgGQJ5Vwl/XQBV/bZBsgiR3RiPqsiBiDPX194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653687; c=relaxed/simple;
	bh=6FPTSUrs2qgaae2jQOZ+qgxfiQvUWEDJTPzcu9+KQwY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PV6Iw58i4jXowpyusthgSExhDVHC2zZPnF1AKfDt+/RozYI++C9EelTd0Hs2URddMueXazOqkojalq44l8uCRb8K2T3UFmq2it4KmeycELPCGIXUWcRPTriPcz8HNZGsjMLvEqChuvwykgIRzDGxhKm4yoXfIfWDJucZ3d+VlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bNLZ6gfa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wPYA26b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 09:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712653684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rg3bvrQ+GLqORPueHx2Z35GuDlJmKPJM4uKntxZwsA=;
	b=bNLZ6gfa1EXPKQwKhP1O1LQLs62Hru3nm9sq1PlsdEgh0Vc3Y3V0u4868v834DjyQ8NsX8
	NPQ5Fvs5E5oTvIRD0pKonL2ghGG/IyrYu7rKzZ8oMg0q1wQY8ON7Sx93Z9xO+fwMmwDnGM
	J+3N3BOzPOWjHhERE8hG+KF25tv5LyKEAZ3MH+Lf3T567pbnNYmwRe6fHjslF9vHCapyux
	ULiEE/2PMk4MWdbXWooaRvS4mWFNOHHCeYEI0iNjavErDjYlFTtEd8BTDtxxvnac8zJTEW
	HkErLweDjtoO6zoIxsykExO/fa38bJL+ZBnf3BAzZtRsd3cGmeDhkNXpCtZbBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712653684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rg3bvrQ+GLqORPueHx2Z35GuDlJmKPJM4uKntxZwsA=;
	b=2wPYA26bLCSMu+moXrTubXkdw0RyIWTIThp/YYzt83u8UzJeTATnb8xRUf1fCoNTSRhjG/
	PTnKslZu2/NN6zCw==
From: "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/alpine-msi: Fix off-by-one in allocation error path
Cc: Zenghui Yu <yuzenghui@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240327142305.1048-1-yuzenghui@huawei.com>
References: <20240327142305.1048-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265368334.10875.15822684262826448229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ff3669a71afa06208de58d6bea1cc49d5e3fcbd1
Gitweb:        https://git.kernel.org/tip/ff3669a71afa06208de58d6bea1cc49d5e3fcbd1
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Wed, 27 Mar 2024 22:23:05 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 11:03:15 +02:00

irqchip/alpine-msi: Fix off-by-one in allocation error path

When alpine_msix_gic_domain_alloc() fails, there is an off-by-one in the
number of interrupts to be freed.

Fix it by passing the number of successfully allocated interrupts, instead
of the relative index of the last allocated one.

Fixes: 3841245e8498 ("irqchip/alpine-msi: Fix freeing of interrupts on allocation error path")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240327142305.1048-1-yuzenghui@huawei.com

---
 drivers/irqchip/irq-alpine-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 9c8b134..a1430ab 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,7 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }

