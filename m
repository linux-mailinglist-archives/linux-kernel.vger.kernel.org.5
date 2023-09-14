Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2127779FE47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjINI0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINI0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:26:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0F1BF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:26:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso1691595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694679995; x=1695284795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozhl2662G3rZuXjhqsyxszQ7KuzNUqIVHYGmBfOpI3w=;
        b=A+ujR7lCK0QPzFDZ9lEbsN3dANeL5dmM3Vp7zMO+03dqmZ6yr11IIlgzqFU7GjEJx9
         QCpZt98pyVYn6gOlyckROE+NmVzL/Ntpbp3liy95a+OU6jBAty/2VHyRad1Ze8SSvlHy
         H60eHrCsg0e+BII4IWOj3WtN8bOOd8RAf5oIsoqvSiAvi19URNbfTw8s2Ma6iGg4RiH5
         6rrExIPzHyf74lPkRfK/isZMcbPEk+dW/KJ/3gvv77fdqv2kTmb/mzqnDNb9QJvlRymm
         Qmr2dCCNCr9haxyQkqxdbXrT8xrbjz1Mktoj/h1HFQQBXOGZJ5MQ/4RAKScrhjWqxFZg
         ey8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679995; x=1695284795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ozhl2662G3rZuXjhqsyxszQ7KuzNUqIVHYGmBfOpI3w=;
        b=HMNcymaW5hLQSxHT0HU7vn0IyOvsz7wxHv2ekqyFCqBeJ4rlVoPF3TUkI3EKx6O0U2
         nxf05Kl/ub3ooyzq+XkfdQK3tlpF0pm6BGvovebInwzmsiLbsDxpcM50t476sz9uJYIt
         45qY78xv+AUrSNaxL45+F+ukpN3EFA8mNM6oUkvrMAlk55uAkP27hYpOlM4OP7Jz/NCY
         zZ/7MKxVwgVNzf9E35ZNZVPy/M0Ap53SrQDejFs332qRIVHFhjHHjqvRxzDvqP6vD2yj
         Tx1qSZCQt+HnLtQe4+fohVIRaFExI4zWtTOsTJPYHy5hbUETFCsZV91Necth2MmNxwKe
         kJuQ==
X-Gm-Message-State: AOJu0Yy44AlIez8gJjxQlsEXqHEz/fXmWxVyMA1fP2CSuHLGPUTM+nhk
        p3CAsj761afg+3osjC8Lg4QaVw==
X-Google-Smtp-Source: AGHT+IHCLs8m/SAS10M6PicX6kviDEG2v5YMQyuDzcsCpjnm5kBayz0bF2uCzwwp9dshmCx5Y3WdaQ==
X-Received: by 2002:a05:600c:108b:b0:401:bf56:8bb2 with SMTP id e11-20020a05600c108b00b00401bf568bb2mr3729900wmd.10.1694679994725;
        Thu, 14 Sep 2023 01:26:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494? ([2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003141a3c4353sm1091493wrn.30.2023.09.14.01.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:26:34 -0700 (PDT)
Message-ID: <93bb0a7e-3f58-4755-bf31-a694e60760d0@linaro.org>
Date:   Thu, 14 Sep 2023 10:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] irqchip: Add support for Amlogic-T7 SoCs
Content-Language: en-US, fr
To:     Huqiang Qin <huqiang.qin@amlogic.com>, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, hkallweit1@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
 <20230913080924.3336391-3-huqiang.qin@amlogic.com>
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
In-Reply-To: <20230913080924.3336391-3-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 10:09, Huqiang Qin wrote:
> The Amlogic-T7 SoCs support 12 GPIO IRQ lines compared with previous
> serial chips and have something different, details are as below.
> 
> IRQ Number:
> - 156      1 pin  on bank TESTN
> - 155:148  8 pins on bank H
> - 147:129 19 pins on bank Y
> - 128:115 14 pins on bank M
> - 114:91  24 pins on bank T
> - 90:77   14 pins on bank Z
> - 76:70    7 pins on bank E
> - 69:57   13 pins on bank D
> - 56:40   17 pins on bank W
> - 39:20   20 pins on bank X
> - 19:13    7 pins on bank C
> - 12:0    13 pins on bank B
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>   drivers/irqchip/irq-meson-gpio.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index f88df39f4129..9a1791908598 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -154,6 +154,10 @@ static const struct meson_gpio_irq_params c3_params = {
>   	INIT_MESON_S4_COMMON_DATA(55)
>   };
>   
> +static const struct meson_gpio_irq_params t7_params = {
> +	INIT_MESON_S4_COMMON_DATA(157)
> +};
> +
>   static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
>   	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
>   	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
> @@ -165,6 +169,7 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
>   	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
>   	{ .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
>   	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
> +	{ .compatible = "amlogic,t7-gpio-intc", .data = &t7_params },
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
