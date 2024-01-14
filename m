Return-Path: <linux-kernel+bounces-25526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD182D1D6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB835B212D7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED810101D2;
	Sun, 14 Jan 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkkt8fYH"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6A5243
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3608e206f27so43626095ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 10:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705256342; x=1705861142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuXHY6yzzsfSBDj3dqAwz/QGnUCzrlfuElia7ghy03E=;
        b=hkkt8fYH47DqmHUvIfzVdSrJLsTQ91WaheolClZ5MwVr42xOSMR4B3EwptY7VEsDiF
         H+ALq1DZgEZii53S9xjV8bBczA4FbzwaD5BNxtx9sAskWDWpH1S21cQdYWD8dLmzd59P
         hrtp79EElOUx24t+3TGcLLct+E3FQ3oBb/7gEziIZXHpmY/H/gi483fPO19adPSvlUg7
         iDQT8QHVXwGtcjms3dLzmqTZVw4riOElvHP3Q2tgtXVh5UIh7FI4JnVU6llR1sMoCWpv
         dzVCifI201QrvWdYk4p2yYiJuZ/b82uZYzBkN/Zcq1q2PhwPdcasXhprhC1A9Sz0G7yn
         zh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705256342; x=1705861142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuXHY6yzzsfSBDj3dqAwz/QGnUCzrlfuElia7ghy03E=;
        b=uwjxsVAdn3s1Cv9KvVg1VtU1Gt6gFYZTZj6cK5T1+L/TD4UMYqjxxdZY3lLc5+AOhy
         2QZKcMUkZu9+H5j12yru63VauMP3ThAwOoXMamWgjBNYEUrQTS75/rqqS8yJSfODHw/v
         V9HHrQKuw3aHCLBsWgfI4CbQV4frb9ZeH2Fn+ayIFLbANbUeWrDycGJwRKmS6729hRHS
         YcUIexkOSOP0rLr/VNh6vXYOq/YBWe6+FJ/g36YJ0JiU5ffO5/i6eIK1FtKjjEAPavBk
         3h667HRNKUGk3v0O8YGw/GPcPIpM8xzKvwbGFt/Bhry46691ZmPoQMwVcZru4IjvEVix
         KIGg==
X-Gm-Message-State: AOJu0YxoYk9enag9IXy006YP2tpE4vaIfDE/JjcP/NxKafLGQc280fYf
	mTwYQ2zA2JCTVgL5evCwQTdeaV7FFPmg5V9jhoraditxAzYBcA==
X-Google-Smtp-Source: AGHT+IFCpQS40quPjrdbIy32+f1qAdS2EEoTcMrc9naf8ZjqUAOZf5WbvR0bRvcpgGSAaQ450j3a1cX89K0BKMCHGIk=
X-Received: by 2002:a92:c5ac:0:b0:360:6d62:17de with SMTP id
 r12-20020a92c5ac000000b003606d6217demr5405030ilt.40.1705256342485; Sun, 14
 Jan 2024 10:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114181103.osrjpvtibmy7cmcq@wyes-pc>
In-Reply-To: <20240114181103.osrjpvtibmy7cmcq@wyes-pc>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Jan 2024 19:18:51 +0100
Message-ID: <CAKfTPtAFKUBn2eBMnq9U-Mgy70J9Po698suKiBWYPWkYqwp6ig@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Wyes Karny <wkarny@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Jan 2024 at 19:11, Wyes Karny <wkarny@gmail.com> wrote:
>
> On Sun, Jan 14, 2024 at 02:03:14PM +0100, Vincent Guittot wrote:
> > On Sun, 14 Jan 2024 at 13:38, Wyes Karny <wkarny@gmail.com> wrote:
> > >
> > > On Sun, Jan 14, 2024 at 12:18:06PM +0100, Vincent Guittot wrote:
> > > > Hi Wyes,
> > > >
> > > > Le dimanche 14 janv. 2024 =C3=A0 14:42:40 (+0530), Wyes Karny a =C3=
=A9crit :
> > > > > On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
> > > > > > On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > >
> > > > > > > It's one of these two:
> > > > > > >
> > > > > > >   f12560779f9d sched/cpufreq: Rework iowait boost
> > > > > > >   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor perfo=
rmance estimation
> > > > > > >
> > > > > > > one more boot to go, then I'll try to revert whichever causes=
 my
> > > > > > > machine to perform horribly much worse.
> > > > > >
> > > > > > I guess it should come as no surprise that the result is
> > > > > >
> > > > > >    9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad co=
mmit
> > > > > >
> > > > > > but to revert cleanly I will have to revert all of
> > > > > >
> > > > > >       b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference f=
requency")
> > > > > >       f12560779f9d ("sched/cpufreq: Rework iowait boost")
> > > > > >       9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> > > > > > performance estimation")
> > > > > >
> > > > > > This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, =
fwiw.
> > > > > >
> > > > > > I'll keep that revert in my private test-tree for now (so that =
I have
> > > > > > a working machine again), but I'll move it to my main branch so=
on
> > > > > > unless somebody has a quick fix for this problem.
> > > > >
> > > > > Hi Linus,
> > > > >
> > > > > I'm able to reproduce this issue with my AMD Ryzen 5600G system. =
 But
