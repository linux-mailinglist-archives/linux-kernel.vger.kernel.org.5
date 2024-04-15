Return-Path: <linux-kernel+bounces-144548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0EB8A47A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24FC1C21489
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7A12B89;
	Mon, 15 Apr 2024 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThjZ4zFZ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0455F510
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159628; cv=none; b=aTSBZsXQlB9RdE0Rk6G4FuSV59is2l0nCBjt4VZk2FTOdYsyv6urk16fV4CJevbWYp8uHDeAgjLKw43+CeQGG+BnK4KuFSGSRkOObiqgfJirD8gAc8/XJ20DLxF1M+5Q9UWDS8qQiTv4s5Kr2gcmd/thHgOwgK3D3wa2S34AIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159628; c=relaxed/simple;
	bh=xw6LiBTKtqdnubnlEIr89XeIYn/c664F4jw22gE1mTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyRDJ/9nxGwG1ZxeMX9UPHF+mW+tORsSn2aoFO5A1MdEy1Xf6XqtWJzggHmlC/FPlxVIguYFhTuk4ZlmNJG0hVD+vrWiAYy52z49j2VwsD2XXT4/6rXS0LFYO2OVxM1pCVfjqKKFh4azwtf6azIknL26vK/w1I41jZ5daP5J+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThjZ4zFZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so4412017a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 22:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713159625; x=1713764425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GIEmjyvgTlzuiRbpI4eQnW0cbdSg6YrPHwvvZri8SY=;
        b=ThjZ4zFZQnoa0XnnYm6DQ9Sa4y9GT93Ze4fxoi94M6qFlry+3y5ozoBiM7nNaKDFch
         aRPBAu/anptzX/uHzo6zBc1mZ6dfFXf2gvgCHntJLF8qsOd3XmSbRq9/hC5kaTbdS/bp
         meXlqm1Vo/jMh+Aq1jSk/IUoUB5GJaLsEasx5BnxDLywAH/X1Ln78rkEgoWvyOqUiIgt
         bgsrmsFNI8Y60O+cncRUvUtTfaeNhm+XbiqSpClnlAP506XpqG43q6IO7d80dV3V/Q6/
         bv9K2+cnSSQfFA3FI2Kcj+Q15Vjk6CG68o0dO3KDjx9SBy0q01FElbuYkZb/F4jlef3a
         ixfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713159625; x=1713764425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GIEmjyvgTlzuiRbpI4eQnW0cbdSg6YrPHwvvZri8SY=;
        b=HbiVajuE3inONEiwbGkF9zDhS65EHHOIBb5za5gIhDVsFUtN5lqTK+PSdy2KmJyTTz
         mps2tPKpa5+CjcJvGq06dgj6gwH1vAajS+X3U9eoJcJN2AtiuWHs2HOe+iSr7IJJd7oU
         HVmdgNlzlv6tBYzy2/D9h4ZmBVoStYNYXLuPVneCBddGdsW71J1nkSo86xX1at2ajna7
         +VQaddxFsYRoHo2Log/5hfeZLl1kXnbjVgv3q0Ix1OdLDQaZfi8qc1MbPEDCK027IcTj
         lw+lEiYYuGaW6cZidBKb+f4lIlWxQmC3QsVMFUk9uAVNaSIGtEb6XPb4TT4KgOQPfZkO
         vfZw==
X-Gm-Message-State: AOJu0YxzdzfVb5X5+HgWtgZIES9/baxUqC8DUt+/KujgdriibXqMjlCs
	ush+8mMqCsQ5iHsf48+5x3b5kw99NvviWMpk8ofBTvLs9Nk0xrQK8aoCs3YJMMSr8EMWXR5V4OM
	iBoZKe4jTyTQnStqPrXfYp5pLwXM=
X-Google-Smtp-Source: AGHT+IGKl6piHeSLVfDzjED+XhSZsu+H08nu6+un64kd5//BIdVALMViQF4wd4jMCiBPAp6fF3DjPgE2PwRi0g1wKRM=
X-Received: by 2002:a50:cc9c:0:b0:570:1ea8:cce8 with SMTP id
 q28-20020a50cc9c000000b005701ea8cce8mr2773032edi.38.1713159624881; Sun, 14
 Apr 2024 22:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085817.48892-1-zegao@tencent.com> <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
