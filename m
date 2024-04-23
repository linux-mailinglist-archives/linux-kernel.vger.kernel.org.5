Return-Path: <linux-kernel+bounces-154772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01E8AE0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F76C1C2193C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99958100;
	Tue, 23 Apr 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="RisI7Xup"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808C3399A;
	Tue, 23 Apr 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863579; cv=none; b=KzdPlHftg7iKQAEOfj31Z5+SRKet+ZrIjy+HTBtWCtUtZf/PXu8xEeS7H08KwmONs+p9aJnCBva2zGnoYhCLo/IrIRQtjCHA08f79qK6oEuinFaQgIuYXAUJnpEcZS2M9//zECBHepcip0tuLcg7+uqeWWlL+viRlgYOJ/pRbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863579; c=relaxed/simple;
	bh=KWOkFmG3aHAc/JdDHQ/HaYbgNUgxXSXQ/L5N+b2f3SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9bErGtbyrzDRwAQyFv0mzkRpLnLwDy72S4ExeUDTp+IT4dU0sfKwauoM5a4N7LLP+cWvO2K7mC951dW/XAjd1QrFaehhPGVJbjbGfQo04h0IRmTIwVXTTzgUo+Xhv9io9ahCgOCEP0VJLzJKHpDsujZ2mkVaC4aWWpDgi5jeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=RisI7Xup; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA66BC000A;
	Tue, 23 Apr 2024 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713863575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RSaeKenSkqzfI7p9YhBSwGcR+DegY61d7J8nJauZO8=;
	b=RisI7XupKRo6wJU3TRc7hhtxbnJr4vk3B/nwdTxtLfYbZbIpTA41dYeHgv83jFwkUkchaJ
	GRxF3LN4ttz6IQL4BgaxfR4QzSd+9e4jgnYPzGQC13E9EBcLVF3dmhG/CwAz9sS2RtKkKZ
	bXK6XI8RCIknkgSlHwDSBjP0btSBBwVQE7Pl6glaHHIO+HGLKiCJSKhqjA9AqgF15kYO3u
	A3C2vLY8YaUQam9W8pRs8kGne7fQ2IF7l/lRO8CtpDJUdNKeyjpubXqIX0TnNQK0XEqAc8
	SFwhodPli7/jQpUUBvMhLN2quJb3d3GujMPKB+UvyTdnWXHmdSsxZov3BHqJEw==
Message-ID: <6e67c66b-1d05-40d4-930f-625acc317ff1@arinc9.com>
Date: Tue, 23 Apr 2024 12:12:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mt7530: simplify core
 operations
To: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-0-3b5fb249b004@arinc9.com>
 <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-2-3b5fb249b004@arinc9.com>
 <6123223eaf54ea6f492c896d81551315a1e38f66.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <6123223eaf54ea6f492c896d81551315a1e38f66.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 23/04/2024 11:40, Paolo Abeni wrote:
> On Thu, 2024-04-18 at 08:35 +0300, Arınç ÜNAL wrote:
>>   	/* Select the Function : DATA with no post increment */
>>   	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
>> -			 MII_MMD_CTRL, devad | MII_MMD_CTRL_NOINCR);
>> +			 MII_MMD_CTRL, MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
>>   	if (ret < 0)
>>   		goto err;
> 
> What about a possible follow-up, moving the above writes in a separate
> helper (say, 'core_select_register' or the like) and reusing it here
> and in core_rmw() ?

There's a possibility where the Clause 45 access method could be used here
which would make this redundant. I will do your suggestion if that won't
work out.

> 
> Not blocking this series, I'm applying it.

Cheers.
Arınç

