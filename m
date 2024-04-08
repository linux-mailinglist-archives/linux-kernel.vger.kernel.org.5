Return-Path: <linux-kernel+bounces-134822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A186789B76C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D3E28177A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E68C04;
	Mon,  8 Apr 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="dYf3Xaq9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD96FBF;
	Mon,  8 Apr 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556102; cv=none; b=DFA/0EIOqyKjNMUJ8EyX4Nk6NSpjeYrQipeqb3KI7pQ5eWaVEj2eYUdf4y//pkNRegAHmkI1dPYitIB3SDYi4hmNoLUMawXFCt3GrH3/6zgs7SXNAW2DGkpyYZah8dURpdqQi0K76im4jGMPwZKhiwJCUoHmKYIURSHFuHZnqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556102; c=relaxed/simple;
	bh=j3pdPO4hK5NCS7PntgOIHOFPyKw8JwypBmH1CVR2IFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJnMXqsihPbEyfxxi/tzLrk4qrhMgNHEj8Uoz6QmXrpomPTFEsdQtNJnJCILF3Q6Eyx/7m3eUG3/norPXSG6HzbvkRRel1gC5uckrUh6b49U20iHPbpMgXc6WqrqfQytlth5r6DJzEKYD3OwiRN/CqF14vd+IiV7Bgc1GONSh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=dYf3Xaq9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712556086; x=1713160886; i=w_armin@gmx.de;
	bh=FHza8gnmORzzujT9IlhA4kRGmjMPLKiRsLX5aj8eCmU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dYf3Xaq9HqyIGoleUmR32yqAd/EX5iwFJ7P3HjweBaZcHx1rHYrdY99rFjef5syz
	 2fZXOUCGh+M7SqU+JOGUDaiXU51WglslOu/JHCkTAMnXs/Upvipu0Cwyv0TBNzNsn
	 BY3EnZ/zO8MgkhPz+mbBxwra/t+LllSLYl3c5HmAu++85gMwopt5HhSqV1mJDOAiC
	 zbg7V0n2znhhtI6zIMFiTiMzWHGDQdRk/fC3+dit9sWEOt3xTkCwBVnfcbL9/DgQV
	 gNhdNOhknMuVqMcuI0LJErq5WGRIA5SRdG1/uKvh5rnSJa/n04sh25eYK0iUzole9
	 r66/NOWjqSGYj7vC2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1sbKXk3rer-00iTpu; Mon, 08
 Apr 2024 08:01:25 +0200
Message-ID: <2cbad5c6-8c70-45dd-8281-3bbffb4e8daf@gmx.de>
Date: Mon, 8 Apr 2024 08:01:24 +0200
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b5d808fd-f9c4-48d5-b888-c4ded4b0cad6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hjeaQ9vUjNMmoTEbJoFEo4ZE5406kKN8PvTMaWmHUPc77kWT5x/
 TSXadYy+mVzZ+TAHIkIkV92V/SUa5pJnazZV0dHuRjQZJdhmPeneH687rOApqSS4bdC7InO
 wBLhrRBPlUsLUTcHfYNJrAGW3AT5ytx8duP3fMRk5ziPxUb+SwRxThLZGUBH5MEWjeJP1P9
 7FH4iVhyOQL8ZyO7ugLSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JmDcpulSKJs=;hqtQ2OsFfo/Zc4Y68lqI3js1hL5
 poGW98JVCINv3bwMfTHcC/j4sxHmnhBvZCsMfxTsBgs5b1G3gDgEZYYKTkfUPHKpw4S8e+7ko
 JWBmsZw0cQLlzf6oN4Aow8TCGZyFRwRdJeE0RlD61jL7VDjJsZ5GqZvZ+cMvDxx3ghF/L1bAi
 W18gaOjmN/zK8MZd3a63ywYfLmo4XWnjOS/y2rFPiIqcfnzQxXwMutqWN7RRZB7Pr1Ya8MzzF
 JTcPJJPlpgvJX35aPSoRnoWZr/GfIxHmK6PKGL20mDCWsha7Y7WmKhrgbI/CJ6f6CnEvXyBIE
 M628N1Qr2RgnuUji4nN6q40mrv/Sb+CDQHXvFFav/AuH+wE21I+yVMLh13/z/Y2u0ZCnDvQ50
 iLvX41bqJZYZ5vEj612YHCu1kfl/NlyIwUzWUkG4Tu2/RWZeyMeQX6i1WyyzYQhTpnqaVBS7C
 aluvtYAeN927LCvKM9xiLfss4wKusbBm7pDrY8+6oKtl/EBSzDr/7UbbLMev/35s2bHXizM0h
 vMjy7U0atTNzgcAtoobpSugtEY04KGnXDDQQVHq0UYvCpW0z/3UZaVbzMvx7i0lwEWud7hlff
 w50B618x5+o1nVwkeAOmG8o+GlNOedD/+6R910ht8IYWS7J/fmakTpDs9w2sLzr6oicTeP+FT
 izVDKqUE9zEMGcYT7UtA2Jf6882pkuJ5DzAsJ/NVuTF6ZjongpwtG/OvIxiiEtFAthSecK1wg
 qSM1w+bGQhVqiqWNKCGWTSe4HQl+BNxyXcQpLJfn/pZLFq3UkND5cnK3dkFY3GjE8kCvfU1bJ
 WHx3613Uzbt23e+VnMqGU6+T6jebDNFJDjH3djfCAaINc=

