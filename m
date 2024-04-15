Return-Path: <linux-kernel+bounces-144967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A58A4D44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493721F269E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7775D477;
	Mon, 15 Apr 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWov3ffj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FC5C902
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179116; cv=none; b=rwqN5JQw7UDLgQ+9H71CHmGCtvqzixZ2a9bkvoHqxW83EPrGnd0CdRB5RgdyKQxI256onIqUciPHew4IkrmSt0ihRpG1z8X0yWehtpkyJMUHG02YRgp6DiDtjOuB3qQptzb8X72F5W+VYZDxMwQBEuVIKGaguX3uuVoGADaXVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179116; c=relaxed/simple;
	bh=vEGNcExgq1q6KTiq7603D/QOBgwfN2PsiUGPRM9OCMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrI0a43rW0srpNY9VK46jaqsHESrNEAujr3X+bgbcj9LNbxSZsjlHMBrO4Npu5hK1aU/qB7oP/cUEYgPIbyrNNjA0n4P3cx+KfoTBzd5SaaSgX/sp99KQzuopOmGZS+HWAOj+I6wZzqpVRvyO8UceliLjMYRweAHQNFheNkMbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWov3ffj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56fff9d2651so3045426a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713179111; x=1713783911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7zAijvyT25+v+BaKAPw5Dka/ozCLvFU0VnlfSAxSLI=;
        b=RWov3ffj+Cu6oQVQ4bho1g6MvTRXF3ILqMPgSJ09i6CQuc7351lJYzTh18LcgWIJXQ
         6ah6FUp9ATpIw4qex39OKJpG1LHpuNlwcSy8KO7aq0pEjmvNnTQ3kKunXu9AU6fNTYW/
         xGVSM6bZ/UUEkHntKadaVmfZr+kJSWsGNkx14grA6u/AJJieZF2YuiVT0Z5PeDyulDR2
         qvhWh9zZc3P/CaiSg84UOlf/WrFLYZnZ12UzLAWeWofKMB3guZhei1ZfME2Yk/ttJtqv
         oy5+mo9zSABVErdvkrsy496e9FimtDwlM/Jvp0RvKwTI2t6FmBRju+VjiECy471zUe2D
         FTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179111; x=1713783911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7zAijvyT25+v+BaKAPw5Dka/ozCLvFU0VnlfSAxSLI=;
        b=wa0aiCpjafj0yN44F5LfrfvKhODdAUVcsax5JAGQTj5e3j3ilHgKn767B2/hXslVZY
         q+QviWm1peVcf6pGKB6J4PylDwLozUcOPORaz1c63gZeG+ot4co6PCa0yFOK+rS8XcJa
         cCPg22EJsCv3zK7VXtnHuzTVYAg2Ycz2gNhglgzhVqsvROfpB8UnRf20UZ+9S1kTG770
         x3MglgkE5dmnTzbOHA0BKozBlGVp7KVeyvuBqY2fXj2fjOOmfxCgyM03W5atyzfFtMR9
         ld0KkH08EjsDWnf5OtkAfoOLAD0rBrunW6XcOEe6WhUinIZ0Io+WZq5mtdG5MebQwBo8
         PMnw==
X-Gm-Message-State: AOJu0YyeojGR/rj32FPN+Ojcz6eIBPRhR3ZyLJlfjCd3LTzZcJdjXE8P
	8CdXELkLtciH46HXpHpkVu6NLnc83cQ7OQ8UO6NpMnVsBUsVk+TRBwV1QD4EpU6eI4LmN8dD0Iq
	eir+3DBi5PGZjz82GGq09vD3pcfE=
X-Google-Smtp-Source: AGHT+IH7x/o9EK3Hcvhw0d6myCO6NK1BQ70rslx1yUh4gl0H4BMe6rc7x2b0uJWsjT2bt/8BK2HUvxxeeJJTAyROSkk=
X-Received: by 2002:a50:9509:0:b0:56e:323b:d7e7 with SMTP id
 u9-20020a509509000000b0056e323bd7e7mr5855895eda.34.1713179111058; Mon, 15 Apr
 2024 04:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085817.48892-1-zegao@tencent.com> <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
 <CAD8CoPDxgL+dkUM_6oAGuAT-GQVdfrckJB2yOjufvbFE14hBxg@mail.gmail.com> <7577582d-46e2-4fe4-8e41-e6521326c31d@linux.ibm.com>
In-Reply-To: <7577582d-46e2-4fe4-8e41-e6521326c31d@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 15 Apr 2024 19:04:59 +0800
Message-ID: <CAD8CoPCmBMwo13TEz2V0Bb9fSNBKR3uGWKFTHxQTnZ8BxQj36A@mail.gmail.com>
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>, 
	Ben Segall <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:25=E2=80=AFPM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Ze Gao,
>
> On 15/04/24 07:33, Ze Gao wrote:
> > On Sat, Apr 13, 2024 at 12:59=E2=80=AFAM Madadi Vineeth Reddy
> > <vineethr@linux.ibm.com> wrote:
> >>
> >> Hi Ze Gao,
> >>
> >> On 13/03/24 14:28, Ze Gao wrote:
> >>> We observered select_idle_sibling() is likely to return the *target* =
cpu
> >>> early which is likely to be the previous cpu this task is running on =
even
> >>> when it's actually not within the affinity list newly set, from where=
 after
