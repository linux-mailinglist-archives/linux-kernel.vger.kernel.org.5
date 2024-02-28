Return-Path: <linux-kernel+bounces-85680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62186B932
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE128401C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B328A14AD07;
	Wed, 28 Feb 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Jv+bxT2S"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38E1DDF4;
	Wed, 28 Feb 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152876; cv=none; b=OtoF4hyggqXHfB225L1dYDbM8Mo+8S55siD64/V0Xaon3nj1HliWNO/nDlrZrmg5gieQ9r04ukhPcbCpwl7n9okPtFoHmXZI8QHv3qx/3YcHlWQMhWRqQuC39ZHOgT2PstuWlRaIF42XHiZCDMj3RAQF/D2jXRz7lo/JiY8881c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152876; c=relaxed/simple;
	bh=SI1SOG3Ye09u0VkvEl9Zy6zbU0hRtOCFt672rfEi9fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKLE2ILyCooEqZYW/4NLYkDAL2oyjm3QMV7jmWvl0d6oxPJ/Ny1KUWwLSKAuM0MbteMfXbEADO9h9ihnt+On4nMu3vu4FzUsFMzmqtxtYaII33iN0KdjHU5icldTXfom3hs3vkRJH/q7nyAX2BA9bHf0GOObPlJ7nLkvP7SBq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Jv+bxT2S; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709152841; x=1709757641; i=w_armin@gmx.de;
	bh=SI1SOG3Ye09u0VkvEl9Zy6zbU0hRtOCFt672rfEi9fM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Jv+bxT2SN3FrfrC2kk69tMO7alB2QU6TsobQtfEfxQLlioIIi3z8fbvx/jMssAdC
	 V+9tkpZK43l7i/YDDsVNid/LcQi9guGsEspFrX+Su+pYO11Mt1QO8YUHdu3YNUGZD
	 lP+we/Gedw8eDQeUx9jSH51i68XxRibH2/+UK32jXjSV8jT4twAdDcYUcKfjr8cSF
	 UEdNvefLLJguxX8T6L0TtkQtxdO4rYT7W/h06FwvGQVv6NDLD6FN9+nBryY0H8vlR
	 Nmh2GV36OqlHaPN/dkxotOumlT7FM3QTv5aiksy+b0ASrYjynD08k8IgRb9CHujCM
	 M8HotaIbeCbtIXK+pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1rjZbl3W7N-00Daep; Wed, 28
 Feb 2024 21:40:40 +0100
Message-ID: <1f4748fe-e45d-42ad-a693-c83095b19ed0@gmx.de>
Date: Wed, 28 Feb 2024 21:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86: wmi: Do not instantiate older WMI
 drivers multiple times
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>
Cc: jithu.joseph@intel.com, linux@weissschuh.net,
 ilpo.jarvinen@linux.intel.com, Dell.Client.Kernel@dell.com,
 jdelvare@suse.com, linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226193557.2888-1-W_Armin@gmx.de>
 <20240226193557.2888-2-W_Armin@gmx.de> <20240227203058.eun4ylvhk4t7uogk@pali>
 <a8602a4a-39e1-46c3-9fe9-b6896c75fa73@gmx.de>
 <807c658b-358f-47c3-b14a-f1b76e9208c6@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <807c658b-358f-47c3-b14a-f1b76e9208c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I+c0Th11ycbZsyH4V5nx5XNtOC8DcTzH3VAaXfHcYXLIdqEahyk
 8/RqBc75Q919ZQpI7kr+aZzGfO20vRY/DjKmZHSPbmrTLnS5sySYrls8takP5YYdwlqVhWS
 OaZAoK62sIl2XMU6+H9sWeM0OBQed3QdV5ZWlnuAU9HiqIX0R+/SHZKekIqJYgxW8og5ZJf
 sExgogKQGskcp8gB+EKdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jbEMSe6E1gk=;UaoWRL6xHhpG6dvU1tpHZABpBNb
 KzXgznn2fVckwYN4vTYqE0SZ0QDolIb2Oq4sK3+nZqu/5gQFB53+U2laWhMclkSUz2mRR/fsx
 Yn/fu/EP24rabh8yYMn7OvWSs8eeUOMBsewR+4baHmHtZqTPjruMvYOUjxGwBUuNjHhvJpXPT
 BlkAkBvCM/ihdKtsFKBctwXnHYSyOtjMZPjieync88s5okD27xUTY/KHQkUsjizb8o+nyPpoT
 CZOWEXZBIq1TFiesLnscVsKHxV68SkWW6VWfXPKaJ4i/sgRtp6duOkZ4RUKGkh64CKm3wZs/9
 ahNgxCdSil2rsgm9wjNQaJs2XAERpjCWSB3DpKKw8eTKsCwJOgzZdBFwEscRWCfQd/hxeOvzZ
 JHAt0j+15PFRS+c+Jv3TCPie5+TDs3eUUK48R0Vw1fKGBFhqZBO8UkNjDe+Snth3E4K3SfMFk
 Mg6aCcV4eJVs6TMXynLBMMi/CA2CZVaLcJ6jmrXoEKd3RbXM+/d7hZGY/sysfmKkKTM0nss2G
 2NMnYUkRk5EjC8vCc44bchIuhQVANkSqKyT0uYFMJZttFkGafkZXIWsD5Iab2ylEQsCaHzg+S
 eAVWFrif3JRUxpmN/3kw5vuLwfqbQNMUgDvfVmcMyZz4Nnc/8RpdDc3W0DG22IMAx6d34jAkO
 VlvSMjJS0a1Fs0J1qvomuSbqfx5AX37sufbJMPr2dLudXE2w8erh+ldHuvm0psoiFI2oZqVd3
 DiEjiUgc4htRi5/+TONRtfksKat+m9vYP846FCvcb08Xipr9zbah8FGLT0TueU3U/zuI/dfSr
 wxbOjxt8PJldVx14N16XlR2X6MRWYtYBTz0F0PpUSxazs=

