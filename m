Return-Path: <linux-kernel+bounces-111965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2B88735C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8452823D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2955970CB1;
	Fri, 22 Mar 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fexFCljY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AA39AC5;
	Fri, 22 Mar 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133356; cv=none; b=cAWtdKcuf9vQDK4D27O/5k4f8ikPXITgDePAgbVA8/DYOzbnf6yhOddBZ2xs6zhlYLooS8R1ZW8NYTVfCSjaA66cAZPrIvYfjLAQnnnQN09wqbOwKSolRF29X1cZ1JKSBwfUZFhe5m+wcyDLqv44oU7PTuPVzV04jzHWMrVrnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133356; c=relaxed/simple;
	bh=n53/fcwqscy7JLUVq7eTOs9MewFdG7+seHsjTqDEO9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkWSQdiSQzRFj3aDyWv8TXFG1kVHA+hekcYuz5OSqaqEry4LuPuyAvOgm6QHUTU57szChbr3zKNSz1e6h5dVcvGHmTl2+Mm+jF2rMzOiBfkbohrwAmmYR46Ie2Cpb52lSnHJI2mLfP3ujnj7wvjw+Oi1bgPpK2S3m0hdRDoeXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fexFCljY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711133340; x=1711738140; i=w_armin@gmx.de;
	bh=Gf140vAIe/6XrAFst2m1XbhP5EmoKJXbeR+F4ntRdGU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fexFCljYi93Hvqo6mFkliIuDP1KSoVls2MBk+s+j9gCEChHiS+EFsGmjc8+Vvk3U
	 mS/kykzrZHZUkxy4HeAj/JCYXXEJMAhyQt0BvKwrut34H+I/nJ+kEP9Nsq8U2E570
	 4A6ropIPRGaOo09FngwBlNIuBSwGXBPDJaLUflzg1T2H7Njicbi0v82qcsT9aFi8q
	 GqAoajZmabuu3G1CesfArnm3cU8OD8ddMWpN0UoshF4uc2nEDxQu/dzkgE/YcdFX/
	 rvenp9bIPtdQYzXxAntYLnhFn8Do16urAXfgPBLxXY2ml7IG1UyZj2BtNRIDQRlfQ
	 Fegb1QcUVvaAM7X3JQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1r9iIM45VR-00e43t; Fri, 22
 Mar 2024 19:49:00 +0100
Message-ID: <8b2245fb-fce0-4155-b022-19ca1d6b9a77@gmx.de>
Date: Fri, 22 Mar 2024 19:48:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ai Chao <aichao@kylinos.cn>, Hans de Goede <hdegoede@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
References: <20240322064750.267422-1-aichao@kylinos.cn>
 <5e30a445-0a14-4242-9c1d-578a5b7cfcbe@linux.intel.com>
 <f1421e47-a6b7-e8f1-49a0-28e3351b2450@linux.intel.com>
 <7705e36f-829b-4661-9399-496905b3d161@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <7705e36f-829b-4661-9399-496905b3d161@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bUPb3MKzRGowKHd2B2cN6R6gArEQdmOVymPGvZkoFZ6ncCkU/Ec
 fkiw+WWjtGlSqIcr9YzIqJUHVEMMiIJLWlMrAfkT4J8UujjrxUp5yQf9ocUkE/RsHGBT/3B
 EtovWAM886/a4lCniJRum1Gq2PnIU/CNxhiIw61IiViF2VPE/D5xGN9XEos3GOxucB0big7
 skZlpFcV5FnqsQQb+6M7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lU2DApP1Dws=;9RljlQCgpoQNUCx7h08Ysj6M9r8
 jfOh/GgkEkKb385vOI0T7Gy/oFjJA65duK+KSSyj9H+4D6FNhHV/gfxPA6t//P+8Kpo0/DF7Y
 9W8eVpQ/f2YHtxXSYI/xHuhOcyVO6fxuRMdY2mpuICtl9q9uJqn2asc7O9l7oQbNb8bCe4cbt
 0g5A8FDBA74Ww658HXbPSQgqM/9dlhKCnTJ4noqq1bm8NgC+v3rixDffSmiMXF3WQL42xeau4
 qZqM2h/jlrrOzurYG3WztBTX55OLlRExCliAQ5xec2nQ2q1MAIcUDrNT2Uxl38t9tDb9ZdVPJ
 tsmwjegO4QQmeSdKDSoVkceWmmW/im5nBGHLnU1xP1QgEDeIWVAmoyk4AkjPyNNo+YcZIfAB3
 VM7BNeke8ASziSoACvDfDTbzemRa08IA7ALhbxm0lz2H9pA/WIYyb7xeB2+v/2tDddfj91Z/H
 gjNFgARqvi/5+Ys4ZG+BOXgaxUTp6IhyxeQYwPxOXPhd+nnouSgrC5xzvKFCrN4bOMGSf9+Tf
 z0X4IhetsRFHETKAFHNaQOOEMj8coGty7AxM0zIT0MIdnX7VG4ojDwU18pNeu/SMS1JIwKDkw
 IvnwA+A4agBt1Vl5DL46U2EFcNhnAE/WGa+HszPNP+j22K6rutAjyt9m6v7msCw5OZcjhEb6a
 uSAhIxDngxVSOc0Hx2Af1G+tqteeyBPVUlbN+dGdMATYuu1WpJICpI7F93GGCvdilBrYB3kCt
 OC6xpMnmOTQGbrC48ylpqpcbry0Q6lXi/AUyrYX/lZRNgNRkKnRPLP0fbJP3Pasqft7fFnuYx
 wcgX7ETj5cB/SOFJLSlWX2mMRaIRWLOQG3UJJDvweNMJ4=

