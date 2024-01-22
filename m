Return-Path: <linux-kernel+bounces-32964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63E836288
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D723291E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7D3D38C;
	Mon, 22 Jan 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAKmCH0p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5cYCC9l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B943D387
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924106; cv=none; b=tGI5n0V6KAvyb9wy71qbeNTWqi//SPNkQoIIFSWB9xmYCQkKKRrz5UupL7U6UK9OPBdo7s/7uu0nA0JUrTETwNmQ3IiWfxNqvdwHA90VTUeKJHK7aDOJJc2NPmcrAgDmkIfXDV76Z9XMf7I/r6hFo6dkL/mR/C07WZ52TQ6vPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924106; c=relaxed/simple;
	bh=+DYkNum4FEIFLopYuEl9D6wPk7Ngk7HY80Bzudp9b0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTY+0tyKTtTPqKehFRirCatsNXKpb2hH57D9CIN59EMET8ZlQ7Osl/AEY3+Sv7FG60d+TZnSOi4g/KUsRlcZfqWdq/MmI2ELACB+0HeylelkykmMEZcSUrpBVjupM6+Lzr+J2NFzoKo1BFqTE3D8m4KpXhCzzUufAw73c1y0ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAKmCH0p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5cYCC9l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705924102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VgdieGJCxlgcQWaTHx81zlGlxh/6iVr3eJP1bpqPZE=;
	b=QAKmCH0poI8LxrvzNB976I5PJB8adJ5N5RsEbXUdJnr6YcWTofVXvPTYnGFz43wHyCOr9C
	bgvqJLG6scBNfMKbZysqOeukECe20G8AF9mG/bbL6mL/TUoV3Q43eZhUp/ouNawngXFZcZ
	gXaJhgYYkDCwhk0uKSHfHhTVeZ0bm44KFohvOQ2XiMrx2Rs1vIWovB0ykaXmHT9XNrGAfF
	/trrRcU/er9bK5loH2e5wpPezKdcJsl66MF+YvgFZDDQ92jhdQBHaKC4TmLj76DHz7yK2+
	5xlxW4aS0ge8Lytx+t5Pmn6ZlVfYu10tTk8zsWFSnQUbNHnjF3Wuzn1Yi7dMDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705924102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VgdieGJCxlgcQWaTHx81zlGlxh/6iVr3eJP1bpqPZE=;
	b=v5cYCC9lcpffaWEqhTxYQGSM2IXpfzywR+MsN3EHRHHUFWOqg9erS/c7bOQGImM2FuvOYJ
	rXprFrro6gY28PBw==
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
Subject: Re: [PATCH v10 04/20] timers: Optimization for
 timer_base_try_to_set_idle()
In-Reply-To: <ZagEK9l06c_7F3pH@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-5-anna-maria@linutronix.de>
 <ZagEK9l06c_7F3pH@localhost.localdomain>
Date: Mon, 22 Jan 2024 12:48:21 +0100
Message-ID: <87r0i9y4fu.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 15, 2024 at 03:37:27PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> When tick is stopped also the timer base is_idle flag is set. When
>> reentering the timer_base_try_to_set_idle() with the tick stopped, there=
 is
>> no need to check whether the timer base needs to be set idle again. When=
 a
>> timer was enqueued in the meantime, this is already handled by the
>> tick_nohz_next_event() call which was executed before
>> tick_nohz_stop_tick().
>>=20
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> ---
>>  kernel/time/tick-sched.c |  2 +-
>>  kernel/time/timer.c      | 11 ++++++++---
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index c6223afc801f..27f1a2ae7f39 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -886,7 +886,7 @@ static void tick_nohz_stop_tick(struct tick_sched *t=
s, int cpu)
>>  	struct clock_event_device *dev =3D __this_cpu_read(tick_cpu_device.evt=
dev);
>>  	unsigned long basejiff =3D ts->last_jiffies;
>>  	u64 basemono =3D ts->timer_expires_base;
>> -	bool timer_idle;
>> +	bool timer_idle =3D ts->tick_stopped;
>>  	u64 expires;
>>=20=20
>>  	/* Make sure we won't be trying to stop it twice in a row. */
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 3a668060692e..2f69a485a070 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1999,13 +1999,18 @@ u64 get_next_timer_interrupt(unsigned long basej=
, u64 basem)
>>   * timer_base_try_to_set_idle() - Try to set the idle state of the time=
r bases
>>   * @basej:	base time jiffies
>>   * @basem:	base time clock monotonic
>> - * @idle:	pointer to store the value of timer_base->is_idle
>> + * @idle:	pointer to store the value of timer_base->is_idle on return;
>> + *		*idle contains the information whether tick was already stopped
>>   *
>> - * Returns the tick aligned clock monotonic time of the next pending
>> - * timer or KTIME_MAX if no timer is pending.
>> + * Returns the tick aligned clock monotonic time of the next pending ti=
mer or
>> + * KTIME_MAX if no timer is pending. When tick was already stopped KTIM=
E_MAX is
>> + * returned as well.
>>   */
>>  u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *id=
le)
>>  {
>> +	if (*idle)
>> +		return KTIME_MAX;
>
> Ok now I see the reason behind the behavioural change.
>
> So either:
>
> * We remove the old behaviour consisting in clearing base->is_idle if the=
 new
>   next timer is within a jiffy while the tick is stopped. But then the ch=
angelog
>   from the previous patch should state that and comments must be clarifie=
d.
>

I would like to take 'either'. I thought the changelog already mentioned
it. But maybe I have to make it more explicit. I'll go and rework the
comments once more.

Thanks,

	Anna-Maria


