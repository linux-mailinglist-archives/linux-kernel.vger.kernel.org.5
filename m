Return-Path: <linux-kernel+bounces-38269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F294F83BD63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A432E29044E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E091BDE2;
	Thu, 25 Jan 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9bz5TP4"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515E1CD22
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175025; cv=none; b=QEZA5atPuuYiIUfuPcw6e/cBaDEDktwILh9eMUDKSibxCxcqDj46AKPtO0PvIoNGCOA21VecE5bUD5MIfcfNfiYgECOjdRBXaqqRoaagEhU+NU73k5k88Oh5WmHYKHFMrHcwNbxUYIEtEBOHYo/xG2Tpq17upOa3OELogICRsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175025; c=relaxed/simple;
	bh=+z8U3jmkrYITgqElhgcXRMdg31Uor/mf5V6CeNez3JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRXnq1O6EpgThE0JClBGYsGDsLTnMNhWN8+smNGs299/GUTigBsboWg9kKgd0cjz7Tq45TITC3J7YyfcwMyC+MZRHmuLezEVfRWun+it9L1Y4ClGeJcm9LFAp/lxqVMTGceT/pXnF0VeXZ7CKV/+SPdrMABL9PcwjOUKINAUaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9bz5TP4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so76204695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706175022; x=1706779822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZ93Ung9UFj9gEmUJ9dbTh7s4u6LdRY89gOu3DzOeMw=;
        b=R9bz5TP42ob88mBEkjL4/Ahdn70pmu17HWyVDSdTrnYCeiSB1tg5XRo4xXkiAOCKVr
         5swLsF88KebPCNaC5YGN0QUjY7h5pYA0GWcwdTfOIoCSwIn0egI60N0rF4WEPC2vSU3Y
         SZZt8+bF97Y11hDwBSlDF2OkkH++AvXBJhy3gupK/BB9V2UtSRCKa0kQntOKiWmvL6G+
         njeTbatXSP7lpjbyBBBg4PWvxNZQzA4vWC3LbeSOUIklM6kFp0q8XNbSHLfw3x0vWq38
         EYcYrBb5nsazJQphNORsw5+ip8dUHml5zVwr9ufbOkPMRa2zDXTtdlslDsbhGQbv1UbP
         9geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175022; x=1706779822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ93Ung9UFj9gEmUJ9dbTh7s4u6LdRY89gOu3DzOeMw=;
        b=AnGWp0ClKHJGorrtXCF8ZpBCAOE6twqeh4TVQq+Fian8X3wD0Ge3Q/1hr0kPvU8tSF
         9nGG4jUJObmLliAL7xVlRY/YEz3XJ7Jpo2c6IaoEUy0QOhRjo6i4pWf6yGaGDyIaYnOY
         VJLuyspmOeaCfT/5F/6zVnyT3fJshtI6Q85Z7xWDX2RK22hCHLOVVklLXP6LBqif4yES
         gQh9GvMvHCYYsSzETTp+ft9DiImV+nXQfu6E25NKvGEjg9u3oOO2cycG8nD6WZzuGC6n
         hIZ10Z71hoaUJgUuq6vUR2BKMM+mWVHeTLQy0xYIB5fMm8l5A3W44BbtYuJXsNq3F9U7
         wb0A==
X-Gm-Message-State: AOJu0YwpG9CT0cvp2p66jPFtVFE6ZjRVUqrag7SP0Al3jhX7QZYbAqus
	BwH1GuZtqe8uz/4hBmZ9lZAedHCwunJ+iWzcte/zGT/VlDOmNI5rtIfP0JqmsUk=
X-Google-Smtp-Source: AGHT+IFW9Dh9uQSkOuMQVDpLAUQv+08vOtsrRbDpJ59aMyH0jm7MsfbpJ9gZPI/GPcA4/RL6Ig0vBg==
X-Received: by 2002:a05:600c:4747:b0:40e:48e9:b47f with SMTP id w7-20020a05600c474700b0040e48e9b47fmr242908wmo.147.1706175021858;
        Thu, 25 Jan 2024 01:30:21 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:3efc:18bf:254:203f? ([2a05:6e02:1041:c10:3efc:18bf:254:203f])
        by smtp.googlemail.com with ESMTPSA id er9-20020a05600c84c900b0040e596320bfsm733750wmb.0.2024.01.25.01.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:30:21 -0800 (PST)
