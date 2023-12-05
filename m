Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A3805BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442488AbjLEPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346860AbjLEPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:49:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487AC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:49:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1975fe7befso632736966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701791387; x=1702396187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSo1Gw7KF03/2DHAX83C0r1c/LNazpYh+ohzF/eEWLc=;
        b=J2XhmGr55C37E4JHdmGigsmk0xgsy3SIvRLxHaf/pWCKp0vqzXUm3F8FnktT8pEUet
         THgRhf7yFUALnYBd+ylYHf7Qzt023wuj2cK31HF6jbYweFlOMSSYl0oGjYL5mQcePWJT
         ED2Sioe9jzPkRl4YbQ5F49kwkS1Bjv6VwbJg2qdTKn8wVASkEOaBDJzB+rg2hbOr4kfe
         Aqmbc0Wqg70r4PgboDECPM6MzAQOPQhO9IMym/yYMlG5OOy08RbPYzotA/wp1d5QxcJU
         m32it6jWddSmIRkL31Kg2nSGMmbzMLx8KOHLpxbwYkyRt4qW+h+hTczPB7KXS6zHJ+C3
         AMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791387; x=1702396187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSo1Gw7KF03/2DHAX83C0r1c/LNazpYh+ohzF/eEWLc=;
        b=FarxOM8C29xUy5oijlrLbrHeSqBOErOOla36NfmeDesnubm7PU/CqYIZcsWfjRXHxB
         n/KwYvAlFIpN0ZYtGdoyUCwGeVTUMQaBQ4HVifiyDWt6tld5DUnDYOqi52BqXmHreQUV
         4jEjLCo0vpMDH8Vk+5Cn+2FTd1oW/PFj3Vl2prb4m40YXtRruj/1bFiEvCjikLxQtnfF
         NDk4duW+83Ti+aeNNHREBKR9c4xVRzAKt7DTe96K0Dcs6XsWvO+9ZXo/ghfKQd5313OK
         iQokOdVpXVkVSj8WhqCDz+o8xxfjPQhN63jAgQTGDL1XQ+z9WqH93rB03/Papq5mmSzJ
         lovA==
X-Gm-Message-State: AOJu0YyHk43bd10HzvynuVwubBNohppik1/Gi1YZ7P0YcpgS499Arwkz
        40VeLVD497LzYTJgdYnRTcE97w==
X-Google-Smtp-Source: AGHT+IEs6fqCRB5LQzUOOhoB5NJbPY3ubNgrYruTpeXGlBRqnzIQZaJa2F1UxIUur7l3rfQPtMareA==
X-Received: by 2002:a17:906:bc5b:b0:a18:cdd7:3987 with SMTP id s27-20020a170906bc5b00b00a18cdd73987mr464930ejv.2.1701791387003;
        Tue, 05 Dec 2023 07:49:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id lt12-20020a170906fa8c00b00a0290da4a50sm6849231ejb.186.2023.12.05.07.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:49:46 -0800 (PST)
Message-ID: <4770f744-2309-4de0-8aaf-a221f69c08b7@linaro.org>
Date:   Tue, 5 Dec 2023 16:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: Add nct736x bindings
Content-Language: en-US
To:     Ban Feng <baneric926@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
        Bonnie_Lo@wiwynn.com
References: <20231204055650.788388-1-kcfeng0@nuvoton.com>
 <20231204055650.788388-2-kcfeng0@nuvoton.com>
 <94607c47-9824-4e2c-8f22-99ca2e088b27@linaro.org>
 <CALz278ZbjcbjUmFKv4B20DPDW33KPW-nZn4if3qTLjYKZZmWWw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CALz278ZbjcbjUmFKv4B20DPDW33KPW-nZn4if3qTLjYKZZmWWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 10:31, Ban Feng wrote:
> Hi Krzysztof,
> 
> On Mon, Dec 4, 2023 at 4:04 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/12/2023 06:56, baneric926@gmail.com wrote:
>>> From: Ban Feng <kcfeng0@nuvoton.com>
>>>
>>> This change documents the device tree bindings for the Nuvoton
>>> NCT7362Y, NCT7363Y driver.
>>>
>>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>>> ---
>>>  .../bindings/hwmon/nuvoton,nct736x.yaml       | 80 +++++++++++++++++++
>>>  MAINTAINERS                                   |  6 ++
>>>  2 files changed, 86 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
>>> new file mode 100644
>>> index 000000000000..f98fd260a20f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +
>>> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct736x.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nuvoton NCT736X Hardware Monitoring IC
>>> +
>>> +maintainers:
>>> +  - Ban Feng <kcfeng0@nuvoton.com>
>>> +
>>> +description: |
>>> +  The NCT736X is a Fan controller which provides up to 16 independent
>>> +  FAN input monitors, and up to 16 independent PWM output with SMBus interface.
>>> +  Besides, NCT7363Y has a built-in watchdog timer which is used for
>>> +  conditionally generating a system reset output (INT#).
>>> +
>>> +additionalProperties: false
>>
>> Please place it just like other bindings are placing it. Not in some
>> random order. See example-schema.
> 
> ok, I'll move additionalProperties to the correct place.
> 
>>
>> You should use common fan properties. If it was not merged yet, you must
>> rebase on patchset on LKML and mention the dependency in the change log
>> (---).
> 
> please kindly see below
> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - nuvoton,nct7362
>>> +      - nuvoton,nct7363
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  nuvoton,pwm-mask:
>>> +    description: |
>>> +      each bit means PWMx enable/disable setting, where x = 0~15.
>>> +      0: disabled, 1: enabled
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 0x0
>>> +    maximum: 0xFFFF
>>> +    default: 0x0
>>
>> Use pwms, not own property for this.
> 
> NCT736X has 16 funtion pins, they can be
> GPIO/PWM/FANIN/Reserved_or_ALERT#, and default is GPIO.
> We would like to add such a property that can configure the function
> pin for pin0~7 and pin10~17.

It looks you are writing custom pinctrl instead of using standard
bindings and frameworks.

> 
> My original design is only for PWM/FANIN, however,
> I noticed that we can change the design to "nuvoton,pin[0-7]$" and
> "nuvoton,pin[10-17]$", like example in adt7475.yaml.
> I'm not sure if this can be accepted or not, please kindly review this.

It looks like the same problem as with other fan/Nuvoton bindings we
discussed some time ago on the lists.

Please do not duplicate threads, work and reviews:
https://lore.kernel.org/all/20230607101827.8544-5-zev@bewilderbeest.net/

I already gave same comments there.

>>> +  nuvoton,wdt-timeout:
>>> +    description: |
>>> +      Watchdog Timer time configuration for NCT7363Y, as below
>>> +      0: 15 sec (default)
>>> +      1: 7.5 sec
>>> +      2: 3.75 sec
>>> +      3: 30 sec
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3]
>>> +    default: 0
>>
>> Nope, reference watchdog.yaml and use its properties. See other watchdog
>> bindings for examples.
> 
> NCT7363 has a built-in watchdog timer which is used for conditionally
> generating a system reset
> output (INT#) if the microcontroller or microprocessor stops to
> periodically send a pulse signal or
> interface communication access signal like SCL signal from SMBus interface.
> 
> We only consider "Watchdog Timer Configuration Register" enable bit
> and timeout setting.
> Should we still need to add struct watchdog_device to struct nct736x_data?

I do not see correlation between watchdog.yaml and some struct. I did
not write anything about driver, so I don't understand your comments.

Anyway, I don't like that we are duplicating entire effort and our
review. Please join existing discussions, threads and build on top of it.

Best regards,
Krzysztof

