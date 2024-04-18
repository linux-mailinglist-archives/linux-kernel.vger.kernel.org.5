Return-Path: <linux-kernel+bounces-150812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA38AA4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF21284286
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90478199E86;
	Thu, 18 Apr 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAYQubXT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YzSj/zk3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4B16ABFF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476706; cv=none; b=A10XJsws10OhhKGXDojYpMzCzp1GyAhUCX4tsVpm+53mVM8qW5vM0EySA3erPCXVWGUPk7+MXhioTNzA6bZC3WRnKnei9ID1GP7Mdny1neKm/7d+GxfJzTSLayEfaBF9tYhv8jTAjNPnxYyf+J4PdY7sAgDItKSsotCJSM7vu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476706; c=relaxed/simple;
	bh=1bm/wORtkQCdpXihuwt8gUE+Ki2iVd0zJjtYxfzl9SI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tdSG/zz6d/5mYVRDdLLYUWmAbDO7ERqAn7gd1r9rvTf09AQ0IXstAA61HKoWQzoP7DOWWZvmnReMf8b2igMyfNORMzmuxnnzAlCSX4J3EYZ/RmP4NNQTq0D7zrIN0jxjIVRPGuzeLP2hhJqDRfA+p/hdcCcll0xQwtzqBALozbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAYQubXT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YzSj/zk3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713476703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+UNQV62Ol6VrGa4nW/aaDoGmYQye3tnIA9PG9k83w=;
	b=nAYQubXTPnfoZjcGza6PlxJt1Q8CfxUqqrdXEtpFRGwOYWHqAtSgyI04m51ZLyTTSBMBj2
	NQAr7/gXaQDfX5f80sCiy+mNvI+onK6WnJENJdxBry3Xtr4a/I3a+seBfjG0kiIVi7vkay
	d+T/6Etlg5PbHz6zPrXpfXKaE+qjbqrUlsGg1ICHioogdxJLMsBICbMskHXVkFDkieEFni
	kbEdYsRlF18H1MrHAmkfnFvlQykTvZOZlBWS6sCCZ2sNblipaospo1L8AlgRzH3uqiAP9Q
	nNfPHyLrWWZX0k9WWakYw/DGeOtyWEgKW9bThp+Pl5G/ozG5kgvWb/MpWIRtCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713476703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+UNQV62Ol6VrGa4nW/aaDoGmYQye3tnIA9PG9k83w=;
	b=YzSj/zk3vPAxj8zDTwM8SgAO2maHMQt0Ai8RP/bVJDxkoRJi3lG5waLiRBA3WdYLv7W8ql
	hgkOPy8zDsfLk7Cw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
In-Reply-To: <ZiEWaA3CeQsccEdj@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
 <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
 <ZhgCgBK7JdRruvkj@localhost.localdomain>
 <87plunoai0.fsf@jogness.linutronix.de> <ZiEWaA3CeQsccEdj@pathway.suse.cz>
Date: Thu, 18 Apr 2024 23:51:01 +0206
Message-ID: <87v84e4a76.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-18, Petr Mladek <pmladek@suse.com> wrote:
>> > 	   Solve this problem by introducing[*] nbcon_atomic_flush_all()
>> > 	   which would flush even newly added messages and
>> > 	   call this in nbcon_cpu_emergency_exit() when the printk
>> > 	   kthread does not work. It should bail out when there
>> > 	   is a panic in progress.
>> >
>> > 	   Motivation: It does not matter which "atomic" context
>> > 		flushes NORMAL/EMERGENCY messages when
>> > 		the printk kthread is not available.
>> 
>> I do not think that solves the problem. If the console is in an unsafe
>> section, nothing can be printed.
>
> IMHO, it solves the problem.
>
> The idea is simple:
>
>   "The current nbcon console owner will be responsible for flushing
>    all messages when the printk kthread does not exist."

Currently this is not valid. It assumes owners are printers. That is not
always true. The owner might be some task modifying the baud rate and
has nothing to do with printing.

> The prove is more complicated:
>
>    1. Let's put aside panic. We already do the best effort there.
>
>    2. Emergency mode currently violates the rule because
>       nbcon_atomic_flush_pending() ignores the simple rule.
>
>       => FIX: improve nbcon_cpu_emergency_exit() to flush
> 	      all messages when kthreads are not ready.

Emergency mode cannot flush _anything_ if there is an owner in an unsafe
region. (And that owner may not be a printer.)

>    3. Normal mode flushes nbcon consoles via
>       nbcon_legacy_emit_next_record() from console_unlock()
>       before the kthreads are started.
>
>       It is not reliable when nbcon_try_acquire() fails.
>       But it would fail only when there is another user.
>       The other owner might be:
>
> 	+ panic: will handle everything
>
> 	+ emergency: should flush everything [*]
>
> 	+ normal: can't happen because of con->device() lock.

As the code is now, "normal" does not imply con->device() lock. When
using con->write_atomic(), we do not (and can not) use the con->device()
lock. So normal _can_ fail in nbcon_legacy_emit_next_record() if another
CPU is adjusting the baud rate. This is why I said the problem with
"emergency" is basically the same problem as "normal" (WRT using
write_atomic()).

> => The only remaining problem is to fix nbcon_atomic_flush_pending()
>    to flush everything when the kthreads are not started yet.

I think my proposed change handles it better. I have been doing various
tests and also adjusted it a bit.

The reason the flushing fails is because another context owns the
console. So I think it makes sense for that owner to handle flushing
responsibility when releasing ownership (even if that context was just
changing the baud rate).

[ Keep in mind we are only talking about printing via write_atomic()
when the kthread is not available. ]

If the current owner is a normal printing context, it will print to
completion anyway (via console_flush_all()).

If the current owner is an emergency printing context, it will only
print the emergency messages (as PRIO_EMERGENCY). However, when it
releases ownership, it could flush the remaining records (as
PRIO_NORMAL) in the same fashion as console_flush_all() does it.

If the current owner is a non-printing context, when it releases
ownership, it could flush the remaining records (as PRIO_NORMAL) in the
same fashion as console_flush_all() does it.

So what I am proposing is that we add two new normal-flushing sites that
are only used when the kthread is not available:

1. after exiting emergency mode: in nbcon_cpu_emergency_exit()

2. after releasing ownership for non-printing: in nbcon_driver_release()

I think this will close the gap and it does not require irq_work.

> Sigh, all this is so complicated. I wonder how to document
> this so that other people do not have to discover these
> dependencies again and again. Is it even possible?

In the end we will have the following 5 scenarios (assuming my
proposal):

1. PRIO_NORMAL non-printing activity, always under con->device() lock,
   upon release flushes[*] full backlog

2. PRIO_NORMAL printing using write_thread(), always called from task
   context and under con->device() lock, always flushes full backlog

3. PRIO_NORMAL printing using write_atomic(), called with hardware
   interrupts disabled, always flushes full backlog, (only used when the
   kthread is not available)

4. PRIO_EMERGENCY printing using write_atomic(), called with hardware
   interrupts disabled, flushes through emergency, upon exit flushes[*]
   full backlog

5. PRIO_PANIC printing using write_atomic(), called with hardware
   interrupts disabled, flushes full backlog

[*] Only when the kthread is not available. And in that case #3 is the
    scenario used for the trailing full flushing by #1 and #4.


Full flushing is attempted in all 5 scenarios. A failed attempt means
there is a new owner, but that owner is also one of the 5 scenarios.

Am I missing something?

IMHO #3 is the only bizarre scenario. It exists only to cover when the
kthread is not available.

John

