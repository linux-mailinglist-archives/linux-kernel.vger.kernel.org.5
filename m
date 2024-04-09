Return-Path: <linux-kernel+bounces-136509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD3E89D4F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332A81F2228A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21697E777;
	Tue,  9 Apr 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQvu/TUN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcUTBqrS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D521EA90;
	Tue,  9 Apr 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653057; cv=none; b=tVa7G494hb/ZjS7dtZ1Gf3RG8FRP0JPerou+N3xyoQHnHSZ0CoV9m5+/G/J2Zo45xRniwFFuHNJAmjHY8UIYQOIJabK8/fQ0/C8jPZwBH7xp+ahd43kLcrHTqlRw+PZCGw0Wsk9NnF/r1rAiMyqCJHajp23PH5G9TORWl2mVio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653057; c=relaxed/simple;
	bh=6p3XrYSfCp5BzdTJPB7ofCyIaoPuRSffsb8bGJ8si6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH0JFObDBIwR0sOFYuZVg1Xi0lW0xpMTbVNgwHbt3SqVnKK5fuJyy0Y2gYjqtjgHBH6l7cK//aQHa2BkTSu7CNJ7s6SA8DwlZdyCrq9mcBp5ZkOFEPwcQWsfdZz2+uk4/60TmmnQXJA4FA3RITZD830QOWiLe4f7rQ2k+ffXByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQvu/TUN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IcUTBqrS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Apr 2024 10:57:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712653053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXJNqVIAGMcVeHUGC7WuTtked9qzXGP9s4PGe4rcDN4=;
	b=uQvu/TUN7HZfe0smaCGPSFG3ofBjd80YJTJNVwTBroEg6wl04NG5PbmwSnxG57W09AXit0
	lQwp43X7EOAnFuRd/eTRLhv6BxvMYiNcX/WJ9riiwc65KscsWatgxUrikK3g16olXtQ4fn
	meUpVnDvVh6jr0wxVBSQq1D4GKs5CXX5WqHIo8GD7ntZKek6V72Wp7+FnTiyYRiG25LHss
	tzIKASmxZiXUgvIVtmDoEqGwVn+p5lFefDWva0NAbhgYVcnp8FaM8TDMzK4k1JfEs+1UhL
	k03ECZ6cA4HwxOIBzzlmTHREaTRkNDlI3n8C03azIFd/Pf/dLOmRKt7XZNp3eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712653053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXJNqVIAGMcVeHUGC7WuTtked9qzXGP9s4PGe4rcDN4=;
	b=IcUTBqrS7ZxoIsMWz18aq33YtpZnE8bFCoQpyDphBDSANCq9OFvMU0UqN4fILvXSPxcbQq
	MwzWPfMl5ehP2HCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20240409085732.FBItbOSO@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZhRhn1B0rMSNv6mV@pavilion.home>

On 2024-04-08 23:29:03 [+0200], Frederic Weisbecker wrote:
> > index c7a0274c662c8..e0b2da8de485f 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2283,21 +2283,6 @@ event_sched_out(struct perf_event *event, struct=
 perf_event_context *ctx)
> >  		state =3D PERF_EVENT_STATE_OFF;
> >  	}
> > =20
> > -	if (event->pending_sigtrap) {
> > -		bool dec =3D true;
> > -
> > -		event->pending_sigtrap =3D 0;
> > -		if (state !=3D PERF_EVENT_STATE_OFF &&
> > -		    !event->pending_work) {
> > -			event->pending_work =3D 1;
> > -			dec =3D false;
> > -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> > -			task_work_add(current, &event->pending_task, TWA_RESUME);
> > -		}
> > -		if (dec)
> > -			local_dec(&event->ctx->nr_pending);
> > -	}
> > -
> >  	perf_event_set_state(event, state);
> > =20
> >  	if (!is_software_event(event))
> > @@ -6741,11 +6726,6 @@ static void __perf_pending_irq(struct perf_event=
 *event)
