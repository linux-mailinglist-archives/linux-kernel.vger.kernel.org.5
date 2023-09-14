Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8014279FB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjINGHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:07:43 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A3E3;
        Wed, 13 Sep 2023 23:07:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bf04263dc8so343935a34.3;
        Wed, 13 Sep 2023 23:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694671659; x=1695276459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Gku+wBib/CGo0C7ZubXdhdqL37D/jrXhwRwbctlzppw=;
        b=D9YCtyqJaWwonIlbTg2sDPHbySix1425AKiTY4/f4rUiQuy59SBiL70/KFXgYq3Qpz
         3fJ9ySQ4uWAsFTzEfNwHuBXIUDJ0xjZ79RYjXZ+wUsUQSv4+f+Z+//n/YtEiNLUdOyS/
         /LzfuoHAQTuk1Usp11tfRsBWDErfYpe8CK6O8sCzyhmgRm/4XCPPJA4L5ZwtCJkyu98K
         MqvPHeESST/jqyqsK9dzrG2JhlB+NbSmbNDZ3pha4fL2fN6qkCb7aseaDQ0aEHZSVL/9
         yPBKBbWGE0RPzhrsmZkqEAWbbQc27ZYzFyqF27HXLAwBjFeENVtCiE+28+AOLGM6KGEK
         MfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694671659; x=1695276459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gku+wBib/CGo0C7ZubXdhdqL37D/jrXhwRwbctlzppw=;
        b=J8Fgj6PSmQXeQZf2EFnvTAL6TuBmFWyFKK+V8UiLCZYZH1PYhZzvHccILGqcy4AOHj
         Ct3BZoBGzSIwfP1Iby4Es9a2VZHl3IS83i8gst7MLQNoPivVyLqirObyiMW6deVQG6I/
         IzrGIsXmXaz6YkjFSnH7yphK8vQa+OGF+OUg0ErZrKXXq3qR62037gLjHAgy+TjsPhSl
         aOK2VIAqaa1NMo7JHCLTxckGG6OT/v5A4Wsa6q0K8/s5hhO+YbPN7I+exXu6LPV6H4BB
         J6/j8QCQZ8AhyJ+hxKP9nnVpL5UrsRZRAVT9LRP4sVFgitCwP6r8WtWPwyaoD621R9sk
         D7vQ==
X-Gm-Message-State: AOJu0YxPNuW4Of1Mi5wLxfZoXo9pSOslQeNfWzjWiQO/G45+V4QZhGiq
        W5I2L/6/92lXR4HK5BM6guzFe457LfE=
X-Google-Smtp-Source: AGHT+IG5gCNqXEgX7N1IDqPGoZOxmQCsj/HAtAHyh1WRx3672wz1s+mLn7BSM7jQofrLPYIRtRGfLA==
X-Received: by 2002:a05:6358:719:b0:139:cdc2:e618 with SMTP id e25-20020a056358071900b00139cdc2e618mr4177975rwj.8.1694671658832;
        Wed, 13 Sep 2023 23:07:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16-20020a656650000000b00565dd935938sm395039pgv.85.2023.09.13.23.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:07:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19c6413c-8837-d4cf-a692-b2846ea47a2c@roeck-us.net>
Date:   Wed, 13 Sep 2023 23:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the
 devicetree
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230913152135.457892-1-daniel.matyas@analog.com>
 <20230913152135.457892-3-daniel.matyas@analog.com>
 <177ef05b-0cca-be25-afad-ac518d9f6473@linaro.org>
 <823b9820-9225-fc24-ff86-1056a1a43cc3@roeck-us.net>
 <c05d0ae9-1711-867e-2595-d5e542d4fa18@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c05d0ae9-1711-867e-2595-d5e542d4fa18@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 22:41, Krzysztof Kozlowski wrote:
