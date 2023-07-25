Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39B761BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjGYO2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjGYO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:28:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A6102;
        Tue, 25 Jul 2023 07:28:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78847bb8940so287564439f.0;
        Tue, 25 Jul 2023 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690295286; x=1690900086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6vB0z4dxN5goqClcWw6bugDj7DXSnUUZmHJBfAn4fgk=;
        b=rBPdVUH2ANTV83DQ3Z3txtYeFR6Q41ovPnKSlHJ6ulbTVgD6XC7xkx2ZmI0VPkrCoF
         Ng6qncx/V77242J5HouqcowDSSkjtppx8McsGVCxMsmQY3ilC0YGf09W0INpzEhXQNjw
         ipRXQ/UE6AMvbcG4SfgZi0JjMvKoSa4aO+oMYMpl5/KdirU6Pp7F3BcBqlDWDknXYMGk
         jXY6IOu+Yv14a4sXi+htkWQ83mDas6l0iLlTD21oQFxgnYq37rhIDtA/gNSKAfeksSAt
         UcEL3ocjwCw3Z64Pqk2y1IBjN6ih+00Omng4/vIUcCYx1KGtPXPcqcITya1QrxYUQ+/T
         47Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295286; x=1690900086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vB0z4dxN5goqClcWw6bugDj7DXSnUUZmHJBfAn4fgk=;
        b=B50DGdhevYSUeGqeO5RhPcJULJg4C4dGufceXft2KdPE/9cRHY2WBW42uhdDc5XwBl
         UJz72lWnQyD7w+6AN5m1Zi0fhT6JpktPD3Y8xTvybvYEKYPbFTbsLCulWZO+qwi2mi7+
         m+BiRNgJiNsZbkQP9BPLaXmZtJqSbsA1uaWYY6Qti0q9bOKpT3CEGx4Erw+RFB7PoB6U
         sSRP4mHTf25jEiTCFZZojZo7QbQg9ZI8PXA+jk9MM1VfUTyZ1mCKSbP/DrrIZBWizMCv
         EZprLHr/mRWMYLkORqSmx/Os+WzCxCyLTfEvadpXCfckQyk5OZjURnpSY783Em5oeaJf
         dVcw==
X-Gm-Message-State: ABy/qLa3IBVKVJDC12X4/aQNWqsXfAJ39idbaNzv8qI9sNv2E82n7IPO
        a4RArmwEiV7x1XBzcPZgL0zJxybAaRs=
X-Google-Smtp-Source: APBJJlHLq5VYfIlb8RV7XBr3lhCOPd3bdfoFZx9vA5HIZym/i8pCPinxcgioiT9T2HDfqGIaNPnaNw==
X-Received: by 2002:a6b:e910:0:b0:787:6ae:46fa with SMTP id u16-20020a6be910000000b0078706ae46famr3078275iof.1.1690295286057;
        Tue, 25 Jul 2023 07:28:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gt11-20020a0566382dcb00b0042b227eb1ddsm3514264jab.55.2023.07.25.07.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:28:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e51de5ee-5342-8771-46a3-34d8ee8b9c55@roeck-us.net>
Date:   Tue, 25 Jul 2023 07:28:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
 <20230725131006.GA2879331-robh@kernel.org>
 <CABqG17iChAyb0gzb2uXfsv5GkiM3a+LoSavdqhjvw3FUccaw8A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABqG17iChAyb0gzb2uXfsv5GkiM3a+LoSavdqhjvw3FUccaw8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 07:17, Naresh Solanki wrote:
> Hi Rob,
> 
> 
> On Tue, 25 Jul 2023 at 18:40, Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Jul 25, 2023 at 01:40:26PM +0200, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> The TDA38640 has a bug in SVID mode and to enable a workaround
>>> remove the TDA38640 from trivial-devices and add a complete schema.
>>>
>>> The schema adds the custom property 'infineon,en-pin-fixed-level' to
>>> signal a fixed level on the ENABLE pin and to enable the workaround.
>>> When the ENABLE pin is left floating it's internally pulled low.
>>>
>>> If not specified the driver will continue to use the PMBUS_OPERATION
>>> register to enable the regulator. When specified the driver will use
>>> the PMBUS_ON_OFF_CONFIG register to enable the regulator.
>>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
>>>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
>>>   2 files changed, 50 insertions(+), 2 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>>> new file mode 100644
>>> index 000000000000..520112e4e271
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>>> @@ -0,0 +1,50 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +
>>> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
>>> +
>>> +description: |
>>> +  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
>>> +  Regulator with SVID and I2C designed for Industrial use.
>>> +
>>> +  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - infineon,tda38640
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  infineon,en-pin-fixed-level:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Fixed level of the ENABLE pin. When specified the PMBUS_ON_OFF_CONFIG
>>> +      register is used to enable the regulator instead of the PMBUS_OPERATION
>>> +      register to workaround a bug of the tda38640 when operating in SVID-mode.
>>> +      If the ENABLE pin is left floating the internal pull-down causes a low
>>> +      level on the pin.
>>
>> Neither this nor the commit message answers how do I decide if I set
>> this property or not? How you work-around it is not that relevant to the
>> binding.
> Sure will update this as:
> The property becomes relevant when dealing with the tda38640 in
> SVID-mode, providing an alternative method to enable the regulator by
> using the PMBUS_ON_OFF_CONFIG register instead of the PMBUS_OPERATION
> register
> 

As mentioned in the other e-mail, I'll want to see an explanation why
this property is even needed. The series claims that the chip has a bug
in SVID mode. It is kind of unusual that we would enable a workaround
for a bug with a devicetree property if the circumstance (SVID mode)
can be determined automatically.

Guenter

> Regards,
> Naresh
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        tda38640@40 {
>>> +            compatible = "infineon,tda38640";
>>> +            reg = <0x40>;
>>> +        };
>>> +    };
>>> +
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> index 6e24c4d25ec3..2b1fbb2a672b 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> @@ -151,8 +151,6 @@ properties:
>>>             - infineon,slb9645tt
>>>               # Infineon SLB9673 I2C TPM 2.0
>>>             - infineon,slb9673
>>> -            # Infineon TDA38640 Voltage Regulator
>>> -          - infineon,tda38640
>>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>>             - infineon,tlv493d-a1b6
>>>               # Infineon Multi-phase Digital VR Controller xdpe11280
>>>
>>> base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
>>> --
>>> 2.41.0
>>>

