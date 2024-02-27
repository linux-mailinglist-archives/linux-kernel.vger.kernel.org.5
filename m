Return-Path: <linux-kernel+bounces-84141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02186A2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A526D1F22CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96155C08;
	Tue, 27 Feb 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="egkM0PPL"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF15577C;
	Tue, 27 Feb 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074070; cv=none; b=PM5q+bxJD6lMjFa3c+raJY/89j+VlKApTPGjzjaPG/gt1szy26DyOEonCf1UWcMLICSTnsZxzcwZVxTpxoogKFMxrfqKKf/lCfWLyGFOYDxl2CD00+Pz8ldDAD3Ikq/yK7BByDFx5i07LC96nOYASgPwWQOOfiVkOFfS6lmTtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074070; c=relaxed/simple;
	bh=Mko3P7i77ENZaG+5elo5f9SGbArhHj1T5sQVhCwdVeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMG9za3V07DkaMw/dnYGEZnQlWdP6xAQqTdn37XijfaaJJdMS3+7H8q+fXaVtnsa8tO4aqbB7vXrU57QOLtW6zG+kK/dx893z9MPf4tUrZV9hqcuuc3+LfGlt4aDD0j2+I8j6Sib4gP/DexJPFaOx8ZXY/OBORcIoeqqBMEDndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=egkM0PPL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709074033; x=1709678833; i=w_armin@gmx.de;
	bh=Mko3P7i77ENZaG+5elo5f9SGbArhHj1T5sQVhCwdVeU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=egkM0PPLd8/05tm68T7h6/NkMA8hhhp/Qhm2yZLcVJg54MgjE6shmxWg3C4hW+rj
	 HCxUne3/uK0yCB7mnE18fEBJkPqzuerEbaW6bJs/CR4MjQzh7tSXi0BPczkF2L/U0
	 FMrIH3oCrveRc0JzFBkMT8YQKwQjZaOgzMLWtV3ZwRG9QEBRu+4afd5orlpTf1Le5
	 UI/iNo0I65q7EKO4T60SPpNFq34HQmxLcAt9TLTiI7kLuCQBlf9/GSz2kUqE6Ix25
	 I5hrp8kwgnzP6TABPSxjus5HAUfvKxP+LncwQTqROv3HfzyYlvuyh6XGM6Hb27L0T
	 lUuyfefLu0BX043Afg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1rNxyZ1iik-00Yf6e; Tue, 27
 Feb 2024 23:47:13 +0100
Message-ID: <a8602a4a-39e1-46c3-9fe9-b6896c75fa73@gmx.de>
Date: Tue, 27 Feb 2024 23:47:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86: wmi: Do not instantiate older WMI
 drivers multiple times
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: jithu.joseph@intel.com, linux@weissschuh.net, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Dell.Client.Kernel@dell.com,
 jdelvare@suse.com, linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226193557.2888-1-W_Armin@gmx.de>
 <20240226193557.2888-2-W_Armin@gmx.de> <20240227203058.eun4ylvhk4t7uogk@pali>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240227203058.eun4ylvhk4t7uogk@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/G3WZZeaZYFWYPNYZTKKSSZvMiZrBK64gl4UQcg+FgJM7tcYonT
 S6XroZJRai7ek7lDU5FD+5yNZP3uivrtgBoY+leFsG2Yl1OxkE/KfzdsS2ABVinxBS5EvZI
 cIMEswG8HujWhkBe5YSxR5M3h/klT7It3AH/aFcaJhx1yADx+srevIhWIeZVVIJvBoKH3vD
 goghC6RPKIvzgfiIPkw6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yYLqlHSi/Bs=;+rck4siOv6e/ktn87niyzpbMhU/
 SF6v9oGB23HwjMKByynKAeG/mqQUQ+qXI13Qo3ROQ7Ztw+NN6xRlgLijrXR5ZFnQLnjzXUFU+
 0g1Hiea3e+HJBBdAeWXtj73O9ukjrS+6V23+f6aHVVz6ikZhTJXAyUDXKPd5s5cGHwhifkMNL
 uP7vmrq6+DfmaLWb4HygXawhLyJQsIGta/kH1zNmWUOLxBSk89a/6Zx90f09X8oPXvT2Q/gH8
 5aDYTjcuhV/yo5hO3ZzMfGTDf7f/Cbjg3mNhB/ZMZiUSjV4LqoVOD1nqQEmEYCNHuxaKsJHWE
 TNldAI5JyV7oREPBUd3Q9yrlOkojGmaG0+F1eZF4LyL+M9KnSutxK6vYVwAQbydAXSPkGxflw
 Qt5G5otb+kapukb6m1+jdxY35JC7tu7O137AH0uN7kVemkzuHWaye8Q4iR6XNCG6OvAJB8rgS
 dnT9PHQk8H2K4nT8hi0rRnfh2GOlghFePAPSY9+3LKcAGBQUVZWhpmAJRRtpMGrhHF5wm+VR0
 zsszslmEJqvoaKHdc3A9gAHfzjjw4SaI0iT6bYAGUdr7BOkMkXPzHKIAdNiRoEiPk4r44lpvX
 05VYjfLHlpkr8fBfp8k08TY9hMqEyn56IX6K/5IZQQ8SBLZBhXjoJNuMF5kAmN85ufmJ7ymm/
 twhwmtB9k4MjveDIjKxMbVzNSH8QCFeTxf7wMSkrnbwm1XYTp6FyJUmzuY57Qh4ORtp/Jgvwu
 ng8NaKhWe1WgffmE92h1UQ3Wv9nJOiQ6oa3YhjCg9c8fmqnncMjZEmT8roCjmG1JxbN2gz6II
 U27CCwgXne5ESk4syXzMNOnzbFrwaIEoy489LJHKy8SZw=

