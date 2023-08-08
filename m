Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932AC774CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjHHVVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjHHVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:21:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAF0205CC;
        Tue,  8 Aug 2023 12:30:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3788ET4o030087;
        Tue, 8 Aug 2023 03:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691482469;
        bh=q1LFr8Ys+3am9aLaqPRJ50YWD3o+yXfMN5AFiRiu3pU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uWP17FZa/bUZs54TT8bWtcoSD9wXu7S6T9daQt49eyVfrZagWrFOz5rtienR7EjNY
         9/iRE5qpxThikh+eH7keJpxygXZrB/KMwHnl1fyQ8WP3hX8DrSwu4kEfcI1hgU7OUo
         JxcMWjDaP7a2leDLz54ZUf07mNvpnRUnIG9ecsMs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3788ETZL043722
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 03:14:29 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 03:14:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 03:14:28 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3788EO2u001102;
        Tue, 8 Aug 2023 03:14:24 -0500
Message-ID: <d2c6c120-5d3b-4975-5972-155343c1c0ca@ti.com>
Date:   Tue, 8 Aug 2023 13:44:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of
 global CMA
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <praneeth@ti.com>,
        <j-choudhary@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
References: <20230803111455.811339-1-devarsht@ti.com>
 <20230805193355.o657pwbq2w3tciui@vehicular>
 <9b61e8a0-fec0-b33f-259c-c744aa5a88b9@ti.com>
 <18bb47b8-c441-00b1-7ac7-f9038dffedc4@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <18bb47b8-c441-00b1-7ac7-f9038dffedc4@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Andrew,

Thanks for the review.

On 07/08/23 23:30, Andrew Davis wrote:
> On 8/7/23 1:03 AM, Devarsh Thakkar wrote:
>> Hi Nishanth,
>>
>> Thanks for the review.
>>
>> On 06/08/23 01:03, Nishanth Menon wrote:
>>> On 16:44-20230803, Devarsh Thakkar wrote:
>>>> Reserve 128MiB of global CMA which is also marked as re-usable
>>>> so that OS can also use the same if peripheral drivers are not using the
>>>> same.
>>>>
>>>> AM62x supports multimedia components such as GPU, dual Display and Camera.
>>>> Assuming the worst-case scenario where all 3 are run in parallel below
>>>> is the calculation :
>>>>
>>>> 1) OV5640 camera sensor supports 1920x1080 resolution
>>>> -> 1920 width x 1080 height x 2 bytesperpixel x 8 buffers
>>>>     (default in yavta) : 32MiB
>>>>
>>>> 2) 1920x1200 Microtips LVDS panel supported
>>>> -> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
>>>>     16 MiB
>>>>
>>>> 3) 1920x1080 HDMI display supported
>>>> -> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
>>>>     15.82 MiB which is ~16 MiB
>>>>
>>>> 4) IMG GPU shares with display allocated buffers while rendering
>>>>     but in case some dedicated operation viz color conversion,
>>>>     keeping same window of ~16 MiB for GPU too.
>>>>
>>>> Total is 80 MiB and adding 32 MiB for other peripherals and extra
>>>> 16 MiB to keep as buffer for fragmentation thus rounding total to 128
>>>> MiB.
>>>>
>>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>>> Acked-by: Darren Etheridge <detheridge@ti.com>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> ---
>>>
>>> I don't think this is right approach. There are other techniques
>>> than having to do this (Andrew: please comment) and require drivers to
>>> behave properly.
>>
>> Sorry but I did not understand clearly the disadvantage of this approach.
>> Here we are reserving CMA and also marking it as re-usable so that in case
>> driver is not using it OS can use that region.
>>
> 

Agreed, the examples where shared just for informational purpose.

> It isn't always that easy, many types of allocations can be pinned and
> cannot be placed in this region. It still has cost.
> 

I agree if some allocations are requested with non-moveable pages than cma
region can't serve those, but that looks more like a tradeoff to me as we also
want to support those drivers requiring CMA to use it on-demand and for
allocations requiring non-moveable pages they can be still served through
non-CMA region.


>> Also I see quite a few vendors already taking this approach :
>>
> 
> Just because others have gotten away with it doesn't mean it is correct :)
> 
> There are some cases when the DMA/CMA region needs to be in a specific
> location as the hardware only supports some addresses (only some address
> pins wired out, etc..). But general CMA size selection is a configuration
> and so has no place in DT which should only be used to describe hardware.
> 

But I do see the DT specification [0] mentioning this provision for CMA size
selection, so I don't think we are violating the DT specification while
choosing to set CMA size this way :


