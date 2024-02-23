Return-Path: <linux-kernel+bounces-78280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C35D861148
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F1A28714F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5307AE7E;
	Fri, 23 Feb 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olt4mu6u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03A25742;
	Fri, 23 Feb 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690346; cv=none; b=QC1HZlvfc44UeoSFMU+RhCA+jrWZuFzj4cGaUU4AAw+Isi0Otgs44WsF/8s9wwkPgGY2s7JVIE7StsmHmejgRK03jPL4Ssd3y+Px/YaOkOxVd6B1spLFaBSn8NdI/ElkUTvzfbXRAvkxmGOZyct+/LX/9tGxkahs6JNq+dzHwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690346; c=relaxed/simple;
	bh=Si1cSo6cLV2RpagB4x8pLhXBiIQGrzIpVFKNX/ozh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7dHwFRH2GTHr4/iBU9i43lLeVlfabZME+l8EQFXp6xYiUgrLSycVqKQKhRiwvQsM+uMsOC0260BSGsQ8yS6LufrJ1iX4S+u7J1MZBpoJrpdBAjfSpmtgLIaXR61FzqfsqQEqOuFmyZXpZHMNb8So4jCKFhmZ8wWaD50LeD6rK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olt4mu6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D745C433F1;
	Fri, 23 Feb 2024 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690346;
	bh=Si1cSo6cLV2RpagB4x8pLhXBiIQGrzIpVFKNX/ozh2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Olt4mu6uPKZ/cjBiywTyt2Ub7F7gzZx+1aKJHPDuRQG492D9JyACSCH0QbvofRGL6
	 54ZktXNYcTFGuq739eTCqu7H8Kk97Ax6y0HBNUCo2yx1otQTwylGzTcUapDFR+FWKK
	 mtCRJDQT1YQxieVk7T5QA+rf2VdtDni6/G8syEx4rd+SKaU/WwJ7mVQlKXvnvyacxp
	 slChlzkNGHYlf7dWZakTUQjZPRJTozACw1wNfKtcv2Y2NMv7MmRTzSM4TTDX6nwDge
	 2zvavTeGYZ1F9yllFA+SmFsVC5xz6eZdAISZZsAblES20t2GmsnpsrrUIVmO66VlrK
	 Napj67BGrguBg==
Date: Fri, 23 Feb 2024 17:42:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shengyang Chen <shengyang.chen@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	Minda Chen <minda.chen@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	"rogerq@kernel.org" <rogerq@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	Keith Zhao <keith.zhao@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] phy: starfive: Add mipi dphy tx support
Message-ID: <ZdiLpvOgi8ztTT5V@matsya>
References: <20240206061921.107372-1-shengyang.chen@starfivetech.com>
 <20240206061921.107372-3-shengyang.chen@starfivetech.com>
 <ZcNc8zZzsVU6viBL@matsya>
 <NT0PR01MB107009D37C2BBD9AC5B3CC4FEF56A@NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <NT0PR01MB107009D37C2BBD9AC5B3CC4FEF56A@NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn>

