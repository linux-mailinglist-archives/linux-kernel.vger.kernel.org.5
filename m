Return-Path: <linux-kernel+bounces-109405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1F8818B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690F51F22716
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2C142AB7;
	Wed, 20 Mar 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="OrA6x1pw"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389512E48;
	Wed, 20 Mar 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967287; cv=none; b=RNdCdsCjIC7FsXgBjGSZiKztYcSYpsueqiYZlYXIOG62perQbHxjg/XkIrQoO6PVnLosw14snTvYfCEN4BGQcdMC0Zan8Tfc02My2/dhWhIvsQwv2NWOgBBu88tsXbyv5OnBpUHbqWoY6yp1gJRoKayxlaAxW90sF5behbc8bAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967287; c=relaxed/simple;
	bh=91yG2vmO+tazo8NZS2KIt/t4gbAjam+wzYjaZ8suBzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmZWNv2iUDzG8GDYR9tR4+Zr6TR3g4u2AJ2n6AOxN+1fNC1wIF4jlwUVYaAIn0zv0LpPHl/R00vZT3rY8ljp/b6txuxyzmYqU1X1N79CkOzhVxyNBRn8jp26n0SVSyCq0/1SUMOU/7aNYgDu0Q+yCGViDQjMs2ZoEAc0I/F6baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=OrA6x1pw; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64A981BF203;
	Wed, 20 Mar 2024 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710967282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1rjsEgyVWVkG2lBkygNFoS+ERY9yY1N//Uw/xuZ26A=;
	b=OrA6x1pw+oPiuzJyJ6Pla7RsogCFk+LQcK4+lE0F3bjgNfUapB5dc+J9P9L6oKhRsURsYY
	1+wzoAlDzufeHPBu4hIfEgvqTui3nNq4Q7Cfa1x7I9LMd4tBO6sEmJrS0iVbVaTaD1WFB1
	KkQ/HhxIibIrs0EvHBweSj/5Z7lXSKJJhuatUETaxN8QrZVo6AZIe5DHSADPq0Q77arMbB
	Kug78hCkX7MmcOPQn+W1L89iwFAHrht83noEZWNrhifBHDefOvwNekMlWe2AO6arp1lc6f
	wHlWDRxSM7I/HYJqePmmg5vcSEnEB1cARMmii3dEj6Qs9Ozpb+EQLEDHCfDRrg==
Message-ID: <3698b522-d6dc-46c1-bab2-d5ee3bed1fce@arinc9.com>
Date: Wed, 20 Mar 2024 23:40:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: phy: mediatek-ge: do not disable EEE
 advertisement
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-3-3f17226344e8@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-3-3f17226344e8@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 18.03.2024 10:46, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> There's no need to disable Energy-Efficient Ethernet (EEE) advertisement on
> the MT7530 and MT7531 switch PHYs. EEE works fine on MT7530 and MT7531
> switch PHYs. Remove the code where EEE advertisement is disabled.
> 
> This is a bugfix because there's a possible race condition where the
> mediatek-ge driver would kick in after the MT7530 DSA subdriver which would
> have EEE disabled until manually enabled.

Can I get an opinion on this? Is it actually possible that the PHY driver
would start probing after the DSA subdriver? On the console logs for the
DSA subdriver, I can see that the name of the PHY driver will appear, which
makes me believe the PHY driver would actually never probe after the DSA
subdriver.

[    4.402641] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=POLL)
[    4.420392] mt7530-mdio mdio-bus:1f lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=POLL)
[    4.437791] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=POLL)
[    4.455096] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=POLL)
[    4.472422] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=POLL)

I don't want to submit a bugfix to the net tree if the bug won't ever
happen in real life.

Arınç

