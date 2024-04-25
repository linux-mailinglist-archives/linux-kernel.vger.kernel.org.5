Return-Path: <linux-kernel+bounces-158232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FC8B1D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8A0282843
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472B84E0B;
	Thu, 25 Apr 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BgY5Mwnj"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A183CCD;
	Thu, 25 Apr 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035757; cv=none; b=je3X372SLTRmRNWYFdupzxPMYqrjdVp5f0e+vMTjrHQWAgB4+TQRSdFN1OtwqxjYvH7e2dN7ble+HgyF8uHsDVh0zbWuA9vSjebL3TJU/etzbOI6y7hNZNa3tcS/4HvZHN+0/NmACc0JZMOS+91CHMfJPfsAT99VOZEh8sz84zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035757; c=relaxed/simple;
	bh=c3h0CFxr96J3TcWHTpu0zjTw6cRVNTcbISj/ySXaJRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQseNIrKyShS2FDaCwelmCWv5qv4nT7TgU2V0rUwDpT5WcwIvOSc/yKsBoARMN2MCD9DjxblN3ZkutSRkv8y1u88FlFBeVI4keg/JyBQRjfIju+ScfMl/fkXJwEwEVh4RqirZRa/J9C2PyZ4JAsllpDVYcxuXf5WLMPMSjSDgAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BgY5Mwnj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tvACK5git9WpWSrstT0kGFb7bKtSP7Oj9178I7kw6ME=; b=BgY5Mwnj2I06U3tZLcTSnD0qEp
	HSfXf05N1JTTR7Mkd/4ep9P+YimNnkYcd2TQ2IcjY02wxn056O+0FN2JdtBR6EAfTwSQs4bWXWODB
	fxmXsbYkxGt9qQlH/fdrWaIdvz1KrIMmxcjWTV5xQ85D+RT1d4RAOK14rMUEejSGX7IuNcSNnckaH
	KKDL3KobcVNDFZChxcq8sCZ03wyYKROEG9LgXx83Mkt/xz11jVsDpnn8JOh2GK+7K6Ubatrd9+ThQ
	D1FarkpP2G0qZVdRGAKLn6Oxe62dZE1AeVQOSxDrD5+rTzDycy5qo0IAtbbejq3u559KNqx6D1U/g
	wy/F+Fuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rzuzU-00077v-2p;
	Thu, 25 Apr 2024 10:02:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rzuzO-0005Td-Gu; Thu, 25 Apr 2024 10:01:58 +0100
Date: Thu, 25 Apr 2024 10:01:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <ZiocBmBWiNnbeyGq@shell.armlinux.org.uk>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 25, 2024 at 10:33:25AM +0800, Sky Huang wrote:
> +static int mt7988_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	int ret, i;
> +	const struct firmware *fw;
> +	struct device *dev = &phydev->mdio.dev;
> +	struct device_node *np;
> +	void __iomem *pmb_addr;
> +	void __iomem *md32_en_cfg_base;
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> +	u16 reg;
> +	struct pinctrl *pinctrl;
> +
> +	if (!priv->fw_loaded) {
> +		np = of_find_compatible_node(NULL, NULL, "mediatek,2p5gphy-fw");
> +		if (!np)
> +			return -ENOENT;
> +		pmb_addr = of_iomap(np, 0);
> +		if (!pmb_addr)
> +			return -ENOMEM;
> +		md32_en_cfg_base = of_iomap(np, 1);
> +		if (!md32_en_cfg_base)
> +			return -ENOMEM;

Wouldn't it be better to do this in the probe function rather than here?

> +
> +		ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
> +		if (ret) {
> +			dev_err(dev, "failed to load firmware: %s, ret: %d\n",
> +				MT7988_2P5GE_PMB, ret);
> +			return ret;
> +		}

This will block for userspace while holding phydev->lock and the RTNL.
That blocks much of the networking APIs, which is not a good idea. If
you have a number of these PHYs, then the RTNL will serialise the
loading of firmware.

> +
> +		reg = readw(md32_en_cfg_base);
> +		if (reg & MD32_EN) {
> +			phy_set_bits(phydev, 0, BIT(15));

This is probably the BMCR, so if it is, please use the established
definitions.

> +			usleep_range(10000, 11000);
> +		}
> +		phy_set_bits(phydev, 0, BIT(11));

This also looks like it's probably the BMCR.

> +
> +		/* Write magic number to safely stall MCU */
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
> +
> +		for (i = 0; i < fw->size - 1; i += 4)
> +			writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
> +		release_firmware(fw);
> +
> +		writew(reg & ~MD32_EN, md32_en_cfg_base);
> +		writew(reg | MD32_EN, md32_en_cfg_base);
> +		phy_set_bits(phydev, 0, BIT(15));

And also probably the BMCR.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

