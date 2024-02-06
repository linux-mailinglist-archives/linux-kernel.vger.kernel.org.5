Return-Path: <linux-kernel+bounces-54536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD884B071
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F471C22897
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95312D751;
	Tue,  6 Feb 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dv690NaZ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6012D17C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209669; cv=none; b=D2m/x2itHi6b1yecGDM/Ltt77tJK3fd3AQSF3dv7A7SJlJ5fTdH4ECBXZKA9nzZaoZdvt00p1gGEzcHYigU+fHDYW70Vhhmltxgx6/66QIKBRx8xGv4zCjWnAOyL92ToXWx+yl2VhCp2NYd6eBrm7ZqH3lZqsX/iQAa2dRnQ1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209669; c=relaxed/simple;
	bh=QiFBOTaBWVTHA5JY45pqSu/99Ao/iz+ZBi7+Bj4Wnhc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iDZUOjXhep1Rx8ndx7qibt1EqgcBxtboUEp4dwNT9tQ+eqEyXcQsap12liDP/fOKwWIVyhrEjx+vZxdUEb3ZZZPwz7tTB5QdYx48N4885QROiRa+mL2g78Op8aXN1r+I/Qcs7hnaEcyrVAvGL9WMu5je7WbqXa9AxaPMLeDwJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dv690NaZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511344235c6so6625836e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707209665; x=1707814465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpfNty4V2FJSl99hyIMrQ7HHIvMTg7pW9dV5rhCPpfQ=;
        b=dv690NaZxJBDnePz5aBuCTtGWiyZggC+kxsrUz2UPPWfwJ7tlszow9udgmoclDWv2z
         w2+amgII8rBS+PkTiWE7qM12U4+5yRaJnNNyo6FW0ATkOW6FR5OgmE+3CqfhAuSvZ0Qx
         GakFoxVGS7m1YOvTo+nBC5sXGHspnJhGB+LkqiaHDCcpRCn3vD++sDS6WhZ5dpjlk25K
         lCFw8fP1oHHmWzIsTYnkRjPhq/m4OEWRo0rXqrnCS5AB/2dGix+X5/lW2kuv5pA/KBHx
         MASk8eLlhS7NR3fbW5jHAAAC+l6QjRnRGv/hBN4KWu+Ump1xw/uii/dBuw4UruOuxo+U
         EkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209665; x=1707814465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpfNty4V2FJSl99hyIMrQ7HHIvMTg7pW9dV5rhCPpfQ=;
        b=qZpovxkKYOc45obIHI1gEnaFvy57EfY2TUFsUAAOAQWPNUYza5XVCKtPi1bKczIrC8
         CdrdBNq/3A+zHhi2fEdYYMGxg/QnQneAJRrxsd5fBvnG9LNj27+xklLKQeX9G1sOZDZD
         ffeWe1Em7SPrv31m2QvaPv93IqA9sIovSei/B12okLOCzkiW1RFnTJ8LrgEq+2p3J74l
         TCsZtLHENWOlK1Qs22igHpA4Cqjc5Pt282RCifxJSSFNBelQ90Vfgc06hSUR82E6pHjJ
         jGOTSJt5Uf1Rw289JavxS7e5MZV/zNUC5/Zv9wpFmpOEXv+L2pSMFYzZVtReH89MvXLO
         XgZQ==
X-Gm-Message-State: AOJu0Yx2xK1ftpGYaZl8aYhInRZf1ZR3EDSj3FruMObCSIFKoSS1TeBQ
	xFdDWN0SJvxt9ih9mUcb59RkP5fE+VAIxhExU7MoErfkDvD1W84dOfWzNm5HjP8=
