Return-Path: <linux-kernel+bounces-135036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92E89BA40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1171287022
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4FA381DF;
	Mon,  8 Apr 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NSA0zWli"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1A36137;
	Mon,  8 Apr 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564946; cv=none; b=POzAq1RGijzHmzRXNEAn7BHDNt29YHu6JWH00061pmcUD1q9wNrZ6KA+TmzxjUyGncXOQht5SGLUNBFFgr8O2SgAoCbSGXSKTbDTLU/K3zn7tBtkiYpSjHb6wn9rHU4oA7LxVuo2QopXD+WD6wERbWIrg0oaP5GIY0McO6xTIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564946; c=relaxed/simple;
	bh=BhAl84YVNyVkMpBVs842AW6rYGxBmKsrOu2RC622kUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDHy502ARtB4u1nBbnUJs3P1qBXGQotnwquDvEIgOnDtuCrI4wdTj66pyfabiSR5CG6R6qoJPD7DohtmhyvqcAUn1z4/vw6lkic2vGB3IQgwO01zSuZzYjBdQ+nVrxBgJ5on5FefudgIM4HCU6Dup7oxvx9ckXtY8DAOmdJxaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NSA0zWli; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712564932; x=1713169732; i=w_armin@gmx.de;
	bh=aY5QMf9mh5GIWN5VBHgJ0gBK05kR4UMW+5B5IWmyTxc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=NSA0zWli73jqxM7UtM/Gw6gz7eeJ3loB9FjxpZQLeKW6oyLnn8NTERE09U0JlyZq
	 uC6HWKMaO5b2j4SCebIeIL9bVic+ywvdQ/KyzehVA0otvJNcTwfg7vrXcFh5+NE2O
	 e7rORLK9Pd5UpM2C+O25jShFVevb0NUt0ZjWVBsuRT/ssrZogqBBRhFCsBiEj4+m2
	 VW2RqA68Qv1pB1L/qQLyjWzKph5e3KUIrXlXCwMnAi9EoOyyij4WmS9m8DdoN9n7a
	 +4AerA4dPUbMhGQHXnIQQb7h611Qj5Iff9zzIbNAuOEPUlOQCklmciHL5DoNO7dDJ
	 PSekCZ7fkvSgdZ88Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1sRyrP1IPr-00aEFa; Mon, 08
 Apr 2024 10:28:52 +0200
Message-ID: <b40e423d-b7c7-4978-8bc0-5a61d4008129@gmx.de>
Date: Mon, 8 Apr 2024 10:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: Fix race condition when
 reporting input event
