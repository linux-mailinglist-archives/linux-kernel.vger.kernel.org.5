Return-Path: <linux-kernel+bounces-29210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120D830AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1024728FAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBB22335;
	Wed, 17 Jan 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImeHEmLs"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C322326;
	Wed, 17 Jan 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508600; cv=none; b=GSFVYuxpwMlEhrsxE0Yx4cfixYxAoX1/faeeO+H1RPSHOKJy4m5O9sQzV/NWfEPvZEJpdM0XChzyn3ueyQ60Myo3tlVZG7t8THZ1dUP4NemB2HK/4BB2NhTWQUl6a9zNyJnLFxaHG2jaMJ8EcJoeiSMgeXiV6jNeQVjIjsU7ln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508600; c=relaxed/simple;
	bh=Jhpo0RtO5vZIipSIDSzEWhD+w7DLJjySlwzehcWDP+4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=S7eedAqtCGzNvWKVLi0O+vxJZw0PEcGoJXqcFWUXh59FjqSWWMyzJiA0fRb/S2JR/LwP6XhB4QYYAnVrM7wv5Gi4jHAg2flPCHJJ0qq6Jsr0JoOTzV7phIo3go095vHx5uNg2k5HGDsUic/g4tJqd8343nqIebWYflxyB4XezxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImeHEmLs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so4831172a12.3;
        Wed, 17 Jan 2024 08:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705508596; x=1706113396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T99Jb3ygkV8L6klJGqfO3HfgK+92V6yGp5Trl0a48Bw=;
        b=ImeHEmLsEy+DrwcTY0gDGF6u1GWWaRqIz4QG+0jr9WTUwjQHT+DJWo5e6YGGqnGhim
         oARWEQ+o2Rmogswqnc162rYHkI9LLEsEoL8jw+0xpt1kaYFWveQOmnyuGCc8GiLwb1oZ
         /IBcqRFShGktRK5s573YLSZAWUWPdP11CviskYxNoHT5cI3oMlMxQaP0z8iM2CrLdA4o
         0m4enA3bAc3LU6O3XCBRKyfqS6sAAXASqsXtYLENtaty0YVlpP0h4qpvVeR74FBxViux
         NYlcPhCmQYcuWVQKArnChgjLzX2/rqs2gwI2VXq3ewKuy4MMzAwxA5CeKFPXOidSUFNw
         tUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508596; x=1706113396;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T99Jb3ygkV8L6klJGqfO3HfgK+92V6yGp5Trl0a48Bw=;
        b=Ujh01Zw3JucpR78z+aeLWHX7qzQpo6Z4aeubj+0ywxdnbCzJF3cFThIWfoQlc1wpO2
         LpK2+92KtDhZngKLoZa6y3i2Qtz25jn5l6mzCOMAgJvcE1QRXyvEN35W2Fiefk2YqpNC
         7IqemrjS95cBcI5STCROKy6XX0QHZ5z3gQ+7YpbFCLUaIYZap86iMdTyM6UVBDwV0fvH
         u088sDkjRG3q1kDW0+ueffMWq0NI74zOxidXYACizUE7miBMLJBISos4HGgK3G1gAeTs
         oXiBqEVjHkV7rT8ujnNEulppmEfKGI2tknHkk7MqrXgtyCgZF2JbywW3Rd5Opo/rSeX2
         FZ5A==
X-Gm-Message-State: AOJu0Yym5IfmuWKY/D9haI23883MxxaC3CxhSKGchwCJ5nlo9IfT17sE
	U8QzQHfm0P2zGkyH1M02y+yNu9XPsxg=
X-Google-Smtp-Source: AGHT+IFNyDsl3K82DAW6qVGbkTpxFcMEHijtQ4+eZmZjSRgdq+8cqZPaamU52Ep3QE+s4OaW/PmeZg==
X-Received: by 2002:a17:90a:b388:b0:28a:9748:d7e4 with SMTP id e8-20020a17090ab38800b0028a9748d7e4mr4703163pjr.14.1705508596103;
        Wed, 17 Jan 2024 08:23:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qd5-20020a17090b3cc500b0028ca92ab09asm14230986pjb.56.2024.01.17.08.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 08:23:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6b1190af-7b28-461d-bcd0-2aaeb0a1fa38@roeck-us.net>
Date: Wed, 17 Jan 2024 08:23:13 -0800
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
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240117102450.4080839-1-lma@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/24 02:24, Lukasz Majczak wrote:
> This adds EC-based watchdog support for ChromeOS
> based devices equipped with embedded controller (EC).
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>

