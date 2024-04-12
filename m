Return-Path: <linux-kernel+bounces-143310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A148A3710
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C0B2148C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BA1514D1;
	Fri, 12 Apr 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Tp3aQNg+"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD03D548;
	Fri, 12 Apr 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953710; cv=none; b=Or9rnzaztGbhE5NgFKEgXN/OUk4CqlgnSsZRtIlbbiR83tcBMBrMz0v0FLUsjmhv0NAie6qbzis2r/PW61eBbm1zcGpNiXAcwmfiKJihgB44RVhL5JBo5aZ8wIu9Q3ASqAJpq3oUk+pP25NOu5owYWvd7UK8bifFIAmjf4k+Uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953710; c=relaxed/simple;
	bh=NML7HhIB7sL0A36qRIddtkSdJWpp+SzmL65TZpkRlKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHRK5pLtsXHb2nIW4okz4EXXAF2udrpDyM8GjQD9pAhFrHMOpoDl72vQ3YHJxOfdByDX9OQWdVHzHN6NRgbKPUBAtglKWtEtmAUx1st0JZKkkSZvPVOlxwqIksTIc+K52R6sKK/+suUlWEn+E744wP+dlNXUj+Ag+vObM/7Lr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Tp3aQNg+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712953678; x=1713558478; i=w_armin@gmx.de;
	bh=KyrgF+nYVVGWGNPHCPiikXqSh6HW9OZuxDd/Wnzjqs8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Tp3aQNg+RoSJMgnCvSy3mayID1O5o7v45xQ+S1xwEOZgoMthSHXPfhN0QyYkGHC0
	 QZ1yaFSGX+wmVfX+b4osItS9PCghOqCD6i8A456aBEI02A8UY7qH43xmlGgX1LHFU
	 PPL2cQ3QMOM7wwEl/XTYaLwTRI54e/HTzPdSbrvNR7w4rsusCsHudcEAlxMROXxIG
	 XtWeYp5nRVt0KlQ0AufzNrjrZIAE7irBz756xG60S+21i9Zf7WTj2F7DoYpCkbBcL
	 gQN7lYGhrw1/guhwu4ud9c3kypXxHXDsKuf/KmiBeQXju9lAkg5B0FLbtnoAI3ZZI
	 MhCTKbNifNTp8TJBug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1psI-1rtAZi2HJw-002Ec0; Fri, 12
 Apr 2024 22:27:58 +0200
Message-ID: <aace96e3-8645-469b-9056-0199af9d220c@gmx.de>
Date: Fri, 12 Apr 2024 22:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: fan: Add hwmon support
To: Guenter Roeck <linux@roeck-us.net>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 jdelvare@suse.com, linux@weissschuh.net, ilpo.jarvinen@linux.intel.com,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240412160857.79858-1-W_Armin@gmx.de>
 <20240412160857.79858-2-W_Armin@gmx.de>
 <4a07f4d1-bbee-445c-a7cc-377506de850d@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4a07f4d1-bbee-445c-a7cc-377506de850d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zKcBohe/ud71onOWhcUnYbRcZBehHVNM8Ttx98F9FAdlELN/jSM
 +A+4oYzhwfwzHzJraDZnae+u5Jo3c3Phrf2bjAQoraHzFongnGP0LJsMv2Wh931Ve8s8FNp
 1+Hae2BtHHYhF5zpZf3hasNT6lWMeu0J/n8zic1SXf1m0LJHgAHAR09ChVuhmehcc1U/DcY
 54jcgyaTqiAd1iipS9eiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jIisPhg1bxc=;ffneigWqNJ8AfAYT0r9Ne9T/GIm
 PdlybKldVl47aUlpjIywa6Veazq408nv9rvvDVLxe8sZZF9IrQvZNTuJSPlZGKAbDcKfiZAkk
 m02V7XNBOovblSOLEZMIr7sPLury3XNsMzhrg2SwTMXLetOFWptHS9Zzan+0UU8parfrGar7g
 6zejkxo1TPr/iZ5E6m2EZZ2CYq0nSmnVFsCozWvUiAYwSOistrQe6GhxMkHKxFCCfrq1Uz3ck
 Pnxfp7L6ldch1tFmlVOdejWtsNfrs6m74JA4b5TZ7qeJnuJBLL1XTpUx+ViYjBOQdtXswFCXR
 ZaRTyV6S3K9mr/A6I5o9rtPeqGe4QCdS7TDUYwTuC9fmsVQz5JX5Eodeosu1ZxqiGBMqIm7zQ
 2I6VlP8oSeXFpwZAb3TVCI3BPJX3atW59u5Jx4wwauIyDuCRQ/nCILQqUGemeVjnRmn7VWCwS
 ut7yUK3qmPrHM9KGDI5yqL6S9TtYgSAHW0P+lwNvrMEXJV0A0lEcPkXKIVKxLIIjcA/9gNY0u
 oqYiSrOfXuxBM3qvfRTRUokTaWyfAG4L0dd3b2WnRbn6zJ8tjq9ox3zt18NMZ54ej+b/Y2zbk
 PQ5pCdb4QnZ82hnEQRDxDk/xvZJME35Ms0I80PPvom0o3qMiI2cCkuOaK1kbHtt7ynS/BOdG2
 rSaCOqUA/pyWk0ccBgCDFywtDYxg2yfILV0IWmlma9LFBgUSinQR6NRnwHIo/B/MbS9NFkpBO
 tJvBrblu7rEIDmGoXYZb7N4zIuLkUG5izH/f9Zq/AfEEWeBubpbtMM7Nswfs2fThpZTaCmBRQ
 Y9WqBXwa3fjsQh2AhTLaNqeVNsj2udLdvGcd53DKdGU6I=

