Return-Path: <linux-kernel+bounces-156886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658A8B09E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172331F25863
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EB158DC2;
	Wed, 24 Apr 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KYPxvwZR"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A133989;
	Wed, 24 Apr 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962586; cv=none; b=GiDP7Zt/1JRRxO4HvCxNDukcwErPgb4XZ0MSPJlpFjvk9VR8zPWm3mJB4kjZ6U5g2YjcvUH3LVHl5NGdBr5+L7m4GqhRuU4e+MquwGv3UFf7CcdTEdQW0CbKRRPXBnZSaAQeb+rVqtnV1lRHdu/K7VsC2L0h/sJaIg6uB/ob0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962586; c=relaxed/simple;
	bh=EsHCFFqeXC3UpFgM4lcKScBITPJEM2RivFdqL6BqyIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjgTMNAAahZ37F7BTYEQzVOS1n6OAOkH2EwuF+mfed+G6B1bMxsKwUeYJrzBi9nMXJpUAqA0RygCAjeDSb70oQ0P/t/6un5uDI14H9+Oxy2EGSvOvvJdo5/ZAyx4FX0TFh3f9c/u5F8me/gOi04EtMZdfloCtImfHwyOz1Fvsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KYPxvwZR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Fwu/iXQ1akt4L+GrdADymSlsnXBLzNXy+RDvydRMpg=; b=KYPxvwZRXoY6w+ZizdV+PLfpFj
	3zSm+ScOya+jLE+RiFFiu8NOqc75y/OV+kUaqMRC5uJtVgf4D+ER/q3tTCfccGKpwg59Ux2lk7q0F
	ZaC48jQsFbYdemORUieKZQAdGv1fegF9ymivG08W0sHq+kkrQwquWTDKcBOJtHz7ViKY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzbxd-00DoUa-Iv; Wed, 24 Apr 2024 14:42:53 +0200
Date: Wed, 24 Apr 2024 14:42:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next] net: phy: marvell: add support for MV88E6020
 internal PHYs
Message-ID: <19c4b8da-203e-4a81-9531-9ba4a4f750fd@lunn.ch>
References: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>

On Wed, Apr 24, 2024 at 02:10:22PM +0200, Matthias Schiffer wrote:
> The embedded PHYs of the MV88E6020 (88E6250 family) switch are very
> basic - they do not even have an Extended Address / Page register.
> 
> This adds support for the PHYs to the driver to set up PHY interrupts
> and retrieve error stats. The ethtool stat functions are slightly
> refactored to allow dealing with different marvell_hw_stat definitions.
> 
> The same code should also work with other 88E6250 family switches
> (6250/6220/6071/6070), but it is unclear whether these use the same PHY
> ID - the spec only lists the prefix 0x01410c00 and describes the lower
> 10 bits as reserved, but that seems too unspecific to be useful, as it
> would cover several existing PHY IDs already supported by the driver.

This sounds like:

https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/mv88e6xxx/chip.c#L3642

So the DSA driver will fill in the lower bits, and it should work for
all devices in the family.

> @@ -4072,6 +4134,7 @@ static struct mdio_device_id __maybe_unused marvell_tbl[] = {
>  	{ MARVELL_PHY_ID_88E1540, MARVELL_PHY_ID_MASK },
>  	{ MARVELL_PHY_ID_88E1545, MARVELL_PHY_ID_MASK },
>  	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
> +	{ MARVELL_PHY_ID_88E6020, MARVELL_PHY_ID_MASK },
>  	{ MARVELL_PHY_ID_88E6341_FAMILY, MARVELL_PHY_ID_MASK },

Please follow the naming convention. MARVELL_PHY_ID_88E6250_FAMILY.

       Andrew

