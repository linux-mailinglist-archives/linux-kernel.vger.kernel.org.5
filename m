Return-Path: <linux-kernel+bounces-88239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0142186DF01
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9495628A078
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7D6A8D3;
	Fri,  1 Mar 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="smmuKgaK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732569304;
	Fri,  1 Mar 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287805; cv=none; b=Mp6hSNp9U74gTy4kM8cJIB3c9BAPIQmOSqjB/0tVw7kWwKb89I7Ctis+/MNofLqT976zu4LbytJMxQKA8CIUl0ZUF0BQ9TS+gdkjKECXlfOHZvfj50ElunzRPucvCooT7au3vbDVArZJq3D/FsvnZ9UgyiC3rXe+kvFNp1Cryfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287805; c=relaxed/simple;
	bh=N1mv8Z92ZaP+zYKubbkh4ayy2qX1zvRrKVeuaowIW/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n+WQhRcF/CK8cOKpFqnm6mw2HDrpvJLJ7lcleoG/Sc6UMr5awTX9piS3h3bVFdV0v1yYdu52B1+zuQHW/Rm+urh5f9JKU1MlIQOnrCF6OUkwaq6yF93Vbnh1m/PR2tScsn4YouySKVx/siqoiOYHB239PtLZqxC/p8o4eOwkXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=smmuKgaK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709287757; x=1709892557; i=w_armin@gmx.de;
	bh=N1mv8Z92ZaP+zYKubbkh4ayy2qX1zvRrKVeuaowIW/A=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=smmuKgaKwJMzd0AvWD+EdPJQqfExm+BopCNWPc0HleDtriuH9a/RwPelEnwL5MRG
	 QmdW0YIshYw2GxiIi7ITsvfxG9dZZAh1foKQzZBo6pak8zacL5+9IBZ0BkuRP+2Ft
	 DLOyzOngqoCNtI8pRqIpoKHszjmn6RC9mToOnM1QboBUXusacCHpmRc82bqPmRIur
	 2eDsWtWSQT93SZ14Q/O/1rEQjkgyRRl126Z/if4exsjefWLI+Cf4Z6Rt5BHPmpOv8
	 4PX0M8e4JLl3ZlbU62yW8KGcK2OhOnqJBmFXgwP/1NOaIdbqdn8lWx6EUn2lds7J9
	 1dr+8ep75dSOHWWmuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1rnQsi1Haf-0082Ii; Fri, 01
 Mar 2024 11:09:17 +0100
Message-ID: <44b660c9-600a-4031-80ae-7a7e9465ffa9@gmx.de>
Date: Fri, 1 Mar 2024 11:09:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: add lenovo generic wmi driver
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240301081648.265907-1-aichao@kylinos.cn>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240301081648.265907-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bn+BqY/zBUb+kSrCnYnLdTrmdhM/TPDrbZo/qyc9/z/J1+rDu+p
 iE3unYqYeVv6CxhTS07Kj7ypsnc1E2nRR0iezNxbtSP8FF8y707Cw2FgU4en776KEKSjNTt
 gyevKCXBV74b4rjf3/nOFR1lhcQVsqov3nbeZ6va5XadNO162KelxQ2eVzOFqnmSG+SYDOd
 kU0+Ol8/l6ZlWtT1ZoIiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SzchIeA8AHg=;wVgUdIoR+s6r6azD+SUxrhlBWTe
 p+Qa/DaVl9lYftgFcRUbG7mcyHPQdgEdhaHsyVJxfM1OMOWJP9bzf61HQRy/q6HRC0bOMTmf+
 1dFFp4CktVoF8+k8rTX0A6/Y6NvCbLoqIVJ5Xykk6o5XSRGvjRytpJMihd/lAZhAqYYy5PQQw
 tHD3BLoMp7KhOBJffNsxdb6LCGRXH/L4WjNnjVJ6a2cXkXi2AN2g3N4WmVSdlONXDW2Ic1nnu
 vtGiGu/IYgLBJ/wdAScSmCL1QEPDUGn+nDAuCE6K0laAnig/iN7B6b4SmfM9Le55sTWKXutRf
 SzDEURNjpKUJupnkkQMhKs6U8r9KtiMvYh7JjCkh+CSZ8Nj9MA+LS1Vj/ECGLv0yTJ4FMqunW
 jgFO5UQDeTu31mpidZl+IAu0zDCHAtXQERFMTZL95lc/SaUD6aYV2dkQiGyebIZ74aD7l29rw
 1UYQn8X9ETviMqLaHjZsyvA32Mw4oeMFF9rn0sSrts/S+sW81G9VzyybIMlVJ+VLsOgURxknZ
 SSoJ+FSIW+g7LZMKS5tcKowYeMsJCHZQWOlO4526QQl+mq7tobBPiDpg1nQpHCObz72k/dT8l
 PQ96AzRvA3rs60b2tYC9vT6pscHtfvz4dengvn0F3nZOy7eRoi7SUzpantfdPeEQZMfG4QsaA
 +BaB7PkTg8I5IXFmWb2naRBtk15yh4AV0dVENZFoZQeUn1cJyM3i+qWPDjNd9JwoDzpqkJWsP
 YSqK65edXfusVxyhaqH1XEY7xt3n51jGEpkG0eTG0ey6fDSVoLA6NXiEQI7TxzQzOhxdB/DW0
 QFJhL3Mf3GWZ1yuKaXVEpApjNvRDY3/KPCLkqE7ZY4V8A=

