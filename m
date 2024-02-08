Return-Path: <linux-kernel+bounces-58041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BD84E08E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FF928983D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEEA71B4A;
	Thu,  8 Feb 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="auHCtQ9E"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77896A029;
	Thu,  8 Feb 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394782; cv=none; b=eKqx/mKHMFY2xYplVXiRSaLC6I7e0evYPOlVb9tRzknOTDRxsEpW9WRfw5nuNq1mHu289WG3aG6K9PwwZsXGA1CJUQdPtHHlz+jC8rdarsrfIlR2nv0bJ8TOVnZppFLwFLyX0274tGFaZXW2bse0DopwPWHrKAvhlITNfIWP8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394782; c=relaxed/simple;
	bh=pFUviES/YwfhYn9he+4+U0jbq+cyRbO8cdpRHOdkCYs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KPR74LMRwiTjL6JgcV5l8ElAYpCJfPi+owGO5TIAFNdtFWdPdiI4M61AM2ypbsaEYD7pYBXg5ugfA829mJLx1zs0e57fhDnrAU2He8fe1Ab69/BqxUG2fAtgTqJiqdc3pzAeWF+pJ+34+TS/9DAnv3HZ0UB8dcj4ntaW8WFUQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=auHCtQ9E; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707394770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36YOQl5yjofBqXwc/rxDNpBPvDR5HhtqEDjecZoc/Gs=;
	b=auHCtQ9EY+ikdcn7n9Y994NxYEqHSwi7ECtcpDzQiKXZncaEWRA1nj6Fb4z4NRz/ngcFTI
	YRvUfmAQCpjGx7SNySMHhstX4i+e7YUZ3Gwh2akf1AUv4mwG59OrVQ5CMKKxgXUi0bqsfc
	UASKLjsWcbkVlpFZMQoioFyz0aR1GatMsYnAcGq5hlfAilKPVwShK2LcwGqL/+Pg1r8bI9
	YM049TB5kRnBVtymnHRl/ZVSCYl+1khNmUFGfaqP4rGLy6zoXJApI/Xspf9ZcVDil/Q5yO
	g2EZRGOtoxGLFACXvfjeUUcX62PgWm/7PIB5di9coP15S61guz2iUzn2C7G5QA==
Date: Thu, 08 Feb 2024 13:19:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: rockchip: Add further granularity in
 RK3588 CPU OPPs
In-Reply-To: <400e19a3f7b2de674a1db457b675233f@manjaro.org>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-4-c6222c4c78df@gmail.com>
 <400e19a3f7b2de674a1db457b675233f@manjaro.org>
Message-ID: <d2f17fdc111bba89a0e107c058d4fca0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-01-31 06:08, Dragan Simic wrote:
> On 2024-01-30 19:21, Alexey Charkov wrote:
>> This introduces additional OPPs that share the same voltage as
>> another OPP already present in the .dtsi but with lower frequency.
>> 
>> The idea is to try and limit system throughput more gradually upon
>> reaching the throttling condition for workloads that are close to
>> sustainable power already, thus avoiding needless performance loss.
>> 
>> My limited synthetic benchmarking [1] showed around 3.8% performance
>> benefit when these are in place, other things equal (not meant to
>> be comprehensive though).
> 
> I'm fine with this two-patch approach, so this important new feature
> can be merged quicker, hopefully in the current merge window.  We can
> add more OPPs later, after the additional testing is performed, of
> course if all checks out as expected.

Thanks to Radxa providing a sample Rock 5B to me, I'll be able to
join the testing in the new few days, or maybe early next week.
Looking forward to the test results. :)

>> [1] 
>> https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#me92aa0ee25e6eeb1d1501ce85f5af4e58b3b13c5
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 87 
>> +++++++++++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> index af8b932a04c1..506676985a7e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> @@ -360,6 +360,21 @@ cluster0_opp_table: opp-table-cluster0 {
>>  		compatible = "operating-points-v2";
>>  		opp-shared;
>> 
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
>>  		opp-1008000000 {
>>  			opp-hz = /bits/ 64 <1008000000>;
>>  			opp-microvolt = <675000 675000 950000>;
>> @@ -392,6 +407,27 @@ cluster1_opp_table: opp-table-cluster1 {
>>  		compatible = "operating-points-v2";
>>  		opp-shared;
>> 
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
>>  		opp-1200000000 {
>>  			opp-hz = /bits/ 64 <1200000000>;
>>  			opp-microvolt = <675000 675000 1000000>;
>> @@ -422,6 +458,21 @@ opp-2208000000 {
>>  			opp-microvolt = <987500 987500 1000000>;
>>  			clock-latency-ns = <40000>;
>>  		};
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
>>  		opp-2400000000 {
>>  			opp-hz = /bits/ 64 <2400000000>;
>>  			opp-microvolt = <1000000 1000000 1000000>;
>> @@ -433,6 +484,27 @@ cluster2_opp_table: opp-table-cluster2 {
>>  		compatible = "operating-points-v2";
>>  		opp-shared;
>> 
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
>>  		opp-1200000000 {
>>  			opp-hz = /bits/ 64 <1200000000>;
>>  			opp-microvolt = <675000 675000 1000000>;
>> @@ -463,6 +535,21 @@ opp-2208000000 {
>>  			opp-microvolt = <987500 987500 1000000>;
>>  			clock-latency-ns = <40000>;
>>  		};
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
>>  		opp-2400000000 {
>>  			opp-hz = /bits/ 64 <2400000000>;
>>  			opp-microvolt = <1000000 1000000 1000000>;
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

