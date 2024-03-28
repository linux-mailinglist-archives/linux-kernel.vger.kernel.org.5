Return-Path: <linux-kernel+bounces-122628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121588FA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC51F22541
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A357895;
	Thu, 28 Mar 2024 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVW2inD8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCE58108
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616512; cv=none; b=E9b0WA7W8PKwHqCkP8RpMtR730BOcf/prWGOzGb72eTZvVybBkA8vToaTVoPIe6pjFmqK0avOgkLIMIm75voX0UdaRrDQJ6nnaFEJ/WnknpZsRjQh0CjEZXuyvkSv8MQwspVGWp3bL5qsL6FLA88OTxu+nE6vlemaYk8kAlASGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616512; c=relaxed/simple;
	bh=dSvrPxa6WCXN3w4zl3cUnWipLNJXSrXaKQdnNQrMO1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D8abIX0vn2hGtBy9t2up/wgHAZDFsw8pNPcGf0RK74Eo5XKcR6ZNM0sOZWAp8BIhm3f0no6LNrKCSlR7A7Ag6ZWiWTVDmfXSNO0XsD3N0TQ9R/NEcWHGMaFYvf3FBWGr90nxlOjBuyfNGypOuhbo+UaOubVZzRUJo3VPTjQPB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVW2inD8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4154471fb81so2742395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616507; x=1712221307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ojQNUSQIFFG++1GZDeRJjvpciqnPUaIAnOJ9p1+1Mag=;
        b=FVW2inD8k00FBxETFpOZqV4bRyB/zZoSHplfvzEq8J51PqwaOMJCXnZjrKcEL8nssP
         bEr8ehXap4y+oO1eA2mygeywZOqLMowha2ksExauOOwiHpYrXMMp+3iZ4BaaDlkVrxjU
         CLU+H7YF5oN+Tztjqa/LUaOge+rQqxK3rnXQ0d+JnOB93G9dWLHsMCVxo21ISauEm8vU
         Z9KcdqJMT5mpH1bZreKrgRiwMo95Y+fmLMIWOqXO1jo3nXhcwxZKqb80h7pOtC9SJYbX
         Jh3p9v1BTTWsasccT+wqQfbAmEoJYqx4W/t0AaU2Xxm5qPReyoYvI14eC1KBkVjqnvEo
         nLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616507; x=1712221307;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojQNUSQIFFG++1GZDeRJjvpciqnPUaIAnOJ9p1+1Mag=;
        b=SGoQYPg2cP5GzzA04RXqi1ZSmW4yUvuZKDHJuETTiTPR9WUxJCqoXXLAdBBlDQmtYv
         xPA7HA1sXEeI2cOF0kFraevo9p8ujC/ICXEL1n/klsLQnLMrR07dPm8oDEhaCy74u/OS
         cnt2gBclkoyTxpXUBtFfDvFQAbDi8Ca1dyGNzXpMZMVqZd3oKwO3UUBtTxE2tBJFqL4Y
         6u3c3n1RBAmYdRgAc0WM5pSdkCsrHFC1fEwP4kCRAHYgbMBsT8jY9Dix0mIcAcBIc3rc
         zhZRmvunVVyOPVSLuAQzoXk7mGaV98aD00bpWg4L42XG2oSpCI3QWxuibgRxQhjc8gXt
         cXLg==
X-Forwarded-Encrypted: i=1; AJvYcCXtakuZ4YXS2DgXLz4FFyAp8uatfVrr/J1fOPGU0+b4+IUcD74ABBa6Kg4hhpjXpECXEEhLkSDlaWj4iCgX170zUtM1zYEcHC7qtMr8
X-Gm-Message-State: AOJu0Yzxgiifg0ODUD6vk0SoHJi8K9qCe/Xoy7F+a9RtoMlVgEt1gqDv
	QcNwuFdeBnU6ktvgP4MLXcS1NQsNElqyc4R7mHkOKku7jis39sQMfPj099fuaBc=
X-Google-Smtp-Source: AGHT+IGEUgdRPIM5y9jOXcxiqCueL/Y86qKN+/+Jit5kxPav10LkDzha4OlzWPC1QuwzziLrP5yFMw==
X-Received: by 2002:a05:600c:3505:b0:414:63c6:8665 with SMTP id h5-20020a05600c350500b0041463c68665mr2153970wmq.2.1711616507497;
        Thu, 28 Mar 2024 02:01:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b004146a1bf590sm4717532wmb.32.2024.03.28.02.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:01:46 -0700 (PDT)
