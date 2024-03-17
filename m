Return-Path: <linux-kernel+bounces-105546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4119887DFF5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0611C20DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D54200CB;
	Sun, 17 Mar 2024 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewR33L3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C11B7F7;
	Sun, 17 Mar 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706619; cv=none; b=huVZtFLfJ868nTp7shbYW3ZLT62CpNnBCd8DvyJ0ApX33hu5mPIBFFGlYIYxzLdIl6Qwhp/Y7PlsoFxayizVKGzjucoxGtqdMIp9KD8JTr1SiKdVIKiPvoPWtACVsW5UrN8FAG90Eu7D+6jb9ZdrpCxPxHolZmY5LpOy88S04OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706619; c=relaxed/simple;
	bh=rUeDT3g2G3Zes6odbwmEp4W4imUsRd9AjrTvCm+svXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDl9PyhulRLmqDnyxTRhPR2AmsIMQIGzD2CbZ3i4oRJq+iWPeRK6hlzaZ5QRH/yJcy+oxZ0y/TrSJtPI54LNvETvRP68urQ6CNAaY81AqCkm0/SkxxYHrjXK0dWylhi8iBT0qDaFHGvbSVylTjgQutsLLJsxtFhFALR60EwwH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewR33L3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A71FC433C7;
	Sun, 17 Mar 2024 20:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710706618;
	bh=rUeDT3g2G3Zes6odbwmEp4W4imUsRd9AjrTvCm+svXU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ewR33L3OrAwrKGvq0Gxkm2zeFzZCxFRWdPDiQBRYi7m7eSCGyWezsG9rtdTY4Y1br
	 v0MykQIAnFpKPhVxegm6FqA6gP1luQTd2ZLhxT5AwB5glG9AADSuccbJcr6tt6ptHL
	 gB0rBS6xyXBKAqsc04cLbZBtMd4f1XDkKrISEZVuU42jftBCV/4Vgwn1ovikAl1jTw
	 HvuWC42KE8u3NUAbxNnClsw3i/Jchb0tsN/Ew0VywBv+NzGbM9uv7qmWLBtpYNFkzD
	 1hjbOHFDyw1GRbW+Gq0UF9oDYWamIhOp/gSMxXh4W6vDVwBoQVkfZyuGQvq2a1JEmt
	 WrhH/fiSvshIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 641CECE0D83; Sun, 17 Mar 2024 13:16:55 -0700 (PDT)
Date: Sun, 17 Mar 2024 13:16:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Make rcutorture support print rcu-tasks
 gp state
Message-ID: <4ffbaa69-0d36-4a16-abc5-8aa4b37e68b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240317113811.8085-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317113811.8085-1-qiang.zhang1211@gmail.com>

On Sun, Mar 17, 2024 at 07:38:11PM +0800, Zqiang wrote:
> This commit make rcu-tasks related rcutorture test support rcu-tasks
> gp state printing when the writer stall occurs or the at the end of
> rcutorture test, and generate rcu_ops->get_gp_data() operation to
> simplify the acquisition of gp state for different types of rcutorture
> tests.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Much better!!!

A few questions below.  One small change left, a question on testing,
and the possibility of a few cleanup patches if you are interested.

							Thanx, Paul

> ---
>  
> [   47.582683] rcu:  Start-test grace-period state: g4313 f0x0
> [   73.780444] rcu:  End-test grace-period state: g15728 f0x0 total-gps=2854
> 
> [   99.013921] srcu:  Start-test grace-period state: g0 f0x0
> [  126.596727] srcu:  End-test grace-period state: g10292 f0x0 total-gps=10292
> 
> [  175.664991] srcud:  Start-test grace-period state: g0 f0x0
> [  195.012774] srcud:  End-test grace-period state: g7628 f0x0 total-gps=7628
> 
> [  216.943521] tasks:  Start-test grace-period state: g8 f0x0
> [  234.245093] tasks:  End-test grace-period state: g300 f0x0 total-gps=292
> 
> [  267.139368] tasks-rude:  Start-test grace-period state: g8 f0x0
> [  296.132748] tasks-rude:  End-test grace-period state: g684 f0x0 total-gps=676
> 
> [  316.044241] tasks-tracing:  Start-test grace-period state: g8 f0x0
> [  342.020447] tasks-tracing:  End-test grace-period state: g348 f0x0 total-gps=340
> 
>  kernel/rcu/rcu.h        | 20 ++++++++++----------
>  kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++--------
>  kernel/rcu/srcutree.c   |  5 +----
>  kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
>  kernel/rcu/tree.c       | 13 +++----------
>  5 files changed, 56 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 86fce206560e..38238e595a61 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -522,12 +522,18 @@ static inline void show_rcu_tasks_gp_kthreads(void) {}
>  
>  #ifdef CONFIG_TASKS_RCU
>  struct task_struct *get_rcu_tasks_gp_kthread(void);
> +void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq);
>  #endif // # ifdef CONFIG_TASKS_RCU
>  
>  #ifdef CONFIG_TASKS_RUDE_RCU
>  struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
> +void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
>  #endif // # ifdef CONFIG_TASKS_RUDE_RCU
>  
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
> +#endif
> +

