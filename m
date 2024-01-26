Return-Path: <linux-kernel+bounces-40631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBE83E36A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B599B23A15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770D241F9;
	Fri, 26 Jan 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SsUhNX5U"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45522EFD;
	Fri, 26 Jan 2024 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301248; cv=none; b=MTzyia/ANJrD8USE3xY2bX0aP37UbQAM5VyLEZCE2v78TCl9sMyl0p0xWMaaoerh1DGqIltUkHSkFOOT27QqhviaceSz1CuSmYkbHQGqo8HRzFKJYBqPaMyz6WOit4/cyEc4HfVlv8wcPjGV/4tt+TiNzoSkQ8FRbH+RWZEaHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301248; c=relaxed/simple;
	bh=sKBrsdN/iJke+2dWjEF0/Ha3HtiNQ2D+bvtta5HSQ3Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M5vQEDed79ccOiszGdvcS5vvKgPcSHVcFIp5dzsbBue0ZttYHZdGN9zqPULBgMehyTu4EmO9m+UPnbe1e0U4WiG+xw5ZsmorqtjMHaMjUjdS+XseBBaSvdp8BR3avhNGRV9/zo0DjypZu33X604u5l/dzBFd1d6kQn1j8efCW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SsUhNX5U; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706301236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bkky5+8g2as3GmXZ7aK+16GJ7KzrivQxWuDMt15LR88=;
	b=SsUhNX5UUohuK4UCzWLce7nSoGb0yMZ8As2yLWT8gB5zQLuuO9OcVCw7sOaRR8GiSUxAL3
	PVNVZBgHqLW/p+0gQQTdMgnklbEnVKFKuSd5+Q6FySV5eZlSJmo9ZISNHW7Xs61EBv61K7
	Oim6Wb41A1OQjrYd2GU/tRCaqqfTjNTTG54IPGunLUpzQdbNCwXFHNpExAPv5WWt6QpmBh
	r6v+xE4BCj31YFkx7/chTp3/2S3AJ2XffLr+XMVcKqVuTcVJ7lfSdBaz3VGpEiTEp/VClI
	NV2abjb2QTsEYZ3CYy3VJiJUV8QPVLqN3UgP7QDw4FkdBMbtDIg7WTp1XjfJkQ==
Date: Fri, 26 Jan 2024 21:33:56 +0100
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
In-Reply-To: <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com>
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
Message-ID: <5ef9bab979260884866efe30d19ba8f1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-26 14:44, Alexey Charkov wrote:
> On Fri, Jan 26, 2024 at 4:56 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 26/01/2024 08:49, Dragan Simic wrote:
>> > On 2024-01-26 08:30, Alexey Charkov wrote:
>> >> On Fri, Jan 26, 2024 at 11:05 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >>> On 2024-01-26 07:44, Alexey Charkov wrote:
>> >>> > On Fri, Jan 26, 2024 at 10:32 AM Dragan Simic <dsimic@manjaro.org>
>> >>> > wrote:
>> >>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
>> >>> >> > On 24/01/2024 21:30, Alexey Charkov wrote:
>> >>> >> >> By default the CPUs on RK3588 start up in a conservative
>> >>> performance
>> >>> >> >> mode. Add frequency and voltage mappings to the device tree to
>> >>> enable
>> 
>> [ ... ]
>> 
>> >> Throttling would also lower the voltage at some point, which cools it
>> >> down much faster!
>> >
>> > Of course, but the key is not to cool (and slow down) the CPU cores too
>> > much, but just enough to stay within the available thermal envelope,
>> > which is where the same-voltage, lower-frequency OPPs should shine.
>> 
>> That implies the resulting power is sustainable which I doubt it is 
>> the
>> case.
>> 
>> The voltage scaling makes the cooling effect efficient not the 
>> frequency.
>> 
>> For example:
>>         opp5 = opp(2GHz, 1V) => 2 BogoWatt
>>         opp4 = opp(1.9GHz, 1V) => 1.9 BogoWatt
>>         opp3 = opp(1.8GHz, 0.9V) => 1.458 BogoWatt
>>         [ other states but we focus on these 3 ]
>> 
>> opp5->opp4 => -5% compute capacity, -5% power, ratio=1
>> opp4->opp3 => -5% compute capacity, -23.1% power, ratio=21,6
>> 
>> opp5->opp3 => -10% compute capacity, -27.1% power, ratio=36.9
>> 
>> In burst operation (no thermal throttling), opp4 is pointless we agree
>> on that.
>> 
>> IMO the following will happen: in burst operation with thermal
>> throttling we hit the trip point and then the step wise governor 
>> reduces
>> opp5 -> opp4. We have slight power reduction but the temperature does
>> not decrease, so at the next iteration, it is throttle at opp3. And at
>> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.
>> 
>> It is probable we end up with an equivalent frequency average (or
>> compute capacity avg).
>> 
>> opp4 <-> opp3 (longer duration in states, less transitions)
>> opp5 <-> opp3 (shorter duration in states, more transitions)
>> 
>> Some platforms had their higher OPPs with the same voltage and they
>> failed to cool down the CPU in the long run.
>> 
>> Anyway, there is only one way to check it out :)
>> 
>> Alexey, is it possible to compare the compute duration for 'dhrystone'
>> with these voltage OPP and without ? (with a period of cool down 
>> between
>> the test in order to start at the same thermal condition) ?
> 
> Sure, let me try that - would be interesting to see the results. In my
> previous tinkering there were cases when the system stayed at 2.35GHz
> for all big cores for non-trivial time (using the step-wise thermal
> governor), and that's an example of "same voltage, lower frequency".
> Other times though it throttled one cluster down to 1.8GHz and kept
> the other at 2.4GHz, and was also stationary at those parameters for
> extended time. This probably indicates that both of those states use
> sustainable power in my cooling setup.

IMHO, there are simply too many factors at play, including different
possible cooling setups, so providing additional CPU throttling
granularity can only be helpful.  Of course, testing and recording
data is the way to move forward, but I think we should use a few
different tests.

> Note though that I still have that tiny heatsink installed (even
> though I disable the fan during tests), and in this setup the
> temperature drops from 85C to around 70C in a matter of seconds as
> soon as the load stops. And if I enable the fan then it balances the
> temperature at the control setpoint of 55C using less than full fan
> speed with 8 threads of dhrystone running for extended time (and the
> PWM value chosen by the step-wise governor stabilizes at 240 out of
> 255). Looks like my prior assessment that "the fan is not super mighty
> vs. the total thermal output" was wrong after all, despite its modest
> size :)

Quite frankly, I wouldn't dare to run an RK3588 (or an RK3399) with
absolutely no heatsink attached, so I think your minimal cooling setup
(i.e. with the fan disconnected) is fine.

