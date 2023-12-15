Return-Path: <linux-kernel+bounces-1532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8AD814FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896F91F250F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFB45C09;
	Fri, 15 Dec 2023 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAJG/lEu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF741872
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so10728931fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702665022; x=1703269822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+rMsyeulFWwNHAD7kH8Y5q6Z8Eg52/2yyKY9+nU09c=;
        b=bAJG/lEuo8UrGv4oJLoE9zjveGGvqd6QtpkXLyUIwI0EjPjvMkJMVgQ/+LMAr4X9wf
         oDjIOqS+f3teo144f1oXs8Btx1DAJWa4dArdu37RdLUi8NPrDq03pokfbJXorrEmuPeZ
         r8cygI/bglOUBMyTFFQ1J1W6seIAQzDGrXxgposedLfrZpzd9/pqk1gIngf5G/OalfwD
         Zjf9NcSIjp20ng8tKPiN+Y0DwSN/POSuT1ZIWTLR9jvVqYxI4cyPvRo49T8GdFIzz1SP
         7rYSzs2FrkPlS9PeVGn20TJUgfCBu3PkclifgzWm8tiLglUFKQZ0eqlWi5kFz30kipsT
         4gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702665022; x=1703269822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+rMsyeulFWwNHAD7kH8Y5q6Z8Eg52/2yyKY9+nU09c=;
        b=ec91KyIa76C+xiSUUDSr7HSfrAYbklb9vU7Mlo6fYORfRHcT9frrovIKcNVSuKAkvW
         +3+3+Rvqaa2isOlly4VEV1UhXad4fbTEYj2oCBJxRWXeYy9nRx1R0wOi6xDX3oNA9m5a
         9JtLi1Ewoec9HXivvw6rMSMoFRGVm7XF1neGgZcaUnBz51PT3C47Tf9k1DWK9U4NXTni
         OKSHfdpP/4LJb5vl8lqfax2ir2VDhbprShrP2N6+sXCtS5Uu5Uyl+7nRT9teVmjsGlsl
         Tmb84U2imlRRovxwPav+fex7fmTPzcJDsI9CBPhKOxFNvxQcfWJY1UxyzXv7cKIkAWtx
         6sFQ==
X-Gm-Message-State: AOJu0YxuwMLNp0OjUyoy1eIRmJdHaF1XSgb0U8AUQI1SUIFzzrap52/s
	y0p14Yh+o+ft850tbl481WJ7uwU4+EulRAqF2O0=
X-Google-Smtp-Source: AGHT+IELY0MC36vUHdhERG9fTDpyDVJCq52mZrqgZ5Yft5r5LZf4O4BNOBEL3pfKKf9IS9BailC4vV6yAtmBLqepnfg=
X-Received: by 2002:a05:651c:549:b0:2cb:30e6:540d with SMTP id
 q9-20020a05651c054900b002cb30e6540dmr3874879ljp.76.1702665021696; Fri, 15 Dec
 2023 10:30:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201073240.T9bFNCkU@linutronix.de> <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
 <20231201161640.Z0cJLUi3@linutronix.de> <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
 <20231205153146.OSpCIs1G@linutronix.de> <CAEQmJ=iNVUuQQrm4bJgud=e7yhgwNb4Q1-BgOQF98D7NP9r29A@mail.gmail.com>
 <20231207103536.30ae05aa@gandalf.local.home> <CAEQmJ=jceiVevd9d3i4h0BHCNc8FFONJqEaiKyN9p21rg0QdkQ@mail.gmail.com>
 <20231207131811.08145840@gandalf.local.home> <20231208092616.LcwLlOyE@linutronix.de>
In-Reply-To: <20231208092616.LcwLlOyE@linutronix.de>
From: Yuanhan Zhang <zyhtheonly@gmail.com>
Date: Fri, 15 Dec 2023 13:30:10 -0500
Message-ID: <CAEQmJ=jOyntcD0Vw2AL6cH-ACD7TKbW7nqjMBmHB=EUjF1DUYA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, zyhtheonly@yeah.net, tglx@linutronix.de, 
	mingo@redhat.com, Venkatesh Pallipadi <venki@google.com>, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=B412=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 04:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2023-12-07 13:18:11 [-0500], Steven Rostedt wrote:
> > On Thu, 7 Dec 2023 12:19:28 -0500
> > Yuanhan Zhang <zyhtheonly@gmail.com> wrote:
> >
> > In irqtime_account_process_tick() there's:
> >
> >       if (this_cpu_ksoftirqd() =3D=3D p) {
> >               /*
> >                * ksoftirqd time do not get accounted in cpu_softirq_tim=
e.
> >                * So, we have to handle it separately here.
> >                * Also, p->stime needs to be updated for ksoftirqd.
> >                */
> >               account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
> >
> > Which to me looks like it is counting ksoftirqd for SOFTIRQ time. But
> > honestly, why do we care about that? What's the difference if ksoftirqd
> > were to run or softirqd were to pass work off to a workqueue?
> >
> > ksoftirqd runs in vanilla Linux as SCHED_OTHER. The work it does doesn'=
t
> > interrupt processes any more than any other kernel thread. I don't know=
 why
> > we make it "special".
>
> The special part is that it runs with disabled preemption the whole time
> and the scheduler can't do a thing about it. This is different on
> PREEMPT_RT where the softirq is preemptible and scheduler can replace it
> with another task if suited. It still runs as SCHED_OTHER. The ktimers/
> thread runs as SCHED_FIFO 1. So accounting it (incl. ksoftirqd) on
> SYSTEM is fine IMHO.

I send a [PATCH v4]
https://lore.kernel.org/lkml/20231211120209.GA25877@didi-ThinkCentre-M930t-=
N000/
for making ksoftirqd not special in PREEMPT_RT. It makes SYSTEM more
while SOFTIRQ less if we run softirqs on ksoftirqd (eg NET_*).

If you have further comments please let me know. Thanks a lot!

>
> > I guess the better question I need to ask is, what is this information =
used
> > for? I thought it was how much time was take away from tasks. As curren=
t
> > would be a task, and we do care if a real softirq is running, as we do =
not
> > want to add that to the current task accounting.
> >
> > But for ksoftirqd, that's not the case, and I don't really care if it's
> > running a softirq or not. As that time isn't interrupting actual tasks.=
 Not
> > to mention, one could simply look at the ksoftirqd tasks to see how muc=
h
> > time they take up.
>
> The original argument was to have the softirq counters right in
> /proc/stat. This is what I remember from the trip to the museum.
>
> > -- Steve
>
> Sebastian

