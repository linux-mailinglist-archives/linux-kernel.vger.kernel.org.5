Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6498091A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443844AbjLGTjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjLGTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:39:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3C10E3;
        Thu,  7 Dec 2023 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701977965; x=1702582765; i=w_armin@gmx.de;
        bh=FlkI+k+oeBH/Etk1zxCkWBTkaumhw9bYZGnJ2bBBOpA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=rtVpRV7bmME5HbPqTEi35p5ANrKL5yYwbwU8MQUy9jwnjsRBUwyn2gm3+1H8W98z
         4Q6Gy69Qjeihi+IfgddO9+3cGOYKOhJ9QEqBe/YjI0yEJgfFHYO0urvqVv95EzCfu
         kxLASbv30qzbQdi2ouN+lLiLoPQSm8KEdZYArIoca/9GnjFXf+aPPe68mcCD6IOBz
         n5dB2a+L5sgrPQQd5W9gup804L65WfPh+D99vOatfqo021fwO4c0WauTZKLP2GbIj
         6cZs8CWkVjKtCWreboWo4rkxnAWHt3eIzbbzP9zxE4TfB13SCzYU6jd3+ionCh6Hv
         2jkzsJHAZjWvD4rtzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1rbtan02yG-00iBCl; Thu, 07
 Dec 2023 20:39:25 +0100
Message-ID: <ce3568c5-c35b-40b5-80f1-8334d1b3549b@gmx.de>
Date:   Thu, 7 Dec 2023 20:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231207122402.107032-1-savicaleksa83@gmail.com>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231207122402.107032-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNCFaXr3NY2Qe5Uj3thhoWHroEFs++2WQTY6UdZ7794uip0RUg9
 QMH+UfKQLjemIlg8+4Yfb5Ee20j++U8xqjmvJzNdfAFbnkM/vruVF/eS+lVF3FRHEI9se90
 nspNUJDSuvqzDmvHpDGp1abpOtc2OC2cCvP/zlynKVEMLmTz+ckOQt81XWsGbc6m6DEVKEu
 NdhGPze+DUOzpuEcRZMUQ==
