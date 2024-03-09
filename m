Return-Path: <linux-kernel+bounces-98022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96EB87737F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F40A2815A6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60494D9EC;
	Sat,  9 Mar 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ev5pHiZN"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC944366;
	Sat,  9 Mar 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710011844; cv=none; b=A0bdbUnNLZaJVRF6fZ4pXH0IL4oynCez4LbZxR4qbYrBmc2Qnms99kJfoCAGnjznTg8Ujt+/z7lEzWp+/gJVN5Z9DhyiI+Cb6UYtu4RmCG6V5H1VPLDTeLYtOOw5u5/vOg1M4D7vDzM8nLQYDwq5Q9fUG+0H/RYMBWxYLQeJrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710011844; c=relaxed/simple;
	bh=XRlgEWOTVijLiWgo9FahxuxdDdXF/OXoFOorpeUKHVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezK+YDqwE9fylfE+y8954xXI0xCAD8/nrBEPEi7jqdzi2yRQqHt9Nv2RGhScg+XgcCzSog3eCHTgZ/2dXfJp9maUs+mU7Srh667miKib5RwtmAxX/BvXC5onRwicpEBapc6iHkuy7j68bgorIy18Nyek+BbKe1NmhCBE6Rcykk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ev5pHiZN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710011827; x=1710616627; i=w_armin@gmx.de;
	bh=XRlgEWOTVijLiWgo9FahxuxdDdXF/OXoFOorpeUKHVg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Ev5pHiZNcYYTercqnsnNLQvLbY0Ka1D+dwIWT2MxivlCNB27GKhGfM6wW8tAm5v9
	 bnR+grdk90QBnxlNuEQisejz5Cjd3ZgaJzlWMNWcOwUDqCVTGIeEOkN7OyHXMl50Z
	 aQpiTLigIxwbVyYkmfMf2otsU07aVF+eJtbMBzZa9l3dfYpQasFqrb43dOidRXE4k
	 U4yHntioafOzo4lcK8aMPWTvGXHtP44AA8GuvxT4efXiymd17lcMJ+dxeUhAW7qCl
	 VeeihpwpmvCVwRS5aE6Qp8rM++Pp7TBk0KCbOgeiFsXlgIJMURITykhi7eS2FCi+M
	 jb4BF4tnh49G78+LBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1rHq9n41Z7-00RnwU; Sat, 09
 Mar 2024 20:17:07 +0100
Message-ID: <2fcd7176-108a-47dc-8096-99a5b6a69641@gmx.de>
Date: Sat, 9 Mar 2024 20:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240308210519.2986-1-W_Armin@gmx.de>
 <a6152da8-5f3a-458b-bc48-4bc654677ece@linux.intel.com>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <a6152da8-5f3a-458b-bc48-4bc654677ece@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bULHEOU6HX1JaTlIKMLQ25OmT1v3acdl+rHs8OfvFAc3yHKN2GC
 Ms+Db2sxx2KK1SsbYZrmcdUlKyU7XHpdvOiyYY2ZSyke2hWW1dp6whprny6TZoEnFgyjEvD
 GBq8vLUXq/mSSaWlX0GU9S7IJOPid75vxNLOkGcCXgB0qBUrKSM7o4EGh2jcTC0oY8PzopO
 VFDMPAUHSve3ZM++lJGdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ceCQFEkWCsY=;+DQKmJPoaMZM4s90BLCt1KVrr01
 IwR2rYzQnyxCx6oNHPjlTVeLBH7wdGz3dI4rGFDH/avUoVIYTOIs/cMxFLCZWwtgrLpnhs8bz
 j4xpo93L+pgXsZ+tv9B9imBr0FZmJQGbvvI61rXgTyHhLxXDexo+sQdsHhPsf9/Enl4bpddtI
 Cv67E/R6je5/CFI0MRJz5NLJ6ZlN3+9YrSq1UimDGJ+F6WKb8qYz4gFZ6pGekc52gfAKEhI3g
 1hezLCoJt0AAZjBjAoTJdYGGXuRgw1true2gPFw38ewvsAZb4cn+4Vxe3O9uyimCMIFQwJXx8
 wDT5uTYT8UrO2VT6BGAvqElWjxD5ehHBz0zspp4Yr6w5caIuZ7/d70KuBMNHttkuYA32FiaRf
 XfP6HhNIeMysx4j9UgLY3kWlbyugUTxeNS7j1eYF7yc1v2VeoQmpuzZSPfAUx/fnI7P8RElLR
 j9mV24nB0QJWtU9fmOImABjJavMSDAioCHB4yKIVVS0ciFt6yPonSodtzYpr6VmzELkICIsa/
 qzNlI9hbG8810C/CG9Izrxk75BB6K5TDxz35QmyJs8GgTnUkSHhX+nUMJY60kKTiJHFzWlOxo
 8LA0rHAYsrSjr5kx/G3YWUgDW8SKxxVw9RmIK4SNKWo7KGfi+TLRRIWLp0l58iguFCiu7o/NV
 gcXEP/Dx1tH9XwCEZaJAcV/xB6qawQwcpmRi31KGJyFO9F2ksUkxXrwgMnvdbc5w6+QsmnOwm
 dKzeu5U66CZCLqHsLnM18m7GAiFtLJfmg0XZ6xdHkS3TLG+BnmO9JufMFsrqsxaQM4fXenEEA
 WqT3+CSrxE/gMHmdtf8rQ5szYYSWA7EJGFS1EJz9QmdR8=

