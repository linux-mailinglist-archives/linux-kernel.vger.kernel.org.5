Return-Path: <linux-kernel+bounces-55089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF6C84B78E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CD71C2536A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6E131E47;
	Tue,  6 Feb 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+hHP1vp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJSQqycG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098E131E29
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228809; cv=none; b=pdrOFfrlNQzrdEH4BrAL3GAVTNUvDNj7z2d7n4xmXCmR8DL/JtT9/dTDEKFEGGtpwvjQRaHIf9c9CgoOLwZEVWI5XoR/hVDbwfk6mKTshv9z+SU/afYmK0qVnouAUuvNRPws8PlZsAjhpHGA/qGrKh+/FihKuhCAWzLxxxahAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228809; c=relaxed/simple;
	bh=9i2VhkIQDk5veFniGTSpL/iY9cyw3Xr+ZiniP0Mx/Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uw5bz3T4fcC5CKV6RYp9Q1UsLcme44M91Cg8HGBNJLP4ppacpWYODXexx9z2ma0xmRy744mEG9p+3DMHEi/S5ZtKk9A/kn9jO1vkzMWuNQmUhUecg9L7qMgzOpivjLbEPuuuGhwmbHfFRsUjgKyhm3jVmajmiWdoDe6gOau/mJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+hHP1vp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJSQqycG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707228804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNnu1k5ooezxCWqUfkL19987OPJ/E7GSIQiW9phWRg8=;
	b=A+hHP1vpQSQHlP/CNmnOVuXpK/Scj3B7ZygPFo1zqTLscm9tsXZd+Tv8EfCugdDhBN9jD4
	EgrZ4HwgWVXUlnVPcxsiv5rtAKiNDDF0s/MaisQdfILBfEGHbG/aRooNllAHGREbZjKlav
	pZMfGdXqeSsWiUz9DJgSrDK4O5q2guxu5jLyLnvO78yn11bV449f0hm9d/KRNcVp/AfZD0
	ZQoN96sZ2p/nuCXGg+6S8ZnLSxUxh4sQVla6ujxIr9SyBgLhriJvPgcsCZOJkQJ0Tj2PXN
	+XTqaOXU47lQRq8KNx8nSiqzyWIwuTsTzT7zZePK/WV8THOtEXB1eKH6WXJlYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707228804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNnu1k5ooezxCWqUfkL19987OPJ/E7GSIQiW9phWRg8=;
	b=zJSQqycGrDKix49apjGqJw7m3q4YAw3Np9mrtRihj776WDGbOWlVmGdBvRwnfpjDfamrte
	+3FesofzXF5gV1AA==
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
In-Reply-To: <ZcIyWJxeLy4GaTbM@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZcAQZ8-gbEYaQflu@pavilion.home> <87eddp3ju0.fsf@somnus>
 <ZcIyWJxeLy4GaTbM@localhost.localdomain>
