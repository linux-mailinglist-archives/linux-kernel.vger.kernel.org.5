Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990FE7A1CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjIOKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:45:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA14C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:45:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3c8adb27so258325866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774711; x=1695379511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SID5oDKY4NJAlRPFZ69oTx9l6P/13bI038tsRW9LUo=;
        b=OfEHIPm8BNCrS9Lm+oU7dVRjeQ+r+TRR5tSsDJJXgASjpbEvq7jAMXHNl8OkRsC4lz
         104B8wOr5IUtH9jy+sjSnZTKUuBQKHdiDH67UrW//WAml8UqB1MCXcIrrD7pE6WBMEYS
         JrXR/UAW54IB8LyCu8zzy4dv23NcIW9nVUAHlbyjFjkBe4JX9V2VUwAVvH3oFy4K6EKE
         5gZrKRRq9TF3QFJotYkRP6l4bE/70tG8FgEsF9k8N0SGICE+3de7fZQ876LdizB89FmX
         2IEPs16+UgTeRovvmkd759XFNTJdfgh0T0EsMvez8zv6t1ySgmJSMHb3bMfjO3z8drgR
         NKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774711; x=1695379511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SID5oDKY4NJAlRPFZ69oTx9l6P/13bI038tsRW9LUo=;
        b=MSwJG/Ogf3nryPkzqUFcV0X43XLwpxI4o5zHflwTV9oZkVci9/f2/or3soWv/16pY0
         NKzrAMhV+p7SXYkQwSFLKo0plTWPqWnJ7pf+f5SbZ1fyjlWXIvRC8TTkjRQYtniGXwyV
         cnUA9ef9SfM4+Zn+rnKcQh335zPxFCXt1mvxJkZ7Sm7Zx/16pSHQhBuMFv1ijqMe4CeC
         pD/+RrgzRSQ2mt7xOr+Vo7WGW10XVgVSk9H3mRwzephifY3VS6X7wzai7/pYiUEHhAO+
         LXmjcf1Qs/a9tLZLrwd96m+Izf0SXSiLvkOGW4tiSd1LUjpJ7HAlfSZ1AFDqhrbpirdr
         owCw==
X-Gm-Message-State: AOJu0Yy2y5NTai4rVNbXfts0iRUDZrrauywpFBADy7Ip45Fobbr7GOi2
        Hw2n+A9mZRMFGmhTB58sfAdJzA==
X-Google-Smtp-Source: AGHT+IH11YBMU4QUnpcqSRlEVLJOYHut97zbieeCJa0wwpsQlPg5PGGsIsgtpUlwTjxuMdQKDv9Dag==
X-Received: by 2002:a17:906:844a:b0:9a2:225a:8d01 with SMTP id e10-20020a170906844a00b009a2225a8d01mr1167891ejy.7.1694774711278;
        Fri, 15 Sep 2023 03:45:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id vl3-20020a170907b60300b009adc77fe164sm1139726ejc.66.2023.09.15.03.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:45:10 -0700 (PDT)
Message-ID: <68abb9ea-37cc-df7a-d557-39b4c83c2e0c@linaro.org>
Date:   Fri, 15 Sep 2023 12:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 17/42] dt-bindings: pwm: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-17-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-17-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC PWM.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
> new file mode 100644
> index 000000000000..198b9a40f756
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/cirrus,ep9301-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logick ep93xx PWM controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +

$ref to pwm.yaml

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-pwm
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-pwm
> +              - cirrus,ep9307-pwm
> +              - cirrus,ep9312-pwm
> +              - cirrus,ep9315-pwm
> +          - const: cirrus,ep9301-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SoC PWM clock

No pwm-cells?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false

and then unevaluatedProperties: false instead

Best regards,
Krzysztof

