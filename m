Return-Path: <linux-kernel+bounces-149885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA698A9763
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D741C219C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498B15CD44;
	Thu, 18 Apr 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCEBO2Z1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7c1Z6VF6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EA146596
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436198; cv=none; b=ggQLObgmhZrPQOB1LYOWop2h0qNVj0Q02PvksI5ysaTbcx/c+Z8sKk74Z+XRCIS9ntV8+m1+D8cSXX8DoDpDJIJsd+uOpp4uyEYUV3TBorItKgmqnaYGVKLG/Dtzug/U/TcD58uj/vnKxTeg6qa/YJGsWfirScHcgg2VF13G7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436198; c=relaxed/simple;
	bh=3A/BmFN47HX15gdrY2SkTMEXvPK1XcK0oX5xemWiyYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxXHelp3DRXxhqlXNit5pI9AIIyssRNRHERnK8ZkHgcpKIGiDb9LrvHedm5+4KmmUxHrLsPNOZBBEoRZJA2D7uc7hnLeG4ZVB+AYviKzL6ZuPiYxju+AoDaZPcfQObiK558jyh6azbZymJJvjkIgA3BeMgZHHNl6cKCaGpQtKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCEBO2Z1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7c1Z6VF6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713436194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIn0pnGzT1q46IedgAtCbpDTV/ssq8v05aYQf2sg8gA=;
	b=HCEBO2Z1lVyS6Ez/Be9Vrhzp3N2IaaNWXhNi/8yROYPFzb7FdIA5L8YRpIbEqrghzCpxxs
	5tIk/ktHwuDBXXiQyjXlu6tLMwBGUOev4D6D9R/i9ltxmp+rHcztGUBGmGuyeHbJ44ikG3
	audSZWuGwbYw3YVAqBNPI11ujJ62uT7JlqLCz1Uh37+N1dsMRvF52O1AgGm1ia5+CuSaq5
	JmaSZHIcQg2KQVMPgFYVPD6p59Wo9j/Xei2Nk1TlfR5/O0qAMIcgGfisSVNtXUdhHIQkta
	qOV52uxNlPOABeVWpR3htZqeUNrfJu6tBPR1ydFIXowOfqQ5OU7cXXogR9Q1fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713436194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIn0pnGzT1q46IedgAtCbpDTV/ssq8v05aYQf2sg8gA=;
	b=7c1Z6VF6l4iBiDt6T4RxjJe0WtJclT0IxTEjp/+OEe6DWn0l4zI386/SH0/P/zbY/XcO3z
	KdpiBBcxEbEcmLCA==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 32/50] posix-timers: Make signal delivery consistent
In-Reply-To: <20240410165552.957338323@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.957338323@linutronix.de>
Date: Thu, 18 Apr 2024 12:29:53 +0200
Message-ID: <87bk67rmji.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Signals of timers which are reprogammed, disarmed or deleted can deliver
> signals related to the past. The POSIX spec is blury about this:
>
>  - "The effect of disarming or resetting a timer with pending expiration
>    notifications is unspecified."
>
>  - "The disposition of pending signals for the deleted timer is
>     unspecified."
>
> In both cases it is reasonable to expect that pending signals are
> discarded. Especially in the reprogramming case it does not make sense to
> account for previous overruns or to deliver a signal for a timer which has
> been disarmed. This makes the behaviour consistent and understandable.
>
> Remove the si_sys_private check from the signal delivery code and invoke
> posix_timer_deliver_signal() unconditionally.

s/posix_timer/posixtimer/ (or renaming the function when you introduced
it)

>
> Change that function so it controls the actual signal delivery via the
> return value. It now instructs the signal code to drop the signal when:
>
>   1) The timer does not longer exist in the hash table
>
>   2) The timer signal_seq value is not the same as the si_sys_private value
>      which was set when the signal was queued.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

[...]

> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -293,19 +297,19 @@ bool posixtimer_deliver_signal(struct ke
>  int posix_timer_queue_signal(struct k_itimer *timr)
>  {
>  	enum posix_timer_state state = POSIX_TIMER_DISARMED;
> -	int ret, si_private = 0;
>  	enum pid_type type;
> +	int ret;
>  
>  	lockdep_assert_held(&timr->it_lock);
>  
>  	if (timr->it_interval) {
> +		timr->it_signal_seq++;
>  		state = POSIX_TIMER_REQUEUE_PENDING;
> -		si_private = ++timr->it_signal_seq;
>  	}
>  	timr->it_status = state;
>  
>  	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> -	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
> +	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
>  	/* If we failed to send the signal the timer stops. */
>  	return ret > 0;
>  }

posix_timer_queue_signal() is executed, when a
posix/posix-cpu/alarmtimer expires. There is the check for it_interval
set, to decide whether reprogramming takes place or not.

If I understood it correctly, a resetted or deleted timer should not get
a signal delivered so it should also do not requeue a timer. But when
the timer expires at the same time when trying to reset or delete it,
the above it_interval check reduces the chance that a timer is
nevertheless requeued. Right?

> @@ -889,8 +891,6 @@ int common_timer_set(struct k_itimer *ti
>  	if (old_setting)
>  		common_timer_get(timr, old_setting);
>  
> -	/* Prevent rearming by clearing the interval */
> -	timr->it_interval = 0;

But here the clearing of the interval is removed. So it is more likely,
that the timer is reamed, when expiring and resetting happens at the
same time. Same thing when deleting the timer (see next hunk). Is this
ok, that the behavior changes like this?

But keeping the clearing of the interval is also a problem here - if I'm
not totally on the wrong track. When an expiry and resetting of the
timer happens together and old_setting is set, then the
timr->it_interval is cleared and timer_try_to_cancel() will fail so
TIMER_RETRY is returend to do_timer_settime(). In do_timer_settime() the
timr->it_interval is written into the old_setting struct. But this is
then cleared even if it was set before... hmm...

>  	/*
>  	 * Careful here. On SMP systems the timer expiry function could be
>  	 * active and spinning on timr->it_lock.
> @@ -1008,7 +1011,6 @@ int common_timer_del(struct k_itimer *ti
>  {
>  	const struct k_clock *kc = timer->kclock;
>  
> -	timer->it_interval = 0;
>  	if (kc->timer_try_to_cancel(timer) < 0)
>  		return TIMER_RETRY;
>  	timer->it_status = POSIX_TIMER_DISARMED;

Thanks,

	Anna-Maria


