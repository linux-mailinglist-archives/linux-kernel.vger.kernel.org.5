Return-Path: <linux-kernel+bounces-72851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0A85B980
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C91C23B20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CB657CA;
	Tue, 20 Feb 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpSEcc5U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+pS7RzwZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B164A80
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426104; cv=none; b=mHN0+827M0/H2msXOxE2ZmHYrIelNpUcaVHeZrtjVx07HUU8FsDXzs5116qsXt+Eskc1wZnMgY+R60sBpYBEJFC51fk/tiVKqe8gTd/ijYWgChXQXivOKo6QsFhKvouu2tgquZyK3B00/4K0OWeMU77s9i1iZ2QBGx6uIlNdThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426104; c=relaxed/simple;
	bh=OkOU8b7HT20UFGFBNacL/fQ25UpcQPS32j6k+3CrnQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dk8kyIIlaQK43M+nGlgPs6LyrlsU1tdSuD22fazI+USmAmtd6GC36168NBzllsWonn+IKfa6fHbWJcy5wiEMRXOQVq+7eToWILHoGWiDKqpimkhrw3NCMi3kXBFAg1S7nXxo1BZhn1t9StCu+fmTU+aN2vaKzeqGTfJn6/032s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpSEcc5U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+pS7RzwZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708426100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itfJgirS7PJnC3wA51xanYEklye2V4fFo70nPk6v5OA=;
	b=HpSEcc5UNYyK00v7KQUoE1025tlvDViHYlggz0sc4ARioay/RvtL6ArLa6MpTssZYGZFgZ
	i2AAgbO+WRgkgH4dyzFkrPvxCpyyOazrCPRWNp/ot348JJM+zN2pbahoF9xuI2h+/aIPDN
	Z8mc6is3dV9mu/WX1GbB/QGJH5m7N12bFBscRzq1bgpwiNLLJ63MvaG60vIrZnv4xZGyDI
	DxpSS3XOleoXBOOdmMoT6L5iLBGFzvfzmRD6Sm3Tn4gPlUPj8JqEvVMd/tE4pfnC17nKAq
	YrY+q73jh2rsNLj+5Ck8QM9X4gbVR+kVhex6HBaB2GTsbV3MfJiT+p+tqWQTnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708426100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itfJgirS7PJnC3wA51xanYEklye2V4fFo70nPk6v5OA=;
	b=+pS7RzwZbAD+apCrsyVHMQjORC3kYqCxPRIQV26I1c2iexhvYCaxLlk5xjhtmPchAbEkh9
	6HFVy3CWY44+xICQ==
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
In-Reply-To: <ZdPYEzno3KqIPo4S@localhost.localdomain>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain>
Date: Tue, 20 Feb 2024 11:48:19 +0100
Message-ID: <878r3f5s3w.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Feb 19, 2024 at 09:52:36AM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> The timer base is marked idle when get_next_timer_interrupt() is
>> executed. But the decision whether the tick will be stopped and whether =
the
>> system is able to go idle is done later. When the timer bases is marked
>> idle and a new first timer is enqueued remote an IPI is raised. Even if =
it
>> is not required because the tick is not stopped and the timer base is
>> evaluated again at the next tick.
>>=20
>> To prevent this, the timer base is marked idle in tick_nohz_stop_tick() =
and
>> get_next_timer_interrupt() is streamlined by only looking for the next t=
imer
>> interrupt. All other work is postponed to timer_base_try_to_set_idle() w=
hich is
>> called by tick_nohz_stop_tick(). timer_base_try_to_set_idle() never rese=
ts
>> timer_base::is_idle state. This is done when the tick is restarted via
>> tick_nohz_restart_sched_tick().
>>=20
>> With this, tick_sched::tick_stopped and timer_base::is_idle are always in
>> sync. So there is no longer the need to execute timer_clear_idle() in
>> tick_nohz_idle_retain_tick(). This was required before, as
>> tick_nohz_next_event() set timer_base::is_idle even if the tick would no=
t be
>> stopped. So timer_clear_idle() is only executed, when timer base is idle=
 So the
>> check whether timer base is idle, is now no longer required as well.
>>=20
>> While at it fix some nearby whitespace damage as well.
>>=20
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Just a small detail below that can be fixed in a further patch:
>
>> @@ -930,6 +947,10 @@ static void tick_nohz_stop_tick(struct tick_sched *=
ts, int cpu)
>>  	 * scheduler tick in tick_nohz_restart_sched_tick().
>>  	 */
>>  	if (!ts->tick_stopped) {
>> +		/* If the timer base is not idle, retain the tick. */
>> +		if (!timer_idle)
>> +			return;
>
> This happens after tick_do_timer_cpu has been set to TICK_DO_TIMER_NONE. =
Ideally
> it would be better to do it before. Not that it hurts in practice: anothe=
r CPU
> or this one will take the duty. But it looks weird to stop halfway.
>

Yes, you are right. I would prefere, to clean it up directly and add
another patch before this patch which simply moves the
TICK_DO_TIMER_NONE related block after the !ts->tick_stopped
block. Because a changed order shouldn't be a problem at the moment as
well, or am I wrong?

Thanks,

	Anna-Maria

---8<----
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 01fb50c1b17e..b93f0e6f273f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts,=
 int cpu)
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base =3D 0;
=20
-	/*
-	 * If this CPU is the one which updates jiffies, then give up
-	 * the assignment and let it be taken by the CPU which runs
-	 * the tick timer next, which might be this CPU as well. If we
-	 * don't drop this here, the jiffies might be stale and
-	 * do_timer() never gets invoked. Keep track of the fact that it
-	 * was the one which had the do_timer() duty last.
-	 */
-	if (cpu =3D=3D tick_do_timer_cpu) {
-		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
-		ts->do_timer_last =3D 1;
-	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
-		ts->do_timer_last =3D 0;
-	}
-
 	/* Skip reprogram of event if it's not changed */
 	if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -938,6 +923,21 @@ static void tick_nohz_stop_tick(struct tick_sched *ts,=
 int cpu)
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
=20
+	/*
+	 * If this CPU is the one which updates jiffies, then give up
+	 * the assignment and let it be taken by the CPU which runs
+	 * the tick timer next, which might be this CPU as well. If we
+	 * don't drop this here, the jiffies might be stale and
+	 * do_timer() never gets invoked. Keep track of the fact that it
+	 * was the one which had the do_timer() duty last.
+	 */
+	if (cpu =3D=3D tick_do_timer_cpu) {
+		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
+		ts->do_timer_last =3D 1;
+	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
+		ts->do_timer_last =3D 0;
+	}
+
 	ts->next_tick =3D expires;
=20
 	/*

