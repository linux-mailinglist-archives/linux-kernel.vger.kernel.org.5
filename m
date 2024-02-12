Return-Path: <linux-kernel+bounces-62043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C1851ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C072B1C21B54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7040C1F;
	Mon, 12 Feb 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ey3qaDwb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2143FB30
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757490; cv=none; b=Gr+knrmnSpsqKSjtKocDUzroJuBIg0+WAONkR0+F5t3r8yHteigBF1NxY5RYs09I5SK8ATRFnJwTlXSGP+xfPXDHLm1YtkWZUnkSir8n/x+P8Fk0jhDjM47aapeclLG/9Jr9Ip/YdWdu1zKxGtRoDgVpzWq0l85/Jcv9fZCC8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757490; c=relaxed/simple;
	bh=UZWYpgoCiXMRqnWtVyZ2yqr0FXd5am4vj8vTDipoq6c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FS068TfVcS51xC3H6H9EO1kByY0dDEC/EMkurUa/Slgrdm3n9L7V8gYaDpEVWDsdYAJE3ndZB8zwpxdP6Xtv/mn02WITnYub1aN/Sa8lC82H14vYPL8E63EzrAZ9YRr1Aw5rE1J9cbqXSXIusUpXmBrbeIwwohiW62PA9RYP+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ey3qaDwb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so28511235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757487; x=1708362287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EboZSoorMU/aGDveGWka+nBx5MaeKWpS3zEhsrSo8Ao=;
        b=ey3qaDwbo/j/oHnE9CCGlXEFdn0o7JcVHPPJP9rtKrl58EiE1BNqX7pDe38IXqgsl0
         dqvINPQzMk2C23GSthm587613ngK1XPBcQeuw4UUDICTevjC3fkyAbKbQ/Qy/cjxlXCK
         ReNhyb4Z72XSWVQ1ZXVEL7+k1YG/lrqOh6orjfwQgyJtcU1FyBn1DBzY5imTQ5eVsGlF
         Z/o1Z1RrNi26khKxIPIkIOQvxi0zNuxdSbfHbR9wSNAeMMPB8jAPCJd4Ar2riWRkKo2C
         yiUTH18s4Y/fZcUpbMFJTjLPcB9CJ131S0qfl+74Gy2WFkcvVkFCHW8GblEvEPzFd0dJ
         RmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757487; x=1708362287;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EboZSoorMU/aGDveGWka+nBx5MaeKWpS3zEhsrSo8Ao=;
        b=kj9wGoP3AI2h4xkKoE54BObwwJM768CgHz2mzkYCgG0rukONnc2FXiCc2Dcxzulpi+
         ASwfHQD0Cvi8L8az0yNW917bzmu3cleNQsGaRXxeG75ef17Ttivo45gv6L5l3GNhal/e
         wsZv8c1fFQO3JBFcvsmZuWF4L32zuIr+AptTwTJoL9AcJKANEKGcKEi5PNZkJuK+UON0
         JH9La5/Cw223kNB5vHcalhoMcTpvojf8flu9pc56HAT18O5go3MTLBQ4JKvRfhnVsOsH
         IcwsJf8R0R7mis6E58zCkXhCe4HZQ+pbUaeQCtrTBqibubPM+gJpMMs74cAysT0sZ0Kc
         rtXw==
X-Forwarded-Encrypted: i=1; AJvYcCVDQSoBZN2QYFMcLMpMMpbUeTGy60RE8oT7IEzL9ViRN0C+8ogcDkR4We3LIJft+D0eto2lJ2/45E251UGW5R8/bl32RzaV4GqV2eVm
X-Gm-Message-State: AOJu0YykSZrOaHC993Fv3cNy/JXWh/lM2F38TxCeSkWuxCZchmXRxf46
	5C17JQEf6f9N6BuoZbdJSYIMWtlG8dZxsAIshyTVP1GH8L+I2dHDbindUsiIW8Q=
X-Google-Smtp-Source: AGHT+IE1a9ilnA+p6OlC353V/A7IFuTkLJbhEXAuhv3rhLJOebkyMrkuRFyECOrY2dEMvZ8Y75Ujyg==
X-Received: by 2002:a05:600c:3d87:b0:410:ed9f:7acb with SMTP id bi7-20020a05600c3d8700b00410ed9f7acbmr1347709wmb.40.1707757487283;
        Mon, 12 Feb 2024 09:04:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXqtMKH20PfQi2t3C/eK3iPaMATY5ZstZzR5CwVKZFPpKrSC2Bj/b5SwIqmbzMMnrcsPp4yk4eJHn3l/zwjOkeyem3WCsin52VkDQCQ/Nx0YNMzioSSU6dxmIO/GrmQ0zCh9Wpq3JWB/1SjPHxSVcNaau/7r1BhOoBALSdzblusHMF2zYhwg7q2BngK4nZosCFoc50NBJNQbucCUR8XfQo2sbh7/DQCuIX16BQmU9RwJy9c1HbqtpI5LTqc2N7uRoMm/erRwTJzbl8QAuwZRRrAb3IwYeSUmuYlWyHqBD4YEE6ipUC7P4qz2uhYubXqQ0BXsVBg9Ru1rzdEL/81RvnT8EggYMTNjEmMQux6ZlP5COluu6OIRqbZTbZzjr4Hg2OvsTGMEEUUeqQB/lAbl6AFCX/BkxwtXqpY3DkoYoK4W1aB3/XhhX69YDx18SVDNKkeTu7dmYCGFd5mMpI9itiFfmrn4xBngSXWEi2Ln3UYFxW54orB4dPHDqohGcXhX4ePFinZ/n0tTvRhgJfC/+7Gy2RC1zZlbkK4WLYCyyLH4iM6PwSrAnPamArPKIKZSXZpRSep65iqD+yOBjVC7FpEo/xd+KgbaQX
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b00410e6a6403esm2462229wmq.34.2024.02.12.09.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:04:46 -0800 (PST)
Message-ID: <1d19de25-362b-4983-98ee-c1aa6d2c5cc0@linaro.org>
Date: Mon, 12 Feb 2024 18:04:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 19/20] arch: arm64: dts: meson: g12: add crypto node
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <20240212135108.549755-20-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-20-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:51, Alexey Romanov wrote:
> This patch adds a crypto node declaration for Amlogic G12-series.
> With the Amlogic crypto driver we can use HW implementation
> of SHA1/224/256 and AES algo.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index ff68b911b729..f6d7047a579c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1709,6 +1709,12 @@ internal_ephy: ethernet-phy@8 {
>   					};
>   				};
>   			};
> +
> +			crypto: crypto@3e000 {
> +				compatible = "amlogic,g12a-crypto";
> +				reg = <0x0 0x3e000 0x0 0x48>;
> +				interrupts = <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>;
> +			};
>   		};
>   
>   		aobus: bus@ff800000 {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

