Return-Path: <linux-kernel+bounces-25465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04082D0B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C941C20C96
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091675238;
	Sun, 14 Jan 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijUt3KF+"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36B5220
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5989d8decbfso2388661eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705237406; x=1705842206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qqh2y+lHV7bVaOxtw3SBz+dkgV4s1P1paR9MHzY3jg=;
        b=ijUt3KF+VFo0JImHHc0we81oxNW7AeipV+k154p/L9ziR2/diWtxWUhtTf9vA6g0rP
         IbclVwQKxXqD4FdkHZHbJ25Q+axwT4dwfaOrbDW1bXXxqEEbv7JKc3CrdaAW2XFwdRyr
         ZRrMRQ7/Z7U2qeioN8iWC+yIQ3EUZ3EdkH8h5+NaqXnHwqAMHJ7qUQ7RGVOY8kgImmtr
         oBRPmBqW1hDXOl7FsfWtXGMpY2VUYfRuXdM72EWcuScnsJxqpnQuMzhHeK7Cm/T3c7S5
         ko4M/B2BDr2ugdZ1WPEriVwAuChZitTQlYQjdaa0o9rO6Cf3gednwMB0CxUtosjmIeOl
         T2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705237406; x=1705842206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qqh2y+lHV7bVaOxtw3SBz+dkgV4s1P1paR9MHzY3jg=;
        b=ajeZw96O1b/ORJnoo0NEw4Y2kvTegWFi2wuX2UD2ett8N5Rkltzvc+ayhBQIePB/PR
         d9sW0qDBZma70Y6sMQUEglSmSqILJfVu/iq71Y7UPJ4xqdX4PhzqAOzKnGDBZ4EOdevW
         C0z1sWzNS7KatEI8OvqBI8wEE57CrSTZVLih2w6bAUjmJtPPv0DEjzCSqkZNAJ+tbkYa
         aLTmJqw4bxk4gurEUSq6UcpIOQfZG4XrwHoBf7NunGe3RtfzLdyQcdsc14KX2dqLvKO2
         jD63bP6UpMMxjjO2zZ9Hw6mqt4hNXy7hh3D0J14tNXZmh5UvoU2huciuoFbl3uHJA6Ch
         Vyew==
X-Gm-Message-State: AOJu0YxSUM6IVr1qGMHzGoPIOm+J0lGdiJ58A65h/rUjn2pxOrolWQxb
	jtFgRKPFAnfsicN5iMwSjWKbFDY4kt7H5IzCn5bovJB5Au3n8A==
X-Google-Smtp-Source: AGHT+IHGadYlOr+qpIuS2unLrtCdjKKAsgvlLqXTy/J2gwMUEpPLur2dHqtComirkNrfD7m/S5jaKpQVZ4jCjNVOZH0=
X-Received: by 2002:a05:6358:70c3:b0:175:c187:c1f with SMTP id
 h3-20020a05635870c300b00175c1870c1fmr6031515rwh.45.1705237406261; Sun, 14 Jan
 2024 05:03:26 -0800 (PST)
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
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book> <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
In-Reply-To: <20240114123759.pjs7ctexcpc6pshl@wyes-pc>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Jan 2024 14:03:14 +0100
Message-ID: <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
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

