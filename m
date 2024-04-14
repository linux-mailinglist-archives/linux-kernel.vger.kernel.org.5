Return-Path: <linux-kernel+bounces-144038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF28A4120
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6631C21279
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FE22EF2;
	Sun, 14 Apr 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ecIEWTgv"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249123741;
	Sun, 14 Apr 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713082586; cv=none; b=rc7lPOS/bG7JBmcO2Lv7ZHdO9uyuxokyn+P1cDvi9y0+TeY1YnTmr2Xq7IIlj7Ey5UFFOVKVPdV6wFBh+FrUEkvW6hy8Q8280a5KYy4Vpkf99eXEITaunYTLBQ0NX+5DSb9MJKJKDesZLiZ/0aM9eFIF5FoKuVPAQhmA6oPp3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713082586; c=relaxed/simple;
	bh=xP/n9GO1x98CwspPsPSUsSQJUSI8U4FNwThGNr9CX0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnbb4kck1J1GtFYR2Ui6aPq/TbHZYeK29n2w2NG/AeA9OkMPqULeTYH/5F3i5oyawNv6y3QcqpmzdF7H7kAZwEp+r4Aw8ezb5kBSkwkS7koVnoj3Bu/zhz4ojnC0rlZ1TGv49B6hPf4jU+4H18fNrS9YuGrdEfm9utOpIQQq1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ecIEWTgv; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vusxraUSs2kxovusxrWrdY; Sun, 14 Apr 2024 10:06:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713082014;
	bh=RqNeVXpCo0a2FuxgS0FBsXQeNAgyt63dNpBjp06s8g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ecIEWTgvlHyKrM4aCxe4CxwWY4N/umtZUc2i4EtdMOVJe8sJOlyDlXsVyoY3aBLZx
	 PoBCEAaZvNT2sYVBc18j3+ZjzAwVs+3RZj3WfqdFd8t+/4ftfsdYrqqI4ZgZEh2+mx
	 Cix0AjGZ3y6dUa1rBZVElJgC8hAIccScNvnKB9EuWh09UHPLH0VXkNbUb6UDa1y35k
	 5hatGlnKICKCKsl39QglBi84en3X5xRlxRvk7/UgIBpCbmPpbyrguGoHwRF4OpOjWi
	 6BYmY/NtLMvnTOQ3mN7XiV42zxMnF//qG3agRHXqHk9SKScEd1ZFt8H5I0cv2zCGAK
	 G1xBC+25UWS+w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 10:06:54 +0200
X-ME-IP: 86.243.17.157
Message-ID: <6faf8008-3a64-4ed9-8d7e-52ff32862df9@wanadoo.fr>
Date: Sun, 14 Apr 2024 10:06:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: mt7530-mdio: read PHY address of
 switch from device tree
To: Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-0-b08936df2770@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v1-1-b08936df2770@arinc9.com>
 <ZhtJGEdjeS3LfMWF@makrotopia.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZhtJGEdjeS3LfMWF@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/04/2024 à 05:10, Daniel Golle a écrit :
> On Sun, Apr 14, 2024 at 01:08:19AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Read the PHY address the switch listens on from the reg property of the
>> switch node on the device tree. This change brings support for MT7530
>> switches on boards with such bootstrapping configuration where the switch
>> listens on a different PHY address than the hardcoded PHY address on the
>> driver, 31.
>>
>> As described on the "MT7621 Programming Guide v0.4" document, the MT7530
>> switch and its PHYs can be configured to listen on the range of 7-12,
>> 15-20, 23-28, and 31 and 0-4 PHY addresses.
>>
>> There are operations where the switch PHY registers are used. For the PHY
>> address of the control PHY, transform the MT753X_CTRL_PHY_ADDR constant
>> into a macro and use it. The PHY address for the control PHY is 0 when the
>> switch listens on 31. In any other case, it is one greater than the PHY
>> address the switch listens on.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> See minor nit inline below.
> 

..

>>   
>> -#define MT753X_CTRL_PHY_ADDR		0
>> +#define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr == 0x1f ? 0 : phy_addr + 1)
> 
> #define MT753X_CTRL_PHY_ADDR(phy_addr)	(phy_addr + 1 & 0x1f)

Nit: maybe (even if certainly useless in this case):
   #define MT753X_CTRL_PHY_ADDR(phy_addr)	((phy_addr) + 1 & 0x1f)

?

> 
> It's shorter, and works without conditional operator which is expensive.
> 

Cj


