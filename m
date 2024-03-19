Return-Path: <linux-kernel+bounces-108105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A083888060A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99ADDB21DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709465F86E;
	Tue, 19 Mar 2024 20:27:40 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187E1E494;
	Tue, 19 Mar 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880060; cv=none; b=d3oWkZSssV8bhbL5nN4rksRvmzByxp2cL8QtFrskorCLOio9YT7U9Oky/y3VG86GU0/BamYiSMc0WcuYAUQFATmlzJvgvnkofCuxTeFhZNuZCSxN+n6Ftwp0Uj0REJr1zm9aZ61qkOy0TEb3GfPBJddDVjMRnnU9aCaFAuKVYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880060; c=relaxed/simple;
	bh=280xtHLxGvOmxcn1ud+ofPYxJ3fY+ofYH1kJIxf2IT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuYGN0n1rHU6BDNxWjaLVAh2TlAZxzqin+SyUgGAjefyLs7xW30tU4EPeKgEwe6eNLwuNkLSU2yvKWIW7SqjnUJn+KL25t+u7b4gHYGACj+i83FM8lOSinPvbzJ1KpPcKAkEBr3VkgadYSoLa9hbC1I5GI5vIt8m9zdME0ubuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rmg32-0006OW-1A;
	Tue, 19 Mar 2024 20:27:00 +0000
Date: Tue, 19 Mar 2024 20:26:55 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <Zfn1DxkEa3u-f7l2@makrotopia.org>
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
 <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>

On Tue, Mar 19, 2024 at 08:38:03PM +0100, Andrew Lunn wrote:
> > I would argue that EEE advertisement on the PHY should be enabled by
> > default.
> 
> That is an open question at the moment. For some use cases, it can add
> extra delay and jitter which can cause problems. I've heard people
> doing PTP don't like EEE for example.

MediaTek consumer-grade hardware doesn't support PTP and hence that
quite certainly won't ever be an issue with all switch ICs supported
by the mt7530 driver.

I'd rather first change the (configuration) default in OpenWrt (which
is arguable the way most people are using this hardware), also because
that will be more visible/obvious for users. Or even just make EEE
configurable in the LuCI web-UI as a first step so users start playing
with it.

After all, I also have a hard time imagining that MediaTek disabled
EEE in their downstream driver for no reason:

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/24091177a18ba7f2dd8d928a8f5b27b14df46b16


> 
> The current phylib core code leaves the PHY advertisement whatever its
> reset default is. So we leave it to the manufacture to decide if it
> should be enabled or disabled by default. It is policy, so it should
> really be down to user space to configure EEE how it wants it.

I very much agree with that policy, changing the default definitely
feels like something which could affect quite a lot of people and
should be done very carefully, if at all.

