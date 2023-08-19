Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6F78178D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbjHSGJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbjHSGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA27420F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d37b541a2so25626087b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425364; x=1693030164;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7+jae9+tPNItTCIj+E1nAAp463mdzPtLiylyzIw/ss=;
        b=TaxfD1WhSd/BtK4RmWGaGKnbUuuYh7WAabLdDDiWWrPR2/vgxB8JQr0fod6ZQUuajS
         PoUF1D/+jYLjT1W/W3zQVYAzK7PcJ4xUy8R/yZQnC43I7uAk+NGFLo6165E8OKA2gLb0
         YZWUpQ3WdEQFHtjBAJrK2C3QXOLisYnoa+KI1i8HBB/Z3wh81IjCWuTo9YxYGtrGD4T+
         JPEXF4qiGAbcOdDWYh0z7GHqyXR5IRBGXea2ypNnx+vOX63EDOjmOsNrb6VZ7nkD9Cpx
         0PwfB7ITW9tKe5t2o6SFsLYJLhvT4iodhZ9O68J+jRvbp1Weu7ebrvAbAD9k9ZKfDMcY
         b5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425364; x=1693030164;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7+jae9+tPNItTCIj+E1nAAp463mdzPtLiylyzIw/ss=;
        b=QNPI1nKHX+yTs6Q4p+jNk933f0SQJVnJfceWKyZEQu83U6+5mx0AkUI19ZBvfkTUDO
         ldjydt1o0Gbtls+FLcxJIiXYNaSZuH5YL6e/Vx8JXh1Ukuk1JrndrHW+FfelpQSnNgsz
         bTHsYm7FqhPD/LCDdRd7BmnaS9luwetesM0/F3V+15IZPkql9neaK8r32N66gSEG6VtI
         +VbwGnekfFCQmmJCeft3s4V5cYoLIBvSSESnhdOLqU03csGPyDPN7OprAE/AVYMZaqA0
         GJ/v/WgrpCV9D0gJWubkP28q6kIvjkhcR5nRA9k0aPBZXOUCLQZz+3/XrijgRsC17dgV
         z5+A==
X-Gm-Message-State: AOJu0YzaPvTZpggTXSEYMfODp05eoMifjK4j/1PU8KcRadWMPXwXuvrw
        M3WfsWCt/LP9vcG1gN02dynQbabxwrme7EbeLyhJ7AAdi7ipGzceCnSQgT6laYyqKxixfuo/K/9
        ujy2ylO+6arhDDDCWYFOLZ82d25qC4Xa+KMH/hrjjt9ch++0A8uCTLx1pvcZ5hzxMYcAJKiU=
X-Google-Smtp-Source: AGHT+IH2oAqmpyNeg8k7iYn8Hx//joEOXmEMnHfcgrI9TShkmK8H7a11B/4UM/Tq9J+mP73by03KBJvZps/l
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:694d:0:b0:d4c:5b69:e95c with SMTP id
 e74-20020a25694d000000b00d4c5b69e95cmr10308ybc.1.1692425364275; Fri, 18 Aug
 2023 23:09:24 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-1-jstultz@google.com>
Subject: [PATCH v5 00/19] Proxy Execution: A generalized form of Priority
 Inheritance v5
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting this iteration of the patch series out to the list has
taken way longer than I had hoped! Right before I sent out the
v4 release, I had found that while the patch series was fairly
stable with lower cpu counts, I could very easily run into
crashes with higher cpus during bootup. Not being able to
quickly resolve the crashes I was seeing, I went ahead and sent
out v4 for review, and figured I=E2=80=99d debug the issue and send out
v5 as a quick follow on.=20

But unfortunately trying to diagnose the failures and fix them
started uncovering other crashes. Additionally, the v4 patch
series wasn=E2=80=99t properly bisectable as earlier changes were
missing fixes from later in the series, which made debugging
issues quite difficult. So after playing constant wack-a-mole
with bugs, I took the entire engine apart and laid all the bits
on the floor, and started slowly re-assembling things, testing
each step as I went.

This has been very laborious, as cutting small chunks from the
larger patches off would run into self-caused issues that I
spent much time debugging, due to my missing needed logic still
in the larger patch. But slowly I=E2=80=99ve managed to get almost all
the fine-grained patches to boot and run.

In fact, the patch series here is coarser than what I=E2=80=99ve
created, as there are a number of small =E2=80=9Ctest=E2=80=9D steps to hel=
p
validate behavior I changed, which would then be replaced by the
real logic afterwards. Including those here would just cause
more work for reviewers, but if you=E2=80=99re interested you can find
the fine-grained tree here:=20
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v5-6.5-rc=
6-fine-grained
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v5-6.5-rc6-fi=
ne-grained

