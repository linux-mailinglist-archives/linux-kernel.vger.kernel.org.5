Return-Path: <linux-kernel+bounces-25655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6482D42E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAE1C21078
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90883C3B;
	Mon, 15 Jan 2024 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfmLDcUh"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD13C0B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso6384949a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705299916; x=1705904716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVKYXAtlG1NhIdc9ro4+8eFxw3bRne6O3DtIFZICp6A=;
        b=nfmLDcUhTJ+VG68xkYDysWruQyNQmTYZiOUyzJTTzFIK3/LCYa3QCg9qKJE8AUSlov
         u5ZZ02IvEWuBrlkfWoRS0T+gOUap+WtRS7M63ZhmaZCj31PK1wPjhLlZavqXxPkpp71c
         FifqSFWvzA4GIj/PArgcqovy+mKX8GTEScHjQ5dj0xLuGTCxZJ7jkDyrSOQNWrui2fWh
         yBcQawnqpCGnEuC0qTC9ZXghYY9kVW0PgIbUJcibZXjW1YzzC+u1hL49qrohxpDJH3yV
         kEH37WyugMA4JDJotF1UZXiXvE5amb3HqycfRV9+0qgt0c9o9S/0n80tG/xBxbPrWcXK
         zGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705299916; x=1705904716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVKYXAtlG1NhIdc9ro4+8eFxw3bRne6O3DtIFZICp6A=;
        b=ny/sQMN3xFRcDNSGJFhCEta9VIobjCcs7WhQyerZl75qnva2LdbcN6LgGTUqRJn52p
         zKdgkjssl8Z4b3x8tLsAnlGAJK6jTyOh6pKl+U/ZSY7a0RFAMwooPdU2otcOEAOavtiN
         rBA76nmnSk0nDuoRyE7gIMO2Zuw3jxsnVtZ5YrjP3gXlO1MLQiK3fF0NsRttepxwAD9J
         Ssswhq0CGv9EvVa6K2ceaaqkEPw1I1jXbgt7weeotegjVRFBoyiwMsj4gF3WOQVacdMa
         D9arHL5F/4ozgTCa2Eyd9jtOF/IqYgdtA4GBH/0DDOHr5YZi/jqhhT3tFTK+QRTGXneV
         Og/w==
X-Gm-Message-State: AOJu0YyplNqtYfdqNGuW338gj8e+RIJ0u+bGsj189ZnOlSIJtYYdwTEM
	tggEhyivAiisJWW+kh+yesar0mZp/IT5ng/eqt8=
X-Google-Smtp-Source: AGHT+IF2B9DQP1WW+6Eke4AIaQtFXZB8BmAXub3Mxp/GyjqLFYzOfAiU9WrZmqu+Dh70kaoTO4Wz7XB4CtNKcdLydd8=
X-Received: by 2002:a05:6a20:938d:b0:199:a43f:db4 with SMTP id
 x13-20020a056a20938d00b00199a43f0db4mr5221320pzh.80.1705299915906; Sun, 14
 Jan 2024 22:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <20240114091240.xzdvqk75ifgfj5yx@wyes-pc> <ZaPC7o44lEswxOXp@vingu-book>
 <20240114123759.pjs7ctexcpc6pshl@wyes-pc> <CAKfTPtCz+95dR38c_u6_7JbkVt=czj5N2dKYVV-zk9dgbk16hw@mail.gmail.com>
 <20240114151250.5wfexq44o3mdm3nh@airbuntu> <CAKfTPtAMxiTbvAYav1JQw+MhjzDPCZDrMLL2JOfsc0GWp+FnOA@mail.gmail.com>
 <20240114195815.nes4bn53tc25djbh@airbuntu> <20240114233728.hrmyelo66beaajhp@airbuntu>
In-Reply-To: <20240114233728.hrmyelo66beaajhp@airbuntu>
From: Wyes Karny <wkarny@gmail.com>
Date: Mon, 15 Jan 2024 11:55:04 +0530
Message-ID: <CAAE01kGAdczPmWZ5VqrF397FeOHexWfHDi9eYXv8LogDbuWiHQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qais,

