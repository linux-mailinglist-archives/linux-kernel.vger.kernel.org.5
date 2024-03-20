Return-Path: <linux-kernel+bounces-108597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C869880CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013A11F235A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FA2E415;
	Wed, 20 Mar 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="PfB7bBnl"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705A2C68A;
	Wed, 20 Mar 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922254; cv=none; b=LkggX0ELxPxL1y3mpe2CAGL0p7ez1tEU/M11RYk9b7vWnzN8LWL1ipqaXxh6ndghJA3hiOMT3bq8oVSnfj1HtvEv7UZepv4CV2+fL+BHzm3h3nJwNHAOLfrfnljqon+3PhvN1QrK3RCUROOy4LFxumJuYibz3S8JG/jRgEc649Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922254; c=relaxed/simple;
	bh=WIh25D4UDwcanH5bYSHrwFXTlS6u6SDi3NuZcoh1ptc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bjhswm5KHJcrbhV2/U8D7ZbAvwIr2lfsnYttiQk/eFm0W/r1OjMIzjqmGyUOYsqxQqCmstXL4HO8hbEKiTfKGcu+Y1lpkqYa0d0l6eRA95dueuMwSOSp1vhafV5xXb61MhgjO/kIysmMTRpQTWTnsUd4Il2rBaFgjVlyrEnly9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=PfB7bBnl; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59D56C000D;
	Wed, 20 Mar 2024 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710922246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SaWDM3C4NrbrAUXV6EDAofx5hE7nR6MhxlVcBrFRh+U=;
	b=PfB7bBnliBYXJICYCLKkGAUdhqDbSe1Sjs8BsDpqoiBbXMMZuapjDYLwI4WR3e0HWifNUl
	kcGtmIrXrDK1U2uIGf1sKPv/tyxOpCEgWihHoJuGa166wDxniLBi/4p2bueL2CpFKMMJea
	uJI2T4pzWMw3GtHZaD7swteQgcqm3whZ8mJBLrAGR1s6+2UwZrdkQO9kZJ5896ihbNKkQQ
	JHIfK6+xssnsH+YH/pfk1DC3oZJXhc6xKMBhcQD81kvrSIljRRFZYjfinei42CJ4Io6B2f
	GIaBr1GZkasDCw01DmMlCCE6HZItBsQBLXJjVIPlvsTJ+/EuvnkMEOYHLCl/XQ==
Message-ID: <9d111cc9-c73a-4d3c-83f5-3f59e6c8841f@arinc9.com>
Date: Wed, 20 Mar 2024 11:10:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 18.03.2024 10:46, Arınç ÜNAL via B4 Relay wrote:
> Hi.
> 
> This patch series fixes EEE support for MT7531 and the switch on the MT7988
> SoC. EEE did not work on MT7531 on most boards before this, it is unclear
> what's the status on MT7988 SoC switch as I don't have the hardware.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

I see the state of this patch series is deferred on patchwork. I see that I
forgot to delegate this to the net tree. As I don't see any objections in
this series, I'll send v2 with it tomorrow.

Arınç

