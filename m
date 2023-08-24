Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA244786A06
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjHXI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjHXI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:28:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472D1722
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:28:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so99973751fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865682; x=1693470482;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjdwqQ0uWrlbkJWuo+U46KrH7QKTD79xul20PtUY7QA=;
        b=WIqcdixLKmmLdnaQukswEXoSl09AoNij4ym3q4xq8v/0rg7k0HSPbaGDi+elDo4TyX
         qzADCpfDmZFGa4mSzmKT0xEY4857ffkU5qoFWwVlYTf6HHFnOMJSb06jEaJY9yX/zRdi
         JlRp/Sotqs86M7x5zBgkXPdMgpqiMcIiHdCLkbpqlvj1S/qDTj7N7zr/6PAJ3Okbgq3c
         /pK27etNgdjCu4tJbovzfYH9tq/qy3qEAHb0AMiyqbav4bqDlJMKzxRfq/QC+Xi4nh1F
         VPHz26bia1/ZRw/oz1XC1RapKAo84KrmrIgzOFbhm9SnvflaO3QBlr2xpHLPtlcHrDY1
         TXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865682; x=1693470482;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kjdwqQ0uWrlbkJWuo+U46KrH7QKTD79xul20PtUY7QA=;
        b=HjVZDgQ9qETpjRTq57ot/G2zRUvI1XxZfx/Quojsi53SG7PNSVIHNd4Mckx19413d0
         x4pSxpy/Kyz5tW7/BD3Io0Ql0Os7QtrgK5Gap9esxXN7AVsayhXRwEAt6ulst4tNTOJL
         tWRjNq6mzFkWM+wi6Re4KUx72vjwIyb5dA00HBgZG0SGaUkkXVFWKO8dRZpPOIqqhsl6
         /G6VXgMlNGca0C9ktEm8JJ0iuxlH96h+ChUerATShN8r+g6ANve0z8W0SU0FHZledgOV
         EHYFGsaDnr9GlhmV0s8sz8cD/QP4YfDAKikUFGWmstafiTnEwpGTYPXtSAhtSFaeWsQt
         IyjQ==
X-Gm-Message-State: AOJu0YwUdus66Y3zEpeLCAcbfoOgYbDIQRJ4AUI5m1SLADbgBzr4fT21
        ihRW+Ub7UwYjc9iLTLwY5vCIdw==
X-Google-Smtp-Source: AGHT+IGH78Fy+8c6JwG7qxeJucEClM0wxXMWmDebYumzqcZd35hvZR5BLwgj8VKI43fxqmP4PIdX+w==
X-Received: by 2002:a2e:8051:0:b0:2bc:e827:a4ff with SMTP id p17-20020a2e8051000000b002bce827a4ffmr896249ljg.9.1692865681962;
        Thu, 24 Aug 2023 01:28:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b? ([2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b])
        by smtp.gmail.com with ESMTPSA id x4-20020adff0c4000000b003180fdf5589sm21866081wro.6.2023.08.24.01.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:28:01 -0700 (PDT)
Message-ID: <741c1e35-648d-4c2f-a939-24bcbec93911@linaro.org>
Date:   Thu, 24 Aug 2023 10:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 2/6] soc: amlogic: add driver to support power parent
 node
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-3-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20230824055930.2576849-3-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/08/2023 07:59, Xianwei Zhao wrote:
> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
> 
> Some power domains depends on other domains, Such as Amlogic T7 SoC.
> Add parent node to support this case.
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: None
> ---
>   drivers/genpd/amlogic/meson-secure-pwrc.c | 26 ++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> index 5ac2437ab8ad..76527f4946b4 100644
> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
> @@ -19,10 +19,12 @@
>   
>   #define PWRC_ON		1
>   #define PWRC_OFF	0
> +#define PWRC_NO_PARENT  ((1UL << (sizeof(unsigned int) * 8)) - 1)

This is fishy, just use UINT_MAX

>   
>   struct meson_secure_pwrc_domain {
>   	struct generic_pm_domain base;
>   	unsigned int index;
> +	unsigned int parent;
>   	struct meson_secure_pwrc *pwrc;
>   };
>   
> @@ -34,6 +36,7 @@ struct meson_secure_pwrc {
>   
>   struct meson_secure_pwrc_domain_desc {
>   	unsigned int index;
> +	unsigned int parent;
>   	unsigned int flags;
>   	char *name;
>   	bool (*is_off)(struct meson_secure_pwrc_domain *pwrc_domain);
> @@ -90,8 +93,19 @@ static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
>   {						\
>   	.name = #__name,			\
>   	.index = PWRC_##__name##_ID,		\
> -	.is_off = pwrc_secure_is_off,	\
> +	.is_off = pwrc_secure_is_off,		\
>   	.flags = __flag,			\
> +	.parent = PWRC_NO_PARENT,		\
> +}
> +
> +#define TOP_PD(__name, __flag, __parent)	\
> +[PWRC_##__name##_ID] =				\
> +{						\
> +	.name = #__name,			\
> +	.index = PWRC_##__name##_ID,		\
> +	.is_off = pwrc_secure_is_off,		\
> +	.flags = __flag,			\
> +	.parent = __parent,			\
>   }
>   
>   static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
> @@ -202,6 +216,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>   
>   		dom->pwrc = pwrc;
>   		dom->index = match->domains[i].index;
> +		dom->parent = match->domains[i].parent;
>   		dom->base.name = match->domains[i].name;
>   		dom->base.flags = match->domains[i].flags;
>   		dom->base.power_on = meson_secure_pwrc_on;
> @@ -212,6 +227,15 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>   		pwrc->xlate.domains[i] = &dom->base;
>   	}
>   
> +	for (i = 0; i < match->count; i++) {
> +		struct meson_secure_pwrc_domain *dom = pwrc->domains;
> +
> +		if (!match->domains[i].name || match->domains[i].parent == PWRC_NO_PARENT)
> +			continue;
> +
> +		pm_genpd_add_subdomain(&dom[dom[i].parent].base, &dom[i].base);
> +	}
> +
>   	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
>   }
>   

