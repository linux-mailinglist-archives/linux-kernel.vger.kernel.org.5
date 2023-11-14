Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF657EB65B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjKNS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjKNS1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:27:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486812A;
        Tue, 14 Nov 2023 10:27:45 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c5249d55so9252239e87.3;
        Tue, 14 Nov 2023 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699986464; x=1700591264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aLKgnxjumveCQmA33N3eaw/7AnwbWNB2KFhyb6Fh/M=;
        b=H+xdIqS+p279Rjx95XOnywx4dme8lCa5Vnh1CUWc7KTFSydT6PTyv1qEJ6LZpF/2BN
         VDlGTqzAo2W/5xrwHZ9Fc31izITcsUYDSxXIIGWuj8XHsBwQRjvOFNTe20JCHfhevC3L
         a5kr7ss345IyXYavYNxund5HOe05QnziBjyzNSxgGXuVoeYdsB3sHVSdjooJv3INzDYB
         n1bVbzU1oVJ0LphTAl1ODkxk2MUMj9Fgr94KbFvWaletVXIXsCnzjUtd+bOpRqu3rrQI
         ZlTMNnniaeo5nIBL1dRM6cNTiW6erEAFCJpO9vMvU5lQmkMwaULeCQaKJxfsg7byuTNO
         baLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699986464; x=1700591264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aLKgnxjumveCQmA33N3eaw/7AnwbWNB2KFhyb6Fh/M=;
        b=XQXUrNFcqC3aYP99zqWCdS7Q6q+QtYYgJ/t/WmOzN3RvtBldahM6tQyIzxXulf7GVn
         RQooy4l0y3xoE+fwdPr13EYL2Mprr75zNYhMJO8YIyPzSBgmgXdo+HAGix8Itv0tRzZ6
         WtfjHVYA4ZEBDTyuCBk0zutiOgokwc6mHCuOgISMbMpAxbFoE/ZtQJtGDogqBxqWPtPl
         kFP0cuLsDky8UI3XM3HlhpfQN8eQcoBvsc7N4DbMzYxoSrQbkj0nkXmmLbchc1Q5vwvN
         adgyXwkmnD2Xf9QggHCjkdgmyT6c1z1TxgVSbjhTKm5Z8cplNHJ7ErcH+KgbCtA1A3Q7
         HvIA==
X-Gm-Message-State: AOJu0YyyLnHEJEFVRtxZpaIREEQQUZ2dbb8/XlOscWkdgmGZNsDFhczJ
        pjx6D9QdVdWGn8141mYQkhnO2hOoW/qs65PuTW0=
X-Google-Smtp-Source: AGHT+IEh9RjdZDWW7hfIGTr1M9kFP62rLBZYB/wEV27gSjM/hp1UXeKHJNEy56A3HMOhaV9tu+DkNQ==
X-Received: by 2002:a05:6512:3f0:b0:50a:6fc5:e95c with SMTP id n16-20020a05651203f000b0050a6fc5e95cmr6168003lfq.60.1699986463736;
        Tue, 14 Nov 2023 10:27:43 -0800 (PST)
Received: from [10.76.84.181] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w24-20020a50d798000000b00544f8271b5fsm5585115edi.8.2023.11.14.10.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 10:27:43 -0800 (PST)
Message-ID: <80ad972c-9f98-4c57-8318-c84225e79cbe@gmail.com>
Date:   Tue, 14 Nov 2023 20:27:41 +0200
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
 <500eec71-e2f4-4f43-8bc9-6d4914b2493c@gmail.com>
 <124c97ca-0c2c-4b92-8d8e-99d589daf2da@linaro.org>
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <124c97ca-0c2c-4b92-8d8e-99d589daf2da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.2023 19:39, Krzysztof Kozlowski wrote:
> On 14/11/2023 17:02, Alisa-Dariana Roman wrote:
>> On 06.11.2023 10:56, Krzysztof Kozlowski wrote:
>>> On 05/11/2023 20:31, alisadariana@gmail.com wrote:
>>>> From: Alisa-Dariana Roman <alisa.roman@analog.com>
>>>>
>>>> Unlike the other AD719Xs, AD7194 has configurable differential
>>>> channels. The default configuration for these channels can be changed
>>>> from the devicetree.
>>>>
>>>> Also add an example for AD7194 devicetree.
>>>>
>>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>>> ---
>>>>    .../bindings/iio/adc/adi,ad7192.yaml          | 69 +++++++++++++++++++
>>>>    1 file changed, 69 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>>> index 16def2985ab4..b9a9f7b20670 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>>> @@ -21,8 +21,15 @@ properties:
>>>>          - adi,ad7190
>>>>          - adi,ad7192
>>>>          - adi,ad7193
>>>> +      - adi,ad7194
>>>>          - adi,ad7195
>>>>    
>>>> +  '#address-cells':
>>>> +    const: 1
>>>> +
>>>> +  '#size-cells':
>>>> +    const: 0
>>>> +
>>>>      reg:
>>>>        maxItems: 1
>>>>    
>>>> @@ -96,6 +103,31 @@ required:
>>>>      - spi-cpol
>>>>      - spi-cpha
>>>>    
>>>> +patternProperties:
>>>> +  "^channel@([0-9a-f])$":
>>>> +    type: object
>>>> +    $ref: adc.yaml
>>>> +    unevaluatedProperties: false
>>>> +
>>>> +    properties:
>>>> +      reg:
>>>> +        description: The channel index.
>>>> +        minimum: 0
>>>> +        maximum: 7
>>>
>>> Your pattern a bit above is not correct then: [0-7]
>>>
>>>> +
>>>> +      diff-channels:
>>>> +        description: |
>>>> +          The differential channel pair for Ad7194 configurable channels. The
>>>> +          first channel is the positive input, the second channel is the
>>>> +          negative input.
>>>> +        items:
>>>> +          minimum: 1
>>>> +          maximum: 16
>>>> +
>>>> +    required:
>>>> +      - reg
>>>> +      - diff-channels
>>>> +
>>>>    allOf:
>>>>      - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>    
>>>> @@ -127,3 +159,40 @@ examples:
>>>>                adi,burnout-currents-enable;
>>>>            };
>>>>        };
>>>> +  - |
>>>> +    spi {
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        adc@0 {
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +            compatible = "adi,ad7194";
>>>> +            reg = <0>;
>>>> +            spi-max-frequency = <1000000>;
>>>> +            spi-cpol;
>>>> +            spi-cpha;
>>>> +            clocks = <&ad7192_mclk>;
>>>> +            clock-names = "mclk";
>>>> +            interrupts = <25 0x2>;
>>>> +            interrupt-parent = <&gpio>;
>>>> +            dvdd-supply = <&dvdd>;
>>>> +            avdd-supply = <&avdd>;
>>>> +            vref-supply = <&vref>;
>>>> +
>>>> +            adi,refin2-pins-enable;
>>>> +            adi,rejection-60-Hz-enable;
>>>> +            adi,buffer-enable;
>>>> +            adi,burnout-currents-enable;
>>>> +
>>>> +            channel@0 {
>>>
>>> Why cannot you add this to the existing example?
>>>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> I added another example to highlight the fact that only AD7194 supports
>> configurable channels. How should I proceed?
> 
> Bindings did not tell that, so it seems you miss that part - allOf
> constraining channels per variant.
> 
> Best regards,
> Krzysztof
> 
And should I remove the AD7194 example?

Kind regards,
Alisa-Dariana Roman

