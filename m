Return-Path: <linux-kernel+bounces-29154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C58309C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A397B23EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A62219FA;
	Wed, 17 Jan 2024 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFjT9711"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130CB219F1;
	Wed, 17 Jan 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505271; cv=none; b=pmjH6Tm29ttPUUV9IB8iU2XSwHmjjMt+4DHPXyR+0soxs5G+W5oKy+lDynViQFEbYfo0i0dKvsaRpcV4qeA+sYydGtjWTsx1l11Hcm5zKLSviR97EV2FyayIO9t2FBj3ilzjpNQ6ghL8JI46NurzreJr4PIbsOoffJvokZHJPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505271; c=relaxed/simple;
	bh=7rsy74VeGwTe0B1dy6yYekBf1JL2mUmizeBzF7JRZZ4=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=GwXX5mD/t5RotuMplZnNBhTfp2D+O4/zH52TThcTUZVlkifrNbrpy08f98gk4sR17iZXRr79QR4fBDrROXHkjfQSWqBIFqEXOsKKCpL24yBVQuQF7+0c4fiD5lQQ3aGDlZjlRc/fWnmMH+xwJmjnPVfrv59hKE0BBw0GuFAK9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFjT9711; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1548EC433C7;
	Wed, 17 Jan 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705505270;
	bh=7rsy74VeGwTe0B1dy6yYekBf1JL2mUmizeBzF7JRZZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RFjT9711zMlwkVrRQbwDAqwTR93aUfjvEgRLecV1TUI9SWDzuXudu2PHtKYjGPoQ7
	 31ARPLXG/aBYFfWZsKukFm1gqlVMpeAVHUxgfHIa/058S3gB/raJocOS0SZfG76qOy
	 MEYb8yQuHh3oKozXt5EruVStfuZZX9RWAAgb8bVGl5GSijr9TGVO2irxweca6hdAqt
	 Cvkj4QKVInzUZ7L24t7obIZWOAllM13CXJObPGzvLeknxm5xKw7s5HjKByYqeTpxOx
	 nayPZ5JmwGWpwXaVGWmCRSvo+pn+vSXYC37i5Ow1dboHRxOuRw3bdwHi8YIcoiPX0p
	 xjwchsaeUrX8g==
Message-ID: <8afd7bda-a600-4abb-95fc-ee70c6f89749@kernel.org>
Date: Wed, 17 Jan 2024 16:27:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: watchdog: Add ChromeOS EC watchdog
Content-Language: en-US
To: Lukasz Majczak <lma@chromium.org>, Gwendal Grignou
 <gwendal@chromium.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Radoslaw Biernacki <biernacki@google.com>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-watchdog@vger.kernel.org
