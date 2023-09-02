Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6EC790485
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351422AbjIBAaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjIBAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:30:12 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6BE7E;
        Fri,  1 Sep 2023 17:30:08 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1ba5cda3530so1648858fac.3;
        Fri, 01 Sep 2023 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693614607; x=1694219407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYRnT7D4+b6P9xuf1Qm2Ab0SDXGXLd7f1KUcFI4sZsA=;
        b=pVjkEPn5LEYIe0Sn6guk5aqlYMoIa7I/i8K72OJH0puJHQNVhEqVtPZVRkZatulea5
         I9Et/Ibz2WIFLeDbfOFIrhLOl7rrmtOuceqr6cChEp1sZBGsklCZekYAKlkrP9JJg2/K
         hH4xylLzEOOEQXMIYbuXBCY2i0wTnXnHVKX3tltpKWwh9WugLLPC61BZx29XME5mQWwQ
         yRZUNKnRub2RjOkDOHXP51PGwCtievIqeS3y7opa5wViGpBbD6tjgr/RS29rPMQbBjXz
         SNxNzkaeC4SKrAdRsSUKYFotS9NASqfDd9lNfQg17nk04xfMLFQfrniq09DtGeB+zs4m
         um7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693614607; x=1694219407;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYRnT7D4+b6P9xuf1Qm2Ab0SDXGXLd7f1KUcFI4sZsA=;
        b=c/MDRmMshmJeNqOdERCZMpoikBJDE/dQDAYO7k8UkDHo+KiXhxKYuq3PKe/x7qfJ2+
         zep/3Ks33zqB8DMeGyME65aa5Chaz7YNXCU8oJrwKCbKqzYAkpgiCdBXIfoC+AS32hH3
         Sv5z0g1M3+KEaEuUuUtV2LhUTxWtJ8N7ILR8umARKmWoxc5WXVdsfZF9z1UjWPZ3Raz5
         vtIUBI7AX6mx6q4DhAzaaxu7Q1kbVgCdMdctB4LhF6C45pIjlyl6RC0hmsNZKXkAtqo7
         5bM95QH8QH8nlg3UYyZVHrUQw2nUmFjIS1z9ZbUxgr18lHpacet4m2UX7HaBK5RH7jCX
         ikIg==
X-Gm-Message-State: AOJu0YzTagG/+AJXq1IzrCSMfMS6PT+NGLCfIUhoCmbSG6avPNBjwMyo
        2E85qNBJ9cfZVd3NEdxVTKs=
X-Google-Smtp-Source: AGHT+IHg32rWvsI0d3O2dCw8BaD4TyvYBHPgIUCTnoxzUyo2e1SwqPw7n4yQ62exoB/u87xpoecYYA==
X-Received: by 2002:a05:6870:e2d4:b0:1d0:f067:bf23 with SMTP id w20-20020a056870e2d400b001d0f067bf23mr4279115oad.25.1693614607369;
        Fri, 01 Sep 2023 17:30:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fy3-20020a0566381e8300b0043193e32c78sm1396657jab.152.2023.09.01.17.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 17:30:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <61fae328-e56d-f999-1613-160987dcefa6@roeck-us.net>
