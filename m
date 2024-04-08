Return-Path: <linux-kernel+bounces-135733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DF89CA89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963061F256C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C397143860;
	Mon,  8 Apr 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NkNa6mbG"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8017142906;
	Mon,  8 Apr 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596386; cv=none; b=R/fGVYKff7cHmcsa7c8eKCfhle9NfFEHhsEOawBMJO+TiNloVFwK0moFVetq2ibROe7YqDYV0fQ8QTYoAzm28blucZPMsgwf7ZGZ4Zgcm2y/Rdz7xBi2GTGfFdhl0MNmCTFyKeNTGMgGANF2VK8d62xiUBd3gjoYeVsgpHHBWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596386; c=relaxed/simple;
	bh=PH2JDJUTyiHRlspOyTKRjku5e8+XEyaorY9RlSSno5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoDEyiFH0BZyiR4FGjCa82wg3zow1kNYpM8EsjM3t2HlpgcuasE/aTJr3tDRb9J5USOyicC5nYDBCqR51VGlTBGguAQbjLa7cm+F3T2dq61EdiBy/SZNy7nDXLbx0Y+I+F9rnizumWm0j7F3dmea84dAuuWSy33izgdBs45u7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NkNa6mbG; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712596367; x=1713201167; i=w_armin@gmx.de;
	bh=pUYmKPFI3akZrYQm/aEBEJru3t4cnDbeDUCTwAxxSmY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=NkNa6mbGnIDH/yuJBWHP+7OlssJ90RYjdQb+sFqph5dbsVdXSunOxtbkPRkKbO4S
	 iO+VsDEsxXHqvT1GCgMtX16PvEQlTBsEGy2LJIrJsZvrhrSAUm76nr+g3EZMfSO+/
	 9dIUwC7rLi/A1u8B+PnNkAm0iC+KUljKwr0mEfmCziagsu24S68BQV0McXNxo0w4w
	 Y44gALdxS+h4yl3gEb74uQwu5/6Hr/Mghto47oTZe0dIvlqUIAU1ujhzeAMdFq7rj
	 JpZec7fH77oe5eQJKKpjHvdT455mSMON67v6636QDlmzVoHjHA7f5tG5h6EmXGVLz
	 XzQtFqwHTJMi9jYZLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1rpUpr3aAi-004UWn; Mon, 08
 Apr 2024 19:12:47 +0200
Message-ID: <36a8ebff-8a89-44e0-9b30-374913bd8cbd@gmx.de>
Date: Mon, 8 Apr 2024 19:12:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: fan: Add hwmon support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240408123718.15512-1-W_Armin@gmx.de>
 <63187b48-7978-3b0f-0526-79afea65c492@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <63187b48-7978-3b0f-0526-79afea65c492@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GoT5ZxNeKtIdD3fxEu6U9a/CTJ4Q3wxU+NMlivRTRSBofK/kh3N
 K0rdPhgfHm63zBrWoFBmDSPcYGkR34LRxr7QzffmGXQ0q3OXsCDs0j2NNHIvJMmF+byCRa+
 2zSoQuZ5PYPWirRAe+RF223Ua91fY+JM0Fu+47nTdkvPN0zub6u2L/v6KveYJOZyHPq9Hyf
 7DtO8qHwmu0nIcCao4NIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LpVhQkJKUIE=;yDTytv9Lc9Lsx3fxIXf2oq64Q3c
 U9wAWjv4/xVBdkW3WMk2P/nKeKjewfIp8nEYieFPCGLNg3YCPH9KY7ByQbaX4NkuaUisUNGcq
 XiWUwQuCQoUoT1lrLwKYLVm0c298B7oXfkYINgg6kGN3hdfXuhn6k6fuloN3NrMIGmuDhU8V+
 0g1BhxvOh1Smaz7rT+IYaPRrMEBOnFgkzvZ1mKAkCSTwzjnrOh+3rzfCzbvSvPy/pr0xUrMoL
 8ETXBuRbnePO2u8ZXHFdAUl2Q5Oh8E2l0VSPdUc7x3R+eUOb5FJ3MM/18G8THJ+rqWJTgxNnv
 mkGe5sMT5VwVSPj45DzuAgRGV9rHUkdHm4fODBoBxnnddhjWzqtpGtQl0tXTH2t9DUgt5mk/B
 ZOkM34QrbgGdV5jiSA92LgwP4OaALUV67xVWjx81Ul97ZC2JmoMUDPLQ0F+G88jmFZpSWSBKd
 Sd3AvhfRgn0GUwXtK0tYfW7DaDtUMFv0D+gqnhuznWRhu9nmXID6lvS6mL5pIWMJrlJrvSgJr
 89CL0rxG/mrwmoy/r70DGLiIiIgPaoLu/JsMo/fpc1MtwV7xo3qNZS+3/7zZx4P2aR4CLejL3
 vpflG56SG0jFZu1RlxzgQOUBck26rp7/7hUKZaWrbbrAwXhptt7QDvG102UNqT+Wz9bXWkdiP
 qf8oYwwY+HdKkzyuKGF8XNpaDKBZl1o9Qta2k3o6wLDTlSQ46DeT47bxWy9lUiSMxVVC6gw1I
 yw1P0WlFVZMThWCIyIULhSZsgIqvqtrDXkqt70wZ+8FVa4l2GfumaXgtf7zpVkSd991hq7zoK
 f8Gc7B1hs2qsa70gADkPRdiOSYR+eKDFh1aegvhkU4c9c=

