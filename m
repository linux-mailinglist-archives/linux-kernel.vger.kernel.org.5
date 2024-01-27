Return-Path: <linux-kernel+bounces-41377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A017D83EFCB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80212B23799
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EACF2E657;
	Sat, 27 Jan 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcgGRcl6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52102E62B;
	Sat, 27 Jan 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384478; cv=none; b=HHiRpI60vIaSozY9Vol1/VQNRYhS226KJo/TaGpVJ6wVwqtNsKnvbiZWAmGIDHQY3ZIS0QGIf+y5paiSyrS1SMrsI/3Vn0jHB+dltoWnyeu9i2JIsP5RKHNcKyZ/LYFfRiix79I0QixP6yMNDEKPljJagyv46vKvpXwtKBwwwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384478; c=relaxed/simple;
	bh=3ejxm1++8JheA0B9ih4btULBIs4W0UqLfoXALwZ9lwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw0qlKBUnJLO5+gNZIITCcZ1QnZ7R0ifUJ5Lq/Mcq59gCnFi/gmDjGa3AZeoy7//AAVP18mQ0hHxBhJ51TpuPby7uBfCDn6RjJFsrzWk68/ABSBHPBs4FySAt9hAH5xJbI5WnY9qZfO7eIYwV1/7EbjYTNEGZdZK3kyxVa9hIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcgGRcl6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3510d79ae9so120498066b.0;
        Sat, 27 Jan 2024 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706384475; x=1706989275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQb7quZ1225FJ5IuNCQf5SD++7TJkJ1ApLlRiZiRjrk=;
        b=hcgGRcl6hOv80PE07WTAsvXpkuvxemADNdn2isWNG3jLl8CLuS744s54vBwSySP+a+
         mLTv81j6qssOAvLguWYIGhEB9Ei/xF+WiJCCSmqVKPxxU8VPNNF4dQrL2ItqE93Hgn7B
         2VJ5dOFVtQUhaGdNzD+xNWy6PYYGEvqlQ9fpcdl1DUSZ37A1No6WDL803jEjN1ddn0kM
         eIrwiMUIIepIjE0Vhj09cNB5vvg5FWDPHbOXH/MFWvTGwxDM1Pa0bMmbXL2C89OeAP8P
         wl3IucxYJa3a/c2mE+VlnPr1e2dYL9aYFiqPbvN7Dc7Cehei+ztBawafa86v+ZN+LWRK
         RpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706384475; x=1706989275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQb7quZ1225FJ5IuNCQf5SD++7TJkJ1ApLlRiZiRjrk=;
        b=aP8YOCbCfA6cNzDcb5UYkvmzY5M0dVkXnoOgxhXUtcqG484J6rIgVVHn6fz0MFH02n
         vkWf4mvg8OZuWXXFg68YphV08C/cIN8EZBWzm9zLbILDHuZ3xUrjyO0OlsONFE7Z/coO
         1wPk8XNWWXbpBPCvWsxA4/4g5IVNBwb9DaP2uKRLdJzKCUKL7LU8EqZRyCaJziFFnUA5
         qOBJJs3bkKjzj/WEEbIcIiWNjjdL5lai3A4Vcfaz87UKjQt1+Wmb2Bs3l+lzy+O6cmoy
         oyedXooM6zlQMawg6KvN8y/DWWpAOw0d0uJTi9onjty3vV5lBofS5kcwNZvRwM1/nz34
         GAeg==
X-Gm-Message-State: AOJu0Ywrhm0jKKkxTLZSmOVA/JKkihzvnjCFlugbEWaGGLragErxNfp1
	Mith/GBx3rGg3DRH5yD1g82t809qS/zakvnhFXdIYpDPDde9VxSSThOQedfdS8dno9gZG+sUlcO
	Tv/NCumUEaYQyUa53UVzHevX2qdI=
X-Google-Smtp-Source: AGHT+IHt7GkPzqAJYdxcpfZ+o88hPJ8ZAK8XEyaYEdNrxjHG4Y6W9HhC70fdNLz80LMAchsIPpTkV3M6QMDEErQCdAE=
X-Received: by 2002:a17:906:b7d4:b0:a31:1ee9:da54 with SMTP id
 fy20-20020a170906b7d400b00a311ee9da54mr1516808ejb.60.1706384474696; Sat, 27
 Jan 2024 11:41:14 -0800 (PST)
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
 <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com> <5ef9bab979260884866efe30d19ba8f1@manjaro.org>
