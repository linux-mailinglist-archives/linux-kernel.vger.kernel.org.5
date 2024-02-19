Return-Path: <linux-kernel+bounces-71718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C385A971
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A39A1F2380C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24144391;
	Mon, 19 Feb 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVtZQAg0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8DwgRJEZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44B3771C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361842; cv=none; b=b4QTllNWGgVCIEd3eLgDX/hMiJHRbJRsJrqnENCBzDTnMOL7/NkplN5D2/32lHBU2vXaj6Kb1nADZ+QYIczl9a0cSNmPjUtktE+MBZwMWzn55xkypreRF/EaM6qXhTTDxsqhJVLEV24lkMmU3NW/VGMSvcCanQE2LlX8/HArHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361842; c=relaxed/simple;
	bh=efuckyKb7AWsjiCxytITdfB2OOnWIcBNGDsHot4Tro4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGvv82gUNb9cVQuRnH5AhTSpIrY2lHBC7Z5X2v3LIKbuBwbijbDwowP/3zK9aR2OTXhKQmWlco9gKoK+B8LBesQpi77egIJI6EYtB5CzeUKnZ9+7v5F6XCWB93FXhz4LIw1gPG/XwfvlfOEVgR9HuX+7mJ3BkKZlLYopU2rOonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVtZQAg0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8DwgRJEZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708361839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dm+peGplDwnHuVHm6xN1c7FQqxraIl8WA7/xR6XwfzI=;
	b=JVtZQAg0VuzD4pvtlCtEEab+1EI+n5XoFSq46kzexfHCrrEkVn/ZJ3g5zUK8RtbizDY1rJ
	vl+QtbHBt4jE2RN8N43k0PBkHiLyy5PhTHxKlhul45QP2lwTbhognybongx22DNDYW75a/
	sKHdP8m77PgYDxQQDAZJXuM8I54uktDMcnM8Q1X83ljoJSZk+yUOQeyZs4Ft++yAQ6I7G0
	FH/2FSNlDomvNLk2Fs6zuylOr4ez/dN8F/g66HE1OXoR7gxPR4fjZgK0FUT/GHshmP0Ejn
	dYGoezLOw5qEBMQAUVme4tU7mg4gD9CBFoFDXX8WCkWNXyR1/DnjPQaKx9L1bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708361839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dm+peGplDwnHuVHm6xN1c7FQqxraIl8WA7/xR6XwfzI=;
	b=8DwgRJEZw6nVJPyGKEh1hknNuJyy3zcQkowApAev6R1js4mPh3omqysbDa5lofL4Idjt/q
	HdYPz0l7G5c8VXBw==
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
 <kprateek.nayak@amd.com>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v10 13/20] timers: Add get next timer interrupt
 functionality for remote CPUs
In-Reply-To: <ZdN8KCTB2smSZb88@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-14-anna-maria@linutronix.de>
 <ZdN8KCTB2smSZb88@localhost.localdomain>
Date: Mon, 19 Feb 2024 17:57:16 +0100
Message-ID: <87edd8fl3n.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 15, 2024 at 03:37:36PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> +# ifdef CONFIG_SMP
>> +/**
>> + * fetch_next_timer_interrupt_remote() - Store next timers into @tevt
>> + * @basej:	base time jiffies
>> + * @basem:	base time clock monotonic
>> + * @tevt:	Pointer to the storage for the expiry values
>> + * @cpu:	Remote CPU
>> + *
>> + * Stores the next pending local and global timer expiry values in the
>> + * struct pointed to by @tevt. If a queue is empty the corresponding
>> + * field is set to KTIME_MAX. If local event expires before global
>> + * event, global event is set to KTIME_MAX as well.
>> + *
>> + * Caller needs to make sure timer base locks are held (use
>> + * timer_lock_remote_bases() for this purpose).
>> + */
>> +void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
>> +				       struct timer_events *tevt,
>> +				       unsigned int cpu)
>> +{
>> +	struct timer_base *base_local, *base_global;
>> +
>> +	/* Preset local / global events */
>> +	tevt->local =3D tevt->global =3D KTIME_MAX;
>> +
>> +	base_local =3D per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
>> +	base_global =3D per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
>> +
>> +	lockdep_assert_held(&base_local->lock);
>> +	lockdep_assert_held(&base_global->lock);
>> +
>> +	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt=
);
>
> If the next timer is global and it is <=3D jiffies + 1, the result will be
> returned in tevt.local only and not on tevt.global. So a remote fetch may=
 miss it.

Oh no. But yes, sounds reasonable.

> For this to work on both local and remote fetch, you may need:
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 320eb4ceafa2..64ce9a7760f5 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2004,6 +2007,8 @@ static unsigned long fetch_next_timer_interrupt(uns=
igned long basej, u64 basem,
>  		if (time_before(nextevt, basej))
>  			nextevt =3D basej;
>  		tevt->local =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
> +		if (!local_first)
> +			tevt->global =3D tevt->local;
>  		return nextevt;
>  	}
>=20=20

Will fix it - with a big comment explaining why this is required for
remote call sites and will not hurt when executed on the local cpu.

Thanks a lot!

