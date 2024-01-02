Return-Path: <linux-kernel+bounces-14654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3838822059
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6201C22647
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5979154BB;
	Tue,  2 Jan 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JnALshJ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC651549F;
	Tue,  2 Jan 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v7p+4wOjxD8iHSF+Ol2HJc13gpqMfMW5a3rOFwDOZ54=; b=JnALshJ1N5mzIsZfJSk3TrJlRy
	GfefA8sf1ABLyd8U0jL5FmbvBIrWqj3dFwDKYnM/S10+/4yYbL1WIU2crYGvyxJA9BA47EQWUYlY1
	vG8x2vf58SKHy7CQuj8cGRupddca6cjHklaoDAdgG6enWtnVIb4PvqTUDPOdX/a1klbX/+BFjHG2X
	/CdzaIkn0TwUcjqS1Y9o7JsKJZbenrMOybNo27ebRJc9k7KGQmxBDds+PZ+mBYQgil/5xskZOlXhY
	ixT4eZiQCDtYck1lwzpAV55O2iN4HC7T7m/ORjg39DbxSl7iftGbuz7B5YQz9hAG5zMBg7LCVn7p6
	GU0zZQ8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46248)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKiVR-0006l9-1E;
	Tue, 02 Jan 2024 17:24:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKiVR-0005V0-N4; Tue, 02 Jan 2024 17:24:45 +0000
Date: Tue, 2 Jan 2024 17:24:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, robert.marko@sartura.hr,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com
Subject: Re: [PATCH v4 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO
 bus register
Message-ID: <ZZRG3eZJM5QouR9+@shell.armlinux.org.uk>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-2-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225084424.30986-2-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 25, 2023 at 04:44:20PM +0800, Luo Jie wrote:
> +/* Maximum SOC PCS(uniphy) number on IPQ platform */
> +#define ETH_LDO_RDY_CNT				3
> +
>  struct ipq4019_mdio_data {
> -	void __iomem	*membase;
> -	void __iomem *eth_ldo_rdy;
> +	void __iomem *membase;
> +	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];

Do you have any plans to make use of eth_ldo_rdy other than by code that
you touch in this patch? If you don't, what is the point of storing
these points in struct ipq4019_mdio_data ? You're using devm_ioremap()
which will already store the pointer internally to be able to free the
resource at the appropriate moment, so if your only use is shortly after
devm_ioremap(), you can use a local variable for this... meaning this
becomes (in addition to the other suggestion):

> +	/* This resource are optional */
> +	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
> +		if (res) {
> +			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
> +								res->start,
> +								resource_size(res));
> +
> +			/* The ethernet LDO enable is necessary to reset PHY
> +			 * by GPIO, some PHY(such as qca8084) GPIO reset uses
> +			 * the MDIO level reset, so this function should be
> +			 * called before the MDIO bus register.
> +			 */
> +			if (priv->eth_ldo_rdy[index]) {
> +				u32 val;
> +
> +				val = readl(priv->eth_ldo_rdy[index]);
> +				val |= BIT(0);
> +				writel(val, priv->eth_ldo_rdy[index]);
> +				fsleep(IPQ_PHY_SET_DELAY_US);
> +			}
> +		}

		void __iomem *eth_ldo_rdy;
		u32 val;

		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
		if (!res)
			break;

		eth_ldo_rdy = devm_ioremap(&pdev->dev, res->start,
					   resource_size(res));
		if (!eth_ldo_rdy)
			continue;

		val = readl(eth_ldo_rdy) | BIT(0);
		writel(val, eth_ldo_rdy);
		... whatever sleep is deemed required ...

Other issues:

1. if devm_ioremap() fails (returns NULL) is it right that we should
   just ignore that resource?

2. Do you need to sleep after each write, or will sleeping after
   writing all of these do? It may be more efficient to detect when
   we have at least one eth_ldo_rdy and then sleep once.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