Having this fine grained tree really helped me chase down and
resolve a large number of bugs in the logic. In some cases I=E2=80=99ve
significantly reworked parts of the changes, so for instance, I
found the previous versions of the patch had a fair amount of
logic changing the blocked_on state in the try_to_wake_up paths
which were racy particularly with the return-migration. I=E2=80=99ve
moved the return-migration logic into __sched so we make sure we
don=E2=80=99t run proxy-migrated blocked tasks on an incorrect cpu when
they are unblocked. This change has its own complexity, so
feedback/suggestions for improvements would be appreciated. But
as a result, the patch series is much more stable (particularly
the earlier components).

Now, I have run into a few issues still, particularly around the
enqueuing of tasks on deactivated/sleeping owners, particularly
with the test-ww_mutex logic (ww_mutexes have been difficult as
they break assumptions that tasks are unblocked along the
blocked_on chain in an orderly fashion - Instead a task in the
middle of the chain may become suddenly runnable because it got
an EDEADLK from its ww_mutex). Additionally I haven=E2=80=99t been able
to test and debug chain migration. So I=E2=80=99ve left those patches out
for now, but will re-include them on the next revision. Given the
number of patches here, I suspect reviewers won=E2=80=99t mind. :)=20

As mentioned previously, this Proxy Execution series has a long
history: First described in a paper[2] by Watkins, Straub,
Niehaus, then from patches from Peter Zijlstra, extended with
lots of work by Juri Lelli, Valentin Schneider, and Connor
O'Brien. (and thank you to Steven Rostedt for providing
additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

Overview:
---------
Proxy Execution is a generalized form of priority inheritance.
Classic priority inheritance works well for real-time tasks where
there is a straight forward priority order to how things are run.
But it breaks down when used between CFS or DEADLINE tasks, as
there are lots of parameters involved outside of just the task=E2=80=99s
nice value when selecting the next task to run (via
pick_next_task()). So ideally we want to imbue the mutex holder
with all the scheduler attributes of the blocked waiting task.

Proxy Execution does this via a few changes:
* Keeping tasks that are blocked on a mutex *on* the runqueue
* Keeping additional tracking of which mutex a task is blocked
  on, and which task holds a specific mutex.
* Special handling for when we select a blocked task to run, so
  that we instead run the mutex holder.=20

The first of these is the most difficult to grasp (I do get the
mental friction here: blocked tasks on the *run*queue sounds like
nonsense! Personally I like to think of the runqueue in this
model more like a =E2=80=9Ctask-selection queue=E2=80=9D).

By leaving blocked tasks on the runqueue, we allow
pick_next_task() to choose the task that should run next (even if
it=E2=80=99s blocked waiting on a mutex). If we do select a blocked task,
we look at the task=E2=80=99s blocked_on mutex and from there look at the
mutex=E2=80=99s owner task. And in the simple case, the task which owns
the mutex is what we then choose to run, allowing it to release
the mutex.

This means that instead of just tracking =E2=80=9Ccurr=E2=80=9D, the schedu=
ler
needs to track both the scheduler context (what was picked and
all the state used for scheduling decisions), and the execution
context (what we=E2=80=99re actually running).

In this way, the mutex owner is run =E2=80=9Con behalf=E2=80=9D of the bloc=
ked
task that was picked to run, essentially inheriting the scheduler
context of the waiting blocked task.

As Connor outlined in a previous submission of this patch series,
this raises a number of complicated situations: The mutex owner
might itself be blocked on another mutex, or it could be
sleeping, running on a different CPU, in the process of migrating
between CPUs, etc.

But the functionality provided by Proxy Execution is useful, as
in Android we have a large number of cases where we are seeing
priority inversion (not unbounded, but longer than we=E2=80=99d like)
between =E2=80=9Cforeground=E2=80=9D and =E2=80=9Cbackground=E2=80=9D SCHED=
_NORMAL applications,
so having a generalized solution would be very useful.

New in v5:
---------
* Broke the patch series up into fine grained changes

* Heavily reworked the return-migration handling by moving it
  out of try_to_wake_up() and into __schedule().

* Reworked blocked_on tracking logic (so it is handled
  completely in mutex code), and added a blocked_on_waking
  value, so we can distinguish when tasks have not acquired the
  mutex, but need to wake up to try to do so.

* Resolved lost-wakeup issues caused by the wake_qs being
  managed in the ctx structures instead of being on the stack. I
  went back to an earlier version of that patch from Juri though
  re-adding some fixes from Connor=E2=80=99s version.

* Resolved null se pointer crashes seen at bootup, caused by
  incorrect put_prev_task() calls

* Fixes to the test-ww_mutex test logic that was causing
  livelocks & hangs. (Sent as a separate series)

* And more I=E2=80=99ve likely forgotten

Also, I know Peter didn=E2=80=99t like the blocked_on wrappers, so I
dropped them last time, but I found them (and the debug checks
within) crucial to working out issues in this patch series. I=E2=80=99m
fine to consider dropping them later if they are still
objectionable, but their utility was too high at this point to
get rid of them.


