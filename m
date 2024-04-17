Return-Path: <linux-kernel+bounces-147940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909328A7BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44341283A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA1BE4E;
	Wed, 17 Apr 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z6SX4RXI"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5474EB5C;
	Wed, 17 Apr 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330012; cv=none; b=qoMi9JRE8L835OjmxDzeFu8fQNZkdzay+3OtOTR8WcL3PCD4FY/Fu0HrKCySWGKSApwqJRKU312vVjvJqqEuY22JQCdB8mQTGP2Ze0KHMv9aDglbo1cfNo34KnOX8IOGI83mQp5smvHIZd3oPE/eta1uzkjIAx0zNb2b6pNXzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330012; c=relaxed/simple;
	bh=gQf/NvzASDZ0M4ToFluS/SITmULOuKDY5l6HFsuqtSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esp81UqQAQ/sgvquWCyTKwa0vbwyDbDIYoNcaEwKguV9HGxZA9LZUr9D05OuyqkHpzCGgI7HU/VPyfDv5sNTxzgMNgZ3CyDIBPzps5XNFDyo0ChpjigTvuCbJQmAOnqTlNOzqtKPG5M3k4Ma6mEBtH5j5UgVPgej5zaoWLEEaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z6SX4RXI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GK1tsm016891;
	Tue, 16 Apr 2024 21:29:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=N1DS92IuWebgeO+LrH6S+L
	JrkeZ68tnc5F+BwH+A7zc=; b=Z6SX4RXIcKsAgwHw+w9Wl1OK3gfLLY7fVAS85r
	CZfPaNff2LTjbdyvCCgSYQ4nyLAWFwqsVYlJTMozICv8u4AqepAeBnwgQvuqVUPs
	v7ugv1dQdlLilMjjNR+TpYxnzxCfsJhaSZdmJpJFAPi4wM1Y4w821QcVzY++pmbC
	BJzz+IDYkVCdVKJUxgAeDPZzMGsVLpq36HPjtBdwIy5NeneyPs3fK5zYjiQftiCX
	t4TltlQjdJpIXGEQttIcWspc3U8yqatEtfaCJyzIrdto3gQDmNLtpXgALzsuBeVF
	tAT+BgaYM36td9ER+8JxtbkZk4Ujr+Ai414DHAozJWUYDz0w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn4w4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 21:29:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 21:29:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 21:29:54 -0700
