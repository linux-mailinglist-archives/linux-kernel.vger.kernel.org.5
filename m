Return-Path: <linux-kernel+bounces-29932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D2831559
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98D0281095
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6F13ADC;
	Thu, 18 Jan 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uM6V2GzY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dH/eVulS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2824125A6;
	Thu, 18 Jan 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568511; cv=none; b=mcBYhXd3T5p+rIazxq5pIotuMFfVoNOOyYM+8uB8LvIfAeWiBVAbTbt7KnCdfS7nTlB4M2T/QtgHEfn8qt/K4d55Uu1BTVFAKso2mm5KGMURqiUrbskKx/DMoTSceOV6JFuj1m3AMp2lz8oY5aOldE2esNi04O4KUhf2n+DKL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568511; c=relaxed/simple;
	bh=VX3UjUxxQDzGP9TuI1emfgiNgL6uYK6UsLnVW9z9Hds=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=gMQ5wh71EwMWHLbPSS8PHye6smDl9ocOdyHQ1nycpt1OY8kHQBZH69hbDsBhO0RudQgXi/PdnqZlrTCIoTj+rdngvC+zQ8zTrv7NiibJFTPSDq7kQD7yGO/eZ8xpw0HlbmG7IlHoC38AhI6F04u/lN9GqAKbuo0/Hn2E4i5RfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uM6V2GzY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dH/eVulS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705568506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvGQqS0lDOtJhhte4gMIiAO7OSJOU62lgkoWaFZVcqY=;
	b=uM6V2GzYuV5UGXHDASMm2CM/nSU9QpHP0LKkODeGZBM/ZPkc42iu/k+tZhRUgLy9Q/SRSC
	HAVhktR1IMUoONTS+if75EbD6ZdHVy9mQi3hTbvW99pGZ1kKdc+TAxxAWhcrigLlAUimm7
	J9eFrHp14980ZNuvYAsjwZK/oa+VfgRrJ50x0DWulzwOaKa0VQ/RoaeS2T5BJ0TSI76wRu
	SqOzU1PtqdantFWJINi3x9pScW69LE507QyavyoNjLazRRxrxmyv/GnotNkbJ7w8A2AGsY
	cJa124sjViXAKZ9fl21bjD2MwGfxPTJ2VbaQoHBf4LU5jaK1Cdsq8ROdk3Q2mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705568506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvGQqS0lDOtJhhte4gMIiAO7OSJOU62lgkoWaFZVcqY=;
	b=dH/eVulSbG3Oc87JgUTJHG38DS605GVHbrI7DR6KJtIfn07lu4Dm9gmtHZyqZppRWcwZeg
	v32IKDvaJOOahWAQ==
To: Leonardo Bras <leobras@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT
 atomic context
In-Reply-To: <ZabJGefGkrs0SNzW@LeoBras>
References: <20240116073701.2356171-1-leobras@redhat.com>
 <20240116073701.2356171-3-leobras@redhat.com>
 <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com>
 <ZabJGefGkrs0SNzW@LeoBras>
Date: Thu, 18 Jan 2024 10:07:45 +0106
Message-ID: <87o7djaubq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-16, Leonardo Bras <leobras@redhat.com> wrote:
> Well, at least in an PREEMPT_RT=y kernel I have found this same bug 
> reproducing several times, and through the debugging that I went through I 
> saw no mechanism for preventing it.
>
> This is one example of the bug:
> While writing to serial with serial8250_tx_chars in a irq_thread handler
> there is an interruption, and __report_bad_irq() tries to printk 
> stuff to the console, and when printk goes down to 
> serial8250_console_write() and tried to get the port->lock, which causes 
> the "BUG: scheduling while atomic":
>
> [   42.485878] irq 4: nobody cared (try booting with the "irqpoll" option)
> [   42.485886] BUG: scheduling while atomic: irq/4-ttyS0/751/0x00010002
> [   42.485890] Modules linked in:
> [   42.485892] Preemption disabled at:
> [   42.485893] [<ffffffff8118ac80>] irq_enter_rcu+0x10/0x80
> [   42.485919] CPU: 0 PID: 751 Comm: irq/4-ttyS0 Not tainted 6.7.0-rc6+ #6

This is 6.7.0-rc6+. How are you setting PREEMPT_RT?

> [   42.485927] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-1.el9 04/01/2014
> [   42.485929] Call Trace:
> [   42.485940]  <IRQ>
> [   42.485944]  dump_stack_lvl+0x33/0x50
> [   42.485976]  __schedule_bug+0x89/0xa0
> [   42.485991]  schedule_debug.constprop.0+0xd1/0x120
> [   42.485996]  __schedule+0x50/0x690
> [   42.486026]  schedule_rtlock+0x1e/0x40
> [   42.486029]  rtlock_slowlock_locked+0xe7/0x2b0
> [   42.486047]  rt_spin_lock+0x41/0x60
> [   42.486051]  serial8250_console_write+0x1be/0x460

On PREEMPT_RT-patched kernel, serial8250_console_write() is not
compiled. So obviously you are not running a PREEMPT_RT-patched kernel.

> [   42.486094]  console_flush_all+0x18d/0x3c0
> [   42.486111]  console_unlock+0x6c/0xd0

Flushing on console_unlock() is the legacy method.

I assume you are using a mainline kernel with forced threading of
irqs. Mainline has many known problems with console printing, including
calling printk when the port->lock is held.

This has been discussed before [0].

> [   42.486117]  vprintk_emit+0x1d6/0x290
> [   42.486122]  _printk+0x58/0x80
> [   42.486139]  __report_bad_irq+0x26/0xc0
> [   42.486147]  note_interrupt+0x2a1/0x2f0
> [   42.486155]  handle_irq_event+0x84/0x90
> [   42.486161]  handle_edge_irq+0x9f/0x260
> [   42.486168]  __common_interrupt+0x68/0x100
> [   42.486178]  common_interrupt+0x9f/0xc0
> [   42.486184]  </IRQ>

If you want to fix any threaded irq problems relating to printk and
console drivers, please use the latest PREEMPT_RT patch series with
CONFIG_PREEMPT_RT enabled. This is the current work that is being
reviewed on LKML for mainline inclusion. Thanks!

John Ogness

[0] https://lore.kernel.org/lkml/87il5o32w9.fsf@jogness.linutronix.de