To: Hans de Goede <hdegoede@redhat.com>, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327214524.123935-1-W_Armin@gmx.de>
 <f662fab0-0f47-4b71-ab71-2b9492253483@gmx.de>
 <b5d808fd-f9c4-48d5-b888-c4ded4b0cad6@redhat.com>
 <2cbad5c6-8c70-45dd-8281-3bbffb4e8daf@gmx.de>
 <0a05cadf-562d-4516-86bb-51afacb7e167@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0a05cadf-562d-4516-86bb-51afacb7e167@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EVPg56mFm/9hAbAc+K58fgDr71tmq01k06hrpCXtDy2XBERU28W
 wD9SaEmuqBFlzbKO7d91qMdrkjET+I+ps+y0bdUBOJSHXmI6bDLEItiXnqZnDCF9NcDFWKW
 tNaKbFAzuFcKGYIkqnVVLH6nFXGXWgJlMOTbwsB2oixE92CZD7Ugblc0CMM0mSXuIjFNztA
 FNva9JpaF40cL8cYsVH2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VXwAb77Aeew=;E4jQMdM6rKZCHZrjwWTcsk0kN+o
 uB123sMW+bVMGckIYe5XX8oYUo4YJ1/NsqwVZLAdsTnBtG/LnNVAyRd3aN9O2qdLtAsaRICkR
 TwPCMg9e2UG21w3wFAX+m5LKulP88j10zE3Ws8ZU13N5LxvfHq47PkTZrnizoXFm5TZyTD2R3
 3Jrl97sQ319/aXaqeysPAX9p9YXnMOmj3AqvJRMzBqyreWzPxQdCUB2gULNf6u3VJyeP4T9Tl
 oRcLxRwkee4PMhEAq38CqhhhOFac3eDSghZ8mueglMcoI+Ve0IdjqQcR2v3B8yh4AC8LND2NZ
 clRtmA3x8/bpIwd0m6+AGNttZNIZGr4xjMLUg6bB5JCMQS1OKwPobepBT95CW70IrH6H2lS1g
 opGtVl3TeiYX9l/jL3bqDpl8fym3nvZEkNE1LlltFY5Rd6+7SpIxLUtFtrLzqAafyydnrp4DN
 gX5BD29k9ruNmUbWadN8ee61T2CGxGN6pU7KHp/ysBX2RGR4PfTE7O3snYf1taagvUiFuCY35
 at0ry9RwaRwU8cZu26OJ/+5LfIR5VVUBbGs0QM7Y7XhLZEFcGAHIf+YtZfWotisHW5/lyxfyr
 3gLG3FHGPhSjtGn8CaOn1yhVrFmIbilad5SOOn5/Oxa7WSxAY1qcYveodGrUwFI1Mj9+K17Dp
 vV52RTih+nuOAqqNCJydUzzynTsc+djkfgmBfX1s/ig0OMvq+BXdmAwR/624tErWOjGQVOeMR
 7eUmkn3kEt77jOqjfqGreGsx4R0E4dhaV7h3n4x87R0OMkhKtEvPU0rnsgL0Tsn6Po999zIpk
 8OWL/BN+3WqbPy4ZVCu3fUhSZ+usCcdQ9sMaMSd8zGfzY=

Am 08.04.24 um 09:49 schrieb Hans de Goede:

> Hi,
>
> On 4/8/24 8:01 AM, Armin Wolf wrote:
>> Am 07.04.24 um 17:32 schrieb Hans de Goede:
>>
>>> Hi,
>>>
>>> On 4/6/24 8:57 PM, Armin Wolf wrote:
>>>> Am 27.03.24 um 22:45 schrieb Armin Wolf:
>>>>
>>>>> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to r=
un
>>>>> on all CPUs"), the ACPI core allows multiple notify calls to be acti=
ve
>>>>> at the same time. This means that two instances of quickstart_notify=
()
>>>>> running at the same time can mess which each others input sequences.
>>>>>
>>>>> Fix this by protecting the input sequence with a mutex.
>>>>>
>>>>> Compile-tested only.
>>>> Any thoughts on this?
>>> I wonder if we need this at all ?
>>>
>>> The input_event() / input_report_key() / input_sync() functions
>>> which underpin sparse_keymap_report_event() all are safe to be called
>>> from multiple threads at the same time AFAIK.
>>>
>>> The only thing which can then still go "wrong" if we have
>>> 2 sparse_keymap_report_event() functions racing for the same
>>> quickstart button and thus for the same keycode is that we may
>>> end up with:
>>>
>>> input_report_key(dev, keycode, 1);
>>> input_report_key(dev, keycode, 1); /* This is a no-op */
>>> input_sync(); /* + another input_sync() somewhere which is a no-op */
>>> input_report_key(dev, keycode, 0);
>>> input_report_key(dev, keycode, 0); /* This is a no-op */
>>> input_sync(); /* + another input_sync() somewhere which is a no-op */
>>>
>>> IOW if 2 racing notifiers hit the perfect race conditions then
>>> only 1 key press is reported, instead of 2 which seems like
>>> it is not a problem since arguably if the same event gets
>>> reported twice at the exact same time it probably really
>>> is only a single button press.
>>>
>>> Also I think it is highly unlikely we will actually see
>>> 2 notifiers for this racing in practice.
>>>
>>> So I don't think we need this at all. But if others feel strongly
>>> about adding this I can still merge it... ?
>>>
>>> Regards,
>>>
>>> Hans
>> Hi,
>>
>> the locking issue was originally brought up by Ilpo Jarvinen during the=
 review of the lenovo-wmi-camera driver.
