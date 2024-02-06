Return-Path: <linux-kernel+bounces-54553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C184B09C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEBBB2133D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D7E12F397;
	Tue,  6 Feb 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ui2M4FW/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68312AAD6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210010; cv=none; b=upZXtiruN57dWcPIuRmFR8+96nxMjKSMy31jQPbc3/hE6sVRgPrYnPGs8F1+/YHYJIahAhCGBBRqytSnnWyNRR/yqxjx3c5nFpudfeAqf8FHV2PKtSEYq/zHfhlXTAvgTpOPURIWrH6Hpzj+jJ2hAsXG7ObQ6HVI8AxIIyO0tDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210010; c=relaxed/simple;
	bh=gtjY3sQf2DqdnEftJrneasK4+TGQaggqxQT/e+BRxjs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HhOJ/KDDVfy6P8KhJ/EvNk8OXBxqYdz3aK+rlfYauUQkA+SzDlfcIbaXxhjMvPNBFbULlYVVCZMignouEmapC4VfINhJaZ3Fz3k8sgcW9Gmm3SkDucIum+8xzhLWVRuFWeTjB9K3QT+94CCNSff6z2GoMjz5jgD38nR+RmxeHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ui2M4FW/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b45e8a670so285284f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707210007; x=1707814807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDA/c0GB/jdNWETef5L0VlQycCa3Yy8UHzYwG7wQK70=;
        b=ui2M4FW/WzUKN1I1jCz1otybqocvIPwXXmxwnxbtClFCb7bJt5j1p81h44eQEklqay
         o6M3N2uU4M3IWGh+eqh/Kw4lfDJLgnAmcVuykjd99smFkCq2eNNr1zEDY7/vavxqrsx3
         tNfmE4OsTBdkvFPORiJPW+YT0yGwV3boWjQ1GG8P7AWRlWUI8Jg6rFGzqeNwc/N01KDQ
         LzvnWnd37HO5nCQkV51soDviDQderH0Kpb3zyc44DZT+DyniqHl8lYsuwNAqqRbkWpoO
         CdCOBrJsodsaO5UHastGPLRLBjW/nwcaF60T2WZBl25tgjn0vNsTAYVD0Tqi9g+rkcw2
         Jv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210007; x=1707814807;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qDA/c0GB/jdNWETef5L0VlQycCa3Yy8UHzYwG7wQK70=;
        b=a7vfw/Pl8wXJcR7gmEVRPTybBGa9RyTsYunKJU2gx+eN375sRqkBLtTYkv5D3cuAhM
         3mE0ahxWIXjK/2WnEtgDp0VioUvS1Ps0FhdILNaMji6O2+Av4DNrsHPnxgPtvnQKRslg
         SWLhtPplORhKwF4MRcRhC2mliHvVkZO2i2mZNlZHBBdWTAl1Hzy0spAwCT7L1JnLI0ZI
         SmvTetKdrDqNa1Q+AGw+j4MxOtCkqIG2mhxs2LoJsQdDhYkJiHumKOGQstS6usq231Zj
         sFNvaopjkew3VRwYpwPjnD+uXL/c89dTb/gdhMgLoNlur1z+5PgMGP1hv29iyE0mgHk3
         zvpw==
X-Gm-Message-State: AOJu0Yy6ATPA59Wt0ayWqtCkSNggRKUKBxIuL9yXhC25sKvlu2Gy5ViD
	SFybbX4J6+YK7MwblVOq3aJYfIwT8PO0skBEj/d8YQRfq5RnMuUlTzA/VnSKr2U=
