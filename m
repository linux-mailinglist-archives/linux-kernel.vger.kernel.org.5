Return-Path: <linux-kernel+bounces-83087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB38D868E43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB641F23F84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F33139567;
	Tue, 27 Feb 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r+VjwLIs"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DC2A8C1;
	Tue, 27 Feb 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031696; cv=none; b=G9X9dsUfRi0YV8KMrqcAxcCufNsap/DGEVRh7EfH8rBoa1C7FUl+vPyJ608px502+xwUx2hvfMLj1htNSRauThfm2cTWHzdkXTV9V80r18AyIDkyP807ccdpq7KNLce4nBBc9s6f354m8Y/QoFNZZcZZc+fyZ2ORn+719aOYaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031696; c=relaxed/simple;
	bh=ZTyUOOdI9D1cGi850Kq0719pmJ7x8j7pILQUq+KdEs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxRhjiqQ18YR/TRu5acbQ5ar3Ygig9Eg6so+JveEnT3DeVlcuiuKlFWq3ZwXBmbm3tZXZLZKy+pR2BJwCKTEmkgH9Mm1axOFeJ6PqG5IlLcw+UVDqFoUgHZelZDySsG6dN0rCZD3qS/iR5V3gYXAghkXYeRaEc7MIxEq4auSgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r+VjwLIs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+DaaHFV+R3CLw59EEXA62uKFGD7Wf52WpiZ2P8WI0uY=; b=r+VjwLIsY/7RMcdO/5MqVjxj66
	bqMv285lAJ0GkQpN0DxrfTNOm94RquYl6/8BdSas6kacDXR7lmNPmhiAWqgZwjxwXSsDRFtdpkgTc
	ZuwHQE/EWwEX2o8KdRqD45D9x7oSVy5lelN9gBnvAJCZ2zYrKSodBZOLNrtqmfln4FFjrfPt2obnU
	YtWyepUT1BT5DaG4kVoIbBnl6TaWswn5lzKjlzZAwkyr+8d7ImMpbXY0KJ+/f0N/aQFqGmMtld9xT
	bUJ/0Li63j25PPkeLuvC6pFIhCWjUtYP/20Rx/p/MH33kd6SC/HsmodCvEzLtcIFSjeifVPzvhCLp
	eO9qw+DQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48690)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1revD4-0007th-1A;
	Tue, 27 Feb 2024 11:01:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1revD2-0007LK-9g; Tue, 27 Feb 2024 11:01:16 +0000
Date: Tue, 27 Feb 2024 11:01:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode
 enabling/disabling from device tree
Message-ID: <Zd3A/OzmfLRWDtjg@shell.armlinux.org.uk>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-7-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227093945.21525-7-bastien.curutchet@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 10:39:45AM +0100, Bastien Curutchet wrote:
> @@ -1141,6 +1147,17 @@ static int dp83640_config_init(struct phy_device *phydev)
>  	val = phy_read(phydev, PCFCR) & ~PCF_EN;
>  	phy_write(phydev, PCFCR, val);
>  
> +	if (dp83640->fiber != FIBER_MODE_DEFAULT) {
> +		val = phy_read(phydev, PCSR) & ~FX_EN;
> +		if (dp83640->fiber == FIBER_MODE_ENABLE)
> +			val |= FX_EN;
> +		phy_write(phydev, PCSR, val);

		val = 0;
		if (dp83640->fiber == FIBER_MODE_ENABLE)
			val = FX_EN;

		phy_modify(phydev, PCSR, FX_EN, val);

> +
> +		/* Write SOFT_RESET bit to ensure configuration */
> +		val = phy_read(phydev, PHYCR2) | SOFT_RESET;
> +		phy_write(phydev, PHYCR2, val);

		phy_set_bits(phydev, PHYCR2, SOFT_RESET);

..
> +#else
> +static int dp83640_of_init(struct phy_device *phydev)
> +{
> +	dp83640->fiber = FIBER_MODE_DEFAULT;

This hasn't been build tested - dp83640 won't exist here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

