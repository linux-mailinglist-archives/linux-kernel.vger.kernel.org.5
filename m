Return-Path: <linux-kernel+bounces-78705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF31286179B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710DB1F222AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8A84A52;
	Fri, 23 Feb 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h9r3OKNb"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096698662B;
	Fri, 23 Feb 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705142; cv=none; b=IsN6RkLDY/+Vwil96l7kowFnmnWu+6dRLDjRNjbqsOXLnPHniyS49Czl++mjEOxRCZPH2gmD1lD4z6y+G1pt4ujLTvrTrd34ZI3T4QZA9MR/Y65gEWSOKxKLIHJYZ5xN5eDtl+5xxb0nGZ9fiPIFn2s6XG0AVaFpy7CVgPD7hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705142; c=relaxed/simple;
	bh=EfdyY8CkHVUBlSGRNMJ1Wclp6OspxwnZBLVVtssweeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdCtB+yADfLAFIXEJ3GJh8sqot3tTQVPw+vvSfo+iXoCHs5jhjoSm36HgS7fAKhkwfTMz4Bd4U2ejGjL9rJGtHic1T3JUQdFBjKEoV5Bd6F7gFwguP6TMupwSaB5yEVF5Mhn9ROVwNqxgwtze7Xm1xKim0QdZtfF/Zf7oYl2ZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h9r3OKNb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gF/Ti7D21vwoFI4DqzVKjlG8oLxKTV8TrLzK+qAxWrI=; b=h9r3OKNbVQXvK+1iTcWLEhWhab
	svwLD5LNTD+DAHUrXi/NUhh1vCka/bP+UYK56IoNIFgJuUjBHRb9IoERvD7lKOZtcmuOF4H3HICsS
	BSNBpjTVU4xcJZ8wEnb4DhLsB6MVdtpy91Oz6sYdWTicK0sKFUvvX05PTbabb2IN8HFzxmpJEa/Fd
	h1NaPgum3+J0OfEMxEOuC/UjNuo5mx1TtmqKhx97PpS692NzaYyXWL3aZ8kQf3yTjVAIIwGLvHUVK
	81AA9e7e1St2X12w2gn3nJRMkAHhCt6R6g8v5WE3F9A8V714rHSQuISNcgix66maBvAyYmkeh2Gln
	yg6lEz3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdYFy-0000AR-0C;
	Fri, 23 Feb 2024 16:18:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdYFv-0003kQ-OW; Fri, 23 Feb 2024 16:18:35 +0000
Date: Fri, 23 Feb 2024 16:18:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net] net: phy: phy_device: free the phy_device on the
 phy_device_create error path
Message-ID: <ZdjFW3EZewQvyQt7@shell.armlinux.org.uk>
References: <20240223160155.861528-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223160155.861528-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 23, 2024 at 05:01:54PM +0100, Maxime Chevallier wrote:
> When error'ing out from phy_device_create(), the previously kzalloc'd "dev"
> pointer gets overwritten with an error pointer, without freeing it
> beforehand, thus leaking the allocated phy_device. Add the missing kfree
> back.
> 
> Fixes: d02cbc461361 ("net: phy: fix memory leak in device-create error path")

No, it doesn't fix anything.

Sadly, this is the second patch that I've received recently which shows
a complete lack of understanding of the driver model, so I suspect
someone has documented something as a task, and that documentation is
either incomplete, or basically wrong.

In this case:

        /* We allocate the device, and initialize the default values */
        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
        if (!dev)
                return ERR_PTR(-ENOMEM);

        mdiodev = &dev->mdio;
..
        device_initialize(&mdiodev->dev);

This sets the reference count on dev->mdio.dev to '1', and means that
at _this_ point, "dev" becomes a refcounted object. device_initialize()
is documented thusly:

/**
 * device_initialize - init device structure.
 * @dev: device.
 *
 * This prepares the device for use by other layers by initializing
 * its fields.
..
 * NOTE: Use put_device() to give up your reference instead of freeing
 * @dev directly once you have called this function.
 */

Now, the error path does this:

        if (ret) {
                put_device(&mdiodev->dev);
                dev = ERR_PTR(ret);
        }

which is (a) compliant with the device_initialize() documentation, and
(b) will drop the reference count of '1' down to '0' resulting in the
release function being called - and it is the responsibility of the
release function to free the memory.

Adding a kfree() in this path will lead to a double-kfree() of the
allocated memory, and that is _incorrect_.

So, given that this is the second such instance of someone wanting to
incorrectly kfree() a structure after a call to device_initialize(),
can I please ask everyone who reads this message, and who receives a
patch like this to _please_ not assume that it is correct, and check
it _very_ _carefully_.

Can I also ask those who propose to send out such patches _also_ do
the due dilligence and check this before creating noise.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

