Return-Path: <linux-kernel+bounces-156028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E68AFCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E14B22BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D144595D;
	Tue, 23 Apr 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EDfgkPum"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F66367;
	Tue, 23 Apr 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916107; cv=none; b=oa7VnEkxs4XlBC3Pu/PVZkvMh2KiZ/dTzQKRz3UapbsFzSnsv3BZhYdLYFHBy0N/Tvbsbq7pm3gPx3rrj54Ooem33mJGDpp7L2dYjh0OWIVh0J/PNLhASLekH7wfCFZU+JYbtP+F2bdnZzxw4UA0Wi/Gh2I1VzRLTMD+R9el5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916107; c=relaxed/simple;
	bh=YhOp2xWkA1R/3ZZdAEZTl894ZzRfvtitlTs3OwDHWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khX00Ofh9bIgUIRobFzHDFMWQ1fuBuwJr/XmJPirx89LIku3c5RfkybviF42M3fqqFzCkbhMydzsURUtvYjPqWJ0Cw6nYTG+Ww2Mqftddvm5DjvOK6B7Q4p2QsKS1xhz0OGxaI5s7T99rrmjeze+oMVpbaf7qH17q5bnRTC05Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EDfgkPum; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zIv+aE6d9Tsxuf0ARD6E2PjXoytyfohuGEy0R9e1RqE=; b=ED
	fgkPumRzS/0pzuFMI0QnPfL1n3gUdYyyOOW1G9f98lC9YUv64Bn0j77UK2RiKvei3TP3Buv9Q+RgJ
	16IaNSEIJdGDkOd7TPXhOTDu8RzvxM+5whGpGOn2gsxzKWRl1+F6I5eVOUaq52Up/T9SfrV8QjqTc
	exH1UhbdLy2Rrlc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzPrx-00DlDm-K0; Wed, 24 Apr 2024 01:48:13 +0200
Date: Wed, 24 Apr 2024 01:48:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <aae5f0be-7e1f-443e-831a-ab0b4df0b839@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-7-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418125648.372526-7-Parthiban.Veerasooran@microchip.com>

> +/* PHY Clause 22 and 29 registers base address and mask */
> +#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
> +#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x3F

Did you every find out why C29 is reference here? From the standard:

29. System considerations for multisegment 100BASE-T networks

NOTE—This clause relates to clauses that are not recommended for new
installations. This clause is not recommended for new
installations. Since March 2012, maintenance changes are no longer
being considered for this clause.

I don't think you should be referencing it in the code.

> +static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
> +{
> +	struct oa_tc6 *tc6 = bus->priv;
> +	u32 regval;
> +	bool ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
> +				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
> +				   &regval);
> +	if (ret)
> +		return -ENODEV;

In general, you should not replace an error code from a lower level
function with a different error code. If there is a good reason to do
this, please add a comment.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 534ca7d1b061..769a88254285 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c
> @@ -268,6 +268,34 @@ static int lan86xx_read_status(struct phy_device *phydev)
>  	return 0;
>  }

Please put this into a new patch.

>  
> +/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
> + * C45 registers space. If the PHY is discovered via C22 bus protocol it assumes
> + * it uses C22 protocol and always uses C22 registers indirect access to access
> + * C45 registers. This is because, we don't have a clean separation between
> + * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C45
> + * registers direct access can't be used which can save multiple SPI bus access.
> + * To support this feature, set .read_mmd/.write_mmd in the PHY driver to call
> + * .read_c45/.write_c45 in the OPEN Alliance framework
> + * drivers/net/ethernet/oa_tc6.c
> + */
> +static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
> +				u16 regnum)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return bus->read_c45(bus, addr, devnum, regnum);

It is better to use __mdiobus_c45_read(). That will check you have the
lock held, won't jump through a null pointer if the bus does not
implement C45, does tracing, and increments the MDIO statistics.

	  Andrew

