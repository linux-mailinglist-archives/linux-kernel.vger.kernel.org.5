Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35F378A97F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjH1J77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjH1J7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:59:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08D91;
        Mon, 28 Aug 2023 02:59:37 -0700 (PDT)
X-UUID: 94a7f7e4458911eeb20a276fd37b9834-20230828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=ULLZemRhMxAbFZxKNtJLD9ABVZO2iMvHhuIqtLS4lLw=;
        b=E3cwQxcPYVQR8cxJIvlU+VpUcB694ACP19v5Ljx3qi0sp6iSYy1YI7K8D7Hre60Nk9XkrEUMf9QTmvcfnCJvDqkraZHOibfM+MfKesDDUjgkFpq8k17J046sfy45xq5vCLeSDLKvZQfCTETqk+JAf+7VEqCIuTgCAJJ3r3PoH6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:3c843121-223a-4bb5-8667-6265dbe0a20f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:3c843121-223a-4bb5-8667-6265dbe0a20f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:3ef24413-4929-4845-9571-38c601e9c3c9,B
        ulkID:230828123614SOTZ7U80,BulkQuantity:8,Recheck:0,SF:64|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 94a7f7e4458911eeb20a276fd37b9834-20230828
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 265903182; Mon, 28 Aug 2023 17:59:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Aug 2023 17:59:28 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 28 Aug 2023 17:59:25 +0800
Message-ID: <986d8056-3708-ed3d-1896-0fbc034ca53c@mediatek.com>
Date:   Mon, 28 Aug 2023 17:59:23 +0800
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
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230825114623.16884-3-macpaul.lin@mediatek.com>
 <CAGXv+5FTuY=ZHB3-2Woit5amRZ=RxByGMq=LQp-es8tWEhAQUA@mail.gmail.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <CAGXv+5FTuY=ZHB3-2Woit5amRZ=RxByGMq=LQp-es8tWEhAQUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/23 12:36, Chen-Yu Tsai wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Fri, Aug 25, 2023 at 7:46 PM Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>>
>> MT6360 is the secondary PMIC for MT8195.
>> It supports USB Type-C and PD functions.
>> Add MT6360 related common nodes which is used for MT8195 platform, includes
>>  - charger
>>  - ADC
>>  - LED
>>  - regulators
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt6360.dtsi | 112 +++++++++++++++++++++++

[snip..]

>> +       regulator {
>> +               compatible = "mediatek,mt6360-regulator";
>> +               LDO_VIN3-supply = <&mt6360_buck2>;
>> +
>> +               mt6360_buck1: buck1 {
>> +                       regulator-compatible = "BUCK1";
>> +                       regulator-name = "mt6360,buck1";
> 
> Normally there's no need to provide a default name. Any used regulator
> should have been named to match the power rail name from the board's
> schematics.
> 

I have 2 schematics on hand. One is mt8195-demo board and the other is 
genio-1200-evk board. There are 2 PMIC used on these board
with "the same" sub power rail name for "BUCK1~BUCK4". One is mt6315, 
and the other is mt6360.

I've also inspected other dtsi of the regulators, such as mt6357 and 
mt6359. They have regulator nodes with named for their purpose. For the
schematics of mt8195-demo and genio-1200-evk boards, there are no 
explicit usage for "BUCK1~BUCK4" for both mt6135 and mt6360. In order to 
specify the sub power rail for mt6360, MediaTek chooses name like 
"mt6360,buck1" instead of simple name "buck1" for distinguish with 
"buck1" of mt6351.

>> +                       regulator-min-microvolt = <300000>;
>> +                       regulator-max-microvolt = <1300000>;
> 
> These values correspond to the regulator's range. They make no sense as
> regulator constraints. The min/max values are supposed to be the most
> restrictive set of voltages of the regulator consumers. If what is fed
> by this regulator can only take 0.7V ~ 1.1V, then it should save 0.7V
> and 1.1V here. If the regulator is unused, then there are no constraints,
> and these can be left out.
> 
> Just leave them out of the file.
> 
> Both comments apply to all the regulators.
> 
> ChenYu

There are some common circuit design for these regulators like mt6359, 
mt6360 and mt6315 used on many products. MediaTek put the most common 
and expected default values in their dtsi. However, some changes still 
need to be applied to derivative boards according to product's 
requirements. The actual value be used will be applied in board's dts 
file to override the default settings in dtsi.

The regulator node "mt6360,ldo6" is not used by mt8195-demo and 
genio-1200-evk. I'll remove it in the next version.
Thanks for the review.

>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP
>> +                                                  MT6360_OPMODE_ULP>;
>> +               };
>> +
>> +               mt6360_buck2: buck2 {
>> +                       regulator-compatible = "BUCK2";
>> +                       regulator-name = "mt6360,buck2";
>> +                       regulator-min-microvolt = <300000>;
>> +                       regulator-max-microvolt = <1300000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP
>> +                                                  MT6360_OPMODE_ULP>;
>> +               };
>> +
>> +               mt6360_ldo1: ldo1 {
>> +                       regulator-compatible = "LDO1";
>> +                       regulator-name = "mt6360,ldo1";
>> +                       regulator-min-microvolt = <1200000>;
>> +                       regulator-max-microvolt = <3600000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP>;
>> +               };
>> +
>> +               mt6360_ldo2: ldo2 {
>> +                       regulator-compatible = "LDO2";
>> +                       regulator-name = "mt6360,ldo2";
>> +                       regulator-min-microvolt = <1200000>;
>> +                       regulator-max-microvolt = <3600000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP>;
>> +               };
>> +
>> +               mt6360_ldo3: ldo3 {
>> +                       regulator-compatible = "LDO3";
>> +                       regulator-name = "mt6360,ldo3";
>> +                       regulator-min-microvolt = <1200000>;
>> +                       regulator-max-microvolt = <3600000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP>;
>> +               };
>> +
>> +               mt6360_ldo5: ldo5 {
>> +                       regulator-compatible = "LDO5";
>> +                       regulator-name = "mt6360,ldo5";
>> +                       regulator-min-microvolt = <2700000>;
>> +                       regulator-max-microvolt = <3600000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP>;
>> +               };
>> +
>> +               mt6360_ldo6: ldo6 {
>> +                       regulator-compatible = "LDO6";
>> +                       regulator-name = "mt6360,ldo6";
>> +                       regulator-min-microvolt = <500000>;
>> +                       regulator-max-microvolt = <2100000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP>;
>> +               };
>> +
>> +               mt6360_ldo7: ldo7 {
>> +                       regulator-compatible = "LDO7";
>> +                       regulator-name = "mt6360,ldo7";
>> +                       regulator-min-microvolt = <500000>;
>> +                       regulator-max-microvolt = <2100000>;
>> +                       regulator-allowed-modes = <MT6360_OPMODE_NORMAL
>> +                                                  MT6360_OPMODE_LP>;
>> +               };
>> +       };
>> +};
>> --
>> 2.18.0
>>

Best regards,
Macpaul Lin.
