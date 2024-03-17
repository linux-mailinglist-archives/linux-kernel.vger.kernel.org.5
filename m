Return-Path: <linux-kernel+bounces-105331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1CD87DC55
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D341C20A8A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948179E5;
	Sun, 17 Mar 2024 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz2mNGad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1163A9;
	Sun, 17 Mar 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710652323; cv=none; b=UxGUnDjfq1KEoEzhgOeosWieYm8N0uWNY4HuPLuMrGv7bkRNNUaTkXRcrMWdJqAYo+je52smDgSso/l2J07I/LeFUWnhOsWa+sljMXQXwSIi6P3049CdqwtSFUg3JefPbNtVugvFiuzqZDEPdsNxfmiKNFqAdWD1odsdu/EogEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710652323; c=relaxed/simple;
	bh=gTAhjzERCy6N4pD52FOLASKnOnPAXTrJ45gSsCEtd/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3aJdepkBxtW6M0W6I+X05m4N1ldXUyu5kujp9W/RRYaLhVX+aGDeTnV6lrYPE8Y2dy/1mMauVV5AZo2rTO1f5qIcl7gYgvhd7q65mUrdwuwVyMd8R/EjylsIdhNIFF/+zI4Pv4YuGda0KnZWo5QXWl6IRRwiXHAeuG6WdkwaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz2mNGad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713BCC433C7;
	Sun, 17 Mar 2024 05:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710652322;
	bh=gTAhjzERCy6N4pD52FOLASKnOnPAXTrJ45gSsCEtd/o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bz2mNGadYghdlRKDPrtRwj+GE0mPUY5P7qwrKLFd3NtpDoWJRaiht2StFso0ScYZ5
	 uLFXZYx1mZ1Sav4hC0RV35ZfUGrXr6CuH0qeWxSFqNpi/Km4wSc2jt0K7Ypa4zaFmb
	 kUz2zhyr6cv61c/+nkwZd7yc3i3UrBt0Q96Y6ceks0XMg7G8sNOXX2kk4MKObMBcOh
	 RZFCeLhJb27IYaNtZg841GjnplB07BrSsF5bUNG/PftxwvlMFpDdHR9ICppCH5zyFu
	 aPgqri63B4mWr97dp+2A/SE3/HvEkFpDyYwKhKxLuWv0SbPZ3toXJ8sQTwjgZP3gih
	 QnBaTmtIXm70A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7FEF0CE0D85; Sat, 16 Mar 2024 22:11:59 -0700 (PDT)
Date: Sat, 16 Mar 2024 22:11:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make rcutorture support print rcu-tasks gp
 state
Message-ID: <40a4b0f3-b850-4d73-b514-ce5149abb465@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240312072357.23517-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312072357.23517-1-qiang.zhang1211@gmail.com>

On Tue, Mar 12, 2024 at 03:23:57PM +0800, Zqiang wrote:
> This commit make rcu-tasks related rcutorture test support rcu-tasks
> gp state printing when the writer stall occurs or the at the end of
> rcutorture test.
> 
> The test is as follows:
> [ 3872.548702] tasks-tracing:  Start-test grace-period state: g4560 f0x0
> [ 4332.661283] tasks-tracing:  End-test grace-period state: g41540 f0x0 total-gps=36980
> 
> [ 4401.381138] tasks:  Start-test grace-period state: g8 f0x0
> [ 4565.619354] tasks:  End-test grace-period state: g1732 f0x0 total-gps=1724
> 
> [ 4589.006917] tasks-rude:  Start-test grace-period state: g8 f0x0
> [ 5059.379321] tasks-rude:  End-test grace-period state: g8508 f0x0 total-gps=8500
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Again, good eyes, and that fix would work.  But wouldn't it make more
sense to create a new cur_ops function pointer for these functions?
That might allow getting rid of the *_FLAVOR checks and values, plus
simplify the code a bit.  To make the function signatures work out,
there would need to be an intermediate SRCU function to supply the right
rcu_struct pointer.

This would shorten and simplify the code a bit.

Or is there some reason that this won't work?

Why didn't I do that to start with?  Well, the various RCU flavors
appeared one at a time over some years...  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h        |  8 ++++++++
>  kernel/rcu/rcutorture.c |  3 +++
>  kernel/rcu/tasks.h      | 25 +++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 86fce206560e..3353e3697645 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -556,6 +556,14 @@ static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0; }
>  static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
>  #endif
>  
> +#ifdef CONFIG_TASKS_RCU_GENERIC
> +void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> +				unsigned long *gp_seq);
> +#else
> +static inline void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> +				unsigned long *gp_seq) { }
> +#endif
> +
>  #if defined(CONFIG_TREE_RCU)
>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>  			    unsigned long *gp_seq);
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index dd7d5ba45740..91c03f37fd97 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2267,6 +2267,7 @@ rcu_torture_stats_print(void)
>  				       &flags, &gp_seq);
>  		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
>  					&flags, &gp_seq);
> +		rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
>  		wtp = READ_ONCE(writer_task);
>  		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
>  			 rcu_torture_writer_state_getname(),
> @@ -3391,6 +3392,7 @@ rcu_torture_cleanup(void)
>  
>  	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
>  	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> +	rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
>  	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
>  		 cur_ops->name, (long)gp_seq, flags,
>  		 rcutorture_seq_diff(gp_seq, start_gp_seq));
> @@ -3763,6 +3765,7 @@ rcu_torture_init(void)
>  	rcu_torture_print_module_parms(cur_ops, "Start of test");
>  	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
>  	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> +	rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
>  	start_gp_seq = gp_seq;
>  	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
>  		 cur_ops->name, (long)gp_seq, flags);
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e83adcdb49b5..b1254cf3c210 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -2149,6 +2149,31 @@ late_initcall(rcu_tasks_verify_schedule_work);
>  static void rcu_tasks_initiate_self_tests(void) { }
>  #endif /* #else #ifdef CONFIG_PROVE_RCU */
>  
> +void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> +				unsigned long *gp_seq)
> +{
> +	switch (test_type) {
> +	case RCU_TASKS_FLAVOR:
> +#ifdef CONFIG_TASKS_RCU
> +		*gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
> +#endif
> +		break;
> +	case RCU_TASKS_RUDE_FLAVOR:
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +		*gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
> +#endif
> +		break;
> +	case RCU_TASKS_TRACING_FLAVOR:
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +		*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
> +#endif
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(rcutaskstorture_get_gp_data);
> +
>  void __init tasks_cblist_init_generic(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -- 
> 2.17.1
> 

