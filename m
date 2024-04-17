Return-Path: <linux-kernel+bounces-148738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB28A86C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ADB28854D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4B5A106;
	Wed, 17 Apr 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teAqBz+T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/n96XbW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41638DD3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365689; cv=none; b=ROQ3VCK+lhxSRNHXpsC+rvV2Qte/8H0RQMTSbmiqnDkQpYhJUG9lfgnazbPup+VI+R7F0bf8GQPBCWxJSoXa69ZkUxQHezk1Z4C9/hp+sJLT+jZof0Ls6xRxsDb/4eFDGk1XI16YzyVoNV9EsQ7sJ0ViSJ8skaPrPK3ixJCuF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365689; c=relaxed/simple;
	bh=0MiiK6F8wzc4SITPbvD/aZwYJFfrRWk+B2juinweY+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DyBfjvyQCh6NbXs1htygpjAPJeLFB8Glhpo8ZNsb4DIKlSECae3YshOf5MLx0WdLBHh7P9nwVSxb58cfqEADpugWVMfHYrMT39W7fEJXe8WEeH0V9t77JIoH/DCghDW76Y4YQod1/IPGAhR3lxDgr7XKdGzNLc+jmoF31awpQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teAqBz+T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/n96XbW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713365685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUivZh613trnPQowXjJAMGHNy6dBQGV9ltkb6mTz4dQ=;
	b=teAqBz+TaY6PlPSNgnTvzoclCTkYgf6aVrrOYTuRWuTeN4lxyGGDmqeiVnlQ27e07aLUyI
	s4kTU7f3xrvIvu0y+XUwFuKOaeDZ6kI/PSw6kfsDFuiCvEmUXfJN7MTRDAAqFLn7VLFC44
	PrroA/fc30ev2gEIdr3hyidGBcwACvQGUAy0UUFqsB0/oBIMww6/BnNolmTBj7ljpu0h3u
	5vnR2lP07h5UpSFkVSo6VHDFPSSkFHruqKHqTZacMrg+682Q4n8aexyZLXSREXO8YDsy1f
	aQXrvtMNirtNk1JWO1sRJ4qAKzj19KJx/Jqlrfgzi7Qt8KxPnf8gy1gYk2IRig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713365685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUivZh613trnPQowXjJAMGHNy6dBQGV9ltkb6mTz4dQ=;
	b=h/n96XbWZ69uTVNvxzAIpmTZXOQBYDxVcu+UviUl32nqKI+3BydpB3VuADcwXNrBeHvvHf
	+CmwXPaISGXR62CA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
In-Reply-To: <Zh_IrB4MyHwU8OJE@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
 <ZhUIatzxietD4F-m@localhost.localdomain>
 <87y19djqr0.fsf@jogness.linutronix.de> <Zh_IrB4MyHwU8OJE@pathway.suse.cz>
Date: Wed, 17 Apr 2024 17:00:42 +0206
Message-ID: <87bk68niod.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-17, Petr Mladek <pmladek@suse.com> wrote:
>> We want to avoid using nbcon console ownership contention whenever
>> possible. In fact, there should _never_ be nbcon console owership
>> contention except for in emergency or panic situations.
>>
>> In the normal case, printk will use the driver-specific locking for
>> synchronization. Previously this was achieved by implementing the
>> lock/unlock within the write() callback. But with nbcon consoles that
>> is not possible because the nbcon ownership must be taken outside of
>> the write callback:
>> 
>> con->device_lock()
>> nbcon_acquire()
>> con->write_atomic() or con->write_thread()
>> nbcon_release()
>> con->device_unlock()
>
> This sounds like a strong requirement. So there should be a strong
> reason

There is: PREEMPT_RT

> when nbcon_acquire() is safe enough in emergency context
> then it should be safe enough in the normal context either.
> Otherwise, we would have a problem.

Of course. That is not the issue.

> My understanding is that we want to take con->device_lock()
> in the normal context from two reasons:
>
>   1. This is historical, king of speculation, and probably
>      not the real reason.

Correct. Not a reason.

>   2. The con->device() defines the context in which nbcon_acquire()
>      will be taken and con->write_atomic() called to make it
>      safe against other operations with the device driver.
>
>      For example, con->device() from uart serial consoles would
>      disable interrupts to prevent deadlocks with the serial
>      port IRQ handlers.
>
>      Some other drivers might just need to disable preemption.
>      And some (future) drivers might even allow to keep
>      the preemption enabled.

(Side note: In PREEMPT_RT, all drivers keep preemption enabled.)

This 2nd reason is almost correct.

Drivers are implemented using their own locking mechanisms. For UART it
will be spinlocks. For VT it will be mutexes. Whatever these mechanisms
are, that is what printk also wants to use. And since (for the normal
case) printk will always print console messages from task context,
drivers are free to use whatever locking mechanism fits them best. By
using the locking choice of the driver, printk will always do the right
thing and the author of that driver will always be in control of the
context.

Unfortunately printk also needs to deal with the non-normal case
(emergencies, panic, shutdown) when no printing threads are
available. For this (and only for this case) the nbcon console ownership
was introduced. It functions as a special[*] inner lock. This inner lock
will never be contended in the normal case. It exists only so that the
non-normal case can takeover the console for printing.

[*] Special = NMI-safe with priority and handover/takeover semantics.

Generally speaking, driver authors should not be concerned about this
special inner lock. It should be hidden (such as in the port lock
wrapper).

The special lock is interesting _only_ for drivers implementing
write_atomic(). And even then, it is only interesting for the
write_thread() and write_atomic() callback implementations. These
require some special handling to make sure they will print sane output
during handover/takeovers. But no other functions need to be concerned
about it.


> I still have to shake my head around this. But I would first like
> to know whether:
>
>    + You agree that nbcon_try_acquire() always have to be called with
>      preemption disabled.

No, it must not. PREEMPT_RT requires preemption enabled. That has always
been the core of this whole rework.

>    + What do you think about explicitly disabling preemption
>      in nbcon_try_acquire().

We cannot do it.

>    + If it is acceptable for the big picture. It should be fine for
>      serial consoles. But I think that graphics consoles wanted to
>      be preemptive when called in the printk kthread.

In PREEMPT_RT, all are preemptive.

> I am sure that it will be possible to make nbcon_try_acquire()
> preemption-safe but it will need some more magic.

I am still investigating why you think it is not safe (as an inner lock
for the normal case). Note that for emergency and panic situations,
preemption _is_ disabled.

John

