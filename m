Return-Path: <linux-kernel+bounces-92612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A18722E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB661C22019
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D671127B46;
	Tue,  5 Mar 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bCH8N1/n"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC002126F1F;
	Tue,  5 Mar 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652941; cv=none; b=TWXlSkxIkyEexN/KgAlyC0RyrQAhhjm8UuZp2IOcplMjwhg10RJpGbAEWhZ1GER9QHR6kSe3o6Oe9vDeHAvLhk4bZ55VoVNrFpM3U4zNen7kEb5caGkI3XOYLR6+219CyOkFPUxfMKcMP5+Omg0g+wV02xj8uxRrbPC7weS4vfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652941; c=relaxed/simple;
	bh=qOaaWxqqe8GanHiAc/3KYE70MmepKsyd/OAvitJnpgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWG4/zdFinVFUIYuKLCjfgdjlVvH75+6iGFBHhrGYNz9eSAVWDAVyczOK25SnzmZ1hJ3uqYBAhQVYt0FIZHSJWdh8IFWMo2TBo6rm4il5/VEhE/jkVVzMF//3aV9gIbV+7hjSC+14G6t+xiyE6e65tC4LQe5ViOvA5cIeEBJ8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bCH8N1/n; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709652911; x=1710257711; i=w_armin@gmx.de;
	bh=qOaaWxqqe8GanHiAc/3KYE70MmepKsyd/OAvitJnpgk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bCH8N1/nVpoYaoXl2QDcJg6UNTMqbTuNNZ5WL7ksZSBzr9/uhgp8HA44M7p3pnwn
	 SMQ5l7NUZUYbWh02klioNzj8H36tTHsR3X5f17XLmsrdoTw+SS5FtLsF2HYkepcF9
	 5sKNGjhmgF9DXiCE8QQsk1d4K+74e5aWRxYMR1CKM7NYjyTmR7XbS8pGxPkztCIj0
	 5CxX9YtYkNQrbSz9EpZ9W8iE1uz7nblaO72jRq6krpEN84hcx5ry+XLc+2gX1eolZ
	 cPJxr7KgQrcGUJ6SE5zw2FM3+NpfNbYM7EomiUlsR1PKarNJRp91RP4mJrLuMMkW/
	 QWW2x/TtTJ6fN/Z2zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1r0jH03s7w-00lUXB; Tue, 05
 Mar 2024 16:35:10 +0100