On Mon, Jan 15, 2024 at 5:07=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 01/14/24 19:58, Qais Yousef wrote:
>
> > > This is not correct because you will have to wait to reach full
> > > utilization at the current OPP possibly the lowest OPP before moving
> > > directly to max OPP
> >
> > Isn't this already the case? The ratio (util+headroom/max) will be less=
 than
> > 1 until util is 80% (with 25% headroom). And for all values <=3D 80% * =
max, we
> > will request a frequency smaller than/equal policy->cur, no?
> >
> > ie:
> >
> >       util =3D 600
> >       max =3D 1024
> >
> >       freq =3D 1.25 * 600 * policy->cur / 1024 =3D 0.73 * policy->cur
> >
> > (util+headroom/max) must be greater than 1 for us to start going above
> > policy->cur - which seems to have been working by accident IIUC.
> >
> > So yes my proposal is incorrect, but it seems the conversion is not rig=
ht to me
> > now.
> >
> > I could reproduce the problem now (thanks Wyes!). I have 3 freqs on my =
system
> >
> > 2.2GHz, 2.8GHz and 3.8GHz
> >
> > which (I believe) translates into capacities
> >
> > ~592, ~754, 1024
> >
> > which means we should pick 2.8GHz as soon as util * 1.25 > 592; which
> > translates into util =3D ~473.
> >
> > But what I see is that we go to 2.8GHz when we jump from 650 to 680 (se=
e
> > attached picture), which is what you'd expect since we apply two headro=
oms now,
> > which means the ratio (util+headroom/max) will be greater than 1 after =
go above
> > this value
> >
> >       1024 * 0.8 * 0.8 =3D ~655
> >
> > So I think the math makes sense logically, but we're missing some other
> > correction factor.
> >
> > When I re-enable CPPC I see for the same test that we go into 3.8GHz st=
raight
> > away. My test is simple busyloop via
> >
> >       cat /dev/zero > /dev/null
> >
> > I see the CPU util_avg is at 523 at fork. I expected us to run to 2.8GH=
z here
> > to be honest, but I am not sure if util_cfs_boost() and util_est() are =
maybe
> > causing us to be slightly above 523 and that's why we start with max fr=
eq.
> >
> > Or I've done the math wrong :-) But the two don't behave the same for t=
he same
> > kernel with and without CPPC.
>
> I think the relationship should be:
>
>         freq =3D util * f_curr / cap_curr

I guess to know the curr_cap correctly we need to know the max_freq,
which is not available when CPPC is disabled.

>
> (patch below)
>
> with that I see (almost) the expected behavior (picture attached). We go =
to
> 2.8GHz when we are above 500. But the move to 3.8GHz is a bit earlier at =
581
> (instead of 754 * 0.8 =3D 603). Not sure why. With 25% headroom 581 is 72=
6. So
> it's a tad too early.
>
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 95c3c097083e..155f96a44fa0 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -123,7 +123,8 @@ static void sugov_deferred_update(struct sugov_policy=
 *sg_policy)
>   * Return: the reference CPU frequency to compute a capacity.
>   */
>  static __always_inline
> -unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy,
> +                                   unsigned long *max)
>  {
>         unsigned int freq =3D arch_scale_freq_ref(policy->cpu);
>
> @@ -133,6 +134,9 @@ unsigned long get_capacity_ref_freq(struct cpufreq_po=
licy *policy)
>         if (arch_scale_freq_invariant())
>                 return policy->cpuinfo.max_freq;
>
> +       if (max)
> +               *max =3D policy->cur * (*max) / policy->cpuinfo.max_freq;

But when freq_invaiant is disabled we don't have policy->cpuinfo.max_freq.

Thanks,
Wyes
> +
>         return policy->cur;
>  }
>
> @@ -164,7 +168,7 @@ static unsigned int get_next_freq(struct sugov_policy=
 *sg_policy,
>         struct cpufreq_policy *policy =3D sg_policy->policy;
>         unsigned int freq;
>
> -       freq =3D get_capacity_ref_freq(policy);
> +       freq =3D get_capacity_ref_freq(policy, &max);
>         freq =3D map_util_freq(util, freq, max);
>
>         if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)



--=20
Thanks & Regards
Wyes

