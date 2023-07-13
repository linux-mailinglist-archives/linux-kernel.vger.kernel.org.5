Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A4751E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjGMKD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjGMKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:03:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082A26B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:02:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so290049f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242574; x=1691834574;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24N6QIJfw8vnZ0z26iuUATuQsDpghCwf/j1TkIoQh/Y=;
        b=ClZzo/bCy2XliMbqG3GS5vec6HVRguyhE0iR5eB0wXIy/CgFmC7TYazGqT7MraSL1m
         ccZRcdih5Mqch2b1VS66B34Z3tao9R6Nz6hOgIV8S+q9/kX13cTm/di4MI6r2Xd0YHCJ
         1Ldq/fTXAdlYioEp4nmdfuMBwChXtc8CvmATe/VK8XiksxyZQJqH3PrV8ybIP2UqtwrK
         oxQfT1neQGeqxwA9ZgQrT228AoDxN1Zwb2613qw09m1VdHCilNfKVdVwnOpGueLo6kB0
         O7Hb9aQrpv2enxm5mdkCP5lu/F7UE/ioEVEVmISVWdgLp88qWApT2ISoFu8JtEExhONi
         x6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242574; x=1691834574;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24N6QIJfw8vnZ0z26iuUATuQsDpghCwf/j1TkIoQh/Y=;
        b=fXIrvwQnH6ln60t0XAW+QGSqE5Fy8FEf+hiE5IGaDGMjuf0UOeStG8L8fbZFDVSw/c
         rGxdnoajRLTBmR97a8nKwJoK60NMFwpMmTMMY7fNq4fO4LjQ8j14kvALi2tTmiMX22j0
         BnqWvZIoAsyWSPVUD+qai1wpj27QtvDp1xcd79GcGc9FYmwv6OKs3wkOkaIUHWyvqLJL
         Wtk1AyXPtJFw5Pw3QC+twVkjj1S3xPuQshDRoz56p6rj2e//75/b77O7XK3QHddO4g5L
         9BrgBLhCMFyOE0Ox6XZZQizchNUDXGlQmHCC3Xa7F57rYu9ZWLMBtm4HUVdKf7oQHZLV
         RSBw==
X-Gm-Message-State: ABy/qLarVJQXDOjvK6njqESVgohC55i/DXL53tGvJB0oPXftS1nOybof
        1r9WbrsWSx5EBaxQNvvo0y8GMg==
X-Google-Smtp-Source: APBJJlFtt8ebDSbwMjmV/fHwToHgVyDwZ1DvTZK1G7a5UTKK0RsrpDpB7V1RLGiAYj/n8+foNZPK9w==
X-Received: by 2002:adf:d0c3:0:b0:314:323b:9d3b with SMTP id z3-20020adfd0c3000000b00314323b9d3bmr3835181wrh.32.1689242574306;
        Thu, 13 Jul 2023 03:02:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s15-20020adff80f000000b00313f9a0c521sm7539831wrp.107.2023.07.13.03.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:02:53 -0700 (PDT)
Message-ID: <1dddf0b5-c47e-4d80-7126-b9563e972927@linaro.org>
Date:   Thu, 13 Jul 2023 12:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 1/2] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x60
Content-Language: en-US
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, cristian.birsan@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, jerry.ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, andre.przywara@arm.com, ada@thorsis.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230713095111.335346-1-durai.manickamkr@microchip.com>
 <20230713095111.335346-2-durai.manickamkr@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713095111.335346-2-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 11:51, Durai Manickam KR wrote:
> Add sam9x60 compatible to DT bindings documentation.

Unfortunately, I don't understand this commit msg with patch. You say
you added a compatible, but the compatible was there before and your
diff moves it to a list.

Explain in the commit msg what is the real problem.

> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../devicetree/bindings/serial/atmel,at91-usart.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> index 30b2131b5860..65cb2e5c5eee 100644
> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -16,13 +16,15 @@ properties:
>        - enum:
>            - atmel,at91rm9200-usart
>            - atmel,at91sam9260-usart
> -          - microchip,sam9x60-usart

It's here, look ^^.

Best regards,
Krzysztof

