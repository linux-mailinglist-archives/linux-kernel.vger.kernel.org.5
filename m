Return-Path: <linux-kernel+bounces-12753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AE81F9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8441EB21BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AFF4E7;
	Thu, 28 Dec 2023 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="m2AL7Csr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9AE56D;
	Thu, 28 Dec 2023 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703777283; x=1704382083; i=w_armin@gmx.de;
	bh=JoMZzxoz1AyN/o68qFoJ8TIjdWVJRwd0SjvPnZvzqyQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=m2AL7CsrqCDZIThNru75hcbHka74FZAv+1QTvAlYErEG8VWM+weYwPwzaWy2GLwA
	 2F3bHsShZ54er96zzb8DjSSa5+fLCnAVLYi/5aPwwaymtUJlOlD5DsOxgLqivf4Wl
	 OqUiMgFvM0SoVkGUJFA+T7/se+NOSmty4c2SvFxjMhtztlxfq1psFQ8MIvrmXr4js
	 nSdgYLyJ/Tg0/JJCY3xLgz9TXLKNxX9QKCvTRP1jCuEiwHlWVfngfv+4V8/CP/ZOr
	 rP/Pcn4IJEQbnazKKcUTL8gDH1yHJFVIuoZbDM6KF6IGnqR8UhCaHOwzQT6RgB5oy
	 ++UVkPAtleBoeQxmJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1r4lT33Vh9-00xKDe; Thu, 28
 Dec 2023 16:28:02 +0100
Message-ID: <764c0645-674a-4a25-9bdb-2707e9532af7@gmx.de>
Date: Thu, 28 Dec 2023 16:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add fan speed monitoring driver for Surface
 devices
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231228003444.5580-1-ivor@iwanders.net>
 <20231228003444.5580-2-ivor@iwanders.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231228003444.5580-2-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jKXoy0BP/OWNiRV4XTKDi/eF1XgUNjCt5DWvopzVi9W0NE1SEjj
 vcEqnv6pLDaK42oN94B6D/5RxG3S3Asesrl0XbZRkywTisXxSgTcXNiOnoJZrTx7eExVNnK
 sGGJN2JBZ2d3uwPwKNRImauc7UW95BuYgZ9dVZTMCv5qgFu4KbynAE2f8kH8AEO5IDMrDPc
 B/1oEWoPIWDYjUpbj3Fiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5cm1qWdS16M=;X0v/47nElLVwqZK6xbzSo8zG3YW
 CUHihWOfk31eZgdCaeHqLnNuSlUE1f9gtsfY66CXGA2Umgfs18nok0y3ivuD2XnYO5XiqrLty
 93ITTHQqnJR66mQGh1fpzXajsL/zi2JjunAzZFDtd5VYi5ARKJ6xvLjV5K74zY7aQtlxbtw2c
 FMnTaoJnw4gktW4WeWgCn892xuPvydzslUWWR7kCILqpj/7H+xb/KYPLjzVQk//Q5dPQRXw4b
 1+/MJqLnj59OLNzLY/ZRV1NCWiMZ7U/LoZeQGNhkWnZ0WZmN8gs+Tj05IUcvHJagiGeFBniCy
 l86g6HjvHU26BmiLI46qAcU3K9g3TSWZjKfC/WzIXFpx4QKBnugWtMALNCPwOBNFK2CFg5Cwy
 IcX0ezmYrYLW1mdQHIRKPp8jOHaX9XvW3NcEMIJemeKw16xn38syTnm/JiBRaUATEQmWuFWXP
 yLJqz5ap62T/tgnl58mCwA6GmkuPSIbrhNfOM2eDZO9dU4Rrh3iFa2bsLfMjST4gTFtZmuxK8
 zkC/hRPCClzd1Yay1J6tc10IhP/1wJrU1z7hhicBMlLYyQ3NIAWcZELU0/sGVZLClqYCn7dLH
 sqqbTNWMLQTkYM8c/2se0DXckaPr+UpGGVX+1m2P7nV4l/WSzq+bz1bW9ZA1HssFE7QIPmSJj
 33jgV7OuBOUlovYOfK342ZBSUOT7Y1UEHExRq2xyaQVu6h0Y97sN31U5C7jqnSw6kNMEfWp5F
 9AZWnNXAbrrxrsAtbFHhM6TUCYr44HUTVFQZhnBMEFl8hszGLAufoyBHI7WkbcZs+YevNj6K3
 oUUQ0TM4nbMqEHdVTt5j74QcrQKMWgMRZFXa7JdBqOzSEn7NiESgC8GsYhtyC0KF3tWXLGhI2
 9+wKKfkmZ9NtA8YCXyHsWZ/z0feQPU0BvbovUqdFQK2KUfVU0+5onch+XZNMyBvxPcJGw36ob
 FajrpEjmb4ZQrqKNOuHwcn5ob60=

