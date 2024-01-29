Return-Path: <linux-kernel+bounces-42025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD583FB23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFB1284A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D756656;
	Mon, 29 Jan 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="F53HV9dh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E12381;
	Mon, 29 Jan 2024 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706486964; cv=none; b=h7iBxcNHVhT3/E336XVzkdalcj8gXLf3dlmMQGZFw+/tfSq3F3zSIbOuwV/FWUzbUky9OVDGh5XkOFix94UMzEAlVGgxE5YAOooOACI6eT79oJMstwvkH+gIk/pxCUeJZ1/6G5dcG7Gtek4/RzanO+jYto3JtCohztcdWGqyAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706486964; c=relaxed/simple;
	bh=E7dTq7Jojq+twkdk/EmDbkIdUnZFqQXdC2/4OgbjszU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B+9OXxAHe3xqQN+tFdu8/RhOp6a9ws61jsilL6vQsajn3mxYBYiAR+ENId0YT0AMqBZlVe9Qa4UaEdxSOPONy7SskI56EXJ9PzEoUcVxGPLw5aq8n7A0v96pJy2eG2VscFLIOp1WUvpl4bf24GKGdu8dm3dVmLqlQFtATX9Wzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=F53HV9dh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706486956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk03a+FET1k1rmW3l/AR6fyVcT+TC3Z8jhBTopbl0TM=;
	b=F53HV9dhyPpLRJoADL1M+ou/YvdWoiRYoBqArrJM+6rEfNgOjkEGVS+tt2GeQlK7O6V9cY
	ZiNahPTAa8L5uYw8YT/G4QqaXcU7knUNUDzLpE57A/LG+UINo7G+3poDoZ+TACLaecSm/w
	o5DGdX+f1p+ULMas1lNL42oLCRoHvUqIBLu4oiyBmNCrFseUZwy6j/dqaSibRBTokDRlVm
	e18j222OcQarBD7MuSLr2gb905FKlvNnIyo+2Ny9nH/g/01sZ0J9Fy3n22ke9djEMkZU7Y
	Os4MARNtmPZ1GfMJ4ym2d4lF5vT3e3mhiKlEfwhEToJknA8q1ibhkuYs76sJ1w==
Date: Mon, 29 Jan 2024 01:09:14 +0100
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
In-Reply-To: <CABjd4Ywfy8zT4sJ5v77CZQ9BNC=nkB7ZQq3QQyONST7gVHq=AA@mail.gmail.com>
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
 <9fda41efe365241ce06bd58974c8e055@manjaro.org>
 <CABjd4Ywfy8zT4sJ5v77CZQ9BNC=nkB7ZQq3QQyONST7gVHq=AA@mail.gmail.com>
