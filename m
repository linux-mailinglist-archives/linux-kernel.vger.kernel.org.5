Return-Path: <linux-kernel+bounces-146500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A78A662A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D822281BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322A811FE;
	Tue, 16 Apr 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SXiPD9tA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314B3EA7B;
	Tue, 16 Apr 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256384; cv=none; b=PDIIhO58g48SNRnQ0xD/0BV3ig8mv0oBae5L5aUrzd7Ur6W/yJdckC7jGQt1LSBQ+hI2JZV5IdrPTLCRuqszxrC+b6tnS3cPawXmyGoGwapTszzEOp3XSdj0Pj7eWRox4D8b9opShE9E0bMnD/1LSV6oqwOjGi0/05rv4FtbLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256384; c=relaxed/simple;
	bh=lflb0pIufUXxyIEvkfnw/gPvn4JiT4OjGBMvQmX6qxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n94Bjpl5jAblhaCbpUY7CDmAJikp4NoeYYN6f0DxQTKSFItDPgyMQjxqv+YejL5hB44ZdXA+ZGIhJ5teXyvGQBlxsVxg4T9OxyM+5M3ydAScrkDTWfMMcdEevlxEPdwsIjnCkl+XWtCCB5tpLSf0+ZglMxKUs7F1t1bL8WCQfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SXiPD9tA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE1FD1C0009;
	Tue, 16 Apr 2024 08:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713256375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m566RVi6Hjc4VyINZc6IMhS42+xhOl1ARnyrIuF1SbM=;
	b=SXiPD9tA3i+YVZj1nSoulZISksMVUPC9CQbgwO1PiVLiguE+LcuIS0qBfzixGRc6j1xhi8
	uHlSIWDTTgF9NgPoZmZVWz3UbBplGE0SEwWD8uV/dz1mJu2vgjF/uiboHYWpd7dkgcNdRf
	WtN3t/O3N9yp+lfpAQUvgCmhXpe9ofeAPmn8o9JGkoOiyR82NwHPluSG1W/ARFWQ/IUAZU
	RyxVW7rNmzpEU1pZvtOnNXCSpcisSn0AnWaZDO3/CwnLH7Qcyo7NgQJQ7l3O/9WtY3MX2r
	T/8TcK3bBxBkX140iMJJHuBG3qUoOZERTbl3FFLHznSEszmBgZZjXcFWdMI7HQ==
Message-ID: <7d0ded52-14f0-4f6a-b639-72f537603be8@arinc9.com>
Date: Tue, 16 Apr 2024 11:32:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mt7530-mdio: read PHY address
 of switch from device tree
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
 <459b31bd-64b3-4804-bc5a-c8ffd145e055@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <459b31bd-64b3-4804-bc5a-c8ffd145e055@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 15/04/2024 18:30, Florian Fainelli wrote:
> 
> 
> On 4/13/2024 11:07 PM, Arınç ÜNAL via B4 Relay wrote:
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
>> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
>> Tested-by: Daniel Golle <daniel@makrotopia.org>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> I would go a step further and name phy_addr switch_mdio_addr, or something along those lines to clearly denote this is not a per-port PHY address neither a proper PHY device, but we've already had a similar discussion before about spelling this out clearly as a "pseudo PHY"....

I am fine with calling the switch operating on an MDIO bus a psuedo-PHY.
But I don't believe this grants making up names on our own instead of using
the name described in IEEE Std 802.3-2022. The switch listens on a PHY
address on the MDIO bus. The description for the phy_addr member of the
mt753x_info structure clearly explains that so I don't see a reason to
change the variable name.

Arınç

