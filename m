Return-Path: <linux-kernel+bounces-102604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A981987B47C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB2B2101D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C95C90B;
	Wed, 13 Mar 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jreQPB+i"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C159B4B;
	Wed, 13 Mar 2024 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369647; cv=none; b=USrOLbwOltRof+tLIUo65lgzQTcsQJVEingL4U6yQkZ2ZrxcN4YdOSF95vv681irAdMdWZD6ex5H4fVcEgJ3HWLz/euIQLuqhatLtAztJRgPsClcG1nOkOMxEf/W6p537GgP70fwX/vVF5UUMN38lqqcHdqW3IMJDfVqJ7YX4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369647; c=relaxed/simple;
	bh=TCpyxtbanpFoocZiiiRl54UsPXFQQfwEnu2lE6Bd3P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l8udt6CUnpYU4qLyNbsW1Rp7oSCULH/m2/ZaGD2+BeKVcgBxTvdw2IoHoywrB7JmH4SwkZhr5HGSQH2ev7ycky7WZk9hzgfTxZ/F3Z0iGNp01z7/ewTE0fVhpAt1nuXl8nI7IkKvDsqQlqB4qr8ve5tQHRV4fHeyDjLIDyKGoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jreQPB+i; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710369629; x=1710974429; i=w_armin@gmx.de;
	bh=TCpyxtbanpFoocZiiiRl54UsPXFQQfwEnu2lE6Bd3P8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=jreQPB+iXdtonSek+C11TR5VePADdVAtdG59WWC5/QOZ1zoUE2qvhaK+TQiJIctp
	 bG6Z476ZXQzI3q7JHMX8LG7eJhFeMWeDHEfxy60Q7pNSh2nPWm0tsMr8VCL3e8UxJ
	 44u46audL2fTCSB4N4SEwfhay8ajSHL8mTDQwdfB/yl/TiBmpBucKg6tGp3EDyz4S
	 NFkrBECsRciJiciBhQq0jTdUCQXMStHchhm2OxpNtkGWvzdZnownuHeNvmLqGqNB3
	 42DTM2xa/RhrDHUIxnol6/S7wz0AUBRuBAf64JyjtW+lgMLJyTVN1BwTRFy6tnSOM
	 x0o/XhHVcwotwI8+JQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1rBkYG2E5Z-00ZdOU; Wed, 13
 Mar 2024 23:40:29 +0100
Message-ID: <6346005d-b4c4-4727-a84e-be5664c566f1@gmx.de>
Date: Wed, 13 Mar 2024 23:40:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240313011359.835109-1-aichao@kylinos.cn>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240313011359.835109-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LwM5cUVXo9hB+Li1BOiNPBuPMVRmhdkyfBvwV/75LgYqy3kvfrQ
 X1iqSTrG3ORmbJHtp1+PoX0jlb/DyIiiVSJArEhUNcjUg9/Wj4gXR/uhRJZh0SRucf7Fua1
 62brkbzUHSpkGLsgOSA8/eYtiF2U8BGf+vqaH6IJJ6YC00CxkPsBT2/GjN7axIYAXUn9rV4
 wdhTvnlsCqoUTAaOfSVMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mcvWdp3vTLg=;uh5p8blTA3YCOGuATzpsCaGNrUY
 k2rh4R9Zixkd1H6X6jxGcRCMRDmYjzkDWNtJMHaIn4wsIUk3AXqw+WQNXmGaAeoENUlfZaxWO
 ilQoW36cFCAw/npZWlHA0kN5X3+FDbKDEil42vuSIrr5lbw9qQnByRUYX23+1lMVHNY0yF1+v
 NSm4lQxXVWUOVFbv4x1KBlMqmCeu+adtGnSAj5Si+yDXdeXTjWzgW17TZ0MA8ZE8SJ1P3SNfz
 GnjnY1hM79mXcPyvWCOD2f7rJMab7MWNsiursbH6MU3oE/2MjuyPXpcCXhUNohJWLP5I7hsij
 /ARrdhER/y7kCtnAbZ/uMgpQl7XbXsJTgRG/lH4I2bhiwSKY89VHywa2rG7fFMDUD2YvRyKGa
 HYmTJlHw5NoguURA4iSWcj/YABC7lV0zs2e7qljLCsXQnrBETxlEZLUD6GAODZbUrO6uP07S6
 i6WJ3qdwWvkBeNNImHR2aVwcX3YKLBZET0PEIqEYE8/lLqDSKpItdrc4BJQSRXud6PshxD1sR
 JSfA5uBDakTZ7zNG0sYLSF2Quo2ix4D4jIJunqn8B/HNu6dkTeBn/dxEuFeG5Odeq/frZSogj
 /eohStpLF+WarFtpiG4f2bUG6fEk9D2c6cbluSj3W3CobdLNBpmq0beUnjWlGIof/hnWAWCpI
 94NfZPqxE/mGEx9h9BrrXQCfn5AZMakhjVNwKwIXJQRZgBw/Wwo4offW2iz1hYmjeyAhAUoTd
 g3XI8vj4f3cySF2JhhirKKe132iuO8mf/TMf1/79ECreKhXFYarBiOOme8cDCzIGO+VVx1Li8
 w9dIImO2nlueZyIGYRLlvpUkK4RulAxj1S37k3Gc/pIWw=

Am 13.03.24 um 02:13 schrieb Ai Chao:

> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v6: Modify SW_CAMERA_LENS_COVER to
> KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COV=
ER.
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_w=
mi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>
>   drivers/platform/x86/Kconfig             | 12 +++
>   drivers/platform/x86/Makefile            |  1 +
>   drivers/platform/x86/lenovo-wmi-camera.c | 98 ++++++++++++++++++++++++
>   3 files changed, 111 insertions(+)
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
> index 000000000000..fc2af7f48bc0
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,98 @@
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

Hi,

could it be that dev is unused? If yes, then please drop it from the struc=
t.

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

Please verify that the size of the ACPI buffer is 1.

> +		/* obj->buffer.pointer[0] is camera mode:
> +		 *      0 camera close
> +		 *      1 camera open
> +		 */
> +		if (obj->buffer.pointer[0] =3D=3D SW_CAMERA_ON) {
> +			input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
> +			input_sync(priv->idev);
> +			input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
> +		} else {
> +			input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
> +			input_sync(priv->idev);
> +			input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
> +		}
> +		input_sync(priv->idev);
> +	} else {
> +		dev_dbg(&wdev->dev, "Bad response type %d or Bad camera mode %d\n",
> +			obj->type, obj->buffer.pointer[0]);

If you receive an ACPI object different to ACPI_TYPE_BUFFER, you cannot ac=
cess obj->buffer.
Try something like this instead:

u8 camera_mode;

if (obj->type !=3D ACPI_TYPE_BUFFER) {
	dev_dbg(&wdev->dev, "Bad response type %u\n", obj->type);
	return -ENOMSG;
}

if (obj->buffer.length !=3D 1) {
	dev_dbg(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
	return -EMSGSIZE;
}

camera_mode =3D obj->buffer.pointer[0];
if (camera_mode > SW_CAMERA_ON) {
	dev_dbg(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
	return -EIO;
}

// Handle camera mode here

Other than that, the driver look good.

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

