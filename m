Return-Path: <linux-kernel+bounces-75813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE885EF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0642F284734
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1639168BD;
	Thu, 22 Feb 2024 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO95sFbv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E944111A1;
	Thu, 22 Feb 2024 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570716; cv=none; b=TwOLrkfa2rPOQYBVtIIoB5P6Kb4SiPLkEHBC6triiAcpX/RBAY+bDhXl0ae8VEM40qo6r9EKnkFBbiZMbZKJdCo2DWOiFfFfudYexCWLouFbr902qjaRR2YdMQHeMR6FBSUeziadO1U+7LpiMmegtxgHKJifyiNCrDMMXCna5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570716; c=relaxed/simple;
	bh=0nphF7usZZqKN3VylhoEAkqBD0TzM+Qs06c7S6NXi1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCkD9p6APDy4QYcPs9KOeC9gJVcuQ0Hk8l3oHaZWLaun6/nu880A/OIyMy9XyVEKPGz3MEUpiCgMoI6KZEQOfSoIApGtve1Y0kf5N3uIZjZrvv1pREKp+WYadkZ50W64vk7gavcOyGsw3oHbOy9q4i3/Ca7syI0XvuOE9p9nHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO95sFbv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51197ca63f5so8505258e87.1;
        Wed, 21 Feb 2024 18:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708570712; x=1709175512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kefti/WKSkVD/+jrlXZpB2qb7waWkiA61t1W1mx7oHU=;
        b=AO95sFbviXM547cKPR+NwymE2U15GnRMQYvH5XNrTdKZu5EFdqDtBxsGSRc4/B1ALs
         P5xAn6LmTv9qa4i4UnOiQtrCIYD8FEpXSIhMN5HJSnVWhm07Z+0RPC6oS7dm/uN0ccJU
         4P/2nm0xZDtWFraXk6MHPxOyQQ6B6uLSXFdmPYgfkG1C7HrkL82qNHJKGXu2KztN8spj
         atmJ7qgdBAF/7iqXZrZm4G46pypy6KRMppNYY/sxgQ/JbELYYxUExTlG+O+GRY47dREI
         pvGaq08Mc6B7n/LoWQt8ywgPdbHpKlxOU1/tdnxG52dFmp+Ze/CTEN7FBrSOOje8ONJD
         s+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570712; x=1709175512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kefti/WKSkVD/+jrlXZpB2qb7waWkiA61t1W1mx7oHU=;
        b=s88mOcIsQFaZFXioX4UTyTK8pnTgVZVI7hFQtof0ptSYYv6NNVXH71yHmDkm1Bk+2X
         4fGAq74NKaceJMfSQ5g3HfLx51b7TkUAo0X7qDiwf2Bxumjx+7wJmmelPXFfYlQZ1xt9
         1BvCbGZcjkJNj80y5G3nckbXqRAGR6DrQl81jFWTed2tR7GoJ42bdElumA7FDOS/l/tx
         Y3PeM1n/l7ErxPzp+jUO7dptMlvlCJIlM475o/uFVqWm5mc69axP3eRQjkkmntb8Xf0M
         3I91JRGlKiRaFva2X/83IUHCWaN5Nz1a9UrsAPAomP+ZK8OEH+KuqaJz76Y1VxP3bfSC
         Vxeg==
X-Forwarded-Encrypted: i=1; AJvYcCWMHq/uYZrbwfwcfY9BqVurYOTHwPi5dGqcLryMnwdoObf3wCPpu8lmLlehfxsXvC37hLejco/Kv6VXGDPOTpQZ8ZqUxbgMsUYrv1TXL7vpZBcZpzjyD4WmoPkTIk9XuuB1TsJP5JDvG5I=
X-Gm-Message-State: AOJu0Yxc2sBAuUAEQ5jzZMd0vUp/qQdcuODE2JAZwXk+PKK79QUUclgB
	ub77oITYywDfa1NU1icmfRQHnzHkdwNPIxT6enby7aJhFsxrz1vHcvr4ZwgOwuIVuknzZH0T+H1
	AGMC4gkxPhwse0ntItd1qssLbxds=
