Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728377AD33C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjIYIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjIYIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:22:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064C810E;
        Mon, 25 Sep 2023 01:22:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P8Lv9F118247;
        Mon, 25 Sep 2023 03:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695630117;
        bh=p6gt9baC8c8rsme8Bo+yhUVgFUMBBOgqzA9mgp1/qe8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=yNmW+lFDQiSeBmEhZBtumqOytU5gBh0fyuUDIwOu4xQvCcrPH3AUzqcg8N+VYMAyZ
         5bSaJkouxcsLu6CJJg8d080KhHITCGsf5Zmht6lt7jRIxcXHIBCTy9J7o05cOe4bCM
         aPwtb/bc7I61vE6QwAJbEml1NoAM9WH10iD4G5mM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P8Lvru050192
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Sep 2023 03:21:57 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 03:21:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 03:21:57 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P8LqHP082913;
        Mon, 25 Sep 2023 03:21:53 -0500
Message-ID: <8db10b88-5b06-af84-cb0a-9fbaa29cf78c@ti.com>
Date:   Mon, 25 Sep 2023 13:51:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3-am654-base-board: add ICSSG2
 Ethernet support
Content-Language: en-US
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
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
In-Reply-To: <52572af4-771e-3bd9-b290-74482694f020@ti.com>
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

Hi Andrew,

On 22/09/23 09:52, MD Danish Anwar wrote:
> On 21/09/23 22:57, Andrew Davis wrote:
>> On 9/21/23 1:09 AM, MD Danish Anwar wrote:
>>> ICSSG2 provides dual Gigabit Ethernet support.
>>>
>>> For support SR2.0 ICSSG Ethernet firmware:
>>> - provide different firmware blobs and use TX_PRU.
>>> - IEP0 is used as PTP Hardware Clock and can only be used for one port.
>>> - TX timestamp notification comes via INTC interrupt.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/Makefile               |   4 +-
>>>   ...se-board.dts => k3-am654-common-board.dts} |   0
>>>   arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso   | 145 ++++++++++++++++++
>>>   3 files changed, 148 insertions(+), 1 deletion(-)
>>>   rename arch/arm64/boot/dts/ti/{k3-am654-base-board.dts =>
>>> k3-am654-common-board.dts} (100%)
>>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/Makefile
>>> b/arch/arm64/boot/dts/ti/Makefile
>>> index e7b8e2e7f083..85c91f5e832e 100644
>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>> @@ -42,12 +42,14 @@ dtb-$(CONFIG_ARCH_K3) +=
>>> k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
>>>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
>>>     # Boards with AM65x SoC
>>> -k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>> +k3-am654-gp-evm-dtbs := k3-am654-common-board.dtb
>>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>>
>> Should the k3-am654-gp-evm.dtb not also have this icssg2 support? Does
>> it work
>> to keep this line like before or is there some conflict having both
>> enabled?
>>
> 
> I have not tested this dtb (k3-am654-gp-evm.dtb). So just to be on the
> safe side I kept gp-evm.dtb as it was. Ideally gp-evm.dtb should have
> icssg2 support as well. But I haven't tested the combination of
> base-board + icssg dtbo + rockteck dtbo. That is why I kept gp-evm dtb
> as it was. Anyways, for ICSSG2's use case only k3-am654-base-board.dtb
> is used so I think it's ok to leave k3-am654-gp-evm.dtb to as it was.
> 
>> Andrew
>>

I tested AM654x-GP EVM with k3-am654-gp-evm.dtb with both the
combination below (having k3-am654-base-board-dtbs :=
k3-am654-common-board.dtb k3-am654-icssg2.dtbo), ICSSG worked fine in
both the scenarios and I didn't see any issue. I don't have a rocktech
panel with me so couldn't test that. But as far as ICSSG is concerned it
works fine with the both the combinations. Please let me know which one
should I use. Should I keep gp-evm as it is (use dtb without the icssg2
overlay) or should I add icssg2 overlay in gp-evm.dtb as well.


1. k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
k3-am654-base-board-rocktech-rk101-panel.dtbo


2. k3-am654-gp-evm-dtbs := k3-am654-common-board.dtb
k3-am654-base-board-rocktech-rk101-panel.dtbo

-- 
Thanks and Regards,
Danish
