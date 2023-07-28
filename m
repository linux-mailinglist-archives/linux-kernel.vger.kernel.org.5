Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D664C76723C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjG1QoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjG1QnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:43:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2D4691
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so2970727a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562576; x=1691167376;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3+wuhVg/p8H9ClZOmeQcBUOyAzdHoE0pZfkw6+aEgE=;
        b=f4rWmLbH6MxCsyYr37tBB/9EqqbZJuHRl8dlSWCSmANEHsTqQ31ZVBocBl1X24/rR9
         Xvyh6Bb+HAh5im1Vz0JV7c+gYlyYCnsPDDDyXoFgnJJjMyJwEqqCf2gybkFnDTGKf2nd
         QzeFOLP9ZI6CIQuRVTXp13T0NEHNrkCmCXBoQt3LjiUEiJ2qPFnLeTSZIaSGH+Nh7HcV
         nYGBKahXXFafGQAoio7PdhVNcfGv2k9v+95YGcvDT8WGgBE/wK7lmqIQpX3qVPtcfH+X
         EsIc6vi41fMzS1gkpAyc9yIAVoOwPjWFfp0ANdQyieeHA5f1nOZdlqjbG7RTEuzUV4GB
         qbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562576; x=1691167376;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3+wuhVg/p8H9ClZOmeQcBUOyAzdHoE0pZfkw6+aEgE=;
        b=JyvE3+IF8YEkoLXHXSuvUrPidOHn3Pm6Xaii1xUYug+h8TexrPqpWnuJblbCAVvBg3
         0aHwXoyToT2F0eX7eqHnVFXJmaFOrd1vUF7qf+gPPkd2pDGfdunPVQZoO3ArCbfDZZqI
         LXAPdZV98f2UUHNSXZewKH01C0pQ7O68ha8IwiLItl3Hg42VuKsF4hEyCUoktUVB3pIo
         94QYNaiwJg2D0yyxySgTdY1xYlB2WRYoAtg26xpSAWohm3T7OlPFGdjxqLWLQxbE2FeY
         vy84yUHEl23J2WP5X82p5NsQGB5yohAki+lx1c811i19t0Qy9J4Z5SgiBv6oessnzYxC
         K2+Q==
X-Gm-Message-State: ABy/qLZzr6iR9zt+3U4ui2F6ivtEc7fszthCwxiNBhBr8VA2rmuOeTb1
        4LqEyvuHEbKQ1z8rhxtYp1HdxQ==
X-Google-Smtp-Source: APBJJlH5bYOR2n9oNfZEBMlqmDVCuTpOl4ID0OVQNdhlRA4qkuu66jlfbD+Oepe/HalkiwyCrR+NKA==
X-Received: by 2002:aa7:d145:0:b0:522:203d:c9b1 with SMTP id r5-20020aa7d145000000b00522203dc9b1mr2368024edo.11.1690562576039;
        Fri, 28 Jul 2023 09:42:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w10-20020aa7da4a000000b0051a53d7b160sm1968420eds.80.2023.07.28.09.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:42:55 -0700 (PDT)
Message-ID: <f042b194-659a-b128-7f5a-572150bf532f@linaro.org>
Date:   Fri, 28 Jul 2023 18:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 27/50] dt-bindings: usb: atmel: add sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102753.266660-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102753.266660-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:27, Varshini Rajendran wrote:
> Add sam9x7 bindings.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/atmel-usb.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index 12183ef47ee4..82bd0dbc2a48 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -3,8 +3,9 @@ Atmel SOC USB controllers
>  OHCI
>  
>  Required properties:
> - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> -   used in host mode.
> + - compatible: Should be "atmel,at91rm9200-ohci" or
> +   "microchip,sam9x7-ohci", "atmel,at91rm9200-ohci"
> +   for USB controllers used in host mode.
>   - reg: Address and length of the register set for the device
>   - interrupts: Should contain ohci interrupt
>   - clocks: Should reference the peripheral, host and system clocks
> @@ -30,8 +31,9 @@ usb0: ohci@500000 {
>  EHCI
>  
>  Required properties:
> - - compatible: Should be "atmel,at91sam9g45-ehci" for USB controllers
> -   used in host mode.
> + - compatible: Should be "atmel,at91sam9g45-ehci" or
> +   "microchip,sam9x7-ehci", "atmel,at91sam9g45-ehci"

This confuses me. Isn't microchip,sam9x7-ehci already described in EHCI
bindings?

Best regards,
Krzysztof

