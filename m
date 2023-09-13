Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19D79EF29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjIMQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjIMQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:45:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FCF2682;
        Wed, 13 Sep 2023 09:43:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1e128135aso58935085ad.3;
        Wed, 13 Sep 2023 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694623402; x=1695228202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVgnaOWsMuI4Gn/SXs85X2e0CNMfL8OIn3v82IsRbno=;
        b=O2fU9FpBaHAFJAX+VITgPyNBHPKXVEaTzN8I4zaCGpUxo5/kpI4LqgYHbB5SZy7PuU
         v4u8yzhRzHKaqKJiqsEmJhdubPT4e4ZCDY2e+J4qQ/XAZ1BZ5r0wXQ4U48bwKQgq5L9H
         C8P70+eUf9fxfvNNg0kjPcH73IZFiAiI5wLoBiR8ILlESwhjyjnH1M48MCCckOUdeBQG
         KhOp08eZYQdRSPceL0L5YD2iWUZB97lfihe24HrprEO8Y+GUr2czGEXDmoiEB3HYegA8
         6lOleRfj1UOvz5MIATLFNJpG7hdj/kVR7quxld2vSV7MZw/Gh6kOzh2p5TWeQonSxFy2
         QoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623402; x=1695228202;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVgnaOWsMuI4Gn/SXs85X2e0CNMfL8OIn3v82IsRbno=;
        b=I5fH8H7XkXi6M4me7Y65lPtcPFCzl6spde++S59db/JrWtQ7dBNMF+tvZoAsbfxSGC
         aQe+SJqwpq2Me5yQ1Ho6xCj5hukzPUo0a31jCzwuOFHnrjgus1SSEoRr3a9iU8su1Ruv
         TDypOkflXvQ8c63aNY2w1ZuIbgKSt4XVOfkSWX2851+3/li7pDfNZwKKsP2a0c6N4Ysf
         mLnTeFAc33E2k9BzEZzloONGdpuXczBs3/lx9WG4B9zG8IAFd/FIuJCGRGk8lpJcFT+U
         mm6ueOfo/74wr0480+cJY1OQ0iUJcohAPWaVz3afTLtd0GBM2x9pJn4CKW6xItOJY9vU
         ZNhw==
X-Gm-Message-State: AOJu0Yycg8FZ0afLXynumPxAf/kFG5QNgidTKQ/5ZNTT/m5TPb+rneBQ
        Jp5LazdzMpZlo78bdZ8uqvtclZt0igg=
X-Google-Smtp-Source: AGHT+IESHKzQ+zFrLqODyTIrVOnHrIwl/UkSo4Sjmh5JoJQkTIOZ69KakqmfgF++348R4TDEK5zJZQ==
X-Received: by 2002:a17:902:ecc5:b0:1bc:2c79:c6b6 with SMTP id a5-20020a170902ecc500b001bc2c79c6b6mr3820569plh.28.1694623402117;
        Wed, 13 Sep 2023 09:43:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iw7-20020a170903044700b001c3a7fbf96fsm7362748plb.216.2023.09.13.09.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:43:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <823b9820-9225-fc24-ff86-1056a1a43cc3@roeck-us.net>
Date:   Wed, 13 Sep 2023 09:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the
 devicetree
In-Reply-To: <177ef05b-0cca-be25-afad-ac518d9f6473@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 08:40, Krzysztof Kozlowski wrote:
> On 13/09/2023 17:21, Daniel Matyas wrote:
> 
> Subject: not much improved. I am sorry, but you are not adding new
> properties to entire devicetree of entire world. You are actually not
> adding anything to any devicetree, because these are bindings (which is
> obvious, as said by prefix).
> 
> You got comments on this.
> 
>> These attributes are:
>> 	- adi,comp-int - boolean property
>> 	- adi,alrm-pol - can be 0, 1 (if not present, default value)
>> 	- adi,flt-q - can be 1, 2, 4, 8 (if not present, default value)
>> 	- adi,timeout-enable - boolean property
> 
> Don't repeat what the code does. Explain why you are adding it, what is
> the purpose.
> 
>>
>> These modify the corresponding bits in the configuration register.
>>
>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>> ---
>>   .../bindings/hwmon/adi,max31827.yaml          | 35 +++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>> index 2dc8b07b4d3b..6bde71bdb8dd 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>> @@ -32,6 +32,37 @@ properties:
>>         Must have values in the interval (1.6V; 3.6V) in order for the device to
>>         function correctly.
>>   
>> +  adi,comp-int:
>> +    description:
>> +      If present interrupt mode is used. If not present comparator mode is used
>> +      (default).
> 
> Why this is a property of hardware?
> 

Because it affects the behavior of the interrupt signal and whatever
it is connected to. For example, it could be connected to an interrupt
controller (interupt mode), or it could be connected to a fan which is
enabled while the signal is active (comparator mode).

>> +    type: boolean
>> +
>> +  adi,alrm-pol:
>> +    description:
>> +      Sets the alarms active state.
>> +            - 0 = active low
>> +            - 1 = active high
>> +      For max31827 and max31828 the default alarm polarity is low. For max31829
>> +      it is high.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +
>> +  adi,flt-q:
>> +    description:
>> +      Select how many consecutive temperature faults must occur before
>> +      overtemperature or undertemperature faults are indicated in the
>> +      corresponding status bits.
>> +      For max31827 default fault queue is 1. For max31828 and max31829 it is 4.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 4, 8]
>> +
>> +  adi,timeout-enable:
>> +    description:
>> +      Enables timeout. Bus timeout resets the I2C-compatible interface when SCL
>> +      is low for more than 30ms (nominal).
> 
> Why this is a property of hardware?
> 

Because it affects i2c bus operation.

I am not sure I understand what you are trying to say here.
This is a much a "hardware" property as the i2c bus speed
and many similar properties, and the need for it is system
dependent (for example, a system with many devices on the
i2c bus or with a less than perfect i2c controller may need
it because the bus tends to get stuck).

Those are not properties where one would, at runtime,
decide to enable bus timeout or the interrupt mode or
the bus speed. Typically that kind of functionality
has to be configured early when the system is started.
If devicetree must not or no longer be used to describe the
system to a point where it can be configured to get it
to a working state, what is the suggested alternative ?

Guenter

