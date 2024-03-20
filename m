Return-Path: <linux-kernel+bounces-109422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6EE8818E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2100A284073
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843278595B;
	Wed, 20 Mar 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="JuoJStpP"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58688565B;
	Wed, 20 Mar 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968728; cv=none; b=DIOHo3I1ZWDuulWLN7mTFEmajfOcSAPOCdHGiXpULAzsKn+5+s9Ux/EsN0xpra2Au/4zjtvNFRs8BOa7HiuHIxOx0frkANJXcifHhLIzxmQCr3zyJ3Ldzz6FqUN+9GjJLlB83N8RTEPMdCdlgJ1udbNaeiVVHDGVEa4ltDGTYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968728; c=relaxed/simple;
	bh=2fuJvgCp/TQfwxtVb1Kj0pQKhEPlbMyqXlkRbqCIatk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouvT3Kxjs//2Su3C5SETPU00ltttVeSVCVyq77unXbeTKvErm75r4w+jW5h5Qiq+E+ZHNhZPZi5Fo5gz6kbj5wgf45R++q7V0dYr5j9KAf3moCsgDDCb2k7rszMsIUvLBzFnVx9ZAyyzZAEOzdNhAlXTF72gxQS6HHQHABeLqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=JuoJStpP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1939E1C0004;
	Wed, 20 Mar 2024 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710968717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+eA4poe7YhKyyg6S2zgB/KMMtaqy46s40/9yE4njUg=;
	b=JuoJStpPp45vWbK9MnkL1uOhTmNJiyG2ZlZsMk0v5ZWHIETQDf8hVwpIWGRJX8ZBwkMDo0
	wytv9+y/VJJMh9NTSqO8LXurlX8T81aySSDJTWyqCaNceHNP/SNrTAG8dhJgvVo8BnZu/7
	aOp+j16m4940s+7uik7lxvDcmFTA7w9HCP2asUiDZUg2k/RTprEhAL4F/a5LTGuTj4klcf
	psNinjH1BMvNlbXZhtCtmrX9i8OQTy8juOVOCVJVYYaAa4vwmkWT+Z57je5orX65jGZuwT
	ZQd079JYQiGDOwFGxHi4rM4YRFo/QjB9ublP+8iMj40zmM310fmmvAxLwXQn4g==
Message-ID: <dc487e20-7d6c-48b7-a590-cb3bd815cd21@arinc9.com>
Date: Thu, 21 Mar 2024 00:04:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: phy: mediatek-ge: do not disable EEE
 advertisement
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-3-3f17226344e8@arinc9.com>
 <3698b522-d6dc-46c1-bab2-d5ee3bed1fce@arinc9.com>
 <ZftM2vDYQ2+5nSRV@shell.armlinux.org.uk>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZftM2vDYQ2+5nSRV@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 20.03.2024 23:53, Russell King (Oracle) wrote:
> On Wed, Mar 20, 2024 at 11:40:56PM +0300, Arınç ÜNAL wrote:
>> On 18.03.2024 10:46, Arınç ÜNAL via B4 Relay wrote:
>> Can I get an opinion on this? Is it actually possible that the PHY driver
>> would start probing after the DSA subdriver? On the console logs for the
>> DSA subdriver, I can see that the name of the PHY driver will appear, which
>> makes me believe the PHY driver would actually never probe after the DSA
>> subdriver.
>>
>> [    4.402641] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    4.420392] mt7530-mdio mdio-bus:1f lan0 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    4.437791] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    4.455096] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=POLL)
>> [    4.472422] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=POLL)
>>
>> I don't want to submit a bugfix to the net tree if the bug won't ever
>> happen in real life.
> 
> It would be really great if you could tell us which bug fixes you're
> submitting are for a real problem that you or a user have encountered,
> and which are down to essentially code inspection and things that
> "aren't correct". Basically, don't do this.

I agree. Patch 1 fixes a real problem, patch 2 "fixes" a problem found with
code inspection. Though, it would be great if you could review patch 2.

> 
> It isn't true that the PHY specific driver will be probed before DSA
> initialises - consider the case where the DSA driver is built-in but
> the PHY specific driver is modular and on the not-yet-mounted rootfs.
> That would result in the generic PHY driver being used even when the
> PHY specific driver were to be loaded later - and thus only basic
> standard 802.3 PHY behaviour will be supported.
> 
> That's not specific to mt7530, it applies to everything that uses
> phylib. It isn't something that really warrants "bug fixing" in each
> and every driver.

That makes sense. But there's a special case with the MT7530 DSA subdriver
and mediatek-ge driver. The PHY driver is needed for the PHYs to function
properly. So the DSA subdriver forces mediatek-ge to be selected [1]. So
the PHY driver could only be compiled as a module when the DSA subdriver is
also compiled so. And that designates mediatek-ge as a dependency for the
DSA subdriver, if I understand correctly.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=fb4bb62aaac715e50c7c007714af19a2698db88b

