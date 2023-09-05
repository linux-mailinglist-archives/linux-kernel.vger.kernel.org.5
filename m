Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0ED792B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbjIEQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353790AbjIEIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:15:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADDACDB;
        Tue,  5 Sep 2023 01:15:14 -0700 (PDT)
X-UUID: 527d15b64bc411ee8051498923ad61e6-20230905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=PdtLuvK5FoLWlrvycOTnaJ+HduNbx6ANjKzfliekyu4=;
        b=svc1DzMHb8sp0cR91beGFmHizs82nCOdNG9OJtoZhNzxoYW2AEObx3ADd1vPYPnw4vqiGVCTy52EkuEFlCqBV9QfgHPAQAaYGW5F/+kzVq+dho+xUxAA5cJ6wfbt6TcN8SnrpyF/N/bF4IKahOVEcejLCM3790OKHLfr47aP5FA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:49b7700b-7047-4762-be5d-f1b70f9474a4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:cc7154ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 527d15b64bc411ee8051498923ad61e6-20230905
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 895902181; Tue, 05 Sep 2023 16:15:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Sep 2023 16:15:05 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 5 Sep 2023 16:15:03 +0800
Message-ID: <6e39b4b1-42b5-515c-aca0-08374ee7634e@mediatek.com>
Date:   Tue, 5 Sep 2023 16:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] arm64: dts: mediatek: mt8195-demo: fix the memory
 size to 8GB
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, <stable@vger.kernel.org>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230905034511.11232-1-macpaul.lin@mediatek.com>
 <4e0c1222-5211-5515-99f1-b44b25f8ecfe@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <4e0c1222-5211-5515-99f1-b44b25f8ecfe@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 16:00, AngeloGioacchino Del Regno wrote:
> Il 05/09/23 05:45, Macpaul Lin ha scritto:
>> The onboard dram of mt8195-demo board is 8GB.
>>
>> Cc: stable@vger.kernel.org      # 6.1, 6.4, 6.5
>> Fixes: 6147314aeedc ("arm64: dts: mediatek: Add device-tree for MT8195 
>> Demo board")
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Changes for v2:
>> Changes for v3:
>>   - No change.
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> index b2485ddfd33b..ff363ab925e9 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>> @@ -48,7 +48,7 @@
>>       memory@40000000 {
>>           device_type = "memory";
>> -        reg = <0 0x40000000 0 0x80000000>;
>> +        reg = <0 0x40000000 0x2 0x00000000>;
> 
> Shouldn't this get automatically filled in by the bootloader?
> Usually, that's the case: if it is, then the right thing to do here
> is to change this property to
> 
>          /* The bootloader will fill in the size */
>          reg = <0x0 0x40000000 0x0 0x0>;
> 
> Regards,
> Angelo
> 

Thanks for the review. However, this value seems depends on the boot 
method. Take u-boot as the example, the total memory size which Linux 
kernel get will be different via EBBR boot or fitImage boot.

It the system is booted through EBBR, the memory size should be filled 
by u-boot's UEFI variables, which is from u-boot's dts file. If the 
system is booted from fitImage, the memory size should be filled by 
kernel's dts file which is usually packed with fitImage. That's why we 
still need this fix.

>>       };
>>       reserved-memory {
> 
> 

Thanks.
Macpaul Lin
