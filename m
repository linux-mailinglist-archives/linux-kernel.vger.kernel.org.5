Return-Path: <linux-kernel+bounces-128410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26474895A72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C971C22B12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F415A487;
	Tue,  2 Apr 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx902Dz+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164914C5B0;
	Tue,  2 Apr 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077920; cv=none; b=YZNU4Pzi2ZitE0i4RKb8ZzrXayAq3cDRYgsfhBUwnouH3Q77UIH2ZFu+Jlquco+aWB1YdXlAiyeaWBB20TQP0/DrbnmEm+oswnk3wjcs93tzcCLsT3jV6hgxxDdvHYZ36JPoFXNemddRMnrlWyud6Og3wrJklQY5SQHJ7PAroQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077920; c=relaxed/simple;
	bh=0zJ07GtE8Z+R/yA0lO0SSNk86rOyr3giL8sz02OHztg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8VofxWbypVPKv62S/XuEicIHbF4VgtbxvEB/gLkXf0b0RivroCXz88znVAdT1cEHhPsoIyk84d//LqTqqLCv8+OszBZg4y3V3QnrKkcYAx5ySju2wWwedGesszFoy7XsepIhuoVBR+N1t92sg4jKKjKHmI9BpV347ODIikQEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx902Dz+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6b22af648so71830b3a.0;
        Tue, 02 Apr 2024 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712077917; x=1712682717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfReLMzac6x2jfYmM6avczW4iSlMJFFCtIz8GzvXYCM=;
        b=Gx902Dz+WWaH0SYyoK9yfAVfuNTigT5m1XLIiwh4V9Sb2gBQHB2XZM08mWxrmuqj9K
         Sufehlvb2uDzzcscsrLbDs6PlIodR2XLvWQHpWPTM842KH1fdCj3iLtYNMXEAzqvPQtr
         pSoEdf4UeJ6b4qWk+4oaVZwG/1IZ1WbQQYQYoPL4uj1yDZcwBkIqHHkyBqDoa8Zr2oKc
         tVrgvOkUkmv5gP5i/NVs4oFtuPb3rpp/9z3mgbFGtd0327HEx/hmEOsiyyYf3c4EWpq/
         7HxIUN+AwogVAmm+e/XHMmKSMqClBhjaqUjmrHOKnuQEhGW7FYB4Z8xQPhP2JnjKp7sO
         pYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712077917; x=1712682717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfReLMzac6x2jfYmM6avczW4iSlMJFFCtIz8GzvXYCM=;
        b=qM+xLfrEBlWcBWki0XLC3ybrRwy7WqjoOieov7+nCpYRHHymKXxhbGjwfk+0nqL5FG
         CMpe8KimnYx/sfX18rvWie7AsyQUnJJ6cDRmgho0EecoPbfWeUET8+WynR7yucozmwiq
         jV+VPAhsohWVTmmd4F3AeS7UyXMa5t2eCvcM1S0ZGYR0hHET/Q3zRCaqblTqgrjo810e
         On5lXeAIxbAxM3MJRTQMwtvSzgQt2EkknRUgOa226VS3gOWuSMyr7UNR/tQGDyVNPNnX
         0pVOpSrn5U9NSt0HfjC6uVcEnIQOuUf8ExLIgZq+7oVM0NddC875DxyADdCaS8HoyJGg
         Oq/w==
X-Forwarded-Encrypted: i=1; AJvYcCVEJIeeSAfjP3zRbja2ZpQ29dSDe0xCA+30sHo2Rmk6fw0KDAI4n+RJG81ZdwudtU54CF6Z8zLL1RttTDW+5MUz+DIA18dj5ol2z+r99ZhLPCy7NGBaDilG1i5qjk3EQjKvR/G2Tfn2190qOMSa4FisgQDgNchhGkI9f3xfmvNKWjJsgow9jrmW
X-Gm-Message-State: AOJu0YwbudW1aRdZSSv99j+Ikz3+39NNUjuwd0x5/t8xTISODdraRGKb
	55X7ObHNECMVmyWVdqfmlPoG8v20oJUFf2LrOY+wv1KqTOWJheuF
