Return-Path: <linux-kernel+bounces-107657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A187FFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54EB1C21A86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B126AE4;
	Tue, 19 Mar 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="nEiwXxFW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF11CFB6;
	Tue, 19 Mar 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858855; cv=none; b=Fjp/PxkMA8CZcQN23xj6w5RtCnucHwMh0IYdaqrp5zwwg05rZnLecgiscmSAeaTtyrqflZ8aswXQ2CXvr+bZxunDaj/jxG8yyZy2qc48cfPp4DC/HrQOm61268r+3S40/5kJ66LOBLUr3/uub3j35YvpiKr4m2tol0W0+xpDTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858855; c=relaxed/simple;
	bh=AbUm5Pq0aF1FAM5ZWdeBptHKFLNal1zLQvqxvR9sTv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EBgb18X04d6UJrki76DcDPzSzsbRyZj9J7olMMq4DUn35fOur3WR7UY157nafLipfAzJsHFCoNssBia7+0TPR/SVP4Euo1B9JEJwc7hi5gyj0XFqJjncJQPU0ql9D/xr6EPmZdfmCuRJdBKli+PYDOKkFMNRkbgTlvTRFkCUxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=nEiwXxFW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710858832; x=1711463632; i=w_armin@gmx.de;
	bh=F78XrSS29LDfIBktWQ4yECtNVi044MB1Oc4ATjgKoMA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=nEiwXxFWykavWnWCUNrRi6NMJEB/XusSZpiw+Fxwd5hr2ZuL8+E128PMalS82gyW
	 l2HqL4Y2V/ldVBj34pBNd32cdScwPtQ+4l5pPakF02DePz5vCVL4dWPLE53a6VqYP
	 Aihm5fVq28FX86PSvW1pHw+Ge+zrjIQQjImMjsILnOGmhJCaPl4kmTv5Hb250XsZh
	 NCdah9LvG92yyTHOB7/KzZfPhbkiQM/bbtjMM87jdMN89dyxYf0EOJxwN1S9a3QGa
	 UWhCRnSTaQfF7g9SuGK8Jbv2XSCHqvKfEA6aNNXttC1u6v0JBqskqMV7XWQBWV9XH
	 tyX8aZG1wTGDvuHQrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1rBbtS2WPC-00cBAi; Tue, 19
 Mar 2024 15:33:52 +0100
Message-ID: <40bfa65d-4c4d-47cd-a0fb-a85c47fdd4c0@gmx.de>
Date: Tue, 19 Mar 2024 15:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] platform/x86: add lenovo wmi camera button driver
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240319021407.15769-1-aichao@kylinos.cn>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240319021407.15769-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YYfavhpn4u/mx2K5C4qXwy+NltiFhlMZO7gDAduL+wDP2R9xQ68
 6g5LWNPKdXQBgNl4UMiJ8bbs4Fjo4Swn/BkgOZhBiH/++y99Yo9plfcZ/1owc8XXl57fkoc
 r8EyKRIih4jGGmYi0GmjCT2qo9imf7pZuNwpfY1kdcD+FJVG/hWV4gmUv/diP/jMvUFmIkQ
 8vGMgae34WnPeiGO5egEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DWvF/XYCkxs=;QNNMjAu1JQGZXQRzyJ/wSQ56tV4
 +n9TLrLDpZGOYfDXX55Tam3xzF3JU/DWzENxxxWJTn6Daogw9tclYnrlG1KzqsKT1Xd6kGYzA
 S/0j7anXHeqdgQBVIVWl5V7WroW3X7I3XOIBMYau4T+NWgmmGchpenbD+SXzJla1OTgRm+STU
 Wf1eLUO77ibIqncLqyW3fDs67l6NG1Uug7rJCQ07x9uHpP0fwVfOyJ2Mm3W+1eHEA9tJBG1/1
 JFNAdbauoPC2bl4CPyUhqe3n1Pka/CfumBQRou9G7edts+/9iYKFpTf8MMxrpGj4CM94XVj9i
 AGH6BYKcHPEC1dtHCH3JzWQJ/oi/rptR4BWbiOpvxG+IEeNIk8cTwdbnLMFwhQ7SdzS3K6iKx
 VaIWji5yjphXDBhfKxFk3KLJ7TuLePuECKZrp5bxteqXkVGHOMCdEf3GyBkub9oMc9RiUJP6L
 HkK4SlQLmkq3U/U4FT9NtjeBKvt7lrtMgdMGjkra5NyvefJzk7DHbdlgG3xYNi+iOIEIfm7VC
 203dLf4aAAzKG5RFjexUpfeMqGXElteOnGkEaQBrb8T3M77XYTyHn6yWNJ82su2BhbsTFF1Ty
 N4PAVI+7pnHzD0di1OojF4eFR9CAw4NxA1L3kx/H4HcqI3rwbLwbK6OanIYgjBI3NbbFceXfq
 BPXlobG/fzqd5HEob8sZVLSaKbrTWjRH/GjIQsTVk0s71hdOHtfUUrRg1oZAXWnGeM64zdGBf
 21fbI9ciV6bg9ZrhC3EExw6wkyLvXxnlt/GWWpr9RcxDsq6bz3LoBks5vq/11AQKg+QrLXYkz
 +F8GO4zFrixvDdEBQv614ScPoxFIox/1n2/fSkm3/x5n4=

Am 19.03.24 um 03:14 schrieb Ai Chao:

> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v9: Add mutex for wmi notify.
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
>   drivers/platform/x86/lenovo-wmi-camera.c | 112 +++++++++++++++++++++++
>   3 files changed, 125 insertions(+)
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
> index 000000000000..820a52588caf
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,112 @@
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
> +#include <linux/mutex.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F=
4EA400013"
> +
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +	struct mutex notify_lock;	/* lenovo wmi notify lock */
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
> +	unsigned int keycode;
> +	u8 camera_mode;
> +
> +	mutex_lock(&priv->notify_lock);
> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> +		goto out_unlock;
> +	}
> +
> +	if (obj->buffer.length !=3D 1) {
> +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length)=
;
> +		goto out_unlock;
> +	}
> +
> +	/* obj->buffer.pointer[0] is camera mode:
> +	 *      0 camera close
> +	 *      1 camera open
> +	 */
> +	camera_mode =3D obj->buffer.pointer[0];
> +	if (camera_mode > SW_CAMERA_ON) {
> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
> +		goto out_unlock;
> +	}
> +

Hi,

can you move the call to mutex_lock() to this line please?
The ACPI object parsing code does not have to be protected by the mutex,
just the key input sequence.

> +	keycode =3D (camera_mode =3D=3D SW_CAMERA_ON ?
> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
> +	input_report_key(priv->idev, keycode, 1);
> +	input_sync(priv->idev);
> +	input_report_key(priv->idev, keycode, 0);
> +	input_sync(priv->idev);
> +
> +out_unlock:
> +	mutex_unlock(&priv->notify_lock);
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
> +	mutex_init(&priv->notify_lock);

Please note that mutex_destroy() should be called when removing the driver
or when an error occurred during probe.

Other than those two issues, the driver looks fine.

Thanks,
Armin Wolf

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

