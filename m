Return-Path: <linux-kernel+bounces-81813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E700867A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BF1F240DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7112B179;
	Mon, 26 Feb 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2PNEOOjn"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826C7E794;
	Mon, 26 Feb 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961668; cv=none; b=KebEiYaptD1ZT9p+iEhgBHW8cXw0DK4/9HGww4BH/U9ui6MHWnjobvLEyzTssYtV2nHW4JuxbeMLcBfHV546J+ypfrrvdPxHe80Tj+SFi7WfbIUxSqXMh6Ja6N11jAjL19llNBjnIFmQIRvNEspMfP2jhQw6faP0XMxwtlL4RSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961668; c=relaxed/simple;
	bh=kuB0H4FU8bT6x452qiWGPFUounbrJC67yGBA/EwPPlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jclwg94lTS/nm/c2Qhg7MijWDQanJrj1yr128PL1yROmjDgFB4bkwK8Ak4raC/GYOA02Ao3eLcZdrhu9Z7Eo9EU6Pb+OT89UGidq++lOHpIZqggTYj9uIZ/Wn6N18v7AFdBL30im93c/VG7GxzyIyM/zD9FHVhNuJSEqTi6kMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2PNEOOjn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Fr1Kk+BTfvCgehT0HKmG9zqX5uvmp1iVYnEnXQZLIm0=; b=2P
	NEOOjnRUsWhPnM+8MVmxsJVwF19KuGfFLSVatDNgAJFpGgAQ6uIdkWd8t9vaVK7JXSnsJJ/e0PnIX
	0b6do8qtJ7zYkI5uelSWBco6g5F3ZKq2HMfFOo79V25DwLUJD+QsnvJUu9FX7dHc9/IR60Zytl8nD
	hvVYPqK4Br2HqWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1reczy-008jmA-Bn; Mon, 26 Feb 2024 16:34:34 +0100
Date: Mon, 26 Feb 2024 16:34:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 2/3] net: phy: dp83826: Add support for phy-mode
 configuration
Message-ID: <aee610ab-2815-42f0-a4e4-5f695238beae@lunn.ch>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
 <20240222103117.526955-3-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222103117.526955-3-jeremie.dautheribes@bootlin.com>

On Thu, Feb 22, 2024 at 11:31:16AM +0100, Jérémie Dautheribes wrote:
> The TI DP83826 PHY can operate in either MII mode or RMII mode.
> By default, it is configured by straps.
> It can also be configured by writing to the bit 5 of register 0x17 - RMII
> and Status Register (RCSR).
> 
> When phydev->interface is rmii, rmii mode must be enabled, otherwise
> mii mode must be set.
> This prevents misconfiguration of hw straps.
> 
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>  drivers/net/phy/dp83822.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index 30f2616ab1c2..2d8275e59dcc 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -100,6 +100,7 @@
>  #define DP83822_WOL_CLR_INDICATION BIT(11)
>  
>  /* RCSR bits */
> +#define DP83822_RMII_MODE_EN	BIT(5)
>  #define DP83822_RGMII_MODE_EN	BIT(9)
>  #define DP83822_RX_CLK_SHIFT	BIT(12)
>  #define DP83822_TX_CLK_SHIFT	BIT(11)
> @@ -500,6 +501,16 @@ static int dp83826_config_init(struct phy_device *phydev)
>  	u16 val, mask;
>  	int ret;
>  
> +	if (phydev->interface == PHY_INTERFACE_MODE_RMII)
> +		ret = phy_set_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
> +				       DP83822_RMII_MODE_EN);
> +	else
> +		ret = phy_clear_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
> +					 DP83822_RMII_MODE_EN);

I would probably add a test for MII and return -EINVAL if asked to do
something else altogether.

	  Andrew

