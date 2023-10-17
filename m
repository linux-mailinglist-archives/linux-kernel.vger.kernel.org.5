Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEC7CC58E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbjJQOGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQOGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:06:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90FF0;
        Tue, 17 Oct 2023 07:06:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a936f4a9so3231030e87.1;
        Tue, 17 Oct 2023 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697551593; x=1698156393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0s/4CIk0Qxy4D6C/paFFwCJyOCOD8J+KFr/totpARKw=;
        b=lNnPfu5H+ymQrQb7f6XpVBhEDtE7JS0p/u0JxlF2Pm3qz7rkMB0MW+YkmLRWsBdNDN
         JsjTVgsbNqozNmn2YDaBQ4A+i6xXOGEy9fH9SjJoApv5z7Q4+59hnEvZHyvAI9dC/GCg
         hWphFY7b9KF0qwAmgGEK05pLejtWQgCmA6dlXZsHJDfWmzCttOX9F8zo75QUfVg4Lhj6
         Zgss4lpSQg23esKu42J/sXGa7bPMJYjA5uDJc5N7heCxMjivexNMP8gNS/ajwLUd0pYg
         zL7sDQUwnwFTqsf1T8oY8MRiDJTYIGz+9Jhf6Auqzxdvnz2VAyYUWpGoAifvVOHGmCuJ
         /V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551593; x=1698156393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s/4CIk0Qxy4D6C/paFFwCJyOCOD8J+KFr/totpARKw=;
        b=Ylxux4dkrXNYyY7oH6ULL42scHGSQANJ7RVp4dB7qADIe4KdiozqCbDgofBkoV8Oop
         EFByT/B+/H26vFd06eTyCk9WtVEMPB/8fk9JUIXW6JrTDTmENB/q1poKjixnwV3DzAfO
         wNKEexRYz23kGWpuSN4iAsmU6t3bph69Nc95jzf3ePAoV0rXXwkQxZRPclAj+u3ol9oS
         3XIY0Kh5/yKFNykbWXHL+9e89s4QpbF+ZkcxleBki7qfE94mu75NpDBxXzPVlPdgFghe
         jm9p5PQabollHq8luqE6qkt7d1kNKne+hGJ1lXnwkoRRuo9jNoGdyVA6KpRj46VEyk7G
         YUTw==
X-Gm-Message-State: AOJu0YxJ2J4yZgEImyKVBS8qR7nDv+2dfANJIUdwFhbE/n/kZOP3GkOv
        423ZCROD8oD+giRG397klME=
X-Google-Smtp-Source: AGHT+IHXdM9WUkZU6l0Fc1mEJSV4n3wpEctHxdihOEQbdyBqgGT46X7sv3/QcTVHCHSjdi8F6SXWXw==
X-Received: by 2002:ac2:4c16:0:b0:503:653:5711 with SMTP id t22-20020ac24c16000000b0050306535711mr1744911lfq.9.1697551592414;
        Tue, 17 Oct 2023 07:06:32 -0700 (PDT)
Received: from pc636 (host-90-233-215-212.mobileonline.telia.com. [90.233.215.212])
        by smtp.gmail.com with ESMTPSA id f13-20020a056512360d00b005007fc9ccccsm295501lfs.122.2023.10.17.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:06:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 17 Oct 2023 16:06:29 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/1] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZS6U5SgvGcmdE_DA@pc636>
References: <20231016173004.14148-1-urezki@gmail.com>
 <CAEXW_YRfuXqnBFN=DpOLio74j8fX3eEDSFCH8LXyavuHDdYysA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRfuXqnBFN=DpOLio74j8fX3eEDSFCH8LXyavuHDdYysA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joel!

> Hello, Vlad,
> 
> Looks like a nice patch, I am still looking at this more and just
> started, but a few small comments:
> 
Thank you for looking at it :) And thank you for the comments.


