Return-Path: <linux-kernel+bounces-145910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E58A5CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EBB284DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA615698A;
	Mon, 15 Apr 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh392K/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFB82D93;
	Mon, 15 Apr 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215307; cv=none; b=ok8XugK9jxHNUCQZInjsFPjT66ymRkUsez5cEMZWVdy7YPR1LHfvgkXWz0B3T3NcTFarXr5j3Rnc1b2UUBgj4w+9iGCSK+SDJ9+NHRS3aU4EYF95YB6lrGiBEx0ihkTWluYs+qZ1cqObp9rn0/V5Z5/YiKX6v/hUgf+EmWB03AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215307; c=relaxed/simple;
	bh=YBb7sPjCuZy7QTFidxmPtSaTUjMukfRrUWRNfl89xUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrxQOUvBiKtIKXWqdF8OZD/aRWad/pehxYK2fDKANRQuDBsGpakEEsGXSB7jLU//UpPremEAcT70uCugp2AYokI2BVL1c9xBg1T4Qr8TwyRRbTKwf9Q709Dh0OfImN6hhyPDM8pjSDUj6e9Mb/BB1EqdLx9nF4o3eTF+io7xH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh392K/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8FDC113CC;
	Mon, 15 Apr 2024 21:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713215305;
	bh=YBb7sPjCuZy7QTFidxmPtSaTUjMukfRrUWRNfl89xUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mh392K/+eV4fnTxdDBL2hkZgVqtnZ+l5R6/Gy424hmIewmf56EAGgPSUnDww7XfrP
	 h/EMGZlW+jRdJmL7bzI5SgyJO1/9KEeUdR6XjumPyAyEl5HX0ceRNNgU4jDGFB93HM
	 nDWLDWEFtUG5bwvvexEm4emW2c7V3AwXnJjPb1TYSSLaxfpruUE26/0mzXuWyl+4ls
	 rdkrG6isEK9o1Ttl20u8haKyBAQvTYBmZ+r/sxLQ4spO9P+fVYi4hFJkuvBARjttIK
	 lBdfxrxLHkt2228D3f/jby+tFGjPNHCtJk3sEwVcPLpt/gUSFFIymS7nyE7NZtXuAh
	 +owzyrxrKOWrw==
Date: Mon, 15 Apr 2024 23:08:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
Message-ID: <Zh2XRgIGDILD6u7Q@pavilion.home>
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
 <Zg6tYD-9AFPkOOsW@localhost.localdomain>
 <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>
 <ZhZqX0YqlzPoOK2b@localhost.localdomain>
 <af3eed7e-a889-4008-ba47-045483ab79fc@paulmck-laptop>
 <xhsmhjzky8tww.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhjzky8tww.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Mon, Apr 15, 2024 at 06:36:31PM +0200, Valentin Schneider a écrit :
> On 10/04/24 12:19, Paul E. McKenney wrote:
> > On Wed, Apr 10, 2024 at 12:30:55PM +0200, Frederic Weisbecker wrote:
> >> Le Tue, Apr 09, 2024 at 12:53:03PM -0700, Paul E. McKenney a écrit :
> >> > I am having a hard time getting too excited about the name.  I could
> >> > suggest CT_RCU_WATCHING_IDX, but that isn't exactly the shortest
> >> > possible name.
> >>
> >> I really like CT_RCU_WATCHING. It says everything. The _IDX isn't even
> >> needed after all. What do you think?
> >
> > Works for me!
> >
> 
> Sounds good to me too, thanks for the suggestion :)
> 
> Now, what about ct_dynticks() & friends? I was about to do:
> 
> -static __always_inline int ct_dynticks(void)
> +static __always_inline int ct_rcu_watching(void)
>  {
> -	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
> +	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
>  }

Yup!

> 
> ... but then realised that there's more siblings to the rcu_dynticks*()
> family;

Ouch right, sorry I forgot there is so much of this namespace. But in case you're
willing to clean that up:

> 
> AFAICT dynticks_nesting could also get the rcu_watching prefix treatment,
> `rcu_dynticks_task_exit() -> rcu_watching_task_exit` doesn't sound as

rcu_tasks_exit() ?

But Paul, is there a reason why check_holdout_task() doesn't check
ct_dynticks_cpu(task_cpu(t)) instead of maintaining this separate counter?

> obvious though. The rcu_dyntick event probably can't be renamed either.

I think we can rename trace_rcu_dyntick() to trace_rcu_watching()

> 
> I'm not sure how far to take the renaming; seeing things like:
> 
>   notrace bool rcu_is_watching(void)
>   {
>           bool ret;
> 
>           preempt_disable_notrace();
>           ret = !rcu_dynticks_curr_cpu_in_eqs();
>           preempt_enable_notrace();
>           return ret;
>   }
>   EXPORT_SYMBOL_GPL(rcu_is_watching);
> 
> makes me think most of the rcu_*dynticks / rcu_*eqs stuff could get an
> rcu_watching facelift?

The eqs part can stay as-is. But the *dynticks* needs an update.

> 
> Here are my current considerations for identifiers used in context_tracking
> in decreasing order of confidence:
> 
> | Old                                   | New                                                           |
> |---------------------------------------+---------------------------------------------------------------|
> | RCU_DYNTICKS_IDX                      | CT_RCU_WATCHING                                               |
> | RCU_DYNTICKS_MASK                     | CT_RCU_WATCHING_MASK                                          |
> | context_tracking.dynticks_nesting     | context_tracking.rcu_watching_nesting                         |

This can be context_tracking.nesting (and yes one day we might need to lock up
context_tracking.nesting and context_tracking.recursion together in a room and see
who wins after a day or two).

> | context_tracking.dynticks_nmi_nesting | context_tracking.rcu_watching_nmi_nesting [bit of a mouthful] |

context_tracking.nmi_nesting

> | rcu_dynticks_curr_cpu_in_eqs()        | rcu_watching_curr_cpu() [with an added negation]              |

Nice!

> |---------------------------------------+---------------------------------------------------------------|
> | TRACE_EVENT_RCU(rcu_dyntick,          | [Can't change?]                                               |

It can change. Officially trace events aren't ABI. Unoficially I wouldn't dare
changing the sched switch trace event but this one is fine.

> |---------------------------------------+---------------------------------------------------------------|
> | rcu_dynticks_task_enter()             | rcu_watching_task_enter()> | |

rcu_tasks_enter() ?

> | rcu_dynticks_task_exit()              | rcu_watching_task_exit()                                      |

rcu_tasks_exit() ?

> | rcu_dynticks_task_trace_enter()       | rcu_watching_task_trace_enter()                               |

rcu_tasks_trace_enter()?

> | rcu_dynticks_task_trace_exit()        | rcu_watching_task_trace_exit()                                |

rcu_tasks_trace_exit() ?

Thanks.

> 
> Thoughts?
> 

