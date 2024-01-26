Return-Path: <linux-kernel+bounces-39662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D564A83D4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19853B23859
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413114275;
	Fri, 26 Jan 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="fP3egsGb"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349A67C47;
	Fri, 26 Jan 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250668; cv=none; b=a9fjhJoyeCerm4OGHY+UEJobHyuVwrJIF7SRBTTXkjg5rN+nUCdHWlt6V2CzQwPzayrx6jCBx1+og0eynFJ12KY6FG4Fd3guNBQVJ26oX9VkBY/PZ7EPrXLHhcF70+A1uBognbtVf/R5xe8hbVOR19DURtM9Ha5/GU8pyH8bzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250668; c=relaxed/simple;
	bh=uUGsIKVzyW06bLNQLY3dnO4VesNXnc6i+sIePN24WDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHDYZKMWnvPC1qYxbgjlK30Mkw9DbtGfiqBf+ilfoOskpGM3o1gRM06TG4AUw99uUYE4pkIaRh1ccuAsUCffwHKsJhfnvgv9k5oUPRtiPNG1BcwJwD3s/VSwC/ugXvpizUbPKe23UaXgK4JMH5tYGH5iPe2dtz0y5Zg19E5eCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=fP3egsGb; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DBE940007;
	Fri, 26 Jan 2024 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706250660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DUdyEK0UfNN06dDURtYyunSegOPRRffSVvE4FBPvac=;
	b=fP3egsGbl3q0y3kh8MvF+ob8MH/ijtiiuqXHeGQg/B/YPbBIv7SQsn74frUO2IqWp7dnhS
	ZIgU0ZCgUmwxUsZpWrvyJj97gvIh6/HNmMZtTIvvVIP6K7865dIWH8AZ99I4u4RAXpI+GT
	UhwE6MvKd55q81LLBznsKteQF07jba4c7sJn315n/uq68K8hFwmehUvnVS9bqUP5084xFC
	POEYeiy5qoFN9mJp5nhoa3bzbD5EuTAj6gSsGRlkSgbK62ydzq6+u7lO5A5cy0uj1mloq2
	3+zqVzexhBZ2RGaDhD0d9O8JoojXQtLj460K/yyPtO/t8HhoShKP2xPTg1+MXw==
Message-ID: <c7d87124-4351-4996-8095-e8b95cc15f27@arinc9.com>
Date: Fri, 26 Jan 2024 09:30:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 John Crispin <john@phrozen.org>
References: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
 <accda24c-9f12-4cfe-b532-a9c60ec97fca@arinc9.com>
 <ZbKJv84vGXInRIo1@makrotopia.org>
 <99a038f3-18d2-44ca-8135-1faf7a37892a@arinc9.com>
 <ZbL1VEcH3RgHZKsq@makrotopia.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZbL1VEcH3RgHZKsq@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 26.01.2024 02:57, Daniel Golle wrote:
