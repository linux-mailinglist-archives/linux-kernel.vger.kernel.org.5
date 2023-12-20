Return-Path: <linux-kernel+bounces-6134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11527819508
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911FC287C90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCE23DF;
	Wed, 20 Dec 2023 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBMHAi4C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AE23B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c641d55e27so141665a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031542; x=1703636342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhNrG8n3VF26CTm19xh5W8tfvZ5HxcKEmqHw5UiZ+qE=;
        b=dBMHAi4CwqKnt8UFAE1Kz6Sj5lHBIJBol3BLSvUscamNbBINnsMiCXSlhPT1CGXDsp
         QGEIxB8dCr0/pJE/y3w4xatRarchw3goba4hFtIQgDH8FSpl/ffADX3LD3M0OFqc9VmI
         CrPtwr3jhOw/RUD9ai+qwiyArzltTX7Wi6QdzxolPVziI0XH3OO6i7JiE/Fg6iDKArxL
         VlR4Kljskr547TxJ6sIPKheOLUXf75crWaSyvQvwknupnBukW/0hswRRubvsybes+4Xo
         sZaGmaLZ/F7KunH/cUTs8jAew0xosUweReTSoKV5LuZdwgzVk2NRfxzgtCoMTQpRdWB0
         yHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031542; x=1703636342;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhNrG8n3VF26CTm19xh5W8tfvZ5HxcKEmqHw5UiZ+qE=;
        b=NUC2KrsxobsLmEzdRkVECPiAakKgtsuZ6+TCJ7o6BbDU7wkmlsomIsI6qoVF5x9ZR6
         4b+F+cRPAOHl2/XBUMbDpbZQeQHTKgvm9xoLOcvzaWCXvWsiuCrpKcYGhBIvMMxQPJQI
         oDcMVd6x2DwvpF1TssaCbIuXAQ+yAgFphS//XgYIALdUFuZ2W+/Fk+ZvGceMyn7dGClV
         RWg5s3zoTww1/9p+RESjJTa39Ffu1lmdXXhRz3shWEIPq4ntq0GY7gO1Y1crfWMiFBj6
         UY+KQoE0PLaAOWG49Z0VwxqRYYXO7MokYn7DImHBr+lXihNQowRkw5aMVJpQROyS6WsH
         vwrg==
X-Gm-Message-State: AOJu0YxChNLXpR8J1rkzr1VFzHOFbX5PvqaVcusC79vTdxpgwREBFSGr
	6uJDTzWfUz9MB9AWvmfAYVNKAEj82pXAAqEbMMfGMSI2n+qSLW/eHp9CrA0o6V0ZAKPq5Dhmsj5
	/Zg2JLrxS9Dsp+rvzZFR9ne7N6+E1e4AI9L0ahiDbO5uk1l8aza7FEHI/46ZVjhHL0zYV/DzFYK
	qTnw==
X-Google-Smtp-Source: AGHT+IFsoI7LOTHrX6N6qYu5e057shT4gXbzDqz+XVIB7kCLBHY6kDbog5Qr5Dbjs407q6KmrflFseKZPqBm
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:594f:0:b0:5b9:aea9:17c2 with SMTP id
 j15-20020a63594f000000b005b9aea917c2mr13349pgm.4.1703031541837; Tue, 19 Dec
 2023 16:19:01 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-1-jstultz@google.com>
Subject: [PATCH v7 00/23] Proxy Execution: A generalized form of Priority
 Inheritance v7
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looking for patches to review before closing out the year?
Have I got something for you! :)

Since sending v6 out and after my presentation at Linux
Plumbers[1], I got some nice feedback from a number of
developers. I particularly want to thank Metin Kaya, who provided
a ton of detailed off-list review comments, questions and cleanup
suggestions. Additionally Xuewen Yan, who pointed out an issue
with placement in my return migration logic that motivated me to
rework the return migration back into the ttwu path. This helped
to resolve the performance regression I had been seeing from the
v4->v5 rework!=20

The other focus of this revision has been to properly
conditionalize and re-integrate the chain-migration feature that
Connor had implemented to address concerns about the preserving
the RT load balancing invariant (always running top N priority
tasks across N available cpus) when we=E2=80=99re migrating tasks around
for proxy-execution. I=E2=80=99ve done a fair amount of reworking the
patches, but they aren=E2=80=99t quite yet to where I=E2=80=99d like them, =
but
I=E2=80=99ve included them here which you can consider as a preview.

Validating this invariant isn=E2=80=99t trivial. Long ago I wrote a
userland test case that=E2=80=99s now in LTP to check this called
sched_football:
  https://github.com/linux-test-project/ltp/blob/master/testcases/realtime/=
func/sched_football/sched_football.c