Received: from IPBU-BLR-SERVER1 (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with SMTP id E11163F7082;
	Tue, 16 Apr 2024 21:29:50 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:59:49 +0530
From: George Cherian <george.cherian@marvell.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones
	<lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Wim Van
 Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC PATCH v2 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <20240417042949.GA3513394@IPBU-BLR-SERVER1>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <d52fd63e98635293022e5a607fd763b580e24189.1712920132.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d52fd63e98635293022e5a607fd763b580e24189.1712920132.git.mazziesaccount@gmail.com>
X-Proofpoint-GUID: gzDIpBzbgS_dRykYWiLtKuySY3_TAn74
X-Proofpoint-ORIG-GUID: gzDIpBzbgS_dRykYWiLtKuySY3_TAn74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_03,2024-04-16_01,2023-05-22_02

On 2024-04-12 at 16:52:46, Matti Vaittinen (mazziesaccount@gmail.com) wrote:
> Introduce driver for WDG block on ROHM BD96801 scalable PMIC.
> 
> This driver only supports watchdog with I2C feeding and delayed
> response detection. Whether the watchdog toggles PRSTB pin or
> just causes an interrupt can be configured via device-tree.
> 
> The BD96801 PMIC HW supports also window watchdog (too early
> feeding detection) and Q&A mode. These are not supported by
> this driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> RFCv1 => RFCv2:
> - remove always running
> - add IRQ handling
> - call emergency_restart()
> - drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
> ---
>  drivers/watchdog/Kconfig       |  13 ++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/bd96801_wdt.c | 389 +++++++++++++++++++++++++++++++++
>  3 files changed, 403 insertions(+)
>  create mode 100644 drivers/watchdog/bd96801_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6bee137cfbe0..d97e735e1faa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -181,6 +181,19 @@ config BD957XMUF_WATCHDOG
>  	  watchdog. Alternatively say M to compile the driver as a module,
>  	  which will be called bd9576_wdt.
>  
> +config BD96801_WATCHDOG
> +	tristate "ROHM BD96801 PMIC Watchdog"
> +	depends on MFD_ROHM_BD96801
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog in the ROHM BD96801 PMIC. Watchdog can be
> +	  configured to only generate IRQ or to trigger system reset via reset
> +	  pin.
> +
> +	  Say Y here to include support for the ROHM BD96801 watchdog.
> +	  Alternatively say M to compile the driver as a module,
> +	  which will be called bd96801_wdt.
> +
>  config CROS_EC_WATCHDOG
>  	tristate "ChromeOS EC-based watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 3710c218f05e..31bc94436c81 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -217,6 +217,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>  
>  # Architecture Independent
>  obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
> +obj-$(CONFIG_BD96801_WATCHDOG) += bd96801_wdt.o
>  obj-$(CONFIG_CROS_EC_WATCHDOG) += cros_ec_wdt.o
>  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>  obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wdt.c
> new file mode 100644
> index 000000000000..08fab9a87aec
> --- /dev/null
> +++ b/drivers/watchdog/bd96801_wdt.c
> @@ -0,0 +1,389 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 ROHM Semiconductors
> + *
> + * ROHM BD96801 watchdog driver
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/rohm-bd96801.h>
> +#include <linux/mfd/rohm-generic.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +static bool nowayout;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default=\"false\")");
> +
> +#define BD96801_WD_TMO_SHORT_MASK	0x70
> +#define BD96801_WD_RATIO_MASK		0x3
> +#define BD96801_WD_TYPE_MASK		0x4
> +#define BD96801_WD_TYPE_SLOW		0x4
> +#define BD96801_WD_TYPE_WIN		0x0
> +
> +#define BD96801_WD_EN_MASK		0x3
> +#define BD96801_WD_IF_EN		0x1
> +#define BD96801_WD_QA_EN		0x2
> +#define BD96801_WD_DISABLE		0x0
> +
> +#define BD96801_WD_ASSERT_MASK		0x8
> +#define BD96801_WD_ASSERT_RST		0x8
> +#define BD96801_WD_ASSERT_IRQ		0x0
> +
> +#define BD96801_WD_FEED_MASK		0x1
> +#define BD96801_WD_FEED			0x1
> +
> +/* units in uS */
> +#define FASTNG_MIN			3370
> +#define BD96801_WDT_DEFAULT_MARGIN	6905120
> +/* Unit is seconds */
> +#define DEFAULT_TIMEOUT 30
> +
> +/*
> + * BD96801 WDG supports window mode so the TMO consists of SHORT and LONG
> + * timeout values. SHORT time is meaningfull only in window mode where feeding
> + * period shorter than SHORT would be an error. LONG time is used to detect if
> + * feeding is not occurring within given time limit (SoC SW hangs). The LONG
> + * timeout time is a multiple of (2, 4, 8 0r 16 times) the SHORT timeout.
> + */
> +
> +struct wdtbd96801 {
> +	struct device		*dev;
> +	struct regmap		*regmap;
> +	struct watchdog_device	wdt;
> +};
> +
> +static int bd96801_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct wdtbd96801 *w = watchdog_get_drvdata(wdt);
> +
> +	return regmap_update_bits(w->regmap, BD96801_REG_WD_FEED,
> +				 BD96801_WD_FEED_MASK, BD96801_WD_FEED);
> +}
> +
> +static int bd96801_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct wdtbd96801 *w = watchdog_get_drvdata(wdt);
> +	int ret;
> +
> +	ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				 BD96801_WD_EN_MASK, BD96801_WD_IF_EN);
> +
> +	return ret;
> +}
> +
> +static int bd96801_wdt_stop(struct watchdog_device *wdt)
> +{
> +	struct wdtbd96801 *w = watchdog_get_drvdata(wdt);
> +
> +	return regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				  BD96801_WD_EN_MASK, BD96801_WD_DISABLE);
> +}
> +
> +static const struct watchdog_info bd96801_wdt_info = {
> +	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
> +			  WDIOF_SETTIMEOUT,
> +	.identity	= "BD96801 Watchdog",
> +};
> +
> +static const struct watchdog_ops bd96801_wdt_ops = {
> +	.start		= bd96801_wdt_start,
> +	.stop		= bd96801_wdt_stop,
> +	.ping		= bd96801_wdt_ping,
> +};
Is there no way to setup a timeout to the WDOG device from userspace?