Am 28.12.23 um 01:34 schrieb Ivor Wanders:

> Adds a driver that provides read only access to the fan speed for Micros=
oft
> Surface Pro devices. The fan speed is always regulated by the EC and can=
not
> be influenced directly.
>
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> ---
> Changes in v2:
>    - Removed all sysfs attributes except fan1_input. Simplified code
>      and updated documentation accordingly.
> ---
>   Documentation/hwmon/index.rst       |   1 +
>   Documentation/hwmon/surface_fan.rst |  25 +++++++
>   MAINTAINERS                         |   8 +++
>   drivers/hwmon/Kconfig               |  13 ++++
>   drivers/hwmon/Makefile              |   1 +
>   drivers/hwmon/surface_fan.c         | 105 ++++++++++++++++++++++++++++
>   6 files changed, 153 insertions(+)
>   create mode 100644 Documentation/hwmon/surface_fan.rst
>   create mode 100644 drivers/hwmon/surface_fan.c
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> index 042e1cf95..4dfb3b9bd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -202,6 +202,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47m1
>      sparx5-temp
>      stpddc60
> +   surface_fan
>      sy7636a-hwmon
>      tc654
>      tc74
> diff --git a/Documentation/hwmon/surface_fan.rst b/Documentation/hwmon/s=
urface_fan.rst
> new file mode 100644
> index 000000000..07942574c
> --- /dev/null
> +++ b/Documentation/hwmon/surface_fan.rst
> @@ -0,0 +1,25 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver surface_fan
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Supported Devices:
> +
> +  * Microsoft Surface Pro 9
> +
> +Author: Ivor Wanders <ivor@iwanders.net>
> +
> +Description
> +-----------
> +
> +This provides monitoring of the fan found in some Microsoft Surface Pro=
 devices,
> +like the Surface Pro 9. The fan is always controlled by the onboard con=
troller.
> +
> +Sysfs interface
> +---------------
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name                    Perm    Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``fan1_input``          RO      Current fan speed in RPM.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 439cf523b..8e7870af3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14078,6 +14078,14 @@ F:	Documentation/driver-api/surface_aggregator/=
clients/dtx.rst
>   F:	drivers/platform/surface/surface_dtx.c
>   F:	include/uapi/linux/surface_aggregator/dtx.h
>
> +MICROSOFT SURFACE SENSOR FAN DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +M:	Ivor Wanders <ivor@iwanders.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/surface_fan.rst
> +F:	drivers/hwmon/surface_fan.c
> +
>   MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 307477b8a..4b4d999af 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1965,6 +1965,19 @@ config SENSORS_SMM665
>   	  This driver can also be built as a module. If so, the module will
>   	  be called smm665.
>
> +config SENSORS_SURFACE_FAN
> +	tristate "Surface Fan Driver"
> +	depends on SURFACE_AGGREGATOR
> +	help
> +	  Driver that provides monitoring of the fan on Surface Pro devices th=
at
> +	  have a fan, like the Surface Pro 9.
> +
> +	  This makes the fan's current speed accessible through the hwmon
> +	  system. It does not provide control over the fan, the firmware is
> +	  responsible for that, this driver merely provides monitoring.
> +
> +	  Select M or Y here, if you want to be able to read the fan's speed.
> +
>   config SENSORS_ADC128D818
>   	tristate "Texas Instruments ADC128D818"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3f4b0fda0..5ae214c06 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -198,6 +198,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+=3D smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+=3D smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+=3D sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+=3D stts751.o
> +obj-$(CONFIG_SENSORS_SURFACE_FAN)+=3D surface_fan.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+=3D sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+=3D amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+=3D tc74.o
> diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
> new file mode 100644
> index 000000000..0160a585c
> --- /dev/null
> +++ b/drivers/hwmon/surface_fan.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Surface Fan driver for Surface System Aggregator Module. It provides=
 access
