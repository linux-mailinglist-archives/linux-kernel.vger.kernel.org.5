Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD77CC75E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbjJQPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344297AbjJQPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:23:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44559F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:23:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d0251d305so3325165a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697556227; x=1698161027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WUNj0RuL/8OOuLQYk8Wdgn+XG/+EMCMWjBwEvhDGVQM=;
        b=Qn+v8umo931TJryfNCEYiO2ZunNncO9EmDicYWH53O5wY2QYH8B9qnCx3HcxCXvRFD
         oCRWXhl2P4u3I1jAPCK3vG3VQl/1BNZzE6U3idpul2mmtZUEkCwfywZQNTPPDnczXUVZ
         cOMhG5lnWMcjZJgo8cF4KoCBk5fG3varhstn+MDoAhb3GL3xLxY40/a2je2ASVKGYnPa
         XWOdw5V3128rC0d2eVZ+WdEigMTCXKuS4RTcCB1tXEouI8m95fJyS5y/W5E0VX3sDbrA
         qGJpcXE5Y5IdV3v5Eiks4ibDI+PJ77HFJjK/oCJp0XO/DzeMA1CsW8KhHB7WAkI3d7Pj
         pLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556227; x=1698161027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUNj0RuL/8OOuLQYk8Wdgn+XG/+EMCMWjBwEvhDGVQM=;
        b=uye+CHbV7MnHKjSYRinlCx31ZFOOYU6/famQ/i53nt+/iuxRZvPVmHFbJVncDV8JDB
         7jqzbH6LIMNpHqCj2nU4xTomt/EBEKu6SdR+hDVhQ0jdjH2QbkQq0Iq/1CQ/owSt6/nV
         C9D2upKe3ofwJuQC3LZSp0Q187lKTvngjYlmjHdjFnjNnMHzVL9Ri72M/tvh5CZ5YI4k
         DNrJPItk1IcppIM4jlfImbdSXmDCsUpP8qLEfNwQ78GVxN8uR/O3N5ZVV8a/LKDGvn9y
         5E2ZQ9v7DVPS8RK/Wj0fxixtJvOhbEZe3YBDzNibT8TexcIlRKyKu7IjJYUCrItFsygh
         T4mQ==
X-Gm-Message-State: AOJu0YxjRCYGNDtXNYgAG9SfCODZwPojPetpkVUXHcewWQpYUQZ2G1gk
        BwCYzmvHizpvxPfa1N00igq9LSJHrfEwQSqVsUnqPQ==
X-Google-Smtp-Source: AGHT+IHL2VoSXoeLqweTG9sAym7m/h3sqSBjc3l8/8LpfHeB7+WMEFPIXJLCLK/jVB3uqbuM2zb2BVpePXIBM0/Sc6Y=
X-Received: by 2002:a17:90b:1645:b0:27d:b885:17f2 with SMTP id
 il5-20020a17090b164500b0027db88517f2mr2358648pjb.30.1697556227120; Tue, 17
 Oct 2023 08:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121707.51368-1-yangyicong@huawei.com> <20231012121707.51368-4-yangyicong@huawei.com>
 <CAKfTPtAdtjZobtrf846kDzscAZTrFxw21SQJbbHU0Cw35vggEQ@mail.gmail.com> <33d8d0c1-da40-278b-5b84-ecb983ee9d34@huawei.com>
In-Reply-To: <33d8d0c1-da40-278b-5b84-ecb983ee9d34@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 17 Oct 2023 17:23:35 +0200
Message-ID: <CAKfTPtD2b6Ky+fqZoCEs5oy+d_c3KLCwmSdSfusEKUwAKZ1R_g@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] sched/fair: Use candidate prev/recent_used CPU if
 scanning failed for cluster wakeup
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, peterz@infradead.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gautham.shenoy@amd.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, kprateek.nayak@amd.com,
        wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 14:55, Yicong Yang <yangyicong@huawei.com> wrote:
>
> Hi Vincent,
>
> On 2023/10/13 23:04, Vincent Guittot wrote:
> > On Thu, 12 Oct 2023 at 14:19, Yicong Yang <yangyicong@huawei.com> wrote:
> >>
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> Chen Yu reports a hackbench regression of cluster wakeup when
> >> hackbench threads equal to the CPU number [1]. Analysis shows
> >> it's because we wake up more on the target CPU even if the
> >> prev_cpu is a good wakeup candidate and leads to the decrease
> >> of the CPU utilization.
> >>
> >> Generally if the task's prev_cpu is idle we'll wake up the task
> >> on it without scanning. On cluster machines we'll try to wake up
> >> the task in the same cluster of the target for better cache
> >> affinity, so if the prev_cpu is idle but not sharing the same
> >> cluster with the target we'll still try to find an idle CPU within
> >> the cluster. This will improve the performance at low loads on
> >> cluster machines. But in the issue above, if the prev_cpu is idle
> >> but not in the cluster with the target CPU, we'll try to scan an
> >> idle one in the cluster. But since the system is busy, we're
> >> likely to fail the scanning and use target instead, even if
> >> the prev_cpu is idle. Then leads to the regression.
> >>
> >> This patch solves this in 2 steps:
> >> o record the prev_cpu/recent_used_cpu if they're good wakeup
> >>   candidates but not sharing the cluster with the target.
> >> o on scanning failure use the prev_cpu/recent_used_cpu if
> >>   they're still idle
> >>
> >> [1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/
> >> Reported-by: Chen Yu <yu.c.chen@intel.com>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  kernel/sched/fair.c | 19 ++++++++++++++++++-
> >>  1 file changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 4039f9b348ec..f1d94668bd71 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7392,7 +7392,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>         bool has_idle_core = false;
> >>         struct sched_domain *sd;
> >>         unsigned long task_util, util_min, util_max;
> >> -       int i, recent_used_cpu;
> >> +       int i, recent_used_cpu, prev_aff = -1;
> >>
> >>         /*
> >>          * On asymmetric system, update task utilization because we will check
> >> @@ -7425,6 +7425,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>
> >>                 if (cpus_share_resources(prev, target))
> >>                         return prev;
> >> +
> >> +               prev_aff = prev;
> >>         }
> >>
> >>         /*
> >> @@ -7457,6 +7459,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>
> >>                 if (cpus_share_resources(recent_used_cpu, target))
> >>                         return recent_used_cpu;
> >> +       } else {
> >> +               recent_used_cpu = -1;
> >>         }
> >>
> >>         /*
> >> @@ -7497,6 +7501,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>         if ((unsigned)i < nr_cpumask_bits)
> >>                 return i;
> >>
> >> +       /*
> >> +        * For cluster machines which have lower sharing cache like L2 or
> >> +        * LLC Tag, we tend to find an idle CPU in the target's cluster
> >> +        * first. But prev_cpu or recent_used_cpu may also be a good candidate,
> >> +        * use them if possible when no idle CPU found in select_idle_cpu().
> >> +        */
> >> +       if ((unsigned int)prev_aff < nr_cpumask_bits &&
> >> +           (available_idle_cpu(prev_aff) || sched_idle_cpu(prev_aff)))
> >
> > Hasn't prev_aff (i.e. prev) been already tested as idle ?
> >
> >> +               return prev_aff;
> >> +       if ((unsigned int)recent_used_cpu < nr_cpumask_bits &&
> >> +           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)))
> >> +               return recent_used_cpu;
> >
> > same here
> >
>
> It was thought that there maybe a small potential race window here that the prev/recent_used
> CPU becoming non-idle after scanning, discussed in [1]. I think the check here won't be
> expensive so added it here. It should be redundant and can be removed.

I agree that there is a race but the whole function
select_idle_sibling() is made of possible races because by the time it
selects a CPU this one can become non-idle. It would be good to have
some figures showing that these redundant checks make a difference.

>
> [1] https://lore.kernel.org/all/ZIams6s+qShFWhfQ@BLR-5CG11610CF.amd.com/
>
> Thanks.
>
> >
> >> +
> >>         return target;
> >>  }
> >>
> >> --
> >> 2.24.0
> >>
> >
