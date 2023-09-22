Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87667AB42F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjIVOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjIVOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:54:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4F197;
        Fri, 22 Sep 2023 07:54:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MEs70k011093;
        Fri, 22 Sep 2023 09:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695394447;
        bh=TZVMQayGRhHcaKx2mOAr28HaXotkI2jbH1a15cXDYfw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mJou6nPic9AcmKDZOFTbHstrerVOEeA7RSD6z44gvMb1V5PDtYtDsSQTHU0ot+XA0
         2xcOm3upGve647r+fg6AG78ej+gAybJjXdKATtklN+o+YlpINAzL6pWwEDvmsf1rZ8
         Q8NB/xnOjUVu7tO+v4G9lVKMnwnEHnK8Ae65Gn9s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MEs7MF026513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 09:54:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 09:54:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 09:54:07 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MEs6Yv005056;
        Fri, 22 Sep 2023 09:54:06 -0500
Message-ID: <d5a01d2c-56f7-707f-5b21-9ccb3eb00158@ti.com>
Date:   Fri, 22 Sep 2023 09:54:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] arm64: dts: ti: am642-evm: Add overlay for NAND
 expansion card
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, <david@gibson.dropbear.id.au>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20230920133450.54226-1-rogerq@kernel.org>
 <20230920133450.54226-3-rogerq@kernel.org>
 <20230920135802.3ej2wcuaruqjidel@uncouth>
 <e8f26137-1284-4f45-a74d-a0a5f2aa2f93@kernel.org>
 <20230920164424.rrjvm6nvtv4ysyrw@unreal>
 <c7ec6ccd-37de-244d-0b3b-cb5d13bae539@ti.com>
 <6f2b38f8-1962-46f2-a095-b1eaf99ed407@kernel.org>
 <f79f521b-bfaf-27d2-f152-2f2f21d6f2b7@ti.com>
 <3eef2d49-d13e-40cf-a633-94b52948b065@kernel.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <3eef2d49-d13e-40cf-a633-94b52948b065@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 4:03 AM, Roger Quadros wrote:
> 
> 
> On 21/09/2023 20:23, Andrew Davis wrote:
>> On 9/21/23 6:37 AM, Roger Quadros wrote:
>>> On 20/09/2023 20:06, Andrew Davis wrote:
>>>> On 9/20/23 11:44 AM, Nishanth Menon wrote:
>>>>> On 18:18-20230920, Roger Quadros wrote:
>>>>>>
>>>>>>
>>>>>> On 20/09/2023 16:58, Nishanth Menon wrote:
>>>>>>> On 16:34-20230920, Roger Quadros wrote:
>>>>>>>> The NAND expansion card plugs in over the HSE (High Speed Expansion)
>>>>>>>> connector. Add support for it.
>>>>>>>>
>>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>>>>> ---
>>>>>>>>     arch/arm64/boot/dts/ti/Makefile               |   1 +
>>>>>>>>     arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++++++++++
>>>>>>>>     2 files changed, 141 insertions(+)
>>>>>>>>     create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>>>>>> index 06d6f264f292..ece74085a6be 100644
>>>>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>>>>> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
>>>>>>>>       # Boards with AM64x SoC
>>>>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>>>>>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtbo
>>>>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>>>>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>>>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>>>>>>>
>>>>>>> Also see https://lore.kernel.org/all/20230911165610.GA1362932-robh@kernel.org/
>>>>>>>
>>>>>>> you may not get the dtbo installed when doing make dtbs_install
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>
>>>>>> $ v8make dtbs_install INSTALL_DTBS_PATH=/tmp
>>>>>>      INSTALL /tmp/ti/k3-am625-beagleplay.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-phyboard-lyra-rdk.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-sk.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dahlia.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dev.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-verdin-nonwifi-yavia.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-verdin-wifi-dahlia.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-verdin-wifi-dev.dtb
>>>>>>      INSTALL /tmp/ti/k3-am625-verdin-wifi-yavia.dtb
>>>>>>      INSTALL /tmp/ti/k3-am62-lp-sk.dtb
>>>>>>      INSTALL /tmp/ti/k3-am62x-sk-hdmi-audio.dtbo
>>>>>>      INSTALL /tmp/ti/k3-am62a7-sk.dtb
>>>>>>      INSTALL /tmp/ti/k3-am62p5-sk.dtb
>>>>>>      INSTALL /tmp/ti/k3-am642-evm.dtb
>>>>>>      INSTALL /tmp/ti/k3-am642-evm-nand.dtbo
>>>>>> ^^^^
>>>>>>      INSTALL /tmp/ti/k3-am642-phyboard-electra-rdk.dtb
>>>>>>      INSTALL /tmp/ti/k3-am642-sk.dtb
>>>>>>
>>>>>>
>>>>>> What did I miss?
>>>>>
>>>>> I missed it, actually. See Rob's comment:
>>>>> https://lore.kernel.org/all/CAL_Jsq+GR3hP6hFvFn2z5aXvSXnh9butD3aKZ-y_XJgx0_YPTw@mail.gmail.com/
>>>>>
>>>>> Having orphan dtbo is apparently frowned upon
>>>>>
>>>>
>>>> And if you apply these overlays to the base DTB then it gets
>>>> symbols added automatically, no need for your patch [1/2] here.
>>>>
>>>
>>> Is this OK?
>>>
>>>      k3-am642-evm-nand-dtbs := k3-am642-evm.dtb k3-am642-evm-nand.dtbo
>>>      dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtb
>>>
>>> So patch 1 is not required in this case but we have an
>>> extra dtb file which is not really required.
>>>
>>
>> While I agree we will end up with several pre-overlayed DTB files
>> that are arguably not required as they could be later built/applied,
>> until we find a better way to check at build time these overlays
>> need applied to something as a test.
>>
>>> I have 2 more issues to point out
>>>
>>> 1)
>>> With existing examples e.g. J7200 EVM
>>> wouldn't  k3-j7200-evm.dtb include the k3-j7200-evm-quad-port-eth-exp.dtbo?
>>> Is this what we really want?
>>>
>>> likewise for k3-j721e-evm.dtb and k3-am654-gp-evm.dtb
>>>
>>
>> Yes, that is the idea, the base-board.dtb is just the raw main board, but
>> the "EVM" when you buy it comes with the quad-port daughtercard attached.
>> That is what we consider the "EVM" and the DTB names match that.
>>
>>> 2)
>>> Another issue (unrelated to this change) is the below warning:
>>>
>>>      arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #address-cells value
>>>      arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #size-cells value
>>>
>>> This is because we use the 'ranges' property in the gpmc0 node
>>> and the compiler doesn't know the #address/size-cells of the
>>> parent node.
>>>
>>> Is there a trick to specify it in the dtso file?
>>>
>>
>> Hmm, seems like a tricky one. Do you really need to do the ranges here?
>> Could you use the default `ranges;` for gpmc0? Then do the range translation
>> down inside the nand node to keep the partition addresses sane.
> 
> GPMC has separate address spaces per chip select.
> 
>  From Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
>    ranges:
>      minItems: 1
>      description: |
>        Must be set up to reflect the memory layout with four
>        integer values for each chip-select line in use,
>        <cs-number> 0 <physical address of mapping> <size>
> 
> The ranges location in the device tree overlay is correct. The overlay is
> meaningless without the base tree.
> 
> The correct solution would be to fix dtc so it doesn't print this warning
> for DT overlays.
> 

This may be too much and we would miss valid cases for this warning.

Maybe that is okay here, but we would need to add a warning/check
when applying overlays for mismatch sizes, right now that seems to
be missing.

Andrew

> i.e.
> 
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 9f31d2607182..dcb0a6f6f3fb 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -1203,6 +1203,9 @@ static void check_avoid_default_addr_size(struct check *c, struct dt_info *dti,
>          if (!reg && !ranges)
>                  return;
>   
> +       if (streq(node->name, "__overlay__"))
> +               return;
> +
>          if (node->parent->addr_cells == -1)
>                  FAIL(c, dti, node, "Relying on default #address-cells value");
> 
> 
