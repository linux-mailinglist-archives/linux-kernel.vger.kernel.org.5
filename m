Return-Path: <linux-kernel+bounces-67653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C4A856E92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F063E1F23C31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808313AA4D;
	Thu, 15 Feb 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BGij8Gri"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FF136995;
	Thu, 15 Feb 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028874; cv=none; b=LI8TzEedIC1f2rnKuKGDLuI41ASpF/Fedv3VpPHEoSCNJvZcjE107r6bRCqGl5J7ZRSnv5QM93/iY6Ac1qqS4M3NIPM2twZ31OyA82MzH0hOa6Z9J6v8HEUHSZyDU7Dp/86Fl4GIC9zj3G7e+ZfHdI3/kU0dDRSQMaII+IKVNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028874; c=relaxed/simple;
	bh=qmikj9StrfDnc2GSsAOFnjLrFISUQoPjOilbFetrIeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8VilouqxYBs7IjyOsH7VFpuBdUcCZiiVwYgAUtzNXx/ZH442bo8aobm8PPOr430PvhtMmwfp6i5C3ipIHmsJvYw4qcPBMgbkkXbhDY4HHE0v0JgkKQRobUyE2apr7GNbTk6el6kW4vezHbkNcIEHSfM2oJQC3qKQuT6Kz0/cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BGij8Gri; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708028858; x=1708633658; i=w_armin@gmx.de;
	bh=qmikj9StrfDnc2GSsAOFnjLrFISUQoPjOilbFetrIeA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=BGij8GriOFfvQenjLAJB6yfs8l1v2Ve6gasklkgJPGtDwvaHEbUeSKou+I9ThO7p
	 +hm/elIGKgze9zxb/n28VBgN9b+4u4cF4ZmBj5zYedK6evAzNqy7s7GxAijkf5oe1
	 N9oh4LLd85qekQ4JYlh13hXQ4FhG71jfyKDZYV9yDUDNjB13zTjANS2ShYAtesSZZ
	 Nc/y6Xk21qtaQk4hgb/CFR7HjAOYCZCCJjMqqEqIjB/55hAuSLUzcaxy8t89mKEjk
	 XsdnHI7yl1FBHKjBwW+xIr/hPJqEFr8rEGld3RyxZQe0N1+5g74I+OVwV+qgd+4oS
	 WvoxYwsTk2PrGsUo+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1rWC5q1L0a-00Uuiy; Thu, 15
 Feb 2024 21:27:38 +0100
Message-ID: <80bc19ce-7111-4a5d-b875-2712bdf2bb72@gmx.de>
Date: Thu, 15 Feb 2024 21:27:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] platform/x86: wmi: Check if event data is not NULL
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240214070433.2677-1-W_Armin@gmx.de>
 <20240214070433.2677-3-W_Armin@gmx.de>
 <e03b600e-6ad2-1dd1-c4af-56ebfce51f12@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e03b600e-6ad2-1dd1-c4af-56ebfce51f12@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6rLYDnFHbyQu96y3zjDa+xc37kvxsfJKJncFYPgotzj2QHYoZBK
 OHq6vIWfWgt8Y+2qxmhV5ws2aZkXQPdnv4SczaPBYHPE9VkQ94diRRf8oHGFZqsaE4scbA+
 tM5+3fNZvQraXOkCVJOpYoHHHyDqUxB1D5adsbV89eLQjh1wNQ17zm7/djkKnVztQ6iBayJ
 S7fGvqMdRAyuxbScpOSGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LBrINFF4lHU=;uBCImhl1dHbQ5kqWIGChyM7Nz8l
 Bvnws1BHOGVfo9JKbEtDKHVON4ZMaTEtsaI3Q+bcwuS2a9OBEouRgNKqsF5R55B+sKNDkI1Wl
 YifBil68Rs9jgJAHnh80tzauR4DYHiPfvzLaPpcrBj4MFAnz8UitaZHwA/Tr3uvf9kze5sPNO
 8/NQQPWNg41/m6XK8+aDKZseB0Cb7F5prpeN/gV8zr818cMCFNdkD9CgO8hi3OhR/HYIJe1u+
 MT+Xwm/PVoHdpqJStN/0YjwjPCwtFllOeCbRg23YcS0aANyCTpSkAp1Bsps0PYjI/5oNdPRRP
 CT+N1m0SXe7IDk9dZkHROr8EzEJFIcRHbjk+Sfty2Ze6Qvm7RYpz73GHYvcznNHuh1uhZrn7o
 VGA6mZyCGR/oveDvxOU/nQWZjD513HqrXGF1vuwo189h26P+4Cg0CokDqc9YY9pdXQBYOKUsr
 HblGGKfR5rAGd/56/Sk7WxSdqHeQwegMStFZsgLmK27d5qi6VMiPckQICVza4Yf2989XjpW1z
 PJVUsStyb9ByUfCGg7ON3GDP7DldWRkcZIZtPJzntzeAjYQaisj9CUJ3AZL2V+ggZxox16HLt
 ovjyVzuzesSkiQ+EmmBv/E3ofgFMO8AAeycD/ks8rC5DtJaemOo/SecyCRMUqkFoPE2ejOVOV
 pq9FVrXfqgvjGK27rqTGvtII+su+TQtFSSVp7q1F5/rPItXI2nRY4CXB92yZVJkGixBmJ+AVQ
 kW9a3pL69l7EQQLAXVDwD1nogSFmElpQglI6aIoiFjxtTxGP2r9PNpKr+vZyrA4dsts7PTW6V
 yV8Pfpw3Qfu/SrQpls4rYktplXFUrkD3uFpKTF8QMAfWg=

Am 15.02.24 um 13:31 schrieb Ilpo J=C3=A4rvinen:

> On Wed, 14 Feb 2024, Armin Wolf wrote:
>
>> WMI event drivers which do not have no_notify_data set expect
>> that each WMI event contains valid data. Evaluating _WED however
>> might return no data, which can cause issues with such drivers.
>>
>> Fix this by validating that evaluating _WED did return data.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/wmi.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index 34d8f55afaad..8a916887c546 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -1211,6 +1211,7 @@ static void wmi_notify_driver(struct wmi_block *w=
block)
>>   {
>>   	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
>>   	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> +	union acpi_object *obj =3D NULL;
>>   	acpi_status status;
>>
>>   	if (!driver->no_notify_data) {
>> @@ -1219,12 +1220,18 @@ static void wmi_notify_driver(struct wmi_block =
*wblock)
>>   			dev_warn(&wblock->dev.dev, "Failed to get event data\n");
>>   			return;
>>   		}
>> +
>> +		obj =3D data.pointer;
>> +		if (!obj) {
>> +			dev_warn(&wblock->dev.dev, "Event contains not event data\n");
>> +			return;
>> +		}
>>   	}
>>
>>   	if (driver->notify)
>> -		driver->notify(&wblock->dev, data.pointer);
>> +		driver->notify(&wblock->dev, obj);
>>
>> -	kfree(data.pointer);
>> +	kfree(obj);
> Hi Armin,
>
> While looking into this patch, I failed to connect the mention of
> no_notify_data in the commit message with the code change that does
> nothing differently based no_notify_data being set or not, AFAICT.
>
> It could be just that you need to explain things better in the commit
> message, I'm not sure.

Here the _WED ACPI control method is only evaluated if driver->no_notify_d=
ata is not set.
So the returned ACPI object should only be validated in this case, as we p=
ass NULL otherwise.

Armin Wolf


