Return-Path: <linux-kernel+bounces-167329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7838BA7FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6450F282471
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA70147C7E;
	Fri,  3 May 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP4lP9w3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224B8465;
	Fri,  3 May 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722072; cv=none; b=H+vPd9Avut3HFNflpAzCbSx3LIjWYTc19VHQk+A1KFLFCb7NMmWj47zVAXVRd//XObAxTY5a16+I68W1AtHzIUhTxenDO7/N6BXrpZa+Y2hICvFB+/QnGCFRBUbzLrURLhtfUvT9jMvVKlAcBRit7MaI5cZaXcPqLz75MzVlmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722072; c=relaxed/simple;
	bh=ENrS4OAoDCRLEKoJLHFpOmbIWEYm4GaiYfDZ+F8wDiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk7N7pJiYcVXzuk6CS0hRn9Q5ryJx+mY04I/stMTiITQ3nSj5oi8XJ76ISXGqv6Q5/MsaRr6XN8qT3cmVQuDsZZMnkfSMp21Y0hs2jzi+Ysmh7VujC60UUxbXXXlJK9moMGPYqN/UnyIvuGOuunza4CiGd1WZk/1nzQAyDKZJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP4lP9w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF71C116B1;
	Fri,  3 May 2024 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714722072;
	bh=ENrS4OAoDCRLEKoJLHFpOmbIWEYm4GaiYfDZ+F8wDiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP4lP9w3+6bPAwzD5vdWRAJJRqXJigiv5X+Yx9csUV3kXFnQmphPGdfugtaLyYRDc
	 O+V8QSWQrG+o2o3LRNkqwpP6/SO613bQSXSMqdIaZMWEx0wYO+2FmOXpS0eKXwYGz5
	 r6YnmNxw8CCzStUm7i5em7N+pVw3zVNLeRUmsu0npTS0HsmGMpcI/OkO0UdDUjtL9k
	 TYQb6qaGxF/IWO8aRswNXJTE1xtMagY8h1lqnuiKOIWWf8qLiEqegwhrJtPy2sPRAP
	 c5P8NoS5Y1FaHx5imTIHgLbtx7UO+FpSsTVgDqCcp1KoimE8+Gu9elEeAuDEDEiHc9
	 16ULT3wc5Yr+A==
Date: Fri, 3 May 2024 08:41:06 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 3/6] mfd: support ROHM BD96801 PMIC core
Message-ID: <20240503074106.GG1227636@google.com>
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <91eafc06728ebb6158d86b58ce987fc8f802a453.1714478142.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91eafc06728ebb6158d86b58ce987fc8f802a453.1714478142.git.mazziesaccount@gmail.com>

On Tue, 30 Apr 2024, Matti Vaittinen wrote:

> The ROHM BD96801 PMIC is highly customizable automotive grade PMIC
> which integrates regulator and watchdog funtionalities.
> 
> Provide INTB IRQ and register accesses for regulator/watchdog drivers.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Changelog: RFCv2 => v1:
> - drop ERRB interrupts (for now)
> - bd96801: Unlock registers in core driver
> 
> Changelog: RFCv1 => RFCv2
> - Work-around the IRQ domain name conflict
> - Add watchdog IRQ
> - Various styling fixes based on review by Lee
> ---
>  drivers/mfd/Kconfig              |  13 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd96801.c       | 278 +++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd96801.h | 215 ++++++++++++++++++++++++
>  include/linux/mfd/rohm-generic.h |   1 +
>  5 files changed, 508 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd96801.c
>  create mode 100644 include/linux/mfd/rohm-bd96801.h

Still some nits, sorry.

