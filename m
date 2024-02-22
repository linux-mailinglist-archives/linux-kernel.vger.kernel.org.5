Return-Path: <linux-kernel+bounces-76077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148FC85F2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9BE282870
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECD182CA;
	Thu, 22 Feb 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da+44rl7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2x+XYiX6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFB17597
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589855; cv=none; b=C2IueqEZ6z8vxUvhRlbQydY8WTsy0KXaVsqKqDjltngw7tiYVtJfMQkC3lNn7U+/U35Bs1ojyw7S+afa5uV6Hj46L06COb2nE89mUVopQgQHW+MA4jMjOOk4cWPzixftZzghuRfhCb1Og5eer3cErYfuq7Op/ABNS80qE5Fjg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589855; c=relaxed/simple;
	bh=adkXh00OWymd9FZr7L/tjffgMKrN341zi5GBQtdzcx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jDrNWsWELOOCTaB/VyBncTUZTkMI5KwNbX/4q5m9129B1LFQOkMXFX3/9/xGSyunmBVZV+UZ/TcUwmspsCI7t3yYrZBJs1uas19sPwKcD7bXmxkD/SGr7Z/fY/5EUlTjU6OpATxT5sGYCNrqSpMETuEYCHZWuBNwi3YKSUOjiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da+44rl7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2x+XYiX6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708589850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBHC4CObQg9jlsK5jcnmuxSj9RPWw35ZNyR9OlhjLls=;
	b=da+44rl7ASMRgCl/1NV6NxaXl/3s0um2+3GYdhSljS/BpG19h+Ladt5MlnR6w/UPGCR3Xy
	XfEirIgpzGCawIve04B8xyjS1v7SeGfdMqmiDhjFNUklimKTfQdUrHEG7j7PUlECidczx8
	4ovPkKhyzR6PghFtG0KYT7+sfA6ctZLXXWZU5GE+lVGDUEENgoroxb+gXVNleIwQMIQhpA
	B8HYKjGZ/rgtriDlJ3f0eosayIzpCuVMJhHbThAd7p4LzQmsy7YySMTQCrSBZWovf8Cc29
	n+yz9VGKBOPHY5s6M9sU47WnuopLp8DoWoxBf8RPQdK3wrc1BQvrLgI4sf0AWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708589850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBHC4CObQg9jlsK5jcnmuxSj9RPWw35ZNyR9OlhjLls=;
	b=2x+XYiX6z0HY/mcyg7CWoKjh7tTaHMjwzbi/PI+8s4cJVbKlssj8wps8NOs4kGyc4F+CFR
	fvLRx6P9+yVMJNBQ==
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
 <kprateek.nayak@amd.com>, Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 18/20] timers: Implement the hierarchical pull model
In-Reply-To: <ZdZ87whmpul8xIBI@pavilion.home>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-19-anna-maria@linutronix.de>
 <ZdZ87whmpul8xIBI@pavilion.home>
Date: Thu, 22 Feb 2024 09:17:29 +0100
Message-ID: <87jzmwnc9y.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Feb 21, 2024 at 10:05:46AM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Placing timers at enqueue time on a target CPU based on dubious heuristi=
cs
>> does not make any sense:
>>=20
>>  1) Most timer wheel timers are canceled or rearmed before they expire.
>>=20
>>  2) The heuristics to predict which CPU will be busy when the timer expi=
res
>>     are wrong by definition.
>>=20
>> So placing the timers at enqueue wastes precious cycles.
>>=20
>> The proper solution to this problem is to always queue the timers on the
>> local CPU and allow the non pinned timers to be pulled onto a busy CPU at
>> expiry time.
>>=20
>> Therefore split the timer storage into local pinned and global timers:
>> Local pinned timers are always expired on the CPU on which they have been
>> queued. Global timers can be expired on any CPU.
>>=20
>> As long as a CPU is busy it expires both local and global timers. When a
>> CPU goes idle it arms for the first expiring local timer. If the first
>> expiring pinned (local) timer is before the first expiring movable timer,
>> then no action is required because the CPU will wake up before the first
>> movable timer expires. If the first expiring movable timer is before the
>> first expiring pinned (local) timer, then this timer is queued into an i=
dle
>> timerqueue and eventually expired by another active CPU.
>>=20
>> To avoid global locking the timerqueues are implemented as a hierarchy. =
The
>> lowest level of the hierarchy holds the CPUs. The CPUs are associated to
>> groups of 8, which are separated per node. If more than one CPU group
>> exist, then a second level in the hierarchy collects the groups. Dependi=
ng
>> on the size of the system more than 2 levels are required. Each group ha=
s a
>> "migrator" which checks the timerqueue during the tick for remote expira=
ble
>> timers.
>>=20
>> If the last CPU in a group goes idle it reports the first expiring event=
 in
>> the group up to the next group(s) in the hierarchy. If the last CPU goes
>> idle it arms its timer for the first system wide expiring timer to ensure
>> that no timer event is missed.
>>=20
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Though I must confess I only had a shallow look at group creation (init_g=
roup,
> get_group, connect_child_parent, setup_groups, add_cpu, and tmigr_init). =
But for
> the rest, I'm running out of bad scenarios. Time for the rest of the worl=
d to
> find them!
>
> Thanks for the hard work!

Thank you for your support!

Did you saw the v11a for this patch? It is only a cleanup - it removes
an unused variable. Just asking, because Review was for plain v11 patch.

Thanks,
	Anna-Maria


