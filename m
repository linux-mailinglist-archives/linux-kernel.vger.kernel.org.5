Return-Path: <linux-kernel+bounces-4648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900B81803F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CA51F24BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBF5393;
	Tue, 19 Dec 2023 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fJtiqTop"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E845235
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67ad277a06bso30372686d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702957139; x=1703561939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YX5TYy/ybPzczd7hAS2O6+/O2HDPlz224pHU/1rX4w8=;
        b=fJtiqTopOMUglG1zrPdSL+JFs741Itp6FWm+7Br1O1ljcNEPnpaTQiO0R3urqcZmZE
         W/XurKyMXM5ZjwVgnezdy400I03Hv9O6rTA7UMVUsvf4jSm1vALnLsp8zuKfWYGYyOUc
         BJm8mdvVFCUHZqVG2HKxA+NknJapibIurJsi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702957139; x=1703561939;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX5TYy/ybPzczd7hAS2O6+/O2HDPlz224pHU/1rX4w8=;
        b=ePdQ5DZb8Wsv36Blbft5a3o3pbu5fP/qNQOlIoP1M0B7rJTeoNeBf8+zMYplt0im64
         FeMMpwIMnUKVdXG10gHEWa8Z7HTxnD5vYxfsu6NSCMP0jlHkXqKDpQICq3m3hVkKsd5N
         TypQOkvX7aCfpidwr6WW3Luv7G2L7tQYdo06kX2fkZuWzRHAe/s4z0xhRuqURsBhicPJ
         Ik87noNF+cSOqlWJ4R693+8Kv4J8jCzM+q8rtp2QkqlGb4IozlhInnQhvjJmfs4clkRi
         RECCp83NqklIQHAkyS/qyAJwym3Kh2IN+Y0uwSrdulkAL/+fB+FerRaW8n8yoS0iOzfw
         GqZg==
X-Gm-Message-State: AOJu0YyEbipY91PcolQ8M7xT7sHMHJwv2e6/B4+zB0y5jz2VPgqg96IY
	epO4ZWJGUN2I1Mnr6b6w9/zNGA==
X-Google-Smtp-Source: AGHT+IHPKLo6fcEr1pM0YaqtWfX95s6Zp0/4QRmdjAcJisqE0iOCB1H6R4jciX1G+uIwTRksePlMrA==
X-Received: by 2002:a05:6214:f0a:b0:67f:45fb:bc2d with SMTP id gw10-20020a0562140f0a00b0067f45fbbc2dmr4109071qvb.92.1702957138746;
        Mon, 18 Dec 2023 19:38:58 -0800 (PST)
Received: from localhost ([91.196.69.49])
        by smtp.gmail.com with ESMTPSA id p1-20020ad452e1000000b0067f4bdacb6csm1074396qvu.116.2023.12.18.19.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 19:38:57 -0800 (PST)
Message-ID: <65811051.d40a0220.75c79.66cf@mx.google.com>
X-Google-Original-Message-ID: <20231219033852.GA2930@JoelBox.>
Date: Mon, 18 Dec 2023 22:38:52 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218231916.11719-3-frederic@kernel.org>

