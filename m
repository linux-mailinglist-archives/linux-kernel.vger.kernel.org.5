Return-Path: <linux-kernel+bounces-43799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6D8418F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAD2289D74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640337169;
	Tue, 30 Jan 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pRFCUjJP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E036B17;
	Tue, 30 Jan 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580628; cv=none; b=oNgqyrrOoZfPE6Yinl/UabT1GeJkPn4DzJMfpsq/nUt0WRHHeNSKJtyXUYZB6XxzVymEDJx+bM2be2c1mwNRHB3o0cY7NkiSXwh8Yo606iFB/dRuno45CkS2Nx+tAzggu1Xj4a0WiHpF+e6rKd14bee/SdmaLgiOQ/a++rLPas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580628; c=relaxed/simple;
	bh=0/cwgNa5o769hb9lpc9VV/AxqGX0ocJpOERw1kajrw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EERsYQCmft/1v2PEwg1+pn+hEYdxPEAjOW+jXQ1/PzJm90MfTMR5mO1xr8z2xmHYRdKOWHzs3+7vCFc5VbN4AnQrBGHWqNo43amG26AqiTfmqwlyHyDWpqpjsCp30esvtaXHHqXmTAbX2C6H4vjkX4n9zqbz6EHlVQG/aBbGs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pRFCUjJP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706580614; x=1707185414; i=w_armin@gmx.de;
	bh=0/cwgNa5o769hb9lpc9VV/AxqGX0ocJpOERw1kajrw8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pRFCUjJPeqe4td44n1KnIYlalMBaFyajWbI/Q7Sv4Dt2mPmp50A1oK7fz+VvYEbr
	 ++oqvV4DJBNzpPIDCtB61w8em+jZR7jll+pJ2A1GQkBhCkGEpB4HsmxIfEYcms6pm
	 lAS9uPFP9i5iBkO4SEqLYq9Wi9j4SMIaT5xNbDv/H0FK+ZnwOHUD9PZCk7hcHhJef
	 oGsMhhM6z19IWIVFrKr23Z6mIt1lv37R+I9aarvQEpcM74VlWNOaqXA/r4SduiTaE
	 i0ff8qdBzWKqFcCXSC4bIoq/JDRhcKIF/2fxTI9J7wXlGtSt6ubXRRZKPBg2I5GEi
	 aEOzipdYRqJK8KcGYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1rHjQF0RaD-00DVBk; Tue, 30
 Jan 2024 03:10:14 +0100
Message-ID: <62a9942f-97b2-4237-b99f-131535368c68@gmx.de>
Date: Tue, 30 Jan 2024 03:10:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Initialize ACPI device class
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240124190732.4795-1-W_Armin@gmx.de>
 <9ccc3b9d-d71a-451c-80f5-3da62108d983@redhat.com>
 <CAJZ5v0j1qvJYXqo96eMmtD4JnGh4Mu2ESdri5cGAqL-4bK0geA@mail.gmail.com>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0j1qvJYXqo96eMmtD4JnGh4Mu2ESdri5cGAqL-4bK0geA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3AcF5tU6qZdcanOaB+BEwiaiDr7kkNZpMdcLmHblUJzPxiYgAW+
 Cgb2wsPCa6AxP+A+J8eYEbI9sYa6UXghJvtHu9vxAG0/+k8sPB7kOQvzicju2EC/+rDePMS
 Vcf9Jz3MkFBMdbC3dSQbotFmCAI3XMiX+NgKhq0vdvXGLww9smW2HRfOGVZfT47xdFrGGsh
 S1n3ayqWSGtvZqJjKgRew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I16w7xej370=;uenX3LDeC7aNEOKXROGVY5gDNwB
 O6MQUB6zZR+uEaHxxNVH0H/lChElc45luCiGn3YXBRRSOx600YW7si4gN96HhhYT2i9c0hJcs
 akGBjDD/JuGjdOIfuBYxu9VMB/JJ1TuB7jjMNGk9D7KVdZ+i2bST+p+ocfNrIWRZdfQlXu0xf
 wBiSW/d1RXxrykP49uduaHXoiHTSUDEUCF1LaGrDAtVbbbsTRUQ/lUMFlfxcG9+FL5QpifW0v
 s0dYx2Bu8fxFFY2mqUg+URyym7s6XsrV9bFWZk/RsFFrqPSftnfmpCm8gazlGt68vMhuz7JRj
 Y/hCIzqs5l5B2yS4JwY3frkdE+owFDB3+Omk0lbnUo2f2a6LZKThUhHNHlVjPcxDu1lFAf+8+
 Dca7oqsTWtZbXr7JUB7x2ToZDYcNLn8i9KI4LjIDv9rbEltDIxfcx4B35qJ8z8kFBRlPWVwRy
 ZHdgdR32o7Rqcachy4S6pO0hzO8oIwnDCy1SusNrbdbP7wY1vyyemIgUfTNZjMsVdbYG/W23L
 E6Q/RS0KmEoJvT4FGLdVXm01TJmb9BKAuVwdwcy9rgS4XpK/LG+25HxdZmICfKeptPMRRkhFg
 VDt/liSHEae73ts7ZBecvP8/IiOZsTXInOZOHWS4vxLuLm3bccS9+zmI6pcNSWzScV6F7BvhL
 yoDTiKQq81/HWyN+N9+qxswA4/TNaeoWJt0Z98K/FqX2jZ7gsryaeVJt5+cho648HgCRMfi53
 CWPXXPi9Nt1f8ynaCxIApZ+yUya1RGogjHiJrqZMV02xCHIRdoBgTgGR2UggK7A0zTZMxb//G
 BnlkHpnhgBJd6pTRXm3g4m0dOBDhcYqz5/TKdvj4Bw7hLO3kLTcyqtsIPGAQnEM2e3lF6V4Ks
 sBc9YN6f3HccE7WNw5y9ajzjWWYLxPUzFgxAId3x7oC5z9k4M2T13nCzbVcYcmpJfUFG7jpt6
 GnDAfA==

