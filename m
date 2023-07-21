Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6561375C8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGUOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGUOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:01:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC02D4A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:01:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so2629470a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948091; x=1690552891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/3cp9x1gFpUnckNTkCFkws97jRjGDVMsdSjVmMNcxs=;
        b=eqWd4vw9CitJnBaDPNmqnEaY3uduNqD04DNpFVNSh6iw92fVTpSqFk/XRvAtvUAgKf
         FLG7/kOqWq3fzJnOzIeZ6L0UUw9oBGMJYQ1TRDEMqVyqI0jlFWhVgnRsJBiIJNYsrOGr
         g5oTfVBhE+nUUNW3e0ynB2SckH2DeC+89319b1DX5ueQSY27EuNGR/D9r2/4HJqFMRwa
         ax6z5PWZf63G6+db3cL9sixhSHvt1XFbD66zqq0bEKdnB3jYRUb/LqTJxwTLgYAJqGFI
         wVPjioStJQG5/jhhZ/V6JKUGJEtgo/U5gjyMiyRlopxfQsK0oDDy+o/+DCnGXLZPYWU+
         E0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948091; x=1690552891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/3cp9x1gFpUnckNTkCFkws97jRjGDVMsdSjVmMNcxs=;
        b=doQHOgE4VIaGexyPVlKjhFF0U4SiYLU/RlqX/rfOfXH5kEvgaxMzEMIq9m0IopYEdC
         KnuY5PRVciaggap9hOcOiFx3VUiP/R8RWLIg+t1iYZMAJlFzt560u1mtAitIyUJCdVSs
         xNz0A529CorifkCAifsHthlcuWoEhjBIkLPvQiU/RigbC05fx2F9+Ql3XG5moF9skF6w
         xej7Er7FtsP18XIbpdp07CKJy+feA71UGoujI7cf0hW4XNBYlq1HZRpi6i1tdMBY8FBW
         Od13Dhefmnffj4UYep1QtPdMLFQlvukNjq73fcPh5Vcna8+EaIvL2Gd8pSR5XGeBJjS3
         Ev/Q==
X-Gm-Message-State: ABy/qLYQ3nLfpXL3ebXVKCCGxHk8Y5WEjIhi/++TZrBHmlzvUHkzL/Zh
        VtPdzIMTuio3ERUepBH2CCSR07e5Wh70HsGjdJDRyg==
X-Google-Smtp-Source: APBJJlGrikwM9xxeF1cre51gzD7CfziHfJi3QRzZATpo+PMbIZTgvQ6nkJ7QK0I5EWys2xDFgDzeos3p+1g1YdTlsmw=
X-Received: by 2002:aa7:dc0f:0:b0:51f:e92a:62ba with SMTP id
 b15-20020aa7dc0f000000b0051fe92a62bamr1561204edu.9.1689948091141; Fri, 21 Jul
 2023 07:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <F4B69136-C13A-4449-9005-4BB0617E60AC@oracle.com>
 <CAKfTPtCBQJYfFgFhA6=364onup2TU1hrTxJYJA5OiSJ_ECB0JA@mail.gmail.com>
 <7C9D3ABF-E878-4B75-9ED6-AD6EFB6243C5@oracle.com> <ZIlgD36syo5nGoZI@chenyu5-mobl2.ccr.corp.intel.com>
 <E0B1B4B6-8281-49AC-AC77-4920D209796F@oracle.com> <1F10D321-2EB5-4546-96BB-0ABEC7638D6E@oracle.com>
 <CAKfTPtBDfCFQUTOmT1BXO8=ena0j5HEBsgcNF5eZdWtMEWP2kg@mail.gmail.com> <CFDAB0A8-9131-408A-97EB-2F4F8E20E86B@oracle.com>
In-Reply-To: <CFDAB0A8-9131-408A-97EB-2F4F8E20E86B@oracle.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Jul 2023 16:01:20 +0200
Message-ID: <CAKfTPtA0JO_5-7+ToP4cYomm+SbNJkV7Lhbcsf_szf-=2qsQuw@mail.gmail.com>
Subject: Re: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangqiao22@huawei.com" <zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

