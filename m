Return-Path: <linux-kernel+bounces-161041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B28B4637
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375FC1F264FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C64EB36;
	Sat, 27 Apr 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dXILapqo"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA834EB30;
	Sat, 27 Apr 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714218037; cv=none; b=jBlARM9TIb3H3euhdE1I+5WFpvunSAHtIrki18IbtCxwFVwsImnbO4UBLSGtjAVBxlOsWh7xbLHPkSq9qReiqpMBYW9a3PIX/ryw9VNGr6yjEpHPW+U+NaabWGR6RB5vCG5D9hBTHb/BBkjyoLEYDfJ2Ih2q++W73tJeE0PGWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714218037; c=relaxed/simple;
	bh=qHnjax+wVI8Hd0+8rGo+MaTwitn/56tGJ2azAOki7Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa8M7CP/zo8gumlgngm9oMU/t6NL9zUOWw5Ry9wtIUpallUqDtPVJHoyfEwOQo2kan3plSh/8zVCeu+5oW7ve+P1diA2VFGNXi5t2bFJYCPtVfvOQvqwCZWiS9z60VfRzkj+SNVIgfv+Ya9aMKEpiEXMhRcXvSIzmwsfbkPaRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dXILapqo; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 531CAFF808;
	Sat, 27 Apr 2024 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1714218032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Th/jadybDrg9puHNEAFgBTKzp4XwtZa5abxeCTq37w=;
	b=dXILapqokkWTzyMm9VzvUN0Z6dDfxO9bU7rAgTMNYEXK7vDiqfCJOABQZ4wsL8UcT7QWRN
	jHStMUmtR4NGqxAIVmKyYQCTm7kYSJyyFbBGgmO8xQ6a8llHGyGM0/M7dIWsZx3SmJ+dVM
	jfwSs6oJIXKl9GDK3XXR9ZLcYyjhZWQJL4gRAASonKr8RLzzIup0GeZ769avxKj/8A+BN6
	plqCU1JU/CgzUCLIzCPLAbyN3s1mM9zFbyRqpY8UNsytedIj1B/uivC67tjUDfM06txK7s
	27Zqd4MZnhMSpciumma0VibwqY9aZ9/ZDzUu3w4C8djBGmBVdLoGKTU0/q8pwA==
Message-ID: <f7af9006-492c-473a-bc77-054d85c6284a@arinc9.com>
Date: Sat, 27 Apr 2024 14:40:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/15] net: dsa: mt7530: move MT753X_MTRAP
 operations for MT7530
To: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
 <20240422-for-netnext-mt7530-improvements-4-v2-7-a75157ba76ad@arinc9.com>
 <Zixh0qsQat3ypqFp@makrotopia.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zixh0qsQat3ypqFp@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 27.04.2024 05:24, Daniel Golle wrote:
> Hi Arınç,
> 
> On Mon, Apr 22, 2024 at 10:15:14AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> On MT7530, the media-independent interfaces of port 5 and 6 are controlled
>> by the MT7530_P5_DIS and MT7530_P6_DIS bits of the hardware trap. Deal with
>> these bits only when the relevant port is being enabled or disabled. This
>> ensures that these ports will be disabled when they are not in use.
>>
>> Do not set MT7530_CHG_TRAP on mt7530_setup_port5() as that's already being
>> done on mt7530_setup().
> 
> Multiple users reported ([1], [2]) that after I've imported the series
> to OpenWrt they noticed that WAN connection on MT7621 boards using
> PHY-muxing to hook up either port 0 or port 4 to GMAC1 no longer works.
> 
> The link still seems to come up, but no data flows. I went ahead and
> confirmed the bug, then started bisecting the patches of this series,
> and ended up identifying this very patch being the culprit.
> 
> I can't exclude that what ever the issue may be is caused by other
> downstream patches we have, but can confirm that removing this patch of
> your series [3] in OpenWrt fixes the issue. Please take a look and as
> the cover letter states you have tested this on some MT7621 board,
> please make sure traffic actually flows on the PHY-muxed port on that
> board after this patch is applied, and if not, please figure out why and
> repost a fixed version of this patch.
> 
> 
> Cheers
> 
> 
> Daniel
> 
> [1]: https://github.com/openwrt/openwrt/issues/15273
> [2]: https://github.com/openwrt/openwrt/issues/15279
> [3]: https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=a8dde7e5bd6d289db6485cf57d3512ea62eaa827

Thanks for reporting this Daniel. I am not happy that I've caused all this
fuss. My testing as described on the cover letter did not include the
hardware design with PHY muxing. Lesson learned; next time, I'll make sure
to test the specific hardware design when I work on the part of the code
that would affect that hardware design.

That said, I've submitted a patch that fixes this issue [1]. I have tested
the hardware design with PHY muxing with this fix applied and I don't
experience this issue anymore.

[1] https://lore.kernel.org/netdev/20240427-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v1-1-793cdf9d7707@arinc9.com/

Arınç

