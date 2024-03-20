Return-Path: <linux-kernel+bounces-109196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB18815FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D351F233D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535269DF5;
	Wed, 20 Mar 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8y2anoi"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4610FA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953883; cv=none; b=X/4iPE7J6e5jaCQ07KTgVmyzpEzV86wY+AY8a5KVnAX1HZn36GAn/i9IiXvW1XgE3hypES/EWXiP/Sr9jed6HNmahM0LDrsAiW33U+oRBTtdn7x8FnhOFuSivejkRk7pd1XTSYm5jf6wf1wqxY1MfUaub/HZ0HLw0ARh098FjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953883; c=relaxed/simple;
	bh=IRuGH8muyCnRkEnnvN23mDt01suqChqI8s24B12Nu3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQOm4rYRBrZ9ssG811CWhb+rBXB5AGu9yqEFQsBCfVVYpLCkv4kZxfhT6QLQshPENaPg8S8sIiZwWqu1Q0K8IipZ+rxCRTNzzpIB+8G4T/kOCwTmY5MmNPhEB6aGpxET3bnrdjnVuxxl1Qbhuk0A6k2noDSeFX16QZEeoN0aedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8y2anoi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso102660b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710953881; x=1711558681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSkItorlO3dNJ7unKUHrmGpIhdyL6BNLufZtR6Qkrdc=;
        b=o8y2anoiPEycvZAkFddGsB0LVMF6sZB1N7zDkH+FmZlFKXjyJ+GXuvYZDcAt8Nzw0z
         NKaGdKFIKCTVcfw1t6Uq1WEkwevWbPL2bE/+fIK9XDad5x8E3SElO+S7KMMzhtKJ6it7
         DSbjb1oSnvBIbOatOiolJRpiJWNCnmCcDSrn7lNKmXKBkHs/r4j9sPrEEbOVxRnqHJG/
         7ty7h0gV3gX8/7854OBjd1IZWXEqHZwfcoU2yjgvZ9eI2UH0RcRBrpPkLKH77djFRjyY
         6mbmVA/KGuTKJ9q9T261WOwBK3Qvylnc3vW+AKucx2LAqGSR+WYfziiaMkn/wkIAw820
         krsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710953881; x=1711558681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSkItorlO3dNJ7unKUHrmGpIhdyL6BNLufZtR6Qkrdc=;
        b=ZIM56mAIi2PZtLPDGeHwDtgF2mp0x9m1domPcSYoBnQOSEVRI8h7XrA322GWMzjtGN
         UqMvawPrAreJRduzxh/CWsKjg1KD3+ilF4rBgxnbit2E6Cg4kml/4KJE/Oy65bY2T2Ay
         rPgosiyvBNFM4TyTQMew9ooSC9VI7kRhuCpHRRnbCNMrWrTenNTzW/M75zHDV9HvPrpB
         sxphgqunf6w2fc2HWigodDP9JCBqVqaUcdiDYdeHWdHti3rdEWlMWToRSR/Em7TlnKhY
         mZrVHLS03yXddgF0qkmfRnpRxm85q+j4uarQ8101tg6WDmJSPC8BbvdhQka9Sp69ixhb
         4K1w==
X-Forwarded-Encrypted: i=1; AJvYcCXwAWhNXBrvex8xnwllOBYekmDBSB1+3i3krfdy31gfYAYk/FzHeNS816xp/0ea/YDS5fgorjPFAFvi6NZV12i/4vUrCPJyynPL5DN+
X-Gm-Message-State: AOJu0YyK3TesLcVyxbnrciSHQYTJvTrLUcg9Ep2mRXPs1EtkEZk7LnF7
	Ipe30YBB5EUMCf5eeLtPDHOMH2tDYrtkfTfgJJd9DUkr3PdXYfFYj93j2MPZ+tBpxE9nt//X8aa
	PBN2KOJlvhICNwnp7587NEe0R56R/NlMKbfQ1kQ==
