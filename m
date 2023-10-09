Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DF7BD30A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbjJIGIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:08:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF69E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:08:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so2378269f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696831718; x=1697436518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pwm5h53PM83gAppKIVLM07zDLHrFUDQ+u9fNo7HxCQE=;
        b=RNddYRngupDLQPvcqvwwwjyoKvAVMbH5IWPH3sffQ5BVm20gqi4NvvrDU7bOr05FxE
         BBFZeifu3+U0y4GsGOGsqyk0BqjY0Mz8dy37Dm8yRlYoIB1e2aH/UHrWPOjcXpJsGJR4
         x1zywiv8sAhdj5ZDZ3ZITc5iSsBQJhob2R08BDM3hSgULJKwW5rFwgBnJ5L3TDTEB07F
         b717iMC8xu3A6Ps/wC/I7FWxEcau2PQi9hkG6JHBxNh1ho2gi0YxlbqC+AblNvYl5xgq
         b/CdPfKqb6Ij/JWr24lFG+zMQ54uLGZH5lhpGrTrSJBOdlpNXIMhj4ja0lW0hB6hRu3N
         X5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696831718; x=1697436518;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pwm5h53PM83gAppKIVLM07zDLHrFUDQ+u9fNo7HxCQE=;
        b=GqB6KIKd8zIgUh0Z7WSxgTDUKUmUEsmavZ9HDp8RnIz+JPAEB2YxRNvdRu+a+QNgth
         jYbBLCrXqwi0eZXTO+XA4kc/CHA2XBGP9l4TP3LEs9tARfetYoei71CJ8GCe9ST8ZVLI
         70W1hgAtN4mLEIfZFx83sebM7txh7jG7pT7lrSJwmAubeBioRfaTdoa7tlyF7Ymc5OjJ
         bTjllgYgpO5W9HKC4LiSqp0Yc+XzAk/CPPnnZx8IkxsGmwbvgotixI/uoAU9ml6bT3by
         ANlS1YDlnEKAQbDX3D778OgwIBzWQH2CTE8Ull9+cycPulAKKaLIJtZbweMUBkwu5peu
         9HQQ==
X-Gm-Message-State: AOJu0YznwYFI6xTFGKcmhXwxccj3H2gUqPbtSYbTl6JkmnoptKpP66cM
        Sg6u/oiYujoTA3+PMAs8wHJNFA==
X-Google-Smtp-Source: AGHT+IGrA27+PJEBWnhyTfbkNFa+gb8MthcGvFo0qoJqXqIApd1OsFGfsb/JAvBqww1b7cMdVXFwuw==
X-Received: by 2002:a5d:500d:0:b0:317:dadc:4a63 with SMTP id e13-20020a5d500d000000b00317dadc4a63mr9154801wrt.8.1696831718205;
        Sun, 08 Oct 2023 23:08:38 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:33f:ec75:fd77:4d0b:f779:280a? ([2a0d:e487:33f:ec75:fd77:4d0b:f779:280a])
        by smtp.gmail.com with ESMTPSA id v7-20020adfedc7000000b003197efd1e7bsm8427040wro.114.2023.10.08.23.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 23:08:37 -0700 (PDT)
Message-ID: <7428554d-bcdf-4193-98dc-fb618d14844d@linaro.org>
Date:   Mon, 9 Oct 2023 08:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: meson: Use device_get_match_data()
Content-Language: en-US, fr
To:     Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231006224644.445295-1-robh@kernel.org>
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
In-Reply-To: <20231006224644.445295-1-robh@kernel.org>
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

On 07/10/2023 00:46, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/firmware/meson/meson_sm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 53bf56e18743..ed60f1103053 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -13,9 +13,10 @@
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/printk.h>
> +#include <linux/property.h>
>   #include <linux/types.h>
>   #include <linux/sizes.h>
>    #include <linux/slab.h>
> @@ -297,7 +298,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
>   	if (!fw)
>   		return -ENOMEM;
>   
> -	chip = of_match_device(meson_sm_ids, dev)->data;
> +	chip = device_get_match_data(dev);
>   	if (!chip)
>   		return -EINVAL;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
