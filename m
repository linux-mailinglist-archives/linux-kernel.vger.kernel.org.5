Return-Path: <linux-kernel+bounces-141578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04078A203D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1A1C21C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056971863F;
	Thu, 11 Apr 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="r7x0UkKB"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032410F4;
	Thu, 11 Apr 2024 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867469; cv=none; b=Rg3si3mKGtBop82knAkiu6e2tfKRJBDIRoVgcS4EZt5QDRmi8UODtBz2SbS/4/wf9FvsSqJ3rpIXcEN2HJ8rm8U3joGLiOOxF8cLV7hqXV1hU6HZFHe+o+WqJIA4yYfWf+XGi0FJ1PRRmwT6/M3L2g02Q0s0ZdJVsNpAwL9PDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867469; c=relaxed/simple;
	bh=XLRJW2ZB09sUuOk5sq/VDVa44LgLk0RFkOhWlRAKK5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c71uQWY/7RDfFpRFtLcwgnvGupIJ2h3j52//x4e9q5BSIMVCeJ1rl1S/RhoCsbOzTFqPmDPwGyJ+iLBOgWtRydb1QFKAV0rAGhzGVE2XfYHuhduVQVWt2RLs+kk7pA5xb9Pzobryf4P9o5pQSGkIcJbTtS3wboOYg83zzX0hbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=r7x0UkKB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712867437; x=1713472237; i=w_armin@gmx.de;
	bh=Cij3AeZGYu6aG/SAd+mnAwUkSz1egYOxzve/K/jk1Z4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=r7x0UkKBIqUOwviGy+2yTXjeKJAV472IC0Y58HpMeeaKo9lrVS4x8U4X7BSBak6x
	 FmNM5NKUuo8R+6bs5F58IpwJJBWYe6FPDz2n1Bd9aZiy+MAc0XGekqquTfFYX4GOe
	 3U/ghQ8+fFYuBkuursMbUJuZ7MZSmRNeAJfeCtewEUtsUMuNF2TsyfgLGegbd8Iy5
	 ZZRGKZfXKxWcogLzpibUu8tkFvETAxWDYKndEVtuxT5QK26I7U0lRy0/jgnNNuL3Y
	 28R8I5qGML2lxsznJ0GB87bCSBUSBWm5I61VQp8UMmYyLAg6DxfYwkogv+6EYn6Td
	 fppcaRE4sw3yBiAVnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1sBiZF3jRd-00LBYD; Thu, 11
 Apr 2024 22:30:36 +0200
Message-ID: <e6798f0a-5e50-41df-ae3e-0069c16abec3@gmx.de>
Date: Thu, 11 Apr 2024 22:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: fan: Add hwmon support
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <AS4P189MB21333C826C173582E12FFE3EBA062@AS4P189MB2133.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1ktiJxlRATIUneiyuUOzEf6NVEWI8XpAsyEN5g6CIa6TFDn5bHM
 3VvfTpcs5/My0i5sY+TO61nQ+8Yk6wWmsnXgVIRyrWq8r+3iKH+S1suXY2xr6KIFBZDVobz
 up77017ZGH5eUrCOHy+p4B967EWOc/ZHhv1Yh07HGCKkhTpN03+WGUblkxTzxpnyxt4zHw3
 RZQgFBeB2c5m8DD7umH2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fnyKa2+Bszw=;GZBkD6zupS4we5/1YF2LXmlSgoP
 kxTgmVPYTRWEHeDs4Lvdti2N4vJyo8wVeF01Tr6oiyFEq7kqzqHWSRT4kXtB69eFyISu2/6Q+
 OtM24k3f917NmrfCHEHvgqEcdFEr6xw/gCHgX+PO+/ijJ0L+E+pcC/LuSqGoVGZ9jczqiF7aD
 1TcjF69gYRvSz4q88M49qVausaD479KHaullZdFFpXiIgIKwmfHnvM10su438rsJ1chVGqo9Z
 8+DsN7YS1RNn2zC8QQb/kh06I+WeDsMSR55WuJyMtZ4h6J+e5if58aKSQpjktG/tL3UngbWKl
 IssAHV6PR5msZ14PjVDLlMhVm7oYgpOn6lmWQHWr1FUG8sCVRwYhSXrPls/D9ga0CS6jK/1f2
 wknatvGPt6gFdQ0YApyCXmJ/eaoHriqY2ZNT20VSIi19h9zUuiqqhJSqikChsvwnFntYSEWuW
 RKa5Cjvh5It0OI3y8bAAHBIfEx76RrgQ5iNCme6uGWvgQ2YEhiChak4p1RQjwijhdBvI4JFmE
 Y6E/FuUEvqbqaXhP03jdRxTZOhuW0qzuQy3FWdyGC9OkIrXz3ccs8Hhap+hlCSVy1GG0BEYUd
 PImtzdQSVmhJSRQAWpIMiv8SR4z6SLrKZWDrwokJUp0QxF5qT0/5ImEkK9iHbnBjEAHqZLFuI
 CA3e4uWH5nLRkbZUKC3WXy7COfpbbmr5ecNxLM4DSdcLCUERNi8v1JYf3MwvNDBVMuCxkmC+0
 /F0GqDqnddcqNdJuKYkLClXWBA30CGgdBrWLUThoHkpJgTO2ApkbuRfpVD+0s6ZCQ/QZGxzMQ
 OmxCe+S6uhr0eHk1zyqMzvULId2aTeDw52z/ElC+NakwY=

