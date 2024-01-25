Return-Path: <linux-kernel+bounces-39372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5983CF90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AD71C23E98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBC11706;
	Thu, 25 Jan 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="jiln+mWM"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F711CB1;
	Thu, 25 Jan 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222709; cv=none; b=jea2sUqiIdRBzPgA/O8aH7AXLyUwZ3GVNKEoalFnxQcojagMF3/ZXbet3e0/MYU1puFdSQn8emN2vZ9308VoJUZf80koj2qpzLZmnmSLhViLkz58jEj8hppdYYYPfd54Nn8mOZk5SXKMZGk+SbU0Bua0Eaa+0u4SuUvFE5fXmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222709; c=relaxed/simple;
	bh=8UHUgio5bcGdOCke7+Q8iL/iKM1UTq80mrwqMurYWVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKzWmmPDQCNaQbqq6QLqxo7UT4fyq0hwLhVdKHZq+RbCpOxdLERpgDEOqoayV/IDthPNj3Yx+6NMRdvtVYKiEtN8ecOL5JtDu7s2ygoIzLlvqZPQm8AGWiwuLr3EclxEq5+N2DSrjrsNHwMoCwod1dzDJlUcWESI5IoWyiycqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=jiln+mWM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AC621BF204;
	Thu, 25 Jan 2024 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706222704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wfCo1mRfWcIdpnT9reav4j0aC7oEhRFsNtNutPWFwI=;
	b=jiln+mWMiPebOcn9uW9BmCuY9qLY2XvRvbb9ncjNF/Cx2PjQjCgIyT/oeNmPnCJ1I13y86
	coEVjjk2+lsBiiaXa0EkztIz9t2ZrMrRXCznqqGerkMj9V7WFFmAX1ynB6uuVJVUhCJm/p
	qrA5brRtgGWpRuXVona3kstZ0u6s7JkrHzozhJ64Z79mD2ZgHtWKtq2s3tMhPOAt63cFzF
	uDZDp8kiSlUAanWHXuxLaxen69N2J+nUYmnjlQdeuC0bT34DYM/fZqHlnVynuTr7ACqMYt
	dkia8tFNa/42GWIx2avBW8dnp9VoyQRCo4kwaD+nWE7FTEzr3SCOIosNN57IRw==
Message-ID: <99a038f3-18d2-44ca-8135-1faf7a37892a@arinc9.com>
Date: Fri, 26 Jan 2024 01:44:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZbKJv84vGXInRIo1@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 25.01.2024 19:18, Daniel Golle wrote:
> On Thu, Jan 25, 2024 at 12:49:19PM +0300, Arınç ÜNAL wrote:
>> On 24/01/2024 08:17, Daniel Golle wrote:
>>> Setup PMCR port register for actual speed and duplex on internally
>>> connected PHYs of the MT7988 built-in switch. This fixes links with
>>> speeds other than 1000M.
>>>
>>> Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>
>> Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> I'm wondering why we manually set speed and duplex for these interface
>> modes in the first place. I don't how it works for
>> PHY_INTERFACE_MODE_INTERNAL but, at least for PHY_INTERFACE_MODE_TRGMII and
>> 802.3z interfaces, phylink should already supply proper speed and duplex.
> 
> It's true that duplex should always be set to full-duplex already by
> phylink. However, speed could be 2500MBit/s (2500Base-X) or 2000MBit/s
> (?, TRGMII) and we yet need to program the PCR like if it was
> 1000MBit/s.
> 
> Regarding the INTERNAL case: it was added by mistake. In case of
> MT7988, all ports of the switch are connected via INTERNAL links,
> however, the PHYs still need adjustment of the PCR register just like
> on all other MT753x switches and the CPU port is setup elsewhere
> anyway.

It's not necessarily PHYs needing adjustment of the port MAC control
register. After reset, speed, duplex mode, etc. will be determined by
polling the PHY connected to the switch MAC. We're forcing these properties
on the PMCR because we're also configuring switch MACs that are not
connected to PHYs, meaning the switch cannot determine these properties by
polling a PHY.

 From what I understand, this code block is for overriding the speed and
duplex variables to make the operations on the PMCR below work. It seems
that this is actually only useful for PHY_INTERFACE_MODE_2500BASEX.
PHY_INTERFACE_MODE_TRGMII is given SPEED_1000 by
drivers/net/phy/phylink.c:phylink_interface_max_speed().
PHY_INTERFACE_MODE_2500BASEX is given SPEED_2500. Overriding the duplex
variable looks unnecessary.

Your patch here doesn't affect CPU ports because MT7531 and MT7988 PMCRs
are configured with cpu_port_config before mt753x_phylink_mac_link_up(),
and PHY_INTERFACE_MODE_INTERNAL is not used for MT7530 which, for MT7530,
PMCRs will be set only on mt753x_phylink_mac_link_up().

PMCR_FORCE_SPEED_1000 is set on cpu_port_config. If someone were to get rid
of cpu_port_config because of its utter uselessness, PMCR_FORCE_SPEED_1000
would not be set, causing the link between port 6 MAC and SoC MAC to break.

In conclusion, I will add "case SPEED_10000:" to the operations where the
speed and EEE bits are set on my patch for getting rid of cpu_port_config.

Arınç