On 22-02-24, 08:48, Shengyang Chen wrote:
> Hi, Vinod
> 
> Thanks for review and comment.
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: 2024年2月7日 18:36
> > To: Shengyang Chen <shengyang.chen@starfivetech.com>
> > Cc: devicetree@vger.kernel.org; linux-phy@lists.infradead.org;
> > kishon@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; p.zabel@pengutronix.de; Minda Chen
> > <minda.chen@starfivetech.com>; Changhuang Liang
> > <changhuang.liang@starfivetech.com>; rogerq@kernel.org;
> > geert+renesas@glider.be; Keith Zhao <keith.zhao@starfivetech.com>;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 2/2] phy: starfive: Add mipi dphy tx support
> > 
> > On 06-02-24, 14:19, Shengyang Chen wrote:
> > > Add mipi dphy tx support for the StarFive JH7110 SoC.
> > > It is a module which is used to receive data from DSI driver and
> > > transfer data to DSI interface like mipi screen.
> > >
> > > Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> > > ---
> > >  MAINTAINERS                               |   7 +
> > >  drivers/phy/starfive/Kconfig              |  10 +
> > >  drivers/phy/starfive/Makefile             |   1 +
> > >  drivers/phy/starfive/phy-jh7110-dphy-tx.c | 635
> > > ++++++++++++++++++++++
> > >  4 files changed, 653 insertions(+)
> > >  create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > 944b8ec33639..5e062b7393cb 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20864,6 +20864,13 @@ S:	Supported
> > >  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> > >  F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
> > >
> > > +STARFIVE JH7110 DPHY TX DRIVER
> > > +M:	Keith Zhao <keith.zhao@starfivetech.com>
> > > +M:	Shengyang Chen <shengyang.chen@starfivetech.com>
> > > +S:	Supported
> > > +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
> > > +F:	drivers/phy/starfive/phy-jh7110-dphy-tx.c
> > > +
> > >  STARFIVE JH7110 MMC/SD/SDIO DRIVER
> > >  M:	William Qiu <william.qiu@starfivetech.com>
> > >  S:	Supported
> > > diff --git a/drivers/phy/starfive/Kconfig
> > > b/drivers/phy/starfive/Kconfig index 9508e2143011..d0cdd7cb4a13 100644
> > > --- a/drivers/phy/starfive/Kconfig
> > > +++ b/drivers/phy/starfive/Kconfig
> > > @@ -15,6 +15,16 @@ config PHY_STARFIVE_JH7110_DPHY_RX
> > >  	  system. If M is selected, the module will be called
> > >  	  phy-jh7110-dphy-rx.ko.
> > >
> > > +config PHY_STARFIVE_JH7110_DPHY_TX
> > > +	tristate "StarFive JH7110 D-PHY TX Support"
> > > +	depends on HAS_IOMEM
> > > +	select GENERIC_PHY
> > > +	select GENERIC_PHY_MIPI_DPHY
> > > +	help
> > > +	  Choose this option if you have a StarFive D-PHY TX in your
> > > +	  system. If M is selected, the module will be called
> > > +	  phy-jh7110-dphy-tx.ko.
> > > +
> > >  config PHY_STARFIVE_JH7110_PCIE
> > >  	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
> > >  	depends on HAS_IOMEM
> > > diff --git a/drivers/phy/starfive/Makefile
> > > b/drivers/phy/starfive/Makefile index b391018b7c47..eedc4a6fec15
> > > 100644
> > > --- a/drivers/phy/starfive/Makefile
> > > +++ b/drivers/phy/starfive/Makefile
> > > @@ -1,4 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_RX)	+= phy-jh7110-dphy-rx.o
> > > +obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_TX)	+= phy-jh7110-dphy-tx.o
> > >  obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)		+= phy-jh7110-pcie.o
> > >  obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)		+= phy-jh7110-usb.o
> > > diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> > > b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> > > new file mode 100644
> > > index 000000000000..00be118c9606
> > > --- /dev/null
> > > +++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> > > @@ -0,0 +1,635 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * DPHY TX driver for the StarFive JH7110 SoC
> > > + *
> > > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > > + * Author: Keith Zhao <keith.zhao@starfivetech.com>
> > > + * Author: Shengyang Chen <shengyang.chen@starfivetech.com>  */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/io.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/phy/phy-mipi-dphy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/reset.h>
> > > +
> > > +#define STF_DPHY_APBIFSAIF_SYSCFG(x)			(x)
> > > +
> > > +#define  STF_DPHY_AON_POWER_READY_N_SHIFT		0x0U
> > > +#define  STF_DPHY_AON_POWER_READY_N_MASK		BIT(0)
> > > +#define  STF_DPHY_CFG_L0_SWAP_SEL_SHIFT			0xCU
> > 
> > lower case please, here and everywhere
> 
> Sorry, I'm a little confused about this.
> Do you mean changing '0xCU' to '0xCu'?

Nope, it should be 0xcU, all the hex values should be in lower case

-- 
~Vinod

