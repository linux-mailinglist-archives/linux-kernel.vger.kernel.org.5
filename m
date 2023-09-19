Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697507A6864
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjISP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjISP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:56:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06889D;
        Tue, 19 Sep 2023 08:56:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JFtxws064411;
        Tue, 19 Sep 2023 10:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695138959;
        bh=DOMnIgJd/3qT7h/zUiPCrXuhex0Ht2z7/JDnNYL/tSk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lvEYMuPqxirMvq/YuQTLPE6rj/ZylQkE5iD4cOmb25m2P5/vFav7P+cHPddtRxIY8
         /gKZUz6K8+5r7hCCzu0TYapuCZGvQ+m3ws/yfrggk2tRUSYGvo38FI8J6rWcGp2YX3
         Gs3hG6wlxM4xc3f5CnjULM7jA0aYQB06csJFy3iw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JFtxUt108188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 10:55:59 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 10:55:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 10:55:58 -0500
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JFtsf7014484;
        Tue, 19 Sep 2023 10:55:55 -0500
Message-ID: <227c251c-6552-8067-3dfc-6595744affb4@ti.com>
Date:   Tue, 19 Sep 2023 21:25:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] arm64: dts: ti: am654-base-board: add ICSSG2 Ethernet
 support
To:     Andrew Davis <afd@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20230911071245.2173520-1-danishanwar@ti.com>
 <20230911071245.2173520-3-danishanwar@ti.com>
 <1e1577a5-fb01-c84b-ede0-38058387ec23@ti.com>
 <6503ca2b-c55a-ab26-6e0c-121aeb5c1c66@ti.com>
 <6cb40b09-8154-5ef4-cbbc-9dfc5994a031@ti.com>
 <cf9f8d95-0f52-b37e-bb97-0382fed01b6a@ti.com>
 <5bbf0a9b-edd0-e591-0a1f-36016bd3f2a0@ti.com>
 <d2ad2519-9c3c-1d93-e8ee-adfeea2b416a@ti.com>
 <f1fe8dab-350d-002e-c922-58e5912bd76f@ti.com>
