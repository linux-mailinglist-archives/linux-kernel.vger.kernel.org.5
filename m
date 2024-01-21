Return-Path: <linux-kernel+bounces-32110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B807E83569D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFCC1C21135
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2F37719;
	Sun, 21 Jan 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s8bZff+l"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCA3770B;
	Sun, 21 Jan 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705853964; cv=none; b=TJ1MoarUDttVmB/l8Qir8a8NYnSIFpgOFEzvoGCCwZYZwBP1mH3Ta1dCrMTTcfIxhBqZcHZ8MFKcu5ConNnQK5oCNgHPx6gSwTk1CFRcnnpneOOwdUFFqER6/uGhJvr52r+YLY9+XRmaiVgV3aleUgOT7EfIM3HKbIwtVChRtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705853964; c=relaxed/simple;
	bh=9RKNz8nLW9GGTiNspXerKEJTQVP110rltOMLVQCPHZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmHWhFo7HBEVDrAkNsEtlYxz7DT2EinZOuICmAn+XhcojI33ceCLZ3F+CMXXFehWMgYOMUDpG6XnLxF0xOJ5npROPhIyOBAS6H71JqW3Uwn70CWRCZ81I5WAHukZ3Ktt+RQ2yAQGZIXtWZtAOtIEv44GrHq57ZxiER55RWhXg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s8bZff+l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qn4t+vas77bkDv8g3HdYzBVs/Lcv/nz47gDWrhkMoW0=; b=s8bZff+lnIy0w1E7iRjMwp/D5N
	CviH96SZl4ruDUwl3yMGZnF+huZmenyU48MCOt6rZmO2g1ZK1RZTN1cmW9QI+0iS7pbwn1FX/1lnd
	ywqOGEuwfb4Cj4Ue1dmv6ay3qiSExwDJq71IHBlCankDuAWJXiykbIHYoN4XtMtnOT6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRaXS-005f13-Ik; Sun, 21 Jan 2024 17:19:14 +0100
Date: Sun, 21 Jan 2024 17:19:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/8] net: phy: Introduce Qualcomm IPQ5018 internal PHY
 driver
Message-ID: <2c6c0d72-5d4e-4ec4-beb6-d30852108a67@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D5568546D6DA4313209EC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB5556D5568546D6DA4313209EC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Sun, Jan 21, 2024 at 08:42:30PM +0800, Ziyang Huang wrote:
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>

You need to say something in the commit message. One obvious thing is
to justify not using the at803x driver, since 

> +#define IPQ5018_PHY_ID			0x004dd0c0

is in the Atheros OUI range.

> +static int ipq5018_probe(struct phy_device *phydev)
> +{
> +	struct ipq5018_phy *priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	char name[64];
> +	int ret;

I guess you are new to mainline network. Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Section 1.6.4.

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to allocate priv\n");

Please read the documentation of dev_err_probe() and this fix the
obvious problem with this.

> +	snprintf(name, sizeof(name), "%s#rx", dev_name(dev));
> +	priv->clk_rx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
> +						  TX_RX_CLK_RATE);
> +	if (IS_ERR_OR_NULL(priv->clk_rx))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk_rx),
> +				     "failed to register rx clock\n");
> +
> +	snprintf(name, sizeof(name), "%s#tx", dev_name(dev));
> +	priv->clk_tx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
> +						  TX_RX_CLK_RATE);
> +	if (IS_ERR_OR_NULL(priv->clk_tx))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk_tx),
> +				     "failed to register tx clock\n");
> +
> +	priv->clk_data = devm_kzalloc(dev,
> +				      struct_size(priv->clk_data, hws, 2),
> +				      GFP_KERNEL);
> +	if (!priv->clk_data)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to allocate clk_data\n");
> +
> +	priv->clk_data->num = 2;
> +	priv->clk_data->hws[0] = priv->clk_rx;
> +	priv->clk_data->hws[1] = priv->clk_tx;
> +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +				     priv->clk_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "fail to register clock provider\n");

This needs an explanation. Why register two fixed clocks, which you
never use? Why not put these two clocks in DT?

> +
> +	return 0;
> +}
> +
> +static int ipq5018_soft_reset(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
> +			 IPQ5018_PHY_FIFO_RESET, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(50);
> +
> +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
> +			 IPQ5018_PHY_FIFO_RESET, IPQ5018_PHY_FIFO_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

This needs an explanation. It is also somewhat like
qca808x_link_change_notify(). Is it really sufficient to only do this
reset FIFO during a soft reset, or is it needed when ever the link
changes?

You also appear to be missing device tree bindings.

    Andrew

---
pw-bot: cr


