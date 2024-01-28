Return-Path: <linux-kernel+bounces-41906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2B83F96E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40781F2180B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8900B3C480;
	Sun, 28 Jan 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF4DqdLM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA73C099;
	Sun, 28 Jan 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470388; cv=none; b=SGhMcauv4guuTqz5C+I3JrTR/nLyXM3R8XcTROj3VsCwWWo/UrbXHn4ZjATKtV5kNg89TAff2H4PjYYJixH08VdSDdiTqv5Ipm4FhQIcZFDgQpYI65awtQHXpuJYi5CLZXA96vmTCWdZeWOe8d3521KhPSywFRhb4unQw7USLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470388; c=relaxed/simple;
	bh=Xmz9jJznef0bJau3ITixlhc9EUCkP/PYtze5OvGTC/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2GffxR0yKxkH+LxqojROrDp9wvatv8u92uZS7L3JzmSS0g6+6FtcO7BjmKhz08si6P+X6xBZ8tvckxSX9BHz7y96MUolGiVdTg7VbC5Z2zca7x6JH69UVHF18NxnOeVj2SlUycDH/1vcsLDn1WiVYVFItTDUUokEVgIojFV7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF4DqdLM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30e445602cso653090466b.0;
        Sun, 28 Jan 2024 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706470385; x=1707075185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQHeChPVjMMeOEPpNz1KpoN86NgSZSy5B35jMIacLls=;
        b=QF4DqdLMpGrS53FLjyAht9jeXJHuFbVpJfNi271uDGXErNbI0La0Hfg+N/JA4MWzuH
         HEwkmv5nFCCs1muUfzl18MRCA+z/1AVUYVzu0PK7+v1iTuUJO/mmtoRx7OhFIqUgUlSH
         uZIJiFjvhcoUijsMG1B2TJAtg4EmIb+E38EUSk7m2t2HvfFYUohZFc0oBQzgETcEvrsd
         MzqGrIfNuNf+kSUOMDWMpUtR7BcD1cYpGRX2DhzZ2iL/2qRU2R6vThy+pLYzh2o2kkj1
         cu3L4PS1EYqhqURrmpbnrlzj+U9jlEtSy5nFdO+dF6b5btZfQs2j/wqqP0GQ7SsHRhf9
         p8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706470385; x=1707075185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQHeChPVjMMeOEPpNz1KpoN86NgSZSy5B35jMIacLls=;
        b=BsWZT/powRq0FRRrF+4at8IX2005BojmsjIF0YaWO03rQ4HUG2B1SayftSgCqsB9wT
         MLbRMYqXI9lMBUfOAh5/goiemrkqrxAfUJevIfxD4AH+PNO+jpkCb8BVzVr1vPMVyg+p
         4pf+9KRPQ2jyWkFzeTy9P9BmLDuzoU+oyreUsahu5TzKUtHKNApSzPViCt1kcF1VvyLY
         EBZ2cknvRUVE206uRtOWd2esQv+o24ViVKd/rBWTMt9v24aSup6x8cg8yxqr48uy9A5D
         2wU9rOZi/ARDnC3i6zc27yMcW2X0Rkjl5Qt2cugQIZlr/gtlOsSZfuPmIlEcNmDtKMfm
         Kv9A==
X-Gm-Message-State: AOJu0YwYeHUCPYiLuUvC1JiAWPIdLaoF0UmbKNryEYXm9ZtrhDClkFkQ
	0aGj85wa5OJGqiavZIxKEypeGbn1kF+ot9rEfxM1I/wrc5ts6+VZs7eVfyBVbcvmzXu8YQlBae7
	6sEplFMVzj0K09bT7M+2VAvkZIW3KBhKbPAONtg==
X-Google-Smtp-Source: AGHT+IGoI/avDEdz511LssCsRgxu9bEBSD/Zj4AW/KWnWtmVF4ijj7GYZY4uOqSMe9Tc2EQU06Vsc1w0P3AZNoJEB3w=
X-Received: by 2002:a17:906:6442:b0:a31:8c73:f42d with SMTP id
 l2-20020a170906644200b00a318c73f42dmr5504998ejn.28.1706470384623; Sun, 28 Jan
 2024 11:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com> <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org> <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org> <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
 <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org> <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
 <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com>
 <5ef9bab979260884866efe30d19ba8f1@manjaro.org> <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
 <ab664c65-954e-4be0-9c1f-6676694e1f11@linaro.org>
