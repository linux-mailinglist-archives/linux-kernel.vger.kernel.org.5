Return-Path: <linux-kernel+bounces-106261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A266287EB96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300501F218BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70034EB4C;
	Mon, 18 Mar 2024 15:06:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DD4EB43
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774359; cv=none; b=KnXUavRZh2KjUbJLqlgiwu3SkNqvDJw/tDc9zaZPAPTbSg37QfzC27EcHT7Ttq1fkDvTsjfRAx9UWZHOBMs7hOsb3xE3ACinsBjjxg+4AFr98SBPBRvYuCwPWK02GautjMT9789Ay2n15dJx4l842E+NdhO3Luul+BNhTRwJJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774359; c=relaxed/simple;
	bh=48mtGlB6ztTVFt33WXCT9VAnnho2o+apXjLK1wB+q5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0j1HPxcY7tpmewYoKIZuempuMGLBlnymZBjmMv+YFo2lKsmgII0vEQTOkSb6i9FEfXWCjnAXfwi1XuHB5+VdfIPEvtyeusUVcAotUTHmrqd0cMLpUHjW3Rh2rpAo+EKSmX4qh0pCRApj4HWb4KseAd9daR2KQI9vyMsH6ToZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67FC5DA7;
	Mon, 18 Mar 2024 08:06:31 -0700 (PDT)
