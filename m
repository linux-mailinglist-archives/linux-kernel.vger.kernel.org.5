Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CD7E6AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKIMet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKIMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:34:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9373A2D57;
        Thu,  9 Nov 2023 04:34:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso1093607e87.2;
        Thu, 09 Nov 2023 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699533284; x=1700138084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4dKsp/95v9+8+ZWBDzOFDEvGUJSpBWLHezqEAeqkWc=;
        b=DKds0H3/3P2HbyDt66bO5iJmarCKPDfUiDb2sluPFT7ijcF4ZWq0/+GTjI0hbkl4ev
         1aRteqAHS3XYEmtb99YEuFOtDD5xHBzBlccI3Hb4yVZg6c08qLg1SrC/lSHjTsOdqwL4
         DZlvJAjDH2/5k8wsgD3J7+AnR/+bk2oYC3b7NJMqLk0nMZt8lSOmo86bJJFCHhNGWqmE
         hLHEaF6TMQWcIyps1YUd+Xv/O/2EQz4ClH+IjpPJhzypbranqPbEA3Anr0zQsHfGgQ8d
         5oYhQi/xvoaFPJ965APEvF6qNX/JcDXaafDF6D0YKgfgg7LJ8oXZEUhop3zxBRbeB97r
         u4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699533284; x=1700138084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4dKsp/95v9+8+ZWBDzOFDEvGUJSpBWLHezqEAeqkWc=;
        b=rdTN44/5jihRC5FQLMit2lOdBI6uUTPltU+EYYbUNSufKgdjKKfMyFDwG/BU2nkjqM
         ibHSoXRW77xH/iVCxPIQqqnznDH+yE4FT3MDzLg+hIzUZulSusbBz89joS92Ly1AUPh+
         /DklVBsCDXczeMyoVNsM0kiRFIymoVIieLB7HI/aFF6SAIQdVnSVn3RPnUpeyrGwjHG+
         Se3f3FWCH0gOZSGI7C0FblF74V92DCXeiESXFrWG43tiyxmCZTrnbBSeOaSdpkf4xExp
         jiTWqQmI2MQRk3ds4keGpgYTfH48tjgsnuVuSgn8UbdMp/sD578yRtgigs+qZdgBOfih
         8AnA==
X-Gm-Message-State: AOJu0YxwMwOdt/PHMW1eSJzg0u5tFl0dMY7iMDYECqXEPPi7o+unJxSZ
        z8FtHwroCiXcf+cygIME6p4=
X-Google-Smtp-Source: AGHT+IGj9eaJYb0UaNd5YB3WVdoe2Lb8h+otvLPQYgpnLyZgzu4gZAV6pfWqDpI+loqBDRwYryNldQ==
X-Received: by 2002:a05:6512:3b98:b0:509:4645:b78b with SMTP id g24-20020a0565123b9800b005094645b78bmr1670707lfv.10.1699533283301;
        Thu, 09 Nov 2023 04:34:43 -0800 (PST)
Received: from pc636 (host-90-233-220-95.mobileonline.telia.com. [90.233.220.95])
        by smtp.gmail.com with ESMTPSA id n2-20020a0565120ac200b00507b085e995sm1050176lfu.44.2023.11.09.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:34:42 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Nov 2023 13:34:40 +0100
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/3] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZUzR4Ae-vBvPG98Z@pc636>
References: <20231030131254.488186-1-urezki@gmail.com>
 <20231030131254.488186-2-urezki@gmail.com>
 <CALm+0cWOV+7t2JOa29YgLb1vbg9W34Zf5jyi3DVXKGv0V2MC=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWOV+7t2JOa29YgLb1vbg9W34Zf5jyi3DVXKGv0V2MC=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 07:36:14PM +0800, Z qiang wrote:
