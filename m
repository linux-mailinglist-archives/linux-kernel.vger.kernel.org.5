Return-Path: <linux-kernel+bounces-48831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C266884622A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176BE287F30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEA3CF52;
	Thu,  1 Feb 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kjC8SJTu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+bpgpd+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC943CF40
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820785; cv=none; b=WVWA/6CVPSH0CZyNAd4P11OzS4y8UcvgNLrBAEEsZDbtBz1vF9Z6D3OQmL0MX7wHPV2bUSXmCqHAKcHO80mUjNTFzyirgx1FOF+vYg1MUxCthE2oJWprBzCbWmeTU/Fc5l4krAkcBieBQ6L3zdWRZjxJiSEos1AXrFbzIHYnPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820785; c=relaxed/simple;
	bh=b2JItZ51zEB/YEAZpwvKdAFils5MDdWV1SqvVQvFhco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t98gQ2QP9+LnoxtRd55UT+bf4cxMHh/M1sqb1H0erfS9RPhotnF81RZDZeMhpU6qlp6iog7QrAoDYvpeMKIJNe8quzFzN+C84QfK8yQKt/EA9dFV+HjU7AtUP5R96Z6z8USSWEde7yGbF6CMTs2TjicbBpE8kuZ9aDlB7PU1nXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kjC8SJTu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+bpgpd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706820781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjv+KgDQ1GYxe+4D5pZPTXuYE3TGKfPQ5fig2YXspLI=;
	b=kjC8SJTul+SSUd/sUXzaVrx0e10rbhaBkI5dCuEWpKszKR21HtC1j+QXxypWO1F574EF00
	OA54r805yF3jD5vlIYupHvp6DEIWixzkPS08GfUWnLWbtxTEzgRjTELNiozpSujF8A/5UZ
	0FIDDpaIROWneF8yy+KAh0geLCuw+IDsD/bgNCAgd9BQHCuKXvOpCOIp6eOz74QgUJwZhL
	iSXVvrKXgf+F7dcIhlwN9mRo1mD2sGrKM91Pxn4inrpYBexqY/di9SlN62IS10oUxtKhft
	x7A9pTJOTfZN114rz+/L1MF+Vjt7LCzqlHLdnKVjxcHaAp6yO3x9GXyQQIQVEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706820781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjv+KgDQ1GYxe+4D5pZPTXuYE3TGKfPQ5fig2YXspLI=;
	b=c+bpgpd+6hIdxPORgrUI47zTs4vUYUjDfv33i1PV3Fhdeyl541unlip3FzAuoffew9uNsG
	hNISxqRgX3ZFjSAA==
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
In-Reply-To: <ZbvYJysR7gnaQiNg@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain> <87bk90i2ja.fsf@somnus>
 <ZbvYJysR7gnaQiNg@localhost.localdomain>
Date: Thu, 01 Feb 2024 21:52:59 +0100
Message-ID: <87y1c3lxec.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Thu, Feb 01, 2024 at 05:15:37PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a =C3=A9c=
rit :
>> >> +static void tmigr_connect_child_parent(struct tmigr_group *child,
>> >> +				       struct tmigr_group *parent)
>> >> +{
>> >> +	union tmigr_state childstate;
>> >> +
>> >> +	raw_spin_lock_irq(&child->lock);
>> >> +	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
>> >> +
>> >> +	child->parent =3D parent;
>> >> +	child->childmask =3D BIT(parent->num_children++);
>> >> +
>> >> +	raw_spin_unlock(&parent->lock);
>> >> +	raw_spin_unlock_irq(&child->lock);
>> >> +
>> >> +	/*
>> >> +	 * To prevent inconsistent states, active children need to be activ=
e in
>> >> +	 * the new parent as well. Inactive children are already marked ina=
ctive
>> >> +	 * in the parent group.
>> >> +	 */
>> >> +	childstate.state =3D atomic_read(&child->migr_state);
>> >> +	if (childstate.migrator !=3D TMIGR_NONE) {
>> >
>> > Is it possible here to connect a running online child (not one that we=
 just
>> > created) to a new parent?
>>=20
>> connect_child_parent() is only executed for the just created ones. So,
>> yes in theory this would be possible, but it doesn't happen as
>> tmigr_setup_groups() takes care to make it right (hopefully :)). When a
>> LVL0 group has some space left, only the connection between tmc and the
>> LVL0 group is done in tmigr_setup_groups(). If there is no space left in
>> LVL0 group, then a new group is created and depending on the levels
>> which has to be created only executed for the new ones.
>>=20
>> > If not, is it possible that a newly created child is
>> > not TMIGR_NONE?
>>=20
>> Yes. See tmigr_cpu_online(). When new groups have to be created starting
>> from LVL0, then they are not active - so TMIGR_NONE is set. Activating
>> the new online CPU is done afterwards.
>>=20
>> But if it is required to add also a new level at the top, then it is
>> mandatory to propagate the active state of the already existing child to
>> the new parent. The connect_child_parent() is then also executed for the
>> formerly top level group (child) to the newly created group (parent).
>
> Ah and this is why we have the "if (childstate.migrator !=3D TMIGR_NONE)"
> branch, right?

yes - I see, comments would be helpful here :)

>> > Heh, I was about to say that it's impossible that timer_base_is_idle()
>> > at this stage but actually if we run in nohz_full...
>> >
>> > It happens so that nohz_full is deactivated until rcutree_online_cpu()
>> > which calls tick_dep_clear() but it's a pure coincidence that might
>> > disappear one day. So yes, let's keep it that way.
>>=20
>> I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure the
>> timer migration hierarchy state 'idle' is in sync with the timer base
>> 'idle'. And this was one part where it was possible that it runs out of
>> sync as I remember correctly. But if I understood you correctly, this
>> shouldn't happen at the moment?
>
> Well, it's not supposed to :-)

Hmm, let me double check this and run the tests on the instrumented
version...

Thanks,

	Anna-Maria


