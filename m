Return-Path: <linux-kernel+bounces-119486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06AB88C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AA31C650E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01715EA6;
	Tue, 26 Mar 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v/UOCWyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPx97lR1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C1C15B;
	Tue, 26 Mar 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471271; cv=none; b=ainzpzst9ZOvAwgU8pXDdzNm+PV1FTPOj98JXn2h2yFyyqLR8CpDBoxH71rX327tARhjiMHcZ4BbDEGIAmK597/YXQ8xas+62t5x3oZDq/izNO0D63SdFJKS9bsdo/5VaVSkWaEvPqigaT8T5RCN87AosARHGdNXQtatssXmedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471271; c=relaxed/simple;
	bh=95hW0FoazmcZRKcfjdOY3hRmZ+Ur6YJRDcmEPH4tum4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dNUMTnZjmZPdjs6VTHMpPa5fXKrBhZUh/TwJ+PMF1BYaTTZTBADalQffj4cTYK6AYAaCpfafXsjSfFcBrAVZaaVDethSpaKe3t4fiOuEt54hrCj8f6TQ6ndfCGKTFY/XcJzPCFi7B+3JjaVjmArj8VjZTt6P6DQ2UxPCuqBPVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v/UOCWyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPx97lR1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711471261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2tXaIE73etqiedBoIAmR9YYNuCBVN3eHa7m40AS61c=;
	b=v/UOCWyZjyBtCJugLnU6XIkrvVbSr/wD0iDXtlMLCPxNBrpyGND370VU7Rs9RaDfjoS1N0
	lmKtUa7+GCzFFiutRECLO4zwmykKhRnAPbPMO0zClZcDYaGzhfaOL7rGbteyR2olbq3KTA
	ff3a5TH2eB2zZGBJJGhn3zbLoKUOOJP77viVThWxMPhWWKDj8SGWgESCxx8Tu3sAueDF6G
	GEaROCK3Jkh+gLNcFXD4spTFmjN5ps/K/28YMD/Q9Pht7oXYrHYhGCpkd+bC+Clnh9mtfT
	ND8jEloiOqwUW4W/Ht/WqG3I+BAABIFucoqNQCq6EwTMOSItkCmQzAIXi0JUgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711471261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2tXaIE73etqiedBoIAmR9YYNuCBVN3eHa7m40AS61c=;
	b=GPx97lR1VZTO0c6FTnAnfNZ84zwihzJJDZ8T8ULPCjhyZ3eHzh3t67clZqBUSz3Eg//iL/
	qWb4TDAF61VpsRBQ==
To: Frederic Weisbecker <frederic@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Joel Fernandes <joel@joelfernandes.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
 rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
 qiang.zhang1211@gmail.com, bigeasy@linutronix.de, chenzhongjin@huawei.com,
 yangjihong1@huawei.com, rostedt@goodmis.org, Justin Chen
 <justin.chen@broadcom.com>
Subject: Re: [PATCH] timer/migration: Remove buggy early return on
 deactivation [was Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU
 changes for v6.9]]
In-Reply-To: <ZfOhB9ZByTZcBy4u@lothringen>
References: <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com> <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx> <ZfN0wY41pU5UjP8T@boqun-archlinux>
 <ZfOhB9ZByTZcBy4u@lothringen>
Date: Tue, 26 Mar 2024 17:41:00 +0100
Message-ID: <87zfulrlnn.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Frederic,

I'm sorry sending my concerns late, but I was on sick leave. Keep in
mind, it is definitely possible that my brain is not yet in the timer
migration hierarchy mood after the sick leave :) so please correct me
whenever I'm wrong.

Frederic Weisbecker <frederic@kernel.org> writes:

> On Thu, Mar 14, 2024 at 03:05:53PM -0700, Boqun Feng wrote:
>> I notice CPU3 didn't have its own non-deferrable timer queued (local or
>> global), so could the following happen?
>> 
>> 	timer_base_try_to_set_idle():
>> 	  __get_next_timer_interrupt():
>> 	    fetch_next_timer_interrupt():
>> 	      // nextevt_local == nextevt_global == basej + NEXT_TIMER_MAX_DELTA
>> 	      // tevt->local == tevt->gloabl = KTIME_MAX
>> 	    timer_use_tmigr():
>> 	      tmigr_cpu_deactivate():
>> 	        __tmigr_cpu_deactivate():
>> 		  // tmc->cpuevt.ignore untouched still == true
>> 		  walk_groups(&tmigr_inactive_up, ...):
>> 		    tmigr_inactive_up():
>> 		      data->remote = true;
>> 		      tmigr_update_events():
>> 		        if (child) { // child is NULL
>> 			  ...
>> 			} else {
>> 			  first_childevt = evt = data->evt;
>> 
>> 			  if (evt->ignore && !remote)
>> 			    return true; // no remote tick is picked.
>> 			  ...
>> 			}
>
> Nice catch! Florian can you try the following?
>
> From b0e335371ed758f68bf4f501246298c98a615b04 Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Fri, 15 Mar 2024 00:21:01 +0100
> Subject: [PATCH] timer/migration: Remove buggy early return on deactivation
>
> When a CPU enters into idle and deactivates itself from the timer
> migration hierarchy without any global timer of its own to propagate,
> the group event of that CPU is set to "ignore" and tmigr_update_events()
> accordingly performs an early return without considering timers queued
> by other CPUs.
>
> If the hierarchy has a single level, and the CPU is the last one to
> enter idle, it will ignore others' global timers, as in the following
> layout:
>
>            [GRP0:0]
>          migrator = 0
>          active   = 0
>          nextevt  = T0i
>           /         \
>          0           1
>       active (T0i)  idle (T1)
>
> 0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
> upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
>
>            [GRP0:0]
>          migrator = NONE
>          active   = NONE
>          nextevt  = T0i
>           /         \
>          0           1
>       idle (T0i)  idle (T1)
>
> 1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
> pushed as its next expiry and its own event kept as "ignore". As a result
> tmigr_update_events() ignores T1 and CPU 0 goes to idle with T1
> unhandled.

This is broken - indeed.

> This isn't proper to single level hierarchy though. A similar issue,
> although slightly different, may arise on multi-level:
>
>                             [GRP1:0]
>                          migrator = GRP0:0
>                          active   = GRP0:0
>                          nextevt  = T0:0i, T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = 0              migrator = NONE
>            active   = 0              active   = NONE
>            nextevt  = T0i            nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>         idle         idle            idle         idle
>
> 0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
> upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
> CPU 2 also has a timer. The expiry order is T0 (ignored) < T1 < T2
>
>                             [GRP1:0]
>                          migrator = GRP0:0
>                          active   = GRP0:0
>                          nextevt  = T0:0i, T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = NONE           migrator = NONE
>            active   = NONE           active   = NONE
>            nextevt  = T0i            nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>         idle         idle            idle         idle
>
> 1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
> pushed as its next expiry and its own event kept as "ignore". As a result
> tmigr_update_events() ignores T1. The change only propagated up to 1st
> level so far.

Right. T0 doesn't has to be enqueued into the timer queue of GRP0:0 as
this timer could be ignored. So nothing changes directly in GRP0:0.

>                             [GRP1:0]
>                          migrator = NONE
>                          active   = NONE
>                          nextevt  = T0:1
>                          /              \
>               [GRP0:0]                  [GRP0:1]
>            migrator = NONE           migrator = NONE
>            active   = NONE           active   = NONE
>            nextevt  = T0i            nextevt  = T2
>            /         \                /         \
>           0 (T0i)     1 (T1)         2 (T2)      3
>         idle         idle            idle         idle
>
> 2) The change now propagates up to the top. tmigr_update_events() finds
> that the child event is ignored and thus removes it. The top level next
> event is now T2 which is returned to CPU 0 as its next effective expiry
> to take account for as the global idle migrator. However T1 has been
> ignored along the way, leaving it unhandled.

Now propagation goes on as GRP0:0 is completely idle. When executing
tmigr_update_events() in the next step of walking the hierarchy via
tmigr_inactive_up(), the arguments for tmigr_update_events() are set in
the following way:

  group = GRP1:0
  child = GRP0:0

Then at the begin of tmigr_update_events() the group event of child is
updated - so all ignored events are removed (T0i), and the
child->groupevt and child->next_expiry is updated with T1. This
reevaluated child->groupevt is then queued/updated in the GRP1:0
timerqueue.

So T1 will be handled!

As there is no parent, the top level group event is updated (see goto
label "check_toplvl") and T1 will be still the first event.

> Fix those issues with removing the buggy related early return. Ignored
> child events must not prevent from evaluating the other events within
> the same group.

I would prefere to keep this early return but skip it, when there is
!group->parent (only a single level in hierarchy).

Then it would prevent taking the group lock and making some random
event updates which are done nevertheless on the next iteration of the
hierarchy walk.

Thanks,

	Anna-Maria


