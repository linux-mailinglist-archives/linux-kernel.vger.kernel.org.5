Return-Path: <linux-kernel+bounces-128120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83360895662
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5A31F2183A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16585C52;
	Tue,  2 Apr 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mSztMLus"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523358405F;
	Tue,  2 Apr 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067226; cv=none; b=npC1lC5siUUxg7L1+5I0JSYWmqOWxL+vzaR7+sih58Px8FABcGlnlMrRw9Hcxl6ySqKMIWvkJRcW5MGCBd0uC+oWx/mvfV6nCeJv4iebG/O4HaTry178S39ihXxpIBLOBDe41BTpCOTEYrbsYWe561wrcNPsOkAhKrPqyQBNN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067226; c=relaxed/simple;
	bh=t60O7Ucy+WoXthLtuuAOS1Utxu8te3IwlUtsBNQHNiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHenScpG4aWe13s2rLXSa9pxKjJLP8DfVkF4GmWtddevwwGK6jiDbkeR8zuSMt+yHD0PfL7EVLAX7VT2Yj+uMX4I/t0H21JXE/eexyksCCyYQnpfFSSk2tTIsgsxeWlnM1Rw0TS/FqIfboHfLbhQChrJj0k5+g+l5nuJRQHNqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mSztMLus; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712067211; x=1712672011; i=w_armin@gmx.de;
	bh=cN9hRjRBiqa1a82umFnF3bDT9Wh/6VtwazCBdn3JI7M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mSztMLusppk30uMkKOin+S409Lg4nWIN5GHht+a7yNc87gNo4UrTGK6csaE+RFeO
	 IjqnKMmEIt6SmW3Tsf44CwQq5VnERRBv7e1OM0nFM0B+lSAyHIb9GvNtnIqnzpVSl
	 bysgqzMqioVvNtiZoZPCOOziAUw8QgdRsSB04Mtdj8Bfl8fJ/ln4naAFNtZBLHMin
	 Tiqy7GP3URwNGNKeioH2rMNprWikYObnGs1oEfsBGcBo6Z4OZ/25VxRhcz51tsLRa
	 2XO2z+ZZUjezkHLFJMYBfeHyK4W7UZH/pyk9n4b+bhfJEWqobKWQG+Jz8bblXMT/J
	 9b7zz8k91M9CHlDaew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1slwqN21SO-00wYbL; Tue, 02
 Apr 2024 16:13:31 +0200
Message-ID: <01bb8576-d75f-4d22-ab29-f366fcfc5bc8@gmx.de>
Date: Tue, 2 Apr 2024 16:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328012336.145612-1-W_Armin@gmx.de>
 <20240328012336.145612-2-W_Armin@gmx.de>
 <b82ded95-d599-4ef7-b984-ac4d8a5c2370@linux.intel.com>
 <3e41e132-98b9-496d-987f-6838289926b6@gmx.de>
 <9e7a081f-b727-4ead-84b9-3c80530a1039@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9e7a081f-b727-4ead-84b9-3c80530a1039@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3OoE19N2WbRLvk/NJ2ws2qpST8R317jcnYqOafiD+FGf9JWGZCy
 3K/VZRUQQ1SQB46DhaWpL0cIbjAzV+Waz/WP+0xJokbLY8WPhBJ98vUXMCUwhqCNAIhwWQi
 xVsbhoYkOb0zANlcXSHaaN1J2I9CzCUuLMfJs0BlgOidN1GgXxz6t9OnNN9HBJ8w9cDtd3j
 QDTq3nGj15yr33FybuxkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:92JrpwzlREI=;9f5acDzr829R4opzUgfEo3pUCCv
 ypNOtryVHGaeRM9e4NcPUVXM4BCvZN458qKde9xUUJ5dZWw3KhOkg81mK4/0S227m2nR60UgY
 cn0w0TmqZ+OXZyIOLQx+dLXI5jn3U8A9BZK/ppq5Gua07fgFlIJCX/XirheynXiKlK8SNfY5U
 LjE7nXF9TpRZFzoJzLIVXOK2wUChZWRZmAZjwAi850pyLR517gbjnObQpVuZzNVk6r3G8iqvk
 SwH7FIIoiLVbNenY3xGc2vTK4qct01MfMLFkE01lWHEic564B3lkx6KTUGaquQrnvRuo1oWFu
 eYqlnwj1reyAP1Z6Nv1HZvpj4Zc5bCrE3YjfKy08osLFpQXzLKehwCLouHo+t6FSzMU6DLLsi
 7Yg1m4j3nOZo5QTQyLYcYCfGLw8gtMXaraCiooOnuPE7rht9wUWDKJAUvyC74AEAdLUxfq2XH
 6rHTkby1q3m86xIaZ/DnGyRCcEyrWJMP160VUM0GUMhLB+RKbuMckVstjCm/nsFSRG7KAbCsU
 QUAN9pMqVUpP3Rilf3bsuCElkWd9DQAUjeRBesZ4G8VGLLxrSSoK9Mw0h/52hRp9rPtF3ktYX
 SWaNH3dtLSsew8U+kcq9jnrbpD6iEeay04aWZv14txjrfGVanKNLT/icsM8oGGm8841Fv9okC
 prPQoEf11xqA7BgQrFiFDk5iYCUbklCwB0t17WQKNQISfkXQRD5MsCqCcMHr3vuO36AWkCieb
 yEB2UkaOHE6oEwL0XohhFWkY4iX8nPIaTsFMjfeq1ORy3Ve9thPiFOilLFyePoJzGsgFTKZK+
 RtRb/utkRw5z5u3tpacg9wni1Rzpe54C3fIXC9iaUkMfY=

