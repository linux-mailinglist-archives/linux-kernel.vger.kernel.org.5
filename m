Return-Path: <linux-kernel+bounces-54731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47884B2FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCFB1F23F73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662591EA72;
	Tue,  6 Feb 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exGI5WQm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U61mteaU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4158101
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217417; cv=none; b=qkthgNEGmqvXyLS7vIFqsRLyqP+k+YMf6P5lYNvQDDENfy4d0tjlfwm5CfSlfIiD8d6MlGT8cpQi/I4cb9O1Mi1lNAXSjupastPaVBWvXGNPmgXyt7lfMsmxFR5yIO4KkjPiiq7PHXO0E4RjHKNsU20mzcGn7PIg03aR1dDDYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217417; c=relaxed/simple;
	bh=6ZP53OUwqRCGv1eI00Tz14ijpNNO5RRahL0r3GROhWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TwPhtbspN8RxOtwj8GsYMaxcIiRRlFU5rH9g3JOhFPbJV9v/PsUAIm2Yo2TECDzPtNkXqN+CH+7p1cjDLrLVYGyln9zwriWk5ydBbvcI+53/RRK1mNUtfyxlHj3pSBZevIDGfnzUTQKG3x3YMhNeAYaZtZ+416W3nqhd2cjq3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=exGI5WQm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U61mteaU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707217412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LZRkHWnCsTvBQL9xJHwReTgzR55YrABFN2q4XJWoC4=;
	b=exGI5WQm8Q3K2kUT5akE03gmds+JS7ZGhfwF9QKZy4bcOWPtWZUrn79CeRonekX30L5la7
	yHexhjWE52bQuZLXLAg90+yNuryTwbC+XSwnURf3pDDbszRKrlXTrUX6HaGT2X12u4dIzv
	lFuiHiBJCQglwZdGfGLWwsNjWcFBYQQHA5Hr+qnHiugWtupXarZ1L2rLuZvX2MHsTmcR9z
	sE05rd5sTVLG5QMs9+WTJ4q4ryRHXjqM+AXRmimhtuGCUX5cI/lC6hbR3IBHFgB4A7VzsQ
	wka35acF+n3v5Ti2vk/8oHxr7qSwWzsyFQWHB1yMIQB9CCS4jfORhwI0eOB15A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707217412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LZRkHWnCsTvBQL9xJHwReTgzR55YrABFN2q4XJWoC4=;
	b=U61mteaUoB5LIGp8GnOfJ1TvaFpL2zqzpDDlMskBqyHRkX1GwwKePVmyHRYxlsCyw7aThZ
	pFQdYK4djy+9smAg==
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
In-Reply-To: <ZcAJjhZKlcUDxzKc@pavilion.home>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZcAJjhZKlcUDxzKc@pavilion.home>
Date: Tue, 06 Feb 2024 12:03:32 +0100
Message-ID: <87h6il3ldn.fsf@somnus>
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
>> +			walk_done =3D true;
>> +			goto unlock;
>> +		}
>> +	} else {
>> +		/*
>> +		 * An update of @evt->cpu and @evt->ignore flag is required only
>> +		 * when @child is set (the child is equal or higher than lvl0),
>> +		 * but it doesn't matter if it is written once more to the per
>> +		 * CPU event; make the update unconditional.
>> +		 */
>> +		evt->cpu =3D first_childevt->cpu;
>> +		evt->ignore =3D false;
>> +	}
>> +
>> +	walk_done =3D !group->parent;
>> +
>> +	/*
>> +	 * If the child event is already queued in the group, remove it from t=
he
>> +	 * queue when the expiry time changed only.
>> +	 */
>> +	if (timerqueue_node_queued(&evt->nextevt)) {
>> +		if (evt->nextevt.expires =3D=3D nextexp)
>> +			goto check_toplvl;
>> +
>> +		leftmost_change =3D timerqueue_getnext(&group->events) =3D=3D &evt->n=
extevt;
>> +		if (!timerqueue_del(&group->events, &evt->nextevt))
>> +			WRITE_ONCE(group->next_expiry, KTIME_MAX);
>> +	}
>> +
>> +	evt->nextevt.expires =3D nextexp;
>> +
>> +	if (timerqueue_add(&group->events, &evt->nextevt)) {
>> +		leftmost_change =3D true;
>> +		WRITE_ONCE(group->next_expiry, nextexp);
>> +	}
>> +
>> +check_toplvl:
>> +	if (walk_done && (groupstate.migrator =3D=3D TMIGR_NONE)) {
>> +		/*
>> +		 * Nothing to do when first event didn't changed and update was
>> +		 * done during remote timer handling.
>> +		 */
>> +		if (remote && !leftmost_change)
>
> So if the first timer in the list hasn't changed, and that first timer be=
longs
> to another CPU (and another group) than the tmc for which we are remotely
> handling timers and re-propagating timers up, then data->firstexp will be
> after the leftmost timer expiration (data->firstexp could even be KTIME_M=
AX
> in the worst case), and so will be tmc->wakeup for the caller of
> tmigr_handle_remote()?
>

This is related to the discussion regarding tmigr_handle_remote_up(). So
this should be also covered by the change I proposed there.

And then we definitely do not need the update of data->firstevt here, as
we are still on the way to top to make sure all events are handled. And
the first event which needs to be handled by the migrator CPU is set by
the call to tmigr_next_expired_groupevt().

>
>> +			goto unlock;
>> +		/*
>> +		 * The top level group is idle and it has to be ensured the
>> +		 * global timers are handled in time. (This could be optimized
>> +		 * by keeping track of the last global scheduled event and only
>> +		 * arming it on the CPU if the new event is earlier. Not sure if
>> +		 * its worth the complexity.)
>> +		 */
>> +		data->firstexp =3D tmigr_next_groupevt_expires(group);
>> +	}
>> +
>> +unlock:
>> +	raw_spin_unlock(&group->lock);
>> +
>> +	if (child)
>> +		raw_spin_unlock(&child->lock);
>> +
>> +	return walk_done;
>> +}

