Return-Path: <linux-kernel+bounces-70550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD12859914
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157431F215ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDA71B33;
	Sun, 18 Feb 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wPKgVFV1"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38D1E86F;
	Sun, 18 Feb 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284818; cv=none; b=Qn8jklqRDSruox2tTJ67Xr3ZHmmo81Vz7I2c+OTmLDNJYceegsWVO8MdnK8TJ+Bm+geXIMPlML+HvxQXiGxOLygPWO5pobujGBYX3zgy+UAoWYjBIkYAgn2n3KB4vydCHjP2wZARGV3Hk083HYNVeGo8monCr5GCvrTKF2GbnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284818; c=relaxed/simple;
	bh=7Ghd5hY5Zy9MQ5coy0TWaYNTyXdVwzw9c3pyJIdHTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Czj2S4rhu21iZrBJYXrSOxiKAwNYCRiE31/ogM0bAuZLjmV6efKUCjCgDIQaH/LpBfcqItwrdQNOtSICsnQu67lGWM6r0IXUgzrzO0ldkUkzep/2Soc8mbAQ+Q/nnhwtlax5JRR0Iv2yqZtlbvtN1+Dcqg0Ry1SmHsq8fqtuCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wPKgVFV1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FlX/3S5lEmqhQMAXnL/TVCuNUd13KReMyckuk67tlEY=; b=wPKgVFV1sdcnrsUaZQ+Laj8Uzi
	yIyEgf7BmnGsvBub/q1CaOXjdq9ssi2dYVAH423kmijFCbZWzWbyVD/5KHePX8Kno1l91s17U5Bh6
	Fo/NZhXHdJAgusMwuz5RBPjqm21UsRdQ2nSee58hDqhoAFKdNFLe9+tDtkrMBZFETcg5MZBZdB8Fp
	IBqt+9TvvzJAhl2ZUG8rGexfN0+38bPqHJGwdei1ZN/wxllkPrWGh9YcKl0woY6VokOlugqt8Eq8r
	jojRcmqCtDMG0KB81WlZQbBZHb3RO2zw1CuoImdeEVxJvlrfON4VhBHU9ozxHxUS401N0avFWzKja
	4O/JhpIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rbmuW-0003SU-1N;
	Sun, 18 Feb 2024 19:33:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rbmuQ-0007eV-QR; Sun, 18 Feb 2024 19:33:06 +0000
Date: Sun, 18 Feb 2024 19:33:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] net: phy: add support for defining
 multiple PHY IDs in PHY driver
Message-ID: <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218190034.15447-2-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 18, 2024 at 08:00:27PM +0100, Christian Marangi wrote:
> Some PHY driver might implement the same OPs for different PHY ID and
> using a mask is not enough to match similar PHYs.
> 
> To reduce code duplication, add support for defining multiple PHY IDs in
> PHY driver struct.
> 
> Introduce a new variable in phy_driver struct, .ids, where a table array of
> mdio_device_id can be defined to reference multiple PHY IDs (with their
> own masks) supporting the same group of OPs and flags.
> 
> Introduce a new variable in phy_device, .dev_id, where the matching
> mdio_device_id is stored. PHYs supporting multiple PHYs for one PHY
> driver struct, should use this instead of matching for phy_id.
> 
> Single PHY ID implementation is still supported and dev_id is filled
> with the data from phy_driver in this case.

This looks like it's been reworked somewhat with my suggestion, or maybe
we just came across a similar structure for comparing the IDs?

> +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;

Why this cast? Try to write code that doesn't need casts.

> +	/* Fill the mdio_device_id for the PHY istance.
> +	 * If PHY driver provide an array of PHYs, search the right one,
> +	 * in the other case fill it with the phy_driver data.
> +	 */
> +	if (phy_driver_match(phydrv, phydev, &dev_id) && dev_id) {
> +		memcpy(phy_dev_id, dev_id, sizeof(*dev_id));
> +	} else {
> +		phy_dev_id->phy_id = phydrv->phy_id;
> +		phy_dev_id->phy_id_mask = phydrv->phy_id_mask;

So this is the _driver_ phy_id.

>  static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
>  {
> -	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
> +	return phy_id_compare(id, phydev->dev_id.phy_id,
> +			      phydev->dev_id.phy_id_mask);

And thus this code is now different (since it _was_ comparing the
phydev phy_id, and you've changed it to effectively the driver's
phy_id. While that should be the same for a matched driver, that
is still a change that probably is't intentional.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

