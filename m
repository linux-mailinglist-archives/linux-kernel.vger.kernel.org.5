Return-Path: <linux-kernel+bounces-20789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C20828542
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C2C1C239AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AE37168;
	Tue,  9 Jan 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ZFNibi1/"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC45374E6;
	Tue,  9 Jan 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D47B24000A;
	Tue,  9 Jan 2024 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704800571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruo0mxJCNC88tZxIuaia/Iixy33YS9rintyuLR3NZro=;
	b=ZFNibi1/5l5DoDg+OQi1D/r1xIgQbN1JhYSs1qAqRiv0FA0bS/q6yEmT5ThIbVMISqDgRe
	dI++ssHmC5fkyUrc2pGAAb30v4eQRdyI1KfNzXOgFOnOuFdcW1nsAOw0FluhoxjLcma+5X
	KqaaHd3uKlegYpuW2FOxLFsDx7zanVNVtgmr+NMmGfmetEWGoutgHjdi1uqSq4vZK6ZUeA
	6GiHn4hdzEVPyGV8JAds2cQOAm1QLVhmvgBw+zzZxzARQqWpJkjCQkKjLkU0A1iUg/Nlfo
	AOJJk9edEzJslMKU7BEJcGghp7H9LNCVoD7HomcTbVq2JrGagyBNiAAVggdKsw==
Message-ID: <2793938a-91e1-419d-a011-850756177e31@arinc9.com>
Date: Tue, 9 Jan 2024 14:42:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-7-arinc.unal@arinc9.com>
 <20240104154241.rxjins4mi5zkbhia@skbuf>
 <f9ad000a-2e42-4ddf-89a4-9a3ff452dc4b@arinc9.com>
Content-Language: en-US
In-Reply-To: <f9ad000a-2e42-4ddf-89a4-9a3ff452dc4b@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 6.01.2024 18:00, Arınç ÜNAL wrote:
> On 4.01.2024 18:42, Vladimir Oltean wrote:
>> On Wed, Dec 27, 2023 at 07:43:46AM +0300, Arınç ÜNAL wrote:
>>> priv->p5_interface and priv->p6_interface are for use on the MT7531 switch.
>>> They prevent the CPU ports of MT7531 to be configured again. They are
>>> useless for MT7530. Therefore, remove setting priv->p5_interface for
>>> MT7530.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> ---
>>
>> What makes priv->p5_interface and priv->p6_interface useless for MT7530
>> as you say? This code in mt753x_phylink_mac_config() seems executed
>> regardless of switch family:
>>
>>     case 5:
>>         if (priv->p5_interface == state->interface)
>>             break;
>>
>>         if (mt753x_mac_config(ds, port, mode, state) < 0)
>>             goto unsupported;
>>
>>         if (priv->p5_intf_sel != P5_DISABLED)
>>             priv->p5_interface = state->interface;
>>         break;
>>     case 6:
>>         if (priv->p6_interface == state->interface)
>>             break;
>>
>>         mt753x_pad_setup(ds, state);
>>
>>         if (mt753x_mac_config(ds, port, mode, state) < 0)
>>             goto unsupported;
>>
>>         priv->p6_interface = state->interface;
>>         break;
> 
> This is also useless for non-MT7531 switches in the sense that it
> unnecessarily prevents port 5 and 6 from being reconfigured. There's
> nothing wrong with configuring them multiple times. These are the remains
> of before phylink was implemented on this driver so the thought of changing
> phy_interface_t on the fly was non existent. At that time, it was probably
> made to apply to all switch models for convenience, as port 5 and 6 are CPU
> ports so they're highly likely to be fixed links.
> 
> The reason I don't deal with this code block now is because I will get rid
> of priv->p5_interface and priv->p6_interface when I also get rid of
> priv->info->cpu_port_config() with a later patch.

Sorry, I couldn't give a straight answer. Here's the exact answer to this
patch.

Running mt7530_setup_port5() from mt7530_setup() handles all cases of
configuring port 5, including phylink.

Setting priv->p5_interface under mt7530_setup_port5() makes sure that
mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.

The ("net: dsa: mt7530: improve code path for setting up port 5") patch
makes so that mt7530_setup_port5() from mt7530_setup() runs only on
non-phylink cases.

So we get rid of setting priv->p5_interface under mt7530_setup_port5() as
port 5 phylink configuration will be done by running mt7530_setup_port5()
from mt753x_phylink_mac_config() now.

Running mt7530_setup_port5() from mt753x_phylink_mac_config() multiple
times is being prevented which shouldn't be done. That's because of a
different reason involving MT7531. I will deal with this with a later
patch.

I intend to put this on the patch log.

Arınç

