Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939D7A1670
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjIOGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjIOGvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:51:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8312707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:51:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401da71b83cso20348035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694760660; x=1695365460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+yPchd1OF14YEx7hFDIQf6gB7Zd0Tpalu5rQeIxJmg=;
        b=p1W+rftkN7pyqeh6UUjd26aMZUgtFNHsxZemI8zQkJq+1heReN9LHUbhAXooHRyNfO
         yy9ndz0Nv2kJdKOxOyepZkXu6RA08LIFNba7eeCUyNitDJVdkj7en/49ufdAR8ooF2hP
         G9qGyUwl1wtXc6yi4cmdKTUwZZLuHGa9YK865q06eP2AaiFf4sumNDchDZsywatfjeIH
         P1V9bM9lF8rUQifoVuX83vpPnyX0Q/8wmUsKHDxAv/7W5Nqxp2RTbzhc+kDW6wM9SOga
         flEzW/VES0aah+9b2JVc6Cv/hx+JrlY5rd0vV8K48OvCmoy3KacQxM0wzwv8qTs24vob
         dg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760660; x=1695365460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+yPchd1OF14YEx7hFDIQf6gB7Zd0Tpalu5rQeIxJmg=;
        b=CFiDEmScd4Pxe0/NuW3KQ194hrSgoQPksOcqIKqVBm+XVeUwQNz9DYYK7eaXMvdKdL
         Te/oTsJUE8FM3VV1RkYwMDfh9NOQxcw8LoNjkNupqDirbbQnhYEZ2KeYjd9wtLv30Ljo
         1f3mqm3FH5AeRulRIcJxRmBFzRyH1xs24IeQhcKmWl0xB80HaJUdaM8YnnW0ybQeYoL1
         UJhE2v5HDl+fvfOiu9Q6BUWlu5LkDuVxN2dnV7YzpZUkJ89pfoWV1KvDi9zwbo7t8Ggf
         7alQB/u0m73w3mIB3lG/cnfquDHsdLUXwkd9FmD80HxoIFLZioXuE3C4+brdRR1MiI8Q
         17AA==
X-Gm-Message-State: AOJu0YyXMW2KK45s6AxLEYnZxcmAkCalSz9yabO61Udg6nUzCErJZAd+
        NUVhSv4z7zvRnYVgqNWMv1KnNg==
X-Google-Smtp-Source: AGHT+IH/8g+avoYqVMdv6S+pJjql4rz2e+Urfb+s7H/AE/YkelrHE8ZK2/YVDITmpvOiEWInE9tw1Q==
X-Received: by 2002:a05:600c:ac8:b0:402:f54d:745 with SMTP id c8-20020a05600c0ac800b00402f54d0745mr778159wmr.17.1694760660045;
        Thu, 14 Sep 2023 23:51:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b0031773a8e5c4sm3559298wrv.37.2023.09.14.23.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 23:50:59 -0700 (PDT)
Message-ID: <6438f3ad-23ff-0392-e549-d64ef499d739@linaro.org>
Date:   Fri, 15 Sep 2023 08:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] dt-bindings: serial: document esp32s3-acm bindings
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-4-jcmvbkbc@gmail.com>
 <196fb9ac-53b7-51a6-6ce4-9f980215fde4@linaro.org>
 <CAMo8Bf+u3hkk8zW6EQUtQcAC5t-hUJ5+HoE8JDskBj4KyFK7xA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMo8Bf+u3hkk8zW6EQUtQcAC5t-hUJ5+HoE8JDskBj4KyFK7xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 22:47, Max Filippov wrote:
> On Wed, Sep 13, 2023 at 10:57 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/09/2023 23:14, Max Filippov wrote:
>>> Add documentation for the ESP32S3 ACM controller.
>>
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
> 
> Ok.
> 
>>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>>> ---
>>>  .../bindings/serial/esp,esp32-acm.yaml        | 40 +++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
>>> new file mode 100644
>>> index 000000000000..dafbae38aa64
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/serial/esp,esp32-acm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ESP32S3 ACM controller
>>> +
>>> +maintainers:
>>> +  - Max Filippov <jcmvbkbc@gmail.com>
>>> +
>>> +description: |
>>
>> Do not need '|' unless you need to preserve formatting.
> 
> Ok.
> 
>>> +  ESP32S3 ACM controller is a communication device found in the ESP32S3
>>
>> What is "ACM"?
> 
> It's an 'Abstract Control Model' as in USB CDC-ACM: 'Communication Device Class
> - Abstract Control Model'.
> 
>> Why is this in serial? Only serial controllers are in serial.
> 
> Because it's a serial communication device. The SoC TRM calls this peripheral
> 'USB Serial', but the USB part is fixed and is not controllable on the SoC side.
> When you plug it into a host USB socket you get a serial port called ttyACM on
> the host.
> 
>> The description is very vague, way too vague.
> 
> Is the following better?
> 
>   Fixed function USB CDC-ACM device controller of the Espressif ESP32S3 SoC.

Yes.

> 
>>> +  SoC that is connected to one of its USB controllers.
>>
>> Same comments as previous patch.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: esp,esp32s3-acm
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    acm@60038000 {

So this must be named "serial" now. ACM describes how this is interfaces
to the SoC, right? Otherwise it would not be in "serial" directory and
you would not be able to put serial devices as children.


>>> +            compatible = "esp,esp32s3-acm";
>>
>> Use 4 spaces for example indentation.
> 
> Ok.
> 
>>> +            reg = <0x60038000 0x1000>;
>>> +            interrupts = <96 3 0>;
>>
>> Same comments as previous patch.
> 
> These are not IRQ flags. In any case the contents of the IRQ
> specification cells is not relevant here, right?

Yes, if 0 is not an IRQ flag :)
> 

Best regards,
Krzysztof

