Return-Path: <linux-kernel+bounces-112627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65623887C26
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF001C20F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EC17555;
	Sun, 24 Mar 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="U61oCGXp"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2316415;
	Sun, 24 Mar 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711273646; cv=none; b=i8ZFtqnM9Ns8yOXtsmYSnDPq67hkB/f48y8F7BQg70oi6CX122NvLpLlWfBockIKIGbFMthuFUBOtoHR8lexb8wNVuqtCLFFt/mYIbNj4EgudCBwVgrM6jqSuwUkTsooCpMv83P6UlzMM0Mt1wCKNmNnZNrWj6rf6/ZKAsDE3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711273646; c=relaxed/simple;
	bh=GWj5y/Qc1K9AjsAliy3LtjX0FL9bQH9JNI+Du7zxiQM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BCkmWrW02oE8sThkqcB/8FJ6UBMAPM8V2gJP4WBXiWej6NBxf58JP/lwb1oRSHA3qFwOVcyNtvgrltAlU+MqLiVetEXb3l+7D2grcZo5sY9xJ0R8BGPBcpzZZVbgF73kY2oi9cXjXYP6XIJoPMiX4WlVKwv5yaimADtZFxftgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=U61oCGXp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D280C40002;
	Sun, 24 Mar 2024 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711273635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f73/Dv7onEyO5WX6ZGZIZmakEQpnxirbQv7vQRZBis4=;
	b=U61oCGXpXRQHJIhDTF91TvYBDsLhHB1RxvBJ4BongC/t9IUZixLMFfWJCkbf/I1R9LCTss
	LbCTa4/lz7pFpk8TTyIuR0FBdkR7Om55Rde9zwnLXpzNZn8+fbxbSmVdAMXxf9CRaYqtSx
	V+Y6tNLH0IQ2OoAJcGgXEbVhFm0TPnnC+F6UhHZ6yedNXazTppRP9+cB2Yd0NhO8CfVPx/
	epUGhMDav2BQrpoQwf9Bnpp1ONpvcZ+pl1KBb4zqii/3a7HaciXiZiSnLfrLIDKcyXEn6e
	Nihvh1gBioe3f8bjApjJeLZE7uaBXQEkU7ClIYQohmFRSlAElVYXE6FgAdA7Ww==
Message-ID: <5a4c0436-cd78-419f-af14-9c4e0c0435e3@arinc9.com>
Date: Sun, 24 Mar 2024 12:47:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
 <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
 <Zfn1DxkEa3u-f7l2@makrotopia.org>
 <38798882-c033-4949-9446-4c6f15c25ebe@gmail.com>
 <0fbe7ba2-6529-4118-b050-8ea76d28b712@arinc9.com>
 <11b2a4d1-66d8-4bcf-b1a8-20a635b99cc4@gmail.com>
Content-Language: en-US
In-Reply-To: <11b2a4d1-66d8-4bcf-b1a8-20a635b99cc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 21/03/2024 18:31, Florian Fainelli wrote:
> On 3/21/24 09:09, Arınç ÜNAL wrote:
>> I have started testing MT7531 with EEE enabled and immediately experienced
>> frames that wouldn't egress the switch or improperly received on the link
>> partner.
>>
>> SoC MAC       <-EEE off-> MT7531 P6 MAC (acting as PHY)
>> MT7531 P0 MAC <-EEE on -> MT7531 P0 PHY
>> MT7531 P0 PHY <-EEE on -> Computer connected with twisted pair
> 
> OK, so this is intended to describe that the SoC's Ethernet MAC link to the integrated switch did not use EEE only the user-facing ports. That makes sense because it's all digital logic and you are not going to be seeing much power saving from having EEE enabled between the SoC's Ethernet MAC and CPU port of the switch, that said, however, I wonder if this has an impact on any form of flow control within the switch that is reacting to LPI and you need EEE to be enabled end-to-end?

I've tested pinging between my computers with EEE enabled interfaces. The
behaviour is identical.

> 
>>
>> I've tested pinging from the SoC's CPU. Packet capturing on the twisted
>> pair computer showed very few frames were being received.
>>
>> # ping 192.168.2.2
>> PING 192.168.2.2 (192.168.2.2): 56 data bytes
>> 64 bytes from 192.168.2.2: seq=36 ttl=64 time=0.486 ms
>> ^C
>> --- 192.168.2.2 ping statistics ---
>> 64 packets transmitted, 1 packets received, 98% packet loss
>> round-trip min/avg/max = 0.486/0.486/0.486 ms
>>
>> It seems there's less loss when frames are passed more frequently.
> 
> That would point to an issue getting in and out of LPI, do you see these packet losses even with different LPI timeouts?

The NICs on my computers don't seem to allow changing the tx-lpi and
tx-timer options.

Computer 1 (Intel I219-V, driver: e1000e):

$ sudo ethtool --set-eee eno1 tx-timer 15
netlink error: Invalid argument

$ sudo ethtool --show-eee eno1
EEE settings for eno1:
	EEE status: enabled - active
	Tx LPI: 17 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

Computer 2 (Realtek RTL8111H, driver: r8169):

$ sudo ethtool --set-eee eno1 tx-lpi on

$ sudo ethtool --show-eee eno1
EEE settings for eno1:
	EEE status: enabled - active
	Tx LPI: disabled
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

I've tested with switch ports interfaces' tx-timer from 0 to 40, same
tx-timer for both interfaces. Loss is still there.

I suppose the MT7531 switch PHYs need calibration for EEE that is currently
missing from the mediatek-ge driver.

Arınç