> Another issue I have is that this forces all users of these boards to
> have this rather large carveout, even if they do not intend to use all
> of these IP at the same time, or even at all.
> 
> Actually, upstream we don't support GPU yet, so you can't use all of
> this carveout anyway.
> 
> Lastly, large CMA carveouts as in this case are masking a bigger issue,
> there is hardware IP that cannot handle scatter-gather and there is
> no system level IOMMU to help with that. This simply does not scale,
> fragmentation can set in even with CMA in a running system, physically
> contiguous allocations can still fail. As our devices grow in complexity
> while still not having an IOMMU we would need to reserve ever increasingly
> sized CMA areas.
> 

Yes I think the CMA allocator tries to address the same scenarios and CMA
reservation is needed to support use-cases with those hardware IP's.

Also, I agree one magic value of CMA may not fit aptly all the users as some
might not intend to use these IPs at all but a default value for CMA can be
chosen to support basic use-cases supported by SoC,
and if the setting doesn't suit the user they can override this setting using
bootargs or some other method.


> This might sound like an ad absurdum argument, but we only need to look
> at our current evil vendor tree to see where this leads [0]. Yes you
> are reading the size right, 1.75GB(!) of CMA..
> 

Hmm I don't have much context on large CMA there, but that board has 32Gb RAM :)

> We need a better solution upstream, I'm not claiming I know what
> that solution is (probably something involved in the memory allocation
> to allow for more/larger movable pages). But for the above 3 reasons
> this patch is not a viable solution.
> 

Regarding movable pages, I think the CMA reservation uses pages allocated with
MIGRATE_CMA [1] flag which ensure that it uses only the movable pages so
reserved memory can be used by system if not used by driver and driver can
reclaim it back when it requires.

I am not sure what could be better solution than this, but I think camera and
display are primary use-cases for AM625 and base device-tree will be enabling
these peripherals by default and so the basic use-cases with them should also
by supported out-of-box. My suggestion is to go with this approach and if
somebody find better approach than this, we can update to it at that time.

The alternatives I see are having a shared dma pool between a set of
peripherals but that will require each driver using it to call
of_reserved_mem_device_init(dev) before starting allocation and prevent other
drivers (those not linked with this reserved region) from using CMA, and so I
did not prefer that approach and prefer the base approach as shared in this patch.

Kindly let me know your opinion.

[0]
https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html#:~:text=If%20a%20linux%2Ccma%2Ddefault
[1] https://elixir.bootlin.com/linux/latest/source/include/linux/mmzone.h#L62

Regards
Devarsh

> [0]
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti/k3-am69-sk.dts?h=ti-linux-6.1.y#n48
> 
> Andrew
> 
>> $grep -r cma-default arch/arm64/boot/dts
>> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:276:
>>   linux,cma-default;
>> arch/arm64/boot/dts/qcom/sc8280xp-crd.dts:222:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts:201:
>>           linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8ulp-evk.dts:32:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi:198:
>>   linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi:48:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8dxl-evk.dts:50:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi:24:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi:59:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi:46:
>> linux,cma-default;
>> arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts:28:
>> linux,cma-default;
>> arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts:67:
>> linux,cma-default;
>> arch/arm64/boot/dts/amlogic/meson-gx.dtsi:63:
>> linux,cma-default;
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:121:
>> linux,cma-default;
>> arch/arm64/boot/dts/amlogic/meson-a1.dtsi:59:
>> linux,cma-default;
>>
>>
>>   I am esp concerned since there are platforms based on
>>> am62x and just 256MB DDR.
>>>
>>
>> The file "k3-am62x-sk-common.dtsi" refers DDR memory size as 2Gb[1] and so I
>> put CMA reservation in same file assuming all boards including this file have
>> 2Gb.
>>
>> But if there are some boards having lesser DDR and including this
>> k3-am62x-sk-common.dtsi and overriding memory node, I can put the CMA
>> reservation node in board specific file i.e. k3-am625-sk.dts in V2.
>>
>> Kindly let me know if above is preferred approach.
>>
>> [1]
>> https://gitlab.com/linux-kernel/linux-next/-/blob/next-20230807/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi?ref_type=tags#L33
>>
>> Regards
>> Devarsh
>>
>>>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> index 34c8ffc553ec..9dd6e23ca9ca 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> @@ -47,6 +47,14 @@ ramoops@9ca00000 {
>>>>               pmsg-size = <0x8000>;
>>>>           };
>>>>   +        /* global cma region */
>>>> +        linux,cma {
>>>> +            compatible = "shared-dma-pool";
>>>> +            reusable;
>>>> +            size = <0x00 0x8000000>;
>>>> +            linux,cma-default;
>>>> +        };
>>>> +
>>>>           secure_tfa_ddr: tfa@9e780000 {
>>>>               reg = <0x00 0x9e780000 0x00 0x80000>;
>>>>               alignment = <0x1000>;
>>>> -- 
>>>> 2.34.1
>>>>
>>>
