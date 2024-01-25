Return-Path: <linux-kernel+bounces-38817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9783C668
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCCA1C22940
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62526EB6A;
	Thu, 25 Jan 2024 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qkG450TS"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8A32182;
	Thu, 25 Jan 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195984; cv=none; b=aC4bZ+dc+YPnYDHx9Bcn9/y9dEDT+nZ6QSLCdI9PdOVqORzBqhZVukr9hk3BBvoWHyfJxwsS8iWILVXpfn9JTaP/BH9WjlmojIort9/0zQ+XoQ/RzQg6OrAgk8BagWxkDI99k/9X+sLdGvs2bjYwkTXTi/M0C0iCcDBlIvry1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195984; c=relaxed/simple;
	bh=CkYqsdSrAMaAjob6NoWgiSmG5+C0U4CurZGk4A5ajsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wu3boAkoGQZd2oFueKYyBIl1yKu2aUaS0FEigh3zgt5+XUyRISF7PRyGD8qSW0cS+p5+8P8g8lG6b2cPTD3dov2RDijDeOayVz1ZlBnKAUA9zKWjOfbh5WV7mai+BT/gF+w7m49vM5q7+It8C2kpzWQl3M3MsWt1YQTETdSAb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qkG450TS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706195947; x=1706800747; i=w_armin@gmx.de;
	bh=CkYqsdSrAMaAjob6NoWgiSmG5+C0U4CurZGk4A5ajsU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qkG450TSy83zYVH+I6cmKBtuEJPvQn9acf38UbY02oJ5+249NyD8ip3VffG+WQRS
	 K62itgxH5zoWR/j8Xk2hY5wYOuPDlMTqkZtoQpnTgC6rzbE0N94OrK5sPF7dtjugY
	 v2/FQjXLF6UXVuL8DeaoXQ/ZoRw7mwaREWs/s3JSrwAyWC8Gvz7hCcfH1RBERFrs/
	 G4US8osszJsnxYRqYLVih8Eb2FUorxrO79pETjDLfPV6meSuSzTKPAi4Rv1AyVk1R
	 0gXnB8a3KobKKRS1baUJwppe1hCgP+2LwM1ch2yC7L7J0Y58hym4A4Olm5ixAAR/m
	 2MakPtYme86W4udA1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1r0Qtf2QJ6-016S0y; Thu, 25
 Jan 2024 16:19:07 +0100