Am 28.02.24 um 14:23 schrieb Hans de Goede:

> Hi Armin,
>
> On 2/27/24 23:47, Armin Wolf wrote:
>> Am 27.02.24 um 21:30 schrieb Pali Roh=C3=A1r:
>>
>>> On Monday 26 February 2024 20:35:56 Armin Wolf wrote:
>>>> Many older WMI drivers cannot be instantiated multiple times for
>>>> two reasons:
>>>>
>>>> - they are using the legacy GUID-based WMI API
>>>> - they are singletons (with global state)
>>>>
>>>> Prevent such WMI drivers from binding to WMI devices with a duplicate=
d
>>>> GUID, as this would mean that the WMI driver will be instantiated at
>>>> least two times (one for the original GUID and one for the duplicated
>>>> GUID).
>>>> WMI drivers which can be instantiated multiple times can signal this
>>>> by setting a flag inside struct wmi_driver.
>>> What do you think about opposite direction? Adding ".singleton =3D tru=
e"
>>> into every driver which is not compatible with duplicated initializati=
on
>>> and having the default value that drivers are not singletons.
>>>
>>> But if the direction it to not accept new "legacy" drivers and start g=
et
>>> rid of all "legacy" drivers by rewriting them, then it does not matter
>>> if "no_singleton" or "is_singleton" is used...
>> Hi,
>>
>> i want to make sure that i wont forget any legacy WMI drivers. This way=
, the
>> older legacy WMI drivers automatically initialize no_singleton with fal=
se.
>>
>> Also i intent to not accept new legacy WMI drivers.
> Somewhat offtopic question, how do you plan to handle the case where
> there are 2 WMI GUIDs for what really is a single "thing",
> specifically one main WMI GUID for a vendor specific interface
> for say the embedded-controller and a separate GUID for events ?
>
> IIRC we have several such cases. I thought we even have a case
> where the main WMI GUID already is bound to using wmi_bus wmi_driver,
> while the event guid is listened to by using wmi_install_notify_handler(=
)
> but I cannot find the code doing this, so I might be mistaken on this.
>
> Regards,
>
> Hans

I am aware of those WMI device constellations, for the classic event-data =
constellation
i think there should be two WMI drivers (one for the event and one for the=
 data) which
are connected with each other through a standard notifier.

I plan on writing a WMI driver developing guide which will address this by=
 giving examples
on what to do in such cases.

The problem is that many WMI interfaces consisting of multiple GUIDs are i=
nherently unstable
since the vendor assumes that they will just be available after the Window=
s userspace has loaded,
so the WMI driver has no means of discovering which GUIDs are available at=
 probe time (other GUIDs
can be discovered later by the WMI driver core, so the WMI driver cannot s=
ee them sooner).

The solution for this depends on the specific WMI device constellation.

Armin Wolf.

