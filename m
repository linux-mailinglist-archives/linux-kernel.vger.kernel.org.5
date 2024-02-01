Return-Path: <linux-kernel+bounces-48348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4EB845ABE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80B81F2AEAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EE5F48E;
	Thu,  1 Feb 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EIiIQwMH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XiRrtL0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A556216D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799548; cv=none; b=b6RargtB85M1vEPHIcWaC7s4ro9qZ7CpJTkmDEFHnUGNXca3xLsuzq7RQPDvNLtQI778YsrYgNVw4W0XTFgons5dSfBXirdw0V2qcRmFBh1b6mhWHm++B9RbFeTfq4MZ9w5WHoKvs1NU2USyCO7dUXvgZSKkbk5hKMnrUpz1J+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799548; c=relaxed/simple;
	bh=qYBzVxN/toizf+c74JhJSSZBszcVHARS+S1gzemK420=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWCS4mCDH4MoWhks5ohb/Jp2IGqIY4bexLQ/5gdsdXrkh0l7f4NLwu30FDkc6p1IIWiDmFxEA6q2PJbUxQgHZJeHejR1uJRAq9E2UEupsXT4IWAD6+5Tmw14cPgFT1XPKbqoUzKjr7XakM3vtT0HKv5qdcFFLcL4tjy0ioiTFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EIiIQwMH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XiRrtL0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706799544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gV0yMeUYhE+MqNs3Pqvta+vb1Igb0yaxfvONXao6KZk=;
	b=EIiIQwMHyfJtQT4CTtUL1Rp7SxQfp46AjpQs9I+qROqiywNZOci+siXkAcc4o8JCFM9dUi
	AJbWEsjRih5HVaeB9V2mrxN0rGG4Et2E76YIFU6CaNFGKs6B18lPqVckspiDdeCjsEm4+s
	EiI+H3CgnVQuoXYvatSQgs6RzusIUEwcDLuUcr6lE4FAmeMD4dl8VA51XAF1ye/FJaER0v
	/OatdUsczmOZ0jNNDq6EREBB6hx/V//0jikyFu5xwt9vfu1HlJyjvZqS+EuUhZNoN7NOkd
	TfvLjvwlpuNf44FnbpHDVRqBlRWwsezxGkKFRTst2nJzAKgLI4H0Q8DEn02aOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706799544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gV0yMeUYhE+MqNs3Pqvta+vb1Igb0yaxfvONXao6KZk=;
	b=1XiRrtL0X0jJrdFoBVohwAy0hl76aYHo5uYPmoAZlOetd9kZDtkeLfofy/cVH6gzNwZe6M
	jKD114+XLJbZ2vAA==
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
In-Reply-To: <ZbkXzsUWZUurSiSk@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbkXzsUWZUurSiSk@localhost.localdomain>
Date: Thu, 01 Feb 2024 15:59:03 +0100
Message-ID: <87sf2c6xjc.fsf@somnus>
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
>> +/*
>> + * Returns true, if there is nothing to be propagated to the next level
>> + *
>> + * @data->firstexp is set to expiry of first gobal event of the (top le=
vel of
>> + * the) hierarchy, but only when hierarchy is completely idle.
>> + *
>> + * This is the only place where the group event expiry value is set.
>> + */
>> +static
>> +bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group =
*child,
>> +			 struct tmigr_walk *data, union tmigr_state childstate,
>> +			 union tmigr_state groupstate)
>> +{
>> +	struct tmigr_event *evt, *first_childevt;
>> +	bool walk_done, remote =3D data->remote;
>> +	bool leftmost_change =3D false;
>> +	u64 nextexp;
>> +
>> +	if (child) {
>> +		raw_spin_lock(&child->lock);
>> +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
>> +
>> +		if (childstate.active) {
>
> Since you're going to do the atomic_read(&group->migr_state)
> within the group->lock, you may as well do the atomic_read(&child->migr_s=
tate)
> within the child->lock. It won't hurt and simplifies the picture
> in the mind.

Already changed it this way.

> Then you can add the following comment to outline the ordering
> expectations:
>
> /*
>  * Observing child->migr_state.active means that:
>  *
>  * 1) Either the child is effectively active, then it's fine to stop here
>  *
>  * 2) Or we are racing with a CPU going inactive and this childstate is a=
ctually
>  *    not active anymore but tmigr_inactive_up() hasn't yet called tmigr_=
update_event()
>  *    on it. It's fine to stop here because that pending call will take c=
are
>  *    of the rest of the propagation.
>  *
>  * 3) In any case it's impossible to observe childstate.active when a rac=
ing
>  *    CPU made it inactive and also called tmigr_update_event() on it. The
>  *    group->lock enforces ordering such that ->migr_state changes
>  *    in tmigr_inactive_up() are released by group->lock UNLOCK on the
>  *    subsequent call to tmigr_update_event() and then acquired by
>  *    child->lock LOCK in tmigr_new_timer() -> tmigr_update_event().
>  */

I'll add the comment! Thanks

>> +			walk_done =3D true;
>> +			goto unlock;
>> +		}
>> +
>> +		first_childevt =3D tmigr_next_groupevt(child);
>> +		nextexp =3D child->next_expiry;
>> +		evt =3D &child->groupevt;
>> +	} else {
>> +		nextexp =3D data->nextexp;
>> +
>> +		first_childevt =3D evt =3D data->evt;
>> +
>> +		/*
>> +		 * Walking the hierarchy is required in any case when a
>> +		 * remote expiry was done before. This ensures to not lose
>> +		 * already queued events in non active groups (see section
>> +		 * "Required event and timerqueue update after a remote
>> +		 * expiry" in the documentation at the top).
>> +		 *
>> +		 * The two call sites which are executed without a remote expiry
>> +		 * before, are not prevented from propagating changes through
>> +		 * the hierarchy by the return:
>> +		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
>> +		 *    is never set.
>> +		 *  - tmigr_inactive_up() takes care of the propagation by
>> +		 *    itself and ignores the return value. But an immediate
>> +		 *    return is required because nothing has to be done in this
>> +		 *    level as the event could be ignored.
>> +		 */
>> +		if (evt->ignore && !remote)
>> +			return true;
>> +
>> +		raw_spin_lock(&group->lock);
>> +	}
>> +
>> +	if (nextexp =3D=3D KTIME_MAX) {
>> +		evt->ignore =3D true;
>> +
>> +		/*
>> +		 * When the next child event could be ignored (nextexp is
>> +		 * KTIME_MAX) and there was no remote timer handling before or
>> +		 * the group is already active, there is no need to walk the
>> +		 * hierarchy even if there is a parent group.
>> +		 *
>> +		 * The other way round: even if the event could be ignored, but
>> +		 * if a remote timer handling was executed before and the group
>> +		 * is not active, walking the hierarchy is required to not miss
>> +		 * an enqueued timer in the non active group. The enqueued timer
>> +		 * of the group needs to be propagated to a higher level to
>> +		 * ensure it is handled.
>> +		 */
>> +		if (!remote || groupstate.active) {
>
> Same here, fetching group->migr_state.active from within the lock simplif=
ies
> the mind mapping.

Sure. Already changed it.

Thanks,
	Anna-Maria

