Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF297B4C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjJBHCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjJBHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:02:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AAB9F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:02:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3231dff4343so1587226f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230131; x=1696834931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uh6V+yik9Ib/JARzquX4rgox6eLV1JUajkuwrIR+ASE=;
        b=Qox6yyXZ9wBRxSt4Ehu61biENhS8YzNYezef5MDJZ99XiW7e5Y41AfSzvngsvNCVOU
         fvXO+dgfdK01hnZyoWgIEe6Dz87xnRVXAK2sFCb6wrqfIc7sz3b2crLDRG8rQZXf/GOO
         S8EnHBR71RmO8RUHetSUFOp6W+M8xbANKrhUQjQ7Rx38Miaehvd6aK7ah1xK+VoYYl/M
         9qKyowZGOK60hHyboGmign803nILhamQtvL1XeNfNONmUw9KnYSEoKt6/LSVvN5Fgh3O
         zb1MkUEsEmjfcNgT36kjfN+GSk2weKuOSYf1/KYjc5+NJv+gWEqLsbMnrgvdJbVBtEkg
         U1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230131; x=1696834931;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uh6V+yik9Ib/JARzquX4rgox6eLV1JUajkuwrIR+ASE=;
        b=LAt189UzFAd8WxbxfSKQzNOtgyCCuioC2sD0ss0VnVjLUwPZrdugkGE5lcJD5V+icy
         Q6GBrLBIe5KmXqa+IDCIUQjVMSgu5Bb8msBk6Hda1Ba67CLdmIr7YYwJ7d/UZoFbMbeS
         AhC7+GRMXNq4MOgBTbf67EC05olXkYqs6esT7iha//bIU9nHXjH1H1UXSS/0zPQsuooX
         MQKjax14Pb2bp5br0FKpUlfWWqtVppyqltBsRapR1yDv9Y6DQDfb5QsOY2Iuem2loSm5
         0olipcOhqxZuGCf/nBZomhz6RrDeHkfe9ZlB+c0RMnqRe5c1r/hbE0uD0rgPuQVVZJjz
         Al3Q==
X-Gm-Message-State: AOJu0YxHv8lB7CjybmBjxDrxs66vD66+Kj3sb+F8dXKIqEJIqYwWGSjA
        FBJKNP4P5JqocZuxg2uHK9ZWaw==
X-Google-Smtp-Source: AGHT+IHFX1UiFe78PtuVf23Tu0d3OzPYiGs7ybCkVuk1lHeshLRibW5pmbWKb/Mop92Qk9LQx9oc2w==
X-Received: by 2002:a5d:56c7:0:b0:31f:ebfa:54eb with SMTP id m7-20020a5d56c7000000b0031febfa54ebmr8973311wrw.3.1696230131111;
        Mon, 02 Oct 2023 00:02:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b653:7e47:ffdd:9340? ([2a01:e0a:982:cbb0:b653:7e47:ffdd:9340])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5403000000b00325c7295450sm6832544wrv.3.2023.10.02.00.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:02:10 -0700 (PDT)
Message-ID: <2e43e392-fcae-4594-a60d-eb8f07154a3a@linaro.org>
Date:   Mon, 2 Oct 2023 09:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: dpc3433: Convert to use maple tree register
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
References: <20231001-drm-dlpc3433-maple-v1-1-7d71170c010b@kernel.org>
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
In-Reply-To: <20231001-drm-dlpc3433-maple-v1-1-7d71170c010b@kernel.org>
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

On 01/10/2023 01:42, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> index b65632ec7e7d..ca3348109bcd 100644
> --- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
> +++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> @@ -100,7 +100,7 @@ static struct regmap_config dlpc_regmap_config = {
>   	.max_register		= WR_DSI_PORT_EN,
>   	.writeable_noinc_reg	= dlpc_writeable_noinc_reg,
>   	.volatile_table		= &dlpc_volatile_table,
> -	.cache_type		= REGCACHE_RBTREE,
> +	.cache_type		= REGCACHE_MAPLE,
>   	.name			= "dlpc3433",
>   };
>   
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-drm-dlpc3433-maple-7e76ba8e59be
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
