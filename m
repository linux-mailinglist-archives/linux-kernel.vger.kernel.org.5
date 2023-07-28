Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E171E766BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjG1Liu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjG1Lis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:38:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615A3AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:38:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977e0fbd742so277434966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544326; x=1691149126;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5leZAhUKQXLEIMkQy47KayEVsACGqcWVCey8ch/+RqI=;
        b=H/+mbj3uJ1by92bWHcMwOHA5sGECXyyOmXBxIimWgNXGoLJZtmEnfe7E7zQoBpSAP0
         VLhSKxdPffAlJXEyKTh8p6U2rgdGlpdseVlBrSn3tug2fJRygrYlwGzXWMNA8V7dXuiJ
         5+mX/+wAXXm8GFWKAixjN0LYxwDB402wTvc4VJ/Eg4GewTFX72CyWEjU0vsJ/57Ug+Dj
         JoxsZHBUV2wFI+waNOZUGHOKeAj+AHugG54wf63ve/ql562bUcVMWmgQGEndz4gqEppa
         ws3q+Xfi0lQhizT9MI0MxpFEQFcDUijMQlZJSsE/Wfux2WSqnmq6pOyDoc3Qi4O6CVDQ
         kReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544326; x=1691149126;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5leZAhUKQXLEIMkQy47KayEVsACGqcWVCey8ch/+RqI=;
        b=IMvifQ4gUkJfMEtb/I2YL9Esb2p2EYf5NpduUAeyQXjlc8frwrxHbOZIpl/97v6gvl
         8usOJUwQzkjfPICLD0XZeopaveEICJzuV5ZoMXTsDaVteZbGP193rS8KA2mLLpS66UAL
         cVNWjroBE++qIyHFHAILpzO6vtlulW3ixdQC8MMMf+8WzyIWt7xgyTnI6zi4DbP2W8Yj
         Mg1GLBtNMU8svJIqto0el0YQ/5e3R/HGFkinpbUEhR3/ikBxZlR1YGy+tqSnAcHpvdHx
         fsRErLjheFk3+btJwR9mzgxSzaoyUIFfWwM2UWR4r9yHXsIKTKVIyn7Da4b4vRYBMvbO
         Ntmw==
X-Gm-Message-State: ABy/qLa7uyW6mVrQoDrr50j/6wIj01EYbNTqcTq+m0Z/waE0hk2BkYdK
        Ro1tzPE1yv7BJTrbqCS/OPrBBg==
X-Google-Smtp-Source: APBJJlG5PfJhIx4SHChUWn3WOKeHmv9ZxctbrGrtTHt3znYFmsGI+SpkABC24ihloGN/r3ccDFUb+Q==
X-Received: by 2002:a17:907:1dd3:b0:99b:bca6:cf90 with SMTP id og19-20020a1709071dd300b0099bbca6cf90mr1836790ejc.9.1690544325906;
        Fri, 28 Jul 2023 04:38:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906051400b00992b8d56f3asm1943015eja.105.2023.07.28.04.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:38:45 -0700 (PDT)
Message-ID: <fb18b855-94d4-77f4-bbf1-ca3167d3be7a@linaro.org>
Date:   Fri, 28 Jul 2023 13:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/50] dt-bindings: clk: at91: add sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102337.265471-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102337.265471-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:23, Varshini Rajendran wrote:
> Add bindings for SAM9X7's slow clock controller.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> index 7be29877e6d2..94b83047c3cf 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> @@ -20,6 +20,9 @@ properties:
>        - items:
>            - const: microchip,sama7g5-sckc
>            - const: microchip,sam9x60-sckc
> +      - items:
> +          - const: microchip,sam9x7-sckc

It should be enum with sama7g5.

Best regards,
Krzysztof