Am 29.03.24 um 02:37 schrieb Kuppuswamy Sathyanarayanan:

> On 3/28/24 5:26 PM, Armin Wolf wrote:
>> Am 28.03.24 um 03:58 schrieb Kuppuswamy Sathyanarayanan:
>>
>>> On 3/27/24 6:23 PM, Armin Wolf wrote:
>>>> Multiple WMI events can be received concurrently, so multiple instanc=
es
>>>> of xiaomi_wmi_notify() can be active at the same time. Since the inpu=
t
>>>> device is shared between those handlers, the key input sequence can b=
e
>>>> disturbed.
>>> Since locking is needed for all notify related calls in all WMI driver=
s,
>>> is there a generic way to add this support in WMI core driver? Like
>>> defining some common function which will hold the lock and call
>>> driver specific notify handler? I am just thinking aloud.. If it is no=
t
>>> feasible, then it is fine.
>> Hi,
>>
>> actually, not all notify-related calls need locking. It just so happens=
 that
>> input drivers must protect their key sequence, other WMI drivers might =
not need
>> to use any locking at all.
> Got it.
>
>> I would prefer if the WMI driver does the locking, so it can be optimiz=
ed for
>> each WMI driver.
> Why not implement this support?

Because different WMI drivers will most certainly have different need when=
 it comes to locking.
Some might want to use a simple mutex, some might want to use a RW-lock, a=
nd others might need
something totally different.

Implementing all of this inside the WMI driver core will be difficult.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>>> Fix this by protecting the key input sequence with a mutex.
>>>>
>>>> Compile-tested only.
>>>>
>>>> Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver")
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>>  =C2=A0 drivers/platform/x86/xiaomi-wmi.c | 18 ++++++++++++++++++
>>>>  =C2=A0 1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86=
/xiaomi-wmi.c
>>>> index 1f5f108d87c0..7efbdc111803 100644
>>>> --- a/drivers/platform/x86/xiaomi-wmi.c
>>>> +++ b/drivers/platform/x86/xiaomi-wmi.c
>>>> @@ -2,8 +2,10 @@
>>>>  =C2=A0 /* WMI driver for Xiaomi Laptops */
>>>>
>>>>  =C2=A0 #include <linux/acpi.h>
>>>> +#include <linux/device.h>
>>>>  =C2=A0 #include <linux/input.h>
>>>>  =C2=A0 #include <linux/module.h>
>>>> +#include <linux/mutex.h>
>>>>  =C2=A0 #include <linux/wmi.h>
>>>>
>>>>  =C2=A0 #include <uapi/linux/input-event-codes.h>
>>>> @@ -20,12 +22,21 @@
>>>>
>>>>  =C2=A0 struct xiaomi_wmi {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct input_dev *input_dev;
>>>> +=C2=A0=C2=A0=C2=A0 struct mutex key_lock;=C2=A0=C2=A0=C2=A0 /* Prote=
cts the key event sequence */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int key_code;
>>>>  =C2=A0 };
>>>>
>>>> +static void xiaomi_mutex_destroy(void *data)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct mutex *lock =3D data;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 mutex_destroy(lock);
>>>> +}
>>>> +
>>>>  =C2=A0 static int xiaomi_wmi_probe(struct wmi_device *wdev, const vo=
id *context)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xiaomi_wmi *data;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wdev =3D=3D NULL || context =3D=
=3D NULL)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVA=
L;
>>>> @@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wde=
v, const void *context)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOME=
M;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wdev->dev, data);
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 mutex_init(&data->key_lock);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D devm_add_action_or_reset(&wdev->dev, xiao=
mi_mutex_destroy, &data->key_lock);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->input_dev =3D devm_input_alloca=
te_device(&wdev->dev);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->input_dev =3D=3D NULL)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOME=
M;
>>>> @@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *=
wdev, union acpi_object *dummy)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data =3D=3D NULL)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&data->key_lock);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_report_key(data->input_dev, dat=
a->key_code, 1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_sync(data->input_dev);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_report_key(data->input_dev, dat=
a->key_code, 0);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_sync(data->input_dev);
>>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->key_lock);
>>>>  =C2=A0 }
>>>>
>>>>  =C2=A0 static const struct wmi_device_id xiaomi_wmi_id_table[] =3D {
>>>> --
>>>> 2.39.2
>>>>
>>>>