> On Mon, Oct 16, 2023 at 1:30 PM Uladzislau Rezki (Sony)
> <urezki@gmail.com> wrote:
> >
> > A call to a synchronize_rcu() can be optimized from time point of
> > view. Different workloads can be affected by this especially the
> > ones which use this API in its time critical sections.
> >
> > For example if CONFIG_RCU_NOCB_CPU is set, the wakeme_after_rcu()
> > callback can be delayed and such delay depends on where in a nocb
> > list it is located.
> >
> > 1. On our Android devices i can easily trigger the scenario when
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
> [...]
> > 3. To address this drawback, maintain a separate track that consists
> > of synchronize_rcu() callers only. The GP-kthread, that drivers a GP
> > either wake-ups a worker to drain all list or directly wakes-up end
> > user if it is one in the drain list.
> 
> I wonder if there is a cut-off N, where waking up N ("a few") inline
> instead of just 1, yields similar results. For small values of N, that
> keeps the total number of wakeups lower than pushing off to a kworker.
> For instance, if 2 users, then you get 3 wakeups instead of just 2 (1
> for the kworker and another 2 for the synchronize). But if you had a
> cut off like N=5, then 2 users results in just 2 wakeups.
> I don't feel too strongly about it, but for small values of N, I am
> interested in a slightly better optimization if we can squeeze it.
> 
This makes sense to me. We can add a threshold to wake-up several users.
Like you mentioned. We can do 2 wake-ups instead of 3.

> [...]
> > + * There are three lists for handling synchronize_rcu() users.
> > + * A first list corresponds to new coming users, second for users
> > + * which wait for a grace period and third is for which a grace
> > + * period is passed.
> > + */
> > +static struct sr_normal_state {
> > +       struct llist_head curr; /* request a GP users. */
> > +       struct llist_head wait; /* wait for GP users. */
> > +       struct llist_head done; /* ready for GP users. */
> > +       struct llist_node *curr_tail;
> > +       struct llist_node *wait_tail;
> 
> Just for clarification, the only reason you need 'tail' is because you
> can use llist_add_batch() to quickly splice the list, instead of
> finding the tail each time (expensive for a large list), correct? It
> would be good to mention that in a comment here.
> 
Right. I do not want to scan the list. I will comment it.

> > +       atomic_t active;
> > +} sr;
> > +
> > +/* Disable it by default. */
> > +static int rcu_normal_wake_from_gp = 0;
> > +module_param(rcu_normal_wake_from_gp, int, 0644);
> > +
> > +static void rcu_sr_normal_complete(struct llist_node *node)
> > +{
> > +       struct rcu_synchronize *rs = container_of(
> > +               (struct rcu_head *) node, struct rcu_synchronize, head);
> > +       unsigned long oldstate = (unsigned long) rs->head.func;
> > +
> > +       if (!poll_state_synchronize_rcu(oldstate))
> > +               WARN_ONCE(1, "A full grace period is not passed yet: %lu",
> > +                       rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> 
> nit: WARN_ONCE(!poll_state_synchronize_rcu(oldstate)), ...) and get
> rid of if() ?
>
Initially i had it written as you proposed i reworked it because i
wanted to see the delta. I do not have a strong opinion, so i can
fix it as you proposed.

> 
> > +
> > +       /* Finally. */
> > +       complete(&rs->completion);
> > +}
> > +
> > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > +{
> > +       struct llist_node *done, *rcu, *next;
> > +
> > +       done = llist_del_all(&sr.done);
> > +       if (!done)
> > +               return;
> > +
> > +       llist_for_each_safe(rcu, next, done)
> > +               rcu_sr_normal_complete(rcu);
> > +}
> [...]
> > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > +{
> > +       atomic_inc(&sr.active);
> > +       if (llist_add((struct llist_node *) &rs->head, &sr.curr))
> > +               /* Set the tail. Only first and one user can do that. */
> > +               WRITE_ONCE(sr.curr_tail, (struct llist_node *) &rs->head);
> > +       atomic_dec(&sr.active);
> 
> Here there is no memory ordering provided by the atomic ops. Is that really Ok?
> 
This needs to be reworked since there is no ordering guaranteed. I think
there is a version of "atomic_inc_something" that guarantees it?

> And same question for other usages of .active.
> 
> Per: https://www.kernel.org/doc/Documentation/atomic_t.txt
> "RMW operations that have no return value are unordered;"
> --
> Note to self to ping my Android friends as well about this improvement
> :-). Especially the -mm Android folks are interested in app startup
> time.
> 
That is good. Thank you :)

--
Uladzislau Rezki
