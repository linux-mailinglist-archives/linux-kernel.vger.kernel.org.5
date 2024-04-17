Return-Path: <linux-kernel+bounces-148292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393088A806E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84DD2831DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99313AD11;
	Wed, 17 Apr 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQA29wj8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ELvIzSX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB431327E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348691; cv=none; b=OxOMOejeXSJjguem2Cqj2NszMdrUtyMCGeshd9Kc0xrU9yOpPK0WhxWCZ5THMWDKT7aUnP/RAK67kyn8ncp22CF28Ejn4isJrZjcgQKEOXe+2PXoION3fCs27F05ZmG8bjl9aVqOO3sPK9uFEnNh5qmtbjjiTWlo6Ku1EH/hp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348691; c=relaxed/simple;
	bh=KSWYUci3DoV7DaS5qMVVGhRJ/5tUi9813wRP0Nrkbno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rThQbE4m3VDGIEz9FRyXg4MLNEXvSQGHN9HmDMVLcqbjq2GdOOvkqH227s8tlnCPskkM8rt2E0ufGOnKfgU+9w/2+TWTMDxIvVjYLi7NNlacmPk2J1iJD9PJkczHtThIWLxSgORVLNmIUerKA3jc3mSMj7HvB9UooGtOlzWORLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQA29wj8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ELvIzSX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713348688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHGrCYyIXJXPc0UebXQRWLCm9Bbzq/e0Q6atneHTgEc=;
	b=oQA29wj8SGodx3GSqF8saTFiv4dvOfpwN8oNZ54G3Q/t44U52TPAWO/Vl8CagJUS15W6Fl
	B9pmGftfxDT3VSCnA8BxSnV/ZdbxO6fATzg/5HDExBnkl9U/Wf6Y36FKMZYFDEeW3ncBib
	pDFfZGGKpAQU37gCQA4pEpR7eQdl5ukQQQm5oMQ3nwjE6dxF5w2c4SOWK/APCtgCeZCtJu
	kP9QvuOtPN1HJ0WoMG1hHiuf6DAKPwhyqBK0x32FaVX6mz0zVLP3Z0KdijnzWnVJ9o5OES
	6N0BTQdCp+xrk9UJHNSUZIhmvzgqisJgisTPtYlIHXECWNDSQm4reZlAfsZqXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713348688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PHGrCYyIXJXPc0UebXQRWLCm9Bbzq/e0Q6atneHTgEc=;
	b=6ELvIzSXUnMuE3hRvx/mB0YbHZ7x+OxUNWQRGKFNv0L+3bI7aqE6CjkZg6AA/L9lHcmSJF
	HfoVg+xA8NFrFhCg==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 21/50] posix-cpu-timers: Make k_itimer::it_active
 consistent
In-Reply-To: <20240410165552.256162566@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.256162566@linutronix.de>
Date: Wed, 17 Apr 2024 12:11:27 +0200
Message-ID: <87le5cwb74.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Posix CPU timers are not updating k_itimer::it_active which makes it
> impossible to base decisions in the common posix timer code on it.
>
> Update it when queueing or dequeueing posix CPU timers.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Move the clearing to cpu_timer_fire() - Frederic
> ---
>  kernel/time/posix-cpu-timers.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -453,6 +453,7 @@ static void disarm_timer(struct k_itimer
>  	struct cpu_timer *ctmr = &timer->it.cpu;
>  	struct posix_cputimer_base *base;
>  
> +	timer->it_active = 0;
>  	if (!cpu_timer_dequeue(ctmr))
>  		return;
>  
> @@ -559,6 +560,7 @@ static void arm_timer(struct k_itimer *t
>  	struct cpu_timer *ctmr = &timer->it.cpu;
>  	u64 newexp = cpu_timer_getexpires(ctmr);
>  
> +	timer->it_active = 1;
>  	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
>  		return;
>  
> @@ -584,6 +586,7 @@ static void cpu_timer_fire(struct k_itim
>  {
>  	struct cpu_timer *ctmr = &timer->it.cpu;
>  
> +	timer->it_active = 0;
>  	if (unlikely(timer->sigq == NULL)) {
>  		/*
>  		 * This a special case for clock_nanosleep,
> @@ -668,6 +671,7 @@ static int posix_cpu_timer_set(struct k_
>  		ret = TIMER_RETRY;
>  	} else {
>  		cpu_timer_dequeue(ctmr);
> +		timer->it_active = 0;

NIT: you could change the order of the above two commands, then it is in
the same order as the others.

with or without changing the NIT:
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

