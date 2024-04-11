Return-Path: <linux-kernel+bounces-141718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB18A2261
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5E01F22F95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F9481C4;
	Thu, 11 Apr 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WKocJ8ec"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE13481CD;
	Thu, 11 Apr 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878726; cv=none; b=lsd8oC9DBOfksqIAQo8TjLL8c8Z1PRGTx9V/z6gtaHqoP7UrumlBZYF63/uju8mlvMY/u2wF1lQPwAysFA7OUVAHANRbKLy/zT4j0KrYB9Z4hVHq9iaoCzWVdxWdpV3fDSSwg5qoGZU/IIf3G9C4Xa96UsUKCGLjzGHL1YKVs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878726; c=relaxed/simple;
	bh=rOKRzDVI+nfL6DR5Djk7+RjCo0yuvrotw3Ij05MfSBg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rWBpf/stVBZXGsdG0tde8AO3W5QV3mVJoGNVNPuLfEoPZT1zxsl6Fv5CyN0/LRYgyLjQDOZAfCcNVqq9K7/B89sfz3L41wwyAlaIi0sz9TtFJBr/U+zaXGBo9zxsYMXZSeV+5nQSQ5luVE454Ru37mk/qSZ4XS4ioqx18BVyQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WKocJ8ec; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712878693; x=1713483493; i=w_armin@gmx.de;
	bh=rOKRzDVI+nfL6DR5Djk7+RjCo0yuvrotw3Ij05MfSBg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=WKocJ8echLHwzQ/MSZdNsjIMBNwycjASmzpwPtYfPHkBYLHOKz3WeHcf4eOvdX1d
	 1kgF/plg/nLBViGPvDhbsozs2QiJRopd/AunkKKdtgmrRnSZ69GbhGYGiMLeDixvS
	 wImIETBdhVTrSfhEHmkwl75hXlZteDOU5LpVVaxH5U+JExN42WXaXX+OHO+QLZpSu
	 A1tLioC+KQ6MEaTycs69t9zgq5ztI4X3HgwqI/Bvz80VIPiNwlKWWQITLwk6YOjz4
	 e99Fbrm28nt3++polCN5jwCfmr8XoidYpHPlVbd/669V+6DhUmzC9S/w3QUe5Agn9
	 x4PmX+iKb4Z2eJ4XTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1sLMGr27UG-00QSnv; Fri, 12
 Apr 2024 01:38:13 +0200
Message-ID: <b0899d74-79d7-459c-8f2d-17a17a0f58d7@gmx.de>
Date: Fri, 12 Apr 2024 01:38:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: fan: Add hwmon support
From: Armin Wolf <W_Armin@gmx.de>
To: Mikael Lund Jepsen <mlj@danelec.com>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>,
 "linux@weissschuh.net" <linux@weissschuh.net>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20240409213323.8031-1-W_Armin@gmx.de>
 <AS4P189MB21333C826C173582E12FFE3EBA062@AS4P189MB2133.EURP189.PROD.OUTLOOK.COM>
 <e6798f0a-5e50-41df-ae3e-0069c16abec3@gmx.de>
Content-Language: en-US
In-Reply-To: <e6798f0a-5e50-41df-ae3e-0069c16abec3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z9kOfMQyQB/Fv2GrugYPqDvo//YKxU6r3vmbv4RWepHwub49NEi
 hnzRjVzHxFU26+r4lagfvdrhQIvL3vvLS/ZnyhYT1VKKy7zWNsswKGa2p15oqDR1HnXKKm1
 rvSrOuO7ppx/HMCzkC55hXkSUOCeS5d4oB51H8/tvBrUk9qJvBDlsUu5o+cTsllt+SYEn5y
 2GTGJC9oZNxufH92aGIew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xop/uKZBb5Q=;zvKmDC3QaAgQWIXBzon3chvuyZR
 u+dP6urITjayP4RMiaX72Q1nfL5iYJ46XPgBtdjbNu2jROqxZFXaWCsrZ7/ASsBIdss7IxNwz
 WUeu5ki0mbedBozskWDfjtaap69fNUAokwgBZ34ao7fxtfyS3dLrnK72LGC5zxt5S04ctYxSc
 iRho0nBhc9+GeANKTt9NXmHwpuHG8HYsVl6AJ8q2O+W3cqRRIEzHe1rOB0k7L13wqJdv+JW0z
 WlKVCLLQMWDyq88FaKgAW3REGLCpJNLzr+79OvlZxk5Sv8J4rxeWccp6Zp1purFpFjkljzUry
 ezjkYnasSsdtrF4ZiKL6MOvYmCLVY1YyEwp86A4o2V1r3xQiB7Dxe/xeg3kKvQujaz3i3pw21
 cYS7EEQDnxUDbmIlgogBtKvbrtoy+u1r4mFFPGHX109wqhnI7co3fjSyyUD92oECdTuys4PwD
 w+ofhkA5pek+ObnCUvmjvTKQxmQSADEJmyKh4zo/gxUmim1kZegbinfGzQJEhYSSfXuqY4g6t
 njgRmLRgMkTRa8rNdDjtAdjY5VIwDANhamN/v7LjgY1+E+JEszROSmQkUkIpTUPXYhYLEjqLj
 RZ7xsL7t2hFb3ZZEbuvapQEVFCpr7ZLAoKFyOQDL2gX7hrQLfIo4Sd5TWPoNn6kkGcznqDWNE
 sxWrnvNTEc/I7OJdgSjSEutcNVTZV3K40b/RISCUIztwiD2/wnNSPZNQnHS7GPulRrZ9pLIy5
 +yA5QnXZG+HRl5eUQc65ZUQP6HqgX0LfTqWRexjFVGEPdAUPa32YzbPOkhwhpkfwC0lIo9EO2
 c1lXBou1nI+7qt5HE7VXoooIL07xV6vSVQPud6L+oNTPQ=

