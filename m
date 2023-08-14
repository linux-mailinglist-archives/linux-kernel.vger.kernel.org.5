Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155477B8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjHNMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjHNMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:38:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4AE5D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:38:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so30117945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692016732; x=1692621532;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bu4ri/TAHb9fiLZLiO4fZJEClWVz9W6Mt3bHz/FHGa4=;
        b=vbgYoAcW9DSA+ZZJcp9LE0KGpkiZXjuz63TcQH2hRZIAFqHrg6ii4D1RLtN1splMEj
         LMejNosab/HaUqPVnYD7ZvDGQ5a/84FeAI57n1NWSJZJ4ND6RoOFxU20DD0GYQhmqi9k
         zUk3g9qMfPD2EJhuS3M9ZLlh8lbwZlpUJFjlMFeYU8kZI3z3DahC/nqC/EFnsO688yCM
         UlE4+p0YnfV4exNl/miYprInofiXhHAzme5LrnMozFrdOPOBUsxI+NxuyTzFx8KVyadw
         9h/Z8DUcfwzmqq/2rHcU0xV71zc+gJY0rPxFkjER23+cUjmM8NW2f0l8fD9OtJW598ps
         v8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016732; x=1692621532;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bu4ri/TAHb9fiLZLiO4fZJEClWVz9W6Mt3bHz/FHGa4=;
        b=hs8f7ydfZZFBQaPTAiPq3d11e0dwu3lJVswCbkjEXnDFKjFilIhSaQGfn1busta+lr
         ekd4VSkMWr6faQI+PU1cZWrCLf5Akxa5NGHLH/DcSEGaHhK6XNU0WGDnmIMXb6KybQCq
         yZsNQYtd4HUD8xs5bpwb24GZeGtakDziKUt1hjD9jG9hzYIgodG3D9vChUaKIRO7hCM9
         fnKbE54rPFIcuZDMDx0JBpYygPnebcqztiszXTjcmB/JARaZlnhwUpTkdxLfQG/sGaBB
         tq4LfJ156Fkgfx2L4El5AOJqENRbGWZDm357br9TgeTtn2saQbxD/wTtVngCWtotWVxe
         i8MA==
X-Gm-Message-State: AOJu0YwRn3gDh/I7AQWURVDjIH5GFknbk6rMAJN2v1OMkhfKuLYedVWx
        /R8uXDTcyT9iHnHJDsFISmNTlQ==
X-Google-Smtp-Source: AGHT+IHbjvyjeMbQM1a8YXZiIwipoNXt26AwQZf3kk0r6paE0Mvn7H5ToUvouknFcdOoEyhR5dHRRg==
X-Received: by 2002:a5d:664c:0:b0:317:dd94:d38b with SMTP id f12-20020a5d664c000000b00317dd94d38bmr10687162wrw.10.1692016732531;
        Mon, 14 Aug 2023 05:38:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003fe24441e23sm14193823wmh.24.2023.08.14.05.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:38:52 -0700 (PDT)
Message-ID: <0df7954c-6520-43bb-9246-c4a5a40b202b@linaro.org>
Date:   Mon, 14 Aug 2023 14:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS clock
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20230804151010.834990-1-luca.ceresoli@bootlin.com>
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
In-Reply-To: <20230804151010.834990-1-luca.ceresoli@bootlin.com>
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

On 04/08/2023 17:10, Luca Ceresoli wrote:
> This panel has been implemented in commit 225213f24c79 ("drm/panel-simple:
> Add Innolux G156HCE-L01 panel entry") with a higher clock than the typical
> one mentioned on the documentation to avoid flickering on the unit
> tested. Testing on a different unit shows that the panel actually works
> with the intended 70.93 MHz clock and even lower frequencies so the
> flickering is likely caused either by a defective unit or by other
> different components such as the bridge.
> 
> Fixes: 225213f24c79 ("drm/panel-simple: Add Innolux G156HCE-L01 panel entry")

This is the wrong sha, it should be eae7488814b5

Neil

> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 56854f78441e..ec3a73bbfe30 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2379,7 +2379,7 @@ static const struct panel_desc innolux_g121x1_l03 = {
>   };
>   
>   static const struct display_timing innolux_g156hce_l01_timings = {
> -	.pixelclock = { 120000000, 144000000, 150000000 },
> +	.pixelclock = { 120000000, 141860000, 150000000 },
>   	.hactive = { 1920, 1920, 1920 },
>   	.hfront_porch = { 80, 90, 100 },
>   	.hback_porch = { 80, 90, 100 },

