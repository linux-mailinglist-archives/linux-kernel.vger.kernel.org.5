Return-Path: <linux-kernel+bounces-37282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E2983ADB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C59B2A24F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E877CF33;
	Wed, 24 Jan 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="C/FGntXI"
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com [103.129.254.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480CD7A73A;
	Wed, 24 Jan 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111221; cv=none; b=oVRrlh+X2QY2scTnMBupehS/Rj3l3AbN1dANZQsujcbJke4wxCx2pVxmftHa8zSd0OOX9F9itZ9bePcmmkdH8f86D/9V8rlId/UHgEjtUlTkjoxkEAXbif43bYsZO4XSmc2jZdPZFHHescDkRJSCXpOjsfX44ynhY5i3+Vv1/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111221; c=relaxed/simple;
	bh=uQa2lONtmzEleKOg5ZbKpNdTUps9FaMPEX+MM/Ezrnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZ7Fm3DZFMn2bG9OwNwHKF9echR+4U5J7MoFNGZHHMgCMCAS8U1oMhHKtmpELt8xm6aD0unrz5X2NZGIerXVYa7NAB4Ky7+k3NK9ojLMUVYMQVypfpN2/uvRtaNLKivKYnjIk3u4bz1/gKBFk53LVciudZ/Ijq8gThV0kik29bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=C/FGntXI; arc=none smtp.client-ip=103.129.254.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=C/FGntXIjF2lIvIm0alsmy2RglzRyK18RkaiHLPRtuPUc4h78ZR0MS6GaRxRZEHq62TdiGviNrqbIUpnKdnOuzXEy4m0NdKbjwEiTuF8fBz8f9289s/9zeg0CGWxF98NXR5bNy7J53jAZfsY/41RQMpcKLQPOm/a5jhKphGR75Q=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TTyPxOdPUgGMjE5qLolsAwgb6LYYW17mcDVr/zky4cw=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 778477801FD;
	Wed, 24 Jan 2024 15:30:34 +0800 (CST)
Message-ID: <b0a3da6d-84e2-44c2-9adf-421e306a2acf@rock-chips.com>
Date: Wed, 24 Jan 2024 15:30:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
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
 kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
 <20240122121409.GW4700@pengutronix.de>
 <00c749f7-3eb9-4bd1-a057-43a692b77d68@collabora.com>
 <e1c56975-6a55-4b75-a447-dd2d0eec62e2@rock-chips.com>
In-Reply-To: <e1c56975-6a55-4b75-a447-dd2d0eec62e2@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQksZTVYeTRlMSxgYSExMGE9VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8d3a60bd24b24fkuuu778477801fd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6Iio5DjwYUQEyHFFLSgg5
	Vg4wCUtVSlVKTEtNS0NKT0hOTE9NVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBQkxPSzcG

Hi Cristian:

On 1/24/24 10:42, Andy Yan wrote:
> Hi Cristian:
> 
> On 1/24/24 08:58, Cristian Ciocaltea wrote:
>> On 1/22/24 14:14, Sascha Hauer wrote:
>>> On Fri, Jan 19, 2024 at 09:38:03PM +0200, Cristian Ciocaltea wrote:
>>>> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.
>>>>
>>>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>>>> and eDP links.  The maximum data rate is 12Gbps (HDMI 2.1 FRL), while
>>>> the minimum is 250Mbps (HDMI 2.1 TMDS).
>>>>
>>>> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
>>>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>   drivers/phy/rockchip/Kconfig                  |    8 +
>>>>   drivers/phy/rockchip/Makefile                 |    1 +
>>>>   .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 2045 +++++++++++++++++
>>>>   3 files changed, 2054 insertions(+)
>>>>   create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>>
>>>> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
>>>> index 94360fc96a6f..95666ac6aa3b 100644
>>>> --- a/drivers/phy/rockchip/Kconfig
>>>> +++ b/drivers/phy/rockchip/Kconfig
>>>> @@ -83,6 +83,14 @@ config PHY_ROCKCHIP_PCIE
>>>>       help
>>>>         Enable this to support the Rockchip PCIe PHY.
>>>> +config PHY_ROCKCHIP_SAMSUNG_HDPTX
>>>> +    tristate "Rockchip Samsung HDMI/DP Combo PHY driver"
>>>> +    depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
>>>> +    select GENERIC_PHY
>>>> +    help
>>>> +      Enable this to support the Rockchip HDMI/DP Combo PHY
>>>> +      with Samsung IP block.
>>>> +
>>>>   config PHY_ROCKCHIP_SNPS_PCIE3
>>>>       tristate "Rockchip Snps PCIe3 PHY Driver"
>>>>       depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
>>>> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
>>>> index 7eab129230d1..3d911304e654 100644
>>>> --- a/drivers/phy/rockchip/Makefile
>>>> +++ b/drivers/phy/rockchip/Makefile
>>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)    += phy-rockchip-inno-hdmi.o
>>>>   obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)    += phy-rockchip-inno-usb2.o
>>>>   obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)    += phy-rockchip-naneng-combphy.o
>>>>   obj-$(CONFIG_PHY_ROCKCHIP_PCIE)        += phy-rockchip-pcie.o
>>>> +obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)    += phy-rockchip-samsung-hdptx.o
>>>>   obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)    += phy-rockchip-snps-pcie3.o
>>>>   obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)    += phy-rockchip-typec.o
>>>>   obj-$(CONFIG_PHY_ROCKCHIP_USB)        += phy-rockchip-usb.o
>>>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> new file mode 100644
>>>> index 000000000000..d8171ea5ce2b
>>>> --- /dev/null
>>>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> @@ -0,0 +1,2045 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
>>>> + * Copyright (c) 2024 Collabora Ltd.
>>>> + *
>>>> + * Author: Algea Cao <algea.cao@rock-chips.com>
>>>> + * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> + */
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/mfd/syscon.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/phy/phy.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/rational.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/reset.h>
>>>> +
>>>> +#define GRF_HDPTX_CON0            0x00
>>>> +#define HDPTX_I_PLL_EN            BIT(7)
>>>> +#define HDPTX_I_BIAS_EN            BIT(6)
>>>> +#define HDPTX_I_BGR_EN            BIT(5)
>>>> +#define GRF_HDPTX_STATUS        0x80
>>>> +#define HDPTX_O_PLL_LOCK_DONE        BIT(3)
>>>> +#define HDPTX_O_PHY_CLK_RDY        BIT(2)
>>>> +#define HDPTX_O_PHY_RDY            BIT(1)
>>>> +#define HDPTX_O_SB_RDY            BIT(0)
>>>> +
>>>> +#define CMN_REG0000            0x0000
>>>
>>> These register names are not particularly helpful. Maybe use a
>>>
>>> #define CMN_REG(x)            ((x) * 4)
>>>
>>> Instead?
>>
>> Yes, sounds good.
>>
>>>> +
>>>> +static int hdptx_lcpll_frl_mode_config(struct rockchip_hdptx_phy *hdptx,
>>>> +                       u32 rate)
>>>> +{
>>>> +    u32 bit_rate = rate & DATA_RATE_MASK;
>>>> +    u8 color_depth = (rate & COLOR_DEPTH_MASK) ? 1 : 0;
>>>> +    const struct lcpll_config *cfg = lcpll_cfg;
>>>> +
>>>> +    for (; cfg->bit_rate != ~0; cfg++)
>>>> +        if (bit_rate == cfg->bit_rate)
>>>> +            break;
>>>
>>> You could use ARRAY_SIZE() to iterate over the array and save the extra
>>> entry at the end. Likewise for the other arrays used in the driver.
>>
>> Sure, will do.
>>
>>>> +
>>>> +    if (cfg->bit_rate == ~0)
>>>> +        return -EINVAL;
>>>> +
>>>
>>>> +static int rockchip_hdptx_phy_power_on(struct phy *phy)
>>>> +{
>>>> +    struct rockchip_hdptx_phy *hdptx = phy_get_drvdata(phy);
>>>> +    int bus_width = phy_get_bus_width(hdptx->phy);
>>>> +    int bit_rate = bus_width & DATA_RATE_MASK;
>>>
>>> What is going on here? bus_width is set to 8 in probe() using
>>> phy_set_bus_width(), but the value you pull out of phy_get_bus_width()
>>> is expected to contain the bit_rate and several other flags.
>>>
>>> It looks like you are tunneling flags from some other driver using this
>>> field. Isn't there a better way to accomplish this? If not, I think this
>>> needs some explanation.
>>
>> Indeed, sorry for missing a comment here.  The flags are set by the
>> bridge driver to enable 10-bit color depth, FRL and EARC.  So far I
>> couldn't find an alternative approach to pass custom data using the PHY API.
>>
>>> At least the variable should be renamed. it's called "bus_width" and it's
>>> passed to functions like hdptx_lcpll_frl_mode_config() which has this
>>> parameter named "rate" which is quite confusing.
>>
>> I think for the initial support it's not really necessary to implement
>> all those features.  Andy, should we drop them until a better solution
>> is found?

How about add a PHY_MODE_HDMI to enum phy_mode, and pass this custom data by extend phy_configure_opts
or the submode of phy_set_mode_ext ?
> 
> I'm fine with it.
> It would be very appreciated if some linux-phy or drm bridge experts can give
> some suggestions about how to pass different custom phy modes.
> 
>>
>>> Sascha
>>
>> Thanks for the review,
>> Cristian

