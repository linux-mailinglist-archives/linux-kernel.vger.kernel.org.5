Return-Path: <linux-kernel+bounces-118631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC888BD88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA58C1C36ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A54C3DE;
	Tue, 26 Mar 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="W79L7du6"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE23524A5;
	Tue, 26 Mar 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444799; cv=none; b=lbnyX9de1ezxJ87tNGy64K+Eu0oxZcC6YocGdfaqFpZoDqpn7Qcb9Bt1UtYf3YOGycfUAXMJN6s8F574lmHTjfuxpxBmTeR9AzHytEqYV6BWFt9e/iwGt5Jkrh7GuByJ5G5+ivDXO5/nvEtdwvVnGyvAdBZNRR8dS70hlGvy6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444799; c=relaxed/simple;
	bh=IOh3XEF8BBwL//UUzGaL2uNU4dFaGihDUknjvI2uROU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib5otsIpJa0NKkywDx+1DBHR0YHIAn1BUxr18FWq2zRm2rAJ6gwbhs06GAwiN6HQHxEpSqIjevfgI1odVGuglv5DQWWHNuuDjkmvDizfxozD/VbMZQ1cvnqnnQuA2A0XzYf0+jFoiHgJbCamPKdXdlp0kHLFjY1tOd4hs5t+y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=W79L7du6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27E4A240011;
	Tue, 26 Mar 2024 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711444788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5r0irEwQn1lB3UnLNAwqebaOIn42MDl/NmPOJcplkmY=;
	b=W79L7du6q9HZs1Gs+5VBgV8goGI2G4zYDm6OB/HDnFsDR/cyl+rlwpzRDXSVo5BG058Y3t
	KCWSoBXKKDza+xs5AxeKEInKNb8Yfi8l07NoBbb0EzR4fwIZdpP2K6/aPggQmOzyTe/6g5
	uggF2txSH8TqpcRd5qrv56ClVvr8Vz7hrdobfsukkq2StZivs3erSICy10Z6QZdZrFRwQv
	egveqbn64WYu9jO9buJlovfCmbvF+UomVb0UkL0kTRe8KItqDLfMHybR1EobKJf4Fg/C2+
	/+MkrO9MYX/PbF+DaIE1eKzexSME/ly5JKwP3mZmsxy43CT5dXhqfdGRKd5RQg==
Message-ID: <d65f4c45-e616-4157-a769-c285cbad575c@arinc9.com>
Date: Tue, 26 Mar 2024 12:19:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: dsa: mt7530: fix disabling EEE on failure
 on MT7531 and MT7988
To: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-2-9af9d5041bfe@arinc9.com>
 <799572b672ea8b4756236b14068aef7c8fa726a6.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <799572b672ea8b4756236b14068aef7c8fa726a6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 26.03.2024 12:02, Paolo Abeni wrote:
> On Thu, 2024-03-21 at 19:29 +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 bits let the
>> PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits determine the 1G/100 EEE
>> abilities of the MAC. If MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 are
>> unset, the abilities are left to be determined by PHY auto polling.
>>
>> The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
>> made it so that the PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits are set on
>> mt753x_phylink_mac_link_up(). But it did not set the MT7531_FORCE_EEE1G and
>> MT7531_FORCE_EEE100 bits. Because of this, EEE will be enabled on the
>> switch MACs by polling the PHY, regardless of the result of phy_init_eee().
>>
>> Define these bits and add them to MT7531_FORCE_MODE which is being used by
>> the subdriver. With this, EEE will be prevented from being enabled on the
>> switch MACs when phy_init_eee() fails.
>>
>> Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> If I read the past discussion correctly, this is a potential issue
> found by code inspection and never producing problem in practice, am I
> correct?
> 
> If so I think it will deserve a 3rd party tested-by tag or similar to
> go in.
> 
> If nobody could provide such feedback in a little time, I suggest to
> drop this patch and apply only 1/2.

Whether a problem would happen in practice depends on when phy_init_eee()
fails, meaning it returns a negative non-zero code. I requested Russell to
review this patch to shed light on when phy_init_eee() would return a
negative non-zero code so we have an idea whether this patch actually fixes
a problem.

Arınç