Am 08.04.24 um 17:48 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 8 Apr 2024, Armin Wolf wrote:
>
>> Currently, the driver does only supports a custom sysfs
>> interface to allow userspace to read the fan speed.
>> Add support for the standard hwmon interface so users
>> can read the fan speed with standard tools like "sensors".
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/acpi/Makefile    |  1 +
>>   drivers/acpi/fan.h       |  2 ++
>>   drivers/acpi/fan_core.c  |  7 ++++
>>   drivers/acpi/fan_hwmon.c | 78 +++++++++++++++++++++++++++++++++++++++=
+
>>   4 files changed, 88 insertions(+)
>>   create mode 100644 drivers/acpi/fan_hwmon.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index d69d5444acdb..9a2e03acc1be 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+=3D tiny-power-=
button.o
>>   obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
>>   fan-objs			:=3D fan_core.o
>>   fan-objs			+=3D fan_attr.o
>> +fan-objs			+=3D fan_hwmon.o
>>
>>   obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
>>   obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
>> index e7b4b4e4a55e..45c2637566da 100644
>> --- a/drivers/acpi/fan.h
>> +++ b/drivers/acpi/fan.h
>> @@ -56,4 +56,6 @@ struct acpi_fan {
>>   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst =
*fst);
>>   int acpi_fan_create_attributes(struct acpi_device *device);
>>   void acpi_fan_delete_attributes(struct acpi_device *device);
>> +
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
>>   #endif
>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>> index ff72e4ef8738..6bbdbb914e95 100644
>> --- a/drivers/acpi/fan_core.c
>> +++ b/drivers/acpi/fan_core.c
>> @@ -7,6 +7,7 @@
>>    *  Copyright (C) 2022 Intel Corporation. All rights reserved.
>>    */
>>
>> +#include <linux/kconfig.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>> @@ -336,6 +337,12 @@ static int acpi_fan_probe(struct platform_device *=
pdev)
>>   		if (result)
>>   			return result;
>>
>> +		if (IS_REACHABLE(CONFIG_HWMON)) {
>> +			result =3D devm_acpi_fan_create_hwmon(device);
>> +			if (result)
>> +				return result;
>> +		}
>> +
>>   		result =3D acpi_fan_create_attributes(device);
>>   		if (result)
>>   			return result;
>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
>> new file mode 100644
>> index 000000000000..4f2bec8664f4
>> --- /dev/null
>> +++ b/drivers/acpi/fan_hwmon.c
>> @@ -0,0 +1,78 @@
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
>> +
>> +#include "fan.h"
>> +
>> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sen=
sor_types type, u32 attr,
>> +				   int channel)
>> +{
>> +	return 0444;
>> +}
>> +
>> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types t=
ype, u32 attr, int channel,
>> +			 long *val)
>> +{
>> +	struct acpi_device *adev =3D dev_get_drvdata(dev);
>> +	struct acpi_fan_fst fst;
>> +	int ret;
>> +
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		ret =3D acpi_fan_get_fst(adev, &fst);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +			if (fst.speed > LONG_MAX)
>> +				return -EOVERFLOW;
>> +
>> +			*val =3D fst.speed;
>> +			return 0;
>> +		case hwmon_fan_fault:
>> +			*val =3D (fst.speed =3D=3D U32_MAX);
>> +			return 0;
> Is it okay to return 0 in this case?

Hi,

i think so, since the value of the attribute (with the meaning of "is the =
rpm value ok?") is being
correctly stored in val. If acpi_fan_get_fst() fails, we already return a =
negative error code.

Thanks,
Armin Wolf

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
>> +static const struct hwmon_ops acpi_fan_ops =3D {
>> +	.is_visible =3D acpi_fan_is_visible,
>> +	.read =3D acpi_fan_read,
>> +};
>> +
>> +static const struct hwmon_channel_info * const acpi_fan_info[] =3D {
>> +	HWMON_CHANNEL_INFO(fan,
>> +			   HWMON_F_INPUT | HWMON_F_FAULT),
> One line.
>

