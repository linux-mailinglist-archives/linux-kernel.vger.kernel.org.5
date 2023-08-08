Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A069773C02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHHP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjHHP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF165FD3;
        Tue,  8 Aug 2023 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509445; x=1723045445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zyD+ajr6NN5YlOrvbgVfRuP+pFxH01sxrRC+U5rKAek=;
  b=IP4UgZl6i5jKSc+djele6I0GX5nIWR0QxnCHFcMhartue2thUALn7nu9
   Qce+gCP3D9D9r8YdJjes327rWdgXQ8JvlKWKZey3XAr1p6Aapf1IEQqeY
   Wf8/vFGIY42lX6cJYK219SUKUhX4SN4wFMmVr4/sQSVo5VLS4vv2IWJ4Y
   otuPF4dhjNdTEey8+Kp6t6wY+hoD1a8Tl5dAWziqhD0U9EChtLDbqyZeE
   gW1jpUID+qj51ghSOh4Pk/Z92PtFjNf8IGFezevo8dK2NyWvTgpg8nfxd
   QnuQKNd/+pARJIsRtutBIyAO9CM+xfzO8Pc8XdEqhwo9iP9xjnMraCYzl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457213606"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457213606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="905219727"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="905219727"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2023 06:51:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTN7c-00AYjE-0P;
        Tue, 08 Aug 2023 16:51:40 +0300
Date:   Tue, 8 Aug 2023 16:51:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Message-ID: <ZNJIa+CbmvDuKq2L@smile.fi.intel.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:25:01PM +0800, Wenhua Lin wrote:
> Add matrix keypad driver, support matrix keypad function.

Bindings should be prerequisite to this, meaning this has to be a series of
two patches.

...

> +	help
> +	  Keypad controller is used to interface a SoC with a matrix-keypad device,
> +	  The keypad controller supports multiple row and column lines.
> +	  Say Y if you want to use the SPRD keyboard.
> +	  Say M if you want to use the SPRD keyboard on SoC as module.

What will be the module name?

...

>  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+= st-keyscan.o
>  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)	+= sun4i-lradc-keys.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
> +obj-$(CONFIG_KEYBOARD_SPRD)		+= sprd_keypad.o

Are you sure it's ordered correctly?

>  obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
>  obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
>  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)	+= tm2-touchkey.o

...

> +/*
> + * Copyright (C) 2018 Spreadtrum Communications Inc.
> + */

A single line

...

Missing bits.h at least.
Revisit you header inclusion block to add exactly what you are using.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>

> +#include <linux/of.h>

Why?

> +#include <linux/input.h>

Order please?

...

> +#define SPRD_KPD_CTRL			0x0
> +#define SPRD_KPD_INT_EN			0x4
> +#define SPRD_KPD_INT_RAW_STATUS		0x8
> +#define SPRD_KPD_INT_MASK_STATUS	0xc

Use fixed width for register offset, like 0x00.

...

> +#define SPRD_DEF_LONG_KEY_MS		1000

	(1 * MSEC_PER_SEC)

?

...

> +struct sprd_keypad_data {
> +	u32 rows_en; /* enabled rows bits */
> +	u32 cols_en; /* enabled cols bits */

Why not bitmaps?

> +	u32 num_rows;
> +	u32 num_cols;
> +	u32 capabilities;
> +	u32 debounce_ms;
> +	void __iomem *base;
> +	struct input_dev *input_dev;
> +	struct clk *enable;
> +	struct clk *rtc;
> +};

...

> +	/*

> +	 * y(ms) = (x + 1) * array_size
> +	 *		/ (32.768 / (clk_div_num + 1))

One line.

+	 * Where:

> +	 * y means time in ms
> +	 * x means counter
> +	 * array_size equal to rows * columns
> +	 * clk_div_num is devider to keypad source clock
> +	 **/

Single asterisk is enough.

...

> +	value = value / (1000 * array_size *

value /= ... ?

MSEC_PER_SEC ?

> +			(SPRD_DEF_DIV_CNT + 1));

One line.

...

> +	if (value >= 1)
> +		value -= 1;

	if (value)
		value--;

...

> +	value = (((data->rows_en << SPRD_KPD_ROWS_SHIFT)
> +		| (data->cols_en << SPRD_KPD_COLS_SHIFT))
> +		& (SPRD_KPD_ROWS_MSK | SPRD_KPD_COLS_MSK))
> +		| SPRD_KPD_EN | SPRD_KPD_SLEEP_EN;