References: <20240117102450.4080839-1-lma@chromium.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240117102450.4080839-1-lma@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/01/2024 11:24, Lukasz Majczak wrote:
> This adds EC-based watchdog support for ChromeOS
> based devices equipped with embedded controller (EC).
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/mfd/cros_ec_dev.c                     |   9 +
>  drivers/watchdog/Kconfig                      |  15 +
>  drivers/watchdog/Makefile                     |   3 +
>  drivers/watchdog/cros_ec_wdt.c                | 303 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_commands.h    |  78 ++---
>  6 files changed, 370 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/watchdog/cros_ec_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391bbb855cbe..55cd626a525f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4952,6 +4952,12 @@ R:	Sami Kyöstilä <skyostil@chromium.org>
>  S:	Maintained
>  F:	drivers/platform/chrome/cros_hps_i2c.c
>  
> +CHROMEOS EC WATCHDOG
> +M:	Lukasz Majczak <lma@chromium.org>
> +L:	chrome-platform@lists.linux.dev
> +S:	Maintained
> +F:	drivers/watchdog/cros_ec_wdt.c
> +
>  CHRONTEL CH7322 CEC DRIVER
>  M:	Joe Tessler <jrt@google.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 79d393b602bf..60fe831cf30a 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells[] = {
>  	{ .name = "cros-usbpd-notify", },
>  };
>  
> +static const struct mfd_cell cros_ec_wdt_cells[] = {
> +	{ .name = "cros-ec-wdt-drv", }
> +};
> +
>  static const struct cros_feature_to_cells cros_subdevices[] = {
>  	{
>  		.id		= EC_FEATURE_CEC,
> @@ -107,6 +111,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  		.mfd_cells	= cros_usbpd_charger_cells,
>  		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
>  	},
> +	{
> +		.id		= EC_FEATURE_HANG_DETECT,
> +		.mfd_cells	= cros_ec_wdt_cells,
> +		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
> +	},
>  };
>  
>  static const struct mfd_cell cros_ec_platform_cells[] = {
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7d22051b15a2..1da4be661be8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2251,4 +2251,19 @@ config KEEMBAY_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called keembay_wdt.
>  
> +#
> +# ChromeOS EC-based Watchdog
> +#

Drop comment, useless, copies what's below.

> +
> +config CROS_EC_WATCHDOG
> +	tristate "ChromeOS EC-based watchdog driver"
> +	select WATCHDOG_CORE
> +	depends on CROS_EC
> +	help
> +	  This is the watchdog driver for ChromeOS devices equipped with EC.
> +	  The EC watchdog - when enabled - expects to be kicked within a given
> +	  time (default set to 30 seconds) otherwise it will simple reboot
> +	  the AP. Priori to that it can also send an event (configurable timeout)
> +	  about upcoming reboot.

Instead you could say what will be the name of the module.

> +
>  endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7cbc34514ec1..8295c209ddb0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -234,3 +234,6 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>  obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> +
> +# Cros EC watchdog

Drop comment.

Also, are you sure you placed it in appropriate place, not just at the
end of both files?

> +obj-$(CONFIG_CROS_EC_WATCHDOG) += cros_ec_wdt.o
> diff --git a/drivers/watchdog/cros_ec_wdt.c b/drivers/watchdog/cros_ec_wdt.c
> new file mode 100644
> index 000000000000..b461c0613269
> --- /dev/null
> +++ b/drivers/watchdog/cros_ec_wdt.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/of_device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/uaccess.h>
> +
> +#define CROS_EC_WATCHDOG_DEFAULT_TIME 30 /* seconds */
> +
> +#define DEV_NAME "cros-ec-wdt-dev"

Drop unused defines.

> +#define DRV_NAME "cros-ec-wdt-drv"
> +
> +static int cros_ec_wdt_ping(struct watchdog_device *wdd);
> +static int cros_ec_wdt_start(struct watchdog_device *wdd);
> +static int cros_ec_wdt_stop(struct watchdog_device *wdd);
> +static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t);
> +

..

> +
> +static int cros_ec_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	/* We need to get a reference to cros_ec_devices
> +	 * (provides communication layer) which is a parent of
> +	 * the cros-ec-dev (our parent)
> +	 */
> +	struct cros_ec_device *cros_ec = dev_get_drvdata(dev->parent->parent);
> +	int ret = 0;
> +	uint32_t bootstatus;
> +
> +	if (!cros_ec) {
> +		ret = -ENODEV;
> +		dev_err_probe(dev, ret, "There is no coresponding EC device!");

Syntax is return dev_err_probe

> +		return ret;
> +	}
> +
> +	cros_ec_wdd.parent = &pdev->dev;
> +	wd_data.cros_ec = cros_ec;
> +	wd_data.wdd = &cros_ec_wdd;
> +	wd_data.start_on_resume = false;
> +	wd_data.keepalive_on = false;
> +	wd_data.wdd->timeout = CROS_EC_WATCHDOG_DEFAULT_TIME;
> +
> +	watchdog_stop_on_reboot(&cros_ec_wdd);
> +	watchdog_stop_on_unregister(&cros_ec_wdd);
> +	watchdog_set_drvdata(&cros_ec_wdd, &wd_data);
> +	platform_set_drvdata(pdev, &wd_data);
> +
> +	/* Get current AP boot status */
> +	ret = cros_ec_wdt_send_hang_detect(&wd_data, EC_HANG_DETECT_CMD_GET_STATUS, 0,
> +					   &bootstatus);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Couldn't get AP boot status from EC");

