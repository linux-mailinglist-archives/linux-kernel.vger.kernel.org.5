Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE5766BED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjG1Lkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjG1Lkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:40:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA4A3AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:40:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so2641605a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544436; x=1691149236;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e99k6MXqRhdp0tUCxYSvy6N+Vt6XwwdZ3dH7SZQmca8=;
        b=kjEh+Tt+VIPgsjM22HSPjWPVCdEgFBmTDIWo21olsDCkp5MWk0SP2hNH75tVkpLC86
         HFJkT1fFcNEbYgT/rtejZmLXRet8JEU38m0XZamxezWWhNBrfQEqQOBjgSc2dPS9e+vb
         pBpbUP8HG2c/aeHuz6Gz+dPgDVdJMnCLrVAWsSf+zoS2TwnOQJobKuo7o1THakhXkzxv
         dDEcfgblfDy4EdPFjX2Lzl9ryOlemqKzP1YKb7XXDfh/nfeb0Qcgzmlwrffvp3MxZvlr
         nsFDErMzVdqcAK377UxsdEug1l7icEil+A834GFsGOjBLOqsqKxYOJyrI6s2DuRX4NG2
         rzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544436; x=1691149236;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e99k6MXqRhdp0tUCxYSvy6N+Vt6XwwdZ3dH7SZQmca8=;
        b=awrN8Ffbn2MqBBJoReAsCBO8FEZOwWHyfpMWpzZZ2rCijOw132L10FZLD5JUm4rpuS
         Z+4FuBl1CPsWV1JspIKPjw3u5WE7hUhs4Jgr8qNLKvQfgA8egzxYBq4QHiYwjSnYZcmE
         Rs9DIsOA8/dUeYXkqM6X96GmtRayXYkjkT7Jn0/QqKK3bhkte1oy9lk1d89I+I36bkny
         CtjNHOh/VeqkiRZZpvSACyp/VLUWn4YvcSoyF36hulblROA5Nnuj6CZ7YCKtCXKlaNgU
         mtVrc8OW4u9kH9tU/3s3wOjzSJFVnH1GnnVUS0I7uqrIQYcbnUXs+wPZduiXNhFoaoyA
         /R3w==
X-Gm-Message-State: ABy/qLZCt4DKRzxLU9LqWbk9QTgQ+i5TE9ZhJrurJVnAKmzneLx4YmxB
        SOrSqpIE4YMTpHQlwI85FtiY3w==
X-Google-Smtp-Source: APBJJlHl7eUF/TWez9o3adZRGXP37ZV6hBsHgUUAP2fi3AK6EB0VOdKrKtioWsbYmb1UkeKkBOGR9Q==
X-Received: by 2002:aa7:d745:0:b0:522:289d:8dcd with SMTP id a5-20020aa7d745000000b00522289d8dcdmr1501443eds.35.1690544436574;
        Fri, 28 Jul 2023 04:40:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402069a00b005224d960e66sm1697221edy.96.2023.07.28.04.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:40:36 -0700 (PDT)
Message-ID: <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
Date:   Fri, 28 Jul 2023 13:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102350.265520-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102350.265520-1-varshini.rajendran@microchip.com>
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
> Add bindings for SAM9X7's pmc.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> index c1bdcd9058ed..ce0d99503645 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - atmel,sama5d4-pmc
>                - microchip,sam9x60-pmc
>                - microchip,sama7g5-pmc
> +              - microchip,sam9x7-pmc
>            - const: syscon

Where is the change in allOf:if:then:? No need for it? Why? Where is the
driver change?

Please do not send huge series to 50 different people and subsystems.
With your lack of threading it is so difficult to review.

Best regards,
Krzysztof

