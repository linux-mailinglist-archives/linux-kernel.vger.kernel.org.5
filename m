Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E17766BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHIR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHIR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:59:17 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA87171D;
        Wed,  9 Aug 2023 10:59:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Hx9TO048598;
        Wed, 9 Aug 2023 12:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691603949;
        bh=4kqEME0iVmag3gTdJpH4PJ+/IZ2IlwZU1DRPoE3UJcw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RYY1/wGx8e5uGxs5eBaVq0YmYQBz4EyCIWWVkKraIGqtBE3J186nO+yxJvatc8G8a
         dQHUgyX4M8yR8D+HUsFRqmDUO1mJaKmXZXg7vjT/Kyx0cNiuGTNzZ4b7C5mtOGOhqB
         7vURyGhXL+LR3qtjClE+1CZTMWh4AluGieIkUpYM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Hx9wP032036
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:59:09 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:59:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:59:09 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hx8FX096753;
        Wed, 9 Aug 2023 12:59:08 -0500
Message-ID: <1ec72d58-de81-d367-3dc6-900a00b6dac4@ti.com>
Date:   Wed, 9 Aug 2023 12:59:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,dss-oldi-io-ctrl
 compatible
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Lee Jones <lee@kernel.org>,
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
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <28cf3fa3-c9ea-aba1-2e45-94142a818849@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/9/23 12:39 PM, Aradhya Bhatia wrote:
> Hi Andrew,
> 
> Thank you for quickly whipping up these patches! =)
> 
> On 09-Aug-23 22:27, Andrew Davis wrote:
>> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
>> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
>> are used to control the characteristics of the OLDI DATA/CLK IO as needed
>> by the DSS display controller node.
> 
> As long as the driver takes care of it, we can reuse the same compatible
> even when OLDI IO Ctrl registers change from SoC to SoC, (in this case,
> AM65 to AM62), right?
> 

That depends, is the register space still "compatible" with the AM65
version of this space? If not then we would want to qualify these
with their SoC versions.

A quick check of the documentation shows the register space is still
5 registers, 4 DATA and 1 CLK. The contents are different though, but
since this compatible string is not used to match with a driver that
would care (that is handled by the DSS node which does have different
compatibles for each device), I'm actually not sure. Guess we can leave
that decision to the DT binding maintainers..

Andrew

> Regards
> Aradhya
> 
>>
>> [0] https://www.ti.com/lit/pdf/spruid7
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 8103154bbb529..5029abd6d6411 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -69,6 +69,7 @@ properties:
>>                 - rockchip,rk3588-qos
>>                 - rockchip,rv1126-qos
>>                 - starfive,jh7100-sysmain
>> +              - ti,dss-oldi-io-ctrl
>>   
>>             - const: syscon
>>   
