Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B049975A60C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGTGKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGTGKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:10:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FA1734
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:10:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso2555165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689833431; x=1692425431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpwiEpwGN8y+xovE4mKCXxps5VNG9/n20Ieq6eiPqzA=;
        b=qkGS9umnljS3kdKjIQuojE0tAbfxQfUlhFeuot80GZluJt97aGuZZp3lhyxgrLc3eA
         YIL3NT+IeKcW/Rv6fekthOUNZaDlOXf8CghId3NeVhfbgBgF8PVgg1h38DwsgnsmwlGV
         fnDQoHX5H+aIB7s9BxBYaEJBBHXOB0N/LONQ4d5mCkWwOHnXzeAU+NZSHTs9F77jacvl
         xCdQHLcGjFk5Zh1TxNfnM+ZIlPW+5uvYnQCTM7nnmnNQlRFqSdQwchnkqsxPN/cqtIbs
         /+4cUNjc4YS8VeQVJknp4RHx2qp+hHu5pGq+KMMg25K/3ZJvNXPaQfziTnYvCNAqmQE0
         oBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689833431; x=1692425431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpwiEpwGN8y+xovE4mKCXxps5VNG9/n20Ieq6eiPqzA=;
        b=jFI8/iX3MPt2yCsW8MbWAmg5zLYkRlZL6CGvsgRQhfO0/CE8jOA3lp7D36S7d4J2LH
         ElOASsd/4cCjSGUkxgRNLMhjljXnHznQGwiVJFE7rngh/OYJ1pRBlvJDIRvod6cv95fB
         hp7Ulxb8c5QgIdT+QT+UwZJluf7nRIgpvcojiRPD+cSTNtaOGmmusBULc7GC0mYHda12
         TCXVl9286TOxRxY7b8vx7sBbfuqP6B+KrsNvQeDiwsXn2zJ9MIvJltwqh9LODHwE0i/E
         yIefrvCwweApvgOXIhvXVrzLoH/hBV69OepNGniab62E2uPhyqZOp/yVc4jObQg1lP3r
         +SRg==
X-Gm-Message-State: ABy/qLYcbLrUZGJ0HWsA0HgLdSVqsBYcTiIHV79CGu0FusdSU09+vzlg
        uCsqYtC9TVCjsh5frpBIlywyWyjs3Cj6kzIQ7Ic=
X-Google-Smtp-Source: APBJJlFtLga5FHzClZTE6RYqbVdAQwZvzfYfA+aMitkMLEwtJitrvBM0xwRGH93LMaMYXjWJKgl55Q==
X-Received: by 2002:a05:600c:3797:b0:3fa:9741:5b73 with SMTP id o23-20020a05600c379700b003fa97415b73mr3503203wmr.10.1689833431076;
        Wed, 19 Jul 2023 23:10:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w9-20020adfd4c9000000b0031423a8f4f7sm246126wrk.56.2023.07.19.23.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:10:30 -0700 (PDT)
Message-ID: <7889ef36-90ee-222b-fe67-ab4e127d1df6@linaro.org>
Date:   Thu, 20 Jul 2023 08:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: rtc: Document nuvoton ma35d1 rtc driver
To:     Jacky Huang <ychuang570808@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230720012826.430026-1-ychuang570808@gmail.com>
 <20230720012826.430026-2-ychuang570808@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720012826.430026-2-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 03:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 rtc driver.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
> new file mode 100644
> index 000000000000..08c30f3018fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nuvoton,ma35d1-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Read Time Clock
> +
> +maintainers:
> +  - Min-Jen Chen <mjchen@nuvoton.com>
> +

Missing ref to rtc.yaml.


> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,ma35d1-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false

And then use unevaluatedProperties: false instead.


Best regards,
Krzysztof