> On Fri, Jan 26, 2024 at 01:44:57AM +0300, Arınç ÜNAL wrote:
>> On 25.01.2024 19:18, Daniel Golle wrote:
>>> On Thu, Jan 25, 2024 at 12:49:19PM +0300, Arınç ÜNAL wrote:
>>>> On 24/01/2024 08:17, Daniel Golle wrote:
>>>>> Setup PMCR port register for actual speed and duplex on internally
>>>>> connected PHYs of the MT7988 built-in switch. This fixes links with
>>>>> speeds other than 1000M.
>>>>>
>>>>> Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>
>>>> Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>
>>>> I'm wondering why we manually set speed and duplex for these interface
>>>> modes in the first place. I don't how it works for
>>>> PHY_INTERFACE_MODE_INTERNAL but, at least for PHY_INTERFACE_MODE_TRGMII and
>>>> 802.3z interfaces, phylink should already supply proper speed and duplex.
>>>
>>> It's true that duplex should always be set to full-duplex already by
>>> phylink. However, speed could be 2500MBit/s (2500Base-X) or 2000MBit/s
>>> (?, TRGMII) and we yet need to program the PCR like if it was
>>> 1000MBit/s.
>>>
>>> Regarding the INTERNAL case: it was added by mistake. In case of
>>> MT7988, all ports of the switch are connected via INTERNAL links,
>>> however, the PHYs still need adjustment of the PCR register just like
>>> on all other MT753x switches and the CPU port is setup elsewhere
>>> anyway.
>>
>> It's not necessarily PHYs needing adjustment of the port MAC control
>> register.
> 
> It's not the PHYs which need adjustment but the MAC PMCR register which
> does.
> 
>> After reset, speed, duplex mode, etc. will be determined by polling
>> the PHY connected to the switch MAC.
> 
> Yes, but as it is a DSA driver we don't use **hardware** PHY polling
> and keep that off. Instead, PHY interrupts or software PHY polling is
> used to have Linux determine the link properties.
> We're then forcing these properties on the MAC port of the switch.
> 
>> on the PMCR because we're also configuring switch MACs that are not
>> connected to PHYs, meaning the switch cannot determine these properties by
>> polling a PHY.
> 
> The switch **never** determines these properties itself when using the
> DSA driver. It has a facility to do so, and yes, when accessing
> Ethernet in U-Boot or when using the 'swconfig'-based driver then this
> facility is used. But, I repeat, when using DSA we do not use hardware
> PHY polling. We poll (or rather: react to interrupts) in software
> instead.
> 
>>
>>  From what I understand, this code block is for overriding the speed and
>> duplex variables to make the operations on the PMCR below work. It seems
>> that this is actually only useful for PHY_INTERFACE_MODE_2500BASEX.
>> PHY_INTERFACE_MODE_TRGMII is given SPEED_1000 by
>> drivers/net/phy/phylink.c:phylink_interface_max_speed().
>> PHY_INTERFACE_MODE_2500BASEX is given SPEED_2500. Overriding the duplex
>> variable looks unnecessary.
>>
>> Your patch here doesn't affect CPU ports because MT7531 and MT7988 PMCRs
> 
> This patch does not intend to affect the CPU port. As I've already
> said in my previous reply "[...] the CPU port is setup elsewhere
> anyway."
> 
> Maybe it wasn't clear, but I meant that the CPU port settings are
> intentionally unaffected by this patch.
> 
> It is intended to affect user ports which with phy-mode = "internal";
> set in DTS -- here we **do** need to set PMCR according the external
> link speed and duplex.
> 
> 
>> are configured with cpu_port_config before mt753x_phylink_mac_link_up(),
>> and PHY_INTERFACE_MODE_INTERNAL is not used for MT7530 which, for MT7530,
>> PMCRs will be set only on mt753x_phylink_mac_link_up().
>>
>> PMCR_FORCE_SPEED_1000 is set on cpu_port_config. If someone were to get rid
>> of cpu_port_config because of its utter uselessness, PMCR_FORCE_SPEED_1000
>> would not be set, causing the link between port 6 MAC and SoC MAC to break.
>>
>> In conclusion, I will add "case SPEED_10000:" to the operations where the
>> speed and EEE bits are set on my patch for getting rid of cpu_port_config.
> 
> PMCR needs to be set according to actual link speed for built-in TP
> PHYs. This is true for all mt7530 variants including MT7988.
> 
> Maybe the confusion here is that on MT7988 we use 'internal' phy-mode
> for both, the switch CPU port's link to mtk_eth_soc gmac0 as well as
> the links to the 4 built-in 1GE switch PHYs.
> 
> The latter were affected by wrongly overriding speed and duplex in
> case phy-mode is set to "internal", which should not have been put
> there (by me) in first place.
> 
> Let's just remove it, ok?

I don't see anything I disagree with on your reply. I've made my response
to explain what I understand and how I will adapt my future changes
accordingly with this patch so as to prevent introducing another issue.
I've already acknowledged this patch!

Arınç

