Return-Path: <linux-kernel+bounces-74734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5E85D861
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF5EB21EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8D69D3D;
	Wed, 21 Feb 2024 12:53:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957436995D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520023; cv=none; b=eu3pXRiO37KfdYcDu5aLXt2hyPwt/we4R0WX4/Dsean5ixtyI8MWzznGUvN7eZShuOGOiLxdyswZMsGu2bPABXeIbkW2lJxrD9XlCFcGa/YOG7Ya2wra0daoNRtKU6UDOTCHFRHdZf/o/BqebtkKjg+mhSDlLhoaEoPVGLH9oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520023; c=relaxed/simple;
	bh=hTG3eAPLYzYmquR02fXknRi2lIHvaWX9Eb6xzIxa+3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7IE4o3kVJW1uGENFQr9UCl15TmMm5eN3FA2x9D9G+Rn662ZUick1tijsLJ36NtkgAyseqsVdbl8ZpKD3LPI7gYyvJPJIgwJYdF9DVUf9qwQwz/wY/3RIAWHbtwgvpoAF54QTEIR+S9a+GB5k9u0lnyx+kRFWAHG7Wq71i1+/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcm6C-0005K1-8p; Wed, 21 Feb 2024 13:53:20 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcm68-0022jj-SA; Wed, 21 Feb 2024 13:53:16 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rcm68-00083g-2a;
	Wed, 21 Feb 2024 13:53:16 +0100
Message-ID: <4bf4146749abb1500f8a412deb4d61ab0f3c80e6.camel@pengutronix.de>
Subject: Re: [PATCH RFC v3 4/5] phy: hisilicon: hisi-inno-phy: add support
 for Hi3798MV200 INNO PHY
From: Philipp Zabel <p.zabel@pengutronix.de>
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn
 Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, David
 Yang <mmyangfl@gmail.com>
Date: Wed, 21 Feb 2024 13:53:16 +0100
In-Reply-To: <20240220-inno-phy-v3-4-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
	 <20240220-inno-phy-v3-4-893cdf8633b4@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-02-20 at 05:28 +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Direct MMIO resgiter access is used by Hi3798MV200. For other models,

              register

> of_iomap() returns 0 due to insufficient length. So they are unaffected.
>=20
> Also Hi3798MV200 INNO PHY has an extra reset required to be deasserted,
> switch to reset_control_bulk_() APIs to resolve this.

            reset_control_array_()

apparently.

> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 65 ++++++++++++++++++------=
------
>  1 file changed, 39 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/his=
ilicon/phy-hisi-inno-usb2.c
> index b7e740eb4752..5175e5a351ac 100644
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
> @@ -43,6 +44,7 @@
>  #define PHY_CLK_ENABLE		BIT(2)
> =20
>  struct hisi_inno_phy_port {
> +	void __iomem *base;
>  	struct reset_control *utmi_rst;
>  	struct hisi_inno_phy_priv *priv;
>  };
> @@ -50,7 +52,7 @@ struct hisi_inno_phy_port {
>  struct hisi_inno_phy_priv {
>  	void __iomem *mmio;
>  	struct clk *ref_clk;
> -	struct reset_control *por_rst;
> +	struct reset_control *rsts;
>  	unsigned int type;
>  	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
>  };
> @@ -62,26 +64,31 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_=
phy_priv *priv,
>  	u32 val;
>  	u32 value;
> =20
> -	if (priv->type =3D=3D PHY_TYPE_0)
> -		val =3D (data & PHY_TEST_DATA) |
> -		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
> -		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
> -		      PHY0_TEST_WREN | PHY0_TEST_RST;
> -	else
> -		val =3D (data & PHY_TEST_DATA) |
> -		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
> -		      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
> -		      PHY1_TEST_WREN | PHY1_TEST_RST;
> -	writel(val, reg);
> -
> -	value =3D val;
> -	if (priv->type =3D=3D PHY_TYPE_0)
> -		value |=3D PHY0_TEST_CLK;
> -	else
> -		value |=3D PHY1_TEST_CLK;
> -	writel(value, reg);
> -
> -	writel(val, reg);
> +	if (priv->ports[port].base)
> +		// stride is 4
> +		writel(data, (u32 *)priv->ports[port].base + addr);
> +	else {
> +		if (priv->type =3D=3D PHY_TYPE_0)
> +			val =3D (data & PHY_TEST_DATA) |
> +			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
> +			      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
> +			      PHY0_TEST_WREN | PHY0_TEST_RST;
> +		else
> +			val =3D (data & PHY_TEST_DATA) |
> +			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
> +			      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
> +			      PHY1_TEST_WREN | PHY1_TEST_RST;
> +		writel(val, reg);
> +
> +		value =3D val;
> +		if (priv->type =3D=3D PHY_TYPE_0)
> +			value |=3D PHY0_TEST_CLK;
> +		else
> +			value |=3D PHY1_TEST_CLK;
> +		writel(value, reg);
> +
> +		writel(val, reg);
> +	}
>  }
> =20
>  static void hisi_inno_phy_setup(struct hisi_inno_phy_priv *priv)
> @@ -104,7 +111,7 @@ static int hisi_inno_phy_init(struct phy *phy)
>  		return ret;
>  	udelay(REF_CLK_STABLE_TIME);
> =20
> -	reset_control_deassert(priv->por_rst);
> +	reset_control_deassert(priv->rsts);
>  	udelay(POR_RST_COMPLETE_TIME);
> =20
>  	/* Set up phy registers */
> @@ -122,7 +129,7 @@ static int hisi_inno_phy_exit(struct phy *phy)
>  	struct hisi_inno_phy_priv *priv =3D port->priv;
> =20
>  	reset_control_assert(port->utmi_rst);
> -	reset_control_assert(priv->por_rst);
> +	reset_control_assert(priv->rsts);
>  	clk_disable_unprepare(priv->ref_clk);
> =20
>  	return 0;
> @@ -158,15 +165,16 @@ static int hisi_inno_phy_probe(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(priv->ref_clk))
>  		return PTR_ERR(priv->ref_clk);
> =20
> -	priv->por_rst =3D devm_reset_control_get_exclusive(dev, NULL);
> -	if (IS_ERR(priv->por_rst))
> -		return PTR_ERR(priv->por_rst);
> +	priv->rsts =3D devm_reset_control_array_get(dev, false, false);

Please use devm_reset_control_array_get_exclusive() instead.


regards
Philipp

