Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C6776B10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjHIVjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:38:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506FE1BD9;
        Wed,  9 Aug 2023 14:38:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379LciEx036431;
        Wed, 9 Aug 2023 16:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691617124;
        bh=zObaM7Rn0xafAyfJJrMuORDcrHAfotyqhFxpVDqhk8o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=rWA88nd7gYqWoImCkU1MYliVjqvwTjleNtdnf2DHnS+XmIoLHS6HZfmjmA0WHOhs+
         YYgClF4thUl8hUiL3CFM1lg5Y38jnKdNDd8JHi/fQNcgHaSrxzvPO6aUbKGm/MEnxM
         jHBeYLRX1MemevhYE459+5mxrlSFXB2fJ84rBna8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Lcilj106651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 16:38:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 16:38:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 16:38:44 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379LchSW030688;
        Wed, 9 Aug 2023 16:38:43 -0500
Message-ID: <f10283a8-5fe4-78fd-fde6-bff406282dbf@ti.com>
Date:   Wed, 9 Aug 2023 16:38:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,dss-oldi-io-ctrl
 compatible
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230809165752.46133-1-afd@ti.com>
 <28cf3fa3-c9ea-aba1-2e45-94142a818849@ti.com>
 <1ec72d58-de81-d367-3dc6-900a00b6dac4@ti.com>
 <90e34ca5-3380-8a66-1041-efea85838236@ti.com>
 <20230809-boxing-unsoiled-0ca242cac892@spud>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230809-boxing-unsoiled-0ca242cac892@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 4:31 PM, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 12:30:03AM +0530, Aradhya Bhatia wrote:
>>
>>
>> On 09-Aug-23 23:29, Andrew Davis wrote:
>>> On 8/9/23 12:39 PM, Aradhya Bhatia wrote:
>>>> Hi Andrew,
>>>>
>>>> Thank you for quickly whipping up these patches! =)
>>>>
>>>> On 09-Aug-23 22:27, Andrew Davis wrote:
>>>>> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
>>>>> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
>>>>> are used to control the characteristics of the OLDI DATA/CLK IO as
>>>>> needed
>>>>> by the DSS display controller node.
>>>>
>>>> As long as the driver takes care of it, we can reuse the same compatible
>>>> even when OLDI IO Ctrl registers change from SoC to SoC, (in this case,
>>>> AM65 to AM62), right?
>>>>
>>>
>>> That depends, is the register space still "compatible" with the AM65
>>> version of this space? If not then we would want to qualify these
>>> with their SoC versions.
> 
> Even if they are compatible, having soc-specific compatibles with a
> fallback to the common oldi compatible string would be ideal.
> 
>> It is certainly not compatible. More on this below.
> 
> But as they're not compatible, that's kinda moot anyway.
> 
>>> A quick check of the documentation shows the register space is still
>>> 5 registers, 4 DATA and 1 CLK. The contents are different though, but
>>> since this compatible string is not used to match with a driver that
>>> would care (that is handled by the DSS node which does have different
>>> compatibles for each device), I'm actually not sure.
> 
>>> Guess we can leave
>>> that decision to the DT binding maintainers..
> 
> I'm not 100% sure what this decision actually is. Could you elaborate?
> 

I was not exactly aware of the extent of the incompatibilities.
If they are not compatible, then there is really no decision needed,
they must have different strings.

> 
>> Exactly. The DSS driver in our, as you like to call, evil-vendor-tree
>> uses the compatible information to decide which register offsets to
>> write to, and what to write.
>>
>>
>> On the register compatibility situation...
>>
>> AM62 OLDI IO Ctrl has, in total, 12 registers (as opposed to 5 in AM65).
>>
>> There are 4 Data and 1 Clk registers (per OLDI). And there are 2 OLDI
>> transmitters in AM62. However, their contents are different as you
>> noted.
>>
>> There are 2 more registers in AM62 (unlike AM65), that control
>> power-down and loop-back. And it is the power-down register, that will
>> be primarily used by the driver.
> 
>>>>> [0] https://www.ti.com/lit/pdf/spruid7
>>>>>
>>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>>> b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>>> index 8103154bbb529..5029abd6d6411 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>>> @@ -69,6 +69,7 @@ properties:
>>>>>                  - rockchip,rk3588-qos
>>>>>                  - rockchip,rv1126-qos
>>>>>                  - starfive,jh7100-sysmain
>>>>> +              - ti,dss-oldi-io-ctrl
> 
> So it sounds like this compatible, that appears to be generic, should
> instead be soc-specific as the register layout is different between
> SoCs?
> 

Sounds like it, I'll go and make this soc-specific.

Thanks,
Andrew

> Apologies if I have misunderstood.
> 
> Thanks,
> Conor.
> 
>>>>>                - const: syscon
>>>>>    
>>
