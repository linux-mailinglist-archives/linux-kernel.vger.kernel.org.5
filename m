Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7B804C07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbjLEIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:14:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243EFA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:14:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332c46d5988so4197120f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701764062; x=1702368862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3r3u+lfPgj1JME98keqJXmNsSgVU0cZOaWgFI+wHvyU=;
        b=liDAgww0Wjh7ayUTJO7c9pWWzF/+O4Nhw7rxjJUgK8WqMQ5W6IBDiVWA7TFlvXHCUl
         8F7+5uD6PNBkQpHbBO+pnCJSYxiqeWQmKsLj/2rGLEh4aTyDRhyU21xV0g5eFxtjaeSM
         M5MLFld5zO4i5BteIe+nPY4jSy+7jQtJ7ceICKB9I/KgJUvUcne4cL/zphoUSizyZvp2
         0cBdXTcvMJqcQShPjgcCiGS+dyOnTCwm3DVAa+QW1ib36mwXVQHlN0fju6ZRn7a4BZj4
         b9kHk9j9c69rVdsj93VtwsmmBZp74FqFEvHEO/wyEtMqgp/lOEALihV3jzHNjcItrgsw
         Gvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764062; x=1702368862;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3r3u+lfPgj1JME98keqJXmNsSgVU0cZOaWgFI+wHvyU=;
        b=DHgfGhzGpjrmuDtlnsgHjmTIclODESOO04ikbVyTzhZsJYH1xMobSYyYvSLWv+Io54
         SU6t9wm+r3jcIli+C0YzZM22YIq+CLnZmzijSQQ59SrluyUG4k1Q2U+l7G0s46JP+YbE
         4ceme4W8CyqqJx9Nkei206RgYGEvMYvIz/3qQuCyBosYsm7xR6mPPjVT7L79dHGVQ9S/
         6c45Is+43a/rR4l4dRO3TPIPSj6jbnS1gQ4vPEfFpAyqLqN/feeDrP1a22wAZxhESBGy
         +mFCKRl0fGE/fzZRSxeF38C6JJClvgDlWsmAXswL+9jWWzRyUrztgcag3znqaXPLSC6L
         Ongw==
X-Gm-Message-State: AOJu0YzN4+lc3tZaBTTd3l0KOTi08cJbXcDVJ1hx6018W9XGSVJdv3/V
        ztm5FttmomxSwYazQYiuoKEDEQ==
X-Google-Smtp-Source: AGHT+IGVKYcMrW+WT06NoqnE3KfNoyRxuwkiBfywhYdAyuWS9yEvlOB6hd1OtWDyG/1dfRdI7b+2ww==
X-Received: by 2002:a1c:4c19:0:b0:408:57bb:ef96 with SMTP id z25-20020a1c4c19000000b0040857bbef96mr246760wmf.30.1701764061761;
        Tue, 05 Dec 2023 00:14:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb? ([2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b004063cd8105csm21461190wmo.22.2023.12.05.00.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:14:21 -0800 (PST)
Message-ID: <600382c8-9560-4228-b621-b41e28b2ace4@linaro.org>
Date:   Tue, 5 Dec 2023 09:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel-simple: add Evervision VGG644804 panel
 entry
Content-Language: en-US, fr
To:     Michael Walle <mwalle@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123102404.2022201-1-mwalle@kernel.org>
 <20231123102404.2022201-2-mwalle@kernel.org>
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
In-Reply-To: <20231123102404.2022201-2-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 11:24, Michael Walle wrote:
> Timings taken from the datasheet, although sometimes there are just
> typical values and it's not clear if they are no min and max values or
> if you must use the typical value exactly. To make things worse, there
> is no back porch but only a combined sync and back porch length.
> 
> Unfortunately, there is not public datasheet. Therefore, here are the
> relevant timings:
>                   | min |  typ   | max |
> -----------------+-----+--------+-----+
> CLK frequency    |  -  | 25.175 |  -  |
> HS period        |  -  |   800  |  -  |
> HS pulse width   |  5  |    30  |  -  |
> HS-DEN time      | 112 |   144  | 175 |
> DEN pulse width  |  -  |   640  |  -  |
> VS pulse width   |  1  |     3  |  5  |
> VS-DEN time      |  -  |    35  |  -  |
> VS period        |  -  |   525  |  -  |
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9367a4572dcf..26702a847b63 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1973,6 +1973,33 @@ static const struct panel_desc eink_vb3300_kca = {
>   	.connector_type = DRM_MODE_CONNECTOR_DPI,
>   };
>   
> +static const struct display_timing evervision_vgg644804_timing = {
> +	.pixelclock = { 25175000, 25175000, 25175000 },
> +	.hactive = { 640, 640, 640 },
> +	.hfront_porch = { 16, 16, 16 },
> +	.hback_porch = { 82, 114, 170 },
> +	.hsync_len = { 5, 30, 30 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 10, 10, 10 },
> +	.vback_porch = { 30, 32, 34 },
> +	.vsync_len = { 1, 3, 5 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +		 DISPLAY_FLAGS_SYNC_POSEDGE,
> +};
> +
> +static const struct panel_desc evervision_vgg644804 = {
> +	.timings = &evervision_vgg644804_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 115,
> +		.height = 86,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
> +};
> +
>   static const struct display_timing evervision_vgg804821_timing = {
>   	.pixelclock = { 27600000, 33300000, 50000000 },
>   	.hactive = { 800, 800, 800 },
> @@ -4334,6 +4361,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "eink,vb3300-kca",
>   		.data = &eink_vb3300_kca,
> +	}, {
> +		.compatible = "evervision,vgg644804",
> +		.data = &evervision_vgg644804,
>   	}, {
>   		.compatible = "evervision,vgg804821",
>   		.data = &evervision_vgg804821,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
