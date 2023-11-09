Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859637E6683
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjKIJUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:20:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8741FFB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:20:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d2c54482fbso98917366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699521608; x=1700126408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vyFZgshh+dS7jGWpFlg17tBqzL9luaMWJZKdCdlEUk=;
        b=uJOOgZbf/DylYPsx4oW5m9cxGNG8FhwM1j4l8INkKVRgiU/vXo+LR7NWO1Hjs4kqhm
         qz3SGWTuywudxMd9DvF7NDiTRmz/wff7Fk9aYH3YNJWdM5DL5bOh+Z/bABg4BnfVggc/
         Qz/LanwTgyew27wrrKYQOoj47WOmUP/c2c0cxrzBmVbgiTgJNKrOjuewjja648fkG4oa
         Zela8O2mpkB97gg3oC+NBIvYI4eIkhjlGSIuNr17vETj6Vm2n2v6oSV4S9BT71Kd2ReH
         wToCokuh7lQ4raU0+p/cAmWlr8YEgqFqwqf05RDhJSe8MC00U/n3GNUt5Dx0X7QUHoqI
         uQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521608; x=1700126408;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vyFZgshh+dS7jGWpFlg17tBqzL9luaMWJZKdCdlEUk=;
        b=DehBNtktxg1kvgr/fzkxUuNIVJrtBuTnRWmIJYAAk7VuIWu/npFOnldg3uZeMlNCyP
         kk2rvZVI1NP3eWmr9hzMNryXkI+1ZJySAvC844pIbLDvIbV5UJ6M7puck/302GWv7iWC
         ikRJViIGCD4UAIf8FP4Q48xjZBREhAtQZGNt5CaFi8V57U6mdlMt/uZ92o8TnJPE+QcA
         hawjYL6Mr+7ZNocmZ/N2j+TKkCFMDz/oYAn9la7KJPka5yF4L+Pt2tgwBf/2Aplc/C+C
         xfvC4MwlMmOaO6ZSoElfD3ihv2pL+cxewTGhM1W6+PwafJ/jeUj2A7XfqCcj1JMh/5PM
         8BPw==
X-Gm-Message-State: AOJu0Yy4owWQ+/t4kDNE9OmqHiMffYROyxqlo0bVM/5/lqqQ7GBVIojC
        43P4Kny37WD/qLaGtOahCOqi6g==
X-Google-Smtp-Source: AGHT+IGH+NJHQnwKGOJbdY9S0j2s0lppdIB6kZvn9yLs2zyUjodkEDgVCLQ4mBrxMsWOoAFJYkkORw==
X-Received: by 2002:a17:907:d27:b0:9b2:abb1:a4ab with SMTP id gn39-20020a1709070d2700b009b2abb1a4abmr4362146ejc.65.1699521607819;
        Thu, 09 Nov 2023 01:20:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id dc17-20020a170906c7d100b009b9aa8fffdasm2274367ejb.131.2023.11.09.01.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 01:20:07 -0800 (PST)
Message-ID: <9fb14ef2-ee2e-41c6-a080-01df2e947091@linaro.org>
Date:   Thu, 9 Nov 2023 10:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dt-bindings: hwmon: Add Amphenol ChipCap 2
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-4-f5c325966fdb@gmail.com>
 <008715d1-de4a-47dd-955c-e2fb7af36a25@linaro.org>
 <0b103837-54e7-430f-8a01-94b620b84f89@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0b103837-54e7-430f-8a01-94b620b84f89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 10:02, Javier Carrasco wrote:
> 
> 
> On 09.11.23 09:53, Krzysztof Kozlowski wrote:
>> On 08/11/2023 16:37, Javier Carrasco wrote:
>>> Add device tree bindings and an example for the ChipCap 2 humidity
>>> and temperature sensor.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>  .../bindings/hwmon/amphenol,chipcap2.yaml          | 68 ++++++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
>>> new file mode 100644
>>> index 000000000000..8bb6daa293d3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
>>> @@ -0,0 +1,68 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/amphenol,chipcap2.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ChipCap 2 humidity and temperature iio sensor
>>> +
>>> +maintainers:
>>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> +
>>> +description: |
>>> +  Relative humidity and temperature sensor on I2C bus.
>>> +
>>> +  Datasheets:
>>> +    https://www.amphenol-sensors.com/en/telaire/humidity/527-humidity-sensors/3095-chipcap-2
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - amphenol,cc2dxx
>>> +      - amphenol,cc2dxxs
>>> +
>>
>> Nothing improved.
>>
>> Really, you just ignored the review.
>>
>> Best regards,
>> Krzysztof
>>
> I am sorry if I missed something from your first review. I changed the
> interrupt description to have one per item as you suggested and removed
> the empty line. I did not change the compatible enum to add all part
> numbers because it was still under discussion, but now that I know that
> I have to add all of them, I will change for the next version.

And a new patch should not be sent while discussion happens. Literally I
had no chances to respond to your comment and v2 appears.

Best regards,
Krzysztof