On Sun, 14 Jan 2024 at 13:38, Wyes Karny <wkarny@gmail.com> wrote:
>
> On Sun, Jan 14, 2024 at 12:18:06PM +0100, Vincent Guittot wrote:
> > Hi Wyes,
> >
> > Le dimanche 14 janv. 2024 =C3=A0 14:42:40 (+0530), Wyes Karny a =C3=A9c=
rit :
> > > On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
> > > > On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > It's one of these two:
> > > > >
> > > > >   f12560779f9d sched/cpufreq: Rework iowait boost
> > > > >   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performan=
ce estimation
> > > > >
> > > > > one more boot to go, then I'll try to revert whichever causes my
> > > > > machine to perform horribly much worse.
> > > >
> > > > I guess it should come as no surprise that the result is
> > > >
> > > >    9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad commit
> > > >
> > > > but to revert cleanly I will have to revert all of
> > > >
> > > >       b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequ=
ency")
> > > >       f12560779f9d ("sched/cpufreq: Rework iowait boost")
> > > >       9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> > > > performance estimation")
> > > >
> > > > This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw=
.
> > > >
> > > > I'll keep that revert in my private test-tree for now (so that I ha=
ve
> > > > a working machine again), but I'll move it to my main branch soon
> > > > unless somebody has a quick fix for this problem.
> > >
> > > Hi Linus,
> > >
> > > I'm able to reproduce this issue with my AMD Ryzen 5600G system.  But
> > > only if I disable CPPC in BIOS and boot with acpi-cpufreq + schedutil=
.
> > > (I believe for your case also CPPC is diabled as log "_CPC object is =
not
> > > present" came). Enabling CPPC in BIOS issue not seen in my system.  F=
or
> > > AMD acpi-cpufreq also uses _CPC object to determine the boost ratio.
> > > When CPPC is disabled in BIOS something is going wrong and max
> > > capacity is becoming zero.
> > >
> > > Hi Vincent, Qais,
> > >

..

> >
> > There is something strange that I don't understand
> >
> > Could you trace on the return of sugov_get_util()
> > the value of sg_cpu->util ?
>
> Yeah, correct something was wrong in the bpftrace readings, max_cap is
> not zero in traces.
>
>              git-5511    [001] d.h1.   427.159763: get_next_freq.constpro=
p.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.163733: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.163735: get_next_freq.constpro=
p.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.167706: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.167708: get_next_freq.constpro=
p.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.171678: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.171679: get_next_freq.constpro=
p.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.h1.   427.175653: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.h1.   427.175655: get_next_freq.constpro=
p.0: [DEBUG] : freq 1400000, util 1024, max 1024
>              git-5511    [001] d.s1.   427.175665: sugov_get_util: [DEBUG=
] : util 1024, sg_cpu->util 1024
>              git-5511    [001] d.s1.   427.175665: get_next_freq.constpro=
p.0: [DEBUG] : freq 1400000, util 1024, max 1024
>
> Debug patch applied:
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 95c3c097083e..5c9b3e1de7a0 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -166,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_policy=
 *sg_policy,
>
>         freq =3D get_capacity_ref_freq(policy);
>         freq =3D map_util_freq(util, freq, max);
> +       trace_printk("[DEBUG] : freq %llu, util %llu, max %llu\n", freq, =
util, max);
>
>         if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)
>                 return sg_policy->next_freq;
> @@ -199,6 +200,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, =
unsigned long boost)
>         util =3D max(util, boost);
>         sg_cpu->bw_min =3D min;
>         sg_cpu->util =3D sugov_effective_cpu_perf(sg_cpu->cpu, util, min,=
 max);
> +       trace_printk("[DEBUG] : util %llu, sg_cpu->util %llu\n", util, sg=
_cpu->util);
>  }
>
>  /**
>
>
> So, I guess map_util_freq going wrong somewhere.

Thanks for the trace. It was really helpful and I think that I got the
root cause.

The problem comes from get_capacity_ref_freq() which returns current
freq when arch_scale_freq_invariant() is not enable, and the fact that
we apply map_util_perf() earlier in the path now which is then capped
by max capacity.

Could you try the below ?

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedu=
til.c
index e420e2ee1a10..611c621543f4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -133,7 +133,7 @@ unsigned long get_capacity_ref_freq(struct
cpufreq_policy *policy)
        if (arch_scale_freq_invariant())
                return policy->cpuinfo.max_freq;

-       return policy->cur;
+       return policy->cur + policy->cur >> 2;
 }

 /**



>
> Thanks,
> Wyes
> >
> > Thanks for you help
> > Vincent
> >
> > >
> > > Thanks,
> > > Wyes
> > >

