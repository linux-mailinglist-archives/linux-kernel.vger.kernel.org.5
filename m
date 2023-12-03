Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E06802600
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjLCRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:36:35 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F089D3;
        Sun,  3 Dec 2023 09:36:38 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b8b80cec8fso607197b6e.0;
        Sun, 03 Dec 2023 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701624997; x=1702229797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kr523lRBe8IV4pq/uiBDJFcnMQHibNgt7yO0lESf8Sk=;
        b=mxi5olRy5FyhqN4HhnGgx12/doM+L+k7TwG/nPSBix3K3TCCwt9tSUpOUKA1FkegU0
         iMr1a7lrKTcwIS8lkEQtAeV4WRq9XztUjkbTdy2z/WjRRXr4LZcHSChLYsbGhWCgLsOs
         O+vqoj5Wm+2zbFm5fvV1hehdr8AJaWsND+eC8LrRrzx+TootLJN6DVpObVMiTY8Dsi3b
         ootfN4RdvUx1iiVXJudBxHgYxCkHSwBOnukIZbFWdvV75uPegzU4uvyOqLHqDxfo+XPe
         W+Q90Z82hx1q3195SYq5NDu/2yFT5lntEeKGbNPnmLDOcPffMUHDZfd5v24Y9FlI7Pow
         hKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701624997; x=1702229797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr523lRBe8IV4pq/uiBDJFcnMQHibNgt7yO0lESf8Sk=;
        b=DISEL7jlwJXTrivi3DqoU3ym0SYVu+hFGsc0PdbAIqihc+psajmyASS5AhV6JvJJdF
         xdNy3xIrUb6rK9hez6f2S5MOCP3YaoQiIa6nUIZGhdbJQ9hUIvDYgdbGqC0yaQD+KQko
         JcEqK8EF1oHYHp0NJHW3jzF5ruV9PiY3b8llHqE+AeMjgDDPpQIJbVU3dd373pp+rl+m
         zVeS+6Jeaj8Y9Cp3BXplt8I+myODzK+ptNFdlapPpf0Z/cNiiKiTsCx60jQfuXpYkCrh
         Awt3Zc4nS2lpDB1b1g+jMwC01c+qp+irjULcOwymhKnschkO36TwmEhEUxmMA3QO5WYj
         fZzw==
X-Gm-Message-State: AOJu0YxZi/Dy+pvYTmXXt7imvyD8akMC1MdOl538Z3xu+yz9H4lXYUGg
        GjElkDG0rBM5iV0icTZN50LnhNvULh0=
X-Google-Smtp-Source: AGHT+IFH1k+H9pcE9nrhC+gdTIbxooFtrYFTHQfzU+Jm1p7jeVQBlTZW0oHtPjzCSbjq8EKBLeO/0Q==
X-Received: by 2002:a05:6870:818c:b0:1fb:165c:473a with SMTP id k12-20020a056870818c00b001fb165c473amr3077496oae.57.1701624997201;
        Sun, 03 Dec 2023 09:36:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id se6-20020a05687122c600b001faf09f0899sm1653654oab.24.2023.12.03.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:36:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 3 Dec 2023 09:36:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Message-ID: <b45529ba-619c-41d7-a890-3b81cf699ebe@roeck-us.net>
