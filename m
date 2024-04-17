Return-Path: <linux-kernel+bounces-149301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CDF8A8F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F9DB2201A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3F85280;
	Wed, 17 Apr 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9WK5xH7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WjBhdRMh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A74FC1F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395168; cv=none; b=XI52RIdxZlYqaka799UQhE9hl1dzxJg7Moq+Qp41AWklh83s0dkqgojBcdT3HwcsCU6efbllHpEeEb4wJeHlApmDXEmooKE/r8D52Mz7EbnUTjhr0f5CJpuSyTWK6OJOy/CdRYa2KPPyJrQ6NEie5RyJMf0GxhpucF8UUoipg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395168; c=relaxed/simple;
	bh=WqgaLntv683En9Ah2PbvQfLoPDQahPKEqmQivL49I0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZYuUNOz/1hwAK4/aBATVbayo9ywekIQ3qxeu+YYtQ6tb0e2cDzVeOFTmM2VNbFGuZYeySh6PhGjOQU80UXmx4D1laEpFKQiF0IvO9Iupl4lInpBC4cJMIkn2N1T2Fg3zF+/s6uQHsRRX5vr6auEUifZ+s0YPfcSPl+VPeZ7vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9WK5xH7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WjBhdRMh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713395161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lHykT6pMWD44u+/0yrZeXfaT6lgxVyh522+nMVcD9c=;
	b=M9WK5xH7biqIz6B/7Z9kHLaPHMcofN02dMgTn02WkyckFbBq8X7LKQDhKtHc00Uiq1WBHg
	anlvfK5KlmdZzMp0Mhi7aiz/Cy+pgPpbnnE8tvVhNAiDEOz+OiK86BrWltVoAkG9sw0pNd
	oYAiIoLy/us74mxXrG1zASEAFFOoFI2FmiF8cZw1z7DjEHSu0HsJczwKgmaZBBVz+ktAcN
	erBtLQi7mNK3eShJtAX5oav2pPn62SXlnodicCwXlAA/4CWLAhlIq/VvjVQ6FcbT+5CDHo
	CY9JBFmvdCq6nvV2H/rHmgFdMnQZMp93KS4PcvVcd/74k2/S9ub+HcwtmIjRWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713395161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lHykT6pMWD44u+/0yrZeXfaT6lgxVyh522+nMVcD9c=;
	b=WjBhdRMhy3v53mrv8rAI6NJl3VTE2tbV+38zyt8A24EBYiPPE2QoAJQ/bUyOCk4qrVJzBe
	h9Ju0BtjVk1I8GBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
In-Reply-To: <ZhgCgBK7JdRruvkj@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
 <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
 <ZhgCgBK7JdRruvkj@localhost.localdomain>
Date: Thu, 18 Apr 2024 01:11:59 +0206
Message-ID: <87plunoai0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-11, Petr Mladek <pmladek@suse.com> wrote:
> I am trying to make a full picture when and how the nbcon consoles
> will get flushed. My current understanding and view is the following,
> starting from the easiest priority:
>
>
>   1. NBCON_PRIO_PANIC messages will be flushed by calling
>      nbcon_atomic_flush_pending() directly in vprintk_emit()
>
>      This will take care of any previously added messages.
>
>      Non-panic CPUs are not allowed to add messages anymore
>      when there is a panic in progress.
>
>      [ALL OK]

OK, because the end of panic will perform unsafe takeovers if necessary.

>   2. NBCON_PRIO_EMERGENCY messages will be flushed by calling
>      nbcon_atomic_flush_pending() directly in nbcon_cpu_emergency_exit().
>
>      This would cover all previously added messages, including
>      the ones printed by the code between
>      nbcon_cpu_emergency_enter()/exit().

This is best effort. If the console is owned by another context and is
marked unsafe, nbcon_atomic_flush_pending() will do nothing.

[ PROBLEM: In this case, who will flush the emergency messages? ]

>      This won't cover later added messages which might be
>      a problem. Let's look at this closer. Later added
>      messages with:
>
> 	+ NBCON_PRIO_PANIC will be handled in vprintk_emit()
> 	  as explained above [OK]
>
> 	+ NBCON_PRIO_EMERGENCY() will be handled in the
> 	  related nbcon_cpu_emergency_exit() as described here.
> 	  [OK]
>
> 	+ NBCON_PRIO_NORMAL will be handled, see below. [?]
>
>      [ PROBLEM: later added NBCON_PRIO_NORMAL messages, see below. ]

Yes, this is also an issue, although the solution may be the same for
this and the above problem.

>   3. NBCON_PRIO_NORMAL messages will be flushed by:
>
>        + the printk kthread when it is available
>
>        + the legacy loop via
>
> 	 + console_unlock()
> 	    + console_flush_all()
> 	      + console nbcon_legacy_emit_next_record() [PROBLEM]
>
> PROBLEM: console_flush_all() does not guarantee progress with
> 	 nbcon consoles as explained above (previous mail).

Not only this. If there is no kthread available, no printing will occur
until the _next_ printk(), whenever that is.


Above we have listed 3 problems:

- emergency messages will not flush if owned by another context and
  unsafe

- normal messages will not flush if owned by another context

- for the above 2 problems, if there is no kthread, nobody will flush
  the messages


My question: Is this really a problem?

The main idea behind the rework is that printing is deferred. The
kthreads exist for this. If the kthreads are not available (early boot
or shutdown) or the kthreads are not reliable enough (emergency
messages), a best-safe-effort is made to print in the caller
context. Only the panic situation is designed to force output (unsafely,
if necessary). Is that not enough?

> My proposal:
>
> 	1. console_flush_all() will flush nbcon consoles only
> 	   in NBCON_PRIO_NORMAL and when the kthreads are not
> 	   available.
>
> 	   It will make it clear that this is the flusher in
> 	   this situation.

This is the current PREEMPT_RT implementation.

> 	2. Allow to skip nbcon consoles in console_flush_all() when
> 	   it can't take the context (as suggested in my previous
> 	   reply).
>
> 	   This won't guarantee flushing NORMAL messages added
> 	   while nbcon_cpu_emergency_exit() calls
> 	   nbcon_atomic_flush_pending().

This was the previous version. And I agree that we need to go back to
that.

> 	   Solve this problem by introducing[*] nbcon_atomic_flush_all()
> 	   which would flush even newly added messages and
> 	   call this in nbcon_cpu_emergency_exit() when the printk
> 	   kthread does not work. It should bail out when there
> 	   is a panic in progress.
>
> 	   Motivation: It does not matter which "atomic" context
> 		flushes NORMAL/EMERGENCY messages when
> 		the printk kthread is not available.

I do not think that solves the problem. If the console is in an unsafe
section, nothing can be printed.

> 	  [*] Alternatively we could modify nbcon_atomic_flush_pending()
> 	      to flush even newly added messages when the kthread is
> 	      not working. But it might create another mess.

This discussion is about when kthreads are not available. If this is a
concern, I wonder if maybe in this situation an irq_work should be
triggered upon release of the console.

For example, something like:

static bool flush_pending(struct console *con)
{
	/* If there is a kthread, let it do the work. */
	if (con->kthread)
		return false;

	/* Make sure a record is pending. */
	if (!prb_read_valid(prb, nbcon_seq_read(con), NULL))
		return false;

	return true;
}

static void nbcon_context_release(struct nbcon_context *ctxt)
{
	...

	/* Trigger irq_work to flush if necessary. */
	if (flush_pending(con))
		defer_console_output();
}

John