UI-OutboundReport: notjunk:1;M01:P0:OgHdLgysxWc=;8KGAVih6MRGfn2E9Z1zt/U9wmCo
 Ta/YjXzKLY6vz1ZKu081w3knQjCN4MnVSiOpAU1oXcb78rlOnQ1GNcsyBWayO85B62iIlc/MV
 LLxTlDIOXi0OPBgDgaD57W3QpZ8CrgRVIFmBPVoWqu1hFKG3MC++5XwRtWLosM+qZzcMQyPFC
 TyvDG8FM86OH6ofy4lMjJCIaWkfKA/Exs0WJPS61kdxqbEQ8JywEk6gwTicsjpQZqs1iYlj4i
 S9WxQe52xYrITSExr9AaNpDy3hdFZ5DcUbFmtktTfFyxqfNq4XHzMlgRcCC/HXdVP68mXXO58
 tq0SyU1Wp8vVECP+oHji0jrov5SaywPbyd4J0ldQ/UNz6IqDk2Gkia+Fq2nbuFUZVEp4Aaxon
 XaYRQcKGHXDpI5Ryg42mk5uKXiWSkhsRAXCyBgUSy50UcUe/KemrUVK6gOsqGmBMpizPktw+B
 yoEPuR/vzpToh3vx37b1PUg5g6Xp3czn0vdJCZfq4AMgJqWmbAZSELEnGi3zzHsmgR6qDnf56
 jrUeVno4u7JlB4Bqmc26Sbzvz9YCafRIKCMKn7Yb6h66hNfjvrVFSNSVgsT7lXtgtWsb1J8Ug
 8ZtpsZfeBmqyuaRLRkTETRvzwRa9e80AzWBkMdDbQZWrA1yvMrFKddr2zD+BSoyZ4TAKk0pd6
 iIwqc2uEkBeIjZoIrYIhw98Yz0ueI5SxS5xv3Psyq2sVCIhn+NhP5NpBUell1bY25W+Ahgh/i
 B6y4Ag2z/UNSFuGnAYVkY8xaInGLdvqdBl0RnfK8Rq0caWoyq6+r8v33U1kEtH9GFVVFYsYfX
 aO2WjoxyZHxvr8c0xHf+lNfMN2i9IqmrBC7FQ5ws8LZhRLCRI9jGazOyOe3YM1gdTqim5EpQb
 vU0OOs6qcX5latGazy8+suXFxukHAKm/MfoKMF6Vd1HbFZvhQRamhU4RQCZPDmvrlMZFB8/b1
 wtAAzkgwpm51SHQqvOxuXb3LjC8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.12.23 um 13:23 schrieb Aleksa Savic:

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
> Changes in v3:
> - Used memcpy_and_pad() in waterforce_write_expanded()
> - Received error code of mutex locking in waterforce_get_status() is now
>    being returned instead of -ENODATA
> - After wait_for_completion_interruptible_timeout() calls, -ETIMEOUT or
>    received error code are returned throughout the driver
> - Formatted variable declarations to follow the reverse christmas tree s=
hape
> - In waterforce_read(), removed status validity check because it's check=
ed
>    when actually getting status
> - In waterforce_read(), error code of waterforce_get_status() is now ret=
urned
>    instead of -ENODATA
> - In waterforce_read(), -EOPNOTSUPP is now returned in the default case =
of
>    hwmon_pwm
> - Removed unneeded #ifdef related to CONFIG_DEBUG_FS and the empty funct=
ion
> - Moved check of success of fw version retrieval to waterforce_debugfs_i=
nit()
> - Fixed the error handling path in waterforce_probe()
> - Moved the fw version request before hwmon registration and removed the
>    hid_device_io_stop() call in waterforce_probe()
> - Added missing debugfs_remove_recursive() call in waterforce_remove()
>
> Changes in v2 (fix issues reported by kernel bot):
> - Add driver doc to hwmon doc index
> - Initialize ret value in waterforce_get_status() to 0
> ---
>   Documentation/hwmon/gigabyte_waterforce.rst |  47 +++
>   Documentation/hwmon/index.rst               |   1 +
>   MAINTAINERS                                 |   7 +
>   drivers/hwmon/Kconfig                       |  10 +
>   drivers/hwmon/Makefile                      |   1 +
>   drivers/hwmon/gigabyte_waterforce.c         | 428 ++++++++++++++++++++
>   6 files changed, 494 insertions(+)
>   create mode 100644 Documentation/hwmon/gigabyte_waterforce.rst
>   create mode 100644 drivers/hwmon/gigabyte_waterforce.c
>
> diff --git a/Documentation/hwmon/gigabyte_waterforce.rst b/Documentation=
/hwmon/gigabyte_waterforce.rst
> new file mode 100644
> index 000000000000..d47f3e8516ee
> --- /dev/null
> +++ b/Documentation/hwmon/gigabyte_waterforce.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver gigabyte_waterforce
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +This driver enables hardware monitoring support for the listed Gigabyte=
 Waterforce
> +all-in-one CPU liquid coolers. Available sensors are pump and fan speed=
 in RPM, as
