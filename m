Return-Path: <linux-kernel+bounces-41664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6719583F607
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAA11F22087
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0F2377B;
	Sun, 28 Jan 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osdiZg8n"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F6210EC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454390; cv=none; b=DWtXVP2aqcSw3UmYOWh9p01ODVDoTJS5+nxJuKmzRnyk52kIP1vYCW0JOmVLRa5e7hzFj1IQjfV+ltLpOWvm467fziXSHQjMbRbuBF0EmoQ/+mF1JoWk9xws15xupmqa6s0chM9vvbBX0y5cyGPDigjmmZGlhU//Kd2qbQZMWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454390; c=relaxed/simple;
	bh=jzi4kRN7E6mn0sx12bR/OnSoPhoWuNopIeB+ZGs9/sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsE0gG/sJUl67uSsGR/zXMAoMOc8mTiEHZ3ccEsfOT0EjaWAFFAL11PtIfAMYxD5fj0HH5V9zTHVVU+PsCY1tnVwvjzz7fKODEL+Bp7t8KiyuoM0zXT0N+RAWDA/t3e2HWLNQFA2VCMk0hPc3vcu5YsW/Mgg/fcfux+B0/EZqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=osdiZg8n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e775695c6so16759365e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706454386; x=1707059186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gt2GoiZlVl4m7DcHB944zDkl2TnQCtXQoPzD4lLJEE4=;
        b=osdiZg8nwxO0kOz9CRPr4nqMhb3N6Iu6rRxUfSyM7BULSAAJG6VCLUE4zJHsRUL1eu
         F+8/g9ywYPd83IHJomq6g8Q+F/yRmqF/cfhTJiD+83gncnm7Vc3Oat9w58qBal7cWGqy
         Xo6kpNmS67cNADIK5Q4+uqaQsQXG9FcMS7RCnJJ/DJDEvGqrmkq5suk/bw2eMU1oXDrz
         aD0AyoOI+o7RGjTljZvxCSU4ud7wUeJ8IALk6i9AL1DlH0xJeC4waHMUsGPCaIBb15oA
         Pe6wQLoxZImtWZg78zp/HJW613q/849jkifBJEmW6uufDekheWHGMoeiKHaBVs42l4dq
         9mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706454386; x=1707059186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt2GoiZlVl4m7DcHB944zDkl2TnQCtXQoPzD4lLJEE4=;
        b=EP0QszZOaVVKR+1600wG6OsxpC2QFhXjeqYeXwe1Keff5rM2VFGvqKGxG/W6ietReA
         1wj5yrhSbQSvKxYRoeTt8Uhuif0PQi+GGdLFtzYgAALQ/LyAitwG3FGVAhFW6XwXm0A5
         U+ar+AC6iLsYfuW6B7QWIOB63qdi92wfyNt1Pfje3eKJFdFkHTJHgzh5YLfywINnD85F
         VulTB6qTYRXK6Q0X7ZmMyus2/SHF5lkB7yd1IM/i2QPFdz7TpOK96A4wAfB8FJkiwjdG
         pDiMMIKW0RRBaCYUdFLkPrqVkQpkw6yGPK9FVBg4pytGFJznudaRg+31yK3NEDyoSKTK
         Ge9w==
X-Gm-Message-State: AOJu0YxEs8Djmtv0wcE6Nz4z9tgwUbRE9k7TiXM9kDMsItNeESzgdeqa
	5XJ3aEY80tX/BHEtYfHeF8U/KjkN/xV0IM7c2iXzv6gkTJqox64AXvZeg+pG0Wg=
X-Google-Smtp-Source: AGHT+IEj9+cXeSMOZkusGROt1uVn5aKOHGnQIK07UeyCT4an0oglnKBtK3VSSbl0Sq4m0/i3YBG4PA==
X-Received: by 2002:a05:600c:3d0b:b0:40e:70c0:5054 with SMTP id bh11-20020a05600c3d0b00b0040e70c05054mr4446371wmb.2.1706454386169;
        Sun, 28 Jan 2024 07:06:26 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id fc20-20020a05600c525400b0040ed1e5d5f3sm10579779wmb.41.2024.01.28.07.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 07:06:25 -0800 (PST)
Message-ID: <ab664c65-954e-4be0-9c1f-6676694e1f11@linaro.org>
Date: Sun, 28 Jan 2024 16:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
Content-Language: en-US
To: Alexey Charkov <alchark@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>
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
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Alexey,

