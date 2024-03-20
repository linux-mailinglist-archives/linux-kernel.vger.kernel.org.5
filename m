Return-Path: <linux-kernel+bounces-109067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CA88143E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AD51F22F86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086654F206;
	Wed, 20 Mar 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsSWeJj6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0sgJUSK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2540866;
	Wed, 20 Mar 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947562; cv=none; b=rnOA2DUXrIFtlf5VeFloe1f887zWqh3WPYJ2KzVR2Mw8OCnJLqIo8T9JQgo1yusGwhYfp3aqpzeYcYRGHX+dtp8q9jJV+PlffRgNxGhwpysy5m2pgAQw4dZUgzjN3L8OEmVT7l2GX+lbQfqJf9NcT5pREkoUBQG4JdAkbHiMbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947562; c=relaxed/simple;
	bh=348HASSEk8QxvS/erlMJDq6aP8awionNlExKtmUlpmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFvvucAifK9uaauaQT0S0viXJTulvLtBE2U6ra/Ug7/8jl1mxMCYL71dg55WShZY1lMwYNfODshVrHQtMdobSXtWcESbMjAfi9FEhdxyNVr/OH9jelwzqJlpKK19sVmLsipqTXPyhQFX0VtCJad8rpWb57Sjih/wcDVRzdV1EuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsSWeJj6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0sgJUSK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Mar 2024 16:12:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710947557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqY42itfFZLfggmIMz0Q0EsnZ8t+OvYnRDCYFxlevL8=;
	b=hsSWeJj6TrjiUW12brMWme8K6vVyTafHuy7VucCN2pHD7oP9IzsRSDYDbMRyKKiW+rpe0K
	0lQTuaY8Gb0C0agF9+dqf19jbIktNHJdaOmSwN1z0PoH7lxCqSXYtzkONRDQr1sOv1ui1B
	zl7O3qNhZ//OQ0iXLcHOW8uJtC7szpRnetpo3uoOMhOVhnoyIGU6vhsgIhytRz2hLI+dNC
	2UWzyk8c3b+4QBNjt1fpE0ulqdZmzSEJI9E4du7A5tJEuNIZhhpzIAlHXvHZvqzWf+L71I
	zVixRX82UFTkA/TWt2vANyOu/DUYUvfha8Eq6+0gdHdqm5+WoonfcpwUTy/+jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710947557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqY42itfFZLfggmIMz0Q0EsnZ8t+OvYnRDCYFxlevL8=;
	b=m0sgJUSKkUfQ2JAu2rnH2dWsfJHsEXLemQ6lVHKz3ifzzl4lFVr09Cu4Pgzt9uE+JBxc9q
	17j4Lrw6ww0J7KAg==
From: Nam Cao <namcao@linutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
 samuel@sholland.org, Marc Zyngier <maz@kernel.org>, guoren@kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] irqchip/sifive-plic: enable interrupt if needed
 before EOI
Message-ID: <20240320161235.7e6916d9@namcao>
In-Reply-To: <mhng-2ab049d5-bab9-4d62-8d68-a7159a987f12@palmer-ri-x1c9>
References: <87wmr8hd7j.ffs@tglx>
	<mhng-2ab049d5-bab9-4d62-8d68-a7159a987f12@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 20/Mar/2024 Palmer Dabbelt wrote:
> On Tue, 13 Feb 2024 02:26:40 PST (-0800), tglx@linutronix.de wrote:
> > Nam!
> >
> > On Wed, Jan 31 2024 at 09:19, Nam Cao wrote:  
> >> RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
> >> explained in the description of Interrupt Completion in the PLIC spec:
> >>
> >> "The PLIC signals it has completed executing an interrupt handler by
> >> writing the interrupt ID it received from the claim to the claim/complete
> >> register. The PLIC does not check whether the completion ID is the same
> >> as the last claim ID for that target. If the completion ID does not match
> >> an interrupt source that *is currently enabled* for the target, the
> >> completion is silently ignored."
> >>
> >> Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
> >> ensured that EOI is successful by enabling interrupt first, before EOI.
> >>
> >> Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
> >> operations") removed the interrupt enabling code from the previous
> >> commit, because it assumes that interrupt should already be enabled at the
> >> point of EOI. However, this is incorrect: there is a window after a hart
> >> claiming an interrupt and before irq_desc->lock getting acquired,
> >> interrupt can be disabled during this window. Thus, EOI can be invoked
> >> while the interrupt is disabled, effectively nullify this EOI. This
> >> results in the interrupt never gets asserted again, and the device who
> >> uses this interrupt appears frozen.  
> >
> > Nice detective work!
> >  
> >> Make sure that interrupt is really enabled before EOI.
> >>
> >> Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Nam Cao <namcao@linutronix.de>
> >> ---
> >> v2:
> >>   - add unlikely() for optimization
> >>   - re-word commit message to make it clearer
> >>
> >>  drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> >> index e1484905b7bd..0a233e9d9607 100644
> >> --- a/drivers/irqchip/irq-sifive-plic.c
> >> +++ b/drivers/irqchip/irq-sifive-plic.c
> >> @@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
> >>  {
> >>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >>
> >> -	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >> +	if (unlikely(irqd_irq_disabled(d))) {
> >> +		plic_toggle(handler, d->hwirq, 1);
> >> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >> +		plic_toggle(handler, d->hwirq, 0);  
> >
> > It's unfortunate to have this condition in the hotpath, though it should
> > be cache hot, easy to predict and compared to the writel() completely in
> > the noise.  
> 
> Ya, I think it's fine.
> 
> I guess we could try and play some tricks.  Maybe hide the load latency 
> with a relaxed writel and some explict fencing, or claim interrupts when 
                                                     ^ you mean complete?
> enabling them.  Those both seem somewhat race-prone, though, so I'm not 
> even sure if they're sane.

The latter option is what I also have in mind. Just need to make sure the
interrupt is masked and we should be safe. Though there is the question of
whether it's worth the effort.

I may do that one day when I stop being lazy.

Best regards,
Nam