Date:   Fri, 1 Sep 2023 17:30:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230902-powerz-v3-1-ed78d450c6c3@weissschuh.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] hwmon: add POWER-Z driver
In-Reply-To: <20230902-powerz-v3-1-ed78d450c6c3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 15:36, Thomas Weißschuh wrote:
> POWER-Z is a series of devices to monitor power characteristics of
> USB-C connections and display those on a on-device display.
> Some of the devices, notably KM002C and KM003C, contain an additional
> port which exposes the measurements via USB.
> 
> This is a driver for this monitor port.
> 
> It was developed and tested with the KM003C.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - CC linux-usb list
> - address Guenters review comments
>    - simplify hwmon chip name
>    - drop member "intf" from struct powerz_priv
>    - use devm-APIs
>    - return EOPNOTSUPP for invalid channels
>    - rework if-else chaining in read functions
>    - integrate transfer context into struct powerz_priv
>    - simplify logic and return value of powerz_read_data
>    - fix naming of struct powerz_sensor_data members
>    - explicitly include all necessary header files
>    - add doc
> - simplify URB completion callbacks a bit
> - fix indentation
> - add support for VDD channel
> - add support for VBUS/IBUS min/max as printed on the device itself
> - allocate single URB as part of struct powerz_priv
> - kill in-flight URBs on disconnect
> - Link to v2: https://lore.kernel.org/r/20230831-powerz-v2-1-5c62c53debd4@weissschuh.net
> 
> Changes in v2:
> - fix syntax error in Kconfig
> - avoid double free of urb in case of failure
> - Link to v1: https://lore.kernel.org/r/20230831-powerz-v1-1-03979e519f52@weissschuh.net
> ---
>   Documentation/hwmon/index.rst  |   1 +
>   Documentation/hwmon/powerz.rst |  27 ++++ >   MAINTAINERS                    |   7 +
>   drivers/hwmon/Kconfig          |  10 ++
>   drivers/hwmon/Makefile         |   1 +
>   drivers/hwmon/powerz.c         | 288 +++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 334 insertions(+)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 88dadea85cfc..10a54644557d 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -178,6 +178,7 @@ Hardware Monitoring Kernel Drivers
>      peci-cputemp
>      peci-dimmtemp
>      pmbus
> +   powerz
>      powr1220
>      pxe1610
>      pwm-fan
> diff --git a/Documentation/hwmon/powerz.rst b/Documentation/hwmon/powerz.rst
> new file mode 100644
> index 000000000000..530fff68ca6e
> --- /dev/null
> +++ b/Documentation/hwmon/powerz.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver POWERZ
> +====================
> +
> +Supported chips:
> +
> +  * ChargerLAB POWER-Z KM003C
> +
> +    Prefix: 'powerz'
> +
> +    Addresses scanned: -
> +
> +Author:
> +
> +  - Thomas Weißschuh <linux@weissschuh.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for the ChargerLAB POWER-Z USB-C power testing
> +family.
> +
> +The device communicates with the custom protocol over USB.
> +
> +The channel labels exposed via hwmon match the labels used by the on-device
> +display and the official POWER-Z PC software.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fcbb106aaa57..153c6fe0a725 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4795,6 +4795,13 @@ X:	drivers/char/ipmi/
>   X:	drivers/char/random.c
>   X:	drivers/char/tpm/
>   
> +CHARGERLAB POWER-Z HARDWARE MONITOR DRIVER
> +M:	Thomas Weißschuh <linux@weissschuh.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/powerz.rst
> +F:	drivers/hwmon/powerz.c
> +
>   CHECKPATCH
>   M:	Andy Whitcroft <apw@canonical.com>
>   M:	Joe Perches <joe@perches.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec38c8892158..12af9f9cfd9f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -839,6 +839,16 @@ config SENSORS_JC42
>   	  This driver can also be built as a module. If so, the module
>   	  will be called jc42.
>   
> +config SENSORS_POWERZ
> +	tristate "ChargerLAB POWER-Z USB-C tester"
> +	depends on USB
> +	help
> +	  If you say yes here you get support for ChargerLAB POWER-Z series of
> +	  USB-C charging testers.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called powerz.
> +
>   config SENSORS_POWR1220
>   	tristate "Lattice POWR1220 Power Monitoring"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4ac9452b5430..019189500e5d 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -176,6 +176,7 @@ obj-$(CONFIG_SENSORS_OXP) += oxp-sensors.o
>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> +obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
>   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>   obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
> diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
> new file mode 100644
> index 000000000000..6209339e5414
> --- /dev/null
> +++ b/drivers/hwmon/powerz.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/lockdep.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/usb.h>
> +
> +#define DRIVER_NAME	"powerz"
> +#define POWERZ_EP_CMD_OUT	0x01
> +#define POWERZ_EP_DATA_IN	0x81
> +
> +/* as printed on the device itself */
> +#define POWERZ_MAX_VOLTAGE	50000
> +#define POWERZ_MAX_CURRENT	6000
> +
> +struct powerz_sensor_data {
> +	u8 _unknown_1[8];
> +	__le32 V_bus;
> +	__le32 I_bus;
> +	__le32 V_bus_avg;
> +	__le32 I_bus_avg;
> +	u8 _unknown_2[8];
> +	u8 temp[2];
> +	__le16 V_cc1;
> +	__le16 V_cc2;
> +	__le16 V_dp;
> +	__le16 V_dm;
> +	__le16 V_dd;
> +	u8 _unknown_3[4];
> +} __packed;
> +
> +struct powerz_priv {
> +	char transfer_buffer[64];	/* first member to satisfy DMA alignment */
> +	struct mutex mutex;
> +	struct completion completion;
> +	struct urb *urb;
> +	int status;
> +};
> +
> +static const struct hwmon_channel_info *const powerz_info[] = {
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_AVERAGE |
> +			   HWMON_I_MIN | HWMON_I_MAX,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_AVERAGE |
> +			   HWMON_C_MIN | HWMON_I_MAX),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static umode_t powerz_is_visible(const void *data, enum hwmon_sensor_types type,
> +				 u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static int powerz_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, const char **str)
> +{
> +	if (type == hwmon_curr && attr == hwmon_curr_label) {
> +		*str = "IBUS";
> +	} else if (type == hwmon_in && attr == hwmon_in_label) {
> +		if (channel == 0)
> +			*str = "VBUS";
> +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 1)
> +			*str = "VCC1";
> +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 2)
> +			*str = "VCC2";
> +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 3)
> +			*str = "VDP";
> +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 4)
> +			*str = "VDM";
> +		else if (type == hwmon_in && attr == hwmon_in_label && channel == 5)
> +			*str = "VDD";