> + * to the fan's rpm through the hwmon system.
> + *
> + * Copyright (C) 2023 Ivor Wanders <ivor@iwanders.net>
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/surface_aggregator/device.h>
> +#include <linux/types.h>
> +
> +// SSAM
> +SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_fan_rpm_get, __le16, {
> +	.target_category =3D SSAM_SSH_TC_FAN,
> +	.command_id      =3D 0x01,
> +});
> +
> +// hwmon
> +umode_t surface_fan_hwmon_is_visible(const void *drvdata,
> +				     enum hwmon_sensor_types type, u32 attr,
> +				     int channel)
> +{
> +	if (type !=3D hwmon_fan)
> +		return 0;
> +
> +	if (attr !=3D hwmon_fan_input)
> +		return 0;

Hi,

You can drop those checks, the hwmon core will only call surface_fan_hwmon=
_is_visible()
for attributes in surface_fan_info[].

> +
> +	return 0444;
> +}
> +
> +static int surface_fan_hwmon_read(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long *val)
> +{
> +	struct ssam_device *sdev =3D dev_get_drvdata(dev);
> +	__le16 value;
> +
> +	if (type !=3D hwmon_fan)
> +		return -EOPNOTSUPP;
> +
> +	if (attr !=3D hwmon_fan_input)
> +		return -EOPNOTSUPP;

Same as above

> +
> +	if (__ssam_fan_rpm_get(sdev, &value))
> +		return -EIO;

Please propagate the error from __ssam_fan_rpm_get().

> +
> +	*val =3D le16_to_cpu(value);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *const surface_fan_info[] =3D {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops surface_fan_hwmon_ops =3D {
> +	.is_visible =3D surface_fan_hwmon_is_visible,
> +	.read =3D surface_fan_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info surface_fan_chip_info =3D {
> +	.ops =3D &surface_fan_hwmon_ops,
> +	.info =3D surface_fan_info,
> +};
> +
> +static int surface_fan_probe(struct ssam_device *sdev)
> +{
> +	struct device *hdev;
> +
> +	hdev =3D devm_hwmon_device_register_with_info(&sdev->dev, "fan", sdev,
> +						    &surface_fan_chip_info,
> +						    NULL);

Maybe you could use a more unique name for the hwmon chip, like "surface_f=
an".

> +	if (IS_ERR(hdev))
> +		return PTR_ERR(hdev);
> +
> +	ssam_device_set_drvdata(sdev, sdev);

What exactly is the purpose of calling ssam_device_set_drvdata() here?

Thanks,
Armin Wolf

> +
> +	return 0;
> +}
> +
> +static const struct ssam_device_id ssam_fan_match[] =3D {
> +	{ SSAM_SDEV(FAN, SAM, 0x01, 0x01) },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(ssam, ssam_fan_match);
> +
> +static struct ssam_device_driver surface_fan =3D {
> +	.probe =3D surface_fan_probe,
> +	.match_table =3D ssam_fan_match,
> +	.driver =3D {
> +		.name =3D "surface_fan",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_ssam_device_driver(surface_fan);
> +
> +MODULE_AUTHOR("Ivor Wanders <ivor@iwanders.net>");
> +MODULE_DESCRIPTION("Fan Driver for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");

