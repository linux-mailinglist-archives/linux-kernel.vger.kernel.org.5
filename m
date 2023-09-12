Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2E79D1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjILNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjILNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:17:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF810CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:17:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5125680f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694524651; x=1695129451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVCcTaSbY9rwe8V8Di2XAdZ+iClnwLVfIq169SCBZEA=;
        b=PR7iuU0BYQQmEucjMMPUMWOjrTO6TWwQLH5Xt0cD7Qk7fICKPMQsV5DbG7c5cqiMSg
         CFTiWb+KWBWULdvTgZ7Wwxr2Zx0Ya0RvIaZrjry+2oHHmWf94k3kPeiFWld29V9j89+r
         rjdAfuMDuOvn6irhywEYX4gHzgEkkDCj/9jC2/06hVMGgtCf+ZK7r1HqZM7stPaAgvqT
         /MFt3AMZn8XeFH9Oc2IY0qyJdtH9z1U4FEYTtagImaZKBtwFI4DQWkIm1lo1q3JIkiWd
         sJuLZiAnYgwwwwaYfZnEw8jAwxlYeqakp0Ky5qVUbLUHTtmN7kTKIPC6Hct3RRlzSwO3
         u5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524651; x=1695129451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVCcTaSbY9rwe8V8Di2XAdZ+iClnwLVfIq169SCBZEA=;
        b=sTL7nT44HLS0fLCpv9FUaSwTuxHfNI1yce6Z/rzwZMB5L+FOZ5CYUQ1ycIF7UkB7s4
         /Qhp2LPkImp9Kaq4n9qeMg2wOYwBLEc7o64wZ0RNJ4GQTTNpvRPOLztySSaqA7zYuFd2
         LYntsHhON0dy94wPJZejHn2KwM1P1gMfdpMrl/mPq2JyUmHsypzXicaxriuWRmMuiJ4Q
         KAbx38ZSlbzpJYF+Laz/aghlG07dtauxwus7AIvQCpvYuLNNVu5X0cXkHqlaQJZx1jNT
         90V6219Lq6NqLjgCl26l8rpbQD1OQIjVRWnq+tU7Ou+GRLhAfPS3XktZ9BZzZGYnBga8
         zxwA==
X-Gm-Message-State: AOJu0YyePvf0SmMCycWhXcqGFkjnQGD/CGw3Lkyki10W/PjfiYeMNFdS
        4eRjkLUk0l7FJaVi0SgHom19gw==
X-Google-Smtp-Source: AGHT+IFHrdYQ+Sq9vpHXLwlvE6jWB4jziFsIr4mUbMR721FEezxCHK3S5u+XI12b+yFvlUmuc3bs1Q==
X-Received: by 2002:a5d:69c3:0:b0:319:74b5:b67d with SMTP id s3-20020a5d69c3000000b0031974b5b67dmr9932380wrw.66.1694524650901;
        Tue, 12 Sep 2023 06:17:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0031aca6cc69csm12859647wrs.2.2023.09.12.06.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:17:30 -0700 (PDT)
Message-ID: <439bf5eb-c146-2f67-1d64-4efa100ee85a@linaro.org>
Date:   Tue, 12 Sep 2023 15:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 6/6] microchip: lan865x: add device-tree
 support for Microchip's LAN865X MACPHY
To:     Parthiban.Veerasooran@microchip.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        andrew@lunn.ch
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-7-Parthiban.Veerasooran@microchip.com>
 <feb8eaeb-954c-416d-6e30-acb4b92764e0@linaro.org>
 <f429ea93-9cb2-8869-a98d-fb55161cf880@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f429ea93-9cb2-8869-a98d-fb55161cf880@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 14:15, Parthiban.Veerasooran@microchip.com wrote:
> Hi Krzysztof,
> 
> Thank you for reviewing the patch.
> 
> On 10/09/23 4:25 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 08/09/2023 16:29, Parthiban Veerasooran wrote:
>>> Add device-tree support for Microchip's LAN865X MACPHY for configuring
>>> the OPEN Alliance 10BASE-T1x MACPHY Serial Interface parameters.
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
> Ok sure, so it will become like,
> 
> dt-bindings: net: add device-tree support for Microchip's LAN865X MACPHY
> 
> I will correct it in the next revision.

"device-tree support for " is redundant, drop

>>
>>>
>>> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
>>> ---
>>>   .../bindings/net/microchip,lan865x.yaml       | 54 +++++++++++++++++++
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 55 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>>> new file mode 100644
>>> index 000000000000..3465b2c97690
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>>> @@ -0,0 +1,54 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
>>> +
>>> +maintainers:
>>> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
>>> +
>>> +description: |
>>> +  Device tree properties for LAN8650/1 10BASE-T1S MACPHY Ethernet
>>
>> Drop "Device tree properties for" and instead describe the hardware.
> sure, will do it.
>>
>>> +  controller.
>>> +
>>> +allOf:
>>> +  - $ref: ethernet-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>
>> No need for items. Just enum.
> Ok noted.
>>
>>
>>> +      - enum:
>>> +          - microchip,lan865x
>>
>> No wildcards in compatibles.
> Yes then we don't need enum also isn't it?

I don't see correlation between these two. Please read the writing
bindings guidelines.


>>
>> Missing blank line.
> Ok will add it.
>>
>>
>>
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  local-mac-address: true
>>> +  oa-chunk-size: true
>>> +  oa-tx-cut-through: true
>>> +  oa-rx-cut-through: true
>>> +  oa-protected: true
>>
>> What are all these? Where are they defined that you skip description,
>> type and vendor prefix?
> Ok missed it. Will do it in the next revision.

No, drop them or explain why they are hardware properties.

>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        ethernet@1{
>>
>> Missing space
> Ok will add it.
>>
>>> +            compatible = "microchip,lan865x";
>>> +            reg = <1>; /* CE0 */
>>
>> CE0? chip-select? What does this comment mean in this context?
> Yes it is chip-select. Will add proper comment.

Why? isn't reg obvious?

Best regards,
Krzysztof

