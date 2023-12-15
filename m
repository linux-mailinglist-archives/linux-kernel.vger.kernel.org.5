Return-Path: <linux-kernel+bounces-1102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5A814A69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B40B21460
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707863173A;
	Fri, 15 Dec 2023 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXmDL+E1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCD315B6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3363ebb277bso457876f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702650262; x=1703255062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXEH9VTtT2t/zpTq7X/06JkbyvhU4uSrSHDYcxjTAbc=;
        b=kXmDL+E11YiUzbzZvojxiTh5xvImRSBYkRjOm6/Mg0T9dzYcPt9ONKeIXP6FCdBjks
         uRgZ2INVm8mkOnCNVfKkcxrmNz2TirndfCA1G5EjKJUN74rGXG6sG1MX5y6lj2nsFAoY
         o92tyaDtZmPDgJMcPVyis+dR0l8q98FKwxYYR75XYB/v0xhBuZfrHpp1NORl80eDvf9w
         QstohZz0RVBila1vC0aj3oh9QCJddxn8o5QRbarw4lGwiG9uDWGzA+6onkgY5C48d1yG
         DTESt8wLlDeubSJoNxT3C3SpeH4+BrU8kDsFJjUNI8iZcWe/qgp1e5O4EHNUvWFnMxgT
         cRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650262; x=1703255062;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXEH9VTtT2t/zpTq7X/06JkbyvhU4uSrSHDYcxjTAbc=;
        b=AENDIzIuVZgH4/rDNDXpK9Lq1H6ozF7q4IDRgT/eOCs0ldeqPE84WrYBuwvMtFBPxk
         NIQj/USvThsG2FD224TaG6xFgfNlgjTcmF7LqzxCIUNW62vQXKYzgjTMMlvDL/U549tk
         HZ5ngbz1WjbJ/Z0jcBYw8xSFo65CrSDd4TpANJFYntqGTJEposAkwPSPSbD/KHEEQAfm
         cBtKYTebLP5xBBxJJ6Oh0km0my2/LdXvOj3Fk7MwYOuK6rZc3D1Pn+OgGNCN5NMwsqyp
         qblZ87k7CWsDoUATKgD29aHsMOhwe0JL3DPpG70mbMzdLpco2pyVqfxhMpfluYFAZ212
         GGrg==
X-Gm-Message-State: AOJu0Yz7ZcSC4f/Vh5xxwE5VM06qDMwnh9rWmu0nT9Arn51VC7TsZ1Hg
	PofUV0xVOw0h/q5yI2AOvXSgVg==
X-Google-Smtp-Source: AGHT+IFIN7VWRruPXhKsc7yOugsDaVphWkRdcxKGcCssDSvtvEqV5NLmjGOoy/L7qIs1Ijo3rSEoAQ==
X-Received: by 2002:a5d:484f:0:b0:336:4a0f:8b26 with SMTP id n15-20020a5d484f000000b003364a0f8b26mr1446394wrs.41.1702650262205;
        Fri, 15 Dec 2023 06:24:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bfe9:1376:5584:1682? ([2a01:e0a:982:cbb0:bfe9:1376:5584:1682])
        by smtp.gmail.com with ESMTPSA id h11-20020adffd4b000000b003333298eb4bsm19124207wrs.61.2023.12.15.06.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 06:24:21 -0800 (PST)
Message-ID: <a2c851fe-2c94-4121-87f2-a9b6480c4a6e@linaro.org>
Date: Fri, 15 Dec 2023 15:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: fix format for s4 uart node
Content-Language: en-US, fr
To: xianwei.zhao@amlogic.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231215-s4-dts-v1-1-7831ab6972be@amlogic.com>
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
In-Reply-To: <20231215-s4-dts-v1-1-7831ab6972be@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 09:28, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Aliases use lowercase letters and place status in end.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts | 4 ++--
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi             | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index 18789242f05f..983caddc409c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -15,7 +15,7 @@ / {
>   	#size-cells = <2>;
>   
>   	aliases {
> -		serial0 = &uart_B;
> +		serial0 = &uart_b;
>   	};
>   
>   	memory@0 {
> @@ -36,7 +36,7 @@ secmon_reserved: secmon@5000000 {
>   	};
>   };
>   
> -&uart_B {
> +&uart_b {
>   	status = "okay";
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index c6b524e1a1ee..ce90b35686a2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -455,14 +455,14 @@ nand: nand-controller@8c800 {
>   				status = "disabled";
>   			};
>   
> -			uart_B: serial@7a000 {
> +			uart_b: serial@7a000 {
>   				compatible = "amlogic,meson-s4-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x7a000 0x0 0x18>;
>   				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> -				status = "disabled";
>   				clocks = <&xtal>, <&clkc_periphs CLKID_UART_B>, <&xtal>;
>   				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
>   			};
>   
>   			reset: reset-controller@2000 {
> 
> ---
> base-commit: 078c5db2a961f674cc27c10f15d15949eece6a49
> change-id: 20231211-s4-dts-4a1805bd56f0
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

