Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7507B7BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjJDJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjJDJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:20:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADABB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:20:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40666aa674fso18410095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696411238; x=1697016038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYUpaA39Zc2Claj+3mSht0h7QLhWJIDPOIO7TJqJpH4=;
        b=c3y7TEm2ns6Fo86W7TilwzCTcitSQWD9By2zrRXJFiNVBvIwUfgd9FDHlKMIi2XY98
         r1n59QM432V5sRzJvIwBFHaeE9lzAuLxkYQWHHTiyq4sLWIAvH4HXeAobny1ERKdQsBm
         l+nyrfejQHD/xzxdmt3/lNvYMe+TSHc8DzdEsmZ2kuj6jFM2i3FO5j8EGNshagn2P7qX
         P9XPCCTM5+QsxbO4RH7C/Ld2BS4KR5SmDR8UlSNjBrhKZu5ZlNgVMAYC1WfSwf9EIhSB
         K0iZImUk8+aKO2Qe/WykjbiRtRupK2GyeL5msc0liSHad4pgwPruIgcZ1HlPR24DqMf1
         HOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411238; x=1697016038;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYUpaA39Zc2Claj+3mSht0h7QLhWJIDPOIO7TJqJpH4=;
        b=K7quXQhNcB0qOuw0K3FMzAqa6ABeF9w1YBTyintn0XOLXlNeIGsuYUJB9ozj4njChh
         GrvUpp2HCTro2IYJMVvYhwd30o1UwukICDx4LkeT/z7Gs0hhZVReLQObhRT+tVUZETIw
         szZn/WVhUAMjGTC84kU1MAC6KxXG2re500xN5I+VGlWLidxscIry7uFyb2Z64XkEsL0o
         F4ZLIwL2sxgcQ209jDv5d0H9kGJYA0gpuul396hk/fvzDgSxLLpJIhowlkTIdeXZD+bg
         zJDUBxAKn44fXkyD4k6xR1jrrna72tDHdmJRGTx2UD4pf5/2MC90SlAqqNEZs0o0RQ2h
         0IQw==
X-Gm-Message-State: AOJu0YxIhRIUPsWa1AWew8bvBOo4KdG+Qim5bE7AiJrdkwmGD7AZOFDN
        7t8vglq8OTT18ZI1CCjIN4yJTw==
X-Google-Smtp-Source: AGHT+IGhb5sZH7KTL52JvEolZHRy2oJ4mfpdYcXphWQZvT1QqIVd+xEVOW+XeIPHs63dgbbvXQ+zEg==
X-Received: by 2002:a1c:4c13:0:b0:406:7d74:a29b with SMTP id z19-20020a1c4c13000000b004067d74a29bmr1709008wmf.13.1696411237969;
        Wed, 04 Oct 2023 02:20:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5? ([2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0040531f5c51asm1032465wmq.5.2023.10.04.02.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:20:37 -0700 (PDT)
Message-ID: <2248b34e-d755-4142-986c-0ead80796e13@linaro.org>
Date:   Wed, 4 Oct 2023 11:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
Content-Language: en-US, fr
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
In-Reply-To: <20231002141020.2403652-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 16:10, Jerome Brunet wrote:
> Add support for the Libretech cottonwood board family.
> These 2 boards are based on the same PCB, with an RPi B form factor.
> 
> The "Alta" board uses an a311d while the "Solitude" variant uses an s905d3.
> 
> Co-developed-by: Da Xue <da.xue@libretech.co>
> Signed-off-by: Da Xue <da.xue@libretech.co>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |   2 +
>   .../amlogic/meson-g12b-a311d-libretech-cc.dts | 133 ++++
>   .../amlogic/meson-libretech-cottonwood.dtsi   | 610 ++++++++++++++++++
>   .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
>   4 files changed, 834 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> 

<snip>

> +
> +	leds-pwm {
> +		compatible = "pwm-leds";
> +
> +		led-green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_STATUS;
> +			linux,default-trigger = "default-on";
> +			panic-indicator;
> +			max-brightness = <255>;
> +			pwms = <&pwm_cd 1 1250 0>;
> +			active-low;
> +		};
> +
> +		led-blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_ACTIVITY;
> +			linux,default-trigger = "activity";

"activity" isn't documented, perhaps heartbeat instead ?

> +			max-brightness = <255>;
> +			pwms = <&pwm_ab 1 1250 0>;
> +			active-low;
> +		};

leds subnodes should be named as led(-[0-9a-f]+)

see Documentation/devicetree/bindings/leds/leds-pwm.yaml

> +	};
> +
> +	leds-gpio {
> +		compatible = "gpio-leds";
> +
> +		led-orange {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_STANDBY;
> +			gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		};

Ditto, but you can simply use "led" since it's the only one.

See Documentation/devicetree/bindings/leds/leds-gpio.yaml

Neil


<snip>

