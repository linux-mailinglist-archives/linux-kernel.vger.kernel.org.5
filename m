Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D692D7F2B74
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjKULIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:08:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF62A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:08:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2afd049aso2185145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700564910; x=1701169710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjdtNxULy8GpfsKCvdM83K03LmtKeMMcPxb4JkNuP7s=;
        b=HQg+S3KVP48LXRMu5SOhU8+U+frPxkptm0p8FqeNlrdZA3ns0HFm1T+EJQxBgBQs/X
         bpeNzRlcBmYXPGFcWWJCXffc9sla89E2NrnTVuDPyslg3dUUp4bTiNJOYEDazHEOaEeK
         3PhCrmUba6mk7VOnopmO0PQD1LD9mQFY9c41q5D0nAEgtNB+VoznXMoY8s5cN/7PsOnq
         bHhNRiyeOuB8cg6AcFoK3g9RHddNxLEPApzDNGPL1tC51/f11xZlchirW667d4EkwdOI
         aMZHDRxoLYdBRIX8AvT/c1Zs+2QhD9Fxux7taBtFk+/OBFxhmCieQLIDMEAeS/1Q0Yji
         G3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564910; x=1701169710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjdtNxULy8GpfsKCvdM83K03LmtKeMMcPxb4JkNuP7s=;
        b=UE8NNiQ1HXxI2F5Q6qq35FzFyyo6F2QCjsSb4kCwgJ6fem7h0bCNMiuZhxVsKbZySh
         NQNMmvGMF2XQye5o3XHW7ddxCEqGZhK/etw+qJlC0iEQsA4tBC3qoTkeojRoveyGDUDt
         8iJOUvVrI5geHMX0omhtaBff/k+1bym9T2xk4zqCdFRiqlUmwrMSMVYWsHAxcW6cse+P
         y+aGH3ifovTgunIBlL/UVn2Rf6tZHqc5tyAfziTuvz8HkueNz3ye9axj40bk4WA/37ps
         dgzxypJ6mO73dRWs6v/U/SOrwa0IB5WzXUZm0l1sS5Hl8v/6t97BNQoMRfngfMWcDneV
         fQeA==
X-Gm-Message-State: AOJu0YzlcVYH4hZruNaP3cyBgKG0XbobFqkOxFr8FKKu4hez7ZubxnWm
        S/L8nYS3kIfjv2ubQGAYyg31Jg==
X-Google-Smtp-Source: AGHT+IE06AyXcbIInK/ALarbb+zk6R0IAgBeYBiZpcgR5OQCTkC4jUkRjeSmSTNHO5ygCD7WzMWbLg==
X-Received: by 2002:a05:600c:230a:b0:408:37d4:b5ba with SMTP id 10-20020a05600c230a00b0040837d4b5bamr8384988wmo.12.1700564910505;
        Tue, 21 Nov 2023 03:08:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a? ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
        by smtp.gmail.com with ESMTPSA id jg6-20020a05600ca00600b0040b2c195523sm449723wmb.31.2023.11.21.03.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 03:08:30 -0800 (PST)
Message-ID: <f693f5c2-7103-4d32-bc38-6832b0f46453@linaro.org>
Date:   Tue, 21 Nov 2023 12:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] iio: adc: meson: add separate config for axg SoC family
Content-Language: en-US, fr
To:     George Stark <gnstark@salutedevices.com>, jic23@kernel.org,
        lars@metafoo.de, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        u.kleine-koenig@pengutronix.de
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@salutedevices.com
References: <20231121075000.133711-1-gnstark@salutedevices.com>
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
In-Reply-To: <20231121075000.133711-1-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 08:50, George Stark wrote:
> According to Amlogic custom kernels ADC of axg SoC family requires
> unique number of setting so add dedicated config for it.

Please rephrase precising AXG has vref_select and requires this setting
to work nominally and thus requires a separate config.

With this:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index db280da9edbf..34555a85f131 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>   	.cmv_select = 1,
>   };
>   
> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> +	.has_bl30_integration = true,
> +	.clock_rate = 1200000,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
> +	.resolution = 12,
> +	.disable_ring_counter = 1,
> +	.has_reg11 = true,
> +	.vref_volatge = 1,
> +	.has_vref_select = true,
> +	.vref_select = VREF_VDDA,
> +	.cmv_select = 1,
> +};
> +
>   static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>   	.has_bl30_integration = false,
>   	.clock_rate = 1200000,
> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>   };
>   
>   static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> -	.param = &meson_sar_adc_gxl_param,
> +	.param = &meson_sar_adc_axg_param,
>   	.name = "meson-axg-saradc",
>   };
>   