On Fri, 21 Jul 2023 at 01:04, Saeed Mirzamohammadi
<saeed.mirzamohammadi@oracle.com> wrote:
>
> Hi Vincent,
>
> > On Jun 30, 2023, at 1:28 AM, Vincent Guittot <vincent.guittot@linaro.or=
g> wrote:
> >
> > On Fri, 30 Jun 2023 at 00:20, Saeed Mirzamohammadi
> > <saeed.mirzamohammadi@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Jun 21, 2023, at 9:41 AM, Saeed Mirzamohammadi <saeed.mirzamohamma=
di@oracle.com> wrote:
> >>>
> >>> Hi Chen, Vincent,
> >>>
> >>>> On Jun 13, 2023, at 11:37 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> >>>>
> >>>> On 2023-06-13 at 19:35:55 +0000, Saeed Mirzamohammadi wrote:
> >>>>> Hi Vincent,
> >>>>>
> >>>>>> On Jun 9, 2023, at 9:52 AM, Vincent Guittot <vincent.guittot@linar=
o.org> wrote:
> >>>>>>
> >>>>>> Hi Saeed,
> >>>>>>
> >>>>>> On Fri, 9 Jun 2023 at 00:48, Saeed Mirzamohammadi
> >>>>>> <saeed.mirzamohammadi@oracle.com> wrote:
> >>>>>>>
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> I=E2=80=99m reporting a regression of up to 8% with Unixbench She=
ll Scripts benchmarks after the following commit:
> >>>>>>>
> >>>>>>> Commit Data:
> >>>>>>> commit-id        : a53ce18cacb477dd0513c607f187d16f0fa96f71
> >>>>>>> subject          : sched/fair: Sanitize vruntime of entity being =
migrated
> >>>>>>> author           : vincent.guittot@linaro.org
> >>>>>>> author date      : 2023-03-17 16:08:10
> >>>>>>>
> >>>>>>>
> >>>>>>> We have observed this on our v5.4 and v4.14 kernel and not yet te=
sted 5.15 but I expect the same.
> >>>>>>
> >>>>>> It would be good to confirm that the regression is present on v6.3
> >>>>>> where the patch has been merged originally.  It can be that there =
is
> >>>>>> hidden dependency with other patches introduced since v5.4
> >>>>>
> >>>>> Regression is present on v6.3 as well, examples:
> >>>>> ub_gcc_224copies_Shell_Scripts_8_concurrent: ~6%
> >>>>> ub_gcc_224copies_Shell_Scripts_16_concurrent: ~8%
> >>>>> ub_gcc_448copies_Shell_Scripts_1_concurrent: ~2%
> >>>
> >>> Apologize for the confusion, I should correct the v6.3 upstream resul=
t above. v6.3 doesn=E2=80=99t have any regression.
> >>> v6.3.y -> no regression
> >>> v5.15.y -> no regression
> >>> v5.4.y -> 5-8% regression.
> >>
> >> A gentle reminder if there is any recommendation for v5.4.y and v4.14.=
y regression. Thanks!
> >
> > I tried to find why the regression happens only for v5.4.y (or lower)
> > and not for v5.15.y (or above) but I haven't been able to find any
> > possible reason in the code.
> >
> > Regarding the 2 commits below, they must come together so we can't
> > simply revert 1 and not the other.
> > commit 829c1651e9c4 sched/fair: sanitize vruntime of entity being place=
d
> > commit a53ce18cacb4 sched/fair: Sanitize vruntime of entity being migra=
ted
> >
> Tests were done before and after these 2 commits.
>
> > entity_is_long_sleeper() should never return true in your case. Could
> > you try to check that it's the case for you ?
> >
> Tested this and entity_is_long_sleeper() never returns True.
>
> I actually removed the related part, tested, and the regression is gone w=
ith the following change (partial revert):
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3ebd2054996bc..0d70dd6e14844 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -792,9 +792,6 @@ static inline void dequeue_task(struct rq *rq, struct=
 task_struct *p, int flags)
