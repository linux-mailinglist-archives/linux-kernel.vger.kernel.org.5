Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8C7826B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjHUJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjHUJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:59:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA1D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:59:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3750242a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692611960; x=1693216760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfnhEnLWB5KwPnq+5sUX4rq+xUeecsyqh2xi9cV8plo=;
        b=aegEo+5bPsOgM7Abn79QB6cXz2xQt9xi7cdVNNPmg9B7tT06PiGKgX1InoNGDl8bxZ
         338mHckrPEE6CLB39U6vZu8e2dHjLZ3g1hSeEIFfzUmSZe/pLjll6pM/vOiOw7SPe9pV
         6TKLHcwpfpFbDK7WYdfP/Oxj2UvZVX5fgihzmiBjduobni/IJL4C4m54oJJC0wj/zFXW
         IF6v01ixmdqh3LL3JnWCHdll3zJzuFo5dw2OP6JlZr7ja0tRF5q+vKed9x++YVwoYWe+
         nF5lnXrdXUW7v51dx+9n9p0UXoxNBpNOm1ZMgs+eool586xi8FMx3BZLVcAWl+sEGi57
         6aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611960; x=1693216760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfnhEnLWB5KwPnq+5sUX4rq+xUeecsyqh2xi9cV8plo=;
        b=kIGXZJZEXhQ+LZAR7w05g9buAsw/GSdIVuJWM1jMkvmqEoiMrC/nBm2LXJnwOHkUY+
         OM/1mUBsnH/vnWouuFFqcS6zvyNGoJcU3Yi4MVemTSU+k3ZLbrN+3nzst2SQ120FjWoK
         5y1libtXQ0CKmzDWYqf0etBABDst89fdgjdktWyNiq/c8To+GufWboZeX34ryOomwq5x
         HJFaeq3pBr/yFd6Yi+Ezt9pu9yiF1o6CbwZ0rjNKRUzQ45i1dYPoujZXSXu6JDwPity1
         z91DeB/KH4mkCqihxDQaRk7uMTZLpcdX+wH09LtXglQIPGjK9pbYaaEKEvpv0OWizg9E
         ISMA==
X-Gm-Message-State: AOJu0YyFrNo8Ut1qcNlq5Q7zoazoRgZ6Nm09jZMpEP8Nsnf0+AwpzBfl
        uWChRPAiyHF+NwZqWvbogzSMmQ==
X-Google-Smtp-Source: AGHT+IG001d1cAQKIxx4riu0MNWkOswLnbQRQh6hkZ4rOg4g8XJRaQpDdMYLSRFQQO+P0HYNtp6SfA==
X-Received: by 2002:aa7:d3d2:0:b0:521:a4bb:374f with SMTP id o18-20020aa7d3d2000000b00521a4bb374fmr4510485edr.5.1692611960545;
        Mon, 21 Aug 2023 02:59:20 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.107])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7d502000000b00529fb5fd3b9sm3996607edq.80.2023.08.21.02.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 02:59:20 -0700 (PDT)
Message-ID: <6c76b28e-e995-2082-6dfa-378002989bcd@linaro.org>
Date:   Mon, 21 Aug 2023 10:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <a7b84b23-a1c1-23df-79db-d965ed261223@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a7b84b23-a1c1-23df-79db-d965ed261223@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 09:59, Nicolas Ferre wrote:
> On 28/07/2023 at 12:24, Varshini Rajendran wrote:
>> Add DT bindings for atmel TDES.

this commit message is way too succinct and hides the complexity that's
needed in the driver

>>
>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> 
> Following my answer to the email thread:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Thanks, best regards,
>   Nicolas
> 
>> ---
>>   .../devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml  | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> index 3d6ed24b1b00..6a441f79efea 100644
>> ---
>> a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> +++
>> b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
>> @@ -12,7 +12,11 @@ maintainers:
>>     properties:
>>     compatible:
>> -    const: atmel,at91sam9g46-tdes
>> +    oneOf:
>> +      - const: atmel,at91sam9g46-tdes
>> +      - items:
>> +          - const: microchip,sam9x7-tdes
>> +          - const: atmel,at91sam9g46-tdes

why do you backup to "atmel,at91sam9g46-tdes"? Simply relying on
"microchip,sam9x7-tdes" and its of_device_id data should be enough.


>>       reg:
>>       maxItems: 1
> 
