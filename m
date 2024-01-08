Return-Path: <linux-kernel+bounces-19332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0C826B85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBCC1F222B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7113FE0;
	Mon,  8 Jan 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="o8+G7C7L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600113AD8;
	Mon,  8 Jan 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E041240004;
	Mon,  8 Jan 2024 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704709348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuJv/OyK8RE0Y94blspywgd4cYFg7aH1NjsPMWEemMY=;
	b=o8+G7C7L1f0U+TNR9hjwq2dvwbkDeoKwHmYJ/lL98i2S7oyotEB4PbNN8gyDcg5GRlloJ4
	OciNnaR2VvZAC4nmjTZ+np5PbKkNYYG7o1Cxr7H5Ye6fAga97KSuwf7NsI7zp7idUgQpfg
	SJ5mMW2o4WK9TYiKJbFjDrnvtHRuIBMM1O5SEMQzc5CfYklj5y1x6IP7YkqlmqWwl+YquJ
	yqFc4NSjOXsnEZ7IPLJZI/AEBAntp7P30m6zqhukwqjO/1FoLS/c3pMqFGmgUl1G6OssGb
	psc0qp57ss1dPfKAo2AdfXGmLbT3NcjCQLmbmv/g/I0FcIuhY6aWaSsm1ApBBw==
Message-ID: <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>
Date: Mon, 8 Jan 2024 13:22:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration
 of switch MDIO bus
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240106122142.235389-1-arinc.unal@arinc9.com>
 <20240107195241.GB132648@kernel.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240107195241.GB132648@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 7.01.2024 22:52, Simon Horman wrote:
> On Sat, Jan 06, 2024 at 03:21:42PM +0300, Arınç ÜNAL wrote:
>> From: David Bauer <mail@david-bauer.net>
>>
>> Currently the MDIO bus of the switches the MT7530 DSA subdriver controls
>> can only be registered as non-OF-based. Bring support for registering the
>> bus OF-based.
>>
>> The subdrivers that control switches [with MDIO bus] probed on OF must
>> follow this logic to support all cases properly:
>>
>> No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
>> bus, set the interrupts for PHYs if "interrupt-controller" is defined at
>> the switch node. This case should only be covered for the switches which
>> their dt-bindings documentation didn't document the MDIO bus from the
>> start. This is to keep supporting the device trees that do not describe the
>> MDIO bus on the device tree but the MDIO bus is being used nonetheless.
>>
>> Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
>> bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
>> the switch node and "interrupts" is defined at the PHY nodes under the
>> switch MDIO bus node].
>>
>> Switch MDIO bus defined but explicitly disabled: If the device tree says
>> status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
>> Instead, just exit as early as possible and do not call any MDIO API.
>>
>> The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
>> switch is described on the device tree [1], which is why we don't populate
>> ds->user_mii_bus in that case.
>>
>> Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
>> Suggested-by: David Bauer <mail@david-bauer.net>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   drivers/net/dsa/mt7530.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 391c4dbdff42..39d7e7ad7154 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2153,17 +2153,25 @@ mt7530_free_irq(struct mt7530_priv *priv)
>>   static int
>>   mt7530_setup_mdio(struct mt7530_priv *priv)
>>   {
>> +	struct device_node *mnp, *np = priv->dev->of_node;
>>   	struct dsa_switch *ds = priv->ds;
>>   	struct device *dev = priv->dev;
>>   	struct mii_bus *bus;
>>   	static int idx;
>> -	int ret;
>> +	int ret = 0;
>> +
>> +	mnp = of_get_child_by_name(np, "mdio");
>> +
>> +	if (mnp && !of_device_is_available(mnp))
>> +		goto out;
> 
> nit: I think it would easier on the eyes to simply
> 
> 		return 0;

Will do.

Thanks.
Arınç

