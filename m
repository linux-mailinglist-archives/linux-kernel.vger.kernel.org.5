Return-Path: <linux-kernel+bounces-54556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8B84B0A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15131C2253B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334D12DD89;
	Tue,  6 Feb 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHrPMfKb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DC12D148
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210069; cv=none; b=Nog2nwgU+xXqxXPVtNZv3toSWr74uORy99q6TMhoaWcW7mr2b+k7ZSJCPB4KyW5Qdg3B1Q1GwXgEXi/sRf/B5IwtjLr+7D2jaB41FGiHTRVWz/CfqjN0iRPbkdQVkyXXn53qku8XgmbfLIjSP4cndfekihg9tFje/AiQo6mWsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210069; c=relaxed/simple;
	bh=Obp3+iU0NYx3LVy2xs6Xipc0ORb8bkb/WXC4pfh6d94=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VLy64EvS5Kg7BCPiFhaM3zhuiWwzPpDePTOyV5HrjrAccNMn2hDRTKzkYF24f7pF9tgZY8S9fJLnv+47rpUm5S+qnMrmPMgg2qqKI3J4lOvB/99ZoWSRTCvTdhJoxkzapdC2g9NB0y+VgoJEEvH09uOqC7WyTwuwdoFs3cp39AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHrPMfKb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so1692185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707210066; x=1707814866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dIUJgwnOyWSt0uclCiKcW3R3F0dsn7PgLN2KshxQ3w=;
        b=JHrPMfKb2dlWty49NwFfInXA2WSqwz8R1tFuHZhvcXFEO264JM87ucrOyU3cpZhodA
         xlwtyJ4a7dTMFJhDWQYum9ho644ju6dY4WQ7nSQ2qlWfwaX+tJmEYIetqe/YU0EuR79I
         k4I1ql5nCjjdBtRzFr8nhAXKqgFiN4y0GIFKwMTOCH4pXHOVPfiyNIOJxA/NA7coRH2d
         2d8A3070ribOqbNd1BXxI+5+4gBWXAKlCmJftTKHxnEQRnBEC6rkdByGXkE7n7dZIEcW
         wYXCexvhD6E9DhrlJuonRDFHZgY+ZwCepBzqWORfJaVM2FNZTLAUI+KcK8fpsm5PTyWX
         o5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210066; x=1707814866;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dIUJgwnOyWSt0uclCiKcW3R3F0dsn7PgLN2KshxQ3w=;
        b=jWnVXfZZTuaQ4IRLcOKXBhVtssMsTuU6D/SmyCQhhYQvGvlmo2+f4QH4u/xPbQ2B6U
         J7ZQ3zukfDl1JHU9X58skh6UoRzOW9jZ3kLRJVsslxmcMcgLlhaxj1O2EiKlKlX4AwbY
         X2TmhKILKMTTNAfq9ohzVbu/NkycrYY5YoODSG10poTjmT4XmqM+4sg4YSYRWo8MiqZQ
         z6a64Rd9pWH/v22ekDwjni4VpSDDJPgRIVtFiiQM7oEM1BJDV9TC7B0zDPLtmCwHNekM
         WAF58xP3fFaon4s7x/9I7iZJCSWoYONv2y3Jyr2JQvyBrniNekkeSQOL8m/L3EyZ2Dc4
         Aa+Q==
X-Gm-Message-State: AOJu0YyUgIzTEv7W8aM8FfkH92ie1e1sMJKNn/4DbcrL5ZyryVVVu++0
	zDI9D5XSQbhzVNN+hCwtcrH0RczVbh5yuOUkqLoIWffxGJlE6uYG3wLC82WfY60=
