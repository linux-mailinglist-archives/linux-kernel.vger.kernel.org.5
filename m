Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10C7FDCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjK2QUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2QUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:20:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E6D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:20:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b54261534so5933665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701274853; x=1701879653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ2BW9Ne27jP4rV4wTRrZBadP+T5Osn/uqKd59KU9Sc=;
        b=QBO+J3LKNFtchlIs7AYGgYZ6fOpu2tyEJAiP8tYWUl5mJXgEfaTA8c+fRKXSl4yRVR
         PP5gH2wuUvx6gZSUcHzT0Ppyu6AJ0LbkLETv0l4DGMiF2rOYBJSsnqhUZ7rD5Ft8uhc0
         JOvGES4Wcmjj+ghFvcfDzGId6XTZCY4Xs4LE0mXqNZon8wOz7O2iujRtsn7Sn0ocnK2u
         qXJvge4mstD8L+2ywqNyvJ2VRqv3agzlfWfWTtxtxYzRuPmFYDE5gtz7GOQ7amqeUfW0
         rtrFxq38KnIThG/NZrHTr5kEqbkRBRh/gpYpUPF47Hxdj+eG+ApRNYvxDdBDpDIgpqcD
         VdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274853; x=1701879653;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQ2BW9Ne27jP4rV4wTRrZBadP+T5Osn/uqKd59KU9Sc=;
        b=NKSKHwb3hXrZFYL8/MkVKhVxzw1naZkBfScv8q5NZxdqh+B8XoT+uzaYSQcep22JBe
         7I6jkVY9QvTKLhKXdN1IzmIQv5WQKqRB3by5DDfDBIuGSRGfQFIMBRDXD+VZhbVSRnLc
         1Q7dwUjUEtOJ6RQslgNktO2PdRtoMJytAkFgXiuoj+/mz4Zni2xzQrkzzKlg1+2um80n
         73UTAHM2qj35Wy55KnKLVZIogHERwurIgeCGeOtyhF0H/btoIPn2O7TC4mSE/4i6gBEM
         7LwEexpKt3cVMWr4Ar5cEgvCPfAOpwBK67uw0xFYTWE+HcLNhQT0/ovJKK/eAEqG2O/B
         WjrA==
X-Gm-Message-State: AOJu0YyPrnSf0E42+Y8ddd+GjZiOl/Crdovhl8oEAk0MbmTgNZIk1Ey1
        TyqUmruY1TY1dOTj+7c0iu7ZcQ==
X-Google-Smtp-Source: AGHT+IGFWp1TdKCXBzP96cPKz+0h9MtjB6+Fi3czSnC4Bm7cqbOWb/xMeV9euB3WYMxArtUa9wZbIg==
X-Received: by 2002:a05:600c:450b:b0:402:ee71:29 with SMTP id t11-20020a05600c450b00b00402ee710029mr13260348wmo.10.1701274853233;
        Wed, 29 Nov 2023 08:20:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c? ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
        by smtp.gmail.com with ESMTPSA id d21-20020adf9b95000000b003316ad360c1sm18579106wrc.24.2023.11.29.08.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:20:52 -0800 (PST)
Message-ID: <8e78be99-3d4d-4f79-9791-404e60bcb67c@linaro.org>
Date:   Wed, 29 Nov 2023 17:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/4] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
 <20231129134004.3642121-3-jbrunet@baylibre.com>
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
In-Reply-To: <20231129134004.3642121-3-jbrunet@baylibre.com>
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

