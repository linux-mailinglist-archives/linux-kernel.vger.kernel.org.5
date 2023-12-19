Return-Path: <linux-kernel+bounces-5831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E4818FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681051F242BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E245381CD;
	Tue, 19 Dec 2023 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+40MOwN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A5381A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso439057a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703011789; x=1703616589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+abm1CynZqwmxdSAGvYXoKA0cxWZeSaorK2glu/eE0=;
        b=y+40MOwNpsOz4FA9GEh67gDe4E42iFyh8TpZXWNMz7/HN1AnyxYlqylWcSWbYBzNpU
         bIVcDbw/H8hNFhQjQnQ+Q5F9uDPwlCPrzY7P0Pn+VmUx/q79XZPv6eclD6CXxASabjdZ
         33iDQNasS9yj8gh+WMX7sNkUhihjpSAECSrExInWhZOsa7BaP1DaTB1Bd/Ny6Tj/4U7N
         bPaQNNVVXLUi5tF+pG8CfF7BB7aLvZUrTjjD5KyheO6l5w3N7M4Xp4Mke8JRv01p82Rq
         HTr/4NUzq5OprpALsW/N7aymfspz2rJh7tX3comsVQzzBZeOak58WZ0/Sxm8j+RdVsQM
         905g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011789; x=1703616589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+abm1CynZqwmxdSAGvYXoKA0cxWZeSaorK2glu/eE0=;
        b=ja+pT1Tai5d286pLbdzQ/F1EEOtWGGCa2KL8enD5Tcdos/GWbfTMoTUL/XnYHiC1sD
         5WOvcA2hfdCulvsolQojl5HB9/BU0b4bJfvTpFnDLdnz3kvJPIl+NxvVEc9EBl1CU3Ef
         DTrjzeO3TU2bA8ak1pBVQcAz9wKVKc4o4a2ilnvj/rmcHkGN7iRb8d/h5AbSBDP/kSbb
         YF/fg/uA9zg/ZjbrDsm262a8lXxBjy5+gGz+s6TGo9EsApLJ/767YJa/tRsmLA6Dxnll
         OSHbWzz4vjpV21KcdETUc1WGpwxnCSCfEPwR1dsiESlrzp9AOVMbqdqAHEKmefoU1ds1
         GgEQ==
X-Gm-Message-State: AOJu0YxGXzfp9teDu8Bl2ANhPDzMJ1c90SFPoBtHyXAnm3C/G6ckOkvK
	M3LR6kKi/OYVuYYtWB8YlgeHlvIZ13Aznf5FftBeFA==
X-Google-Smtp-Source: AGHT+IG94A6aZIp2lHe8Rhylp3swtSETnFmS34m6DHnbk6A3D3oDNGFz6W8PN+rO6yj2D8gUBkemcYisi1A0t8fToz8=
X-Received: by 2002:a17:90a:db0c:b0:28b:4010:1df7 with SMTP id
 g12-20020a17090adb0c00b0028b40101df7mr2403370pjv.74.1703011788834; Tue, 19
 Dec 2023 10:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
 <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
 <d8507f86-2458-4b01-a774-5102473e657e@oracle.com> <1c13b0cc-098c-4f75-9f37-a53a66965409@oracle.com>
In-Reply-To: <1c13b0cc-098c-4f75-9f37-a53a66965409@oracle.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 Dec 2023 19:49:37 +0100
Message-ID: <CAKfTPtDqqAYNCFb6US-4Yd=-xvj8mhMuO0PkUhWsqekxp__M4g@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there are
 no running tasks.
To: Imran Khan <imran.f.khan@oracle.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Imram,

