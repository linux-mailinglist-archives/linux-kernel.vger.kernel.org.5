Return-Path: <linux-kernel+bounces-45984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B968438AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B97283893
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0058138;
	Wed, 31 Jan 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BF39uFbj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+szjX1SI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A415810E;
	Wed, 31 Jan 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689227; cv=none; b=LsYB01II6iGBpIVx23tRdjcnFWsWtr+Ys4Kb/WJpV3xt9yJ4koDiBwD34VzNzqhIy7U6sAbCbaudC/oPBayrmSJW7cGCuUs0GHoavvl4zdBkj/QBWRGhofmzIzzR0mr64XlfUr3NZXRX2vmoyosK8sqzMztYeXBbWhBhHAFkycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689227; c=relaxed/simple;
	bh=RW9cv7toZnF6LEuYZzxkXycyW8t3NCYo9rT737UUGSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qeAa1f8X2ENvqnQ2DmC6QKpa17SuZpvojwVH4FT1yyhl2YU/JWDmG9JrUN7WhJoDRxnIZz48L02CU+TTaVymWxbC/RzBb7yhraoDxn4BRD4WaUysZyflQlVveC2oecrJJ/mIjPC8QT3hkzr2SdWJ5I3hVkaUFc+qmaJntQd144M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BF39uFbj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+szjX1SI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706689224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8HpHV0x1fENAzE/fQpwHsbHa7p7cxsO49CTT+C0rLw=;
	b=BF39uFbjNsmkux2PvO6mYxHtzNyyH1IobjCeqy+pT88EE4kYmF/uj2F6wNtsfNvuDXme94
	MFOoi2nFs/dZsB0b8H4+arNJ9qWwirkF2xZGxPgkgih5NhkgLQ5BFgzsES4xsVrvXGP7jI
	zWDM3gu9LaTJbpAR4Y+EA9IEEoPQJa7KPiUP0pRiGdD/+kEGRh4SNjdkt7Vonj58BFxYYH
	WcVrZbUuBOmtQMb6dDWq1eOd269vzAvxi/VDp2Q0aPwcCZdDhrLyBP6Jyga8H2gRN+5O5x
	A88RBpmMtRjd3LFB/nnD0NhcPKtnUFKq0k7zOXnuFtvXW50HUCqCUQz/cH+I+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706689224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8HpHV0x1fENAzE/fQpwHsbHa7p7cxsO49CTT+C0rLw=;
	b=+szjX1SI5t1MyKsWanFvac6dZS4L+0EVLC1N3HAKrYGepum1PrI36nKXIG5xYU90olsKy3
	gGtmx59GsHAqH0Ag==
To: Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel@sholland.org>,
	Marc Zyngier <maz@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] irqchip/sifive-plic: enable interrupt if needed before EOI
Date: Wed, 31 Jan 2024 09:19:33 +0100
Message-Id: <20240131081933.144512-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
explained in the description of Interrupt Completion in the PLIC spec:

"The PLIC signals it has completed executing an interrupt handler by
writing the interrupt ID it received from the claim to the claim/complete
register. The PLIC does not check whether the completion ID is the same
as the last claim ID for that target. If the completion ID does not match
an interrupt source that *is currently enabled* for the target, the
completion is silently ignored."

Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
ensured that EOI is successful by enabling interrupt first, before EOI.

Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
operations") removed the interrupt enabling code from the previous
commit, because it assumes that interrupt should already be enabled at the
point of EOI. However, this is incorrect: there is a window after a hart
claiming an interrupt and before irq_desc->lock getting acquired,
interrupt can be disabled during this window. Thus, EOI can be invoked
while the interrupt is disabled, effectively nullify this EOI. This
results in the interrupt never gets asserted again, and the device who
uses this interrupt appears frozen.

Make sure that interrupt is really enabled before EOI.

Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask ope=
rations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - add unlikely() for optimization
  - re-word commit message to make it clearer

 drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive=
-plic.c
index e1484905b7bd..0a233e9d9607 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
=20
-	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	if (unlikely(irqd_irq_disabled(d))) {
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


