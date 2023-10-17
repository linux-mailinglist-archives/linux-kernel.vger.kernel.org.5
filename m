Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A677CBC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjJQHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjJQHMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:12:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65893
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:12:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4066241289bso53979385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697526735; x=1698131535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgSQoLdF5vHLUnEeliiJIRAgjnOj/aWprHJjgNjEMgM=;
        b=cOrsYIR6RdJQRJ88NHyQPyqepuaXnbBNpz6Hp7PwdK+sRFnM1+aAvHNziEPGqKyw2k
         KRMSb+XVBS2i+Pq5ubqe6i+joSa3M0kOKkgi+kWnNXZOEmc95JcT9uZMK279QrQrrzlV
         rDaq/YhoYfG2REki2SSL3t+PNRL/mttik3vRZSYwYsbY0LWXqD7+mF2FeYsfwsC96G+9
         VZJk2wAbdgCXytKJwrOz8TN0qZC6iXCMJqWouuGhe0kZ9T1MuahKQ6ZXsrHfkF908gfz
         rjN4jHbS2plAoygPesa74yGBgGNuqSzYJzsuDw3tT0cVFn0f2HqkIopM4z02urVs3G+T
         vO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697526735; x=1698131535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BgSQoLdF5vHLUnEeliiJIRAgjnOj/aWprHJjgNjEMgM=;
        b=tCeHly/g9HlG5yMXDYQ/U4vJmUpRho0IkmJYFuV4S5LCS8vkVwiWD0JrUc2l4j65lR
         5+q/F7cUuhLmCAAaiZ5/GaVAMiBufkQ3hGk6vrzvy0Qj6IcL/w0CAkyk9HfQPr9TXegb
         rvkKWGSOk9j7Z5B0Rkb+4Kff8iYef6ZPFZTKCLzcF4qjBT3ef5GF9wKsuxuzle3p37kU
         Cm6KP1hulr315jzqxjE5X4yxMXBesDNKOD9L+KK8vDEDgCKIL22yMjEn7oMYYMv2tcO+
         l408p39c8f2OVxfI0G/O2dDUnMBRNWz3KqeZ0O3egc7wTx6obLsRvrLR7rQYBQZIedqz
         9Ddw==
X-Gm-Message-State: AOJu0Yw9Glh7ArLcvkUMEpK1SBE0U73hhedctSt5AmVot+VCHTCr9Hnv
        WBy65HQ8nyV5cgI9TstmOktACA==
X-Google-Smtp-Source: AGHT+IGu0Yed9EDUQrOpnA8mAZUfLeXThufJ1bWnI1CVAHVcm4oaAVaTAznPnQG9bg/DA8n/FYnLBw==
X-Received: by 2002:a05:600c:470a:b0:401:b53e:6c40 with SMTP id v10-20020a05600c470a00b00401b53e6c40mr960171wmo.10.1697526735408;
        Tue, 17 Oct 2023 00:12:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:97ef:6513:8029:4596? ([2a01:e0a:982:cbb0:97ef:6513:8029:4596])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b00406408dc788sm9180427wmq.44.2023.10.17.00.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 00:12:14 -0700 (PDT)
Message-ID: <0bfe799f-6eef-455a-b9c6-96660bf5df9e@linaro.org>
Date:   Tue, 17 Oct 2023 09:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] crypto: qcom-rng - Add missing dependency on hw_random
Content-Language: en-US, fr
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231016-qcom_rng-v1-1-1a7d7856651e@apitzsch.eu>
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20231016-qcom_rng-v1-1-1a7d7856651e@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 19:45, André Apitzsch wrote:
> This should fix the undefined reference:
> 
>> /usr/bin/aarch64-alpine-linux-musl-ld: Unexpected GOT/PLT entries detected!
>> /usr/bin/aarch64-alpine-linux-musl-ld: Unexpected run-time procedure linkages detected!
>> /usr/bin/aarch64-alpine-linux-musl-ld: drivers/crypto/qcom-rng.o: in function `qcom_rng_probe':
>> qcom-rng.c:(.text+0x130): undefined reference to `devm_hwrng_register'
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>   drivers/crypto/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index c761952f0dc6..79c3bb9c99c3 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -601,6 +601,7 @@ config CRYPTO_DEV_QCE_SW_MAX_LEN
>   config CRYPTO_DEV_QCOM_RNG
>   	tristate "Qualcomm Random Number Generator Driver"
>   	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on HW_RANDOM
>   	select CRYPTO_RNG
>   	help
>   	  This driver provides support for the Random Number
> 
> ---
> base-commit: 4d0515b235dec789578d135a5db586b25c5870cb
> change-id: 20231016-qcom_rng-e46c8a8628bb
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
