Return-Path: <linux-kernel+bounces-98316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4D877854
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF47281090
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A73A8CB;
	Sun, 10 Mar 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIyFtyG5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBA3A8C0;
	Sun, 10 Mar 2024 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710099821; cv=none; b=dQbIQTeZAn9LtkopSrIzDe94lTwBp45w2JN/E8aTYAAV6oke9hFBEQdWUuZNkTJpMgUW6PeIMLUVXbgWHgHtMkyzTliZBVTdkXhrMc8XEz27z8CLZVC5Fkjj9YT7uGFwHsRitu7P7Phl5434x/eayOMLasWvTQgZjxZZ0ylo4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710099821; c=relaxed/simple;
	bh=zeepOcvSOEeps6KjwQ75mbN3NbQDT42Kq3qUgI/PVQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb4I1CLRsO/tqz4DQi8SX+gRjUV4DwlxoVRA7BlopckVn3K1AAbQCIAEaRLdd7rnZP5G+jDahH6ZqLpTZXC+HHU13scbgVYcB8VdIRt/neB0WNVIYPUq/HEzfQrUL+2O8h/yhNgYfeQJICJ7RCFmNyoOYLmLvVdeAla4PlcU6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIyFtyG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33936C433F1;
	Sun, 10 Mar 2024 19:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710099821;
	bh=zeepOcvSOEeps6KjwQ75mbN3NbQDT42Kq3qUgI/PVQM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZIyFtyG5P0do0VurNskvQWQUhiJWdyYaJU1XzKVDgap+j67101zTgeRUrXtfR16X0
	 1FR+ULMrBgekAGGqV7+5FtmY6ERoszdlm/sJ3tmHIkNImU2KTWODuLAGUTmhTnvLv1
	 Jx+Egtg+MNBTg4uhfA0C4rOu7JUXmMeDvll81v2eIUT94XpXTyZ6CMZnfAIUhV1c61
	 LYX+QLJURgVEzLFjnEbEPY19mEfrzs/dW5TFUT7jcSk0RZ8jJe819tk49znwTXWHh7
	 mlcXgZ6y/f/MOVDFoCrHYVZerMsuKV/8LL4Q4yCmyNr5d3j4fdNJhooSHcGT3u1kse
	 0o4tSb70h6o0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B12D7CE0556; Sun, 10 Mar 2024 12:43:40 -0700 (PDT)
Date: Sun, 10 Mar 2024 12:43:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
	rostedt@goodmis.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 rcu/dev 2/2] rcu/tree: Add comments explaining
 now-offline-CPU QS reports
Message-ID: <01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240308224439.281349-1-joel@joelfernandes.org>
 <20240308224439.281349-2-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308224439.281349-2-joel@joelfernandes.org>

On Fri, Mar 08, 2024 at 05:44:38PM -0500, Joel Fernandes (Google) wrote:
> This a confusing piece of code (rightfully so as the issue it deals with
> is complex). Recent discussions brought up a question -- what prevents the
> rcu_implicit_dyntick_qs() from warning about QS reports for offline
> CPUs.
> 
> QS reporting for now-offline CPUs should only happen from:
> - gp_init()
> - rcutree_cpu_report_dead()
> 
> Add some comments to this code explaining how QS reporting is not
> missed when these functions are concurrently running.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you for putting this together!

A couple of questions below.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bd29fe3c76bf..f3582f843a05 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1917,7 +1917,22 @@ static noinline_for_stack bool rcu_gp_init(void)

Would it make sense to tag the earlier arch_spin_lock(&rcu_state.ofl_lock)
as preventing grace period from starting concurrently with
rcutree_report_cpu_dead()?

>  		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
>  					    rnp->level, rnp->grplo,
>  					    rnp->grphi, rnp->qsmask);
> -		/* Quiescent states for tasks on any now-offline CPUs. */
> +		/*
> +		 * === Quiescent states for tasks on any now-offline CPUs. ===
> +		 *
> +		 * QS reporting for now-offline CPUs should only be performed from
> +		 * either here, i.e., gp_init() or from rcutree_report_cpu_dead().
> +		 *
> +		 * Note that, when reporting quiescent states for now-offline CPUs,
> +		 * the sequence of code doing those reports while also accessing
> +		 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
> +		 * that QS reporting is not missed! Otherwise it possible that
> +		 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
> +		 * the rnp->lock acquired throughout these QS-reporting
> +		 * sequences, which is also acquired in
> +		 * rcutree_report_cpu_dead(), so, acquiring ofl_lock is not
> +		 * necessary here to synchronize with that function.
> +		 */

Would it be better to put the long-form description in the "Hotplug
CPU" section of Documentation/RCU/Design/Requirements/Requirements.rst?
I will be the first to admit that this section is not as detailed as it
needs to be.  This section is already referenced by the block comment
preceding the WARN_ON_ONCE() in rcu_implicit_dyntick_qs(), which is
where people will look first if any of this gets messed up.

Then these other places can refer to that comment or to that section of
Requirements.rst, allowing them to focus on the corresponding piece of
the puzzle.

>  		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
>  		rnp->rcu_gp_init_mask = mask;
>  		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
> @@ -5116,6 +5131,25 @@ void rcutree_report_cpu_dead(void)
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>  	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
> +
> +	/*
> +	 * === Quiescent state reporting for now-offline CPUs ===
> +	 *
> +	 * QS reporting for now-offline CPUs should only be performed from
> +	 * either here, i.e. rcutree_report_cpu_dead(), or gp_init().
> +	 *
> +	 * Note that, when reporting quiescent states for now-offline CPUs,
> +	 * the sequence of code doing those reports while also accessing
> +	 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
> +	 * that QS reporting is not missed! Otherwise it possible that
> +	 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
> +	 * the rnp->lock acquired throughout these QS-reporting sequences, which
> +	 * is also acquired in gp_init().
> +	 * One slight change to this rule is below, where we release and
> +	 * reacquire the lock after a QS report, but before we clear the
> +	 * ->qsmaskinitnext bit. That is OK to do, because gp_init() report a
> +	 * QS again, if it acquired the rnp->lock before we reacquired below.
> +	 */

And then this need only say what is happening right here, but possibly
moved to within the following "if" statement, at which point we know that
we are in a grace period that cannot end until we report the quiescent
state (which releases the rcu_node structure's ->lock) and a new grace
period cannot look at this rcu_node structure's ->qsmaskinitnext until
we release rcu_state.ofl_lock.

Thoughts?

>  	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
>  		/* Report quiescent state -before- changing ->qsmaskinitnext! */
>  		rcu_disable_urgency_upon_qs(rdp);
> -- 
> 2.34.1
> 

