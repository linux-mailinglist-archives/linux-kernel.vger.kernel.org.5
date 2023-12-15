Return-Path: <linux-kernel+bounces-558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3058142E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFCD1C22144
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C78111AE;
	Fri, 15 Dec 2023 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E1IqYSR/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C7111A8;
	Fri, 15 Dec 2023 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7690cc429b1d11eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:Message-ID; bh=2wAqJO6ow5pbhLNgeXDGDdT6gSCu+5ZCYT020dCWPOM=;
	b=E1IqYSR/4K/sjc1swu8RYVPjxo6eBcVRUShSdKJi5tlB5Cooayf22p9PJn/cGjfBmJ/zPCapa+FPNkYqfnHSLgqPCGolodPU8gBH+GG4XGy/PZihUe/x5YsVY+WM+fynCiZqXV6nV0wVofBuHJtzocrLmvqLaLqvR7w9XJA4QdU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b2d86169-3ed4-4bab-8fb4-41f44379c6fb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:d731d373-1bd3-4f48-b671-ada88705968c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7690cc429b1d11eea5db2bebc7c28f94-20231215
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1126703269; Fri, 15 Dec 2023 15:42:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 15:42:11 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 15 Dec 2023 15:42:09 +0800
Message-ID: <6a0bc9c2-a9c6-5842-b66a-f9f020bf3aa3@mediatek.com>
Date: Fri, 15 Dec 2023 15:42:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: mediatek: remove broken pmic interrupt property
Content-Language: en-US
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Arnd Bergmann" <arnd@kernel.org>, <soc@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Ben Lok <ben.lok@mediatek.com>
CC: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <bear.wang@mediatek.com>,
	<pablo.sun@mediatek.com>, <wenst@chromium.org>
References: <20231212214737.230115-1-arnd@kernel.org>
 <bc5dafe4-5487-4794-97f1-f4e4d967a665@collabora.com>
 <1ce43346-3f60-b614-cdcc-7d9db8dec758@mediatek.com>
In-Reply-To: <1ce43346-3f60-b614-cdcc-7d9db8dec758@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.802600-8.000000
X-TMASE-MatchedRID: eVEkOcJu0F4OwH4pD14DsPHkpkyUphL9Wot5Z16+u77Bs8kDsMW7wymC
	jjsTccFFUYtkiBoupX8uAovee89QpC1Wsi+5O6Jc6ivQ8oO6nUIxXH/dlhvLv4KwF4K/wIz9x62
	K9vpeVDElpVclvjJJDAdoZ0oEtSg00YEzPS5rM625kfgtJfb41UMYMp0ANFh5jU67CM+uPQRDvi
	ZnrU/ym8l1PwlhNC8gii+rjsN9t6AdWKRD1iYss521GZGE81yGIR1rLBJm/M54TmuAv2jjeS2Yu
	hoO5axHdFVDrCqWLfIQbi0n2beMrBElELPcdUQnkX71Hy/ufOYwCmrLlx+SdWjliw+xvItd+876
	KLWQRT2+uHCFBcDhnx2NwlAFp+i1v1l2Uvx6idpWdFebWIc3VsRB0bsfrpPIfiAqrjYtFiS/RvL
	zr5xet56fdmHAkNDU7melNaZ+qBmhqzYP1yklcn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.802600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 026B01DCDDCE9116B9D54BB5E5B875CC4A12E046A3197EEE1A7B5B1A873AD7872000:8

On 12/15/23 01:54, Macpaul Lin wrote:
> On 12/13/23 19:09, AngeloGioacchino Del Regno wrote:
>
>> Il 12/12/23 22:47, Arnd Bergmann ha scritto:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The pmic is connected to the GIC, which uses four-cell interrupt 
>>> properties,
>>> but its interrupt is specified as two-cell that would only make 
>>> sense for
>>> the GPIO irqchip:
>>>
>>> arch/arm64/boot/dts/mediatek/mt8195.dtsi:464.4-27: Warning 
>>> (interrupts_property): /soc/i2c@11d01000/pmic@34:#interrupt-cells: 
>>> size is (8), expected multiple of 16
>>>
>>> Remove the interrupt for now to shut up the warning. When someone 
>>> figures out
>>> what the correct interrupt and parent are, we can add it back.
>>>
>>
>> Please, can anyone from MediaTek comment on that?
>
> Sorry for late response, I've just stuck in other tasks and didn't 
> notice this
>
> patch is for genio-1200-evk. I've tested 6.7-rc1 but I thought it 
> might be an issue
>
> in origin mt8195.dtsi and not be related to board dts.
>
>> I see a mt6360_pins on PIO:
>>             pinmux = <PINMUX_GPIO17__FUNC_GPIO17>,
>>                  <PINMUX_GPIO128__FUNC_GPIO128>;
>>
>> ...and that's GPIO128, which may effectively be the IRQ pin for MT6360.
>>
>> Still, I'm not sure whether the interrupt is on GIC or PIO, please 
>> clarify,
>> otherwise we will have to get this commit upstream.
>>
> I think it could be solved by adding
>
> 'interrupt-parent = <&pio>;' to mt6360 node.
>
> But currently I have no much time to verify it.
>
> I'll try to find some time to find out the solution tomorrow.
>
>> Thanks,
>> Angelo
>>
>>> Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for 
>>> Genio 1200 EVK board")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts 
>>> b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>> index 70b465f7c6a7..a409ef998746 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>> @@ -238,8 +238,6 @@ &i2c6 {
>>>       mt6360: pmic@34 {
>>>           compatible = "mediatek,mt6360";
>>>           reg = <0x34>;
>>> -        interrupts = <128 IRQ_TYPE_EDGE_FALLING>;
>>> -        interrupt-names = "IRQB";
>>>           interrupt-controller;
>>>           #interrupt-cells = <1>;
>>>           pinctrl-0 = <&mt6360_pins>;
>>
>
> Thanks for pointing out the issue! Let's see if it could be solved by 
> adding 'interrupt-parents'.
>
> Macpaul Lin

I've send a patch to add 'interrupt-parent' for mt6360 and tested with 
my local kernel-6.7-rc1.

Link: 
https://lore.kernel.org/linux-devicetree/20231215073252.21586-1-macpaul.lin@mediatek.com/

Thanks for Angelo , Arnd, and Chen-yu's reminding.

Best regards,

Macpaul Lin