X-Google-Smtp-Source: AGHT+IEskMN7jjVczkBYTgDpp3w7MAtrqaOErGgIls3EVSnsOx3K0j4so1rTvyuRo3iHw2N4dOxWTiX6OmHHDrVbNQQ=
X-Received: by 2002:a05:6512:2242:b0:512:ae95:d6cd with SMTP id
 i2-20020a056512224200b00512ae95d6cdmr9932769lfu.2.1708570711918; Wed, 21 Feb
 2024 18:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220061542.489922-1-zhaoyang.huang@unisoc.com> <CAKfTPtCbxk4_pAwi_+0ROo52f7R4+kZawe=OFEcOc2bTCYfsHw@mail.gmail.com>
In-Reply-To: <CAKfTPtCbxk4_pAwi_+0ROo52f7R4+kZawe=OFEcOc2bTCYfsHw@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 22 Feb 2024 10:58:20 +0800
Message-ID: <CAGWkznHj=kt-7X+eeU-HrvWnokdDZKVeLQEV1zAAe+1iXc75jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched: introduce helper function to calculate
 distribution over sched class
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:51=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 20 Feb 2024 at 07:16, zhaoyang.huang <zhaoyang.huang@unisoc.com> =
wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > As RT, DL, IRQ time could be deemed as lost time of CFS's task, some
>
> It's lost only if cfs has been actually preempted
Yes. Actually, I just want to get the approximate proportion of how
CFS tasks(whole runq) is preempted. The preemption among CFS is not
considered.
>
> > timing value want to know the distribution of how these spread
> > approximately by using utilization account value (nivcsw is not enough
> > sometimes). This commit would like to introduce a helper function to
> > achieve this goal.
> >
> > eg.
> > Effective part of A =3D Total_time * cpu_util_cfs / cpu_util
> >
> > Timing value A
> > (should be a process last for several TICKs or statistics of a repeadte=
d
> > process)
> >
> > Timing start
> > |
> > |
> > preempted by RT, DL or IRQ
> > |\
> > | This period time is nonvoluntary CPU give up, need to know how long
> > |/
>
> preempted means that a cfs task stops running on the cpu and lets
> another rt/dl task or an irq run on the cpu instead. We can't know
> that. We know an average ratio of time spent in rt/dl and irq contexts
> but not if the cpu was idle or running cfs task
ok, will take idle into consideration and as explained above,
preemption among cfs tasks is not considered on purpose
>
> > sched in again
> > |
> > |
> > |
> > Timing end
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/sched.h |  1 +
> >  kernel/sched/core.c   | 20 ++++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 77f01ac385f7..99cf09c47f72 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2318,6 +2318,7 @@ static inline bool owner_on_cpu(struct task_struc=
t *owner)
> >
> >  /* Returns effective CPU energy utilization, as seen by the scheduler =
*/
> >  unsigned long sched_cpu_util(int cpu);
> > +unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long =
val);
> >  #endif /* CONFIG_SMP */
> >
> >  #ifdef CONFIG_RSEQ
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 802551e0009b..217e2220fdc1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7494,6 +7494,26 @@ unsigned long sched_cpu_util(int cpu)
> >  {
> >         return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, =
NULL);
> >  }
> > +
> > +/*
> > + * Calculate the approximate proportion of timing value consumed in cf=
s.
> > + * The user must be aware of this is done by avg_util which is tracked=
 by
> > + * the geometric series as decaying the load by y^32 =3D 0.5 (unit is =
1ms).
> > + * That is, only the period last for at least several TICKs or the sta=
tistics
> > + * of repeated timing value are suitable for this helper function.
> > + */
> > +unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long =
val)
> > +{
> > +       unsigned int cpu =3D task_cpu(tsk);
> > +       struct rq *rq =3D cpu_rq(cpu);
> > +       unsigned long util;
> > +
> > +       if (tsk->sched_class !=3D &fair_sched_class)
> > +               return val;
> > +       util =3D cpu_util_rt(rq) + cpu_util_cfs(cpu) + cpu_util_irq(rq)=
 + cpu_util_dl(rq);
>
> This is not correct as irq is not on the same clock domain: look at
> effective_cpu_util()
>
> You don't care about idle time ?
ok, will check. thanks
>
> > +       return min(val, cpu_util_cfs(cpu) * val / util);
> > +}
> > +
> >  #endif /* CONFIG_SMP */
> >
> >  /**
> > --
> > 2.25.1
> >

