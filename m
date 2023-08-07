Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7523771CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHGJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjHGJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:07:53 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BCBE68;
        Mon,  7 Aug 2023 02:07:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D759D8157;
        Mon,  7 Aug 2023 17:07:38 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 17:07:38 +0800
Received: from [192.168.125.128] (113.72.146.246) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 17:07:37 +0800
Message-ID: <12a9bfda-9c9f-6baf-3e5f-ce7cc7d79aee@starfivetech.com>
Date:   Mon, 7 Aug 2023 17:03:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/5] ASoC: dt-bindings: snps,designware-i2s: Add
 StarFive JH7110 SoC support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-riscv@lists.infradead.org>
References: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
 <20230802084301.134122-3-xingyu.wu@starfivetech.com>
 <37a636dd-fbd8-d475-8814-e0cc6d5cc812@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <37a636dd-fbd8-d475-8814-e0cc6d5cc812@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.246]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/6 5:02, Krzysztof Kozlowski wrote:
> On 02/08/2023 10:42, Xingyu Wu wrote:
>> Add the StarFive JH7110 (TX0/TX1/RX channel) SoC support in the bindings
>> of Designware I2S controller. The I2S controller needs two reset items''
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>>  
>>    resets:
>>      items:
>>        - description: Optional controller resets
>> +      - description: controller reset of Sampling rate
>> +    minItems: 1
>>  
>>    dmas:
>>      items:
>> @@ -51,6 +75,17 @@ properties:
>>        - const: rx
>>      minItems: 1
>>  
>> +  starfive,syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to System Register Controller sys_syscon node.
>> +          - description: I2S-rx enabled control offset of SYS_SYSCONSAIF__SYSCFG register.
>> +          - description: I2S-rx enabled control mask
>> +    description:
>> +      The phandle to System Register Controller syscon node and the I2S-rx(ADC)
>> +      enabled control offset and mask of SYS_SYSCONSAIF__SYSCFG register.
>> +
>>  allOf:
>>    - $ref: dai-common.yaml#
>>    - if:
>> @@ -66,6 +101,66 @@ allOf:
>>        properties:
>>          "#sound-dai-cells":
>>            const: 0
> 
> You need to constrain clocks and resets also for all other existing
> variants.
>>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: snps,designware-i2s
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 1
>> +        clock-names:
>> +          maxItems: 1
>> +        resets:
>> +          maxItems: 1
>> +    else:
>> +      properties:
>> +        resets:
>> +          minItems: 2

The resets of TX0/TX1/RX on JH7110 SoC are mentioned in 'else' here.

>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: starfive,jh7110-i2stx0
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 5
> 
> Also maxItems

Will add.

> 
>> +        clock-names:
>> +          minItems: 5
> 
> Also maxItems

Will add.

> 
> What about resets? 1 or 2 items?

Mentioned it in the 'else'.
Or do you mean I should drop the 'else' and add the resets in here?
And is the same for TX1 and RX?

> 
>> +      required:
>> +        - resets
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: starfive,jh7110-i2stx1
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 9
>> +        clock-names:
>> +          minItems: 9
> 
> resets?> 
>> +      required:
>> +        - resets
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: starfive,jh7110-i2srx
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 9
>> +        clock-names:
>> +          minItems: 9
> 
> resets?
> 
>> +      required:
>> +        - resets
>> +        - starfive,syscon
>> +    else:
>> +      properties:
>> +        starfive,syscon: false
>>  
>>  required:
>>    - compatible
> 

Best regards,
Xingyu Wu

