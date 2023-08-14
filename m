Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C795177B8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHNMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHNMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:37:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C87E52
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:37:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so42863525e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692016627; x=1692621427;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlIvr0fkgWj9OH257CwsuYbd1YZEKyLG860533ceSYA=;
        b=KWpnHkUGIjX/ReVnPDLgqaJ3BXFhG8B9m+jVtQzG5WOj+0jzaUW6VvUmafIBrS98J5
         hWlZVHb//Rgu3vR/vIR62pSEOXY4ndfKUVWlAYEuYdA7BrMElTuoKgmgOrHBwTBTv1Un
         0VV4DEFssVE/kDCHHz6wShmLCmKZK4679Equx7/vI4B6k6FCaSiO1NX+jhFGDmjyb5Lh
         Q2kAbUdeaQG217j6P2UaVND54x6A0KgnFin8vBv5s8w3xEhl5TdWvd5WlQXs7cGyS0/e
         i2CWa25bq60RNac59LxHBmxtAjBpaVINP2z0gdIHgh3N/xD2dGzSDfEmZYr4K/6W2eCT
         /Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016627; x=1692621427;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TlIvr0fkgWj9OH257CwsuYbd1YZEKyLG860533ceSYA=;
        b=kBbs6cg+SDnA3tQjA4W1vIAXB+Hbbh7z5U9ipLh9k0NwSr5gGcGK3f+9yxQ5W2l0xz
         DUM4eQzDtIbMW0W0jErpnQF+14X6ihhErAJtenxUevXpeYQzhYDptvmalr6WNFcim8To
         HmjIc431+p08VdnuWY5nrnh83PUiypMUoRfx5BOAr310M1feEZUk7pP8yjgKc0ExTmR6
         /v0I8F56g+rfYn2uMa0TQHbzJUQzoc2ZOOGZVSj+qxxv0NMzNIS1DJs5ic+ya8QFRkC3
         G2faohpzdntXsyUR2cderrPY3OdePNgxKuN6yn9rGaMiR6r+xL04P6X0FNLZC+W6pxeu
         0FXA==
X-Gm-Message-State: AOJu0YzlTnZH+zf8ZwCAVBXTpFE9xVZTCQZ6LP4UocYvZHK6344SlS/Z
        7/ItPnR5748MsW+UCGsFp2Xl7g==
X-Google-Smtp-Source: AGHT+IFKxsiuL2vos6RnrXgQD29lDjWBiZF8TyS1r+pay2gx1GycmMCpzqqjliBrXMt+vMRRkJcusg==
X-Received: by 2002:a7b:c7ca:0:b0:3fe:1b67:db7e with SMTP id z10-20020a7bc7ca000000b003fe1b67db7emr7925038wmk.18.1692016627285;
        Mon, 14 Aug 2023 05:37:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm17088850wmj.43.2023.08.14.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:37:06 -0700 (PDT)
Message-ID: <7047fbf4-fe47-4f4b-8129-8ad25eddf350@linaro.org>
Date:   Mon, 14 Aug 2023 14:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: simple: Fix AUO G121EAN01 panel timings
 according to the docs
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20230804151239.835216-1-luca.ceresoli@bootlin.com>
Content-Language: en-US
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
In-Reply-To: <20230804151239.835216-1-luca.ceresoli@bootlin.com>
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

On 04/08/2023 17:12, Luca Ceresoli wrote:
> Commit 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4
> panel") added support for this panel model, but the timings it implements
> are very different from what the datasheet describes. I checked both the
> G121EAN01.0 datasheet from [0] and the G121EAN01.4 one from [1] and they
> all have the same timings: for example the LVDS clock typical value is 74.4
> MHz, not 66.7 MHz as implemented.
> 
> Replace the timings with the ones from the documentation. These timings
> have been tested and the clock frequencies verified with an oscilloscope to
> ensure they are correct.
> 
> Also use struct display_timing instead of struct drm_display_mode in order
> to also specify the minimum and maximum values.
> 
> [0] https://embedded.avnet.com/product/g121ean01-0/
> [1] https://embedded.avnet.com/product/g121ean01-4/
> 
> Fixes: 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4 panel")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 701013b3ad13..56854f78441e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -999,21 +999,21 @@ static const struct panel_desc auo_g104sn02 = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> -static const struct drm_display_mode auo_g121ean01_mode = {
> -	.clock = 66700,
> -	.hdisplay = 1280,
> -	.hsync_start = 1280 + 58,
> -	.hsync_end = 1280 + 58 + 8,
> -	.htotal = 1280 + 58 + 8 + 70,
> -	.vdisplay = 800,
> -	.vsync_start = 800 + 6,
> -	.vsync_end = 800 + 6 + 4,
> -	.vtotal = 800 + 6 + 4 + 10,
> +static const struct display_timing auo_g121ean01_timing = {
> +	.pixelclock = { 60000000, 74400000, 90000000 },
> +	.hactive = { 1280, 1280, 1280 },
> +	.hfront_porch = { 20, 50, 100 },
> +	.hback_porch = { 20, 50, 100 },
> +	.hsync_len = { 30, 100, 200 },
> +	.vactive = { 800, 800, 800 },
> +	.vfront_porch = { 2, 10, 25 },
> +	.vback_porch = { 2, 10, 25 },
> +	.vsync_len = { 4, 18, 50 },
>   };
>   
>   static const struct panel_desc auo_g121ean01 = {
> -	.modes = &auo_g121ean01_mode,
> -	.num_modes = 1,
> +	.timings = &auo_g121ean01_timing,
> +	.num_timings = 1,
>   	.bpc = 8,
>   	.size = {
>   		.width = 261,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
