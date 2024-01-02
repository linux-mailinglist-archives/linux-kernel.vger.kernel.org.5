Return-Path: <linux-kernel+bounces-14293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD1821AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C0528324B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98158EAD7;
	Tue,  2 Jan 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="d+FVtQhM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404BE544;
	Tue,  2 Jan 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jI2+mSjyP3+sg9ERDBog/JWSHEnygreZvEgS5CoygT0=; b=d+FVtQhMbRhOqhtPjPcymM0/4V
	NEZF5QOL1M/Uy7wapNoAU28VJvz2wkk/bQLg2B7A0/DnzU1C2ZX0a2tv8/kdA/ATbATJL1pfl874C
	BBvZqqnQfmbEcvhXEzu+n/qL76BW/QB9MnNwiYWwkMVn2sk0FsEfFXsEO1RrnVv9Igwq1DmefpxTN
	0ApCWN4JswB2HF/8v4N4PvqjFHcSylGk3CHo/1g3rYSXElkcuZzLYKrh9YSRXOW7j1523OC+gm9FW
	UO48rXiHxXf/LxRB6gpccR00M8JC/O86Ud8a4y0ZbP1Vt5Cvb03ssT1kqrZO3KlN8690Fel2KezwV
	1EcunSLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40982)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcyz-0006T8-3D;
	Tue, 02 Jan 2024 11:30:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcyx-0005Ep-7l; Tue, 02 Jan 2024 11:30:51 +0000
Date: Tue, 2 Jan 2024 11:30:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, wens@csie.org, samuel@sholland.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v5 1/3] phy: handle optional regulator for PHY
Message-ID: <ZZPz6+LETeF4PRDW@shell.armlinux.org.uk>
References: <20231220203537.83479-1-jernej.skrabec@gmail.com>
 <20231220203537.83479-2-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220203537.83479-2-jernej.skrabec@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 09:35:35PM +0100, Jernej Skrabec wrote:
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Add handling of optional regulators for PHY.
> 
> Regulators need to be enabled before PHY scanning, so MDIO bus
> initiate this task.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/net/mdio/fwnode_mdio.c | 53 ++++++++++++++++++++++++++++++++--
>  drivers/net/phy/phy_device.c   |  6 ++++
>  include/linux/phy.h            |  3 ++
>  3 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index fd02f5cbc853..bd5a27eaf40c 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/pse-pd/pse.h>
> +#include <linux/regulator/consumer.h>
>  
>  MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
>  MODULE_LICENSE("GPL");
> @@ -58,6 +59,40 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  	return register_mii_timestamper(arg.np, arg.args[0]);
>  }
>  
> +static int
> +fwnode_regulator_get_bulk_enabled(struct device *dev,
> +				  struct fwnode_handle *fwnode,
> +				  struct regulator_bulk_data **consumers)

This seems to be a bad name for something living in fwnode_mdio.c - it
looks like something the regulator core should be providing.

> +clean_regulators:
> +	if (reg_cnt > 0)
> +		regulator_bulk_disable(reg_cnt, consumers);
> +	kfree(consumers);

and there really should be a function that undoes the effects of
fwnode_regulator_get_bulk_enabled() rather than having it open-coded,
especially as:

> @@ -3400,6 +3401,11 @@ static int phy_remove(struct device *dev)
>  
>  	phydev->drv = NULL;
>  
> +	if (phydev->regulator_cnt > 0)
> +		regulator_bulk_disable(phydev->regulator_cnt, phydev->consumers);
> +
> +	kfree(phydev->consumers);
> +

it also appears here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

