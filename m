Return-Path: <linux-kernel+bounces-83721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E13869DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B21F22F63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2000C14F982;
	Tue, 27 Feb 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+OwZAEz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3814EFE5;
	Tue, 27 Feb 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054839; cv=none; b=Kodwnzsbb9G7R+iqBgUj09Xc+M67wuwopTCJ5WoqO6Asc3ZevjoHhp4oVUxT8Kad/i5/nNcTE8v6EZR/hEdw+SD23Cv4XIty/VEOAuPt7fdcV8EHFknHagP8utEOtSCMVyaqOpoTjALv3lnhBVZx4jZUGpK8YOxURrZPwlkt3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054839; c=relaxed/simple;
	bh=Od/aOIUhXMgq1P7yVBIO6sixyOR8bW29D/1S1PNOxd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2epYJGQ6JiaualC2bdzh2WdnhdExAWr+kgHHm6+fBXBaGdt8/ZXiOvjQuLIC4oO+fLsXiIkUK9RFUA4wx3SoAHcJMinFHSaKALr865r14N0G4oIHWyMhDEMx9YCmyUH1PCH+5W1Llg5wORBWOZV7Uxczv7qf2FHChRjA6XqMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+OwZAEz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709054838; x=1740590838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Od/aOIUhXMgq1P7yVBIO6sixyOR8bW29D/1S1PNOxd8=;
  b=R+OwZAEznz09ttdkshqpYka9lPBMT4XwaEQBYfoGk1xZ/1LMihOJ1LLG
   Ps/SMj0nodo0xt7IC0kwak4sDFvEkEp3/YErj34jwhRSeyE3ATSnD3p3x
   o6ROfxS6EZYWI6sqflFiOIQHCCKZYKVvz/UECJ6kQFS8Up3GEGqeWhiUC
   H8L8JHjejg2F6ffTr4L0ugMotowklMYsl3YvwVwwvkFkibyUhNAE0/tRG
   jU7jYpYPP0I48MnE+811ZsRsu268wmt60G/7M4mDlGNtFf+/4X3j2nYly
   FKcZm2NakzTOHSwq3Intja2hk693uCIpROgLwL8UpxmQBnFm/MFyNml6W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7222890"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7222890"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913917737"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913917737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:27:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rf1ES-000000080WA-3mKT;
	Tue, 27 Feb 2024 19:27:08 +0200
Date: Tue, 27 Feb 2024 19:27:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
Message-ID: <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 03:55:25PM +0100, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 reset controller driver. It belongs to a syscon
> region called OLB. It might grow to add later support of other
> platforms from Mobileye.

..

The inclusion block is a semi-random. Please, follow IWYU principle.

+ array_size.h
+ bits.h
+ bug.h
+ container_of.h

> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

+ device.h
+ err.h
+ io.h
+ lockdep.h

+ mod_devicetable.h

> +#include <linux/mutex.h>

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

Are all of them in use?

> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>

+ types.h

..

> +/* Vendor-provided timeout values. D1 has a long timeout because of LBIST. */
> +#define D0_TIMEOUT_POLL			10
> +#define D1_TIMEOUT_POLL			40000

We use units as suffixes. The above doesn't tell magnitude of timeouts.

Also constants like USEC_PER_MSEC are useful to make code robust.

..

> +	unsigned int val, mask;
> +	int i;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		for (i = 0; i < D0_TIMEOUT_POLL; i++) {
> +			val = readl(priv->base_d0 + D0_SARCR1);
> +			val = !(val & BIT(offset));
> +			if (val == assert)
> +				return 0;
> +			udelay(1);
> +		}
> +		break;

See what iopoll.h gives you.

> +	case 1:
> +		mask = assert ? D1_ACRP_ST_POWER_DOWN : D1_ACRP_ST_ACTIVE;
> +		for (i = 0; i < D1_TIMEOUT_POLL; i++) {
> +			val = readl(priv->base_d1 + 4 * offset);
> +			if (val & mask)
> +				return 0;
> +			udelay(1);
> +		}

Ditto.

> +		break;
> +	case 2:
> +		return 0; /* No busy waiting for domain 2. */
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}

> +	dev_dbg(dev, "%u-%u: timeout\n", domain, offset);

> +	return -ETIMEDOUT;

..

