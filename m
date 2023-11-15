Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE67E83E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbjKJUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKJUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:36:38 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804DBD082
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:08:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58a01a9fad0so417500eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699607283; x=1700212083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxSeprcxpBJUJjiwbfG8GWPRS8RElTLI/FQYj7xxayE=;
        b=isYtwT8rcleuiwWC16HOSTNVm300khB9YRbDOIZDUFANkaxp+F9IT4LOHg9+B2iazq
         pPpc3bmi4icOPOhSe7GUE5myhiZkBPFqp6YHx6UJFn9PBY7qneMgQNjK6g6YaERZLxFX
         H1sivu937EX+91XnH/bJatKrIRmk7CLfk55E/Pd+HQciV1d3vxcHDsNxyl8t3Bhrbsin
         0l2LWk6mdFTzO/3GybUZlVqdLU+gqIjzWtR6LcYHExdct8O8C2sJ9v72kjtcOemsUEGr
         EHsSHLDsidJe5EyTlsUJVHA/xkfmg8GYjGEYApiQKFOroafkkVJnM5/Y2MP/zTNVhY1O
         6Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607283; x=1700212083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxSeprcxpBJUJjiwbfG8GWPRS8RElTLI/FQYj7xxayE=;
        b=nC3328QDiiVn9qQk3uxPDWzqr11ymwwveWkz0/A8F0qXU9E3oUV072UR1E6b3InMlq
         hFF9QdTgUown1xNj10a/D1UJEDjteLsEyjjaXWJxRejljWqqkXgET5Y6S8r2S4+Mo+Af
         HpNpcURnQwNjV069mKYjDB1l0gNjc3QJkubr25wR3kGpdfTWNomMF/jePFB6sOdEr+DL
         4ZoQCapV+CaVqDPmjHMnGH2gU0oiLp6X3I1N8lO+K8mKha0cwjR15ctUG/3BpbKyTTsP
         66n3VbqziHIFwO/qQFTRPC2kUwFBIlaTyEbTwOTHiH6AikmT3WkUI2mJ8p8rsExChZi+
         Litw==
X-Gm-Message-State: AOJu0YzAsvNwapPbE4GBvqWaohtV84wPEJGkVzTP6rigyFU6cNBLniBS
        xePWBT/g8cB0AyPpe81hKVCsLa/kjhnaTE7OPtE=
X-Google-Smtp-Source: AGHT+IHZGKwNJULVZYp/FTNo7XCczOEocF0WYXXS6XOiq6YdFPcH0I8uV4qpu6MYg77gRkaT/D+lnKehW2EDq02/zJE=
X-Received: by 2002:a05:6870:15d4:b0:1f0:4e1f:e09a with SMTP id
 k20-20020a05687015d400b001f04e1fe09amr950197oad.4.1699607282613; Fri, 10 Nov
 2023 01:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 10 Nov 2023 17:07:51 +0800
Message-ID: <CAB8ipk8J0N-K10JdMoJw6a8WY3fzUeDWi2WYEou8=cAD78oBRA@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

On Tue, Nov 7, 2023 at 3:37=E2=80=AFAM John Stultz <jstultz@google.com> wro=
te:
>
> Stabilizing this Proxy Execution series has unfortunately
> continued to be a challenging task. Since the v5 release, I=E2=80=99ve
> been focused on getting the deactivated/sleeping owner enqueuing
> functionality, which I left out of v5, stabilized. I=E2=80=99ve managed
> to rework enough to avoid the crashes previously tripped with the
> locktorture & ww_mutex selftests, so I feel it=E2=80=99s much improved,
> but I do still see some issues (blocked waitqueues and hung task
> watchdogs firing) after stressing the system for many hours in a
> 64 cpu qemu environment (though this issue seems to be introduced
> earlier in the series with proxy-migration/return-migration).
>
> I still haven=E2=80=99t had time to focus on testing and debugging the
> chain migration patches. So I=E2=80=99ve left that patch out of this
> submission for now, but will try to get it included in the next
> revision.
>
> This patch series is actually coarser than what I=E2=80=99ve been
> developing with, as there are a number of small =E2=80=9Ctest=E2=80=9D st=
eps to
> help validate behavior I changed, which would then be replaced by
> the real logic afterwards. Including those here would just cause
> more work for reviewers, so I=E2=80=99ve folded them together, but if
> you=E2=80=99re interested you can find the fine-grained tree here:
> https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.6-fi=
ne-grained
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v6-6.6-fine=
-grained
>
> As mentioned previously, this Proxy Execution series has a long
> history: First described in a paper[1] by Watkins, Straub,
> Niehaus, then from patches from Peter Zijlstra, extended with
> lots of work by Juri Lelli, Valentin Schneider, and Connor
> O'Brien. (and thank you to Steven Rostedt for providing
> additional details here!)
>
> So again, many thanks to those above, as all the credit for this
> series really is due to them - while the mistakes are likely
> mine.
>
> Overview:
> =E2=80=94----------
> Proxy Execution is a generalized form of priority inheritance.
> Classic priority inheritance works well for real-time tasks where
> there is a straight forward priority order to how things are run.
> But it breaks down when used between CFS or DEADLINE tasks, as
> there are lots of parameters involved outside of just the task=E2=80=99s
> nice value when selecting the next task to run (via
> pick_next_task()).  So ideally we want to imbue the mutex holder
> with all the scheduler attributes of  the blocked waiting task.
>
> Proxy Execution does this via a few changes:
> * Keeping tasks that are blocked on a mutex *on* the runqueue
> * Keeping additional tracking of which mutex a task is blocked
>   on, and which task holds a specific mutex.
> * Special handling for when we select a blocked task to run, so
>   that we instead run the mutex holder.
>
> By leaving blocked tasks on the runqueue, we allow
> pick_next_task() to choose the task that should run next (even if
> it=E2=80=99s blocked waiting on a mutex). If we do select a blocked task,
> we look at the task=E2=80=99s blocked_on mutex and from there look at the
> mutex=E2=80=99s owner task. And in the simple case, the task which owns
> the mutex is what we then choose to run, allowing it to release
> the mutex.
>
> This means that instead of just tracking =E2=80=9Ccurr=E2=80=9D, the sche=
duler
> needs to track both the scheduler context (what was picked and
> all the state used for scheduling decisions), and the execution
> context (what we=E2=80=99re actually running).
>
> In this way, the mutex owner is run =E2=80=9Con behalf=E2=80=9D of the bl=
ocked
> task that was picked to run, essentially inheriting the scheduler
> context of the waiting blocked task.

