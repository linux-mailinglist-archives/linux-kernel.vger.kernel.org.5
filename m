Return-Path: <linux-kernel+bounces-67256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D48568B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6EB290F63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90105134751;
	Thu, 15 Feb 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kF0taM9q"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3851339AC;
	Thu, 15 Feb 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012959; cv=none; b=LMufxWy4VRkUsNp3Zp0tRnN8jqXVBC/W4AaeVaHj7cF4nT7jlS/lm06TJponMS3aMNTJAIFl4Mcc5kPn+ZVQ91Pnx3CWR4f0i3b8VqVOYwI8hyIZGZYZFbmIZF2/l+Wp67rpPwVz9gRZNvi7FijzZLNQlQqceCnOm2eFdcvosvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012959; c=relaxed/simple;
	bh=vCX30uSOIcfJD/9firrildGpUnUbZaUq1SXGVFbONvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+iHgRwzPK2LIKFAWn4p0W8qg7JDVFmhiT1p+9wDkOWwLMVhMDbr0DZ842uXARya+KkdMn4j/UryqulI87HS8Pln2HgZw/izyF4zN537hH2AAybf9sYVHhKETam6hmMen8G3TE6wuyecyMKvJ4EHxnvXQLuflAJl17IXBi2518g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kF0taM9q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YQNWh7GF/RgZwIhyO2ZMjQuqWh+GiSsA9oHVl02ggEI=; b=kF0taM9qJfyXAROo0+zXB7uFzR
	aoGafoZ/LScV/hDufIGDnoF4KI4wt9lrgKS/EXyBbTBLRfPq7gq6+ZlBwhY2ZyAfLYzuQ1kEaBsSS
	Rwg3kblOtlpazxzqEMhvXUYAfzpkVnUjofCw3nFg0HC/Px1LcHzHR/RlnZmciaXvgbP/6dN1AVZlx
	0QVFypKSnv6J+hcMiBMWEkHSvqmdnlz+htm02NNe1+/Lds/tjpfvxuKVS31nY12q6Kneh6UHyhfij
	X+g/g/B3uNYv8H+UzMXEcBjdiLv3TXoyhjNlCbE7xsBrajeFI90DjQ2PMEAQnIKam8jPIRx9F0eyL
	qhjbkZhA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39184)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1raeBx-0004O8-0I;
	Thu, 15 Feb 2024 16:02:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1raeBu-0004og-5y; Thu, 15 Feb 2024 16:02:26 +0000
Date: Thu, 15 Feb 2024 16:02:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: sfp: remove redundant NULL check
Message-ID: <Zc41kuP2iwK3AlWv@shell.armlinux.org.uk>
References: <20240211150824.3947-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211150824.3947-1-d.dulov@aladdin.ru>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 11, 2024 at 07:08:24AM -0800, Daniil Dulov wrote:
> bus->upstream_ops in sfp_register_bus() cannot be NULL. So remove
> redundant NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

It probably would've been better to include in here details of the two
paths that lead to this point, and indicate why it's safe to remove the
NULL check.

The first path is via sfp_register_socket(), which checks that
bus->upstream_ops is not NULL prior to calling sfp_register_bus().
Therefore, "ops" can not be NULL when sfp_register_bus() is called
via this path.

The second path is via sfp_bus_add_upstream(), and this path assumes
that the "ops" passed into this function will not be NULL. Nothing in
this code makes that guarantee, and it's up to the design(er) to
determine whether NULL is permitted or not. It's not something that
an automated checker ought to be suggesting.

In this particular instance, I, as the interface designer, do indeed
intend that "ops" will not be NULL here, so the patch can remove the
check is acceptable in this instance.

However, I'll go back to my original point: this is *not* something
that automated tools should be identifying, and it is *not* something
that should be used to throw patches randomly out, especially where
the commit message doesn't include human analysis details.


> 
> Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/net/phy/sfp-bus.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index 850915a37f4c..829cb1dccc27 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -478,14 +478,12 @@ static int sfp_register_bus(struct sfp_bus *bus)
>  	const struct sfp_upstream_ops *ops = bus->upstream_ops;
>  	int ret;
>  
> -	if (ops) {
> -		if (ops->link_down)
> -			ops->link_down(bus->upstream);
> -		if (ops->connect_phy && bus->phydev) {
> -			ret = ops->connect_phy(bus->upstream, bus->phydev);
> -			if (ret)
> -				return ret;
> -		}
> +	if (ops->link_down)
> +		ops->link_down(bus->upstream);
> +	if (ops->connect_phy && bus->phydev) {
> +		ret = ops->connect_phy(bus->upstream, bus->phydev);
> +		if (ret)
> +			return ret;
>  	}
>  	bus->registered = true;
>  	bus->socket_ops->attach(bus->sfp);
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