In-Reply-To: <ab664c65-954e-4be0-9c1f-6676694e1f11@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Sun, 28 Jan 2024 23:32:53 +0400
Message-ID: <CABjd4Yy1rX39uHHj24RoyzAvhcFvZbgUJJFJ2V_w_8xvLujmoA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 7:06=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Alexey,

Hi Daniel,

> On 27/01/2024 20:41, Alexey Charkov wrote:
> > On Sat, Jan 27, 2024 at 12:33=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg> wrote:
> >>
> >> On 2024-01-26 14:44, Alexey Charkov wrote:
> >>> On Fri, Jan 26, 2024 at 4:56=E2=80=AFPM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>> On 26/01/2024 08:49, Dragan Simic wrote:
> >>>>> On 2024-01-26 08:30, Alexey Charkov wrote:
> >>>>>> On Fri, Jan 26, 2024 at 11:05=E2=80=AFAM Dragan Simic <dsimic@manj=
aro.org> wrote:
> >>>>>>> On 2024-01-26 07:44, Alexey Charkov wrote:
> >>>>>>>> On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Dragan Simic <dsimic@ma=
njaro.org>
> >>>>>>>> wrote:
> >>>>>>>>> On 2024-01-25 10:30, Daniel Lezcano wrote:
> >>>>>>>>>> On 24/01/2024 21:30, Alexey Charkov wrote:
> >>>>>>>>>>> By default the CPUs on RK3588 start up in a conservative
> >>>>>>> performance
> >>>>>>>>>>> mode. Add frequency and voltage mappings to the device tree t=
o
> >>>>>>> enable
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>>> Throttling would also lower the voltage at some point, which cools=
 it
> >>>>>> down much faster!
> >>>>>
> >>>>> Of course, but the key is not to cool (and slow down) the CPU cores=
 too