> >  	 * Yay, we hit home and are in the context of the event.
> >  	 */
> >  	if (cpu =3D=3D smp_processor_id()) {
> > -		if (event->pending_sigtrap) {
> > -			event->pending_sigtrap =3D 0;
> > -			perf_sigtrap(event);
> > -			local_dec(&event->ctx->nr_pending);
> > -		}
> >  		if (event->pending_disable) {
> >  			event->pending_disable =3D 0;
> >  			perf_event_disable_local(event);
> > @@ -9592,14 +9572,23 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> > =20
> >  		if (regs)
> >  			pending_id =3D hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> > -		if (!event->pending_sigtrap) {
> > -			event->pending_sigtrap =3D pending_id;
> > +		if (!event->pending_work) {
> > +			event->pending_work =3D pending_id;
> >  			local_inc(&event->ctx->nr_pending);
> > -			irq_work_queue(&event->pending_irq);
> > +			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> > +			task_work_add(current, &event->pending_task, TWA_RESUME);
>=20
> If the overflow happens between exit_task_work() and perf_event_exit_task=
(),
> you're leaking the event. (This was there before this patch).
> See:
> 	https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m5e6c=
8ebbef04ab9a1d7f05340cd3e2716a9a8c39

Okay.

> > +			/*
> > +			 * The NMI path returns directly to userland. The
> > +			 * irq_work is raised as a dummy interrupt to ensure
> > +			 * regular return path to user is taken and task_work
> > +			 * is processed.
> > +			 */
> > +			if (in_nmi())
> > +				irq_work_queue(&event->pending_irq);
> >  		} else if (event->attr.exclude_kernel && valid_sample) {
> >  			/*
> >  			 * Should not be able to return to user space without
> > -			 * consuming pending_sigtrap; with exceptions:
> > +			 * consuming pending_work; with exceptions:
> >  			 *
> >  			 *  1. Where !exclude_kernel, events can overflow again
> >  			 *     in the kernel without returning to user space.
> > @@ -9609,7 +9598,7 @@ static int __perf_event_overflow(struct perf_even=
t *event,
> >  			 *     To approximate progress (with false negatives),
> >  			 *     check 32-bit hash of the current IP.
> >  			 */
> > -			WARN_ON_ONCE(event->pending_sigtrap !=3D pending_id);
> > +			WARN_ON_ONCE(event->pending_work !=3D pending_id);
> >  		}
> > =20
> >  		event->pending_addr =3D 0;
> > @@ -13049,6 +13038,13 @@ static void sync_child_event(struct perf_event=
 *child_event)
> >  		     &parent_event->child_total_time_running);
> >  }
> > =20
> > +static bool task_work_cb_match(struct callback_head *cb, void *data)
> > +{
> > +	struct perf_event *event =3D container_of(cb, struct perf_event, pend=
ing_task);
> > +
> > +	return event =3D=3D data;
> > +}
>=20
> I suggest we introduce a proper API to cancel an actual callback head, se=
e:
>=20
> https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#mbfac4=
17463018394f9d80c68c7f2cafe9d066a4b
> https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m0a347=
249a462523358724085f2489ce9ed91e640

This rework would work.

> >  static void
> >  perf_event_exit_event(struct perf_event *event, struct perf_event_cont=
ext *ctx)
> >  {
> > @@ -13088,6 +13084,18 @@ perf_event_exit_event(struct perf_event *event=
, struct perf_event_context *ctx)
> >  		 * Kick perf_poll() for is_event_hup();
> >  		 */
> >  		perf_event_wakeup(parent_event);
> > +		/*
> > +		 * Cancel pending task_work and update counters if it has not
> > +		 * yet been delivered to userland. free_event() expects the
> > +		 * reference counter at one and keeping the event around until
> > +		 * the task returns to userland can be a unexpected if there is
> > +		 * no signal handler registered.
> > +		 */
> > +		if (event->pending_work &&
> > +		    task_work_cancel_match(current, task_work_cb_match, event)) {
> > +			put_event(event);
> > +			local_dec(&event->ctx->nr_pending);
> > +		}
>=20
> So exiting task, privileged exec and also exit on exec call into this bef=
ore
> releasing the children.
>=20
> And parents rely on put_event() from file close + the task work.
>=20
> But what about remote release of children on file close?
> See perf_event_release_kernel() directly calling free_event() on them.

Interesting things you are presenting. I had events popping up at random
even after the task decided that it won't go back to userland to handle
it so letting it free looked like the only option=E2=80=A6

> One possible fix is to avoid the reference count game around task work
> and flush them on free_event().
>=20
> See here:
>=20
> https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28=
147d8ac06b21c64d7784d49f892e06c0e50

That wake_up() within preempt_disable() section breaks on RT.

How do we go on from here?

> Thanks.

Sebastian

