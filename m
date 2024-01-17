Return-Path: <linux-kernel+bounces-28758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6428302B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200C11F23AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852A156C2;
	Wed, 17 Jan 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="c9Ya0QrL"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075415AE0;
	Wed, 17 Jan 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484826; cv=none; b=oevKONKSkHRu3LMZdUjDDUqCIsnPY0jtpjM8xHhvIT/vpzNiqSLFSzHG1/GFPXeSfNYAvu8LJ2QxH5PnW5434RbFztZEZz7PJpnUtiem6ZJFWr47h7U5sHhpAKIm/xRphXhiRedJCXQdH0CyMOWaec7B4jS1XDmWU6zZ4PiR5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484826; c=relaxed/simple;
	bh=7018fT8BOZjszHwOMlOJoy7+lgPQexmupiPJbcWp/SE=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type; b=fbnntODbSGONt4Qb7FTukaZk/TVAfmGWhdcgGrWmpt4uNj0IrJlQyirExh1LvlOYSjlX7emdDvb0xmbZyI5aX8SvQgjKpByqYTjYhJ5/pn+Cllmbj6EM0Zdw22NUW21/nag3bI7YL+50LBdZFRkhbHbkAmJhDNnrvCFbgBkFX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=c9Ya0QrL; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705484823; x=1737020823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fxZ0UEKWOwYf4QKD2JIJfHjMRBWewARbU873Zw0tqpk=;
  b=c9Ya0QrLWZGu7FM1dUrMgXgk+4QG2VSTN5qF01j2LDGxnzEdsytTZV+H
   LyGkK3/u5OP3Qg/s891mS4ke5r7tBcsmBTXOumQgCk8JVAsbJT+PI+9a5
   7taO6oipbmLw8aR5uT0O3O7Mv80P62z0W0Pv+jLE1AsOcAlOvav/bsgQA
   KAWkJHC8zW26aOGjc4Oqi3nrjO99ngL+u0CpuQ/hy5qt4BvG7Ks9l1JSi
   bj8+Sju/HKlM3S7E4jDQzckSHs2AWiB7Z4PBS9UC+f18tIbSapYXIJaBZ
   q12N31xZwCUnAe32YuSALmwSMTQe0ZQQ5GMZUUbO3UDgarnUa2HyefL6+
   g==;
X-IronPort-AV: E=Sophos;i="6.05,200,1701126000"; 
   d="scan'208";a="34935831"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Jan 2024 10:47:02 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 27CB4280075;
	Wed, 17 Jan 2024 10:47:02 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, Sandor Yu <Sandor.yu@nxp.com>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, Sandor.yu@nxp.com, oliver.brown@nxp.com, sam@ravnborg.org
Subject: Re: [PATCH v12 7/7] phy: freescale: Add HDMI PHY driver for i.MX8MQ
Date: Wed, 17 Jan 2024 10:47:01 +0100
Message-ID: <3204157.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <176920a13c11129f61c1f550bb64e7ddb7ef1b14.1704785836.git.Sandor.yu@nxp.com>
References: <cover.1704785836.git.Sandor.yu@nxp.com> <176920a13c11129f61c1f550bb64e7ddb7ef1b14.1704785836.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Sandor,

thanks for the update.

Am Mittwoch, 10. Januar 2024, 02:08:48 CET schrieb Sandor Yu:
> Add Cadence HDP-TX HDMI PHY driver for i.MX8MQ.
>=20
> Cadence HDP-TX PHY could be put in either DP mode or
> HDMI mode base on the configuration chosen.
> HDMI PHY mode is configurated in the driver.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> v11->v12:
> - Adjust clk disable order.
> - Return error code to replace -1 for function wait_for_ack().
> - Use bool for variable pclk_in.
> - Add year 2024 to copyright.
>=20
>  drivers/phy/freescale/Kconfig               |  10 +
>  drivers/phy/freescale/Makefile              |   1 +
>  drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c | 959 ++++++++++++++++++++
>  3 files changed, 970 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c
>=20
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index c39709fd700ac..14f47b7cc77ab 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -45,6 +45,16 @@ config PHY_FSL_IMX8MQ_DP
>  	  Enable this to support the Cadence HDPTX DP PHY driver
>  	  on i.MX8MQ SOC.
>=20
> +config PHY_FSL_IMX8MQ_HDMI
> +	tristate "Freescale i.MX8MQ HDMI PHY support"
> +	depends on OF && HAS_IOMEM
> +	depends on COMMON_CLK
> +	select GENERIC_PHY
> +	select CDNS_MHDP_HELPER
> +	help
> +	  Enable this to support the Cadence HDPTX HDMI PHY driver
> +	  on i.MX8MQ SOC.
> +
>  endif
>=20
>  config PHY_FSL_LYNX_28G
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makef=
ile
> index 47e5285209fa8..1380ac31c2ead 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PHY_FSL_IMX8MQ_DP)		+=3D phy-fsl-imx8mq-dp.o
> +obj-$(CONFIG_PHY_FSL_IMX8MQ_HDMI)	+=3D phy-fsl-imx8mq-hdmi.o
>  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+=3D phy-fsl-imx8mq-usb.o
>  obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+=3D phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+=3D phy-fsl-imx8-mipi-dphy.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c
> b/drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c new file mode 100644
> index 0000000000000..9e03c726f290c
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c
> @@ -0,0 +1,959 @@
> [snip]
> +int cdns_hdptx_hdmi_phy_valid(struct phy *phy, enum phy_mode mode, int
> submode, +			      union phy_configure_opts *opts)

