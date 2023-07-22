Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F375DC7C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGVMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGVMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:25:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905C1BF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:25:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991fe70f21bso438709066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690028722; x=1690633522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qk8thI5T+jwpgQAFR2Sn0a0swilLkr2X5Xs+pz76+Bw=;
        b=OdtX93M93cwYtlIaxyFYFcqhyf+ZhngBA16jNysIyFzfu/idxlBHZEyhvWlllxHFRL
         FwIy3PD7JJET4Jc5h6ncoltltE/IoQqIW7wrf5RdcWQ5Vv9tGHzcGm2qBLP2qJypt/Vm
         CYC15ROIM8Tuh9199z8EIWoxDvyDwN+1fN1FYv6OmJKVgbKHC02hInTYhRW+H7HCtdD+
         hsLBHlykaM00EMRL9Fbzv9LDj6b2EAgkMDdp8Dsr+A+b/3LnBHEIocLgsKx7SYysNIy3
         jfZOTgb3VB2gxZjMa4wN/9gYq1pYN2nZ5H07obVATuXVzvlKyte8gkAvgX2R30fMeQbC
         AQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690028722; x=1690633522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qk8thI5T+jwpgQAFR2Sn0a0swilLkr2X5Xs+pz76+Bw=;
        b=DKrSy/CiOnf3+j4FCmCG34nWmm1H2+ZAO0YYQdabLA641syK0y5wMyhniJd5EnKjQQ
         G1ThrcLFFXeM6fdoRyVX2QjvdaUJ6rBslGA9sjxsE7ST6VNp4X77jhkG9qj3kqVYwZwg
         JMW6KzwYtF3YBZ3AzjPs5JTBv/U2tsHbpq1rd/cAo7AkHjejniEJWUoCf1WdtwDtdSFk
         G5s8B9JLrIRZREQh4K/9xYtKxIaWrSkysHEvuyU7E7KAuM9ZV8OtoiTiYtKrKa2KAnOp
         3S1/DqlABQRRAj2SwpxSP4qIFEMCzU28deqO1Y6t6lsMHAlGXgzGCny9JRS2UEU8LnYT
         I0Uw==
X-Gm-Message-State: ABy/qLY/0ymQiYZvxzFhaXm84CvuyUbPA0B+grTSPd4F/DBEyw8xRohB
        iOiH0E9F5SuM38wiOzoEQPDGFg==
X-Google-Smtp-Source: APBJJlHOvyYYvovJinVixKvVqiltjmOuHV8LvW+P6Y2r1hKtR343aqbqjTzQxPryfyMmf7K3WoxSnA==
X-Received: by 2002:a17:907:77d0:b0:98e:4c96:6e18 with SMTP id kz16-20020a17090777d000b0098e4c966e18mr4153864ejc.5.1690028722296;
        Sat, 22 Jul 2023 05:25:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709062f8a00b00992c92af6f4sm3559816eji.144.2023.07.22.05.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 05:25:21 -0700 (PDT)
Message-ID: <8324119a-ac06-da3d-dacb-5b7cc90f22eb@linaro.org>
Date:   Sat, 22 Jul 2023 14:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: mfd: maxim,max8998: Convert to DT schema
To:     Conor Dooley <conor@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721161712.31767-1-krzysztof.kozlowski@linaro.org>
 <20230722-occupant-outflank-bf433bc728c5@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230722-occupant-outflank-bf433bc728c5@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 13:57, Conor Dooley wrote:
> On Fri, Jul 21, 2023 at 06:17:12PM +0200, Krzysztof Kozlowski wrote:
>> Convert the bindings for Maxim MAX8998, National/TI LP3974 Power
>> Management IC to DT schema.  Adjust example to real DTS and make second
>> interrupt optional (like on s5pv210-aries.dtsi).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/mfd/max8998.txt       | 125 -------
>>  .../bindings/mfd/maxim,max8998.yaml           | 324 ++++++++++++++++++
>>  2 files changed, 324 insertions(+), 125 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/max8998.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
> 
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
>> new file mode 100644
>> index 000000000000..f3c3f64fd012
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max8998.yaml
>> @@ -0,0 +1,324 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/maxim,max8998.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX8998, National/TI LP3974 Power Management IC
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>> +
>> +description:
>> +  The Maxim MAX8998 is a Power Management IC which includes voltage/current
>> +  regulators, real time clock, battery charging controller and several other
>> +  sub-blocks. It is interfaced using an I2C interface. Each sub-block is
>> +  addressed by the host system using different i2c slave address.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max8998
>> +      - national,lp3974
>> +      - ti,lp3974
> 
> Should one of these be marked as deprecated?

We could deprecate national, because it was acquired by TI. But the chip
was actually made by National - the datasheet I found has a National
brand in product brief page and only the title page was added by TI.

> 
>> +  regulators:
>> +    type: object
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      CHARGER:
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        unevaluatedProperties: false
>> +        description:
>> +          CHARGER is main battery charger current control, wrongly represented
>> +          as regulator.
>> +
>> +        properties:
>> +          regulator-min-microamp:
>> +            minimum: 90000
>> +            maximum: 800000
>> +
>> +          regulator-max-microamp:
>> +            minimum: 90000
>> +            maximum: 800000
> 
> Did you pull these from the datasheet, or from the dts/example?

From the driver.

TBH, this is, very very old device used in very old boards which I don't
care about. I just want DT schema to be happy, so I don't think the
bindings should be really correct. It's not like anyone will make any
device with it.

Best regards,
Krzysztof