Am 11.04.24 um 22:30 schrieb Armin Wolf:

> Am 10.04.24 um 16:29 schrieb Mikael Lund Jepsen:
>
>> On 9. april 2024 Armin Wolf wrote:
>>> To: Mikael Lund Jepsen <mlj@danelec.com>;
>>> rafael.j.wysocki@intel.com; lenb@kernel.org
>>> Cc: jdelvare@suse.com; linux@roeck-us.net; linux@weissschuh.net;
>>> ilpo.jarvinen@linux.intel.com; linux-acpi@vger.kernel.org;
>>> linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> platform-driver-x86@vger.kernel.org
>>> Subject: [PATCH v2] ACPI: fan: Add hwmon support
>>>
>>> Caution: External email. Do not click links or open attachments
>>> unless you recognize the sender and know the content is safe.
>>>
>>>
>>> Currently, the driver does only support a custom sysfs to allow
>>> userspace to read the fan speed.
>>> Add support for the standard hwmon interface so users can read the
>>> fan speed with standard tools like "sensors".
>>>
>>> Compile-tested only.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>> Changes since v1:
>>> - fix undefined reference error
>>> - fix fan speed validation
>>> - coding style fixes
>>> - clarify that the changes are compile-tested only
>>> - add hwmon maintainers to cc list
>>>
>>> The changes will be tested by Mikael Lund Jepsen from Danelec and
>>> should be merged only after those tests.
>>> ---
>>> drivers/acpi/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> drivers/acpi/fan.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++
>>> drivers/acpi/fan_core.c=C2=A0 |=C2=A0 4 ++
>>> drivers/acpi/fan_hwmon.c | 83 ++++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 97 insertions(+)
>>> create mode 100644 drivers/acpi/fan_hwmon.c
>>>
>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile index
>>> d69d5444acdb..c272ab2c93b9 100644
>>> --- a/drivers/acpi/Makefile
>>> +++ b/drivers/acpi/Makefile
>>> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)=C2=A0 +=3D
>>> tiny-power-button.o
>>> obj-$(CONFIG_ACPI_FAN)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D fan.o
>>> fan-objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=
=3D fan_core.o
>>> fan-objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D fan_attr.o
>>> +fan-$(CONFIG_HWMON)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +=3D fan_hwmon.o
>>>
>>> obj-$(CONFIG_ACPI_VIDEO)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D vide=
o.o
>>> obj-$(CONFIG_ACPI_TAD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D acpi_tad.o
>>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h index
>>> e7b4b4e4a55e..97863bdb6303 100644
>>> --- a/drivers/acpi/fan.h
>>> +++ b/drivers/acpi/fan.h
>>> @@ -10,6 +10,8 @@
>>> #ifndef _ACPI_FAN_H_
>>> #define _ACPI_FAN_H_
>>>
>>> +#include <linux/kconfig.h>
>>> +
>>> #define ACPI_FAN_DEVICE_IDS=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"INT3404", }, /* Fan */ \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"INTC1044", }, /* Fan for =
Tiger Lake generation */ \ @@
>>> -56,4 +58,11 @@ struct acpi_fan {=C2=A0 int acpi_fan_get_fst(struct
>>> acpi_device *device, struct acpi_fan_fst *fst);=C2=A0 int
>>> acpi_fan_create_attributes(struct acpi_device *device);=C2=A0 void
>>> acpi_fan_delete_attributes(struct acpi_device *device);
>>> +
>>> +#if IS_REACHABLE(CONFIG_HWMON)
>>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device); #else
>>> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device
>>> +*device) { return 0; }; #endif
>>> +
>>> #endif
>>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c index
>>> ff72e4ef8738..7cea4495f19b 100644
>>> --- a/drivers/acpi/fan_core.c
>>> +++ b/drivers/acpi/fan_core.c
>>> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct
>>> platform_device *pdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (result)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn result;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 result =3D devm_acpi_fan_create_hwmon(device);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (result)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res=
ult;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 result =3D acpi_fan_create_attributes(device);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (result)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn result;
>>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c new
>>> file mode 100644 index 000000000000..b01055432ded
>>> --- /dev/null
>>> +++ b/drivers/acpi/fan_hwmon.c
>>> @@ -0,0 +1,83 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
>>> + *
>>> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>=C2=A0 */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/limits.h>
>>> +
>>> +#include "fan.h"
>>> +
>>> +/* Returned when the ACPI fan does not support speed reporting */
>>> +#define FAN_SPEED_UNAVAILABLE=C2=A0 0xffffffff
>>> +
>>> +static umode_t acpi_fan_is_visible(const void *drvdata, enum
>>> hwmon_sensor_types type, u32 attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int channel) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0444;
>>> +}
>>> +
>>> +static int acpi_fan_read(struct device *dev, enum
>>> hwmon_sensor_types type, u32 attr, int channel,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long=
 *val)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_device *adev =3D dev=
