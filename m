Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352E786A12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjHXIai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbjHXIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:30:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D42171F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:30:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so46595881fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865811; x=1693470611;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xg+6LU2qLbyDNeIWBYMZUpdqHpT0GomQwi8jpOi5ytg=;
        b=fe3VF2AVkhDbqpW0ZGtyKbG0XrZ+YhEZnFsVuKuENQyhcAatjzyBUL1D4NhCTh0I9c
         uFLwdUH3kj2LdhnJM0CMy7JEM3JmTMuIxuUIoTDe0BRtLz9AkoD034k+imMTBU5jRdlB
         Qm5w8vQZdhgtPkrQXm5kJ+1wbDKTiFaqFhZbuYnqgF+mcKxk3VYggVeuW2ItRRIvcwZH
         vtENLjzTjunqHph6zziQfw/s6MerFOeAr2kaUS+5Nz40L9d6yEE+f/rrc7fPclk9BBDs
         gCVtpmzsIKq0E52HpRzOd2uWnZ1MV7YqPwd7exn1UQwt/zI1df6IzRzfByqZl5jLw9XK
         85wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865811; x=1693470611;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xg+6LU2qLbyDNeIWBYMZUpdqHpT0GomQwi8jpOi5ytg=;
        b=i6ZuwhFpVb8TEHakHi5hhDksDoi3Ilw/o2gToeI1M4qEDk6gX/NLXTn4s9SAsN8mrP
         j2itZ7wyYnU8WPRx2M9dnsDoZFGe4qWMrFYT8lrzV2tZliVKUw8D3ofpVY62rrofLUKO
         BTkfk9eFQeSyFDKNxDDLnUJg/DjdieDmfVapnesXv/ViBo57IYovf2W2YzDQa4mbd+39
         Cadf1d/dpwrni2dvmlNuzLFs5rgV7PYTgGjxpSbVkZ+Hifwimgxbs2joW6lOmP0E/cKX
         YKl8rjjQNixM4QkfqeRuzwqcAAOw3a8efoErFGL0U/8vyhRVBE0+JNQGOJV8rx1w9v/V
         ml0A==
X-Gm-Message-State: AOJu0Yx6mWpP1zhrqLDQjGZhayIkwUDPMHK4KWd9OcgYJ02x/EHi3Ucz
        onRbXn7dqS+QjfCGLCtOJ8zhbZNwK44Q4oBoDqCG6IAK
X-Google-Smtp-Source: AGHT+IFDCWnxfbeRf73G5R+6eO8t/eBJyXZxQHkqwUUV8xzI53EYnlXBAV2kZKRkg/QOEUjdWfS4fQ==
X-Received: by 2002:a2e:9096:0:b0:2bc:d5f1:b9cf with SMTP id l22-20020a2e9096000000b002bcd5f1b9cfmr4753306ljg.27.1692865811211;
        Thu, 24 Aug 2023 01:30:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b? ([2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c22d600b003fbd9e390e1sm1907393wmg.47.2023.08.24.01.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:30:10 -0700 (PDT)
Message-ID: <91e4a3f1-84ed-4433-90fc-bdfb9b08e57a@linaro.org>
Date:   Thu, 24 Aug 2023 10:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 3/6] soc: amlogic: init power domain state
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-4-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20230824055930.2576849-4-xianwei.zhao@amlogic.com>
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

Hi,

On 24/08/2023 07:59, Xianwei Zhao wrote:
> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
> 
> If initial power domain with 'AWAY_ON' property state is off,
> turn on the power.
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: None
> ---
>   drivers/genpd/amlogic/meson-secure-pwrc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> index 76527f4946b4..3e7e3bd25d1f 100644
> --- a/drivers/genpd/amlogic/meson-secure-pwrc.c
> +++ b/drivers/genpd/amlogic/meson-secure-pwrc.c
> @@ -55,7 +55,7 @@ static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
>   			  pwrc_domain->index, 0, 0, 0, 0) < 0)
>   		pr_err("failed to get power domain status\n");
>   
> -	return is_off;
> +	return !!is_off;

Can you explain this ? the function returns bool, so if if_off is > 0, it would return true,
so I don't see why you would need to transform is_off into 1 or 0 using !!.

>   }
>   
>   static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
> @@ -222,6 +222,9 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>   		dom->base.power_on = meson_secure_pwrc_on;
>   		dom->base.power_off = meson_secure_pwrc_off;
>   
> +		if (match->domains[i].is_off(dom) && (dom->base.flags & GENPD_FLAG_ALWAYS_ON))
> +			meson_secure_pwrc_on(&dom->base);
> +
>   		pm_genpd_init(&dom->base, NULL, match->domains[i].is_off(dom));
>   
>   		pwrc->xlate.domains[i] = &dom->base;