Message-ID: <a5fb28fa0f973ed1393dc3edc6bc729c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-28 20:14, Alexey Charkov wrote:
> On Sun, Jan 28, 2024 at 7:35 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-27 20:41, Alexey Charkov wrote:
>> > On Sat, Jan 27, 2024 at 12:33 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> On 2024-01-26 14:44, Alexey Charkov wrote:
>> >> > On Fri, Jan 26, 2024 at 4:56 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> >> >> On 26/01/2024 08:49, Dragan Simic wrote:
>> >> >> > On 2024-01-26 08:30, Alexey Charkov wrote:
>> >> >> >> On Fri, Jan 26, 2024 at 11:05 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> >> >>> On 2024-01-26 07:44, Alexey Charkov wrote:
>> >> >> >>> > On Fri, Jan 26, 2024 at 10:32 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> >> >>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
>> >> >> >> Throttling would also lower the voltage at some point, which cools it
>> >> >> >> down much faster!
>> >> >> >
>> >> >> > Of course, but the key is not to cool (and slow down) the CPU cores too
>> >> >> > much, but just enough to stay within the available thermal envelope,
>> >> >> > which is where the same-voltage, lower-frequency OPPs should shine.
>> >> >>
>> >> >> That implies the resulting power is sustainable which I doubt it is
>> >> >> the
>> >> >> case.
>> >> >>
>> >> >> The voltage scaling makes the cooling effect efficient not the
>> >> >> frequency.
>> >> >>
>> >> >> For example:
>> >> >>         opp5 = opp(2GHz, 1V) => 2 BogoWatt
>> >> >>         opp4 = opp(1.9GHz, 1V) => 1.9 BogoWatt
>> >> >>         opp3 = opp(1.8GHz, 0.9V) => 1.458 BogoWatt
>> >> >>         [ other states but we focus on these 3 ]
>> >> >>
>> >> >> opp5->opp4 => -5% compute capacity, -5% power, ratio=1
>> >> >> opp4->opp3 => -5% compute capacity, -23.1% power, ratio=21,6
>> >> >>
>> >> >> opp5->opp3 => -10% compute capacity, -27.1% power, ratio=36.9
>> >> >>
>> >> >> In burst operation (no thermal throttling), opp4 is pointless we agree
>> >> >> on that.
>> >> >>
>> >> >> IMO the following will happen: in burst operation with thermal
>> >> >> throttling we hit the trip point and then the step wise governor
>> >> >> reduces
>> >> >> opp5 -> opp4. We have slight power reduction but the temperature does
>> >> >> not decrease, so at the next iteration, it is throttle at opp3. And at
>> >> >> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.
>> >> >>
>> >> >> It is probable we end up with an equivalent frequency average (or
>> >> >> compute capacity avg).
>> >> >>
>> >> >> opp4 <-> opp3 (longer duration in states, less transitions)
>> >> >> opp5 <-> opp3 (shorter duration in states, more transitions)
>> >> >>
>> >> >> Some platforms had their higher OPPs with the same voltage and they
>> >> >> failed to cool down the CPU in the long run.
>> >> >>
>> >> >> Anyway, there is only one way to check it out :)
>> >> >>
>> >> >> Alexey, is it possible to compare the compute duration for 'dhrystone'
>> >> >> with these voltage OPP and without ? (with a period of cool down
>> >> >> between
>> >> >> the test in order to start at the same thermal condition) ?
>> >> >
>> >> > Sure, let me try that - would be interesting to see the results. In my
>> >> > previous tinkering there were cases when the system stayed at 2.35GHz
>> >> > for all big cores for non-trivial time (using the step-wise thermal
>> >> > governor), and that's an example of "same voltage, lower frequency".
>> >> > Other times though it throttled one cluster down to 1.8GHz and kept
>> >> > the other at 2.4GHz, and was also stationary at those parameters for
>> >> > extended time. This probably indicates that both of those states use
>> >> > sustainable power in my cooling setup.
>> >>
>> >> IMHO, there are simply too many factors at play, including different
>> >> possible cooling setups, so providing additional CPU throttling
>> >> granularity can only be helpful.  Of course, testing and recording
>> >> data is the way to move forward, but I think we should use a few
>> >> different tests.
>> >
>> > Soooo, benchmarking these turned out a bit trickier than I had hoped
>> > for. Apparently, dhrystone uses an unsigned int rather than an
>> > unsigned long for the loops count (or something of that sort), which
>> > means that I can't get it to run enough loops to heat up my chip from
>> > a stable idle state to the throttling state (due to counter
>> > wraparound). So I ended up with a couple of crutches, namely:
>> 
>> Huh, it seems that recent SBCs may have become a bit too fast for it,
>> which is great. :)  Thank you for the benchmarking.
>> 
>> >  - run dhrystone continuously on 6 out of 8 cores to make the chip
>> > warm enough (`taskset -c 0-5 ./dhrystone -t 6 -r 6000` - note that on
>> > my machine cores 6-7 are usually the first ones to get throttled, due
>> > to whatever thermal peculiarities)
>> >  - wait for the temperature to stabilize (which happens at 79.5C)
>> >  - then run timed dhrystone on the remaining 2 out of 6 cores (big
>> > ones) to see how throttling with different OPP tables affects overall
>> > performance.
>> 
>> Just checking, running the test on just two CPU cores was enough to
>> keep the package temperature at around 80 oC?
> 
> No, not even remotely.
> 
> I kept the continuous 6 dhrystone threads running on all the other
> cores (`taskset -c 0-5 ./dhrystone -t 6 -r 6000`) to let it reach the
> throttling temperature. This adds further imprecision to the benchmark
> of course, because the governor might choose to throttle some of the
> cores that do not participate in the timed benchmarking run, and thus
> lend some thermal headroom to the latter. That didn't seem to happen
> from my naked-eye observation via `watch "cpupower -c 0,4,6
> frequency-info | grep current"`, although I admit that I didn't record
> more granular logs of frequency states, and some quick transitions to
> lower frequencies could also have happened on the other cores. Don't
> think it's a major influence though, because a quick transition back
> and forth shouldn't have contributed much to the thermal output.

Thank you for the clarification!

You're right, that might have introduced some inaccuracy into the test
results, and it also made the tests kind of hardly repeatable.  On the
other hand, that way the synthetic CPU test feels a bit more like some
real-world CPU load, in which multiple resource-hungry tasks usually
compete for the CPU cores and the thermal budget.