Received: from [10.57.95.135] (unknown [10.57.95.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1D653F67D;
	Mon, 18 Mar 2024 08:05:50 -0700 (PDT)
Message-ID: <e2c4631a-2344-427a-9e8e-123b979c433d@arm.com>
Date: Mon, 18 Mar 2024 15:05:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] Preparatory changes for Proxy Execution v9
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
References: <20240315044007.2778856-1-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240315044007.2778856-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/03/2024 4:39 am, John Stultz wrote:
> As mentioned last time[1], after previous submissions of the
> Proxy Execution series, I got feedback that the patch series was
> getting a bit unwieldy to review, and Qais suggested I break out
> just the cleanups/preparatory components of the patch series and
> submit them on their own in the hope we can start to merge the
> less complex bits and discussion can focus on the more
> complicated portions afterwards. This so far has not been very
> successful, with the submission & RESEND of the v8 preparatory
> changes not getting much in the way of review.
> 
> Nonetheless, for v9 of this series, I’m again only submitting
> those early cleanup/preparatory changes here (which have not
> changed since the v8 submissions, but to avoid confusion with the
> git branch names, I’m labeling it as v9). In the meantime, I’ve
> continued to put a lot of effort into the full series, mostly
> focused on polishing the series for correctness, and fixing some
> hard to trip races.
> 
> If you are interested, the full v9 series, it can be found here:
>    https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v9-6.8
>    https://github.com/johnstultz-work/linux-dev.git proxy-exec-v9-6.8
> 
> 
> New in v9:
> (In the git tree. Again, none of the preparatory patches
> submitted here have changed since v8)
> ---------
> * Change to force mutex lock handoff when we have a blocked donor
>    (preserves optimistic spinning elsewhere, but still prioritizes
>    donor when present on unlock)
> 
> * Do return migration whenever we’re not on the wake_cpu (should
>    address placement concerns brought up earlier by Xuewen Yan)
> 
> * Closed hole where we might mark a task as BO_RUNNABLE without
>    doing return migration
> 
> * Much improved handling of balance callbacks when we need to
>    pick_again
> 
> * Fixes for cases where we put_prev_task() but left a dangling
>    pointer to rq_selected() when deactivating a task (as it could
>    then be migrated away while we still have a reference to it),
>    by selecting idle before deactivating next.
> 
> * Fixes for dangling references to rq->curr (which had been
>    put_prev_task’ed)  when we drop rq lock for proxy_migration
> 
> * Fixes for ttwu / find_proxy_task() races if the lock owner was
>    being return migrated, and ttwu hadn’t yet set_task_cpu() and
>    activated it, which allowed that task to be scheduled on two
>    cpus at the same time.
> 
> * Fix for live-lock between activate_blocked_tasks() and
>    proxy_enqueue_on_owner() if activated owner went right back to
>    sleep (which also simplifies the locking in
>    activate_blocked_tasks())
> 
> * Cleanups to avoid locked BO_WAKING->BO_RUNNABLE transition in
>    try_to_wake_up() if proxy execution isn't enabled
> 
> * Fix for psi_dequeue, as proxy changes assumptions around
>    voluntary sleeps.
> 
> * Numerous typos, comment improvements, and other fixups
>    suggested by Metin
> 
> * And more!
> 
> 
> Performance:
> ---------
> K Prateek Nayak provided some feedback on the v8 series here[2].
> Given the potential extra overhead of doing rq migrations/return
> migrations/etc for the proxy case, it’s not completely surprising
> a few of K Prateek’s test cases saw ~3-5% regressions, but I’m
> hoping to look into this soon to see if we can reduce those
> further. The donor mutex handoff in this revision may help some.
> 
> 
> Issues still to address:
> ---------
> * The chain migration functionality needs further iterations and
>    better validation to ensure it truly maintains the RT/DL load
>    balancing invariants.
> 
> * CFS load balancing. There was concern that blocked tasks may
>    carry forward load (PELT) to the lock owner's CPU, so the CPU
>    may look like it is overloaded. Needs investigation.
> 
> * The sleeping owner handling (where we deactivate waiting tasks
>    and enqueue them onto a list, then reactivate them when the
>    owner wakes up) doesn’t feel great. This is in part because
>    when we want to activate tasks, we’re already holding a
>    task.pi_lock and a rq_lock, just not the locks for the task
>    we’re activating, nor the rq we’re enqueuing it onto. So there
>    has to be a bit of lock juggling to drop and acquire the right
>    locks (in the right order). It feels like there’s got to be a
>    better way. Also needs some rework to get rid of the recursion.
> 
> 
> Credit/Disclaimer:
> —--------------------
> As mentioned previously, this Proxy Execution series has a long
> history: First described in a paper[3] by Watkins, Straub,
> Niehaus, then from patches from Peter Zijlstra, extended with
> lots of work by Juri Lelli, Valentin Schneider, and Connor
> O'Brien. (and thank you to Steven Rostedt for providing
> additional details here!)
> 
> So again, many thanks to those above, as all the credit for this
> series really is due to them - while the mistakes are likely
> mine.
> 
> Thanks so much!
> -john
> 
> [1] https://lore.kernel.org/lkml/20240224001153.2584030-1-jstultz@google.com/
> [2] https://lore.kernel.org/lkml/c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com/
> [3] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
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
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> 
> 
> Connor O'Brien (2):
>    sched: Add do_push_task helper
>    sched: Consolidate pick_*_task to task_is_pushable helper
> 
> John Stultz (1):
>    sched: Split out __schedule() deactivate task logic into a helper
> 
> Juri Lelli (2):
>    locking/mutex: Make mutex::wait_lock irq safe
>    locking/mutex: Expose __mutex_owner()
> 
> Peter Zijlstra (2):
>    locking/mutex: Remove wakeups from under mutex::wait_lock
>    sched: Split scheduler and execution contexts
> 
>   kernel/locking/mutex.c       |  60 +++++++----------
>   kernel/locking/mutex.h       |  25 +++++++
>   kernel/locking/rtmutex.c     |  26 +++++---
>   kernel/locking/rwbase_rt.c   |   4 +-
>   kernel/locking/rwsem.c       |   4 +-
>   kernel/locking/spinlock_rt.c |   3 +-
>   kernel/locking/ww_mutex.h    |  49 ++++++++------
>   kernel/sched/core.c          | 122 +++++++++++++++++++++--------------
>   kernel/sched/deadline.c      |  53 ++++++---------
>   kernel/sched/fair.c          |  18 +++---
>   kernel/sched/rt.c            |  59 +++++++----------
>   kernel/sched/sched.h         |  44 ++++++++++++-
>   12 files changed, 268 insertions(+), 199 deletions(-)
> 

I could cleanly apply this patch series to `linux-next/next-20240318` 
branch.