> On 13/09/2023 18:43, Guenter Roeck wrote:
>> On 9/13/23 08:40, Krzysztof Kozlowski wrote:
>>> On 13/09/2023 17:21, Daniel Matyas wrote:
>>>
>>> Subject: not much improved. I am sorry, but you are not adding new
>>> properties to entire devicetree of entire world. You are actually not
>>> adding anything to any devicetree, because these are bindings (which is
>>> obvious, as said by prefix).
>>>
>>> You got comments on this.
>>>
>>>> These attributes are:
>>>> 	- adi,comp-int - boolean property
>>>> 	- adi,alrm-pol - can be 0, 1 (if not present, default value)
>>>> 	- adi,flt-q - can be 1, 2, 4, 8 (if not present, default value)
>>>> 	- adi,timeout-enable - boolean property
>>>
>>> Don't repeat what the code does. Explain why you are adding it, what is
>>> the purpose.
>>>
>>>>
>>>> These modify the corresponding bits in the configuration register.
>>>>
>>>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>>>> ---
>>>>    .../bindings/hwmon/adi,max31827.yaml          | 35 +++++++++++++++++++
>>>>    1 file changed, 35 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> index 2dc8b07b4d3b..6bde71bdb8dd 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>>> @@ -32,6 +32,37 @@ properties:
>>>>          Must have values in the interval (1.6V; 3.6V) in order for the device to
>>>>          function correctly.
>>>>    
>>>> +  adi,comp-int:
>>>> +    description:
>>>> +      If present interrupt mode is used. If not present comparator mode is used
>>>> +      (default).
>>>
>>> Why this is a property of hardware?
>>>
>>
>> Because it affects the behavior of the interrupt signal and whatever
>> it is connected to. For example, it could be connected to an interrupt
>> controller (interupt mode), or it could be connected to a fan which is
>> enabled while the signal is active (comparator mode).
> 
> That makes sense. Pardon my naive questions, I just could not figure out
> use case out of the field description. Based on this very short
> description itself, I could imagine sysfs entry.
> 
>>
>>>> +    type: boolean
>>>> +
>>>> +  adi,alrm-pol:
>>>> +    description:
>>>> +      Sets the alarms active state.
>>>> +            - 0 = active low
>>>> +            - 1 = active high
>>>> +      For max31827 and max31828 the default alarm polarity is low. For max31829
>>>> +      it is high.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [0, 1]
>>>> +
>>>> +  adi,flt-q:
>>>> +    description:
>>>> +      Select how many consecutive temperature faults must occur before
>>>> +      overtemperature or undertemperature faults are indicated in the
>>>> +      corresponding status bits.
>>>> +      For max31827 default fault queue is 1. For max31828 and max31829 it is 4.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [1, 2, 4, 8]
>>>> +
>>>> +  adi,timeout-enable:
>>>> +    description:
>>>> +      Enables timeout. Bus timeout resets the I2C-compatible interface when SCL
>>>> +      is low for more than 30ms (nominal).
>>>
>>> Why this is a property of hardware?
>>>
>>
>> Because it affects i2c bus operation.
>>
>> I am not sure I understand what you are trying to say here.
>> This is a much a "hardware" property as the i2c bus speed
>> and many similar properties, and the need for it is system
>> dependent (for example, a system with many devices on the
>> i2c bus or with a less than perfect i2c controller may need
>> it because the bus tends to get stuck).
>>
>> Those are not properties where one would, at runtime,
>> decide to enable bus timeout or the interrupt mode or
>> the bus speed. Typically that kind of functionality
>> has to be configured early when the system is started.
>> If devicetree must not or no longer be used to describe the
>> system to a point where it can be configured to get it
>> to a working state, what is the suggested alternative ?
> 
> I could imagine enabling it always, unconditionally. I wanted to
> understand why different boards with this chip will have it enabled or
> disabled.
> 

Some boards may need a larger timeout, for example if there is
a chip on the same bus which supports clock stretching.

Guenter

