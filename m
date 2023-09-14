Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D279FAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjINFlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjINFls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:41:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692DFB4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:41:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso898488e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694670102; x=1695274902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huUBd8tQVsMhRFKqU4ZhJpKNvIZIXJ92rzk44rhrTS8=;
        b=jRsb83ZcG5gOnDLu7hrkA5U20GflFqz2EJmVTv4XDKnUu2xoRL1vCcjE3zOvFUv4HG
         Q41updvaziX+ZD/hUpc3xYQ/5MtI/RPjU7iasxPSohQmJ7Z2jtkVWv5O6Bf1JbiQFWDU
         fX926tX3VgJ0qjY82pZu+WK/BeCpSfGlpW4Cr/viRWnCQCTobGEh0OVsgh2OTpo/hS0N
         Dy6O7CPsdc+OlwKYW6Z60supCxKp4hF6tk+7GaLlsZuoepjhupd72SoXB1mTAGfnsx1M
         7dRlp4OtucJZgrGqN8BwpyQJ14oD1pDZc4i0Y9rH9dqLmImPJit1OnABu6sfUXuCVVng
         ay3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670102; x=1695274902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huUBd8tQVsMhRFKqU4ZhJpKNvIZIXJ92rzk44rhrTS8=;
        b=DWv6aq1Z8zFFfQShgXvCN02bGn4x6bX1UEqsvCWWgPgwHIZng8Zj0136JbYB/6VW/i
         +Tt95/K+YcKJeG2pbttawhQizZ5E7RXt9Gr176Mn5oj0cVGiGIZv8DfNp7z4UJnAvQ18
         lorugFN3JWPXD28u50d4A+DQH1r7gGufs5jwRe/saKwaZ7gPlOIbMw7EoLkDjk1swX9Y
         8Rp3FDUgIMrdm8TSJCnchktU7UpJmm2jR7Zcc8kE7Ys6rjaOHaO/srBSlHjrICDO0tcq
         liGpiPwNcoULQ6DvEwK2Eboj88eQeCXAtW9alp8k+xdYhuUgoDI+ah+sfwksqTkAQEZS
         U0bw==
X-Gm-Message-State: AOJu0YzWZQXckboQVR4FTRkrghAikjqZE6ypcf8d12O6WXSG9KyCnubK
        CbTUzeaDCGCcfb0LhrfcmXFp2LEO7WaysZXu2TA=
X-Google-Smtp-Source: AGHT+IEUyqt8XXNqwYTXme8n7SieB1SWAc04i/9uNyoTn9HJVc61ES/WbZXXSGCxqZrBoy31xUYWnA==
X-Received: by 2002:a19:5e57:0:b0:4ff:7e1e:b4b4 with SMTP id z23-20020a195e57000000b004ff7e1eb4b4mr3961063lfi.39.1694670102547;
        Wed, 13 Sep 2023 22:41:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b1-20020aa7df81000000b0052c4dacf54csm435287edy.44.2023.09.13.22.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:41:41 -0700 (PDT)
Message-ID: <c05d0ae9-1711-867e-2595-d5e542d4fa18@linaro.org>
Date:   Thu, 14 Sep 2023 07:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the
 devicetree
To:     Guenter Roeck <linux@roeck-us.net>,
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <823b9820-9225-fc24-ff86-1056a1a43cc3@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 18:43, Guenter Roeck wrote:
> On 9/13/23 08:40, Krzysztof Kozlowski wrote:
>> On 13/09/2023 17:21, Daniel Matyas wrote:
>>
>> Subject: not much improved. I am sorry, but you are not adding new
>> properties to entire devicetree of entire world. You are actually not
>> adding anything to any devicetree, because these are bindings (which is
>> obvious, as said by prefix).
>>
>> You got comments on this.
>>
>>> These attributes are:
>>> 	- adi,comp-int - boolean property
>>> 	- adi,alrm-pol - can be 0, 1 (if not present, default value)
>>> 	- adi,flt-q - can be 1, 2, 4, 8 (if not present, default value)
>>> 	- adi,timeout-enable - boolean property
>>
>> Don't repeat what the code does. Explain why you are adding it, what is
>> the purpose.
>>
>>>
>>> These modify the corresponding bits in the configuration register.
>>>
>>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>>> ---
>>>   .../bindings/hwmon/adi,max31827.yaml          | 35 +++++++++++++++++++
>>>   1 file changed, 35 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>> index 2dc8b07b4d3b..6bde71bdb8dd 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>>> @@ -32,6 +32,37 @@ properties:
>>>         Must have values in the interval (1.6V; 3.6V) in order for the device to
>>>         function correctly.
>>>   
>>> +  adi,comp-int:
>>> +    description:
>>> +      If present interrupt mode is used. If not present comparator mode is used
>>> +      (default).
>>
>> Why this is a property of hardware?
>>
> 
> Because it affects the behavior of the interrupt signal and whatever
> it is connected to. For example, it could be connected to an interrupt
> controller (interupt mode), or it could be connected to a fan which is
> enabled while the signal is active (comparator mode).

That makes sense. Pardon my naive questions, I just could not figure out
use case out of the field description. Based on this very short
description itself, I could imagine sysfs entry.

> 
>>> +    type: boolean
>>> +
>>> +  adi,alrm-pol:
>>> +    description:
>>> +      Sets the alarms active state.
>>> +            - 0 = active low
>>> +            - 1 = active high
>>> +      For max31827 and max31828 the default alarm polarity is low. For max31829
>>> +      it is high.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1]
>>> +
>>> +  adi,flt-q:
>>> +    description:
>>> +      Select how many consecutive temperature faults must occur before
>>> +      overtemperature or undertemperature faults are indicated in the
>>> +      corresponding status bits.
>>> +      For max31827 default fault queue is 1. For max31828 and max31829 it is 4.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [1, 2, 4, 8]
>>> +
>>> +  adi,timeout-enable:
>>> +    description:
>>> +      Enables timeout. Bus timeout resets the I2C-compatible interface when SCL
>>> +      is low for more than 30ms (nominal).
>>
>> Why this is a property of hardware?
>>
> 
> Because it affects i2c bus operation.
> 
> I am not sure I understand what you are trying to say here.
> This is a much a "hardware" property as the i2c bus speed
> and many similar properties, and the need for it is system
> dependent (for example, a system with many devices on the
> i2c bus or with a less than perfect i2c controller may need
> it because the bus tends to get stuck).
> 
> Those are not properties where one would, at runtime,
> decide to enable bus timeout or the interrupt mode or
> the bus speed. Typically that kind of functionality
> has to be configured early when the system is started.
> If devicetree must not or no longer be used to describe the
> system to a point where it can be configured to get it
> to a working state, what is the suggested alternative ?

I could imagine enabling it always, unconditionally. I wanted to
understand why different boards with this chip will have it enabled or
disabled.

Best regards,
Krzysztof

