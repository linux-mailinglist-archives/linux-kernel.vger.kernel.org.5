Return-Path: <linux-kernel+bounces-133833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29B89A975
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC281281C52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EE22EED;
	Sat,  6 Apr 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo4eSOcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD52206E;
	Sat,  6 Apr 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387187; cv=none; b=eLzl4Luby0cW2ZEPifXFTmvaiKjV2P62D9XRPnFYX3gMBNDAIxSslS8wY4keaZ1Q9y6UO3Isg6dS5JksnKPy8ZAmZgGDSkg+5v5EaKWwIAIsADrfkiNAl6JrwSJ57reXyzjn56t0vNe0RWWVc1e7scR5T1XN4UF2INEy8Nrz8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387187; c=relaxed/simple;
	bh=MCFYeOmRurFOqa2pWXaognBvgbOHLrLLj1a7t+4t00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtKAAseE+1dPIKNerq/eOSvyd/GbY77sEqmd7s9v+68FOpL5LsMCoD+PTPYXLtxLExlOO6s64TP7ajEuamBOdqmo+nQLbj3t8qyiXP6kvI+CXsbLQJCePAdWQPjInStw9T+hcINYpS+s9s2kOv/1aARBa3sAf03wEsd3hAewxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo4eSOcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E995C43390;
	Sat,  6 Apr 2024 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712387186;
	bh=MCFYeOmRurFOqa2pWXaognBvgbOHLrLLj1a7t+4t00g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qo4eSOcjsN7orGimV+Ldl+ZnKKNN6IZnM6S/e3F+Yum2SMulDYOtIwqkAOE2LrAo0
	 xfXzoOJ8cwkYKAZ5BzJl6NcsMlGZ6cX8WwH4rvKHfyeInnpLyyayx1a+sxM52MJaUu
	 aiVR+2+AHRKPMGHzMp4MpuRKKAWw2FPdNdpRSu1LMOX2E7CrDQU0woSYzOptZXovMx
	 NL8If4/Qh1IOYMPZWTbdyF0g/7XbVZW+Ji5imyF4tpmwGBu7FTwhsfqFPZPtigzl3H
	 CXShIg1ek8MCpFHFu9wf6SekZVvhxRoDg5GUdW4aJeLZlQwdRJaHtVZh4m+9u7do1v
	 pT4T6vNRucH6A==
Date: Sat, 6 Apr 2024 12:36:22 +0530
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
Subject: Re: [PATCH v4 02/10] phy: rockchip: add usbdp combo phy driver
Message-ID: <ZhD0bvZLh0POrljR@matsya>
References: <20240325141653.84910-1-sebastian.reichel@collabora.com>
 <20240325141653.84910-3-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325141653.84910-3-sebastian.reichel@collabora.com>

On 25-03-24, 15:15, Sebastian Reichel wrote:
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
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/phy/rockchip/Kconfig              |   12 +
>  drivers/phy/rockchip/Makefile             |    1 +
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 1612 +++++++++++++++++++++
>  3 files changed, 1625 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index a34f67bb7e61..c3d62243b474 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -115,3 +115,15 @@ config PHY_ROCKCHIP_USB
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
> index 3d911304e654..010a824e32ce 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)	+= phy-rockchip-samsung-hdptx.o
>  obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> +obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> new file mode 100644
> index 000000000000..38dc96cfe403
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -0,0 +1,1612 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Rockchip USBDP Combo PHY with Samsung IP block driver
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd

we are in 2024!

> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>

Do you need both

> +#include <linux/delay.h>
> +#include <linux/gpio.h>
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

That seems a bit more of headers, do you need all of them?

> +static int rk_udphy_setup(struct rk_udphy *udphy)
> +{
> +	int ret = 0;

Superfluous init

> +static int rk_udphy_parse_dt(struct rk_udphy *udphy)
> +{
> +	struct device *dev = udphy->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	enum usb_device_speed maximum_speed;
> +	int ret;
> +
> +	udphy->u2phygrf = syscon_regmap_lookup_by_phandle(np, "rockchip,u2phy-grf");
> +	if (IS_ERR(udphy->u2phygrf))
> +		return dev_err_probe(dev, PTR_ERR(udphy->u2phygrf), "failed to get u2phy-grf\n");
> +
> +	udphy->udphygrf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbdpphy-grf");
> +	if (IS_ERR(udphy->udphygrf))
> +		return dev_err_probe(dev, PTR_ERR(udphy->udphygrf), "failed to get usbdpphy-grf\n");
> +
> +	udphy->usbgrf = syscon_regmap_lookup_by_phandle(np, "rockchip,usb-grf");
> +	if (IS_ERR(udphy->usbgrf))
> +		return dev_err_probe(dev, PTR_ERR(udphy->usbgrf), "failed to get usb-grf\n");
> +
> +	udphy->vogrf = syscon_regmap_lookup_by_phandle(np, "rockchip,vo-grf");
> +	if (IS_ERR(udphy->vogrf))
> +		return dev_err_probe(dev, PTR_ERR(udphy->vogrf), "failed to get vo-grf\n");
> +
> +	ret = rk_udphy_parse_lane_mux_data(udphy);
> +	if (ret)
> +		return ret;
> +
> +	udphy->sbu1_dc_gpio = devm_gpiod_get_optional(dev, "sbu1-dc", GPIOD_OUT_LOW);
> +	if (IS_ERR(udphy->sbu1_dc_gpio))
> +		return PTR_ERR(udphy->sbu1_dc_gpio);
> +
> +	udphy->sbu2_dc_gpio = devm_gpiod_get_optional(dev, "sbu2-dc", GPIOD_OUT_LOW);
> +	if (IS_ERR(udphy->sbu2_dc_gpio))
> +		return PTR_ERR(udphy->sbu2_dc_gpio);
> +
> +	if (device_property_present(dev, "maximum-speed")) {
> +		maximum_speed = usb_get_maximum_speed(dev);
> +		udphy->hs = maximum_speed <= USB_SPEED_HIGH ? true : false;
> +	}
> +
> +	ret = rk_udphy_clk_init(udphy, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = rk_udphy_reset_init(udphy, dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return rk_udphy_reset_init()

> +static const struct phy_ops rk_udphy_dp_phy_ops = {
> +	.init		= rk_udphy_dp_phy_init,
> +	.exit		= rk_udphy_dp_phy_exit,
> +	.power_on	= rk_udphy_dp_phy_power_on,
> +	.power_off	= rk_udphy_dp_phy_power_off,
> +	.configure	= rk_udphy_dp_phy_configure,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int rk_udphy_usb3_phy_init(struct phy *phy)
> +{
> +	struct rk_udphy *udphy = phy_get_drvdata(phy);
> +	int ret = 0;

Superfluous init here too

-- 
~Vinod