X-Google-Smtp-Source: AGHT+IHqUCzXiZ92tM5ElUPeDFh/QSLJkor5uHIT/8y6w7/Jygp5VuISiRs526LTY2GRXOhzVt5Vjw==
X-Received: by 2002:a05:6000:11c7:b0:336:6a76:40cd with SMTP id i7-20020a05600011c700b003366a7640cdmr671376wrx.62.1707210006793;
        Tue, 06 Feb 2024 01:00:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdRnH6cUHjQXQoS9ElKgXTzO05+dvNgzt+0WhToP1pzwBZGlGik+t7zOpL2tmY8wk15cOXta1sIKcTs5uIdxm6Kwx1xQ1nbMuXLfhMNwIhi7BksXBvDhm/pAZg6q0LJKBYp9UEVZnryQIHFJOLiaaAcb0WueT1NE2xvMSEy1dG4kbqEAg9ig25tJEziWm3m/1hySTr759JCUJW4cJ1xmnSOxmQq1nvkdCF6TdqsFB9aQNOp+p5L3sGKxezskvX3qvbalN47b+ilmLBtvl+YFti3nxvJeEpHdPnl/MGd+1p45Y347nZ7XeftyPq4oajVyVYfOp+UEmchG8u+T1cthveZwHUwNCoxzYBxhIN0a7JNG0eEPiJkEavTKCXpUiUT0ejFt/0poeZdaza9egnApOE/Q==
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0040fe4b733f4sm930244wmq.26.2024.02.06.01.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 01:00:06 -0800 (PST)
Message-ID: <cf47b82c-6307-475b-af3a-eab7f09715f0@linaro.org>
Date: Tue, 6 Feb 2024 10:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCHv1 4/5] arm64: dts: amlogic: Add cache information to the
 Amlogic S922X SoC
Content-Language: en-US, fr
To: Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240205171930.968-1-linux.amoon@gmail.com>
 <20240205171930.968-5-linux.amoon@gmail.com>
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
In-Reply-To: <20240205171930.968-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/02/2024 18:19, Anand Moon wrote:
> As per S922X datasheet add missing cache information to the Amlogic
> S922X SoC.
> 
> - Each Cortex-A53 core has 32 KB of instruction cache and
> 	32 KB of L1 data cache available.
> - Each Cortex-A73 core has 64 KB of L1 instruction cache and
> 	64 KB of L1 data cache available.
> - The little (A53) cluster has 512 KB of unified L2 cache available.
> - The big (A73) cluster has 1 MB of unified L2 cache available.

Datasheet says:
The quad core Cortex™-A73 processor is paired with A53 processor in a big.Little configuration, with each
core has L1 instruction and data chaches, together with a single shared L2 unified cache with A53

And there's no indication of the L1 or L2 cache sizes.

Neil

> 
> To improve system performance.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> [0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
> [1] https://en.wikipedia.org/wiki/ARM_Cortex-A73
> [2] https://en.wikipedia.org/wiki/ARM_Cortex-A53
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 62 ++++++++++++++++++---
>   1 file changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> index 86e6ceb31d5e..624c6fd763ac 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> @@ -49,7 +49,13 @@ cpu0: cpu@0 {
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <592>;
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2_cache_l>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -59,7 +65,13 @@ cpu1: cpu@1 {
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <592>;
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l2_cache_l>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -69,7 +81,13 @@ cpu100: cpu@100 {
>   			reg = <0x0 0x100>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -79,7 +97,13 @@ cpu101: cpu@101 {
>   			reg = <0x0 0x101>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -89,7 +113,13 @@ cpu102: cpu@102 {
>   			reg = <0x0 0x102>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -99,14 +129,32 @@ cpu103: cpu@103 {
>   			reg = <0x0 0x103>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <64>;
> +			d-cache-size = <0x10000>;
> +			d-cache-sets = <64>;
> +			i-cache-line-size = <64>;
> +			i-cache-size = <0x10000>;
> +			i-cache-sets = <64>;
> +			next-level-cache = <&l2_cache_b>;
>   			#cooling-cells = <2>;
>   		};
>   
> -		l2: l2-cache0 {
> +		l2_cache_l: l2-cache-cluster0 {
>   			compatible = "cache";
>   			cache-level = <2>;
>   			cache-unified;
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
> +			cache-sets = <512>;
>   		};
>   	};
>   };


