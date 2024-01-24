Return-Path: <linux-kernel+bounces-36395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5C83A003
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D8BB25862
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2AE53A2;
	Wed, 24 Jan 2024 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QfH2Us9E"
Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com [45.254.49.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED846B4;
	Wed, 24 Jan 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066366; cv=none; b=lslZQMWJBqbGNg6OdxStGleXqDqbUQyDvrViCJacdlktrQOIURD92u5ibWek04f6IlYjl+zJ8rlHWdkj+IogdbZ//8fvTezz8jgiIC9FWouBPgkeHoq9dI6KJIFV81dfmdQiNkfb8fiDAEwPomvYn3MkX9KN1hUZxwyznvlmLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066366; c=relaxed/simple;
	bh=2Afcxvj7vwAOm7pIOzh9bPfEuegqAozbnRiCL18B2Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1PrUKCAznU2S/B55H6WP9lxNIO2FBMXmj4WzDZ0QKdjYiV90laf0SXrzPBd2xiH4j+4wlsr/ooWPXv10l9BR3pB+Le68BFF7/H/o0gWsvQAhvfDBUBezAjVAHcUBwWWkYwsYr9WcxVw9BzDyn7tedz6aNGSj/n1V15NWrWxTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QfH2Us9E; arc=none smtp.client-ip=45.254.49.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=QfH2Us9Eq8B0ueN4t3tCCXCgmbIqlFl7ZJymOQuLq7M9YeL9smUzrKpL905TUTtNqsltZOxtpgQpdHkuqvWUXq0CZPZmy8JLlcS1NlFLVNWSTCiKR0ghlYv2lzXt/RCUWBVgMKQx0A0tv8P0Ew9Cyzg2QyIlvURz7W7Yw0MY5Gg=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TAinrEkDcwYxgKcucbTjUS75lf3OZ7z9iVmkDRaZ18I=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 660777801C6;
	Wed, 24 Jan 2024 10:42:32 +0800 (CST)
Message-ID: <e1c56975-6a55-4b75-a447-dd2d0eec62e2@rock-chips.com>
Date: Wed, 24 Jan 2024 10:42:31 +0800
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
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Algea Cao <algea.cao@rock-chips.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Heiko Stuebner <heiko@sntech.de>
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
 <20240122121409.GW4700@pengutronix.de>
 <00c749f7-3eb9-4bd1-a057-43a692b77d68@collabora.com>
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <00c749f7-3eb9-4bd1-a057-43a692b77d68@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkIdTlZNHx9NTUxKTEJLTk9VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8d395908efb24fkuuu660777801c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6ORw*MzwtCAJMAxoCKRIz
	DU8aCwJVSlVKTEtNS01PSk5IT0xCVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBQ0NITDcG

Hi Cristian:

On 1/24/24 08:58, Cristian Ciocaltea wrote:
> On 1/22/24 14:14, Sascha Hauer wrote:
>> On Fri, Jan 19, 2024 at 09:38:03PM +0200, Cristian Ciocaltea wrote:
>>> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.
>>>
>>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>>> and eDP links.  The maximum data rate is 12Gbps (HDMI 2.1 FRL), while
>>> the minimum is 250Mbps (HDMI 2.1 TMDS).
>>>
>>> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
>>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>   drivers/phy/rockchip/Kconfig                  |    8 +
>>>   drivers/phy/rockchip/Makefile                 |    1 +
>>>   .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 2045 +++++++++++++++++
>>>   3 files changed, 2054 insertions(+)
>>>   create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>
>>> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
>>> index 94360fc96a6f..95666ac6aa3b 100644
>>> --- a/drivers/phy/rockchip/Kconfig
>>> +++ b/drivers/phy/rockchip/Kconfig
>>> @@ -83,6 +83,14 @@ config PHY_ROCKCHIP_PCIE
>>>   	help
>>>   	  Enable this to support the Rockchip PCIe PHY.
>>>   
>>> +config PHY_ROCKCHIP_SAMSUNG_HDPTX
>>> +	tristate "Rockchip Samsung HDMI/DP Combo PHY driver"
>>> +	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
>>> +	select GENERIC_PHY
>>> +	help
>>> +	  Enable this to support the Rockchip HDMI/DP Combo PHY
>>> +	  with Samsung IP block.
>>> +
>>>   config PHY_ROCKCHIP_SNPS_PCIE3
>>>   	tristate "Rockchip Snps PCIe3 PHY Driver"
>>>   	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
>>> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
>>> index 7eab129230d1..3d911304e654 100644
>>> --- a/drivers/phy/rockchip/Makefile
>>> +++ b/drivers/phy/rockchip/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>>>   obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
>>>   obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
>>>   obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>>> +obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)	+= phy-rockchip-samsung-hdptx.o
>>>   obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>>>   obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>>>   obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
>>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>> new file mode 100644
>>> index 000000000000..d8171ea5ce2b
>>> --- /dev/null
>>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>> @@ -0,0 +1,2045 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
>>> + * Copyright (c) 2024 Collabora Ltd.
>>> + *
>>> + * Author: Algea Cao <algea.cao@rock-chips.com>
>>> + * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> + */
>>> +#include <linux/bitfield.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/rational.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset.h>
>>> +
>>> +#define GRF_HDPTX_CON0			0x00
>>> +#define HDPTX_I_PLL_EN			BIT(7)
>>> +#define HDPTX_I_BIAS_EN			BIT(6)
>>> +#define HDPTX_I_BGR_EN			BIT(5)
>>> +#define GRF_HDPTX_STATUS		0x80
>>> +#define HDPTX_O_PLL_LOCK_DONE		BIT(3)
>>> +#define HDPTX_O_PHY_CLK_RDY		BIT(2)
>>> +#define HDPTX_O_PHY_RDY			BIT(1)
>>> +#define HDPTX_O_SB_RDY			BIT(0)
>>> +
>>> +#define CMN_REG0000			0x0000
>>
>> These register names are not particularly helpful. Maybe use a
>>
>> #define CMN_REG(x)			((x) * 4)
>>
>> Instead?
> 
> Yes, sounds good.
> 
>>> +
>>> +static int hdptx_lcpll_frl_mode_config(struct rockchip_hdptx_phy *hdptx,
>>> +				       u32 rate)
>>> +{
>>> +	u32 bit_rate = rate & DATA_RATE_MASK;
>>> +	u8 color_depth = (rate & COLOR_DEPTH_MASK) ? 1 : 0;
>>> +	const struct lcpll_config *cfg = lcpll_cfg;
>>> +
>>> +	for (; cfg->bit_rate != ~0; cfg++)
>>> +		if (bit_rate == cfg->bit_rate)
>>> +			break;
>>
>> You could use ARRAY_SIZE() to iterate over the array and save the extra
>> entry at the end. Likewise for the other arrays used in the driver.
> 
> Sure, will do.
> 
>>> +
>>> +	if (cfg->bit_rate == ~0)
>>> +		return -EINVAL;
>>> +
>>
>>> +static int rockchip_hdptx_phy_power_on(struct phy *phy)
>>> +{
>>> +	struct rockchip_hdptx_phy *hdptx = phy_get_drvdata(phy);
>>> +	int bus_width = phy_get_bus_width(hdptx->phy);
>>> +	int bit_rate = bus_width & DATA_RATE_MASK;
>>
>> What is going on here? bus_width is set to 8 in probe() using
>> phy_set_bus_width(), but the value you pull out of phy_get_bus_width()
>> is expected to contain the bit_rate and several other flags.
>>
>> It looks like you are tunneling flags from some other driver using this
>> field. Isn't there a better way to accomplish this? If not, I think this
>> needs some explanation.
> 
> Indeed, sorry for missing a comment here.  The flags are set by the
> bridge driver to enable 10-bit color depth, FRL and EARC.  So far I
> couldn't find an alternative approach to pass custom data using the PHY API.
> 
>> At least the variable should be renamed. it's called "bus_width" and it's
>> passed to functions like hdptx_lcpll_frl_mode_config() which has this
>> parameter named "rate" which is quite confusing.
> 
> I think for the initial support it's not really necessary to implement
> all those features.  Andy, should we drop them until a better solution
> is found?

I'm fine with it.
It would be very appreciated if some linux-phy or drm bridge experts can give
some suggestions about how to pass different custom phy modes.

> 
>> Sascha
> 
> Thanks for the review,
> Cristian

