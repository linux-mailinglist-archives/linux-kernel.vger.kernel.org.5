Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC237B4C15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjJBHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjJBHC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:02:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB3F9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:02:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3231d6504e1so12130894f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230143; x=1696834943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPMc6aMQK0lRLH9xe8mE8M5I4jqy0/8Cc31SAdtz1GY=;
        b=raVa1c7jFgJqdwYBw2fMremhV31IteNmJb/L6YhOklgqkQ02PJIqHf+HoskAgvO2vV
         G711NqMVOp6Wg39X4fcXejIWcaS18RBAOj0PqyQwskaehaN8LLp2HyVPk8jDMgTeQlKN
         zoHPoVN4KxiIWWRz/BHArxFyuNyOCeXoV5JmmTdmc/A35f409ei7RoDIWxZnvwHaS4aI
         fgxRIv7pfjNWN66rclJUHPNSnjOESRAaFSyH3ij9hMk75WBiTbQtu12YISSkDxRyZxos
         2/4qIHFVopvmmTFBZBFFFWBZtQmXnWS4rm6/lKcTygNLN6rg/0qFYIOMpgsCLy+vWYfJ
         kcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230143; x=1696834943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wPMc6aMQK0lRLH9xe8mE8M5I4jqy0/8Cc31SAdtz1GY=;
        b=wvqDOkc3BrSIxhYrGNv4Cr2t9v1WbHMdkcLWfrGR6zdaYEEfGWX5qunXL17Y1/BB27
         wdAEroXiA5KJVPiTo+z+RnmRbiaAR0/sUlU73KgjQmxcGMyJw9jNDxZM+/9rv4nLdGMQ
         MrFe256H17Whj+UYsghTSRMDAgxK+m78t5HnvRiLWX7PzNjvpWXj+mEi3AcnyFxb8lOv
         rm5Vxfw9qddUdX+mqTRLU616hCSVFx+fwaXxGVkU/HYAoaYjXvWXQ6w+5AIqHzQ4wysG
         PKHEELzfI1b3PVjJ3XEIN/r3mqr0TZDnGCqFVLO7DrbzODJ9b5M84FDn0cHMXFQ8OzU3
         7DKg==
X-Gm-Message-State: AOJu0YzGt5yVvx0j/KhvcgAZr5VOPwkKsrSB5KjYo5eFfCXriQKpOAxN
        WTqe8tp18cjRuOqGqxhbY6B2DA==
X-Google-Smtp-Source: AGHT+IFWAWAbqaH4c3PJxCdZs2YUSfB+WbWXjpIVquh9nHKgU/2pqOhxBYeK5rwuol7Oc7DylIj5lA==
X-Received: by 2002:adf:de89:0:b0:31a:d49a:38d with SMTP id w9-20020adfde89000000b0031ad49a038dmr9784288wrl.54.1696230142604;
        Mon, 02 Oct 2023 00:02:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5403000000b00325c7295450sm6832544wrv.3.2023.10.02.00.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:02:22 -0700 (PDT)
Message-ID: <abcbdabd-ec3b-4d14-8774-c290866ad86a@linaro.org>
Date:   Mon, 2 Oct 2023 09:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: icn6211: Convert to use maple tree register
 cache
Content-Language: en-US, fr
To:     Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231001-drm-chipone-maple-v1-1-fb3ce5a53710@kernel.org>
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
In-Reply-To: <20231001-drm-chipone-maple-v1-1-fb3ce5a53710@kernel.org>
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

On 01/10/2023 01:46, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/gpu/drm/bridge/chipone-icn6211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> index d205e755e524..82d23e4df09e 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -197,7 +197,7 @@ static const struct regmap_config chipone_regmap_config = {
>   	.val_bits = 8,
>   	.rd_table = &chipone_dsi_readable_table,
>   	.wr_table = &chipone_dsi_writeable_table,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.max_register = MIPI_ATE_STATUS(1),
>   };
>   
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-drm-chipone-maple-1d5e37ce5ed0
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
