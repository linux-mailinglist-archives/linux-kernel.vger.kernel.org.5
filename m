Return-Path: <linux-kernel+bounces-41673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE3E83F634
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A73B225CC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83C288A7;
	Sun, 28 Jan 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfADKsh3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/DG3E+o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFD2576A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457547; cv=none; b=srMkL2yV4YuG7XYOGaFqp7NcBwPBZzAdXaZnWPBfQV0M3+wn2zntDTRQ0ipTC3TNeS3xnVp+N+fm4jhRtg5eTM4FcyT+WtY0EUsv21GuOGa86lntWUguDemYBQZjYnNocIeEX+7v14vE+nfla7ynIYeDO0nCh3keRHJG/yQyTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457547; c=relaxed/simple;
	bh=VTeZgFaMux19J+AtoCTwq05Gg9e6XRPAjIoJPK6y9X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NebpBLTqNeiu/0eHBhArU/scfZ70fh5xX31NFjm/hyiLAcoMSZ5ReXEFmbyl9Z0AITEASNYPfAizU2cB9ClvEaqP4mNntELFRrfc+aaUsvMwvtmxFznGir8MlZovyzziJJw+nEIcLUaa7cjD64WlG8EP6DqltB8sXbsSPFbe0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GfADKsh3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/DG3E+o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706457537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdjxWpAbY/+ezO/HaP8FaCbSVbjWXPTuvNNbDLxVHhQ=;
	b=GfADKsh3ZkH4V4ZbE80lqE5He2TE382wUqT/wqbO7UzAh0Vz2lQGJW8mhd52FtJwdZpOoy
	/Zlk6gFsTmYD7P6jq1MQei/f2jJSMP7LmZ1CpknbFQy8OflpZ8wkpcysoW0/iwckiGm9m9
	DgT3l2bgFoUV56Ka37+HSjoVk+0QvVNWaYU3Ikk2+Mup7PcdoXxMIMeMyBWoY0Pusj+dB/
	pAErnEWKk3me3pSjZwQRiRFQ8OMGjwcW1SL+8lZPn46ruLATa5NdxArWg2NYf4B5m0j35f
	2NNxuBU4nabNny+CdwL8mQU9YRx7DVFXU4M/to152ZGlkifzR9p5msluXJujpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706457537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdjxWpAbY/+ezO/HaP8FaCbSVbjWXPTuvNNbDLxVHhQ=;
	b=D/DG3E+og+KHIJvEbZLhzLn8mNfynDfz5OT11W3v/j8VrBziYzFuZnY3Cxv5B1ku1yWYav
	5kPGThpV5LxIuOCw==
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
In-Reply-To: <ZbJwol4QoSgz0QlH@lothringen>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbJwol4QoSgz0QlH@lothringen>
Date: Sun, 28 Jan 2024 16:58:55 +0100
Message-ID: <877cjtcuv4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frederic Weisbecker <frederic@kernel.org> writes:

> On Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen wrote:
>> +/**
>> + * tmigr_quick_check() - Quick forecast of next tmigr event when CPU wants to
>> + *			 go idle
>> + *
>> + * Returns KTIME_MAX, when it is probable that nothing has to be done (not the
>> + * only one in the level 0 group; and if it is the only one in level 0 group,
>> + * but there are more than a single group active in top level)
>> + *
>> + * Returns first expiry of the top level group, when it is the only one in level
>> + * 0 and top level also only has a single active child.
>> + */
>> +u64 tmigr_quick_check(void)
>> +{
>> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
>> +	struct tmigr_group *topgroup;
>> +	struct list_head lvllist;
>> +
>> +	if (tmigr_is_not_available(tmc))
>> +		return KTIME_MAX;
>
> Offline CPUs are supposed to handle their own global timers.
>
> So instead of returning KTIME_MAX here, shouldn't we pass instead
> tevt->global as a parameter and return that value?
>
> Otherwise the quick check will simply ignore the next global event of this CPU
> if it's before the next local event.

I thought about this as well. I skipped it to keep it as simple as
possible - as this is only a forecast and might change (CPUs will come
online/go offline/deletion of timers...). But I can integrate it to keep
it more precise.

>> +
>> +	if (WARN_ON_ONCE(tmc->idle))
>> +		return KTIME_MAX;
>
> Same here I guess...

Yes.

>> +
>> +	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
>> +		return KTIME_MAX;
>
> This one makes sense.
>
>> +
>> +	for (int i = tmigr_hierarchy_levels; i > 0 ; i--) {
>> +		lvllist = tmigr_level_list[i - 1];
>> +		if (list_is_singular(&lvllist)) {
>> +			topgroup = list_first_entry(&lvllist, struct
>> tmigr_group, list);
>
> Is it safe against concurrent allocation failure in hotplug?

As you pointed out, it isn't!

> If the list is seen singular, then concurrently a CPU comes up and creates/add
> a new group. The current CPU actually fetches it instead of the current group
> because it's not singular anymore. But then some higher level group
> allocation fails and the newly added first entry is removed.
>
> list_is_singular() looks safe. But list_first_entry isn't. You can create
> list_first_entry_rcu:
>
> #define list_first_entry_rcu(ptr, type, member) \
> 	list_entry_rcu((ptr)->next, type, member)
>
> Protected inside rcu_read_lock() until the below READ_ONCE().
>
> And then use list_del_rcu/list_add_rcu/kfree_rcu on the update side.
>
> Isn't it possible to walk through group->parent instead?

Yes. Sure! This is possible and maybe also easier. I cannot remember why
I implemented it this way...

>> +
>> +			if (tmigr_check_lonely(topgroup))
>> +				return READ_ONCE(topgroup->next_expiry);

When I hand in tevt->global as a parameter, I'll need to compare the
first expiry of the toplevel group and the tevt->global value and return
the earlier expiry. Only a single child is active in top level, so it
might be that this CPU is the last active CPU in hierarchy.

I didn't check all the way to the top whether all groups are
'lonely'. So when the top level group has only a single active child, it
is also possible that the child of the top level group has two active
children... Then a return of KTIME_MAX would be also a more precise
forecast.

This quick check is there to keep the overhead minimal when checking
whether it might be possible to go idle. So I don't know, if we should
add this additional check per level (which is pretty simple when using
group->parent for walking the hierarchy). What do you think?

>> +		} else {
>> +			continue;
>> +		}
>> +	}
>> +
>> +	return KTIME_MAX;
>
> I'm less sure about that return value.


This is ok, because there is not only a single child active in top
level. This CPU is definitely not the last active CPU in hierarchy. So
it is likely that some other CPU will handle tevt->global of this CPU.

I'll add a comment :)

Thanks,

	Anna-Maria


