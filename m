Return-Path: <linux-kernel+bounces-73192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB485BF13
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A81F25283
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552B6D1CA;
	Tue, 20 Feb 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gikVLEP+"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF51C2E;
	Tue, 20 Feb 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440472; cv=none; b=md0RGqSa7MTHgPZiJi0pAiZKHxTUFvyfHXNTHJ0joiPED1h6HbSPemf85YfssmwL6Cth3nYKNQoGJy9qcI9fevxfQf3Z/6GvUp7NrCLsS5SvqRqSci1kxnUj1UgB9/CsC6/LBK/vvhzG4vQmU/iu95c4E69OdSRTNMCe9gujWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440472; c=relaxed/simple;
	bh=gfGgS0BzBQ6bVw6tXUZ63VUQ3Xzy7xsSK9nGxoKfb3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We3AcFeMPlLtMXHb1CDUJyosRnuh+/z9fKhKGzZ/IPCbbDdNOLp+6MxqmFPYzj+vfNBio/fr1wYi5jDU/PVq5VJJkcfFWmOx284Zr76gK2xHdRv/J3gXY1KuYF01fS8aLiBxjpsYtb0YRUrdroan+Heyat82fCvDzRKv11p/eRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gikVLEP+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA1FA6000E;
	Tue, 20 Feb 2024 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708440462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yglFL5fFdcHpFnlQNpb6idsgAtkWcjOqPbPFvmeXUII=;
	b=gikVLEP+Bz3vz7gJOxqJOr1kSy6d9Ij/c/ToLre8ieQ17PtiwyVxhmvnMiFZPP5Bcab87Z
	E3AcT1vditl6ZgkEkVyPzztEL/gUuYf/aEOHH7HckTxIbfR0c/I3wNkzyeNeVURvaj44ab
	BR8JQLpwCKOsRzFGYdh1xwiO6pTb5SFy5NtQcnjvk4hx13PjZH6O5zdoiSlQQyI6gDvKjz
	qbIZoqThtTwASk3nZ8irmUDqroGIi7y3Akqbn68/dBj8WZEGZO/ul/UHQHU/tE1KHZgZrs
	j/MZ8/8G5gFp+I4H9+jEAJuQAGCYSL4ozbXuljSor7wMAs92ix4P0VeJ/R1eaA==
Date: Tue, 20 Feb 2024 15:47:37 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: <forbidden405@outlook.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Message-ID: <20240220154737.705c33e5@device-28.home>
In-Reply-To: <20240220-net-v3-3-b68e5b75e765@outlook.com>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
	<20240220-net-v3-3-b68e5b75e765@outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Tue, 20 Feb 2024 03:57:38 +0800
Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Register the sub MDIO bus if it is found. Also implement the internal
> PHY reset procedure as needed.
> 
> Note it's unable to put the MDIO bus node outside of MAC controller
> (i.e. at the same level in the parent bus node). Because we need to
> control all clocks and resets in FEMAC driver due to the phy reset
> procedure. So the clocks can't be assigned to MDIO bus device, which is
> an essential resource for the MDIO bus to work.
> 
> No backward compatibility is maintained since the only existing
> user(Hi3516DV300) has not received any updates from HiSilicon for about
> 8 years already. And till today, no mainline dts for this SoC is found.
> It seems unlikely that there are still existing mainline Hi3516DV300
> users. The effort to maintain the old binding seems gain a little.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Besides what Andrew and Simon already mentionned, I have a few other
small comments :

[...]

> @@ -797,23 +816,22 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  		goto out_free_netdev;
>  	}
>  
> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "failed to get clk\n");
> -		ret = -ENODEV;
> +	ret = devm_clk_bulk_get_all(&pdev->dev, &priv->clks);
> +	if (ret < 0 || ret != CLK_NUM) {
> +		dev_err(dev, "failed to get clk bulk: %d\n", ret);
>  		goto out_free_netdev;
>  	}
>  
> -	ret = clk_prepare_enable(priv->clk);
> +	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
>  	if (ret) {
> -		dev_err(dev, "failed to enable clk %d\n", ret);
> +		dev_err(dev, "failed to enable clk bulk: %d\n", ret);
>  		goto out_free_netdev;
>  	}
>  
>  	priv->mac_rst = devm_reset_control_get(dev, "mac");
>  	if (IS_ERR(priv->mac_rst)) {
>  		ret = PTR_ERR(priv->mac_rst);
> -		goto out_disable_clk;
> +		goto out_free_netdev;

When you return here (or even later), you are missing a call to
"clk_bulk_disable_unprepare" in the cleanup path

>  	}
>  	hisi_femac_core_reset(priv);
>  
> @@ -826,15 +844,34 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  						 priv->phy_reset_delays,
>  						 DELAYS_NUM);
>  		if (ret)
> -			goto out_disable_clk;
> +			goto out_free_netdev;
>  		hisi_femac_phy_reset(priv);
>  	}
>  
> +	// Register the optional MDIO bus

I think this comment style should be avoided, in favor of C-style
comments ( /* blabla */ )

> +	for_each_available_child_of_node(node, mdio_np) {
> +		if (of_node_name_prefix(mdio_np, "mdio")) {
> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
> +			of_node_put(mdio_np);
> +			if (!priv->mdio_pdev) {
> +				dev_err(dev, "failed to register MDIO bus device\n");
> +				ret = -ENODEV;
> +				goto out_free_netdev;
> +			}
> +			mdio_registered = true;
> +			break;
> +		}
> +		of_node_put(mdio_np);
> +	}
> +
> +	if (!mdio_registered)
> +		dev_warn(dev, "MDIO subnode not found. This is usually a bug.\n");
> +
>  	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>  	if (!phy) {
>  		dev_err(dev, "connect to PHY failed!\n");
>  		ret = -ENODEV;
> -		goto out_disable_clk;
> +		goto out_unregister_mdio_bus;
>  	}
>  
>  	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",

Thanks,

Maxime

