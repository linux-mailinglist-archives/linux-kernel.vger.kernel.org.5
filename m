Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B587EB454
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjKNQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:02:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BD1FE;
        Tue, 14 Nov 2023 08:02:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c41e95efcbso849596166b.3;
        Tue, 14 Nov 2023 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699977753; x=1700582553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7o5QmUXPo3E3VEamoF4ZTOZ4Zd/AR5NbdIm9cwl4NQ=;
        b=W0qaTbRxY65vkTDI1zQyqlKcG6Si3x/oVu2GLExbRuCE8AFRRjGfS1AUhyr+PbqH8s
         O6xGnKxpqbgxSszYPdnCd4aP+DHIUmaWOEGcLhjVe3zXtL/IjzUj3ySYyVzSy2t4K8IE
         bq21aY2yrBpAHcanfNreMTdSVUFZWICXDW69OYteD8c4DOfz/Ao0REmt+sVLaLZUqElq
         lq/TCxDMmlSOuefXLr2WG1YZvbNgG6XEQ4SY/mWMwr+F7bdb8DNE48k1R11VKjOYZlbt
         f/6znF0fCltXG42r5F+i1gB57kVg8MAVk4toB++HKxGnOvd8pNkbriufUyA3ahQsACkV
         SyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977753; x=1700582553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7o5QmUXPo3E3VEamoF4ZTOZ4Zd/AR5NbdIm9cwl4NQ=;
        b=qD08UVZvSBjjJFmCTK62jXTfSBAVPomFS6WMNGfisd5Mt1Zy7DXlAnbqVVzQLfQvoD
         EMWLgYScEfe5+VQ4WodsIH3fjcL+PpA+hxjW7RbXEsJMgovVAQZgLQ2PDzOvfO9IyWhz
         JObzCVGUO3D3LLecJKK83XkDfwjT6zm2brzUwJasbxfj6CT2MH3OQARJWde5J5tTNu/l
         kTNLdq+TAtN45via2WpTnAcUMlHBRvSwJGefR8pXdXrFlspV6JF223hQU74YVI/4YQqt
         GsIzV0YsglGrOlIfPHatAMOPbVTuRc/5+3kpaGZMOnz+PlO/eUOmpdg+YuGp0kmtzxvi
         VNFw==
X-Gm-Message-State: AOJu0Yz3sQ6HiIQ9VukGiv2CO6KYzVj0z4IIphUMMC9FRc1WzHygOXlr
        o93OALbha72JtHneAbyLXr8=
X-Google-Smtp-Source: AGHT+IFijuEq+KWENnhrCTxm6KR4O5FgNbgxdRujmQMAkF+aq8oBCuUwkRXRm1A3/iHVlUkADwA0yw==
X-Received: by 2002:a17:906:d8d2:b0:9ad:e180:16e3 with SMTP id re18-20020a170906d8d200b009ade18016e3mr7347700ejb.37.1699977753229;
        Tue, 14 Nov 2023 08:02:33 -0800 (PST)
Received: from [10.76.84.181] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ay18-20020a170906d29200b009ce03057c48sm5766424ejb.214.2023.11.14.08.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:02:32 -0800 (PST)
Message-ID: <500eec71-e2f4-4f43-8bc9-6d4914b2493c@gmail.com>
Date:   Tue, 14 Nov 2023 18:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: ad7192: Add AD7194 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231105193132.47009-1-alisadariana@gmail.com>
 <20231105193132.47009-3-alisadariana@gmail.com>
 <e5c9eaaa-a8f3-4ca5-acf6-9ff714a07898@linaro.org>
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <e5c9eaaa-a8f3-4ca5-acf6-9ff714a07898@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2023 10:56, Krzysztof Kozlowski wrote:
> On 05/11/2023 20:31, alisadariana@gmail.com wrote:
>> From: Alisa-Dariana Roman <alisa.roman@analog.com>
>>
>> Unlike the other AD719Xs, AD7194 has configurable differential
>> channels. The default configuration for these channels can be changed
>> from the devicetree.
>>
>> Also add an example for AD7194 devicetree.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad7192.yaml          | 69 +++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> index 16def2985ab4..b9a9f7b20670 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> @@ -21,8 +21,15 @@ properties:
>>         - adi,ad7190
>>         - adi,ad7192
>>         - adi,ad7193
>> +      - adi,ad7194
>>         - adi,ad7195
>>   
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>>     reg:
>>       maxItems: 1
>>   
>> @@ -96,6 +103,31 @@ required:
>>     - spi-cpol
>>     - spi-cpha
>>   
>> +patternProperties:
>> +  "^channel@([0-9a-f])$":
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        description: The channel index.
>> +        minimum: 0
>> +        maximum: 7
> 
> Your pattern a bit above is not correct then: [0-7]
> 
>> +
>> +      diff-channels:
>> +        description: |
>> +          The differential channel pair for Ad7194 configurable channels. The
>> +          first channel is the positive input, the second channel is the
>> +          negative input.
>> +        items:
>> +          minimum: 1
>> +          maximum: 16
>> +
>> +    required:
>> +      - reg
>> +      - diff-channels
>> +
>>   allOf:
>>     - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>   
>> @@ -127,3 +159,40 @@ examples:
>>               adi,burnout-currents-enable;
>>           };
>>       };
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@0 {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            compatible = "adi,ad7194";
>> +            reg = <0>;
>> +            spi-max-frequency = <1000000>;
>> +            spi-cpol;
>> +            spi-cpha;
>> +            clocks = <&ad7192_mclk>;
>> +            clock-names = "mclk";
>> +            interrupts = <25 0x2>;
>> +            interrupt-parent = <&gpio>;
>> +            dvdd-supply = <&dvdd>;
>> +            avdd-supply = <&avdd>;
>> +            vref-supply = <&vref>;
>> +
>> +            adi,refin2-pins-enable;
>> +            adi,rejection-60-Hz-enable;
>> +            adi,buffer-enable;
>> +            adi,burnout-currents-enable;
>> +
>> +            channel@0 {
> 
> Why cannot you add this to the existing example?
> 
> 
> 
> Best regards,
> Krzysztof
> 
I added another example to highlight the fact that only AD7194 supports 
configurable channels. How should I proceed?

Kind regards,
Alisa-Dariana Roman
