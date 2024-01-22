Return-Path: <linux-kernel+bounces-33887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E155837003
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0FB355B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CF52F99;
	Mon, 22 Jan 2024 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NPwRkO4Y"
Received: from mail-m12815.netease.com (mail-m12815.netease.com [103.209.128.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A853E0C;
	Mon, 22 Jan 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946500; cv=none; b=AgSXhKmS0o+c7YD04keRRacy6askMmWxHGy3s2gE62nv5X7SrhoH5fgsL7nNdyfFHARd29AxSk7xFQi1uZBtJ1cbQj63zF7ZjOPo0pfi1NswB4kGJfDCVp0eTtkWYx3cKlbtClPclLP0ba/SRpy9mCAytE31NhC5AflDYVKBi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946500; c=relaxed/simple;
	bh=TCs8iLkQroZQTv+h2YLvzu2iuUUULRyzaqKYD+mMd2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvWHYsd5tlzw2sXiFM3z5+m9sVh9EovN/ZvOKGT9kMi7nekjJnSSt7nOrM9U7s2w+TJtubK4sX+cYT+K511XPypQ40/Eya4HUbRaqTDc+lZMton73GwmTXZ+GewY+JMnYM7/FFJzX424tGYj0yuXUBA/HWwEAJpn/+ih3bbjyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NPwRkO4Y; arc=none smtp.client-ip=103.209.128.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=NPwRkO4YBopYzw4InnzA5pl/SEKSJ5rLnDPRoX4E9wtedcYXzs6Q2Yq2YhtBQiqJZsvrro9v59cnTaNQFSG7VVvrLxL61g+L4ffp0dJcCBpIq53tWu/NOHxfN9JJYRQ+8RHFVhmfrBleWBVUgoN1/cBwBVW6EoSHfaQr9cIcvls=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CZIXVOusvU85eQ0S3gse9qAdAIjzc1HSuKObhB9h9S0=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12758.qiye.163.com (Hmail) with ESMTPA id 705B8AE04C0;
	Mon, 22 Jan 2024 18:17:51 +0800 (CST)
Message-ID: <298b7a10-2acb-4297-92cd-2ee4d890bfb2@rock-chips.com>
Date: Mon, 22 Jan 2024 18:17:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
Content-Language: en-US
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkfT1ZNSRlOSR1KQ0MfTx5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8d30ad2c24b225kuuu705b8ae04c0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDI6HQw4AjwqMg8JCRMcQ1E8
	ITwwC09VSlVKTEtOQkpDTUxJTUlLVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBTE5NSEo3Bg++

Hi Cristian:

On 1/20/24 03:38, Cristian Ciocaltea wrote:
> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.  The maximum data rate is 12Gbps (HDMI 2.1 FRL), while
> the minimum is 250Mbps (HDMI 2.1 TMDS).
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/phy/rockchip/Kconfig                  |    8 +
>   drivers/phy/rockchip/Makefile                 |    1 +
>   .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 2045 +++++++++++++++++
>   3 files changed, 2054 insertions(+)
>   create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 94360fc96a6f..95666ac6aa3b 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -83,6 +83,14 @@ config PHY_ROCKCHIP_PCIE
>   	help
>   	  Enable this to support the Rockchip PCIe PHY.
>   
> +config PHY_ROCKCHIP_SAMSUNG_HDPTX
> +	tristate "Rockchip Samsung HDMI/DP Combo PHY driver"
> +	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip HDMI/DP Combo PHY
> +	  with Samsung IP block.
> +
>   config PHY_ROCKCHIP_SNPS_PCIE3
>   	tristate "Rockchip Snps PCIe3 PHY Driver"
>   	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index 7eab129230d1..3d911304e654 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>   obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
>   obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
>   obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
> +obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)	+= phy-rockchip-samsung-hdptx.o
>   obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>   obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>   obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> new file mode 100644
> index 000000000000..d8171ea5ce2b
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -0,0 +1,2045 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2024 Collabora Ltd.
> + *
> + * Author: Algea Cao <algea.cao@rock-chips.com>
> + * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/rational.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define GRF_HDPTX_CON0			0x00
> +#define HDPTX_I_PLL_EN			BIT(7)
> +#define HDPTX_I_BIAS_EN			BIT(6)
> +#define HDPTX_I_BGR_EN			BIT(5)
> +#define GRF_HDPTX_STATUS		0x80
> +#define HDPTX_O_PLL_LOCK_DONE		BIT(3)
> +#define HDPTX_O_PHY_CLK_RDY		BIT(2)
> +#define HDPTX_O_PHY_RDY			BIT(1)
> +#define HDPTX_O_SB_RDY			BIT(0)
> +
> +#define CMN_REG0000			0x0000
> +#define CMN_REG0001			0x0004
> +#define CMN_REG0002			0x0008
> +#define CMN_REG0003			0x000C
> +#define CMN_REG0004			0x0010
> +#define CMN_REG0005			0x0014
> +#define CMN_REG0006			0x0018
> +#define CMN_REG0007			0x001C
> +#define CMN_REG0008			0x0020
> +#define LCPLL_EN_MASK			BIT(6)
> +#define LCPLL_LCVCO_MODE_EN_MASK	BIT(4)
> +#define CMN_REG0009			0x0024
> +#define CMN_REG000A			0x0028
> +#define CMN_REG000B			0x002C
> +#define CMN_REG000C			0x0030
> +#define CMN_REG000D			0x0034
> +#define CMN_REG000E			0x0038
> +#define CMN_REG000F			0x003C
> +#define CMN_REG0010			0x0040
> +#define CMN_REG0011			0x0044
> +#define CMN_REG0012			0x0048
> +#define CMN_REG0013			0x004C
> +#define CMN_REG0014			0x0050
> +#define CMN_REG0015			0x0054
> +#define CMN_REG0016			0x0058
> +#define CMN_REG0017			0x005C
> +#define CMN_REG0018			0x0060
> +#define CMN_REG0019			0x0064
> +#define CMN_REG001A			0x0068
> +#define CMN_REG001B			0x006C
> +#define CMN_REG001C			0x0070
> +#define CMN_REG001D			0x0074
> +#define CMN_REG001E			0x0078
> +#define LCPLL_PI_EN_MASK		BIT(5)
> +#define LCPLL_100M_CLK_EN_MASK		BIT(0)
> +#define CMN_REG001F			0x007C
> +#define CMN_REG0020			0x0080
> +#define CMN_REG0021			0x0084
> +#define CMN_REG0022			0x0088
> +#define CMN_REG0023			0x008C
> +#define CMN_REG0024			0x0090
> +#define CMN_REG0025			0x0094
> +#define LCPLL_PMS_IQDIV_RSTN		BIT(4)
> +#define CMN_REG0026			0x0098
> +#define CMN_REG0027			0x009C
> +#define CMN_REG0028			0x00A0
> +#define LCPLL_SDC_FRAC_EN		BIT(2)
> +#define LCPLL_SDC_FRAC_RSTN		BIT(0)
> +#define CMN_REG0029			0x00A4
> +#define CMN_REG002A			0x00A8
> +#define CMN_REG002B			0x00AC
> +#define CMN_REG002C			0x00B0
> +#define CMN_REG002D			0x00B4
> +#define LCPLL_SDC_N_MASK		GENMASK(3, 1)
> +#define CMN_REG002E			0x00B8
> +#define LCPLL_SDC_NUMBERATOR_MASK	GENMASK(5, 0)
> +#define CMN_REG002F			0x00BC
> +#define LCPLL_SDC_DENOMINATOR_MASK	GENMASK(7, 2)
> +#define LCPLL_SDC_NDIV_RSTN		BIT(0)
> +#define CMN_REG0030			0x00C0
> +#define CMN_REG0031			0x00C4
> +#define CMN_REG0032			0x00C8
> +#define CMN_REG0033			0x00CC
> +#define CMN_REG0034			0x00D0
> +#define CMN_REG0035			0x00D4
> +#define CMN_REG0036			0x00D8
> +#define CMN_REG0037			0x00DC
> +#define CMN_REG0038			0x00E0
> +#define CMN_REG0039			0x00E4
> +#define CMN_REG003A			0x00E8
> +#define CMN_REG003B			0x00EC
> +#define CMN_REG003C			0x00F0
> +#define CMN_REG003D			0x00F4
> +#define ROPLL_LCVCO_EN			BIT(4)
> +#define CMN_REG003E			0x00F8
> +#define CMN_REG003F			0x00FC
> +#define CMN_REG0040			0x0100
> +#define CMN_REG0041			0x0104
> +#define CMN_REG0042			0x0108
> +#define CMN_REG0043			0x010C
> +#define CMN_REG0044			0x0110
> +#define CMN_REG0045			0x0114
> +#define CMN_REG0046			0x0118
> +#define CMN_REG0047			0x011C
> +#define CMN_REG0048			0x0120
> +#define CMN_REG0049			0x0124
> +#define CMN_REG004A			0x0128
> +#define CMN_REG004B			0x012C
> +#define CMN_REG004C			0x0130
> +#define CMN_REG004D			0x0134
> +#define CMN_REG004E			0x0138
> +#define ROPLL_PI_EN			BIT(5)
> +#define CMN_REG004F			0x013C
> +#define CMN_REG0050			0x0140
> +#define CMN_REG0051			0x0144
> +#define CMN_REG0052			0x0148
> +#define CMN_REG0053			0x014C
> +#define CMN_REG0054			0x0150
> +#define CMN_REG0055			0x0154
> +#define CMN_REG0056			0x0158
> +#define CMN_REG0057			0x015C
> +#define CMN_REG0058			0x0160
> +#define CMN_REG0059			0x0164
> +#define CMN_REG005A			0x0168
> +#define CMN_REG005B			0x016C
> +#define CMN_REG005C			0x0170
> +#define ROPLL_PMS_IQDIV_RSTN		BIT(5)
> +#define CMN_REG005D			0x0174
> +#define CMN_REG005E			0x0178
> +#define ROPLL_SDM_EN_MASK		BIT(6)
> +#define ROPLL_SDM_FRAC_EN_RBR		BIT(3)
> +#define ROPLL_SDM_FRAC_EN_HBR		BIT(2)
> +#define ROPLL_SDM_FRAC_EN_HBR2		BIT(1)
> +#define ROPLL_SDM_FRAC_EN_HBR3		BIT(0)
> +#define CMN_REG005F			0x017C
> +#define CMN_REG0060			0x0180
> +#define CMN_REG0061			0x0184
> +#define CMN_REG0062			0x0188
> +#define CMN_REG0063			0x018C
> +#define CMN_REG0064			0x0190
> +#define ROPLL_SDM_NUM_SIGN_RBR_MASK	BIT(3)
> +#define CMN_REG0065			0x0194
> +#define CMN_REG0066			0x0198
> +#define CMN_REG0067			0x019C
> +#define CMN_REG0068			0x01A0
> +#define CMN_REG0069			0x01A4
> +#define ROPLL_SDC_N_RBR_MASK		GENMASK(2, 0)
> +#define CMN_REG006A			0x01A8
> +#define CMN_REG006B			0x01AC
> +#define CMN_REG006C			0x01B0
> +#define CMN_REG006D			0x01B4
> +#define CMN_REG006E			0x01B8
> +#define CMN_REG006F			0x01BC
> +#define CMN_REG0070			0x01C0
> +#define CMN_REG0071			0x01C4
> +#define CMN_REG0072			0x01C8
> +#define CMN_REG0073			0x01CC
> +#define CMN_REG0074			0x01D0
> +#define ROPLL_SDC_NDIV_RSTN		BIT(2)
> +#define ROPLL_SSC_EN			BIT(0)
> +#define CMN_REG0075			0x01D4
> +#define CMN_REG0076			0x01D8
> +#define CMN_REG0077			0x01DC
> +#define CMN_REG0078			0x01E0
> +#define CMN_REG0079			0x01E4
> +#define CMN_REG007A			0x01E8
> +#define CMN_REG007B			0x01EC
> +#define CMN_REG007C			0x01F0
> +#define CMN_REG007D			0x01F4
> +#define CMN_REG007E			0x01F8
> +#define CMN_REG007F			0x01FC
> +#define CMN_REG0080			0x0200
> +#define CMN_REG0081			0x0204
> +#define OVRD_PLL_CD_CLK_EN		BIT(8)
> +#define PLL_CD_HSCLK_EAST_EN		BIT(0)
> +#define CMN_REG0082			0x0208
> +#define CMN_REG0083			0x020C
> +#define CMN_REG0084			0x0210
> +#define CMN_REG0085			0x0214
> +#define CMN_REG0086			0x0218
> +#define PLL_PCG_POSTDIV_SEL_MASK	GENMASK(7, 4)
> +#define PLL_PCG_CLK_SEL_MASK		GENMASK(3, 1)
> +#define PLL_PCG_CLK_EN			BIT(0)
> +#define CMN_REG0087			0x021C
> +#define PLL_FRL_MODE_EN			BIT(3)
> +#define PLL_TX_HS_CLK_EN		BIT(2)
> +#define CMN_REG0088			0x0220
> +#define CMN_REG0089			0x0224
> +#define LCPLL_ALONE_MODE		BIT(1)
> +#define CMN_REG008A			0x0228
> +#define CMN_REG008B			0x022C
> +#define CMN_REG008C			0x0230
> +#define CMN_REG008D			0x0234
> +#define CMN_REG008E			0x0238
> +#define CMN_REG008F			0x023C
> +#define CMN_REG0090			0x0240
> +#define CMN_REG0091			0x0244
> +#define CMN_REG0092			0x0248
> +#define CMN_REG0093			0x024C
> +#define CMN_REG0094			0x0250
> +#define CMN_REG0095			0x0254
> +#define CMN_REG0096			0x0258
> +#define CMN_REG0097			0x025C
> +#define DIG_CLK_SEL			BIT(1)
> +#define ROPLL_REF			BIT(1)
> +#define LCPLL_REF			0
> +#define CMN_REG0098			0x0260
> +#define CMN_REG0099			0x0264
> +#define CMN_ROPLL_ALONE_MODE		BIT(2)
> +#define ROPLL_ALONE_MODE		BIT(2)
> +#define CMN_REG009A			0x0268
> +#define HS_SPEED_SEL			BIT(0)
> +#define DIV_10_CLOCK			BIT(0)
> +#define CMN_REG009B			0x026C
> +#define IS_SPEED_SEL			BIT(4)
> +#define LINK_SYMBOL_CLOCK		BIT(4)
> +#define LINK_SYMBOL_CLOCK1_2		0
> +#define CMN_REG009C			0x0270
> +#define CMN_REG009D			0x0274
> +#define CMN_REG009E			0x0278
> +#define CMN_REG009F			0x027C
> +#define CMN_REG00A0			0x0280
> +#define CMN_REG00A1			0x0284
> +#define CMN_REG00A2			0x0288
> +#define CMN_REG00A3			0x028C
> +#define CMN_REG00AD			0x0290
> +#define CMN_REG00A5			0x0294
> +#define CMN_REG00A6			0x0298
> +#define CMN_REG00A7			0x029C
> +#define SB_REG0100			0x0400
> +#define SB_REG0101			0x0404
> +#define SB_REG0102			0x0408
> +#define OVRD_SB_RXTERM_EN_MASK		BIT(5)
> +#define SB_RXTERM_EN_MASK		BIT(4)
> +#define ANA_SB_RXTERM_OFFSP_MASK	GENMASK(3, 0)
> +#define SB_REG0103			0x040C
> +#define ANA_SB_RXTERM_OFFSN_MASK	GENMASK(6, 3)
> +#define OVRD_SB_RX_RESCAL_DONE_MASK	BIT(1)
> +#define SB_RX_RESCAL_DONE_MASK		BIT(0)
> +#define SB_REG0104			0x0410
> +#define OVRD_SB_EN_MASK			BIT(5)
> +#define SB_EN_MASK			BIT(4)
> +#define SB_REG0105			0x0414
> +#define OVRD_SB_EARC_CMDC_EN_MASK	BIT(6)
> +#define SB_EARC_CMDC_EN_MASK		BIT(5)
> +#define ANA_SB_TX_HLVL_PROG_MASK	GENMASK(2, 0)
> +#define SB_REG0106			0x0418
> +#define ANA_SB_TX_LLVL_PROG_MASK	GENMASK(6, 4)
> +#define SB_REG0107			0x041C
> +#define SB_REG0108			0x0420
> +#define SB_REG0109			0x0424
> +#define ANA_SB_DMRX_AFC_DIV_RATIO_MASK	GENMASK(2, 0)
> +#define SB_REG010A			0x0428
> +#define SB_REG010B			0x042C
> +#define SB_REG010C			0x0430
> +#define SB_REG010D			0x0434
> +#define SB_REG010E			0x0438
> +#define SB_REG010F			0x043C
> +#define OVRD_SB_VREG_EN_MASK		BIT(7)
> +#define SB_VREG_EN_MASK			BIT(6)
> +#define OVRD_SB_VREG_LPF_BYPASS_MASK	BIT(5)
> +#define SB_VREG_LPF_BYPASS_MASK		BIT(4)
> +#define ANA_SB_VREG_GAIN_CTRL_MASK	GENMASK(3, 0)
> +#define SB_REG0110			0x0440
> +#define ANA_SB_VREG_REF_SEL_MASK	BIT(0)
> +#define SB_REG0111			0x0444
> +#define SB_REG0112			0x0448
> +#define SB_REG0113			0x044C
> +#define SB_RX_RCAL_OPT_CODE_MASK	GENMASK(5, 4)
> +#define SB_RX_RTERM_CTRL_MASK		GENMASK(3, 0)
> +#define SB_REG0114			0x0450
> +#define SB_TG_SB_EN_DELAY_TIME_MASK	GENMASK(5, 3)
> +#define SB_TG_RXTERM_EN_DELAY_TIME_MASK	GENMASK(2, 0)
> +#define SB_REG0115			0x0454
> +#define SB_READY_DELAY_TIME_MASK	GENMASK(5, 3)
> +#define SB_TG_OSC_EN_DELAY_TIME_MASK	GENMASK(2, 0)
> +#define SB_REG0116			0x0458
> +#define AFC_RSTN_DELAY_TIME_MASK	GENMASK(6, 4)
> +#define SB_REG0117			0x045C
> +#define FAST_PULSE_TIME_MASK		GENMASK(3, 0)
> +#define SB_REG0118			0x0460
> +#define SB_REG0119			0x0464
> +#define SB_REG011A			0x0468
> +#define SB_REG011B			0x046C
> +#define SB_EARC_SIG_DET_BYPASS_MASK	BIT(4)
> +#define SB_AFC_TOL_MASK			GENMASK(3, 0)
> +#define SB_REG011C			0x0470
> +#define SB_REG011D			0x0474
> +#define SB_REG011E			0x0478
> +#define SB_REG011F			0x047C
> +#define SB_PWM_AFC_CTRL_MASK		GENMASK(7, 2)
> +#define SB_RCAL_RSTN_MASK		BIT(1)
> +#define SB_REG0120			0x0480
> +#define SB_EARC_EN_MASK			BIT(1)
> +#define SB_EARC_AFC_EN_MASK		BIT(2)
> +#define SB_REG0121			0x0484
> +#define SB_REG0122			0x0488
> +#define SB_REG0123			0x048C
> +#define OVRD_SB_READY_MASK		BIT(5)
> +#define SB_READY_MASK			BIT(4)
> +#define SB_REG0124			0x0490
> +#define SB_REG0125			0x0494
> +#define SB_REG0126			0x0498
> +#define SB_REG0127			0x049C
> +#define SB_REG0128			0x04A0
> +#define SB_REG0129			0x04AD
> +#define LNTOP_REG0200			0x0800
> +#define PROTOCOL_SEL			BIT(2)
> +#define HDMI_MODE			BIT(2)
> +#define HDMI_TMDS_FRL_SEL		BIT(1)
> +#define LNTOP_REG0201			0x0804
> +#define LNTOP_REG0202			0x0808
> +#define LNTOP_REG0203			0x080C
> +#define LNTOP_REG0204			0x0810
> +#define LNTOP_REG0205			0x0814
> +#define LNTOP_REG0206			0x0818
> +#define DATA_BUS_SEL			BIT(0)
> +#define DATA_BUS_36_40			BIT(0)
> +#define LNTOP_REG0207			0x081C
> +#define LANE_EN				0xf
> +#define ALL_LANE_EN			0xf
> +#define LNTOP_REG0208			0x0820
> +#define LNTOP_REG0209			0x0824
> +#define LNTOP_REG020A			0x0828
> +#define LNTOP_REG020B			0x082C
> +#define LNTOP_REG020C			0x0830
> +#define LNTOP_REG020D			0x0834
> +#define LNTOP_REG020E			0x0838
> +#define LNTOP_REG020F			0x083C
> +#define LNTOP_REG0210			0x0840
> +#define LNTOP_REG0211			0x0844
> +#define LNTOP_REG0212			0x0848
> +#define LNTOP_REG0213			0x084C
> +#define LNTOP_REG0214			0x0850
> +#define LNTOP_REG0215			0x0854
> +#define LNTOP_REG0216			0x0858
> +#define LNTOP_REG0217			0x085C
> +#define LNTOP_REG0218			0x0860
> +#define LNTOP_REG0219			0x0864
> +#define LNTOP_REG021A			0x0868
> +#define LNTOP_REG021B			0x086C
> +#define LNTOP_REG021C			0x0870
> +#define LNTOP_REG021D			0x0874
> +#define LNTOP_REG021E			0x0878
> +#define LNTOP_REG021F			0x087C
> +#define LNTOP_REG0220			0x0880
> +#define LNTOP_REG0221			0x0884
> +#define LNTOP_REG0222			0x0888
> +#define LNTOP_REG0223			0x088C
> +#define LNTOP_REG0224			0x0890
> +#define LNTOP_REG0225			0x0894
> +#define LNTOP_REG0226			0x0898
> +#define LNTOP_REG0227			0x089C
> +#define LNTOP_REG0228			0x08A0
> +#define LNTOP_REG0229			0x08A4
> +#define LANE_REG0300			0x0C00
> +#define LANE_REG0301			0x0C04
> +#define LANE_REG0302			0x0C08
> +#define LANE_REG0303			0x0C0C
> +#define LANE_REG0304			0x0C10
> +#define LANE_REG0305			0x0C14
> +#define LANE_REG0306			0x0C18
> +#define LANE_REG0307			0x0C1C
> +#define LANE_REG0308			0x0C20
> +#define LANE_REG0309			0x0C24
> +#define LANE_REG030A			0x0C28
> +#define LANE_REG030B			0x0C2C
> +#define LANE_REG030C			0x0C30
> +#define LANE_REG030D			0x0C34
> +#define LANE_REG030E			0x0C38
> +#define LANE_REG030F			0x0C3C
> +#define LANE_REG0310			0x0C40
> +#define LANE_REG0311			0x0C44
> +#define LANE_REG0312			0x0C48
> +#define LN0_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN0_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN0_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN0_TX_SER_RATE_SEL_HBR3	BIT(2)
> +#define LANE_REG0313			0x0C4C
> +#define LANE_REG0314			0x0C50
> +#define LANE_REG0315			0x0C54
> +#define LANE_REG0316			0x0C58
> +#define LANE_REG0317			0x0C5C
> +#define LANE_REG0318			0x0C60
> +#define LANE_REG0319			0x0C64
> +#define LANE_REG031A			0x0C68
> +#define LANE_REG031B			0x0C6C
> +#define LANE_REG031C			0x0C70
> +#define LANE_REG031D			0x0C74
> +#define LANE_REG031E			0x0C78
> +#define LANE_REG031F			0x0C7C
> +#define LANE_REG0320			0x0C80
> +#define LANE_REG0321			0x0C84
> +#define LANE_REG0322			0x0C88
> +#define LANE_REG0323			0x0C8C
> +#define LANE_REG0324			0x0C90
> +#define LANE_REG0325			0x0C94
> +#define LANE_REG0326			0x0C98
> +#define LANE_REG0327			0x0C9C
> +#define LANE_REG0328			0x0CA0
> +#define LANE_REG0329			0x0CA4
> +#define LANE_REG032A			0x0CA8
> +#define LANE_REG032B			0x0CAC
> +#define LANE_REG032C			0x0CB0
> +#define LANE_REG032D			0x0CB4
> +#define LANE_REG0400			0x1000
> +#define LANE_REG0401			0x1004
> +#define LANE_REG0402			0x1008
> +#define LANE_REG0403			0x100C
> +#define LANE_REG0404			0x1010
> +#define LANE_REG0405			0x1014
> +#define LANE_REG0406			0x1018
> +#define LANE_REG0407			0x101C
> +#define LANE_REG0408			0x1020
> +#define LANE_REG0409			0x1024
> +#define LANE_REG040A			0x1028
> +#define LANE_REG040B			0x102C
> +#define LANE_REG040C			0x1030
> +#define LANE_REG040D			0x1034
> +#define LANE_REG040E			0x1038
> +#define LANE_REG040F			0x103C
> +#define LANE_REG0410			0x1040
> +#define LANE_REG0411			0x1044
> +#define LANE_REG0412			0x1048
> +#define LN1_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN1_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN1_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN1_TX_SER_RATE_SEL_HBR3	BIT(2)
> +#define LANE_REG0413			0x104C
> +#define LANE_REG0414			0x1050
> +#define LANE_REG0415			0x1054
> +#define LANE_REG0416			0x1058
> +#define LANE_REG0417			0x105C
> +#define LANE_REG0418			0x1060
> +#define LANE_REG0419			0x1064
> +#define LANE_REG041A			0x1068
> +#define LANE_REG041B			0x106C
> +#define LANE_REG041C			0x1070
> +#define LANE_REG041D			0x1074
> +#define LANE_REG041E			0x1078
> +#define LANE_REG041F			0x107C
> +#define LANE_REG0420			0x1080
> +#define LANE_REG0421			0x1084
> +#define LANE_REG0422			0x1088
> +#define LANE_REG0423			0x108C
> +#define LANE_REG0424			0x1090
> +#define LANE_REG0425			0x1094
> +#define LANE_REG0426			0x1098
> +#define LANE_REG0427			0x109C
> +#define LANE_REG0428			0x10A0
> +#define LANE_REG0429			0x10A4
> +#define LANE_REG042A			0x10A8
> +#define LANE_REG042B			0x10AC
> +#define LANE_REG042C			0x10B0
> +#define LANE_REG042D			0x10B4
> +#define LANE_REG0500			0x1400
> +#define LANE_REG0501			0x1404
> +#define LANE_REG0502			0x1408
> +#define LANE_REG0503			0x140C
> +#define LANE_REG0504			0x1410
> +#define LANE_REG0505			0x1414
> +#define LANE_REG0506			0x1418
> +#define LANE_REG0507			0x141C
> +#define LANE_REG0508			0x1420
> +#define LANE_REG0509			0x1424
> +#define LANE_REG050A			0x1428
> +#define LANE_REG050B			0x142C
> +#define LANE_REG050C			0x1430
> +#define LANE_REG050D			0x1434
> +#define LANE_REG050E			0x1438
> +#define LANE_REG050F			0x143C
> +#define LANE_REG0510			0x1440
> +#define LANE_REG0511			0x1444
> +#define LANE_REG0512			0x1448
> +#define LN2_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN2_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN2_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN2_TX_SER_RATE_SEL_HBR3	BIT(2)
> +#define LANE_REG0513			0x144C
> +#define LANE_REG0514			0x1450
> +#define LANE_REG0515			0x1454
> +#define LANE_REG0516			0x1458
> +#define LANE_REG0517			0x145C
> +#define LANE_REG0518			0x1460
> +#define LANE_REG0519			0x1464
> +#define LANE_REG051A			0x1468
> +#define LANE_REG051B			0x146C
> +#define LANE_REG051C			0x1470
> +#define LANE_REG051D			0x1474
> +#define LANE_REG051E			0x1478
> +#define LANE_REG051F			0x147C
> +#define LANE_REG0520			0x1480
> +#define LANE_REG0521			0x1484
> +#define LANE_REG0522			0x1488
> +#define LANE_REG0523			0x148C
> +#define LANE_REG0524			0x1490
> +#define LANE_REG0525			0x1494
> +#define LANE_REG0526			0x1498
> +#define LANE_REG0527			0x149C
> +#define LANE_REG0528			0x14A0
> +#define LANE_REG0529			0x14AD
> +#define LANE_REG052A			0x14A8
> +#define LANE_REG052B			0x14AC
> +#define LANE_REG052C			0x14B0
> +#define LANE_REG052D			0x14B4
> +#define LANE_REG0600			0x1800
> +#define LANE_REG0601			0x1804
> +#define LANE_REG0602			0x1808
> +#define LANE_REG0603			0x180C
> +#define LANE_REG0604			0x1810
> +#define LANE_REG0605			0x1814
> +#define LANE_REG0606			0x1818
> +#define LANE_REG0607			0x181C
> +#define LANE_REG0608			0x1820
> +#define LANE_REG0609			0x1824
> +#define LANE_REG060A			0x1828
> +#define LANE_REG060B			0x182C
> +#define LANE_REG060C			0x1830
> +#define LANE_REG060D			0x1834
> +#define LANE_REG060E			0x1838
> +#define LANE_REG060F			0x183C
> +#define LANE_REG0610			0x1840
> +#define LANE_REG0611			0x1844
> +#define LANE_REG0612			0x1848
> +#define LN3_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN3_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN3_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN3_TX_SER_RATE_SEL_HBR3	BIT(2)
> +#define LANE_REG0613			0x184C
> +#define LANE_REG0614			0x1850
> +#define LANE_REG0615			0x1854
> +#define LANE_REG0616			0x1858
> +#define LANE_REG0617			0x185C
> +#define LANE_REG0618			0x1860
> +#define LANE_REG0619			0x1864
> +#define LANE_REG061A			0x1868
> +#define LANE_REG061B			0x186C
> +#define LANE_REG061C			0x1870
> +#define LANE_REG061D			0x1874
> +#define LANE_REG061E			0x1878
> +#define LANE_REG061F			0x187C
> +#define LANE_REG0620			0x1880
> +#define LANE_REG0621			0x1884
> +#define LANE_REG0622			0x1888
> +#define LANE_REG0623			0x188C
> +#define LANE_REG0624			0x1890
> +#define LANE_REG0625			0x1894
> +#define LANE_REG0626			0x1898
> +#define LANE_REG0627			0x189C
> +#define LANE_REG0628			0x18A0
> +#define LANE_REG0629			0x18A4
> +#define LANE_REG062A			0x18A8
> +#define LANE_REG062B			0x18AC
> +#define LANE_REG062C			0x18B0
> +#define LANE_REG062D			0x18B4
> +
> +#define HDMI20_MAX_RATE			600000000
> +#define DATA_RATE_MASK			0xFFFFFFF
> +#define COLOR_DEPTH_MASK		BIT(31)
> +#define HDMI_MODE_MASK			BIT(30)
> +#define HDMI_EARC_MASK			BIT(29)
> +
> +struct lcpll_config {
> +	u32 bit_rate;
> +	u8 lcvco_mode_en;
> +	u8 pi_en;
> +	u8 clk_en_100m;
> +	u8 pms_mdiv;
> +	u8 pms_mdiv_afc;
> +	u8 pms_pdiv;
> +	u8 pms_refdiv;
> +	u8 pms_sdiv;
> +	u8 pi_cdiv_rstn;
> +	u8 pi_cdiv_sel;
> +	u8 sdm_en;
> +	u8 sdm_rstn;
> +	u8 sdc_frac_en;
> +	u8 sdc_rstn;
> +	u8 sdm_deno;
> +	u8 sdm_num_sign;
> +	u8 sdm_num;
> +	u8 sdc_n;
> +	u8 sdc_n2;
> +	u8 sdc_num;
> +	u8 sdc_deno;
> +	u8 sdc_ndiv_rstn;
> +	u8 ssc_en;
> +	u8 ssc_fm_dev;
> +	u8 ssc_fm_freq;
> +	u8 ssc_clk_div_sel;
> +	u8 cd_tx_ser_rate_sel;
> +};
> +
> +struct ropll_config {
> +	u32 bit_rate;
> +	u8 pms_mdiv;
> +	u8 pms_mdiv_afc;
> +	u8 pms_pdiv;
> +	u8 pms_refdiv;
> +	u8 pms_sdiv;
> +	u8 pms_iqdiv_rstn;
> +	u8 ref_clk_sel;
> +	u8 sdm_en;
> +	u8 sdm_rstn;
> +	u8 sdc_frac_en;
> +	u8 sdc_rstn;
> +	u8 sdm_clk_div;
> +	u8 sdm_deno;
> +	u8 sdm_num_sign;
> +	u8 sdm_num;
> +	u8 sdc_n;
> +	u8 sdc_num;
> +	u8 sdc_deno;
> +	u8 sdc_ndiv_rstn;
> +	u8 ssc_en;
> +	u8 ssc_fm_dev;
> +	u8 ssc_fm_freq;
> +	u8 ssc_clk_div_sel;
> +	u8 ana_cpp_ctrl;
> +	u8 ana_lpf_c_sel;
> +	u8 cd_tx_ser_rate_sel;
> +};
> +
> +enum rockchip_hdptx_reset {
> +	RST_PHY = 0,
> +	RST_APB,
> +	RST_INIT,
> +	RST_CMN,
> +	RST_LANE,
> +	RST_ROPLL,
> +	RST_LCPLL,
> +	RST_MAX
> +};
> +
> +struct rockchip_hdptx_phy {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regmap *grf;
> +
> +	struct phy *phy;
> +	struct phy_config *phy_cfg;
> +	struct clk_bulk_data *clks;
> +	int nr_clks;
> +	struct reset_control_bulk_data rsts[RST_MAX];
> +	bool earc_en;
> +};
> +
> +static const struct lcpll_config lcpll_cfg[] = {
> +	{ 48000000, 1, 0, 0, 0x7d, 0x7d, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 2,
> +	  0, 0x13, 0x18, 1, 0, 0x20, 0x0c, 1, 0, },
> +	{ 40000000, 1, 1, 0, 0x68, 0x68, 1, 1, 0, 0, 0, 1, 1, 1, 1, 9, 0, 1, 1,
> +	  0, 2, 3, 1, 0, 0x20, 0x0c, 1, 0, },
> +	{ 32000000, 1, 1, 1, 0x6b, 0x6b, 1, 1, 0, 1, 2, 1, 1, 1, 1, 9, 1, 2, 1,
> +	  0, 0x0d, 0x18, 1, 0, 0x20, 0x0c, 1, 1, },
> +	{ ~0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	  0, 0, 0, 0, 0, },
> +};
> +
> +static const struct ropll_config ropll_frl_cfg[] = {
> +	{ 24000000, 0x19, 0x19, 1, 1, 0, 1, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1,
> +	  0, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 18000000, 0x7d, 0x7d, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1,
> +	  0, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 9000000, 0x7d, 0x7d, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1,
> +	  0, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ ~0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	  0, 0, 0, 0, },
> +};
> +
> +static const struct ropll_config ropll_tmds_cfg[] = {
> +	{ 5940000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 3712500, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 2970000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1620000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1856250, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1540000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1485000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
> +	  0x10, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1462500, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1190000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1065000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1080000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 855000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 835000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 928125, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 742500, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 650000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 337500, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
> +	  1, 1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 400000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 270000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 251750, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ ~0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +	  0, 0, 0, 0, },
> +};
> +
> +static bool rockchip_hdptx_phy_is_rw_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x0000 ... 0x029c:
> +	case 0x0400 ... 0x04a4:
> +	case 0x0800 ... 0x08a4:
> +	case 0x0c00 ... 0x0cb4:
> +	case 0x1000 ... 0x10b4:
> +	case 0x1400 ... 0x14b4:
> +	case 0x1800 ... 0x18b4:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config rockchip_hdptx_phy_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.writeable_reg = rockchip_hdptx_phy_is_rw_reg,
> +	.readable_reg = rockchip_hdptx_phy_is_rw_reg,
> +	.fast_io = true,
> +	.max_register = 0x18b4,
> +};
> +
> +static int hdptx_write(struct rockchip_hdptx_phy *hdptx, u32 reg, u8 val)
> +{
> +	return regmap_write(hdptx->regmap, reg, val);
> +}
> +
> +static int hdptx_update_bits(struct rockchip_hdptx_phy *hdptx, u32 reg,
> +			     u8 mask, u8 val)
> +{
> +	return regmap_update_bits(hdptx->regmap, reg, mask, val);
> +}
> +
> +static int hdptx_grf_write(struct rockchip_hdptx_phy *hdptx, u32 reg, u32 val)
> +{
> +	return regmap_write(hdptx->grf, reg, val);
> +}
> +
> +static u8 hdptx_grf_read(struct rockchip_hdptx_phy *hdptx, u32 reg)
> +{
> +	u32 val;
> +
> +	regmap_read(hdptx->grf, reg, &val);
> +
> +	return val;
> +}
> +
> +static void hdptx_pre_power_up(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +
> +	reset_control_assert(hdptx->rsts[RST_APB].rstc);
> +	usleep_range(20, 25);
> +	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
> +
> +	reset_control_assert(hdptx->rsts[RST_LANE].rstc);
> +	reset_control_assert(hdptx->rsts[RST_CMN].rstc);
> +	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
> +
> +	val = (HDPTX_I_PLL_EN | HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +}
> +
> +static int hdptx_post_enable_lane(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	reset_control_deassert(hdptx->rsts[RST_LANE].rstc);
> +
> +	val = (HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16 |
> +	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
> +				       (val & HDPTX_O_PHY_RDY) &&
> +				       (val & HDPTX_O_PLL_LOCK_DONE),
> +				       100, 5000);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to get PHY lane lock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(hdptx->dev, "PHY lane locked\n");
> +
> +	return 0;
> +}
> +
> +static int hdptx_post_enable_pll(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = (HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16 |
> +	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	usleep_range(10, 15);
> +	reset_control_deassert(hdptx->rsts[RST_INIT].rstc);
> +
> +	usleep_range(10, 15);
> +	val = HDPTX_I_PLL_EN << 16 | HDPTX_I_PLL_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	usleep_range(10, 15);
> +	reset_control_deassert(hdptx->rsts[RST_CMN].rstc);
> +
> +	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
> +				       val & HDPTX_O_PHY_CLK_RDY, 20, 400);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to get PHY clk ready: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(hdptx->dev, "PHY clk ready\n");
> +
> +	return 0;
> +}
> +
> +static int hdptx_post_power_up(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = (HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16 |
> +	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	usleep_range(10, 15);
> +	reset_control_deassert(hdptx->rsts[RST_INIT].rstc);
> +
> +	usleep_range(10, 15);
> +	val = HDPTX_I_PLL_EN << 16 | HDPTX_I_PLL_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	usleep_range(10, 15);
> +	reset_control_deassert(hdptx->rsts[RST_CMN].rstc);
> +
> +	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
> +				       val & HDPTX_O_PLL_LOCK_DONE, 20, 400);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to get PHY PLL lock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_LANE].rstc);
> +
> +	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
> +				       val & HDPTX_O_PHY_RDY, 100, 5000);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to get PHY ready: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(hdptx->dev, "PHY ready\n");
> +
> +	return 0;
> +}
> +
> +static void hdptx_phy_disable(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +
> +	/* reset phy and apb, or phy locked flag may keep 1 */
> +	reset_control_assert(hdptx->rsts[RST_PHY].rstc);
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_PHY].rstc);
> +
> +	reset_control_assert(hdptx->rsts[RST_APB].rstc);
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
> +
> +	hdptx_write(hdptx, LANE_REG0300, 0x82);
> +	hdptx_write(hdptx, SB_REG010F, 0xc1);
> +	hdptx_write(hdptx, SB_REG0110, 0x1);
> +	hdptx_write(hdptx, LANE_REG0301, 0x80);
> +	hdptx_write(hdptx, LANE_REG0401, 0x80);
> +	hdptx_write(hdptx, LANE_REG0501, 0x80);
> +	hdptx_write(hdptx, LANE_REG0601, 0x80);
> +
> +	reset_control_assert(hdptx->rsts[RST_LANE].rstc);
> +	reset_control_assert(hdptx->rsts[RST_CMN].rstc);
> +	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
> +
> +	val = (HDPTX_I_PLL_EN | HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +}
> +
> +static void hdptx_earc_config(struct rockchip_hdptx_phy *hdptx)
> +{
> +	hdptx_update_bits(hdptx, SB_REG0113, SB_RX_RCAL_OPT_CODE_MASK,
> +			  FIELD_PREP(SB_RX_RCAL_OPT_CODE_MASK, 1));
> +	hdptx_write(hdptx, SB_REG011C, 0x04);
> +	hdptx_update_bits(hdptx, SB_REG011B, SB_AFC_TOL_MASK,
> +			  FIELD_PREP(SB_AFC_TOL_MASK, 3));
> +	hdptx_write(hdptx, SB_REG0109, 0x05);
> +
> +	hdptx_update_bits(hdptx, SB_REG0120,
> +			  SB_EARC_EN_MASK | SB_EARC_AFC_EN_MASK,
> +			  FIELD_PREP(SB_EARC_EN_MASK, 1) |
> +			  FIELD_PREP(SB_EARC_AFC_EN_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG011B, SB_EARC_SIG_DET_BYPASS_MASK,
> +			  FIELD_PREP(SB_EARC_SIG_DET_BYPASS_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG011F,
> +			  SB_PWM_AFC_CTRL_MASK | SB_RCAL_RSTN_MASK,
> +			  FIELD_PREP(SB_PWM_AFC_CTRL_MASK, 0xc) |
> +			  FIELD_PREP(SB_RCAL_RSTN_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG0115, SB_READY_DELAY_TIME_MASK,
> +			  FIELD_PREP(SB_READY_DELAY_TIME_MASK, 2));
> +	hdptx_update_bits(hdptx, SB_REG0113, SB_RX_RTERM_CTRL_MASK,
> +			  FIELD_PREP(SB_RX_RTERM_CTRL_MASK, 3));
> +	hdptx_update_bits(hdptx, SB_REG0102, ANA_SB_RXTERM_OFFSP_MASK,
> +			  FIELD_PREP(ANA_SB_RXTERM_OFFSP_MASK, 3));
> +	hdptx_update_bits(hdptx, SB_REG0103, ANA_SB_RXTERM_OFFSN_MASK,
> +			  FIELD_PREP(ANA_SB_RXTERM_OFFSN_MASK, 3));
> +
> +	hdptx_write(hdptx, SB_REG011A, 0x03);
> +	hdptx_write(hdptx, SB_REG0118, 0x0a);
> +	hdptx_write(hdptx, SB_REG011E, 0x6a);
> +	hdptx_write(hdptx, SB_REG011D, 0x67);
> +
> +	hdptx_update_bits(hdptx, SB_REG0117, FAST_PULSE_TIME_MASK,
> +			  FIELD_PREP(FAST_PULSE_TIME_MASK, 4));
> +	hdptx_update_bits(hdptx, SB_REG0114,
> +			  SB_TG_SB_EN_DELAY_TIME_MASK | SB_TG_RXTERM_EN_DELAY_TIME_MASK,
> +			  FIELD_PREP(SB_TG_SB_EN_DELAY_TIME_MASK, 2) |
> +			  FIELD_PREP(SB_TG_RXTERM_EN_DELAY_TIME_MASK, 2));
> +	hdptx_update_bits(hdptx, SB_REG0105, ANA_SB_TX_HLVL_PROG_MASK,
> +			  FIELD_PREP(ANA_SB_TX_HLVL_PROG_MASK, 7));
> +	hdptx_update_bits(hdptx, SB_REG0106, ANA_SB_TX_LLVL_PROG_MASK,
> +			  FIELD_PREP(ANA_SB_TX_LLVL_PROG_MASK, 7));
> +	hdptx_update_bits(hdptx, SB_REG010F, ANA_SB_VREG_GAIN_CTRL_MASK,
> +			  FIELD_PREP(ANA_SB_VREG_GAIN_CTRL_MASK, 0));
> +	hdptx_update_bits(hdptx, SB_REG0110, ANA_SB_VREG_REF_SEL_MASK,
> +			  FIELD_PREP(ANA_SB_VREG_REF_SEL_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG0115, SB_TG_OSC_EN_DELAY_TIME_MASK,
> +			  FIELD_PREP(SB_TG_OSC_EN_DELAY_TIME_MASK, 2));
> +	hdptx_update_bits(hdptx, SB_REG0116, AFC_RSTN_DELAY_TIME_MASK,
> +			  FIELD_PREP(AFC_RSTN_DELAY_TIME_MASK, 2));
> +	hdptx_update_bits(hdptx, SB_REG0109, ANA_SB_DMRX_AFC_DIV_RATIO_MASK,
> +			  FIELD_PREP(ANA_SB_DMRX_AFC_DIV_RATIO_MASK, 5));
> +	hdptx_update_bits(hdptx, SB_REG0103, OVRD_SB_RX_RESCAL_DONE_MASK,
> +			  FIELD_PREP(OVRD_SB_RX_RESCAL_DONE_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG0104, OVRD_SB_EN_MASK,
> +			  FIELD_PREP(OVRD_SB_EN_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG0102, OVRD_SB_RXTERM_EN_MASK,
> +			  FIELD_PREP(OVRD_SB_RXTERM_EN_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG0105, OVRD_SB_EARC_CMDC_EN_MASK,
> +			  FIELD_PREP(OVRD_SB_EARC_CMDC_EN_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG010F,
> +			  OVRD_SB_VREG_EN_MASK | OVRD_SB_VREG_LPF_BYPASS_MASK,
> +			  FIELD_PREP(OVRD_SB_VREG_EN_MASK, 1) |
> +			  FIELD_PREP(OVRD_SB_VREG_LPF_BYPASS_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG0123, OVRD_SB_READY_MASK,
> +			  FIELD_PREP(OVRD_SB_READY_MASK, 1));
> +
> +	usleep_range(1000, 1100);
> +	hdptx_update_bits(hdptx, SB_REG0103, SB_RX_RESCAL_DONE_MASK,
> +			  FIELD_PREP(SB_RX_RESCAL_DONE_MASK, 1));
> +	usleep_range(50, 60);
> +	hdptx_update_bits(hdptx, SB_REG0104, SB_EN_MASK,
> +			  FIELD_PREP(SB_EN_MASK, 1));
> +	usleep_range(50, 60);
> +	hdptx_update_bits(hdptx, SB_REG0102, SB_RXTERM_EN_MASK,
> +			  FIELD_PREP(SB_RXTERM_EN_MASK, 1));
> +	usleep_range(50, 60);
> +	hdptx_update_bits(hdptx, SB_REG0105, SB_EARC_CMDC_EN_MASK,
> +			  FIELD_PREP(SB_EARC_CMDC_EN_MASK, 1));
> +	hdptx_update_bits(hdptx, SB_REG010F, SB_VREG_EN_MASK,
> +			  FIELD_PREP(SB_VREG_EN_MASK, 1));
> +	usleep_range(50, 60);
> +	hdptx_update_bits(hdptx, SB_REG010F, OVRD_SB_VREG_LPF_BYPASS_MASK,
> +			  FIELD_PREP(OVRD_SB_VREG_LPF_BYPASS_MASK, 1));
> +	usleep_range(250, 300);
> +	hdptx_update_bits(hdptx, SB_REG010F, OVRD_SB_VREG_LPF_BYPASS_MASK,
> +			  FIELD_PREP(OVRD_SB_VREG_LPF_BYPASS_MASK, 0));
> +	usleep_range(100, 120);
> +	hdptx_update_bits(hdptx, SB_REG0123, SB_READY_MASK,
> +			  FIELD_PREP(SB_READY_MASK, 1));
> +}
> +
> +static bool hdptx_phy_clk_pll_calc(unsigned int data_rate,
> +				   struct ropll_config *cfg)
> +{
> +	unsigned int fref = 24000;
> +	unsigned int sdc;
> +	unsigned int fout = data_rate / 2;
> +	unsigned int fvco;
> +	u32 mdiv, sdiv, n = 8;
> +	unsigned long k = 0, lc, k_sub, lc_sub;
> +
> +	for (sdiv = 16; sdiv >= 1; sdiv--) {
> +		if (sdiv % 2 && sdiv != 1)
> +			continue;
> +
> +		fvco = fout * sdiv;
> +
> +		if (fvco < 2000000 || fvco > 4000000)
> +			continue;
> +
> +		mdiv = DIV_ROUND_UP(fvco, fref);
> +		if (mdiv < 20 || mdiv > 255)
> +			continue;
> +
> +		if (fref * mdiv - fvco) {
> +			for (sdc = 264000; sdc <= 750000; sdc += fref)
> +				if (sdc * n > fref * mdiv)
> +					break;
> +
> +			if (sdc > 750000)
> +				continue;
> +
> +			rational_best_approximation(fref * mdiv - fvco,
> +						    sdc / 16,
> +						    GENMASK(6, 0),
> +						    GENMASK(7, 0),
> +						    &k, &lc);
> +
> +			rational_best_approximation(sdc * n - fref * mdiv,
> +						    sdc,
> +						    GENMASK(6, 0),
> +						    GENMASK(7, 0),
> +						    &k_sub, &lc_sub);
> +		}
> +
> +		break;
> +	}
> +
> +	if (sdiv < 1)
> +		return false;
> +
> +	if (cfg) {
> +		cfg->pms_mdiv = mdiv;
> +		cfg->pms_mdiv_afc = mdiv;
> +		cfg->pms_pdiv = 1;
> +		cfg->pms_refdiv = 1;
> +		cfg->pms_sdiv = sdiv - 1;
> +
> +		cfg->sdm_en = k > 0 ? 1 : 0;
> +		if (cfg->sdm_en) {
> +			cfg->sdm_deno = lc;
> +			cfg->sdm_num_sign = 1;
> +			cfg->sdm_num = k;
> +			cfg->sdc_n = n - 3;
> +			cfg->sdc_num = k_sub;
> +			cfg->sdc_deno = lc_sub;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static int hdptx_ropll_cmn_config(struct rockchip_hdptx_phy *hdptx,
> +				  unsigned long bit_rate)
> +{
> +	int bus_width = phy_get_bus_width(hdptx->phy);
> +	u8 color_depth = (bus_width & COLOR_DEPTH_MASK) ? 1 : 0;
> +	const struct ropll_config *cfg = ropll_tmds_cfg;
> +	struct ropll_config rc = {0};
> +
> +	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%lu\n",
> +		__func__, bus_width, bit_rate);
> +
> +	if (color_depth)
> +		bit_rate = bit_rate * 10 / 8;
> +
> +	for (; cfg->bit_rate != ~0; cfg++)
> +		if (bit_rate == cfg->bit_rate)
> +			break;
> +
> +	if (cfg->bit_rate == ~0) {
> +		if (hdptx_phy_clk_pll_calc(bit_rate, &rc)) {
> +			cfg = &rc;
> +		} else {
> +			dev_err(hdptx->dev, "%s cannot find pll cfg\n", __func__);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	dev_dbg(hdptx->dev, "mdiv=%u, sdiv=%u, sdm_en=%u, k_sign=%u, k=%u, lc=%u\n",
> +		cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
> +		cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
> +
> +	hdptx_pre_power_up(hdptx);
> +
> +	reset_control_assert(hdptx->rsts[RST_ROPLL].rstc);
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_ROPLL].rstc);
> +
> +	hdptx_write(hdptx, CMN_REG0008, 0x00);
> +	hdptx_write(hdptx, CMN_REG0009, 0x0c);
> +	hdptx_write(hdptx, CMN_REG000A, 0x83);
> +	hdptx_write(hdptx, CMN_REG000B, 0x06);
> +	hdptx_write(hdptx, CMN_REG000C, 0x20);
> +	hdptx_write(hdptx, CMN_REG000D, 0xb8);
> +	hdptx_write(hdptx, CMN_REG000E, 0x0f);
> +	hdptx_write(hdptx, CMN_REG000F, 0x0f);
> +	hdptx_write(hdptx, CMN_REG0010, 0x04);
> +	hdptx_write(hdptx, CMN_REG0011, 0x01);
> +	hdptx_write(hdptx, CMN_REG0012, 0x26);
> +	hdptx_write(hdptx, CMN_REG0013, 0x22);
> +	hdptx_write(hdptx, CMN_REG0014, 0x24);
> +	hdptx_write(hdptx, CMN_REG0015, 0x77);
> +	hdptx_write(hdptx, CMN_REG0016, 0x08);
> +	hdptx_write(hdptx, CMN_REG0017, 0x20);
> +	hdptx_write(hdptx, CMN_REG0018, 0x04);
> +	hdptx_write(hdptx, CMN_REG0019, 0x48);
> +	hdptx_write(hdptx, CMN_REG001A, 0x01);
> +	hdptx_write(hdptx, CMN_REG001B, 0x00);
> +	hdptx_write(hdptx, CMN_REG001C, 0x01);
> +	hdptx_write(hdptx, CMN_REG001D, 0x64);
> +	hdptx_write(hdptx, CMN_REG001E, 0x14);
> +	hdptx_write(hdptx, CMN_REG001F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0020, 0x00);
> +	hdptx_write(hdptx, CMN_REG0021, 0x00);
> +	hdptx_write(hdptx, CMN_REG0022, 0x11);
> +	hdptx_write(hdptx, CMN_REG0023, 0x00);
> +	hdptx_write(hdptx, CMN_REG0024, 0x00);
> +	hdptx_write(hdptx, CMN_REG0025, 0x53);
> +	hdptx_write(hdptx, CMN_REG0026, 0x00);
> +	hdptx_write(hdptx, CMN_REG0027, 0x00);
> +	hdptx_write(hdptx, CMN_REG0028, 0x01);
> +	hdptx_write(hdptx, CMN_REG0029, 0x01);
> +	hdptx_write(hdptx, CMN_REG002A, 0x00);
> +	hdptx_write(hdptx, CMN_REG002B, 0x00);
> +	hdptx_write(hdptx, CMN_REG002C, 0x00);
> +	hdptx_write(hdptx, CMN_REG002D, 0x00);
> +	hdptx_write(hdptx, CMN_REG002E, 0x04);
> +	hdptx_write(hdptx, CMN_REG002F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0030, 0x20);
> +	hdptx_write(hdptx, CMN_REG0031, 0x30);
> +	hdptx_write(hdptx, CMN_REG0032, 0x0b);
> +	hdptx_write(hdptx, CMN_REG0033, 0x23);
> +	hdptx_write(hdptx, CMN_REG0034, 0x00);
> +	hdptx_write(hdptx, CMN_REG0035, 0x00);
> +	hdptx_write(hdptx, CMN_REG0038, 0x00);
> +	hdptx_write(hdptx, CMN_REG0039, 0x00);
> +	hdptx_write(hdptx, CMN_REG003A, 0x00);
> +	hdptx_write(hdptx, CMN_REG003B, 0x00);
> +	hdptx_write(hdptx, CMN_REG003C, 0x80);
> +	hdptx_write(hdptx, CMN_REG003D, 0x40);
> +	hdptx_write(hdptx, CMN_REG003E, 0x0c);
> +	hdptx_write(hdptx, CMN_REG003F, 0x83);
> +	hdptx_write(hdptx, CMN_REG0040, 0x06);
> +	hdptx_write(hdptx, CMN_REG0041, 0x20);
> +	hdptx_write(hdptx, CMN_REG0042, 0x78);
> +	hdptx_write(hdptx, CMN_REG0043, 0x00);
> +	hdptx_write(hdptx, CMN_REG0044, 0x46);
> +	hdptx_write(hdptx, CMN_REG0045, 0x24);
> +	hdptx_write(hdptx, CMN_REG0046, 0xff);
> +	hdptx_write(hdptx, CMN_REG0047, 0x00);
> +	hdptx_write(hdptx, CMN_REG0048, 0x44);
> +	hdptx_write(hdptx, CMN_REG0049, 0xfa);
> +	hdptx_write(hdptx, CMN_REG004A, 0x08);
> +	hdptx_write(hdptx, CMN_REG004B, 0x00);
> +	hdptx_write(hdptx, CMN_REG004C, 0x01);
> +	hdptx_write(hdptx, CMN_REG004D, 0x64);
> +	hdptx_write(hdptx, CMN_REG004E, 0x34);
> +	hdptx_write(hdptx, CMN_REG004F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0050, 0x00);
> +
> +	hdptx_write(hdptx, CMN_REG0051, cfg->pms_mdiv);
> +	hdptx_write(hdptx, CMN_REG0055, cfg->pms_mdiv_afc);
> +
> +	hdptx_write(hdptx, CMN_REG0059, (cfg->pms_pdiv << 4) | cfg->pms_refdiv);
> +
> +	hdptx_write(hdptx, CMN_REG005A, (cfg->pms_sdiv << 4));
> +
> +	hdptx_write(hdptx, CMN_REG005C, 0x25);
> +	hdptx_write(hdptx, CMN_REG005D, 0x0c);
> +	hdptx_write(hdptx, CMN_REG005E, 0x4f);
> +	hdptx_update_bits(hdptx, CMN_REG005E, ROPLL_SDM_EN_MASK,
> +			  FIELD_PREP(ROPLL_SDM_EN_MASK, cfg->sdm_en));
> +	if (!cfg->sdm_en)
> +		hdptx_update_bits(hdptx, CMN_REG005E, 0xf, 0);
> +
> +	hdptx_write(hdptx, CMN_REG005F, 0x01);
> +
> +	hdptx_update_bits(hdptx, CMN_REG0064, ROPLL_SDM_NUM_SIGN_RBR_MASK,
> +			  FIELD_PREP(ROPLL_SDM_NUM_SIGN_RBR_MASK, cfg->sdm_num_sign));
> +	hdptx_write(hdptx, CMN_REG0065, cfg->sdm_num);
> +	hdptx_write(hdptx, CMN_REG0060, cfg->sdm_deno);
> +
> +	hdptx_update_bits(hdptx, CMN_REG0069, ROPLL_SDC_N_RBR_MASK,
> +			  FIELD_PREP(ROPLL_SDC_N_RBR_MASK, cfg->sdc_n));
> +
> +	hdptx_write(hdptx, CMN_REG006C, cfg->sdc_num);
> +	hdptx_write(hdptx, CMN_REG0070, cfg->sdc_deno);
> +
> +	hdptx_write(hdptx, CMN_REG006B, 0x04);
> +
> +	hdptx_write(hdptx, CMN_REG0073, 0x30);
> +	hdptx_write(hdptx, CMN_REG0074, 0x04);
> +	hdptx_write(hdptx, CMN_REG0075, 0x20);
> +	hdptx_write(hdptx, CMN_REG0076, 0x30);
> +	hdptx_write(hdptx, CMN_REG0077, 0x08);
> +	hdptx_write(hdptx, CMN_REG0078, 0x0c);
> +	hdptx_write(hdptx, CMN_REG0079, 0x00);
> +	hdptx_write(hdptx, CMN_REG007B, 0x00);
> +	hdptx_write(hdptx, CMN_REG007C, 0x00);
> +	hdptx_write(hdptx, CMN_REG007D, 0x00);
> +	hdptx_write(hdptx, CMN_REG007E, 0x00);
> +	hdptx_write(hdptx, CMN_REG007F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0080, 0x00);
> +	hdptx_write(hdptx, CMN_REG0081, 0x01);
> +	hdptx_write(hdptx, CMN_REG0082, 0x04);
> +	hdptx_write(hdptx, CMN_REG0083, 0x24);
> +	hdptx_write(hdptx, CMN_REG0084, 0x20);
> +	hdptx_write(hdptx, CMN_REG0085, 0x03);
> +
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_POSTDIV_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
> +
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_CLK_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_CLK_SEL_MASK, color_depth));
> +
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_CLK_EN, PLL_PCG_CLK_EN);
> +
> +	hdptx_write(hdptx, CMN_REG0087, 0x04);
> +	hdptx_write(hdptx, CMN_REG0089, 0x00);
> +	hdptx_write(hdptx, CMN_REG008A, 0x55);
> +	hdptx_write(hdptx, CMN_REG008B, 0x25);
> +	hdptx_write(hdptx, CMN_REG008C, 0x2c);
> +	hdptx_write(hdptx, CMN_REG008D, 0x22);
> +	hdptx_write(hdptx, CMN_REG008E, 0x14);
> +	hdptx_write(hdptx, CMN_REG008F, 0x20);
> +	hdptx_write(hdptx, CMN_REG0090, 0x00);
> +	hdptx_write(hdptx, CMN_REG0091, 0x00);
> +	hdptx_write(hdptx, CMN_REG0092, 0x00);
> +	hdptx_write(hdptx, CMN_REG0093, 0x00);
> +	hdptx_write(hdptx, CMN_REG0095, 0x00);
> +	hdptx_write(hdptx, CMN_REG0097, 0x02);
> +	hdptx_write(hdptx, CMN_REG0099, 0x04);
> +	hdptx_write(hdptx, CMN_REG009A, 0x11);
> +	hdptx_write(hdptx, CMN_REG009B, 0x00);
> +
> +	return hdptx_post_enable_pll(hdptx);
> +}
> +
> +static int hdptx_ropll_tmds_mode_config(struct rockchip_hdptx_phy *hdptx,
> +					u32 rate)
> +{
> +	u32 bit_rate = rate & DATA_RATE_MASK;
> +
> +	if (!(hdptx_grf_read(hdptx, GRF_HDPTX_STATUS) & HDPTX_O_PLL_LOCK_DONE)) {
> +		int ret;
> +
> +		ret = hdptx_ropll_cmn_config(hdptx, bit_rate);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	hdptx_write(hdptx, SB_REG0114, 0x00);
> +	hdptx_write(hdptx, SB_REG0115, 0x00);
> +	hdptx_write(hdptx, SB_REG0116, 0x00);
> +	hdptx_write(hdptx, SB_REG0117, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0200, 0x06);
> +
> +	if (bit_rate >= 3400000) {
> +		/* For 1/40 bitrate clk */
> +		hdptx_write(hdptx, LNTOP_REG0201, 0x00);
> +		hdptx_write(hdptx, LNTOP_REG0202, 0x00);
> +		hdptx_write(hdptx, LNTOP_REG0203, 0x0f);
> +		hdptx_write(hdptx, LNTOP_REG0204, 0xff);
> +		hdptx_write(hdptx, LNTOP_REG0205, 0xff);
> +	} else {
> +		/* For 1/10 bitrate clk */
> +		hdptx_write(hdptx, LNTOP_REG0201, 0x07);
> +		hdptx_write(hdptx, LNTOP_REG0202, 0xc1);
> +		hdptx_write(hdptx, LNTOP_REG0203, 0xf0);
> +		hdptx_write(hdptx, LNTOP_REG0204, 0x7c);
> +		hdptx_write(hdptx, LNTOP_REG0205, 0x1f);
> +	}
> +
> +	hdptx_write(hdptx, LNTOP_REG0206, 0x07);
> +	hdptx_write(hdptx, LNTOP_REG0207, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0303, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0307, 0x20);
> +	hdptx_write(hdptx, LANE_REG030A, 0x17);
> +	hdptx_write(hdptx, LANE_REG030B, 0x77);
> +	hdptx_write(hdptx, LANE_REG030C, 0x77);
> +	hdptx_write(hdptx, LANE_REG030D, 0x77);
> +	hdptx_write(hdptx, LANE_REG030E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0310, 0x03);
> +	hdptx_write(hdptx, LANE_REG0311, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0312, 0x00);
> +	hdptx_write(hdptx, LANE_REG0316, 0x02);
> +	hdptx_write(hdptx, LANE_REG031B, 0x01);
> +	hdptx_write(hdptx, LANE_REG031E, 0x00);
> +	hdptx_write(hdptx, LANE_REG031F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0320, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0403, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0407, 0x20);
> +	hdptx_write(hdptx, LANE_REG040A, 0x17);
> +	hdptx_write(hdptx, LANE_REG040B, 0x77);
> +	hdptx_write(hdptx, LANE_REG040C, 0x77);
> +	hdptx_write(hdptx, LANE_REG040D, 0x77);
> +	hdptx_write(hdptx, LANE_REG040E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0410, 0x03);
> +	hdptx_write(hdptx, LANE_REG0411, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0412, 0x00);
> +	hdptx_write(hdptx, LANE_REG0416, 0x02);
> +	hdptx_write(hdptx, LANE_REG041B, 0x01);
> +	hdptx_write(hdptx, LANE_REG041E, 0x00);
> +	hdptx_write(hdptx, LANE_REG041F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0420, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0503, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0507, 0x20);
> +	hdptx_write(hdptx, LANE_REG050A, 0x17);
> +	hdptx_write(hdptx, LANE_REG050B, 0x77);
> +	hdptx_write(hdptx, LANE_REG050C, 0x77);
> +	hdptx_write(hdptx, LANE_REG050D, 0x77);
> +	hdptx_write(hdptx, LANE_REG050E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0510, 0x03);
> +	hdptx_write(hdptx, LANE_REG0511, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0512, 0x00);
> +	hdptx_write(hdptx, LANE_REG0516, 0x02);
> +	hdptx_write(hdptx, LANE_REG051B, 0x01);
> +	hdptx_write(hdptx, LANE_REG051E, 0x00);
> +	hdptx_write(hdptx, LANE_REG051F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0520, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0603, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0607, 0x20);
> +	hdptx_write(hdptx, LANE_REG060A, 0x17);
> +	hdptx_write(hdptx, LANE_REG060B, 0x77);
> +	hdptx_write(hdptx, LANE_REG060C, 0x77);
> +	hdptx_write(hdptx, LANE_REG060D, 0x77);
> +	hdptx_write(hdptx, LANE_REG060E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0610, 0x03);
> +	hdptx_write(hdptx, LANE_REG0611, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0612, 0x00);
> +	hdptx_write(hdptx, LANE_REG0616, 0x02);
> +	hdptx_write(hdptx, LANE_REG061B, 0x01);
> +	hdptx_write(hdptx, LANE_REG061E, 0x08);
> +	hdptx_write(hdptx, LANE_REG061F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0620, 0xa0);
> +
> +	hdptx_write(hdptx, LANE_REG0303, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0403, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0503, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0603, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0305, 0x03);
> +	hdptx_write(hdptx, LANE_REG0405, 0x03);
> +	hdptx_write(hdptx, LANE_REG0505, 0x03);
> +	hdptx_write(hdptx, LANE_REG0605, 0x03);
> +	hdptx_write(hdptx, LANE_REG0306, 0x1c);
> +	hdptx_write(hdptx, LANE_REG0406, 0x1c);
> +	hdptx_write(hdptx, LANE_REG0506, 0x1c);
> +	hdptx_write(hdptx, LANE_REG0606, 0x1c);
> +
> +	if (hdptx->earc_en)
> +		hdptx_earc_config(hdptx);
> +
> +	return hdptx_post_enable_lane(hdptx);
> +}
> +
> +static int hdptx_ropll_frl_mode_config(struct rockchip_hdptx_phy *hdptx,
> +				       u32 rate)
> +{
> +	u32 bit_rate = rate & DATA_RATE_MASK;
> +	u8 color_depth = (rate & COLOR_DEPTH_MASK) ? 1 : 0;
> +	const struct ropll_config *cfg = ropll_frl_cfg;
> +
> +	for (; cfg->bit_rate != ~0; cfg++)
> +		if (bit_rate == cfg->bit_rate)
> +			break;
> +
> +	if (cfg->bit_rate == ~0) {
> +		dev_err(hdptx->dev, "%s cannot find pll cfg\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	hdptx_pre_power_up(hdptx);
> +
> +	reset_control_assert(hdptx->rsts[RST_ROPLL].rstc);
> +	usleep_range(10, 20);
> +	reset_control_deassert(hdptx->rsts[RST_ROPLL].rstc);
> +
> +	hdptx_write(hdptx, CMN_REG0008, 0x00);
> +	hdptx_write(hdptx, CMN_REG0009, 0x0c);
> +	hdptx_write(hdptx, CMN_REG000A, 0x83);
> +	hdptx_write(hdptx, CMN_REG000B, 0x06);
> +	hdptx_write(hdptx, CMN_REG000C, 0x20);
> +	hdptx_write(hdptx, CMN_REG000D, 0xb8);
> +	hdptx_write(hdptx, CMN_REG000E, 0x0f);
> +	hdptx_write(hdptx, CMN_REG000F, 0x0f);
> +	hdptx_write(hdptx, CMN_REG0010, 0x04);
> +	hdptx_write(hdptx, CMN_REG0011, 0x00);
> +	hdptx_write(hdptx, CMN_REG0012, 0x26);
> +	hdptx_write(hdptx, CMN_REG0013, 0x22);
> +	hdptx_write(hdptx, CMN_REG0014, 0x24);
> +	hdptx_write(hdptx, CMN_REG0015, 0x77);
> +	hdptx_write(hdptx, CMN_REG0016, 0x08);
> +	hdptx_write(hdptx, CMN_REG0017, 0x00);
> +	hdptx_write(hdptx, CMN_REG0018, 0x04);
> +	hdptx_write(hdptx, CMN_REG0019, 0x48);
> +	hdptx_write(hdptx, CMN_REG001A, 0x01);
> +	hdptx_write(hdptx, CMN_REG001B, 0x00);
> +	hdptx_write(hdptx, CMN_REG001C, 0x01);
> +	hdptx_write(hdptx, CMN_REG001D, 0x64);
> +	hdptx_write(hdptx, CMN_REG001E, 0x14);
> +	hdptx_write(hdptx, CMN_REG001F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0020, 0x00);
> +	hdptx_write(hdptx, CMN_REG0021, 0x00);
> +	hdptx_write(hdptx, CMN_REG0022, 0x11);
> +	hdptx_write(hdptx, CMN_REG0023, 0x00);
> +	hdptx_write(hdptx, CMN_REG0025, 0x00);
> +	hdptx_write(hdptx, CMN_REG0026, 0x53);
> +	hdptx_write(hdptx, CMN_REG0027, 0x00);
> +	hdptx_write(hdptx, CMN_REG0028, 0x00);
> +	hdptx_write(hdptx, CMN_REG0029, 0x01);
> +	hdptx_write(hdptx, CMN_REG002A, 0x01);
> +	hdptx_write(hdptx, CMN_REG002B, 0x00);
> +	hdptx_write(hdptx, CMN_REG002C, 0x00);
> +	hdptx_write(hdptx, CMN_REG002D, 0x00);
> +	hdptx_write(hdptx, CMN_REG002E, 0x00);
> +	hdptx_write(hdptx, CMN_REG002F, 0x04);
> +	hdptx_write(hdptx, CMN_REG0030, 0x00);
> +	hdptx_write(hdptx, CMN_REG0031, 0x20);
> +	hdptx_write(hdptx, CMN_REG0032, 0x30);
> +	hdptx_write(hdptx, CMN_REG0033, 0x0b);
> +	hdptx_write(hdptx, CMN_REG0034, 0x23);
> +	hdptx_write(hdptx, CMN_REG0035, 0x00);
> +	hdptx_write(hdptx, CMN_REG0038, 0x00);
> +	hdptx_write(hdptx, CMN_REG0039, 0x00);
> +	hdptx_write(hdptx, CMN_REG003A, 0x00);
> +	hdptx_write(hdptx, CMN_REG003B, 0x00);
> +	hdptx_write(hdptx, CMN_REG003C, 0x80);
> +	hdptx_write(hdptx, CMN_REG003D, 0x40);
> +	hdptx_write(hdptx, CMN_REG003E, 0x0c);
> +	hdptx_write(hdptx, CMN_REG003F, 0x83);
> +	hdptx_write(hdptx, CMN_REG0040, 0x06);
> +	hdptx_write(hdptx, CMN_REG0041, 0x20);
> +	hdptx_write(hdptx, CMN_REG0042, 0xb8);
> +	hdptx_write(hdptx, CMN_REG0043, 0x00);
> +	hdptx_write(hdptx, CMN_REG0044, 0x46);
> +	hdptx_write(hdptx, CMN_REG0045, 0x24);
> +	hdptx_write(hdptx, CMN_REG0046, 0xff);
> +	hdptx_write(hdptx, CMN_REG0047, 0x00);
> +	hdptx_write(hdptx, CMN_REG0048, 0x44);
> +	hdptx_write(hdptx, CMN_REG0049, 0xfa);
> +	hdptx_write(hdptx, CMN_REG004A, 0x08);
> +	hdptx_write(hdptx, CMN_REG004B, 0x00);
> +	hdptx_write(hdptx, CMN_REG004C, 0x01);
> +	hdptx_write(hdptx, CMN_REG004D, 0x64);
> +	hdptx_write(hdptx, CMN_REG004E, 0x14);
> +	hdptx_write(hdptx, CMN_REG004F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0050, 0x00);
> +	hdptx_write(hdptx, CMN_REG0051, cfg->pms_mdiv);
> +	hdptx_write(hdptx, CMN_REG0055, cfg->pms_mdiv_afc);
> +	hdptx_write(hdptx, CMN_REG0059, (cfg->pms_pdiv << 4) | cfg->pms_refdiv);
> +	hdptx_write(hdptx, CMN_REG005A, (cfg->pms_sdiv << 4));
> +	hdptx_write(hdptx, CMN_REG005C, 0x25);
> +	hdptx_write(hdptx, CMN_REG005D, 0x0c);
> +	hdptx_update_bits(hdptx, CMN_REG005E, ROPLL_SDM_EN_MASK,
> +			  FIELD_PREP(ROPLL_SDM_EN_MASK, cfg->sdm_en));
> +	if (!cfg->sdm_en)
> +		hdptx_update_bits(hdptx, CMN_REG005E, 0xf, 0);
> +
> +	hdptx_write(hdptx, CMN_REG005F, 0x01);
> +	hdptx_update_bits(hdptx, CMN_REG0064, ROPLL_SDM_NUM_SIGN_RBR_MASK,
> +			  FIELD_PREP(ROPLL_SDM_NUM_SIGN_RBR_MASK, cfg->sdm_num_sign));
> +	hdptx_write(hdptx, CMN_REG0065, cfg->sdm_num);
> +	hdptx_write(hdptx, CMN_REG0060, cfg->sdm_deno);
> +	hdptx_update_bits(hdptx, CMN_REG0069, ROPLL_SDC_N_RBR_MASK,
> +			  FIELD_PREP(ROPLL_SDC_N_RBR_MASK, cfg->sdc_n));
> +
> +	hdptx_write(hdptx, CMN_REG006C, cfg->sdc_num);
> +	hdptx_write(hdptx, CMN_REG0070, cfg->sdc_deno);
> +	hdptx_write(hdptx, CMN_REG006B, 0x04);
> +	hdptx_write(hdptx, CMN_REG0073, 0x30);
> +	hdptx_write(hdptx, CMN_REG0074, 0x00);
> +	hdptx_write(hdptx, CMN_REG0075, 0x20);
> +	hdptx_write(hdptx, CMN_REG0076, 0x30);
> +	hdptx_write(hdptx, CMN_REG0077, 0x08);
> +	hdptx_write(hdptx, CMN_REG0078, 0x0c);
> +	hdptx_write(hdptx, CMN_REG0079, 0x00);
> +	hdptx_write(hdptx, CMN_REG007B, 0x00);
> +	hdptx_write(hdptx, CMN_REG007C, 0x00);
> +	hdptx_write(hdptx, CMN_REG007D, 0x00);
> +	hdptx_write(hdptx, CMN_REG007E, 0x00);
> +	hdptx_write(hdptx, CMN_REG007F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0080, 0x00);
> +	hdptx_write(hdptx, CMN_REG0081, 0x09);
> +	hdptx_write(hdptx, CMN_REG0082, 0x04);
> +	hdptx_write(hdptx, CMN_REG0083, 0x24);
> +	hdptx_write(hdptx, CMN_REG0084, 0x20);
> +	hdptx_write(hdptx, CMN_REG0085, 0x03);
> +	hdptx_write(hdptx, CMN_REG0086, 0x01);
> +
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_POSTDIV_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_CLK_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_CLK_SEL_MASK, color_depth));
> +
> +	hdptx_write(hdptx, CMN_REG0087, 0x0c);
> +	hdptx_write(hdptx, CMN_REG0089, 0x00);
> +	hdptx_write(hdptx, CMN_REG008A, 0x55);
> +	hdptx_write(hdptx, CMN_REG008B, 0x25);
> +	hdptx_write(hdptx, CMN_REG008C, 0x2c);
> +	hdptx_write(hdptx, CMN_REG008D, 0x22);
> +	hdptx_write(hdptx, CMN_REG008E, 0x14);
> +	hdptx_write(hdptx, CMN_REG008F, 0x20);
> +	hdptx_write(hdptx, CMN_REG0090, 0x00);
> +	hdptx_write(hdptx, CMN_REG0091, 0x00);
> +	hdptx_write(hdptx, CMN_REG0092, 0x00);
> +	hdptx_write(hdptx, CMN_REG0093, 0x00);
> +	hdptx_write(hdptx, CMN_REG0094, 0x00);
> +	hdptx_write(hdptx, CMN_REG0097, 0x02);
> +	hdptx_write(hdptx, CMN_REG0099, 0x04);
> +	hdptx_write(hdptx, CMN_REG009A, 0x11);
> +	hdptx_write(hdptx, CMN_REG009B, 0x10);
> +	hdptx_write(hdptx, SB_REG0114, 0x00);
> +	hdptx_write(hdptx, SB_REG0115, 0x00);
> +	hdptx_write(hdptx, SB_REG0116, 0x00);
> +	hdptx_write(hdptx, SB_REG0117, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0200, 0x04);
> +	hdptx_write(hdptx, LNTOP_REG0201, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0202, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0203, 0xf0);
> +	hdptx_write(hdptx, LNTOP_REG0204, 0xff);
> +	hdptx_write(hdptx, LNTOP_REG0205, 0xff);
> +	hdptx_write(hdptx, LNTOP_REG0206, 0x05);
> +	hdptx_write(hdptx, LNTOP_REG0207, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0303, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0307, 0x20);
> +	hdptx_write(hdptx, LANE_REG030A, 0x17);
> +	hdptx_write(hdptx, LANE_REG030B, 0x77);
> +	hdptx_write(hdptx, LANE_REG030C, 0x77);
> +	hdptx_write(hdptx, LANE_REG030D, 0x77);
> +	hdptx_write(hdptx, LANE_REG030E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0310, 0x03);
> +	hdptx_write(hdptx, LANE_REG0311, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0312, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0316, 0x02);
> +	hdptx_write(hdptx, LANE_REG031B, 0x01);
> +	hdptx_write(hdptx, LANE_REG031F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0320, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0403, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0407, 0x20);
> +	hdptx_write(hdptx, LANE_REG040A, 0x17);
> +	hdptx_write(hdptx, LANE_REG040B, 0x77);
> +	hdptx_write(hdptx, LANE_REG040C, 0x77);
> +	hdptx_write(hdptx, LANE_REG040D, 0x77);
> +	hdptx_write(hdptx, LANE_REG040E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0410, 0x03);
> +	hdptx_write(hdptx, LANE_REG0411, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0412, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0416, 0x02);
> +	hdptx_write(hdptx, LANE_REG041B, 0x01);
> +	hdptx_write(hdptx, LANE_REG041F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0420, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0503, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0507, 0x20);
> +	hdptx_write(hdptx, LANE_REG050A, 0x17);
> +	hdptx_write(hdptx, LANE_REG050B, 0x77);
> +	hdptx_write(hdptx, LANE_REG050C, 0x77);
> +	hdptx_write(hdptx, LANE_REG050D, 0x77);
> +	hdptx_write(hdptx, LANE_REG050E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0510, 0x03);
> +	hdptx_write(hdptx, LANE_REG0511, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0512, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0516, 0x02);
> +	hdptx_write(hdptx, LANE_REG051B, 0x01);
> +	hdptx_write(hdptx, LANE_REG051F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0520, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0603, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0607, 0x20);
> +	hdptx_write(hdptx, LANE_REG060A, 0x17);
> +	hdptx_write(hdptx, LANE_REG060B, 0x77);
> +	hdptx_write(hdptx, LANE_REG060C, 0x77);
> +	hdptx_write(hdptx, LANE_REG060D, 0x77);
> +	hdptx_write(hdptx, LANE_REG060E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0610, 0x03);
> +	hdptx_write(hdptx, LANE_REG0611, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0612, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0616, 0x02);
> +	hdptx_write(hdptx, LANE_REG061B, 0x01);
> +	hdptx_write(hdptx, LANE_REG061F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0620, 0xa0);
> +
> +	if (hdptx->earc_en)
> +		hdptx_earc_config(hdptx);
> +
> +	return hdptx_post_power_up(hdptx);
> +}
> +
> +static int hdptx_lcpll_frl_mode_config(struct rockchip_hdptx_phy *hdptx,
> +				       u32 rate)
> +{
> +	u32 bit_rate = rate & DATA_RATE_MASK;
> +	u8 color_depth = (rate & COLOR_DEPTH_MASK) ? 1 : 0;
> +	const struct lcpll_config *cfg = lcpll_cfg;
> +
> +	for (; cfg->bit_rate != ~0; cfg++)
> +		if (bit_rate == cfg->bit_rate)
> +			break;
> +
> +	if (cfg->bit_rate == ~0)
> +		return -EINVAL;
> +
> +	hdptx_pre_power_up(hdptx);
> +
> +	hdptx_update_bits(hdptx, CMN_REG0008,
> +			  LCPLL_EN_MASK | LCPLL_LCVCO_MODE_EN_MASK,
> +			  FIELD_PREP(LCPLL_EN_MASK, 1) |
> +			  FIELD_PREP(LCPLL_LCVCO_MODE_EN_MASK, cfg->lcvco_mode_en));
> +
> +	hdptx_write(hdptx, CMN_REG0009, 0x0c);
> +	hdptx_write(hdptx, CMN_REG000A, 0x83);
> +	hdptx_write(hdptx, CMN_REG000B, 0x06);
> +	hdptx_write(hdptx, CMN_REG000C, 0x20);
> +	hdptx_write(hdptx, CMN_REG000D, 0xb8);
> +	hdptx_write(hdptx, CMN_REG000E, 0x0f);
> +	hdptx_write(hdptx, CMN_REG000F, 0x0f);
> +	hdptx_write(hdptx, CMN_REG0010, 0x04);
> +	hdptx_write(hdptx, CMN_REG0011, 0x00);
> +	hdptx_write(hdptx, CMN_REG0012, 0x26);
> +	hdptx_write(hdptx, CMN_REG0013, 0x22);
> +	hdptx_write(hdptx, CMN_REG0014, 0x24);
> +	hdptx_write(hdptx, CMN_REG0015, 0x77);
> +	hdptx_write(hdptx, CMN_REG0016, 0x08);
> +	hdptx_write(hdptx, CMN_REG0017, 0x00);
> +	hdptx_write(hdptx, CMN_REG0018, 0x04);
> +	hdptx_write(hdptx, CMN_REG0019, 0x48);
> +	hdptx_write(hdptx, CMN_REG001A, 0x01);
> +	hdptx_write(hdptx, CMN_REG001B, 0x00);
> +	hdptx_write(hdptx, CMN_REG001C, 0x01);
> +	hdptx_write(hdptx, CMN_REG001D, 0x64);
> +
> +	hdptx_update_bits(hdptx, CMN_REG001E,
> +			  LCPLL_PI_EN_MASK | LCPLL_100M_CLK_EN_MASK,
> +			  FIELD_PREP(LCPLL_PI_EN_MASK, cfg->pi_en) |
> +			  FIELD_PREP(LCPLL_100M_CLK_EN_MASK, cfg->clk_en_100m));
> +
> +	hdptx_write(hdptx, CMN_REG001F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0020, cfg->pms_mdiv);
> +	hdptx_write(hdptx, CMN_REG0021, cfg->pms_mdiv_afc);
> +	hdptx_write(hdptx, CMN_REG0022, (cfg->pms_pdiv << 4) | cfg->pms_refdiv);
> +	hdptx_write(hdptx, CMN_REG0023, (cfg->pms_sdiv << 4) | cfg->pms_sdiv);
> +	hdptx_write(hdptx, CMN_REG0025, 0x10);
> +	hdptx_write(hdptx, CMN_REG0026, 0x53);
> +	hdptx_write(hdptx, CMN_REG0027, 0x01);
> +	hdptx_write(hdptx, CMN_REG0028, 0x0d);
> +	hdptx_write(hdptx, CMN_REG0029, 0x01);
> +	hdptx_write(hdptx, CMN_REG002A, cfg->sdm_deno);
> +	hdptx_write(hdptx, CMN_REG002B, cfg->sdm_num_sign);
> +	hdptx_write(hdptx, CMN_REG002C, cfg->sdm_num);
> +
> +	hdptx_update_bits(hdptx, CMN_REG002D, LCPLL_SDC_N_MASK,
> +			  FIELD_PREP(LCPLL_SDC_N_MASK, cfg->sdc_n));
> +
> +	hdptx_write(hdptx, CMN_REG002E, 0x02);
> +	hdptx_write(hdptx, CMN_REG002F, 0x0d);
> +	hdptx_write(hdptx, CMN_REG0030, 0x00);
> +	hdptx_write(hdptx, CMN_REG0031, 0x20);
> +	hdptx_write(hdptx, CMN_REG0032, 0x30);
> +	hdptx_write(hdptx, CMN_REG0033, 0x0b);
> +	hdptx_write(hdptx, CMN_REG0034, 0x23);
> +	hdptx_write(hdptx, CMN_REG0035, 0x00);
> +	hdptx_write(hdptx, CMN_REG0038, 0x00);
> +	hdptx_write(hdptx, CMN_REG0039, 0x00);
> +	hdptx_write(hdptx, CMN_REG003A, 0x00);
> +	hdptx_write(hdptx, CMN_REG003B, 0x00);
> +	hdptx_write(hdptx, CMN_REG003C, 0x80);
> +	hdptx_write(hdptx, CMN_REG003D, 0x00);
> +	hdptx_write(hdptx, CMN_REG003E, 0x0c);
> +	hdptx_write(hdptx, CMN_REG003F, 0x83);
> +	hdptx_write(hdptx, CMN_REG0040, 0x06);
> +	hdptx_write(hdptx, CMN_REG0041, 0x20);
> +	hdptx_write(hdptx, CMN_REG0042, 0xb8);
> +	hdptx_write(hdptx, CMN_REG0043, 0x00);
> +	hdptx_write(hdptx, CMN_REG0044, 0x46);
> +	hdptx_write(hdptx, CMN_REG0045, 0x24);
> +	hdptx_write(hdptx, CMN_REG0046, 0xff);
> +	hdptx_write(hdptx, CMN_REG0047, 0x00);
> +	hdptx_write(hdptx, CMN_REG0048, 0x44);
> +	hdptx_write(hdptx, CMN_REG0049, 0xfa);
> +	hdptx_write(hdptx, CMN_REG004A, 0x08);
> +	hdptx_write(hdptx, CMN_REG004B, 0x00);
> +	hdptx_write(hdptx, CMN_REG004C, 0x01);
> +	hdptx_write(hdptx, CMN_REG004D, 0x64);
> +	hdptx_write(hdptx, CMN_REG004E, 0x14);
> +	hdptx_write(hdptx, CMN_REG004F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0050, 0x00);
> +	hdptx_write(hdptx, CMN_REG0051, 0x00);
> +	hdptx_write(hdptx, CMN_REG0055, 0x00);
> +	hdptx_write(hdptx, CMN_REG0059, 0x11);
> +	hdptx_write(hdptx, CMN_REG005A, 0x03);
> +	hdptx_write(hdptx, CMN_REG005C, 0x05);
> +	hdptx_write(hdptx, CMN_REG005D, 0x0c);
> +	hdptx_write(hdptx, CMN_REG005E, 0x07);
> +	hdptx_write(hdptx, CMN_REG005F, 0x01);
> +	hdptx_write(hdptx, CMN_REG0060, 0x01);
> +	hdptx_write(hdptx, CMN_REG0064, 0x07);
> +	hdptx_write(hdptx, CMN_REG0065, 0x00);
> +	hdptx_write(hdptx, CMN_REG0069, 0x00);
> +	hdptx_write(hdptx, CMN_REG006B, 0x04);
> +	hdptx_write(hdptx, CMN_REG006C, 0x00);
> +	hdptx_write(hdptx, CMN_REG0070, 0x01);
> +	hdptx_write(hdptx, CMN_REG0073, 0x30);
> +	hdptx_write(hdptx, CMN_REG0074, 0x00);
> +	hdptx_write(hdptx, CMN_REG0075, 0x20);
> +	hdptx_write(hdptx, CMN_REG0076, 0x30);
> +	hdptx_write(hdptx, CMN_REG0077, 0x08);
> +	hdptx_write(hdptx, CMN_REG0078, 0x0c);
> +	hdptx_write(hdptx, CMN_REG0079, 0x00);
> +	hdptx_write(hdptx, CMN_REG007B, 0x00);
> +	hdptx_write(hdptx, CMN_REG007C, 0x00);
> +	hdptx_write(hdptx, CMN_REG007D, 0x00);
> +	hdptx_write(hdptx, CMN_REG007E, 0x00);
> +	hdptx_write(hdptx, CMN_REG007F, 0x00);
> +	hdptx_write(hdptx, CMN_REG0080, 0x00);
> +	hdptx_write(hdptx, CMN_REG0081, 0x09);
> +	hdptx_write(hdptx, CMN_REG0082, 0x04);
> +	hdptx_write(hdptx, CMN_REG0083, 0x24);
> +	hdptx_write(hdptx, CMN_REG0084, 0x20);
> +	hdptx_write(hdptx, CMN_REG0085, 0x03);
> +	hdptx_write(hdptx, CMN_REG0086, 0x01);
> +
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_POSTDIV_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
> +	hdptx_update_bits(hdptx, CMN_REG0086, PLL_PCG_CLK_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_CLK_SEL_MASK, color_depth));
> +
> +	hdptx_write(hdptx, CMN_REG0087, 0x0c);
> +	hdptx_write(hdptx, CMN_REG0089, 0x02);
> +	hdptx_write(hdptx, CMN_REG008A, 0x55);
> +	hdptx_write(hdptx, CMN_REG008B, 0x25);
> +	hdptx_write(hdptx, CMN_REG008C, 0x2c);
> +	hdptx_write(hdptx, CMN_REG008D, 0x22);
> +	hdptx_write(hdptx, CMN_REG008E, 0x14);
> +	hdptx_write(hdptx, CMN_REG008F, 0x20);
> +	hdptx_write(hdptx, CMN_REG0090, 0x00);
> +	hdptx_write(hdptx, CMN_REG0091, 0x00);
> +	hdptx_write(hdptx, CMN_REG0092, 0x00);
> +	hdptx_write(hdptx, CMN_REG0093, 0x00);
> +	hdptx_write(hdptx, CMN_REG0095, 0x00);
> +	hdptx_write(hdptx, CMN_REG0097, 0x00);
> +	hdptx_write(hdptx, CMN_REG0099, 0x00);
> +	hdptx_write(hdptx, CMN_REG009A, 0x11);
> +	hdptx_write(hdptx, CMN_REG009B, 0x10);
> +	hdptx_write(hdptx, SB_REG0114, 0x00);
> +	hdptx_write(hdptx, SB_REG0115, 0x00);
> +	hdptx_write(hdptx, SB_REG0116, 0x00);
> +	hdptx_write(hdptx, SB_REG0117, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0200, 0x04);
> +	hdptx_write(hdptx, LNTOP_REG0201, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0202, 0x00);
> +	hdptx_write(hdptx, LNTOP_REG0203, 0xf0);
> +	hdptx_write(hdptx, LNTOP_REG0204, 0xff);
> +	hdptx_write(hdptx, LNTOP_REG0205, 0xff);
> +	hdptx_write(hdptx, LNTOP_REG0206, 0x05);
> +	hdptx_write(hdptx, LNTOP_REG0207, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0303, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0307, 0x20);
> +	hdptx_write(hdptx, LANE_REG030A, 0x17);
> +	hdptx_write(hdptx, LANE_REG030B, 0x77);
> +	hdptx_write(hdptx, LANE_REG030C, 0x77);
> +	hdptx_write(hdptx, LANE_REG030D, 0x77);
> +	hdptx_write(hdptx, LANE_REG030E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0310, 0x03);
> +	hdptx_write(hdptx, LANE_REG0311, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0312, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0316, 0x02);
> +	hdptx_write(hdptx, LANE_REG031B, 0x01);
> +	hdptx_write(hdptx, LANE_REG031F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0320, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0403, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0407, 0x20);
> +	hdptx_write(hdptx, LANE_REG040A, 0x17);
> +	hdptx_write(hdptx, LANE_REG040B, 0x77);
> +	hdptx_write(hdptx, LANE_REG040C, 0x77);
> +	hdptx_write(hdptx, LANE_REG040D, 0x77);
> +	hdptx_write(hdptx, LANE_REG040E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0410, 0x03);
> +	hdptx_write(hdptx, LANE_REG0411, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0412, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0416, 0x02);
> +	hdptx_write(hdptx, LANE_REG041B, 0x01);
> +	hdptx_write(hdptx, LANE_REG041F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0420, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0503, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0507, 0x20);
> +	hdptx_write(hdptx, LANE_REG050A, 0x17);
> +	hdptx_write(hdptx, LANE_REG050B, 0x77);
> +	hdptx_write(hdptx, LANE_REG050C, 0x77);
> +	hdptx_write(hdptx, LANE_REG050D, 0x77);
> +	hdptx_write(hdptx, LANE_REG050E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0510, 0x03);
> +	hdptx_write(hdptx, LANE_REG0511, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0512, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0516, 0x02);
> +	hdptx_write(hdptx, LANE_REG051B, 0x01);
> +	hdptx_write(hdptx, LANE_REG051F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0520, 0xa0);
> +	hdptx_write(hdptx, LANE_REG0603, 0x0c);
> +	hdptx_write(hdptx, LANE_REG0607, 0x20);
> +	hdptx_write(hdptx, LANE_REG060A, 0x17);
> +	hdptx_write(hdptx, LANE_REG060B, 0x77);
> +	hdptx_write(hdptx, LANE_REG060C, 0x77);
> +	hdptx_write(hdptx, LANE_REG060D, 0x77);
> +	hdptx_write(hdptx, LANE_REG060E, 0x38);
> +	hdptx_write(hdptx, LANE_REG0610, 0x03);
> +	hdptx_write(hdptx, LANE_REG0611, 0x0f);
> +	hdptx_write(hdptx, LANE_REG0612, 0x3c);
> +	hdptx_write(hdptx, LANE_REG0616, 0x02);
> +	hdptx_write(hdptx, LANE_REG061B, 0x01);
> +	hdptx_write(hdptx, LANE_REG061F, 0x15);
> +	hdptx_write(hdptx, LANE_REG0620, 0xa0);
> +
> +	hdptx_write(hdptx, LANE_REG0303, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0403, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0503, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0603, 0x2f);
> +	hdptx_write(hdptx, LANE_REG0305, 0x03);
> +	hdptx_write(hdptx, LANE_REG0405, 0x03);
> +	hdptx_write(hdptx, LANE_REG0505, 0x03);
> +	hdptx_write(hdptx, LANE_REG0605, 0x03);
> +	hdptx_write(hdptx, LANE_REG0306, 0xfc);
> +	hdptx_write(hdptx, LANE_REG0406, 0xfc);
> +	hdptx_write(hdptx, LANE_REG0506, 0xfc);
> +	hdptx_write(hdptx, LANE_REG0606, 0xfc);
> +
> +	hdptx_write(hdptx, LANE_REG0305, 0x4f);
> +	hdptx_write(hdptx, LANE_REG0405, 0x4f);
> +	hdptx_write(hdptx, LANE_REG0505, 0x4f);
> +	hdptx_write(hdptx, LANE_REG0605, 0x4f);
> +	hdptx_write(hdptx, LANE_REG0304, 0x14);
> +	hdptx_write(hdptx, LANE_REG0404, 0x14);
> +	hdptx_write(hdptx, LANE_REG0504, 0x14);
> +	hdptx_write(hdptx, LANE_REG0604, 0x14);
> +
> +	if (hdptx->earc_en)
> +		hdptx_earc_config(hdptx);
> +
> +	return hdptx_post_power_up(hdptx);
> +}
> +
> +static int rockchip_hdptx_phy_power_on(struct phy *phy)
> +{
> +	struct rockchip_hdptx_phy *hdptx = phy_get_drvdata(phy);
> +	int bus_width = phy_get_bus_width(hdptx->phy);
> +	int bit_rate = bus_width & DATA_RATE_MASK;
> +	int ret;
> +
> +	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%d\n",
> +		__func__, bus_width, bit_rate);
> +
> +	ret = pm_runtime_resume_and_get(hdptx->dev);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to resume phy: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (bus_width & HDMI_EARC_MASK)
> +		hdptx->earc_en = true;
> +	else
> +		hdptx->earc_en = false;
> +
> +	if (bus_width & HDMI_MODE_MASK) {

Here use phy->attrs.bus_width to indicate different work mode,
we also use the same in our bsp, but not sure if it is the appropriate way.