References: <20231203120651.371429-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231203120651.371429-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 01:06:48PM +0100, Aleksa Savic wrote:
> This driver exposes hardware sensors of the Gigabyte AORUS Waterforce
> all-in-one CPU liquid coolers, which communicate through a proprietary
> USB HID protocol. Report offsets were initially discovered in [1] and
> confirmed by me on a Waterforce X240 by observing the sent reports from
> the official software.
> 
> Available sensors are pump and fan speed in RPM, as well as coolant
> temperature. Also available through debugfs is the firmware version.
> 
> Attaching a fan is optional and allows it to be controlled from the
> device. If it's not connected, the fan-related sensors will report
> zeroes.
> 
> The addressable RGB LEDs and LCD screen are not supported in this
> driver and should be controlled through userspace tools.
> 
> [1]: https://github.com/liquidctl/liquidctl/issues/167
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> Changes in v2 (fix issues reported by kernel bot):
> - Add driver doc to hwmon doc index
> - Initialize ret value in waterforce_get_status() to 0
> ---
>  Documentation/hwmon/gigabyte_waterforce.rst |  47 +++
>  Documentation/hwmon/index.rst               |   1 +
>  MAINTAINERS                                 |   7 +
>  drivers/hwmon/Kconfig                       |  10 +
>  drivers/hwmon/Makefile                      |   1 +
>  drivers/hwmon/gigabyte_waterforce.c         | 439 ++++++++++++++++++++
>  6 files changed, 505 insertions(+)
>  create mode 100644 Documentation/hwmon/gigabyte_waterforce.rst
>  create mode 100644 drivers/hwmon/gigabyte_waterforce.c
> 
> diff --git a/Documentation/hwmon/gigabyte_waterforce.rst b/Documentation/hwmon/gigabyte_waterforce.rst
> new file mode 100644
> index 000000000000..d47f3e8516ee
> --- /dev/null
> +++ b/Documentation/hwmon/gigabyte_waterforce.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver gigabyte_waterforce
> +=================================
> +
> +Supported devices:
> +
> +* Gigabyte AORUS WATERFORCE X240
> +* Gigabyte AORUS WATERFORCE X280
> +* Gigabyte AORUS WATERFORCE X360
> +
> +Author: Aleksa Savic
> +
> +Description
> +-----------
> +
> +This driver enables hardware monitoring support for the listed Gigabyte Waterforce
> +all-in-one CPU liquid coolers. Available sensors are pump and fan speed in RPM, as
> +well as coolant temperature. Also available through debugfs is the firmware version.
> +
> +Attaching a fan is optional and allows it to be controlled from the device. If
> +it's not connected, the fan-related sensors will report zeroes.
> +
> +The addressable RGB LEDs and LCD screen are not supported in this driver and should
> +be controlled through userspace tools.
> +
> +Usage notes
> +-----------
> +
> +As these are USB HIDs, the driver can be loaded automatically by the kernel and
> +supports hot swapping.
> +
> +Sysfs entries
> +-------------
> +
> +=========== =============================================
> +fan1_input  Fan speed (in rpm)
> +fan2_input  Pump speed (in rpm)
> +temp1_input Coolant temperature (in millidegrees Celsius)
> +=========== =============================================
> +
> +Debugfs entries
> +---------------
> +
> +================ =======================
> +firmware_version Device firmware version
> +================ =======================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 095c36f5e8a1..36101e9e38e9 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
>     ftsteutates
>     g760a
>     g762
> +   gigabyte_waterforce
>     gsc-hwmon
>     gl518sm
>     gxp-fan-ctrl
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..b1a69c5042b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8960,6 +8960,13 @@ F:	Documentation/filesystems/gfs2*
>  F:	fs/gfs2/
>  F:	include/uapi/linux/gfs2_ondisk.h
>  
> +GIGABYTE WATERFORCE SENSOR DRIVER
> +M:	Aleksa Savic <savicaleksa83@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/gigabyte_waterforce.rst
> +F:	drivers/hwmon/gigabyte_waterforce.c
> +
>  GIGABYTE WMI DRIVER
>  M:	Thomas Weiﬂschuh <thomas@weissschuh.net>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 76cb05db1dcf..a608264da87d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -664,6 +664,16 @@ config SENSORS_FTSTEUTATES
>  	  This driver can also be built as a module. If so, the module
>  	  will be called ftsteutates.
>  
> +config SENSORS_GIGABYTE_WATERFORCE
> +	tristate "Gigabyte Waterforce X240/X280/X360 AIO CPU coolers"
> +	depends on USB_HID
> +	help
> +	  If you say yes here you get support for hardware monitoring for the
> +	  Gigabyte Waterforce X240/X280/X360 all-in-one CPU liquid coolers.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called gigabyte_waterforce.
> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e84bd9685b5c..47be39af5c03 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
>  obj-$(CONFIG_SENSORS_FTSTEUTATES) += ftsteutates.o
>  obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
>  obj-$(CONFIG_SENSORS_G762)	+= g762.o
> +obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
> diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
> new file mode 100644
> index 000000000000..5c1084ad340a
> --- /dev/null
> +++ b/drivers/hwmon/gigabyte_waterforce.c
> @@ -0,0 +1,439 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hwmon driver for Gigabyte AORUS Waterforce AIO CPU coolers: X240, X280 and X360.
> + *
> + * Copyright 2023 Aleksa Savic <savicaleksa83@gmail.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/hid.h>
> +#include <linux/hwmon.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <asm/unaligned.h>
> +
> +#define DRIVER_NAME	"gigabyte_waterforce"
> +
> +#define USB_VENDOR_ID_GIGABYTE		0x1044
> +#define USB_PRODUCT_ID_WATERFORCE	0x7a4d	/* Gigabyte AORUS WATERFORCE X240, X280 and X360 */
> +
> +#define STATUS_VALIDITY		(2 * 1000)	/* ms */
> +#define MAX_REPORT_LENGTH	6144
> +
> +#define WATERFORCE_TEMP_SENSOR	0xD
> +#define WATERFORCE_FAN_SPEED	0x02
> +#define WATERFORCE_PUMP_SPEED	0x05
> +#define WATERFORCE_FAN_DUTY	0x08
> +#define WATERFORCE_PUMP_DUTY	0x09
> +
> +/* Control commands, inner offsets and lengths */
> +static const u8 get_status_cmd[] = { 0x99, 0xDA };
> +
> +#define FIRMWARE_VER_START_OFFSET_1	2
> +#define FIRMWARE_VER_START_OFFSET_2	3
> +static const u8 get_firmware_ver_cmd[] = { 0x99, 0xD6 };
> +
> +/* Command lengths */
> +#define GET_STATUS_CMD_LENGTH		2
> +#define GET_FIRMWARE_VER_CMD_LENGTH	2
> +
> +static const char *const waterforce_temp_label[] = {
> +	"Coolant temp"
> +};
> +
> +static const char *const waterforce_speed_label[] = {
> +	"Fan speed",
> +	"Pump speed"
> +};
> +
> +struct waterforce_data {
> +	struct hid_device *hdev;
> +	struct device *hwmon_dev;
> +	struct dentry *debugfs;
> +	/* For locking access to buffer */
> +	struct mutex buffer_lock;
> +	/* For queueing multiple readers */
> +	struct mutex status_report_request_mutex;
> +	/* For reinitializing the completion below */
> +	spinlock_t status_report_request_lock;
> +	struct completion status_report_received;
> +	struct completion fw_version_processed;
> +
> +	/* Sensor data */
> +	s32 temp_input[1];
> +	u16 speed_input[2];	/* Fan and pump speed in RPM */
> +	u8 duty_input[2];	/* Fan and pump duty in 0-100% */
> +
> +	u8 *buffer;
> +	int firmware_version;
> +	unsigned long updated;	/* jiffies */
> +};
> +
> +static umode_t waterforce_is_visible(const void *data,
> +				     enum hwmon_sensor_types type, u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +		case hwmon_temp_input:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_label:
> +		case hwmon_fan_input:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Writes the command to the device with the rest of the report filled with zeroes */
> +static int waterforce_write_expanded(struct waterforce_data *priv, const u8 *cmd, int cmd_length)
> +{
> +	int ret;
> +
> +	mutex_lock(&priv->buffer_lock);
> +
> +	memset(priv->buffer, 0x00, MAX_REPORT_LENGTH);
> +	memcpy(priv->buffer, cmd, cmd_length);
> +	ret = hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENGTH);
> +
> +	mutex_unlock(&priv->buffer_lock);
> +	return ret;
> +}
> +
> +static int waterforce_get_status(struct waterforce_data *priv)
> +{
> +	int ret = 0;
> +
> +	if (!mutex_lock_interruptible(&priv->status_report_request_mutex)) {
> +		if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
> +			/* Data is up to date */
> +			goto unlock_and_return;
> +		}

What is the point of this check ? The calling code already checks it.
Checking it twice, once inside and once outside the lock, seems
excessive.

> +
> +		/*
> +		 * Disable raw event parsing for a moment to safely reinitialize the
> +		 * completion. Reinit is done because hidraw could have triggered
> +		 * the raw event parsing and marked the priv->status_report_received
> +		 * completion as done.
> +		 */
> +		spin_lock_bh(&priv->status_report_request_lock);
> +		reinit_completion(&priv->status_report_received);
> +		spin_unlock_bh(&priv->status_report_request_lock);
> +
> +		/* Send command for getting status */
> +		ret = waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD_LENGTH);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (wait_for_completion_interruptible_timeout
> +		    (&priv->status_report_received, msecs_to_jiffies(STATUS_VALIDITY)) <= 0)
> +			ret = -ENODATA;

