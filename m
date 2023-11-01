Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68E7DE03D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjKALVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKALVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:21:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295BF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:21:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso3766105a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698837681; x=1699442481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L/Z47gSQKxAAIq0iuZpu0N2NhE2dFDUAI45STsYwdUE=;
        b=JpAAGr5TjD8hI+GeF0QoHKx+myjw7edy9ubvUxpLiapGjjLdbl4Z6cRtypf4FYRgQX
         8zGY92bidLkXNJpRV1P7qefsFwLGQiEUAdxracex9C3hsWG/saatl1Cm8SN4U4uxUXxn
         LVbBvlN+IEzRtHRZajKSgA5DNrToUwou0nWJ/7WF47E4YCGW6TdAhceOIbHfQy7NN4yL
         NJ+3UFKemKQYwU+Ah+92Y1x3izHYlfA75eGBzX8XJfPEHyosj4Kp9d7CLqFfoP63IVgQ
         51l5rcK5o/7wf/niL9bi/97oUV9pthpx8KGeBAzngGCy6fe6qA6o/cIWeK/ZBSRxuCXo
         la0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698837681; x=1699442481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/Z47gSQKxAAIq0iuZpu0N2NhE2dFDUAI45STsYwdUE=;
        b=EMC85q3gPkas/UmOreOkISACyEhisf2UuJ4KnxmfvqbdUbtQUCVsTc28eyNTETm6pO
         qJ5v5YcOa5JoM4voVGXkctZW48SE62DFZ2PsK5EOvrtuDCA3aWKqTUybVFynDF7qslCa
         HCnmwqJXkWsx/693zhBpT0sp+Hgd3T7pVTcwlxwqMY5nJ+OsydY/pzzvRIKdFBdmeV+c
         hijTFxZAirc9cvKD4gifXcqfFgvvGdk8aqzst0od5QzbJIQ92OXZqciWTZNuPfhDh5j1
         sCJy9bvE9hqgJB9UNqG78usGEHpgJYRdVruNvdavY8mQWDFiQWiHAxT1PCWinxcvqUKa
         rNGw==
X-Gm-Message-State: AOJu0YwY2hgz5yAOJJruKwI/mzit92VXxxRhl/uN1dqennkjd4EM/30C
        wLmI1CnIQkxE9cXsl9p5d6xOaq4jV7t1/Dxd/RI=
X-Google-Smtp-Source: AGHT+IE6fhML8ZxXvIf2y5OTf0w9VByLRiajwtKF3XyubgEPI5VO3CSwH6JcdE6jcJ9iKGDzb0yfl66S/gtC3CcNIyY=
X-Received: by 2002:a17:90b:1904:b0:280:16bb:8169 with SMTP id
 mp4-20020a17090b190400b0028016bb8169mr9385823pjb.40.1698837680667; Wed, 01
 Nov 2023 04:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231031001418.274187-1-longman@redhat.com> <20231031085308.GB35651@noisy.programming.kicks-ass.net>
 <a46f5614-53ec-49fb-86d0-fa5aea4d0a42@paulmck-laptop> <20231031200228.GG15024@noisy.programming.kicks-ass.net>
