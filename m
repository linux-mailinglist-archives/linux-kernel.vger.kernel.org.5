Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F070810F02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378330AbjLMK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378100AbjLMKzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:55:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EEB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:56:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-336417c565eso215635f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702464959; x=1703069759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQkH5/5osgKVo3tNDoPrJaXgoaqcaGVVsq5o+Z+9iZw=;
        b=sZn3gecbCMsKWboKVVekZF6xbGdTI8ru4z7U+N2c/nokfdMA6W46A8gPpl6uwnsJBp
         8n1oB1uQbInQdsGF5lHNAuNO48VrM9rc+7GUoWRa/eouoQi5Emc/oh5EQlbga0sItvdi
         YAsLKwFj0YwdFPGXUNmKg2SRD9FU/vt3xONVt/fY3ewAXTWCmSxNfJZpPA2HAvwHNZiQ
         Pn1ixUFz0t7mbuHzJPN3E16E3h/Xu9P22pwBCC7/cc+B8lptbjZt8VTWbglQfo5h14TP
         MnFTHrqsTH3hbqAJE5GD2BZNpwiZjho2llWQLGB29gMswiwfc+ktv0X1J8gmOWRlACKI
         YI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464959; x=1703069759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQkH5/5osgKVo3tNDoPrJaXgoaqcaGVVsq5o+Z+9iZw=;
        b=SnPBkJdZEJdvCKRGTNkXWI7gGVvFxANu9ie4xGjtqBC5qrHtyjuU76MPhBd8obcQtR
         9oG0lanw3jI/FlUz/OKBTrT9z3V/myiNrx/xRhJNzSHRwVH+VKtMTHYIocrnCgzekcSR
         bOqLMPPilBd0HVcYOy6+ewcz9RXeN69r1f27YK2Yj1kL2GPjG8EscqbRBiSaJmjZRm54
         jWhIFdlogfJN2ptWnFuHcORnbmjHXH0CXqaepO5kwQPAhyl0qBrEFa4Y9E+fBOiBZwtX
         cIsBik6pdmL53c+t236fSED/YiO++guGus5xs2EPtB0JIGgRvIDrFmyGD0Kg/S+lQoEB
         eM7Q==
X-Gm-Message-State: AOJu0Yw8ffjYkT7RS3iem3pUnJ+TCGyMBvWuLSO6OYNhVXHSIyuaNAlv
        FaO+h/4k6O5SeJ8K/jDORobIaw==
X-Google-Smtp-Source: AGHT+IHkAyxQBKijO8UgWwVjAQojd8/sPdEZR15Hv9OQi+OcH7RK1LOTfPObQ4tKJemdlvtpbHipiw==
X-Received: by 2002:a5d:6311:0:b0:336:3919:54fe with SMTP id i17-20020a5d6311000000b00336391954femr294068wru.162.1702464958626;
        Wed, 13 Dec 2023 02:55:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65? ([2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b003332aa97101sm12999662wrv.38.2023.12.13.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:55:58 -0800 (PST)
Message-ID: <9ce9ab48-4277-4628-bff6-9a028c6046ce@linaro.org>
Date:   Wed, 13 Dec 2023 11:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [linux-next:master] drm/panel: ilitek-ili9805: adjust the
 includes
Content-Language: en-US, fr
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
References: <20231213100334.1799034-1-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20231213100334.1799034-1-dario.binacchi@amarulasolutions.com>
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

Hi,

On 13/12/2023 11:03, Dario Binacchi wrote:
> Adjust the includes to explicitly include the correct headers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> index 5054d1a2b2f5..1cbc25758bd2 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -7,10 +7,9 @@
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
> -#include <linux/fb.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>   
>   #include <linux/gpio/consumer.h>
>   #include <linux/regulator/consumer.h>

Please send to correct mailing lists with appropriate maintainers/reviewers.

Thanks,
Neil
