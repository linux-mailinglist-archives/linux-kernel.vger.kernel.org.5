Return-Path: <linux-kernel+bounces-104721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B60F87D2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB5283D11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046A4F20E;
	Fri, 15 Mar 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Y9SYMkth"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DE4CB28;
	Fri, 15 Mar 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523604; cv=none; b=bwmEMjISyVTaoE5Yx6FEQjcQCLDtjbLx/QxHdPuNZJQn8QAtcTa8y6rsRZuLHABCAn+ZxR7zVkhgwotS5PeKHkAPEWT90Q1i8UOpPbZiIpRezwfFgnrp26f9kaC3hg1IoyvI94SI8cBj5/e9l9M8HvjKSR4rUmN3EBg+91Ne0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523604; c=relaxed/simple;
	bh=ygRI23C6RBYWrQ/EPvkkuPXFb+etv39kxODn1idD9Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6ha3+CqSF4ps+RLG9aJFCYH1qaEhtdquGYV5ykiXBeu7/tJmLaQsL+UlMWTB3OUNz243A90ckghBOVMQA0vRbO5S/q2VCAglNXeVr/pEBKmjOMmwYXJODlqxkrojgdXcvALQ7ncLgiiYUuoEwQbsAasxVak0EKMkUBub5r/qWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Y9SYMkth; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710523590; x=1711128390; i=w_armin@gmx.de;
	bh=3sTic/dN2Y9HOneaJCdXm9WF6RW0UjLBsv+KEhE/fGw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Y9SYMkth4P+i9FgCSgSUU9yONP830s39QbQda3MQFgNs1btN0dim774cfKiclwrG
	 T84sHL1h1n1T55Jcm3fX5oU/PtFT1xE7EA9HzKXHEOOmdM5APdLs4FlvwcgF0pxzQ
	 SaEIPfHMpe+ahH80ledWN/0ZN20YLAA6iG6IQhZ3J/Zp7WwJ/iyABAlkCt/FqYYSJ
	 NNJ5rW4nx4X58KgHFbLzSY/5IuXimD2M0CVyaZz0RTKMLoIbb4HXR1oXBG6XDVfW5
	 TuyV2ZK9GWoMCCi7uHVwRT4mXRy3xyuDnjOIa9hG8ikkZooyayn3KY6OSpd5925BB
	 Zkh9SiXOiNHLacVy0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1qlYCE1YMC-00zrVn; Fri, 15
 Mar 2024 18:26:30 +0100
Message-ID: <a2db8f76-d0c3-402e-9fb0-13f36c848607@gmx.de>
Date: Fri, 15 Mar 2024 18:26:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] platform/x86: add lenovo wmi camera button driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ai Chao <aichao@kylinos.cn>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <20240314050319.171816-1-aichao@kylinos.cn>
 <d7c2de21-50f9-4602-abd0-b83ecbc3f42f@gmx.de>
 <62b54638-92eb-52e1-d4ad-074963771157@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <62b54638-92eb-52e1-d4ad-074963771157@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BReRoI1r0SUu0SLWBo2NeaaQaUGdwd40G5tqaIleZJDUjghS5u1
 ftsMtTWZQ2EsUFgU3fvXgtxnibKnDcX8sxUrg3sxtkmAyRMhO/k18Bop/YvcI8/ZV1+eufy
 wql8ZI7/JdmNTSEPyT3Vnn1P4zG31KcmU132whpKqF7hRRgOC3Joc3T11ay+HNoAJ+ty/Zi
 Bp8JYRfaL3iJgGdOhM5XQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:87JozaQszNc=;p5OmE38unKw1/dDvL3/uB/XtT/c
 2IZDMcaSww5LFPh67I8j/tSrIJdBXHZPRkCjLT76ltR5THwjf89zFmN1vb5fpHIwjUwKyrJJl
 K5fnjxu4Ay3ERpylmqnFRLjlgLyEawg78reOZszyLCYBJDL2wnGl602hrKd5u7/JuxxCmpzQC
 wEIu+VLJn9jOQZ9LJQkKUDyYI6Wb7jbhCRWnmnljJhGOQ5ZbsDxeTn8BIfBhx8yOxU5NJh13T
 m010Jgq2H1TRKJXB9Ws4+HxIZnvJoNlky8V6BHLSSue3fW+leFfOhZWDD+dsx9Gi/zbw5ovVx
 uAvs0SjuSiC7eF4GiAWQ9MEqLn1AhLGfWYa6pl2NLXFQ2nTEsNIExYBlgFWHCLd91jXYErnBH
 FHEQcvg2C/BFq+cmDrSfVH2XDXPYEuaVK/jpBNfKa3+D/IQ521sOf4zH1qhl+AOBA2dNjG7OU
 rmL/hU2+WQwBroeqeyaCSCRgjsx5eWwsSQeoJXMb/IM8drWkvl/sRw/wJbVd7KJed0GdAHK0o
 BfQYnGdiCCLsBnFbTBnpQce+rYOwfPPjzzupJdORlpD0I8RoYwKkhzX0ayAWrrF9XWi0C5Vpv
 BLwnTqX1S6fGOmLhz4KOBNuPj2nLCJZPZs1YyYVNha9mPlaVpZsx+wm8kb4z87vXVf1BYRTpL
 uzxB7WOVlp8sugHFwEUsXJFayIVCTZAzBtkTtRoVWeJdROYER4yAd7Y2baJCwnE7KgDxl2Jns
 znD74YrPJi2H8pFVUmuKNdsFyh5D4ab4EaKdpaeE2+48xS7Z8WbxE8BjsUq/RVv4CVbTmADAV
 +fukKamJVCaOrGqYlgfI73AUPio5cXooD29hb244olS38=

