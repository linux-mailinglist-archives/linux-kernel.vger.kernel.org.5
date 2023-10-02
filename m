Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9528F7B4C11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjJBHCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjJBHCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:02:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714CBC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:02:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so16077512f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230138; x=1696834938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYAYLeRsicXOvNtqDn4yoYXYQH3c4bNCWoCyNw3DKTA=;
        b=w74zFuXR8DgPDvXfzPV0nTDczDj/LpLv21f7Vv2tvK2xz0dC0RPBM2omHh2v04P5q4
         GDNqde0XWnS6MxsgnDf07vZL52XqY/PEh5F4hTKSemsDnS7ZOThZgeCH7wS4AMv08ir4
         uZCiTVDX/xhhfa2noQLsjPI3GRm8QcxlM9JGoWw2lf0O9OjDaFa7TJuI00j6rUZU3CEx
         rLc3mdlHGViDNTntROMUFsWRo2EoYq5lYTZkB+CTeinh7AFHG1svMEGrL9bgSEt0qJqW
         UqowTeNJ8ctbHiSBhwfzAWlCEB4zPuPYwR0eJh0FhFUGiWUrAy4ZhHtixJ/HqvcmAq8W
         R2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230138; x=1696834938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SYAYLeRsicXOvNtqDn4yoYXYQH3c4bNCWoCyNw3DKTA=;
        b=rQV8bPH/0aZdvnANPIoWYO5dmBIe/NLB7ZB31VdImBG/7GLHwLU86d1WHt+NubvpTo
         8LgrIP31IUQTMGODrNNfmA8iEI0VO8WJlWV8wglFPf9sPxh2TvJfOuwWidd8LdF9aQ25
         H1/USMXMo7nobgOE7lvtMRJKja8P7LFnYLzEUuG8Rg+KQBSdBEfAgO+piR0pm91QOn0l
         csp4qoifEGQvK0Ob5hMmRnZLTzi9Jz5AbBsss31wPtbQ1lFhbooHUaaMCYu9O67PiKa8
         EZjGmqXYf4xJEc4QFvCNfa6VaRNpvmWD5Ct2Of7NQPzFxUapgeidJUKCnNa1hsiU5E83
         t0rQ==
X-Gm-Message-State: AOJu0YxmFICy+PRDM9mZSttVkAofynnjs+5eMylCB2ItpTWGJJjn0qcQ
        LQSEhcjWmxQ6XxPfrFWNcI94Ow==
X-Google-Smtp-Source: AGHT+IE7/EHTOdS3sRPZBazh4feS/C+P3Qyg1GuvhflNTD/ZQ6BRNqKT/WCErQ8CYxERKC9HEtsFJw==
X-Received: by 2002:a5d:4cc3:0:b0:317:ef76:b773 with SMTP id c3-20020a5d4cc3000000b00317ef76b773mr8829556wrt.45.1696230137015;
        Mon, 02 Oct 2023 00:02:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5403000000b00325c7295450sm6832544wrv.3.2023.10.02.00.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:02:16 -0700 (PDT)
Message-ID: <0431777c-a0bc-4d50-9657-ae4e9e4aec18@linaro.org>
Date:   Mon, 2 Oct 2023 09:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: tc358767: Convert to use maple tree register
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
References: <20231001-drm-tc358767-maple-v1-1-f759fcc4bd98@kernel.org>
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
In-Reply-To: <20231001-drm-tc358767-maple-v1-1-f759fcc4bd98@kernel.org>
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

On 01/10/2023 01:43, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/gpu/drm/bridge/tc358767.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index b45bffab7c81..ef2e373606ba 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2005,7 +2005,7 @@ static const struct regmap_config tc_regmap_config = {
>   	.val_bits = 32,
>   	.reg_stride = 4,
>   	.max_register = PLL_DBG,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.readable_reg = tc_readable_reg,
>   	.volatile_table = &tc_volatile_table,
>   	.writeable_reg = tc_writeable_reg,
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-drm-tc358767-maple-db143f667958
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