All those repeated "type == hwmon_in && attr == hwmon_in_label" checks are
unnecessary. Note that this could be much simpler written as

	const char *in_labels[] = {
		"VBUS", "VCC1", "VCC2", "VDP", "VDM", "VDD"
	};
	...
	*str = in_labels[channel];

but I'll leave that up to you.

> +		else
> +			return -EOPNOTSUPP;
> +	} else if (type == hwmon_temp && attr == hwmon_temp_label) {
> +		*str = "TEMP";
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static void powerz_usb_data_complete(struct urb *urb)
> +{
> +	struct powerz_priv *priv = urb->context;
> +
> +	complete(&priv->completion);
> +}
> +
> +static void powerz_usb_cmd_complete(struct urb *urb)
> +{
> +	struct powerz_priv *priv = urb->context;
> +
> +	usb_fill_bulk_urb(urb, urb->dev,
> +			  usb_rcvbulkpipe(urb->dev, POWERZ_EP_DATA_IN),
> +			  priv->transfer_buffer, sizeof(priv->transfer_buffer),
> +			  powerz_usb_data_complete, priv);
> +
> +	priv->status = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (priv->status)
> +		complete(&priv->completion);
> +}
> +
> +static int powerz_read_data(struct usb_device *udev, struct powerz_priv *priv)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&priv->mutex);
> +

This is a local function, so this check is unnecessary.
It is well known that the lock is held when this function is called.