Message-ID: <34960bb8-fb85-4cca-8b84-d99596d046e4@gmx.de>
Date: Thu, 25 Jan 2024 16:19:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: add fan speed monitoring driver for Surface
 devices
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240113183306.9566-1-ivor@iwanders.net>
 <20240113183306.9566-3-ivor@iwanders.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240113183306.9566-3-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOz4EBEugkIgALhAkTjG5E83mbP7bYE5uPTbJe+wXmU4hmygKV9
 KQ+K+UX0/03FijFfprwm6rgV32M9m69mNJttH95NQPjBgEudH0gOmTaX3krP2dVNBRYNDSa
 BXRd4sBU0Gmzt1dN/gG4Z1CEPogat0Xokru0g9br3gZLiGDgS63slF6qWBG29vYIfDibB+H
 y2SQtFmbHog2Qk52n3eBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vu2tusABNWk=;vJ0xUT/w7LCzstHF+LQgwFqzfRf
 fy8GJ1Q9iEPXv34OKWNlVIGqgjahDhLgAbrDfzCMACm8UKYZg6Ddq7k1YfmEMIjzlDp2Enou5
 hm1FjVLUkGmwUaLIIgXtRompDbeSL47s9sguLSE7hueQIuOUwxltfxTEDF6yZXzjd+VIH3TrU
 OZv+sYSeUP8jnfwAfrryXmHXPjn3VdN/2x9qnA1zWclKPnGlPzlTctKI6pmGZBvZA1YSFWhpF
 zepe/fwKEkvWwvm01OWBC3GzEYNAF+HZuuvhnIvYIAPqR6FHrxfz6s/WL3/sWYEDH0HSlzc5H
 sFFyluHhd2hS3aG6JwXNBEztxkCDTPaaynV8+Nk3GxBncPtOoCwoRTJTnZsoawMy8owhBEam8
 2sXbk4fRdnsXuRhoSDx8kcng0onoV8LOjeusUyKGfSTBmWVWRQXchSXJKapuEQ21do344+F6w
 TchsrZcFCF503Wew7y4430eQx2jjqrsMewdoNUGwMuZhmI724ZNzEl5u7biftlCtbVuQOiE0x
 5cGhJDAh2wBxW1Sk4Ab6IDvZ+tusZa3CcObMx8zgMn2bLpgtLysojXfithktZCrSruJWPtfrV
 583BbaK5tG/Vx+4qDgix4ifrKFhHMKHacC6HLmRZxSi/zVnoY3jPouC0/HMNHZSzJvaNDUA5B
 O0SDqtcbM1TzF5CSHATuJkNhM+ubEvyvK2Y24sc9mjYViBAdIAHLCi+2O0BkIbgT8ba48l5nP
 KJTMG8vIccfyzMfPYA5ihnvjgjvOe+MNHcbjNZ0XpleviFCNZKyBonnZrVI+10RXDqxQRVkUY
 TF32gOuLdRT5NgSuhKcofDWRzNaEfOvUSailIjU6DNLQjksIi5o3CXYh0xTzCmqMo/WJ/9SIf
 ckWj2fbvMeFL/Sd0TFEgHOXE4IgKRD+9EwywPx+ko6IhYOnjOMEkrlUClr8OjWZFXUVWDa8P+
 7IpP/UMMZ77CsPA+Ad2TRdoMv40=

Am 13.01.24 um 19:33 schrieb Ivor Wanders:

> Adds a driver that provides read only access to the fan speed for Micros=
oft
> Surface Pro devices. The fan speed is always regulated by the EC and can=
not
> be influenced directly.
>
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> ---
> Changes in v3:
>    - Removed type and attr checks in read and is_visible.
>    - Removed assigning sdev to ssam_device drvdata.
>    - Propagate return from __ssam_fan_rpm_get.
>    - Renamed hwmon chip name from 'fan' to 'surface_fan'.
>    - Removed unnecessary platform_device header.
> Changes in v2:
>    - Removed all sysfs attributes except fan1_input. Simplified code
>      and updated documentation accordingly.
> ---
>   Documentation/hwmon/index.rst       |  1 +
>   Documentation/hwmon/surface_fan.rst | 25 ++++++++
>   MAINTAINERS                         |  8 +++
>   drivers/hwmon/Kconfig               | 13 ++++
>   drivers/hwmon/Makefile              |  1 +
>   drivers/hwmon/surface_fan.c         | 93 +++++++++++++++++++++++++++++
>   6 files changed, 141 insertions(+)
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
> index 000000000..7c2e3ae3e
> --- /dev/null
> +++ b/drivers/hwmon/surface_fan.c
> @@ -0,0 +1,93 @@
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
> +	return 0444;
> +}
> +
> +static int surface_fan_hwmon_read(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long *val)
> +{
> +	struct ssam_device *sdev =3D dev_get_drvdata(dev);
> +	int ret;
> +	__le16 value;
> +
> +	ret =3D __ssam_fan_rpm_get(sdev, &value);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D le16_to_cpu(value);
> +
> +	return ret;

Hello,

maybe you can just return 0 here.

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
> +	hdev =3D devm_hwmon_device_register_with_info(&sdev->dev,
> +						    "surface_fan", sdev,
> +						    &surface_fan_chip_info,
> +						    NULL);
> +	if (IS_ERR(hdev))
> +		return PTR_ERR(hdev);
> +
> +	return 0;

Maybe use PTR_ERR_OR_ZERO() here?

Other than those two small things:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

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