So I=E2=80=99ve reimplemented this idea as an in-kernel test case,
extended to have lock chains across priority levels. The good
news is that the test case does not show any issues with RT load
balancing invariant when we add the chain-migration feature, but
I=E2=80=99m not actually seeing any issues with the test when
chain-migration isn=E2=80=99t added either, so I need to further extend
the test to try to manufacture the specific type of invariant
breakage I can imagine we don=E2=80=99t handle properly:
ie:
  CPU0: P99, P98(boP2), P2
  CPU1: P50

Which chain-migration should adjust to become:
  CPU0: P99
  CPU1: P98(boP2), P50, P2

On the stability front, the series has continued to fare much
better than pre-v6 patches. The only stability issue I had seen
with v6 (workqueue lockups when stressing under 64 core qemu
environment with KVM disabled) has so far not reproduced against
6.7-rc. At plumbers Thomas mentioned there had been a workqueue
issue in 6.6 that was since fixed, so I=E2=80=99m optimistic that was
what I was tripping on. If you run into any stability issues in
testing, please do let me know.

This patch series is actually coarser than what I=E2=80=99ve been
developing with, as there are a number of small =E2=80=9Ctest=E2=80=9D step=
s to
help validate behavior I changed, which would then be replaced by
the real logic afterwards. Including those here would just cause
more work for reviewers, so I=E2=80=99ve folded them together, but if
you=E2=80=99re interested you can find the fine-grained tree here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc=
6-fine-grained
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v7-6.7-rc6-fi=
ne-grained

Credit/Disclaimer:
=E2=80=94--------------------
As mentioned previously, this Proxy Execution series has a long
history:=20

First described in a paper[2] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

Overview:
=E2=80=94----------
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

The complexity from these edge cases are imposing, but currently
in Android we have a large number of cases where we are seeing
priority inversion (not unbounded, but much longer than we=E2=80=99d
like) between =E2=80=9Cforeground=E2=80=9D and =E2=80=9Cbackground=E2=80=9D=
 SCHED_NORMAL
applications. As a result, currently we cannot usefully limit
background activity without introducing inconsistent behavior. So
Proxy Execution is a very attractive approach to resolving this
critical issue.

New in v7:
---------
* Extended blocked_on state tracking to use a tri-state so we
  can avoid running tasks before they are return-migrated.

* Switched return migration back to the ttwu path to avoid extra
  lock handling and resolve performance regression seen since v5

* _Tons_ of typos, cleanups, runtime conditionalization
  improvements, build fixes for different config options, and
  clarifications suggested by Metin Kaya. *Many* *many* thanks
  for all the review and help here!

* Split up and reworked Connor=E2=80=99s chain-migration patches to be
  properly conditionalized on the config value, and hopefully a
  little easier to review.

* Added first stab at RT load-balancing invariant test
  (sched_football)

* Fixed wake_cpu not being preserved during
  activate_blocked_entities

* Fix build warnings Reported-by: kernel test robot <lkp@intel.com>

* Other minor cleanups

Performance:
=E2=80=94----------
v7 of the series improves over v6 and v5 by moving proxy return
migration back into the ttwu path, which avoids a lot of extra
locking. This gets performance back to where we were in v4.

K Prateek Nayak did some benchmarking and performance analysis
with the v6 series and while he noted with a number of benchmarks
(schbench, tbench, netperf, ycsb-mongodb, DeathStarBench) he
found =E2=80=9Clittle to no difference=E2=80=9D when running with
proxy-execution[3], he did find a large regression with the
=E2=80=9Cperf bench sched messaging=E2=80=9D test.

I=E2=80=99ve reproduced this issue and the majority of the regression
seems to come from the fact this patch series switches mutexes to
use handoff mode rather than optimistic spinning. This has been a
concern for cases where locks are under high contention, so I
need to spend some time on finding a solution to restore some
ability for optimistic spinning. Many thanks to Preteek for
raising this issue!

Previously Chenyu also report a regression[4], which seems
similar, but I need to look further into it.

Issues still to address:
=E2=80=94----------
* The chain migration patches still need further iterations and
  better validation to ensure they resolve the RT/DL load
  balancing invariants.

* Xuewen Yan earlier pointed out that we may see task
  mis-placement on EAS systems if we do return migration based
  strictly on cpu allowability. I tried an optimization to
  always try to return migrate to the wake_cpu (which was saved
  on proxy-migration), but this seemed to undo a chunk of the
  benefit I saw in moving return migration back to ttwu, at
  least with my prio-inversion-demo microbenchmark. Need to do
  some broader performance analysis with the variations there.

* Optimization to avoid migrating blocked tasks (to preserve
  optimistic mutex spinning) if the runnable lock-owner at the
  end of the blocked_on chain is already running (though this is
  difficult due to the limitations from locking rules needed to
  traverse the blocked on chain across run queues).

* Similarly as we=E2=80=99re often dealing with lists of tasks or chains
  of tasks and mutexes, iterating across these chains of objects
  can be done safely while holding the rq lock, but as these
  chains can cross runqueues our ability to traverse the chains
  safely is somewhat limited.=20