Though, as we know repeatability is the key for a scientific approach,
but it also usually contradicts with simulating real-world loads that
are of rather random nature.  Well, testing is hard. :)

I'll think a bit more about all this, and I'll come back with an update.
Maybe I'll also be able to join the testing.

>> > In the end, here's what I got with the 'original' OPP table (including
>> > "same voltage - different frequencies" states):
>> > alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
>> > duration: 0 seconds
>> > number of threads: 2
>> > number of loops: 4000000000000000
>> > delay between starting threads: 0 seconds
>> >
>> > Dhrystone(1.1) time for 1233977344 passes = 29.7
>> > This machine benchmarks at 41481539 dhrystones/second
>> >                            23609 DMIPS
>> > Dhrystone(1.1) time for 1233977344 passes = 29.8
>> > This machine benchmarks at 41476618 dhrystones/second
>> >                            23606 DMIPS
>> >
>> > Total dhrystone run time: 30.864492 seconds.
>> >
>> > And here's what I got with the 'reduced' OPP table (keeping only the
>> > highest frequency state for each voltage):
>> > alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
>> > duration: 0 seconds
>> > number of threads: 2
>> > number of loops: 4000000000000000
>> > delay between starting threads: 0 seconds
>> >
>> > Dhrystone(1.1) time for 1233977344 passes = 30.9
>> > This machine benchmarks at 39968549 dhrystones/second
>> >                           22748 DMIPS
>> > Dhrystone(1.1) time for 1233977344 passes = 31.0
>> > This machine benchmarks at 39817431 dhrystones/second
>> >                           22662 DMIPS
>> >
>> > Total dhrystone run time: 31.995136 seconds.
>> >
>> > Bottomline: removing the lower-frequency OPPs led to a 3.8% drop in
>> > performance in this setup. This is probably far from a reliable
>> > estimate, but I guess it indeed indicates that having lower-frequency
>> > states might be beneficial in some load scenarios.
>> 
>> Measuring a difference of about 4% may be attributed to some unknown
>> inaccuracy or test deviation, but again, a performance improvement of
>> about 4% that comes free of charge is nothing to be sneezed at, IMHO.
> 
> True :)
> 
>> > Note though that several seconds after hitting the throttling
>> > threshold cores 6-7 were oscillating between 1.608GHz and 1.8GHz in
>> > both runs, which implies that the whole difference in performance was
>> > due to different speed of initial throttling (i.e. it might be a
>> > peculiarity of the step-wise thermal governor operation when it has to
>> > go through more cooling states to reach the "steady-state" one). Given
>> > that both 1.608GHz and 1.8GHz have no lower-frequency same-voltage
>> > siblings in either of the OPP tables, it implies that under prolonged
>> > constant load there should be no performance difference at all.
>> 
>> ... all that with one possible cooling setup, and with one synthetic
>> test.  We simply can't know in advance how would a different cooling
>> setup on the same or on a different board behave, if you agree.
> 
> Of course. My only concern is whether we might be somewhat deceiving
> ourselves by that benchmarked performance boost: after all, it's also
> entirely possible that by going through multiple intermediate
> frequency states, the step-wise governor simply didn't cool the core
> just enough over some fraction of the benchmarking run, which we would
> have observed in a detailed temperature log as a higher peak
> temperature and longer residence above the throttling threshold
> temperature (and that would be the case if intermediate frequency
> states were "unsustainable" as Daniel pointed out, which they probably
> were given that the throttling didn't stop at any of them).

Well, the observed CPU frequency scaling didn't stop at any particular
OPP for an extended period of time, if I'm not mistaken?  That's even
more not to be expected under any kind of unpredictable real-world CPU
load, if you agree.

> Attributing a performance increase in this case to a benefit from
> additional intermediate OPPs is not fully fair, because then we can
> also simply move the throttling threshold higher. And it would be
> super tricky to separate the effects from greater system throughput at
> intermediate frequency states vs. greater effective thermal budget we
> allow the governor to use before it even considers throttling.

I'd agree that drawing such conclusions (or the conclusions from the
opposite end of the spectrum) wouldn't be exactly fair at this point.
Though, IMHO it's important that the test results observed so far
weren't worse with the additional same-voltage, lower-frequency OPPs.

In other words, all I ever said, basically, is that having more granular
OPPs should be helpful at best, and not harmful at worst.  How helpful
is very hard to predict, because it depends on all kinds of things.

