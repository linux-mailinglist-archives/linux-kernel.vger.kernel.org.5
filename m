Return-Path: <linux-kernel+bounces-63784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0E853459
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375E61F2352E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB255EE96;
	Tue, 13 Feb 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WMEMpsba"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A95DF37;
	Tue, 13 Feb 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837013; cv=none; b=N47HkaRrWKeZSZQNwUaaYG/c8e9BjmflqrZLFVm/Gzn0HGLBHvu9jg6X93yqx94i/8uqUJZCOPRMQwuUWn9StltbUPC+mfC9JJVUCD9q5+w+2F6UrZ26l3PpkOzRkJGVavFiL1AdZGeOmWQ5ZnuNu5zaVGutVyA8OHe4wPoW+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837013; c=relaxed/simple;
	bh=8JpYlpRZ/YtjwUK9dUoDXdjuuE48fRgeitE+8LL6FL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekr0m78F/UY3/7AHCzxUF5/wmXUayd/jFMogP7keJ37NlP9IqBBeHJsmWkiBYhQfKF1AOKrAMY898k0wJUNFPUF7f4HEW6hcHIeyhaBNfz2VJEKUh5wf6XecHBJhe96Lhb8JCPdjQOgcV6ySMYVmXkrwqMg0sQpqLzom7LMxYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WMEMpsba; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EW2Z4z4tbC8mVYcPOsOEQqRS2TMEj+6BsqWaI1ui/fo=; b=WMEMpsbaiVbZvDHWgS+CI5/scn
	LOgxpQb6behfWkHoVBhMwiy32VWB7upCR7JI8TXUhic+m8pheSvjTvslYP5QKpWn3H17iu6gEfPok
	oz/pGjsKXyV0lcXEv3vCJS1GF88h0jcyHKuYuOWuKvGVMBHNK79BFTh04uo4WIJbYhbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZuQ5-007h0O-9x; Tue, 13 Feb 2024 16:10:01 +0100
Date: Tue, 13 Feb 2024 16:10:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
Message-ID: <a10c3b55-c6c3-4982-b294-d6e5b9383e31@lunn.ch>
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
 <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>
 <65cb7a25.5d0a0220.de7b7.a1f3@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb7a25.5d0a0220.de7b7.a1f3@mx.google.com>

On Tue, Feb 13, 2024 at 03:18:09PM +0100, Christian Marangi wrote:
> On Tue, Feb 13, 2024 at 03:09:57PM +0100, Andrew Lunn wrote:
> > On Tue, Feb 13, 2024 at 02:35:51PM +0100, Christian Marangi wrote:
> > > Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
> > > but actually supports up to 5G speed, hence some manual fixup is needed.
> > 
> > Any chance this is a "golden screwdriver" situation? The chip really
> > can do 10G, but the firmware is supposed to limit it to 5G? This is
> > just a firmware "bug"?
> >
> 
> >From [1] the PHY can support up to 5G so yes it is a firmware bug. I can
> try searching for some regs to fix the wrong provision values if really
> needed.
> 
> [1] https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen3-product-brief-2019-09.pdf

I think you missed the meaning of golden screwdriver.

https://www.urbandictionary.com/define.php?term=Golden%20Screwdriver

It could be that the silicon can do 10G, but marvell are selling it as
a 5G device, with firmware limiting it to 5G. And that firmware
limitation has a bug, so some of the 10G functionality is leaking
through.

Anyway, you change looks O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