checkpatch --strict says:

total: 0 errors, 0 warnings, 14 checks, 455 lines checked

Please fix.

> ---
>   MAINTAINERS                                   |   6 +
>   drivers/mfd/cros_ec_dev.c                     |   9 +
>   drivers/watchdog/Kconfig                      |  15 +
>   drivers/watchdog/Makefile                     |   3 +
>   drivers/watchdog/cros_ec_wdt.c                | 303 ++++++++++++++++++
>   .../linux/platform_data/cros_ec_commands.h    |  78 ++---
>   6 files changed, 370 insertions(+), 44 deletions(-)
>   create mode 100644 drivers/watchdog/cros_ec_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 391bbb855cbe..55cd626a525f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4952,6 +4952,12 @@ R:	Sami Kyöstilä <skyostil@chromium.org>
>   S:	Maintained
>   F:	drivers/platform/chrome/cros_hps_i2c.c
>   
> +CHROMEOS EC WATCHDOG
> +M:	Lukasz Majczak <lma@chromium.org>
> +L:	chrome-platform@lists.linux.dev
> +S:	Maintained
> +F:	drivers/watchdog/cros_ec_wdt.c
> +
>   CHRONTEL CH7322 CEC DRIVER
>   M:	Joe Tessler <jrt@google.com>
>   L:	linux-media@vger.kernel.org
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 79d393b602bf..60fe831cf30a 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells[] = {
>   	{ .name = "cros-usbpd-notify", },
>   };
>   
> +static const struct mfd_cell cros_ec_wdt_cells[] = {
> +	{ .name = "cros-ec-wdt-drv", }
> +};
> +
>   static const struct cros_feature_to_cells cros_subdevices[] = {
>   	{
>   		.id		= EC_FEATURE_CEC,
> @@ -107,6 +111,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>   		.mfd_cells	= cros_usbpd_charger_cells,
>   		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
>   	},
> +	{
> +		.id		= EC_FEATURE_HANG_DETECT,
> +		.mfd_cells	= cros_ec_wdt_cells,
> +		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
> +	},
>   };
>   
>   static const struct mfd_cell cros_ec_platform_cells[] = {

The above should be a separate patch.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7d22051b15a2..1da4be661be8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2251,4 +2251,19 @@ config KEEMBAY_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called keembay_wdt.
>   
> +#
> +# ChromeOS EC-based Watchdog
> +#

Pointless comment.

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
> +

In other words, it is a watchdog driver. I don't think it adds value
to describe how a watchdog works here, nor to describe what other (unused)
functionality the hardware may have.

Also, please try to insert in alphabetic order.

>   endif # WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7cbc34514ec1..8295c209ddb0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -234,3 +234,6 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>   obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>   obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
>   obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> +
> +# Cros EC watchdog

We don't add individual comments for each watchdog, and we should not start
doing so. Also, please try to insert in alphabetic order.

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

Alphabetic include file order, please. Also, I don't immediately see where
uaccess.h or of_device.h are used. Please drop unused includes.

> +
> +#define CROS_EC_WATCHDOG_DEFAULT_TIME 30 /* seconds */
> +
> +#define DEV_NAME "cros-ec-wdt-dev"
> +#define DRV_NAME "cros-ec-wdt-drv"

One of those is unused.

> +
> +static int cros_ec_wdt_ping(struct watchdog_device *wdd);
> +static int cros_ec_wdt_start(struct watchdog_device *wdd);
> +static int cros_ec_wdt_stop(struct watchdog_device *wdd);
> +static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t);
> +

Please rearrange to avoid forward declarations.

> +struct cros_ec_wdt_data {
> +	bool start_on_resume;
> +	bool keepalive_on;
> +	struct cros_ec_device *cros_ec;
> +	struct watchdog_device *wdd;
> +};
> +static struct cros_ec_wdt_data wd_data;

Please allocate and avoid static variables.

