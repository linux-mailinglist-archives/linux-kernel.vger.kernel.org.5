Return-Path: <linux-kernel+bounces-64237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D2853C91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C21B21A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AA6166D;
	Tue, 13 Feb 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M9soQuv2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0B612FD;
	Tue, 13 Feb 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857939; cv=none; b=ORn5eVtIC59BN7CXRwc82g1QtbpWnvkWQaE8I+PYQGkqMgZtg8YU0PteKydQmRCTaJUL4Ibe1udw8wD/++EpPrQAN3eq5vBKja0yTtnB5WzaDmsiMCmljOizrrn+WqfFU9Rx8fsXxtZshPk6y7IBF9FB/V6+BFqu/03OPZecVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857939; c=relaxed/simple;
	bh=sMc0wkAcU9sU8DBluQOSxS/iw8EL2/v8m4HjZdznSos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjwkhQuYZJWUjP48/NxX+icboLVQJU+sIDSA8RMrQQ2r3xnSfkranVEAfMbhIHiVi+iY63Q6ffmMxS4J6boIoiHE32MV8p+BjonYV8Vwtxm8J9GwkHmUnyqg9p/qJzj01qkmL7bP8tq5ucESa1Wqk5OS6Q3pqvrxMEXOJ9yLOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M9soQuv2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JzBsHjPCw9jYYKUYI1fE7FfGlYl2lggPJVrd5oZJYqE=; b=M9soQuv2DofJ1tPs39LAtoERcU
	8g/Z10Nuv2XDliZyevUXupgmODvPOHp9ziMSjW9SM93HQ7jGV7WLr/2iHHNO+5W56tmkRHhrFxz1F
	BnRZI4gpr34gmdh6TJCj2SgTkHfBNadDULgbqs2W+/NgdXE6RGhOHACpO4T1YHQqZIhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZzrn-007iqc-6V; Tue, 13 Feb 2024 21:58:59 +0100
Date: Tue, 13 Feb 2024 21:58:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/2] net: phy: aquantia: fix system
 interface provision
Message-ID: <a71e473e-bb92-4769-9f52-53de63f6a4ae@lunn.ch>
References: <20240213182415.17223-1-ansuelsmth@gmail.com>
 <ee00b11a-4679-4ba4-be42-10f15d5e9f65@lunn.ch>
 <65cbbacb.050a0220.b81d1.eb5b@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cbbacb.050a0220.b81d1.eb5b@mx.google.com>

> > So in effect, the driver needs to write every single register it
> > depends on.
> >
> 
> Well if that's the case then this RFC patch is a must. With a
> misconfigured System Interface configuration, the PHY can't comunicate
> with the MAC.
> 
> > > This might be the safest change but again would not give us 100% idea that
> > > the thing provision by the FW are correct.
> > 
> > I would say, we have to assume provision is 100% wrong. Write every
> > single register with the needed value.
> > 
> > Is the provisioning information available? Can it be read from the
> > flash? Can it be dumped from firmware we have on disk? Dumping it for
> > a number of devices could give a list of register values which are
> > highly suspect, ones that OEMs typically mess with. We could start by
> > always setting those registers.
> >
> 
> We know where they are stored in the FW but it's not documented how the
> provision values are stored in the FW. (the format, how they are
> organized...) I can waste some time trying to reverse it and produce a
> tool to parse them if needed.

It might be worth it. How complex could it be? The obvious format is a
C45 mmd.reg pair and a value.

> Would love also some comments by Russell about this, there was a patch
> adding support for WoL where another user was messing with these regs
> and he was with the idea of being careful with overwriting the provision
> values.

I expect the SERDES eye configuration is in there somewhere, and we
should not touch that. That was one of the arguments Aquantia made at
the time, that needs to be stored somewhere, and is board specific.

But knowing what standard 802.3 registers are commonly changed would
be useful, and could help track down silly problems like the
transmitter being disabled by default by provisioning.

	Andrew