How to prevent malicious programs? If a program takes a hotspot lock
and never releases the lock, then there will be more and more blocked
tasks, and then there will be more and more tasks on the runq, and
because the block tasks are involved scheduling, it may cause the
owner to always be in the running state. As a result, other tasks
cannot be scheduled.
Maybe we can use the hung-task mechanism to also detect such long-running t=
asks?
I will also think about this issue simultaneously. If there is a
patch, I will send it here.

On the other hand, regardless of the extreme situation like above, the
impact of more tasks in runq on performance may require more testing.

BR

---
xuewen

>
> As Connor outlined in a previous submission of this patch series,
> this raises a number of complicated situations:  The mutex owner
> might itself be blocked on another mutex, or it could be
> sleeping, running on a different CPU, in the process of migrating
> between CPUs, etc.
>
> The complexity from this is imposing, but currently in Android we
> have a large number of cases where we are seeing priority
> inversion (not unbounded, but much longer than we=E2=80=99d like) between
> =E2=80=9Cforeground=E2=80=9D and =E2=80=9Cbackground=E2=80=9D SCHED_NORMA=
L applications. As a
> result, currently we cannot usefully limit background activity
> without introducing inconsistent behavior. So Proxy Execution is
> a very attractive approach to resolving this critical issue.
>
>
> New in v6:
> ---------
> * Big rework of blocked owner enqueuing, re-adding the
>   functionality to the series.
>
> * Added a boot option proxy_exec=3D and additional logic to allow
>   the functionality to be boot time toggled.
>
> * Minor tweaks to wake_q logic suggested by Waiman Long
>
> * Minor fixups Reported-by: kernel test robot <lkp@intel.com>
>
> * Various cleanups, optimizations as well as fixes for bugs found in v5
>
> Also, I know Peter didn=E2=80=99t like the blocked_on wrappers, so I
> previously dropped them, but I found them (and the debug checks
> within) crucial to working out issues in this patch series. I=E2=80=99m
> fine to consider dropping them later if they are still
> objectionable, but their utility was too high at this point to
> get rid of them.
>
>
> Issues still to address:
> =E2=80=94----------
> * As already mentioned, the sleeping owner handling (where we
>   deactivate waiting tasks and enqueue them onto a list, then
>   reactivate them when the owner wakes up) has been very
>   difficult to get right. This is in part because when we want
>   to activate tasks, we=E2=80=99re already holding a task.pi_lock and a
>   rq_lock, just not the locks for the task we=E2=80=99re activating, nor
>   the rq we=E2=80=99re  enqueuing it onto. So there has to be a bit of
>   lock juggling to drop and acquire the right locks (in the right
>   order).
>
> * Similarly as we=E2=80=99re often dealing with lists of tasks or chains
>   of tasks and mutexes, iterating across these chains of objects
>   can be done safely while holding the rq lock, but as these
>   chains can cross runqueues our ability to traverse the chains
>   safely is somewhat limited.
>
> * Additionally, in the sleeping owner enqueueing as well as in
>   proxy return migration, we seem to be constantly working
>   against the proper locking order (task.pi_lock->rq lock
>   ->mutex.waitlock -> task.blocked_lock), having to repeatedly
>   =E2=80=9Cswim upstream=E2=80=9D where we need a higher order lock then =
what
>   we=E2=80=99re already holding. Suggestions for different approaches to
>   the serialization or ways to move the logic outside of where
>   locks are already held would be appreciated.
>
> * Still need to validate and re-add the chain migration patches
>   to ensure they resolve the RT/DL load balancing invariants.
>
> * =E2=80=9Crq_selected()=E2=80=9D naming. Peter doesn=E2=80=99t like it, =
but I=E2=80=99ve not
>   thought of a better name. Open to suggestions.
>
> * As discussed at OSPM[2], I like to split pick_next_task() up
>   into two phases selecting and setting the next tasks, as
>   currently pick_next_task() assumes the returned task will be
>   run which results in various side-effects in sched class logic
>   when it=E2=80=99s run. I tried to take a pass at this earlier, but it=
=E2=80=99s
>   hairy and lower on the priority list for now.
>
> * CFS load balancing. Blocked tasks may carry forward load (PELT)
>   to the lock owner's CPU, so CPU may look like it is overloaded.
>
> * Optimization to avoid migrating blocked tasks (to preserve
>   optimistic mutex spinning) if the runnable lock-owner at the
>   end of the blocked_on chain is already running (though this is
>   difficult due to the limitations from locking rules needed to
>   traverse the blocked on chain across run queues).
>
>
> Performance:
> =E2=80=94----------
> This patch series switches mutexes to use handoff mode rather
> than optimistic spinning. This is a potential concern where locks
> are under high contention. However, earlier performance analysis
> (on both x86 and mobile devices) did not see major regressions.
> That said, Chenyu did report a regression[3], which I=E2=80=99ll need to
> look further into. I also briefly re-tested with this v5 series
> and saw some average latencies grow vs v4, suggesting the changes
> to return-migration (and extra locking) have some impact. With v6
> the extra overhead is reduced but still not as nice as v4. I=E2=80=99ll
> be digging more there, but my priority is still stability over
> speed at this point (it=E2=80=99s easier to validate correctness of
> optimizations if the baseline isn=E2=80=99t crashing).
>
>
> If folks find it easier to test/tinker with, this patch series
> can also be found here:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.6
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v6-6.6
>
> Awhile back Sage Sharp had a nice blog post about types of
> reviews [4], and while any review and feedback would be greatly
> appreciated, those focusing on conceptual design or correctness
> issues would be *especially* valued.
>
> Thanks so much!
> -john
>
> [1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
> [2] https://youtu.be/QEWqRhVS3lI (video of my OSPM talk)
> [3] https://lore.kernel.org/lkml/Y7vVqE0M%2FAoDoVbj@chenyu5-mobl1/
> [4] https://sage.thesharps.us/2014/09/01/the-gentle-art-of-patch-review/
>
>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: kernel-team@android.com
>
>
> John Stultz (8):
>   locking/mutex: Removes wakeups from under mutex::wait_lock
>   sched: Add CONFIG_PROXY_EXEC & boot argument to enable/disable
>   locking/mutex: Split blocked_on logic into two states (blocked_on and
>     blocked_on_waking)
>   sched: Fix runtime accounting w/ split exec & sched contexts
>   sched: Split out __sched() deactivate task logic into a helper
>   sched: Add a very simple proxy() function
>   sched: Add proxy deactivate helper
>   sched: Handle blocked-waiter migration (and return migration)
>
> Juri Lelli (2):
>   locking/mutex: make mutex::wait_lock irq safe
>   locking/mutex: Expose __mutex_owner()
>
> Peter Zijlstra (8):
>   sched: Unify runtime accounting across classes
>   locking/mutex: Rework task_struct::blocked_on
>   locking/mutex: Add task_struct::blocked_lock to serialize changes to
>     the blocked_on state
>   locking/mutex: Switch to mutex handoffs for CONFIG_PROXY_EXEC
>   sched: Split scheduler execution context
>   sched: Start blocked_on chain processing in proxy()
>   sched: Add blocked_donor link to task for smarter mutex handoffs
>   sched: Add deactivated (sleeping) owner handling to proxy()
>
> Valentin Schneider (2):
>   locking/mutex: Add p->blocked_on wrappers for correctness checks
>   sched: Fix proxy/current (push,pull)ability
>
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  include/linux/sched.h                         |  49 +-
>  init/Kconfig                                  |   7 +
>  init/init_task.c                              |   1 +
>  kernel/Kconfig.locks                          |   2 +-
>  kernel/fork.c                                 |   8 +-
>  kernel/locking/mutex-debug.c                  |   9 +-
>  kernel/locking/mutex.c                        | 163 ++--
>  kernel/locking/mutex.h                        |  25 +
>  kernel/locking/ww_mutex.h                     |  72 +-
>  kernel/sched/core.c                           | 723 ++++++++++++++++--
>  kernel/sched/deadline.c                       |  50 +-
>  kernel/sched/fair.c                           | 104 ++-
>  kernel/sched/rt.c                             |  77 +-
>  kernel/sched/sched.h                          |  61 +-
>  kernel/sched/stop_task.c                      |  13 +-
>  16 files changed, 1117 insertions(+), 251 deletions(-)
>
> --
> 2.42.0.869.gea05f2083d-goog
>
