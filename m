Return-Path: <linux-kernel+bounces-148607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910998A8500
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7721F21A48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4A13FD93;
	Wed, 17 Apr 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTuPyB01";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AYde4Zra"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082B63A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361246; cv=none; b=RnbNGDUBZnpND+StdyOuINlvntp0IrXJxyztRUntxmp42ip8A3YEldy3rQ0o16hwHgin6fcJwOO7trK+5SgoKqTKeddMH59OSekCkcLMLPkj2HfqG6YvTcW7NCiCFlwkGN8WftnyZ8YHIDWpSMFttW6Q95HcLO9fdgZSXLNKU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361246; c=relaxed/simple;
	bh=CwT5+A+AAo9zDEcsy8FPvHCxrkbTomDQL9lgkxv8/Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lR0B4nnWuI/yW6afqLpE9Ax61KUnlbwcpjsY7iCw747oNMneoh9Yes7qvJdiiH5G+LArn5AJomKr6PbDrJORI4e4c+JdcgoGXutzEaraHUk7RsbRjRIisoFC9XNry9VXbJTFQsOVFoPnrEaCaqWSOE78n1ljQBvZkhuiUXolWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTuPyB01; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AYde4Zra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713361237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu9I8bD1ga5XJP8oacpJnpvCewJOm/t6+qEJfST3VTU=;
	b=DTuPyB01c1OA7vKv0lwQXr3cZnRdSiMDL21JZSgXDmyKUGFsp/yGgvdoPSGGyUWCQC3QYw
	EpDdoAsW+D8wOEmgzxRJyxE3+fTkspZQA3ZmO5aMVlS7Tv0uAIkidrCIChj6bpjetxy4aW
	Gd6DzHKr9QEw9MG8/LCukwY5cAVYA0wYH/blqGVXy4v/WAQrudiDZEzDZPF/hHz5PBmpa0
	wp7P+l6q23odQu5NdHIoQEqQE0yWvi47uCGSW2ydMAsR3QSJztNZBhhOUAwg0HJXua4UaY
	kCyHtfH+lM3IxNAAm0eKIMGWN3kK2mU+D6F+QxCiE/4+A0ykox9K9dtyQHj00A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713361237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu9I8bD1ga5XJP8oacpJnpvCewJOm/t6+qEJfST3VTU=;
	b=AYde4Zralt5QbNG2e9IISOCBoivZy35aZOD4osZB1pFlh/e8zV7nAsyaXnoWSqT/rORcoP
	/4avCy74h5r7Y+AA==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 31/50] posix-timers: Add proper state tracking
In-Reply-To: <20240410165552.895516106@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.895516106@linutronix.de>
Date: Wed, 17 Apr 2024 15:40:36 +0200
Message-ID: <8734rk5cq3.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Right now the state tracking is done by two struct members:
>
>  - it_active:
>      A boolean which tracks armed/disarmed state
>
>  - it_signal_seq:
>      A sequence counter which is used to invalidate settings
>      and prevent rearming
>
> Replace it_active with it_status and keep properly track about the states
> in one place.
>
> This allows to reuse it_signal_seq to track reprogramming, disarm and
> delete operations in order to drop signals which are related to the state
> previous of those operations.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

[...]

> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -453,7 +453,6 @@ static void disarm_timer(struct k_itimer
>  	struct cpu_timer *ctmr = &timer->it.cpu;
>  	struct posix_cputimer_base *base;
>  
> -	timer->it_active = 0;
>  	if (!cpu_timer_dequeue(ctmr))
>  		return;
>  
> @@ -494,11 +493,12 @@ static int posix_cpu_timer_del(struct k_
>  		 */
>  		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
>  	} else {
> -		if (timer->it.cpu.firing)
> +		if (timer->it.cpu.firing) {
>  			ret = TIMER_RETRY;
> -		else
> +		} else {
>  			disarm_timer(timer, p);
> -
> +			timer->it_status = POSIX_TIMER_DISARMED;
> +		}
>  		unlock_task_sighand(p, &flags);
>  	}

Why do you move the update of the it_status here and do not reuse the
place where you added the it_active in patch 21 "posix-cpu-timers: Make
k_itimer::it_active consistent"? Then the update of the state would
still be next to cpu_timer_dequeue().

[...]

> @@ -647,10 +650,10 @@ void common_timer_get(struct k_itimer *t
>  	/* interval timer ? */
>  	if (iv) {
>  		cur_setting->it_interval = ktime_to_timespec64(iv);
> -	} else if (!timr->it_active) {
> +	} else if (timr->it_status == POSIX_TIMER_DISARMED) {
>  		/*
>  		 * SIGEV_NONE oneshot timers are never queued and therefore
> -		 * timr->it_active is always false. The check below
> +		 * timr->it_status is always DISARMED. The check below

s/DISARMED/POSIX_TIMER_DISARMED/

This change would help when using grep.

>  		 * vs. remaining time will handle this case.
>  		 *
>  		 * For all other timers there is nothing to update here, so