-ETIMEDOUT if timed out, or error code if one was reported.

> +unlock_and_return:
> +		mutex_unlock(&priv->status_report_request_mutex);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		return -ENODATA;
> +	}

This should be something like

	rc = mutex_lock_interruptible(&priv->status_report_request_mutex);
	if (rc)
		return rc;

The returned error code should not be overwritten. If you want to make the mutex
interruptible, report the interrupt event to the caller.

> +
> +	return 0;
> +}
> +
> +static int waterforce_read(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	int ret;
> +	struct waterforce_data *priv = dev_get_drvdata(dev);

I don't enfore it, but declaring variables in reverse christmas tree order
(longer variables first) does look nicer.
> +
> +	if (time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
> +		/* Request status on demand */
> +		ret = waterforce_get_status(priv);
> +		if (ret < 0)
> +			return -ENODATA;

Again, please do not overwrite error codes. Here you are overwriting it twice,
which is really not appropriate.

> +	}
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		*val = priv->temp_input[channel];
> +		break;
> +	case hwmon_fan:
> +		*val = priv->speed_input[channel];
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			*val = DIV_ROUND_CLOSEST(priv->duty_input[channel] * 255, 100);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;	/* unreachable */
> +	}
> +
> +	return 0;
> +}
> +
> +static int waterforce_read_string(struct device *dev, enum hwmon_sensor_types type,
> +				  u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		*str = waterforce_temp_label[channel];
> +		break;
> +	case hwmon_fan:
> +		*str = waterforce_speed_label[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;	/* unreachable */
> +	}
> +
> +	return 0;
> +}
> +
> +static int waterforce_get_fw_ver(struct hid_device *hdev)
> +{
> +	int ret;
> +	struct waterforce_data *priv = hid_get_drvdata(hdev);
> +
> +	ret = waterforce_write_expanded(priv, get_firmware_ver_cmd, GET_FIRMWARE_VER_CMD_LENGTH);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (wait_for_completion_interruptible_timeout
> +	    (&priv->fw_version_processed, msecs_to_jiffies(STATUS_VALIDITY)) <= 0)
> +		return -ENODATA;

Another overwritten error code.

> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops waterforce_hwmon_ops = {
> +	.is_visible = waterforce_is_visible,
> +	.read = waterforce_read,
> +	.read_string = waterforce_read_string
> +};
> +
> +static const struct hwmon_channel_info *waterforce_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info waterforce_chip_info = {
> +	.ops = &waterforce_hwmon_ops,
> +	.info = waterforce_info,
> +};
> +
> +static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
> +				int size)
> +{
> +	struct waterforce_data *priv = hid_get_drvdata(hdev);
> +
> +	if (data[0] == get_firmware_ver_cmd[0] && data[1] == get_firmware_ver_cmd[1]) {
> +		/* Received a firmware version report */
> +		priv->firmware_version =
> +		    data[FIRMWARE_VER_START_OFFSET_1] * 10 + data[FIRMWARE_VER_START_OFFSET_2];
> +
> +		if (!completion_done(&priv->fw_version_processed))
> +			complete_all(&priv->fw_version_processed);
> +		return 0;
> +	}
> +
> +	if (data[0] != get_status_cmd[0] || data[1] != get_status_cmd[1])
> +		return 0;
> +
> +	priv->temp_input[0] = data[WATERFORCE_TEMP_SENSOR] * 1000;
> +	priv->speed_input[0] = get_unaligned_le16(data + WATERFORCE_FAN_SPEED);
> +	priv->speed_input[1] = get_unaligned_le16(data + WATERFORCE_PUMP_SPEED);
> +	priv->duty_input[0] = data[WATERFORCE_FAN_DUTY];
> +	priv->duty_input[1] = data[WATERFORCE_PUMP_DUTY];
> +
> +	if (!completion_done(&priv->status_report_received))
> +		complete_all(&priv->status_report_received);
> +
> +	priv->updated = jiffies;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +

Those ifdefs are unnecessary.

> +static int firmware_version_show(struct seq_file *seqf, void *unused)
> +{
> +	struct waterforce_data *priv = seqf->private;
> +
> +	if (!priv->firmware_version)
> +		return -ENODATA;

Maybe don't create the file in the firmware version is not reported.
Returning an error when trying to read it seems pointless (and confusing).

> +
> +	seq_printf(seqf, "%u\n", priv->firmware_version);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(firmware_version);
> +
> +static void waterforce_debugfs_init(struct waterforce_data *priv)
> +{
> +	char name[64];
> +
> +	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
> +
> +	priv->debugfs = debugfs_create_dir(name, NULL);
> +	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
> +}
> +
> +#else
> +
> +static void waterforce_debugfs_init(struct waterforce_data *priv)
> +{
> +}
> +
> +#endif
> +
> +static int waterforce_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	struct waterforce_data *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->hdev = hdev;
> +	hid_set_drvdata(hdev, priv);
> +
> +	/*
> +	 * Initialize priv->updated to STATUS_VALIDITY seconds in the past, making
> +	 * the initial empty data invalid for waterforce_read() without the need for
> +	 * a special case there.
> +	 */
> +	priv->updated = jiffies - msecs_to_jiffies(STATUS_VALIDITY);
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid parse failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Enable hidraw so existing user-space tools can continue to work.
> +	 */
> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +	if (ret) {
> +		hid_err(hdev, "hid hw start failed with %d\n", ret);
> +		goto fail_and_stop;
> +	}
> +
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid hw open failed with %d\n", ret);
> +		goto fail_and_close;
> +	}
> +
> +	priv->buffer = devm_kzalloc(&hdev->dev, MAX_REPORT_LENGTH, GFP_KERNEL);
> +	if (!priv->buffer) {
> +		ret = -ENOMEM;
> +		goto fail_and_close;
> +	}
> +
> +	mutex_init(&priv->status_report_request_mutex);
> +	mutex_init(&priv->buffer_lock);
> +	spin_lock_init(&priv->status_report_request_lock);
> +	init_completion(&priv->status_report_received);
> +	init_completion(&priv->fw_version_processed);
> +
> +	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "waterforce",
> +							  priv, &waterforce_chip_info, NULL);
> +	if (IS_ERR(priv->hwmon_dev)) {
> +		ret = PTR_ERR(priv->hwmon_dev);
> +		hid_err(hdev, "hwmon registration failed with %d\n", ret);
> +		goto fail_and_close;
> +	}
> +
> +	hid_device_io_start(hdev);
> +	ret = waterforce_get_fw_ver(hdev);
> +	if (ret < 0)
> +		hid_warn(hdev, "fw version request failed with %d\n", ret);
> +	hid_device_io_stop(hdev);

