Return-Path: <linux-kernel+bounces-41520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C90A83F3A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E64283F2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA993C35;
	Sun, 28 Jan 2024 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KG6rScrR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30903FEF;
	Sun, 28 Jan 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706412970; cv=none; b=XRsUcSRGZAxpxEXxMGo+5OGNa5rTx5equrBT4VXtAAzp39RKuDf223gwDq9hGf0HCDwPzsc+lHbzNKONMb1cQpRF5QB61pfKrrMJf5+7e8REshzSAkHi3wUlUCQg10g7ptloW6YsMln0xq4McfeC+v15T/c5zmbOEwb4bo7b9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706412970; c=relaxed/simple;
	bh=KYQFlIIyPOnAYU4BCpmcqOZW2Fk66y/U3GkF/Ses4e8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QCg/Ut2cbi2V1owaLm6JIKWrQ0x+PpCgFjcvDv77D34YBNwGt6KoB+qOpvbcU510DBF53Y5pSRdViyJ6oY4NRJBFldrjDzMq1XLYHl4ggZXDJ7EJI+rsrWGpM6SBxWD6NKx773rMIufPR1i2pXIg6uOxAGn0GKBjut8/vGICMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KG6rScrR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706412958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGynTAOYEGgnqBwfLRvahiiezGVmO/RYQ5/JRIx6Ctk=;
	b=KG6rScrRZHwd6CM0HJJfXU/XWE00HNFc5rAeAejlPdmECoKkqpbO62Qeqy2q9DNE9cgk9g
	P9io/r1zWzHMvU6jV6jd32bXQecZALlr61VkUpTB/5GQ2ye5R8Q4fOdg29UXOc/LtNLcup
	DasNWw3fAqWceknmDXZHUp/OaSdniHAmUluORsO6YZvv/5FksGr6k5JTBgfYjUyZJckAH8
	VNa17VsMXlMhKqg4XfYGkhP+H+5Q595YPnsmv+odGHio5qtz8SlX/gJ56i2zKTF7lT8HiM
	77ORaZwK7M77FpFPPJzoOA6X4MAquOIRGWP67I5YXk20m+vMBt7JIA0TsIUBPQ==
Date: Sun, 28 Jan 2024 04:35:58 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
In-Reply-To: <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
 <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
 <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org>
 <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
 <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org>
 <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
 <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com>
 <5ef9bab979260884866efe30d19ba8f1@manjaro.org>
 <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
Message-ID: <9fda41efe365241ce06bd58974c8e055@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-27 20:41, Alexey Charkov wrote:
> On Sat, Jan 27, 2024 at 12:33 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-26 14:44, Alexey Charkov wrote:
>> > On Fri, Jan 26, 2024 at 4:56 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> >> On 26/01/2024 08:49, Dragan Simic wrote:
>> >> > On 2024-01-26 08:30, Alexey Charkov wrote:
>> >> >> On Fri, Jan 26, 2024 at 11:05 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> >>> On 2024-01-26 07:44, Alexey Charkov wrote:
>> >> >>> > On Fri, Jan 26, 2024 at 10:32 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> >>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
>> >> >> Throttling would also lower the voltage at some point, which cools it
>> >> >> down much faster!
>> >> >
>> >> > Of course, but the key is not to cool (and slow down) the CPU cores too
>> >> > much, but just enough to stay within the available thermal envelope,
>> >> > which is where the same-voltage, lower-frequency OPPs should shine.
>> >>
>> >> That implies the resulting power is sustainable which I doubt it is
>> >> the
>> >> case.
>> >>
>> >> The voltage scaling makes the cooling effect efficient not the
>> >> frequency.
>> >>
>> >> For example:
>> >>         opp5 = opp(2GHz, 1V) => 2 BogoWatt
>> >>         opp4 = opp(1.9GHz, 1V) => 1.9 BogoWatt
>> >>         opp3 = opp(1.8GHz, 0.9V) => 1.458 BogoWatt
>> >>         [ other states but we focus on these 3 ]
>> >>
>> >> opp5->opp4 => -5% compute capacity, -5% power, ratio=1
>> >> opp4->opp3 => -5% compute capacity, -23.1% power, ratio=21,6
>> >>
>> >> opp5->opp3 => -10% compute capacity, -27.1% power, ratio=36.9
>> >>
>> >> In burst operation (no thermal throttling), opp4 is pointless we agree
>> >> on that.
>> >>
>> >> IMO the following will happen: in burst operation with thermal
>> >> throttling we hit the trip point and then the step wise governor
>> >> reduces
>> >> opp5 -> opp4. We have slight power reduction but the temperature does
>> >> not decrease, so at the next iteration, it is throttle at opp3. And at
>> >> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.
>> >>
>> >> It is probable we end up with an equivalent frequency average (or
>> >> compute capacity avg).
>> >>
>> >> opp4 <-> opp3 (longer duration in states, less transitions)
>> >> opp5 <-> opp3 (shorter duration in states, more transitions)
>> >>
>> >> Some platforms had their higher OPPs with the same voltage and they
>> >> failed to cool down the CPU in the long run.
>> >>
>> >> Anyway, there is only one way to check it out :)
>> >>
>> >> Alexey, is it possible to compare the compute duration for 'dhrystone'
>> >> with these voltage OPP and without ? (with a period of cool down
>> >> between
>> >> the test in order to start at the same thermal condition) ?
>> >
>> > Sure, let me try that - would be interesting to see the results. In my
>> > previous tinkering there were cases when the system stayed at 2.35GHz
>> > for all big cores for non-trivial time (using the step-wise thermal
>> > governor), and that's an example of "same voltage, lower frequency".
>> > Other times though it throttled one cluster down to 1.8GHz and kept
>> > the other at 2.4GHz, and was also stationary at those parameters for
>> > extended time. This probably indicates that both of those states use
>> > sustainable power in my cooling setup.
>> 
>> IMHO, there are simply too many factors at play, including different
>> possible cooling setups, so providing additional CPU throttling
>> granularity can only be helpful.  Of course, testing and recording
>> data is the way to move forward, but I think we should use a few
>> different tests.
> 
> Soooo, benchmarking these turned out a bit trickier than I had hoped
> for. Apparently, dhrystone uses an unsigned int rather than an
> unsigned long for the loops count (or something of that sort), which
> means that I can't get it to run enough loops to heat up my chip from
> a stable idle state to the throttling state (due to counter
> wraparound). So I ended up with a couple of crutches, namely:

Huh, it seems that recent SBCs may have become a bit too fast for it,
which is great. :)  Thank you for the benchmarking.

>  - run dhrystone continuously on 6 out of 8 cores to make the chip
> warm enough (`taskset -c 0-5 ./dhrystone -t 6 -r 6000` - note that on
> my machine cores 6-7 are usually the first ones to get throttled, due
> to whatever thermal peculiarities)
>  - wait for the temperature to stabilize (which happens at 79.5C)
>  - then run timed dhrystone on the remaining 2 out of 6 cores (big
> ones) to see how throttling with different OPP tables affects overall
> performance.

Just checking, running the test on just two CPU cores was enough to
keep the package temperature at around 80 oC?

> In the end, here's what I got with the 'original' OPP table (including
> "same voltage - different frequencies" states):
> alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
> duration: 0 seconds
> number of threads: 2
> number of loops: 4000000000000000
> delay between starting threads: 0 seconds
> 
> Dhrystone(1.1) time for 1233977344 passes = 29.7
> This machine benchmarks at 41481539 dhrystones/second
>                            23609 DMIPS
> Dhrystone(1.1) time for 1233977344 passes = 29.8
> This machine benchmarks at 41476618 dhrystones/second
>                            23606 DMIPS
> 
> Total dhrystone run time: 30.864492 seconds.
> 
> And here's what I got with the 'reduced' OPP table (keeping only the
> highest frequency state for each voltage):
> alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
> duration: 0 seconds
> number of threads: 2
> number of loops: 4000000000000000
> delay between starting threads: 0 seconds
> 
> Dhrystone(1.1) time for 1233977344 passes = 30.9
> This machine benchmarks at 39968549 dhrystones/second
>                           22748 DMIPS
> Dhrystone(1.1) time for 1233977344 passes = 31.0
> This machine benchmarks at 39817431 dhrystones/second
>                           22662 DMIPS
> 
> Total dhrystone run time: 31.995136 seconds.
> 
> Bottomline: removing the lower-frequency OPPs led to a 3.8% drop in
> performance in this setup. This is probably far from a reliable
> estimate, but I guess it indeed indicates that having lower-frequency
> states might be beneficial in some load scenarios.

Measuring a difference of about 4% may be attributed to some unknown
inaccuracy or test deviation, but again, a performance improvement of
about 4% that comes free of charge is nothing to be sneezed at, IMHO.

> Note though that several seconds after hitting the throttling
> threshold cores 6-7 were oscillating between 1.608GHz and 1.8GHz in
> both runs, which implies that the whole difference in performance was
> due to different speed of initial throttling (i.e. it might be a
> peculiarity of the step-wise thermal governor operation when it has to
> go through more cooling states to reach the "steady-state" one). Given
> that both 1.608GHz and 1.8GHz have no lower-frequency same-voltage
> siblings in either of the OPP tables, it implies that under prolonged
> constant load there should be no performance difference at all.

.. all that with one possible cooling setup, and with one synthetic
test.  We simply can't know in advance how would a different cooling
setup on the same or on a different board behave, if you agree.

