Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3377DDFA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjKAKnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:43:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59324E8;
        Wed,  1 Nov 2023 03:43:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA19FC433C7;
        Wed,  1 Nov 2023 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698835380;
        bh=oM0sd9v9BqX6WjMkw6XdpEQIFa2aVFOZ4k+P+0WfIoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TezNJ+i7kS52MwFDCUasJC1CuVUe7Efdyo87wFVedsHqMFrOU8YLDh8sQVCGjXKw+
         WE6vkMJfR5Nhsvik+e4PyFSvI0AK2iLCCmx+YUcH8UCyc9HaW8EBFcKr/6VslbCAnO
         X6RWwY2L4WTLnxWjYjUANjkL5fmgrWW7ZAJi7jNqkdHMchu/YdkbWTEwJB7CaAsoCV
         Midm50dHAnd2LZHyg2NbgaT97Axb/x5Mb4h9MvVVdqmGZYWDkkwJtTHgxykEO1ZRGB
         DYVsky4JwpveoX5borrwxOJp2kJ5yHiBqY+3Tfv55i2d31MMrg4Kay6nsRqYVnwII4
         BJOUWoiq8g+WA==
Message-ID: <4a000265-6f92-439c-bb2c-66fbafa5c76c@kernel.org>
Date:   Wed, 1 Nov 2023 11:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Content-Language: en-US
To:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
 <20231031015119.29756-3-larry.lai@yunjingtech.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231031015119.29756-3-larry.lai@yunjingtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 02:51, larry.lai wrote:
> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control) through an on-board FPGA.
> 
> Reported-by: kernel test robot <lkp@intel.com>

Drop, LKP did not report this patch.

> Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> ---
> PATCH V6 -> V7: There's no change.
> PATCH V5 -> PATCH V6
> (1) Refer 2023/08/10 Linus Walleij review, cleaned up coding style and
> addressed review comments.
> PATCH V4 -> PATCH V5
> (1) Fixed kernel test robot compiler warning.
> (2) Synchronizing upboard github to v1.0.5 tag.
> RFC 2023/04/25 -> PATCH V4
> (1) Fixed kernel test robot compiler warning.
> (2) Remove mistakes with wrong Reviewed-by tags.
> RFC 2022/11/23 -> RFC 2023/04/25
> (1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style and
> addressed review comments.
> PATCH V3 -> RFC 2022/11/23:
> (1) Refer 2022/11/09 Linus Walleij review, cleaned up coding style and
> addressed review comments.
> PATCH V2 -> V3:
> There's no change.
> PATCH V1 -> V2:
> (1) Synchronized with upboard github to rc2
> (2) Refer 2022/10/19 Mark Brown and Andy Shevchenko review, we removed
> the regmap and acpi patches and implement in upboard pinctrl driver.
> (3) Refer 2022/10/19 Andy Shevchenko review, fixed the coding style
> issues, removed using gpio_xxxx API and removed including <linux/gpio.h>.
> ---
>  drivers/pinctrl/Kconfig           |   14 +
>  drivers/pinctrl/Makefile          |    1 +
>  drivers/pinctrl/pinctrl-upboard.c | 1390 +++++++++++++++++++++++++++++
>  3 files changed, 1405 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-upboard.c
> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 1cf74b0c42e5..cc8dae75289b 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -483,6 +483,20 @@ config PINCTRL_THUNDERBAY
>  	  rate control and direction control. This module will be
>  	  called as pinctrl-thunderbay.
>  
> +config PINCTRL_UPBOARD
> +	tristate "UP board FPGA pin controller"
> +	depends on (X86 && ACPI) || COMPILE_TEST
> +	depends on MFD_INTEL_UPBOARD_FPGA
> +	select GENERIC_PINCONF
> +	select PINMUX
> +	select PINCONF
> +	help
> +	  Pin controller for the FPGA GPIO lines on UP boards. Due to the
> +	  hardware layout, these are meant to be controlled in tandem with their
> +	  corresponding Intel SoC GPIOs.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pinctrl-upboard.
> +
>  config PINCTRL_ZYNQ
>  	bool "Pinctrl driver for Xilinx Zynq"
>  	depends on ARCH_ZYNQ
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e76f5cdc64b0..c366706d36e7 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
>  obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
>  obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
>  obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
> +obj-$(CONFIG_PINCTRL_UPBOARD)	+= pinctrl-upboard.o
>  obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
>  
> diff --git a/drivers/pinctrl/pinctrl-upboard.c b/drivers/pinctrl/pinctrl-upboard.c
> new file mode 100644
> index 000000000000..73d50a695aab
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-upboard.c
> @@ -0,0 +1,1390 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UP Board HAT pin controller driver
> + * remapping native pin to RPI pin and set CPLD pin dir
> + *
> + * Copyright (c) AAEON. All rights reserved.
> + *
> + * Authors: Gary Wang <garywang@aaeon.com.tw>
> + *
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/upboard-fpga.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/seq_file.h>
> +#include <linux/string.h>
> +
> +#include "core.h"
> +#include "intel/pinctrl-intel.h"
> +

...

> +	{
> +		.ident = BOARD_UP_ADLN01,
> +		.matches = { /* UP 7000 */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-ADLN01"),
> +		},
> +	},
> +	{ }	/* Terminating entry */
> +};
> +
> +static int __init upboard_pinctrl_probe(struct platform_device *pdev)

Probe functions are not __init. Also, this isn't even used.

> +{
> +	struct upboard_fpga * const fpga = dev_get_drvdata(pdev->dev.parent);
> +	struct pinctrl_desc *pctldesc;
> +	struct upboard_pinctrl *pctrl;
> +	struct upboard_pin *pins;
> +	const struct dmi_system_id *system_id;
> +	const unsigned int *rpi_mapping;
> +	unsigned int ngpio;
> +	int ret;

...

> +	/* add acpi pin mapping according to external-gpios key */
> +	ret = upboard_acpi_node_pin_mapping(fpga, pctrl,
> +					    "external",
> +					    dev_name(&pdev->dev),
> +					    0);
> +	if (ret)
> +		return ret;
> +
> +	upboard_alt_func_enable(&pctrl->chip, "I2C",    pctrl->ident);
> +	upboard_alt_func_enable(&pctrl->chip, "SPI",    pctrl->ident);
> +	upboard_alt_func_enable(&pctrl->chip, "UART",   pctrl->ident);
> +	upboard_alt_func_enable(&pctrl->chip, "I2S",    pctrl->ident);
> +	upboard_alt_func_enable(&pctrl->chip, "PWM",    pctrl->ident);
> +	upboard_alt_func_enable(&pctrl->chip, "ADC",    pctrl->ident);
> +	upboard_alt_func_enable(&pctrl->chip, "PINMUX", pctrl->ident);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver upboard_pinctrl_driver = {
> +	.driver = {
> +		.name = "upboard-pinctrl",
> +	},
> +};
> +module_platform_driver_probe(upboard_pinctrl_driver, upboard_pinctrl_probe);
> +
> +MODULE_AUTHOR("Gary Wang <garywang@aaeon.com.tw>");
> +MODULE_DESCRIPTION("UP Board HAT pin controller driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:upboard-pinctrl");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.

Best regards,
Krzysztof