Message-ID: <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
Date: Thu, 25 Jan 2024 10:30:20 +0100
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
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Alexey,

Adding Viresh

On 24/01/2024 21:30, Alexey Charkov wrote:
> By default the CPUs on RK3588 start up in a conservative performance
> mode. Add frequency and voltage mappings to the device tree to enable
> dynamic scaling via cpufreq
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 209 ++++++++++++++++++++++++++++++
>   1 file changed, 209 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 131b9eb21398..e605be531a0f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
>   			assigned-clocks = <&scmi_clk SCMI_CLK_CPUL>;
>   			assigned-clock-rates = <816000000>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <32768>;
>   			i-cache-line-size = <64>;
> @@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <530>;
>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <32768>;
>   			i-cache-line-size = <64>;
> @@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <530>;
>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <32768>;
>   			i-cache-line-size = <64>;
> @@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <530>;
>   			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> +			operating-points-v2 = <&cluster0_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <32768>;
>   			i-cache-line-size = <64>;
> @@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
>   			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
>   			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
>   			assigned-clock-rates = <816000000>;
> +			operating-points-v2 = <&cluster1_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <65536>;
>   			i-cache-line-size = <64>;
> @@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
>   			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
> +			operating-points-v2 = <&cluster1_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <65536>;
>   			i-cache-line-size = <64>;
> @@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
>   			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
>   			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
>   			assigned-clock-rates = <816000000>;
> +			operating-points-v2 = <&cluster2_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <65536>;
>   			i-cache-line-size = <64>;
> @@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
>   			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
> +			operating-points-v2 = <&cluster2_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP>;
>   			i-cache-size = <65536>;
>   			i-cache-line-size = <64>;
> @@ -348,6 +356,207 @@ l3_cache: l3-cache {
>   		};
>   	};
>   
> +	cluster0_opp_table: opp-table-cluster0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 950000>;
> +			clock-latency-ns = <40000>;
> +		};

It is not useful to introduce OPP with the same voltage. There is no 
gain in terms of energy efficiency as the compute capacity is linearly 
tied with power consumption (P=CxFxV²) in this case.

For example, opp-408 consumes 2 bogoWatts and opp-816 consumes 4 
bogoWatts (because of the same voltage).

For a workload, opp-408 takes 10 sec and opp-816 takes 5 sec because it 
is twice faster.

The energy consumption is:

opp-408 = 10 x 2 = 20 BogoJoules
opp-816 = 5 x 4 = 20 BogoJoules


> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <712500 712500 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <762500 762500 950000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <850000 850000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <950000 950000 950000>;
> +			clock-latency-ns = <40000>;
> +		};
> +	};
> +
> +	cluster1_opp_table: opp-table-cluster1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};

same comment

> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <725000 725000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <762500 762500 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <850000 850000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <925000 925000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2208000000 {
> +			opp-hz = /bits/ 64 <2208000000>;
> +			opp-microvolt = <987500 987500 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2256000000 {
> +			opp-hz = /bits/ 64 <2256000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2352000000 {
> +			opp-hz = /bits/ 64 <2352000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2400000000 {
> +			opp-hz = /bits/ 64 <2400000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};

Same comment

> +	};
> +
> +	cluster2_opp_table: opp-table-cluster2 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <675000 675000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <725000 725000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <762500 762500 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <850000 850000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <925000 925000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2208000000 {
> +			opp-hz = /bits/ 64 <2208000000>;
> +			opp-microvolt = <987500 987500 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2256000000 {
> +			opp-hz = /bits/ 64 <2256000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2304000000 {
> +			opp-hz = /bits/ 64 <2304000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2352000000 {
> +			opp-hz = /bits/ 64 <2352000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp-2400000000 {
> +			opp-hz = /bits/ 64 <2400000000>;
> +			opp-microvolt = <1000000 1000000 1000000>;
> +			clock-latency-ns = <40000>;
> +		};

Same comment

> +	};
> +
>   	firmware {
>   		optee: optee {
>   			compatible = "linaro,optee-tz";
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