_get_drvdata(dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_fan_fst fst;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (type) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case hwmon_fan:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D acpi_fan_get_fst(adev, &fst);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 switch (attr) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 case hwmon_fan_input:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fst.sp=
eed =3D=3D FAN_SPEED_UNAVAILABLE)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODATA;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fst.sp=
eed > LONG_MAX)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOVERFLOW;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D f=
st.speed;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 case hwmon_fan_fault:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D (=
fst.speed =3D=3D FAN_SPEED_UNAVAILABLE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static const struct hwmon_ops acpi_fan_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .is_visible =3D acpi_fan_is_visi=
ble,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read =3D acpi_fan_read,
>>> +};
>>> +
>>> +static const struct hwmon_channel_info * const acpi_fan_info[] =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HWMON_CHANNEL_INFO(fan, HWMON_F_=
INPUT | HWMON_F_FAULT),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>>> +};
>>> +
>>> +static const struct hwmon_chip_info acpi_fan_chip_info =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ops =3D &acpi_fan_ops,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .info =3D acpi_fan_info,
>>> +};
>>> +
>>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *hdev;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdev =3D devm_hwmon_device_regis=
ter_with_info(&device->dev,
>>> "acpi_fan", device,
>>> + &acpi_fan_chip_info,
>>> + NULL);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR_OR_ZERO(hdev);
>>> +}
>>> --
>>> 2.39.2
>>>
>> Sorry about the delay, new to ACPI and needed to create the missing
>> tables to define the fan as an ACPIv4 fan and make it talk to the
>> pse/eclite firmware.
>>
>> I've tested patch v2 on kernel 6.6.15 on my Intel ElkhartLake CRB
>> board, and it works fine for me:
>> Fan tacho value is shown correctly and FAULT is reported if
>> ishtp_eclite driver is not loaded.
>>
>> For reference, my test setup:
>> - Intel ElkhartLake CRB board w/ Intel Atom x6425RE
>> - Slimbootloader: Intel MR7 release, with custom ACPI definitions for
>> the fan, and If I remember correctly, I also needed to correct some
>> TGPIO softstraps compared to release defaults
>> - PseFW: Intel MR7 release, with fixes to enable TGPIO/Tacho reading
>> (which was not enabled in release defaults) and to make sure tacho
>> value is read even when fan is turning off (default PSE FW skipped
>> reading tacho if control value was 0, so last tacho value read while
>> fan was turned on would persist).
>>
>> One thing that occurred to me: The fan control value is reported in
>> _FST, but not used in acpi-fan, so how can we flag an error in hwmon
>> if the fan is broken, but shall not always be running?
>> If the control value was exported, then we can alert if tacho is zero
>> when control > 0. I think I'm missing something here?
>>
>> Thanks,
>> Mikael
>
> You are right, i can expose the target RPM as fan1_target when the fan
> is not in fine-grained control mode (otherwise there is no guarantee
> that each
> control value has an associated fan state entry).
>
> This way, userspace can detect when the fan is stuck. I will send a v3
> soon.
>
> Armin Wolf
>
I just noticed that the drvdata argument of the is_visible callback is mar=
ked as const, so i cannot use dev_get_drvdata() on the resulting ACPI devi=
ce.
Guenter, would it be ok to make drvdata non-const in a separate patch seri=
es?

Thanks,
Armin Wolf


