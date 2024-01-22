Return-Path: <linux-kernel+bounces-33770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE4E836E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B91C2402E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFD4E1CB;
	Mon, 22 Jan 2024 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NE4tdCy6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00843D567;
	Mon, 22 Jan 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943942; cv=none; b=ZYAwR0n71VuKn/kQ5CQUkuGZ1NNuiPhdbeDcpTQCPA2t2NLOoBvfUoTWqKIzlJ4IkxyMQ0XPOVkaYNNXL+YYPHqDjS60NGrMuC9HhJNAd+VcESF3A4fV9L8ThxD6PlD9alWiiGo6JfX9S06OrEiBrXISvHrYODlq25mhTZsv0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943942; c=relaxed/simple;
	bh=bHh6L70ByKmvX43JAigo5dIKWprOsC2iQ6a7BvSafJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5f8ldIY1ZWE2pMfslN94X8rccOJYAirXc7hnMUOaOUozO6Gvk1x3x1vZBJsmVgEmZUwgSYhnlOd8ra0iwjimqQyU+9czicBprAxsutUiXEZq47fi5wscf8v0RD5ZPd0OSec4aAzoahwkjHKjvd4ow5NZQ+BXte60CLUsFs8J8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NE4tdCy6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GIH1lk8fYjb+SC7zSuml30XODBqNf4rdLQG2tLbfsTY=; b=NE
	4tdCy6gDsUAP6RmHgoHuidlz73NSsdOnQqHSs8vsI0brvXLTz0P17svDS7NF/lw402SrNlLgSQVHo
	Tv9USmTEPwtyQK5joYWQQfroqdzelbv2du3HhvX59F0UXCdswNPc43MaiG3BCHFqcl4a0tdubUP6Z
	S3epleNfi7Rua3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRxwf-005kME-6n; Mon, 22 Jan 2024 18:18:49 +0100
Date: Mon, 22 Jan 2024 18:18:49 +0100
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
Message-ID: <e1fd863a-6725-4180-8ad3-faeb44c09238@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D5568546D6DA4313209EC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <2c6c0d72-5d4e-4ec4-beb6-d30852108a67@lunn.ch>
 <TYZPR01MB5556D035D9A13962844BB553C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR01MB5556D035D9A13962844BB553C9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Mon, Jan 22, 2024 at 11:37:29PM +0800, Ziyang Huang wrote:
> 在 2024/1/22 0:19, Andrew Lunn 写道:
> > On Sun, Jan 21, 2024 at 08:42:30PM +0800, Ziyang Huang wrote:
> > > Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> > 
> > You need to say something in the commit message. One obvious thing is
> > to justify not using the at803x driver, since
> 
> I want add more descriptions here. But I have no idea what to write. This is
> a mininal driver for a special phy.

So say how it is special. Indicate why it needs a minimal driver.

Does the hardware support cable test? WoL? Does it perform downshift
and you can read the actual speed from the AT803X_SPECIFIC_STATUS
registers?

What we want to avoid is that you start with a special driver, and
then start copying bits of the at803x driver to support the hardware
features. The at803x.c driver already supports a few internal PHYs:
"Qualcomm Atheros AR9331 built-in", "Qualcomm Atheros QCA9561 built-in
PHY", "Qualcomm Atheros 8337 internal PHY", "Qualcomm Atheros 8327-A
internal PHY", "Qualcomm Atheros 8327-B internal PHY", so please add
it to the driver and test what additional features work for it.

> Here is the thing, at first, I was tring to add these into at803x driver,
> then I found that the IPQ5018 internel phy is a special device. The
> initialization sequence is initing GCC clock and reset control, then
> registering clocks providers, which is very different from other devices.

That is a different story all together, and part of the problems we
had with Qualcomm patches. It might be you need to use ID values in
the compatible to get this driver loaded. The PHY driver can then
enable the clocks it needs and take itself out of reset. What is
important here is an accurate device tree representation. What clocks
and resets does this device consume.