> >>> we can only rely on select_fallback_rq() to choose one for us at its =
will
> >>> (the first valid mostly for now).
> >>>
> >>> However, the one chosen by select_fallback_rq() is highly likely not =
a
> >>> good enough candidate, sometimes it has to rely on load balancer to k=
ick
> >>> in to place itself to a better cpu, which adds one or more unnecessar=
y
> >>> migrations in no doubt. For example, this is what I get when I move t=
ask
> >>> 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> >>>
> >>>         swapper       0 [013]   959.791829: sched:sched_migrate_task:=
 comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D13 dest_cpu=3D23
> >>> kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task:=
 comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D23 dest_cpu=3D24
> >>>
> >>
> >> I am able to reproduce this scenario of having an extra migration thro=
ugh load balance
> >> swapper       0 [031] 398764.057232: sched:sched_migrate_task: comm=3D=
loop pid=3D178687 prio=3D120 orig_cpu=3D31 dest_cpu=3D33
> >> ksoftirqd/0  13 [000] 398764.356138: sched:sched_migrate_task: comm=3D=
loop pid=3D178687 prio=3D120 orig_cpu=3D33 dest_cpu=3D34
> >>
> >> I wrote a simple c program that blocks for few seconds, meanwhile I ta=
skset it to CPUs 33,34 while I already have a
> >> busy task running on CPU 33.
> >>
> >>> The thing is we can actually do better if we do checks early and take=
 more
> >>> advantages of the *target* in select_idle_sibling(). That is, we cont=
inue
> >>> the idle cpu selection if *target* fails the test of cpumask_test_cpu=
(
> >>> *target*, p->cpus_ptr). By doing so, we are likely to pick a good can=
didate,
> >>> especially when the newly allowed cpu set shares some cpu resources w=
ith
> >>> *target*.
> >>>
> >>> And with this change, we clearly see the improvement when I move task=
 3964
> >>> to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> >>>
> >>>         swapper       0 [027]  4249.204658: sched:sched_migrate_task:=
 comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D27 dest_cpu=3D26
> >>
> >> But after applying this patch, The extra migration is still happening =
as CPU 33 is still chosen by try_to_wake_up.
> >>
> >> On placing some perf probes and testing,
> >>     migration/57     304 [057] 12216.988491:       sched:sched_migrate=
_task: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D57 dest_cpu=3D4
> >>          swapper       0 [004] 12226.989065: probe:select_idle_sibling=
_L124: (c0000000001bafc0) i=3D-1 recent_used_cpu=3D-1 prev_aff=3D-1
> >>          swapper       0 [004] 12226.989071:       probe:select_fallba=
ck_rq: (c0000000001a2e38) cpu=3D4
> >>          swapper       0 [004] 12226.989074:       sched:sched_migrate=
_task: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D4 dest_cpu=3D33
> >>          swapper       0 [000] 12227.007768:       sched:sched_migrate=
_task: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D33 dest_cpu=3D34
> >>
> >> It is observed that, select_fallback_rq is still taken in this scenari=
o as default target is returned at the end of select_idle_sibling
> >> which was CPU 4.
> >
> > My best guess is that you may have hit the code path for running tasks
> > (taskset happens right after the task is woken up). Should that happen,
> > the picking is done via:
> >
> >         dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->ne=
w_mask);
>
> Yes, I verified that cpumask_any_and_distribute is hit.
>
> >
> > and it also makes sense that select_fallback_rq() returns 4 since that =
happens
> > before you change the affinities.
>
> In this case, 4 is passed as an argument to select_fallback_rq(), it's no=
t the return
> value. It actually returns the first affined CPU which is 33 here.
>
> Also, I see select_fallback_rq() happening after cpumask_any_and_distribu=
te.
>
> >
> > you may need to rule out this case first :)
> >
>
> I am not sure on how to avoid hitting cpumask_any_and_distribute, Can you=
 explain how did you move the tasks in case
> of stress-ng?

Acutally there is no easy way to avoid taskset on the running task
(maybe -l with a low load expectation which increases the chance
the task sleeps). and then it is simple and stupid: let the trace be
as much verbose as I can, and filter what I pay attention to.

Regards,
Ze

> Thanks and Regards
> Madadi Vineeth Reddy
>
> > Regards,
> > Ze
> >
> >> In most of my testing, default target is returned at the end of the fu=
nction due to the initial checks. It's possible that there would
> >> be cases where we can get optimal CPU before we reach end of the selec=
t_idle_sibling function but it would be interesting to know if the
> >> extra time spent in finding an optimal cpu have an impact instead of r=
eturning it earlier if in most of the times we are returning the
> >> default target at the end.
> >>
> >> Thanks and Regards
> >> Madadi Vineeth Reddy
> >>
> >>>
> >>> Note we do the same check for *prev* in select_idle_sibling() as well=
.
> >>>
> >>> Signed-off-by: Ze Gao <zegao@tencent.com>
> >>> ---
> >>
>