On 27/01/2024 20:41, Alexey Charkov wrote:
> On Sat, Jan 27, 2024 at 12:33 AM Dragan Simic <dsimic@manjaro.org> wrote:
>>
>> On 2024-01-26 14:44, Alexey Charkov wrote:
>>> On Fri, Jan 26, 2024 at 4:56 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>> On 26/01/2024 08:49, Dragan Simic wrote:
>>>>> On 2024-01-26 08:30, Alexey Charkov wrote:
>>>>>> On Fri, Jan 26, 2024 at 11:05 AM Dragan Simic <dsimic@manjaro.org> wrote:
>>>>>>> On 2024-01-26 07:44, Alexey Charkov wrote:
>>>>>>>> On Fri, Jan 26, 2024 at 10:32 AM Dragan Simic <dsimic@manjaro.org>
>>>>>>>> wrote:
>>>>>>>>> On 2024-01-25 10:30, Daniel Lezcano wrote:
>>>>>>>>>> On 24/01/2024 21:30, Alexey Charkov wrote:
>>>>>>>>>>> By default the CPUs on RK3588 start up in a conservative
>>>>>>> performance
>>>>>>>>>>> mode. Add frequency and voltage mappings to the device tree to
>>>>>>> enable
>>>>
>>>> [ ... ]
>>>>
>>>>>> Throttling would also lower the voltage at some point, which cools it
>>>>>> down much faster!
>>>>>
>>>>> Of course, but the key is not to cool (and slow down) the CPU cores too
>>>>> much, but just enough to stay within the available thermal envelope,
>>>>> which is where the same-voltage, lower-frequency OPPs should shine.
>>>>
>>>> That implies the resulting power is sustainable which I doubt it is
>>>> the
>>>> case.
>>>>
>>>> The voltage scaling makes the cooling effect efficient not the
>>>> frequency.
>>>>
>>>> For example:
>>>>          opp5 = opp(2GHz, 1V) => 2 BogoWatt
>>>>          opp4 = opp(1.9GHz, 1V) => 1.9 BogoWatt
>>>>          opp3 = opp(1.8GHz, 0.9V) => 1.458 BogoWatt
>>>>          [ other states but we focus on these 3 ]
>>>>
>>>> opp5->opp4 => -5% compute capacity, -5% power, ratio=1
>>>> opp4->opp3 => -5% compute capacity, -23.1% power, ratio=21,6
>>>>
>>>> opp5->opp3 => -10% compute capacity, -27.1% power, ratio=36.9
>>>>
>>>> In burst operation (no thermal throttling), opp4 is pointless we agree
>>>> on that.
>>>>
>>>> IMO the following will happen: in burst operation with thermal
>>>> throttling we hit the trip point and then the step wise governor
>>>> reduces
>>>> opp5 -> opp4. We have slight power reduction but the temperature does
>>>> not decrease, so at the next iteration, it is throttle at opp3. And at
>>>> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.
>>>>
>>>> It is probable we end up with an equivalent frequency average (or
>>>> compute capacity avg).
>>>>
>>>> opp4 <-> opp3 (longer duration in states, less transitions)
>>>> opp5 <-> opp3 (shorter duration in states, more transitions)
>>>>
>>>> Some platforms had their higher OPPs with the same voltage and they
>>>> failed to cool down the CPU in the long run.
>>>>
>>>> Anyway, there is only one way to check it out :)
>>>>
>>>> Alexey, is it possible to compare the compute duration for 'dhrystone'
>>>> with these voltage OPP and without ? (with a period of cool down
>>>> between
>>>> the test in order to start at the same thermal condition) ?
>>>
>>> Sure, let me try that - would be interesting to see the results. In my
>>> previous tinkering there were cases when the system stayed at 2.35GHz
>>> for all big cores for non-trivial time (using the step-wise thermal
>>> governor), and that's an example of "same voltage, lower frequency".
>>> Other times though it throttled one cluster down to 1.8GHz and kept
>>> the other at 2.4GHz, and was also stationary at those parameters for
>>> extended time. This probably indicates that both of those states use
>>> sustainable power in my cooling setup.
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
>   - run dhrystone continuously on 6 out of 8 cores to make the chip
> warm enough (`taskset -c 0-5 ./dhrystone -t 6 -r 6000` - note that on
> my machine cores 6-7 are usually the first ones to get throttled, due
> to whatever thermal peculiarities)
>   - wait for the temperature to stabilize (which happens at 79.5C)
>   - then run timed dhrystone on the remaining 2 out of 6 cores (big
> ones) to see how throttling with different OPP tables affects overall
> performance.

Thanks for taking the time to test.

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
>                             23609 DMIPS
> Dhrystone(1.1) time for 1233977344 passes = 29.8
> This machine benchmarks at 41476618 dhrystones/second
>                             23606 DMIPS
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
>                            22748 DMIPS
> Dhrystone(1.1) time for 1233977344 passes = 31.0
> This machine benchmarks at 39817431 dhrystones/second
>                            22662 DMIPS
> 
> Total dhrystone run time: 31.995136 seconds.
> 
> Bottomline: removing the lower-frequency OPPs led to a 3.8% drop in
> performance in this setup. This is probably far from a reliable
> estimate, but I guess it indeed indicates that having lower-frequency
> states might be beneficial in some load scenarios.

What is the duration between these two tests?

I would be curious if it is repeatable by inverting the setup (reduced 
OPP table and then original OPP table).

BTW: I used -l 10000 for a ~30 seconds workload more or less on the 
rk3399, may be -l 20000 will be ok for the rk3588.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


