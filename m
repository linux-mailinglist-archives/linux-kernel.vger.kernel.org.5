Return-Path: <linux-kernel+bounces-164364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA88B7CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2A1C223C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCF179641;
	Tue, 30 Apr 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2kpHrDt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218C175551;
	Tue, 30 Apr 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494289; cv=none; b=HdEj1vXVnxSkXIv1A4mWZxhJvBRUK1gqv4YT1PwyhpRxkvPb86HjalHXUrQHEpbzBB3Ec7b22Wc3w7gMgu7WbJ336RjIPR/jLXQehwY6Yb5DceJjiuQc0ChCbT1Sks3blnEjExmhkVdhmHqTNm24iM411DWD8phvXF+knGpEBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494289; c=relaxed/simple;
	bh=KYqUEMR15dbVUBMBmYpe4FGD6JeH9VEM4po943dtKY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO40XYqELQixI4Ix3+iUfotQt3C9Sdahj+F13h1joFS1N3QFwrjUlo6zQJXg2khkdyrfSTOevywxs/gxW0suLeMGEsYOWK0avqXJTDy4O0bIslQ6aQsns6UFG2OOiQw+MsP4+wbifdD0YIuRoY7dzyUbZVEDo2EXSxk33McO6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2kpHrDt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so5928956b3a.2;
        Tue, 30 Apr 2024 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494287; x=1715099087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CmU6vdJlFujJwI/d3JQdfrcSGSioWDIcd97I629VQgA=;
        b=K2kpHrDt4hsxK8EVEVbjbHwL39pllcnw9uKxBB42po5/GQw9zpSir5WvDYV1EqUu0x
         /nksj5VVLTncRjE5DRR2RVDS5dbuc+3fFPDtsmiod7bGl9GTzCbYqgoBZB05C/AbgauY
         ju5THEFsZCs1uG0JmkNNoITJoTG3Mza64vWgSgG8sER1QS7821iqNO6F27AWvkBidcPf
         zvl+qZItfGtMt0wavIetIcUrUEf7SDdVZiA7iko+b5LodfzNVOZscxw9WBtyRToTt2LF
         OU0Xp/VxGU48CKb3pOPKbaMXlrMhWX6xz9NTbO7re8ades+O7SlZ1N0lX02koVpONt+e
         d3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494287; x=1715099087;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmU6vdJlFujJwI/d3JQdfrcSGSioWDIcd97I629VQgA=;
        b=G+f6punj4OdmebHjDrnEPLxFa0GKdLeXq2Zg/ZS7iQdKt5jiScxDl8Vgyk2O/P2vgp
         CQ4E9oogr8YOSw/fE3U7fz3bBKY/ZreNghvQjKt5jflIjqviSzuaNnVQEJNuYMah+lvn
         o3QDrNv76+vBGIVd79TdUHVAQsa1C8HAUU1ptBDxw45fCeDMXAye2BYzF9CS4vtAVceq
         3kMbYWspBf7KuIxGDaRjrneNAYsblhbpWRWZRpurCrhKvB8wTjKndy+22FP05bplIHZn
         3mMMlwEWzw0EVr53jLACjOvmFBZ0/B+0vwV+Hjp4C0fGg/m8fRFEpGml49D2k7bIY74b
         M6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXAqy5KANV/r/d9TVgovNDg7DWtS64mbg0kZRBWL0Gvc53eQD4ornuGauEiJUScP7InORGiBFZT65vjeRr5qfB+uyledOF6sNFWKS6QGypmWKV+gYj7MqWMIjSAJD/lZUBaYnQipBoSpeYfol0sUnw3nYEt3ZUr3gSnumZFQUfADONmvvdcoZU7
X-Gm-Message-State: AOJu0Yx/Z5jaPaw/GwA8GblLWFA5joJoh83X4v6DTIQJNSk9T+uUumkr
	k1lk1UYbhyly7Yde3FmdmPyRMWtI4FWY9PknBQLK++evGdhfYLmg
X-Google-Smtp-Source: AGHT+IEML/4Wwr3ReF1BiZsCHw7WLQSCiXUu8zG9jkMCjWhqJsUxcuCeQEYVXBaQoNj4w7+g2vyRcg==
X-Received: by 2002:a05:6a20:ddaf:b0:1af:5451:d00c with SMTP id kw47-20020a056a20ddaf00b001af5451d00cmr362789pzb.32.1714494286399;
        Tue, 30 Apr 2024 09:24:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nb16-20020a17090b35d000b002af8056917csm10551808pjb.29.2024.04.30.09.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:24:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4c67e76-fad8-47bc-a9f8-29cc5630bc7b@roeck-us.net>
