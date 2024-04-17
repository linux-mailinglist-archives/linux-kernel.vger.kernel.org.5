Return-Path: <linux-kernel+bounces-148455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B1D8A82D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FFB282719
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699413CFAF;
	Wed, 17 Apr 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzaT5iWw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27HQC/Wl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D79AD48
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355752; cv=none; b=UVN3AECGR6B3oiOYCNYAHE/h309LOsnRTb7FtUpXuCRKSNhvY7ZhIBa7MNT8NuGrSXcVg9Fti+QzsaUUvPXvvxYVs1jLIlbbZEeOc82pOPTW8eU+wmXdUbsjkWEXEnR9G3mHmGCCLJ2g4szdI96nul1IHVOAbWnUp1bNY6Jg9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355752; c=relaxed/simple;
	bh=5Hx3JPtxG6DH3oUCBMk+s42v/1GkEL+FBqZS/S6m2YU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=JqBroKzrQNrn7LHqsGrLHGG8glapnIK1Jdcyh5PPIQ5I/+uX46cMHQ4PjDCgVI9FU1pZ/Z8Zz7OnuxMvqb3vR3cPeBgd+O8i7FLd7x3XzRsXh6bMCmoURTh1yyUKJx8HTDqR0bh0Vs1mpVqLxa4rjdyN1oJmWXVzqJIpqtaIl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzaT5iWw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27HQC/Wl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713355746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=r3NaHExdm3WyaQpGvSme9+DJMOEEo7U68Oxk8WVMP6c=;
	b=kzaT5iWwdY7sDVbmWnZy4HewbLuodwL8BhxT8xiaOlh4srpFtkSIMCqbKwzEYmADioe9hb
	prz8Jg+pFhd630ysRgu2ZHm0qH4t3mWXP9pgGJAxMIyRb/HgT+eu+HyT9lEgix2+rJS5lE
	3otJ7xpX2HBxJVYXTOpzPGob+S9MUpZmmqvQ6BkeIPRwFvlf+F1efGf9pi3hbEOUtlDMMt
	VsfN+uLUij8+Bn0307InM8sS3oPUMU93uaUd9qJ29LWBLilwEM+rtIyuqlxNRNslktp/D+
	i9ztcTB/lb3Ho+iNdVrohVrk6ydhQHb3q+/RL9hnxB7CODO3mP2Bdrj+dCv5dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713355746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=r3NaHExdm3WyaQpGvSme9+DJMOEEo7U68Oxk8WVMP6c=;
	b=27HQC/WliuAvN5p6BSTI/WOjOoyh01yAonxOFihw2ySLbtcsckqGFCi0WyxbCwSIdBaChQ
	hBkNt+2KRahVmJBA==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 25/50] signal: Confine POSIX_TIMERS properly
In-Reply-To: <20240410165552.509700441@linutronix.de>
Date: Wed, 17 Apr 2024 14:09:05 +0200
Message-ID: <875xwg5gym.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Move the itimer rearming out of the signal code and consolidate all posix
> timer related functions in the signal code under one ifdef.

It would be easier to read, when it is splitted. But I made it :)

With the typo fix below feel free to add:

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/posix-timers.h |    5 +
>  kernel/signal.c              |  125 +++++++++++++++----------------------------
>  kernel/time/itimer.c         |   22 +++++++
>  kernel/time/posix-timers.c   |   15 ++++-
>  4 files changed, 82 insertions(+), 85 deletions(-)
>
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h

[...]

> @@ -151,7 +151,27 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, w
>  #endif
>  
>  /*
> - * The timer is automagically restarted, when interval != 0
> + * Invoked from dequeue_signal() when SIG_ALRM is delivered.

s/SIG_ALRM/SIGALRM


> + *
> + * Restart the ITIMER_REAL timer if it is armed as periodic timer.  Doing
> + * this in the signal delivery path instead of self rearming prevents a DoS
> + * with small increments in the high reolution timer case and reduces timer
> + * noise in general.
> + */
> +void posixtimer_rearm_itimer(struct task_struct *tsk)
> +{
> +	struct hrtimer *tmr = &tsk->signal->real_timer;
> +
> +	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr != 0) {
> +		hrtimer_forward(tmr, tmr->base->get_time(),
> +				tsk->signal->it_real_incr);
> +		hrtimer_restart(tmr);
> +	}
> +}
> +
> +/*
> + * Interval timers are restarted in the signal delivery path.  See
> + * posixtimer_rearm_itimer().
>   */
>  enum hrtimer_restart it_real_fn(struct hrtimer *timer)
>  {

