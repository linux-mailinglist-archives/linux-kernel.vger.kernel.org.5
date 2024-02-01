Return-Path: <linux-kernel+bounces-48498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103E845CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC492292506
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D417779FE;
	Thu,  1 Feb 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zHnNgMnK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e11kxeGj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2144626BF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804143; cv=none; b=WpzGBqDP1McgskvcNAJ0rYVNM8NrxmZoDji4ja4WItisFLHHxUEpwt+Mu6dQkbyoHKjLlw8SjnUj2YdyvSVaA8xJ2IrBUujoO02oIbAfKVcXfJxUbJl+vqZ1eIkFH3K/0Q4ZgwBO1Jg/m4PGVmt61g09HV28XcpZh20CvNzHnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804143; c=relaxed/simple;
	bh=hucyDoyB198P92XOc/xJ4Fgc9b9ouJQYLAPKAPOOQxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uIL7wiBMNsmnWWXPLXLPYsJ9dgl7rD5akAK9SlxVKnjOxzwB+uqHBvsEOfF2SXQWX8nZ3sl6m28x+M8Jek/UD63oSyoqfVdT/DkRh93+lI0sVcezd0tXvZommHPB0JTGfoMBWOU0wcsAjJUqc4J3DjubjiOnBCkyJSZEYW9d86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zHnNgMnK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e11kxeGj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706804138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3su6GEjDWeW+aIiB6N0/thC4vCVzN9qzBKEIGmzsb4g=;
	b=zHnNgMnKaBdSm8FUs7VS3+hdXN3qLbkJds/TPtQ/1tDMhNooenYEAeffEk1O8CZQgUOGH5
	nzUrv19ZAATTytmM0Dcq4F2PQWjH9hE3fi2Dt5tS2qM5xXwgO48+RimEFoE+EaJdYugak5
	f29kfz6JhRhx6fpwhBf0y8WHbGPNTgH8SsJzutOX6/0iAvCKBjshXB3Bm5YGykmJafOQGO
	P9yzhk4evWDhQBnnv+OhB/A8tzQPuOKLZhTNdDEorzqyG0hiw6JeOorqWVe3JYNhNgJe22
	8GWqFjO8ScwWSUYe6OhiTAk1JBwHjMgjEzTyVZFLCWFE7Uc4b5oiQ0knReJkUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706804138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3su6GEjDWeW+aIiB6N0/thC4vCVzN9qzBKEIGmzsb4g=;
	b=e11kxeGjce5v+N6sZA3Mrsp9i5lD0/ZAhjTXKixvGuinAu4AtRantsGKK9j+ZN9RyWBU6d
	aA0AvFUFS4rq8eAw==
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
In-Reply-To: <ZbuzMeKlCgebhJZ-@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain>
Date: Thu, 01 Feb 2024 17:15:37 +0100
Message-ID: <87bk90i2ja.fsf@somnus>
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
>> +static void tmigr_connect_child_parent(struct tmigr_group *child,
>> +				       struct tmigr_group *parent)
>> +{
>> +	union tmigr_state childstate;
>> +
>> +	raw_spin_lock_irq(&child->lock);
>> +	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
>> +
>> +	child->parent =3D parent;
>> +	child->childmask =3D BIT(parent->num_children++);
>> +
>> +	raw_spin_unlock(&parent->lock);
>> +	raw_spin_unlock_irq(&child->lock);
>> +
>> +	/*
>> +	 * To prevent inconsistent states, active children need to be active in
>> +	 * the new parent as well. Inactive children are already marked inacti=
ve
>> +	 * in the parent group.
>> +	 */
>> +	childstate.state =3D atomic_read(&child->migr_state);
>> +	if (childstate.migrator !=3D TMIGR_NONE) {
>
> Is it possible here to connect a running online child (not one that we ju=
st
> created) to a new parent?

connect_child_parent() is only executed for the just created ones. So,
yes in theory this would be possible, but it doesn't happen as
tmigr_setup_groups() takes care to make it right (hopefully :)). When a
LVL0 group has some space left, only the connection between tmc and the
LVL0 group is done in tmigr_setup_groups(). If there is no space left in
LVL0 group, then a new group is created and depending on the levels
which has to be created only executed for the new ones.

> If not, is it possible that a newly created child is
> not TMIGR_NONE?

Yes. See tmigr_cpu_online(). When new groups have to be created starting
from LVL0, then they are not active - so TMIGR_NONE is set. Activating
the new online CPU is done afterwards.

But if it is required to add also a new level at the top, then it is
mandatory to propagate the active state of the already existing child to
the new parent. The connect_child_parent() is then also executed for the
formerly top level group (child) to the newly created group (parent).

>
>> +		struct tmigr_walk data;
>> +
>> +		data.childmask =3D child->childmask;
>> +
>> +		/*
>> +		 * There is only one new level per time. When connecting the
>> +		 * child and the parent and set the child active when the parent
>> +		 * is inactive, the parent needs to be the uppermost
>> +		 * level. Otherwise there went something wrong!
>> +		 */
>> +		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
>> +	}
>> +}
> [...]
>> +static int tmigr_cpu_online(unsigned int cpu)
>> +{
>> +	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
>> +	int ret;
>> +
>> +	/* First online attempt? Initialize CPU data */
>> +	if (!tmc->tmgroup) {
>> +		raw_spin_lock_init(&tmc->lock);
>> +
>> +		ret =3D tmigr_add_cpu(cpu);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (tmc->childmask =3D=3D 0)
>> +			return -EINVAL;
>> +
>> +		timerqueue_init(&tmc->cpuevt.nextevt);
>> +		tmc->cpuevt.nextevt.expires =3D KTIME_MAX;
>> +		tmc->cpuevt.ignore =3D true;
>> +		tmc->cpuevt.cpu =3D cpu;
>> +
>> +		tmc->remote =3D false;
>> +		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
>> +	}
>> +	raw_spin_lock_irq(&tmc->lock);
>> +	tmc->idle =3D timer_base_is_idle();
>> +	if (!tmc->idle)
>> +		__tmigr_cpu_activate(tmc);
>
> Heh, I was about to say that it's impossible that timer_base_is_idle()
> at this stage but actually if we run in nohz_full...
>
> It happens so that nohz_full is deactivated until rcutree_online_cpu()
> which calls tick_dep_clear() but it's a pure coincidence that might
> disappear one day. So yes, let's keep it that way.

I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure the
timer migration hierarchy state 'idle' is in sync with the timer base
'idle'. And this was one part where it was possible that it runs out of
sync as I remember correctly. But if I understood you correctly, this
shouldn't happen at the moment?

Thanks,

	Anna-Maria


