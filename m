Return-Path: <linux-kernel+bounces-139225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DE8A0014
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13DC1F23E41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506A17F36E;
	Wed, 10 Apr 2024 18:53:06 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A992E405;
	Wed, 10 Apr 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775185; cv=none; b=VT/TvYBVFVmpaODPA3ip1pjqrecNi1xeLq3r+RzcHwCDFUh2w9OtSJOdviARYW8z3h8Gd2AjHWLXIA6CZ0E7EiUZA0Ee4bMCib9vLoc1W4SjXRj/1emWIK3Ia3BTiDt9zR95sM4c/Hp5s0pXpXNCOUydqOZKvCPHRoNqJJpSzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775185; c=relaxed/simple;
	bh=MB/GDTg7r7l13A4bD83ZT67rRbSgLdSJjmRK2twUutQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nokbph4ybGfF7b8riGLiwpXcSVo5WAQzTGKWGUMpTi61JQ06Bu850fn15scJvsld60lo/Rluv/zQf5HicV6rpPHCY3WwJDJBN8GI3TYMrbbRZnUggnc/n34oh1d/I+pkyMqAG7DNiZoWzixIBnhpeREGo8HVTyahydD5FVdPgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rud3c-0001D4-1U;
	Wed, 10 Apr 2024 18:52:28 +0000
Date: Wed, 10 Apr 2024 19:52:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: arinc.unal@arinc9.com, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
	linux-mediatek@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix enabling EEE on MT7531
 switch on all boards
Message-ID: <Zhbf6AtfBfxXMIGc@makrotopia.org>
References: <20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com>
 <1f2bc5416a0a73756cc1f45f3300619eb201b0a4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f2bc5416a0a73756cc1f45f3300619eb201b0a4.camel@redhat.com>

On Tue, Apr 09, 2024 at 01:58:56PM +0200, Paolo Abeni wrote:
> On Mon, 2024-04-08 at 10:08 +0300, Arınç ÜNAL via B4 Relay wrote:
> > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > 
> > The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> > brought EEE support but did not enable EEE on MT7531  MACs. EEE is
> > enabled on MT7531 switch MACs by pulling the LAN2LED0 pin low on the board
> > (bootstrapping), unsetting the EEE_DIS bit on the trap register, or setting
> > the internal EEE switch bit on the CORE_PLL_GROUP4 register. Thanks to
> > SkyLake Huang (黃啟澤) from MediaTek for providing information on the
> > internal EEE switch bit.
> > 
> > There are existing boards that were not designed to pull the pin low.
> > Because of that, the EEE status currently depends on the board design.
> > 
> > The EEE_DIS bit on the trap pertains to the LAN2LED0 pin which is usually
> > used to control an LED. Once the bit is unset, the pin will be low. That
> > will make the active low LED turn on. The pin is controlled by the switch
> > PHY. It seems that the PHY controls the pin in the way that it inverts the
> > pin state. That means depending on the wiring of the LED connected to
> > LAN2LED0 on the board, the LED may be on without an active link.
> > 
> > To not cause this unwanted behaviour whilst enabling EEE on all boards, set
> > the internal EEE switch bit on the CORE_PLL_GROUP4 register.
> > 
> > My testing on MT7531 shows a certain amount of traffic loss when EEE is
> > enabled. That said, I haven't come across a board that enables EEE. So
> > enable EEE on the switch MACs but disable EEE advertisement on the switch
> > PHYs. This way, we don't change the behaviour of the majority of the boards
> > that have this switch. The mediatek-ge PHY driver already disables EEE
> > advertisement on the switch PHYs but my testing shows that it is somehow
> > enabled afterwards. Disabling EEE advertisement before the PHY driver
> > initialises keeps it off.
> > 
> > With this change, EEE can now be enabled using ethtool.
> > 
> > Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > ---
> > Here's some information for the record. EEE could not be enabled on MT7531
> > on most boards using ethtool before this. On MT7988 SoC switch, EEE is
> > disabled by default but can be turned on normally using ethtool. EEE is
> > enabled by default on MT7530 and there's no need to make changes on the DSA
> > subdriver for it.
> > ---
> > Changes in v3:
> > - Remove patch 2, it was revealed that it doesn't fix a bug.
> > - Patch 1
> >   - Use the internal EEE switch bit provided by SkyLake Huang (黃啟澤). It
> >     is a better method compared to unsetting the EEE_DIS bit of the trap as
> >     the latter method causes unwanted behaviour on the LED connected to the
> >     pin that pertains to the EEE_DIS bit.
> 
> Since this leverages something relatively obscure, it would be great if
> someone in the CC list could independently test it. Let's wait a bit
> more.

I've excessively tested this patch on MT7531 today, and reviewed it
today and yesterday. I've also picked it as downstream patch[1] to
OpenWrt, so an even wider audience will have the pleasure of working
EEE on those switch ICs and in-SoC switches.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>

[1]: https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=98f9154316fe8371c709bd11ae8f263e22075ec6