X-Google-Smtp-Source: AGHT+IFDuq2X6Uvryx2hWt2fAZuxhgi0XTgVH8xY45EUkgsc37IDyLafR++qOnorPu2PMc+4r2ZTDw==
X-Received: by 2002:a05:6512:401c:b0:511:48ab:2f9c with SMTP id br28-20020a056512401c00b0051148ab2f9cmr1639393lfb.42.1707209665385;
        Tue, 06 Feb 2024 00:54:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsA3tHV93bjseQi9VAWCbR5rYjl+ynyrSGk88N5INNZDvQL1XbJfo95gKDoH+zgAQiLSdYxgwdKdbnOIZXHLccA5Kb+G1PYItQQr5OFFa6dwgO2VWbDNu4G1HSgoqTCqrGQ/8YublNLuk4l+uEJDy6fi7MLw4imMjw2pBxUTAkiLsSgUZepH8FTviIkskqvGoRsG20JVXnq9kas3aLPNRVa7QdvgNnqZo2GoAp3YqX+2Mirru59YyyaoEMgmPlIGVPMVAPrE4KIytrewPkTxMWdaeYD94rsG0KgWs91BeV16viAeUqRM7sUC7h0Qt+nK/DyFUI1QpfvUYYKDS/OGQhpDgD+XBJoF7fVhsBSExw9n41wmYHBs/mtFi1rJC63WnL1ox3ubEKfggpZI/FKN4OcQ==
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id fa13-20020a05600c518d00b0040fb03f803esm1251337wmb.24.2024.02.06.00.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:54:24 -0800 (PST)
Message-ID: <26732d5a-9fe1-4662-9362-ed397d266e01@linaro.org>
Date: Tue, 6 Feb 2024 09:54:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCHv1 2/5] arm64: dts: amlogic: Add cache information to the
 Amlogic SM1 SoC
Content-Language: en-US, fr
To: Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240205171930.968-1-linux.amoon@gmail.com>
 <20240205171930.968-3-linux.amoon@gmail.com>
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
In-Reply-To: <20240205171930.968-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2024 18:19, Anand Moon wrote:
> As per S905X3 datasheet add missing cache information to the Amlogic
> SM1 SoC. ARM Cortex-A55 CPU uses unified L3 cache instead of L2 cache.
> 
> - Each Cortex-A55 core has 32KB of L1 instruction cache available and
> 	32KB of L1 data cache available.
> - Along with 512KB Unified L3 cache.

This 512K number is for the NPU, AFAIK the CPU L3 Cache size isn't specified in the datasheet

> 
> To improve system performance.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Datasheet
> [0] https://dn.odroid.com/S905X3/ODROID-C4/Docs/S905X3_Public_Datasheet_Hardkernel.pdf
> [1] https://en.wikipedia.org/wiki/ARM_Cortex-A55
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 39 ++++++++++++++++++----
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 643f94d9d08e..403443e782e4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -55,7 +55,13 @@ cpu0: cpu@0 {
>   			compatible = "arm,cortex-a55";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l3>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -64,7 +70,13 @@ cpu1: cpu@1 {
>   			compatible = "arm,cortex-a55";
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l3>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -73,7 +85,13 @@ cpu2: cpu@2 {
>   			compatible = "arm,cortex-a55";
>   			reg = <0x0 0x2>;
>   			enable-method = "psci";
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l3>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -82,14 +100,23 @@ cpu3: cpu@3 {
>   			compatible = "arm,cortex-a55";
>   			reg = <0x0 0x3>;
>   			enable-method = "psci";
> -			next-level-cache = <&l2>;
> +			d-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <32>;
> +			next-level-cache = <&l3>;
>   			#cooling-cells = <2>;
>   		};
>   
> -		l2: l2-cache0 {
> +		l3: l3-cache0 {
>   			compatible = "cache";
> -			cache-level = <2>;
> +			cache-level = <3>;
>   			cache-unified;
> +			cache-size = <0x7d000>; /* L2. 512 KB */

Comment should be L3 here

> +			cache-line-size = <64>;
> +			cache-sets = <512>;
>   		};
>   	};
>   

Thanks,
Neil