Am 10.04.24 um 16:29 schrieb Mikael Lund Jepsen:

> On 9. april 2024 Armin Wolf wrote:
>> To: Mikael Lund Jepsen <mlj@danelec.com>; rafael.j.wysocki@intel.com; lenb@kernel.org
>> Cc: jdelvare@suse.com; linux@roeck-us.net; linux@weissschuh.net; ilpo.jarvinen@linux.intel.com; linux-acpi@vger.kernel.org; linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
>> Subject: [PATCH v2] ACPI: fan: Add hwmon support
>>
>> Caution: External email. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> Currently, the driver does only support a custom sysfs to allow userspace to read the fan speed.
>> Add support for the standard hwmon interface so users can read the fan speed with standard tools like "sensors".
>>
>> Compile-tested only.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes since v1:
>> - fix undefined reference error
>> - fix fan speed validation
>> - coding style fixes
>> - clarify that the changes are compile-tested only
>> - add hwmon maintainers to cc list
>>
>> The changes will be tested by Mikael Lund Jepsen from Danelec and should be merged only after those tests.
>> ---
>> drivers/acpi/Makefile    |  1 +
>> drivers/acpi/fan.h       |  9 +++++
>> drivers/acpi/fan_core.c  |  4 ++
>> drivers/acpi/fan_hwmon.c | 83 ++++++++++++++++++++++++++++++++++++++++
>> 4 files changed, 97 insertions(+)
>> create mode 100644 drivers/acpi/fan_hwmon.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile index d69d5444acdb..c272ab2c93b9 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)  += tiny-power-button.o
>> obj-$(CONFIG_ACPI_FAN)         += fan.o
>> fan-objs                       := fan_core.o
>> fan-objs                       += fan_attr.o
>> +fan-$(CONFIG_HWMON)            += fan_hwmon.o
>>
>> obj-$(CONFIG_ACPI_VIDEO)       += video.o
>> obj-$(CONFIG_ACPI_TAD)         += acpi_tad.o
>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h index e7b4b4e4a55e..97863bdb6303 100644
>> --- a/drivers/acpi/fan.h
>> +++ b/drivers/acpi/fan.h
>> @@ -10,6 +10,8 @@
>> #ifndef _ACPI_FAN_H_
>> #define _ACPI_FAN_H_
>>
>> +#include <linux/kconfig.h>
>> +
>> #define ACPI_FAN_DEVICE_IDS    \
>>         {"INT3404", }, /* Fan */ \
>>         {"INTC1044", }, /* Fan for Tiger Lake generation */ \ @@ -56,4 +58,11 @@ struct acpi_fan {  int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);  int acpi_fan_create_attributes(struct acpi_device *device);  void acpi_fan_delete_attributes(struct acpi_device *device);
>> +
>> +#if IS_REACHABLE(CONFIG_HWMON)
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device); #else
>> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device
>> +*device) { return 0; }; #endif
>> +
>> #endif
>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c index ff72e4ef8738..7cea4495f19b 100644
>> --- a/drivers/acpi/fan_core.c
>> +++ b/drivers/acpi/fan_core.c
>> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>                 if (result)
>>                         return result;
>>
>> +               result = devm_acpi_fan_create_hwmon(device);
>> +               if (result)
>> +                       return result;
>> +
>>                 result = acpi_fan_create_attributes(device);
>>                 if (result)
>>                         return result;
>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c new file mode 100644 index 000000000000..b01055432ded
>> --- /dev/null
>> +++ b/drivers/acpi/fan_hwmon.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
>> + *
>> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>  */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/limits.h>
>> +
>> +#include "fan.h"
>> +
>> +/* Returned when the ACPI fan does not support speed reporting */
>> +#define FAN_SPEED_UNAVAILABLE  0xffffffff
>> +
>> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>> +                                  int channel) {
>> +       return 0444;
>> +}
>> +
>> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
>> +                        long *val)
>> +{
>> +       struct acpi_device *adev = dev_get_drvdata(dev);
>> +       struct acpi_fan_fst fst;
>> +       int ret;
>> +
>> +       switch (type) {
>> +       case hwmon_fan:
>> +               ret = acpi_fan_get_fst(adev, &fst);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               switch (attr) {
>> +               case hwmon_fan_input:
>> +                       if (fst.speed == FAN_SPEED_UNAVAILABLE)
>> +                               return -ENODATA;
>> +
>> +                       if (fst.speed > LONG_MAX)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val = fst.speed;
>> +                       return 0;
>> +               case hwmon_fan_fault:
>> +                       *val = (fst.speed == FAN_SPEED_UNAVAILABLE);
>> +                       return 0;
>> +               default:
>> +                       break;
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct hwmon_ops acpi_fan_ops = {
>> +       .is_visible = acpi_fan_is_visible,
>> +       .read = acpi_fan_read,
>> +};
>> +
>> +static const struct hwmon_channel_info * const acpi_fan_info[] = {
>> +       HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT),
>> +       NULL
>> +};
>> +
>> +static const struct hwmon_chip_info acpi_fan_chip_info = {
>> +       .ops = &acpi_fan_ops,
>> +       .info = acpi_fan_info,
>> +};
>> +
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device) {
>> +       struct device *hdev;
>> +
>> +       hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", device,
>> +                                                   &acpi_fan_chip_info,
>> + NULL);
>> +
>> +       return PTR_ERR_OR_ZERO(hdev);
>> +}
>> --
>> 2.39.2
>>
> Sorry about the delay, new to ACPI and needed to create the missing tables to define the fan as an ACPIv4 fan and make it talk to the pse/eclite firmware.
>
> I've tested patch v2 on kernel 6.6.15 on my Intel ElkhartLake CRB board, and it works fine for me:
> Fan tacho value is shown correctly and FAULT is reported if ishtp_eclite driver is not loaded.
>
> For reference, my test setup:
> - Intel ElkhartLake CRB board w/ Intel Atom x6425RE
> - Slimbootloader: Intel MR7 release, with custom ACPI definitions for the fan, and If I remember correctly, I also needed to correct some TGPIO softstraps compared to release defaults
> - PseFW: Intel MR7 release, with fixes to enable TGPIO/Tacho reading (which was not enabled in release defaults) and to make sure tacho value is read even when fan is turning off (default PSE FW skipped reading tacho if control value was 0, so last tacho value read while fan was turned on would persist).
>
> One thing that occurred to me: The fan control value is reported in _FST, but not used in acpi-fan, so how can we flag an error in hwmon if the fan is broken, but shall not always be running?
> If the control value was exported, then we can alert if tacho is zero when control > 0. I think I'm missing something here?
>
> Thanks,
> Mikael

You are right, i can expose the target RPM as fan1_target when the fan is not in fine-grained control mode (otherwise there is no guarantee that each
control value has an associated fan state entry).

This way, userspace can detect when the fan is stuck. I will send a v3 soon.

Armin Wolf


