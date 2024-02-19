Return-Path: <linux-kernel+bounces-71455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA185A57A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C2D2880C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF2D3716D;
	Mon, 19 Feb 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZfwf83y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLn437Wb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29117360BA;
	Mon, 19 Feb 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351702; cv=none; b=Zed1I12rCJHiVO2+rFEix9pydc/rgTF95Y6z2OM4YvOixFeUnnAoNxl4w6hXrtxJErh/8XFi/0TZrdqQdTHjXrYwy9ANPkZdTbacqHvouGPSS9duN9uvI/sjdXw+iG3tC9t5RPNFXwHKsLQ35Qlo2g8vaxSq5yXHXuOypaMEgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351702; c=relaxed/simple;
	bh=O2I250bObo2NNSE+4ut1WpJK2Pce7ig8kJIKAPvMElQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sc1HYt1730ja6Jz8yHwmEOOSJ1/BCwCEjCEhw7uiaZLtRIf68RmSmDRERxI22HQb+1p81CYaxu2hQqLwzmBJJLWZ/qL1h3BEU7AxxA3HqoiJ2h34WgimjRjei21SRZj+0kGGIE028+3BjDuBOB9dZMBFDlVN9dxTxEE4Apy64pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZfwf83y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLn437Wb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 14:08:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708351698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ15QQb5lo2AdR2SG9y6GMsXz1qi6IFa/UGCYP+exNg=;
	b=FZfwf83ypHWycWhnl4ZxH7XYiUmcCenQUZR9KawYT32E8UjI+XWSlkK8pKC72dN2w5EJQq
	Mt9G0rQueYHfNnh4ZXHCHRXihwkq0sH9lJNLnGXCdf6NH4Jgta84ZI4RICFR3Fzct3ex9M
	F8uKn9K9V0sK/rJi6ZpnStCScTzfrEWZRmHU+26OCbZ/MVqaHANMacx2GMWB0JfLjs3DJz
	M6U2boMSWtVD/EKeT11hryFWEjdMxc/pQClA4eY3xeq83e1lSajp2/2mLYRZig16bOlHrx
	DnFIBnznLFiC+GyCi6VT3PoypMzqk6si1MdssFko7IRIK57gPxLxEHZ85FvQWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708351698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ15QQb5lo2AdR2SG9y6GMsXz1qi6IFa/UGCYP+exNg=;
	b=FLn437WbpgpmXhCwoGJ3NCl1iPy98mW0NLwsqiJPr3q79WUfGDT4avqYpn95+XXhQLNimV
	eT1nOG6ukxTkekBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/sifive-plic: Enable interrupt if needed before EOI
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>,
 Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
  <stable@vger.kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240131081933.144512-1-namcao@linutronix.de>
References: <20240131081933.144512-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170835169709.398.11515115809265577283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9c92006b896c767218aabe8947b62026a571cfd0
Gitweb:        https://git.kernel.org/tip/9c92006b896c767218aabe8947b62026a571cfd0
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 31 Jan 2024 09:19:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 15:05:18 +01:00

irqchip/sifive-plic: Enable interrupt if needed before EOI

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
point of EOI.

However, this is incorrect: there is a window after a hart claiming an
interrupt and before irq_desc->lock getting acquired, interrupt can be
disabled during this window. Thus, EOI can be invoked while the interrupt
is disabled, effectively nullify this EOI. This results in the interrupt
never gets asserted again, and the device who uses this interrupt appears
frozen.

Make sure that interrupt is really enabled before EOI.

Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240131081933.144512-1-namcao@linutronix.de
---
 drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b7bc4f..bf0b40b 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
 
-	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	if (unlikely(irqd_irq_disabled(d))) {
+		plic_toggle(handler, d->hwirq, 1);
+		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+		plic_toggle(handler, d->hwirq, 0);
+	} else {
+		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	}
 }
 
 #ifdef CONFIG_SMP

