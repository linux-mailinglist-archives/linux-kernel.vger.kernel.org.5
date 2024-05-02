Return-Path: <linux-kernel+bounces-166600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989558B9CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F67289FD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7BC153BC6;
	Thu,  2 May 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1uyuAgb+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DF153800;
	Thu,  2 May 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661519; cv=none; b=jpYp8hsEXWE106RXpXDuoE/ucDRnUROg7Sx210bkPUdZdzePQrnEwsN8pcV1krRZBjwSJ9pDk8L3RvBXCB05jGPSM9WTVK2MErwpI05maaUPvRFHm6YZ742OioEAGw13OXRlDQjO/HtXq6MJ5zjuBH7342dJBykdSRzp39ISGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661519; c=relaxed/simple;
	bh=ST+TZwgCd+nDZ5M4t+lR71k82ZcVIF/RLDpS5hQosys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM50GH5O4tWO9fiEb2Hl3dt5996+6F6Q/6pIFZhJ3ia8OnB+lUwczmKcSx8ORo4Q+0osZxTIKsuihjHGWUJqI1TRpdyf5b0GiJDrZM8hEcmvA+H8UhDDeUve267xDEiLUzjrj63tNX45hvEw2XaRCgL7DlwTbGlg9XUcKP9/dJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1uyuAgb+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wqpw/ZGaL/K9oEQyWGG2tvRSaK0AjAGtY128e8n64RA=; b=1uyuAgb+/pJTNrSUOf1oUcENk7
	ITwsmNWDdS3RtL8SIsOZYzw+yZLbG7Oy864GiNT/xw3Od71t43ADVsmYwBq/PlYJttybj1eeY8oqj
	0urYbiEHdWsb96/i5cu9N38WdiX+80nYJ2MO7edPMvqMBzowpcb7VW9JSNDJD3qnsnmU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2Xmg-00EVgP-Fq; Thu, 02 May 2024 16:51:42 +0200
Date: Thu, 2 May 2024 16:51:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, lxu@maxlinear.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>

On Tue, Apr 30, 2024 at 10:36:35AM +0530, Raju Lakkaraju wrote:
> Introduce a new member named 'wolopts' to the 'phy_device' structure to
> store the user-specified Wake-on-LAN (WOL) settings. Update this member
> within the phy driver's 'set_wol()' function whenever the WOL configuration
> is modified by the user.
> 
> Currently, when the system resumes from sleep, the 'phy_init_hw()' function
> resets the PHY's configuration and interrupts, which leads to problems upon
> subsequent WOL attempts. By retaining the desired WOL settings in 'wolopts',
> we can ensure that the PHY's WOL configuration is correctly reapplied
> through 'phy_ethtool_set_wol()' before a system suspend, thereby resolving
> the issue

Sorry it took a white to review this.

> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/phy/mxl-gpy.c    | 5 +++++
>  drivers/net/phy/phy_device.c | 5 +++++
>  include/linux/phy.h          | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index b2d36a3a96f1..6edb29a1d77e 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
>  	struct net_device *attach_dev = phydev->attached_dev;
>  	int ret;
>  
> +	phydev->wolopts = 0;

Is this specific to mlx-gpy?

You should be trying to solve the problem for all PHYs which support
WoL. So i expect the core to be doing most of the work. In fact, i
don't think there is any need for driver specific code.

phy_ethtool_set_wol() can set phydev->wolopts after calling
phydev->drv->set_wol(). If it returns an error, including -ENOTSUPP,
set phydev->wolopts to 0, otherwise set it to wolopts.

> @@ -2038,6 +2038,11 @@ int phy_suspend(struct phy_device *phydev)
>  	if (phydev->suspended)
>  		return 0;
>  
> +	if (phydev->wolopts) {
> +		wol.wolopts = phydev->wolopts;
> +		phy_ethtool_set_wol(phydev, &wol);
> +	}

Why on suspend? I would expect it to be on resume, after the PHY has
been reset.

I also think you need to save sopass[] in phydev, since some PHYs
support WAKE_MAGICSECURE. Just because mlx-gpy does not need the
password does not mean we should ignore it in general. I also think it
is safe to store in memory. Its is not a highly confidential
password. I would not be too surprised if some PHYs have the registers
read/write rather than write only.

	Andrew

