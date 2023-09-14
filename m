Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1076A79FE56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjINI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjINI2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:28:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12021FF1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:28:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401187f8071so4560815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694680089; x=1695284889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxGQXNzN+NwBnNyk/TZou6F9rmpM0eYJarlgQW2CMAg=;
        b=NDEkv5O732fkaxr7OAUszavP+aipF+Pc1eJCk0bmHEebshURNIK/8VmVMPcoNM4kef
         HKLFQywMft7HssYbUG6UTvM7ehKaGfAuv1nEY9YS71jLPL6N9+3ivR6Q0vGlGkj0vbjQ
         EtxbRnR043e7J/f5AgfZjtj982azKKX8hkCmlMG1KTu5ub+E72rNTlAS3cveF7gQBryT
         hiTOKfzgHyYc8NUu105CLGHoDxXoW+hAKeirIcTGd8akePLfSGR2JyyPyeUOWCGqLhLb
         lkVAP9hIu+GkLWHjov5KmvQem6Ztg70Uffcrsh7qj5+bkhNguoIF6SWzHr3M2aVwWqaw
         4pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680089; x=1695284889;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AxGQXNzN+NwBnNyk/TZou6F9rmpM0eYJarlgQW2CMAg=;
        b=AL7n154WEdoD0kaM2VNe1inJbHhN1iqM5Wlaenk+qMnDJylRQOwx5kBQBW4cp4yj48
         ZQXn+eG8KeoCsjM6FcYV5tkmbFn0YmyQ6D72YaodZwpkt4W7tByFp0pCSv0P44edckcb
         0Esoiic2KEIMjjxyNvS6Hv1vY/qYiD2s6AS+B1u4S0JBVIF5qHKKsX8K95gJT231rcl4
         efRln3B4dLopIIsnbRC9T3J7UhHlS6NKAPhiIYDvZGbU3y5DrNCESEalSD9n6j7m0O5W
         9CXYvEJ1qVw7JB1h0CmzwPoDf+kUFT7gumKujLbSLCnhQ+KrKJabTPjfjtLdLOXMw4L0
         vbzQ==
X-Gm-Message-State: AOJu0YwShmP8xvOyEAmPIGypxDxWKQN1atnIS89S4sGot7b5S4ylqWCw
        iurwcOB2ARBPAbJhBgwDWXKU+A==
X-Google-Smtp-Source: AGHT+IFEGFDMleZi4sTo/OOg2pcnaPOtvFe5E6YxWvlKnqaMGiOQFJwFRp9lYNGJhdERHXK7yzRKVw==
X-Received: by 2002:a1c:770c:0:b0:3ff:516b:5c4c with SMTP id t12-20020a1c770c000000b003ff516b5c4cmr912355wmi.18.1694680089139;
        Thu, 14 Sep 2023 01:28:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494? ([2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003141a3c4353sm1091493wrn.30.2023.09.14.01.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:28:08 -0700 (PDT)
Message-ID: <c4cccb50-2b59-4e79-9462-5f76c7c45f33@linaro.org>
Date:   Thu, 14 Sep 2023 10:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/3] reset: reset-meson: add support for Amlogic C3 SoC
 Reset Controller
Content-Language: en-US, fr
To:     zelong dong <zelong.dong@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        yonghui.yu@amlogic.com, kelvin.zhang@amlogic.com,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
References: <20230914064018.18790-1-zelong.dong@amlogic.com>
 <20230914064018.18790-3-zelong.dong@amlogic.com>
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
In-Reply-To: <20230914064018.18790-3-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 08:40, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add a new compatible string to support for the reset controller
> on the C3 SoC. The count and offset for C3 Soc RESET registers are
> same as S4 Soc.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/reset/reset-meson.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index a7af051b17fb..f78be97898bc 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -108,6 +108,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>   	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
>   	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>   	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
> +	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
>   	 { /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