Am 29.01.24 um 14:08 schrieb Rafael J. Wysocki:

> On Mon, Jan 29, 2024 at 1:51=E2=80=AFPM Hans de Goede <hdegoede@redhat.c=
om> wrote:
>> Hi,
>>
>> On 1/24/24 20:07, Armin Wolf wrote:
>>> When an ACPI netlink event is received by acpid, the ACPI device
>>> class is passed as its first argument. But since the class string
>>> is not initialized, an empty string is being passed:
>>>
>>>        netlink:  PNP0C14:01 000000d0 00000000
>>>
>>> Fix this by initializing the ACPI device class during probe.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>> Note: This patch is based on commit 3f399b5d7189 ("platform/x86: wmi: =
Use ACPI device name in netlink event")
>>> ---
>>>   drivers/platform/x86/wmi.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index 7ef1e82dc61c..b92425c30a50 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -32,6 +32,8 @@
>>>   #include <linux/wmi.h>
>>>   #include <linux/fs.h>
>>>
>>> +#define ACPI_WMI_DEVICE_CLASS        "wmi"
>>> +
>>>   MODULE_AUTHOR("Carlos Corbacho");
>>>   MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
>>>   MODULE_LICENSE("GPL");
>>> @@ -1202,7 +1204,7 @@ static int wmi_notify_device(struct device *dev,=
 void *data)
>>>                wblock->handler(*event, wblock->handler_data);
>>>        }
>>>
>>> -     acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_=
class,
>>> +     acpi_bus_generate_netlink_event(acpi_device_class(wblock->acpi_d=
evice),
>>>                                        acpi_dev_name(wblock->acpi_devi=
ce), *event, 0);
>>>
>>>        return -EBUSY;
>>> @@ -1267,6 +1269,8 @@ static int acpi_wmi_probe(struct platform_device=
 *device)
>>>                return -ENODEV;
>>>        }
>>>
>>> +     strscpy(acpi_device_class(acpi_device), ACPI_WMI_DEVICE_CLASS, s=
izeof(acpi_device_class));
>>> +
>> Hmm, I'm not sure if you are supposed to do this when you are not an
>> acpi_driver's add() function.
> You aren't.

I believed otherwise, as the ACPI AC driver (which is a platform_driver) d=
oes the same thing.
Seems i was wrong on that.

>
>> Rafael, do you have any comments on this ?
> I'm not quite sure why this is done here.

The initialization of the ACPI device class is being done to access this v=
alue later when sending an
ACPI netlink event like other ACPI drivers do.

However since you clarified that doing this outside of an acpi_driver's ad=
d() function is forbidden
i think it would indeed be better to just pass the value directly without =
touching the ACPI device class.

Thanks,
Armin Wolf


