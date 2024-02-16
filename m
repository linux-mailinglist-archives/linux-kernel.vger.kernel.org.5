Return-Path: <linux-kernel+bounces-68111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE985761B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426B51C2267B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23EF14294;
	Fri, 16 Feb 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFixQkYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D06EEAC;
	Fri, 16 Feb 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066058; cv=none; b=amERx59PljaQidHEMd/WWsDq4U8BDFvqJ+KtKhNghlAJxY14ampTc0yu61lnGANrfWqHgbNiGjdEgxxCk3nSJJPSeljL2FfUkO683AgW8UTf6zLPc+qw7e478OjEA18e237FFHBgyF/Dkqd9mth47+H/2+w5338+L2wHmvHn3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066058; c=relaxed/simple;
	bh=IaYS5krugxcWWLdlP3aNH0s2GExm1DY2BuiHt8XgCtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1DhMnTHmWQgKfm3HtkDwD8bb/qWCXjAUQG9PuC3e4d9u5MyIPmuRgJjDuEWFhpxtnhTBsaZrJGNgvmf9KQMQtLLbdHRisPv8/YlqTrdoAbtPzbSbFoBAvPxK7ZTXaXo8PrZ6PLcc5rSt9MGWIB/aa2WrIZAHxbq5XYZCqXTIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFixQkYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28845C433C7;
	Fri, 16 Feb 2024 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066057;
	bh=IaYS5krugxcWWLdlP3aNH0s2GExm1DY2BuiHt8XgCtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFixQkYX/oFkmeTY9XozPfHlCyyrwGGiRn+t5Qo2SQB/M3BQWiTr6Gmi+2QULbQIP
	 ZXyActqWf41o80jJ/+K/aXx3YrthzC4zot80y4ffZW05ZYxhXuJLS4Xb9d8m+4qWm4
	 ZITMB1FHWB47wV/xS9bobtFeFdi8szGyjBCxLvwX6VopLmpkmGPqg/gMb4BR97pBwO
	 HOXf7/oYuxZ+TR5Qjqc8l5ef/mmv6O4cZt7vWOFgPIOo42otWumPFAq/7INIlaVp+D
	 lZvsWls0YcMYkkuRYs8lmSvHfHBp3g4mkjYpFRZt/hOfeHmFVZszks349e2vRiV7ZP
	 PJ0kdCoTwZeEQ==
Date: Fri, 16 Feb 2024 12:17:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	Zhang Yubing <yubing.zhang@rock-chips.com>
Subject: Re: [PATCH v2 04/12] phy: rockchip: add usbdp combo phy driver
Message-ID: <Zc8FBJbMeLng9DjS@matsya>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
 <20240213163609.44930-5-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213163609.44930-5-sebastian.reichel@collabora.com>

On 13-02-24, 17:32, Sebastian Reichel wrote:
> This adds a new USBDP combo PHY with Samsung IP block driver.
> 
> The driver get lane mux and mapping info in 2 ways, supporting
> DisplayPort alternate mode or parsing from DT. When parsing from DT,
> the property "rockchip,dp-lane-mux" provide the DP mux and mapping
> info. This is needed when the PHY is not used with TypeC Alt-Mode.
> For example if the USB3 interface of the PHY is connected to a USB
> Type A connector and the DP interface is connected to a DisplayPort
> connector.
> 
> When do DP link training, need to set lane number, link rate, swing,
> and pre-emphasis via PHY configure interface.
> 
> Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Co-developed-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Signed-off-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/phy/rockchip/Kconfig              |   12 +
>  drivers/phy/rockchip/Makefile             |    1 +
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 1639 +++++++++++++++++++++
>  3 files changed, 1652 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 94360fc96a6f..d21b458c1d18 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -107,3 +107,15 @@ config PHY_ROCKCHIP_USB
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the Rockchip USB 2.0 PHY.
> +
> +config PHY_ROCKCHIP_USBDP
> +	tristate "Rockchip USBDP COMBO PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	select TYPEC
> +	help
> +	  Enable this to support the Rockchip USB3.0/DP combo PHY with
> +	  Samsung IP block. This is required for USB3 support on RK3588.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called phy-rockchip-usbdp
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index 7eab129230d1..25d2e1355db7 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>  obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> +obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> new file mode 100644
> index 000000000000..8b1ace2aaa98
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -0,0 +1,1639 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Rockchip USBDP Combo PHY with Samsung IP block driver
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_mux.h>

Thats a lot of headers, do you need all?

> +static inline int rk_udphy_grfreg_write(struct regmap *base,
> +					const struct rk_udphy_grf_reg *reg, bool en)
> +{
> +	u32 val, mask, tmp;
> +
> +	tmp = en ? reg->enable : reg->disable;
> +	mask = GENMASK(reg->bitend, reg->bitstart);
> +	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);

Perhaps FIELD_PREP|GET for these?

> +static int rk_udphy_dplane_get(struct rk_udphy *udphy)
> +{
> +	int dp_lanes;
> +
> +	switch (udphy->mode) {
> +	case UDPHY_MODE_DP:
> +		dp_lanes = 4;
> +		break;

empty line after break makes it more readable

> +	case UDPHY_MODE_DP_USB:
> +		dp_lanes = 2;
> +		break;
> +	case UDPHY_MODE_USB:
> +		fallthrough;
> +	default:
> +		dp_lanes = 0;
> +		break;
> +	}
> +
> +	return dp_lanes;
> +}
> +
> +static int rk_udphy_dplane_enable(struct rk_udphy *udphy, int dp_lanes)
> +{
> +	u32 val = 0;
> +	int i;
> +
> +	for (i = 0; i < dp_lanes; i++)
> +		val |= BIT(udphy->dp_lane_sel[i]);
> +
> +	regmap_update_bits(udphy->pma_regmap, CMN_LANE_MUX_AND_EN_OFFSET, CMN_DP_LANE_EN_ALL,
> +			   FIELD_PREP(CMN_DP_LANE_EN_ALL, val));
> +
> +	if (!dp_lanes)
> +		regmap_update_bits(udphy->pma_regmap, CMN_DP_RSTN_OFFSET,
> +				   CMN_DP_CMN_RSTN, FIELD_PREP(CMN_DP_CMN_RSTN, 0x0));
> +
> +	return 0;

there is no error generation in the fn, these kind of fn should really
be not returning anything

> +static int rk_udphy_usb3_phy_init(struct phy *phy)
> +{
> +	struct rk_udphy *udphy = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	mutex_lock(&udphy->mutex);
> +	/* DP only or high-speed, disable U3 port */
> +	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs) {
> +		rk_udphy_u3_port_disable(udphy, true);
> +		goto unlock;

no power up in that case?

> +	}
> +
> +	ret = rk_udphy_power_on(udphy, UDPHY_MODE_USB);
> +
> +unlock:
> +	mutex_unlock(&udphy->mutex);
> +	return ret;
> +}
-- 
~Vinod

