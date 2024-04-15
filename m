Return-Path: <linux-kernel+bounces-144968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6B8A4D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB292813AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B25D47E;
	Mon, 15 Apr 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTYbjpyT"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6295D465
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179199; cv=none; b=YyhFuF5gauG9G92uVXiyB15KG6HyIPQIkcuFs3XL5Q3FFEV4m7cq6QZbmZ+cA0wFmkbQUipWkc2XL1PTPJBX82bRj7rIHS0D9fhv1dzyWv48zJzniHHKlAgYXZeuVm+v7y29w7bP4/7wkygn39yhIsMiTe+RZvJzVQeUZ1mowm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179199; c=relaxed/simple;
	bh=/oMa1GL/kKnQW5NMnPve87tUJS/4H/Umomvj2AmkwHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6MDuQJ9LahvLZdlp0KVXddZ0Ja61LzgdnZ6z2vMokkiZWUEbpxOOu7LfQqUKGLRNSVxvDP+mcwnR+QoMHZTEpViDuZD4EwEzfNAlA4MXTAE4eHFwlHPSCekXNtTNnzjdMuirfstmIF52w1Jo4V/UnhhfWsWsECs15jWUx6in04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTYbjpyT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so4891653a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713179193; x=1713783993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HOJ3qTLEUCMYQdoKHMuYV4Z4Tr5FAYEvCc3KkThVm0=;
        b=jTYbjpyT5xNqggB6P3H6wn9qanTXOmQNuwqBu8QHahft4H01sumShUassQf1SPNFrk
         p4s3keQlWWHVVFINslEpXnLLvh7kdrD8Ik5hjnGEFU4C5Ea4rbEvSUJYqBBbTK860xfE
         gdQB9WV9J2bPm9eWUf8nPXQWhSolI0aEHS6zc4wxyo2agg4QrhvMIGc0W+cJFq5qaGRb
         9tCZN+WmtT9CwLtZOxWluT++hibvtuar5OrR8Z3SYqo/PaFI2V/zsi8dHh0PDvFt7o3O
         sMczXuMGWU1VwkHOzyG9M18QY78hmlSpmqkhXh3g6glmvob0zeP1AdfwrYhivREIPzk5
         NqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179193; x=1713783993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HOJ3qTLEUCMYQdoKHMuYV4Z4Tr5FAYEvCc3KkThVm0=;
        b=rWsLgK7VUCElh9RVx0JPo/3n70F4DZSpeT+Q09Fx6uZDXFjjjIfD1R1g214ZlCoFh8
         nqNAyffa45G6e7ANkwnOlH3eEfedMyrwEuoNp/wYbBjGK/kKGXUxw3T9tscNgiYXc/tg
         RgE+//3Vmxundlw7HxmkXtB52cL5g/ewHwRzidBysNpXZPw4CazMwyP6MSlm0VF/h4lz
         RZUjpDP1wZf/RWJ4nnMKrOIrujKFoM5r/R4CXFOvKwkej7FVRWvLPaWuKuqUJxwU5EZx
         bNtJ7hYT+dp4wCwSfESZoHxYUpMSv7VPR1bpO3GPsi6sTN3DjOAuMBTide8TTsR195Ih
         dTdg==
X-Gm-Message-State: AOJu0YzqehOrxFkI9U3NeHQUzCEqLd4l5+qj850MYh8Vrs9ImvCuEArw
	nfBCbd7/nLKCI5mvcNHMfPL+V8u9+op0NpcgX8I/RvxS9hZ5GqttfIOkMDGJxvVp5Plv2csAwFz
	/G6BB0BYyu70Tmomhw5842Ti3AHA=
X-Google-Smtp-Source: AGHT+IHqrBCxC1XEPHIZjzCth9iRYO/Ggjd0q8qY+ZAtZIa8kvW4Kiz32YsCZE5gMTCJqoCXUDCs6cgdiGmMmjmSAiQ=
X-Received: by 2002:a50:cc9c:0:b0:570:1ea8:cce8 with SMTP id
 q28-20020a50cc9c000000b005701ea8cce8mr3424202edi.38.1713179192917; Mon, 15
 Apr 2024 04:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085817.48892-1-zegao@tencent.com> <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
 <CAD8CoPDajt_EciU0x8G_BocajfaJrQ1FKLYkp_nLSfF9+9FJVw@mail.gmail.com> <e8cafcdf-a1aa-4ff1-b614-7c6fd4fa9716@linux.ibm.com>
In-Reply-To: <e8cafcdf-a1aa-4ff1-b614-7c6fd4fa9716@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 15 Apr 2024 19:06:21 +0800
Message-ID: <CAD8CoPDG0C3LmYiExOnQ+sjY=1xbGM5w0gX=h5QdhSaGaBLuNQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
To: CAD8CoPDajt_EciU0x8G_BocajfaJrQ1FKLYkp_nLSfF9+9FJVw@mail.gmail.com
Cc: linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>, 
	Ben Segall <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:36=E2=80=AFPM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> On 15/04/24 11:10, Ze Gao wrote:
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
> > After second thoughts, it indeed could happen if CPU 4 shares nothing
> > with CPU 33(34),
> > for example, in different numa nodes.
> >
> > IOW, it cannot benefit from select_idle_siblings() and has to rely on
> > select_fallback_rq
> > as the last resort. Just like what I said in the changelog, this patch
> > aims to improve rq
> > selection for cases where the newly allowed cpu set shares some cpu
> > resources with
> > the old cpu set.
>
> Right. In power 10(where I tested), LLC is smaller being at SMT4 small co=
re
> level. So, I think there are less chances of affined CPUs to share resour=
ces
> with the old CPU set.
>
> I also ran schbench and hackbench just to make sure that there is no regr=
ession
> in powerpc. Luckily there is no regression.
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks for the testing!

Sincerely,
Ze

> Thanks and Regards
> Madadi Vineeth Reddy
>
> >
> > Sorry for not being able to recall all details immediately, since this
> > thread has been inactive
> > for a long while and receives no feedback from sched folks.
> >
> > Best,
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