In-Reply-To: <20231031200228.GG15024@noisy.programming.kicks-ass.net>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 1 Nov 2023 19:21:09 +0800
Message-ID: <CALm+0cWuZZLWkwMPS6n1YyTWzkex9=c1E9CB-m6e_F38MNLVqw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Break rcu_node_0 --> &rq->__lock order
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, Oct 31, 2023 at 07:29:04AM -0700, Paul E. McKenney wrote:
> > Other than the de-alphabetization of the local variables, it looks
> > plausible to me.  Frederic's suggestion also sounds plausible to me.
>
> Having spend the better part of the past two decades using upside down
> xmas trees for local variables, this alphabet thing is obnoxious :-)
>
> But your code, your rules.
>
> To reduce the number of alphabet songs required, I've taken the liberty
> to move a few variables into a narrower scope, hope that doesn't offend.
>
> ---
> Subject: rcu: Break rcu_node_0 --> &rq->__lock order
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 31 Oct 2023 09:53:08 +0100
>
> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> do_set_cpus_allowed()") added a kfree() call to free any user
> provided affinity mask, if present. It was changed later to use
> kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
> in do_set_cpus_allowed()") to avoid a circular locking dependency
> problem.
>
> It turns out that even kfree_rcu() isn't safe for avoiding
> circular locking problem. As reported by kernel test robot,
> the following circular locking dependency now exists:
>
>   &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
>
> Solve this by breaking the rcu_node_0 --> &rq->__lock chain by moving
> the resched_cpu() out from under rcu_node lock.
>
> [peterz: heavily borrowed from Waiman's Changelog]
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/oe-lkp/202310302207.a25f1a30-oliver.sang@intel.com
> ---
>  kernel/rcu/tree.c |   34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -754,14 +754,19 @@ static int dyntick_save_progress_counter
>  }
>
>  /*
> - * Return true if the specified CPU has passed through a quiescent
> - * state by virtue of being in or having passed through an dynticks
> - * idle state since the last call to dyntick_save_progress_counter()
> - * for this same CPU, or by virtue of having been offline.
> + * Returns positive if the specified CPU has passed through a quiescent state
> + * by virtue of being in or having passed through an dynticks idle state since
> + * the last call to dyntick_save_progress_counter() for this same CPU, or by
> + * virtue of having been offline.
> + *
> + * Returns negative if the specified CPU needs a force resched.
> + *
> + * Returns zero otherwise.
>   */
>  static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  {
>         unsigned long jtsq;
> +       int ret = 0;
>         struct rcu_node *rnp = rdp->mynode;
>
>         /*
> @@ -847,8 +852,8 @@ static int rcu_implicit_dynticks_qs(stru
>             (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
>              rcu_state.cbovld)) {
>                 WRITE_ONCE(rdp->rcu_urgent_qs, true);
> -               resched_cpu(rdp->cpu);
>                 WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> +               ret = -1;
>         }
>


Maybe some modifications are missing here:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa4c808978b8..77e7a0dc722a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -867,8 +867,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
        if (time_after(jiffies, rcu_state.jiffies_resched)) {
                if (time_after(jiffies,
                               READ_ONCE(rdp->last_fqs_resched) + jtsq)) {
-                       resched_cpu(rdp->cpu);
                        WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+                       ret = -1;
                }
                if (IS_ENABLED(CONFIG_IRQ_WORK) &&
                    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&



Thanks
Zqiang


>         /*
> @@ -891,7 +896,7 @@ static int rcu_implicit_dynticks_qs(stru
>                 }
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
> @@ -2257,15 +2262,15 @@ static void force_qs_rnp(int (*f)(struct
>  {
>         int cpu;
>         unsigned long flags;
> -       unsigned long mask;
> -       struct rcu_data *rdp;
>         struct rcu_node *rnp;
>
>         rcu_state.cbovld = rcu_state.cbovldnext;
>         rcu_state.cbovldnext = false;
>         rcu_for_each_leaf_node(rnp) {
> +               unsigned long mask = 0;
> +               unsigned long rsmask = 0;
> +
>                 cond_resched_tasks_rcu_qs();
> -               mask = 0;
>                 raw_spin_lock_irqsave_rcu_node(rnp, flags);
>                 rcu_state.cbovldnext |= !!rnp->cbovldmask;
>                 if (rnp->qsmask == 0) {
> @@ -2283,11 +2288,17 @@ static void force_qs_rnp(int (*f)(struct
>                         continue;
>                 }
>                 for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
> +                       struct rcu_data *rdp;
> +                       int ret;
> +
>                         rdp = per_cpu_ptr(&rcu_data, cpu);
> -                       if (f(rdp)) {
> +                       ret = f(rdp);
> +                       if (ret > 0) {
>                                 mask |= rdp->grpmask;
>                                 rcu_disable_urgency_upon_qs(rdp);
>                         }
> +                       if (ret < 0)
> +                               rsmask |= rdp->grpmask;
>                 }
>                 if (mask != 0) {
>                         /* Idle/offline CPUs, report (releases rnp->lock). */
> @@ -2296,6 +2307,9 @@ static void force_qs_rnp(int (*f)(struct
>                         /* Nothing to do here, so just drop the lock. */
>                         raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>                 }
> +
> +               for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
> +                       resched_cpu(cpu);
>         }
>  }
>