>
>  void activate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -       if (task_on_rq_migrating(p))
> -               flags |=3D ENQUEUE_MIGRATED;
> -
>         if (task_contributes_to_load(p))
>                 rq->nr_uninterruptible--;
>

Is the regression still there if you only apply the partial revert
below but not the above part ?
I have rechecked the code but can't see any obvious reason why there
is a regression on v5.4 and not on v5.15.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 83a7cf62c0f53..ef9aca05c7bdf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3779,9 +3779,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
>
>         if (flags & ENQUEUE_WAKEUP)
>                 place_entity(cfs_rq, se, 0);
> -       /* Entity has migrated, no longer consider this task hot */
> -       if (flags & ENQUEUE_MIGRATED)
> -               se->exec_start =3D 0;
>
>         check_schedstat_required();
>         update_stats_enqueue(cfs_rq, se, flags);
> @@ -6182,6 +6179,9 @@ static void migrate_task_rq_fair(struct task_struct=
 *p)
>
>         /* Tell new CPU we are migrated */
>         p->se.avg.last_update_time =3D 0;
> +
> +       /* We have migrated, no longer consider this task hot */
> +       p->se.exec_start =3D 0;
>  }
>
>  static void task_dead_fair(struct task_struct *p)
>
>
> >
> >
> >
> >
> >>
> >>>
> >>>
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> ub_gcc_1copy_Shell_Scripts_1_concurrent  :  -0.01%
> >>>>>>> ub_gcc_1copy_Shell_Scripts_8_concurrent  :  -0.1%
> >>>>>>> ub_gcc_1copy_Shell_Scripts_16_concurrent  :  -0.12%%
> >>>>>>> ub_gcc_56copies_Shell_Scripts_1_concurrent  :  -2.29%%
> >>>>>>> ub_gcc_56copies_Shell_Scripts_8_concurrent  :  -4.22%
> >>>>>>> ub_gcc_56copies_Shell_Scripts_16_concurrent  :  -4.23%
> >>>>>>> ub_gcc_224copies_Shell_Scripts_1_concurrent  :  -5.54%
> >>>>>>> ub_gcc_224copies_Shell_Scripts_8_concurrent  :  -8%
> >>>>>>> ub_gcc_224copies_Shell_Scripts_16_concurrent  :  -7.05%
> >>>>>>> ub_gcc_448copies_Shell_Scripts_1_concurrent  :  -6.4%
> >>>>>>> ub_gcc_448copies_Shell_Scripts_8_concurrent  :  -8.35%
> >>>>>>> ub_gcc_448copies_Shell_Scripts_16_concurrent  :  -7.09%
> >>>>>>>
> >>>>>>> Link to unixbench:
> >>>>>>> github.com/kdlucas/byte-unixbench
> >>>>>>
> >>>>>> I tried to reproduce the problem with v6.3 on my system but I don'=
t
> >>>>>> see any difference with or without the patch
> >>>>>>
> >>>>>> Do you have more details on your setup ? number of cpu and topolog=
y ?
> >>>>>>
> >>>>> model name  : Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
> >>>>>
> >>>>> Topology:
> >>>>> node   0   1
> >>>>> 0:  10  21
> >>>>> 1:  21  10
> >>>>>
> >>>>> Architecture:          x86_64
> >>>>> CPU op-mode(s):        32-bit, 64-bit
> >>>>> CPU(s):                56
> >>>>> On-line CPU(s) list:   0-55
> >>>>> Thread(s) per core:    2
> >>>>> Core(s) per socket:    14
> >>>>> Socket(s):             2
> >>>>> NUMA node(s):          2
> >>>>>
> >>>> Tested on a similar platform E5-2697 v2 @ 2.70GHz which has 2 nodes,
> >>>> 24 cores/48 CPUs in total, however I could not reproduce the issue.
> >>>> Since the regression was reported mainly against 224 and 448 copies =
case
> >>>> on your platform, I tested unixbench shell1 with 4 x 48 =3D 192 copi=
es.
> >>>>
> >>>>
> >>>> a53ce18cacb477dd 213acadd21a080fc8cda8eebe6d
> >>>> ---------------- ---------------------------
> >>>>       %stddev     %change         %stddev
> >>>>           \          |                \
> >>>>   21304            +0.5%      21420        unixbench.score
> >>>>  632.43            +0.0%     632.44        unixbench.time.elapsed_ti=
me
> >>>>  632.43            +0.0%     632.44        unixbench.time.elapsed_ti=
me.max
> >>>> 11837046            -4.7%   11277727        unixbench.time.involunta=
ry_context_switches
> >>>>  864713            +0.1%     865914        unixbench.time.major_page=
_faults
> >>>>    9600            +4.0%       9984        unixbench.time.maximum_re=
sident_set_size
> >>>> 8.433e+08            +0.6%   8.48e+08        unixbench.time.minor_pa=
ge_faults
> >>>>    4096            +0.0%       4096        unixbench.time.page_size
> >>>>    3741            +1.1%       3783        unixbench.time.percent_of=
_cpu_this_job_got
> >>>>   18341            +1.3%      18572        unixbench.time.system_tim=
e
> >>>>    5323            +0.6%       5353        unixbench.time.user_time
> >>>> 78197044            -3.1%   75791701        unixbench.time.voluntary=
_context_switches
> >>>> 57178573            +0.4%   57399061        unixbench.workload
> >>>>
> >>>> There is no much difference with a53ce18cacb477dd applied or not.
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> a2e90611b9f425ad 829c1651e9c4a6f78398d3e6765
> >>>> ---------------- ---------------------------
> >>>>       %stddev     %change         %stddev
> >>>>           \          |                \
> >>>>   19985            +8.6%      21697        unixbench.score
> >>>>  632.64            -0.0%     632.53        unixbench.time.elapsed_ti=
me
> >>>>  632.64            -0.0%     632.53        unixbench.time.elapsed_ti=
me.max
> >>>> 11453985            +3.7%   11880259        unixbench.time.involunta=
ry_context_switches
> >>>>  818996            +3.1%     844681        unixbench.time.major_page=
_faults
> >>>>    9600            +0.0%       9600        unixbench.time.maximum_re=
sident_set_size
> >>>> 7.911e+08            +8.4%  8.575e+08        unixbench.time.minor_pa=
ge_faults
> >>>>    4096            +0.0%       4096        unixbench.time.page_size
> >>>>    3767            -0.4%       3752        unixbench.time.percent_of=
_cpu_this_job_got
> >>>>   18873            -2.4%      18423        unixbench.time.system_tim=
e
> >>>>    4960            +7.1%       5313        unixbench.time.user_time
> >>>> 75436000           +10.8%   83581483        unixbench.time.voluntary=
_context_switches
> >>>> 53553404            +8.7%   58235303        unixbench.workload
> >>>>
> >>>> Previously with 829c1651e9c4a6f introduced, there is 8.6% improvemen=
t. And this improvement
> >>>> remains with a53ce18cacb477dd applied.
> >>>>
> >>>> Can you send the full test script so I can have a try locally?
> >>>
> >>> Thanks for testing this. For v5.4.y kernel (not for v6.3.y or v5.15.y=
), there is an 8% regression with the following test: ub_gcc_448copies_Shel=
l_Scripts_8_concurrent
> >>> And that=E2=80=99s =E2=80=99shell8=E2=80=99 with =E2=80=98-c 448=E2=
=80=99 copies passed as argument.
> >>>
> >>> Thanks,
> >>> Saeed
> >>>
> >>>>
> >>>> thanks,
> >>>> Chenyu
>
