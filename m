Return-Path: <linux-kernel+bounces-6565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D596819A67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB02E1F268A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05F1D6B6;
	Wed, 20 Dec 2023 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL2HSFPD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011551D6A6;
	Wed, 20 Dec 2023 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bc870c540so743953a91.2;
        Wed, 20 Dec 2023 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703060763; x=1703665563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGBJIX00nRFnxttmOloymB1Dg5dVPv450YCsoRrnAV0=;
        b=WL2HSFPDcBR+TnH+wyelx6DE7s/KMNcexqzLOYgBKkRAgkZgZ26rmwcNeIDGGNG0WJ
         QaIh4dDAUm95v0IZ2FVd6tcR/+2d6ZlS4mFoyta74vQj4pnuodQ8dMtka9WCLM/2VE96
         m9hf8T0zn3RWA+tptAhla7EEN0gGYDuCHxejMeSgLiTRIwwcztrTvHIkskBq+3rJbTje
         4VgQQymHIZ9zQNYsuzTYU8CYKr2cArU8ufkHNFXSBvpLsANtLSG0FNh2JIHWr3Is/hm6
         AjwOamsERY6V8Kz5p2hND+u9cQuld/+pQlHJdwHRa31WDnj0/wFg5k7G67YnOTtuVoGT
         Lg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060763; x=1703665563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGBJIX00nRFnxttmOloymB1Dg5dVPv450YCsoRrnAV0=;
        b=uR7vEM6UAGjG0RmbP11egVv5ZC3xtE4c+oJbRhte1Zs1+VBE1k1gEPczRilSHrWL2X
         0I0P2D8DqnM/b6iiwvkO1J0ttw6NboC5Bb6ltTOYHPXsdzazS82RnpllKKi6icxQsQjJ
         k0nYAhVNqiLYhVEQTx7eiXzIcClE3/MbaeHT+JRat5KknVQ13IMSxSSOWfZT+djyUfeq
         ainNIMFOp6HhI3C+qslLR8irezNItbhaOr5KBcqxoY+vgHvqoq+oL2xYV8WtrVbsm+Tb
         jBO7s9j3h0RSFN6dX7rWlbtN07R5D3ZGV5nwf/HuySkLrrwxwYmcXKoBfB9Q6gJ/UYTB
         xosA==
X-Gm-Message-State: AOJu0Yz9aQXYqqBGuqodSSPX38Z0jZFMwbaOgwhSHjNENCJkQKsKo34V
	JGCAkPyED315+0dwXsE1ISqS2eTdinbbHG+T6Ig=
X-Google-Smtp-Source: AGHT+IGMOifjc3vknpsfE+/fBZkC7YzuOnZZyyMRaU37Yf4c7kBcGGxiFvK52vJ03/vFxRZkVodQ33eOnCFixwBjsYg=
X-Received: by 2002:a17:90b:438d:b0:28b:5429:97fe with SMTP id
 in13-20020a17090b438d00b0028b542997femr3164500pjb.4.1703060763153; Wed, 20
 Dec 2023 00:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218231916.11719-1-frederic@kernel.org> <20231218231916.11719-3-frederic@kernel.org>
In-Reply-To: <20231218231916.11719-3-frederic@kernel.org>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 20 Dec 2023 16:24:35 +0800
Message-ID: <CALm+0cVv4cnbDPi=9oCYE_5s+DfuzQcB1fz=M1T8Hyp9D9sbXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

>
> When the CPU goes idle for the last time during the CPU down hotplug
> process, RCU reports a final quiescent state for the current CPU. If
> this quiescent state propagates up to the top, some tasks may then be
> woken up to complete the grace period: the main grace period kthread
> and/or the expedited main workqueue (or kworker).
>
> If those kthreads have a SCHED_FIFO policy, the wake up can indirectly
> arm the RT bandwith timer to the local offline CPU. Since this happens
> after hrtimers have been migrated at CPUHP_AP_HRTIMERS_DYING stage, the
> timer gets ignored. Therefore if the RCU kthreads are waiting for RT
> bandwidth to be available, they may never be actually scheduled.
>

