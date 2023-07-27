Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF15D7650C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjG0KS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjG0KSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:18:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980A19A1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:18:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bc0da5684so99632066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690453130; x=1691057930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8pQp0JlWDW0p3G87TyWz56o023qjSUpNspFrRRywds=;
        b=QfEJTE3uBRSqlYwjXjlLZC47w+Qnup0IlP5go/z2wJb1+JHIhuhTvkLI9y392DC7C0
         w9U2XPD5LYPDKSOvpeErflTm+g68ThUX49iW/lbQ5Ijknl9eIUHjqXJsKm1HC1UO9t6a
         bnjP9AKWCdCegVMuUpGGvEQGzfjE4CZI/JgjMKqc5VN29gWBDa8/uloGUicrH+YAqElb
         09eEtFKOkdxOWG0u7k/P/D9IdUgOMtfbVdLl/3OXys3NDIm6LascgUza1kL+QF4XCZOG
         ckvS+FCrACPpQTG42/gbO8YeZ4IjLjj/EGBEj0CIXzh1HnRbgkdVr5pbizJMTdkpR2DU
         CE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453130; x=1691057930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8pQp0JlWDW0p3G87TyWz56o023qjSUpNspFrRRywds=;
        b=SpPynBx3xbSg29vBaRhMQpoeoBnNQcd6dSg2e2dF8S2+FFxnHEgG/M6U+o6muAXvEr
         MiQ+5WQOjIc9k0H1IOQZeLH3OB5nb665BsH+COIpMulKSYWSxKb6EfyhkG5uUnenl291
         itOcrwzEAMvQxCFvtmu0Ijsxd7hl9RBpy7aknDM1xhRuOd0PAlXquOeu/gEsSl6IPM5b
         HuvD2i5LNxAboLMdmGaBHRQzJoPuNjDAKg91NbMHV0mdKsiTVAVKfGrkFmYfmfYk4ckB
         GfCcaY3mKFmDpnJPQwp5VAAkCYOMCpRrynbFLLXTFcAlYcIqfc9I2Nt40pRKWQZFZDUk
         U9RQ==
X-Gm-Message-State: ABy/qLYlT+fJpQBB6IaM6m9ObHYGJzBgppJ3+hHyDLdWGHfW3lNADAmZ
        0jTcLOm4joMYzbxPzBFnwONnDA==
X-Google-Smtp-Source: APBJJlH0SI2SaNJR6mF9IrL+ZFvmgLfTTzxHnN1wXAFn7DYgB8GkRnzVJ6lSp6QEs5wmJTiAbpLGRQ==
X-Received: by 2002:a17:906:10d9:b0:99b:bf43:732b with SMTP id v25-20020a17090610d900b0099bbf43732bmr1597175ejv.23.1690453129801;
        Thu, 27 Jul 2023 03:18:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ke16-20020a17090798f000b00989027eb30asm582691ejc.158.2023.07.27.03.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:18:49 -0700 (PDT)
Message-ID: <3c69b206-a9f0-c8f3-70a1-3994e056140b@linaro.org>
Date:   Thu, 27 Jul 2023 12:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: mcp3911: add support for the
 whole MCP39xx family
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 12:13, Marcus Folkesson wrote:
> Microchip does have many similar chips, add those to the compatible
> string as the driver support is extended.
> 
> The new supported chips are:
>   - microchip,mcp3910
>   - microchip,mcp3912
>   - microchip,mcp3913
>   - microchip,mcp3914
>   - microchip,mcp3918
>   - microchip,mcp3919
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index f7b3fde4115a..06951ec5f5da 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -18,7 +18,13 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - microchip,mcp3910
>        - microchip,mcp3911
> +      - microchip,mcp3912
> +      - microchip,mcp3913
> +      - microchip,mcp3914
> +      - microchip,mcp3918
> +      - microchip,mcp3919

Your driver suggests that they are all compatible, so maybe just use one
as fallback?

Best regards,
Krzysztof