Here is checkpatch report:
```
$ ./scripts/checkpatch.pl -g 6aa2a9e7aea6d..HEAD 
 
 

--------------------------------------------------------------------- 
 
 

Commit a9124906b27f ("locking/mutex: Make mutex::wait_lock irq safe") 
 
 

---------------------------------------------------------------------
total: 0 errors, 0 warnings, 128 lines checked

Commit a9124906b27f ("locking/mutex: Make mutex::wait_lock irq safe") 
has no obvious style problems and is ready for submission.
-------------------------------------------------------------
Commit c3b81eb4858a ("locking/mutex: Expose __mutex_owner()")
-------------------------------------------------------------
WARNING: Possible repeated word: 'at'
#91: FILE: kernel/locking/mutex.h:26:
+ * NULL means not owned. Since task_struct pointers are aligned at
+ * at least L1_CACHE_BYTES, we have low bits to store extra state.

total: 0 errors, 1 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

Commit c3b81eb4858a ("locking/mutex: Expose __mutex_owner()") has style 
problems, please review.
------------------------------------------------------
Commit 6adb713bd389 ("sched: Add do_push_task helper")
------------------------------------------------------
total: 0 errors, 0 warnings, 64 lines checked

Commit 6adb713bd389 ("sched: Add do_push_task helper") has no obvious 
style problems and is ready for submission.
---------------------------------------------------------------------------------
Commit 037345d6896a ("sched: Consolidate pick_*_task to task_is_pushable 
helper")
---------------------------------------------------------------------------------
total: 0 errors, 0 warnings, 61 lines checked

Commit 037345d6896a ("sched: Consolidate pick_*_task to task_is_pushable 
helper") has no obvious style problems and is ready for submission.
-----------------------------------------------------------------------------------------
Commit 6c9aa2fd15de ("sched: Split out __schedule() deactivate task 
logic into a helper")
-----------------------------------------------------------------------------------------
total: 0 errors, 0 warnings, 84 lines checked

Commit 6c9aa2fd15de ("sched: Split out __schedule() deactivate task 
logic into a helper") has no obvious style problems and is ready for 
submission.
---------------------------------------------------------------------
Commit 6af85d44be35 ("sched: Split scheduler and execution contexts")
---------------------------------------------------------------------
WARNING: Duplicate signature
#46:
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

WARNING: Do not crash the kernel unless it is absolutely 
unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead 
of BUG() or variants
#557: FILE: kernel/sched/rt.c:1979:
+       BUG_ON(task_current_selected(rq, p));

total: 0 errors, 2 warnings, 539 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

Commit 6af85d44be35 ("sched: Split scheduler and execution contexts") 
has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
```

I think only the duplicate signature warning is a real problem and will 
reply to the offending mail.

Issued `make defconfig` on a x86_64 machine, enabled lock & RCU 
debugging config options and built the kernel.

Then, ran commands below on a QEMU Debian guest (arch=x86_64, cores=32, 
threads=2, memory=2GiB) before and after this patch series:
```
$ insmod torture.ko && insmod scftorture.ko verbose=1 onoff_holdoff=5 
onoff_interval=1; sleep 60; rmmod scftorture torture
$ insmod torture.ko random_shuffle=1 && insmod locktorture.ko 
torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3 
writer_fifo=1; sleep 60; rmmod locktorture torture
$ taskset -c 0-31,32-63 perf bench sched messaging -p -t -l 100000 -g 2
$ perf bench sched pipe -l 100000 -T
```