X-Google-Smtp-Source: AGHT+IEHQJsnPLvOgzzbTqcaihdz7JucQcSLVDFyzzfpX5MhpAZyFe2sjOarFQIq6oxbGEku2wsfpw==
X-Received: by 2002:a05:6a20:7295:b0:1a5:7437:53b4 with SMTP id o21-20020a056a20729500b001a5743753b4mr153727pzk.26.1712077916500;
        Tue, 02 Apr 2024 10:11:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fk12-20020a056a003a8c00b006ea858e6e78sm10077579pfb.45.2024.04.02.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:11:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Apr 2024 10:11:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Message-ID: <4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>

On Tue, Apr 02, 2024 at 04:11:41PM +0300, Matti Vaittinen wrote:
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
> ---
>  drivers/watchdog/Kconfig       |  13 ++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/bd96801_wdt.c | 375 +++++++++++++++++++++++++++++++++
>  3 files changed, 389 insertions(+)
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
> index 000000000000..cb2b526ecc21
> --- /dev/null
> +++ b/drivers/watchdog/bd96801_wdt.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 ROHM Semiconductors
> + *
> + * ROHM BD96801 watchdog driver
> + */
> +
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
> +	bool			always_running;
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
> +	if (!w->always_running)
> +		return regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				 BD96801_WD_EN_MASK, BD96801_WD_DISABLE);
> +	set_bit(WDOG_HW_RUNNING, &wdt->status);
> +
> +	return 0;
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

I don't see the devicetree bindings documented in the series.

I am also a bit surprised that the interrupt isn't handled in the driver.
Please explain.

> +
> +	return 0;
> +}
> +
> +static int bd96801_wdt_probe(struct platform_device *pdev)
> +{
> +	struct wdtbd96801 *w;
> +	int ret;
> +	unsigned int val;
> +
> +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	w->regmap = dev_get_regmap(pdev->dev.parent, NULL);

dev_get_regmap() can return NULL.

> +	w->dev = &pdev->dev;
> +
> +	w->wdt.info = &bd96801_wdt_info;
> +	w->wdt.ops =  &bd96801_wdt_ops;
> +	w->wdt.parent = pdev->dev.parent;
> +	w->wdt.timeout = DEFAULT_TIMEOUT;
> +	watchdog_set_drvdata(&w->wdt, w);
> +
> +	w->always_running = device_property_read_bool(pdev->dev.parent,
> +						      "always-running");
> +
Without documentation, it looks like the always-running (from
linux,wdt-gpio.yaml) may be abused. Its defined meaning is
"the watchdog is always running and can not be stopped". Its
use here seems to be "start watchdog when loading the module and
prevent it from being stopped". 

Oh well, looks like the abuse was introduced with bd9576_wdt. That
doesn't make it better. At the very least it needs to be documented
that the property does not have the intended (documented) meaning.

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
> +	if (w->always_running)
> +		bd96801_wdt_start(&w->wdt);

I think this needs to set WDOG_HW_RUNNING or the watchdog will trigger
a reboot if the watchdog device is not opened and the watchdog wasn't
already running when the module was loaded.

That makes me wonder what happens if the property is set and the
watchdog daemon isn't started in the bd9576_wdt driver.

> +
> +	return devm_watchdog_register_device(&pdev->dev, &w->wdt);
> +}
> +
> +static struct platform_driver bd96801_wdt = {
> +	.driver = {
> +		.name = "bd96801-wdt"
> +	},
> +	.probe = bd96801_wdt_probe,
> +};
> +module_platform_driver(bd96801_wdt);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("BD96801 watchdog driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:bd96801-wdt");
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



