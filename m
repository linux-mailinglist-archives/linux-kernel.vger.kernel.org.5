Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E77767CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjHITAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjHITAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:00:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC3E72;
        Wed,  9 Aug 2023 12:00:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379J09L7071677;
        Wed, 9 Aug 2023 14:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691607609;
        bh=Q46d8+LLC/blTQTQ+yNedyYOj0K8/lNhA0yjGNott8E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JfRP4+uF5nCebfT/KXxt1Oy4oc5lcMoqHDpiVviVSqCW2DDS96RdPcov5eyVAdlhH
         /KMbgImoNh1vl3qlnpT3+QCJaZPXg8F0Z6Uce20DVAFsGa2suPb3+6ndvgtRha+UJ5
         XoHAtHePEArrzDNPDUHOt3I/YCiETIncck8S0AhI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379J09j8043482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:00:09 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:00:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:00:08 -0500
Received: from [10.249.132.69] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379J048X013940;
        Wed, 9 Aug 2023 14:00:05 -0500
Message-ID: <90e34ca5-3380-8a66-1041-efea85838236@ti.com>
Date:   Thu, 10 Aug 2023 00:30:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,dss-oldi-io-ctrl
 compatible
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230809165752.46133-1-afd@ti.com>
 <28cf3fa3-c9ea-aba1-2e45-94142a818849@ti.com>
 <1ec72d58-de81-d367-3dc6-900a00b6dac4@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <1ec72d58-de81-d367-3dc6-900a00b6dac4@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09-Aug-23 23:29, Andrew Davis wrote:
> On 8/9/23 12:39 PM, Aradhya Bhatia wrote:
>> Hi Andrew,
>>
>> Thank you for quickly whipping up these patches! =)
>>
>> On 09-Aug-23 22:27, Andrew Davis wrote:
>>> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
>>> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
>>> are used to control the characteristics of the OLDI DATA/CLK IO as
>>> needed
>>> by the DSS display controller node.
>>
>> As long as the driver takes care of it, we can reuse the same compatible
>> even when OLDI IO Ctrl registers change from SoC to SoC, (in this case,
>> AM65 to AM62), right?
>>
> 
> That depends, is the register space still "compatible" with the AM65
> version of this space? If not then we would want to qualify these
> with their SoC versions.

It is certainly not compatible. More on this below.

> 
> A quick check of the documentation shows the register space is still
> 5 registers, 4 DATA and 1 CLK. The contents are different though, but
> since this compatible string is not used to match with a driver that
> would care (that is handled by the DSS node which does have different
> compatibles for each device), I'm actually not sure. Guess we can leave
> that decision to the DT binding maintainers..

Exactly. The DSS driver in our, as you like to call, evil-vendor-tree
uses the compatible information to decide which register offsets to
write to, and what to write.


On the register compatibility situation...

AM62 OLDI IO Ctrl has, in total, 12 registers (as opposed to 5 in AM65).

There are 4 Data and 1 Clk registers (per OLDI). And there are 2 OLDI
transmitters in AM62. However, their contents are different as you
noted.

There are 2 more registers in AM62 (unlike AM65), that control
power-down and loop-back. And it is the power-down register, that will
be primarily used by the driver.

Regards
Aradhya


> 
> Andrew
> 
>> Regards
>> Aradhya
>>
>>>
>>> [0] https://www.ti.com/lit/pdf/spruid7
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> index 8103154bbb529..5029abd6d6411 100644
>>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> @@ -69,6 +69,7 @@ properties:
>>>                 - rockchip,rk3588-qos
>>>                 - rockchip,rv1126-qos
>>>                 - starfive,jh7100-sysmain
>>> +              - ti,dss-oldi-io-ctrl
>>>               - const: syscon
>>>   

