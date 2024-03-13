Return-Path: <linux-kernel+bounces-102409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA4C87B1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D43D1C289DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80A60DF8;
	Wed, 13 Mar 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hK2bScIl"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035360DD6;
	Wed, 13 Mar 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357206; cv=none; b=UvovGXnUL5BUy0GIQMU2Ra6vuo2lFlPbimIG2vli5Ri4ZGiskljBP1UakSQI22TKpvg+VRwK39KYApGW3LpTjN9QqcgYGkJVG4FANqu+BF+CCOfWfEc6tHU37gABdWdXiCzPDTSPFNtS1BoYhNrF1uJg75UEvzwmcziFBJkMWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357206; c=relaxed/simple;
	bh=Sbu7s5cRzT2+JBOIU5iBfi04JYiRAz5mbhHb5ik8btU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuasFgveFoG8/K+PTd9K9srkyZ8gw7w/aTtSz1UFrTO3oUW0uSSukIzQwyo5VqvQyB2Ht4pmBwHEi4KBDhaQIps4RHtHUsiedFe0EkqvzJMwRybfRMZP+GHJVgN98mQK65b60SoRVRK5lxkaD/qD2bTVVRwupvUMbFvHTOu+9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hK2bScIl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x+qZONr6YbvwJyGwyuaj5Ota3n6M4e55YF2EBPfxwwo=; b=hK2bScIlHaMdfudaOjJZfcJutS
	PU5PIbzx8+T5vEIkwmy+4gF0ed/CXuNcmJzTOrUbR35VSj6WaFUcuhQOovb5Y0aeBYfORRM0uY9g+
	y/2s/uLpzva+K3DDYq4pyZQG3lDU/i9zEHoNpiIxpAOR01bFjOEpAxOpV3r4I73i5CDJ4Y6Hwhlsx
	urFtU5lHm+OkvVvM5dBY1CnjjTpNGFe0urPg15HCbiJhzEP+oLgblkfqPyFvIF4EF3o+AldcLO/D7
	0CEJt4Ye/U5F3MxriJ/9hOAlZBZtPQhDfXHHbePR8rJJU9gKB2QZ5MaHafipvza0AuSZPScbEJ0Mv
	JaKxmZGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkU2C-000858-33;
	Wed, 13 Mar 2024 19:13:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkU28-0004j5-2D; Wed, 13 Mar 2024 19:13:00 +0000
Date: Wed, 13 Mar 2024 19:12:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: fix phy_read_poll_timeout argument type in
 genphy_loopback
Message-ID: <ZfH6u/njccckwT1K@shell.armlinux.org.uk>
References: <>
 <e2ef8067-bac7-45c1-96cf-1160625aef3d@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ef8067-bac7-45c1-96cf-1160625aef3d@ancud.ru>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 13, 2024 at 09:13:23PM +0300, Nikita Kiryushin wrote:
> read_poll_timeout inside phy_read_poll_timeout can set val negative
> in some cases (for example, __mdiobus_read inside phy_read can return
> -EOPNOTSUPP).
> 
> Supposedly, commit 4ec732951702 ("net: phylib: fix
> phy_read*_poll_timeout()")
> should fix problems with wrong-signed vals, but I do not see how
> as val is sent to phy_read as is and __val = phy_read (not val)
> is checked for sign.
> 
> Change val type for signed to allow better error handling as done in other
> phy_read_poll_timeout callers. This will not fix any error handling
> by itself, but allows, for example, to modify cond with appropriate
> sign check or check resulting val separately.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 014068dcb5b1 ("net: phy: genphy_loopback: add link speed
> configuration")

Fixes lines must not be wrapped.

> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>  drivers/net/phy/phy_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8297ef681bf5..6c6ec9475709 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2831,8 +2831,8 @@ EXPORT_SYMBOL(genphy_resume);
>  int genphy_loopback(struct phy_device *phydev, bool enable)
>  {
>  	if (enable) {
> -		u16 val, ctl = BMCR_LOOPBACK;
> -		int ret;
> +		u16 ctl = BMCR_LOOPBACK;
> +		int ret, val;
>   		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
>  -- 2.34.1

The patch seems broken - blank lines appear to be missing.

I think the change itself is correct however - "val" passed into
phy_read_poll_timeout() must be signed.

Lastly, as you need to indicate which tree your patch is targetting,
which is done via the subject line prefix. As this is in mainline, then
[PATCH net] would be the correct prefix.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

