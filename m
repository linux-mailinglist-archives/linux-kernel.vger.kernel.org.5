Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBD97933CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbjIFClr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241049AbjIFClq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:41:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA1E41;
        Tue,  5 Sep 2023 19:41:39 -0700 (PDT)
X-UUID: e22a69084c5e11ee8051498923ad61e6-20230906
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=wU2b4FfMrOH1WfUlVsQQlHq+T7r0NVr/yzvkGrizXGY=;
        b=kzjlTPaae/Jb44katXMSg89T66JNpC1LyuIaFKuJp+wHyPSWFFlGu2u1y/W0Db7Bb55hMLX0+ly6CW5QszZXtWWDuw6cSLOr31uKK0ATDW7du9c3G2nKsSRVp76JaF8Ct9GlSbrQ6Izg+a/jZ+hZeJSNhQBVyqrm56We/h/+gPQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:1380620d-96d0-4c5e-9b5c-f2557438dd9e,IP:0,U
        RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:0ad78a4,CLOUDID:83c1b0c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e22a69084c5e11ee8051498923ad61e6-20230906
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2012800782; Wed, 06 Sep 2023 10:41:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Sep 2023 10:41:28 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 6 Sep 2023 10:41:24 +0800
Message-ID: <0acb43c3-3164-2a17-0105-84dbd533af8a@mediatek.com>
Date:   Wed, 6 Sep 2023 10:41:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8395-evk
 board
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <e2e35d4d-7853-fccc-28c2-b8ecf309d6ec@linaro.org>
 <00f0a1cf-6246-92e9-13b0-cf31bb292a94@mediatek.com>
 <97b82a16-8710-9430-35c8-673381aaa417@linaro.org>
 <d5645707-bcb0-4d4b-1d94-d3cd17c042fb@mediatek.com>
 <ddbc2681-bbda-88a1-643c-54fcabc9b83a@linaro.org>
 <bf8394c6-5460-8696-f46b-0c39927aaf84@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <bf8394c6-5460-8696-f46b-0c39927aaf84@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 18:58, AngeloGioacchino Del Regno and Krzsztof Kozlowski wrote:
> Il 05/09/23 12:36, Krzysztof Kozlowski ha scritto:
>> On 05/09/2023 11:36, Macpaul Lin wrote:
>>>
>>>
>>> On 9/4/23 20:11, Krzysztof Kozlowski wrote:
>>>>
>>>>
>>>> External email : Please do not click links or open attachments until 
>>>> you
>>>> have verified the sender or the content.
>>>>
>>>> On 04/09/2023 11:50, Macpaul Lin wrote:
>>>>>
>>>>>
>>>>> On 9/4/23 17:33, Krzysztof Kozlowski wrote:
>>>>>>
>>>>>>
>>>>>> External email : Please do not click links or open attachments 
>>>>>> until you
>>>>>> have verified the sender or the content.
>>>>>>
>>>>>> On 04/09/2023 11:20, Macpaul Lin wrote:
>>>>>>> Add bindings for the MediaTek mt8395-evk board.
>>>>>>> The mt8359-evk board is also named as "Genio 1200-EVK".
>>>>>>> MT8195 and MT8395 are the same family series SoC could share
>>>>>>
>>>>>> How can be the same and have different numbers? You sill need 
>>>>>> dedicated
>>>>>> compatible.
>>>>>>
>>>>>
>>>>> The SoCs mt8195 and mt8395 are designed for different market 
>>>>> application
>>>>> and physical characteristics, using different efuse values for
>>>>> distinction. The booting flow and configurations are controllered 
>>>>> by the
>>>>> boot loaders, firmware, and TF-A. Therefore, the part numbers and
>>>>> procurement channels are different. The detail information of these
>>>>> efuse values is proprietary, so I cant disclose it futher. Hence the
>>>>> most of peripheral drivers and base address are almost the same.
>>>>
>>>> 1. Drivers? So we talk about compatibility, not the same.
>>>> 2. "almost the same" is not the same. Follow the guidelines for writing
>>>> bindings.
>>>>
>>>
>>> Thanks for the review.
>>>
>>> After internal confirmation and discussion, it can be confirmed that the
>>> MT8195 and MT8395 are identical SoCs from to binding's perspective.
>>
>> I am sorry, but I really do not care what you internally discussed about
>> bindings. I do not think your internal review respect existing
>> guidelines. You talked about drivers, not "bindings perspective", so
>> your internal discussion is clearly discussing something else.
>>
>>> MediaTek hope the mt8395 boards could directly use mt8195.dtsi, without
>>> the need to create a separate mt8395.dtsi to include mt8195.dtsi.
>>> Therefore, we hope to fully adopt the bindings of mt8195. However, I
>>> will submit a revised patch for compatible since they are different 
>>> boards.
>>
>> You can disagree but then I expect arguments from your side.
>>
> 
> In short - they're the same chip, as in, they behave the same on a 
> *hardware*
> perspective; what changes is the bootchain (plus stricter security from 
> TF-A)
> and allowable temperature ranges for operation, that's practically it...
> 
> ...so yes the compatible for the "new soc" must be documented, but that's
> practically just a revision, *not a new soc* at all.
> 
> (though, I agree that seeing a different name as in 1 -> 3 can be totally
> confusing)
> 
> The drivers difference that Macpaul hinted to are about drivers needing 
> some
> SMC calls instead of direct MMIO manipulation, so, something like two 
> bindings
> for something like two drivers will need to add a 8395 compatible; 
> speaking of
> what we would have in a devicetree for this SoC, that'd be exactly 99% 
> identical
> to mt8195.dtsi.
> 
> Anyway, drivers are drivers, bindings describe hardware - and the hw is, 
> again,
> the same...
> 
> Hope that this makes things clearer! :-)
> 
> Cheers,
> Angelo

Thanks for your patience and clarification.
I'll submit new SOC binding and revise the patches for mt8395 board.

Thanks
Macpaul Lin