In-Reply-To: <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 15 Apr 2024 13:40:13 +0800
Message-ID: <CAD8CoPDajt_EciU0x8G_BocajfaJrQ1FKLYkp_nLSfF9+9FJVw@mail.gmail.com>
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

On Sat, Apr 13, 2024 at 12:59=E2=80=AFAM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Ze Gao,
>
> On 13/03/24 14:28, Ze Gao wrote:
> > We observered select_idle_sibling() is likely to return the *target* cp=
u
> > early which is likely to be the previous cpu this task is running on ev=
en
> > when it's actually not within the affinity list newly set, from where a=
fter
> > we can only rely on select_fallback_rq() to choose one for us at its wi=
ll
> > (the first valid mostly for now).
> >
> > However, the one chosen by select_fallback_rq() is highly likely not a
> > good enough candidate, sometimes it has to rely on load balancer to kic=
k
> > in to place itself to a better cpu, which adds one or more unnecessary
> > migrations in no doubt. For example, this is what I get when I move tas=
k
> > 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> >
> >         swapper       0 [013]   959.791829: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D13 dest_cpu=3D23
> > kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D23 dest_cpu=3D24
> >
>
> I am able to reproduce this scenario of having an extra migration through=
 load balance
> swapper       0 [031] 398764.057232: sched:sched_migrate_task: comm=3Dloo=
p pid=3D178687 prio=3D120 orig_cpu=3D31 dest_cpu=3D33
> ksoftirqd/0  13 [000] 398764.356138: sched:sched_migrate_task: comm=3Dloo=
p pid=3D178687 prio=3D120 orig_cpu=3D33 dest_cpu=3D34
>
> I wrote a simple c program that blocks for few seconds, meanwhile I tasks=
et it to CPUs 33,34 while I already have a
> busy task running on CPU 33.
>
> > The thing is we can actually do better if we do checks early and take m=
ore
> > advantages of the *target* in select_idle_sibling(). That is, we contin=
ue
> > the idle cpu selection if *target* fails the test of cpumask_test_cpu(
> > *target*, p->cpus_ptr). By doing so, we are likely to pick a good candi=
date,
> > especially when the newly allowed cpu set shares some cpu resources wit=
h
> > *target*.
> >
> > And with this change, we clearly see the improvement when I move task 3=
964
> > to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> >
> >         swapper       0 [027]  4249.204658: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D27 dest_cpu=3D26
>
> But after applying this patch, The extra migration is still happening as =
CPU 33 is still chosen by try_to_wake_up.
>
> On placing some perf probes and testing,
>     migration/57     304 [057] 12216.988491:       sched:sched_migrate_ta=
sk: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D57 dest_cpu=3D4
>          swapper       0 [004] 12226.989065: probe:select_idle_sibling_L1=
24: (c0000000001bafc0) i=3D-1 recent_used_cpu=3D-1 prev_aff=3D-1
>          swapper       0 [004] 12226.989071:       probe:select_fallback_=
rq: (c0000000001a2e38) cpu=3D4
>          swapper       0 [004] 12226.989074:       sched:sched_migrate_ta=
sk: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D4 dest_cpu=3D33
>          swapper       0 [000] 12227.007768:       sched:sched_migrate_ta=
sk: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D33 dest_cpu=3D34
>
> It is observed that, select_fallback_rq is still taken in this scenario a=
s default target is returned at the end of select_idle_sibling
> which was CPU 4.

After second thoughts, it indeed could happen if CPU 4 shares nothing
with CPU 33(34),
for example, in different numa nodes.

IOW, it cannot benefit from select_idle_siblings() and has to rely on
select_fallback_rq
as the last resort. Just like what I said in the changelog, this patch
aims to improve rq
selection for cases where the newly allowed cpu set shares some cpu
resources with
the old cpu set.

Sorry for not being able to recall all details immediately, since this
thread has been inactive
for a long while and receives no feedback from sched folks.

Best,
Ze

> In most of my testing, default target is returned at the end of the funct=
ion due to the initial checks. It's possible that there would
> be cases where we can get optimal CPU before we reach end of the select_i=
dle_sibling function but it would be interesting to know if the
> extra time spent in finding an optimal cpu have an impact instead of retu=
rning it earlier if in most of the times we are returning the
> default target at the end.
>
> Thanks and Regards
> Madadi Vineeth Reddy
>
> >
> > Note we do the same check for *prev* in select_idle_sibling() as well.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
>