Content-Language: en-US
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <f1fe8dab-350d-002e-c922-58e5912bd76f@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2023 8:57 PM, Andrew Davis wrote:
> On 9/19/23 1:52 AM, MD Danish Anwar wrote:
>> On 15/09/23 21:36, Andrew Davis wrote:
>>> On 9/13/23 1:05 AM, MD Danish Anwar wrote:
>>>> On 12/09/23 20:28, Andrew Davis wrote:
>>>>> On 9/12/23 3:29 AM, MD Danish Anwar wrote:
>>>>>> Hi Andrew,
>>>>>>
>>>>>> On 11/09/23 18:35, Andrew Davis wrote:
>>>>>>> On 9/11/23 2:12 AM, MD Danish Anwar wrote:
>>>>>>>> ICSSG2 provides dual Gigabit Ethernet support.
>>>>>>>>
>>>>>>>> For support SR2.0 ICSSG Ethernet firmware:
>>>>>>>> - provide different firmware blobs and use TX_PRU.
>>>>>>>> - IEP0 is used as PTP Hardware Clock and can only be used for one
>>>>>>>> port.
>>>>>>>> - TX timestamp notification comes via INTC interrupt.
>>>>>>>>
>>>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>>>> ---
>>>>>>>>      .../arm64/boot/dts/ti/k3-am654-base-board.dts | 123
>>>>>>>> ++++++++++++++++++
>>>>>>>
>>>>>>> Adding this to the base dts? What if I want to use my PRUs for
>>>>>>> something
>>>>>>> else? These "application nodes" define a single usecase out of many
>>>>>>> possible, and should IMHO always be in overlays so users can select
>>>>>>> which
>>>>>>> they want easily.
>>>>>>>
>>>>>>
>>>>>> The base board (AM654x-EVM) has two Ethernet ports dedicated for
>>>>>> ICSSG.
>>>>>> The expectation is that when a user boots up AM654x-EVM, ICSSG is
>>>>>> supported on those two ports by default. If the icssg nodes are not
>>>>>> added to base dts then by default the two Ethernet ports will have no
>>>>>> functionality.
>>>>>>
>>>>>
>>>>> This is *your* default use-case for these PRUs, mine might be
>>>>> different.
>>>>> I can agree that most might want this use-case too and this is the one
>>>>> intended as the demo for these ports on this board. What I am
>>>>> saying is
>>>>> that when one wants to use these PRUs for something else, having this
>>>>> one application baked into the base DTB makes it very difficult to
>>>>> switch.
>>>>>
>>>>
>>>> This is the intended use case. The base board has two ICSSG Ethernet
>>>> ports. My understanding is that device trees describe the hardware.
>>>>
>>>
>>> Correct, but you are not describing hardware here, you are describing
>>> software. Yes it is software that uses hardware so you are listing a
>>> bunch of hardware too, but the core is a firmware.
>>>
>>>> The base board dts should describe the base board hardware which has
>>>> the
>>>> two ICSSG ports. So the base board dts should contain nodes to enable
>>>> those two ports.
>>>>
>>>> Any hardware component that is not present in the base board should be
>>>> applied as an overlay.
>>>>
>>>
>>> Correct again, the firmware is not baked into the base board, that is
>>> loaded by U-Boot/Linux at runtime and can be selected.
>>>
>>>> For example in the AM654x-IDK, we have extra IDK card applied on the
>>>> base board. This IDK card contains 4 ICSSG Ethernet ports. The nodes
>>>> for
>>>> these 4 ICSSG port should go in an overlay i.e. k3-am654-idk.dtso which
>>>> I am doing as part of the patch 3 of this series.
>>>>
>>>> My understanding is that any hardware component that is part of the
>>>> base
>>>> board should be described in base-board.dts. Any hardware component
>>>> that
>>>> is not part of the base board and is added by extra cards should be
>>>> described in overlays.
>>>>
>>>>>> The primary use case is that ICSSG should support on those two
>>>>>> ports in
>>>>>> AM654x-EVM by default. The user should not need to apply any
>>>>>> overlay to
>>>>>> get the two ports working. So In order to achieve that I think it
>>>>>> is OK
>>>>>> to add the ICSSG nodes in the base board dts file.
>>>>>>
>>>>>
>>>>> A user does not need to apply an overlay to use these, this
>>>>> application
>>>>> node overlay can be applied at build time. You can even rename the
>>>>> base
>>>>> .dtb to be the one that has this overlay applied by default.
>>>>>
>>>>> Take a look at k3-am654-gp-evm.dtb, it is a composite DTB built from
>>>>> the "base-board" DTB and the "rocktech-rk101-panel" DTBO applied on
>>>>> top.
>>>>> This combination is what we call and sell as the "GP EVM", and you
>>>>> can use it by booting the "k3-am654-gp-evm.dtb". Now let's say you
>>>>> want to use a different panel, all you need to do is take the base-
>>>>> board and apply a different panel overlay. Had we hard-coded the
>>>>> "default" panel into the base-board DTS then a user with a different
>>>>> panel would have to go and edit the DTS to remove all the rk101-panel
>>>>> bits.
>>>>>
>>>>
>>>> This is one way to do it. But I still think the best way to do this is
>>>> to have the ICSSG nodes in base board dts as the ICSSG hardware is
>>>> present on the base board.
>>>>
>>>
>>> So again, you are not describing the hardware, you are describing a
>>> *use of* the hardware. This node describes what firmware to load and
>>> what bits of hardware that firmware should use to get some end result,
>>> but I could just as easily use a different firmware and give it
>>> different
>>> links to different hardware bits and make it into something else. No
>>> physical changes to the hardware needed.
>>>
>>>>>> If user wants to use PRUs for something else, we can have overlay for
>>>>>> those. But we should not need to apply any overlay to achieve the
>>>>>> primary functionality i.e. ICSSG working in the two dedicated ICSSG
>>>>>> Ethernet ports.
>>>>>>
>>>>>
>>>>> They could *not* simply add a different overlay for their usecase as
>>>>> you have baked your usecase into the base DTB. Their overlay would
>>>>> have to have a bunch of /delete-node/ junk to remove your "defaults".
>>>>>
>>>>
>>>> This patch adds one node "icssg2-eth" which uses six PRUs. If user
>>>> wants
>>>> to use PRUs for something else they can add "/delete-node/ &icssg2_eth"
>>>> in the overlay.
>>>>
>>>
>>> /delete-node/ is usually an indication some layering was done wrong,
>>> it shouldn't be needed in most cases to delete nodes. And that is
>>> my point here, I don't want to have to delete your use-case in
>>> every overlay file that uses the PRUs differently than you. Your
>>> use-case should simply be an overlay too, then all I have to do is
>>> apply my overlay instead of yours without deletes.
>>>
>>
>> Sure I understand this. But my expectation is as soon as you boot gp-evm
>> or base-board, you should be able to see the two ICSSG ports and they
>> should be working properly.
>>
>> If I move the ICSSG2 nodes from k3-am654-base-board.dtb to some overlay
>> and make k3-am654-gp-evm-dtb to have this overlay applied by default
>> using below then it will require to change u-boot as well.
>>
>> The only reason I am adding these ICSSG nodes to k3-am654-base-board.dtb
>> is because k3-am654-base-board.dtb is used by default to boot the board.
> 
> Seems we are making an ABI around the names of dtb files, guess that
> has always been kinda true.
> 
>> If I move ICSSG2 nodes to some dtbo and generate k3-am654-gp-evm-dtb
>> with that dtbo then we will need to use k3-am654-gp-evm-dtb as default
>> while booting AM65x GP EVM
>>
>> diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
>> index 755bff2707..f9249cb7f2 100644
>> --- a/board/ti/am65x/am65x.env
>> +++ b/board/ti/am65x/am65x.env
>> @@ -6,7 +6,7 @@
>>   #endif
>>
>>   findfdt=
>> -       setenv name_fdt ti/k3-am654-base-board.dtb;
>> +       setenv name_fdt ti/k3-am654-gp-evm-dtb;
>>          setenv fdtfile ${name_fdt}
>>   name_kern=Image
>>   console=ttyS2,115200n8
>>
>> If this is okay with you, I can go ahead and move ICSSG2 nodes to some
>> overlay.
>>
> 
> That is fine with me, booting the raw -base-board dtb by default
> in u-boot always seemed wrong to me anyway.
> 
> Another option is to rename the dts file and have the file called
> k3-am654-base-board.dtb be made from that + this new overlay,
> that way no change is needed in u-boot.
> 

