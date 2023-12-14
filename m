Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B495813921
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjLNRyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNRyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:54:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDB7CF;
        Thu, 14 Dec 2023 09:54:28 -0800 (PST)
X-UUID: cfd594fa9aa911eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=QtivBajJ2uEBe/N9gJN8n3kJKYyoOgnif0RBAayWfuQ=;
        b=ql44oSG2Bhr9l3tkGQz4JLjMujdHaHk2gtPBefJsL/VTiueEMMjVViLtSgyRnVhqwW1hmY/VtdvArqL73TIfpghrnEHb8EOHmW0hDFM2jKF/5CfP5LCBKk1JDaS+wf721FWyHMHbCM0OZZFVoGwrDqkVgwKOXwGRdCKpyzCDbVw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1c84478b-279d-43a1-a913-32752cb4efb4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:284fcc73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cfd594fa9aa911eeba30773df0976c77-20231215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1779464143; Fri, 15 Dec 2023 01:54:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 01:54:21 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 15 Dec 2023 01:54:20 +0800
Message-ID: <1ce43346-3f60-b614-cdcc-7d9db8dec758@mediatek.com>
Date:   Fri, 15 Dec 2023 01:54:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: mediatek: remove broken pmic interrupt property
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@kernel.org>, <soc@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ben Lok <ben.lok@mediatek.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <bear.wang@mediatek.com>,
        <pablo.sun@mediatek.com>, <wenst@chromium.org>
References: <20231212214737.230115-1-arnd@kernel.org>
 <bc5dafe4-5487-4794-97f1-f4e4d967a665@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <bc5dafe4-5487-4794-97f1-f4e4d967a665@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 19:09, AngeloGioacchino Del Regno wrote:

> Il 12/12/23 22:47, Arnd Bergmann ha scritto:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The pmic is connected to the GIC, which uses four-cell interrupt 
>> properties,
>> but its interrupt is specified as two-cell that would only make sense 
>> for
>> the GPIO irqchip:
>>
>> arch/arm64/boot/dts/mediatek/mt8195.dtsi:464.4-27: Warning 
>> (interrupts_property): /soc/i2c@11d01000/pmic@34:#interrupt-cells: 
>> size is (8), expected multiple of 16
>>
>> Remove the interrupt for now to shut up the warning. When someone 
>> figures out
>> what the correct interrupt and parent are, we can add it back.
>>
>
> Please, can anyone from MediaTek comment on that?

Sorry for late response, I've just stuck in other tasks and didn't 
notice this

patch is for genio-1200-evk. I've tested 6.7-rc1 but I thought it might 
be an issue

in origin mt8195.dtsi and not be related to board dts.

> I see a mt6360_pins on PIO:
>             pinmux = <PINMUX_GPIO17__FUNC_GPIO17>,
>                  <PINMUX_GPIO128__FUNC_GPIO128>;
>
> ...and that's GPIO128, which may effectively be the IRQ pin for MT6360.
>
> Still, I'm not sure whether the interrupt is on GIC or PIO, please 
> clarify,
> otherwise we will have to get this commit upstream.
>
I think it could be solved by adding

'interrupt-parent = <&pio>;' to mt6360 node.

But currently I have no much time to verify it.

I'll try to find some time to find out the solution tomorrow.

> Thanks,
> Angelo
>
>> Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for Genio 
>> 1200 EVK board")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> index 70b465f7c6a7..a409ef998746 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> @@ -238,8 +238,6 @@ &i2c6 {
>>       mt6360: pmic@34 {
>>           compatible = "mediatek,mt6360";
>>           reg = <0x34>;
>> -        interrupts = <128 IRQ_TYPE_EDGE_FALLING>;
>> -        interrupt-names = "IRQB";
>>           interrupt-controller;
>>           #interrupt-cells = <1>;
>>           pinctrl-0 = <&mt6360_pins>;
>

Thanks for pointing out the issue! Let's see if it could be solved by 
adding 'interrupt-parents'.

Macpaul Lin

