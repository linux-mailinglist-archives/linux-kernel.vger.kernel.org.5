Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65C7B4C19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjJBHCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjJBHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:02:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C282197
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:02:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3231d67aff2so12629054f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230154; x=1696834954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGGdoZAFJGO71hTNqenLHWwvhFdcM85+NahI0R1EFgI=;
        b=UUo6lVWRGZTmLWafK2s/yOgoWtZCNgi6vwz7Db6OAfA0v6otiLTqseRnRdNbM9eyXR
         Ck9N1xMTgVkWQm4DuKF3UsOMsvV+ERYLiIVfPUkMfBD2GFuNT+zrGRMVxeaHVTvwN/2/
         Nn4qImgRVaruzX9A5B4bBrfise+9bqpzmeSGu/eQf2G0tlshkujPKb8vPkchNM9hC3m8
         fb0P14UX/TGW/17Ai4/tOV3h2mQ34A+JJMieVZ4wQ9w6vctjwYYUQKY6PrukvkE4Rtqj
         tDpKR5q29ChcDP9fIpA78xV9EKVZZ0gdr957z39KD5FaGdBwo5atyLOOUCovnVglzV+j
         OsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230154; x=1696834954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wGGdoZAFJGO71hTNqenLHWwvhFdcM85+NahI0R1EFgI=;
        b=LiWmE2ggl9jWP4jpJQiHi8ZaFM2raYuWKwrn5SckKSB0L086HPkZJ9GjXKjCvGq41S
         2POmt0QgwaWV3gKvF+ISgQv1XL15nB4MXBBBgBfbqBM0rA4KX5oQMANeqmPDlDzev2oR
         oMzKravn/Kul3/y6nc1Ps0GdPeTLbWF117zHC+7vE9/yO451AU8sHch1xBJK7AlDBEhI
         N0uUuTUTklEUsRRq5wDVRcUvovN7vZXP7qvkz1YqHhr1xPYPfaikkEEHPtp1N954HY3w
         5eZMOufml4XRD+f+eU/jWB3l/6JKOSWGOAaeOV+A0RxqkTpOzGAOG35Nqqk3OsEu4vvY
         CruA==
X-Gm-Message-State: AOJu0YwMGO0Zk3xgexfzMtVzat7fmNdpQoN8oQUv0cyFQSKFRrsIU8nc
        4e4zOArSPHofUJs53158JnWRig==
X-Google-Smtp-Source: AGHT+IENWhdAqzKI9eB8k5hUZAVTKzla22QLtktyWkbno3iZ1XDaGofNE3wkIjIk2iPVrAlTiHe5AQ==
X-Received: by 2002:adf:ead0:0:b0:31f:f9aa:a456 with SMTP id o16-20020adfead0000000b0031ff9aaa456mr9658087wrn.2.1696230153874;
        Mon, 02 Oct 2023 00:02:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5403000000b00325c7295450sm6832544wrv.3.2023.10.02.00.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:02:33 -0700 (PDT)
Message-ID: <d9d692d2-696d-4400-8021-2f534f785687@linaro.org>
Date:   Mon, 2 Oct 2023 09:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: sn65dsi83: Convert to use maple tree register
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
References: <20231001-drm-sn65dsi83-maple-v1-1-cf8ad22b6be0@kernel.org>
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
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-1-cf8ad22b6be0@kernel.org>
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

On 01/10/2023 12:26, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 061e8bd5915d..4814b7b6d1fd 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -233,7 +233,7 @@ static const struct regmap_config sn65dsi83_regmap_config = {
>   	.rd_table = &sn65dsi83_readable_table,
>   	.wr_table = &sn65dsi83_writeable_table,
>   	.volatile_table = &sn65dsi83_volatile_table,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.max_register = REG_IRQ_STAT,
>   };
>   
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-drm-sn65dsi83-maple-f15042b93dcd
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
