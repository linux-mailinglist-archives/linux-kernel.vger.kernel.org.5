Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5DB7B4BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjJBGwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJBGwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:52:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B93A4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:52:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4054496bde3so144016185e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696229547; x=1696834347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnEXoybYZCbjlzX7GnyyOxEnGYbND0k1bA0inBSyCi0=;
        b=V1fANMFxqjxanI37Fj4kaW37HgnIRrpFpf+esb1mRz3zx+oURmcuPF6hDh+Nbvo4ng
         wQ6y4j17P4E6IqNS55vyR7IXFUD/QTfRTOhncANhLbj5uuKtkQrG2/mpACORiplFYd6u
         zWjyg7hK+DWA19oKIxIskVA1nLHl91zEOFxZ3qYWYKbZxnwmwYNh2afDbf+03BwBmvh0
         BOzfR4Hl4GmwiMyFrJGPCfU7RHinQqyXnTIiLAhQQLlK+AJlRMALUXJIz8xUZ7mGVmQj
         HpaL8oKqfCI1IsU2DYU/Vpfzen8nrBZY1U9Ggo+fNUy0/Z+tJdDCHb577PTjwgCLMMOG
         zjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229547; x=1696834347;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LnEXoybYZCbjlzX7GnyyOxEnGYbND0k1bA0inBSyCi0=;
        b=wZnZjrYNm6RSfQBX6YBaRl4q02d0RfVDYBAKqA3CqKfQWo3JDzS/5Vokbf4Yb0QvT8
         uiwoJWbhcVqKIo+rM4++WI5LYFPBlO3v8VQtaLXWmSaPHps7B4rf81rjTGypy6kCkL5U
         lZnu245wdVs6VPSx6XxZku9F9nZM4qFMPkBTCK8FT/NMIgG2SViu12FKZsjJ62+jrM3k
         ntPw97zp7QXRcWNr7BCrkgX6bVAvP8dMSKa8K/BAsfLyEiBVuNtMAmsjWL42Coc6hwdB
         wSbgrjgNzEVNxz0gRr2m6vbR/UreB8zKH/yphT+1QwW2tORqTDwhhPRGj90zkEhFDLQS
         Mu8A==
X-Gm-Message-State: AOJu0YwTS4idpbi1eFChkv6xLRHHr1sKt5t5ksCz0X3IPK1a4OtnK6Ee
        SXpfydfM7wbtKkdy+Y8rANEvvprWBWeMIwCe8H4OOeBp
X-Google-Smtp-Source: AGHT+IF73l4FOJP/Vu1SOVBsHPf9hJjRDs8yblJoxiqcG15Ejt82VvMh9CJFFs8ZyPmLYNn0CKNbgA==
X-Received: by 2002:a05:600c:220d:b0:405:3455:567e with SMTP id z13-20020a05600c220d00b004053455567emr8761562wml.5.1696229546870;
        Sun, 01 Oct 2023 23:52:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b00401b242e2e6sm6504319wmq.47.2023.10.01.23.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 23:52:26 -0700 (PDT)
Message-ID: <cd95f9d9-b5de-4d6e-b2ee-1af6dee2c00a@linaro.org>
Date:   Mon, 2 Oct 2023 08:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/panel: ili9322: Remove redundant volatle_reg()
 operation
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
 <20231001-drm-sn65dsi83-maple-v1-1-5519799a55e5@kernel.org>
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
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-1-5519799a55e5@kernel.org>
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
> The ili9322 driver has a volatile_reg() operation in it's regmap which
> always returns false. This is redundant since it is the default in the
> regmap core, remove the operation for a trivial code size and performance
> improvement.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> index 61c872f0f7ca..15b81e5228b5 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
> @@ -325,11 +325,6 @@ static struct regmap_bus ili9322_regmap_bus = {
>   	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>   };
>   
> -static bool ili9322_volatile_reg(struct device *dev, unsigned int reg)
> -{
> -	return false;
> -}
> -
>   static bool ili9322_writeable_reg(struct device *dev, unsigned int reg)
>   {
>   	/* Just register 0 is read-only */
> @@ -343,7 +338,6 @@ static const struct regmap_config ili9322_regmap_config = {
>   	.val_bits = 8,
>   	.max_register = 0x44,
>   	.cache_type = REGCACHE_RBTREE,
> -	.volatile_reg = ili9322_volatile_reg,
>   	.writeable_reg = ili9322_writeable_reg,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