If you have not already done so, could you please test with the rcutorture
scenarios, while artificially forcing that warning to trigger?

For example, CONFIG_TASKS_TRACE_RCU can be tested using this command
line:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5m --configs "TRACE01 TRACE02" --trust-make

You can add more scenarios to the --configs argument, and the rest of
them can be found in tools/testing/selftests/rcutorture/configs/rcu.

>  #ifdef CONFIG_TASKS_RCU_GENERIC
>  void tasks_cblist_init_generic(void);
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> @@ -557,8 +563,7 @@ static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
>  #endif
>  
>  #if defined(CONFIG_TREE_RCU)
> -void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> -			    unsigned long *gp_seq);
> +void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq);
>  void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       struct rcu_head *rhp,
>  			       unsigned long secs,
> @@ -566,8 +571,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  			       unsigned long c);
>  void rcu_gp_set_torture_wait(int duration);
>  #else
> -static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
> -					  int *flags, unsigned long *gp_seq)
> +static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
>  {
>  	*flags = 0;
>  	*gp_seq = 0;
> @@ -587,20 +591,16 @@ static inline void rcu_gp_set_torture_wait(int duration) { }
>  
>  #ifdef CONFIG_TINY_SRCU
>  
> -static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
> -					   struct srcu_struct *sp, int *flags,
> +static inline void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
>  					   unsigned long *gp_seq)
>  {
> -	if (test_type != SRCU_FLAVOR)
> -		return;
>  	*flags = 0;
>  	*gp_seq = sp->srcu_idx;
>  }
>  
>  #elif defined(CONFIG_TREE_SRCU)
>  
> -void srcutorture_get_gp_data(enum rcutorture_type test_type,
> -			     struct srcu_struct *sp, int *flags,
> +void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
>  			     unsigned long *gp_seq);
>  
>  #endif
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 2f43d31fb7a5..2e8a037072eb 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -381,6 +381,7 @@ struct rcu_torture_ops {
>  	void (*gp_kthread_dbg)(void);
>  	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
>  	int (*stall_dur)(void);
> +	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
>  	long cbflood_max;
>  	int irq_capable;
>  	int can_boost;
> @@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
>  	.gp_kthread_dbg		= show_rcu_gp_kthreads,
>  	.check_boost_failed	= rcu_check_boost_fail,
>  	.stall_dur		= rcu_jiffies_till_stall_check,
> +	.get_gp_data		= rcutorture_get_gp_data,
>  	.irq_capable		= 1,
>  	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
>  	.extendables		= RCUTORTURE_MAX_EXTEND,
> @@ -612,6 +614,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
>  	.sync		= synchronize_rcu_busted,
>  	.exp_sync	= synchronize_rcu_busted,
>  	.call		= call_rcu_busted,
> +	.get_gp_data	= NULL,

When this is NULL, please just leave it out.

If you wish, you can also send separate patches removing the pre-existing
initialization of function pointers to NULL, one per function pointer.

>  	.cb_barrier	= NULL,
>  	.fqs		= NULL,
>  	.stats		= NULL,
> @@ -628,6 +631,11 @@ static struct srcu_struct srcu_ctld;
>  static struct srcu_struct *srcu_ctlp = &srcu_ctl;
>  static struct rcu_torture_ops srcud_ops;
>  
> +static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
> +{
> +	srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
> +}
> +
>  static int srcu_torture_read_lock(void)
>  {
>  	if (cur_ops == &srcud_ops)
> @@ -736,6 +744,7 @@ static struct rcu_torture_ops srcu_ops = {
>  	.call		= srcu_torture_call,
>  	.cb_barrier	= srcu_torture_barrier,
>  	.stats		= srcu_torture_stats,
> +	.get_gp_data	= srcu_get_gp_data,
>  	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> @@ -774,6 +783,7 @@ static struct rcu_torture_ops srcud_ops = {
>  	.call		= srcu_torture_call,
>  	.cb_barrier	= srcu_torture_barrier,
>  	.stats		= srcu_torture_stats,
> +	.get_gp_data	= srcu_get_gp_data,
>  	.cbflood_max	= 50000,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
> @@ -796,6 +806,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
>  	.call		= srcu_torture_call,
>  	.cb_barrier	= srcu_torture_barrier,
>  	.stats		= srcu_torture_stats,
> +	.get_gp_data	= NULL,
>  	.irq_capable	= 1,
>  	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
>  	.extendables	= RCUTORTURE_MAX_EXTEND,
> @@ -838,6 +849,7 @@ static struct rcu_torture_ops trivial_ops = {
>  	.get_gp_seq	= rcu_no_completed,
>  	.sync		= synchronize_rcu_trivial,
>  	.exp_sync	= synchronize_rcu_trivial,
> +	.get_gp_data	= NULL,
>  	.fqs		= NULL,
>  	.stats		= NULL,
>  	.irq_capable	= 1,
> @@ -882,6 +894,7 @@ static struct rcu_torture_ops tasks_ops = {
>  	.call		= call_rcu_tasks,
>  	.cb_barrier	= rcu_barrier_tasks,
>  	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
> +	.get_gp_data	= rcu_tasks_get_gp_data,
>  	.fqs		= NULL,
>  	.stats		= NULL,
>  	.irq_capable	= 1,
> @@ -922,6 +935,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
>  	.call		= call_rcu_tasks_rude,
>  	.cb_barrier	= rcu_barrier_tasks_rude,
>  	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
> +	.get_gp_data	= rcu_tasks_rude_get_gp_data,
>  	.cbflood_max	= 50000,
>  	.fqs		= NULL,
>  	.stats		= NULL,
> @@ -974,6 +988,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
>  	.call		= call_rcu_tasks_trace,
>  	.cb_barrier	= rcu_barrier_tasks_trace,
>  	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
> +	.get_gp_data    = rcu_tasks_trace_get_gp_data,
>  	.cbflood_max	= 50000,
>  	.fqs		= NULL,
>  	.stats		= NULL,
> @@ -2264,10 +2279,8 @@ rcu_torture_stats_print(void)
>  		int __maybe_unused flags = 0;
>  		unsigned long __maybe_unused gp_seq = 0;
>  
> -		rcutorture_get_gp_data(cur_ops->ttype,
> -				       &flags, &gp_seq);
> -		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
> -					&flags, &gp_seq);
> +		if (cur_ops->get_gp_data)
> +			cur_ops->get_gp_data(&flags, &gp_seq);
>  		wtp = READ_ONCE(writer_task);
>  		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
>  			 rcu_torture_writer_state_getname(),
> @@ -3390,8 +3403,8 @@ rcu_torture_cleanup(void)
>  		fakewriter_tasks = NULL;
>  	}
>  
> -	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> -	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> +	if (cur_ops->get_gp_data)
> +		cur_ops->get_gp_data(&flags, &gp_seq);
>  	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
>  		 cur_ops->name, (long)gp_seq, flags,
>  		 rcutorture_seq_diff(gp_seq, start_gp_seq));
> @@ -3762,8 +3775,8 @@ rcu_torture_init(void)
>  			nrealreaders = 1;
>  	}
>  	rcu_torture_print_module_parms(cur_ops, "Start of test");
> -	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> -	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> +	if (cur_ops->get_gp_data)
> +		cur_ops->get_gp_data(&flags, &gp_seq);
>  	start_gp_seq = gp_seq;
>  	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
>  		 cur_ops->name, (long)gp_seq, flags);
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d19326486edd..98f79ba01b0a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1828,12 +1828,9 @@ static void process_srcu(struct work_struct *work)
>  	srcu_reschedule(ssp, curdelay);
>  }
>  
> -void srcutorture_get_gp_data(enum rcutorture_type test_type,
> -			     struct srcu_struct *ssp, int *flags,
> +void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
>  			     unsigned long *gp_seq)
>  {
> -	if (test_type != SRCU_FLAVOR)
> -		return;
>  	*flags = 0;
>  	*gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
>  }
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e83adcdb49b5..e7ac9138a4fd 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1182,6 +1182,13 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
>  }
>  EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
>  
> +void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
> +{
> +	*flags = 0;
> +	*gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
> +}
> +EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
> +
>  /*
>   * Protect against tasklist scan blind spot while the task is exiting and
>   * may be removed from the tasklist.  Do this by adding the task to yet
> @@ -1361,6 +1368,13 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
>  }
>  EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
>  
> +void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq)
> +{
> +	*flags = 0;
> +	*gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
> +}
> +EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
> +
>  #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
>  
>  ////////////////////////////////////////////////////////////////////////
> @@ -2020,6 +2034,13 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
>  }
>  EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
>  
> +void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
> +{
> +	*flags = 0;
> +	*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
> +}
> +EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
> +
>  #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
>  static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
>  #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..e229a12afe31 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -539,17 +539,10 @@ static struct rcu_node *rcu_get_root(void)
>  /*
>   * Send along grace-period-related data for rcutorture diagnostics.
>   */
> -void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> -			    unsigned long *gp_seq)
> +void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
>  {
> -	switch (test_type) {
> -	case RCU_FLAVOR:
> -		*flags = READ_ONCE(rcu_state.gp_flags);
> -		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
> -		break;
> -	default:
> -		break;
> -	}
> +	*flags = READ_ONCE(rcu_state.gp_flags);
> +	*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
>  }
>  EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
>  
> -- 
> 2.17.1
> 

