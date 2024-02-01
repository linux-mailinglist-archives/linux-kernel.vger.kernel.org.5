Return-Path: <linux-kernel+bounces-48838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0D846237
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0923728461F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587D3CF4E;
	Thu,  1 Feb 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWufQS7Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HwusgnOu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97A3B19E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821123; cv=none; b=YR/wOHSUcvzRLqRlCswp5zWUkYxH6PqI3SdFxWLCUChYdVxo0pjMRok26CzMU3BA+EyROAOBMgg2Lurl4OGARdPK3aubomtpTp2rs04MAdx5XaqFBoUJkDb4uQfpCvskSvXKXXWjTqtysT6vk9mVi4NzSThpaSCeuED7R6Pet0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821123; c=relaxed/simple;
	bh=ipdBrpeaeAq86oJiA4zfEVXmcm7GmlXAQf9z2kQe4ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ME+ZxZn/f4xXOhYA5AkP01YghnSCO8uVpfAIdx6KZ2ZTFVxyk5wOXbHxY/XGF/PhCq7BH6lblxgq2vqDpSDVxPvmCGJStzT/+ybRGVSVgfBTO9oXzIOiECjYBdS7GFQ8uhbzoZw7sQToQ+D6UDPVy0TV/FoWqdH1JMFhKunkfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWufQS7Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HwusgnOu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706821119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QI3iX6iM3CVoRL1riN3zf2VD3PRXN9V+mD6gJFRQThA=;
	b=YWufQS7QgfHY/PlXMCdTDVva1mgl/SCpBB9SAO3RWnWFWScFYbP+46OfYQyj909IDZQTp9
	uTYoPddD1nNY3WtvYoE+BweQqU+wBr+ndcZTfIA9R88MtifzVd/QgM6Vck1PC6GIvPrmN1
	rRP1x63jJest13a1+owyZKDISW4MM8s4quPUx3RP/reNY7a8ELnByhTUjRM64f2V1TTN5Q
	e45J/+y8B+U6SE+qwUxrAWDHcp7jhlRIFb3jWrsVbE4TpCQVNRjtXMClGXgWw2MeCzF/ds
	btswccaw34T0a1b6aJ9w7qoTNleIzYQ7nS4iZHqpwi9OYtHXbSNxUw7Lys96kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706821119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QI3iX6iM3CVoRL1riN3zf2VD3PRXN9V+mD6gJFRQThA=;
	b=HwusgnOuPyhVak5TfYlYrlfek+7bXWkIKnUVHU8p6OyXR+xspPNeiay9B1nYfE0Jb8gExk
	b17j5ag6G/aqMHAQ==
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
 <kprateek.nayak@amd.com>, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v10 20/20] timers: Always queue timers on the local CPU
In-Reply-To: <ZbvWhOOblt3YPaSV@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-21-anna-maria@linutronix.de>
 <ZbvWhOOblt3YPaSV@localhost.localdomain>
Date: Thu, 01 Feb 2024 21:58:38 +0100
Message-ID: <87plxflx4x.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 15, 2024 at 03:37:43PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> The timer pull model is in place so we can remove the heuristics which t=
ry
>> to guess the best target CPU at enqueue/modification time.
>>=20
>> All non pinned timers are queued on the local CPU in the separate storage
>> and eventually pulled at expiry time to a remote CPU.
>>=20
>> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.c=
om>
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Just one detail below:
>
>> @@ -590,10 +590,13 @@ trigger_dyntick_cpu(struct timer_base *base, struc=
t timer_list *timer)
>>=20=20
>>  	/*
>>  	 * We might have to IPI the remote CPU if the base is idle and the
>> -	 * timer is not deferrable. If the other CPU is on the way to idle
>> -	 * then it can't set base->is_idle as we hold the base lock:
>> +	 * timer is pinned. If it is a non pinned timer, it is only queued
>> +	 * on the remote CPU, when timer was running during queueing. Then
>> +	 * everything is handled by remote CPU anyway. If the other CPU is
>> +	 * on the way to idle then it can't set base->is_idle as we hold
>> +	 * the base lock:
>>  	 */
>> -	if (base->is_idle)
>> +	if (base->is_idle && timer->flags & TIMER_PINNED)
>
> Is the TIMER_PINNED test necessary? If base->is_idle, then the timer
> is now guaranteed to be TIMER_PINNED, right?
>

Yes, you are right. Should I drop it? To clarify it, I could add a

  WARN_ON_ONCE(!timer->flags & TIMER_PINNED)

instead.

Thanks,

	Anna-Maria


