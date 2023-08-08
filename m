Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD0774897
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjHHTfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjHHTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:35:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CE29459;
        Tue,  8 Aug 2023 12:00:07 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378AvQC0121589;
        Tue, 8 Aug 2023 05:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691492246;
        bh=+wmWtx1vKl7gTF/aouUyV7Zp6iwajQ3qDPiq69+61co=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=blwxyIQeOu924/GLkem29ZkB+K4mvw1Bvg6lKpXES5j/qowDDUL/RgDh7yRlNcxBe
         1uXQ5wLwTHMNn7yjECtEtpHSUTalQNu2fhxHnmOpL9c0KHsyNopryddJqrqPp8EVEF
         ggzkmGfAIfeVaYhCYMEZIzh5t/eAyllZS9IUwIWM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378AvQoL021326
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 05:57:26 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 05:57:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 05:57:26 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378AvL8F038075;
        Tue, 8 Aug 2023 05:57:21 -0500
Message-ID: <5ca41ad1-4f42-f71a-4b5f-f2b6def42cb1@ti.com>
Date:   Tue, 8 Aug 2023 16:27:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
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
 <1ade44f5-b3d1-dcde-6819-9e944f3b115d@linaro.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <1ade44f5-b3d1-dcde-6819-9e944f3b115d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 3:48 pm, Krzysztof Kozlowski wrote:
> On 08/08/2023 11:44, Md Danish Anwar wrote:
>>>>    properties:
>>>>      compatible:
>>>> @@ -171,6 +181,9 @@ examples:
>>>>                <0x22400 0x100>;
>>>>          reg-names = "iram", "control", "debug";
>>>>          firmware-name = "am65x-pru0_0-fw";
>>>> +        interrupt-parent = <&icssg0_intc>;
>>>> +        interrupts = <16 2 2>;
>>>> +        interrupt-names = "vring";
>>>>        };
>>>
>>> These examples would probably be more helpful if they used the
>>> appropriate defines, no?
>>>
>>
>> PRUSS Interrupt controller doesn't have any appropriate defines. This doesn't
>> use GIC so defines from arm-gic.h can not be used here. These are specific to
>> PRUSS INTC.
>>
>> I think these example are OK. Please let me know if this is OK to you.
> 
> But isn't "2" type of the interrupt?
> 
> Best regards,
> Krzysztof
> 

As per the description of interrupts property in ti,pruss-intc.yaml [1]

Cell 1 is PRU System event number, cell 2 is PRU channel and cell 3 is PRU
host_event (target). None of them is type of interrupt. So that's why they all
are hardcoded. I don't think we can use IRQ_TYPE macros here.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml#:~:text=const%3A%203-,description%3A%20%7C,-Client%20users%20shall

-- 
Thanks and Regards,
Danish.