On Tue, 19 Dec 2023 at 07:42, Imran Khan <imran.f.khan@oracle.com> wrote:
>
> Hello Vincent,
>
>
> On 15/12/2023 8:59 pm, Imran Khan wrote:
> > Hello Vincent,
> > Thanks a lot for having a look and getting back.
> >
> > On 15/12/2023 7:11 pm, Vincent Guittot wrote:
> >> On Fri, 15 Dec 2023 at 06:27, Imran Khan <imran.f.khan@oracle.com> wrote:
> >>>
> >>> It has been found that sometimes a task_group has some residual
> >>> load_avg even though the load average at each of its owned queues
> >>> i.e task_group.cfs_rq[cpu].avg.load_avg and task_group.cfs_rq[cpu].
> >>> tg_load_avg_contrib have become 0 for a long time.
> >>> Under this scenario if another task starts running in this task_group,
> >>> it does not get proper time share on CPU since pre-existing
> >>> load average of task group inversely impacts the new task's CPU share
> >>> on each CPU.
> >>>
> >>> This change looks for the condition when a task_group has no running
> >>> tasks and sets the task_group's load average to 0 in such cases, so
> >>> that tasks that run in future under this task_group get the CPU time
> >>> in accordance with the current load.
> >>>
> >>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> >>> ---
> >>>
> >>
> >> [...]
> >>
> >>>
> >>> 4. Now move systemd-udevd to one of these test groups, say test_group_1, and
> >>> perform scale up to 124 CPUs followed by scale down back to 4 CPUs from the
> >>> host side.
> >>
> >> Could it be the root cause of your problem ?
> >>
> >> The cfs_rq->tg_load_avg_contrib of the 120 CPUs that have been plugged
> >> then unplugged,  have not been correctly removed from tg->load_avg. If
> >> the cfs_rq->tg_load_avg_contrib of the 4 remaining CPUs is 0 then
> >> tg->load_avg should be 0 too.
> >>
> > Agree and this was my understanding as well. The issue only happens
> > with large number of CPUs. For example if I go from 4 to 8 and back to
> > 4 , the issue does not happen and even if it happens the residual load
> > avg is very little.
> >
> >> Could you track that the cfs_rq->tg_load_avg_contrib is correctly
> >> removed from tg->load_avg when you unplug the CPUs ? I can easily
> >> imagine that the rate limit can skip some update of tg- >load_avg
> >> while offlining the cpu
> >>
> >
> > I will try to trace it but just so you know this issue is happening on other
> > kernel versions (which don't have rate limit feature) as well. I started
> > with v4.14.x but have tested and found it on v5.4.x and v5.15.x as well.
> >
> I collected some debug trace to understand the missing load avg
> context better. From the traces it looks like during scale down,
> the task_group.cfs_rq[cpu].avg.load_avg is not getting updated
> properly for CPU(s) being hotplugged out.

Your traces are interesting and I think that
task_group.cfs_rq[cpu].avg.load_avg is updated correctly but we don't
call update_tg_load_avg() to reflect that in tg->load_avg.

Could you try the patch below ? It forces the scheduler to clear the
contribution of all cfs_rq of a CPU that becomes offline.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 466e01b2131f..e5da5eaab6ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4087,6 +4087,11 @@ static inline void update_tg_load_avg(struct
cfs_rq *cfs_rq)
        if (cfs_rq->tg == &root_task_group)
                return;

+
+       /* rq has been offline and doesn't contribute anymore to the share */
+       if (!cpu_active(cpu_of(rq_of(cfs_rq))))
+               return;
+
        /*
         * For migration heavy workloads, access to tg->load_avg can be
         * unbound. Limit the update rate to at most once per ms.
@@ -4103,6 +4108,48 @@ static inline void update_tg_load_avg(struct
cfs_rq *cfs_rq)
        }
 }

+static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
+{
+       long delta;
+       u64 now;
+
+       /*
+        * No need to update load_avg for root_task_group as it is not used.
+        */
+       if (cfs_rq->tg == &root_task_group)
+               return;
+
+       now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
+       delta = 0 - cfs_rq->tg_load_avg_contrib;
+       atomic_long_add(delta, &cfs_rq->tg->load_avg);
+       cfs_rq->tg_load_avg_contrib = 0;
+       cfs_rq->last_update_tg_load_avg = now;
+}
+
+/* cpu offline callback */
+static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
+{
+       struct task_group *tg;
+
+       lockdep_assert_rq_held(rq);
+
+       /*
+        * The rq clock has already been updated in the
+        * set_rq_offline(), so we should skip updating
+        * the rq clock again in unthrottle_cfs_rq().
+        */
+       rq_clock_start_loop_update(rq);
+
+       rcu_read_lock();
+       list_for_each_entry_rcu(tg, &task_groups, list) {
+               struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+               clear_tg_load_avg(cfs_rq);
+       }
+       rcu_read_unlock();
+
+       rq_clock_stop_loop_update(rq);
+}
+
 /*
  * Called within set_task_rq() right before setting a task's CPU. The
  * caller only guarantees p->pi_lock is held; no other assumptions,
@@ -12414,6 +12461,9 @@ static void rq_offline_fair(struct rq *rq)

        /* Ensure any throttled groups are reachable by pick_next_task */
        unthrottle_offline_cfs_rqs(rq);