This function can be made static.

Thanks and best regards,
Alexander

> +{
> +	u32 rate =3D opts->hdmi.pixel_clk_rate;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pixel_clk_output_ctrl_table); i++)
> +		if (rate =3D=3D=20
pixel_clk_output_ctrl_table[i].pixel_clk_freq_min)
> +			return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int cdns_hdptx_hdmi_phy_init(struct phy *phy)
> +{
> +	return 0;
> +}
> +
> +static int cdns_hdptx_hdmi_configure(struct phy *phy,
> +				     union phy_configure_opts *opts)
> +{
> +	struct cdns_hdptx_hdmi_phy *cdns_phy =3D phy_get_drvdata(phy);
> +	int ret;
> +
> +	cdns_phy->pixel_clk_rate =3D opts->hdmi.pixel_clk_rate;
> +	cdns_phy->color_space =3D opts->hdmi.color_space;
> +	cdns_phy->bpc =3D opts->hdmi.bpc;
> +
> +	/* Check HDMI FW alive before HDMI PHY init */
> +	ret =3D hdptx_phy_check_alive(cdns_phy);
> +	if (!ret) {
> +		dev_err(cdns_phy->dev, "NO HDMI FW running\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Configure PHY */
> +	if (hdptx_hdmi_phy_cfg(cdns_phy, cdns_phy->pixel_clk_rate) < 0) {
> +		dev_err(cdns_phy->dev, "failed to set phy pclock\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D hdptx_hdmi_phy_power_up(cdns_phy);
> +	if (ret < 0)
> +		return ret;
> +
> +	hdptx_hdmi_phy_set_vswing(cdns_phy);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops cdns_hdptx_hdmi_phy_ops =3D {
> +	.init =3D cdns_hdptx_hdmi_phy_init,
> +	.configure =3D cdns_hdptx_hdmi_configure,
> +	.power_on =3D cdns_hdptx_hdmi_phy_on,
> +	.power_off =3D cdns_hdptx_hdmi_phy_off,
> +	.validate =3D cdns_hdptx_hdmi_phy_valid,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int cdns_hdptx_hdmi_phy_probe(struct platform_device *pdev)
> +{
> +	struct cdns_hdptx_hdmi_phy *cdns_phy;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	struct phy *phy;
> +	int ret;
> +
> +	cdns_phy =3D devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
> +	if (!cdns_phy)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, cdns_phy);
> +	cdns_phy->dev =3D dev;
> +	mutex_init(&cdns_phy->mbox_mutex);
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	cdns_phy->regs =3D devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(cdns_phy->regs))
> +		return PTR_ERR(cdns_phy->regs);
> +
> +	phy =3D devm_phy_create(dev, node, &cdns_hdptx_hdmi_phy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy->attrs.mode =3D PHY_MODE_HDMI;
> +
> +	cdns_phy->phy =3D phy;
> +	phy_set_drvdata(phy, cdns_phy);
> +
> +	/* init base struct for access mhdp mailbox */
> +	cdns_phy->base.dev =3D cdns_phy->dev;
> +	cdns_phy->base.regs =3D cdns_phy->regs;
> +	cdns_phy->base.mbox_mutex =3D &cdns_phy->mbox_mutex;
> +
> +	ret =3D hdptx_hdmi_clk_enable(cdns_phy);
> +	if (ret) {
> +		dev_err(dev, "Init clk fail\n");
> +		return -EINVAL;
> +	}
> +
> +	phy_provider =3D devm_of_phy_provider_register(dev,=20
of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		ret =3D PTR_ERR(phy_provider);
> +		goto clk_disable;
> +	}
> +
> +	dev_dbg(dev, "probe success!\n");
> +
> +	return 0;
> +
> +clk_disable:
> +	hdptx_hdmi_clk_disable(cdns_phy);
> +
> +	return -EINVAL;
> +}
> +
> +static int cdns_hdptx_hdmi_phy_remove(struct platform_device *pdev)
> +{
> +	struct cdns_hdptx_hdmi_phy *cdns_phy =3D platform_get_drvdata(pdev);
> +
> +	hdptx_hdmi_clk_disable(cdns_phy);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cdns_hdptx_hdmi_phy_of_match[] =3D {
> +	{.compatible =3D "fsl,imx8mq-hdmi-phy" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cdns_hdptx_hdmi_phy_of_match);
> +
> +static struct platform_driver cdns_hdptx_hdmi_phy_driver =3D {
> +	.probe =3D cdns_hdptx_hdmi_phy_probe,
> +	.remove =3D cdns_hdptx_hdmi_phy_remove,
> +	.driver =3D {
> +		.name	=3D "cdns-hdptx-hdmi-phy",
> +		.of_match_table	=3D cdns_hdptx_hdmi_phy_of_match,
> +	}
> +};
> +module_platform_driver(cdns_hdptx_hdmi_phy_driver);
> +
> +MODULE_AUTHOR("Sandor Yu <sandor.yu@nxp.com>");
> +MODULE_DESCRIPTION("Cadence HDP-TX HDMI PHY driver");
> +MODULE_LICENSE("GPL");


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