In-Reply-To: <5ef9bab979260884866efe30d19ba8f1@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 27 Jan 2024 23:41:03 +0400
Message-ID: <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 12:33=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> On 2024-01-26 14:44, Alexey Charkov wrote:
> > On Fri, Jan 26, 2024 at 4:56=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >> On 26/01/2024 08:49, Dragan Simic wrote:
> >> > On 2024-01-26 08:30, Alexey Charkov wrote:
> >> >> On Fri, Jan 26, 2024 at 11:05=E2=80=AFAM Dragan Simic <dsimic@manja=
ro.org> wrote:
> >> >>> On 2024-01-26 07:44, Alexey Charkov wrote:
> >> >>> > On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Dragan Simic <dsimic@ma=
njaro.org>
> >> >>> > wrote:
> >> >>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
> >> >>> >> > On 24/01/2024 21:30, Alexey Charkov wrote:
> >> >>> >> >> By default the CPUs on RK3588 start up in a conservative
> >> >>> performance
> >> >>> >> >> mode. Add frequency and voltage mappings to the device tree =
to
> >> >>> enable
> >>
> >> [ ... ]
> >>
> >> >> Throttling would also lower the voltage at some point, which cools =
it
> >> >> down much faster!
> >> >
> >> > Of course, but the key is not to cool (and slow down) the CPU cores =
too
> >> > much, but just enough to stay within the available thermal envelope,
> >> > which is where the same-voltage, lower-frequency OPPs should shine.
> >>
> >> That implies the resulting power is sustainable which I doubt it is
> >> the
> >> case.
> >>
> >> The voltage scaling makes the cooling effect efficient not the
> >> frequency.
> >>
> >> For example:
> >>         opp5 =3D opp(2GHz, 1V) =3D> 2 BogoWatt
> >>         opp4 =3D opp(1.9GHz, 1V) =3D> 1.9 BogoWatt
> >>         opp3 =3D opp(1.8GHz, 0.9V) =3D> 1.458 BogoWatt
> >>         [ other states but we focus on these 3 ]
> >>
> >> opp5->opp4 =3D> -5% compute capacity, -5% power, ratio=3D1
> >> opp4->opp3 =3D> -5% compute capacity, -23.1% power, ratio=3D21,6
> >>
> >> opp5->opp3 =3D> -10% compute capacity, -27.1% power, ratio=3D36.9
> >>
> >> In burst operation (no thermal throttling), opp4 is pointless we agree
> >> on that.
> >>
> >> IMO the following will happen: in burst operation with thermal
> >> throttling we hit the trip point and then the step wise governor
> >> reduces
> >> opp5 -> opp4. We have slight power reduction but the temperature does
> >> not decrease, so at the next iteration, it is throttle at opp3. And at
> >> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.
> >>
> >> It is probable we end up with an equivalent frequency average (or
> >> compute capacity avg).
> >>
> >> opp4 <-> opp3 (longer duration in states, less transitions)
> >> opp5 <-> opp3 (shorter duration in states, more transitions)
> >>
> >> Some platforms had their higher OPPs with the same voltage and they
> >> failed to cool down the CPU in the long run.
> >>
> >> Anyway, there is only one way to check it out :)
> >>
> >> Alexey, is it possible to compare the compute duration for 'dhrystone'
> >> with these voltage OPP and without ? (with a period of cool down
> >> between
> >> the test in order to start at the same thermal condition) ?
> >
> > Sure, let me try that - would be interesting to see the results. In my
> > previous tinkering there were cases when the system stayed at 2.35GHz
> > for all big cores for non-trivial time (using the step-wise thermal
> > governor), and that's an example of "same voltage, lower frequency".
> > Other times though it throttled one cluster down to 1.8GHz and kept
> > the other at 2.4GHz, and was also stationary at those parameters for
> > extended time. This probably indicates that both of those states use
> > sustainable power in my cooling setup.
>
> IMHO, there are simply too many factors at play, including different
> possible cooling setups, so providing additional CPU throttling
> granularity can only be helpful.  Of course, testing and recording
> data is the way to move forward, but I think we should use a few
> different tests.

Soooo, benchmarking these turned out a bit trickier than I had hoped
for. Apparently, dhrystone uses an unsigned int rather than an
unsigned long for the loops count (or something of that sort), which
means that I can't get it to run enough loops to heat up my chip from
a stable idle state to the throttling state (due to counter
wraparound). So I ended up with a couple of crutches, namely:
 - run dhrystone continuously on 6 out of 8 cores to make the chip
warm enough (`taskset -c 0-5 ./dhrystone -t 6 -r 6000` - note that on
my machine cores 6-7 are usually the first ones to get throttled, due
to whatever thermal peculiarities)
 - wait for the temperature to stabilize (which happens at 79.5C)
 - then run timed dhrystone on the remaining 2 out of 6 cores (big
ones) to see how throttling with different OPP tables affects overall
performance.

In the end, here's what I got with the 'original' OPP table (including
"same voltage - different frequencies" states):
alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
duration: 0 seconds
number of threads: 2
number of loops: 4000000000000000
delay between starting threads: 0 seconds

Dhrystone(1.1) time for 1233977344 passes =3D 29.7
This machine benchmarks at 41481539 dhrystones/second
                           23609 DMIPS
Dhrystone(1.1) time for 1233977344 passes =3D 29.8
This machine benchmarks at 41476618 dhrystones/second
                           23606 DMIPS

Total dhrystone run time: 30.864492 seconds.

And here's what I got with the 'reduced' OPP table (keeping only the
highest frequency state for each voltage):
alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
duration: 0 seconds
number of threads: 2
number of loops: 4000000000000000
delay between starting threads: 0 seconds

Dhrystone(1.1) time for 1233977344 passes =3D 30.9
This machine benchmarks at 39968549 dhrystones/second
                          22748 DMIPS
Dhrystone(1.1) time for 1233977344 passes =3D 31.0
This machine benchmarks at 39817431 dhrystones/second
                          22662 DMIPS

Total dhrystone run time: 31.995136 seconds.

Bottomline: removing the lower-frequency OPPs led to a 3.8% drop in
performance in this setup. This is probably far from a reliable
estimate, but I guess it indeed indicates that having lower-frequency
states might be beneficial in some load scenarios.

Note though that several seconds after hitting the throttling
threshold cores 6-7 were oscillating between 1.608GHz and 1.8GHz in
both runs, which implies that the whole difference in performance was
due to different speed of initial throttling (i.e. it might be a
peculiarity of the step-wise thermal governor operation when it has to
go through more cooling states to reach the "steady-state" one). Given
that both 1.608GHz and 1.8GHz have no lower-frequency same-voltage
siblings in either of the OPP tables, it implies that under prolonged
constant load there should be no performance difference at all.

Best regards,
Alexey