Date: Tue, 30 Apr 2024 09:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] watchdog: ROHM BD96801 PMIC WDG driver
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <d1d5429e4a34a06af0ceb853d72344cf9b8ae67c.1714478142.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <d1d5429e4a34a06af0ceb853d72344cf9b8ae67c.1714478142.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 05:01, Matti Vaittinen wrote:
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
> RFCv2 => v1:
> - Fix watchdog time-outs to match DS4
> - Fix target timeout overflow
> - Improve dbg prints
> 
> RFCv1 => RFCv2:
> - remove always running
> - add IRQ handling
> - call emergency_restart()
> - drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
> ---
>   drivers/watchdog/Kconfig       |  13 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/bd96801_wdt.c | 400 +++++++++++++++++++++++++++++++++
>   3 files changed, 414 insertions(+)
>   create mode 100644 drivers/watchdog/bd96801_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6bee137cfbe0..d97e735e1faa 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -181,6 +181,19 @@ config BD957XMUF_WATCHDOG
>   	  watchdog. Alternatively say M to compile the driver as a module,
>   	  which will be called bd9576_wdt.
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
>   config CROS_EC_WATCHDOG
>   	tristate "ChromeOS EC-based watchdog"
>   	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 3710c218f05e..31bc94436c81 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -217,6 +217,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>   
>   # Architecture Independent
>   obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
> +obj-$(CONFIG_BD96801_WATCHDOG) += bd96801_wdt.o
>   obj-$(CONFIG_CROS_EC_WATCHDOG) += cros_ec_wdt.o
>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>   obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wdt.c
> new file mode 100644
> index 000000000000..6069f1d75356
> --- /dev/null
> +++ b/drivers/watchdog/bd96801_wdt.c
> @@ -0,0 +1,400 @@
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
> +#define FASTNG_MIN			11
> +
> +#define BD96801_WDT_DEFAULT_MARGIN_MS	1843
> +/* Unit is seconds */
> +#define DEFAULT_TIMEOUT 30
> +
> +/*
> + * BD96801 WDG supports window mode so the TMO consists of SHORT and LONG
> + * timeout values. SHORT time is meaningfull only in window mode where feeding

meaningful

> + * period shorter than SHORT would be an error. LONG time is used to detect if
> + * feeding is not occurring within given time limit (SoC SW hangs). The LONG
> + * timeout time is a multiple of (2, 4, 8 0r 16 times) the SHORT timeout.

0r -> or

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
> +				  BD96801_WD_FEED_MASK, BD96801_WD_FEED);
> +}
> +
> +static int bd96801_wdt_start(struct watchdog_device *wdt)
> +{
> +	struct wdtbd96801 *w = watchdog_get_drvdata(wdt);
> +
> +	return regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
> +				  BD96801_WD_EN_MASK, BD96801_WD_IF_EN);
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
> +
> +static int find_closest_fast(unsigned int target, int *sel, unsigned int *val)
> +{
> +	unsigned int window = FASTNG_MIN;
> +	int i;
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

It might make sense to have the error check before assigning return values,
similar to the other find functions.

> +	return 0;
> +}
> +
> +static int find_closest_slow_by_fast(unsigned int fast_val, unsigned int *target, int *slowsel)
> +{
> +	static const int multipliers[] = {2, 4, 8, 16};
> +	int sel;
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
> +static int find_closest_slow(unsigned int *target, int *slow_sel, int *fast_sel)
> +{
> +	static const int multipliers[] = {2, 4, 8, 16};
> +	unsigned int window = FASTNG_MIN;
> +	unsigned int val = 0;
> +	int i, j;
> +
> +	for (i = 0; i < 8; i++) {
> +		for (j = 0; j < ARRAY_SIZE(multipliers); j++) {
> +			unsigned int slow;
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
> +static int bd96801_set_wdt_mode(struct wdtbd96801 *w, unsigned int hw_margin,
> +			       unsigned int hw_margin_min)
> +{
> +	int fastng, slowng, type, ret, reg, mask;
> +	struct device *dev = w->dev;
> +
> +	/*
> +	 * Convert to 100uS to guarantee reasonable timeouts fit in
> +	 * 32bit maintaining also a decent accuracy.
> +	 */
> +	hw_margin *= 10;
> +	hw_margin_min *= 10;
> +
> +	if (hw_margin_min) {
> +		unsigned int min;
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
> +		w->wdt.min_hw_heartbeat_ms = min / 10;
> +	} else {
> +		type = BD96801_WD_TYPE_SLOW;
> +		dev_dbg(dev, "Setting type SLOW 0x%x\n", type);
> +		ret = find_closest_slow(&hw_margin, &slowng, &fastng);
> +		if (ret) {
> +			dev_err(dev, "bad WDT window\n");

What is the value of those error messages ? To me they only leave big
question marks. One would see "bad WDT window" or "bad WDT window for
fast timeout" and then what ? If the cause is bad values for hw_margin
and/or hw_margin_min, the message should include the offending values
and not leave the user in the dark.

> +			return ret;
> +		}
> +	}
> +
> +	w->wdt.max_hw_heartbeat_ms = hw_margin / 10;
> +
> +	fastng <<= ffs(BD96801_WD_TMO_SHORT_MASK) - 1;

Any reason fore not using standard functionality such as FIELD_PREP here ?

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

This should be dev_err(). It is not just a warning.

> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(w->regmap, BD96801_REG_WD_TMO, &val);
> +	if (ret)
> +		return ret;
> +
> +	sel = val & BD96801_WD_TMO_SHORT_MASK;
> +	sel >>= ffs(BD96801_WD_TMO_SHORT_MASK) - 1;

Same question as above: Why not use FIELD_GET() ?

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
> +	u32 hw_margin_max = BD96801_WDT_DEFAULT_MARGIN_MS, hw_margin_min = 0;
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
> +			if (hw_margin[1] > hw_margin[0]) {
> +				hw_margin_max = hw_margin[1];
> +				hw_margin_min = hw_margin[0];
> +			} else {
> +				hw_margin_max = hw_margin[0];
> +				hw_margin_min = hw_margin[1];
> +			}
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

No. include linux/reboot.h instead.

> +static irqreturn_t bd96801_irq_hnd(int irq, void *data)
> +{
> +	emergency_restart();
> +
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
> +	dev_dbg(w->dev, "heartbeat set to %u - %u\n",
> +		w->wdt.min_hw_heartbeat_ms, w->wdt.max_hw_heartbeat_ms);
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


