Return-Path: <linux-kernel+bounces-40784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9083E5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8421C24BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE545969;
	Fri, 26 Jan 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1sr8VWzT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l9Kmcghk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0733CC5;
	Fri, 26 Jan 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308729; cv=none; b=SMpR7miA2wd+XyvxitJoj+yG/DT2+55hCdoB8b6OpkZtjhwUqngTnZ405E7kDsMBbs3rXkpVI1CBi6zNvdnD63js79Okj2zbzoZdmMiUx0HeOOmYI8DnjQDoeHfkZ/C1BwLvUP5oTlmtoLLbYuB6LUbZONC70N5zzqdqkMm2nP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308729; c=relaxed/simple;
	bh=7lOWwXH/WRFuWZZ/p5u1Sz60O9F39LLJNZyVUA3JD44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CA537AMFbV4ty21maE4QrerW9+rlxIwn7w54GdjsvtbjzNvJO5gVKfK1OAOheD9rHm5mTYqNlrACKLpaecgYkZcIrH523YwTLH4oQw0SxMI31QuqlTZnrkj/EBAVf7Re5iDlKY1AHpeQYsjj4DzeqLxMSQE4lkSm/XmcvHBv+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1sr8VWzT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l9Kmcghk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706308724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OSY4AA+ERuahWut+3rNr0L68f8wAh2tNR3brI8MYRrg=;
	b=1sr8VWzT31KeAk/uxoLKrfRKmZYe7u1SQ2lRSdKhorNCv8KuQb2ac+WiA+rU640ICqiHVz
	MT9Guulw72qEjtqkIj59AMaBGQI3SNlz7QEBWSWIv3MsVB/uZgEixpj5wGfIBF6lsizh48
	NJFxBLhROuxlA1jdLxcZlBc7rXEVGRPvNtly5Hr6RgPkWNHRrSi8+kEXGSUBQ1sOqIh/l2
	w3/Kb+RaT0mf+FDBy4Rnm46U5iU1oQEcq+nwi1uwciWbwpNn9jY23/roTwmGvri8BbQzCE
	zNW1CK278k3vLEQsES8FSF97ayjNN0JdBKBZ48ZOiSQQzfm3xZIhDSrP1PqlNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706308724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OSY4AA+ERuahWut+3rNr0L68f8wAh2tNR3brI8MYRrg=;
	b=l9KmcghkgmsXMiSYrpdPPTa025ZNvFZoX4I8GVfWpFJMzjE0wzCv9aH+u7puAYNVVVNjAU
	JqC+GlJvjpaRqvCA==
To: Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel@sholland.org>,
	Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/sifive-plic: enable interrupt if needed before EOI
Date: Fri, 26 Jan 2024 23:38:36 +0100
Message-Id: <20240126223836.202321-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RISC-V PLIC cannot EOI disabled interrupts, as explained in the
description of Interrupt Completion in the PLIC spec:

"The PLIC signals it has completed executing an interrupt handler by
writing the interrupt ID it received from the claim to the claim/complete
register. The PLIC does not check whether the completion ID is the same
as the last claim ID for that target. If the completion ID does not match
an interrupt source that *is currently enabled* for the target, the
completion is silently ignored."

Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
ensured that by enabling the interrupt if needed before EOI.

Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
operations") removed the interrupt enabling code from the previous
commit, because it assumes that interrupt should be enabled at the point
of EOI. However, this is incorrect: there is a small window after a hart
claiming an interrupt and before irq_desc->lock getting acquired,
interrupt can be disabled during this window. Thus, EOI can be invoked
while the interrupt is disabled, effectively nullify this EOI.

Make sure that interrupt is really enabled before EOI.

Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask ope=
rations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive=
-plic.c
index 5b7bc4fd9517..0857a516c35b 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
=20
-	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	if (irqd_irq_disabled(d)) {
+		plic_toggle(handler, d->hwirq, 1);
+		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+		plic_toggle(handler, d->hwirq, 0);
+	} else {
+		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	}
 }
=20
 #ifdef CONFIG_SMP
--=20
2.39.2


