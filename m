Return-Path: <linux-kernel+bounces-41114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D083EC0C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6B8285DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294191DFC5;
	Sat, 27 Jan 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18TQg4Vn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K28Qz48W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE51DDEE;
	Sat, 27 Jan 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344280; cv=none; b=a9H1XxjhjP7BKV1tXz++1J63XLe7xHDZa8YxnZTDDtZux6fqbTk+7isDVivjlbqSYzwL0jReSRH62MleEWI+yNAZQcjrw4K/wmHDN7N1kAPujOO4NaR4hvA8PLcg0xG/bKsApTrEAnS0OaPL+CM//wpqxkTc3tMK1g6Sm6agzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344280; c=relaxed/simple;
	bh=3y97SIJ5xBgVxKMWNJIJ4rLGMAWGOZ3UhyjMU+C2pOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zwc7v2ch8b4voG5mEAw1pUYckhGXXhMfIn5QvV86itIoaLigTw9/TdQHZ4TWgi6JZH/HFtylbM3dJok3YppQFNJ5zBU3TgaPloPBgKhVkn55EiDG6/LsAJXg5T3vS7as87mhUhfX14r2nZSsusPm0ZSyKLw1sKg2wAo7GKt/nNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18TQg4Vn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K28Qz48W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 27 Jan 2024 09:31:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706344276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I7OJx5NKf289xrERaDLT1wF8RTcX1Wk/OCiBAc6Gtk=;
	b=18TQg4VnhdAfpujoCis6XXFumAyQY/XA4yICkWbb8vFFLH1DAB1sUTpd8YxIZiAbHbedvo
	e21QAAwnfmPI6/9+CAm/Xn9JCufaTiu0L0Ob10PBY4smQ6xRQMUIY9YQhbbpZsXsHLG2mD
	ca1lTz46zkXyMOKoTEhpyR1YGxqPy9Czcp3e9eFiXHvevjuuA11qI62KsROng/er8ga+VP
	y5H/7VcGB4LMPq4oEEl8Ji0lE0ysdaJecx0NXX4yiOXXMpxm+kUJv51CJ7q8fEAafZpM1Z
	VMsSktzNAQA4BD4tEtoscvEnEDiIqUadyL/Y1z6d0xQ7C0pGKWKX8yD+0/y2Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706344276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I7OJx5NKf289xrERaDLT1wF8RTcX1Wk/OCiBAc6Gtk=;
	b=K28Qz48WNcKWSyoQpS/7SybGS3TJtuhaR0/z7bCQ1I/ZdbIBYQJeoXyRKLl4neQzlsKB+H
	GmpthLsy0/QJZ5Dw==
From: Nam Cao <namcao@linutronix.de>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel
 Holland <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren
 <guoren@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] irqchip/sifive-plic: enable interrupt if needed before
 EOI
Message-ID: <20240127093114.15fdfa5c@namcao>
In-Reply-To: <071142d9-3644-4c62-a99d-40b55bf64406@sifive.com>
References: <20240126223836.202321-1-namcao@linutronix.de>
	<071142d9-3644-4c62-a99d-40b55bf64406@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 18:31:19 -0600 Samuel Holland <samuel.holland@sifive.com> wrote:
> On 2024-01-26 4:38 PM, Nam Cao wrote:
> > RISC-V PLIC cannot EOI disabled interrupts, as explained in the
> > description of Interrupt Completion in the PLIC spec:
> > 
> > "The PLIC signals it has completed executing an interrupt handler by
> > writing the interrupt ID it received from the claim to the claim/complete
> > register. The PLIC does not check whether the completion ID is the same
> > as the last claim ID for that target. If the completion ID does not match
> > an interrupt source that *is currently enabled* for the target, the
> > completion is silently ignored."
> > 
> > Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
> > ensured that by enabling the interrupt if needed before EOI.
> > 
> > Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
> > operations") removed the interrupt enabling code from the previous
> > commit, because it assumes that interrupt should be enabled at the point
> > of EOI. However, this is incorrect: there is a small window after a hart
> > claiming an interrupt and before irq_desc->lock getting acquired,
> > interrupt can be disabled during this window. Thus, EOI can be invoked
> > while the interrupt is disabled, effectively nullify this EOI.
> > 
> > Make sure that interrupt is really enabled before EOI.  
> 
> Could you please try the patch I previously sent for this issue[1]?

Unfortunately my system still gets frozen with the patch applied :(

I think because the patch doesn't prevent plic_irq_shutdown() from getting
called after the hart claiming the interrupt and before irq_desc is locked
up.

> It should fix the bug without complicating the IRQ hot path.

I can add an unlikely() to help that a bit, because from my experience, it
is quite rare that EOI happens with interrupt disabled.

Best regards,
Nam

