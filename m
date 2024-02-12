Return-Path: <linux-kernel+bounces-61859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086B85177F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48601C215BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE133BB34;
	Mon, 12 Feb 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziJrhYtR"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186E3C464
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750184; cv=none; b=GL5tOu8tfq3hxRP8fNdlzExrCFyxfdU4nbwpIL3Kvegbg4G9JdlvZR2XwcMhylp0CqN3VOhzvf6LsDgZTWhfihQjztHLvf1b54xM9Sihe9ILA5loXJ+eEwxXlHBPajvl1YsTGWdJUiQjea8WHOofI1l3mgMHfUqVWdZcvbZNA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750184; c=relaxed/simple;
	bh=19dBIg/bA2HoCuVl14Am2aieNUid8bHodvPuLABDvxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gpOOaAJ/mv9XtlzQXrLxOr+TMWmUMYb5YNPo3LXY8DSFGZoeQ58itq/rUvtPeXqCKMumGq1vXMFDZmopwpBFgSkti1C9bflt+XgUs53DRZKfUV4Ku51dq2HMdhQpZl/vuBPgrS8fm76wj8XSIwtdioQ+n6vbTKtaGoi2JwjPY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ziJrhYtR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116b540163so4645231e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707750181; x=1708354981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/662BTTNue4FgSV7ZIVHuGcGkzpnWLOBzkvEKQKYY5c=;
        b=ziJrhYtRMjnP7yQa/HAboyYZrjTCAXaTIxCN611B3XEYRxovE9Lk8K5kxY1OfL0CID
         X/Jj5iF4tGGVuMsy30K0fXmHHTBr13DjlCHnen4Wb0A6dUl/XnxajEufXuPP48E+QUx6
         3hQmtC+TUwm61eRBXx93A8CA3N40FLNh9rCM8PAQ9W6Wg5zKI/RK3dYediQFp8ltfgVz
         7NuntzRHi2kZNemlCu3SY8KZInYoM2cM+793X/WoZtfGqAYkEQNcbvOShwmDcpHYEBJ9
         3Hg3JH1ezP2ZLSYua9YisvkmU9bDJ5uShLKXSrThqx1mldO7WSzru4PkGKILGxsAvSub
         xqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750181; x=1708354981;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/662BTTNue4FgSV7ZIVHuGcGkzpnWLOBzkvEKQKYY5c=;
        b=nGF21K8J9raQBvuMzrkH+oppaWAJRBBYCNZG5+ZMic5LJdAPOXY8/N4A30Ex52tW3p
         /LO1p41bwg/Bf9D35C/o1SRMj56M/RwtbV7U7prMQxbKyTCpNpHDpm7sTtIrO5QkETjV
         XulyXZBsIACRwAZV9vrAEHq2FOSyRFDnbsj/04dVy34eNvPe7gZ7LPU0LeEbKbO5dEM+
         jDUqXpBV+ZaRwc9WhkQ/h0qDD4VO2bSZz7dhx6ZEf1ihcXV8BrlocoaJRHdw/QyTrBJ6
         lpY/dXtSaMtYaZZptTuieKyAJMRlW9yHjK1WBsta//oGQLpLxXjDpajcwzlLCmBSIFli
         8Lpg==
X-Gm-Message-State: AOJu0Yx2KTfawoxrVVLjUi1V5XXQwCzTDCXZhXFvJhIcC+zqPi4/b1Ij
	32bwKS7ptC/q89VARSCTraWVVxmsFn0rjUAt1Jn2nBF3LB0GxMH/0N6jkgwyEo0=
X-Google-Smtp-Source: AGHT+IHSVn6saEc+8g+EJruureTFWLvP1jCapP+oPZ7JM5PMzHmO/rA6779OUV+XcReclPSaEIsGxA==
X-Received: by 2002:ac2:5477:0:b0:511:67ee:3946 with SMTP id e23-20020ac25477000000b0051167ee3946mr4551139lfn.29.1707750180626;
        Mon, 12 Feb 2024 07:03:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt4JHf6lEB4bjIGhGNlkYerjl9WriXzWrAOiih4tkkDe3/KKaCBxYaX3+LX9tj6zUkICBDuM3LjORHPPtepNeGuOsn1sORZBMgI3WycKHTnDWvetKcBfDeqPPlOqEEsc1PJETBv6XRzm4XX2M5a1brlvuDiBlrnq/15WcswXLlkN3vujgQkOk1ljJA7KdKEXQRq9VFKwAPz+ieprrjiaYoF9Hp7IJsh2/qGTev1vfuvb+Zd5HYv9eeUVO4FsFHlrWdAufdzR68PgmolSVNmcHikh2cEc+8ch2QLvvIbhn32WAq5rAGTTEA+SfFEytF2Altf5v2kGK8jF0KTZzmza1nR1nwdPoNy9E/rXTYH5wG8+zhnz1WBHDaBRtsMHq8OvWjaUjLU2cFwtiRLGYlrCHaDigl+XUHZhE5HGyRuWWfWOfl9oa72JJfVBUrMAt53RP+CGrk9gVUP1g2U7GUfeNa4tfZhxG7WxB1g3WvCVnWswwDPK1xKivkPzVEgoGH0VLfwRCAzCymmW5g4W+ycrkq5/0IOxcIon9FY69earrxN2DwuN+dWat21J2G/Q==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id fm8-20020a05600c0c0800b0040ef718cf81sm9146044wmb.28.2024.02.12.07.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:03:00 -0800 (PST)
Message-ID: <ceb6a93d-39e0-4d12-b2bf-d27acab83a28@linaro.org>
Date: Mon, 12 Feb 2024 16:02:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] arm64: dts: amlogic: axg: move cpu cooling-cells
 to common dtsi
Content-Language: en-US, fr
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, jbrunet@baylibre.com,
 mturquette@baylibre.com, adeep@lexina.in, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, conor+dt@kernel.org
Cc: kernel@sberdevices.ru, sdfw_system_team@sberdevices.ru,
 rockosov@gmail.com, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240209212816.11187-1-ddrokosov@salutedevices.com>
 <20240209212816.11187-2-ddrokosov@salutedevices.com>
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
In-Reply-To: <20240209212816.11187-2-ddrokosov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 22:28, Dmitry Rokosov wrote:
> The CPU cooling-cells property should be located in the meson-axg common
> dtsi, as it is required for all AXG-based boards with DVFS.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   .../amlogic/meson-axg-jethome-jethub-j1xx.dtsi   | 16 ----------------
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi       |  4 ++++
>   2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> index db605f3a22b4..55802fb03a46 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> @@ -332,19 +332,3 @@ &gpio {
>   		"", "", "", "", "", // 80 - 84
>   		"", ""; // 85-86
>   };
> -
> -&cpu0 {
> -	#cooling-cells = <2>;
> -};
> -
> -&cpu1 {
> -	#cooling-cells = <2>;
> -};
> -
> -&cpu2 {
> -	#cooling-cells = <2>;
> -};
> -
> -&cpu3 {
> -	#cooling-cells = <2>;
> -};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 7e5ac9db93f8..ea96fef328e8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -74,6 +74,7 @@ cpu0: cpu@0 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -83,6 +84,7 @@ cpu1: cpu@1 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -92,6 +94,7 @@ cpu2: cpu@2 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -101,6 +104,7 @@ cpu3: cpu@3 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		l2: l2-cache0 {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