Am 01.03.24 um 09:16 schrieb Ai Chao:

> Add lenovo generic wmi driver to support camera button.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
> v3: Remove lenovo_wmi_remove function.
>
>   drivers/platform/x86/Kconfig      |  10 +++
>   drivers/platform/x86/Makefile     |   1 +
>   drivers/platform/x86/lenovo-wmi.c | 113 ++++++++++++++++++++++++++++++
>   3 files changed, 124 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..fbbb8fb843d7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1001,6 +1001,16 @@ config INSPUR_PLATFORM_PROFILE
>   	To compile this driver as a module, choose M here: the module
>   	will be called inspur-platform-profile.
>
> +config LENOVO_WMI
> +	tristate "Lenovo Geneirc WMI driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	This driver provides support for Lenovo WMI driver.
> +
> +	To compile this driver as a module, choose M here: the module
> +	will be called lenovo-wmi.
> +

Hi,

does the WMI driver only handle the camera button? If yes, then please cha=
nge the
driver name to something more specific like "lenovo-wmi-camera".

And please add a more descriptive help text.

>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>
>   config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index 1de432e8861e..d51086552192 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>   obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>   obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
> +obj-$(CONFIG_LENOVO_WMI)	+=3D lenovo-wmi.o
>
>   # Intel
>   obj-y				+=3D intel/
> diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/le=
novo-wmi.c
> new file mode 100644
> index 000000000000..96c2ec9e6441
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Lenovo Generic WMI Driver
> + *

See note above.

> + *  Copyright (C) 2024	      Ai Chao <aichao@kylinos.cn>
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
> +static u8 camera_mode;

Please avoid unnecessary global state, the WMI driver should be able to be=
 instantiated
multiple times by the WMI driver core.

Instead move camera_mode into struct lenovo_wmi_priv.

> +
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +};
> +
> +static ssize_t camerabutton_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", camera_mode);
> +}
> +
> +DEVICE_ATTR_RO(camerabutton);
> +
> +static struct attribute *lenovo_wmi_attrs[] =3D {
> +	&dev_attr_camerabutton.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group lenovo_wmi_group =3D {
> +	.attrs =3D lenovo_wmi_attrs,
> +};
> +
> +const struct attribute_group *lenovo_wmi_groups[] =3D {
> +	&lenovo_wmi_group,
> +	NULL,
> +};
> +
> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_objec=
t *obj)
> +{
> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +	if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
> +		camera_mode =3D obj->buffer.pointer[0];
> +		input_report_key(priv->idev, KEY_CAMERA, 1);
> +		input_sync(priv->idev);
> +		input_report_key(priv->idev, KEY_CAMERA, 0);
> +		input_sync(priv->idev);

Two things:

- you should validate the size of the received ACPI buffer
- what data does camera_mode contain? Maybe it would make sense to
export camera_mode over the input subsystem _if_ it contains the current
state of the camera button (or something similar).

I think of a construct like this (assuming camera_mode contains the curren=
t state of the button):

input_report_key(priv->idev, KEY_CAMERA, camera_mode =3D=3D CAMERA_BUTTON_=
PRESSED);
input_sync(priv->idev);

> +	} else {
> +		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
> +	}
> +}
> +
> +static int lenovo_wmi_input_setup(struct wmi_device *wdev)
> +{
> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +	priv->idev =3D devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name =3D "Lenovo WMI Camera Button";
> +	priv->idev->phys =3D "wmi/input0";
> +	priv->idev->id.bustype =3D BUS_HOST;
> +	priv->idev->dev.parent =3D &wdev->dev;
> +	priv->idev->evbit[0] =3D BIT_MASK(EV_KEY);
> +	priv->idev->keybit[BIT_WORD(KEY_CAMERA)] =3D BIT_MASK(KEY_CAMERA);
> +

I thing set_bit() could be used here, like the xiaomi-wmi driver does it.

> +	return input_register_device(priv->idev);
> +}
> +
> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
> +{
> +	struct lenovo_wmi_priv *priv;
> +	int err;
> +
> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(struct lenovo_wmi_priv),
> +			    GFP_KERNEL);

Please use sizeof(*priv) instead of sizeof(struct lenovo_wmi_priv).

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	err =3D lenovo_wmi_input_setup(wdev);
> +	return err;

I think lenovo_wmi_input_setup() is small enough to merge it with lenovo_w=
mi_probe().

> +}
> +
> +static const struct wmi_device_id lenovo_wmi_id_table[] =3D {
> +	{ .guid_string =3D WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver lenovo_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "lenovo-wmi",
> +		.dev_groups =3D lenovo_wmi_groups,
> +	},
> +	.id_table =3D lenovo_wmi_id_table,
> +	.probe =3D lenovo_wmi_probe,
> +	.notify =3D lenovo_wmi_notify,
> +};

Please set probe_type =3D PROBE_PREFER_ASYNCHRONOUS like the inspur_platfo=
rm_profile driver.

Also please set the no_singleton flag inside the WMI driver struct after y=
ou moved
camera_mode into struct lenovo_wmi_priv, as i wont accept new WMI drivers =
without
this flag.

Please note that the no_singleton flag was added very recently and you wil=
l need to rebase
your driver onto for-next.

Thanks,
Armin Wolf

> +
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo Generic WMI Driver");
> +MODULE_LICENSE("GPL");