Logs before this patch series:
```
$ insmod torture.ko && insmod scftorture.ko verbose=1 onoff_holdoff=5 
onoff_interval=1; sleep 60; rmmod scftorture torture
[   35.912508] torture module --- scftorture:  disable_onoff_at_boot=0 
ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 
verbose_sleep_duration=1 random_shuffle=0
[   35.914627] scftorture: --- Start of test:  verbose=1 holdoff=0 
longwait=0 nthreads=-1 onoff_holdoff=5 onoff_interval=1 shutdown_secs=0 
stat_interval=60 stutter=5 use_cpus_read_lock=0, weight_resched=-1, 
weight_single=-1, weight_single_rpc=-1, weight_single_wait=-1, weight_many1
[   35.918824] scftorture: !!! built as module, weight_resched ignored
[   35.919842] scf_sel_dump:  32.820 smp_call_function_single(nowait)
[   35.921035] scf_sel_dump:  32.820 smp_call_function_single_rpc(wait)
[   35.922183] scf_sel_dump:  32.820 smp_call_function_single(wait)
[   35.923334] scf_sel_dump:   0.512 smp_call_function_many(nowait)
[   35.924372] scf_sel_dump:   0.512 smp_call_function_many(wait)
[   35.925410] scf_sel_dump:   0.256 smp_call_function(nowait)
[   35.926398] scf_sel_dump:   0.256 smp_call_function(wait)
[   35.927373] scftorture-torture: Creating torture_onoff task
[   35.928665] scftorture-torture: torture_onoff task started
[   35.928677] scftorture-torture: Creating torture_stutter task
[   35.929696] scftorture-torture: torture_onoff begin holdoff
[   35.930902] scftorture: Starting 64 smp_call_function() threads
[   35.930904] scftorture-torture: torture_stutter task started
[   35.933755] scftorture-torture: Creating scftorture_invoker task
[   35.934966] scftorture-torture: Creating scftorture_invoker task
[   35.934980] scftorture: scftorture_invoker 0: task started
..
[   99.689799] scftorture:  scf_invoked_count VER: 87177502 resched: 0 
single: 28726722/28492519 single_ofl: 13877596/13766523 single_rpc: 
28492768 single_rpc_ofl: 0 many: 445547/446215 all: 221861/223143 onoff: 
1527/1527:1559/1559 14,74:8,642 23749:29438 (HZ=1000) ste: 0 stnmie: 0
[   99.694023] scftorture: --- End of test: SUCCESS:  verbose=1 
holdoff=0 longwait=0 nthreads=64 onoff_holdoff=5 onoff_interval=1 
shutdown_secs=0 stat_interval=60 stutter=5 use_cpus_read_lock=0, 
weight_resched=-1, weight_single=-1, weight_single_rpc=-1, 
weight_single_wait=-1, weig1

$ insmod torture.ko random_shuffle=1 && insmod locktorture.ko 
torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3 
writer_fifo=1; sleep 60; rmmod locktorture torture
[  114.543156] torture module --- mutex_lock:  disable_onoff_at_boot=0 
ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 
verbose_sleep_duration=1 random_shuffle=1
[  114.545291] mutex_lock-torture:--- Start of test [debug]: 
acq_writer_lim=0 bind_readers=0-63 bind_writers=0-63 call_rcu_chains=0 
long_hold=100 nested_locks=3 nreaders_stress=0 nwriters_stress=128 
onoff_holdoff=0 onoff_interval=0 rt_boost=1 rt_boost_factor=50 
shuffle_interval=3 1
[  114.549640] mutex_lock-torture: Creating torture_shuffle task
[  114.550880] mutex_lock-torture: Creating torture_stutter task
[  114.550905] mutex_lock-torture: torture_shuffle task started
[  114.552006] mutex_lock-torture: Creating lock_torture_writer task
[  114.552021] mutex_lock-torture: torture_stutter task started
..
[  177.883162] mutex_lock-torture: Stopping lock_torture_stats task
[  177.884249] Writes:  Total: 72982638  Max/Min: 748221/404806   Fail: 0
[  177.885483] mutex_lock-torture: lock_torture_stats is stopping
[  177.886516] Writes:  Total: 72982638  Max/Min: 748221/404806   Fail: 0
[  177.887630] mutex_lock-torture:--- End of test: SUCCESS [debug]: 
acq_writer_lim=0 bind_readers=0-63 bind_writers=0-63 call_rcu_chains=0 
long_hold=100 nested_locks=3 nreaders_stress=0 nwriters_stress=128 
onoff_holdoff=0 onoff_interval=0 rt_boost=1 rt_boost_factor=50 shuffle_inte1

$ taskset -c 0-31,32-63 perf bench sched messaging -p -t -l 100000 -g 2
# Running 'sched/messaging' benchmark:0-31,32-63 perf bench sched 
messaging -p -t -l 100000 -g 2
# 20 sender and receiver threads per group
# 2 groups == 80 threads run

      Total time: 13.835 [sec]

$ perf bench sched pipe -l 100000 -T
# Running 'sched/pipe' benchmark:
# Executed 100000 pipe operations between two threads

      Total time: 2.772 [sec]

       27.725990 usecs/op
           36067 ops/sec
```

