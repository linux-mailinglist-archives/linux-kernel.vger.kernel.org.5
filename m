Return-Path: <linux-kernel+bounces-12231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C881F1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA408B21FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47A47F4E;
	Wed, 27 Dec 2023 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="de58BORB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BE47776;
	Wed, 27 Dec 2023 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AD9E1C0003;
	Wed, 27 Dec 2023 19:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703706674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQV8YX8rOUM4ZWornMi1pNG+BpkRd9hjDAN9lELZU0w=;
	b=de58BORBYXHfy/2uytj3vdf2RsHJQQjor1wdt8a0I3AbXyUJRu0ImhEU/e7UJ6QtwlQPP3
	F/zSvdSUpYdWvHYxOrcaHX8yhmv7ejuq41TFnZ/h0+TkqCmv4cS719NG/yzZEZgbUqS3z7
	g/rbRu55JigKRp1MnNcsBjOdjkzQDhWWEjco2m1607VZGf3k8bGXSUyeHiPR4IllJvjcze
	EasPv28pPh2j/iW5HYRyIJHb5SU6kUFtxbt7qjLUa16EqL2Tay/S0Y9DHOXQYNAPOG+/pG
	5vYsm1bPbvoSzPQdLARKDry6J74u12W1jcUUFLcGAzRB81cRYaRjGrxRkHmwSg==
Message-ID: <bdbe24b2-30f6-48fa-b6eb-a1ae3afe9076@arinc9.com>
Date: Wed, 27 Dec 2023 22:51:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231221151607.ujobhh4aet4obxdz@skbuf>
 <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>
 <20231227191154.6jkqdlqdxciidpfw@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231227191154.6jkqdlqdxciidpfw@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 27.12.2023 22:11, Vladimir Oltean wrote:
> On Sun, Dec 24, 2023 at 10:37:12AM +0300, Arınç ÜNAL wrote:
>> If the MDIO bus of the switch is defined on the devicetree, the
>> (!ds->user_mii_bus && ds->ops->phy_read) check in dsa_switch_setup will be
>> true so the MDIO bus will be attempted to be registered again, resulting in
>> a kernel panic.
> 
> Where does mt7530 provide ds->ops->phy_read() in upstream?

Sorry, that's a misdiagnosis from my part. There's indeed no
ds->ops->phy_read() or ds->ops->phy_write(). I should know that as I have
intensively studied the MDIO bus registration on all DSA subdrivers. The
issue is at mt7530_setup_mdio_irq():

ds->user_mii_bus->irq[p] = irq;

I didn't realise ds->user_mii_bus is also used to store irq mapping for
each PHY. Should we agree that user_mii_bus is needed for all cases or make
another way to store the irq mappings?

Arınç

