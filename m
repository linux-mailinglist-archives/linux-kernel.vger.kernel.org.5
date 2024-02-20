Return-Path: <linux-kernel+bounces-72973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEDB85BB51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49005281EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2567C58;
	Tue, 20 Feb 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZEA2sdww";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wXnjrvj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3F67C49
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430548; cv=none; b=P//hZMBCfsyVd4zs2kIuv60sn5Nin1DG/OOabHBCOXRuHKk16CFTmNL5Hl4bRNsVvUrqO6ISfXAu57LL988oyz3qoW+cVBikCO/NhT9FPMZOystGqdyo45akkaxhtp5DO+rGVnykuKLYq6r6VH0nWm1Hww9OzSrITeXMoHeiSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430548; c=relaxed/simple;
	bh=gI1VKZdVvz7XqaINps1sU1w+LQ3my44IGWVK2ZkxeWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7ySOqm8H/hq4HgqlLEr7VZZ3SEmrvcJ1TjBWs5/g4UHTZOp8egtd90CINaqd5DFRHK+QbewhCGIoXKdg8DgbkL6QP+/vxZdGgOYZDIqvXXZXeiWPGAejINOCByH1imoQYn2KJfMMb6h1pWYbuq1VChqKWCN7+wcwN9p6FtJlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZEA2sdww; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wXnjrvj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708430539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfDJweaF0YOIVk4J8ZnGrKRTeT33r4hnrYAwQPzWmM4=;
	b=ZEA2sdww9nlmGSqM2eWJo2AKa6aw/BQuCF1Y0zYnWJ7lgBNhf23EUaS9DDQoX13HlcP5qu
	lYfYMIqz+E+VML20R3LovNux1kyiVQn7c261t4BoEz2f4PZmu4Ws6OXzEK4z6BYWtc/ed3
	Uq/lo7WBT+lb1jofvrGqxS65OLoO5eOIbymIhdattU9vX2Dltrvwr17Lyy2118HyuLxPp8
	j+p8Vp1RKcCvZoF9qD/i5o/OishaKg/1tHyhfOl9Xbu+G5lZErcTB2faN2kZFQsBkmRZh7
	wFir9Dv2Ed4YDQadnTmM0+9iFwOy8bV5hmJymmA2fQI9mRVAakqpJx1OEZE6ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708430539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfDJweaF0YOIVk4J8ZnGrKRTeT33r4hnrYAwQPzWmM4=;
	b=3wXnjrvj38iBtrdC7ZGDujBaeRRdBixBgojNASHy5chScQSGuo/e79DGLkzg0glFJYlGrt
	wtpw4N+t96vmDVDg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@infradead.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior
 <bigeasy@linutronix.de>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lukasz
 Luba <lukasz.luba@arm.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10a] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
In-Reply-To: <ZdSQBD_ZpWvH5SoZ@localhost.localdomain>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain> <878r3f5s3w.fsf@somnus>
 <ZdSQBD_ZpWvH5SoZ@localhost.localdomain>
Date: Tue, 20 Feb 2024 13:02:18 +0100
Message-ID: <87zfvv4a45.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Tue, Feb 20, 2024 at 11:48:19AM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 01fb50c1b17e..b93f0e6f273f 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_sched *=
ts, int cpu)
>>  	/* Make sure we won't be trying to stop it twice in a row. */
>>  	ts->timer_expires_base =3D 0;
>>=20=20
>> -	/*
>> -	 * If this CPU is the one which updates jiffies, then give up
>> -	 * the assignment and let it be taken by the CPU which runs
>> -	 * the tick timer next, which might be this CPU as well. If we
>> -	 * don't drop this here, the jiffies might be stale and
>> -	 * do_timer() never gets invoked. Keep track of the fact that it
>> -	 * was the one which had the do_timer() duty last.
>> -	 */
>> -	if (cpu =3D=3D tick_do_timer_cpu) {
>> -		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
>> -		ts->do_timer_last =3D 1;
>> -	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
>> -		ts->do_timer_last =3D 0;
>> -	}
>> -
>>  	/* Skip reprogram of event if it's not changed */
>>  	if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
>>  		/* Sanity check: make sure clockevent is actually programmed */
>
> That should work but then you lose the optimization that resets
> ts->do_timer_last even if the next timer hasn't changed.
>

Beside of this optimization thing, I see onther problem. But I'm not
sure, if I understood it correctly: When the CPU drops the
tick_do_timer_cpu assignment and stops the tick, it is possible, that
this CPU nevertheless executes tick_sched_do_timer() and then reassigns
to tick_do_timer_cpu?

Then it is mandatory that we have this drop the assignment also in the
path when the tick is already stopped. Otherwise the problem described
in the comment could happen with stale jiffies, no?

Thanks

> Thanks.
>
>
>
>> @@ -938,6 +923,21 @@ static void tick_nohz_stop_tick(struct tick_sched *=
ts, int cpu)
>>  		trace_tick_stop(1, TICK_DEP_MASK_NONE);
>>  	}
>>=20=20
>> +	/*
>> +	 * If this CPU is the one which updates jiffies, then give up
>> +	 * the assignment and let it be taken by the CPU which runs
>> +	 * the tick timer next, which might be this CPU as well. If we
>> +	 * don't drop this here, the jiffies might be stale and
>> +	 * do_timer() never gets invoked. Keep track of the fact that it
>> +	 * was the one which had the do_timer() duty last.
>> +	 */
>> +	if (cpu =3D=3D tick_do_timer_cpu) {
>> +		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
>> +		ts->do_timer_last =3D 1;
>> +	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
>> +		ts->do_timer_last =3D 0;
>> +	}
>> +
>>  	ts->next_tick =3D expires;
>>=20=20
>>  	/*

