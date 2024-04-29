Return-Path: <linux-kernel+bounces-162718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1B8B5F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA0D283F63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0586279;
	Mon, 29 Apr 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4asB7LY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523F86136;
	Mon, 29 Apr 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410136; cv=none; b=T4NfknMtFSwWBbetzV+Qyqp6eq+5yyokCwXIsrW4cAyma5aXs9DmAqTbx/tFE2Dq5Dj7bb3Vz6WRGnkjmf+4H52ihxl/REVhAtwq3ykWGLFdqgytqo5dHE7xkTfFzMd7/ui/AdM14yrshvLpcVltoLsO+ruBfSwmnZPLS+m379U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410136; c=relaxed/simple;
	bh=mf+Frf7fl4octShqGzqgSvfIMtLGvDDcUQwMkYwh52w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7GZhmub1F3M6OSZ0xVcIFlMcmxGNq180ING5E3ciLlETV0kimWJHdh2EDsn2M5XQ5IaPIMxU0ig5YAFIoZf7YAScZ3DHdM/WFEOf+gP21af/Tk3MBM8Mvj+7LZtb3SjrnbGnBfLhkYHA4RALSCTgy2ul9oSTMwJlu2PC8C9VJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4asB7LY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49588C113CD;
	Mon, 29 Apr 2024 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714410136;
	bh=mf+Frf7fl4octShqGzqgSvfIMtLGvDDcUQwMkYwh52w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N4asB7LYM7edUrYg20DFQhFxA5xHp7KBeRiplnxz42b/zY597qXOefd92XaaFjLX7
	 SjUxtQRFjNs8cIIJoxAN36VhzCgvUz39Vzk/7tidvIZP7DBf31OF7jk1f+cZA6FPPL
	 Vpt7jxNDq5vYzSMC+xYn+uartn7aX7P8rR4D6rV0nqiQf9UqOERu8uaVCMybeMbhYG
	 EAsIZr1KG/KbhgdqpKv0qlipw04BC5TuWX3Uqa3ikgQ4sHQcFaQECH3IsYf3JDq2+p
	 B8krtSnmepcwItO2p50wzQDxv3YqxZZH/LVNGgpvUtFD1ZSyzzdC3jC39Kt4ZxNtsD
	 NPkPZ0NmU6saQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5afbcf8059cso92494eaf.1;
        Mon, 29 Apr 2024 10:02:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6zCKVv2gj1Fqg0G/W5ia1H2cSE6G9MlGs7ccrnzUtUZKo/Jzdq+2CfAfSua3/SJr3U5kFvtBg6dMZZ66O5i5FEDfKuHn0gl4eCa++7WqKOn4GuoT3eVlKM/ZZF7e577vhJy0Aarw=
X-Gm-Message-State: AOJu0YxjxceqjjLcT/FwlkqsU1BpJOK0+tDbSDNdtj60F2WNQpxNiJ6D
	7GDeRPJ8L7V5+YXwBZ6Ca5q0AX505CFYmVhIYrwEXZb0qQxTbnBCOVhtfShKj1mpvSoSsSGbNAD
	CRVdpAwFrlSIOiDfvYPWS5ZuXsms=
X-Google-Smtp-Source: AGHT+IEh2603NEh5eaK6jZwLSv1i7q/5BJhdB7/G6wwWs0YkMLMlL5+osmYaEIGLHGAdsZBuodNgU3JUvs+l6m1bFE8=
X-Received: by 2002:a4a:a882:0:b0:5aa:241a:7f4b with SMTP id
 q2-20020a4aa882000000b005aa241a7f4bmr12779394oom.1.1714410135568; Mon, 29 Apr
 2024 10:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020> <87zfth3l6y.fsf@somnus>
 <CAJZ5v0g_GKF8-QK5UdFCpJapf+MK7EouQ7hMTVtPYRjNNyUt+g@mail.gmail.com>
 <3aba1a1d-8ebc-4ee0-9caf-d9baae586db7@arm.com> <87zftcy0xt.fsf@somnus> <87sez4xxhn.fsf@somnus>
