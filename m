Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19C3810F03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377954AbjLMK4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378297AbjLMK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:56:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AFA95
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:56:08 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-334af3b3ddfso6134463f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702464966; x=1703069766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcCM96pOVKvI1C4cdyAruUt660p21wE/szjc8Zc3cSU=;
        b=no+tOCAVjPFnIIXoAQckA+Xvgyt4ArXrecxrbHGMUHHcyxw0oNn6rUaxIbnCK+C2Pb
         VCL0TIFu13MxsSb5PZouxP61nua6nFR1PrVQVZCeadMnKxoJws2hn+uRWQdLk/JaW6K1
         u5id+WlMqwEIP5uwI7T48NQhwS8ntEo54g4InNCLK8cdY9iVJDFq6XF37k6Q03ETnMXo
         8K1t4tQhRK5/FQzeLQDCkIj/mTf2clYm0O/1RJU3s1n7AQBhqKnMbQMXyd6X7T620sNH
         UqBzTPaTDVrI9Ib6wEqIJuU0qeozz+BNMjso5wo8sIqjtOtvN6XCCTjvvZYaAVdo4IWi
         jT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464966; x=1703069766;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WcCM96pOVKvI1C4cdyAruUt660p21wE/szjc8Zc3cSU=;
        b=eVdb3GIx/NA2GxNSDeHzoPLG+aW3ofHZdBS19WWlxjOkjc/2roxsrlsDiTSof4tYOr
         oyN68eEXGGMYa8o0f3l91ORu5hSBBR5xT6iIp+Z78tfE9djfEjwwGEPqfwXJhtALP1OA
         H5MzqbC/+ro1Bi7PkqFkfRx2lcTQDszIUgnUTr/WuYP/+sOA+sPOieXCyDa6qjtfpmAS
         JSun/AI2Oau+CPH6yjV+mlekHvl1HB32FnXiNphmguk6qnGZhHlEOPb+neXQaMxYaM+0
         mL4nEbv2H7crTk2QgB7DpkFJCC3zjSPy/ww5vFmT2gndyIotuE2BxM+cLoZnrqCM7o5v
         s1cg==
X-Gm-Message-State: AOJu0Yx7zCJhIODZuR2xZ2hoDMmMgUuavrO9Ygln8G9VduBot6/sIgAg
        OfnKSWcjMi2i0AW5HZAPFZeIYg==
X-Google-Smtp-Source: AGHT+IFNJztd/28BY3I0PiGfqbA1cnzsbS51BqmDVUBEGODs+M26g9FObjOq3+3kQRMghtAKJAZB5w==
X-Received: by 2002:a05:6000:90e:b0:336:b8d:6531 with SMTP id cw14-20020a056000090e00b003360b8d6531mr3901321wrb.100.1702464966678;
        Wed, 13 Dec 2023 02:56:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65? ([2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b003332aa97101sm12999662wrv.38.2023.12.13.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:56:06 -0800 (PST)
Message-ID: <bbbda345-5840-42e3-bac5-47aad6433163@linaro.org>
Date:   Wed, 13 Dec 2023 11:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [linux-next:master] drm/panel: synaptics-r63353: adjust the
 includes
Content-Language: en-US, fr
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
References: <20231213100357.1799057-1-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20231213100357.1799057-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 11:03, Dario Binacchi wrote:
> Adjust the includes to explicitly include the correct headers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>   drivers/gpu/drm/panel/panel-synaptics-r63353.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> index 3f61fcdc550b..169c629746c7 100644
> --- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> +++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> @@ -9,10 +9,9 @@
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
> -#include <linux/fb.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>   #include <linux/media-bus-format.h>
>   
>   #include <linux/gpio/consumer.h>

Please send to correct mailing lists with appropriate maintainers/reviewers.

Thanks,
Neil