> +static void eq5r_assert_withlock(struct eq5r_private *priv, u32 domain,
> +				 u32 offset)
> +{
> +	void __iomem *reg;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		reg = priv->base_d0 + D0_SARCR0;
> +		writel(readl(reg) & ~BIT(offset), reg);
> +		break;
> +	case 1:
> +		reg = priv->base_d1 + 4 * offset;
> +		writel(readl(reg) | D1_ACRP_PD_REQ, reg);
> +		break;
> +	case 2:
> +		reg = priv->base_d2;
> +		writel(readl(reg) & ~BIT(offset), reg);
> +		break;
> +	default:
> +		WARN_ON(1);

break;

> +	}
> +}
> +
> +static int eq5r_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct eq5r_private *priv = rcdev_to_priv(rcdev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;
> +
> +	dev_dbg(rcdev->dev, "%u-%u: assert request\n", domain, offset);
> +
> +	guard(mutex)(&priv->mutexes[domain]);
> +	eq5r_assert_withlock(priv, domain, offset);
> +	return eq5r_busy_wait_withlock(priv, rcdev->dev, domain, offset, true);
> +}
> +
> +static void eq5r_deassert_withlock(struct eq5r_private *priv, u32 domain,
> +				   u32 offset)
> +{
> +	void __iomem *reg;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		reg = priv->base_d0 + D0_SARCR0;
> +		writel(readl(reg) | BIT(offset), reg);
> +		break;
> +	case 1:
> +		reg = priv->base_d1 + 4 * offset;
> +		writel(readl(reg) & ~D1_ACRP_PD_REQ, reg);
> +		break;
> +	case 2:
> +		reg = priv->base_d2;
> +		writel(readl(reg) | BIT(offset), reg);
> +		break;
> +	default:
> +		WARN_ON(1);

break;

> +	}
> +}

..

> +static int eq5r_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct eq5r_private *priv = rcdev_to_priv(rcdev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;

Perhaps

	u32 offset = (id & GENMASK(7, 0)) >> 0;
	u32 domain = (id & GENMASK(31, 8)) >> 8;

for better understanding the split?

> +	dev_dbg(rcdev->dev, "%u-%u: deassert request\n", domain, offset);
> +
> +	guard(mutex)(&priv->mutexes[domain]);
> +	eq5r_deassert_withlock(priv, domain, offset);
> +	return eq5r_busy_wait_withlock(priv, rcdev->dev, domain, offset, false);

withlock is not usual naming pattern, "locked" is shorter and widely used.

> +}
> +
> +static int eq5r_status(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct eq5r_private *priv = rcdev_to_priv(rcdev);
> +	u32 offset = id & GENMASK(7, 0);
> +	u32 domain = id >> 8;

Ditto.

> +	u32 val;
> +
> +	dev_dbg(rcdev->dev, "%u-%u: status request\n", domain, offset);
> +
> +	guard(mutex)(&priv->mutexes[domain]);
> +
> +	switch (domain) {
> +	case 0:
> +		val = readl(priv->base_d0 + D0_SARCR1);
> +		return !(val & BIT(offset));
> +	case 1:
> +		val = readl(priv->base_d1 + 4 * offset);
> +		return !(val & D1_ACRP_ST_ACTIVE);
> +	case 2:
> +		val = readl(priv->base_d2);
> +		return !(val & BIT(offset));
> +	default:
> +		return -EINVAL;
> +	}
> +}

..

> +	struct eq5r_private *priv;
> +	int ret, i;

Why is i signed?

> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base_d0 = devm_platform_ioremap_resource_byname(pdev, "d0");
> +	if (IS_ERR(priv->base_d0))
> +		return PTR_ERR(priv->base_d0);
> +
> +	priv->base_d1 = devm_platform_ioremap_resource_byname(pdev, "d1");
> +	if (IS_ERR(priv->base_d1))
> +		return PTR_ERR(priv->base_d1);
> +
> +	priv->base_d2 = devm_platform_ioremap_resource_byname(pdev, "d2");
> +	if (IS_ERR(priv->base_d2))
> +		return PTR_ERR(priv->base_d2);
> +
> +	for (i = 0; i < EQ5R_DOMAIN_COUNT; i++)
> +		mutex_init(&priv->mutexes[i]);
> +
> +	priv->rcdev.ops = &eq5r_ops;
> +	priv->rcdev.owner = THIS_MODULE;
> +	priv->rcdev.dev = dev;

> +	priv->rcdev.of_node = np;

It's better to use device_set_node().

> +	priv->rcdev.of_reset_n_cells = 2;
> +	priv->rcdev.of_xlate = eq5r_of_xlate;
> +
> +	priv->rcdev.nr_resets = 0;
> +	for (i = 0; i < EQ5R_DOMAIN_COUNT; i++)

> +		priv->rcdev.nr_resets += __builtin_popcount(eq5r_valid_masks[i]);

Please, use corresponding hweightXX() API.

> +	ret = devm_reset_controller_register(dev, &priv->rcdev);
> +	if (ret) {

> +		dev_err(dev, "Failed registering reset controller: %d\n", ret);
> +		return ret;

		return dev_err_probe(...);

> +	}
> +
> +	return 0;
> +}

..

> +static struct platform_driver eq5r_driver = {
> +	.probe = eq5r_probe,
> +	.driver = {
> +		.name = "eyeq5-reset",
> +		.of_match_table = eq5r_match_table,
> +	},
> +};

> +

Unneeded blank line.

> +builtin_platform_driver(eq5r_driver);

-- 
With Best Regards,
Andy Shevchenko



