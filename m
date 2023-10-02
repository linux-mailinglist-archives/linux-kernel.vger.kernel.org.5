Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C07B4C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjJBHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjJBHCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:02:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DBEE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:02:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3226cc3e324so15003717f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230149; x=1696834949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr+xVqPNpMrLhcwFvaq34JU49vQK5SE2KksVYojk9ro=;
        b=eS6LICeKngNPRS0JWzX5fK881HkgW77eK4A7y0iEQvIZpdR/DaoA1Chy7ixI2Hb/Yk
         ueA2AySs7QUk10+YsAp0FxZzmAU7qmU1snKQ3Jom0d3sf4s6vFpQYhJZCHXm+Z7B9wtA
         YjZUV1fKjuIQclHuj37C5KgI8LhMCwM7SZE6x5x+6QdI/Dh0GNZQCGqkpsj2jkst5eML
         LdF4yWovKk8nOG5x5wGnNHE9SRJC6NkGYxekpVcZqTY9iQ7ttgKSBY1M3EVHp2/DcV8F
         Z3nTs2exRG+hJme0Hi6d/F64SSwQyMyS18/iNw/W/PcznrRoH+8xwvXT3ZIzFZHlS8yb
         GJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230149; x=1696834949;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tr+xVqPNpMrLhcwFvaq34JU49vQK5SE2KksVYojk9ro=;
        b=QUsHNB9Fx+AOwJQqWkmgaUVf5M0F4caqtyKqK9bzUoR8wRH1ZHI89IOlXBq679lV+G
         9ENItKj77+1OVqEYZt7htlLazt3UA9erAYoJ7c2zXtXING9b+J4Djvi4nJBICNi7lj5L
         E9zMLW4U6aDCKYeZWKgUr4ZlJSbmXJrI2cRa2eFSCd4oFH5SMu6z4Ub4YY75DUfN/Aq4
         z4OA7RBbTVjySnwKE3vM63mxhDPdDHo8gPU0QF6XZusxkOdHB7/T1M4d3IJsLvJMQoIG
         mlCVTv3bHx99I5cTdfvsXi8HUV/2MFjstpvQfWx0zCgcGgsDJaEBhD8kdTbwpA3RTiMJ
         yZoA==
X-Gm-Message-State: AOJu0YxW3koY5964XHABhfQX8DUWVpphiH0WwvH4+/OGZOph9Qlnap2d
        JZjdRgOYeGz+bhV7tnEC3UcEBg==
X-Google-Smtp-Source: AGHT+IEp+mlKtqEqFmb41B9Z6vADDoCAU3pAs/lf8VMTSYO/ORbon65315cIj+DjD8xiU0z9VUNang==
X-Received: by 2002:adf:f343:0:b0:317:6fb5:bafc with SMTP id e3-20020adff343000000b003176fb5bafcmr8888151wrp.65.1696230148390;
        Mon, 02 Oct 2023 00:02:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5403000000b00325c7295450sm6832544wrv.3.2023.10.02.00.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:02:27 -0700 (PDT)
Message-ID: <033469a4-1f16-4be9-8e97-5646d66b9fae@linaro.org>
Date:   Mon, 2 Oct 2023 09:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: lt9211: Convert to use maple tree register
 cache
Content-Language: en-US, fr
To:     Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231001-drm-lt9211-maple-v1-1-1cf74fb10991@kernel.org>
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
In-Reply-To: <20231001-drm-lt9211-maple-v1-1-1cf74fb10991@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
>   drivers/gpu/drm/bridge/lontium-lt9211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
> index 4d404f5ef87e..c8881796fba4 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> @@ -89,7 +89,7 @@ static const struct regmap_config lt9211_regmap_config = {
>   	.volatile_table	= &lt9211_rw_table,
>   	.ranges = &lt9211_range,
>   	.num_ranges = 1,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.max_register = 0xda00,
>   };
>   
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-drm-lt9211-maple-f2b0807acd53
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