So these are our options.
1. Create k3-am654-icssg2.dtso, have
k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
and change the default dtb in uboot.

2. Create k3-am654-icssg2.dtso, Rename k3-am654-base-board.dts to
k3-am654-evm.dts or something else. and have
k3-am654-base-board.dtbs := k3-am654-evm.dtb k3-am654-icssg2.dtbo
No change needed in uboot.

I am fine with both of these options. Option 2 makes more sense to me as
we won't need to change uboot in this case.

@Vignesh, Can you please let me know which one should I go ahead with.
Does option 2 looks OK to you?

> Andrew
> 
>> The ICSSG2 node will be part of k3-am654-icssg2.dtso
>> The ICSSG0 and ICSSG1 nodes will be part of k3-am654-idk.dtso
>>
>> Let me know if this looks OK to you.
>>
>>> Andrew
>>>
>>>>> As above, if this is the "primary functionality" then have this
>>>>> overlay applied by default:
>>>>>
>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>> @@ -42,7 +42,7 @@ dtb-$(CONFIG_ARCH_K3) +=
>>>>> k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
>>>>>      # Boards with AM65x SoC
>>>>> -k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>>>>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>>>> +k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>>>>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>>>> k3-am654-base-board-prueth.dtbo
>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>>>>
>>>>> Andrew
>>>>>
>>>>>>
>>>>>>> Andrew
>>>>>>>
>>>>>>>>      1 file changed, 123 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>>>>> b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>>>>> index f5c26e9fba98..5cf9546ff9f7 100644
>>>>>>>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>>>>> @@ -25,6 +25,8 @@ aliases {
>>>>>>>>              ethernet0 = &cpsw_port1;
>>>>>>>>              mmc0 = &sdhci0;
>>>>>>>>              mmc1 = &sdhci1;
>>>>>>>> +        ethernet1 = &icssg2_emac0;
>>>>>>>> +        ethernet2 = &icssg2_emac1;
>>>>>>>>          };
>>>>>>>>            chosen {
>>>>>>>> @@ -144,6 +146,72 @@ vtt_supply: regulator-3 {
>>>>>>>>              vin-supply = <&vcc3v3_io>;
>>>>>>>>              gpio = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
>>>>>>>>          };
>>>>>>>> +
>>>>>>>> +    /* Dual Ethernet application node on PRU-ICSSG2 */
>>>>>>>> +    icssg2_eth: icssg2-eth {
>>>>>>>> +        compatible = "ti,am654-icssg-prueth";
-- 
Thanks and Regards,
Md Danish Anwar