> +well as coolant temperature. Also available through debugfs is the firm=
ware version.
> +
> +Attaching a fan is optional and allows it to be controlled from the dev=
ice. If
> +it's not connected, the fan-related sensors will report zeroes.
> +
> +The addressable RGB LEDs and LCD screen are not supported in this drive=
r and should
> +be controlled through userspace tools.
> +
> +Usage notes
> +-----------
> +
> +As these are USB HIDs, the driver can be loaded automatically by the ke=
rnel and
> +supports hot swapping.
> +
> +Sysfs entries
> +-------------
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +fan1_input  Fan speed (in rpm)
> +fan2_input  Pump speed (in rpm)
> +temp1_input Coolant temperature (in millidegrees Celsius)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Debugfs entries
> +---------------
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +firmware_version Device firmware version
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> index 095c36f5e8a1..36101e9e38e9 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
>      ftsteutates
>      g760a
>      g762
> +   gigabyte_waterforce
>      gsc-hwmon
>      gl518sm
>      gxp-fan-ctrl
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..b1a69c5042b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8960,6 +8960,13 @@ F:	Documentation/filesystems/gfs2*
>   F:	fs/gfs2/
>   F:	include/uapi/linux/gfs2_ondisk.h
>
> +GIGABYTE WATERFORCE SENSOR DRIVER
> +M:	Aleksa Savic <savicaleksa83@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/gigabyte_waterforce.rst
> +F:	drivers/hwmon/gigabyte_waterforce.c
> +
>   GIGABYTE WMI DRIVER
>   M:	Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 76cb05db1dcf..a608264da87d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -664,6 +664,16 @@ config SENSORS_FTSTEUTATES
>   	  This driver can also be built as a module. If so, the module
>   	  will be called ftsteutates.
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
>   config SENSORS_GL518SM
>   	tristate "Genesys Logic GL518SM"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e84bd9685b5c..47be39af5c03 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_SENSORS_FSCHMD)	+=3D fschmd.o
>   obj-$(CONFIG_SENSORS_FTSTEUTATES) +=3D ftsteutates.o
>   obj-$(CONFIG_SENSORS_G760A)	+=3D g760a.o
>   obj-$(CONFIG_SENSORS_G762)	+=3D g762.o
> +obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) +=3D gigabyte_waterforce.o
>   obj-$(CONFIG_SENSORS_GL518SM)	+=3D gl518sm.o
>   obj-$(CONFIG_SENSORS_GL520SM)	+=3D gl520sm.o
>   obj-$(CONFIG_SENSORS_GSC)	+=3D gsc-hwmon.o
> diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyt=
e_waterforce.c
> new file mode 100644
> index 000000000000..1799377fc2f1
> --- /dev/null
> +++ b/drivers/hwmon/gigabyte_waterforce.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hwmon driver for Gigabyte AORUS Waterforce AIO CPU coolers: X240, X2=
80 and X360.
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
> +#define USB_PRODUCT_ID_WATERFORCE	0x7a4d	/* Gigabyte AORUS WATERFORCE X=
240, X280 and X360 */
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
> +static const u8 get_status_cmd[] =3D { 0x99, 0xDA };
> +
> +#define FIRMWARE_VER_START_OFFSET_1	2
> +#define FIRMWARE_VER_START_OFFSET_2	3
> +static const u8 get_firmware_ver_cmd[] =3D { 0x99, 0xD6 };
> +
> +/* Command lengths */
> +#define GET_STATUS_CMD_LENGTH		2
> +#define GET_FIRMWARE_VER_CMD_LENGTH	2
> +
> +static const char *const waterforce_temp_label[] =3D {
> +	"Coolant temp"
> +};
> +
> +static const char *const waterforce_speed_label[] =3D {
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
> +/* Writes the command to the device with the rest of the report filled =
with zeroes */
> +static int waterforce_write_expanded(struct waterforce_data *priv, cons=
t u8 *cmd, int cmd_length)
> +{
> +	int ret;
> +
> +	mutex_lock(&priv->buffer_lock);
> +
> +	memcpy_and_pad(priv->buffer, MAX_REPORT_LENGTH, cmd, cmd_length, 0x00)=
;
> +	ret =3D hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENG=
TH);
> +
> +	mutex_unlock(&priv->buffer_lock);
> +	return ret;
> +}
> +
> +static int waterforce_get_status(struct waterforce_data *priv)
> +{
> +	int ret =3D mutex_lock_interruptible(&priv->status_report_request_mute=
x);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALID=
ITY))) {
> +		/* Data is up to date */
> +		goto unlock_and_return;
> +	}
> +
> +	/*
> +	 * Disable raw event parsing for a moment to safely reinitialize the
> +	 * completion. Reinit is done because hidraw could have triggered
> +	 * the raw event parsing and marked the priv->status_report_received
> +	 * completion as done.
> +	 */
> +	spin_lock_bh(&priv->status_report_request_lock);
> +	reinit_completion(&priv->status_report_received);
> +	spin_unlock_bh(&priv->status_report_request_lock);
> +
> +	/* Send command for getting status */
> +	ret =3D waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD=
_LENGTH);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D wait_for_completion_interruptible_timeout(&priv->status_report=
_received,
> +							msecs_to_jiffies(STATUS_VALIDITY));
> +	if (ret =3D=3D 0)
> +		ret =3D -ETIMEDOUT;
> +
> +unlock_and_return:
> +	mutex_unlock(&priv->status_report_request_mutex);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int waterforce_read(struct device *dev, enum hwmon_sensor_types =
type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct waterforce_data *priv =3D dev_get_drvdata(dev);
> +	int ret =3D waterforce_get_status(priv);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		*val =3D priv->temp_input[channel];
> +		break;
> +	case hwmon_fan:
> +		*val =3D priv->speed_input[channel];
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			*val =3D DIV_ROUND_CLOSEST(priv->duty_input[channel] * 255, 100);
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;	/* unreachable */
> +	}
> +
> +	return 0;
> +}
> +
> +static int waterforce_read_string(struct device *dev, enum hwmon_sensor=
_types type,
> +				  u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		*str =3D waterforce_temp_label[channel];
> +		break;
> +	case hwmon_fan:
> +		*str =3D waterforce_speed_label[channel];
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
> +	struct waterforce_data *priv =3D hid_get_drvdata(hdev);
> +	int ret;
> +
> +	ret =3D waterforce_write_expanded(priv, get_firmware_ver_cmd, GET_FIRM=
WARE_VER_CMD_LENGTH);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D wait_for_completion_interruptible_timeout(&priv->fw_version_pr=
ocessed,
> +							msecs_to_jiffies(STATUS_VALIDITY));
> +	if (ret =3D=3D 0)
> +		return -ETIMEDOUT;
> +	else if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops waterforce_hwmon_ops =3D {
> +	.is_visible =3D waterforce_is_visible,
> +	.read =3D waterforce_read,
> +	.read_string =3D waterforce_read_string
> +};
> +
> +static const struct hwmon_channel_info *waterforce_info[] =3D {
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
> +static const struct hwmon_chip_info waterforce_chip_info =3D {
> +	.ops =3D &waterforce_hwmon_ops,
> +	.info =3D waterforce_info,
> +};
> +
> +static int waterforce_raw_event(struct hid_device *hdev, struct hid_rep=
ort *report, u8 *data,
> +				int size)
> +{
> +	struct waterforce_data *priv =3D hid_get_drvdata(hdev);
> +
> +	if (data[0] =3D=3D get_firmware_ver_cmd[0] && data[1] =3D=3D get_firmw=
are_ver_cmd[1]) {
> +		/* Received a firmware version report */
> +		priv->firmware_version =3D
> +		    data[FIRMWARE_VER_START_OFFSET_1] * 10 + data[FIRMWARE_VER_START_=
OFFSET_2];
> +
> +		if (!completion_done(&priv->fw_version_processed))
> +			complete_all(&priv->fw_version_processed);
> +		return 0;
> +	}
> +
> +	if (data[0] !=3D get_status_cmd[0] || data[1] !=3D get_status_cmd[1])
> +		return 0;
> +
> +	priv->temp_input[0] =3D data[WATERFORCE_TEMP_SENSOR] * 1000;
> +	priv->speed_input[0] =3D get_unaligned_le16(data + WATERFORCE_FAN_SPEE=
D);
> +	priv->speed_input[1] =3D get_unaligned_le16(data + WATERFORCE_PUMP_SPE=
ED);
> +	priv->duty_input[0] =3D data[WATERFORCE_FAN_DUTY];
> +	priv->duty_input[1] =3D data[WATERFORCE_PUMP_DUTY];
> +
> +	if (!completion_done(&priv->status_report_received))
> +		complete_all(&priv->status_report_received);
> +
> +	priv->updated =3D jiffies;
> +
> +	return 0;
> +}
> +
> +static int firmware_version_show(struct seq_file *seqf, void *unused)
> +{
> +	struct waterforce_data *priv =3D seqf->private;
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
> +	if (!priv->firmware_version)
> +		return;	/* There's nothing to show in debugfs */
> +
> +	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hd=
ev->dev));
> +
> +	priv->debugfs =3D debugfs_create_dir(name, NULL);
> +	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &fi=
rmware_version_fops);
> +}
> +
> +static int waterforce_probe(struct hid_device *hdev, const struct hid_d=
evice_id *id)
> +{
> +	struct waterforce_data *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->hdev =3D hdev;
> +	hid_set_drvdata(hdev, priv);
> +
> +	/*
> +	 * Initialize priv->updated to STATUS_VALIDITY seconds in the past, ma=
king
> +	 * the initial empty data invalid for waterforce_read() without the ne=
ed for
> +	 * a special case there.
> +	 */
> +	priv->updated =3D jiffies - msecs_to_jiffies(STATUS_VALIDITY);
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid parse failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Enable hidraw so existing user-space tools can continue to work.
> +	 */
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +	if (ret) {
> +		hid_err(hdev, "hid hw start failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "hid hw open failed with %d\n", ret);
> +		goto fail_and_stop;
> +	}
> +
> +	priv->buffer =3D devm_kzalloc(&hdev->dev, MAX_REPORT_LENGTH, GFP_KERNE=
L);
> +	if (!priv->buffer) {
> +		ret =3D -ENOMEM;
> +		goto fail_and_close;
> +	}
> +
> +	mutex_init(&priv->status_report_request_mutex);
> +	mutex_init(&priv->buffer_lock);
> +	spin_lock_init(&priv->status_report_request_lock);
> +	init_completion(&priv->status_report_received);
> +	init_completion(&priv->fw_version_processed);
> +
> +	hid_device_io_start(hdev);
> +	ret =3D waterforce_get_fw_ver(hdev);
> +	if (ret < 0)
> +		hid_warn(hdev, "fw version request failed with %d\n", ret);
> +
> +	priv->hwmon_dev =3D hwmon_device_register_with_info(&hdev->dev, "water=
force",
> +							  priv, &waterforce_chip_info, NULL);
> +	if (IS_ERR(priv->hwmon_dev)) {
> +		ret =3D PTR_ERR(priv->hwmon_dev);
> +		hid_err(hdev, "hwmon registration failed with %d\n", ret);
> +		goto fail_and_close;
> +	}
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
> +	struct waterforce_data *priv =3D hid_get_drvdata(hdev);
> +
> +	debugfs_remove_recursive(priv->debugfs);
> +	hwmon_device_unregister(priv->hwmon_dev);
> +
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id waterforce_table[] =3D {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GIGABYTE, USB_PRODUCT_ID_WATERFORCE) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(hid, waterforce_table);
> +
> +static struct hid_driver waterforce_driver =3D {
> +	.name =3D "waterforce",
> +	.id_table =3D waterforce_table,
> +	.probe =3D waterforce_probe,
> +	.remove =3D waterforce_remove,
> +	.raw_event =3D waterforce_raw_event,
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

Hi,

I think you could use the module_hid_driver() macro here.

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> +MODULE_DESCRIPTION("Hwmon driver for Gigabyte AORUS Waterforce AIO cool=
ers");
