Return-Path: <linux-kernel+bounces-108144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77BC88069C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C71C284034
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238064084B;
	Tue, 19 Mar 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="MHv/Y2Jf"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785353FBB0;
	Tue, 19 Mar 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882993; cv=none; b=XQqvA5oBc2h+pm6faiewRGvj5zu27sTFifEJPZ//nCdQKq/rDXr+eDhbD2sVg/8YhQNkwWSbOpQ6cRDYf7gFc5VDkUk2M/4agdiF1slu9FhB2jvIb5rYGIYCq8bjFl/EKRIvDmB08hsKpY7s9VTG84vdDIvBpbfCtN1BhJDXpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882993; c=relaxed/simple;
	bh=hVggVZ7F4YoaEhM4q8btxqhfFXmKM3YgpzpWHw+WR8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGVLs7ONGKXbMNFvaR33VDcEgD8Nombiqh3z2m+eQAKiiNJL4pos6DaKYVU6bsOeJR/kMop2DoRclWBC5c6CAl6vM4eCF9or4OenoD5TN05xfgeLuXr+OxfjkNy0OVOsg8qUy2uyGxNlGWsGYRSvHjzk/pwZmjENeM71WwHVvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=MHv/Y2Jf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A37D20003;
	Tue, 19 Mar 2024 21:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710882988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9s4X5Gi14fiprbPp/n09JkrAb3WJPWZ0M3os7Ylh/ek=;
	b=MHv/Y2Jf/gg5YRz9Xg02A3Uy/+L3ntSL/gPAF2UzYbGmc/qP7PHY7VuKl1zed85n+N0kdQ
	1o1k/QGe5GsBCSlsu39mtGksj8tLqwlnJ7WHeuYmJUOTLN8UP0ukvtN7f4FqZXg/Wv8AKZ
	mkWevzKGdbH9d1/Kjo5b6aQL2Fa88IJLQZwGG6TRvf8issssdzTBXSnOVcorW02H6rKQl4
	W8teqzjihbMWP1A90re1PyZwbcQn5VgYA5ceHRdyq2N8AnXB104IBNYkdxUa96gkkknxog
	fBwi1pMb8vaeKS9pQFCxNaQI2NRAfJjGt4aRoqOV43X4DOwUGW9EY4V5n6pisA==
Message-ID: <3c6ccef9-8654-49ba-88d9-d39e99d2b7b1@arinc9.com>
Date: Wed, 20 Mar 2024 00:16:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zfn1DxkEa3u-f7l2@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 19.03.2024 23:26, Daniel Golle wrote:
> On Tue, Mar 19, 2024 at 08:38:03PM +0100, Andrew Lunn wrote:
>>> I would argue that EEE advertisement on the PHY should be enabled by
>>> default.
>>
>> That is an open question at the moment. For some use cases, it can add
>> extra delay and jitter which can cause problems. I've heard people
>> doing PTP don't like EEE for example.
> 
> MediaTek consumer-grade hardware doesn't support PTP and hence that
> quite certainly won't ever be an issue with all switch ICs supported
> by the mt7530 driver.
> 
> I'd rather first change the (configuration) default in OpenWrt (which
> is arguable the way most people are using this hardware), also because
> that will be more visible/obvious for users. Or even just make EEE
> configurable in the LuCI web-UI as a first step so users start playing
> with it.
> 
> After all, I also have a hard time imagining that MediaTek disabled
> EEE in their downstream driver for no reason:
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/24091177a18ba7f2dd8d928a8f5b27b14df46b16

Are you saying this to indicate that we shouldn't remove that from
mediatek-ge? If so, I've already explained that there'd be no practical
change in removing it as both MT7530 and MT7531 switches enable EEE
advertisement after mediatek-ge.

Arınç