>> Also the race condition can cause an invalid input sequence to be emitt=
ed:
>>
>> input_report_key(dev, keycode, 1);
>> input_sync();
>> input_report_key(dev, keycode, 0);=C2=A0=C2=A0=C2=A0 // Possible invali=
d sequence?
>> input_report_key(dev, keycode, 1);
>> input_sync();
>> input_sync();
>> input_report_key(dev, keycode, 0);
>> input_sync();
>>
>>
>> I think this input sequence would be invalid, so we need the locking.
> The:
>
> input_report_key(dev, keycode, 0);    // Possible invalid sequence?
> input_report_key(dev, keycode, 1);
> input_sync();
>
> Part is equivalent of:
>
> input_report_key(dev, keycode, 1);
> input_sync();
>
> Since there is no sync() after the release event it will
> never reach userspace.
>
> With that said, I'm still happy to merge this if you
> prefer to have the locking in place.
>
> Either way please let me know how you want to proceed.
>
> Regards,
>
> Hans

I would prefer to have the locking in place, just in case.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>>>> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0=
C32) driver")
>>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>>> ---
>>>>> This applies on the branch "review-hans". Maybe we could somehow
>>>>> document the concurrency rules for ACPI notify handlers?
>>>>> ---
>>>>>  =C2=A0=C2=A0 drivers/platform/x86/quickstart.c | 17 +++++++++++++++=
++
>>>>>  =C2=A0=C2=A0 1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x8=
6/quickstart.c
>>>>> index ba3a7a25dda7..e40f852d42c1 100644
>>>>> --- a/drivers/platform/x86/quickstart.c
>>>>> +++ b/drivers/platform/x86/quickstart.c
>>>>> @@ -18,6 +18,7 @@
>>>>>  =C2=A0=C2=A0 #include <linux/input/sparse-keymap.h>
>>>>>  =C2=A0=C2=A0 #include <linux/kernel.h>
>>>>>  =C2=A0=C2=A0 #include <linux/module.h>
>>>>> +#include <linux/mutex.h>
>>>>>  =C2=A0=C2=A0 #include <linux/platform_device.h>
>>>>>  =C2=A0=C2=A0 #include <linux/sysfs.h>
>>>>>  =C2=A0=C2=A0 #include <linux/types.h>
>>>>> @@ -35,6 +36,7 @@
>>>>>
>>>>>  =C2=A0=C2=A0 struct quickstart_data {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev;
>>>>> +=C2=A0=C2=A0=C2=A0 struct mutex input_lock;=C2=A0=C2=A0=C2=A0 /* Pr=
otects input sequence during notify */
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct input_dev *input_device=
;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char input_name[32];
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char phys[32];
>>>>> @@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle,=
 u32 event, void *context)
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (event) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QUICKSTART_EVENT_RUNTIME:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&data->input_=
lock);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sparse=
_keymap_report_event(data->input_device, 0x1, 1, true);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->inpu=
t_lock);
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_b=
us_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>>> @@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *cont=
ext)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_remove_notify_handler(han=
dle, ACPI_DEVICE_NOTIFY, quickstart_notify);
>>>>>  =C2=A0=C2=A0 }
>>>>>
>>>>> +static void quickstart_mutex_destroy(void *data)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 struct mutex *lock =3D data;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_destroy(lock);
>>>>> +}
>>>>> +
>>>>>  =C2=A0=C2=A0 static int quickstart_probe(struct platform_device *pd=
ev)
>>>>>  =C2=A0=C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct quickstart_data *data;
>>>>> @@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_dev=
ice *pdev)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dev =3D &pdev->dev;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&pdev->dev, da=
ta);
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_init(&data->input_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D devm_add_action_or_reset(&pdev->dev, qui=
ckstart_mutex_destroy, &data->input_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have to initialize the d=
evice wakeup before evaluating GHID because
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * doing so will notify t=
he device if the button was used to wake the machine
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from S5.
>>>>> --
>>>>> 2.39.2
>>>>>
>>>>>
>

