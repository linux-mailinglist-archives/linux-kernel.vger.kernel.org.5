Return-Path: <linux-kernel+bounces-97269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F8876808
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E53EB22A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85A2C183;
	Fri,  8 Mar 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="POIUQF/R"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F871539C;
	Fri,  8 Mar 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913904; cv=none; b=LBpnityFU/2lzrjU73qj1pZu7J3qyL2m4Rh7Yda9BVDHG0E5c68qfMNQ8viAwrTC4G5vqZ74TRRaM+r3a8rtCk+/kCFpTHQrhIe2BjkT8+xAjdBX3WMTF4a896XXFsrs2zDV661bW6fdA/6ad/2yuhSgpfvljrmQE0dBBJFXVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913904; c=relaxed/simple;
	bh=K7z8th/v+DsQhE0bFlxFAc251ph2T8/2hocApg51reA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyADcDxyn4SMWux6ivRjcOxki3NPO38nKM+j25dX3PgOZlyUjStIb6sXGQx6utsCMdKHEsLZqRACkKZxXAa+wZWTfi0lLxhozASge5mzVZW6pJfNX+GVkuzLsB08MwJRWQXrJqu0JYrqauYL5Wy2cuaFrBT2VTFclgHTAhawK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=POIUQF/R; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709913890; x=1710518690; i=w_armin@gmx.de;
	bh=K7z8th/v+DsQhE0bFlxFAc251ph2T8/2hocApg51reA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=POIUQF/R/TqLEbi6jCX6ME6vQvdEBE2VNGA4oHFZnP2rLCstv51w+m5j5g7x7JF3
	 E0l8zSnr98CUQt4QbQ4tkfVtGIe/RoOUwsD9yCxy5lnVa3y30tYVxu3+tSxjjaNqk
	 8uLVU0Wv31TLU22NGrhJyBGZdmo9vzZxpA9+g4SVET0VDAhSv9MqCtbh+MihzaNLz
	 LryhZQn/HTi5R4aG3j9o1gLUhMTp5YPIQq2abSiNuNTetR+jm4/GGoxTX6H9+vNfT
	 TMv2cPtkTcRL2ZUDNvRosIdoI+1uj+8IOBMkD/EsxW4ZaomMdZjteNc7YpydTTlS2
	 LtsV1iuBQi9LIq4XhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1qsIk91K6B-00stjh; Fri, 08
 Mar 2024 17:04:50 +0100
Message-ID: <ec91a9ff-7c64-4428-b32d-c65d7a5a1ed3@gmx.de>
Date: Fri, 8 Mar 2024 17:04:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240307195753.2961-1-W_Armin@gmx.de>
 <21fd57a2-d8c3-779c-7090-b7cdfc8198be@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <21fd57a2-d8c3-779c-7090-b7cdfc8198be@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eDoC37TAcRM0DNcDk4oCDxtUXhYKhG2/rUkOPlEN5vrIWyyUL0Q
 ybCMpqI1Z0L9iCbV27rDa21df9lw/3BK5ZiWOniXJaWrne7YiCakEkQo0VWDJ8v3M5dYwen
 MF5rrgjqfAjRZ8ZSSAvqWTMHIKNoxjaiNpcMhZcIzk8oJA3psyl0JBcEc550F5W/XJzsf1Q
 YUiK/bD/8ocsmfe6nCtLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/twEZbo7cPw=;zH/K0U78ml8Acbw9oc6kY6gf+mD
 ZGC0SLF+n2cNgzsHXXvRhSNqdLD7XzgfEqhR9VOwexp02rWCeGFhQfbIAYcC6IW26nBhHTcC6
 AND1zXD+8gCl7ocJARDrwljV3ojCC1nAa5tQCj1lYj7OGLN+ABk2soFiRSkP6dn3URVufpE7k
 fBf8zYz5BUMQ9+Yy1v3YH3AdBBDvj4JhFIE0T/u5gPuUck2oOGFC3o8jo89+b8IqXpkuRX8uK
 D0x/7Y65I1kCBqzOIDDWBqoI/au1BlZDqhcLBpU+cwJ6wD7h0/woKbBlG1HTMpiO7O1c+wYEr
 Qug8e4jdzQLY2Ttig9QAPTnuPWblNcwlpi8ZwcmUQGOZREzNHe3W8hu6XuqqnGy+juSo5WLo2
 e+RnN9b4lv3TZc+GLFYCc5j7ndC4eZCrvHNqbW+pCuFK8urcwRUXSsfqb+2wxy+HSPy30j2JQ
 ptfaErPcSpmGggeSvFGwgCxviwQS13JSRmg2idrR7u/BnFwBS9+n4hdPVmoFsNy5tkp1vOSTR
 P3jsP+oJqgCUkAXPx+7GCcH7bKAyhkAgdBW+DGls0t53f9F7Qv5fMWigDa9PO1eZ2Y5sAG0TC
 4Y2l9RW3Sjee1fl7VlHpQ6eKf7jWolB8Co2HQIqMMPaHUUzpxb5fUS3yFY6zQm8gCLUvRoVr0
 5VLOz5soEI6FOC4TV5m5MahYDE5SiRjwhIQ4uIj+WO4FeIhSpvOMY7DNfKvHHoSWPFKxHsXw+
 eN68aqLGJ6JBAgbDQ3w3S61BK39LGUMTf1dd4DFq8rLIaHWKOjGfQSiR8Vri1V4gyuEN63oeH
 Qy1pnUEUJ1fFR1WfhxVcikzAwPpcvza8b5HqH0AUVOZzs=

Am 08.03.24 um 09:01 schrieb Ilpo J=C3=A4rvinen:

> On Thu, 7 Mar 2024, Armin Wolf wrote:
>
>> The ACPI EC address space handler currently only supports
>> reading/writing 8 bit values. Some firmware implementations however
>> want to access for example 16 bit values, which is prefectly legal
>> according to the ACPI spec.
>>
>> Add support for reading/writing such values.
>>
>> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> @@ -1162,27 +1188,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_ph=
ysical_address address,
>>   			  u32 bits, u64 *value,
>>   			  void *handler_context, void *region_context)
>>   {
>> -	int result =3D 0;
>> -	u8 temp =3D 0;
>> +	int bytes =3D bits / BITS_PER_BYTE;
>> +	int ret;
>> +
>> +	if (!value)
>> +		return AE_NULL_ENTRY;
>>
>> -	if ((address > 0xFF) || !value)
>> +	if (bytes > sizeof(*value))
>>   		return AE_BAD_PARAMETER;
>>
>> -	if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
>> +	if (address > U8_MAX || address + bytes > U8_MAX)
> This doesn't look correct. With address =3D 0xff and bits =3D 8 this wil=
l
> return AE_BAD_PARAMETER, is that intensional?
>
You are absolutely correct, i will send an updated series soon.

Thanks,
Armin Wolf


