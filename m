Return-Path: <linux-kernel+bounces-104763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24887D334
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A744B21D74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80E4CE1B;
	Fri, 15 Mar 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="a/0+2rJv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041C18E06;
	Fri, 15 Mar 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525815; cv=none; b=ZZ14aVDH7yCjuqzcN+mCmwUGeXmxF6fv4dhyl8NvetEjx8tx0RvDb+hTHYBLUjj2urhMeCjCiudnW2qC8SJZbkhK8CD9R1xpQmDG9GtAfO9f3pFDM2XHb9YLZpI9cqZ4d6AmXnIGjSiuo5l/aM6XwZItE+rxD70NTnLbAk5uKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525815; c=relaxed/simple;
	bh=5PExrIX6hZZkjrjwEvc8mBLHVkw1G3s/oizwldnSEA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYKi0HvMA+Wz3CNwBXDR8A3s72G78811U9oU4nQOob/DjRfM/7gLgRKh3ToVD7GRVAXxTLLGLqoXNlkvO/iH2xcIU5j9AVWyPt8YN4oTEjUQsI1DX3Z/IAk5pwbhujSiumEyVRqaVxzJdzssIUnwwtxq+ciL+O8yEuWyJyQb3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=a/0+2rJv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710525801; x=1711130601; i=w_armin@gmx.de;
	bh=3mZw4lWM1ySsxwWZWpV0eMf7iGWyeeV4Pqe21MaySbU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=a/0+2rJvjYbqu81G8SPofC/5wbTZFHvdLMiHd+5HTHxQEEU1TcZVitgNYxDo76Uz
	 nvylazVhCW9N8QU4moBql9AU418WMy61D/Pz86qVE4Owvryx1otoACugVqesHkE9P
	 XF9Xu7qJC7vo2Iqa9jYhBQJ8BOda+7TGKX4m2YYToYC1ZLLsVjjIcU3fep1ZUM8iZ
	 sY+Xs3h+F72mah0ywjgP6/sQhVGtWuFKA/RKZeZc5Opahngy2q9hXkiE/wXyGta2h
	 +Xk2m+STyhlx4M4SUe8b6v5hFmRYUZBC9Qu9p1Z6pEwv6lbLYdtk/VS1BCGmER7Ol
	 VTxsfFmYFs6PDloWfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1rJWvi0K0h-00XpEF; Fri, 15
 Mar 2024 19:03:21 +0100
Message-ID: <ff3b7217-5763-4ed9-8b22-b846d3811e15@gmx.de>
Date: Fri, 15 Mar 2024 19:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ai Chao <aichao@kylinos.cn>, Hans de Goede <hdegoede@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
References: <20240314050319.171816-1-aichao@kylinos.cn>
 <d7c2de21-50f9-4602-abd0-b83ecbc3f42f@gmx.de>
 <62b54638-92eb-52e1-d4ad-074963771157@linux.intel.com>
 <a2db8f76-d0c3-402e-9fb0-13f36c848607@gmx.de>
 <c3dba443-89d5-96cb-3e40-a4e3ab87002e@linux.intel.com>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <c3dba443-89d5-96cb-3e40-a4e3ab87002e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7RnQXprhojchEHbrXDGPbbNty4+OMqq7xNhCA/FYV5tyOjle1EX
 +G3U5Ny+zHr21W/iwPuBjc/VsWITKR6mmchwuZHc+5wcxDB0FZ0dw6QVqGxHptFAeNvEc6e
 jJXNnweXUvQQwjBT2H6lyLBQ7IFjWHYIuuUb1QnmCNxJ5T5rHs3m9apMpQxjj8JIVQzpxKM
 DHAIxlr/lJAGeXIBRi3cA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JNB7gU4FF6w=;5W+cnu6pclC1kBI0PwqoIWJ4mWI
 1kqzGlI3vtUvBI86cARZO8OoqpXkii8XarmS6GD8d8X8zfWDmpXKBVuykCuqSRBg/imWE07TE
 42Wx0yGxjYiYk5xPlVdVKdWZxDZ/hW98WTZgknaWiO5UeRRQ5VUW9htaxYq0zX4FyMeTMIZ4l
 BCtRmSzeDfF3hf9jCebPIbt91zhW1DfPK/m/Cr2hZJikl7aEVDCsRsTBgzRU/G3IReqkheh3k
 7KuQgRTCmr6YlSw/NOc8cF29HowF0MrYAZAO1k3Cg4s3J84z2BVgnDJdQeF8yEi6QdGNvLkFI
 5unuV9Ax4N4cFhgf5rsLx7jelq2O1O8rQHsBUvz2LYFk/L6s+lt+0h7iIocjHP/bxef9JGvTC
 Zue/4l0xhinQNsBMv8d2RZaeCPtM9w1otDOV5HJ/23B/UzF41sls9+VsyQCkrrSApLDxAyzLC
 bNIOnBRMGa/BMCnqhjpSqe0pT2ORCWLHU4WaJDDa4PXGRjuECtr2G02HIZnkjvUTTPPkdO950
 kQGVtZwIJ9vrVbp+KSxLMdDOLzD8bgvQi6gRiG1B9Zc1uYbULcPQGMOQDRJufqYx3eec1lQ1Y
 ej8yehcWyZbPXAWn0m8szmTlnKZB1SCeQ8I1d3kuiuQJb5WfmKWSjKoD6Y7I5FyFC4nMtOZmI
 yabLwNzWs0q2yqrZOBkoF4ppupn7YRuS9VpfTJMhuGtPCzqnbk8gfwq7pZaL9pLzAed53bgm4
 FNLgrYckwZwCSZy+EOusfcKbjNhRBMl6f7fJ/A8nqEswGDtHVfca2+0LFcPzDWxkLXkQ9bW7f
 qwqIBCMOgucRDLV0q8f6OFsGurs30bQ+iOk26oM22ptiY=