Move | & etc on previous lines respectively.

...

> +static int __maybe_unused sprd_keypad_suspend(struct device *dev)

No __maybe_unused.

...

> +static int __maybe_unused sprd_keypad_resume(struct device *dev)

Ditto.

...

> +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> +			sprd_keypad_suspend, sprd_keypad_resume);

Use new DEFINE_*() PM macro.

...

> +static int sprd_keypad_parse_dt(struct device *dev)

dt -> fw

...

> +	if (data->num_rows > SPRD_KPD_ROWS_MAX
> +		|| data->num_cols > SPRD_KPD_COLS_MAX) {

Move the || to the previous line.

> +		dev_err(dev, "invalid num_rows or num_cols\n");
> +		return -EINVAL;
> +	}

...

> +	ret = of_property_read_u32(np, "debounce-interval", &data->debounce_ms);

device_property_...()

> +	if (ret) {
> +		data->debounce_ms = 5;

> +		dev_warn(dev, "parse debounce-interval failed.\n");

Why do we need this message?

> +	}

...

> +	if (of_get_property(np, "linux,repeat", NULL))
> +		data->capabilities |= SPRD_CAP_REPEAT;
> +	if (of_get_property(np, "sprd,support_long_key", NULL))
> +		data->capabilities |= SPRD_CAP_LONG_KEY;
> +	if (of_get_property(np, "wakeup-source", NULL))
> +		data->capabilities |= SPRD_CAP_WAKEUP;

device_property_*()

And I'm wondering if input subsystem already does this for you.

...

> +	data->enable = devm_clk_get(dev, "enable");
> +	if (IS_ERR(data->enable)) {
> +		if (PTR_ERR(data->enable) != -EPROBE_DEFER)
> +			dev_err(dev, "get enable clk failed.\n");
> +		return PTR_ERR(data->enable);
> +	}
> +
> +	data->rtc = devm_clk_get(dev, "rtc");
> +	if (IS_ERR(data->rtc)) {
> +		if (PTR_ERR(data->enable) != -EPROBE_DEFER)
> +			dev_err(dev, "get rtc clk failed.\n");
> +		return PTR_ERR(data->rtc);
> +	}

Why not bulk?
Why not _enabled() variant?

> +	return 0;
> +}

...

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);

devm_platform_ioremap_resource()

> +	if (IS_ERR(data->base)) {

> +		dev_err(&pdev->dev, "ioremap resource failed.\n");

Dup message.

> +		ret =  PTR_ERR(data->base);
> +		goto err_free;
> +	}

...

> +	data->input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (IS_ERR(data->input_dev)) {
> +		dev_err(&pdev->dev, "alloc input dev failed.\n");
> +		ret =  PTR_ERR(data->input_dev);

Too many spaces.

> +		goto err_free;

Here and elsewhere in ->probe() use return dev_err_probe() approach as Dmitry
nowadays is okay with that.

> +	}

...

> +	ret = matrix_keypad_build_keymap(NULL, NULL, data->num_rows,
> +					 data->num_cols, NULL, data->input_dev);

Reindent this to be split logically.

> +	if (ret) {
> +		dev_err(&pdev->dev, "keypad build keymap failed.\n");
> +		goto err_free;
> +	}

...

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {

> +		dev_err(&pdev->dev, "platform get irq failed.\n");

Dup message.

> +		goto clk_free;
> +	}

...

> +clk_free:
> +	sprd_keypad_disable(data);

See above how this can be avoided.

...

> +err_free:
> +	devm_kfree(&pdev->dev, data);

Huh?!

> +	return ret;

...

> +static const struct of_device_id sprd_keypad_match[] = {
> +	{ .compatible = "sprd,sc9860-keypad", },
> +	{},

No comma for the terminator.

> +};

...

> +static struct platform_driver sprd_keypad_driver = {
> +	.driver = {
> +		.name = "sprd-keypad",

> +		.owner = THIS_MODULE,

~15 years this is not needed.
Where did you get this code from? Time machine?

> +		.of_match_table = sprd_keypad_match,
> +		.pm = &sprd_keypad_pm_ops,
> +	},
> +	.probe = sprd_keypad_probe,
> +	.remove = sprd_keypad_remove,
> +};

> +

No need to have this blank line.

> +module_platform_driver(sprd_keypad_driver);

-- 
With Best Regards,
Andy Shevchenko