> +	priv->status = -ETIMEDOUT;
> +	reinit_completion(&priv->completion);
> +
> +	priv->transfer_buffer[0] = 0x0c;
> +	priv->transfer_buffer[1] = 0x00;
> +	priv->transfer_buffer[2] = 0x02;
> +	priv->transfer_buffer[3] = 0x00;
> +
> +	usb_fill_bulk_urb(priv->urb, udev, usb_sndbulkpipe(udev, POWERZ_EP_CMD_OUT),
> +			  priv->transfer_buffer, 4, powerz_usb_cmd_complete,
> +			  priv);
> +	ret = usb_submit_urb(priv->urb, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	if (!wait_for_completion_interruptible_timeout
> +	    (&priv->completion, msecs_to_jiffies(5))) {
> +		usb_kill_urb(priv->urb);
> +		return -EIO;
> +	}
> +
> +	if (priv->urb->actual_length < sizeof(struct powerz_sensor_data))
> +		return -EIO;
> +
> +	return priv->status;
> +}
> +
> +static int powerz_read(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long *val)
> +{
> +	struct usb_interface *intf = to_usb_interface(dev->parent);
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct powerz_priv *priv = usb_get_intfdata(intf);
> +	struct powerz_sensor_data *data;
> +	int ret;
> +
> +	if (!priv)
> +		return -EIO; /* disconnected */
> +
> +	mutex_lock(&priv->mutex);
> +	ret = powerz_read_data(udev, priv);
> +	if (ret)
> +		goto out;
> +
> +	data = (struct powerz_sensor_data *)priv->transfer_buffer;
> +
> +	if (type == hwmon_curr) {
> +		if (attr == hwmon_curr_input)
> +			*val = ((s32)le32_to_cpu(data->I_bus)) / 1000;
> +		else if (attr == hwmon_curr_average)
> +			*val = ((s32)le32_to_cpu(data->I_bus_avg)) / 1000;

Just wondering ... does this device really report current in micro-amps ?

> +		else if (attr == hwmon_curr_min)
> +			*val = -POWERZ_MAX_CURRENT;
> +		else if (attr == hwmon_curr_max)
> +			*val = POWERZ_MAX_CURRENT;

I just noticed that. Please drop limits if they are constants.
That is not the idea with limit attributes; they should only
be provided if they are supported/reported by the chip/device,
not if they are constants (yes, I know, there are some drivers
reporting such constants, but that doesn't make it better or
acceptable).

> +		else
> +			ret = -EOPNOTSUPP;
> +	} else if (type == hwmon_in) {
> +		if (attr == hwmon_in_input) {
> +			if (channel == 0)
> +				*val = le32_to_cpu(data->V_bus) / 1000;

and voltage in micro-volt ? Just asking, because I don't think I have
ever seen that.

> +			else if (channel == 1)
> +				*val = le16_to_cpu(data->V_cc1) / 10;
> +			else if (channel == 2)
> +				*val = le16_to_cpu(data->V_cc2) / 10;
> +			else if (channel == 3)
> +				*val = le16_to_cpu(data->V_dp) / 10;
> +			else if (channel == 4)
> +				*val = le16_to_cpu(data->V_dm) / 10;
> +			else if (channel == 5)
> +				*val = le16_to_cpu(data->V_dd) / 10;
> +			else
> +				ret = -EOPNOTSUPP;
> +		} else if (attr == hwmon_in_average && channel == 0) {
> +			*val = le32_to_cpu(data->V_bus_avg) / 1000;
> +		} else if (attr == hwmon_in_min && channel == 0) {
> +			*val = -POWERZ_MAX_VOLTAGE;
> +		} else if (attr == hwmon_in_max && channel == 0) {
> +			*val = POWERZ_MAX_VOLTAGE;
> +		} else {

There are more repeated checks (for channel == 0) here. Not that it matters,
because the constants should not bre reported anyway. Also, I do wonder if
hwmon_in_min == -POWERZ_MAX_VOLTAGE is really correct.

> +			ret = -EOPNOTSUPP;
> +		}
> +	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
> +		*val =
> +		    ((long)data->temp[1]) * 2000 +
> +		    ((long)data->temp[0]) * 1000 / 128;

I guess this is really ((data->temp[1] << 8) + data->temp[0]) * 1000 / 128,
which might be easier to understand, but good enough. The typecasts are
unnecessary, though.

> +	} else {
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +out:
> +	mutex_unlock(&priv->mutex);
> +	return ret;
> +}
> +
> +static const struct hwmon_ops powerz_hwmon_ops = {
> +	.is_visible = powerz_is_visible,
> +	.read = powerz_read,
> +	.read_string = powerz_read_string,
> +};
> +
> +static const struct hwmon_chip_info powerz_chip_info = {
> +	.ops = &powerz_hwmon_ops,
> +	.info = powerz_info,
> +};
> +
> +static int powerz_probe(struct usb_interface *intf,
> +			const struct usb_device_id *id)
> +{
> +	struct powerz_priv *priv;
> +	struct device *hwmon_dev;
> +	struct device *parent;
> +
> +	parent = &intf->dev;
> +
> +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!priv->urb)
> +		return -ENOMEM;
> +	mutex_init(&priv->mutex);
> +	priv->status = -ETIMEDOUT;

I don't see why this would be needed here.

> +	init_completion(&priv->completion);
> +
> +	hwmon_dev =
> +	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
> +						 &powerz_chip_info, NULL);
> +	usb_set_intfdata(intf, priv);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static void powerz_disconnect(struct usb_interface *intf)
> +{
> +	struct powerz_priv *priv = usb_get_intfdata(intf);
> +
> +	mutex_lock(&priv->mutex);
> +	usb_kill_urb(priv->urb);
> +	usb_free_urb(priv->urb);
> +	mutex_unlock(&priv->mutex);
> +}
> +
> +static const struct usb_device_id powerz_id_table[] = {
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) },	/* ChargerLAB POWER-Z KM003C */
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(usb, powerz_id_table);
> +
> +static struct usb_driver powerz_driver = {
> +	.name = DRIVER_NAME,
> +	.id_table = powerz_id_table,
> +	.probe = powerz_probe,
> +	.disconnect = powerz_disconnect,
> +};
> +
> +module_usb_driver(powerz_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
> +MODULE_DESCRIPTION("ChargerLAB POWER-Z USB-C tester");
> 
> ---
> base-commit: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
> change-id: 20230831-powerz-2ccb978a8e57
> 
> Best regards,