Am 15.03.24 um 12:51 schrieb Ilpo J=C3=A4rvinen:

> On Thu, 14 Mar 2024, Armin Wolf wrote:
>
>> Am 14.03.24 um 06:03 schrieb Ai Chao:
>>
>>> Add lenovo generic wmi driver to support camera button.
>>> The Camera button is a GPIO device. This driver receives ACPI notifyi
>>> when the camera button is switched on/off. This driver is used in
>>> Lenovo A70, it is a Computer integrated machine.
>>>
>>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>>> ---
>>> v8: Dev_deb convert to dev_err.
>>> v7: Add dev_dbg and remove unused dev in struct.
>>> v6: Modify SW_CAMERA_LENS_COVER to
>>> KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
>>> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_C=
OVER.
>>> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct
>>> lenovo_wmi_priv.
>>> v3: Remove lenovo_wmi_remove function.
>>> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>>>
>>>    drivers/platform/x86/Kconfig             |  12 +++
>>>    drivers/platform/x86/Makefile            |   1 +
>>>    drivers/platform/x86/lenovo-wmi-camera.c | 108 ++++++++++++++++++++=
+++
>>>    3 files changed, 121 insertions(+)
>>>    create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconf=
ig
>>> index bdd302274b9a..9506a455b547 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>>>    	To compile this driver as a module, choose M here: the module
>>>    	will be called inspur-platform-profile.
>>>
>>> +config LENOVO_WMI_CAMERA
>>> +	tristate "Lenovo WMI Camera Button driver"
>>> +	depends on ACPI_WMI
>>> +	depends on INPUT
>>> +	help
>>> +	  This driver provides support for Lenovo camera button. The Camera
>>> +	  button is a GPIO device. This driver receives ACPI notify when the
>>> +	  camera button is switched on/off.
>>> +
>>> +	  To compile this driver as a module, choose M here: the module
>>> +	  will be called lenovo-wmi-camera.
>>> +
>>>    source "drivers/platform/x86/x86-android-tablets/Kconfig"
>>>
>>>    config FW_ATTR_CLASS
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Make=
file
>>> index 1de432e8861e..217e94d7c877 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>>>    obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>>>    obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>>>    obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
>>> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
>>>
>>>    # Intel
>>>    obj-y				+=3D intel/
>>> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c
>>> b/drivers/platform/x86/lenovo-wmi-camera.c
>>> new file mode 100644
>>> index 000000000000..f83e3ccd9189
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
>>> @@ -0,0 +1,108 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Lenovo WMI Camera Button Driver
>>> + *
>>> + * Author: Ai Chao <aichao@kylinos.cn>
>>> + * Copyright (C) 2024 KylinSoft Corporation.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/device.h>
>>> +#include <linux/input.h>
>>> +#include <linux/module.h>
>>> +#include <linux/wmi.h>
>>> +
>>> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID
>>> "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
>>> +
>>> +struct lenovo_wmi_priv {
>>> +	struct input_dev *idev;
>>> +};
>>> +
>>> +enum {
>>> +	SW_CAMERA_OFF	=3D 0,
>>> +	SW_CAMERA_ON	=3D 1,
>>> +};
>>> +
>>> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_obj=
ect
>>> *obj)
>>> +{
>>> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
>>> +	u8 camera_mode;
>>> +
>>> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
>>> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
>>> +		return;
>>> +	}
>>> +
>>> +	if (obj->buffer.length !=3D 1) {
>>> +		dev_err(&wdev->dev, "Invalid buffer length %u\n",
>>> obj->buffer.length);
>>> +		return;
>>> +	}
>>> +
>>> +	/* obj->buffer.pointer[0] is camera mode:
>>> +	 *      0 camera close
>>> +	 *      1 camera open
>>> +	 */
>>> +	camera_mode =3D obj->buffer.pointer[0];
>>> +	if (camera_mode > SW_CAMERA_ON) {
>>> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
>>> +		return;
>>> +	}
>>> +
>>> +	if (camera_mode =3D=3D SW_CAMERA_ON) {
>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
>>> +		input_sync(priv->idev);
>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
>>> +	} else {
>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
>>> +		input_sync(priv->idev);
>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
>>> +	}
> While not exactly wrong the if seems unnecessary, you could do:
>
> 	unsigned int keycode;
>
> 	...
>
> 	keycode =3D camera_mode =3D=3D SW_CAMERA_ON ? KEY_CAMERA_ACCESS_ENABLE =
:
> 						KEY_CAMERA_ACCESS_DISABLE;
>
> 	input_report_key(priv->idev, keycode, 1);
> 	input_sync(priv->idev);
> 	input_report_key(priv->idev, keycode, 0);
>>> +	input_sync(priv->idev);
>>> +}
> Armin,
>
> I tried to figure out the concurrency rules for the WMI notify handler b=
ut
> came up basically nothing. I suppose it boils down on ACPI notify handli=
ng
> and I couldn't find useful documentation about that either. :-/
>
> Could you perhaps add this information into WMI documentation?

As far as i know, the ACPI notify handlers can be scheduled concurrently o=
n all CPUs,
see https://lore.kernel.org/all/7617703.EvYhyI6sBW@kreacher/ for details.

I will add a short note about this to the WMI driver guide which i plan to=
 upstream
soon (after the EC handler stuff is finished).

Thanks,
Armin Wolf


