Return-Path: <linux-kernel+bounces-44702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119C2842636
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58751F2705F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9844F6BB59;
	Tue, 30 Jan 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JXg6rZDn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ah/juV7v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E426BB4A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621528; cv=none; b=hAay4jQBrYdEdHLvrrfBXmG+KurLy6Ky6WMAeaKFNCJpRAgneqgSDuhuWISZlKV8rOSz8StMBYBS32PalS1Vxq/Nx2ZbKF42gB0QFq1pZtaDWw322A7fWTWWKXAaeA9zmoJ3LLb5vHwm8ckC2zUK4endSQyKSraYVz1MWNkMJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621528; c=relaxed/simple;
	bh=Q3RywOI5yh/HANDrSQMliRiI9pIw1KH0dkBlimZfGnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xeioqta3e4dyxT4yDGuCPNHEJIr0j0laz0ep/4AVwe5WbmoVEoJ6DEvmgfMRq1rErr0XFshqW2jF88Bfh3n6EpBiy4uq5W+JiO4flRvQnyuPelo8Ro/nDXCXsUY2VDoPx2C9HUH10ENSvrJ9fbHTWp92DFSAAmHNHcpShfiM5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JXg6rZDn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ah/juV7v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706621524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoGBQqFC13qcoNHcdf2rUWYTrZsM7egtvXUQDCYwpl8=;
	b=JXg6rZDnXRBbHtdcs47L+6Ca2Aisv3A0ThFVXnoRN08n+fPjU+iiWAm3hbvInmzMeBRQKd
	+p2J3LLcHkiwv5q0DDigI9EGfS6pr+8F3uJpKXiPkVzvFav2I2wbYanSs0djlMEMMrQ4rK
	NmDZeYA2zsEupyFqJA0t2qM0ah4dvk+NjCEF2F+P+u/OciDHuHH2Tojkt+6xJJPY9w0jlw
	YpV30RlIrZzkfTBtSH3hjUTtnWZXL5Rp2wVHTRoHKQqmhwsS828lqoT9lkyyTH1jlkfxwv
	HRTT49j4e3nHngEo9oVb7NKBir5y9HFQ3Tlmtua6Okf2lLZzhNV55U0TqifWuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706621524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoGBQqFC13qcoNHcdf2rUWYTrZsM7egtvXUQDCYwpl8=;
	b=Ah/juV7vebNVr5559pa43g0oRDXCzCf7YBpXgMKEM6CVlxYZAboJlRBu6Gpg2vOBNpgB2I
	GbovtdtImzjs/1DA==
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
 <kprateek.nayak@amd.com>, Boqun Feng <boqun.feng@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
In-Reply-To: <Zbgk-q863VU6yZKm@pavilion.home>
References: <ZbWJtkAj9z0S9xsH@pavilion.home> <87sf2gqups.fsf@somnus>
 <Zbgk-q863VU6yZKm@pavilion.home>
Date: Tue, 30 Jan 2024 14:32:03 +0100
Message-ID: <87cytj3q24.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 29, 2024 at 11:50:39AM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a =C3=A9c=
rit :
>> >> +static bool tmigr_inactive_up(struct tmigr_group *group,
>> >> +			      struct tmigr_group *child,
>> >> +			      void *ptr)
>> >> +{
>> >> +	union tmigr_state curstate, newstate, childstate;
>> >> +	struct tmigr_walk *data =3D ptr;
>> >> +	bool walk_done;
>> >> +	u8 childmask;
>> >> +
>> >> +	childmask =3D data->childmask;
>> >> +	curstate.state =3D atomic_read(&group->migr_state);
>> >> +	childstate.state =3D 0;
>> >> +
>> >> +	do {
>> >
>> > So I got the confirmation from Boqun (+Cc) and Paul that a failing cmp=
xchg
>> > may not order the load of the old value against subsequent loads. And
>> > that may apply to atomic_try_cmpxchg() as well.
>> >
>> > Therefore you not only need to turn group->migr_state read into
>> > an atomic_read_acquire() but you also need to do this on each iteration
>> > of this loop. For example you can move the read_acquire right here.
>>=20
>> I tried to read and understand more about the memory barriers especially
>> the acquire/release stuff. So please correct me whenever I'm wrong.
>>=20
>> We have to make sure that the child/group state values contain the last
>> updates and prevent reordering to be able to rely on those values.
>>=20
>> So I understand, that we need the atomic_read_acquire() here for the
>> child state, because we change the group state accordingly and need to
>> make sure, that it contains the last update of it. The cmpxchg which
>> writes the child state is (on success) a full memory barrier. And the
>> atomic_read_acquire() makes sure all preceding "critical sections"
>> (which ends with the full memory barrier) are visible. Is this right?
>
> Right. And BTW I'm being suggested by Paul to actually avoid
> atomic_read_acquire() after cmpxchg() failure because that implies an
> error prone re-read. So pick up your favourite between smp_rmb() or
> smp_mb__after_atomic().
>
> With the latter this could look like:
>
> curstate.state =3D atomic_read_acquire(&group->migr_state);
> for (;;) {
>     childstate.state =3D atomic_read(&child->migr_state);
>     ...
>     if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.=
state))
>        break;
>     smp_mb__after_atomic();
> }

I'll take this.

>>=20
>> To make sure the proper states are used, atomic_read_acquire() is then
>> also required in:
>>   - tmigr_check_migrator()
>>   - tmigr_check_migrator_and_lonely()
>>   - tmigr_check_lonely()
>
> Not sure about those. I'll check them.

Please ignore - I was on the wrong track and John helped me out (at
least another step) of my "memory barrier understanding mess". So I have
no more questions regarding the memory barriers here - at least at the
moment.

>>   - tmigr_new_timer_up() (for childstate and groupstate)
>
> Actually you need to fix some ordering there that I suggested a while ago=
 :)
> See https://lore.kernel.org/all/ZIhKT3h7Dc0G3xoU@lothringen/

I quickly opened it and it seems that I completely missed it
somehow. I'm sorry!

Thanks for your patience!

	Anna-Maria