Am 12.04.24 um 18:41 schrieb Guenter Roeck:

> On Fri, Apr 12, 2024 at 06:08:57PM +0200, Armin Wolf wrote:
>> Currently, the driver does only support a custom sysfs
>> to allow userspace to read the fan speed.
>> Add support for the standard hwmon interface so users
>> can read the fan speed with standard tools like "sensors".
>>
>> Compile-tested only.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes since v2:
>> - add support for fanX_target and power attrs
>>
>> Changes since v1:
>> - fix undefined reference error
>> - fix fan speed validation
>> - coding style fixes
>> - clarify that the changes are compile-tested only
>> - add hwmon maintainers to cc list
>>
>> The changes will be tested by Mikael Lund Jepsen from Danelec and
>> should be merged only after those tests.
>> ---
>>   drivers/acpi/Makefile    |   1 +
>>   drivers/acpi/fan.h       |   9 +++
>>   drivers/acpi/fan_core.c  |   4 ++
>>   drivers/acpi/fan_hwmon.c | 148 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 162 insertions(+)
>>   create mode 100644 drivers/acpi/fan_hwmon.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 39ea5cfa8326..61ca4afe83dc 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
>>   obj-$(CONFIG_ACPI_FAN)		+= fan.o
>>   fan-objs			:= fan_core.o
>>   fan-objs			+= fan_attr.o
>> +fan-$(CONFIG_HWMON)		+= fan_hwmon.o
>>
>>   obj-$(CONFIG_ACPI_VIDEO)	+= video.o
>>   obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
>> index f89d19c922dc..db25a3898af7 100644
>> --- a/drivers/acpi/fan.h
>> +++ b/drivers/acpi/fan.h
>> @@ -10,6 +10,8 @@
>>   #ifndef _ACPI_FAN_H_
>>   #define _ACPI_FAN_H_
>>
>> +#include <linux/kconfig.h>
>> +
>>   #define ACPI_FAN_DEVICE_IDS	\
>>   	{"INT3404", }, /* Fan */ \
>>   	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
>> @@ -57,4 +59,11 @@ struct acpi_fan {
>>   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
>>   int acpi_fan_create_attributes(struct acpi_device *device);
>>   void acpi_fan_delete_attributes(struct acpi_device *device);
>> +
>> +#if IS_REACHABLE(CONFIG_HWMON)
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
>> +#else
>> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) { return 0; };
>> +#endif
>> +
>>   #endif
>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>> index ff72e4ef8738..7cea4495f19b 100644
>> --- a/drivers/acpi/fan_core.c
>> +++ b/drivers/acpi/fan_core.c
>> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>   		if (result)
>>   			return result;
>>
>> +		result = devm_acpi_fan_create_hwmon(device);
>> +		if (result)
>> +			return result;
>> +
>>   		result = acpi_fan_create_attributes(device);
>>   		if (result)
>>   			return result;
>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
>> new file mode 100644
>> index 000000000000..57216ba872db
>> --- /dev/null
>> +++ b/drivers/acpi/fan_hwmon.c
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
>> + *
>> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/limits.h>
>> +#include <linux/units.h>
>> +
>> +#include "fan.h"
>> +
>> +/* Returned when the ACPI fan does not support speed reporting */
>> +#define FAN_SPEED_UNAVAILABLE	0xffffffff
>> +#define FAN_POWER_UNAVAILABLE	0xffffffff
>> +
>> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < fan->fps_count; i++) {
>> +		if (fan->fps[i].control == control)
>> +			return &fan->fps[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>> +				   int channel)
>> +{
>> +	return 0444;
>> +}
>> +
>> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
>> +			 long *val)
>> +{
>> +	struct acpi_device *adev = dev_get_drvdata(dev);
>> +	struct acpi_fan *fan = acpi_driver_data(adev);
>> +	struct acpi_fan_fps *fps;
>> +	struct acpi_fan_fst fst;
>> +	int ret;
>> +
>> +	ret = acpi_fan_get_fst(adev, &fst);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +			if (fst.speed == FAN_SPEED_UNAVAILABLE)
>> +				return -ENODATA;
>> +
>> +			if (fst.speed > LONG_MAX)
>> +				return -EOVERFLOW;
>> +
>> +			*val = fst.speed;
>> +			return 0;
>> +		case hwmon_fan_target:
>> +			fps = acpi_fan_get_current_fps(fan, fst.control);
>> +			if (!fps)
>> +				return -ENODATA;
>> +
>> +			*val = fps->speed;
>> +			return 0;
>> +		case hwmon_fan_fault:
>> +			*val = (fst.speed == FAN_SPEED_UNAVAILABLE);
> Is it documented that this is indeed a fault (broken fan) ?
>
Hi,

it actually means that the fan does not support speed reporting.

>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_power:
>> +		fps = acpi_fan_get_current_fps(fan, fst.control);
>> +		if (!fps)
>> +			return -ENODATA;
>> +
>> +		switch (attr) {
>> +		case hwmon_power_input:
>> +			if (fps->power == FAN_POWER_UNAVAILABLE)
>> +				return -ENODATA;
>> +
>> +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
>> +				return -EOVERFLOW;
>> +
>> +			*val = fps->power * MICROWATT_PER_MILLIWATT;
>> +			return 0;
>> +		case hwmon_power_fault:
>> +			*val = (fps->power == FAN_POWER_UNAVAILABLE);
> Is it documented that this is indeed a power supply failure ?
> What if the value is simply not reported ? "UNAVAILABLE" is not
> commonly associated with a "fault".
>
> Guenter
>
FAN_POWER_UNAVAILABLE signals that the power value is not supported.
Would it be more suitable to drop the fault attributes and just return -ENODATA in such a case?

Thanks,
Armin Wolf

>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct hwmon_ops acpi_fan_ops = {
>> +	.is_visible = acpi_fan_is_visible,
>> +	.read = acpi_fan_read,
>> +};
>> +
>> +static const struct hwmon_channel_info * const acpi_fan_info[] = {
>> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET |  HWMON_F_FAULT),
>> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_FAULT),
>> +	NULL
>> +};
>> +
>> +static const struct hwmon_chip_info acpi_fan_chip_info = {
>> +	.ops = &acpi_fan_ops,
>> +	.info = acpi_fan_info,
>> +};
>> +
>> +static const struct hwmon_channel_info * const acpi_fan_fine_grain_info[] = {
>> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT),
>> +	NULL
>> +};
>> +
>> +static const struct hwmon_chip_info acpi_fan_fine_grain_chip_info = {
>> +	.ops = &acpi_fan_ops,
>> +	.info = acpi_fan_fine_grain_info,
>> +};
>> +
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
>> +{
>> +	struct acpi_fan *fan = acpi_driver_data(device);
>> +	const struct hwmon_chip_info *info;
>> +	struct device *hdev;
>> +
>> +	/* When in fine grain control mode, not every fan control value
>> +	 * has an associated fan performance state.
>> +	 */
>> +	if (fan->fif.fine_grain_ctrl)
>> +		info = &acpi_fan_fine_grain_chip_info;
>> +	else
>> +		info = &acpi_fan_chip_info;
>> +
>> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", device, info, NULL);
>> +
>> +	return PTR_ERR_OR_ZERO(hdev);
>> +}
>> --
>> 2.39.2
>>