Doesn't this interfere with normal hwmon operation if a hwmon request
is made immediately after hwmon device registration ?

> +
> +	waterforce_debugfs_init(priv);
> +
> +	return 0;
> +
> +fail_and_close:
> +	hid_hw_close(hdev);
> +fail_and_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}
> +
> +static void waterforce_remove(struct hid_device *hdev)
> +{
> +	struct waterforce_data *priv = hid_get_drvdata(hdev);
> +
> +	hwmon_device_unregister(priv->hwmon_dev);
> +
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id waterforce_table[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GIGABYTE, USB_PRODUCT_ID_WATERFORCE) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(hid, waterforce_table);
> +
> +static struct hid_driver waterforce_driver = {
> +	.name = "waterforce",
> +	.id_table = waterforce_table,
> +	.probe = waterforce_probe,
> +	.remove = waterforce_remove,
> +	.raw_event = waterforce_raw_event,
> +};
> +
> +static int __init waterforce_init(void)
> +{
> +	return hid_register_driver(&waterforce_driver);
> +}
> +
> +static void __exit waterforce_exit(void)
> +{
> +	hid_unregister_driver(&waterforce_driver);
> +}
> +
> +/* When compiled into the kernel, initialize after the HID bus */
> +late_initcall(waterforce_init);
> +module_exit(waterforce_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> +MODULE_DESCRIPTION("Hwmon driver for Gigabyte AORUS Waterforce AIO coolers");