Date: Tue, 06 Feb 2024 15:13:23 +0100
Message-ID: <878r3x3cl8.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Tue, Feb 06, 2024 at 12:36:55PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a =C3=A9c=
rit :
>> >> +/*
>> >> + * Returns true, if there is nothing to be propagated to the next le=
vel
>> >> + *
>> >> + * @data->firstexp is set to expiry of first gobal event of the (top=
 level of
>> >> + * the) hierarchy, but only when hierarchy is completely idle.
>> >> + *
>> >> + * This is the only place where the group event expiry value is set.
>> >> + */
>> >> +static
>> >> +bool tmigr_update_events(struct tmigr_group *group, struct tmigr_gro=
up *child,
>> >> +			 struct tmigr_walk *data, union tmigr_state childstate,
>> >> +			 union tmigr_state groupstate)
>> >> +{
>> >> +	struct tmigr_event *evt, *first_childevt;
>> >> +	bool walk_done, remote =3D data->remote;
>> >> +	bool leftmost_change =3D false;
>> >> +	u64 nextexp;
>> >> +
>> >> +	if (child) {
>> >> +		raw_spin_lock(&child->lock);
>> >> +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
>> >> +
>> >> +		if (childstate.active) {
>> >> +			walk_done =3D true;
>> >> +			goto unlock;
>> >> +		}
>> >> +
>> >> +		first_childevt =3D tmigr_next_groupevt(child);
>> >> +		nextexp =3D child->next_expiry;
>> >> +		evt =3D &child->groupevt;
>> >> +	} else {
>> >> +		nextexp =3D data->nextexp;
>> >> +
>> >> +		first_childevt =3D evt =3D data->evt;
>> >> +
>> >> +		/*
>> >> +		 * Walking the hierarchy is required in any case when a
>> >> +		 * remote expiry was done before. This ensures to not lose
>> >> +		 * already queued events in non active groups (see section
>> >> +		 * "Required event and timerqueue update after a remote
>> >> +		 * expiry" in the documentation at the top).
>> >> +		 *
>> >> +		 * The two call sites which are executed without a remote expiry
>> >> +		 * before, are not prevented from propagating changes through
>> >> +		 * the hierarchy by the return:
>> >> +		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
>> >> +		 *    is never set.
>> >> +		 *  - tmigr_inactive_up() takes care of the propagation by
>> >> +		 *    itself and ignores the return value. But an immediate
>> >> +		 *    return is required because nothing has to be done in this
>> >> +		 *    level as the event could be ignored.
>> >> +		 */
>> >> +		if (evt->ignore && !remote)
>> >> +			return true;
>> >> +
>> >> +		raw_spin_lock(&group->lock);
>> >> +	}
>> >> +
>> >> +	if (nextexp =3D=3D KTIME_MAX) {
>> >> +		evt->ignore =3D true;
>> >> +
>> >> +		/*
>> >> +		 * When the next child event could be ignored (nextexp is
>> >> +		 * KTIME_MAX) and there was no remote timer handling before or
>> >> +		 * the group is already active, there is no need to walk the
>> >> +		 * hierarchy even if there is a parent group.
>> >> +		 *
>> >> +		 * The other way round: even if the event could be ignored, but
>> >> +		 * if a remote timer handling was executed before and the group
>> >> +		 * is not active, walking the hierarchy is required to not miss
>> >> +		 * an enqueued timer in the non active group. The enqueued timer
>> >> +		 * of the group needs to be propagated to a higher level to
>> >> +		 * ensure it is handled.
>> >> +		 */
>> >> +		if (!remote || groupstate.active) {
>> >> +			walk_done =3D true;
>> >> +			goto unlock;
>> >
>> > So if the current tmc going inactive was the migrator for the whole hi=
erarchy
>> > and it is reaching here the top-level, this assumes that if none of th=
is tmc's
>> > groups have a timer, then it can just return. But what if the top leve=
l has
>> > timers from other children? Who is going to handle them then?
>> >
>> > Should this be "goto check_toplvl" instead?
>> >
>>=20
>> Simply replacing this goto will not work. Then we chould end up with a
>> 'data->firstexp' set even if we do not want to have it (when remote is
>> not set).
>
> Hmm, but the (groupstate.migrator =3D=3D TMIGR_NONE) condition should pre=
vent that,
> no?
>

When remote is not set, and the group is not active (but it's not top
level), walk_done will be set to true. Then goto check_toplevel. There
walk_done and the groupstate migrator check is both true. But it is not
top level... and the next goto unlock will also not happen and
data->firstexp will be set. No?

>>=20
>> There is another issue in here. When the event could be ignored and it
>> is propagated because of e.g. remote timer handling, then the timerqueue
>> dance is done nevertheless. It's not a big problem (as the ignore flag
>> is set and event is removed of queue when revisting the timer queue),
>> but its obviously more work than it is required to have.
>
> Right. I guess it doesn't hurt to delete it from the timerqueue if presen=
t and
> then update group->next_expiry accordingly. But it's certainly not useful
> to requeue it :-)
>

This would be the plan to keep the delete but drop the requeue in this
case.

With those two things, the tmigr_update_events() wants to be changed a
little more.

Thanks

> Thanks.
>
>>=20
>> Thanks
>>=20
>> >> +		}
>> >> +	} else {
>> >> +		/*
>> >> +		 * An update of @evt->cpu and @evt->ignore flag is required only
>> >> +		 * when @child is set (the child is equal or higher than lvl0),
>> >> +		 * but it doesn't matter if it is written once more to the per
>> >> +		 * CPU event; make the update unconditional.
>> >> +		 */
>> >> +		evt->cpu =3D first_childevt->cpu;
>> >> +		evt->ignore =3D false;
>> >> +	}
>> >> +
>> >> +	walk_done =3D !group->parent;
>> >> +
>> >> +	/*
>> >> +	 * If the child event is already queued in the group, remove it fro=
m the
>> >> +	 * queue when the expiry time changed only.
>> >> +	 */
>> >> +	if (timerqueue_node_queued(&evt->nextevt)) {
>> >> +		if (evt->nextevt.expires =3D=3D nextexp)
>> >> +			goto check_toplvl;
>> >> +
>> >> +		leftmost_change =3D timerqueue_getnext(&group->events) =3D=3D &evt=
->nextevt;
>> >> +		if (!timerqueue_del(&group->events, &evt->nextevt))
>> >> +			WRITE_ONCE(group->next_expiry, KTIME_MAX);
>> >> +	}
>> >> +
>> >> +	evt->nextevt.expires =3D nextexp;
>> >> +
>> >> +	if (timerqueue_add(&group->events, &evt->nextevt)) {
>> >> +		leftmost_change =3D true;
>> >> +		WRITE_ONCE(group->next_expiry, nextexp);
>> >> +	}
>> >> +
>> >> +check_toplvl:
>> >> +	if (walk_done && (groupstate.migrator =3D=3D TMIGR_NONE)) {
>> >> +		/*
>> >> +		 * Nothing to do when first event didn't changed and update was
>> >> +		 * done during remote timer handling.
>> >> +		 */
>> >> +		if (remote && !leftmost_change)
>> >> +			goto unlock;
>> >> +		/*
>> >> +		 * The top level group is idle and it has to be ensured the
>> >> +		 * global timers are handled in time. (This could be optimized
>> >> +		 * by keeping track of the last global scheduled event and only
>> >> +		 * arming it on the CPU if the new event is earlier. Not sure if
>> >> +		 * its worth the complexity.)
>> >> +		 */
>> >> +		data->firstexp =3D tmigr_next_groupevt_expires(group);
>> >> +	}
>> >> +
>> >> +unlock:
>> >> +	raw_spin_unlock(&group->lock);
>> >> +
>> >> +	if (child)
>> >> +		raw_spin_unlock(&child->lock);
>> >> +
>> >> +	return walk_done;
>> >> +}