> > > > > only if I disable CPPC in BIOS and boot with acpi-cpufreq + sched=
util.
> > > > > (I believe for your case also CPPC is diabled as log "_CPC object=
 is not
> > > > > present" came). Enabling CPPC in BIOS issue not seen in my system=
  For
> > > > > AMD acpi-cpufreq also uses _CPC object to determine the boost rat=
io.
> > > > > When CPPC is disabled in BIOS something is going wrong and max
> > > > > capacity is becoming zero.
> > > > >
> > > > > Hi Vincent, Qais,
> > > > >
> >
> > ...
> >
> > > >
> > > > There is something strange that I don't understand
> > > >
> > > > Could you trace on the return of sugov_get_util()
> > > > the value of sg_cpu->util ?
> > >
> > > Yeah, correct something was wrong in the bpftrace readings, max_cap i=
s
> > > not zero in traces.
> > >
> > >              git-5511    [001] d.h1.   427.159763: get_next_freq.cons=
tprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> > >              git-5511    [001] d.h1.   427.163733: sugov_get_util: [D=
EBUG] : util 1024, sg_cpu->util 1024
> > >              git-5511    [001] d.h1.   427.163735: get_next_freq.cons=
tprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> > >              git-5511    [001] d.h1.   427.167706: sugov_get_util: [D=
EBUG] : util 1024, sg_cpu->util 1024
> > >              git-5511    [001] d.h1.   427.167708: get_next_freq.cons=
tprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> > >              git-5511    [001] d.h1.   427.171678: sugov_get_util: [D=
EBUG] : util 1024, sg_cpu->util 1024
> > >              git-5511    [001] d.h1.   427.171679: get_next_freq.cons=
tprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> > >              git-5511    [001] d.h1.   427.175653: sugov_get_util: [D=
EBUG] : util 1024, sg_cpu->util 1024
> > >              git-5511    [001] d.h1.   427.175655: get_next_freq.cons=
tprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> > >              git-5511    [001] d.s1.   427.175665: sugov_get_util: [D=
EBUG] : util 1024, sg_cpu->util 1024
> > >              git-5511    [001] d.s1.   427.175665: get_next_freq.cons=
tprop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> > >
> > > Debug patch applied:
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_=
schedutil.c
> > > index 95c3c097083e..5c9b3e1de7a0 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -166,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_po=
licy *sg_policy,
> > >
> > >         freq =3D get_capacity_ref_freq(policy);
> > >         freq =3D map_util_freq(util, freq, max);
> > > +       trace_printk("[DEBUG] : freq %llu, util %llu, max %llu\n", fr=
eq, util, max);
> > >
> > >         if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->nee=
d_freq_update)
> > >                 return sg_policy->next_freq;
> > > @@ -199,6 +200,7 @@ static void sugov_get_util(struct sugov_cpu *sg_c=
pu, unsigned long boost)
> > >         util =3D max(util, boost);
> > >         sg_cpu->bw_min =3D min;
> > >         sg_cpu->util =3D sugov_effective_cpu_perf(sg_cpu->cpu, util, =
min, max);
> > > +       trace_printk("[DEBUG] : util %llu, sg_cpu->util %llu\n", util=
, sg_cpu->util);
> > >  }
> > >
> > >  /**
> > >
> > >
> > > So, I guess map_util_freq going wrong somewhere.
> >
> > Thanks for the trace. It was really helpful and I think that I got the
> > root cause.
> >
> > The problem comes from get_capacity_ref_freq() which returns current
> > freq when arch_scale_freq_invariant() is not enable, and the fact that
> > we apply map_util_perf() earlier in the path now which is then capped
> > by max capacity.
> >
> > Could you try the below ?
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index e420e2ee1a10..611c621543f4 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct
> > cpufreq_policy *policy)
> >         if (arch_scale_freq_invariant())
> >                 return policy->cpuinfo.max_freq;
> >
> > -       return policy->cur;
> > +       return policy->cur + policy->cur >> 2;
> >  }
> >
> >  /**
>
> Issue seems to be fixed with this (but bit modified by me for arithmetic =
precedence):

Ok, thanks for your test

>
> patch:
>
> @@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct cpufreq_po=
licy *policy)
>         if (arch_scale_freq_invariant())
>                 return policy->cpuinfo.max_freq;
>
> -       return policy->cur;
> +       return policy->cur + (policy->cur >> 2);

fair enough
I prepare a patch with the fix and will add your Tested-by

Thanks for your help

>  }
>
>  /**
>
> trace:
>             make-7912    [001] d..2.   182.070005: sugov_get_util: [DEBUG=
] : util 595, sg_cpu->util 743
>             make-7912    [001] d..2.   182.070006: get_next_freq.constpro=
p.0: [DEBUG] : freq 3537231, util 743, max 1024
>               sh-7956    [001] d..2.   182.070494: sugov_get_util: [DEBUG=
] : util 835, sg_cpu->util 1024
>               sh-7956    [001] d..2.   182.070495: get_next_freq.constpro=
p.0: [DEBUG] : freq 4875000, util 1024, max 1024
>               sh-7956    [001] d..2.   182.070576: sugov_get_util: [DEBUG=
] : util 955, sg_cpu->util 1024
>               sh-7956    [001] d..2.   182.070576: get_next_freq.constpro=
p.0: [DEBUG] : freq 4875000, util 1024, max 1024
>               sh-7957    [001] d.h1.   182.072120: sugov_get_util: [DEBUG=
] : util 990, sg_cpu->util 1024
>               sh-7957    [001] d.h1.   182.072121: get_next_freq.constpro=
p.0: [DEBUG] : freq 4875000, util 1024, max 1024
>               nm-7957    [001] dNh1.   182.076088: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>               nm-7957    [001] dNh1.   182.076089: get_next_freq.constpro=
p.0: [DEBUG] : freq 4875000, util 1024, max 1024
>             grep-7958    [001] d..2.   182.076833: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>
>
> Thanks,
> Wyes