> +
> +static const struct watchdog_info cros_ec_wdt_ident = {
> +	.options          = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.firmware_version = 0,
> +	.identity         = DRV_NAME,
> +};
> +
> +static const struct watchdog_ops cros_ec_wdt_ops = {
> +	.owner		 = THIS_MODULE,
> +	.ping		 = cros_ec_wdt_ping,
> +	.start		 = cros_ec_wdt_start,
> +	.stop		 = cros_ec_wdt_stop,
> +	.set_timeout = cros_ec_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device cros_ec_wdd = {
> +	.info = &cros_ec_wdt_ident,
> +	.ops = &cros_ec_wdt_ops,
> +	.timeout = CROS_EC_WATCHDOG_DEFAULT_TIME,
> +	.bootstatus = EC_HANG_DETECT_AP_BOOT_NORMAL

Consider allocating and embedding in struct cros_ec_wdt_data.
timeout and .bootstatus are overwritten anyway, and it does not make sense
to initialize those elements here.

> +};
> +
> +static int cros_ec_wdt_send_hang_detect(struct cros_ec_wdt_data *wd_data,

Seems to me that cros_ec_wdt_send_cmd or similar would be a better function name,
but your call.

> +					uint16_t command,
> +					uint16_t reboot_timeout_sec,
> +					uint32_t *status)
> +{
> +	int ret;
> +
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_hang_detect req;
> +			struct ec_response_hang_detect resp;
> +		};
> +	} __packed buf = {
> +		.msg = {
> +			.version = 0,
> +			.command = EC_CMD_HANG_DETECT,
> +			.insize  = (command == EC_HANG_DETECT_CMD_GET_STATUS) ?
> +				   sizeof(struct ec_response_hang_detect) :
> +				   0,
> +			.outsize = sizeof(struct ec_params_hang_detect),
> +		},
> +		.req = {
> +			.command = command,
> +			.reboot_timeout_sec = reboot_timeout_sec,
> +		}
> +	};
> +
> +	ret = cros_ec_cmd_xfer_status(wd_data->cros_ec, &buf.msg);
> +	if (ret < 0) {
> +		dev_warn(wd_data->wdd->parent,

Given that wdd is needed anyway,

> +				 "cros_ec_cmd_xfer_status failed(%d) command (%04x) reboot_timeout_sec(%ds)",
> +				 ret, command, reboot_timeout_sec);

That message, if ever seen, does not make much sense if the command was
one that does not set the timeout. On top of that, this code
dumps a warning, and the calling code dumps an error message. Is the EC
really that fragile that it is necessary to dump all those error messages ?

If not, please consider replacing most if not all of those log messages
with dev_dbg().

> +		return ret;
> +	}
> +
> +	if (status && (command == EC_HANG_DETECT_CMD_GET_STATUS)) {

Unnecessary (). Besides, it doesn't make much sense. Why provide
a status pointer but only use it if the command is a specific one ?

> +		*status = buf.resp.status;
> +		dev_info(wd_data->wdd->parent, "EC Watchdog boot status (%d)",
> +				 buf.resp.status);

That message does not belong here.

> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_ec_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct cros_ec_wdt_data *wd_data = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = cros_ec_wdt_send_hang_detect(wd_data, EC_HANG_DETECT_CMD_RELOAD,
> +					   0, NULL);
> +	if (ret < 0)
> +		dev_err(wdd->parent, "%s failed (%d)", __func__, ret);

return here and drop the else.

Nore that this driver is extremely noisy. If the EC for some reason doesn't
respond as expected the error messages will drown all other kernel messages.
I really do not see the point of this.

> +	else
> +		wd_data->keepalive_on = true;

This is odd and needs a detailed explanation. More on that see below.

> +
> +	return ret;
> +}
> +
> +static int cros_ec_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct cros_ec_wdt_data *wd_data = watchdog_get_drvdata(wdd);
> +	int ret = 0;
> +
> +	/* Prepare watchdog on EC side */
> +	ret = cros_ec_wdt_send_hang_detect(wd_data,
> +					EC_HANG_DETECT_CMD_SET_TIMEOUT,
> +					wdd->timeout,
> +					NULL);
> +	if (ret < 0)
> +		dev_err(wdd->parent, "%s failed (%d)", __func__, ret);
> +
> +	return ret;
> +}
> +
> +static int cros_ec_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct cros_ec_wdt_data *wd_data = watchdog_get_drvdata(wdd);
> +	int ret = 0;
> +
> +	if (wd_data->keepalive_on) {
> +		wd_data->keepalive_on = false;
> +		ret = cros_ec_wdt_send_hang_detect(wd_data, EC_HANG_DETECT_CMD_CANCEL,
> +						0, NULL);

This needs explanation. Why is it only needed here after the first ping is sent,
but on suspend it is unconditional ? In other words, why does the watchdog
behave differently after the first ping ? Why does the watchdog not have to be
stopped if it never received a ping ? Logically that seems odd, if not plain
wrong. The watchdog should behave exactly the same after it was started, no matter
if it ever received a ping or not.

> +		if (ret < 0)
> +			dev_err(wdd->parent, "%s failed (%d)", __func__, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int cros_ec_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
> +{
> +	struct cros_ec_wdt_data *wd_data = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	if (t < EC_HANG_DETECT_MIN_TIMEOUT) {
> +		dev_err(wdd->parent,
> +				"%s failed, requested timeout is lower than min(%d < %d)",
> +				__func__, t, EC_HANG_DETECT_MIN_TIMEOUT);
> +		return -EINVAL;

This should be handled in the watchdog core. If it isn't the driver is misconfigured.

> +	}
> +
> +	ret = cros_ec_wdt_send_hang_detect(wd_data,
> +					   EC_HANG_DETECT_CMD_SET_TIMEOUT,
> +					   t, NULL);
> +	if (ret < 0)
> +		dev_err(wdd->parent, "%s failed (%d)", __func__, ret);

return here.

> +	else
> +		wdd->timeout = t;
> +
> +	return ret;
> +}
> +
> +static int cros_ec_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	/* We need to get a reference to cros_ec_devices
> +	 * (provides communication layer) which is a parent of
> +	 * the cros-ec-dev (our parent)
> +	 */
> +	struct cros_ec_device *cros_ec = dev_get_drvdata(dev->parent->parent);


Other cros drivers get struct cros_ec_dev from dev->parent and then use
ec->ec_dev. Please explain why you don't use the same pattern; dereferencing
parent->parent and assuming to know its driver data seems to be (much) more
risky than the existing pattern.

Also, the comment seems obvious. None of the other cros_ec drivers needed it,
and I don't see why it would add value here.

> +	int ret = 0;
> +	uint32_t bootstatus;
> +
> +	if (!cros_ec) {
> +		ret = -ENODEV;
> +		dev_err_probe(dev, ret, "There is no coresponding EC device!");
> +		return ret;

return dev_err_probe(). Same elsewhere.

> +	}
> +
> +	cros_ec_wdd.parent = &pdev->dev;
> +	wd_data.cros_ec = cros_ec;
> +	wd_data.wdd = &cros_ec_wdd;
> +	wd_data.start_on_resume = false;
> +	wd_data.keepalive_on = false;
> +	wd_data.wdd->timeout = CROS_EC_WATCHDOG_DEFAULT_TIME;

Ah, I guess the reason for the error handling when setting the timeout is
the lack of setting boundaries here. That is wrong. min_timeout
and max_timeout need to be set.

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
> +		return ret;
> +	}
> +
> +	/*
> +	 * If bootstatus is not EC_HANG_DETECT_AP_BOOT_NORMAL
> +	 * it mens EC has rebooted the AP due to watchdog timeout.

means

> +	 * Lets translate it to watchdog core status code.
> +	 */
> +	if (bootstatus != EC_HANG_DETECT_AP_BOOT_NORMAL)
> +		wd_data.wdd->bootstatus = WDIOF_CARDRESET;
> +
> +	ret = watchdog_register_device(&cros_ec_wdd);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "Couldn't get AP boot status from EC");