+
+       /* Ensure that we remove rq contribution to group share */
+       clear_tg_offline_cfs_rqs(rq);
 }

 #endif /* CONFIG_SMP */


>
> For example if we look at following snippet (I have kept
> only the relevant portion of trace in the mail), we can see that,
> in the last invocation of update_tg_load_avg for task_group.cfs_rq[11]
> both the load avg and contribution of this cfs_rq were 1024.
> So delta was zero and this contribution eventually remains undeducted.
> In this case scale down was done from 16 to 8 CPUs, so CPU 11 has been
> offlined.
>
>
> cpuhp/15-131605  [015] d...  6112.350658: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=5 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 0 delta = 0 ###
>  systemd-udevd-894 [005] d...  6112.351096: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 0 delta = 1024 ###
>  systemd-udevd-894 [005] d...  6112.351165: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=5 cfs_rq->avg.load_avg = 10, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 1024 delta = 10 ###
>
> .........................
> .........................
>  cat-128667  [006] d...  6112.504633: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 3085 delta = 0 ###
> .........................
>  sh-142414  [006] d...  6112.505392: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 4041 delta = 1024 ###
> .........................
>  cat-128667  [006] d...  6112.504633: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 3085 delta = 0 ###
> ..........................
>  sh-142414  [006] d...  6112.505392: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 4041 delta = 1024 ###
> ..........................
>  systemd-run-142416  [011] d.h.  6112.506547: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 1024
>    tg->load_avg = 3010 delta = 0 ###
> ..........................
>  systemd-run-142416  [011] d.h.  6112.507546: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=11 cfs_rq->avg.load_avg = 1024, cfs_rq->tg_load_avg_contrib = 1024
>    tg->load_avg = 3010 delta = 0 ### <-- last invocation for cfs_rq[11]
>
> ..........................
> ..........................
> <idle>-0  [001] d.s.  6113.868542: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 1027 delta = 0 ###
> <idle>-0  [001] d.s.  6113.869542: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 1027 delta = 0 ###
>  <idle>-0 [001] d.s.  6113.870541: update_tg_load_avg.constprop.124:
>    cfs_of_cpu=2 cfs_rq->avg.load_avg = 0, cfs_rq->tg_load_avg_contrib = 0
>    tg->load_avg = 1027 delta = 0 ###
>
>
> If I understand correctly, when CPU 11 is offlined the task(s) on its cfs_rq
> will be migrated and its cfs_rq.avg.load_avg will be updated accordingly. This
> drop is cfs_rq.avg.load_avg will be detected by update_tg_load_avg and hence
> the contribution of this cfs_rq will get deducted from tg->load_avg.
> It looks like during hotplug load of one or more tasks, being migrated are
> not getting accounted in the source cfs_rq and this is ending up as residual
> load_avg at task_group (if these tasks are members of a task_group).
>
> Moreover this looks racy and dependent on number of CPUs or some delay.
> For example for scale down from 124 to 4 CPUs I always hit this issue but
> for scale down from 16 to 4 CPUs I hit this issue 8-9 out of 10 times.
> Also for the cases when residual load_avg at task group is low (like < 10),
> I can see that both of my test cgroups get similar CPU times which further
> proves that the unaccounted load avg ending up in a task_group is eventually
> leading to uneven CPU allotment between task groups.
>
>
> I am debugging it further but in the mean time if you have some suggestions or
> need traces from some specific portion of sched code, please let me know.
>
> Thanks,
> Imran
>
> > Thanks,
> > Imran
> >

