Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901877AE474
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjIZELl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjIZELf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:11:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8120EC;
        Mon, 25 Sep 2023 21:11:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38Q4Ault117691;
        Mon, 25 Sep 2023 23:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695701456;
        bh=8FskWr9ivCrbrfrBejroOfp5cPTyHuS9Y94xhIafONc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=i7Pqo+MK3wRcWZkCJBgYgHbXOBcgxDd9ynkeqh6wzG4Df8N4eq8IvYf86cIOrtnuh
         ZbprZg2cf8ln+M/QhkvzSyrU+TimQybrxHObPSk2NMhBzk7LOJC6EZlZDlwM6e6gwb
         l2dFVdeaLQvelnQN6xhjvX6UE+quf3BMk9MsM4KM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38Q4AuAW019443
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Sep 2023 23:10:56 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 23:10:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 23:10:56 -0500
Received: from [10.249.135.225] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38Q4AqSY122072;
        Mon, 25 Sep 2023 23:10:52 -0500
Message-ID: <c11ce7e2-d388-cb81-f133-d57eefa14f95@ti.com>
Date:   Tue, 26 Sep 2023 09:40:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3-am654-base-board: add ICSSG2
 Ethernet support
Content-Language: en-US
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
References: <20230921060913.721336-1-danishanwar@ti.com>
 <20230921060913.721336-3-danishanwar@ti.com>
 <3b4629c7-5625-f32f-0532-5f50832c1714@ti.com>
 <52572af4-771e-3bd9-b290-74482694f020@ti.com>
 <8db10b88-5b06-af84-cb0a-9fbaa29cf78c@ti.com>
 <3869499c-532d-8cd0-f428-6697bbbedd8d@ti.com>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <3869499c-532d-8cd0-f428-6697bbbedd8d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 7:15 PM, Andrew Davis wrote:
> On 9/25/23 3:21 AM, MD Danish Anwar wrote:
>> Hi Andrew,
>>
>> On 22/09/23 09:52, MD Danish Anwar wrote:
>>> On 21/09/23 22:57, Andrew Davis wrote:
>>>> On 9/21/23 1:09 AM, MD Danish Anwar wrote:
>>>>> ICSSG2 provides dual Gigabit Ethernet support.
>>>>>
>>>>> For support SR2.0 ICSSG Ethernet firmware:
>>>>> - provide different firmware blobs and use TX_PRU.
>>>>> - IEP0 is used as PTP Hardware Clock and can only be used for one
>>>>> port.
>>>>> - TX timestamp notification comes via INTC interrupt.
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/ti/Makefile               |   4 +-
>>>>>    ...se-board.dts => k3-am654-common-board.dts} |   0
>>>>>    arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso   | 145
>>>>> ++++++++++++++++++
>>>>>    3 files changed, 148 insertions(+), 1 deletion(-)
>>>>>    rename arch/arm64/boot/dts/ti/{k3-am654-base-board.dts =>
>>>>> k3-am654-common-board.dts} (100%)
>>>>>    create mode 100644 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile
>>>>> b/arch/arm64/boot/dts/ti/Makefile
>>>>> index e7b8e2e7f083..85c91f5e832e 100644
>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>> @@ -42,12 +42,14 @@ dtb-$(CONFIG_ARCH_K3) +=
>>>>> k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
>>>>>      # Boards with AM65x SoC
>>>>> -k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>>>>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>>>> +k3-am654-gp-evm-dtbs := k3-am654-common-board.dtb
>>>>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>>>
>>>> Should the k3-am654-gp-evm.dtb not also have this icssg2 support? Does
>>>> it work
>>>> to keep this line like before or is there some conflict having both
>>>> enabled?
>>>>
>>>
>>> I have not tested this dtb (k3-am654-gp-evm.dtb). So just to be on the
>>> safe side I kept gp-evm.dtb as it was. Ideally gp-evm.dtb should have
>>> icssg2 support as well. But I haven't tested the combination of
>>> base-board + icssg dtbo + rockteck dtbo. That is why I kept gp-evm dtb
>>> as it was. Anyways, for ICSSG2's use case only k3-am654-base-board.dtb
>>> is used so I think it's ok to leave k3-am654-gp-evm.dtb to as it was.
>>>
>>>> Andrew
>>>>
>>
>> I tested AM654x-GP EVM with k3-am654-gp-evm.dtb with both the
>> combination below (having k3-am654-base-board-dtbs :=
>> k3-am654-common-board.dtb k3-am654-icssg2.dtbo), ICSSG worked fine in
>> both the scenarios and I didn't see any issue. I don't have a rocktech
>> panel with me so couldn't test that. But as far as ICSSG is concerned it
>> works fine with the both the combinations. Please let me know which one
>> should I use. Should I keep gp-evm as it is (use dtb without the icssg2
>> overlay) or should I add icssg2 overlay in gp-evm.dtb as well.
>>
>>
>> 1. k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>
>>
>> 2. k3-am654-gp-evm-dtbs := k3-am654-common-board.dtb
>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>
> 
> As you said here before, most will expect the icssg2 to work
> on the EVM out of box, you should include it. If anyone wants
> something else they can apply the set of overlays that match
> on their own.
> 
> So, use base-board.
> 
> Andrew

Sure Andrew, I will make the change and send v3.

-- 
Thanks and Regards,
Md Danish Anwar
