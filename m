Return-Path: <linux-kernel+bounces-110702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209608862AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2981F2147A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B6136650;
	Thu, 21 Mar 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gzZ9Awnq"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB1288AE;
	Thu, 21 Mar 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057584; cv=none; b=IeI6QlbZGLyzWRr1mTutZZWWhnLZuEJ2OvR70hc2P06Inm4EMQNjoeuuOaU925EXzryGFyw0o91IlF9CSJ84PZTxNkuMIogRtcx3aGt7vlmC1XcTjWwTzbwmMPPMCgHjYrax4HQaANWewobiYe+pIsVAkPEa3st8U3hwcDq01+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057584; c=relaxed/simple;
	bh=YM7x7eduytqOu7XXjRK6C57ev4aoRSQUGQRkutl1edM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XUlWqaQFxU8ecUrfc8ZnROD6liyM3ygD8X+R8O5LiGYnTDeu5Yl7aWSxmOHJ5x3hATaBkehC4cgMmCL6WLWxzSS6Pn2ugaDL9j9X9JVizWKPpliSm+LAp9ZQmySodllHhlIFGadgeCs5LbCj41/lm5blgQLECMP7UeBgr6PDO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gzZ9Awnq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711057568; x=1711662368; i=w_armin@gmx.de;
	bh=LiiThx5XQf5ZpU9dfYljMmJCsCbXTOayXeZUH9AnN2U=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=gzZ9AwnqG5C3w6poFXp8KE441bDGPRKQ5aYyvCtJnPfT9Pet0rrrgJsLdeJb4w7M
	 nW4dfnvCFTHgjDJzGw1SUJIN0sHT1sbnzvJxFkKroSE4JaXaCIBZR49vgDiPEH4DN
	 nvtjImAE6Idkcqu1/Fg67kMuxWADEQxfmq7UcvCefIopu6pr0PI8+CMbXkM3n9Vo0
	 OcvnRsbB/53OgtsF9Xe2mlFvFSxnTcdZseACtj2f+TrMA6rt3yRxKm705RJwYmnsd
	 Ko41hIx9dmfZTTX7E+ODVFusuF6F3Suj8/kBLnU7WSk6rek2dvDlgwS0mSAh9V3uI
	 87OirR+UwcH8QOL4Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1qzm4a1qaq-00ne7k; Thu, 21
 Mar 2024 22:46:08 +0100
Message-ID: <98358aa6-332b-47ab-bdec-8a377fff992b@gmx.de>
Date: Thu, 21 Mar 2024 22:46:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] platform/x86: add lenovo wmi camera button driver
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240320081740.818344-1-aichao@kylinos.cn>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240320081740.818344-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rs9TsRlPjWPRp/ucGDeA3miUzim9IOZtArWY9QsuqKro5JgNcLg
 ff2CiBdizvWvlo9M9Ax2VOvJVPXnFQmPSL1/eIXmnLPOMwOMm8EWX3ZYuYvV3vLzvQedi9T
 C7CrveCYhLvhyHUMMlAkd2rir+kHTTbL7HingNGy5LCeY+OauzRZnGaNyXogyDewgDe8cfw
 gHhFP6GM9uviGq4TPP4uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wDyhss3OC5M=;mRJl9e4WYyOPGIzStYnuBm/j+jb
 lXsobDGm7Mvh49mmhvvnLXTdU4D4oWWIB0/9UE1lzU9ib0ajgMdW33i8knn7Q+/EtUMBajdSU
 B5zB2g+2Z36//k/4d92GxLqBS+vCSGbkowV9TDxEfQVAP8sGbkfLaUvDifWjFIjzwPpwz/RAh
 fz4I2DuWKQpM5u2ipt1KpGy9sbFBnWMZoRcw6RvMQV0MmgFL2yXfgsN5CsQ6GtLoCcIMDqkTR
 LPOP4BCQZktfjcVOzuYjEOb8Q1DyuKUBUiTiulmuxq33ZBVa9KeHHV8lcnKHxwdWdzVdRCU2s
 1Ue0DCbbEKvXK3u6wZygwOGUKy0vfDQbGdFqgs8SnSUqeAT8fegozaO5AGzjLJZWAlYvZjixY
 UkTvOpKkH5WgmJThLzEd2d4NqKQyrAoU2MKAYK81kVPTdTEcOobjXbmVmXlhBJbEut0X19nkt
 p4FmMI68JfajBogKXvhXp19AS7AywAbD7uN6Ds+/XH6Hkth62zn3nLIaDB1x6yxpfDRAKfM2k
 OxuZ6VK5DZh1vCd/PR/xBu3b8qcmpMT1B0r+XDotVtnFn+k6TDC8Wo3qcZ6fo0FS9cT2XiBAA
 SmhWQPWsHGVcvHXjluMKCNYdE+BJnYP/UjlnZ5Bx7NkqLlP4V/K5bVe6kRWv+vJm/ThnDf+2a
 ZfkiDZ3gUWw+4cUbauE524vbTlZl3dkmWQ85ZUITbiAQKkdnRgX4WIHwhq21mnWxQTwplYIvN
 iJlgV51ZKdq/z7CLi2nUEtwWjmBHbVGfJJt4n1+GqXO7rhASlMQt9YiPbP7VamPgoiCIjWam2
 1cCT/p2y2IVvvPStAmPQxR9U5okNl2IBqe5FOXp6XBZeA=

Am 20.03.24 um 09:17 schrieb Ai Chao:

> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v10: Add lenovo_wmi_remove and mutex_destroy.
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
>   drivers/platform/x86/lenovo-wmi-camera.c | 123 +++++++++++++++++++++++
>   3 files changed, 136 insertions(+)
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
> index 000000000000..4b1bd81cc581
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,123 @@
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
> +	struct mutex notify_lock;	/* lenovo wmi camera button notify lock */
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
> +	mutex_lock(&priv->notify_lock);
> +
> +	keycode =3D (camera_mode =3D=3D SW_CAMERA_ON ?
> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
> +	input_report_key(priv->idev, keycode, 1);
> +	input_sync(priv->idev);
> +	input_report_key(priv->idev, keycode, 0);
> +	input_sync(priv->idev);
> +
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
> +	priv->idev =3D devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev) {
> +		mutex_destroy(&priv->notify_lock);
> +		return -ENOMEM;
> +	}
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
> +static void lenovo_wmi_remove(struct wmi_device *wdev)
> +{
> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +	mutex_destroy(&priv->notify_lock);
> +	input_unregister_device(priv->idev);

Hi,

input_unregister_device() is not needed because of devm_input_allocate_dev=
ice(),
and still mutex_destroy() is not called when input_device_register() fails=
.

Maybe you can just call mutex_init() after calling input_device_register()=
 (after doing
the necessary error handling), like this:

	ret =3D input_register_device(priv->idev);
	if (ret < 0)
		return ret;

	mutex_init(&priv->notify_lock);

	return 0;

This should work because the notify handler (which is the only user of thi=
s mutex) can only
run after lenovo_wmi_probe() returns.

In lenovo_wmi_remove(), you then just need to call mutex_destroy().

Thanks,
Armin Wolf

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
> +	.remove =3D lenovo_wmi_remove,
> +};
> +
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo WMI Camera Button Driver");
> +MODULE_LICENSE("GPL");

