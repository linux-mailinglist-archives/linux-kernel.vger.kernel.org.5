Return-Path: <linux-kernel+bounces-52907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104F849E22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52711F230B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342872D610;
	Mon,  5 Feb 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e2zE6H8z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4CD2EAE6;
	Mon,  5 Feb 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146949; cv=none; b=ejvXQOX7ZLpsuMuH39IoeH+EjfzrcC9C4M3fM8kU4pN9vdPorNIaAWI7RJJOtrgpIfPmLXBXVQmM86tYsTlU3FKNI7RLxUL7Cf8f7J31ODvH++lyfDI/Wg9iJH8aOWJ57INfzZpys6oWajjCdhSuT3cAtsC8pvJmBZlkE3AxfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146949; c=relaxed/simple;
	bh=zwMiEUy3DNM16U6Gg/D4CWCvZyrDQSqVGiYAzy6rIAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RSBJcTLAQe3kaKAS61oSD7iyj106REgJu6Psa2012hn2klEU8FKqWJUhxIpEJGseJyVIBpTQVXtW4g45Z8ui/dFbIlyvFL7MBh5KpPh8qM53o6QSTcvXPuaBe1uY9MRFwINhieTVafGJPtJM22RKQEHfttNus57SUanVkRC3IY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e2zE6H8z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707146945;
	bh=zwMiEUy3DNM16U6Gg/D4CWCvZyrDQSqVGiYAzy6rIAo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=e2zE6H8zQDqR2BslAuM5KgW3wOlp6GAHwypDWTARmsHMfZ+/oMDfMEddH6Ay3KDXv
	 sr1J+qiu408YbVXiWEbr127YpHPbDOfDqHt8HO9ya1RloT1t/We23IddjUkJrZ/DBW
	 MPzg5iSy42+vOQRteY+Bh/FDMu6Mg/qYBEbD1gFsOzbq0amT0bWBa+EkDCJnSXIZia
	 oJteUYcjptHv9wkZYzmpMPIn1CXxmNe80V0QcIgLxVY77CvzYea9tKiGF/YLF4o+nt
	 jLvxUsTo1GefQSCEwrL1s1Q5tv+QC1JIIQRv9gHLGPACZGYDHhfuky67IfaHzHJVJq
	 WvyeCIjvDI7Qw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3606F37813E4;
	Mon,  5 Feb 2024 15:29:04 +0000 (UTC)
Message-ID: <f7b2475a-990e-4972-9c82-0989876fa116@collabora.com>
Date: Mon, 5 Feb 2024 16:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: add driver for MediaTek XFI T-PHY
Content-Language: en-US
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 =?UTF-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
 <bc-bocun.chen@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "dqfext@gmail.com" <dqfext@gmail.com>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
References: <702afb0c1246d95c90b22e57105304028bdd3083.1706823233.git.daniel@makrotopia.org>
 <dd6b40ea1f7f8459a9a2cfe7fa60c1108332ade6.1706823233.git.daniel@makrotopia.org>
 <a2641a62703bcd33115689544001cdbd26e84bbb.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a2641a62703bcd33115689544001cdbd26e84bbb.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/02/24 07:29, Chunfeng Yun (云春峰) ha scritto:
> On Thu, 2024-02-01 at 21:53 +0000, Daniel Golle wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Add driver for MediaTek's XFI T-PHY, 10 Gigabit/s Ethernet SerDes
>> PHY
>> which can be found in the MT7988 SoC.
>>
>> The PHY can operates only in PHY_MODE_ETHERNET, the submode is one of
>> PHY_INTERFACE_MODE_* corresponding to the supported modes:
>>
>>   * USXGMII                 \
>>   * 10GBase-R                }- USXGMII PCS - XGDM  \
>>   * 5GBase-R                /                        \
>>                                                       }- Ethernet MAC
>>   * 2500Base-X              \                        /
>>   * 1000Base-X               }- LynxI PCS - GDM     /
>>   * Cisco SGMII (MAC side)  /
>>
>> In order to work-around a performance issue present on the first of
>> two XFI T-PHYs present in MT7988, special tuning is applied which can
>> be
>> selected by adding the 'mediatek,usxgmii-performance-errata' property
>> to
>> the device tree node.
>>
>> There is no documentation for most registers used for the
>> analog/tuning part, however, most of the registers have been
>> partially
>> reverse-engineered from MediaTek's SDK implementation (an opaque
>> sequence of 32-bit register writes) and descriptions for all relevant
>> digital registers and bits such as resets and muxes have been
>> supplied
>> by MediaTek.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> ---
>>   MAINTAINERS                             |   1 +
>>   drivers/phy/mediatek/Kconfig            |  12 +
>>   drivers/phy/mediatek/Makefile           |   1 +
>>   drivers/phy/mediatek/phy-mtk-xfi-tphy.c | 392
>> ++++++++++++++++++++++++
>>   4 files changed, 406 insertions(+)
>>   create mode 100644 drivers/phy/mediatek/phy-mtk-xfi-tphy.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 52769631bdb1a..52e4192470bd9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13715,6 +13715,7 @@ L:netdev@vger.kernel.org
>>   S:Maintained
>>   F:drivers/net/phy/mediatek-ge-soc.c
>>   F:drivers/net/phy/mediatek-ge.c
>> +F:drivers/phy/mediatek/phy-mtk-xfi-tphy.c
>>   
>>   MEDIATEK I2C CONTROLLER DRIVER
>>   M:Qii Wang <qii.wang@mediatek.com>
>> diff --git a/drivers/phy/mediatek/Kconfig
>> b/drivers/phy/mediatek/Kconfig
>> index 3125ecb5d119f..5161d130c7f8b 100644
>> --- a/drivers/phy/mediatek/Kconfig
>> +++ b/drivers/phy/mediatek/Kconfig
>> @@ -13,6 +13,18 @@ config PHY_MTK_PCIE
>>     callback for PCIe GEN3 port, it supports software efuse
>>     initialization.
>>   
>> +config PHY_MTK_XFI_TPHY
>> +tristate "MediaTek XFI T-PHY Driver"
>> +depends on ARCH_MEDIATEK || COMPILE_TEST
>> +depends on OF && OF_ADDRESS
>> +depends on HAS_IOMEM
>> +select GENERIC_PHY
>> +help
>> +  Say 'Y' here to add support for MediaTek XFI T-PHY driver.
>> +  The driver provides access to the Ethernet SerDes T-PHY supporting
>> +  1GE and 2.5GE modes via the LynxI PCS, and 5GE and 10GE modes
>> +  via the USXGMII PCS found in MediaTek SoCs with 10G Ethernet.
>> +
>>   config PHY_MTK_TPHY
>>   tristate "MediaTek T-PHY Driver"
>>   depends on ARCH_MEDIATEK || COMPILE_TEST
>> diff --git a/drivers/phy/mediatek/Makefile
>> b/drivers/phy/mediatek/Makefile
>> index c9a50395533eb..fa7217178e7f4 100644
>> --- a/drivers/phy/mediatek/Makefile
>> +++ b/drivers/phy/mediatek/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_MTK_PCIE)+= phy-mtk-pcie.o
>>   obj-$(CONFIG_PHY_MTK_TPHY)+= phy-mtk-tphy.o
>>   obj-$(CONFIG_PHY_MTK_UFS)+= phy-mtk-ufs.o
>>   obj-$(CONFIG_PHY_MTK_XSPHY)+= phy-mtk-xsphy.o
>> +obj-$(CONFIG_PHY_MTK_XFI_TPHY)+= phy-mtk-xfi-tphy.o
>>   
>>   phy-mtk-hdmi-drv-y:= phy-mtk-hdmi.o
>>   phy-mtk-hdmi-drv-y+= phy-mtk-hdmi-mt2701.o
>> diff --git a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
>> b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
>> new file mode 100644
>> index 0000000000000..d50e6320860e5
>> --- /dev/null
>> +++ b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
>> @@ -0,0 +1,392 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* MediaTek 10GE SerDes PHY driver
>> + *
>> + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
>> + *                    Bc-bocun Chen <bc-bocun.chen@mediatek.com>
>> + * based on mtk_usxgmii.c found in MediaTek's SDK released under
>> GPL-2.0
>> + * Copyright (c) 2022 MediaTek Inc.
>> + * Author: Henry Yen <henry.yen@mediatek.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/reset.h>
>> +#include <linux/phy.h>
>> +#include <linux/phy/phy.h>
>> +
>> +#define MTK_XFI_TPHY_NUM_CLOCKS2
>> +
>> +#define REG_DIG_GLB_700x0070
>> +#define  XTP_PCS_RX_EQ_IN_PROGRESS(x)FIELD_PREP(GENMASK(25, 24),
>> (x))
>> +#define  XTP_PCS_MODE_MASKGENMASK(17, 16)
>> +#define  XTP_PCS_MODE(x)FIELD_PREP(GENMASK(17, 16), (x))
>> +#define  XTP_PCS_RST_BBIT(15)
>> +#define  XTP_FRC_PCS_RST_BBIT(14)
>> +#define  XTP_PCS_PWD_SYNC_MASKGENMASK(13, 12)
>> +#define  XTP_PCS_PWD_SYNC(x)FIELD_PREP(XTP_PCS_PWD_SYNC_MASK, (x))
>> +#define  XTP_PCS_PWD_ASYNC_MASKGENMASK(11, 10)
>> +#define  XTP_PCS_PWD_ASYNC(x)FIELD_PREP(XTP_PCS_PWD_ASYNC_MASK, (x))
>> +#define  XTP_FRC_PCS_PWD_ASYNCBIT(8)
>> +#define  XTP_PCS_UPDTBIT(4)
>> +#define  XTP_PCS_IN_FR_RGBIT(0)
>> +
>> +#define REG_DIG_GLB_F40x00f4
>> +#define  XFI_DPHY_PCS_SELBIT(0)
>> +#define   XFI_DPHY_PCS_SEL_SGMIIFIELD_PREP(XFI_DPHY_PCS_SEL, 1)
>> +#define   XFI_DPHY_PCS_SEL_USXGMIIFIELD_PREP(XFI_DPHY_PCS_SEL, 0)
>> +#define  XFI_DPHY_AD_SGDT_FRC_ENBIT(5)
>> +
>> +#define REG_DIG_LN_TRX_400x3040
>> +#define  XTP_LN_FRC_TX_DATA_ENBIT(29)
>> +#define  XTP_LN_TX_DATA_ENBIT(28)
>> +
>> +#define REG_DIG_LN_TRX_B00x30b0
>> +#define  XTP_LN_FRC_TX_MACCK_ENBIT(5)
>> +#define  XTP_LN_TX_MACCK_ENBIT(4)
>> +
>> +#define REG_ANA_GLB_D00x90d0
>> +#define  XTP_GLB_USXGMII_SEL_MASKGENMASK(3, 1)
>> +#define  XTP_GLB_USXGMII_SEL(x)FIELD_PREP(GENMASK(3, 1), (x))
>> +#define  XTP_GLB_USXGMII_ENBIT(0)
>> +
>> +struct mtk_xfi_tphy {
>> +void __iomem*base;
>> +struct device*dev;
>> +struct reset_control*reset;
>> +struct clk_bulk_dataclocks[MTK_XFI_TPHY_NUM_CLOCKS];
>> +boolda_war;
>> +};
>> +
>> +static void mtk_xfi_tphy_write(struct mtk_xfi_tphy *xfi_tphy, u16
>> reg,
>> +       u32 value)
>> +{
>> +iowrite32(value, xfi_tphy->base + reg);
>> +}
>> +
>> +static void mtk_xfi_tphy_rmw(struct mtk_xfi_tphy *xfi_tphy, u16 reg,
>> +     u32 clr, u32 set)
>> +{
>> +u32 val;
>> +
>> +val = ioread32(xfi_tphy->base + reg);
>> +val &= ~clr;
>> +val |= set;
>> +iowrite32(val, xfi_tphy->base + reg);
>> +}
>> +
>> +static void mtk_xfi_tphy_set(struct mtk_xfi_tphy *xfi_tphy, u16 reg,
>> +     u32 set)
>> +{
>> +mtk_xfi_tphy_rmw(xfi_tphy, reg, 0, set);
>> +}
>> +
>> +static void mtk_xfi_tphy_clear(struct mtk_xfi_tphy *xfi_tphy, u16
>> reg,
>> +       u32 clr)
>> +{
>> +mtk_xfi_tphy_rmw(xfi_tphy, reg, clr, 0);
>> +}
> 
> Helpers defined in phy-mtk-io.h can be used instead?
> 
>> +
>> +static void mtk_xfi_tphy_setup(struct mtk_xfi_tphy *xfi_tphy,
>> +       phy_interface_t interface)
>> +{
>> +bool is_2p5g = (interface == PHY_INTERFACE_MODE_2500BASEX);
>> +bool is_1g = (interface == PHY_INTERFACE_MODE_1000BASEX ||
>> +      interface == PHY_INTERFACE_MODE_SGMII);
>> +bool is_10g = (interface == PHY_INTERFACE_MODE_10GBASER ||
>> +       interface == PHY_INTERFACE_MODE_USXGMII);
>> +bool is_5g = (interface == PHY_INTERFACE_MODE_5GBASER);
>> +bool is_xgmii = (is_10g || is_5g);
>> +
>> +dev_dbg(xfi_tphy->dev, "setting up for mode %s\n",
>> phy_modes(interface));
>> +
>> +/* Setup PLL setting */
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x9024, 0x100000, is_10g ? 0x0 :
>> 0x100000);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x2020, 0x202000, is_5g ? 0x202000 :
>> 0x0);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x2030, 0x500, is_1g ? 0x0 : 0x500);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x2034, 0xa00, is_1g ? 0x0 : 0xa00);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x2040, 0x340000, is_1g ? 0x200000 :
>> +     0x140000);
>> +
>> +/* Setup RXFE BW setting */
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x50f0, 0xc10, is_1g ? 0x410 :
>> +  is_5g ? 0x800 : 0x400);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x50e0, 0x4000, is_5g ? 0x0 : 0x4000);
>> +
>> +/* Setup RX CDR setting */
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x506c, 0x30000, is_5g ? 0x0 : 0x30000);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x5070, 0x670000, is_5g ? 0x620000 :
>> 0x50000);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x5074, 0x180000, is_5g ? 0x180000 :
>> 0x0);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x5078, 0xf000400, is_5g ? 0x8000000 :
>> +      0x7000400);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x507c, 0x5000500, is_5g ? 0x4000400 :
>> +      0x1000100);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x5080, 0x1410, is_1g ? 0x400 :
>> +   is_5g ? 0x1010 : 0x0);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x5084, 0x30300, is_1g ? 0x30300 :
>> +    is_5g ? 0x30100 :
>> +    0x100);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x5088, 0x60200, is_1g ? 0x20200 :
>> + is_5g ? 0x40000 :
>> + 0x20000);
>> +
>> +/* Setting RXFE adaptation range setting */
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x50e4, 0xc0000, is_5g ? 0x0 : 0xc0000);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x50e8, 0x40000, is_5g ? 0x0 : 0x40000);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x50ec, 0xa00, is_1g ? 0x200 : 0x800);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x50a8, 0xee0000, is_5g ? 0x800000 :
>> +     0x6e0000);
>> +mtk_xfi_tphy_rmw(xfi_tphy, 0x6004, 0x190000, is_5g ? 0x0 :
>> 0x190000);
>> +if (is_10g)
>> +mtk_xfi_tphy_write(xfi_tphy, 0x00f8, 0x01423342);
>> +else if (is_5g)
>> +mtk_xfi_tphy_write(xfi_tphy, 0x00f8, 0x00a132a1);
>> +else if (is_2p5g)
>> +mtk_xfi_tphy_write(xfi_tphy, 0x00f8, 0x009c329c);
>> +else
>> +mtk_xfi_tphy_write(xfi_tphy, 0x00f8, 0x00fa32fa);
> Still have many magic number.
> 

There's lack of documentation, that's why Daniel has all those magic numbers there.

If you can help unrolling some definitions that'd be really appreciated, as that
would result in a cleaner driver.

Cheers,
Angelo


