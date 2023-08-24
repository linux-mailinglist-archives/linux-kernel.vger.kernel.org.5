Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B17869F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjHXIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjHXIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:24:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE201711
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:24:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so100997861fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865486; x=1693470286;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBWUe/welSTyLE0XN0FKQ2m/IGgsZK6nJo7F/yrgL6Y=;
        b=LSoHKy21NykeUkVhVQdpbUKajkdlZpVqlx/6hxXKj4EHeM4spA3kYQ3Jz4WKK5yvAP
         /SSCnwZ/8xpB0IgIQ5yz/VRfVdPDRBEnG2gI6ZdJVWhr6PRN6V9aBZIUP2ol5FMKNMMV
         TeUuJ9Ko+aGEJMWnVmkfed73CcADeoi+9f3BbGOfIts/ia/WOJNpYI4Ko9/OH48lUTYF
         5I2yaQ9ce+D4/EmDDMqDLcpPa6w8rblGqAaxCFKMyB9zLU9n9L96tUXIS6mAScAzHHnV
         VYaVHPsnNZOAi0lXPljkPMwugt3EIeHvQffSPWNofB00ySMNIyHHvg07rfpDJQ9OVHmv
         O7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865486; x=1693470286;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MBWUe/welSTyLE0XN0FKQ2m/IGgsZK6nJo7F/yrgL6Y=;
        b=S4WDPjuJ4sih1nf58HSxFG65Eo1YgogwAmRGnOSF5lFCfT8ChUFPJfG4dBoHU0ERK1
         +H/lO8h9WeZTYn3EYTkGUQQSS00A8YZxLO/GC6KVy6BewBcSv/IrLO7/mp1qE29YmyHA
         djssQ9/E9Squ/iY+OkX6+3YQfenXwbDP7kRiETwTwzktQ/6g8QqHoeV8UWxIWJfVAGWs
         ScozdtAb6kQS4ZDOQJneuyG2VaCa/L79AjrFqu/3cpW1gYYwDfva7cliAIJBe/4VYcSS
         oRykN4+E72utMwGgnGxd5tr4SDbWTS/wPWwFpPBQdDb77duoUh7dmKugn8PnkqCtzYjI
         Q2nQ==
X-Gm-Message-State: AOJu0YwrjEf1FayD9bzTvR9VnnknVyzze90LKPgXnLQeJLmiaOjh9Mr7
        TLdF7KCjo7jF5s7mQZZlv02hBg==
X-Google-Smtp-Source: AGHT+IHWcZB9lXJ+vBSQhndi+/YAyJ3D89wEBDbfn5fmHYq1DWowl+vWIotNA3tOjxfImtYPyoRRuQ==
X-Received: by 2002:a2e:8349:0:b0:2b9:5eae:814f with SMTP id l9-20020a2e8349000000b002b95eae814fmr9589719ljh.50.1692865486158;
        Thu, 24 Aug 2023 01:24:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b? ([2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003fe2bea77ccsm12946wmj.5.2023.08.24.01.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:24:42 -0700 (PDT)
Message-ID: <cdab27cb-fea4-4f09-8a66-ce1aa1090186@linaro.org>
Date:   Thu, 24 Aug 2023 10:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 1/6] soc: amlogic: modify some power domains property
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-2-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20230824055930.2576849-2-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> Some power domains for C3 can be using runtime PM,
> remove ALWAYS_ON property. And add some power domains
> description when ALWAYS_ON property.

The subject should now be:
genpd: amlogic: ....

same for patches 2 & 5.

> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: None
> ---
>   drivers/genpd/amlogic/meson-secure-pwrc.c | 25 ++++++++++++-----------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> index 89c881c56cd7..5ac2437ab8ad 100644
> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
> @@ -122,18 +122,19 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>   };
>   
>   static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
> -	SEC_PD(C3_NNA,	0),
> -	SEC_PD(C3_AUDIO,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_SDIOA,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_EMMC,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_SDCARD,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_ETH,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_GE2D,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_CVE,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_GDC_WRAP,	GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_ISP_TOP,		GENPD_FLAG_ALWAYS_ON),
> -	SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_NNA,		0),
> +	SEC_PD(C3_AUDIO,	0),
> +	SEC_PD(C3_SDIOA,	0),
> +	SEC_PD(C3_EMMC,		0),
> +	SEC_PD(C3_USB_COMB,	0),
> +	SEC_PD(C3_SDCARD,	0),
> +	/* ETH is for ethernet online wakeup, and should be always on */
> +	SEC_PD(C3_ETH,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_GE2D,		0),
> +	SEC_PD(C3_CVE,		0),
> +	SEC_PD(C3_GDC_WRAP,	0),
> +	SEC_PD(C3_ISP_TOP,	0),
> +	SEC_PD(C3_MIPI_ISP_WRAP, 0),
>   	SEC_PD(C3_VCODEC,	0),
>   };
>   
> 
> base-commit: 413f5c02929bb33042bbc4ee233166550a5fca70

With changed subject:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
