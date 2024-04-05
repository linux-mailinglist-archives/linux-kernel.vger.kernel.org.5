Return-Path: <linux-kernel+bounces-133368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555CC89A2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FA71F23A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6960171658;
	Fri,  5 Apr 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaRNhIgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219EE79E3;
	Fri,  5 Apr 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335970; cv=none; b=CGAxFyNtujWVVhH+gICjMixTILZU0K7OGDIaq6d76TGjRiv0IV3TgOmIGzPQZzYZnozQyq9ebE1frAnFXvuKnmraXV8UvtWkPFHE3EY1sBtC95Lo46uR8XXfsI0IgeW5SeUQ8+eGrruf7LgNlPRsKKGQElecrdOdAD4r1jYtmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335970; c=relaxed/simple;
	bh=mt/7m6gE+/mQeYNIuTIpesLMoVgYypS7PcDtGHkbqws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUHTSgVMQLc/ujuOXGMVDYXFJs3nkjWOS+rA/iN5+fGYQ6DofsouQs0RPVzkSRcr8EuJQQdA+qw30xSIMWGp99xg1sH0w1KDIzMD8rb/Q0peMgYeTgGcGJp7P6257Tekrdqei2tvK7T7svyucEu4B+qkt6YStd4gCEnPHrLvXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaRNhIgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3367AC433F1;
	Fri,  5 Apr 2024 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712335969;
	bh=mt/7m6gE+/mQeYNIuTIpesLMoVgYypS7PcDtGHkbqws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaRNhIgMnDYWgjPVKq0IlAjsC3Yq2QY7DGainZ5KQiecDDQtNx5qr1eZMbSCf2AW5
	 oHlWIljCKRo6uCUN/Sn3mTjZbi+JqlZzs5QIbAVshQ/+bI9obXK6dIAybh3d3Yl7Yk
	 mFqfGcaZjr1AIUnFw2q+1Yt/mbrw9+NWx7csLU/Q7QIoDpjd0Kh2yRqSCjJwgM+Itf
	 e2mA9jcY5cw/wYgitaH/t7+3wKljzuXDPPDgzPA61i6VA5KHy4FfXQ0+tKpAHNpqc3
	 lcRVcr7P/kNK5dVr3Z0pmZMvFRLHbUmowypCXZyq6mSAXJixspO0ayR93tha/UFb05
	 gNyRa8cYrP2Zw==
Date: Fri, 5 Apr 2024 22:22:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: forbidden405@outlook.com
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	David Yang <mmyangfl@gmail.com>
Subject: Re: [PATCH v5 5/5] phy: hisilicon: hisi-inno-phy: add support for
 Hi3798MV200 INNO PHY
Message-ID: <ZhAsXUjifTD6HeKx@matsya>
References: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
 <20240305-inno-phy-v5-5-dc1cb130ea08@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-inno-phy-v5-5-dc1cb130ea08@outlook.com>

On 05-03-24, 21:32, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>

That is quite an email id!

> 
> Direct MMIO resgiter access is used by Hi3798MV200. For other models,
> of_iomap() returns NULL due to insufficient length. So they are

so how is that fixed... Pls describe the change...
> unaffected.
> 
> Also Hi3798MV200 INNO PHY has an extra reset required to be deasserted,
> switch to reset_control_array_*() APIs for that.

That probably should be a different patch

> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 66 ++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> index b7e740eb4752..df154cd99ed8 100644
> --- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> +++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> @@ -24,6 +25,7 @@
>  
>  #define PHY_TYPE_0	0
>  #define PHY_TYPE_1	1
> +#define PHY_TYPE_MMIO	2
>  
>  #define PHY_TEST_DATA		GENMASK(7, 0)
>  #define PHY_TEST_ADDR_OFFSET	8
> @@ -43,6 +45,7 @@
>  #define PHY_CLK_ENABLE		BIT(2)
>  
>  struct hisi_inno_phy_port {
> +	void __iomem *base;
>  	struct reset_control *utmi_rst;
>  	struct hisi_inno_phy_priv *priv;
>  };
> @@ -50,7 +53,7 @@ struct hisi_inno_phy_port {
>  struct hisi_inno_phy_priv {
>  	void __iomem *mmio;
>  	struct clk *ref_clk;
> -	struct reset_control *por_rst;
> +	struct reset_control *rsts;
>  	unsigned int type;
>  	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
>  };
> @@ -62,26 +65,31 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
>  	u32 val;
>  	u32 value;
>  
> -	if (priv->type == PHY_TYPE_0)
> -		val = (data & PHY_TEST_DATA) |
> -		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
> -		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
> -		      PHY0_TEST_WREN | PHY0_TEST_RST;
> -	else
> -		val = (data & PHY_TEST_DATA) |
> -		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
> -		      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
> -		      PHY1_TEST_WREN | PHY1_TEST_RST;
> -	writel(val, reg);
> -
> -	value = val;
> -	if (priv->type == PHY_TYPE_0)
> -		value |= PHY0_TEST_CLK;
> -	else
> -		value |= PHY1_TEST_CLK;
> -	writel(value, reg);
> -
> -	writel(val, reg);
> +	if (priv->ports[port].base)
> +		/* FIXME: fill stride in priv */

when?

> +		writel(data, (u32 *)priv->ports[port].base + addr);
> +	else {
> +		if (priv->type == PHY_TYPE_0)
> +			val = (data & PHY_TEST_DATA) |
> +			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
> +			      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
> +			      PHY0_TEST_WREN | PHY0_TEST_RST;
> +		else
> +			val = (data & PHY_TEST_DATA) |
> +			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
> +			      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
> +			      PHY1_TEST_WREN | PHY1_TEST_RST;
> +		writel(val, reg);
> +
> +		value = val;
> +		if (priv->type == PHY_TYPE_0)
> +			value |= PHY0_TEST_CLK;
> +		else
> +			value |= PHY1_TEST_CLK;
> +		writel(value, reg);
> +
> +		writel(val, reg);

val and value are very helpful variables, do consider naming them
better!

> +	}
>  }
>  
>  static void hisi_inno_phy_setup(struct hisi_inno_phy_priv *priv)
> @@ -104,7 +112,7 @@ static int hisi_inno_phy_init(struct phy *phy)
>  		return ret;
>  	udelay(REF_CLK_STABLE_TIME);
>  
> -	reset_control_deassert(priv->por_rst);
> +	reset_control_deassert(priv->rsts);
>  	udelay(POR_RST_COMPLETE_TIME);
>  
>  	/* Set up phy registers */
> @@ -122,7 +130,7 @@ static int hisi_inno_phy_exit(struct phy *phy)
>  	struct hisi_inno_phy_priv *priv = port->priv;
>  
>  	reset_control_assert(port->utmi_rst);
> -	reset_control_assert(priv->por_rst);
> +	reset_control_assert(priv->rsts);
>  	clk_disable_unprepare(priv->ref_clk);
>  
>  	return 0;
> @@ -158,15 +166,16 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->ref_clk))
>  		return PTR_ERR(priv->ref_clk);
>  
> -	priv->por_rst = devm_reset_control_get_exclusive(dev, NULL);
> -	if (IS_ERR(priv->por_rst))
> -		return PTR_ERR(priv->por_rst);
> +	priv->rsts = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(priv->rsts))
> +		return PTR_ERR(priv->rsts);
>  
>  	priv->type = (uintptr_t) of_device_get_match_data(dev);
>  
>  	for_each_child_of_node(np, child) {
>  		struct reset_control *rst;
>  		struct phy *phy;
> +		void __iomem *base;
>  
>  		rst = of_reset_control_get_exclusive(child, NULL);
>  		if (IS_ERR(rst)) {
> @@ -174,7 +183,10 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
>  			return PTR_ERR(rst);
>  		}
>  
> +		base = of_iomap(child, 0);
> +
>  		priv->ports[i].utmi_rst = rst;
> +		priv->ports[i].base = base;
>  		priv->ports[i].priv = priv;
>  
>  		phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
> @@ -205,6 +217,8 @@ static const struct of_device_id hisi_inno_phy_of_match[] = {
>  	  .data = (void *) PHY_TYPE_0 },
>  	{ .compatible = "hisilicon,hi3798mv100-usb2-phy",
>  	  .data = (void *) PHY_TYPE_1 },
> +	{ .compatible = "hisilicon,hi3798mv200-usb2-phy",
> +	  .data = (void *) PHY_TYPE_MMIO },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, hisi_inno_phy_of_match);
> 
> -- 
> 2.43.0

-- 
~Vinod

