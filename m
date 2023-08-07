Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59B772D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjHGSBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHGSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:00:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963B10F3;
        Mon,  7 Aug 2023 11:00:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377I0nq3018704;
        Mon, 7 Aug 2023 13:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691431249;
        bh=b6FLmaE1Rf5mwg/wVsO9g/4WdXaAznkBCXsadwi9pD0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bmCqtk9inLN/s4+ePCos5wDZydMQ+FSyNcPUGxOWGWtSAjQ2Fj6EMk4WBKTbtXyl3
         UjcYfFCLUiZ8ur0oO5Hb24F0K7jl0KrohQhjjNoxFcxbWzm5QNyAmHdeclW0di8xTG
         wy5iBRFpS75g0/39toeTky0cQcBd3A1fXaAc/ddQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377I0njq064284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 13:00:49 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 13:00:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 13:00:49 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377I0mIj035524;
        Mon, 7 Aug 2023 13:00:48 -0500
Message-ID: <18bb47b8-c441-00b1-7ac7-f9038dffedc4@ti.com>
Date:   Mon, 7 Aug 2023 13:00:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of
 global CMA
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <praneeth@ti.com>,
        <j-choudhary@ti.com>
References: <20230803111455.811339-1-devarsht@ti.com>
 <20230805193355.o657pwbq2w3tciui@vehicular>
 <9b61e8a0-fec0-b33f-259c-c744aa5a88b9@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <9b61e8a0-fec0-b33f-259c-c744aa5a88b9@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 1:03 AM, Devarsh Thakkar wrote:
> Hi Nishanth,
> 
> Thanks for the review.
> 
> On 06/08/23 01:03, Nishanth Menon wrote:
>> On 16:44-20230803, Devarsh Thakkar wrote:
>>> Reserve 128MiB of global CMA which is also marked as re-usable
>>> so that OS can also use the same if peripheral drivers are not using the
>>> same.
>>>
>>> AM62x supports multimedia components such as GPU, dual Display and Camera.
>>> Assuming the worst-case scenario where all 3 are run in parallel below
>>> is the calculation :
>>>
>>> 1) OV5640 camera sensor supports 1920x1080 resolution
>>> -> 1920 width x 1080 height x 2 bytesperpixel x 8 buffers
>>>     (default in yavta) : 32MiB
>>>
>>> 2) 1920x1200 Microtips LVDS panel supported
>>> -> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
>>>     16 MiB
>>>
>>> 3) 1920x1080 HDMI display supported
>>> -> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
>>>     15.82 MiB which is ~16 MiB
>>>
>>> 4) IMG GPU shares with display allocated buffers while rendering
>>>     but in case some dedicated operation viz color conversion,
>>>     keeping same window of ~16 MiB for GPU too.
>>>
>>> Total is 80 MiB and adding 32 MiB for other peripherals and extra
>>> 16 MiB to keep as buffer for fragmentation thus rounding total to 128
>>> MiB.
>>>
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> Acked-by: Darren Etheridge <detheridge@ti.com>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> ---
>>
>> I don't think this is right approach. There are other techniques
>> than having to do this (Andrew: please comment) and require drivers to
>> behave properly.
> 
> Sorry but I did not understand clearly the disadvantage of this approach.
> Here we are reserving CMA and also marking it as re-usable so that in case
> driver is not using it OS can use that region.
> 

It isn't always that easy, many types of allocations can be pinned and
cannot be placed in this region. It still has cost.

> Also I see quite a few vendors already taking this approach :
> 

Just because others have gotten away with it doesn't mean it is correct :)

There are some cases when the DMA/CMA region needs to be in a specific
location as the hardware only supports some addresses (only some address
pins wired out, etc..). But general CMA size selection is a configuration
and so has no place in DT which should only be used to describe hardware.

Another issue I have is that this forces all users of these boards to
have this rather large carveout, even if they do not intend to use all
of these IP at the same time, or even at all.

Actually, upstream we don't support GPU yet, so you can't use all of
this carveout anyway.

Lastly, large CMA carveouts as in this case are masking a bigger issue,
there is hardware IP that cannot handle scatter-gather and there is
no system level IOMMU to help with that. This simply does not scale,
fragmentation can set in even with CMA in a running system, physically
contiguous allocations can still fail. As our devices grow in complexity
while still not having an IOMMU we would need to reserve ever increasingly
sized CMA areas.

This might sound like an ad absurdum argument, but we only need to look
at our current evil vendor tree to see where this leads [0]. Yes you
are reading the size right, 1.75GB(!) of CMA..

We need a better solution upstream, I'm not claiming I know what
that solution is (probably something involved in the memory allocation
to allow for more/larger movable pages). But for the above 3 reasons
this patch is not a viable solution.

[0] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti/k3-am69-sk.dts?h=ti-linux-6.1.y#n48

Andrew

> $grep -r cma-default arch/arm64/boot/dts
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:276:
>   linux,cma-default;
> arch/arm64/boot/dts/qcom/sc8280xp-crd.dts:222:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts:201:
>           linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8ulp-evk.dts:32:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi:198:
>   linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi:48:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8dxl-evk.dts:50:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi:24:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi:59:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi:46:
> linux,cma-default;
> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts:28:
> linux,cma-default;
> arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts:67:
> linux,cma-default;
> arch/arm64/boot/dts/amlogic/meson-gx.dtsi:63:
> linux,cma-default;
> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:121:
> linux,cma-default;
> arch/arm64/boot/dts/amlogic/meson-a1.dtsi:59:
> linux,cma-default;
> 
> 
>   I am esp concerned since there are platforms based on
>> am62x and just 256MB DDR.
>>
> 
> The file "k3-am62x-sk-common.dtsi" refers DDR memory size as 2Gb[1] and so I
> put CMA reservation in same file assuming all boards including this file have
> 2Gb.
> 
> But if there are some boards having lesser DDR and including this
> k3-am62x-sk-common.dtsi and overriding memory node, I can put the CMA
> reservation node in board specific file i.e. k3-am625-sk.dts in V2.
> 
> Kindly let me know if above is preferred approach.
> 
> [1]
> https://gitlab.com/linux-kernel/linux-next/-/blob/next-20230807/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi?ref_type=tags#L33
> 
> Regards
> Devarsh
> 
>>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> index 34c8ffc553ec..9dd6e23ca9ca 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> @@ -47,6 +47,14 @@ ramoops@9ca00000 {
>>>   			pmsg-size = <0x8000>;
>>>   		};
>>>   
>>> +		/* global cma region */
>>> +		linux,cma {
>>> +			compatible = "shared-dma-pool";
>>> +			reusable;
>>> +			size = <0x00 0x8000000>;
>>> +			linux,cma-default;
>>> +		};
>>> +
>>>   		secure_tfa_ddr: tfa@9e780000 {
>>>   			reg = <0x00 0x9e780000 0x00 0x80000>;
>>>   			alignment = <0x1000>;
>>> -- 
>>> 2.34.1
>>>
>>