Am 27.02.24 um 21:30 schrieb Pali Roh=C3=A1r:

> On Monday 26 February 2024 20:35:56 Armin Wolf wrote:
>> Many older WMI drivers cannot be instantiated multiple times for
>> two reasons:
>>
>> - they are using the legacy GUID-based WMI API
>> - they are singletons (with global state)
>>
>> Prevent such WMI drivers from binding to WMI devices with a duplicated
>> GUID, as this would mean that the WMI driver will be instantiated at
>> least two times (one for the original GUID and one for the duplicated
>> GUID).
>> WMI drivers which can be instantiated multiple times can signal this
>> by setting a flag inside struct wmi_driver.
> What do you think about opposite direction? Adding ".singleton =3D true"
> into every driver which is not compatible with duplicated initialization
> and having the default value that drivers are not singletons.
>
> But if the direction it to not accept new "legacy" drivers and start get
> rid of all "legacy" drivers by rewriting them, then it does not matter
> if "no_singleton" or "is_singleton" is used...

Hi,

i want to make sure that i wont forget any legacy WMI drivers. This way, t=
he
older legacy WMI drivers automatically initialize no_singleton with false.

Also i intent to not accept new legacy WMI drivers.

Thanks,
Armin Wolf

>> Tested on a ASUS Prime B650-Plus.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/dell-smm-hwmon.c                 |  1 +
>>   drivers/platform/x86/dell/dell-wmi-ddv.c       |  1 +
>>   drivers/platform/x86/intel/wmi/sbl-fw-update.c |  1 +
>>   drivers/platform/x86/intel/wmi/thunderbolt.c   |  1 +
>>   drivers/platform/x86/wmi-bmof.c                |  1 +
>>   drivers/platform/x86/wmi.c                     | 12 ++++++++++++
>>   include/linux/wmi.h                            |  2 ++
>>   7 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index 6d8c0f328b7b..168d669c4eca 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -1587,6 +1587,7 @@ static struct wmi_driver dell_smm_wmi_driver =3D =
{
>>   	},
>>   	.id_table =3D dell_smm_wmi_id_table,
>>   	.probe =3D dell_smm_wmi_probe,
>> +	.no_singleton =3D true,
>>   };
>>
>>   /*
>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platfor=
m/x86/dell/dell-wmi-ddv.c
>> index db1e9240dd02..0b2299f7a2de 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> @@ -882,6 +882,7 @@ static struct wmi_driver dell_wmi_ddv_driver =3D {
>>   	},
>>   	.id_table =3D dell_wmi_ddv_id_table,
>>   	.probe =3D dell_wmi_ddv_probe,
>> +	.no_singleton =3D true,
>>   };
>>   module_wmi_driver(dell_wmi_ddv_driver);
>>
>> diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/p=
latform/x86/intel/wmi/sbl-fw-update.c
>> index 040153ad67c1..75c82c08117f 100644
>> --- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>> +++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>> @@ -131,6 +131,7 @@ static struct wmi_driver intel_wmi_sbl_fw_update_dr=
iver =3D {
>>   	.probe =3D intel_wmi_sbl_fw_update_probe,
>>   	.remove =3D intel_wmi_sbl_fw_update_remove,
>>   	.id_table =3D intel_wmi_sbl_id_table,
>> +	.no_singleton =3D true,
>>   };
>>   module_wmi_driver(intel_wmi_sbl_fw_update_driver);
>>
>> diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/pla=
tform/x86/intel/wmi/thunderbolt.c
>> index e2ad3f46f356..08df560a2c7a 100644
>> --- a/drivers/platform/x86/intel/wmi/thunderbolt.c
>> +++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
>> @@ -63,6 +63,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver=
 =3D {
>>   		.dev_groups =3D tbt_groups,
>>   	},
>>   	.id_table =3D intel_wmi_thunderbolt_id_table,
>> +	.no_singleton =3D true,
>>   };
>>
>>   module_wmi_driver(intel_wmi_thunderbolt_driver);
>> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi=
-bmof.c
>> index 644d2fd889c0..df6f0ae6e6c7 100644
>> --- a/drivers/platform/x86/wmi-bmof.c
>> +++ b/drivers/platform/x86/wmi-bmof.c
>> @@ -94,6 +94,7 @@ static struct wmi_driver wmi_bmof_driver =3D {
>>   	.probe =3D wmi_bmof_probe,
>>   	.remove =3D wmi_bmof_remove,
>>   	.id_table =3D wmi_bmof_id_table,
>> +	.no_singleton =3D true,
>>   };
>>
>>   module_wmi_driver(wmi_bmof_driver);
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index 29dfe52eb802..349deced87e8 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -883,6 +883,18 @@ static int wmi_dev_probe(struct device *dev)
>>   	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);
>>   	int ret =3D 0;
>>
>> +	/* Some older WMI drivers will break if instantiated multiple times,
>> +	 * so they are blocked from probing WMI devices with a duplicated GUI=
D.
>> +	 *
>> +	 * New WMI drivers should support being instantiated multiple times.
>> +	 */
>> +	if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags) && !wdriver->no_sin=
gleton) {
>> +		dev_warn(dev, "Legacy driver %s cannot be instantiated multiple time=
s\n",
>> +			 dev->driver->name);
>> +
>> +		return -ENODEV;
>> +	}
>> +
>>   	if (wdriver->notify) {
>>   		if (test_bit(WMI_NO_EVENT_DATA, &wblock->flags) && !wdriver->no_not=
ify_data)
>>   			return -ENODEV;
>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>> index 781958310bfb..63cca3b58d6d 100644
>> --- a/include/linux/wmi.h
>> +++ b/include/linux/wmi.h
>> @@ -49,6 +49,7 @@ u8 wmidev_instance_count(struct wmi_device *wdev);
>>    * @driver: Driver model structure
>>    * @id_table: List of WMI GUIDs supported by this driver
>>    * @no_notify_data: Driver supports WMI events which provide no event=
 data
>> + * @no_singleton: Driver can be instantiated multiple times
>>    * @probe: Callback for device binding
>>    * @remove: Callback for device unbinding
>>    * @notify: Callback for receiving WMI events
>> @@ -59,6 +60,7 @@ struct wmi_driver {
>>   	struct device_driver driver;
>>   	const struct wmi_device_id *id_table;
>>   	bool no_notify_data;
>> +	bool no_singleton;
>>
>>   	int (*probe)(struct wmi_device *wdev, const void *context);
>>   	void (*remove)(struct wmi_device *wdev);
>> --
>> 2.39.2
>>

