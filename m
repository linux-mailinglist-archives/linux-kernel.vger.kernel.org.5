Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E07742C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjHHRtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbjHHRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:49:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211C902F;
        Tue,  8 Aug 2023 09:21:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378CqvRG089729;
        Tue, 8 Aug 2023 07:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691499177;
        bh=oAHyNjZ4qdC82k09nVl9fcw3dWGC9wMNtP2mYp5EnBg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=x5loM3xAJZK3TdZ20gpQPf/jYzpWvShwUK+nxQQkjkwF3cZXx3TTHkTGMe+sKL0em
         7DCRD3knWnpzokaCJWUsMUb36WE9s2mTAn7tGnYfwyTZtmJ/v9gpyXqImCoDYOlexw
         uG2j6oEaq/4yvHIZQsW874lET6vHffvnFO5OU+dM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378Cqv1V084651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:52:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:52:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:52:57 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378CqqbG121602;
        Tue, 8 Aug 2023 07:52:53 -0500
Message-ID: <27bdb861-64ff-b7ac-85cf-beaaaca2b704@ti.com>
Date:   Tue, 8 Aug 2023 18:22:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
 <20230808-unwomanly-generic-67d20f0e51cd@spud>
 <cd74e31f-8bc6-445b-9c33-51e53a439cd2@ti.com>
 <20230808-bazooka-uncoated-a3401d94b063@spud>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230808-bazooka-uncoated-a3401d94b063@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 4:58 pm, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 04:30:32PM +0530, Md Danish Anwar wrote:
>> On 08/08/23 4:18 pm, Conor Dooley wrote:
>>> On Tue, Aug 08, 2023 at 03:14:31PM +0530, Md Danish Anwar wrote:
>>>> On 07/08/23 8:09 pm, Conor Dooley wrote:
>>>>> On Mon, Aug 07, 2023 at 04:38:36PM +0530, MD Danish Anwar wrote:
>>>>>> Add interrupts and interrupt-names protperties for PRU and RTU cores.
>>>>>>
>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>> ---
>>>>>>  .../bindings/remoteproc/ti,pru-rproc.yaml     | 22 +++++++++++++++++++
>>>>>>  1 file changed, 22 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>>>>> index cd55d80137f7..6970316943bb 100644
>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>>>>> @@ -66,6 +66,16 @@ properties:
>>>>>>        Should contain the name of the default firmware image
>>>>>>        file located on the firmware search path.
>>>>>>  
>>>>>> +  interrupts:
>>>>>> +    maxItems: 1
>>>>>> +    description:
>>>>>> +      Interrupt specifiers enable the virtio/rpmsg communication between MPU
>>>>>> +      and the PRU/RTU cores.
>>>>>> +
>>>>>> +  interrupt-names:
>>>>>> +    items:
>>>>>> +      - const: vring
>>>>>> +
>>>>>>  if:
>>>>>>    properties:
>>>>>>      compatible:
>>>>>> @@ -171,6 +181,9 @@ examples:
>>>>>>                <0x22400 0x100>;
>>>>>>          reg-names = "iram", "control", "debug";
>>>>>>          firmware-name = "am65x-pru0_0-fw";
>>>>>> +        interrupt-parent = <&icssg0_intc>;
>>>>>> +        interrupts = <16 2 2>;
>>>>>> +        interrupt-names = "vring";
>>>>>>        };
>>>>>
>>>>> These examples would probably be more helpful if they used the
>>>>> appropriate defines, no?
>>>>>
>>>>
>>>> PRUSS Interrupt controller doesn't have any appropriate defines. This doesn't
>>>> use GIC so defines from arm-gic.h can not be used here. These are specific to
>>>> PRUSS INTC.
>>>
>>> I was deliberately vague in case the gic stuff applied too, but my main
>>> question was about the standard defines used for interrupt types.
>>>
>>
>> There are no standard defines for these interrupt types. However I can create a
>> new .h file defining all the three interrupt cells and their values for both
>> PRU and RTU cores if you think that is required. Otherwise we can go with
>> hardcoded values.
>>
>> Please let me know what you think should be done here.
> 
> It'd be good to reference to the documentation for the cells, I don't
> think adding a header is necessary here.

Sure. Then I would keep this as it is. the interrupt cell values will remain as
it is. No change required here then. Please let me know if any other change is
required in this patch.

> 
> Thanks,
> Conor.

-- 
Thanks and Regards,
Danish.
