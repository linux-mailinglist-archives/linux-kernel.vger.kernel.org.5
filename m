Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF86180C598
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjLKKGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjLKKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:06:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865BD5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:06:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so19338245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702289171; x=1702893971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dweN6hcC4xdtDuh2HCZYd5ulQCZ11ggf8uho7v/8KPs=;
        b=BPCTv0x5JMJFEEI5Yc8SWu20bmdR9UYR+oq6hJH4JuHzrDp1cUeLDu1dBmiei3G+Tp
         5t4cfTBGswSaLyg6+CNh/lMQ8bOJ1n1qQc9Ys0JLjvGSSekxucS9SlcI1H6Too3Z+zoP
         4S6U0d8x0b3+of3cdKhtrTRw27HKqaMkKpzkOSInUNawlVl1KPAJD/4qAFDtswr5W3xL
         WF3yMmT3xQIGg6Yl6WkxAI0kge8OjvFjg/bgjbtdimn+9AaBOAqp6f/idKqK+aEGeNcN
         Lmt3seak6VmuDeKm4n+toYQeIOF5+L+vNen5tknHNFpJYPSZl9VzB1q+KEHBbvENB2JH
         x3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289171; x=1702893971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dweN6hcC4xdtDuh2HCZYd5ulQCZ11ggf8uho7v/8KPs=;
        b=dXMuHcLWFkhH1oHEVN2ljJCKx+y51tlqvXsWIbi1PZxOhIgIDP5o2Y7WDYS6HFtoct
         VZSa0eMAcfSzdFMhxE80fBRr8gcy/f1NiGnoxX2hWNYmkoJGoq2cHzsB3eaZKaHHVqmf
         8B+S5iR4YwtU0nJewxQfaF6cyUGajQehB578jhys/CO9tIaqoWgy9hNOIsSC8MhbU3lo
         bX6dKqoqXIfvl3fLOeTQJ5gDD7jF3+5i9gKWhq9ygCM7uRCxCq+C6JAFzXytCMKRISvu
         OJodIKgJQJ7PkT3PWWvZO0BDzXUnlloP5bEhcBVhsXRxWFp575xz3rRNreLiLF0FzZUG
         iTDw==
X-Gm-Message-State: AOJu0YzVkuIYZNaU9Lr3yjoXOwQCRvzhoSwE0lPqbjv0FyjLH3zzDEKh
        op2WrOUQM/De0SU0MXn2psbVVw==
X-Google-Smtp-Source: AGHT+IH41AsduGCPUUvheD1DhHvD5Y2tiqJlr5B9J9DeZzXNU11RyjwG9G7beGY528cPspH8RLueeQ==
X-Received: by 2002:a05:600c:1e20:b0:40c:3daf:52f4 with SMTP id ay32-20020a05600c1e2000b0040c3daf52f4mr1356923wmb.185.1702289171642;
        Mon, 11 Dec 2023 02:06:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm14781799wms.0.2023.12.11.02.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:06:11 -0800 (PST)
Message-ID: <3b53b6c4-96e6-4129-912e-82b8ab9b2269@linaro.org>
Date:   Mon, 11 Dec 2023 11:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings: watchdog: starfive,jh7100-wdt: Add
 compatible for JH8100
Content-Language: en-US
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231209142723.2060196-1-jisheng.teoh@starfivetech.com>
 <20231209142723.2060196-3-jisheng.teoh@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231209142723.2060196-3-jisheng.teoh@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2023 15:27, Ji Sheng Teoh wrote:
> Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> watchdog.
> Since JH8100 watchdog only has 1 reset signal, update binding
> document to support one reset for "starfive,jh8100-wdt" compatible.
> 
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> ---
>  .../watchdog/starfive,jh7100-wdt.yaml         | 29 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> index 68f3f6fd08a6..eec182317219 100644
> --- a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> @@ -19,14 +19,12 @@ description:
>    isn't cleared, the watchdog will reset the system unless the watchdog
>    reset is disabled.
>  
> -allOf:
> -  - $ref: watchdog.yaml#
> -
>  properties:
>    compatible:
>      enum:
>        - starfive,jh7100-wdt
>        - starfive,jh7110-wdt
> +      - starfive,jh8100-wdt
>  
>    reg:
>      maxItems: 1
> @@ -44,11 +42,6 @@ properties:
>        - const: apb
>        - const: core
>  
> -  resets:

No, keep it here with min/maxItems.

> -    items:
> -      - description: APB reset
> -      - description: Core reset
> -
>  required:
>    - compatible
>    - reg
> @@ -56,6 +49,26 @@ required:
>    - clock-names
>    - resets
>  
> +allOf:
> +  - $ref: watchdog.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - starfive,jh8100-wdt
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: Watchdog reset

Why is it called "Watchdog"? How is it different from "Core"?

Best regards,
Krzysztof

