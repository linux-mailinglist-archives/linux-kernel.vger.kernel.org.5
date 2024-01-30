Return-Path: <linux-kernel+bounces-45063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D3842B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA741F2017A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46943151CE0;
	Tue, 30 Jan 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0WtWH9Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4nb4igs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470C1552F6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637397; cv=none; b=Y8Vpn+2Pw20xyAOnC5vMY86V1O4mF9E8y6x67ihBk4Jo8vZo8/TGOVFjSvgDeb4UYC5vHPlAONA3Tm8qX8NlwQ/wREuwOHtkmMV0ADRpE2X7vkTVX1V/3a/Fbgg9vvkcxEn98N9TTyuRvOdgOBY0TKUJvL5bgsKLNLKNScCb4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637397; c=relaxed/simple;
	bh=zfwT9+XBwNcPhZT8KldeSmfyliuUV2mCCmUuK7uv1Ks=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=uRm1OkeUGNEjLJMYBYnTi+R5nGQPm5j7En4FiOcsRMuTqW2Zm/giXyd6Sw4W1/5upC99BfKUHmFAI7sNT81LKn/MiCuck5oj0gGkX2P5wumQEsd3vjNKWyjctIaOLjzC08DlGffVBFEgbtl7bV697Kh6AMEItWybk73VZV+5/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0WtWH9Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4nb4igs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706637393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=NOnB3hiQ527eKnsK4PlTaBiOx5SgLm4MdloT0qUpUSw=;
	b=i0WtWH9ZEnvlwyyCRUmDRVVJ/dLl7RT2MelhbWMrsRweXYWWfzhYehzo8txdS/IvGvqYdM
	pIgQo7hybGz4P2u00XNANex2LRKrwoa0yfxaPKUfw7UgWRqo9AsFPyGnkrwwDEIqGGgCh3
	zapqhq/ybR8Qb6R2ShBhXEhYePKcrSnwV36finlv6GppeoiC3wApl2G916rFVqPjbuxM7h
	ZzjyZlWPWxyY0t33QaEY3Js8PXZo/cykAX00mwMWqf0w8wSuz2EuNBJJz8jWHDCL9B1XTM
	Wdi+LFCdxVXEnUouwEli1MzloSFHPHSFILJn8b43J7JS8clvx47YFM19tn3N3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706637393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=NOnB3hiQ527eKnsK4PlTaBiOx5SgLm4MdloT0qUpUSw=;
	b=w4nb4igsu+y5rBKtel0hXJAkWA6zV0goSbfEpIWQEP3vJo0KbfEFaAwqWyovHP2/hZ96Pd
	qi/G8uFblip/8eAg==
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
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
In-Reply-To: <Zbb5m0hRHgk59-8z@pavilion.home>
Date: Tue, 30 Jan 2024 18:56:32 +0100
Message-ID: <87v87a9033.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> +int tmigr_requires_handle_remote(void)
>> +{
>> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
>> +	struct tmigr_remote_data data;
>> +	unsigned int ret =3D 0;
>> +	unsigned long jif;
>> +
>> +	if (tmigr_is_not_available(tmc))
>> +		return ret;
>> +
>> +	data.now =3D get_jiffies_update(&jif);
>> +	data.childmask =3D tmc->childmask;
>> +	data.firstexp =3D KTIME_MAX;
>> +	data.tmc_active =3D !tmc->idle;
>> +	data.check =3D false;
>> +
>> +	/*
>> +	 * If the CPU is active, walk the hierarchy to check whether a remote
>> +	 * expiry is required.
>> +	 *
>> +	 * Check is done lockless as interrupts are disabled and @tmc->idle is
>> +	 * set only by the local CPU.
>> +	 */
>> +	if (!tmc->idle) {
>> +		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
>> +
>> +		if (data.firstexp !=3D KTIME_MAX)
>> +			ret =3D 1;
>> +
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * If the CPU is idle, check whether the recalculation of @tmc->wakeup
>> +	 * is required. @tmc->wakeup_recalc is set, when the last active CPU
>> +	 * went offline. The last active CPU delegated the handling of the tim=
er
>> +	 * migration hierarchy to another (this) CPU by updating this flag and
>> +	 * sending a reschedule.
>> +	 *
>> +	 * Racy lockless check is valid:
>> +	 * - @tmc->wakeup_recalc is set by the remote CPU before it issues
>> +	 *   reschedule IPI.
>> +	 * - As interrupts are disabled here this CPU will either observe
>> +	 *   @tmc->wakeup_recalc set before the reschedule IPI can be handled =
or
>> +	 *   it will observe it when this function is called again on return
>> +	 *   from handling the reschedule IPI.
>> +	 */
>> +	if (tmc->wakeup_recalc) {
>> +		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
>> +
>> +		if (data.firstexp !=3D KTIME_MAX)
>> +			ret =3D 1;
>> +
>> +		raw_spin_lock(&tmc->lock);
>> +		WRITE_ONCE(tmc->wakeup, data.firstexp);
>> +		tmc->wakeup_recalc =3D false;
>> +		raw_spin_unlock(&tmc->lock);
>
> Suppose we have:
>
>             [GRP1:0]
>             migrator =3D GRP0:1
>             active   =3D GRP0:0, GRP0:1
>               /                \
>      [GRP0:0]                  [GRP0:1]
>      migrator =3D CPU 1         migrator =3D CPU 3
>      active   =3D CPU 1         active   =3D CPU 3
>        /         \               /         \
> CPUs  0           1             2           3
>      idle        active        idle        active
>
> CPU 0 and CPU 2 have no timer.
> CPU 1 has a timer in a few millisecs.
>
>             [GRP1:0]
>             migrator =3D GRP0:1
>             active   =3D GRP0:1
>               /                \
>      [GRP0:0]                  [GRP0:1]
>      migrator =3D NONE           migrator =3D CPU 3
>      active   =3D NONE           active   =3D CPU 3
>        /         \                /         \
> CPUs  0           1              2           3
>      idle        idle         idle        active
>
>
> CPU 1 went idle, CPU 3 will take care of CPU 1's timer. Then come two
> things happening at the same time: CPU 0 has a timer interrupt, due to
> RCU callbacks handling for example, and CPU 3 goes offline:
>
> CPU 0                                   CPU 3
> -----                                   -----
>                                         // On top level [GRP1:0], just se=
t migrator =3D TMIGR_NONE
>                                         tmigr_inactive_up() {
>                                             cpu =3D cpumask_any_but(cpu_o=
nline_mask, cpu);
>                                             //cpu =3D=3D 0
>                                             tmc_resched =3D per_cpu_ptr(&=
tmigr_cpu, CPU 0);
>                                             raw_spin_lock(&tmc_resched->l=
ock);
>                                             tmc_resched->wakeup_recalc =
=3D true;
>                                             raw_spin_unlock(&tmc_resched-=
>lock);
> // timer interrupt
> run_local_timers() {
>     tmigr_requires_handle_remote() {
>         data.firstexp =3D KTIME_MAX;
>         // CPU 0 sees the tmc_resched->wakeup_recalc
>         // latest update
>         if (tmc->wakeup_recalc) {
>             tmigr_requires_handle_remote_up() {
>                 // CPU 0 doesn't see GRP0:0=20
>                 // latest update from CPU 1,
>                 // because it has no locking
>                 // and does a racy check.
>         	    if (!tmigr_check_migrator(group, childmask))
>                     return true;
>             }
>             raw_spin_lock(&tmc->lock);
>             WRITE_ONCE(tmc->wakeup, data.firstexp);
>             tmc->wakeup_recalc =3D false;
>             raw_spin_unlock(&tmc->lock)
>             return 0;
>         }
>                                             // IPI is sent only now
> 		                                    smp_send_reschedule(cpu);
>                                             }
>
>
> There is nothing that prevents CPU 0 from not seeing the hierarchy update=
s from
> other CPUs since it checks the migrators in a racy way. As a result the t=
imer of
> CPU 1 may be ignored by CPU 0.
>
> You'd need to lock the tmc while calling tmigr_requires_handle_remote_up(=
), so
> that CPU 0 "inherits" everything that CPU 3 has seen, and that includes c=
hanges
> from CPU 1.
>

puhh. ok. But for the !idle case the lockless walk of
tmigr_requires_handle_remote_up() is ok? It's also possible, that the
CPU misses an update of the state - another CPU goes idle and selects
this CPU as the new migrator. And this CPU reads a stale value where the
other CPU is migrator. But this will be revisited on the next
tick. hmm...

>
> But I see that tmigr_cpu_new_timer() does it right. Wouldn't it be possib=
le to
> exlusively let tmigr_cpu_new_timer() handle the wakeup_recalc thing? This=
 is
> going to be called after the end of the IRQ (whether timer interrupt or s=
ched
> IPI) in any case.

Should work, yes. But when a timer has to be handled right away and it
is checked after the end of the IRQ, then the tick might be reprogrammed
so that CPU comes out of idle, or am I wrong?

But, while I'm having a deeper look at the code - I completely destroyed
the logic to use the 'check' value of the tmigr_remote_date struct for
making a decision whether to raise a timer softirq or not... Whenever
the expiry in the top level is !KTIME_MAX, then
tmigr_require_handle_remote returns 1. Oh no. Also the struct member
description is not up to date.

Thanks,

	Anna-Maria

