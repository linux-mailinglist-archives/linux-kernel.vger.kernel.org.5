Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E878AAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjH1KZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjH1KZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:25:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33218B;
        Mon, 28 Aug 2023 03:25:28 -0700 (PDT)
X-UUID: 3414babc458d11ee9cb5633481061a41-20230828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=jRXDdDGfcw2VGrYOWIzRIFvqKbDeBV/O8IucKucUEhk=;
        b=K1YcmgA64iHvkZcGitOm1UcHqs7QSDmEObVDCBKZZ+Xar05GiRgEZzDeUQX9kYXG2+z3KFl8TnNxzwg3Sobcdm0ha2RQ5+kenMI3dKN7zZnIhh92cmZzbBr+ylWu+nkt5etHZ0ZZyxRCMl/L7HX7ZzDsSUt0gvtWjN/dbQVgvZ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:d5ffd5ae-bd7e-452d-bada-d465bd3ebefc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:bb825bc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3414babc458d11ee9cb5633481061a41-20230828
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 355078162; Mon, 28 Aug 2023 18:25:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Aug 2023 18:25:24 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 28 Aug 2023 18:25:24 +0800
Message-ID: <35d2fd6a-167b-8df8-aa61-b40aa7224e3c@mediatek.com>
Date:   Mon, 28 Aug 2023 18:25:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] spidev: add compatible string for MediaTek IoT (Genio)
 boards
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
CC:     <angelogioacchino.delregno@collabora.com>,
        <bear.wang@mediatek.com>, <broonie@kernel.org>,
        <chunfeng.yun@mediatek.com>, <fparent@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <macpaul@gmail.com>, <matthias.bgg@gmail.com>,
        <pablo.sun@mediatek.com>
References: <20230828080909.16610-1-macpaul.lin@mediatek.com>
 <20230828093326.3255275-1-mwalle@kernel.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20230828093326.3255275-1-mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 17:33, Michael Walle wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> 
>> Add compatible string for MediaTek IoT (Genio) boards.
> 
> This has already be discussed [1] and was naked.
> 
> https://lore.kernel.org/lkml/20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com/
> 
> -michael

Thanks for the reminding, I'll check previous discussion thread.

>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   drivers/spi/spidev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
>> index d13dc15cc191..9d7952dbbaa6 100644
>> --- a/drivers/spi/spidev.c
>> +++ b/drivers/spi/spidev.c
>> @@ -714,6 +714,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
>>   	{ .name = "spi-authenta" },
>>   	{ .name = "em3581" },
>>   	{ .name = "si3210" },
>> +	{ .name = "genio-board" },
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
>> @@ -742,6 +743,7 @@ static const struct of_device_id spidev_dt_ids[] = {
>>   	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
>>   	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
>>   	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
>> +	{ .compatible = "mediatek,genio-board", .data = &spidev_of_check },
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, spidev_dt_ids);
>> -- 
>> 2.18.0

Regards,
Macpaul Lin