Am 22.03.24 um 17:47 schrieb Kuppuswamy Sathyanarayanan:

> On 3/22/24 7:39 AM, Ilpo J=C3=A4rvinen wrote:
>> On Fri, 22 Mar 2024, Kuppuswamy Sathyanarayanan wrote:
>>> On 3/21/24 11:47 PM, Ai Chao wrote:
>>>> Add lenovo generic wmi driver to support camera button.
>>>> The Camera button is a GPIO device. This driver receives ACPI notifyi
>>>> when the camera button is switched on/off. This driver is used in
>>>> Lenovo A70, it is a Computer integrated machine.
>>>>
>>>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>>>> ---
>>>> v11: remove input_unregister_device.
>>>> v10: Add lenovo_wmi_remove and mutex_destroy.
>>>> v9: Add mutex for wmi notify.
>>>> v8: Dev_deb convert to dev_err.
>>>> v7: Add dev_dbg and remove unused dev in struct.
>>>> v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMER=
A_ACCESS_DISABLE.
>>>> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_=
COVER.
>>>> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenov=
o_wmi_priv.
>>>> v3: Remove lenovo_wmi_remove function.
>>>> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>>>>
>>>>   drivers/platform/x86/Kconfig             |  12 +++
>>>>   drivers/platform/x86/Makefile            |   1 +
>>>>   drivers/platform/x86/lenovo-wmi-camera.c | 126 ++++++++++++++++++++=
+++
>>>>   3 files changed, 139 insertions(+)
>>>>   create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>>>>
>>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
>>>> index bdd302274b9a..9506a455b547 100644
>>>> --- a/drivers/platform/x86/Kconfig
>>>> +++ b/drivers/platform/x86/Kconfig
>>>> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>>>>   	To compile this driver as a module, choose M here: the module
>>>>   	will be called inspur-platform-profile.
>>>>
>>>> +config LENOVO_WMI_CAMERA
>>>> +	tristate "Lenovo WMI Camera Button driver"
>>>> +	depends on ACPI_WMI
>>>> +	depends on INPUT
>>>> +	help
>>>> +	  This driver provides support for Lenovo camera button. The Camera
>>>> +	  button is a GPIO device. This driver receives ACPI notify when th=
e
>>>> +	  camera button is switched on/off.
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the module
>>>> +	  will be called lenovo-wmi-camera.
>>>> +
>>>>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>>>>
>>>>   config FW_ATTR_CLASS
>>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Mak=
efile
>>>> index 1de432e8861e..217e94d7c877 100644
>>>> --- a/drivers/platform/x86/Makefile
>>>> +++ b/drivers/platform/x86/Makefile
>>>> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>>>>   obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>>>>   obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>>>>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
>>>> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
>>>>
>>>>   # Intel
>>>>   obj-y				+=3D intel/
>>>> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platf=
orm/x86/lenovo-wmi-camera.c
>>>> new file mode 100644
>>>> index 000000000000..fda936e2f37c
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
>>>> @@ -0,0 +1,126 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Lenovo WMI Camera Button Driver
>>>> + *
>>>> + * Author: Ai Chao <aichao@kylinos.cn>
>>>> + * Copyright (C) 2024 KylinSoft Corporation.
>>>> + */
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/input.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/wmi.h>
>>>> +
>>>> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-=
62F4EA400013"
>>>> +
>>>> +struct lenovo_wmi_priv {
>>>> +	struct input_dev *idev;
>>>> +	struct mutex notify_lock;	/* lenovo wmi camera button notify lock *=
/
>>>> +};
>>>> +
>>>> +enum {
>>>> +	SW_CAMERA_OFF	=3D 0,
>>>> +	SW_CAMERA_ON	=3D 1,
>>>> +};
>>>> +
>>>> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_ob=
ject *obj)
>>>> +{
>>>> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
>>>> +	unsigned int keycode;
>>>> +	u8 camera_mode;
>>>> +
>>>> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
>>>> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (obj->buffer.length !=3D 1) {
>>>> +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.leng=
th);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/* obj->buffer.pointer[0] is camera mode:
>>>> +	 *      0 camera close
>>>> +	 *      1 camera open
>>>> +	 */
>>>> +	camera_mode =3D obj->buffer.pointer[0];
>>>> +	if (camera_mode > SW_CAMERA_ON) {
>>>> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	mutex_lock(&priv->notify_lock);
>>>> +
>>>> +	keycode =3D (camera_mode =3D=3D SW_CAMERA_ON ?
>>>> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
>>>> +	input_report_key(priv->idev, keycode, 1);
>>>> +	input_sync(priv->idev);
>>>> +	input_report_key(priv->idev, keycode, 0);
>>>> +	input_sync(priv->idev);
>>>> +
>>>> +	mutex_unlock(&priv->notify_lock);
>>>> +}
>>>> +
>>>> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *con=
text)
>>>> +{
>>>> +	struct lenovo_wmi_priv *priv;
>>>> +	int ret;
>>>> +
>>>> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dev_set_drvdata(&wdev->dev, priv);
>>>> +
>>>> +	priv->idev =3D devm_input_allocate_device(&wdev->dev);
>>>> +	if (!priv->idev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	priv->idev->name =3D "Lenovo WMI Camera Button";
>>>> +	priv->idev->phys =3D "wmi/input0";
>>>> +	priv->idev->id.bustype =3D BUS_HOST;
>>>> +	priv->idev->dev.parent =3D &wdev->dev;
>>>> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_ENABLE);
>>>> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_DISABLE)=
;
>>>> +
>>>> +	ret =3D input_register_device(priv->idev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	mutex_init(&priv->notify_lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void lenovo_wmi_remove(struct wmi_device *wdev)
>>>> +{
>>>> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
>>>> +
>>>> +	mutex_destroy(&priv->notify_lock);
>>> Do you really need to call mutex_destroy() during the module unload?
>>>
>>> I don't think kernel allocates any memory during mutex_init() that nee=
ds
>>> be freed.
>> Is all debug code going to be happy if it's not called?
>>
> I am not aware of any issue. Do you have any details about it?
>
>  From the comments, it looks like mutex_destroy() is used to mark a
> mutex unusable. Not sure why we need to mark a device priv lock
> unusable during the unload process.

Hi,

AFAIK calling mutex_destroy() allows the lock debugging code to catch
attempts to access the mutex afterwards, so this would allow us to spot
such issues when enabling lock debugging.

For the whole driver:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>