Am 09.03.24 um 18:07 schrieb Kuppuswamy Sathyanarayanan:

> On 3/8/24 1:05 PM, Armin Wolf wrote:
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
>> Changes since v3:
>> - change type of variable i to size_t
>>
>> Changes since v2:
>> - fix address overflow check
>>
>> Changes since v1:
>> - use BITS_PER_BYTE
>> - validate that number of bytes to read/write does not overflow the
>>    address
>> ---
>>   drivers/platform/x86/wmi.c | 49 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index 1920e115da89..d9bf6d452b3a 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>>   	return 0;
>>   }
>>
>> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
>> +{
>> +	size_t i;
>> +	int ret;
>> +
>> +	for (i = 0; i < bytes; i++) {
>> +		ret = ec_read(address + i, &buffer[i]);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> Why not use ec_transaction?

Hi,

because ec_transaction() is meant to send raw commands to the EC. And AFAIK read/write transactions can only transfer a
single byte at once, so using ec_transaction() would yield no benefit here.

>
>> +
>> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
>> +{
>> +	size_t i;
>> +	int ret;
>> +
>> +	for (i = 0; i < bytes; i++) {
>> +		ret = ec_write(address + i, buffer[i]);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> Same as above.
>> +
>>   /*
>>    * WMI can have EmbeddedControl access regions. In which case, we just want to
>>    * hand these off to the EC driver.
>> @@ -1162,27 +1190,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>>   			  u32 bits, u64 *value,
>>   			  void *handler_context, void *region_context)
>>   {
>> -	int result = 0;
>> -	u8 temp = 0;
>> +	int bytes = bits / BITS_PER_BYTE;
>> +	int ret;
>> +
>> +	if (!value)
>> +		return AE_NULL_ENTRY;
>>
>> -	if ((address > 0xFF) || !value)
>> +	if (!bytes || bytes > sizeof(*value))
>>   		return AE_BAD_PARAMETER;
>>
>> -	if (function != ACPI_READ && function != ACPI_WRITE)
>> +	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>>   		return AE_BAD_PARAMETER;
>>
>> -	if (bits != 8)
> Since you want to support only 16 bit reads/writes, can you check for >16

The 16 bit reads/writes where meant as an example, ACPI code can request much larger values.
The WMI EC handler should be able to handle those, just like the regular ACPI EC handler.

Thanks,
Armin Wolf

>> +	if (function != ACPI_READ && function != ACPI_WRITE)
>>   		return AE_BAD_PARAMETER;
>>
>>   	if (function == ACPI_READ) {
>> -		result = ec_read(address, &temp);
>> -		*value = temp;
>> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
>>   	} else {
>> -		temp = 0xff & *value;
>> -		result = ec_write(address, temp);
>> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
>>   	}
>>
>> -	switch (result) {
>> +	switch (ret) {
>>   	case -EINVAL:
>>   		return AE_BAD_PARAMETER;
>>   	case -ENODEV:
>> --
>> 2.39.2
>>
>>