Logs after applying this patch series:
```
$ insmod torture.ko && insmod scftorture.ko verbose=1 onoff_holdoff=5 
onoff_interval=1; sleep 60; rmmod scftorture torture
[   17.840768] torture module --- scftorture:  disable_onoff_at_boot=0 
ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 
verbose_sleep_duration=1 random_shuffle=0
[   17.842941] scftorture: --- Start of test:  verbose=1 holdoff=0 
longwait=0 nthreads=-1 onoff_holdoff=5 onoff_interval=1 shutdown_secs=0 
stat_interval=60 stutter=5 use_cpus_read_lock=0, weight_resched=-1, 
weight_single=-1, weight_single_rpc=-1, weight_single_wait=-1, weight_many1
[   17.847211] scftorture: !!! built as module, weight_resched ignored
[   17.848135] scf_sel_dump:  32.820 smp_call_function_single(nowait)
[   17.849230] scf_sel_dump:  32.820 smp_call_function_single_rpc(wait)
[   17.850475] scf_sel_dump:  32.820 smp_call_function_single(wait)
[   17.851523] scf_sel_dump:   0.512 smp_call_function_many(nowait)
[   17.852559] scf_sel_dump:   0.512 smp_call_function_many(wait)
[   17.853602] scf_sel_dump:   0.256 smp_call_function(nowait)
[   17.854541] scf_sel_dump:   0.256 smp_call_function(wait)
[   17.855490] scftorture-torture: Creating torture_onoff task
[   17.856673] scftorture-torture: torture_onoff task started
[   17.856694] scftorture-torture: Creating torture_stutter task
[   17.857701] scftorture-torture: torture_onoff begin holdoff
[   17.859816] scftorture: Starting 64 smp_call_function() threads
[   17.859816] scftorture-torture: torture_stutter task started
[   17.860839] scftorture-torture: Creating scftorture_invoker task
[   17.860930] scftorture-torture: Creating scftorture_invoker task
[   17.860940] scftorture: scftorture_invoker 0: task started
..
[   78.914652] scftorture:  scf_invoked_count VER: 86855271 resched: 0 
single: 27751906/27523464 single_ofl: 12966034/12854343 single_rpc: 
27530433 single_rpc_ofl: 0 many: 430178/430527 all: 215119/214473 onoff: 
1441/1441:1474/1474 14,268:8,177 22685:28034 (HZ=1000) ste: 0 stnmie:0
[   78.919133] scftorture: --- End of test: SUCCESS:  verbose=1 
holdoff=0 longwait=0 nthreads=64 onoff_holdoff=5 onoff_interval=1 
shutdown_secs=0 stat_interval=60 stutter=5 use_cpus_read_lock=0, 
weight_resched=-1, weight_single=-1, weight_single_rpc=-1, 
weight_single_wait=-1, weig1

$ insmod torture.ko random_shuffle=1 && insmod locktorture.ko 
torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3 
writer_fifo=1; sleep 60; rmmod locktorture torture
[   83.340115] torture module --- mutex_lock:  disable_onoff_at_boot=0 
ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 
verbose_sleep_duration=1 random_shuffle=1
[   83.342142] mutex_lock-torture:--- Start of test [debug]: 
acq_writer_lim=0 bind_readers=0-63 bind_writers=0-63 call_rcu_chains=0 
long_hold=100 nested_locks=3 nreaders_stress=0 nwriters_stress=128 
onoff_holdoff=0 onoff_interval=0 rt_boost=1 rt_boost_factor=50 
shuffle_interval=3 1
[   83.346306] mutex_lock-torture: Creating torture_shuffle task
[   83.347383] mutex_lock-torture: Creating torture_stutter task
[   83.347395] mutex_lock-torture: torture_shuffle task started
[   83.348549] mutex_lock-torture: Creating lock_torture_writer task
[   83.348555] mutex_lock-torture: torture_stutter task started
..
[  146.611980] mutex_lock-torture: Stopping lock_torture_stats task
[  146.613012] Writes:  Total: 75575274  Max/Min: 1085187/396665 ??? 
Fail: 0
[  146.614183] mutex_lock-torture: lock_torture_stats is stopping
[  146.615160] Writes:  Total: 75575274  Max/Min: 1085187/396665 ??? 
Fail: 0
[  146.616273] mutex_lock-torture:--- End of test: SUCCESS [debug]: 
acq_writer_lim=0 bind_readers=0-63 bind_writers=0-63 call_rcu_chains=0 
long_hold=100 nested_locks=3 nreaders_stress=0 nwriters_stress=128 
onoff_holdoff=0 onoff_interval=0 rt_boost=1 rt_boost_factor=50 shuffle_inte1

$ taskset -c 0-31,32-63 perf bench sched messaging -p -t -l 100000 -g 2
# Running 'sched/messaging' benchmark:0-31,32-63 perf bench sched 
messaging -p -t -l 100000 -g 2
# 20 sender and receiver threads per group
# 2 groups == 80 threads run

      Total time: 13.548 [sec]

$ perf bench sched pipe -l 100000 -T
# Running 'sched/pipe' benchmark:
# Executed 100000 pipe operations between two threads

      Total time: 2.350 [sec]

       23.503460 usecs/op
           42546 ops/sec
```

Looks like there are slight differences (both improvements and 
regressions) before & after this patch series. I believe they should be 
ignored since I ran the test only few times and it's just a virtual machine.

I also ported commits in 
https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v9-6.8 
to an Android v6.1 kernel and tested on my Pixel 6.

In conclusion, I'm happy to give my:
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>

Thanks,

