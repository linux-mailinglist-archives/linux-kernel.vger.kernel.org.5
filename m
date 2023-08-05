Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE577121F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHEU00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEU0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:26:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870D13E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 13:26:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c4923195dso453774566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691267181; x=1691871981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAz255BT1WAd5rdSTPS0g8lSyWT42ZSsNJRJpO6M4DQ=;
        b=v5XYHEGfJJGxE2sv+IcdbZf7UDfptunfq2jK3aS6gIxAf/NdA8csOgV650Nck4uF0Z
         36nun/djtlUzrFtKKKCYdBQBu8hresLkWuMVFeFRWxwde5lnIndWnhEKQPxlsOR9LvRj
         n0DlPvJVyQFhBxyYf+uwceAdQQbFB7/iY8v9nJAyikMPw7LT5pCezXS8HHb/ElzakH/s
         /oMTyntb0ELMn0/7WE7YOUrUmicHkfDghpFJQOvfSyyuLW6ABR/UsS0l3R/IeqBvJOlX
         J0wMl5jfulcsR4oCZ3LZb13SOW96g1pEo87j2ty7a67S4OqvxwwaVaFC1x2e+T8lc9p9
         UZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691267181; x=1691871981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAz255BT1WAd5rdSTPS0g8lSyWT42ZSsNJRJpO6M4DQ=;
        b=U/ii9WEXH7+PcxrXUwmag6JjCQAJUUrGjKQmPI5o6md0A397APQ4lzZxiYpVkAi0bY
         4au5eGLv/FvO2fF7w5GrpFHRe9dqBhzNMTI7vZA863DCjDU5XLDdhVjrElNdxoJ7XjPa
         QsZ7E2EkXZzA44zOqL+thyUeo3JzAezOTG2ayoH1vufAtoG6F4wtMMYN8R5GB+uYEGxz
         byZ0SWd4ZN3lp5SsHQ/8laUffauUQUhLb9d6lilka8QIUTiijFz7q7RNmrxkmDLGSjdW
         IkQ6/FoILOuy12t0tscTTmzlsYHWi51P32ZpnoW1sLAjniSqeJ0jbTS//Kx18dzwbcSm
         cmFg==
X-Gm-Message-State: AOJu0YwXVvbbNY+N9XQZ7CO/+U57knHndik/pZpAIt6HEYJNjcM8IWa0
        vIZ3zSLNwM50wffHV37Dfeu/Tw==
X-Google-Smtp-Source: AGHT+IFbhS/cauLdtL9VOjxZ7i1FT0GuhqIHFL+9PJhLRc33p48fvYVc9wjgRx6Cgg0kA80miKBrFQ==
X-Received: by 2002:a17:906:7388:b0:99b:d2a9:99f5 with SMTP id f8-20020a170906738800b0099bd2a999f5mr4863494ejl.6.1691267181362;
        Sat, 05 Aug 2023 13:26:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906071000b00992d122af63sm3076421ejb.89.2023.08.05.13.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 13:26:21 -0700 (PDT)
Message-ID: <7d7b53e8-fe48-f87c-24b2-ccf64e29eeb2@linaro.org>
Date:   Sat, 5 Aug 2023 22:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MAX6639
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Conor Dooley <conor@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
 <20230804-tamper-numbness-0117bb53a921@spud>
 <3f947ad6-eed6-59ff-e4e6-8b21d90eb803@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3f947ad6-eed6-59ff-e4e6-8b21d90eb803@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 18:10, Guenter Roeck wrote:
> On 8/4/23 08:48, Conor Dooley wrote:
>> On Thu, Aug 03, 2023 at 04:43:59PM +0200, Naresh Solanki wrote:
>>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>>
>>> Add binding documentation for Maxim MAX6639 fan-speed controller.
>>>
>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>> Changes in V3:
>>> - Update title
>>> - Add pulses-per-revolution, supplies & interrupts
>>> Changes in V2:
>>> - Update subject
>>> - Drop blank lines
>>> ---
>>>   .../bindings/hwmon/maxim,max6639.yaml         | 60 +++++++++++++++++++
>>>   1 file changed, 60 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> new file mode 100644
>>> index 000000000000..b3292061ca58
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> @@ -0,0 +1,60 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Maxim MAX6639 Fan Controller
>>> +
>>> +maintainers:
>>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>>> +
>>> +description: |
>>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>>> +  fan-speed controller.  It monitors its own temperature and one external
>>> +  diode-connected transistor or the temperatures of two external diode-connected
>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>
>>> +  fan-supply:
>>> +    description: Phandle to the regulator that provides power to the fan.
>>
>>> +  pulses-per-revolution:
>>> +    description:
>>> +      Define the number of pulses per fan revolution for each tachometer
>>> +      input as an integer.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [1, 2, 3, 4]
>>> +    default: 2
>>
>> Apologies if I am digging up old wounds here, since there was quite a
>> bit of back and forth on the last version, but these two newly added
>> properties look to be common with the "pwm-fan" and with
>> "adi,axi-fan-control". At what point should these live in a common
>> schema instead?
>>
>> Otherwise, this looks okay to me, although I'll leave things to
>> Krzysztof since he had a lot to say about the previous version.
>>
> 
> Rob has said that he won't accept any fan controller bindings without a generic
> schema. At the same time he has said that he expects properties such as the
> number of pulses per revolution to be attached to a 'fan' description, and he
> wants pwm related properties of fan controllers to be modeled as pwm controllers.
> And now we have a notion of a regulator providing power to the fan (which again
> would be the fan controller, at least in cases where the fan controller
> provides direct voltage to the fan). On top of that, this fan-supply property
> should presumably, again, be part of a fan description and not be part of the
> controller description. I don't think anyone knows how to make this all work
> (I for sure don't), so it is very unlikely we'll see a generic fan controller
> schema anytime soon.
> 
> Given that neither fan-supply nor pulses-per-revolution is implemented in the
> driver, and given that I am not aware of any fans which would have a value for
> pulses-per-revolution other than 2, my personal suggestion would be to add the
> chip to trivial devices and be done with it for the time being.

Yeah, this also would work.

Best regards,
Krzysztof

