Return-Path: <linux-kernel+bounces-44973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9CA8429D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A868B20955
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265061272D6;
	Tue, 30 Jan 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o66xEKtp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6hfqlMT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71743823AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633111; cv=none; b=fvp+puQ+Al6+z0j8uaePRxlQ9D6bOUhSwhK+4xsRIIZEPMZP92dEQ3PBgYbGyfTnCRzbY0ioPnOorTofnbNZMyySm1uVNHuEzlh+0pRMXdGfA2sv3Z5UL8yLpEvNx1CCAxqONlSt1eqYVFP/ox2LTSAIHieQ14Rf6SQB/j42SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633111; c=relaxed/simple;
	bh=gu861JxVK+YlPBKUGVxXJIPtb1yCoYWMQ0RkEI8EOec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aaMG8EUa8o8rli0pSyIIYmmqea3Te27rrZUcoHOxBbAvtWDPuSlt5ksqF5CPRWc2jcETeR+37lmP97w+6nDX8SBAdu3zd40ogOn8r7OLPvNptGUCRTAWl/jk3nQVKGXZ+eTmIeqZzqZGAQOsQxw7aSbYxCpBf+0k1h9snCOAzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o66xEKtp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c6hfqlMT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706633107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V73c0bJOIfsp+IxKwdVANpoPIBXYkA+Z/1o8vaANWpA=;
	b=o66xEKtpWAyWBjuYIXjt6O6wK+mF69FtbbGIN4xsTRACmm1jcQjZN6bPSIVf8kdFduKzGU
	v56NVJ4RhgT0pyeVTVhcV47FDmwfPUkC/tm99GCk6wo6SnMG84JFhfkUPyY2+PEFcWvQMx
	gRHt+/QZtZIBPklUuarD8ywNA3uBbOEqW/djL1tS23KG2K8V9+7P8Ce2sUZ34zQyAGuQNb
	Bwln6EOAagc++3ozzueT4yoHyj9we0PRDDcfdEel/E3nhPw6kG9GF6k9RYpN1o+7Dt65hA
	a4+UGSHH9cYOn0hKEwmr2hEzesWoT4Bo1CQN1BTFq8Ok4R4rtN2qUVNEez355A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706633107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V73c0bJOIfsp+IxKwdVANpoPIBXYkA+Z/1o8vaANWpA=;
	b=c6hfqlMTVCJbI4Vzr+47FdgIsdk24rflmxOECbLfH3ig/8CptXsEFeZBJnkJPqxHxZ68VE
	3JQhCceeJlDxjACw==
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
In-Reply-To: <ZbkV9wVxFhQxujb3@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbJwol4QoSgz0QlH@lothringen> <877cjtcuv4.fsf@somnus>
 <ZbkV9wVxFhQxujb3@localhost.localdomain>
Date: Tue, 30 Jan 2024 17:45:06 +0100
Message-ID: <87zfwm93e5.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Sun, Jan 28, 2024 at 04:58:55PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> >> +
>> >> +			if (tmigr_check_lonely(topgroup))
>> >> +				return READ_ONCE(topgroup->next_expiry);
>>=20
>> When I hand in tevt->global as a parameter, I'll need to compare the
>> first expiry of the toplevel group and the tevt->global value and return
>> the earlier expiry. Only a single child is active in top level, so it
>> might be that this CPU is the last active CPU in hierarchy.
>>=20
>> I didn't check all the way to the top whether all groups are
>> 'lonely'. So when the top level group has only a single active child, it
>> is also possible that the child of the top level group has two active
>> children... Then a return of KTIME_MAX would be also a more precise
>> forecast.
>>=20
>> This quick check is there to keep the overhead minimal when checking
>> whether it might be possible to go idle. So I don't know, if we should
>> add this additional check per level (which is pretty simple when using
>> group->parent for walking the hierarchy). What do you think?
>
> Not sure. Maybe if the tree never exceeds 3 levels (does it?) it's ok to
> do the walk?

Levels depend on the number of CPUs and NUMA nodes

Take 4096 CPUs, all evenly distributed across 4 NUMA nodes, then you
will end up with 6 levels.

Thanks,

	Anna-Maria