* CFS load balancing. Blocked tasks may carry forward load
  (PELT) to the lock owner's CPU, so CPU may look like it is
  overloaded.

* The sleeping owner handling (where we deactivate waiting tasks
  and enqueue them onto a list, then reactivate them when the
  owner wakes up) doesn=E2=80=99t feel great. This is in part because
  when we want to activate tasks, we=E2=80=99re already holding a
  task.pi_lock and a rq_lock, just not the locks for the task
  we=E2=80=99re activating, nor the rq we=E2=80=99re enqueuing it onto. So =
there
  has to be a bit of lock juggling to drop and acquire the right
  locks (in the right order). It feels like there=E2=80=99s got to be a
  better way.

* =E2=80=9Crq_selected()=E2=80=9D naming. Peter doesn=E2=80=99t like it, bu=
t I=E2=80=99ve not
  thought of a better name. Open to suggestions.

* As discussed at OSPM[5], I like to split pick_next_task() up
  into two phases selecting and setting the next tasks, as
  currently pick_next_task() assumes the returned task will be
  run which results in various side-effects in sched class logic
  when it=E2=80=99s run. I tried to take a pass at this earlier, but
  it=E2=80=99s hairy and lower on the priority list for now.


If folks find it easier to test/tinker with, this patch series
can also be found here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc=
6
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v7-6.7-rc6

Feedback would be very welcome!

Thanks so much!
-john

[1] https://lwn.net/Articles/953438/
[2] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
[3] https://lore.kernel.org/lkml/c6787831-f659-12cb-4954-fd13a05ed590@amd.c=
om/
[4] https://lore.kernel.org/lkml/Y7vVqE0M%2FAoDoVbj@chenyu5-mobl1/
[5] https://youtu.be/QEWqRhVS3lI (video of my OSPM talk)


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
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com

Connor O'Brien (5):
  sched: Add push_task_chain helper
  sched: Consolidate pick_*_task to task_is_pushable helper
  sched: Push execution and scheduler context split into deadline and rt
    paths
  sched: Add find_exec_ctx helper
  sched: Fix rt/dl load balancing via chain level balance

John Stultz (8):
  locking/mutex: Remove wakeups from under mutex::wait_lock
  sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable
  sched: Fix runtime accounting w/ split exec & sched contexts
  sched: Split out __sched() deactivate task logic into a helper
  sched: Add a initial sketch of the find_proxy_task() function
  sched: Handle blocked-waiter migration (and return migration)
  sched: Initial sched_football test implementation
  sched: Refactor dl/rt find_lowest/latest_rq logic

Juri Lelli (2):
  locking/mutex: Make mutex::wait_lock irq safe
  locking/mutex: Expose __mutex_owner()

Peter Zijlstra (7):
  sched: Unify runtime accounting across classes
  locking/mutex: Rework task_struct::blocked_on
  locking/mutex: Switch to mutex handoffs for CONFIG_SCHED_PROXY_EXEC
  sched: Split scheduler and execution contexts
  sched: Start blocked_on chain processing in find_proxy_task()
  sched: Add blocked_donor link to task for smarter mutex handoffs
  sched: Add deactivated (sleeping) owner handling to find_proxy_task()

Valentin Schneider (1):
  sched: Fix proxy/current (push,pull)ability

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/locking/mutex-design.rst        |   3 +
 include/linux/sched.h                         |  59 +-
 init/Kconfig                                  |   7 +
 init/init_task.c                              |   1 +
 kernel/fork.c                                 |   9 +-
 kernel/locking/mutex-debug.c                  |   9 +-
 kernel/locking/mutex.c                        | 166 ++--
 kernel/locking/mutex.h                        |  25 +
 kernel/locking/rtmutex.c                      |  26 +-
 kernel/locking/rwbase_rt.c                    |   4 +-
 kernel/locking/rwsem.c                        |   4 +-
 kernel/locking/spinlock_rt.c                  |   3 +-
 kernel/locking/ww_mutex.h                     |  73 +-
 kernel/sched/Makefile                         |   1 +
 kernel/sched/core.c                           | 822 ++++++++++++++++--
 kernel/sched/cpudeadline.c                    |  12 +-
 kernel/sched/cpudeadline.h                    |   3 +-
 kernel/sched/cpupri.c                         |  31 +-
 kernel/sched/cpupri.h                         |   6 +-
 kernel/sched/deadline.c                       | 218 +++--
 kernel/sched/fair.c                           | 102 ++-
 kernel/sched/rt.c                             | 298 +++++--
 kernel/sched/sched.h                          | 105 ++-
 kernel/sched/stop_task.c                      |  13 +-
 kernel/sched/test_sched_football.c            | 242 ++++++
 lib/Kconfig.debug                             |  14 +
 27 files changed, 1861 insertions(+), 400 deletions(-)
 create mode 100644 kernel/sched/test_sched_football.c

--=20
2.43.0.472.g3155946c3a-goog