> > > +	if (!priv)
> > > +		return dev_err_probe(dev, -ENOMEM,
> > > +				     "failed to allocate priv\n");
> > 
> > Please read the documentation of dev_err_probe() and this fix the
> > obvious problem with this.

> And I can find the same code in other driver, so I thought it is a standard.
> Or should I just return -ENOMEM? Please let me known.

-ENOMEM is one of the error codes you are unlikely to see. And if it
does happen, you are going to have cascading errors. So just return
-ENOMEM.

> > > +	snprintf(name, sizeof(name), "%s#rx", dev_name(dev));
> > > +	priv->clk_rx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
> > > +						  TX_RX_CLK_RATE);
> > > +	if (IS_ERR_OR_NULL(priv->clk_rx))
> > > +		return dev_err_probe(dev, PTR_ERR(priv->clk_rx),
> > > +				     "failed to register rx clock\n");
> > > +
> > > +	snprintf(name, sizeof(name), "%s#tx", dev_name(dev));
> > > +	priv->clk_tx = clk_hw_register_fixed_rate(dev, name, NULL, 0,
> > > +						  TX_RX_CLK_RATE);
> > > +	if (IS_ERR_OR_NULL(priv->clk_tx))
> > > +		return dev_err_probe(dev, PTR_ERR(priv->clk_tx),
> > > +				     "failed to register tx clock\n");
> > > +
> > > +	priv->clk_data = devm_kzalloc(dev,
> > > +				      struct_size(priv->clk_data, hws, 2),
> > > +				      GFP_KERNEL);
> > > +	if (!priv->clk_data)
> > > +		return dev_err_probe(dev, -ENOMEM,
> > > +				     "failed to allocate clk_data\n");
> > > +
> > > +	priv->clk_data->num = 2;
> > > +	priv->clk_data->hws[0] = priv->clk_rx;
> > > +	priv->clk_data->hws[1] = priv->clk_tx;
> > > +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> > > +				     priv->clk_data);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret,
> > > +				     "fail to register clock provider\n");
> > 
> > This needs an explanation. Why register two fixed clocks, which you
> > never use? Why not put these two clocks in DT?
> 
> Without documentions, here is my guess:

So you don't have the data sheet? Are you working from the Qualcomm
vendor tree?

> This is required by GCC controller. GCC driver require TX and RX clocks from
> GEPHY/UNIPHY. Then throught some sel or div cells, output clocks to
> GEPHY/UNIPHY and MAC. So I need to register them to make them can be refered
> in GCC controller. Will add a figure describing the clock tree in UNIPHY
> driver.

So in this case, the GCC is a clock consumer and the PHY is a clock
provider. Does GCC use DT properties clocks/clock-names and phandles
to reference these clocks it is consuming? If so, you can just use
fixed-clocks in DT.

> > > +static int ipq5018_soft_reset(struct phy_device *phydev)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
> > > +			 IPQ5018_PHY_FIFO_RESET, 0);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	msleep(50);
> > > +
> > > +	ret = phy_modify(phydev, IPQ5018_PHY_FIFO_CONTROL,
> > > +			 IPQ5018_PHY_FIFO_RESET, IPQ5018_PHY_FIFO_RESET);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> > 
> > This needs an explanation. It is also somewhat like
> > qca808x_link_change_notify(). Is it really sufficient to only do this
> > reset FIFO during a soft reset, or is it needed when ever the link
> > changes?
> 
> I'm not sure here, this is what u-boot does. But I guess, we can reset
> GCC_GEPHY_* serial reset_controls.

Please add a comment with your best guess what it is doing and why. Is
this vendor u-boot, or upstream u-boot? Maybe the git history will
give you more details.

> > You also appear to be missing device tree bindings.
> 
> Sorry for forgeting to add a WiP tag. Will add dt-bindings documentions in
> next patches.

The DT binding is just as important as the code. Often the DT binding
is so broken we don't even bother looking at the code...

   Andrew

