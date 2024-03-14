Return-Path: <linux-kernel+bounces-103621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D147B87C20D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C10E1F22277
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE2745EF;
	Thu, 14 Mar 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GyoiH8zD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874074411;
	Thu, 14 Mar 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436840; cv=none; b=BWADE8ZviA+p/Tq9xTMjXZYRNZARB3ki8Yhj2+AR1xgW6DU32WVzDWjHfx76qbTY1tOdydo8KBKO5Uw19RRptGe30w+bUAMwjY/uDQYqa54b2mxDIBNrHoiNxGJ9jKt3ppPf9j9oB127udFc0dbHEJwZpCdsnNPp3vtEB2gjOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436840; c=relaxed/simple;
	bh=NgHgotKhtD1A7iD6oloMGvxAQNHj7LiaQcSDONTaOLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AkIyn8MOOuM53bC36YPnYB4148MsJ877DAACTg4jJ7CUXhv1CiOc1Q7Xqw2mIov1JiClJqC8ysbc1LuiCHUUvxuXRcTJtRMRys59em40Fy7aRa9J8XuAFOcfQph+Db3vJpHOdLHJF1IBnlvzsW1FEhfGG8ODQVp9hMepPVxj+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GyoiH8zD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710436824; x=1711041624; i=w_armin@gmx.de;
	bh=LQXqc83Fz2n7ArY1KyXlZRGRxcZUTaZFRwjyZfC2l1A=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=GyoiH8zD2a+yMwuwCtKvTG5w8gcWZ2gN/8RyMdTSSGYc0yLQAU6JpJQpXlhKZmYk
	 tR1+s6M8s/EMwYriuKVaLmBz3ILw/9CPTMeAiVJyc2X8yAengjP7vjT94v4M5A5Zm
	 7ONdmghmmr6KiF/S47EbWrE/Y9IrTFPTAplC1ZxwfMCyuD83kpsbuzPFd7bz5sFnv
	 4NB4xqdY5Ms7Vdn+gpQWOSyX0UheGfbI7OXp9hXuTjYFooLrakIsaKsR+Vpsrk4Kk
	 WbZEJHVasGE5sGF413ewXr9XPZtPeocg+UndtiiXwIUql0QZ3WW+qX3EI6k98oqRf
	 YQPu6/6HjOY7fyP4gA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1rZV1F0ttB-00Flne; Thu, 14
 Mar 2024 18:20:24 +0100
Message-ID: <d7c2de21-50f9-4602-abd0-b83ecbc3f42f@gmx.de>
Date: Thu, 14 Mar 2024 18:20:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240314050319.171816-1-aichao@kylinos.cn>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240314050319.171816-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jfmhznM+gZlYWuE+LsYUpAIbRl9nyhWCaECfPATz+Bwqi/BVY0v
 v3aEIW//Pa0jKiA0fvYwCp4dwTgzdVIP32thTZqaFv4S4hZcmGkdKSlBHBnODCZjO5bA9Zj
 WSfyTkE4F+NoRcMqlpxk5KU2pvprwzcLS6OfUb8Mh0cVcFbvSmDuP5TZ6Uv6mHTjo9q2kRA
 RsAJugEurj73xmh+Cw96g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5mqxxvk5B+s=;uiYdS93D9qlPd53Fm01iM4jBHFC
 fDQXKxhaeH05QGMmAtP+Rq4oYNShInpSdUOVY9k5mKSXqqITZ0HE1fwFZL+chPteurx7qUBWY
 Qs7EHTRR/SVcgz8HuaocLIpFTwRG60wnoSbZTAOsXHrqpex9J5xgm+P9+FFZlupaCf5LZdQN4
 waI/4J1vuYnUaB/WRuEeMXJkLJUvnDnUExYNnFCX66tmZkTkBbEIZw887zIrOpb6wTj6bJrUq
 qqBX6TPzTkO2gh723V+SHmwuyGcIIgBv6RXxY3BkI48U5pUBC2059JF76bnKJUO5rFl+XemSw
 fNUvLsteK22984Q7367Rhbm8avNSKp8kFoXVHtrzr7rnBKFkrC1rniRAkNH+9JNbAsUfO0gAv
 jSXS/wuI2AnkiVk50FsOaKa1jjkzygSkS2zAFStNl/AFC8mO7o08vFBcq6xRQQJm9VKcBq7Fj
 BGriD+BAoaliTu3MvO2OU+Ci+HiZaezITWe6OKGeJtc8+rLjdUvTf+cK7eZCQDlw2XLZO8c3b
 yZQNqTP2IzfaDsrw4e2gdThLzDtXjdISWHiuDgxMM7WgmVYVYHKbrFA21n9nDnYeqEbi5UrTA
 ktkKPqOaNkoLulIzMOofj371OTdEzgZNE8Qp2+FFTtIewWdT1CuqWSM3pL8+yMwba0AuMPM0D
 OqtsaMx+Jv3Sah+D6+xxl0pFAAS/r4U48SSHegWqw8WFK/CS0LvIXTZJrjYplRQDVp/7NWFiQ
 vgh4LEG14F7jVPou/3EIDgc+3ZsulgY0eDmQT/3rDVmtOR9ccsdh2jl/shDWAh9kG6GIzUnMW
 Z51iXvSvPwsIAVSrjLNuwOSQ5xpVFXtAWytUpXwd0ujuQ=

