Return-Path: <linux-kernel+bounces-108089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6398805D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E305B1F23304
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BA57895;
	Tue, 19 Mar 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="HO3WkU4p"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB61CAB2;
	Tue, 19 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878729; cv=none; b=YGbB9Lx8LZL2ik+SbdxkmT8aM5tjSxCLUi0ZFTvAC1ZCKctDjvyEe17b64boaldTMV6cZactTwiu6XNb7lQ25V0FkL4xSVthmpWoClrKpF6jR3ZQD5J6cuq+4jlCGiETJD/BeI2w1lWTSJTv/7xlkjMcTdv/ByN22IXH50CLf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878729; c=relaxed/simple;
	bh=8Ru+r5tmczOVlu4ej5UKX3wbZzLXCVtCcMTcY6qI3hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBFj0ipybEj7TzMlBim+hTWRz4EYkfp62VuiTUosP4X8/PoIuuKOO3BYqcA1XAlGpJloYgK5O0NhmW1lUO9aw5dU1IeyXINmKp3AxVzpIiIJ7UkbkL0mDH8GuaoB7z1SYDvmCHAIxwWKZUIwkLeWUEyNsnH0U+ondwR6c/14yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=HO3WkU4p; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24838240002;
	Tue, 19 Mar 2024 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710878718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6j8gsk/0efjiGaA6j1k1JY0wgpOfZpJCDP88uiiOZI=;
	b=HO3WkU4phWfOw6nkmEI15k1bdiHhhOOUzsS9cl0etLXk2S8wBLrnSkHn8XjXMyv6EN1XR3
	C7oyOImPYZ4kTV+5TlOp4wtW+fKVn19gGbTMyXoVkyI5jtbUepfm7keb6Yr7E33wAxdusK
	/piuAZB0JR+Y7dD5ylWGnMvLHziaYf9FbTDmRx2aa/SrRg0gQAar/eFToEdKrPH5v61Ard
	cvv4gjBNqakKYYlDwXJaLeNUsLDghUcLHxd+Fo8QpkyAS9FdiBw7w66w1gkyuxhD3C5zBQ
	jRaCKZsWSpnwb/AVIbB6HXDK4F8aVoOIGj4LjVZohotEK1TSubPdq9lVCRD6rg==
Message-ID: <7feb4cbc-15f3-47e1-874e-382ebee109de@arinc9.com>
Date: Tue, 19 Mar 2024 23:04:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Florian Fainelli <f.fainelli@gmail.com>,
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
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 19.03.2024 22:38, Andrew Lunn wrote:
>> I would argue that EEE advertisement on the PHY should be enabled by
>> default.
> 
> That is an open question at the moment. For some use cases, it can add
> extra delay and jitter which can cause problems. I've heard people
> doing PTP don't like EEE for example.
> 
> The current phylib core code leaves the PHY advertisement whatever its
> reset default is. So we leave it to the manufacture to decide if it
> should be enabled or disabled by default. It is policy, so it should
> really be down to user space to configure EEE how it wants it.

That's fine by me. Then my patch series is okay as it is.

Arınç