Message-ID: <a85fa1fd-c210-4e65-96fa-bb556671b30d@gmx.de>
Date: Tue, 5 Mar 2024 16:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] platform/x86: add lenovo generic wmi driver
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Ai Chao <aichao@kylinos.cn>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240305121315.1744363-1-aichao@kylinos.cn>
 <20240305154002-7100004b-7ced-4ef0-9bbe-ad528e1869e2@linutronix.de>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240305154002-7100004b-7ced-4ef0-9bbe-ad528e1869e2@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:krtb9adck4rX5aaY32Z0/xXlT7sIXZqRwsIAeTkaCR4LFt7g6gr
 gbCICJwgnFr4Vwd/tXeyODIfEPPbJVw8Sos5mMmrOkQ4MczOmUG7zS+xfP5yagJJYcJOwZl
 TPFHSBIcTqwcSpBjfjY+eAvRjK3gRrMCOkzxM+9Oa/085cYaNnWJviaqFw2z6knCy5W3H9J
 LTgCsmnKCaPYlqL/f2hRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3GakgJDJBO4=;NhVpk83dEMO0O8exgdDV2V7GIU4
 3AzPhEgaSsCxugjOUFTTyx6DjfO/x1bRqVwn0y8FVucWo106wI4FJ9eLn5hdC1HEtNsefbi1u
 Qz1nzHFNg0wZH+x62ggWdw3XWCGhLFsJvSS8bvs++QoIBeKtF+Ge9q6YKNvWDC9X4A/KyFqsV
 TIFoJxKk8k+qwt9RPuUKC2cFJdhSNslRdp5jsdY/175J0VnxaebAEamqw9GrmJ5Ns+N8L4lq9
 cN82brjYgIwke0+ySJvKDWUXaS6Q13YDfpfiaeyg7f1OzI7V0Etu9EUBHeTCD2qiXIlwpFec3
 kiy5ZZhH1TJBD6+x2cc6+VShOPBB9Wp1ONKn/4bxkUTL4epVK+69SOxuzO2Th4SwFyqhqDtJ3
 pVHzAyOPxKUpreprc6CsDnC9RB6i8p5LVgRD2NeYxMjZN0CQft/hC4mwr9YAPoFYU0jqipYIO
 exPlwHuX/lmxEPb8Ht7cLRAH+0bdRAdmS4Zjx8td2j/7c4XLvK05mXbBDPcrazviT+3Bb8b8X
 o4ndYwMuCgA26+2b1qz8hjVrqdzP2NqRfiX6CpHqWuyrT81xWUKXSc2iqSiptqFRpi2YiltHG
 eKHOsA56+I8gw9H5FaJ7tyULwGdKfQKeumA+yl7+hqPNMvpvkQgIsBnU9KKtZEpHLlZhH/d0O
 ZuDtn4kV/yR5DlI4POWn4Qa8ZWMhzpji+n729IWnICXXFNbtsBPXDIvGIEKUcSwCRY5aWckAQ
 vBxDFtrcsIdJNB6apUYdI0k6UnSnxqYl8jnsyYArkzXRFK4KIsdSxLPHvbjnh15Svfx1P818h
 x5OO+tohfhsWD0aTSPOCTQ5IQNmokwXPhZkmvtWnQISnY=

Am 05.03.24 um 15:48 schrieb Thomas Wei=C3=9Fschuh:

