Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F837AB3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjIVOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIVOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:42:51 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B61AD;
        Fri, 22 Sep 2023 07:42:45 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57359e85e9bso1098881eaf.2;
        Fri, 22 Sep 2023 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695393764; x=1695998564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nqMzhPbNr8RLZEXVHoQWk3F1U8K2ekWVPTnLuWZ6u0=;
        b=GXxiQ8tD86aENwV4iVOaGzeMO5LpjcJJginTUnH3gGJKd+bKMFuszBHwgflpzEQomW
         +mJn5a8t6IZb0uNXowf6lPh6R+t5cYv9gVu6j7dEKd1s7iTL3QLcllTwxJxMvN7EueFa
         BH1NqbBb1O0ghFWPjQaNa1HNxT5tr2lWr0ri/eX4c6ah2c35ayUmf2EbGZO5fE9uyWQK
         FJZw5/3ia4ttkOUrpYBpYWAewQoCFWTH+zwSdzlVjfqe8D7yz8I8+AZ7W/xLb5V3i4oA
         0kGUmFj/bnxXSS9oEpfwI1PahVPG6RzowhE/NqBsAr9igYNWQtc6icUNB/BqfowD+wKY
         c7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393764; x=1695998564;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nqMzhPbNr8RLZEXVHoQWk3F1U8K2ekWVPTnLuWZ6u0=;
        b=oBgyJqxRNVlRdC3l2sHZFd06kLGICTgf0FTSKLLECLFCpBfMyfks6YVCDbMOMT3bvX
         m7cwa7yIR/njZ3jXLdl0ZDda5zb2P4DZuaEpMNNkhRgwNCdoXZoxqd7gJ87wg7g6KOXc
         qjMZ3XUha8EUCr2n8UcBYstAciWw+A/gMyZqn9h0T5r8feBA7DaDjae0pkpxU/SCLo26
         FqMMo+amSPWNqpRy+EYaoZyOP9ZCvZy86W5+nMIuxHjRXoKEbsvWMZZllaWjmtnfGDvS
         nToqSMaxOMbWpSmzJAmEYkp7c5aG9NJ843VyoGHqvAZqNW8mqUBPVorJgfZTTP0xdllG
         2hMQ==
X-Gm-Message-State: AOJu0YwOB9KC2ot19p8ySEUUqCBqFfiwf7e/JgdZrIbkRD34K/GyqY38
        CG7Jkm/QTRbWxJFSrNh6AlI=
X-Google-Smtp-Source: AGHT+IErb4fP6iB04EKS9z5eo37yfXxKUQp6mTQIYz2oHpTlfaLWzbmrcgutHVeqXMhtd7KrJvHIwA==
X-Received: by 2002:a05:6870:4395:b0:1d1:425b:8026 with SMTP id r21-20020a056870439500b001d1425b8026mr9267161oah.26.1695393764236;
        Fri, 22 Sep 2023 07:42:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b28-20020a63715c000000b00578b40a4903sm573936pgn.22.2023.09.22.07.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 07:42:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ceea0b12-9165-a9f6-cbd1-b25c07c75efb@roeck-us.net>
Date:   Fri, 22 Sep 2023 07:42:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
 <20230915062926.2460502-3-Delphine_CC_Chiu@wiwynn.com>
 <20230915-quench-left-8fbc1ca3b1da@spud>
 <CAL_JsqKWRfT71k56uMUJtU_abzFuicW01OBo-iScYash4Jrd2w@mail.gmail.com>
 <TYZPR04MB58530C4CB0386DF02D29E216D6FFA@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <20230922-washday-primer-af8dcf1cde7d@spud>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: add MAX31790
In-Reply-To: <20230922-washday-primer-af8dcf1cde7d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 02:53, Conor Dooley wrote:
> On Fri, Sep 22, 2023 at 02:33:06AM +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>>>> On Fri, Sep 15, 2023 at 02:29:24PM +0800, Delphine CC Chiu wrote:
> 
>>>>> +  pwm-as-tach:
>>>>
>>>> I don't see any other users of this in-tree, so you'd need a vendor
>>>> prefix. That said, I'm once bitten, twice shy about fan related
>>>> properties in hwmon, so I would definitely like Rob to comment on this
>>>> whole binding.
>>>
>>> Please see this[1] and comment on it to ensure it meets your needs.
>>> Otherwise, omit any fan related properties for now.
>>>
>> This property could only be used in max31790 driver. Would it be ok if we add
>> vendor prefix like "maxim, pwm-as-tach"?
> 
> I think the answer to this is a pretty straightforward no. The goal is
> to create a set of common fan properties that works for multiple
> usecases, not create one specifically for each user...
> 

Another chip with configurable channel configuration is nct7802, where
individual channels can be configured as temperature or voltage sensor.
We are using sensor-type to select the mode in that driver. Maybe something
similar would make sense / be acceptable here.

>>>> +examples:
>>>> +  - |
>>>> +    i2c {
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +
>>>> +      pwm@20 {
>>>> +        compatible = "maxim,max31790";
>>>> +        reg = <0x20>;
>>>> +        pwm-as-tach = <2 5>;
>>>
>>> This would be <2>, <5>; no?
>>>
>> I refer to the other binding documents in hwmon and most of them were using
>> the format like <2 5> as an array.
> 
> Which also makes this moot, since it'll be going away.
> 
>>>> diff --git a/MAINTAINERS b/MAINTAINERS index
>>>> c8fdd0d03907..97e13b6bf51d 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1371,6 +1371,12 @@ F:
>>>        Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>>>>   F: Documentation/hwmon/max31760.rst
>>>>   F: drivers/hwmon/max31760.c
>>>>
>>>> +ANALOG DEVICES INC MAX31790 DRIVER
>>>> +M: Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
>>>> +S: Odd Fixes
>>>
>>> This is a pretty odd status for something you're newly adding.
>>> How come it's not going to be maintained?
>>>
>> We are not the authors of this driver but we want to add a feature to
>> config PWM as TACH that was descripted in the datasheet of MAX31790.
>> Should we set the status to maintained?
> 
> It's really up to you. I just found it curious & wanted to ask why it
> was that way.
> 

It is misleading because it downgrades the driver from "supported"
(like all other hwmon drivers) to "odd fixes".

Guenter

