Return-Path: <linux-kernel+bounces-73132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F985BDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDF11F24766
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA966A8A0;
	Tue, 20 Feb 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VLvzOOAo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZHvChhOd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981D5C5FC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437666; cv=none; b=rkuBaYmxxxDuoBWlJtVwJeyBPc/xQecJpcGMT185DyMi0nVe8gHo/NhQCmnBUg3K51T3YVEkk6PeY0Zp7g3iJydtaWIFSLpa+bvtAj81d+JoxCgy8V3PZy86KV0tyhIjmBqjKLCPupe0DH3uSaeSIY6PGxKxxrgqMFBVaCdR8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437666; c=relaxed/simple;
	bh=Sk853J/yvAxcOfHqWwtyvMGjsxlpkpM7HaqcX4p2XxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zjp8tkm/bj4AKF9YlPQ7jFE0goOwI94VfFFmswk7FoCQHO434hQdsMH1wJE9m7zPPVXi7KxcHPjuovZLBOiCgkCT3xCE3w8vRAdomNv5jsX6LJCYM8Msn5K+oXPYuArVriQkjoB/Uod29yAVxcduyoin5IT5AR381SPdOcBNAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VLvzOOAo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZHvChhOd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708437658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LusGeqe77Vvht/qUtbx9FzxlRWWi7gbUeUQ+PlF/39w=;
	b=VLvzOOAopuqEJ803n7CTkl4EShM1wiYx3+JmYJ9PdqMbE45AhHlZGF0HxfzBTHnXfV1oyo
	d/r/IpQ9kBQPPdPnhXHhyzRfdrG8vsaycXU8iA4XUpQFqxYh7XJ0D290zG9WREUOZTSsJU
	CrxAAgAKHMYsS28/BlV6qS0EunSiS8LXlu3XCHMgVV1D0HAK1rkVBSZUHBytcpGitDugt4
	gfQWV19qAtB9NX8gHv3S+Jvm69ui0q3jmZPr+5EzyGnpb9DhQnAdc3dY5l8TlkF2vhyjSP
	YX6fPLTvZObHda5r9HQS+Zj809g1uXkILQvNalfTZUSPYdcL57nGl+AOXGwjnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708437658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LusGeqe77Vvht/qUtbx9FzxlRWWi7gbUeUQ+PlF/39w=;
	b=ZHvChhOdl1wOUHPOJwyrKLYwIV000Q4KDR+WEGOHgSzn+g4LmoLC+GFmptRN9o5Nz8vFQA
	ITurUXs7IWatrEAw==
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
In-Reply-To: <ZdScXhIS_G1cjaWG@localhost.localdomain>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain> <878r3f5s3w.fsf@somnus>
 <ZdSQBD_ZpWvH5SoZ@localhost.localdomain> <87zfvv4a45.fsf@somnus>
 <ZdScXhIS_G1cjaWG@localhost.localdomain>
Date: Tue, 20 Feb 2024 15:00:57 +0100
Message-ID: <87ttm344me.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Tue, Feb 20, 2024 at 01:02:18PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > Le Tue, Feb 20, 2024 at 11:48:19AM +0100, Anna-Maria Behnsen a =C3=A9c=
rit :
>> >> Frederic Weisbecker <frederic@kernel.org> writes:
>> >> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> >> index 01fb50c1b17e..b93f0e6f273f 100644
>> >> --- a/kernel/time/tick-sched.c
>> >> +++ b/kernel/time/tick-sched.c
>> >> @@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_sche=
d *ts, int cpu)
>> >>  	/* Make sure we won't be trying to stop it twice in a row. */
>> >>  	ts->timer_expires_base =3D 0;
>> >>=20=20
>> >> -	/*
>> >> -	 * If this CPU is the one which updates jiffies, then give up
>> >> -	 * the assignment and let it be taken by the CPU which runs
>> >> -	 * the tick timer next, which might be this CPU as well. If we
>> >> -	 * don't drop this here, the jiffies might be stale and
>> >> -	 * do_timer() never gets invoked. Keep track of the fact that it
>> >> -	 * was the one which had the do_timer() duty last.
>> >> -	 */
>> >> -	if (cpu =3D=3D tick_do_timer_cpu) {
>> >> -		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
>> >> -		ts->do_timer_last =3D 1;
>> >> -	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
>> >> -		ts->do_timer_last =3D 0;
>> >> -	}
>> >> -
>> >>  	/* Skip reprogram of event if it's not changed */
>> >>  	if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
>> >>  		/* Sanity check: make sure clockevent is actually programmed */
>> >
>> > That should work but then you lose the optimization that resets
>> > ts->do_timer_last even if the next timer hasn't changed.
>> >
>>=20
>> Beside of this optimization thing, I see onther problem. But I'm not
>> sure, if I understood it correctly: When the CPU drops the
>> tick_do_timer_cpu assignment and stops the tick, it is possible, that
>> this CPU nevertheless executes tick_sched_do_timer() and then reassigns
>> to tick_do_timer_cpu?
>
> Yes but in this case a timer interrupt has executed and ts->next_tick
> is cleared, so the above skip reprogramm branch is not taken.
>

Yes... So I need to change it without dropping the
optimization. Otherwise someone might complain about it.

Two possible solutions:

a) split out this if/else thing for dropping the tick_do_timer_cpu
   assignment into a separate function and call it:
   - before the return in the skip reprogramm branch
   - and after the if clause which contains stopping the tick (where it
     is executed in the current proposal)

b) Take my current proposal and add before the return in the skip
   reprogramm branch the following lines:

   if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE)
   	ts->do_timer_last =3D 0;

   as the first part of the tick_do_timer_cpu/last logic shouldn't be
   required (because then also ts->next_tick is already cleared).

What do you prefere? Or do you prefere something else?

Thanks

> Thanks.
>
>>=20
>> Then it is mandatory that we have this drop the assignment also in the
>> path when the tick is already stopped. Otherwise the problem described
>> in the comment could happen with stale jiffies, no?
>>=20
>> Thanks
>>=20
>> > Thanks.
>> >
>> >
>> >
>> >> @@ -938,6 +923,21 @@ static void tick_nohz_stop_tick(struct tick_sche=
d *ts, int cpu)
>> >>  		trace_tick_stop(1, TICK_DEP_MASK_NONE);
>> >>  	}
>> >>=20=20
>> >> +	/*
>> >> +	 * If this CPU is the one which updates jiffies, then give up
>> >> +	 * the assignment and let it be taken by the CPU which runs
>> >> +	 * the tick timer next, which might be this CPU as well. If we
>> >> +	 * don't drop this here, the jiffies might be stale and
>> >> +	 * do_timer() never gets invoked. Keep track of the fact that it
>> >> +	 * was the one which had the do_timer() duty last.
>> >> +	 */
>> >> +	if (cpu =3D=3D tick_do_timer_cpu) {
>> >> +		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
>> >> +		ts->do_timer_last =3D 1;
>> >> +	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
>> >> +		ts->do_timer_last =3D 0;
>> >> +	}
>> >> +
>> >>  	ts->next_tick =3D expires;
>> >>=20=20
>> >>  	/*

