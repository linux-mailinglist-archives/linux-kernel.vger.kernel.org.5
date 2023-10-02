Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4D7B4BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjJBGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjJBGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:52:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3608A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:52:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5044dd5b561so19442788e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696229573; x=1696834373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uO3AI9wMnhnO+0jnqSb19capTQsV4I9EWcmdqxl6YE=;
        b=Z3M8bdEdt37S6vsyExMIW+urrY6eZhSx4rLHUsDWQZHWVRjqoB4RqHaFjeLaONhCGt
         61yVOU6dhFdkZ6oaP495YFyeFbbQXFSZriEP2W/xhmz3CSHyJwyx4ah8ItXw69H4+nzT
         Zwlt3I6deA+5Ke3nwOa/cm77CoBtjIiIAJLzm7iVEsUQfDYyvhoVEAcK1PSX6LGqKEUT
         vY9CuXZAXpgzFrIxqkd6Y+AJH5QkKXX0obeDphbfgAL3X913S+HzqXvTVYgA2wztxao5
         q5HWa839GGcgJNpzukQXI6QCTJwnPCw4ucUIJj0PLKfm5EiBGg5POu1nrs1jL8K/HAr8
         IyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229573; x=1696834373;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8uO3AI9wMnhnO+0jnqSb19capTQsV4I9EWcmdqxl6YE=;
        b=E+vfagyMXMp3fxEMV86JYGWXUCYI9exOC69cZfqfnct1Od+xd5uS7gfxQfSpGCuLHC
         wQDucOpLY+vGE6mdy75ku36FyHd5M8HO+MMBPwopif5RAc1DABYe1PJxLiLAgpVEd+Ss
         OZ1j3b68xV88vHlNNs8NFLxNhAUW4aUe/PZrP5m1fk+Nb3GCVEeoNmIH9CzVwhBAOYMh
         m23PNlmavyZvyneG6XrlLWXzvql8wA0toF7IkNof32y9y+z+IHH4ojUk2W0GqE6T67wq
         GlCzGgrFOe5/xONiueginF+gz4V/rQgFqwyrhJw895aDSInfk9jI8nHTbq0/bSfa+jmQ
         OTzQ==
X-Gm-Message-State: AOJu0YwXDxyTp2+B27QU8vdwTHHY2L3mW0OV6/UnJ5vPpMNxcMo778Wy
        FSEYRobl79kYyiIrXBAuQog1Lg==
X-Google-Smtp-Source: AGHT+IHoDIWAZMiHMGEWKH6ulDnBVeiV39StIiLnV26tzgF51mGrT6t/5aZt1pbKnpxyESAt5xuJ1g==
X-Received: by 2002:a05:6512:238c:b0:503:3682:2624 with SMTP id c12-20020a056512238c00b0050336822624mr9647586lfv.48.1696229573099;
        Sun, 01 Oct 2023 23:52:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b00401b242e2e6sm6504319wmq.47.2023.10.01.23.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 23:52:52 -0700 (PDT)
Message-ID: <28ac4edd-f600-456a-b6ea-ebf7d527015e@linaro.org>
Date:   Mon, 2 Oct 2023 08:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: ili9322: Convert to use maple tree
 register cache
Content-Language: en-US, fr
To:     Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
 <20231001-drm-sn65dsi83-maple-v1-2-5519799a55e5@kernel.org>
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
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-2-5519799a55e5@kernel.org>
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

On 01/10/2023 12:24, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> index 15b81e5228b5..4a6dcfd781e8 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> @@ -337,7 +337,7 @@ static const struct regmap_config ili9322_regmap_config = {
>   	.reg_bits = 8,
>   	.val_bits = 8,
>   	.max_register = 0x44,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.writeable_reg = ili9322_writeable_reg,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