I probably wouldn't have been so picky if I hadn't have found the unused enum.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4b023ee229cf..9e874453d94d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2089,6 +2089,19 @@ config MFD_ROHM_BD957XMUF
>  	  BD9573MUF Power Management ICs. BD9576 and BD9573 are primarily
>  	  designed to be used to power R-Car series processors.
>  
> +config MFD_ROHM_BD96801
> +	tristate "ROHM BD96801 Power Management IC"
> +	depends on I2C=y
> +	depends on OF
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  Select this option to get support for the ROHM BD96801 Power
> +	  Management IC. The ROHM BD96801 is a highly scalable Power Management
> +	  IC for industrial and automotive use. The BD96801 can be used as a
> +	  master PMIC in a chained PMIC solution with suitable companion PMICs.
> +
>  config MFD_STM32_LPTIMER
>  	tristate "Support for STM32 Low-Power Timer"
>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c66f07edcd0e..e792892d4a8b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -264,6 +264,7 @@ obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
> +obj-$(CONFIG_MFD_ROHM_BD96801)	+= rohm-bd96801.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
> diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
> new file mode 100644
> index 000000000000..1e9c49c857c1
> --- /dev/null
> +++ b/drivers/mfd/rohm-bd96801.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 ROHM Semiconductors
> + *
> + * ROHM BD96801 PMIC driver
> + *
> + * This version of the "BD86801 scalable PMIC"'s driver supports only very
> + * basic set of the PMIC features. Most notably, there is no support for
> + * the ERRB interrupt and the configurations which should be done when the
> + * PMIC is in STBY mode.
> + *
> + * Supporting the ERRB interrupt would require dropping the regmap-IRQ
> + * usage or working around (or accepting a presense of) a naming conflict
> + * in debugFS IRQs.
> + *
> + * Being able to reliably do the configurations like changing the
> + * regulator safety limits (like limits for the over/under -voltages, over
> + * current, thermal protection) would require the configuring driver to be
> + * synchronized with entity causing the PMIC state transitions. Eg, one
> + * should be able to ensure the PMIC is in STBY state when the
> + * configurations are applied to the hardware. How and when the PMIC state
> + * transitions are to be done is likely to be very system specific, as will
> + * be the need to configure these safety limits. Hence it's not simple to
> + * come up with a generic solution.
> + *
> + * Users who require the ERRB handling and STBY state configurations can
> + * have a look at the original RFC:
> + * https://lore.kernel.org/all/cover.1712920132.git.mazziesaccount@gmail.com/
> + * which implements a workaround to debugFS naming conflict and some of
> + * the safety limit configurations - but leaves the state change handling
> + * and synchronization to be implemented.
> + *
> + * It would be great to hear (and receive a patch!) if you implement the
> + * STBY configuration support or a proper fix to the debugFS naming
> + * conflict in your downstream driver ;)
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/mfd/rohm-bd96801.h>
> +#include <linux/mfd/rohm-generic.h>
> +static const struct resource regulator_intb_irqs[] = {
> +	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "bd96801-core-thermal"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "bd96801-buck1-overcurr-h"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPL_STAT, "bd96801-buck1-overcurr-l"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPN_STAT, "bd96801-buck1-overcurr-n"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OVD_STAT, "bd96801-buck1-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_UVD_STAT, "bd96801-buck1-undervolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_TW_CH_STAT, "bd96801-buck1-thermal"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPH_STAT, "bd96801-buck2-overcurr-h"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPL_STAT, "bd96801-buck2-overcurr-l"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OCPN_STAT, "bd96801-buck2-overcurr-n"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_OVD_STAT, "bd96801-buck2-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_UVD_STAT, "bd96801-buck2-undervolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK2_TW_CH_STAT, "bd96801-buck2-thermal"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPH_STAT, "bd96801-buck3-overcurr-h"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPL_STAT, "bd96801-buck3-overcurr-l"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OCPN_STAT, "bd96801-buck3-overcurr-n"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_OVD_STAT, "bd96801-buck3-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_UVD_STAT, "bd96801-buck3-undervolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK3_TW_CH_STAT, "bd96801-buck3-thermal"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPH_STAT, "bd96801-buck4-overcurr-h"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPL_STAT, "bd96801-buck4-overcurr-l"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OCPN_STAT, "bd96801-buck4-overcurr-n"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_OVD_STAT, "bd96801-buck4-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_UVD_STAT, "bd96801-buck4-undervolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_BUCK4_TW_CH_STAT, "bd96801-buck4-thermal"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OCPH_STAT, "bd96801-ldo5-overcurr"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_OVD_STAT, "bd96801-ldo5-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO5_UVD_STAT, "bd96801-ldo5-undervolt"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OCPH_STAT, "bd96801-ldo6-overcurr"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_OVD_STAT, "bd96801-ldo6-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO6_UVD_STAT, "bd96801-ldo6-undervolt"),
> +
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OCPH_STAT, "bd96801-ldo7-overcurr"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_OVD_STAT, "bd96801-ldo7-overvolt"),
> +	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_UVD_STAT, "bd96801-ldo7-undervolt"),
> +};
> +
> +static const struct resource wdg_intb_irqs[] = {
> +	DEFINE_RES_IRQ_NAMED(BD96801_WDT_ERR_STAT, "bd96801-wdg"),
> +};
> +
> +enum {
> +	WDG_CELL = 0,
> +	REGULATOR_CELL,
> +};

Dead code?

