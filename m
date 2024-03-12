Return-Path: <linux-kernel+bounces-100200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E1879377
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368F52847F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68ED79DD0;
	Tue, 12 Mar 2024 11:58:56 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245679B98;
	Tue, 12 Mar 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244736; cv=none; b=tA3BDTdJaQuh2KexFSc//auAGTwYHgkh/PoqxcuahNCd0elfgUvc0pyz8A6ABC8UpGNCdqsvIJih3Z+KrZwfHbQaHgfzOvAoKj8T8ebGlOEhTq9hVKeD8LlgEekKSxsnHBXArxFzk3TfsGVqEMdPs09F6ycdEhlV/3T8sFrDWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244736; c=relaxed/simple;
	bh=PLmC6BbRmhT98s/2WERHDrru1CT+5wjpeaXBWOT4hco=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=FVaCpaCFmCuOETS2a1ylfEL4QZnu4r6MAltxLsjnHwROKBB1Vd9fkFZ0HlRajqdR+g2uVL9PNJk3tv7QUUjtDYQqb5A+CJSx6lkWFWOJG107iSkYP7wl06AxqNwTaAUkvvccWpXBELaFQ0uyMTPNjeLPiN6dAHbYfCPPStvF8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TvBtq5Qzkz1gxtv;
	Tue, 12 Mar 2024 19:56:19 +0800 (CST)
Received: from kwepemd100008.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 00D001A016C;
	Tue, 12 Mar 2024 19:58:46 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd100008.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 12 Mar
 2024 19:58:45 +0800
Message-ID: <65F04374.20308@hisilicon.com>
Date: Tue, 12 Mar 2024 19:58:44 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Yang Xiwen <forbidden405@outlook.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder
	<elder@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com> <SEZPR06MB695952078B51C4549191F8AB962B2@SEZPR06MB6959.apcprd06.prod.outlook.com> <65F03D79.2070008@hisilicon.com> <SEZPR06MB69599C39A47E625A0C3CB83F962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB69599C39A47E625A0C3CB83F962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100008.china.huawei.com (7.221.188.193)

Hi Yang,

On 2024/3/12 19:46, Yang Xiwen wrote:
> On 3/12/2024 7:33 PM, Wei Xu wrote:
>> Hi Yang,
>>
>> On 2024/3/12 19:19, Yang Xiwen wrote:
>>> On 2/19/2024 11:05 PM, Yang Xiwen via B4 Relay wrote:
>>>> The patchset fixes some warnings reported by the kernel during boot.
>>>>
>>>> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
>>>> 2.2.1 Master Processor.
>>>>
>>>> The cache line size and the set-associative info are from Cortex-A53
>>>> Documentation [2].
>>>>
>>>>   From the doc, it can be concluded that L1 i-cache is 4-way assoc, L1
>>>> d-cache is 2-way assoc and L2 cache is 16-way assoc. Calculate the dts
>>>> props accordingly.
>>>>
>>>> Also, to use KVM's VGIC code, GICH, GICV registers spaces and maintenance
>>>> IRQ are added to the dts with verification.
>>>>
>>>> [1]: https://github.com/96boards/documentation/blob/master/enterprise/poplar/hardware-docs/Processor_Datasheet_v2XX.pdf
>>>> [2]: https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>> Changes in v3:
>>>> - send patches to stable (Andrew Lunn)
>>>> - rewrite the commit logs more formally (Andrew Lunn)
>>>> - rename l2-cache0 to l2-cache (Krzysztof Kozlowski)
>>>> - Link to v2: https://lore.kernel.org/r/20240218-cache-v2-0-1fd919e2bd3e@outlook.com
>>>>
>>>> Changes in v2:
>>>> - arm64: dts: hi3798cv200: add GICH, GICV register spces and
>>>>     maintainance IRQ.
>>>> - Link to v1: https://lore.kernel.org/r/20240218-cache-v1-0-2c0a8a4472e7@outlook.com
>>>>
>>>> ---
>>>> Yang Xiwen (3):
>>>>         arm64: dts: hi3798cv200: fix the size of GICR
>>>>         arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>>>>         arm64: dts: hi3798cv200: add cache info
>>>>
>>>>    arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
>>>>    1 file changed, 42 insertions(+), 1 deletion(-)
>>>> ---
>>>> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
>>>> change-id: 20240218-cache-11c8bf7566c2
>>>>
>>>> Best regards,
>>> May someone apply this patchset to their tree so that it can land in stable at the end? This is a fix, not adding new functionalities. It's been 2 weeks already.
>>>
>> Sorry for the delay, I am too busy to catch up with this cycle.
>> I will go through this patch set and maybe apply it during the next cycle.
> 
> 
> No problem. I'm just a bit worried if this patch is getting lost. It's good to know it's still maintained. Because i've seen some maintainers not reviewing any patches for over 1 year already, with their names and emails still in MAINTAINERS.

Thanks for the understanding!

> 
> 
> By the way, I think fixes and new features are in different cycles? Most maintainers seem to have multiple branches to handle this.

Yes, they can be in different cycle. But now is the merge window.

Best Regards,
Wei

> 
> 
>>
>> Best Regards,
>> Wei
> 
> 

