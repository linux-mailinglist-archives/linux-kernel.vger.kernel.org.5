Return-Path: <linux-kernel+bounces-52986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470F849F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B35E2828CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865244596B;
	Mon,  5 Feb 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eI4xyS1X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VpWGz+Oq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64F45957
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148790; cv=none; b=ZGF+mfo99XwaKZKybX0213ujAb6nd5VMZSlmGs4LqO9+otvspzOMvZjxeMJnWn/giEzsNIP1lBhH6gf55xOGkurJROea6DiGeAfDsSiFkBk1v7hwRVZkr5dH3J3Hyo5aQHL0fi1cnO6k4K23UOXkKWXdIsoaetFh6O8hI/a5UGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148790; c=relaxed/simple;
	bh=mg90tXSKYlVnVzV9nqdFyuxOcFgebZX+SG1uwgUf5KE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=HMF+zJ1SgQjAjWrTqTPcxWcEdxNvhc/+DZE2Lm2YRQRlS+zdk3hE4+ZtCB45boy97Ej+Zv6tj9hNbLcVVj0NUjOhFRbs2HpLgxAQFTuYzZW8z2PXqTOg03pR5oa8fAU+qxLKK5J7obiuDYM4cGZBQIHhpXF0ize8JpYBAHrpGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eI4xyS1X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VpWGz+Oq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707148786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=3zgMOwdfmaBrPpJWcWaAk1Bv94XR6alX/vcC8fZQAHU=;
	b=eI4xyS1X8RgmniiqIwW3S82zQPcMwXBcBzgrJLEsUZwXILcLECkWRnf/0KoBZJ4bPxgkjV
	VJ4jBpugwZIZEvA0Bu9KAJ6NEf9F2JuCYe+H77iQM4MruyqNg3DIbsakH6e5693O/iqglk
	Ao6Agd7/E3hhnzZoewdGIzCPPqZmL4uC6r4/LU5a73QGq56kAyv8SHdniXsjiBOv7luh/B
	fxq8/evJ8aBe+UxibdjJWnaoppRZAOCa1ym9bB2JCJZ8cDwkgG2oNfeL34Cb2D3RSUvvqx
	vQbtHJIlWdTvPhvMl3C38JZcYp8ZNQj0iQKJv94hFOBfN+5aHnBXwnTyvRyXyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707148786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=3zgMOwdfmaBrPpJWcWaAk1Bv94XR6alX/vcC8fZQAHU=;
	b=VpWGz+Oq3aos67LcFt82JvOKLMHrKABlUS+kOVITHYwnWPGskL2RqHqlQF2ZYX6vY3MMlC
	WKIlKyY62SvjMQAA==
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
In-Reply-To: <ZbvHvKdpgqfsJp0E@localhost.localdomain>
Date: Mon, 05 Feb 2024 16:59:45 +0100
Message-ID: <871q9qucjy.fsf@somnus>
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
>> +static bool tmigr_handle_remote_up(struct tmigr_group *group,
>> +				   struct tmigr_group *child,
>> +				   void *ptr)
>> +{
>> +	struct tmigr_remote_data *data =3D ptr;
>> +	u64 now, next =3D KTIME_MAX;
>> +	struct tmigr_event *evt;
>> +	unsigned long jif;
>> +	u8 childmask;
>> +
>> +	jif =3D data->basej;
>> +	now =3D data->now;
>> +
>> +	childmask =3D data->childmask;
>> +
>> +again:
>> +	/*
>> +	 * Handle the group only if @childmask is the migrator or if the
>> +	 * group has no migrator. Otherwise the group is active and is
>> +	 * handled by its own migrator.
>> +	 */
>> +	if (!tmigr_check_migrator(group, childmask))
>> +		return true;
>> +
>> +	raw_spin_lock_irq(&group->lock);
>> +
>> +	evt =3D tmigr_next_expired_groupevt(group, now);
>> +
>> +	if (evt) {
>> +		unsigned int remote_cpu =3D evt->cpu;
>> +
>> +		raw_spin_unlock_irq(&group->lock);
>> +
>> +		next =3D tmigr_handle_remote_cpu(remote_cpu, now, jif);
>> +
>> +		/* check if there is another event, that needs to be handled */
>> +		goto again;
>> +	} else {
>> +		raw_spin_unlock_irq(&group->lock);
>> +	}
>> +
>> +	/*
>> +	 * Update of childmask for the next level and keep track of the expiry
>> +	 * of the first event that needs to be handled
>> +	 */
>> +	data->childmask =3D group->childmask;
>> +	data->firstexp =3D next;
>
> So assume we have:
>
>             [GRP1:0]
>         migrator =3D [GRP0:0]
>         active   =3D [GRP0:0]
>         nextevt  =3D TIMER3
>         /                    \
>     [GRP0:0]                  [GRP0:1]
>  migrator =3D CPU0           migrator =3D NONE
>  active   =3D CPU0           active   =3D NONE
>  nextevt  =3D KTIME_MAX      nextevt  =3D TIMER3
>     /         \                /         \
>    0           1              2           3
>   idle       idle           idle         idle (TIMER3)
>
> Then CPU 0 goes idle:
>
>             [GRP1:0]
>         migrator =3D NONE
>         active   =3D NONE
>         nextevt  =3D TIMER3
>         /                    \
>     [GRP0:0]                  [GRP0:1]
>  migrator =3D NONE           migrator =3D NONE
>  active   =3D NONE           active   =3D NONE
>  nextevt  =3D KTIME_MAX      nextevt  =3D TIMER3
>     /         \                /         \
>    0           1              2           3
>   idle       idle           idle         idle (TIMER3)
>
> CPU 0 is the idle migrator and its tmc->wakeup is TIMER3.
> But CPU 0 has a local timer that expires before TIMER3.
>
> When that timer interrupt fires, it raises the softirq, which
> executes on IRQ tail. So CPU0 eventually calls tmigr_handle_remote()
> before TIMER3 has expired.
>
> This leads to tmigr_next_expired_groupevt() to return NULL and then
> data->firstexp =3D KTIME_MAX and then tmc->wakeup =3D KTIME_MAX.
>
> Later on, tmigr_new_timer() is called with a KTIME_MAX global
> event and so tmc->wakeup stays with KTIME_MAX, ignoring TIMER3.
>
> It looks like you need to handle the tmigr_next_expired_groupevt()
> case returning NULL.

Yes. You are right. group->next_expiry is updated via
tmigr_next_expired_groupevt(). So I should take this value to rely on
for the firstevt.

But with this, we do not need the return value of
tmigr_handle_remote_cpu(). When the upperst level is inactive and there
is a timer (e.g. propagated there by tmigr_handle_remote_cpu()), the
return value of tmigr_handle_remote_cpu() is the next_expiry of the top
level group. But this value is also noticed by walking the hierarchy up
to the top level with tmigr_handle_remote_up().

Thanks,

	Anna-Maria




