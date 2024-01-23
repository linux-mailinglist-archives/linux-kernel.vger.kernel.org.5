Return-Path: <linux-kernel+bounces-36185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D7839D30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26621C24F61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5275467D;
	Tue, 23 Jan 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GrD29UDW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD412B9CE;
	Tue, 23 Jan 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052317; cv=none; b=hKGUnv8TiOelttAR66eY3n0bWlZBZ6T+t2LM4le4AHdigNt7Uzgsj4u14OCSQ0zP+UKByq3BDnND6jyApzN66fhBMRrqSc4RIV+y/8tROQbmbqL+VenV807O2+oqRFnMRSkEcwb1QCktiKDalWkWTpyPCuT2yR2ZydvIinuJ2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052317; c=relaxed/simple;
	bh=ZYod9weUPl1yPCka4SUZzp2i3MZt1MpdN0tH/3PVFz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+UCzLNXkrUANOiOMv0DNaUOYISCzDfCqtYY9gUYzuZIJJ9RqdenQxby3VBpUQEKLEXfq/zt3gmYpnScxU9t9JzmrD9JWF+VCuu0qVqU3xSo+eQ0snjB5uEWln8Rped+OYiSGfpjyX1JRHm+w4c+va8Du1vRqQluH7HydSHa4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GrD29UDW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3L0RW4HC32Lx5N8gtFQZihg57fFjleHQGb6GEyv904U=; b=Gr
	D29UDWX/6aQD2sRb7aY/kxmfBVq8gBCbrbzylkaj3+maXmg+39XjQ//bc3h0pQe6NrE5FlbECD2h1
	OFSQjWYIxZyLizyhMAttwp5ZPoa/PTVRkI3vqrWY6BNsDqw8u8oTCBTOTjFU9IPgjFHKVVgf1HL/O
	LnjELfdoswWP1DI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSQ8h-005t6u-Hh; Wed, 24 Jan 2024 00:25:07 +0100
Date: Wed, 24 Jan 2024 00:25:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/8] phy: Introduce Qualcomm ethernet uniphy driver
Message-ID: <8488a274-148d-42da-9fd3-d56ef1db6061@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB55568ACB534944D7DEB00C7AC9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB555648886D03AB911224F6FAC9742@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR01MB555648886D03AB911224F6FAC9742@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Tue, Jan 23, 2024 at 11:58:26PM +0800, Ziyang Huang wrote:
> 在 2024/1/21 20:42, Ziyang Huang 写道:
> > +#define rmwl(addr, mask, val) \
> > +	writel(((readl(addr) & ~(mask)) | ((val) & (mask))), addr)
> > +
> > +static int cmn_init(struct platform_device *pdev)
> > +{
> > +	struct resource *res;
> > +	void __iomem *cmn_base;
> > +	void __iomem *tcsr_base;
> > +	u32 val;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cmn");
> > +	if (!res)
> > +		return 0;
> > +
> > +	cmn_base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR_OR_NULL(cmn_base))
> > +		return PTR_ERR(cmn_base);
> > +
> > +	/* For IPQ50xx, tcsr is necessary to enable cmn block */
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr");
> > +	if (res) {
> > +		tcsr_base = devm_ioremap_resource(&pdev->dev, res);
> > +		if (IS_ERR_OR_NULL(tcsr_base))
> > +			return PTR_ERR(tcsr_base);
> > +
> > +		rmwl((tcsr_base + TCSR_ETH_CMN), TCSR_ETH_CMN_ENABLE,
> > +		     TCSR_ETH_CMN_ENABLE);
> > +	}
> > +
> > +	rmwl((cmn_base + CMN_PLL_REFCLK_SRC),
> > +	     CMN_PLL_REFCLK_SRC_FROM_MASK,
> > +	     CMN_PLL_REFCLK_SRC_FROM_REG);
> > +	rmwl((cmn_base + CMN_PLL_REFCLK),
> > +	     (CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_FREQ_MASK
> > +	      | CMN_PLL_REFCLK_DIV_MASK),
> > +	     (CMN_PLL_REFCLK_FREQ_48M | CMN_PLL_REFCLK_DIV(2)));
> > +
> > +	rmwl((cmn_base + CMN_PLL_CTRL), CMN_PLL_CTRL_RST_N, 0);
> > +	msleep(1);
> > +	rmwl((cmn_base + CMN_PLL_CTRL), CMN_PLL_CTRL_RST_N,
> > +	     CMN_PLL_CTRL_RST_N);
> > +	msleep(1);
> > +
> > +	return read_poll_timeout(readl, val,
> > +				 (val & CMN_PLL_STATUS_LOCKED),
> > +				 100, 200000, false,
> > +				 (cmn_base + CMN_PLL_STATUS));
> > +}
> > +
> 
> Hi Andrew,
> 
> Sorry to bother you. But I can't make a decision here.
> 
> The CMN block (Seem like the Abbreviation of "component") controls the
> entire network block. It need to be configured before uniphy, mdio, gmac,
> etc.. In the past, Qualcomm put it in mdio driver. But UNIPHY need to been
> initializated before mdio because some PHYs/switchs use the outclk provided
> by UNIPHY as their main clocks.
> 
> So it seem like that it should be described in a separate node. But I
> couldn't find a suitable driver directory for it. Can you please give me
> some suggestions? Thanks.

Maybe drivers/soc/qcom.

Does it provide any resources to the uniphy, mdio, gmac, etc? Anything
which can be used to link all the bits together?

Looking at CMN_PLL_CTRL_RST_N, could it be considered as a reset
driver? Each of the other drivers have a phandle to it, and use the
reset API to take it out of reset when they probe? That should give
you some ordering guarantees.

    Andrew

