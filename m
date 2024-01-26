Return-Path: <linux-kernel+bounces-39664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87983D48B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240531F25B98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E814282;
	Fri, 26 Jan 2024 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="no93Fid2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C91CD09;
	Fri, 26 Jan 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250805; cv=none; b=grkq/90Wij5PwsTJfDFQQV2lZnETqCvWM06NaRY7tfSwZaKmC6gQvVToBpA9K/4XQAClwtVdsAY9YMqyP1c60TlXZ3Gl/2byqBMWpIT2dfortqNzHlNd95ZSqcABOK7FbSQUj2fnUysJl/PXUfduRUgKzOaznsSi4w1WWuYgSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250805; c=relaxed/simple;
	bh=offJf0VyPfS398yjWNlM0xXnYpWKsuZjYq2pMB/MOvw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NWPUB6qtR7NHEWfNVw0ZDP8M+Qr4ASJmY9wZRnBRkwoq6jYR6k7zWnaFDbB0kS8RfnEy7XyMpKgjzy7zQkM7+oE7UGyCWnPyNyJh2rc/5WFvOfDU6Mc9DxS5i4EN4c8W89Rku3QCK74sMxQHFkU++ynMonLC8stYu2R7E5qfqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=no93Fid2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706250777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MRXlIIy0VD0/u+N1s9Ud2jR0dqZGBtr7S8gaTLUY6A=;
	b=no93Fid2gKwZxc/LA/Zhl/z4VJlThQTh9J+jTG7pzoFUX2SFJyMy1ipzg+Y8e2f9maC+Yh
	34RLPbl7mfbjEU7WBbhbyf3j7GROGpOmxlLBFfuiQg4248OeDuuIBqPv02QFrBEwnLeUfa
	bLNwDDujQN8irHGX0RNYCZo8yUICInDPaGH+TiY4HEMYby+LKt1TsdMc2Yg4BmQvN/NyTC
	TaUkfxq1GWzbIQh8qORPfX2skYnCKvjbNtsAMue+hd3yqJ/nUUcQvTwEWQQ3d6UfGC6nYK
	HtwgkBYqinII6RRCF5u2rDkBhYHW4UCvBijHSlvn3awElzaLJqWNN7DwpI1Qpw==
Date: Fri, 26 Jan 2024 07:32:55 +0100
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
In-Reply-To: <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
 <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
Message-ID: <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Daniel,

On 2024-01-25 10:30, Daniel Lezcano wrote:
> On 24/01/2024 21:30, Alexey Charkov wrote:
>> By default the CPUs on RK3588 start up in a conservative performance
>> mode. Add frequency and voltage mappings to the device tree to enable
>> dynamic scaling via cpufreq
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 209 
>> ++++++++++++++++++++++++++++++
>>   1 file changed, 209 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> index 131b9eb21398..e605be531a0f 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> @@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
>>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
>>   			assigned-clocks = <&scmi_clk SCMI_CLK_CPUL>;
>>   			assigned-clock-rates = <816000000>;
>> +			operating-points-v2 = <&cluster0_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <32768>;
>>   			i-cache-line-size = <64>;
>> @@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
>>   			enable-method = "psci";
>>   			capacity-dmips-mhz = <530>;
>>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
>> +			operating-points-v2 = <&cluster0_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <32768>;
>>   			i-cache-line-size = <64>;
>> @@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
>>   			enable-method = "psci";
>>   			capacity-dmips-mhz = <530>;
>>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
>> +			operating-points-v2 = <&cluster0_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <32768>;
>>   			i-cache-line-size = <64>;
>> @@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
>>   			enable-method = "psci";
>>   			capacity-dmips-mhz = <530>;
>>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
>> +			operating-points-v2 = <&cluster0_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <32768>;
>>   			i-cache-line-size = <64>;
>> @@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
>>   			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
>>   			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
>>   			assigned-clock-rates = <816000000>;
>> +			operating-points-v2 = <&cluster1_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <65536>;
>>   			i-cache-line-size = <64>;
>> @@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
>>   			enable-method = "psci";
>>   			capacity-dmips-mhz = <1024>;
>>   			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
>> +			operating-points-v2 = <&cluster1_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <65536>;
>>   			i-cache-line-size = <64>;
>> @@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
>>   			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
>>   			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
>>   			assigned-clock-rates = <816000000>;
>> +			operating-points-v2 = <&cluster2_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <65536>;
>>   			i-cache-line-size = <64>;
>> @@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
>>   			enable-method = "psci";
>>   			capacity-dmips-mhz = <1024>;
>>   			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
>> +			operating-points-v2 = <&cluster2_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP>;
>>   			i-cache-size = <65536>;
>>   			i-cache-line-size = <64>;
>> @@ -348,6 +356,207 @@ l3_cache: l3-cache {
>>   		};
>>   	};
>>   +	cluster0_opp_table: opp-table-cluster0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-408000000 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <675000 675000 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <675000 675000 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <675000 675000 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <675000 675000 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
> 
> It is not useful to introduce OPP with the same voltage. There is no
> gain in terms of energy efficiency as the compute capacity is linearly
> tied with power consumption (P=CxFxV²) in this case.
> 
> For example, opp-408 consumes 2 bogoWatts and opp-816 consumes 4
> bogoWatts (because of the same voltage).
> 
> For a workload, opp-408 takes 10 sec and opp-816 takes 5 sec because
> it is twice faster.
> 
> The energy consumption is:
> 
> opp-408 = 10 x 2 = 20 BogoJoules
> opp-816 = 5 x 4 = 20 BogoJoules