> +static struct mfd_cell bd96801_mfd_cells[] = {
> +	{
> +		.name = "bd96801-wdt",
> +		.resources = wdg_intb_irqs,
> +		.num_resources = ARRAY_SIZE(wdg_intb_irqs),
> +	}, {
> +		.name = "bd96801-pmic",
> +		.resources = regulator_intb_irqs,
> +		.num_resources = ARRAY_SIZE(regulator_intb_irqs),
> +	},
> +};
> +
> +static const struct regmap_range bd96801_volatile_ranges[] = {
> +	/* Status regs */

Full words in comments please.

> +	regmap_reg_range(BD96801_REG_WD_FEED, BD96801_REG_WD_FAILCOUNT),
> +	regmap_reg_range(BD96801_REG_WD_ASK, BD96801_REG_WD_ASK),
> +	regmap_reg_range(BD96801_REG_WD_STATUS, BD96801_REG_WD_STATUS),
> +	regmap_reg_range(BD96801_REG_PMIC_STATE, BD96801_REG_INT_LDO7_INTB),
> +	/* Registers which do not update value unless PMIC is in STBY */
> +	regmap_reg_range(BD96801_REG_SSCG_CTRL, BD96801_REG_SHD_INTB),
> +	regmap_reg_range(BD96801_REG_BUCK_OVP, BD96801_REG_BOOT_OVERTIME),
> +	/*
> +	 * LDO control registers have single bit (LDO MODE) which does not
> +	 * change when we write it unless PMIC is in STBY. It's safer to not
> +	 * cache it.
> +	 */
> +	regmap_reg_range(BD96801_LDO5_VOL_LVL_REG, BD96801_LDO7_VOL_LVL_REG),
> +};
> +
> +static const struct regmap_access_table volatile_regs = {
> +	.yes_ranges = bd96801_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bd96801_volatile_ranges),
> +};
> +
> +static const struct regmap_irq bd96801_intb_irqs[] = {
> +	/* STATUS SYSTEM INTB */
> +	REGMAP_IRQ_REG(BD96801_TW_STAT, 0, BD96801_TW_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_WDT_ERR_STAT, 0, BD96801_WDT_ERR_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_I2C_ERR_STAT, 0, BD96801_I2C_ERR_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_CHIP_IF_ERR_STAT, 0, BD96801_CHIP_IF_ERR_STAT_MASK),
> +	/* STATUS BUCK1 INTB */
> +	REGMAP_IRQ_REG(BD96801_BUCK1_OCPH_STAT, 1, BD96801_BUCK_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK1_OCPL_STAT, 1, BD96801_BUCK_OCPL_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK1_OCPN_STAT, 1, BD96801_BUCK_OCPN_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK1_OVD_STAT, 1, BD96801_BUCK_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK1_UVD_STAT, 1, BD96801_BUCK_UVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK1_TW_CH_STAT, 1, BD96801_BUCK_TW_CH_STAT_MASK),
> +	/* BUCK 2 INTB */
> +	REGMAP_IRQ_REG(BD96801_BUCK2_OCPH_STAT, 2, BD96801_BUCK_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK2_OCPL_STAT, 2, BD96801_BUCK_OCPL_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK2_OCPN_STAT, 2, BD96801_BUCK_OCPN_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK2_OVD_STAT, 2, BD96801_BUCK_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK2_UVD_STAT, 2, BD96801_BUCK_UVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK2_TW_CH_STAT, 2, BD96801_BUCK_TW_CH_STAT_MASK),
> +	/* BUCK 3 INTB */
> +	REGMAP_IRQ_REG(BD96801_BUCK3_OCPH_STAT, 3, BD96801_BUCK_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK3_OCPL_STAT, 3, BD96801_BUCK_OCPL_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK3_OCPN_STAT, 3, BD96801_BUCK_OCPN_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK3_OVD_STAT, 3, BD96801_BUCK_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK3_UVD_STAT, 3, BD96801_BUCK_UVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK3_TW_CH_STAT, 3, BD96801_BUCK_TW_CH_STAT_MASK),
> +	/* BUCK 4 INTB */
> +	REGMAP_IRQ_REG(BD96801_BUCK4_OCPH_STAT, 4, BD96801_BUCK_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK4_OCPL_STAT, 4, BD96801_BUCK_OCPL_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK4_OCPN_STAT, 4, BD96801_BUCK_OCPN_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK4_OVD_STAT, 4, BD96801_BUCK_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK4_UVD_STAT, 4, BD96801_BUCK_UVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_BUCK4_TW_CH_STAT, 4, BD96801_BUCK_TW_CH_STAT_MASK),
> +	/* LDO5 INTB */
> +	REGMAP_IRQ_REG(BD96801_LDO5_OCPH_STAT, 5, BD96801_LDO_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_LDO5_OVD_STAT, 5, BD96801_LDO_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_LDO5_UVD_STAT, 5, BD96801_LDO_UVD_STAT_MASK),
> +	/* LDO6 INTB */
> +	REGMAP_IRQ_REG(BD96801_LDO6_OCPH_STAT, 6, BD96801_LDO_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_LDO6_OVD_STAT, 6, BD96801_LDO_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_LDO6_UVD_STAT, 6, BD96801_LDO_UVD_STAT_MASK),
> +	/* LDO7 INTB */
> +	REGMAP_IRQ_REG(BD96801_LDO7_OCPH_STAT, 7, BD96801_LDO_OCPH_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_LDO7_OVD_STAT, 7, BD96801_LDO_OVD_STAT_MASK),
> +	REGMAP_IRQ_REG(BD96801_LDO7_UVD_STAT, 7, BD96801_LDO_UVD_STAT_MASK),
> +};
> +
> +static struct regmap_irq_chip bd96801_irq_chip_intb = {
> +	.name = "bd96801-irq-intb",
> +	.main_status = BD96801_REG_INT_MAIN,
> +	.num_main_regs = 1,
> +	.irqs = &bd96801_intb_irqs[0],
> +	.num_irqs = ARRAY_SIZE(bd96801_intb_irqs),
> +	.status_base = BD96801_REG_INT_SYS_INTB,
> +	.mask_base = BD96801_REG_MASK_SYS_INTB,
> +	.ack_base = BD96801_REG_INT_SYS_INTB,
> +	.init_ack_masked = true,
> +	.num_regs = 8,
> +	.irq_reg_stride = 1,
> +};
> +
> +static const struct regmap_config bd96801_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &volatile_regs,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int bd96801_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct regmap *regmap;
> +	int ret, intb_irq;

