Return-Path: <linux-kernel+bounces-40602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4583E30A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A635B20CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703F22EE3;
	Fri, 26 Jan 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="i/lX5Faq"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3622616;
	Fri, 26 Jan 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299459; cv=none; b=ijig1lA91DuTJNt7Rn1YXrfigMuRP1jmzv8htRGl8vOfXQFoqc76AvE0/8eJGUU6Qa7r5V6u2wzzjvmHFzD898FqKSuNmooV/Y6Sle2grxpJRgh1XQtyALd/CFMSWLfe8mpXK94Di5oe4Wwutk0fYPnhadYnrnxEx8yr+0eFzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299459; c=relaxed/simple;
	bh=WpeuBB6OF2cH1n6dbWfQ48jzm0zZaAYZoCRX4MyWQ8E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gXlxDSnTFQc29ndFquweFIGKlhS0Z9eeczmfV7htn4RCVHcWqac1pmsWXQcYBSPrK/ooE+SPyH9NlRzbTARbGQHYmpgSLCp2lZyel5pFUQYhGMBC0gmueJSMYuP33d3o5cQp25/m3j+bOhV95hisVoYARPH4QIbmOQKj8ako9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=i/lX5Faq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706299453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSe9cmELggsROW8Xa3K0sEdzswCwt2lkxHp4I65nO1s=;
	b=i/lX5FaqbJSyzbAnEJyyaHyMOF4YfJwfmEhG3d7hPKYl5Gdati1LZW5uuDVPxyQm5GvoOB
	JQrwFbRDLuiKl/9c6olOazGw5ERUg/IQKZk9vb/GZhnHAnNVGGEUxNMqpi/k2vzTM3K9nx
	SwMQ0ipJknBOEbTbruAhcgqotsJkjWO8FjFj5biTohvmu3IBvwlSYngGrb7H6XwmpnFZqm
	tZlzcD4AGC/qI7jxs92HXlXo6ojYJrvUaXnDCOqfftK24KdQw3RTVAElogAJIyFiGvLhsZ
	e9T0SjMPoeI50YvU93d8zHFdNmArScFaon66WpNc0BIC+N2ZInwLyGLLs7tPbA==
Date: Fri, 26 Jan 2024 21:04:12 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Viresh
 Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
In-Reply-To: <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
 <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
 <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org>
 <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
 <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org>
 <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
Message-ID: <0ed47e91c2d69ade447bd79bdfe5637a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-26 13:56, Daniel Lezcano wrote:
> On 26/01/2024 08:49, Dragan Simic wrote:
>> On 2024-01-26 08:30, Alexey Charkov wrote:
>>> On Fri, Jan 26, 2024 at 11:05 AM Dragan Simic <dsimic@manjaro.org> 
>>> wrote:
>>>> On 2024-01-26 07:44, Alexey Charkov wrote:
>>>> > On Fri, Jan 26, 2024 at 10:32 AM Dragan Simic <dsimic@manjaro.org>
>>>> > wrote:
>>>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
>>>> >> > On 24/01/2024 21:30, Alexey Charkov wrote:
>>>> >> >> By default the CPUs on RK3588 start up in a conservative performance
>>>> >> >> mode. Add frequency and voltage mappings to the device tree to enable
> 
> [ ... ]
> 
>>> Throttling would also lower the voltage at some point, which cools it
>>> down much faster!
>> 
>> Of course, but the key is not to cool (and slow down) the CPU cores 
>> too
>> much, but just enough to stay within the available thermal envelope,
>> which is where the same-voltage, lower-frequency OPPs should shine.
> 
> That implies the resulting power is sustainable which I doubt it is the 
> case.

Hmm, why wouldn't it be sustainable?  Would you elaborate a bit, please?
I mean, there are so many factors that can't be known for sure in 
advance,
so providing additional CPU throttling granularity can only be helpful.

> The voltage scaling makes the cooling effect efficient not the 
> frequency.
> 
> For example:
> 	opp5 = opp(2GHz, 1V) => 2 BogoWatt
> 	opp4 = opp(1.9GHz, 1V) => 1.9 BogoWatt
> 	opp3 = opp(1.8GHz, 0.9V) => 1.458 BogoWatt
> 	[ other states but we focus on these 3 ]
> 
> opp5->opp4 => -5% compute capacity, -5% power, ratio=1
> opp4->opp3 => -5% compute capacity, -23.1% power, ratio=21,6
> 
> opp5->opp3 => -10% compute capacity, -27.1% power, ratio=36.9
> 
> In burst operation (no thermal throttling), opp4 is pointless we agree 
> on that.

Well, if there's no thermal throtting at all, the opp3 is also not
needed.  In an unlikely scenario like that, the opp5 is all we need.

> IMO the following will happen: in burst operation with thermal
> throttling we hit the trip point and then the step wise governor
> reduces opp5 -> opp4. We have slight power reduction but the
> temperature does not decrease, so at the next iteration, it is
> throttle at opp3. And at the end we have opp4 <-> opp3 back and forth
> instead of opp5 <-> opp3.

Why should the temperature not decrease when switching from the opp5
to the opp4?  See, we can't assume or know in advance that reducing
the power consumption by 5% wouldn't do anything;  5% is actually
quite a lot.  If that would do absolutely nothing, then something
else would probably be wrong or not as expected.

Also, for some workloads it might be better to have rather frequent
transitions between the opp4 and the opp3, instead of staying at the
opp3 for longer priods of time.  Running 100 MHz faster can be quite
significant, especially on two CPU cores.

> It is probable we end up with an equivalent frequency average (or
> compute capacity avg).
> 
> opp4 <-> opp3 (longer duration in states, less transitions)
> opp5 <-> opp3 (shorter duration in states, more transitions)
> 
> Some platforms had their higher OPPs with the same voltage and they
> failed to cool down the CPU in the long run.
> 
> Anyway, there is only one way to check it out :)
> 
> Alexey, is it possible to compare the compute duration for 'dhrystone'
> with these voltage OPP and without ? (with a period of cool down
> between the test in order to start at the same thermal condition) ?

I agree that testing and recording as much data as possible is the best
approach.  However, quite frankly, we should run more different tests,
not only one synthetic test.