I'd respectfully disagree that including multiple OPPs with the same 
voltage
but different frequencies isn't useful.  Please allow me to explain.

See, the total amount of consumed energy is, in general, the same for 
such
OPPs and the same CPU task(s), if we ignore the static leakage current 
and
such stuff, which isn't important here.  Though, the emphasis here is on
"total", i.e. without taking into account the actual amount of time 
required
for the exemplified CPU task(s) to complete.  If the total amount of 
time
is quite short, we aren't going to heat up the package and the board 
enough
to hit the CPU thermal throttling;  this approach is also sometimes 
referred
to as "race to idle", which is actually quite effective for 
battery-powered
mobile devices that tend to load their CPU cores in bursts, while 
remaining
kind of inactive for the remaining time.

However, if the CPU task(s) last long enough to actually saturate the 
thermal
capacities of the package and the board or the device, we're getting 
into the
CPU throttling territory, in which running the CPU cores slower, but 
still as
fast as possible, may actually be beneficial for the overall CPU 
performance.
By running the CPU cores slower, we're lowering the power and 
"spreading" the
total energy consumption over time, i.e. we're making some time to allow 
the
generated heat to dissipate into the surroundings.  As we know, having 
more
energy consumed by the SoC means more heat generated by the SoC, but the
resulting temperature of the SoC depends on how fast the energy is 
consumed,
which equals to how fast the CPUs run;  of course, all that is valid 
under
the reasonable assumption that the entire cooling setup, including the 
board
surroundings, remains unchanged all the time.

Having all that in mind, having a few OPPs with the same voltage but 
different
frequencies can actually help us achieve better CPU performance.  That 
way,
throttling won't have to slow the CPUs more than it's actually needed to 
hit
and maintain the desired thermal trip temperatures.

>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <712500 712500 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1416000000 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <762500 762500 950000>;
>> +			clock-latency-ns = <40000>;
>> +			opp-suspend;
>> +		};
>> +		opp-1608000000 {
>> +			opp-hz = /bits/ 64 <1608000000>;
>> +			opp-microvolt = <850000 850000 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <950000 950000 950000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +	};
>> +
>> +	cluster1_opp_table: opp-table-cluster1 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-408000000 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +			opp-suspend;
>> +		};
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
> 
> same comment
> 
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1416000000 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <725000 725000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1608000000 {
>> +			opp-hz = /bits/ 64 <1608000000>;
>> +			opp-microvolt = <762500 762500 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <850000 850000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2016000000 {
>> +			opp-hz = /bits/ 64 <2016000000>;
>> +			opp-microvolt = <925000 925000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2208000000 {
>> +			opp-hz = /bits/ 64 <2208000000>;
>> +			opp-microvolt = <987500 987500 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2256000000 {
>> +			opp-hz = /bits/ 64 <2256000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2304000000 {
>> +			opp-hz = /bits/ 64 <2304000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2352000000 {
>> +			opp-hz = /bits/ 64 <2352000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2400000000 {
>> +			opp-hz = /bits/ 64 <2400000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
> 
> Same comment
> 
>> +	};
>> +
>> +	cluster2_opp_table: opp-table-cluster2 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-408000000 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +			opp-suspend;
>> +		};
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <675000 675000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1416000000 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <725000 725000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1608000000 {
>> +			opp-hz = /bits/ 64 <1608000000>;
>> +			opp-microvolt = <762500 762500 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <850000 850000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2016000000 {
>> +			opp-hz = /bits/ 64 <2016000000>;
>> +			opp-microvolt = <925000 925000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2208000000 {
>> +			opp-hz = /bits/ 64 <2208000000>;
>> +			opp-microvolt = <987500 987500 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2256000000 {
>> +			opp-hz = /bits/ 64 <2256000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2304000000 {
>> +			opp-hz = /bits/ 64 <2304000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2352000000 {
>> +			opp-hz = /bits/ 64 <2352000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp-2400000000 {
>> +			opp-hz = /bits/ 64 <2400000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +			clock-latency-ns = <40000>;
>> +		};
> 
> Same comment
> 
>> +	};
>> +
>>   	firmware {
>>   		optee: optee {
>>   			compatible = "linaro,optee-tz";
>> 