Message-ID: <cff5e036-7f7c-4270-be0c-f49b196a502b@linaro.org>
Date: Thu, 28 Mar 2024 10:01:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-4-jan.dakinevich@salutedevices.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328010831.884487-4-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 02:08, Jan Dakinevich wrote:
> Add device tree bindings for A1 SoC audio clock and reset controllers.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---

> +title: Amlogic A1 Audio Clock Control Unit and Reset Controller
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jan Dakinevich <jan.dakinevich@salutedevices.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,a1-audio-clkc
> +      - amlogic,a1-audio2-clkc

What is "2"?

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 6
> +    maxItems: 7
> +
> +  clock-names:
> +    minItems: 6
> +    maxItems: 7
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,a1-audio-clkc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: input core clock
> +            - description: input main peripheral bus clock
> +            - description: input dds_in
> +            - description: input fixed pll div2
> +            - description: input fixed pll div3
> +            - description: input hifi_pll
> +            - description: input oscillator (usually at 24MHz)
> +        clocks-names:
> +          items:
> +            - const: core
> +            - const: pclk
> +            - const: dds_in
> +            - const: fclk_div2
> +            - const: fclk_div3
> +            - const: hifi_pll
> +            - const: xtal
> +      required:
> +        - '#reset-cells'
> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: input main peripheral bus clock
> +            - description: input dds_in
> +            - description: input fixed pll div2
> +            - description: input fixed pll div3
> +            - description: input hifi_pll
> +            - description: input oscillator (usually at 24MHz)
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: dds_in
> +            - const: fclk_div2
> +            - const: fclk_div3
> +            - const: hifi_pll
> +            - const: xtal

#reset-cells: false

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> +    #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
> +    #include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
> +    audio {

If there is going to be any new version/resend:
soc {

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clkc_audio: audio-clock-controller@fe050000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
So: clock-controller

> +                compatible = "amlogic,a1-audio-clkc";
> +                reg = <0x0 0xfe050000 0x0 0xb0>;
> +                #clock-cells = <1>;
> +                #reset-cells = <1>;
> +                clocks = <&clkc_audio2 AUD2_CLKID_AUDIOTOP>,
> +                         <&clkc_periphs CLKID_AUDIO>,
> +                         <&clkc_periphs CLKID_DDS_IN>,
> +                         <&clkc_pll CLKID_FCLK_DIV2>,
> +                         <&clkc_pll CLKID_FCLK_DIV3>,
> +                         <&clkc_pll CLKID_HIFI_PLL>,
> +                         <&xtal>;
> +                clock-names = "core",
> +                              "pclk",
> +                              "dds_in",
> +                              "fclk_div2",
> +                              "fclk_div3",
> +                              "hifi_pll",
> +                              "xtal";
> +        };
> +
> +        clkc_audio2: audio-clock-controller@fe054800 {

clock-controller
(so I expect resend)

> +                compatible = "amlogic,a1-audio2-clkc";
> +                reg = <0x0 0xfe054800 0x0 0x20>;
> +                #clock-cells = <1>;
> +                clocks = <&clkc_periphs CLKID_AUDIO>,
> +                         <&clkc_periphs CLKID_DDS_IN>,
> +                         <&clkc_pll CLKID_FCLK_DIV2>,
> +                         <&clkc_pll CLKID_FCLK_DIV3>,
> +                         <&clkc_pll CLKID_HIFI_PLL>,
> +                         <&xtal>;
> +                clock-names = "pclk",
> +                              "dds_in",
> +                              "fclk_div2",
> +                              "fclk_div3",
> +                              "hifi_pll",
> +                              "xtal";
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/amlogic,a1-audio-clkc.h b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
> new file mode 100644
> index 000000000000..b30df3b1ae08
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#ifndef __A1_AUDIO_CLKC_BINDINGS_H
> +#define __A1_AUDIO_CLKC_BINDINGS_H
> +
> +#define AUD_CLKID_DDR_ARB		1
> +#define AUD_CLKID_TDMIN_A		2
> +#define AUD_CLKID_TDMIN_B		3
> +#define AUD_CLKID_TDMIN_LB		4

Why both clock controllers have the same clocks? This is confusing. It
seems you split same block into two!

Best regards,
Krzysztof


