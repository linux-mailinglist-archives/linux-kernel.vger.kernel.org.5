Return-Path: <linux-kernel+bounces-58629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E994084E904
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5812A1F2155D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554B381BF;
	Thu,  8 Feb 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="nghsWFai"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93936B0A;
	Thu,  8 Feb 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420966; cv=none; b=oIi7KRADUJ4RJ4aE+kpj9IpuyZ3TPe5Yhl0Xp2pZ30MAbnQ1n9chBJKiwGAfigo9UdqO2QVek/eDzlseCT9EulwbT8yHeHKPsf9kYSFDO6LvpP5qaNP58x2HcYCft2gyB/QZC7TqSo25Vl4SySaKL5m/6S0kRbsGGOVrJLZbvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420966; c=relaxed/simple;
	bh=5lZgy15lyjC3SHCmPGyg/uVp5XyWug9UfglmY/G6ex4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb+sTYaL4GpV13ro3x/tPnvh5/SGbGUeyt115GyRyiCsdXfuSe5Ky6sl+3iyiCyJC7ziqndg2pkmd5jnEeMg/NScqdlsDlAv7IfYTEs+UfCukUF3cXPpMZm103GXDPIu5zQQ7kmPHbi+1DAHXG2341d2YDL359wcs1VjBL0Q56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=nghsWFai; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C11B1BF207;
	Thu,  8 Feb 2024 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1707420958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddz8Sv+QlYT5INqMFfFhMaDjWIdMDNTLjt/Wj7ITUr8=;
	b=nghsWFaikliESs/fO8r46x5t8cVB/B+0wrV0kdwuHfqtdxFbxnOj36IIpcEDKDvErggVne
	Qg4XiFACEowYkf02TO0897fWCBHQNG+iINuFD3b0wK0vQDM1Palyk4GdWK0P7yZaCiDgrt
	hI5ScCCJZY88D3teO70p343rCtIYwizwh7Acj+kNv5MCO5LzNnNWq2udd2PrTSkWNO4YhD
	dtFTnyavm/on7eUzWUjCv3LQWl8x8nJ5s+OAi5AXg04pBCunytKhBh52q3pv0YLk9uvTrJ
	hPY/C8NtqMDBDyGuwg/IPcPFmfW8kUhMNpnvLz7nerfL55pQg8T93IC0XisgIQ==
Message-ID: <2a6a8d93-beae-4bec-a792-0e093b4c4ecd@arinc9.com>
Date: Thu, 8 Feb 2024 22:35:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH netnext 8/8] net: dsa: mt7530: simplify link operations
 and force link down on all ports
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
 <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>
 <ZcT_r68mStRAC3Uk@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZcT_r68mStRAC3Uk@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 8.02.2024 19:22, Daniel Golle wrote:
> On Thu, Feb 08, 2024 at 08:51:36AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Currently, the link operations for switch MACs are scattered across
>> port_enable, port_disable, phylink_mac_config, phylink_mac_link_up, and
>> phylink_mac_link_down.
>>
>> port_enable and port_disable clears the link settings. Move that to
>> mt7530_setup() and mt7531_setup_common() which set up the switches. This
>> way, the link settings are cleared on all ports at setup, and then only
>> once with phylink_mac_link_down() when a link goes down.
>>
>> Enable force mode at setup to apply the force part of the link settings.
>> This ensures that only active ports will have their link up.
>>
>> Now that the bit for setting the port on force mode is done on
>> mt7530_setup() and mt7531_setup_common(), get rid of PMCR_FORCE_MODE_ID()
>> which helped determine which bit to use for the switch model.
>>
>> The "MT7621 Giga Switch Programming Guide v0.3", "MT7531 Reference Manual
>> for Development Board v1.0", and "MT7988A Wi-Fi 7 Generation Router
>> Platform: Datasheet (Open Version) v0.1" documents show that these bits are
>> enabled at reset:
>>
>> PMCR_IFG_XMIT(1) (not part of PMCR_LINK_SETTINGS_MASK)
>> PMCR_MAC_MODE (not part of PMCR_LINK_SETTINGS_MASK)
>> PMCR_TX_EN
>> PMCR_RX_EN
>> PMCR_BACKOFF_EN (not part of PMCR_LINK_SETTINGS_MASK)
>> PMCR_BACKPR_EN (not part of PMCR_LINK_SETTINGS_MASK)
>> PMCR_TX_FC_EN
>> PMCR_RX_FC_EN
>>
>> These bits also don't exist on the MT7530_PMCR_P(6) register of the switch
>> on the MT7988 SoC:
>>
>> PMCR_IFG_XMIT()
>> PMCR_MAC_MODE
>> PMCR_BACKOFF_EN
>> PMCR_BACKPR_EN
>>
>> Remove the setting of the bits not part of PMCR_LINK_SETTINGS_MASK on
>> phylink_mac_config as they're already set.
>>
>> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   drivers/net/dsa/mt7530.c | 26 +++++++++++++-------------
>>   drivers/net/dsa/mt7530.h |  2 --
>>   2 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 5c8ad41ce8cd..f67db577d1c0 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -1018,7 +1018,6 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
>>   	priv->ports[port].enable = true;
>>   	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
>>   		   priv->ports[port].pm);
>> -	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
>>   
>>   	mutex_unlock(&priv->reg_mutex);
>>   
>> @@ -1038,7 +1037,6 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
>>   	priv->ports[port].enable = false;
>>   	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
>>   		   PCR_MATRIX_CLR);
>> -	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
>>   
>>   	mutex_unlock(&priv->reg_mutex);
>>   }
>> @@ -2257,6 +2255,12 @@ mt7530_setup(struct dsa_switch *ds)
>>   	mt7530_mib_reset(ds);
>>   
>>   	for (i = 0; i < MT7530_NUM_PORTS; i++) {
>> +		/* Clear link settings and enable force mode to force link down
>> +		 * on all ports until they're enabled later.
>> +		 */
>> +		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
>> +		mt7530_set(priv, MT7530_PMCR_P(i), PMCR_FORCE_MODE);
> 
> Any reason to not combine the two lines above into a single call:
> 
> mt7530_rmw(priv, MT7530_PMCR_P(i),
> 	   PMCR_LINK_SETTINGS_MASK | PMCR_FORCE_MODE,
> 	   PMCR_FORCE_MODE);

No reason whatsoever, I'll do this. Thanks!

Arınç