>
>>>> Tested on a ASUS Prime B650-Plus.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>>  =C2=A0 drivers/hwmon/dell-smm-hwmon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 +
>>>>  =C2=A0 drivers/platform/x86/dell/dell-wmi-ddv.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>  =C2=A0 drivers/platform/x86/intel/wmi/sbl-fw-update.c |=C2=A0 1 +
>>>>  =C2=A0 drivers/platform/x86/intel/wmi/thunderbolt.c=C2=A0=C2=A0 |=C2=
=A0 1 +
>>>>  =C2=A0 drivers/platform/x86/wmi-bmof.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>  =C2=A0 drivers/platform/x86/wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 12 ++++++++++++
>>>>  =C2=A0 include/linux/wmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>>>  =C2=A0 7 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-=
hwmon.c
>>>> index 6d8c0f328b7b..168d669c4eca 100644
>>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>>> @@ -1587,6 +1587,7 @@ static struct wmi_driver dell_smm_wmi_driver =
=3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D dell_smm_wmi_id_table,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D dell_smm_wmi_probe,
>>>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>>>>  =C2=A0 };
>>>>
>>>>  =C2=A0 /*
>>>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platf=
orm/x86/dell/dell-wmi-ddv.c
>>>> index db1e9240dd02..0b2299f7a2de 100644
>>>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>>>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>>> @@ -882,6 +882,7 @@ static struct wmi_driver dell_wmi_ddv_driver =3D =
{
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D dell_wmi_ddv_id_table,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D dell_wmi_ddv_probe,
>>>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>>>>  =C2=A0 };
>>>>  =C2=A0 module_wmi_driver(dell_wmi_ddv_driver);
>>>>
>>>> diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers=
/platform/x86/intel/wmi/sbl-fw-update.c
>>>> index 040153ad67c1..75c82c08117f 100644
>>>> --- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>>>> +++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
>>>> @@ -131,6 +131,7 @@ static struct wmi_driver intel_wmi_sbl_fw_update_=
driver =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D intel_wmi_sbl_fw_update_pr=
obe,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =3D intel_wmi_sbl_fw_update_r=
emove,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D intel_wmi_sbl_id_table,
>>>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>>>>  =C2=A0 };
>>>>  =C2=A0 module_wmi_driver(intel_wmi_sbl_fw_update_driver);
>>>>
>>>> diff --git a/drivers/platform/x86/intel/wmi/thunderbolt.c b/drivers/p=
latform/x86/intel/wmi/thunderbolt.c
>>>> index e2ad3f46f356..08df560a2c7a 100644
>>>> --- a/drivers/platform/x86/intel/wmi/thunderbolt.c
>>>> +++ b/drivers/platform/x86/intel/wmi/thunderbolt.c
>>>> @@ -63,6 +63,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driv=
er =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =
=3D tbt_groups,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D intel_wmi_thunderbolt_i=
d_table,
>>>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>>>>  =C2=A0 };
>>>>
>>>>  =C2=A0 module_wmi_driver(intel_wmi_thunderbolt_driver);
>>>> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/w=
mi-bmof.c
>>>> index 644d2fd889c0..df6f0ae6e6c7 100644
>>>> --- a/drivers/platform/x86/wmi-bmof.c
>>>> +++ b/drivers/platform/x86/wmi-bmof.c
>>>> @@ -94,6 +94,7 @@ static struct wmi_driver wmi_bmof_driver =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D wmi_bmof_probe,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =3D wmi_bmof_remove,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D wmi_bmof_id_table,
>>>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>>>>  =C2=A0 };
>>>>
>>>>  =C2=A0 module_wmi_driver(wmi_bmof_driver);
>>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>>> index 29dfe52eb802..349deced87e8 100644
>>>> --- a/drivers/platform/x86/wmi.c
>>>> +++ b/drivers/platform/x86/wmi.c
>>>> @@ -883,6 +883,18 @@ static int wmi_dev_probe(struct device *dev)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct wmi_driver *wdriver =3D drv_to=
_wdrv(dev->driver);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 /* Some older WMI drivers will break if instantia=
ted multiple times,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * so they are blocked from probing WMI devi=
ces with a duplicated GUID.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * New WMI drivers should support being inst=
antiated multiple times.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags)=
 && !wdriver->no_singleton) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(dev, "Legacy dri=
ver %s cannot be instantiated multiple times\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev->driver->name);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wdriver->notify) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(=
WMI_NO_EVENT_DATA, &wblock->flags) && !wdriver->no_notify_data)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENODEV;
>>>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>>>> index 781958310bfb..63cca3b58d6d 100644
>>>> --- a/include/linux/wmi.h
>>>> +++ b/include/linux/wmi.h
>>>> @@ -49,6 +49,7 @@ u8 wmidev_instance_count(struct wmi_device *wdev);
>>>>  =C2=A0=C2=A0 * @driver: Driver model structure
>>>>  =C2=A0=C2=A0 * @id_table: List of WMI GUIDs supported by this driver
>>>>  =C2=A0=C2=A0 * @no_notify_data: Driver supports WMI events which pro=
vide no event data
>>>> + * @no_singleton: Driver can be instantiated multiple times
>>>>  =C2=A0=C2=A0 * @probe: Callback for device binding
>>>>  =C2=A0=C2=A0 * @remove: Callback for device unbinding
>>>>  =C2=A0=C2=A0 * @notify: Callback for receiving WMI events
>>>> @@ -59,6 +60,7 @@ struct wmi_driver {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_driver driver;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct wmi_device_id *id_table;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool no_notify_data;
>>>> +=C2=A0=C2=A0=C2=A0 bool no_singleton;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*probe)(struct wmi_device *wdev,=
 const void *context);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*remove)(struct wmi_device *wde=
v);
>>>> --
>>>> 2.39.2
>>>>
>

