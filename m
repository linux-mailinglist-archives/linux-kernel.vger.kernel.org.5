Return-Path: <linux-kernel+bounces-88002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB786DBFF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9682B26589
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55E6930F;
	Fri,  1 Mar 2024 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="QbgeyEDU"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793169940;
	Fri,  1 Mar 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277488; cv=none; b=EEr+WAF3pQc2hAePFvk1AiBPWgsquEO+63DRT4JWvga37+7MqvNxZw7O2OA6XLs1aaeGLsbu1Cci/2XIzdVbOLBogyKPedVhmsPl3ZJboNFGWJqNFKfURLEaHwK0gC7Wp5Qyzlgo3koi1IuPsZZshRWnKpvsNunmCCAYlfy8lAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277488; c=relaxed/simple;
	bh=GbVSxdxOcXrMNMtwoCnXVKLHEXl3QoXDvb9SPjJL/Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXJsRijSqsBAbf05quOwh4OHdSe/tmJ0Y4y0CQR2YeizkxWg96flcETtcwNmvpYzfgmPJttqmgusHEWU9RS2D6t4fByJiJSk2C2awQNcrzydYCkccmWDAUrxUZvo1toorTXpkXgBdaKxT199xHIjxtOpOfNK4a02VP72WM7yG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=QbgeyEDU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C9E21C0006;
	Fri,  1 Mar 2024 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709277478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrWsSClDpsgyGzHOaL8tpqRTFE2Qs26x3Fav87hKIS4=;
	b=QbgeyEDUeUMQOAPAbUNPlZUfudRBI8YM9TORjlY7M2cJeot2oDtllAcd0MjXUEnr5ZIZX1
	p7KyYE+yeIDFTQ8yQPM/ufRM8qE/cq+c2eNJ85dh0mpaStnBthX56nTPnApoRI0AihsDkF
	2/9EUpOLnnYTX/kKXISnEy6CzgF93YcJS+IzWLbfHW3wbZdVCVMkFOY9DGnPRrcWHktCq+
	pnHg5rPZD9FjXi0nAkhUqTYBfKx3j0DXH1Rhl+1pCFfYQkJSE8jq3RrkdY+VYmv+1rcD3M
	zlFgosSPF0xqqFX/CJ9MPl/p7Oqr645ldbp9SG2lOxBi/QZUBeIm20G6rHL0zA==
Message-ID: <ac5feb1c-602d-4562-9aed-d949670dd0f0@arinc9.com>
Date: Fri, 1 Mar 2024 09:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: dsa: mt7530: simplify link
 operations and force link down on all ports
To: Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXk=?=
 <devnull+arinc.unal.arinc9.com@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
 <20240216-for-netnext-mt7530-improvements-3-v2-8-094cae3ff23b@arinc9.com>
 <20240228174932.2500653d@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240228174932.2500653d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Thanks for looking over this patch series Jakub!

On 29/02/2024 03:49, Jakub Kicinski wrote:
> On Fri, 16 Feb 2024 14:05:36 +0300 Arınç ÜNAL via B4 Relay wrote:
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
> 
> I don't know phylink so some basic questions..
> 
> What's "mode" in this case?

The mode here represents whether we will configure properties of the link
manually (force mode), or by polling the PHY. The driver is supposed to
configure the properties so we enable force mode on the port MAC registers.

MT7530 has a single bit for this, PMCR_FORCE_MODE. MT7531 has multiple
bits, MT7531_FORCE_MODE, each of them enabling the force mode for a certain
property of the link.

> 
>> Now that the bit for setting the port on force mode is done on
>> mt7530_setup() and mt7531_setup_common(), get rid of PMCR_FORCE_MODE_ID()
>> which helped determine which bit to use for the switch model.
> 
> MT7531_FORCE_MODE also includes MT7531_FORCE_LNK, doesn't that mean
> the link will be up?

No, that one enables force mode for the link status property. The bit for
setting the link status is PMCR_FORCE_LNK.

I know the current naming of the bits is confusing. I have patch for this
on my next patch series to improve it.

> 
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
> 
> This should be a separate change.

Sure, will do.

> 
>> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
>> @@ -2257,6 +2255,12 @@ mt7530_setup(struct dsa_switch *ds)
>>   	mt7530_mib_reset(ds);
>>   
>>   	for (i = 0; i < MT7530_NUM_PORTS; i++) {
>> +		/* Clear link settings and enable force mode to force link down
> 
> "Clear link settings to force link down" makes sense.
> Since I don't know what the mode is, the "and enable force mode"
> sounds possibly out of place. If you're only combining this
> for the convenience of RMW, keep the reasoning separate.

No. Force mode must be enabled so that we can manually set the link state.
Then, clearing the link settings achieves setting the link status to down.

Arınç