> >>>>> much, but just enough to stay within the available thermal envelope=
,
> >>>>> which is where the same-voltage, lower-frequency OPPs should shine.
> >>>>
> >>>> That implies the resulting power is sustainable which I doubt it is
> >>>> the
> >>>> case.
> >>>>
> >>>> The voltage scaling makes the cooling effect efficient not the
> >>>> frequency.
> >>>>
> >>>> For example:
> >>>>          opp5 =3D opp(2GHz, 1V) =3D> 2 BogoWatt
> >>>>          opp4 =3D opp(1.9GHz, 1V) =3D> 1.9 BogoWatt
> >>>>          opp3 =3D opp(1.8GHz, 0.9V) =3D> 1.458 BogoWatt
> >>>>          [ other states but we focus on these 3 ]
> >>>>
> >>>> opp5->opp4 =3D> -5% compute capacity, -5% power, ratio=3D1
> >>>> opp4->opp3 =3D> -5% compute capacity, -23.1% power, ratio=3D21,6
> >>>>
> >>>> opp5->opp3 =3D> -10% compute capacity, -27.1% power, ratio=3D36.9
> >>>>
> >>>> In burst operation (no thermal throttling), opp4 is pointless we agr=
ee
> >>>> on that.
> >>>>
> >>>> IMO the following will happen: in burst operation with thermal
> >>>> throttling we hit the trip point and then the step wise governor
> >>>> reduces
> >>>> opp5 -> opp4. We have slight power reduction but the temperature doe=
s
> >>>> not decrease, so at the next iteration, it is throttle at opp3. And =
at
> >>>> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp=
3.
> >>>>
> >>>> It is probable we end up with an equivalent frequency average (or
> >>>> compute capacity avg).
> >>>>
> >>>> opp4 <-> opp3 (longer duration in states, less transitions)
> >>>> opp5 <-> opp3 (shorter duration in states, more transitions)
> >>>>
> >>>> Some platforms had their higher OPPs with the same voltage and they
> >>>> failed to cool down the CPU in the long run.
> >>>>
> >>>> Anyway, there is only one way to check it out :)
> >>>>
> >>>> Alexey, is it possible to compare the compute duration for 'dhryston=
e'
> >>>> with these voltage OPP and without ? (with a period of cool down
> >>>> between
> >>>> the test in order to start at the same thermal condition) ?
> >>>
> >>> Sure, let me try that - would be interesting to see the results. In m=
y
> >>> previous tinkering there were cases when the system stayed at 2.35GHz
> >>> for all big cores for non-trivial time (using the step-wise thermal
> >>> governor), and that's an example of "same voltage, lower frequency".
> >>> Other times though it throttled one cluster down to 1.8GHz and kept
> >>> the other at 2.4GHz, and was also stationary at those parameters for
> >>> extended time. This probably indicates that both of those states use
> >>> sustainable power in my cooling setup.
> >>
> >> IMHO, there are simply too many factors at play, including different
> >> possible cooling setups, so providing additional CPU throttling
> >> granularity can only be helpful.  Of course, testing and recording
> >> data is the way to move forward, but I think we should use a few
> >> different tests.
> >
> > Soooo, benchmarking these turned out a bit trickier than I had hoped
> > for. Apparently, dhrystone uses an unsigned int rather than an
> > unsigned long for the loops count (or something of that sort), which
> > means that I can't get it to run enough loops to heat up my chip from
> > a stable idle state to the throttling state (due to counter
> > wraparound). So I ended up with a couple of crutches, namely:
> >   - run dhrystone continuously on 6 out of 8 cores to make the chip
> > warm enough (`taskset -c 0-5 ./dhrystone -t 6 -r 6000` - note that on
> > my machine cores 6-7 are usually the first ones to get throttled, due
> > to whatever thermal peculiarities)
> >   - wait for the temperature to stabilize (which happens at 79.5C)
> >   - then run timed dhrystone on the remaining 2 out of 6 cores (big
> > ones) to see how throttling with different OPP tables affects overall
> > performance.
>
> Thanks for taking the time to test.
>
> > In the end, here's what I got with the 'original' OPP table (including
> > "same voltage - different frequencies" states):
> > alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
> > duration: 0 seconds
> > number of threads: 2
> > number of loops: 4000000000000000
> > delay between starting threads: 0 seconds
> >
> > Dhrystone(1.1) time for 1233977344 passes =3D 29.7
> > This machine benchmarks at 41481539 dhrystones/second
> >                             23609 DMIPS
> > Dhrystone(1.1) time for 1233977344 passes =3D 29.8
> > This machine benchmarks at 41476618 dhrystones/second
> >                             23606 DMIPS
> >
> > Total dhrystone run time: 30.864492 seconds.
> >
> > And here's what I got with the 'reduced' OPP table (keeping only the
> > highest frequency state for each voltage):
> > alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
> > duration: 0 seconds
> > number of threads: 2
> > number of loops: 4000000000000000
> > delay between starting threads: 0 seconds
> >
> > Dhrystone(1.1) time for 1233977344 passes =3D 30.9
> > This machine benchmarks at 39968549 dhrystones/second
> >                            22748 DMIPS
> > Dhrystone(1.1) time for 1233977344 passes =3D 31.0
> > This machine benchmarks at 39817431 dhrystones/second
> >                            22662 DMIPS
> >
> > Total dhrystone run time: 31.995136 seconds.
> >
> > Bottomline: removing the lower-frequency OPPs led to a 3.8% drop in
> > performance in this setup. This is probably far from a reliable
> > estimate, but I guess it indeed indicates that having lower-frequency
> > states might be beneficial in some load scenarios.
>
> What is the duration between these two tests?

Several hours and a couple of reboots. I did the first one, recorded
the results and the temperatures, then rebuilt the dtb the next day,
rebooted with it and did everything again with the other OPP table.

> I would be curious if it is repeatable by inverting the setup (reduced
> OPP table and then original OPP table).

Frankly, I can't see how ordering could have mattered, given that I
let the system cool down completely, and also rebooted it to use a
different dtb, so there shouldn't have been any caching effects. Maybe
there is some outside randomness in the results though - perhaps 5-10
repetitions in each case would have been more statistically
meaningful. But then again to make it statistically meaningful I'd
have to peg the other (non-benchmarked) cores to a static OPP to
ensure the thermal governor doesn't play with them when not asked to -
and it all starts to sound like a rabbit hole :)

> BTW: I used -l 10000 for a ~30 seconds workload more or less on the
> rk3399, may be -l 20000 will be ok for the rk3588.

-l 20000 with two threads also gives me about ~30 seconds runtime...
While -l 200000 completed in 25 seconds *facepalm*

Best regards,
Alexey

