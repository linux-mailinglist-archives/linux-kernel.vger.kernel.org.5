Return-Path: <linux-kernel+bounces-106190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4687EA85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DA81F232E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4FC4AEEC;
	Mon, 18 Mar 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="CamfvvLz"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F931E86E;
	Mon, 18 Mar 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770654; cv=none; b=W+uosG17E1rRjSt0orMB2zcwLRz9cSD+QdNjz+UTSEC6VRjso69IYjGc8hzPjhcNe4oSMvAIhKXjNrwqHqKKZoQJvdIL9hYEskXgUA23fGbWgdC4ZRj+6cnPL0a/igRY214qypXN60K32huuzU7V9fpC7qi3T3SAPeFWjZU2AxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770654; c=relaxed/simple;
	bh=yt0vvdQ0AF4dKywIGaeSYn8xaqprOqcsJER6kJkaP4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwyMWVfUx+HUFrsTTGG8BwtYfm35Sq04FNfnbKYcD/IP2gdzQ1AQsEVmtE3gBiw6xHRQs1qUQXhfr80BRJ2h2M6E9gm7OnrYsp08vTqsBVjY4WZFD47lMSFm/SMZ4qKnrbv75OeijXPC53SEJcdbBwow9lEDaFMUisl+D5+SdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=CamfvvLz; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 0FB6CC7C6B;
	Mon, 18 Mar 2024 14:04:04 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB309FF808;
	Mon, 18 Mar 2024 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710770636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1f9OOyD8ojNFCWrfNkKyD6ZGmK3+QyUoXSTo95z0FgQ=;
	b=CamfvvLzQzsBdgypLgY/TEg7rsBJh9tJ+ohoflWSdsyQbji5ujNuZqci7HP0KRoS8CjBHi
	WQUwkIFa0sq59pFBT/Q/sHh/MN2UDjG9j8C0YB/MLpZ2F6V+oGNWO7zJAC9aGrPaCp+pA7
	l67S4uSyqKrf/IXUSdhKv+qQhnD5weIhkuXCwmuO6BgO6ybXvCc3HWv+3Ez3xHoZaJvEpr
	6o2E6JOawk0LC42vui9eCdiW0sy6eGQwUT/ATypB1Cp+wTf0mQ39C8Ouxhc+HDcsCmkSNv
	8N0907nZNxmBUv/2myPs/IO2VqI4Te9Nm97Ofictb1Pt36iqmfcw2c/OSYxz2A==
Message-ID: <ea889226-3649-4f74-8c38-67c459e4ea4d@arinc9.com>
Date: Mon, 18 Mar 2024 17:03:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <65f7f17d.050a0220.3c75a.cde3SMTPIN_ADDED_BROKEN@mx.google.com>
 <5514243b-c795-436e-8628-8f421c900bcb@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <5514243b-c795-436e-8628-8f421c900bcb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 18.03.2024 15:57, Florian Fainelli wrote:
> 
> 
> On 3/18/2024 12:46 AM, Arınç ÜNAL via B4 Relay wrote:
>> Hi.
>>
>> This patch series fixes EEE support for MT7531 and the switch on the MT7988
>> SoC. EEE did not work on MT7531 on most boards before this, it is unclear
>> what's the status on MT7988 SoC switch as I don't have the hardware.
> 
> We've received your patch series 4 times and this was the same thing with your previous b4 submission, can you find out what happened? Thanks.

It looks like my branch name was too long again. b4 0.13.0 cannot handle
branch names that are too long. I'll keep it shorter for future
submissions. It'd be great if Konstantin could provide a specific limit.

https://lore.kernel.org/all/20240205-silky-sensible-puffin-8e23ee@lemur/

Arınç

