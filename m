Return-Path: <linux-kernel+bounces-94355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ACF873DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A521F25615
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05813DB99;
	Wed,  6 Mar 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EjTVU2c1"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04480136987;
	Wed,  6 Mar 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747879; cv=none; b=T7tAG/I8lvpCFhVSxAr++pwa5bSH1uLXF3dXanYZutKDCNwW1088+i6L3sP28fCCltM3Bpihs1qxeL/LBg5UCvV72RhpbqAvUmMG87ZhIwFCmQPRYScP4uabPH5AXyBhKNELO+V7II1Mz5T9zPxkHgMwxrGwBDJNYNfKRTUdd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747879; c=relaxed/simple;
	bh=QUqisBiS7xXNdRUk3IDGMEjPq5qEk9BBlwz6y0jfWus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3Ml31/gQxb3hWJPZkHNlM0FMGmZLH6KHVtTt1BeVKzGoXw77WxnpX9q5G0GYIHh4vUVn6lOMl4gI4rPw2RD2ciAk/t0whxp7Mti3aidfWC6QUSXlj+QKP/d34+BR6ajcbt1560eyzhvwDVmakGXzfY5zY+DljdMhsVZq/XToX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EjTVU2c1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709747856; x=1710352656; i=w_armin@gmx.de;
	bh=QUqisBiS7xXNdRUk3IDGMEjPq5qEk9BBlwz6y0jfWus=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=EjTVU2c1ilxIWoNULS+lLzo5/HzE5sR15i7oYbdNd/UYKmx2O9mwQ5N30oW5c23C
	 51EIiFkmN4gFFUOuaTqH97jIVGBrAFcBoHAkc564gDDJtH5EDtYTzgYrpzCK+yleA
	 BQVWP2yg3zLoQEO2lRg2qMfqvdarOuKmFJFSfL+taIf8bDuGmQXKazB+NStpVJSpK
	 9TyDn1eoPQPqPjpjhpNc3VEouLPznWRP0lAxDcXnSJZv3x8JyYnT0Q1qJS2uVVNi2
	 JZVKB4Waop1cITF+XhEjvjFu52/Kuc55NrVJvKyf3STv4qtWWp524xX2NvobYo1bJ
	 jl2EiHLZQiUSCowIEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1r98fS2LgI-00ZzTj; Wed, 06
 Mar 2024 18:57:36 +0100
Message-ID: <bac77347-1308-49a1-b02a-19c6b7a5a31b@gmx.de>
Date: Wed, 6 Mar 2024 18:57:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: wmi: Support reading/writing 16 bit EC
 values
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240304221732.39272-1-W_Armin@gmx.de>
 <ffb87c8f-3d6d-c96c-71e9-2abccfe68405@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ffb87c8f-3d6d-c96c-71e9-2abccfe68405@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:feF8vV7gQon9C5KSS4hdaK1sHZXtm5Yw+8fO7Sw8qDZmNeP2y/c
 ktWpEAuIjQZaM+YXCc3AFfCF4wEGcpYIKmn63v2kMxjxSJG09ELyV1xzoFqssDp4Hk45r6T
 KjxwbtzGqO+9ek/1CeWbrgm30RTPPfJPA+qXw0kybQrGC/P8nym40IsLYMLV6N9UR4tEKkC
 T2APgm5BTTUYfDW7pgVbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PwLHHy9sUMw=;TA1kQu+WXeJuNKAPVKA2+2uoFIG
 VQE3tQsOtJqSL8gdHWA95rWsSM89K6db6K1NOGuS9rya72twymnhsAGlGPcmvDa4OrmnwF6u7
 VsWeQNhOGgeonat/8TqlywIsEiRNjB7h5iL+5ROjNfmXC4+v6VrTyRr0WKVk0DNGqSke3dR/5
 j48gsRD0VBf2zhaOCwVxKcNYpYBmGmBGeG3DyOs/qv6W22zuRoIUEl7WERkLAA48MQbXZ27/+
 ntUzG6JN1OWjK1sTssE/haIUJoWcw4h7nhfSYwRAwKqQqemWOt2hjK7ptImNWOTjwMo47Qf1N
 e3M/Nfrk4ubvTGiuRhaZ4QAY9tD9TFQpH58MOlE/zs8pcftfQPUsFNLVR8nV87X+kpgIbPAKS
 mRzwmm1AMsh2Yd/5Pg3krQvdoLw1MsdvIzsmpIxREiDk0b7fiZd19eHCA1OasfeJoEtzgf1iM
 kwfabf5BIj/UQYRhoS52WPgIWteXfQ2KD37hbHzCxCNL0iiRAvnU/d0k6+sfTBd8JSWe/zVc0
 qCMihghA+IUpi8nUj8Ps45/R1kY6vT+oKNx5EFa8QCVH8d94LgSqZG0z9yP5j4ZCsBtS8BHeA
 WjT4jtkAb705/6G//q0xlIuVjXWTVuj4dQu4wC2sNTCUHG2b7mQnjZ2xoDRKrMm4flrnywzpz
 RlYPm1H3pRSkXji3+wo79ZJCwwF7+fLFqiGHbOO/3wz657ZuNkDvmIOn5WrJPxn7z7e/OTUwk
 tdtRrqqcOxBryM4HeBuTIoHCtXZHe/s5i1dFFD60PVlP0X8n3fRhP2ZlEXU84ehgEkFJSPJ+V
 1nIsEgbcTxi6OuZGF038vNtXn2SVRkhFAIGJCXdKY/XLY=

Am 06.03.24 um 11:19 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 4 Mar 2024, Armin Wolf wrote:
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
>> ---
>>   drivers/platform/x86/wmi.c | 44 +++++++++++++++++++++++++++++--------=
-
>>   1 file changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index 1920e115da89..900e0e52a5fa 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -1153,6 +1153,32 @@ static int parse_wdg(struct device *wmi_bus_dev,=
 struct platform_device *pdev)
>>   	return 0;
>>   }
>>
>> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
>> +{
>> +	int i, ret;
>> +
>> +	for (i =3D 0; i < bytes; i++) {
>> +		ret =3D ec_read(address + i, &buffer[i]);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
>> +{
>> +	int i, ret;
>> +
>> +	for (i =3D 0; i < bytes; i++) {
>> +		ret =3D ec_write(address + i, buffer[i]);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * WMI can have EmbeddedControl access regions. In which case, we jus=
t want to
>>    * hand these off to the EC driver.
>> @@ -1162,27 +1188,25 @@ acpi_wmi_ec_space_handler(u32 function, acpi_ph=
ysical_address address,
>>   			  u32 bits, u64 *value,
>>   			  void *handler_context, void *region_context)
>>   {
>> -	int result =3D 0;
>> -	u8 temp =3D 0;
>> +	int bytes =3D bits / 8;
> I'm a quite hesitant about this. IMO, it should do DIV_ROUND_UP(bits,
> BITS_PER_BYTE) or return AE_BAD_PARAMETER when bits is not divisable by =
8.
> And if you choose the round up approach, I'm not sure what the write
> should do with the excess bits.
>
> In any case, 8 -> BITS_PER_BYTE.

After taking a look at acpi_ex_access_region(), which invokes the address =
space handler,
i think the number of bits are always divisible by 8.

I CCed the maintainers of the ACPI EC driver, so that we can clarify if th=
is is indeed
always the case.

Thanks,
Armin Wolf

>> +	int ret;
>>
>> -	if ((address > 0xFF) || !value)
>> +	if (address > 0xFF || !value)
> This should takes bytes into account to not overflow the u8 address?
>

