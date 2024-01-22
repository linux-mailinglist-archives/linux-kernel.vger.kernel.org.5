Return-Path: <linux-kernel+bounces-32958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D7836276
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885521C2758E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C63A1A2;
	Mon, 22 Jan 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfDn2SAb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LC97BSYx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5E3A8C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923908; cv=none; b=QuZrY+vEvT7o0o6q9MwdQ/0Yij+ZpsxUSEhND62V0uWc31KkYdPl62f1MzADTDuOgqb/zNMTf/RfAP3MqT6epMHEjaH37a0ByWCMN/ZJm8JBl4L1f9R2jtpu3i8W+tQJFte/KT9nQbThG4S4jH/3kNnY4QQ/wXROEYnye9P6RHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923908; c=relaxed/simple;
	bh=gEPtLbsLKBRHvoc6SCpXFrEuTXD0330WyImOG5O0OBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/rW182V+27O9F34pebxZIjPEMiwm+zpfhvUNSp/Ri55iXLZ+XnTmyvyYi1phVEDH6qVWyqwnkKppMcmdxaOxqQ4eOr/uy7OMPchY9pt3ZCvQ0/t4YVh5TET60TYk6wwSD7SI6Pg/+C8EgoWxlxCp0zj72/U2Yj4wjX/DZNHgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OfDn2SAb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LC97BSYx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705923904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSSVx10KQaY1fPXkVl6BPMMEjWncRpah42eY2WU1xOY=;
	b=OfDn2SAbU7w3pxO3N9wLqrSXbuHDBXOdbu/gHc35+ciZVD/SbSfSAz+f8r6w7PWxdkgvgy
	/zl8L4tGeic3l1IjxujkkCNmbFabT22I50aG79uLkO5Rv66ZEY7aKnAaWqvCD9hihVXiUm
	34+WiWwNGm81lFwxWV4qGHhpRW76zPu0PjfiT3X3bwdarjk0vtjonWX8FvUeJCFYMSM8bB
	YLg0Ztnhv7snvCXK8dfsLQGSDRKdEZWRFDIv5NNCHegnvKViCAhOQnIXVdASI/Cx3ZtwbY
	UoFeFoPo+Jbf+2a/m2V5m4My3fh5Hn4iL0WPc1csaYaUVwEV3nQbYIvRo23FRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705923904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSSVx10KQaY1fPXkVl6BPMMEjWncRpah42eY2WU1xOY=;
	b=LC97BSYxOyn2gDZJHPaHcNdNrq/7wCjSKb0kvpvFGT9GCZ6soRcjl4Qk5m7M5zou8mQhfn
	7rRekrppNZvRGxDA==
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
Subject: Re: [PATCH v10 03/20] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
In-Reply-To: <Zaf6E61X_l1Bx6Mu@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-4-anna-maria@linutronix.de>
 <Zaf6E61X_l1Bx6Mu@localhost.localdomain>
Date: Mon, 22 Jan 2024 12:45:03 +0100
Message-ID: <87ttn5y4lc.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 15, 2024 at 03:37:26PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> @@ -889,12 +884,41 @@ static ktime_t tick_nohz_next_event(struct tick_sc=
hed *ts, int cpu)
>>  static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>>  {
>>  	struct clock_event_device *dev =3D __this_cpu_read(tick_cpu_device.evt=
dev);
>> +	unsigned long basejiff =3D ts->last_jiffies;
>>  	u64 basemono =3D ts->timer_expires_base;
>> -	u64 expires =3D ts->timer_expires;
>> +	bool timer_idle;
>> +	u64 expires;
>>=20=20
>>  	/* Make sure we won't be trying to stop it twice in a row. */
>>  	ts->timer_expires_base =3D 0;
>>=20=20
>> +	/*
>> +	 * Now the tick should be stopped definitely - so the timer base needs
>> +	 * to be marked idle as well to not miss a newly queued timer.
>> +	 */
>> +	expires =3D timer_base_try_to_set_idle(basejiff, basemono, &timer_idle=
);
>> +	if (!timer_idle) {
>> +		/*
>> +		 * Do not clear tick_stopped here when it was already set - it
>
> Can that really happen? Looking at __get_next_timer_interrupt(), you're m=
aking a
> behavioural change: if base->is_idle was previously set and the next time=
r is
> now below/equal a jiffy, base->is_idle is not going to be cleared by
> __get_next_timer_interrupt().
>
> Therefore you shouldn't observe ts->tick_stopped && !timer_idle
>
> But I'm assuming that behavioural change wasn't intended?

It was intended to keep tick_stopped and base->is_idle in sync. So when
tick_stopped is set also base->is_idle needs to be set and dropping it
before tick_stopped is dropped will break the plan to keep it in sync.

>> +		 * will be retained on the next idle iteration when the tick
>> +		 * expired earlier than expected.
>
> I'm a bit confused by this sentence.

Me too :) It is there because of a previous version and I didn't cleaned
it up properly.

>> +		 */
>> +		expires =3D basemono + TICK_NSEC;
>
> Do you need this line?

No. After revisiting it once more, it is not required, as it should be
set properly by the return value of timer_base_try_to_set_idle(). So I
should be able to completely drop this first part of the if statement.

>
>> @@ -1147,11 +1175,6 @@ void tick_nohz_idle_stop_tick(void)
>>  void tick_nohz_idle_retain_tick(void)
>>  {
>>  	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
>
> Looks like the content of tick_nohz_retain_tick() can move here now.

I can do this.

>> -	/*
>> -	 * Undo the effect of get_next_timer_interrupt() called from
>> -	 * tick_nohz_next_event().
>> -	 */
>> -	timer_clear_idle();
>>  }
>
> Thanks.

Thanks,

	Anna-Maria