X-Google-Smtp-Source: AGHT+IGmZv5/ZwUXLZBEWIQriNR+L/Vqpbg2i5djqRd6e6lnmwcyprtpMUMQPA9dZ/hJiHJIQ4x8pQ==
X-Received: by 2002:a05:600c:4f4d:b0:40f:de25:f9a9 with SMTP id m13-20020a05600c4f4d00b0040fde25f9a9mr2756501wmq.15.1707210065859;
        Tue, 06 Feb 2024 01:01:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUP7hpkPQs7XkJMZeboQiQzxcsHpLY+gTBGwCFcvYyYWfB1HXTUMUjZdT3sGA+YwRK7KRZctuePJz8Q8x2E3sy9jf8g8SJfnPfmR5ySJuTCvMoHytOefwnpgh7w5Nve4WKMDPFPRTlzJKB2Z8csbiobrmPe6PTNitRlQLIxmwYxAtGjhySX3d7Y3qATn9a8aYUHt5mkAVmXK3S4Idxell0Hmp+ujPMOTWQlMGSeyX/DIG3rB7OWBNatXmD0tQHIYVN9R83Wfeu4bzR/osbHPvCXCEFitQ+kMlGccXMXb0/6PU+h/Pab5rUGJr6w4vdNkgxaP8M1n43VOFxpBdTjbUArN5G31siq/HVwVlf3wudQLgxMV4tBZ02MSD+z4V7ELMmqHFQqfkka
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0040fe4b733f4sm930244wmq.26.2024.02.06.01.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 01:01:05 -0800 (PST)
Message-ID: <451adbff-c2b7-4141-990d-73cf869b752f@linaro.org>
Date: Tue, 6 Feb 2024 10:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCHv1 5/5] arm64: dts: amlogic: Add cache information to the
 Amlogic A7 SoC
Content-Language: en-US, fr
To: Anand Moon <linux.amoon@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205171930.968-1-linux.amoon@gmail.com>
 <20240205171930.968-6-linux.amoon@gmail.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240205171930.968-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2024 18:19, Anand Moon wrote:
> As per A311D datasheet add missing cache information to the Amlogic A7 SoC.
> 
> - Each Cortex-A53 core has 32 KB of instruction cache and
> 	32 KB of L1 data cache available.
> - Each Cortex-A73 core has 64 KB of L1 instruction cache and
> 	64 KB of L1 data cache available.
> - The little (A53) cluster has 512 KB of unified L2 cache available.
> - The big (A73) cluster has 1 MB of unified L2 cache available.

Where did you get those numbers ? I can't find them.

Neil

> 
> To improve system performance.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> [0] https://dl.khadas.com/products/vim4/datasheet/a311d2_quick_reference_manual_v0.6.pdf
> [1] https://en.wikipedia.org/wiki/ARM_Cortex-A73
> [2] https://en.wikipedia.org/wiki/ARM_Cortex-A53
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 74 +++++++++++++++++++++
>   1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index a03c7667d2b6..72dedc40f460 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -52,6 +52,13 @@ cpu100: cpu@100 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x100>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2_cache_l>;
>   		};
>   
>   		cpu101: cpu@101{
> @@ -59,6 +66,13 @@ cpu101: cpu@101{
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x101>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2_cache_l>;
>   		};
>   
>   		cpu102: cpu@102 {
> @@ -66,6 +80,13 @@ cpu102: cpu@102 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x102>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2_cache_l>;
>   		};
>   
>   		cpu103: cpu@103 {
> @@ -73,6 +94,13 @@ cpu103: cpu@103 {
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x103>;
>   			enable-method = "psci";
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2_cache_l>;
>   		};
>   
>   		cpu0: cpu@0 {
> @@ -80,6 +108,13 @@ cpu0: cpu@0 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -87,6 +122,13 @@ cpu1: cpu@1 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -94,6 +136,13 @@ cpu2: cpu@2 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x0 0x2>;
>   			enable-method = "psci";
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -101,6 +150,31 @@ cpu3: cpu@3 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x0 0x3>;
>   			enable-method = "psci";
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
> +		};
> +
> +		l2_cache_l: l2-cache-cluster0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +		};
> +
> +		l2_cache_b: l2-cache-cluster1 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +			cache-size = <0x100000>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
>   		};
>   	};
>   


