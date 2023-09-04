Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAC7914FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbjIDJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjIDJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:50:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A24AB;
        Mon,  4 Sep 2023 02:50:12 -0700 (PDT)
X-UUID: 6d7e64264b0811eea33bb35ae8d461a2-20230904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=pDcVkHt0PgOyyDOoExjE+TeYuugV9WTIUjuLd6MGDyg=;
        b=GxzsFXWXOCMWi9zBfbTxmpjGlIEVIEiwC1jgnV33zN5mhITHMwT+ReosEUxbq5ZLvxj9NYb2bdjabCqTEH1hjr4cGZ4n3jDbTtjrGk47GW6lVmblmtWiZtVy9+bMXwoVsZrYB+XuXnA+Wer/lYoIMX7zUBho1T2eSbO2z3tQA04=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:50857094-f2af-43a7-8087-da395980b8a2,IP:0,U
        RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:3
X-CID-META: VersionHash:0ad78a4,CLOUDID:1b691720-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6d7e64264b0811eea33bb35ae8d461a2-20230904
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1406635621; Mon, 04 Sep 2023 17:50:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Sep 2023 17:50:05 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 4 Sep 2023 17:50:03 +0800
Message-ID: <00f0a1cf-6246-92e9-13b0-cf31bb292a94@mediatek.com>
Date:   Mon, 4 Sep 2023 17:50:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8395-evk
 board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <e2e35d4d-7853-fccc-28c2-b8ecf309d6ec@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/23 17:33, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 04/09/2023 11:20, Macpaul Lin wrote:
>> Add bindings for the MediaTek mt8395-evk board.
>> The mt8359-evk board is also named as "Genio 1200-EVK".
>> MT8195 and MT8395 are the same family series SoC could share
> 
> How can be the same and have different numbers? You sill need dedicated
> compatible.
> 

The SoCs mt8195 and mt8395 are designed for different market application 
and physical characteristics, using different efuse values for 
distinction. The booting flow and configurations are controllered by the 
boot loaders, firmware, and TF-A. Therefore, the part numbers and 
procurement channels are different. The detail information of these 
efuse values is proprietary, so I cant disclose it futher. Hence the 
most of peripheral drivers and base address are almost the same.

> 
> Best regards,
> Krzysztof
> 

Best regards,
Macpaul Lin
