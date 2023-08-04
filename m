Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B214D7705A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjHDQKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHDQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:10:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69EB2;
        Fri,  4 Aug 2023 09:10:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2682b4ca7b7so1279819a91.3;
        Fri, 04 Aug 2023 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691165439; x=1691770239;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUioFZ7tXMJEvu9BOB44xCzuGpOwtxseq1YU/H9f2GY=;
        b=Bu8zWvC/pNAwG2ZDB65BogeFW6RHuCyK9yLNSZovbdS0DTP1e1VCDsQLqJSP6JUHWx
         rNwntmzjIRpxLV8HSBsD+lW9PaC98+9JJFSlT7q0ktD9FO8fYVJqmSuFp0uPifsDIgz6
         8wSkJtd1R5dtD19PKK4ibKld/tT71nfOKrguWrys3yG+2A9eApu5WFd1fdtH6R7tFJFV
         phK8+NiQ0g1mxxfnz4qzSctExwM8DjX7zDkT84afrFPRvWO7EAxxYVuGIgzXoXJStvLC
         RsedEKJb/wt1VNw5UcO/SLn3b3iATl0u0StR3b90KC9TLJplyiy8kUQu6LjViMXBgfAb
         N9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165439; x=1691770239;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUioFZ7tXMJEvu9BOB44xCzuGpOwtxseq1YU/H9f2GY=;
        b=dWycs8Bh2Ht+VDYHseJoR6l6s6y3F0M2BhwC1SGhYL5SARRpovBAxRPJBpQZLE5WFB
         UxEN6vbKgLugmXcoZz6bHWDMx7r8mjuhXdfyXKbq07EiKJdJJLqevz5LywZmxy3aj//o
         lmvVIDKTd4JnMouTnyMgNvwGm12Hzy4hxKaSJwZWINNc95qwp4CWpLxdUxwgRFeAZ4Bj
         BRbo9lmqW875n6uG2WOMmWYoO4pBCTctCSt6FcsQs9NRCU/ePnQ2L1iwRZXmKmtiWaSs
         VnQyTa27j3CJsVdafhK1Wbp3bGKxVNZHBUuuQnIDWg1ILFqdCdzWS2YvB2SN6fXtUeec
         lgIQ==
X-Gm-Message-State: AOJu0YwHyZYsnrWWWTMrTN4s9OiYC+pNcUbUtlvkxE6EtQtZrGez/PMb
        6JbKx8JEj7J1MF8GM/LnzTw=
X-Google-Smtp-Source: AGHT+IEstIfZLC3v30nXj54vSiBMNfdSyHE8UD/YLEqRYAvJE1jjq0xd2rI5iSfBKY+yqSRALloHNg==
X-Received: by 2002:a17:90a:3004:b0:263:72c5:9ac6 with SMTP id g4-20020a17090a300400b0026372c59ac6mr1768740pjb.11.1691165438701;
        Fri, 04 Aug 2023 09:10:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001bb3beb2bc6sm71067plx.65.2023.08.04.09.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:10:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3f947ad6-eed6-59ff-e4e6-8b21d90eb803@roeck-us.net>
Date:   Fri, 4 Aug 2023 09:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MAX6639
In-Reply-To: <20230804-tamper-numbness-0117bb53a921@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 08:48, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 04:43:59PM +0200, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> Add binding documentation for Maxim MAX6639 fan-speed controller.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>> Changes in V3:
>> - Update title
>> - Add pulses-per-revolution, supplies & interrupts
>> Changes in V2:
>> - Update subject
>> - Drop blank lines
>> ---
>>   .../bindings/hwmon/maxim,max6639.yaml         | 60 +++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> new file mode 100644
>> index 000000000000..b3292061ca58
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX6639 Fan Controller
>> +
>> +maintainers:
>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>> +
>> +description: |
>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>> +  fan-speed controller.  It monitors its own temperature and one external
>> +  diode-connected transistor or the temperatures of two external diode-connected
>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
> 
>> +  fan-supply:
>> +    description: Phandle to the regulator that provides power to the fan.
> 
>> +  pulses-per-revolution:
>> +    description:
>> +      Define the number of pulses per fan revolution for each tachometer
>> +      input as an integer.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 3, 4]
>> +    default: 2
> 
> Apologies if I am digging up old wounds here, since there was quite a
> bit of back and forth on the last version, but these two newly added
> properties look to be common with the "pwm-fan" and with
> "adi,axi-fan-control". At what point should these live in a common
> schema instead?
> 
> Otherwise, this looks okay to me, although I'll leave things to
> Krzysztof since he had a lot to say about the previous version.
> 

Rob has said that he won't accept any fan controller bindings without a generic
schema. At the same time he has said that he expects properties such as the
number of pulses per revolution to be attached to a 'fan' description, and he
wants pwm related properties of fan controllers to be modeled as pwm controllers.
And now we have a notion of a regulator providing power to the fan (which again
would be the fan controller, at least in cases where the fan controller
provides direct voltage to the fan). On top of that, this fan-supply property
should presumably, again, be part of a fan description and not be part of the
controller description. I don't think anyone knows how to make this all work
(I for sure don't), so it is very unlikely we'll see a generic fan controller
schema anytime soon.

Given that neither fan-supply nor pulses-per-revolution is implemented in the
driver, and given that I am not aware of any fans which would have a value for
pulses-per-revolution other than 2, my personal suggestion would be to add the
chip to trivial devices and be done with it for the time being.

Guenter