On 29/11/2023 14:39, Jerome Brunet wrote:
> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs,
> dealing with clocks differently. This does not enable new HW. It is meant
> to fix a bad DT ABI for the currently supported HW.
> 
> The original clock bindings describe which input the PWM channel
> multiplexer should pick among its possible parents, which are
> hard-coded in the driver. As such, it is a setting tied to the driver
> implementation and does not describe the HW.
> 
> The new bindings introduce here describe the clocks input of the PWM block
> as they exist.
> 
> The old compatible is deprecated but kept to maintain ABI compatibility.
> 
> The SoC specific compatibles introduced match the SoC families supported
> by the original bindings.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 52 ++++++++++++++++---
>   1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 387976ed36d5..eece390114a3 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -21,23 +21,35 @@ properties:
>             - amlogic,meson-g12a-ee-pwm
>             - amlogic,meson-g12a-ao-pwm-ab
>             - amlogic,meson-g12a-ao-pwm-cd
> -          - amlogic,meson-s4-pwm
> +        deprecated: true
>         - items:
>             - const: amlogic,meson-gx-pwm
>             - const: amlogic,meson-gxbb-pwm
> +        deprecated: true
>         - items:
>             - const: amlogic,meson-gx-ao-pwm
>             - const: amlogic,meson-gxbb-ao-pwm
> +        deprecated: true
>         - items:
>             - const: amlogic,meson8-pwm
>             - const: amlogic,meson8b-pwm
> +        deprecated: true

I think deprecated should be moved in a third patch

> +      - const: amlogic,meson8-pwm-v2
> +      - items:
> +          - enum:
> +              - amlogic,meson8b-pwm-v2
> +              - amlogic,meson-gxbb-pwm-v2
> +              - amlogic,meson-axg-pwm-v2
> +              - amlogic,meson-g12-pwm-v2
> +          - const: amlogic,meson8-pwm-v2
> +      - const: amlogic,meson-s4-pwm
>   
>     reg:
>       maxItems: 1
>   
>     clocks:
>       minItems: 1
> -    maxItems: 2
> +    maxItems: 4
>   
>     clock-names:
>       minItems: 1
> @@ -58,7 +70,6 @@ allOf:
>           compatible:
>             contains:
>               enum:
> -              - amlogic,meson8-pwm
>                 - amlogic,meson8b-pwm
>                 - amlogic,meson-gxbb-pwm
>                 - amlogic,meson-gxbb-ao-pwm
> @@ -67,14 +78,15 @@ allOf:
>                 - amlogic,meson-g12a-ee-pwm
>                 - amlogic,meson-g12a-ao-pwm-ab
>                 - amlogic,meson-g12a-ao-pwm-cd
> -              - amlogic,meson-gx-pwm
> -              - amlogic,meson-gx-ao-pwm

I don't understand why those entries are removed

>       then:
> -      # Historic bindings tied to the driver implementation
> +      # Obsolete historic bindings tied to the driver implementation
>         # The clocks provided here are meant to be matched with the input
>         # known (hard-coded) in the driver and used to select pwm clock
>         # source. Currently, the linux driver ignores this.
> +      # This is kept to maintain ABI backward compatibility.

Same here, this should go in a third patch

>         properties:
> +        clocks:
> +          maxItems: 2
>           clock-names:
>             oneOf:
>               - items:
> @@ -83,6 +95,27 @@ allOf:
>                   - const: clkin0
>                   - const: clkin1
>   
> +  # Newer binding where clock describe the actual clock inputs of the pwm
> +  # block. These are necessary but some inputs may be grounded.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8-pwm-v2
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          items:
> +            - description: input clock 0 of the pwm block
> +            - description: input clock 1 of the pwm block
> +            - description: input clock 2 of the pwm block
> +            - description: input clock 3 of the pwm block
> +        clock-names: false
> +      required:
> +        - clocks
> +
>     # Newer IP block take a single input per channel, instead of 4 inputs
>     # for both channels
>     - if:
> @@ -112,6 +145,13 @@ examples:
>         clock-names = "clkin0", "clkin1";
>         #pwm-cells = <3>;
>       };
> +  - |
> +    pwm@2000 {
> +      compatible = "amlogic,meson8-pwm-v2";
> +      reg = <0x1000 0x10>;
> +      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
> +      #pwm-cells = <3>;
> +    };
>     - |
>       pwm@1000 {
>         compatible = "amlogic,meson-s4-pwm";

Neil