Nit: Pop these at the bottom.

> +	struct regmap_irq_chip_data *intb_irq_data;
> +	struct irq_domain *intb_domain;
> +	const struct fwnode_handle *fwnode;
> +
> +	fwnode = dev_fwnode(&i2c->dev);
> +	if (!fwnode)
> +		return dev_err_probe(&i2c->dev, -EINVAL, "no fwnode\n");

Make error messages consistent and clear.

"Failed to find fwnode"

> +	intb_irq = fwnode_irq_get_byname(fwnode, "intb");
> +	if (intb_irq < 0)
> +		return dev_err_probe(&i2c->dev, intb_irq, "No INTB IRQ configured\n");

I don't know what it is about the "no ..." comments that I don't like.

"INTB IRQ not configured" just sounds more professional.

> +	regmap = devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
> +				    "regmap initialization failed\n");

Your other errors start with an uppercase char.  Consistency.

> +	ret = regmap_write(regmap, BD96801_LOCK_REG, BD96801_UNLOCK);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret, "Can't unlock PMIC\n");

"Failed to ..." like everywhere else.

> +	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, intb_irq,
> +				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
> +				       &intb_irq_data);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB irq_chip\n");

"INTB IRQ chip", it's not a variable and this is user facing.

> +	intb_domain = regmap_irq_get_domain(intb_irq_data);
> +
> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				   bd96801_mfd_cells,
> +				   ARRAY_SIZE(bd96801_mfd_cells), NULL, 0,
> +				   intb_domain);
> +
> +	if (ret)
> +		dev_err(&i2c->dev, "Failed to create subdevices\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id bd96801_of_match[] = {
> +	{ .compatible = "rohm,bd96801",	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bd96801_of_match);
> +
> +static struct i2c_driver bd96801_i2c_driver = {
> +	.driver = {
> +		.name = "rohm-bd96801",
> +		.of_match_table = bd96801_of_match,
> +	},
> +	.probe = bd96801_i2c_probe,
> +};
> +
> +static int __init bd96801_i2c_init(void)
> +{
> +	return i2c_add_driver(&bd96801_i2c_driver);
> +}
> +
> +/* Initialise early so consumer devices can complete system boot? */

Why the question mark?  What are you unsure about?

Why doesn't -EPROBE_DEFER work for this?

> +subsys_initcall(bd96801_i2c_init);
> +
> +static void __exit bd96801_i2c_exit(void)
> +{
> +	i2c_del_driver(&bd96801_i2c_driver);
> +}
> +module_exit(bd96801_i2c_exit);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("ROHM BD96801 Power Management IC driver");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]