Am 14.03.24 um 06:03 schrieb Ai Chao:

> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v8: Dev_deb convert to dev_err.
> v7: Add dev_dbg and remove unused dev in struct.
> v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_A=
CCESS_DISABLE.
> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COV=
ER.
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_w=
mi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>
>   drivers/platform/x86/Kconfig             |  12 +++
>   drivers/platform/x86/Makefile            |   1 +
>   drivers/platform/x86/lenovo-wmi-camera.c | 108 +++++++++++++++++++++++
>   3 files changed, 121 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..9506a455b547 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>   	To compile this driver as a module, choose M here: the module
>   	will be called inspur-platform-profile.
>
> +config LENOVO_WMI_CAMERA
> +	tristate "Lenovo WMI Camera Button driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	  This driver provides support for Lenovo camera button. The Camera
> +	  button is a GPIO device. This driver receives ACPI notify when the
> +	  camera button is switched on/off.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called lenovo-wmi-camera.
> +
>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>
>   config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index 1de432e8861e..217e94d7c877 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>   obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>   obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
>
>   # Intel
>   obj-y				+=3D intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platform=
/x86/lenovo-wmi-camera.c
> new file mode 100644
> index 000000000000..f83e3ccd9189
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lenovo WMI Camera Button Driver
> + *
> + * Author: Ai Chao <aichao@kylinos.cn>
> + * Copyright (C) 2024 KylinSoft Corporation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F=
4EA400013"
> +
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +};
> +
> +enum {
> +	SW_CAMERA_OFF	=3D 0,
> +	SW_CAMERA_ON	=3D 1,
> +};
> +
> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_objec=
t *obj)
> +{
> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +	u8 camera_mode;
> +
> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> +		return;
> +	}
> +
> +	if (obj->buffer.length !=3D 1) {
> +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length)=
;
> +		return;
> +	}
> +
> +	/* obj->buffer.pointer[0] is camera mode:
> +	 *      0 camera close
> +	 *      1 camera open
> +	 */
> +	camera_mode =3D obj->buffer.pointer[0];
> +	if (camera_mode > SW_CAMERA_ON) {
> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
> +		return;
> +	}
> +
> +	if (camera_mode =3D=3D SW_CAMERA_ON) {
> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
> +		input_sync(priv->idev);
> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
> +	} else {
> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
> +		input_sync(priv->idev);
> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
> +	}
> +	input_sync(priv->idev);
> +}
> +
> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
> +{
> +	struct lenovo_wmi_priv *priv;
> +
> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	priv->idev =3D devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name =3D "Lenovo WMI Camera Button";
> +	priv->idev->phys =3D "wmi/input0";
> +	priv->idev->id.bustype =3D BUS_HOST;
> +	priv->idev->dev.parent =3D &wdev->dev;
> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_ENABLE);
> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_DISABLE);
> +
> +	return input_register_device(priv->idev);
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_id_table[] =3D {
> +	{ .guid_string =3D WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver lenovo_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "lenovo-wmi-camera",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table =3D lenovo_wmi_id_table,
> +	.no_singleton =3D true,
> +	.probe =3D lenovo_wmi_probe,
> +	.notify =3D lenovo_wmi_notify,
> +};
> +
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo WMI Camera Button Driver");
> +MODULE_LICENSE("GPL");

Looks good to me.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>


