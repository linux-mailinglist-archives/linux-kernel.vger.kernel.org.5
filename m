Return-Path: <linux-kernel+bounces-73234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A685BFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A381C2132E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431276045;
	Tue, 20 Feb 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cN1hqKbR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yif0f2/O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9907602A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442611; cv=none; b=Qh3Wx8+T6RJfZgcwln1hP4lNutgkuXOzxcxGmA2HM8SGaX/1LA0ZsWzxwwmsblB6nOeFmJN5PcEhp3L42G1s2R8GHreyxwgNJ4XjryFXRjv0HEiARTG5q7j6zjKP2BDQggIJHpJF2xUJEnaV5NE0A7dRgG+kVZaQ6dbd0OIpI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442611; c=relaxed/simple;
	bh=6apxUbGLRVIk0SDI4FWJUp5S+jZ7Hbs/WvC5d8Ksefk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bt4yeNwemAlpgSS1GK/jzlUHyvGhCULUlJ3GyJC9pfUPSjnTpx/vIqiBoKk2J8mC5RdzVO0tRH5Yzlp5fVgObVmzrAWMLFXzjhL4/ezQ78ChJTHgC8gnZHKWIhp3ZWEoWkEju9fY1mW+ahrT45QmOryuxT5PgcmHT/5p4Afuo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cN1hqKbR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yif0f2/O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708442607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHbKRWsO5idm1ujga/8RloD02Jyiz2PKPbh0KQHrpd8=;
	b=cN1hqKbR23ffB/4E9W0AIAlD8SEtSjIN9k028dhDBJp3ZZfqKXpe/N5MXvbT5GZyLC6hZe
	o7JCbtrork2DtcTU8QR9PH9V/aVT/YNP8/sngqIQ0A5fRcUtviOFDf5icbEc9s/7QP50zw
	kEf7TlDSrs7IxIxsmURVxETo750msptugiQTpWR6PzEZZWBMxkSo8e0CM5EQhNYYQj6j+F
	Bo/LNFps5RFBWS0Olznkm5DQaS1KCNEeCxOxLOLQ2PifTjgfVUKgSX3BpkTTSd5lG2EF86
	LtES79LdTwvbLka/i7nFkeQf47FCaVYDnpM9B2BZ8oJjWcnTcDwlk3hkxgXnjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708442607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHbKRWsO5idm1ujga/8RloD02Jyiz2PKPbh0KQHrpd8=;
	b=yif0f2/OncJbvGkUgZadf0pwxVxKMqaIHgaHQxLmQakKOh+uU27NyvnXB/i7HeE8z4Xyqz
	zTsyFfnTjfCsm5Bw==
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
In-Reply-To: <ZdTA8N7TkGG66Ay6@lothringen>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain> <878r3f5s3w.fsf@somnus>
 <ZdSQBD_ZpWvH5SoZ@localhost.localdomain> <87zfvv4a45.fsf@somnus>
 <ZdScXhIS_G1cjaWG@localhost.localdomain> <87ttm344me.fsf@somnus>
 <ZdTA8N7TkGG66Ay6@lothringen>
Date: Tue, 20 Feb 2024 16:23:26 +0100
Message-ID: <87o7cb40sx.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> On Tue, Feb 20, 2024 at 03:00:57PM +0100, Anna-Maria Behnsen wrote:
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > Le Tue, Feb 20, 2024 at 01:02:18PM +0100, Anna-Maria Behnsen a =C3=A9c=
rit :
>> >> Frederic Weisbecker <frederic@kernel.org> writes:
>> >>=20
>> >> > Le Tue, Feb 20, 2024 at 11:48:19AM +0100, Anna-Maria Behnsen a =C3=
=A9crit :
>> >> >> Frederic Weisbecker <frederic@kernel.org> writes:
>> >> >> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> >> >> index 01fb50c1b17e..b93f0e6f273f 100644
>> >> >> --- a/kernel/time/tick-sched.c
>> >> >> +++ b/kernel/time/tick-sched.c
>> >> >> @@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_s=
ched *ts, int cpu)
>> >> >>  	/* Make sure we won't be trying to stop it twice in a row. */
>> >> >>  	ts->timer_expires_base =3D 0;
>> >> >>=20=20
>> >> >> -	/*
>> >> >> -	 * If this CPU is the one which updates jiffies, then give up
>> >> >> -	 * the assignment and let it be taken by the CPU which runs
>> >> >> -	 * the tick timer next, which might be this CPU as well. If we
>> >> >> -	 * don't drop this here, the jiffies might be stale and
>> >> >> -	 * do_timer() never gets invoked. Keep track of the fact that it
>> >> >> -	 * was the one which had the do_timer() duty last.
>> >> >> -	 */
>> >> >> -	if (cpu =3D=3D tick_do_timer_cpu) {
>> >> >> -		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
>> >> >> -		ts->do_timer_last =3D 1;
>> >> >> -	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
>> >> >> -		ts->do_timer_last =3D 0;
>> >> >> -	}
>> >> >> -
>> >> >>  	/* Skip reprogram of event if it's not changed */
>> >> >>  	if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
>> >> >>  		/* Sanity check: make sure clockevent is actually programmed */
>> >> >
>> >> > That should work but then you lose the optimization that resets
>> >> > ts->do_timer_last even if the next timer hasn't changed.
>> >> >
>> >>=20
>> >> Beside of this optimization thing, I see onther problem. But I'm not
>> >> sure, if I understood it correctly: When the CPU drops the
>> >> tick_do_timer_cpu assignment and stops the tick, it is possible, that
>> >> this CPU nevertheless executes tick_sched_do_timer() and then reassig=
ns
>> >> to tick_do_timer_cpu?
>> >
>> > Yes but in this case a timer interrupt has executed and ts->next_tick
>> > is cleared, so the above skip reprogramm branch is not taken.
>> >
>>=20
>> Yes... So I need to change it without dropping the
>> optimization. Otherwise someone might complain about it.
>>=20
>> Two possible solutions:
>>=20
>> a) split out this if/else thing for dropping the tick_do_timer_cpu
>>    assignment into a separate function and call it:
>>    - before the return in the skip reprogramm branch
>>    - and after the if clause which contains stopping the tick (where it
>>      is executed in the current proposal)
>>=20
>> b) Take my current proposal and add before the return in the skip
>>    reprogramm branch the following lines:
>>=20
>>    if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE)
>>    	ts->do_timer_last =3D 0;
>>=20
>>    as the first part of the tick_do_timer_cpu/last logic shouldn't be
>>    required (because then also ts->next_tick is already cleared).
>>=20
>> What do you prefere? Or do you prefere something else?
>
> Wouldn't the following work? If timer_idle is false, then the tick isn't
> even stopped and there is nothing to do? So you can early return.
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index fdd57f1af1d7..1b2984acafbd 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -924,6 +924,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts=
, int cpu)
>  		expires =3D ts->timer_expires;
>  	}
>=20=20
> +	if (!timer_idle)
> +		return;
> +
>  	/*
>  	 * If this CPU is the one which updates jiffies, then give up
>  	 * the assignment and let it be taken by the CPU which runs

Yes... And then I can drop the if (!timer_idle) thing inside
!ts->tick_stopped branch.