Syntax is return dev_err_probe

> +		return ret;
> +	}
> +
> +	/*
> +	 * If bootstatus is not EC_HANG_DETECT_AP_BOOT_NORMAL
> +	 * it mens EC has rebooted the AP due to watchdog timeout.
> +	 * Lets translate it to watchdog core status code.
> +	 */
> +	if (bootstatus != EC_HANG_DETECT_AP_BOOT_NORMAL)
> +		wd_data.wdd->bootstatus = WDIOF_CARDRESET;
> +
> +	ret = watchdog_register_device(&cros_ec_wdd);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "Couldn't get AP boot status from EC");

Syntax is return dev_err_probe

> +
> +	return ret;

return 0

> +}
> +
> +static int cros_ec_wdt_remove(struct platform_device *pdev)
> +{
> +	struct cros_ec_wdt_data *wd_data = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(wd_data->wdd);
> +
> +	return 0;
> +}
> +
> +static void cros_ec_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_wdt_data *wd_data = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	/*
> +	 * Clean only bootstatus flag.
> +	 * EC wdt is are already stopped by watchdog framework.
> +	 */
> +	ret = cros_ec_wdt_send_hang_detect(wd_data,
> +					   EC_HANG_DETECT_CMD_CLEAR_STATUS, 0, NULL);
> +	if (ret < 0)
> +		dev_err(dev, "%s failed (%d)", __func__, ret);
> +
> +	watchdog_unregister_device(wd_data->wdd);
> +}
> +
> +static int __maybe_unused cros_ec_wdt_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_wdt_data *wd_data = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	if (watchdog_active(wd_data->wdd)) {
> +		ret = cros_ec_wdt_send_hang_detect(wd_data,
> +						   EC_HANG_DETECT_CMD_CANCEL, 0, NULL);
> +		if (ret < 0)
> +			dev_err(dev, "%s failed (%d)", __func__, ret);
> +		wd_data->start_on_resume = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cros_ec_wdt_resume(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_wdt_data *wd_data = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	/* start_on_resume is only set if watchdog was active
> +	 * when device was going to sleep
> +	 */
> +	if (wd_data->start_on_resume) {
> +		/* On resume we just need to setup a EC watchdog the same way as

Use comment style from Linux coding style.

> +		 * in cros_ec_wdt_start(). When userspace resumes from suspend
> +		 * the watchdog app should just start petting the watchdog again.
> +		 */
> +		ret = cros_ec_wdt_start(wd_data->wdd);
> +		if (ret < 0)
> +			dev_err(dev, "%s failed (%d)", __func__, ret);

That's not really helpful. This applies everywhere. You have all over
the place debugging prints with __func__. This is not useful pattern.
Print something useful, not function name.

> +
> +		wd_data->start_on_resume = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_ec_wdt_driver = {
> +	.probe		= cros_ec_wdt_probe,
> +	.remove		= cros_ec_wdt_remove,
> +	.shutdown	= cros_ec_wdt_shutdown,
> +	.suspend	= pm_ptr(cros_ec_wdt_suspend),
> +	.resume		= pm_ptr(cros_ec_wdt_resume),
> +	.driver		= {
> +		.name	= DRV_NAME,
> +	},
> +};
> +
> +module_platform_driver(cros_ec_wdt_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.


> +MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 7dae17b62a4d..35a7a2d32819 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3961,60 +3961,50 @@ struct ec_response_i2c_passthru {
>  } __ec_align1;
>  
>  /*****************************************************************************/
> -/* Power button hang detect */
> -
> +/* AP hang detect */

I don't understand how this change is related to the new driver. This
entire hunk is confusing.


Best regards,
Krzysztof