On Tue, Dec 19, 2023 at 12:19:15AM +0100, Frederic Weisbecker wrote:
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
> This triggers TREE03 rcutorture hangs:
> 
> 	 rcu: INFO: rcu_preempt self-detected stall on CPU
> 	 rcu:     4-...!: (1 GPs behind) idle=9874/1/0x4000000000000000 softirq=0/0 fqs=20 rcuc=21071 jiffies(starved)
> 	 rcu:     (t=21035 jiffies g=938281 q=40787 ncpus=6)
> 	 rcu: rcu_preempt kthread starved for 20964 jiffies! g938281 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> 	 rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> 	 rcu: RCU grace-period kthread stack dump:
> 	 task:rcu_preempt     state:R  running task     stack:14896 pid:14    tgid:14    ppid:2      flags:0x00004000
> 	 Call Trace:
> 	  <TASK>
> 	  __schedule+0x2eb/0xa80
> 	  schedule+0x1f/0x90
> 	  schedule_timeout+0x163/0x270
> 	  ? __pfx_process_timeout+0x10/0x10
> 	  rcu_gp_fqs_loop+0x37c/0x5b0
> 	  ? __pfx_rcu_gp_kthread+0x10/0x10
> 	  rcu_gp_kthread+0x17c/0x200
> 	  kthread+0xde/0x110
> 	  ? __pfx_kthread+0x10/0x10
> 	  ret_from_fork+0x2b/0x40
> 	  ? __pfx_kthread+0x10/0x10
> 	  ret_from_fork_asm+0x1b/0x30
> 	  </TASK>
> 
> The situation can't be solved with just unpinning the timer. The hrtimer
> infrastructure and the nohz heuristics involved in finding the best
> remote target for an unpinned timer would then also need to handle
> enqueues from an offline CPU in the most horrendous way.
> 
> So fix this on the RCU side instead and defer the wake up to an online
> CPU if it's too late for the local one.

Ah, ideally we'd not run into this if sched_feat(TTWU_QUEUE) was enabled
but then in any case there is also the ttwu_queue_cond() also shutting down
the remote queueing..

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
>  	return needmore;
>  }
>  
> +static void swake_up_one_online_ipi(void *arg)
> +{
> +	struct swait_queue_head *wqh = arg;
> +
> +	swake_up_one(wqh);
> +}

Speaking of, the scheduler refuses to do remote-IPI-style wakeups
(TTWU_QUEUE) whenever the destination CPU is in a hotplug state.

static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
{
	/*
	 * Do not complicate things with the async wake_list while the CPU is
	 * in hotplug state.
	 */
	if (!cpu_active(cpu))
		return false;
	...
}

Along these lines, I wonder if, it is safe to do a wakeup in this fashion (as
done by this patch) if the destination CPU was also going down.

Also the same ttwu_queue_cond() checks for CPU affinities before deciding to
not do the IPI-style queue.

	/* Ensure the task will still be allowed to run on the CPU. */
	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
		return false;

Not that anyone should be changing RCU thread priorities around while the IPI
is in flight, but...

I wonder if the reason TTWU is excessively paranoid is that the IPI can be
delayed for example, leading to race conditions.

Anyway, just my 2 cents.

Happy holidays! thanks,

 - Joel


> +
> +static void swake_up_one_online(struct swait_queue_head *wqh)
> +{
> +	int cpu = get_cpu();
> +
> +	/*
> +	 * If called from rcutree_report_cpu_starting(), wake up
> +	 * is dangerous that late in the CPU-down hotplug process. The
> +	 * scheduler might queue an ignored hrtimer. Defer the wake up
> +	 * to an online CPU instead.
> +	 */
> +	if (unlikely(cpu_is_offline(cpu))) {
> +		int target;
> +
> +		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
> +					 cpu_online_mask);
> +
> +		smp_call_function_single(target, swake_up_one_online_ipi,
> +					 wqh, 0);
> +		put_cpu();
> +	} else {
> +		put_cpu();
> +		swake_up_one(wqh);
> +	}
> +}
> +
>  /*
>   * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
>   * interrupt or softirq handler, in which case we just might immediately
> @@ -1037,7 +1069,7 @@ static void rcu_gp_kthread_wake(void)
>  		return;
>  	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
>  	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
> -	swake_up_one(&rcu_state.gp_wq);
> +	swake_up_one_online(&rcu_state.gp_wq);
>  }
>  
>  /*
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..2ac440bc7e10 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -173,7 +173,6 @@ static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
>  	return ret;
>  }
>  
> -
>  /*
>   * Report the exit from RCU read-side critical section for the last task
>   * that queued itself during or before the current expedited preemptible-RCU
> @@ -201,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
>  			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  			if (wake) {
>  				smp_mb(); /* EGP done before wake_up(). */
> -				swake_up_one(&rcu_state.expedited_wq);
> +				swake_up_one_online(&rcu_state.expedited_wq);
>  			}
>  			break;
>  		}
> -- 
> 2.42.1
> 