In the rcutree_report_cpu_dead(), the rcuog kthreads may also be wakeup in
do_nocb_deferred_wakeup(), if the rcuog kthreads is rt-fifo and wakeup happen,
the rt_period_active is set 1 and enqueue hrtimer to offline CPU in
do_start_rt_bandwidth(),
after that, we invoke swake_up_one_online() send ipi to online CPU, due to the
rt_period_active is 1, the rt-bandwith hrtimer will not enqueue to online CPU.
any thoughts?

Thanks
Zqiang


>
> This triggers TREE03 rcutorture hangs:
>
>          rcu: INFO: rcu_preempt self-detected stall on CPU
>          rcu:     4-...!: (1 GPs behind) idle=9874/1/0x4000000000000000 softirq=0/0 fqs=20 rcuc=21071 jiffies(starved)
>          rcu:     (t=21035 jiffies g=938281 q=40787 ncpus=6)
>          rcu: rcu_preempt kthread starved for 20964 jiffies! g938281 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>          rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>          rcu: RCU grace-period kthread stack dump:
>          task:rcu_preempt     state:R  running task     stack:14896 pid:14    tgid:14    ppid:2      flags:0x00004000
>          Call Trace:
>           <TASK>
>           __schedule+0x2eb/0xa80
>           schedule+0x1f/0x90
>           schedule_timeout+0x163/0x270
>           ? __pfx_process_timeout+0x10/0x10
>           rcu_gp_fqs_loop+0x37c/0x5b0
>           ? __pfx_rcu_gp_kthread+0x10/0x10
>           rcu_gp_kthread+0x17c/0x200
>           kthread+0xde/0x110
>           ? __pfx_kthread+0x10/0x10
>           ret_from_fork+0x2b/0x40
>           ? __pfx_kthread+0x10/0x10
>           ret_from_fork_asm+0x1b/0x30
>           </TASK>
>
> The situation can't be solved with just unpinning the timer. The hrtimer
> infrastructure and the nohz heuristics involved in finding the best
> remote target for an unpinned timer would then also need to handle
> enqueues from an offline CPU in the most horrendous way.
>
> So fix this on the RCU side instead and defer the wake up to an online
> CPU if it's too late for the local one.
>
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c     | 34 +++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree_exp.h |  3 +--
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..157f3ca2a9b5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1013,6 +1013,38 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
>         return needmore;
>  }
>
> +static void swake_up_one_online_ipi(void *arg)
> +{
> +       struct swait_queue_head *wqh = arg;
> +
> +       swake_up_one(wqh);
> +}
> +
> +static void swake_up_one_online(struct swait_queue_head *wqh)
> +{
> +       int cpu = get_cpu();
> +
> +       /*
> +        * If called from rcutree_report_cpu_starting(), wake up
> +        * is dangerous that late in the CPU-down hotplug process. The
> +        * scheduler might queue an ignored hrtimer. Defer the wake up
> +        * to an online CPU instead.
> +        */
> +       if (unlikely(cpu_is_offline(cpu))) {
> +               int target;
> +
> +               target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
> +                                        cpu_online_mask);
> +
> +               smp_call_function_single(target, swake_up_one_online_ipi,
> +                                        wqh, 0);
> +               put_cpu();
> +       } else {
> +               put_cpu();
> +               swake_up_one(wqh);
> +       }
> +}
> +
>  /*
>   * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
>   * interrupt or softirq handler, in which case we just might immediately
> @@ -1037,7 +1069,7 @@ static void rcu_gp_kthread_wake(void)
>                 return;
>         WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
>         WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
> -       swake_up_one(&rcu_state.gp_wq);
> +       swake_up_one_online(&rcu_state.gp_wq);
>  }
>
>  /*
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..2ac440bc7e10 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -173,7 +173,6 @@ static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
>         return ret;
>  }
>
> -
>  /*
>   * Report the exit from RCU read-side critical section for the last task
>   * that queued itself during or before the current expedited preemptible-RCU
> @@ -201,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
>                         raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>                         if (wake) {
>                                 smp_mb(); /* EGP done before wake_up(). */
> -                               swake_up_one(&rcu_state.expedited_wq);
> +                               swake_up_one_online(&rcu_state.expedited_wq);
>                         }
>                         break;
>                 }
> --
> 2.42.1
>

