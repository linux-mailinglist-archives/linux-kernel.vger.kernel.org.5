Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36878DF66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjH3TGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243480AbjH3LLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:11:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F8CCF;
        Wed, 30 Aug 2023 04:11:04 -0700 (PDT)
X-UUID: e396f308472511eeb20a276fd37b9834-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=YhRvmurAP7YRVh7QRW6C3C4TvfzSRDnjtU87KinxIB8=;
        b=UFczTh9IxDNU/JIkAFMnxp4dm2/4uhugfMdt9KAcVbL4bS2Pf/c3QRe2Kf+3M7LODISSnkySnHbD5sNE+nVvAgzHnERBxZ6tPaXEuJEwExSH38u34YgfXzRmgaoxhbhsZJnch9vyP8yaCS8le8uRkIIpXLG6WC1NfLUFw27sYf4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b1bc7dac-7385-42ea-bb1b-873065067df2,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:0ad78a4,CLOUDID:638272c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e396f308472511eeb20a276fd37b9834-20230830
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 42832874; Wed, 30 Aug 2023 19:10:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Aug 2023 19:10:52 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 30 Aug 2023 19:10:51 +0800
Message-ID: <bfff8dc1-5f1c-1da8-488c-58e83cb1e651@mediatek.com>
Date:   Wed, 30 Aug 2023 19:10:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt6360: add PMIC MT6360 related
 nodes
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230825114623.16884-3-macpaul.lin@mediatek.com>
 <CAGXv+5FTuY=ZHB3-2Woit5amRZ=RxByGMq=LQp-es8tWEhAQUA@mail.gmail.com>
 <986d8056-3708-ed3d-1896-0fbc034ca53c@mediatek.com>
 <CAGXv+5E2kOOz59AMCvQv_as6SesDkt15b9uDOSZ_iJMytgf1gA@mail.gmail.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <CAGXv+5E2kOOz59AMCvQv_as6SesDkt15b9uDOSZ_iJMytgf1gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 18:51, Chen-Yu Tsai wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Mon, Aug 28, 2023 at 5:59 PM Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>>
>>
>> On 8/28/23 12:36, Chen-Yu Tsai wrote:
>> >
>> >
>> > External email : Please do not click links or open attachments until you
>> > have verified the sender or the content.
>> >
>> > On Fri, Aug 25, 2023 at 7:46 PM Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>> >>
>> >> MT6360 is the secondary PMIC for MT8195.
>> >> It supports USB Type-C and PD functions.
>> >> Add MT6360 related common nodes which is used for MT8195 platform, includes
>> >>  - charger
>> >>  - ADC
>> >>  - LED
>> >>  - regulators
>> >>
>> >> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> >> ---
>> >>  arch/arm64/boot/dts/mediatek/mt6360.dtsi | 112 +++++++++++++++++++++++
>>
>> [snip..]
>>
>> >> +       regulator {
>> >> +               compatible = "mediatek,mt6360-regulator";
>> >> +               LDO_VIN3-supply = <&mt6360_buck2>;
>> >> +
>> >> +               mt6360_buck1: buck1 {
>> >> +                       regulator-compatible = "BUCK1";
>> >> +                       regulator-name = "mt6360,buck1";
>> >
>> > Normally there's no need to provide a default name. Any used regulator
>> > should have been named to match the power rail name from the board's
>> > schematics.
>> >
>>
>> I have 2 schematics on hand. One is mt8195-demo board and the other is
>> genio-1200-evk board. There are 2 PMIC used on these board
>> with "the same" sub power rail name for "BUCK1~BUCK4". One is mt6315,
>> and the other is mt6360.
> 
> This is more of an board level integration thing. Regulator names are
> expected to be named after the actual power rail names. For example,
> take a look at Rock Pi 4 schematics [1], the power rail from BUCK1 of
> the RK808 PMIC is named "VDD_CENTER". And in the dts file [1] we can
> see the regulator is named that as well (albeit with some style changes).
> 
> Now if a project really chooses meaningless names like BUCKx or LDOy
> for their power rails, then so be it. However those are board level
> decisions. The names are there to help with integration debugging, so
> it makes sense to have names that match the power rail names in the
> schematics. Default names rarely make sense.
> 
> [1]https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf  <https://urldefense.com/v3/__https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf__;!!CTRNKA9wMg0ARbw!g4T6kWfnETA38Kc_yc6dx6gYi7zzW2m6YU0ybNN5vbTWjK5SfapEQEQMrtxg8E9xRNdpJm678Rj3uLrWHeM$>
> [2]https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi#L267  <https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi*L267__;Iw!!CTRNKA9wMg0ARbw!g4T6kWfnETA38Kc_yc6dx6gYi7zzW2m6YU0ybNN5vbTWjK5SfapEQEQMrtxg8E9xRNdpJm678Rj3hdwm0VA$>
> 
>> I've also inspected other dtsi of the regulators, such as mt6357 and
>> mt6359. They have regulator nodes with named for their purpose. For the
>> schematics of mt8195-demo and genio-1200-evk boards, there are no
>> explicit usage for "BUCK1~BUCK4" for both mt6135 and mt6360. In order to
>> specify the sub power rail for mt6360, MediaTek chooses name like
>> "mt6360,buck1" instead of simple name "buck1" for distinguish with
>> "buck1" of mt6351.
>>
>> >> +                       regulator-min-microvolt = <300000>;
>> >> +                       regulator-max-microvolt = <1300000>;
>> >
>> > These values correspond to the regulator's range. They make no sense as
>> > regulator constraints. The min/max values are supposed to be the most
>> > restrictive set of voltages of the regulator consumers. If what is fed
>> > by this regulator can only take 0.7V ~ 1.1V, then it should save 0.7V
>> > and 1.1V here. If the regulator is unused, then there are no constraints,
>> > and these can be left out.
>> >
>> > Just leave them out of the file.
>> >Alexandre Mergnat <amergnat@baylibre.com>
>> > Both comments apply to all the regulators.
>> >
>> > ChenYu
>>
>> There are some common circuit design for these regulators like mt6359,
>> mt6360 and mt6315 used on many products. MediaTek put the most common
>> and expected default values in their dtsi. However, some changes still
>> need to be applied to derivative boards according to product's
>> requirements. The actual value be used will be applied in board's dts
>> file to override the default settings in dtsi.
> 
> The values here are definitely not some product's expected values.
> They are the full range of output voltages supported, as seen in the
> driver.
> 
> The regulator binding says:
> 
>      regulator-min-microvolt:
>        description: smallest voltage consumers may set
> 
>      regulator-max-microvolt:
>        description: largest voltage consumers may set
> 
> The constraints given in the regulator node are those of the consumers,
> not the PMIC regulator itself. As you mentioned, a board may need to
> adjust the range based on its design, i.e. what the board has connected
> to the regulator.
> 
> So either something is connected, and the consumer's constraints are set
> by overriding the default in the board .dts file; or, nothing is connected
> and the constraints don't matter, as nothing is going to set the voltage
> or enable the regulator. So there's no reason to give a default. For
> unused regulator outputs, their device nodes don't even have to exist.
> 
> I'm trying to get people to _not_ write default values, as they don't
> make any sense. The full voltage range is already implied by the
> compatible string.
> 
> ChenYu

Thanks for the explanation in detail.
I'll update the patch v2 for these modification.

Best regards,
Macpaul Lin
