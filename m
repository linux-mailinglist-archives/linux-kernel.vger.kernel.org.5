Return-Path: <linux-kernel+bounces-42568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F9840333
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449A3284773
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EF57865;
	Mon, 29 Jan 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YLRXD1cP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9bexL5g+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239256B96
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525444; cv=none; b=Zyo624qS7GKMM2yIZfP3MKl31dVHBryhIkIJH3vZ+Zd62ZrQMak8SZd3984xLaUok7TS88noEyOsXGxNYX3EClGiplK8QJs00W/k4eIm+d7O6oM9QqcGdR7UjHa9Fn2dKjEFSZqShj8ERoUNpsqYhTG7C1j/7aRhqDPmiFECfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525444; c=relaxed/simple;
	bh=DnuTha7KNKHzQPwEWeaTvMuCeQxxhZ6GmDjhRV8GE3E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=OTMSzs5Xg6A4Rl0iMdf5BkrB69mTljafS4YnTxbF8j5LEl/C7nqgeK9bw6ATvW1VWUs+CkvNtOy8ADvxM0sOMP5wWFkSJlVEj6SqTkGhcURh7OnQSN6ARFg5pEeLHvbkh3nm6rcdb2yuZQL8q1Qqof3YqDBaD+DZ29dAMPnhbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YLRXD1cP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9bexL5g+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706525440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=eKkFbQBJR8SAcctJxozvyF5JbWof11lJ5JU0i+4RdFw=;
	b=YLRXD1cP6bE2ifq53k6rNAuNgPLBsPy0WqGzjpRdCb/y0fppmFkyKHzfeKqYLvmC5CQHt9
	iQE+N1gY1EmwDx0RB+0DB57ABAOeZfls7z8Si17mM0o0fLA8Ok+Fqyi0Dxj6NgQcNySo8j
	Z1OCEyfLtEWkwq8aJBa5SvhUDDJ4xnquEkZlgW8uH4T4AYFPmWRVm5Hg3qlD4slp3ZfxZS
	xStn5viDXogxMEeyFGAxdJHfNPHGoiUDkzAKQ4UUzHXlaWvY48lwGEMB3O3Z8z1nstrB3k
	vzKrF627X6406ePDUQe9OW6D+9p4t2vo0igop6q8DQ+pfL88uaIOPgl4yH4DqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706525440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=eKkFbQBJR8SAcctJxozvyF5JbWof11lJ5JU0i+4RdFw=;
	b=9bexL5g+R69zkW1SG+p1ywWXHd2BI7r3k5+k9dBBYIcf/ozZ/q56ClqXy/DCL9Ql0Ukhpc
	msLhHqFh2TbnvODw==
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
 <kprateek.nayak@amd.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
In-Reply-To: <ZbWJtkAj9z0S9xsH@pavilion.home>
Date: Mon, 29 Jan 2024 11:50:39 +0100
Message-ID: <87sf2gqups.fsf@somnus>
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
>> +static bool tmigr_inactive_up(struct tmigr_group *group,
>> +			      struct tmigr_group *child,
>> +			      void *ptr)
>> +{
>> +	union tmigr_state curstate, newstate, childstate;
>> +	struct tmigr_walk *data =3D ptr;
>> +	bool walk_done;
>> +	u8 childmask;
>> +
>> +	childmask =3D data->childmask;
>> +	curstate.state =3D atomic_read(&group->migr_state);
>> +	childstate.state =3D 0;
>> +
>> +	do {
>
> So I got the confirmation from Boqun (+Cc) and Paul that a failing cmpxchg
> may not order the load of the old value against subsequent loads. And
> that may apply to atomic_try_cmpxchg() as well.
>
> Therefore you not only need to turn group->migr_state read into
> an atomic_read_acquire() but you also need to do this on each iteration
> of this loop. For example you can move the read_acquire right here.

I tried to read and understand more about the memory barriers especially
the acquire/release stuff. So please correct me whenever I'm wrong.

We have to make sure that the child/group state values contain the last
updates and prevent reordering to be able to rely on those values.

So I understand, that we need the atomic_read_acquire() here for the
child state, because we change the group state accordingly and need to
make sure, that it contains the last update of it. The cmpxchg which
writes the child state is (on success) a full memory barrier. And the
atomic_read_acquire() makes sure all preceding "critical sections"
(which ends with the full memory barrier) are visible. Is this right?

To make sure the proper states are used, atomic_read_acquire() is then
also required in:
  - tmigr_check_migrator()
  - tmigr_check_migrator_and_lonely()
  - tmigr_check_lonely()
  - tmigr_new_timer_up() (for childstate and groupstate)
  - tmigr_connect_child_parent()
Right?

Regarding the pairing of acquire: What happens when two
atomic_read_acquire() are executed afterwards without pairing 1:1 with a
release or stronger memory barrier?

Now I want to understand the case for the group state here and also in
active_up path. When reading it without acquire, it is possible, that
not all changes are visible due to reordering,... . But then the worst
outcome would be that the cmpxchg fails and the loop has to be done once
more? Is this right?

I know that memory barriers are not for free and redo the loop is also
not for free. But I don't know which of both is worse. At least in
inactive_up() path, we are not in the critical path. In active_up() it
would be good to take the less expensive option.

I want to understand the atomic_try_cmpxchg_acquire() variant: The Read
is an acquire, so even if the compare/write fails, the value which is
handed back is the one which was update last with a succesful cmpxchg
and then we can rely on this value?

Thanks a lot in advance for the help to understand this topic a little
better!

	Anna-Maria

>
> Thanks.
>
>> +		if (child)
>> +			childstate.state =3D atomic_read(&child->migr_state);
>> +
>> +		newstate =3D curstate;
>> +		walk_done =3D true;
>> +
>> +		/* Reset active bit when the child is no longer active */
>> +		if (!childstate.active)
>> +			newstate.active &=3D ~childmask;
>> +
>> +		if (newstate.migrator =3D=3D childmask) {
>> +			/*
>> +			 * Find a new migrator for the group, because the child
>> +			 * group is idle!
>> +			 */
>> +			if (!childstate.active) {
>> +				unsigned long new_migr_bit, active =3D newstate.active;
>> +
>> +				new_migr_bit =3D find_first_bit(&active, BIT_CNT);
>> +
>> +				if (new_migr_bit !=3D BIT_CNT) {
>> +					newstate.migrator =3D BIT(new_migr_bit);
>> +				} else {
>> +					newstate.migrator =3D TMIGR_NONE;
>> +
>> +					/* Changes need to be propagated */
>> +					walk_done =3D false;
>> +				}
>> +			}
>> +		}
>> +
>> +		newstate.seq++;
>> +
>> +		WARN_ON_ONCE((newstate.migrator !=3D TMIGR_NONE) && !(newstate.active=
));
>> +
>> +	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, news=
tate.state));

