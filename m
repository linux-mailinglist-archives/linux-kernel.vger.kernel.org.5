Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656FB78B6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjH1R4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjH1Rzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:55:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169A106
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:55:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so139587a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693245347; x=1693850147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ZGm2c8M5uCZpx5NsLqloIP7RYTRm5RGMmegNXhmtc=;
        b=QD/fvPS84hhSpZsACY5HQkaY/XohpljOn1oQw5z0pvXOd3H8hsIMvkW7YEXWb8Md9H
         yqJ8NXPBYibBQtae7bCjf5xZRudWds2LMitSn6/PvVw4ikSwhDtwvbbptZ4rqV1LTUl9
         S3i9FyYWusdGB2kZx/n0W8KklrcL8kwAvSkjIuzaiZdYqcKnGvlBr654Otpj9TnBZ1cU
         BMOHD3+j8nE+qvc4ThVgFfuXQOvss+ppoy21Vgf6L4DPpX5PMA+zMP6t2DruQXqW0sR+
         u4GHPKmlhM04DKy/ZOzoQrDSFD8EL7oLrZYfCSs2oXBCmYZ0YrKPO7nehUo4UZOGl+9k
         f+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245347; x=1693850147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ZGm2c8M5uCZpx5NsLqloIP7RYTRm5RGMmegNXhmtc=;
        b=RsdHMRFnmFgexOMyb88sL+R5CKGDzX/I0k+k5OyEzM/+iuUikYFIahfMLEe4eWidNj
         SyINynYisBHXvcAy5IZvHg+gqLBMptkldCNE+46LPYCDJcISys2DQQH92AtfRDythM3+
         DrElCBjCBifjBove2IYaOCp794WGC2Qe5lyTWAB6ezxwjXReC+6A0EQIbnB3zL22Img5
         N7EGGjWJvvGHxEeFZ1zHHcRL2TuRlaYlipI1dtsr3fnmCxEUD/PtfkP/yN8Hc6r/p3dc
         iZg/oXNqBGyikhtW9pB680Emn6uqSvach5YTztrQ3ITFVllapudEJs488jEjGT7XvYil
         iJag==
X-Gm-Message-State: AOJu0YwdaIEcdAKnvQx3cWhqMkCylTauj8C2ft/+9nHMJGUZ5dpif8RN
        kxQ6IQ9AixtmZJkDUskB5DfTfA==
X-Google-Smtp-Source: AGHT+IH54gGY3YgXrsJV+7+2XCu+45eXNW/T27xOMIUiGWecCGA9P4KGwAtfdsWavYmLKVIZDXY5Bw==
X-Received: by 2002:a05:6402:3514:b0:523:4e41:2a37 with SMTP id b20-20020a056402351400b005234e412a37mr420275edd.11.1693245347138;
        Mon, 28 Aug 2023 10:55:47 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7d80a000000b005233deb30aesm4646569edq.10.2023.08.28.10.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:55:46 -0700 (PDT)
Message-ID: <75829c0e-b6f8-536e-c84e-a660be3f39d0@linaro.org>
Date:   Mon, 28 Aug 2023 19:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: add T-HEAD dwmac
 support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
        Coquelin@web.codeaurora.org,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-3-jszhang@kernel.org>
 <qc2nyqmuouig6qww2q7orlwzvcprjyruyeuyr5dqdpxysajjpv@6fzsgjgokry7>
 <ZOy6kLGZ1lR0I2sC@xhacker>
 <pbh7gh7fkfis7zqqmmug5wtosq3xsx7z3ktsfg3jy6jthm6qva@a3wy7knv2vcr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <pbh7gh7fkfis7zqqmmug5wtosq3xsx7z3ktsfg3jy6jthm6qva@a3wy7knv2vcr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 17:51, Serge Semin wrote:
> On Mon, Aug 28, 2023 at 11:17:36PM +0800, Jisheng Zhang wrote:
>> On Mon, Aug 28, 2023 at 04:13:00PM +0300, Serge Semin wrote:
>>> On Sun, Aug 27, 2023 at 05:17:09PM +0800, Jisheng Zhang wrote:
>>>> Add documentation to describe T-HEAD dwmac.
>>>>
>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>> ---
>>>>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>>>>  .../devicetree/bindings/net/thead,dwmac.yaml  | 77 +++++++++++++++++++
>>>>  2 files changed, 78 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/net/thead,dwmac.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> index b196c5de2061..73821f86a609 100644
>>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> @@ -96,6 +96,7 @@ properties:
>>>>          - snps,dwxgmac
>>>>          - snps,dwxgmac-2.10
>>>>          - starfive,jh7110-dwmac
>>>> +        - thead,th1520-dwmac
>>>>  
>>>>    reg:
>>>>      minItems: 1
>>>> diff --git a/Documentation/devicetree/bindings/net/thead,dwmac.yaml b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
>>>> new file mode 100644
>>>> index 000000000000..bf8ec8ca2753
>>>> --- /dev/null
>>>
>>>> +++ b/Documentation/devicetree/bindings/net/thead,dwmac.yaml
>>>
>>> see further regarding using dwmac in the names here.
>>>
>>>> @@ -0,0 +1,77 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>
>>>> +title: T-HEAD DWMAC Ethernet controller
>>>
>>> Additionally would be nice to have a brief controller "description:"
>>> having the next info: the SoCs the controllers can be found on, the DW
>>> (G)MAC IP-core version the ethernet controller is based on and some
>>> data about the synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA
>>> FIFOs size, perfect and hash MAC-filters size, L3L4 frame filters
>>> availability, VLAN hash filter, SA/VLAN-tag insertion, ARP offload
>>> engine, PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE
>>> 1588(-2008) Timestamping support, PMT and Wake-up frame support, MAC
>>> Management counters (MMC). In addition to that for DW QoS
>>> ETH/XGMAC/XLGMAC the next info would be useful: number of MTL Queues
>>> and DMA channels, MTL queues capabilities (QoS-related), TSO
>>> availability, SPO availability.
>>>
> 
>>> Note DMA FIFO sizes can be also constrained in the properties
>>> "rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter sizes -
>>> in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".
> 
> BTW plus to this you may wish to add the "rx-internal-delay-ps" and
> "tx-internal-delay-ps" properties constraints seeing they device
> supports internal Tx/Rx delays.
> 
>>
>> Hi Serge,
>>
> 
>> Thank you for your code review. I have different views here: If we
>> only support the gmac controller in one specific SoC, these detailed
>> information is nice to have, but what about if the driver/dt-binding
>> supports the gmac controller in different SoCs? These detailed
>> information will be outdated.
> 
> First they won't. Second then you can either add more info to the
> description for instance in a separate paragraph or create a dedicated
> DT-bindings. Such information would be very much useful for the
> generic STMMAC driver code maintenance.
> 
>>
>> what's more, I think the purpose of dt-binding is different from
>> the one of documentation.
> 
> The purpose of the DT-bindings is a hardware "description". The info I
> listed describes your hardware.
> 
>>
>> So I prefer to put these GMAC IP related detailed information into
>> the SoC's dtsi commit msg rather than polluting the dt-binding.
>>>
>>>> +
>>>> +maintainers:
>>>> +  - Jisheng Zhang <jszhang@kernel.org>
>>>> +
>>>> +select:
>>>> +  properties:
>>>> +    compatible:
>>>> +      contains:
>>>> +        enum:
>>>
>>>> +          - thead,th1520-dwmac
>>>
>>> Referring to the DW IP-core in the compatible string isn't very
>>> much useful especially seeing you have a generic fallback compatible.
>>> Name like "thead,th1520-gmac" looks more informative indicating its
>>> speed capability.
>>
> 
>> This is just to follow the common style as those dwmac-* does.
>> I'm not sure which is better, but personally, I'd like to keep current
>> common style.
> 
> It's not that common. Half the compatible strings use the notation
> suggested by me and it has more sense then a dwmac suffix. It's ok to
> use the suffix in the STMMAC driver-related things because the glue
> code is supposed to work with the DW *MAC generic code. Using it in
> the compatible string especially together with the generic fallback
> compatible just useless.

THEAD did not make dwmac here, but a gmac. dwmac does not exist in the
context of Thead and Th1520, so the naming suggested by Serge makes sense.

Best regards,
Krzysztof