> +
> +static int find_closest_fast(int target, int *sel, int *val)
> +{
> +	int i;
> +	int window = FASTNG_MIN;
> +
> +	for (i = 0; i < 8 && window < target; i++)
> +		window <<= 1;
> +
> +	*val = window;
> +	*sel = i;
> +
> +	if (i == 8)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int find_closest_slow_by_fast(int fast_val, int *target, int *slowsel)
> +{
> +	int sel;
> +	static const int multipliers[] = {2, 4, 8, 16};
> +
> +	for (sel = 0; sel < ARRAY_SIZE(multipliers) &&
> +	     multipliers[sel] * fast_val < *target; sel++)
> +		;
> +
> +	if (sel == ARRAY_SIZE(multipliers))
> +		return -EINVAL;
> +
> +	*slowsel = sel;
> +	*target = multipliers[sel] * fast_val;
> +
> +	return 0;
> +}
> +
> +static int find_closest_slow(int *target, int *slow_sel, int *fast_sel)
> +{
> +	static const int multipliers[] = {2, 4, 8, 16};
> +	int i, j;
> +	int val = 0;
> +	int window = FASTNG_MIN;
> +
> +	for (i = 0; i < 8; i++) {
> +		for (j = 0; j < ARRAY_SIZE(multipliers); j++) {
> +			int slow;
> +
> +			slow = window * multipliers[j];
> +			if (slow >= *target && (!val || slow < val)) {
> +				val = slow;
> +				*fast_sel = i;
> +				*slow_sel = j;
> +			}
> +		}
> +		window <<= 1;
> +	}
> +	if (!val)
> +		return -EINVAL;
> +
> +	*target = val;
> +
> +	return 0;
> +}
> +
> +static int bd96801_set_wdt_mode(struct wdtbd96801 *w, int hw_margin,
> +			       int hw_margin_min)
> +{
> +	int ret, fastng, slowng, type, reg, mask;
> +	struct device *dev = w->dev;
> +
> +	/* convert to uS */
> +	hw_margin *= 1000;
> +	hw_margin_min *= 1000;
> +	if (hw_margin_min) {
> +		int min;
> +
> +		type = BD96801_WD_TYPE_WIN;
> +		dev_dbg(dev, "Setting type WINDOW 0x%x\n", type);
> +		ret = find_closest_fast(hw_margin_min, &fastng, &min);
> +		if (ret) {
> +			dev_err(dev, "bad WDT window for fast timeout\n");
> +			return ret;
> +		}
> +
> +		ret = find_closest_slow_by_fast(min, &hw_margin, &slowng);
> +		if (ret) {
> +			dev_err(dev, "bad WDT window\n");
> +			return ret;
> +		}
> +		w->wdt.min_hw_heartbeat_ms = min / 1000;
> +	} else {
> +		type = BD96801_WD_TYPE_SLOW;
> +		dev_dbg(dev, "Setting type SLOW 0x%x\n", type);
> +		ret = find_closest_slow(&hw_margin, &slowng, &fastng);
> +		if (ret) {
> +			dev_err(dev, "bad WDT window\n");
> +			return ret;
> +		}
> +	}
> +
> +	w->wdt.max_hw_heartbeat_ms = hw_margin / 1000;
> +
> +	fastng <<= ffs(BD96801_WD_TMO_SHORT_MASK) - 1;
> +
> +	reg = slowng | fastng;
> +	mask = BD96801_WD_RATIO_MASK | BD96801_WD_TMO_SHORT_MASK;
> +	ret = regmap_update_bits(w->regmap, BD96801_REG_WD_TMO,
> +				 mask, reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				 BD96801_WD_TYPE_MASK, type);
> +
> +	return ret;
> +}
> +
> +static int bd96801_set_heartbeat_from_hw(struct wdtbd96801 *w,
> +					 unsigned int conf_reg)
> +{
> +	int ret;
> +	unsigned int val, sel, fast;
> +
> +	/*
> +	 * The BD96801 supports a somewhat peculiar QA-mode, which we do not
> +	 * support in this driver. If the QA-mode is enabled then we just
> +	 * warn and bail-out.
> +	 */
> +	if ((conf_reg & BD96801_WD_EN_MASK) != BD96801_WD_IF_EN) {
> +		dev_warn(w->dev, "watchdog set to Q&A mode - exiting\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(w->regmap, BD96801_REG_WD_TMO, &val);
> +	if (ret)
> +		return ret;
> +
> +	sel = val & BD96801_WD_TMO_SHORT_MASK;
> +	sel >>= ffs(BD96801_WD_TMO_SHORT_MASK) - 1;
> +	fast = FASTNG_MIN << sel;
> +
> +	sel = (val & BD96801_WD_RATIO_MASK) + 1;
> +	w->wdt.max_hw_heartbeat_ms = (fast << sel) / USEC_PER_MSEC;
> +
> +	if ((conf_reg & BD96801_WD_TYPE_MASK) == BD96801_WD_TYPE_WIN)
> +		w->wdt.min_hw_heartbeat_ms = fast / USEC_PER_MSEC;
> +
> +	return 0;
> +}
> +
> +static int init_wdg_hw(struct wdtbd96801 *w)
> +{
> +	u32 hw_margin[2];
> +	int count, ret;
> +	u32 hw_margin_max = BD96801_WDT_DEFAULT_MARGIN, hw_margin_min = 0;
> +
> +	count = device_property_count_u32(w->dev->parent, "rohm,hw-timeout-ms");
Why is that timeout need to be configured from a devicce-tree property?
set_timeout/get_timeout can't be done for this device?

> +	if (count < 0 && count != -EINVAL)
> +		return count;
> +
> +	if (count > 0) {
> +		if (count > ARRAY_SIZE(hw_margin))
> +			return -EINVAL;
> +
> +		ret = device_property_read_u32_array(w->dev->parent,
> +						     "rohm,hw-timeout-ms",
> +						     &hw_margin[0], count);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (count == 1)
> +			hw_margin_max = hw_margin[0];
> +
> +		if (count == 2) {
> +			hw_margin_max = hw_margin[1];
> +			hw_margin_min = hw_margin[0];
> +		}
> +	}
> +
> +	ret = bd96801_set_wdt_mode(w, hw_margin_max, hw_margin_min);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
> +					   "prstb");
> +	if (ret >= 0) {
> +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				 BD96801_WD_ASSERT_MASK,
> +				 BD96801_WD_ASSERT_RST);
> +		return ret;
> +	}
> +
> +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
> +					   "intb-only");
> +	if (ret >= 0) {
> +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				 BD96801_WD_ASSERT_MASK,
> +				 BD96801_WD_ASSERT_IRQ);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +extern void emergency_restart(void);
> +static irqreturn_t bd96801_irq_hnd(int irq, void *data)
> +{
> +	emergency_restart();
In case of a full system hang will this function get executed?
> +	return IRQ_NONE;
> +}
> +
> +static int bd96801_wdt_probe(struct platform_device *pdev)
> +{
> +	struct wdtbd96801 *w;
> +	int ret, irq;
> +	unsigned int val;
> +
> +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	w->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	w->dev = &pdev->dev;
> +
> +	w->wdt.info = &bd96801_wdt_info;
> +	w->wdt.ops =  &bd96801_wdt_ops;
> +	w->wdt.parent = pdev->dev.parent;
> +	w->wdt.timeout = DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(&w->wdt, w);
> +
> +	ret = regmap_read(w->regmap, BD96801_REG_WD_CONF, &val);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to get the watchdog state\n");
> +
> +	/*
> +	 * If the WDG is already enabled we assume it is configured by boot.
> +	 * In this case we just update the hw-timeout based on values set to
> +	 * the timeout / mode registers and leave the hardware configs
> +	 * untouched.
> +	 */
> +	if ((val & BD96801_WD_EN_MASK) != BD96801_WD_DISABLE) {
> +		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
> +		ret = bd96801_set_heartbeat_from_hw(w, val);
> +		if (ret)
> +			return ret;
> +
> +		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
> +	} else {
> +		/* If WDG is not running so we will initializate it */
> +		ret = init_wdg_hw(w);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
> +	watchdog_set_nowayout(&w->wdt, nowayout);
> +	watchdog_stop_on_reboot(&w->wdt);
> +
> +	irq = platform_get_irq_byname(pdev, "bd96801-wdg");
> +	if (irq > 0) {
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						bd96801_irq_hnd,
> +						IRQF_ONESHOT,  "bd96801-wdg",
> +						NULL);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to register IRQ\n");
> +	}
> +
> +	return devm_watchdog_register_device(&pdev->dev, &w->wdt);
> +}
> +
> +static const struct platform_device_id bd96801_wdt_id[] = {
> +	{ "bd96801-wdt", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, bd96801_wdt_id);
> +
> +static struct platform_driver bd96801_wdt = {
> +	.driver = {
> +		.name = "bd96801-wdt"
> +	},
> +	.probe = bd96801_wdt_probe,
> +	.id_table = bd96801_wdt_id,
> +};
> +module_platform_driver(bd96801_wdt);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("BD96801 watchdog driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.2
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 

-George