Issues still to address:
=E2=80=94----------
* As mentioned above, the deactivated owner handling (where we
  deactivate waiting tasks and enqueue them onto a list, then
  reactivate them when the owner wakes up) has some major issues
  with ww_mutexes. Additionally I think there are other races
  possible, since everyone is using a single blocked_entry
  list_head, anyone who wakes up may think it=E2=80=99s the front of the
  chain and wake everyone else up(not just those waiting on it).
  I believe if two processes are woken at the same time, they
  could fight trying to consume and activate tasks onto different
  cpus.

* Still need to validate and re-add the chain migration patches.

* Seen some rare crashes around rt runqueue accounting. Will be
  investigating this.

* =E2=80=9Crq_selected()=E2=80=9D naming. Peter doesn=E2=80=99t like it, bu=
t I=E2=80=99ve not
  thought of a better name. Open to suggestions.

* As discussed at OSPM[1], I want to split pick_next_task() up
  into two phases selecting and setting the next tasks, as
  currently pick_next_task() assumes the returned task will be
  run which results in various side-effects in sched class logic
  when it=E2=80=99s run.=20

* CFS load balancing. Blocked tasks may carry forward load (PELT)
  to the lock owner's CPU, so CPU may look like it is overloaded.

* I still want to push down the split scheduler and execution
  context awareness further through the scheduling code, as lots
  of logic still assumes there=E2=80=99s only a single =E2=80=9Crq->curr=E2=
=80=9D task.

* Optimization to avoid migrating blocked tasks (allowing for
  optimistic spinning) if the runnable lock-owner at the end of
  the blocked_on chain is already running (though this is
  difficult as locking rules to traverse the blocked on chain
  across run queues isn=E2=80=99t trivial).


Performance:
=E2=80=94----------
This patch series switches mutexes to use handoff mode rather
than optimistic spinning. This is a potential concern where locks
are under high contention. However, earlier performance analysis
(on both x86 and mobile devices) did not see major regressions.
That said, Chenyu did report a regression[3], which I=E2=80=99ll need to
look further into. I also briefly re-tested with this v5 series
and saw some average latencies grow suggesting the changes to
return-migration (and extra locking) have some impact. I=E2=80=99ll be
digging more there. As mentioned above, there may be some
additional optimizations that can help here, but my focus is on
getting the code working well before I spend time optimizing.

Review and feedback would be greatly appreciated!

If folks find it easier to test/tinker with, this patch series can also be =
found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v5-6.5-rc=
6
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v5-6.5-rc6

Thanks so much!
-john

[1] https://youtu.be/QEWqRhVS3lI (video of my OSPM talk)
[2] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
[3] https://lore.kernel.org/lkml/Y7vVqE0M%2FAoDoVbj@chenyu5-mobl1/

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com

John Stultz (8):
  locking/mutex: Removes wakeups from under mutex::wait_lock
  locking/mutex: Split blocked_on logic into two states (blocked_on and
    blocked_on_waking)
  sched: Fix runtime accounting w/ split exec & sched contexts
  sched: Unnest ttwu_runnable in prep for proxy-execution
  sched: Split out __sched() deactivate task logic into a helper
  sched: Add a very simple proxy() function
  sched: Add proxy deactivate helper
  sched: Handle blocked-waiter migration (and return migration)

Juri Lelli (2):
  locking/mutex: make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (7):
  sched: Unify runtime accounting across classes
  locking/mutex: Rework task_struct::blocked_on
  locking/mutex: Add task_struct::blocked_lock to serialize changes to
    the blocked_on state
  locking/mutex: Switch to mutex handoffs for CONFIG_PROXY_EXEC
  sched: Split scheduler execution context
  sched: Start blocked_on chain processing in proxy()
  sched: Add blocked_donor link to task for smarter mutex handoffs

Valentin Schneider (2):
  locking/mutex: Add p->blocked_on wrappers for correctness checks
  sched: Fix proxy/current (push,pull)ability

 include/linux/sched.h        |  33 ++-
 init/Kconfig                 |   7 +
 init/init_task.c             |   1 +
 kernel/Kconfig.locks         |   2 +-
 kernel/fork.c                |   6 +-
 kernel/locking/mutex-debug.c |   9 +-
 kernel/locking/mutex.c       | 128 ++++++---
 kernel/locking/mutex.h       |  25 ++
 kernel/locking/ww_mutex.h    |  72 +++--
 kernel/sched/core.c          | 522 +++++++++++++++++++++++++++++++----
 kernel/sched/deadline.c      |  50 ++--
 kernel/sched/fair.c          | 104 +++++--
 kernel/sched/rt.c            |  78 +++---
 kernel/sched/sched.h         |  61 +++-
 kernel/sched/stop_task.c     |  13 +-
 15 files changed, 868 insertions(+), 243 deletions(-)

--=20
2.42.0.rc1.204.g551eb34607-goog