X-Google-Smtp-Source: AGHT+IGGXyloonBMvtnP8c28xGLiQQHpLY8xOHzt8mJUN4JO5yhJjKxjMKfBSUt/AwzV8HTiyE3F6zCmhbxxP6lelS0=
X-Received: by 2002:a05:6a20:8f05:b0:1a3:54b3:73cc with SMTP id
 b5-20020a056a208f0500b001a354b373ccmr13597898pzk.24.1710953881441; Wed, 20
 Mar 2024 09:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-2-vincent.guittot@linaro.org> <CABk29NsQf_xStzWg8bB_hpNpPC_LduMs-M058LjdhnDG16wN_A@mail.gmail.com>
In-Reply-To: <CABk29NsQf_xStzWg8bB_hpNpPC_LduMs-M058LjdhnDG16wN_A@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 20 Mar 2024 17:57:50 +0100
Message-ID: <CAKfTPtDSC25N8TvszDAjseqdLdGy4qiDnwobNThkt8piSL_5Pw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
To: Josh Don <joshdon@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

Sorry for the late reply.

On Mon, 12 Feb 2024 at 21:29, Josh Don <joshdon@google.com> wrote:
>
> Hi Vincent,
>
> On Thu, Aug 25, 2022 at 5:27=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > During load balance, we try at most env->loop_max time to move a task.
> > But it can happen that the loop_max LRU tasks (ie tail of
> > the cfs_tasks list) can't be moved to dst_cpu because of affinity.
> > In this case, loop in the list until we found at least one.
>
> We had a user recently trigger a hard lockup which we believe is due
> to this patch. The user in question had O(10k) threads affinitized to
> a cpu; seems like the process had an out of control thread spawning
> issue, and was in the middle of getting killed. However, that was
> being slowed down due to the fact that load balance was iterating all

Does it mean that it was progressing but not as fast as you would like

> these threads and bouncing the rq lock (and making no progress due to
> ALL_PINNED). Before this patch, load balance would quit after hitting
> loop_max.
>
> Even ignoring that specific instance, it seems pretty easy for this
> patch to cause a softlockup due to a buggy or malicious process.

The fact that the rq is released regularly should prevent a
softlockup. And we could even fasten can_migrate() which does a lot of
useless stuff for task affined to 1 cpu.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8270e2e15cb..15bc1067c69d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8920,6 +8920,8 @@ int can_migrate_task(struct task_struct *p,
struct lb_env *env)

        lockdep_assert_rq_held(env->src_rq);

+       if (p->nr_cpus_allowed =3D=3D 1)
+               return 0;
        /*
         * We do not migrate tasks that are:
         * 1) throttled_lb_pair, or

>
> For the tradeoff you were trying to make in this patch (spend more
> time searching in the hopes that there's something migratable further
> in the list), perhaps it would be better to adjust
> sysctl.sched_nr_migrate instead of baking this into the kernel?

That could be a solution but this increases the iterations for all
cases including those which are more time consuming to sort out and
the number of tasks that you will migrate in one lb. The latter is the
one which consumes time

Vincent

>
> Best,
> Josh
>
> >
> > The maximum of detached tasks remained the same as before.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index da388657d5ac..02b7b808e186 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
> >                 p =3D list_last_entry(tasks, struct task_struct, se.gro=
up_node);
> >
> >                 env->loop++;
> > -               /* We've more or less seen every task there is, call it=
 quits */
> > -               if (env->loop > env->loop_max)
> > +               /*
> > +                * We've more or less seen every task there is, call it=
 quits
> > +                * unless we haven't found any movable task yet.
> > +                */
> > +               if (env->loop > env->loop_max &&
> > +                   !(env->flags & LBF_ALL_PINNED))
> >                         break;
> >
> >                 /* take a breather every nr_migrate tasks */
> > @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq=
 *this_rq,
> >
> >                 if (env.flags & LBF_NEED_BREAK) {
> >                         env.flags &=3D ~LBF_NEED_BREAK;
> > -                       goto more_balance;
> > +                       /* Stop if we tried all running tasks */
> > +                       if (env.loop < busiest->nr_running)
> > +                               goto more_balance;
> >                 }
> >
> >                 /*
> > --
> > 2.17.1
> >