Wrong error message.

> +
> +	return ret;
> +}
> +
> +static int cros_ec_wdt_remove(struct platform_device *pdev)
> +{
> +	struct cros_ec_wdt_data *wd_data = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(wd_data->wdd);

Why not use devm_watchdog_register_device() ? Please explain.

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

Why is this necessary if the watchdog is stopped ?

> +	ret = cros_ec_wdt_send_hang_detect(wd_data,
> +					   EC_HANG_DETECT_CMD_CLEAR_STATUS, 0, NULL);
> +	if (ret < 0)
> +		dev_err(dev, "%s failed (%d)", __func__, ret);
> +
> +	watchdog_unregister_device(wd_data->wdd);

This doesn't make sense to me. Explain why it is necessary.

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

Needs explanation. See below.

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

Please use standard multi-line comments. This is not the networking subsystem.
Even more important, use _consistent_ multi-line comments.

> +	if (wd_data->start_on_resume) {

Please explain why watchdog_active() does not work here.

> +		/* On resume we just need to setup a EC watchdog the same way as
> +		 * in cros_ec_wdt_start(). When userspace resumes from suspend
> +		 * the watchdog app should just start petting the watchdog again.
> +		 */

Isn't that obvious ?

> +		ret = cros_ec_wdt_start(wd_data->wdd);
> +		if (ret < 0)
> +			dev_err(dev, "%s failed (%d)", __func__, ret);
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
> +MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 7dae17b62a4d..35a7a2d32819 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3961,60 +3961,50 @@ struct ec_response_i2c_passthru {
>   } __ec_align1;
>   
>   /*****************************************************************************/
> -/* Power button hang detect */
> -
> +/* AP hang detect */
>   #define EC_CMD_HANG_DETECT 0x009F
>   
> -/* Reasons to start hang detection timer */
> -/* Power button pressed */
> -#define EC_HANG_START_ON_POWER_PRESS  BIT(0)
> -
> -/* Lid closed */
> -#define EC_HANG_START_ON_LID_CLOSE    BIT(1)
> -
> - /* Lid opened */
> -#define EC_HANG_START_ON_LID_OPEN     BIT(2)
> -
> -/* Start of AP S3->S0 transition (booting or resuming from suspend) */
> -#define EC_HANG_START_ON_RESUME       BIT(3)
> -
> -/* Reasons to cancel hang detection */
> +#define EC_HANG_DETECT_MIN_TIMEOUT 5
>   
> -/* Power button released */
> -#define EC_HANG_STOP_ON_POWER_RELEASE BIT(8)
> +/* EC hang detect commands */
> +enum ec_hang_detect_cmds {
> +	/* Reload AP hang detect timer. */
> +	EC_HANG_DETECT_CMD_RELOAD = 0x0,
>   
> -/* Any host command from AP received */
> -#define EC_HANG_STOP_ON_HOST_COMMAND  BIT(9)
> +	/* Stop AP hang detect timer. */
> +	EC_HANG_DETECT_CMD_CANCEL = 0x1,
>   

This is making unrelated changes. Please make those in a separate patch.
It might be best to update this file in a separate patch to start with.

> -/* Stop on end of AP S0->S3 transition (suspending or shutting down) */
> -#define EC_HANG_STOP_ON_SUSPEND       BIT(10)
> +	/* Configure watchdog with given reboot timeout and
> +	 * cancel currently running AP hand detect timer.
> +	 */
> +	EC_HANG_DETECT_CMD_SET_TIMEOUT = 0x2,
>   
> -/*
> - * If this flag is set, all the other fields are ignored, and the hang detect
> - * timer is started.  This provides the AP a way to start the hang timer
> - * without reconfiguring any of the other hang detect settings.  Note that
> - * you must previously have configured the timeouts.
> - */
> -#define EC_HANG_START_NOW             BIT(30)
> +	/* Get last hang status - whether the AP boot was clear or not */
> +	EC_HANG_DETECT_CMD_GET_STATUS = 0x3,
>   
> -/*
> - * If this flag is set, all the other fields are ignored (including
> - * EC_HANG_START_NOW).  This provides the AP a way to stop the hang timer
> - * without reconfiguring any of the other hang detect settings.
> - */
> -#define EC_HANG_STOP_NOW              BIT(31)
> +	/* Clear last hang status. Called when AP is rebooting/shutting down
> +	 * gracefully.
> +	 */
> +	EC_HANG_DETECT_CMD_CLEAR_STATUS = 0x4
> +};
>   
>   struct ec_params_hang_detect {
> -	/* Flags; see EC_HANG_* */
> -	uint32_t flags;
> -
> -	/* Timeout in msec before generating host event, if enabled */
> -	uint16_t host_event_timeout_msec;
> -
> -	/* Timeout in msec before generating warm reboot, if enabled */
> -	uint16_t warm_reboot_timeout_msec;
> -} __ec_align4;
> +	uint16_t command; /* enum ec_hang_detect_cmds */
> +	/* Timeout in seconds before generating reboot */
> +	uint16_t reboot_timeout_sec;
> +} __ec_align2;
>   
> +/* Status codes that describe whether AP has boot normally or the hang has been
> + * detected and EC has reset AP
> + */
> +enum ec_hang_detect_status {
> +	EC_HANG_DETECT_AP_BOOT_NORMAL = 0x0,
> +	EC_HANG_DETECT_AP_BOOT_EC_WDT = 0x1,
> +	EC_HANG_DETECT_AP_BOOT_COUNT,
> +};
> +struct ec_response_hang_detect {
> +	uint8_t status; /* enum ec_hang_detect_status */
> +} __ec_align1;
>   /*****************************************************************************/
>   /* Commands for battery charging */
>   