In-Reply-To: <87sez4xxhn.fsf@somnus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Apr 2024 19:02:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLNWu6K2vhA3j==rbeHjku6eOvuWymRGcux4V9Xx_7Uw@mail.gmail.com>
Message-ID: <CAJZ5v0iLNWu6K2vhA3j==rbeHjku6eOvuWymRGcux4V9Xx_7Uw@mail.gmail.com>
Subject: Re: [linus:master] [timers] 7ee9887703: stress-ng.uprobe.ops_per_sec
 -17.1% regression
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, 
	Frederic Weisbecker <frederic@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:40=E2=80=AFPM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
>
> > Hi,
> >
> > Lukasz Luba <lukasz.luba@arm.com> writes:
> >> On 4/26/24 17:03, Rafael J. Wysocki wrote:
> >>> On Thu, Apr 25, 2024 at 10:23=E2=80=AFAM Anna-Maria Behnsen
> >>> <anna-maria@linutronix.de> wrote:
> >
> > [...]
> >
> >>>> So my assumption here is, that cpuidle governors assume that a deepe=
r
> >>>> idle state could be choosen and selecting the deeper idle state make=
s an
> >>>> overhead when returning from idle. But I have to notice here, that I=
'm
> >>>> still not familiar with cpuidle internals... So I would be happy abo=
ut
> >>>> some hints how I can debug/trace cpuidle internals to falsify or ver=
ify
> >>>> this assumption.
> >>>
> >>> You can look at the "usage" and "time" numbers for idle states in
> >>>
> >>> /sys/devices/system/cpu/cpu*/cpuidle/state*/
> >>>
> >>> The "usage" value is the number of times the governor has selected th=
e
> >>> given state and the "time" is the total idle time after requesting th=
e
> >>> given state (ie. the sum of time intervals between selecting that
> >>> state by the governor and wakeup from it).
> >>>
> >>> If "usage" decreases for deeper (higher number) idle states relative
> >>> to its value for shallower (lower number) idle states after applying
> >>> the test patch, that will indicate that the theory is valid.
> >>
> >> I agree with Rafael here, this is the first thing to check, those
> >> statistics. Then, when you see difference in those stats in baseline
> >> vs. patched version, we can analyze the internal gov decisions
> >> with help of tracing.
> >>
> >> Please also share how many idle states is in those testing platforms.
> >
> > Thanks Rafael and Lukasz, for the feedback here!
> >
> > So I simply added the state usage values for all 112 CPUs and calculate=
d
> > the diff before and after the stress-ng call. The values are from a
> > single run.
> >
>
> Now here are the values of the states and the time because I forgot to
> track also the time in the first run:
>
> USAGE           good            bad             bad+patch
>                 ----            ---             ---------
> state0          115             137             234
> state1          450680          354689          420904
> state2          3092092         2687410         3169438
>
>
> TIME            good            bad             bad+patch
>                 ----            ---             ---------
> state0          9347            9683            18378
> state1          626029557       562678907       593350108
> state2          6130557768      6201518541      6150403441
>
>
> > good: 57e95a5c4117 ("timers: Introduce function to check timer base
> >         is_idle flag")
> > bad:    v6.9-rc4
> > bad+patch: v6.9-rc4 + patch
> >
> > I choosed v6.9-rc4 for "bad", to make sure all the timer pull model fix=
es
> > are applied.
> >
> > If I got Raphael right, the values indicate, that my theory is not
> > right...

It appears so.

However, the hardware may refuse to enter a deeper idle state in some cases=
.

It would be good to run the test under turbostat and see what happens
to hardware C-state residencies.  I would also like to have a look at
the CPU frequencies in use in all of the cases above.

> ... but with the time values: CPUs are less often but in total longer in =
state2.

I have divided the total residency numbers above by the corresponding
usage numbers and got the below:

state1:   1389,08         1586,40        1409,70
state2:   1982,66         2307,62        1940,53

for "good", "bad" and "bad+patch" , respectively.

This shows that, on the average, after entering an idle state, a CPU
spends more time in it in the "bad" case than in the other cases.

To me, this means that, on the average, in the "bad" case there are
fewer wakeups from idle states (or IOW the wakeups occur less
frequently) and that seems to affect the benchmark in question
adversely.

Thanks!