> On Tue, Mar 05, 2024 at 08:13:15PM +0800, Ai Chao wrote:
>> Add lenovo generic wmi driver to support camera button.
>> The Camera button is a GPIO device. This driver receives ACPI notifyi
>>   when the button pressed.
> the button *is* pressed.
>
>
> The subject does not mention that it is only about te camera button.
>
> I would be interested on which devices this driver was tested and is
> expected to work with.
>
>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>> ---
>> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_=
wmi_priv.
>> v3: Remove lenovo_wmi_remove function.
>> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>>
>>   drivers/platform/x86/Kconfig             |  12 +++
>>   drivers/platform/x86/Makefile            |   1 +
>>   drivers/platform/x86/lenovo-wmi-camera.c | 118 ++++++++++++++++++++++=
+
>>   3 files changed, 131 insertions(+)
>>   create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index bdd302274b9a..079f5aa5910c 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>>   	To compile this driver as a module, choose M here: the module
>>   	will be called inspur-platform-profile.
>>
>> +config LENOVO_WMI_CAMERA
>> +	tristate "Lenovo WMI Camera Button driver"
>> +	depends on ACPI_WMI
>> +	depends on INPUT
>> +	help
>> +	  This driver provides support for Lenovo camera button. The Camera
>> +	  button is a GPIO device. This driver receives ACPI notify when the
>> +	  button pressed.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called lenovo-wmi-camera.
>> +
>>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>>
>>   config FW_ATTR_CLASS
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
>> index 1de432e8861e..217e94d7c877 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>>   obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>>   obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
>> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
>>
>>   # Intel
>>   obj-y				+=3D intel/
>> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platfor=
m/x86/lenovo-wmi-camera.c
>> new file mode 100644
>> index 000000000000..77084266829c
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Lenovo WMI Camera Button Driver
>> + *
>> + * Author: Ai Chao <aichao@kylinos.cn>
>> + * Copyright (C) 2024 KylinSoft Corporation.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/input.h>
>> +#include <linux/module.h>
>> +#include <linux/wmi.h>
>> +
>> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62=
F4EA400013"
>> +
>> +struct lenovo_wmi_priv {
>> +	struct input_dev *idev;
>> +	struct device *dev;
>> +	u8 camera_mode;
>> +};
>> +
>> +enum {
>> +	CAMERA_BUTTON_PRESSED =3D 1,
>> +};
>> +
>> +static ssize_t camerabutton_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%u\n", priv->camera_mode);
>> +}
>> +DEVICE_ATTR_RO(camerabutton);
>> +
>> +static struct attribute *lenovo_wmi_attrs[] =3D {
>> +	&dev_attr_camerabutton.attr,
>> +	NULL,
> No trailing comma after sentinel elements.
>
>> +};
>> +
>> +static const struct attribute_group lenovo_wmi_group =3D {
>> +	.attrs =3D lenovo_wmi_attrs,
>> +};
>> +
>> +const struct attribute_group *lenovo_wmi_groups[] =3D {
>> +	&lenovo_wmi_group,
>> +	NULL,
> Also no trailing comma.
>
>> +};
>> +
>> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_obje=
ct *obj)
>> +{
>> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +
>> +	if (obj->type =3D=3D ACPI_TYPE_BUFFER &&
>> +	    obj->buffer.pointer[0] <=3D CAMERA_BUTTON_PRESSED) {
>> +		/* Camera mode:
>> +		 *      0 camera close
>> +		 *      1 camera open
>> +		 */
>> +		priv->camera_mode =3D obj->buffer.pointer[0];
> This looks similar to a switch.
> Would it be more useful for the user to report a standard switch instead
> of a key event which needs to be correlated with the sysfs file?

I agree, maybe SW_CAMERA_LENS_COVER might be the right thing to use here,
if those camera states (open/closed) are meant to symbolize camera shutter=
 states.

In such a case the initial switch state has to be retrieved, or else the i=
nput device
cannot be registered until the first event is received (similar how the hp=
-wmi driver
handles SW_CAMERA_LENS_COVER events).

Ai Chao, can you tell us if those two camera states are meant to act like =
a switch (camera switched off,
camera switched on) or meant to act like a key (camera button pressed, cam=
era button released)?

>> +
>> +		input_report_key(priv->idev, KEY_CAMERA, 1);
>> +		input_sync(priv->idev);
>> +		input_report_key(priv->idev, KEY_CAMERA, 0);
>> +		input_sync(priv->idev);
>> +	} else {
>> +		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
>> +	}
>> +}
>> +
>> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *conte=
xt)
>> +{
>> +	struct lenovo_wmi_priv *priv;
>> +
>> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv),
>> +			    GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(&wdev->dev, priv);
>> +
>> +	priv->idev =3D devm_input_allocate_device(&wdev->dev);
>> +	if (!priv->idev)
>> +		return -ENOMEM;
>> +
>> +	priv->idev->name =3D "Lenovo WMI Camera Button";
>> +	priv->idev->phys =3D "wmi/input0";
>> +	priv->idev->id.bustype =3D BUS_HOST;
>> +	priv->idev->dev.parent =3D &wdev->dev;
>> +	set_bit(EV_KEY, priv->idev->evbit);
>> +	set_bit(KEY_CAMERA, priv->idev->keybit);
> input_set_capability()?
>
>> +
>> +	return input_register_device(priv->idev);
>> +}
>> +
>> +static const struct wmi_device_id lenovo_wmi_id_table[] =3D {
>> +	{ .guid_string =3D WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
>> +	{  }
>> +};
>> +
>> +static struct wmi_driver lenovo_wmi_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "lenovo-wmi-camera",
>> +		.dev_groups =3D lenovo_wmi_groups,
>> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +	.id_table =3D lenovo_wmi_id_table,
>> +	.no_singleton =3D false,

The correct setting in this case would be ".no_singleton =3D true",
since camera_mode now lives inside struct lenovo_wmi_priv.

Thanks,
Armin Wolf

>> +	.probe =3D lenovo_wmi_probe,
>> +	.notify =3D lenovo_wmi_notify,
>> +};
>> +
>> +module_wmi_driver(lenovo_wmi_driver);
>> +
>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
>> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
>> +MODULE_DESCRIPTION("Lenovo Generic WMI Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>