Am 15.03.24 um 18:54 schrieb Ilpo J=C3=A4rvinen:

> On Fri, 15 Mar 2024, Armin Wolf wrote:
>> Am 15.03.24 um 12:51 schrieb Ilpo J=C3=A4rvinen:
>>> On Thu, 14 Mar 2024, Armin Wolf wrote:
>>>> Am 14.03.24 um 06:03 schrieb Ai Chao:
>>>>
>>>>> Add lenovo generic wmi driver to support camera button.
>>>>> The Camera button is a GPIO device. This driver receives ACPI notify=
i
>>>>> when the camera button is switched on/off. This driver is used in
>>>>> Lenovo A70, it is a Computer integrated machine.
>>>>>
>>>>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>>>>> ---
>>>>> v8: Dev_deb convert to dev_err.
>>>>> v7: Add dev_dbg and remove unused dev in struct.
>>>>> v6: Modify SW_CAMERA_LENS_COVER to
>>>>> KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
>>>>> v5: Remove camera button groups, modify KEY_CAMERA to
>>>>> SW_CAMERA_LENS_COVER.
>>>>> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct
>>>>> lenovo_wmi_priv.
>>>>> v3: Remove lenovo_wmi_remove function.
>>>>> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>>>>>
>>>>>     drivers/platform/x86/Kconfig             |  12 +++
>>>>>     drivers/platform/x86/Makefile            |   1 +
>>>>>     drivers/platform/x86/lenovo-wmi-camera.c | 108
>>>>> +++++++++++++++++++++++
>>>>>     3 files changed, 121 insertions(+)
>>>>>     create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>>>>>
>>>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kco=
nfig
>>>>> index bdd302274b9a..9506a455b547 100644
>>>>> --- a/drivers/platform/x86/Kconfig
>>>>> +++ b/drivers/platform/x86/Kconfig
>>>>> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>>>>>     	To compile this driver as a module, choose M here: the module
>>>>>     	will be called inspur-platform-profile.
>>>>>
>>>>> +config LENOVO_WMI_CAMERA
>>>>> +	tristate "Lenovo WMI Camera Button driver"
>>>>> +	depends on ACPI_WMI
>>>>> +	depends on INPUT
>>>>> +	help
>>>>> +	  This driver provides support for Lenovo camera button. The Camer=
a
>>>>> +	  button is a GPIO device. This driver receives ACPI notify when t=
he
>>>>> +	  camera button is switched on/off.
>>>>> +
>>>>> +	  To compile this driver as a module, choose M here: the module
>>>>> +	  will be called lenovo-wmi-camera.
>>>>> +
>>>>>     source "drivers/platform/x86/x86-android-tablets/Kconfig"
>>>>>
>>>>>     config FW_ATTR_CLASS
>>>>> diff --git a/drivers/platform/x86/Makefile
>>>>> b/drivers/platform/x86/Makefile
>>>>> index 1de432e8861e..217e94d7c877 100644
>>>>> --- a/drivers/platform/x86/Makefile
>>>>> +++ b/drivers/platform/x86/Makefile
>>>>> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>>>>>     obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>>>>>     obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>>>>>     obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
>>>>> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
>>>>>
>>>>>     # Intel
>>>>>     obj-y				+=3D intel/
>>>>> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c
>>>>> b/drivers/platform/x86/lenovo-wmi-camera.c
>>>>> new file mode 100644
>>>>> index 000000000000..f83e3ccd9189
>>>>> --- /dev/null
>>>>> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
>>>>> @@ -0,0 +1,108 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Lenovo WMI Camera Button Driver
>>>>> + *
>>>>> + * Author: Ai Chao <aichao@kylinos.cn>
>>>>> + * Copyright (C) 2024 KylinSoft Corporation.
>>>>> + */
>>>>> +
>>>>> +#include <linux/acpi.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/input.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/wmi.h>
>>>>> +
>>>>> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID
>>>>> "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
>>>>> +
>>>>> +struct lenovo_wmi_priv {
>>>>> +	struct input_dev *idev;
>>>>> +};
>>>>> +
>>>>> +enum {
>>>>> +	SW_CAMERA_OFF	=3D 0,
>>>>> +	SW_CAMERA_ON	=3D 1,
>>>>> +};
>>>>> +
>>>>> +static void lenovo_wmi_notify(struct wmi_device *wdev, union
>>>>> acpi_object
>>>>> *obj)
>>>>> +{
>>>>> +	struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
>>>>> +	u8 camera_mode;
>>>>> +
>>>>> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
>>>>> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	if (obj->buffer.length !=3D 1) {
>>>>> +		dev_err(&wdev->dev, "Invalid buffer length %u\n",
>>>>> obj->buffer.length);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	/* obj->buffer.pointer[0] is camera mode:
>>>>> +	 *      0 camera close
>>>>> +	 *      1 camera open
>>>>> +	 */
>>>>> +	camera_mode =3D obj->buffer.pointer[0];
>>>>> +	if (camera_mode > SW_CAMERA_ON) {
>>>>> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	if (camera_mode =3D=3D SW_CAMERA_ON) {
>>>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
>>>>> +		input_sync(priv->idev);
>>>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
>>>>> +	} else {
>>>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
>>>>> +		input_sync(priv->idev);
>>>>> +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
>>>>> +	}
>>> While not exactly wrong the if seems unnecessary, you could do:
>>>
>>> 	unsigned int keycode;
>>>
>>> 	...
>>>
>>> 	keycode =3D camera_mode =3D=3D SW_CAMERA_ON ? KEY_CAMERA_ACCESS_ENABL=
E :
>>> 						KEY_CAMERA_ACCESS_DISABLE;
>>>
>>> 	input_report_key(priv->idev, keycode, 1);
>>> 	input_sync(priv->idev);
>>> 	input_report_key(priv->idev, keycode, 0);
>>>>> +	input_sync(priv->idev);
>>>>> +}
>>> Armin,
>>>
>>> I tried to figure out the concurrency rules for the WMI notify handler=
 but
>>> came up basically nothing. I suppose it boils down on ACPI notify hand=
ling
>>> and I couldn't find useful documentation about that either. :-/
>>>
>>> Could you perhaps add this information into WMI documentation?
>> As far as i know, the ACPI notify handlers can be scheduled concurrentl=
y on
>> all CPUs,
>> see https://lore.kernel.org/all/7617703.EvYhyI6sBW@kreacher/ for detail=
s.
> Hi,
>
> I meant this from the point of view whether the same notify handler can
> only have one instance active at a time because otherwise one would
> need locking to protect e.g. that input injection sequence.

The same WMI notify handler can have multiple instances active at the
same time, so the input sequence indeed needs some locking.

Chao, can you please add a mutex to the struct lenovo_wmi_priv and use thi=
s to
protect the input sequence?

Thanks,
Armin Wolf

>
>> I will add a short note about this to the WMI driver guide which i plan=
 to
>> upstream soon (after the EC handler stuff is finished).
> Thanks.
>

