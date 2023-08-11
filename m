Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0E778461
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjHJXyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHJXyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:54:20 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E02D44;
        Thu, 10 Aug 2023 16:54:19 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3491a8e6fd1so5461345ab.3;
        Thu, 10 Aug 2023 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691711658; x=1692316458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z+auyRstamwwRbqcQmL9Mx+x5Q8z46Bc3zdKRkalKs4=;
        b=QG1po71M2RMyYGb0sWLxsxTqCfVouKqlilON82HZsURmjrAzPjCZ+lcmb+WZ1qyILl
         tcwsk+XaZ7/3TrgRLAXXtfOkZURH8Kf/2/eYFkw5J/feOI/zMPLYVU4/+iX8mS4V8T8C
         LsL0SfMiRXRRFsPDPDrpGp/I6EbP77U8rBQlETheNZiXDpCtzGpZ5cH6/0HeXFnD1Hac
         raHcb7BNM5kP0t3c7AdqcSqJzRkeM+QIGSG1AwiVtX0kxklQ9ej4PXaqcmlAKrBs+9e+
         5EGD7AubXQd5c0th0Cke5JGwaIA4wSecvhfpEq1bdJxpm9MFlE1c2ZepjRQm09oKLTKJ
         uxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711659; x=1692316459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+auyRstamwwRbqcQmL9Mx+x5Q8z46Bc3zdKRkalKs4=;
        b=Moo4AFf5xevWDXC/H8vlL79P1UsijwQuOOucessM6UfnoGohDvZHNjg5r/A8yZX330
         O1Pyhu1IUum4USZ3hL4N3dRm5j0Kjznv2MY5DCYi4WgVjpqU9Gn1ho3Dcrpb/F+oYvKu
         GE3vq14Kyd/sjYXANPTvmUleUIc7XRPKvwlCZfI/TNz4KWqOFJeTvbSV+LZByOKRSI8u
         xDQ+s29yxnQHpNuEtA6PmEENYY3qEqSQC4VRiSVI7GSv5qSNixG/h+STi4Z1JBBzo2AP
         SaeEWbiWFQaN0Sg7cHni6atSyKhzu8fu9P+nUyVBUlQTjOenkdW+d6+/N5HAZWuiee7v
         AdRg==
X-Gm-Message-State: AOJu0YwwPCMXc58gRHPLoAfqyUhNqtljbDQv2oqPQqJK6JlU/MEuapRU
        1rHHJ/C4A2tEQ4oH3kesod8=
X-Google-Smtp-Source: AGHT+IFxIJffgP5h+4z4eo1llXNE8TsbS9rO2ir0n3kdk8JJJ5DiCDBdaI/5ja5PtNzS1KbqnI8DYA==
X-Received: by 2002:a05:6e02:20e7:b0:348:8576:15b5 with SMTP id q7-20020a056e0220e700b00348857615b5mr324444ilv.3.1691711658634;
        Thu, 10 Aug 2023 16:54:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u21-20020a02aa95000000b0042b28813816sm700517jai.14.2023.08.10.16.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 16:54:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9dfe8bbb-54df-7746-3267-5f7ea8893bef@roeck-us.net>
Date:   Thu, 10 Aug 2023 16:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MAX6639
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Jean Delvare <jdelvare@suse.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
 <20230804-tamper-numbness-0117bb53a921@spud>
 <3f947ad6-eed6-59ff-e4e6-8b21d90eb803@roeck-us.net>
 <20230810231142.GA1506309-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230810231142.GA1506309-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 16:11, Rob Herring wrote:
> On Fri, Aug 04, 2023 at 09:10:37AM -0700, Guenter Roeck wrote:
>> On 8/4/23 08:48, Conor Dooley wrote:
>>> On Thu, Aug 03, 2023 at 04:43:59PM +0200, Naresh Solanki wrote:
>>>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>
>>>> Add binding documentation for Maxim MAX6639 fan-speed controller.
>>>>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>> Changes in V3:
>>>> - Update title
>>>> - Add pulses-per-revolution, supplies & interrupts
>>>> Changes in V2:
>>>> - Update subject
>>>> - Drop blank lines
>>>> ---
>>>>    .../bindings/hwmon/maxim,max6639.yaml         | 60 +++++++++++++++++++
>>>>    1 file changed, 60 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> new file mode 100644
>>>> index 000000000000..b3292061ca58
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> @@ -0,0 +1,60 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Maxim MAX6639 Fan Controller
>>>> +
>>>> +maintainers:
>>>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> +
>>>> +description: |
>>>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>>>> +  fan-speed controller.  It monitors its own temperature and one external
>>>> +  diode-connected transistor or the temperatures of two external diode-connected
>>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>>
>>>> +  fan-supply:
>>>> +    description: Phandle to the regulator that provides power to the fan.
>>>
>>>> +  pulses-per-revolution:
>>>> +    description:
>>>> +      Define the number of pulses per fan revolution for each tachometer
>>>> +      input as an integer.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [1, 2, 3, 4]
>>>> +    default: 2
>>>
>>> Apologies if I am digging up old wounds here, since there was quite a
>>> bit of back and forth on the last version, but these two newly added
>>> properties look to be common with the "pwm-fan" and with
>>> "adi,axi-fan-control". At what point should these live in a common
>>> schema instead?
>>>
>>> Otherwise, this looks okay to me, although I'll leave things to
>>> Krzysztof since he had a lot to say about the previous version.
>>>
>>
>> Rob has said that he won't accept any fan controller bindings without a generic
>> schema. At the same time he has said that he expects properties such as the
>> number of pulses per revolution to be attached to a 'fan' description, and he
>> wants pwm related properties of fan controllers to be modeled as pwm controllers.
>> And now we have a notion of a regulator providing power to the fan (which again
>> would be the fan controller, at least in cases where the fan controller
>> provides direct voltage to the fan). On top of that, this fan-supply property
>> should presumably, again, be part of a fan description and not be part of the
>> controller description. I don't think anyone knows how to make this all work
>> (I for sure don't), so it is very unlikely we'll see a generic fan controller
>> schema anytime soon.
> 
> I thought what was done earlier in this series was somewhat close. And
> there are some bindings that already look pretty close to what a common
> binding should. But it seems no one wants to worry about more than their
> 1 device.
> 
> In case it's not clear, as-is, this binding is a NAK for me.
> 

Ok, I'll drop it.

Guenter

>> Given that neither fan-supply nor pulses-per-revolution is implemented in the
>> driver, and given that I am not aware of any fans which would have a value for
>> pulses-per-revolution other than 2, my personal suggestion would be to add the
>> chip to trivial devices and be done with it for the time being.
> 
> I'm fine with that too. Just keep kicking that can...
> 
> Rob

