Return-Path: <linux-kernel+bounces-96004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07A8755F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023D41F22864
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B31332B0;
	Thu,  7 Mar 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pSqDPCQ5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211D13329E;
	Thu,  7 Mar 2024 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835446; cv=none; b=heLpYqvUshRT5ML8JjceB2kq7X+jQX2F9QlFrYeCsTaEShWzJuNi30Bfe1kGodDXjYJez5zc56+I3KKAiru2M8CgG5SAQ/ksOBtF+E/uSfRIn8RjGGBbSNdWrYBebXt10WGVvJ6AIwJWe3jhsUX6jipK9PTswWpFvGi/Nj/i0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835446; c=relaxed/simple;
	bh=17xkoOp/RcqQ2Bfic2Dy+htvwJ8t+y8Dib3iXXsLSV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TufG81PZ9wJlcMjzHz/3nMirlydgmTwJawpxsN5ezRduxc87533oavzmiCg5P+8TQpROyO1GPmygnMHYM9JY1ZCU+BMT09OTK2Bi1FysSQUGiFpAXUSc5DaD1cy/y8omcAb2vVmLS1WmFLu3YWCIoU3LSVteJ2dNBenGzNZfcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pSqDPCQ5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709835429; x=1710440229; i=w_armin@gmx.de;
	bh=17xkoOp/RcqQ2Bfic2Dy+htvwJ8t+y8Dib3iXXsLSV4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=pSqDPCQ5u3gYOqbyX+4uIv9RBmf9O91b2qXk4GqB7axYbEsMziJxtHAW2ewc3f1V
	 E6ZFS1tdrHkFZ7udXJ7odfy5p7WQhn1vLFKnme2S0fCone7tjojciQ4N959WdV/iF
	 AORPe+HQCnsQ2d2+tHwX5EwGnabYllSOr7UOs+1gldRrsuOxTadXmsYjRVrQe2z/v
	 99a8JuKgyP8MRiCnSskXTnd5Nj+IEox3IWIjmzPHlH29SmC8o1xoMpkswno1W99QW
	 pv6PuHcr5L4B7fY9JsoEFNmW6mBt32HEnK4me1lvAjamDOmTF0AXVvOiq3Hzkg58h
	 sG4V9RaOYeHwrDc5aQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1rR2ZA1AXZ-00Hxzc; Thu, 07
 Mar 2024 19:17:09 +0100
Message-ID: <4138a86e-c0cd-4bd1-948c-88dd73749027@gmx.de>
Date: Thu, 7 Mar 2024 19:17:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: add lenovo wmi camera button driver
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240307085939.668881-1-aichao@kylinos.cn>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240307085939.668881-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rQjpVGoBcHFxH+hSQxJCNqhe0vjPZvbm5a0Ld1TfvEMTfQk61Bh
 4xg0J6SAcZMXHyk/w/10bFDgoG/dZEeODvk8jl0M8YS/cm2DtuCO6NTgPkZdkI9laag0qmX
 x5RTSCJuQ0O/qftm6Ku9sH3nWALZTi+ecyk22Yg1iGdOM0vkhBFhGVQoQpq60sbpJGbMmXo
 dSq2wfF2GkGDBxEGvLnAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2nViqPVXDJI=;AKiMCwB8jmfOMufyK3l0wW+GkXY
 KurZfcMS4Zb7KvXBhIsv1jKQ4ii1Glw6vGO+jY05XpoqGZtL43KRffVy4JLSYNf9h4hUeyDTF
 9+hBdJ5euYzUTlGj/MVQRpT83w39wdLE59niRgP71mIpSyWFUn/hklfv7Wz9Lc4w7YWQ2Bb2o
 jU3f2Xz5ROiss3xrOMWOJKoeMozo2fac/2LxjPRXtHqXQkJfcZN/69kwhd5B+beucHpetiw/Q
 xRvRXevS7Tv04g2w1a+zsNIMm8xj2UfqADQ10jD8/wBKv4IELiss4OHwwUtzgKMMVZFIjgN/R
 akj9sFK3Hj/IzviMb+Y71eFihOOF3j0pJkSI4Y9BpsYtqOGU6oUKqHR4AoZ5Ug7LC8DfVQmRZ
 0i991oyn95WNtOsmpzXt0HqLKysXC414I3t5RUeCbf3T3IqI9semxfkKclaUX+nGe1IU9w/E9
 Hf7mol8bR8sFL4W5CVGrN66OcNx3rBPsHtxijHmI9+rsm2SZ+XDmbgFqMGK/inK77ClHEQRRi
 X0bZbM6deEGAez1dbckYD2L4d1Da/39gG8be/yW8yAraAanLmwXSDdiu9TExLVHg0MFZ31JuU
 gjT0dw1WaiK8/lLPNie8IPe3FpEfQ/AyA9wR2cBK/LTNWTggvH/S1x1EG8miSE/vtY9BSbK/f
 7sri9Bt5U+yew5+EMK1L8OF+gI2giwQuee5vBfMX56ldd8kbwE4Q3zJfeYDVHUKqlKWpUbasA
 dt7sQa0gVI+GUbV79lHJaNKOz7DK9GcRhGrTcdqBdsKzwcE0MCvFbIE0ScFjtADLE/8/FGXiC
 AVrlv64PY3FJeqfPt2lVUBPI74HgGMfJeGdWPOt2HNegU=

Am 07.03.24 um 09:59 schrieb Ai Chao:

> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COV=
ER.
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_w=
mi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>
>   drivers/platform/x86/Kconfig             | 12 ++++
>   drivers/platform/x86/Makefile            |  1 +
>   drivers/platform/x86/lenovo-wmi-camera.c | 89 ++++++++++++++++++++++++
>   3 files changed, 102 insertions(+)
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
> index 000000000000..571d67ade8ac
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,89 @@
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
> +	struct device *dev;
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
> +
> +	if (obj->type =3D=3D ACPI_TYPE_BUFFER &&
> +	    obj->buffer.pointer[0] <=3D SW_CAMERA_ON) {

Hi,

please check that the ACPI buffer has an appropriate size before you acces=
s it.
In this case, check that the ACPI buffer has a length of 1;

> +		/* obj->buffer.pointer[0] is camera mode:
> +		 *      0 camera close
> +		 *      1 camera open
> +		 */
> +		input_report_switch(priv->idev, SW_CAMERA_LENS_COVER,
> +				    obj->buffer.pointer[0]);

If SW_CAMERA_LENS_COVER is set, then it means that the camera lens is cove=
red. So in this case
you have to pass 1 when the camera is closed and 0 when the camera is open=
 (basically the opposite
of camera mode).

> +		input_sync(priv->idev);
> +	} else {
> +		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
> +	}
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
> +	input_set_capability(priv->idev, EV_SW, SW_CAMERA_LENS_COVER);
> +

Is there a way to determine the current state of the camera switch without=
 having
to wait for an WMI event?

If its not possible to determine the current state of the camera switch, t=
hen your
driver has to defer the initialization of the input device until it knows =
the current
state of the camera switch. Otherwise the initial switch state reported by=
 the
input device might be wrong.

In this case, that means your driver must initialize the input device when=
 receiving
a valid WMI event for the first time.

Basically when your driver receives a WMI event, it has to check if the in=
put device
is already initialized. If this is not the case, then the input device is =
initialized.
Please protect this check and the input device initialization with a mutex=
, since WMI
event handling is multithreaded.

After that the event is reported as usual.

Other than that, the driver seems to be in good shape.

Thanks,
Armin Wolf

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

