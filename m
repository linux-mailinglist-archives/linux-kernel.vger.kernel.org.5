Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B609D77B8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHNMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjHNMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:40:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D610E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:40:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so38687175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692016806; x=1692621606;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPY+jEXhrjcjJjgPf7QBsv25ZrENh0KuhnzLi48FeUE=;
        b=OekTk5KXyYJdvEt2nZom//pEkAn+1z1/7Z7tdpH7IQ4Uv98uMNQHSe1WmZN/EOH/Mz
         kGYjVKrZb/eZb00QbdKioR6Y1PWO4iiDLGPUWI+nPjpNfkuAOZM0k3dJityEHst4qgJi
         ixbpSxIyObrhR6gWe01jvC+0RaeX33oRoG8eTpDpmGnOMzsf4rNgikeFENKdnSpR2zqH
         lvO53OJlHkeMdbdiU15RGkacUVIJ8F/zWI1H/gGUtPNX3J01ZlIYLVZvgZD01el4DpN9
         qr7UJEQhXxs41mA+m9XaS+DzR0GIaTt/m5RkaPxGmzCbYJAys9AOfA++Zrr7h4ZyuBVv
         +iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016806; x=1692621606;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rPY+jEXhrjcjJjgPf7QBsv25ZrENh0KuhnzLi48FeUE=;
        b=T5f5YTOGHspPteH390c+9+t+oIrQR0fcQhqdP5v1RKOr5kuTPd9644E5fD70mzVeML
         O2U4TEQyY5tNXKZjsEo0RILuUF+dw8X11pA9qeo7p+iaOUNFJ0dZjMniSsccxcjxKwHD
         5y17TzbEfyUDngCobnJo8bnvFhy5Hhn5Id6QXCHTy0jvwnd3sRNflGe2w5yPfOFX3vrM
         L05WwGhlPQoRXh51/wZnyHMps7hPsy0dzvtKGg16oNrnVdzh9EZOtew4Vw9TxxpSgSnq
         SsIzR1DBRrIwIcPLS8Qx5xePcZNqes4lGpvXV319ae8P4vPo9oxi86xF3uaz/1CXKddf
         Rl0Q==
X-Gm-Message-State: AOJu0YwQzCV8CLZQOlVC5+mCKgwIh5rwSNm+XTTdQee0pBpF0AMkFLGE
        6Upoo/ef3R/EHri8phJOAdBf2A==
X-Google-Smtp-Source: AGHT+IESQmxYAQ8invo+LuS7mk45cJFiPtXV3GC3mIfli1/teCY1sJQhbbarUG1utFPIMFPDdu9srg==
X-Received: by 2002:a05:600c:259:b0:3fe:2102:8083 with SMTP id 25-20020a05600c025900b003fe21028083mr6801544wmj.26.1692016806660;
        Mon, 14 Aug 2023 05:40:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003fe24441e23sm14193823wmh.24.2023.08.14.05.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:40:06 -0700 (PDT)
Message-ID: <b5878783-303c-410a-8542-3000e214bf78@linaro.org>
Date:   Mon, 14 Aug 2023 14:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RESEND PATCH v2] drm/panel: JDI LT070ME05000 simplify with
 dev_err_probe()
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230812185239.378582-1-david@ixit.cz>
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
In-Reply-To: <20230812185239.378582-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2023 20:52, David Heidelberg wrote:
> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless error is printed.
> 
> Fixes error:
> panel-jdi-lt070me05000 4700000.dsi.0: cannot get enable-gpio -517
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> resend:
>   - applies cleanly on -next
> v2:
>   - original v1 patch name "drm/panel: JDI LT070ME05000 remove useless warning"
>   - use dev_err_probe function
> 
>   .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 36 ++++++++-----------
>   1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> index e94c98f00391..f9a69f347068 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> @@ -400,38 +400,30 @@ static int jdi_panel_add(struct jdi_panel *jdi)
>   
>   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(jdi->supplies),
>   				      jdi->supplies);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to init regulator, ret=%d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to init regulator, ret=%d\n", ret);
>   
>   	jdi->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
>   	if (IS_ERR(jdi->enable_gpio)) {
> -		ret = PTR_ERR(jdi->enable_gpio);
> -		dev_err(dev, "cannot get enable-gpio %d\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(jdi->enable_gpio),
> +				     "cannot get enable-gpio %d\n", ret);
>   	}
>   
>   	jdi->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(jdi->reset_gpio)) {
> -		ret = PTR_ERR(jdi->reset_gpio);
> -		dev_err(dev, "cannot get reset-gpios %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(jdi->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(jdi->reset_gpio),
> +				     "cannot get reset-gpios %d\n", ret);
>   
>   	jdi->dcdc_en_gpio = devm_gpiod_get(dev, "dcdc-en", GPIOD_OUT_LOW);
> -	if (IS_ERR(jdi->dcdc_en_gpio)) {
> -		ret = PTR_ERR(jdi->dcdc_en_gpio);
> -		dev_err(dev, "cannot get dcdc-en-gpio %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(jdi->dcdc_en_gpio))
> +		return dev_err_probe(dev, PTR_ERR(jdi->dcdc_en_gpio),
> +				     "cannot get dcdc-en-gpio %d\n", ret);
>   
>   	jdi->backlight = drm_panel_create_dsi_backlight(jdi->dsi);
> -	if (IS_ERR(jdi->backlight)) {
> -		ret = PTR_ERR(jdi->backlight);
> -		dev_err(dev, "failed to register backlight %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(jdi->backlight))
> +		return dev_err_probe(dev, PTR_ERR(jdi->backlight),
> +				     "failed to register backlight %d\n", ret);
>   
>   	drm_panel_init(&jdi->base, &jdi->dsi->dev, &jdi_panel_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
