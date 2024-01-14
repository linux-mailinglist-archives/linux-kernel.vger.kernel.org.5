Return-Path: <linux-kernel+bounces-25466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDA82D0B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D952815E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28E2114;
	Sun, 14 Jan 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4+9TElV"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6B374
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dddf12f280so4199582a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705237532; x=1705842332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMGvKPofY5MOpXk13/yiBWLqSi/Ty5WsGrwDjyyvUgE=;
        b=F4+9TElVhlzLvaIp508Ktooj1XR/BkrNe6+BwbLgrgv8cHcYztaSWWqfHgane5BQl/
         VzgsgX6n7Z5tH8BAuD2DsyDn9uvUypI7bi0PBuPg0VFvy+5+qtINqn5FqwK/0Xsquxj5
         uh5vV3kopFfUG89wi1MAYKtFAoLwi/KoaIiZqzicK9UBE90exoqpB110uC6vseVToHZV
         mVYVgVjY+ENGaxpxlDacZI5QIU37LKMXJorc01TBZ9at//gWg6w0TtnUAhcC9ielrV5/
         kTsu20dNvKrvGtgf5Foj/IDLVq5Hn4UNwDlbbDT7T/gWIwzpm7kDbA+uXYX0Tjse6h0S
         TxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705237532; x=1705842332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMGvKPofY5MOpXk13/yiBWLqSi/Ty5WsGrwDjyyvUgE=;
        b=SJZvR3wIbn/2r247q31VaY1wj3ycfhAasHRxpRQ3LwriHHiDWFFkL1+O5th/721tXU
         ldZe9V40OWxDopI9K7ULVQUdzB+sD/n7L2phP+HqQNQd/YZoaCRl89Zzc3F2VPcsGYK/
         Fm79lrw27mybF1QWM0P2sqgtK7+EwhJCdfErzoR6AD+lrWjcREevtcFDQyYN+ygfUj3O
         oT0+oznLTRNYfQk3SvqWyR4UHC15bJe21tDy0xughVevO7AxXlixVzWBnZPagY2VP5xo
         GaV779Ducw1vS3/sYRmc6XDfsf18moS2qSfxkJ+KputJOBSvsk9QFueYJeZL1/FNnphm
         S5bw==
X-Gm-Message-State: AOJu0YwJBhciGex+2oBjyBTKoX9FPx3Hf8xj7cWFdcD7p4suT37Rh+np
	0J8UYDBrXQCOs3TeLHONlsoLp5YC6RAqtQXPqoGxG2deZ3CIuw==
X-Google-Smtp-Source: AGHT+IFu0DqfdEL2pbwtk/XR/VL48EolFlG6D4HB/lvjHnB11ldd1amMuKJzSdEWLdB639ArP/Uc8UdrPCh0311JXBM=
X-Received: by 2002:a05:6870:8999:b0:206:81c:4af5 with SMTP id
 f25-20020a056870899900b00206081c4af5mr6201815oaq.108.1705237531984; Sun, 14
 Jan 2024 05:05:31 -0800 (PST)
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
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <711c20cf-4aa7-4380-b076-195736bc4978@arm.com>
In-Reply-To: <711c20cf-4aa7-4380-b076-195736bc4978@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Jan 2024 14:05:20 +0100
Message-ID: <CAKfTPtA8dQoT404AzHE_O9sP+ecx0vpKG_2ErjgusSUWRUgXxQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Wyes Karny <wkarny@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Jan 2024 at 14:02, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 14/01/2024 13:37, Wyes Karny wrote:
> > On Sun, Jan 14, 2024 at 12:18:06PM +0100, Vincent Guittot wrote:
> >> Hi Wyes,
> >>
> >> Le dimanche 14 janv. 2024 =C3=AF=C2=BF=C2=BD 14:42:40 (+0530), Wyes Ka=
rny a =C3=AF=C2=BF=C2=BDcrit :
> >>> On Wed, Jan 10, 2024 at 02:57:14PM -0800, Linus Torvalds wrote:
> >>>> On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
> >>>> <torvalds@linux-foundation.org> wrote:
>
> [...]
>
> > Yeah, correct something was wrong in the bpftrace readings, max_cap is
> > not zero in traces.
> >
> >              git-5511    [001] d.h1.   427.159763: get_next_freq.constp=
rop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.163733: sugov_get_util: [DEB=
UG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.163735: get_next_freq.constp=
rop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.167706: sugov_get_util: [DEB=
UG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.167708: get_next_freq.constp=
rop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.171678: sugov_get_util: [DEB=
UG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.171679: get_next_freq.constp=
rop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.h1.   427.175653: sugov_get_util: [DEB=
UG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.h1.   427.175655: get_next_freq.constp=
rop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >              git-5511    [001] d.s1.   427.175665: sugov_get_util: [DEB=
UG] : util 1024, sg_cpu->util 1024
> >              git-5511    [001] d.s1.   427.175665: get_next_freq.constp=
rop.0: [DEBUG] : freq 1400000, util 1024, max 1024
> >
> > Debug patch applied:
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 95c3c097083e..5c9b3e1de7a0 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -166,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_poli=
cy *sg_policy,
> >
> >         freq =3D get_capacity_ref_freq(policy);
> >         freq =3D map_util_freq(util, freq, max);
> > +       trace_printk("[DEBUG] : freq %llu, util %llu, max %llu\n", freq=
, util, max);
> >
> >         if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_=
freq_update)
> >                 return sg_policy->next_freq;
> > @@ -199,6 +200,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu=
, unsigned long boost)
> >         util =3D max(util, boost);
> >         sg_cpu->bw_min =3D min;
> >         sg_cpu->util =3D sugov_effective_cpu_perf(sg_cpu->cpu, util, mi=
n, max);
> > +       trace_printk("[DEBUG] : util %llu, sg_cpu->util %llu\n", util, =
sg_cpu->util);
> >  }
> >
> >  /**
> >
> >
> > So, I guess map_util_freq going wrong somewhere.
>
> sugov_update_single_freq() -> get_next_freq() -> get_capacity_ref_freq()
>
> Is arch_scale_freq_invariant() true in both cases, so that
> get_capacity_ref_freq() returns 'policy->cpuinfo.max_freq' and not just
> 'policy->cur'?

That's also my assumption and the change that I sent shoulf fix it

>

