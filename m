Return-Path: <linux-kernel+bounces-43038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B730840A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BECB22752
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EE15530B;
	Mon, 29 Jan 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Pz/YiQMU"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10721154BEE;
	Mon, 29 Jan 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543604; cv=none; b=nxoohPkgrH7dzteHcfq6UzC0lIvbjZh9qlOipYsIZ306O3rkOp1SOFpjo55XnuJzGhl35G8jjGBfoINlUInUz+fpxG4BNeZ4oXPoTu7O3+cm+n/jds6Hmjpln4XnAI+Aoqp5Z4Avu/bZ0bTC5/l7Zt0gj4WCr9ImhQnU2wdrFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543604; c=relaxed/simple;
	bh=30B39kt2T6fIrtx/54G2x6YGaUHwJVG+0+8CunFDuQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oawA0RiC4RC4KuHXO02cntqd8co7x8uakGmhUjENXZe6WHCTdcl+xzl4BLm/5gSwyZusi4UjhV8HwPibVvWwCYdx+SeuP3XLTMiiMZOaaPzYzMAxHmq3/C/b7Ih7e+i9lHQtm6OKmbzfty5rnbsTOE3SmRa0q02u246DpX8e15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Pz/YiQMU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5BEBFF808;
	Mon, 29 Jan 2024 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706543599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv3PMf4fY1pbuKUa1JNM5dOu/R0kOpxjHd38nxGZDWA=;
	b=Pz/YiQMUwq7eAJ8pYBk5TyOi+/JOofuX2tqg/171A9V9fvl9PCUR5DU2jGqjhgxuz9EaL/
	ZF9oNMoq6rfUGmma3thDv5IDtaf8n3oe/0xsytwkEIt39HldGaWVj569aIs+wBVAYRI900
	hbKPV/Y/Oe0S1HlalZHuNp+maibeeJ6xGktlxWkuZJtGTgOVg7JNUvlJg1QrGP/OVt3fiW
	FDUvL/RFxtbM92KW1SuGhIEE4V+S+7D0l4CzgzE4wwS+v4xOPLQCGSK6L6Hpq3rzhYVvtS
	gRA04HcmC3hn+vBVaOq9KASoKvRF0AKxhEKXlH8zubK9XWh3mFXTTxN51J8lSw==
Message-ID: <816442dc-b420-4413-a29f-c73b95f1026b@arinc9.com>
Date: Mon, 29 Jan 2024 18:53:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
To: Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240123154431.gwhufnatxjppnm64@skbuf>
 <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
 <CAJq09z6pidHvtv=3F_yKHDdY89kzYSF+xh89pzg1raAiQPMyMg@mail.gmail.com>
 <20240129145632.d2mu6vbwcqhjpyty@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240129145632.d2mu6vbwcqhjpyty@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 29.01.2024 17:56, Vladimir Oltean wrote:
> On Sat, Jan 27, 2024 at 11:23:33PM -0300, Luiz Angelo Daros de Luca wrote:
>>>> IIUC, Luiz made the original patch for the realtek switches. Shouldn't
>>>> we wait until realtek registers ds->user_mii_bus on its own, before
>>>> reverting? Otherwise, you're basically saying that Luiz made the DSA
>>>> core patch without needing it.
>>>
>>> My findings point to that. Luiz made the patch to optionally register the
>>> MDIO bus of the MDIO controlled Realtek switches OF-based. So it's not
>>> necessary to wait.
>>
>> Back in the time when I wrote that code, with the phy_read/write in
>> dsa_switch_ops, the OF node was only required to associate IRQ to each
>> port. Until my patch to register its own mdiobus driver lands (I hope
>> that happens before the next version), the port status will fall back
>> to polling. I don't think it is a critical feature but I'll let the
>> maintainers decide. ACK for me.
>>
>> Regards,
>>
>> Luiz
> 
> It isn't really great that this loses IRQ support for Realtek internal PHYs,
> especially since Arınç's commit message did not estimate this would happen.
> 
> I don't see why this patch could not wait until you resubmit the realtek
> consolidation set and it gets accepted.

I agree. I didn't anticipate that realtek-mdio didn't set IRQs on PHYs for
the MDIO bus registered non-OF-based. I'd much rather wait and then send v2
with the mention to realtek-mdio removed.

Arınç