Am 07.04.24 um 17:32 schrieb Hans de Goede:

> Hi,
>
> On 4/6/24 8:57 PM, Armin Wolf wrote:
>> Am 27.03.24 um 22:45 schrieb Armin Wolf:
>>
>>> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
>>> on all CPUs"), the ACPI core allows multiple notify calls to be active
>>> at the same time. This means that two instances of quickstart_notify()
>>> running at the same time can mess which each others input sequences.
>>>
>>> Fix this by protecting the input sequence with a mutex.
>>>
>>> Compile-tested only.
>> Any thoughts on this?
> I wonder if we need this at all ?
>
> The input_event() / input_report_key() / input_sync() functions
> which underpin sparse_keymap_report_event() all are safe to be called
> from multiple threads at the same time AFAIK.
>
> The only thing which can then still go "wrong" if we have
> 2 sparse_keymap_report_event() functions racing for the same
> quickstart button and thus for the same keycode is that we may
> end up with:
>
> input_report_key(dev, keycode, 1);
> input_report_key(dev, keycode, 1); /* This is a no-op */
> input_sync(); /* + another input_sync() somewhere which is a no-op */
> input_report_key(dev, keycode, 0);
> input_report_key(dev, keycode, 0); /* This is a no-op */
> input_sync(); /* + another input_sync() somewhere which is a no-op */
>
> IOW if 2 racing notifiers hit the perfect race conditions then
> only 1 key press is reported, instead of 2 which seems like
> it is not a problem since arguably if the same event gets
> reported twice at the exact same time it probably really
> is only a single button press.
>
> Also I think it is highly unlikely we will actually see
> 2 notifiers for this racing in practice.
>
> So I don't think we need this at all. But if others feel strongly
> about adding this I can still merge it... ?
>
> Regards,
>
> Hans

Hi,

the locking issue was originally brought up by Ilpo Jarvinen during the re=
view of the lenovo-wmi-camera driver.
Also the race condition can cause an invalid input sequence to be emitted:

input_report_key(dev, keycode, 1);
input_sync();
input_report_key(dev, keycode, 0);	// Possible invalid sequence?
input_report_key(dev, keycode, 1);
input_sync();
input_sync();
input_report_key(dev, keycode, 0);
input_sync();


I think this input sequence would be invalid, so we need the locking.

Thanks,
Armin Wolf

>>> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C3=
2) driver")
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>> This applies on the branch "review-hans". Maybe we could somehow
>>> document the concurrency rules for ACPI notify handlers?
>>> ---
>>>  =C2=A0 drivers/platform/x86/quickstart.c | 17 +++++++++++++++++
>>>  =C2=A0 1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/=
quickstart.c
>>> index ba3a7a25dda7..e40f852d42c1 100644
>>> --- a/drivers/platform/x86/quickstart.c
>>> +++ b/drivers/platform/x86/quickstart.c
>>> @@ -18,6 +18,7 @@
>>>  =C2=A0 #include <linux/input/sparse-keymap.h>
>>>  =C2=A0 #include <linux/kernel.h>
>>>  =C2=A0 #include <linux/module.h>
>>> +#include <linux/mutex.h>
>>>  =C2=A0 #include <linux/platform_device.h>
>>>  =C2=A0 #include <linux/sysfs.h>
>>>  =C2=A0 #include <linux/types.h>
>>> @@ -35,6 +36,7 @@
>>>
>>>  =C2=A0 struct quickstart_data {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev;
>>> +=C2=A0=C2=A0=C2=A0 struct mutex input_lock;=C2=A0=C2=A0=C2=A0 /* Prot=
ects input sequence during notify */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct input_dev *input_device;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char input_name[32];
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char phys[32];
>>> @@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle, u=
32 event, void *context)
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (event) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QUICKSTART_EVENT_RUNTIME:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&data->input_lo=
ck);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sparse_keymap_=
report_event(data->input_device, 0x1, 1, true);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->input_=
lock);
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_bus_gener=
ate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> @@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *contex=
t)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_remove_notify_handler(handle, ACP=
I_DEVICE_NOTIFY, quickstart_notify);
>>>  =C2=A0 }
>>>
>>> +static void quickstart_mutex_destroy(void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct mutex *lock =3D data;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mutex_destroy(lock);
>>> +}
>>> +
>>>  =C2=A0 static int quickstart_probe(struct platform_device *pdev)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct quickstart_data *data;
>>> @@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_devic=
e *pdev)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dev =3D &pdev->dev;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&pdev->dev, data);
>>>
>>> +=C2=A0=C2=A0=C2=A0 mutex_init(&data->input_lock);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D devm_add_action_or_reset(&pdev->dev, quick=
start_mutex_destroy, &data->input_lock);
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have to initialize the device wa=
keup before evaluating GHID because
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * doing so will notify the devic=
e if the button was used to wake the machine
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from S5.
>>> --
>>> 2.39.2
>>>
>>>
>

