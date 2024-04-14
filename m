Return-Path: <linux-kernel+bounces-143989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B298A4075
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B1E282CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB31C687;
	Sun, 14 Apr 2024 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Njoqy5Ng"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFD179BD;
	Sun, 14 Apr 2024 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074379; cv=none; b=MnTeJTaSYPxthVv/qu/MIypqoDluEs+zRNtlA5g2CcfWoFBXXgl4zZLM+VasvPWsO8uXl/XVLiB0Zk/tr+ajGsN2YhKlwNKCeXMEgJQinapW0v5khykWVkayYEKHPJYWyzUV9UCk4X1Bb4DlMafLQ40UVO3dP+WhVIEbvHNZeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074379; c=relaxed/simple;
	bh=+F9SE9a2hneMWBPdTbXkuw6pE8D5bqSVAmLAV1tq13Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdZ7JEmFE+GKZ3lDqBnaUQFLXBylS4c8kQd6x8CCxe4tS1yZ9p2avldJGCJVOVfBiuBzAwzDb2duQeVKuxG+URjgNqUSN6s/vTzQWo8f5kLYyfJIXLFJ0GyLQPHG3z75g/pjSRu8APTfmy5HVvpg9LoD7E9FVQbL0S2qdEErdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Njoqy5Ng; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1F44E0002;
	Sun, 14 Apr 2024 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713074369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkAVfJhrb20IYkFdMPZ7uw1ETykugiPubMA1XaxEiMQ=;
	b=Njoqy5NgTDA6NbHuTAtH3AtByQBGjYShG+Bi5WaBWSlEI+xUoDFNc/CXuhNv9anFPfulab
	gb7EBw9Ydxa5LDoEWQdyiw0CRVG9qaMskqreRlmFwmYvEkJPmFK0jx1FWX44ZkfyEtounA
	eKOpYraemv4ZCjooEJdmbTDhGD/Zq4W5PTb4gtARvLpOafS4OHofhKPWwe06Rjcu0B4okw
	THU8GsDRRv9FuFU/tBZFn1+O5mAcwrq45RUgQ18iV43P8bDGcancaU7V9RP/E+AlrFc+Bm
	omzgfykL5m+7IabFWjQshiaJEbwheJpBhQimpPlMZAbfGW/rleFLRSW7+zMZGg==
Message-ID: <f54166f4-bbd6-4711-8194-cc9d9efdee89@arinc9.com>
Date: Sun, 14 Apr 2024 08:59:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: mt7530-mdio: read PHY address of
 switch from device tree
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-0-b08936df2770@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-1-b08936df2770@arinc9.com>
 <ZhtJGEdjeS3LfMWF@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZhtJGEdjeS3LfMWF@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 14.04.2024 06:10, Daniel Golle wrote:
> On Sun, Apr 14, 2024 at 01:08:19AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Read the PHY address the switch listens on from the reg property of the
>> switch node on the device tree. This change brings support for MT7530
>> switches on boards with such bootstrapping configuration where the switch
>> listens on a different PHY address than the hardcoded PHY address on the
>> driver, 31.
>>
>> As described on the "MT7621 Programming Guide v0.4" document, the MT7530
>> switch and its PHYs can be configured to listen on the range of 7-12,
>> 15-20, 23-28, and 31 and 0-4 PHY addresses.
>>
>> There are operations where the switch PHY registers are used. For the PHY
>> address of the control PHY, transform the MT753X_CTRL_PHY_ADDR constant
>> into a macro and use it. The PHY address for the control PHY is 0 when the
>> switch listens on 31. In any other case, it is one greater than the PHY
>> address the switch listens on.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> See minor nit inline below.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> (only MT7530 and MT7531 on address 0x1f has been tested, I don't have
> any board configuring the switch to any other base-address)
> 
>> ---
>>   drivers/net/dsa/mt7530-mdio.c | 28 ++++++++++++++--------------
>>   drivers/net/dsa/mt7530.c      | 35 ++++++++++++++++++++++-------------
>>   drivers/net/dsa/mt7530.h      |  4 +++-
>>   3 files changed, 39 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
>> index 585db03c0548..76adc9d21bcf 100644
>> --- a/drivers/net/dsa/mt7530.h
>> +++ b/drivers/net/dsa/mt7530.h
>> @@ -625,7 +625,7 @@ enum mt7531_clk_skew {
>>   #define  MT7531_PHY_PLL_OFF		BIT(5)
>>   #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
>>   
>> -#define MT753X_CTRL_PHY_ADDR		0
>> +#define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr == 0x1f ? 0 : phy_addr + 1)
> 
> #define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr + 1 & 0x1f)
> 
> It's shorter, and works without conditional operator which is expensive.

Great, thanks.

Arınç