> >
> > A call to a synchronize_rcu() can be optimized from a latency
> > point of view. Workloads which depend on this can benefit of it.
> >
> > The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> > depends on several factors:
> >
> > - how fast a process of offloading is started. Combination of:
> >     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
> >     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
> >     - other.
> > - when started, invoking path is interrupted due to:
> >     - time limit;
> >     - need_resched();
> >     - if limit is reached.
> > - where in a nocb list it is located;
> > - how fast previous callbacks completed;
> >
> > Example:
> >
> > 1. On our embedded devices i can easily trigger the scenario when
> > it is a last in the list out of ~3600 callbacks:
> >
> > <snip>
> >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> > ...
> >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> > <snip>
> >
> > 2. We use cpuset/cgroup to classify tasks and assign them into
> > different cgroups. For example "backgrond" group which binds tasks
> > only to little CPUs or "foreground" which makes use of all CPUs.
> > Tasks can be migrated between groups by a request if an acceleration
> > is needed.
> >
> > See below an example how "surfaceflinger" task gets migrated.
> > Initially it is located in the "system-background" cgroup which
> > allows to run only on little cores. In order to speed it up it
> > can be temporary moved into "foreground" cgroup which allows
> > to use big/all CPUs:
> >
> > cgroup_attach_task():
> >  -> cgroup_migrate_execute()
> >    -> cpuset_can_attach()
> >      -> percpu_down_write()
> >        -> rcu_sync_enter()
> >          -> synchronize_rcu()
> >    -> now move tasks to the new cgroup.
> >  -> cgroup_migrate_finish()
> >
> > <snip>
> >          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
> >     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
> >    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> > <snip>
> >
> > "Boosting a task" depends on synchronize_rcu() latency:
> >
> > - first trace shows a completion of synchronize_rcu();
> > - second shows attaching a task to a new group;
> > - last shows a final step when migration occurs.
> >
> > 3. To address this drawback, maintain a separate track that consists
> > of synchronize_rcu() callers only. After completion of a grace period
> > users are awaken directly, it is limited by allowed threshold, others
> > are deferred(if still exist) to a worker to complete the rest.
> >
> > 4. This patch reduces the latency of synchronize_rcu() approximately
> > by ~30-40% on synthetic tests. The real test case, camera launch time,
> > shows(time is in milliseconds):
> >
> > 1-run 542 vs 489 improvement 9%
> > 2-run 540 vs 466 improvement 13%
> > 3-run 518 vs 468 improvement 9%
> > 4-run 531 vs 457 improvement 13%
> > 5-run 548 vs 475 improvement 13%
> > 6-run 509 vs 484 improvement 4%
> >
> > Synthetic test:
> >
> > Hardware: x86_64 64 CPUs, 64GB of memory
> >
> > - 60K tasks(simultaneous);
> > - each task does(1000 loops)
> >      synchronize_rcu();
> >      kfree(p);
> >
> > default: CONFIG_RCU_NOCB_CPU: takes 323 seconds to complete all users;
> > patch: CONFIG_RCU_NOCB_CPU: takes 240 seconds to complete all users.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c     | 154 +++++++++++++++++++++++++++++++++++++++++-
> >  kernel/rcu/tree_exp.h |   2 +-
> >  2 files changed, 154 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 78554e7181dd..f04846b543de 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1384,6 +1384,125 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> >                 raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  }
> >
> > +/*
> > + * There are three lists for handling synchronize_rcu() users.
> > + * A first list corresponds to new coming users, second for users
> > + * which wait for a grace period and third is for which a grace
> > + * period is passed.
> > + */
> > +static struct sr_normal_state {
> > +       struct llist_head srs_next;     /* request a GP users. */
> > +       struct llist_head srs_wait;     /* wait for GP users. */
> > +       struct llist_head srs_done;     /* ready for GP users. */
> > +
> > +       /*
> > +        * In order to add a batch of nodes to already
> > +        * existing srs-done-list, a tail of srs-wait-list
> > +        * is maintained.
> > +        */
> > +       struct llist_node *srs_wait_tail;
> > +} sr;
> > +
> > +/* Disabled by default. */
> > +static int rcu_normal_wake_from_gp;
> > +module_param(rcu_normal_wake_from_gp, int, 0644);
> > +
> > +static void rcu_sr_normal_complete(struct llist_node *node)
> > +{
> > +       struct rcu_synchronize *rs = container_of(
> > +               (struct rcu_head *) node, struct rcu_synchronize, head);
> > +       unsigned long oldstate = (unsigned long) rs->head.func;
> > +
> > +       WARN_ONCE(!poll_state_synchronize_rcu(oldstate),
> > +               "A full grace period is not passed yet: %lu",
> > +               rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> > +
> > +       /* Finally. */
> > +       complete(&rs->completion);
> > +}
> > +
> > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > +{
> > +       struct llist_node *done, *rcu, *next;
> > +
> > +       done = llist_del_all(&sr.srs_done);
> > +       if (!done)
> > +               return;
> > +
> > +       llist_for_each_safe(rcu, next, done)
> > +               rcu_sr_normal_complete(rcu);
> > +}
> > +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> > +
> > +/*
> > + * This is hard-coded and it is a maximum number of
> > + * synchronize_rcu() users(might be +1 extra), which
> > + * are awaken directly by the rcu_gp_kthread(). The
> > + * reset is deferred to a dedicated worker.
> > + */
> > +#define MAX_SR_WAKE_FROM_GP 5
> > +
> > +/*
> > + * Helper function for rcu_gp_cleanup().
> > + */
> > +static void rcu_sr_normal_gp_cleanup(void)
> > +{
> > +       struct llist_node *head, *tail, *pos;
> > +       int i = 0;
> > +
> > +       if (llist_empty(&sr.srs_wait))
> > +               return;
> > +
> > +       tail = READ_ONCE(sr.srs_wait_tail);
> > +       head = __llist_del_all(&sr.srs_wait);
> > +
> > +       llist_for_each_safe(pos, head, head) {
> > +               rcu_sr_normal_complete(pos);
> > +
> > +               if (++i == MAX_SR_WAKE_FROM_GP) {
> > +                       /* If last, process it also. */
> > +                       if (head && !head->next)
> > +                               continue;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (head) {
> > +               /* Can be not empty. */
> > +               llist_add_batch(head, tail, &sr.srs_done);
> > +               queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > +       }
> > +}
> > +
> > +/*
> > + * Helper function for rcu_gp_init().
> > + */
> > +static void rcu_sr_normal_gp_init(void)
> > +{
> > +       struct llist_node *head, *tail;
> > +
> > +       if (llist_empty(&sr.srs_next))
> > +               return;
> > +
> > +       tail = llist_del_all(&sr.srs_next);
> > +       head = llist_reverse_order(tail);
> > +
> > +       /*
> > +        * A waiting list of GP should be empty on this step,
> > +        * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > +        * rolls it over. If not, it is a BUG, warn a user.
> > +        */
> > +       WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > +
> > +       WRITE_ONCE(sr.srs_wait_tail, tail);
> > +       __llist_add_batch(head, tail, &sr.srs_wait);
> > +}
> > +
> > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > +{
> > +       llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> > +}
> > +
> >  /*
> >   * Initialize a new grace period.  Return false if no grace period required.
> >   */
> > @@ -1418,6 +1537,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> >         /* Record GP times before starting GP, hence rcu_seq_start(). */
> >         rcu_seq_start(&rcu_state.gp_seq);
> >         ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > +       rcu_sr_normal_gp_init();
> >         trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> >         rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >         raw_spin_unlock_irq_rcu_node(rnp);
> > @@ -1787,6 +1907,9 @@ static noinline void rcu_gp_cleanup(void)
> >         }
> >         raw_spin_unlock_irq_rcu_node(rnp);
> >
> > +       // Make synchronize_rcu() users aware of the end of old grace period.
> > +       rcu_sr_normal_gp_cleanup();
> > +
> >         // If strict, make all CPUs aware of the end of the old grace period.
> >         if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> >                 on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > @@ -3500,6 +3623,35 @@ static int rcu_blocking_is_gp(void)
> >         return true;
> >  }
> >
> > +/*
> > + * Helper function for the synchronize_rcu() API.
> > + */
> > +static void synchronize_rcu_normal(void)
> > +{
> > +       struct rcu_synchronize rs;
> > +
> > +       if (READ_ONCE(rcu_normal_wake_from_gp)) {
> > +               init_rcu_head_on_stack(&rs.head);
> > +               init_completion(&rs.completion);
> > +
> > +               /*
> > +                * This code might be preempted, therefore take a GP
> > +                * snapshot before adding a request.
> > +                */
> > +               rs.head.func = (void *) get_state_synchronize_rcu();
> > +               rcu_sr_normal_add_req(&rs);
> > +
> > +               /* Kick a GP and start waiting. */
> > +               (void) start_poll_synchronize_rcu();
> > +
> 
> Before invoking rcu_sr_normal_add_req(), can we add the following judgment?
> 
>   if (poll_state_synchronize_rcu((unsigned long)rs.head.func)) {
>                    complete(&rs->completion);
>    } else {
>                  rcu_sr_normal_add_req(&rs);
>                  (void) start_poll_synchronize_rcu();
>    }
> 
OK, you mean if we preempted and GP is passed but we request a new one.
I think it is possible, it looks like we can just bail out without even
calling complete().

We reworking it now, i will try to apply it. Or it can be added later as
a separate patch.

--
Uladzislau Rezki
