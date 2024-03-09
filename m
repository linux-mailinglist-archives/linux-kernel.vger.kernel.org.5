Return-Path: <linux-kernel+bounces-98020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D56877376
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D7B281C6B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4D34D112;
	Sat,  9 Mar 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="m28F+VLh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCF4C610;
	Sat,  9 Mar 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710011450; cv=none; b=k9AfZyABH/VBgX1wFiayHcVUmV6joJ+SqL7RVMBgD5lUWdd/FlFeQd4mw0B9CiwSYaRIMLytzzCzXvr4xRMFeHFDNm9hJvE+EGFd/7fEvuJGwxxK7x7uwviqjOEWVs7zO916TPsWUeNurJJ+eCo2ENJwQ5kxPBPJLulMgl/aIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710011450; c=relaxed/simple;
	bh=3h1diuKMmrMJ9GwypIuce+ygNapPEpe4YuLR9sV0HHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW7CCf85nSKQ3vl8Ne6gVfuNVmNlElA0183IyWik/dhKl2uwbwvZ/KksHXaKkHcCKGp+U2yFL03BC3HJj4BJYaXbf9JsqWqltsSbdYB2PDzf/riW2nnx+gpSchEjaouTuNSSAHSvsOZh25IJ/bcjX9lXGJZndgax5JRzhybqXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=m28F+VLh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710011429; x=1710616229; i=w_armin@gmx.de;
	bh=3h1diuKMmrMJ9GwypIuce+ygNapPEpe4YuLR9sV0HHA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=m28F+VLhinWVi6vH4K6dhSjlIV93eeJ12Q85t/5bGrSHLUDX5IXRJ+44WCLIVPC0
	 FALWnkbTVs8hQkYN4pYTXKJ2HSLrxaCprBx+sgNg+9bxB/hAgdBjaliDXFzLCmhNV
	 T2KNALPbKyOg7IjPWU6hJM2RtqEaPamF8KZjRroHBxlxVr/wpc+oIaJK2VMAQ9CeG
	 vLUvGalRaF9M/ioNAnvv/ePusXsanKU0TxD+8fveB+ioSYh0u3ivJMczbnORd7928
	 X4sjx8y3HxXaSCxQ5FpbcOHtlinrzrIOSzjD0f3l9Hoe/eAt6OEo0fs8K4Zf6sEzF
	 xawE9GdP+Ru6p+GvxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1r83iA3Q54-00cCpW; Sat, 09
 Mar 2024 20:10:28 +0100
Message-ID: <232dcca6-d4b0-4c5a-9e17-d9c194a67a71@gmx.de>
Date: Sat, 9 Mar 2024 20:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] platform/x86: wmi: Avoid returning AE_OK upon
 unknown error
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240308210519.2986-1-W_Armin@gmx.de>
 <20240308210519.2986-2-W_Armin@gmx.de>
 <42aa0678-4472-4964-b84e-33beb0a23058@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <42aa0678-4472-4964-b84e-33beb0a23058@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TVKkA0mip/FmnHWbrtf+yt5nPt6k8Kh3biCPR798K0wF5YQ2pkn
 pw5YI/yOG7iIzU2ZDDAnTbw42v9vzTtds0RqwFWXCUFgTGwlPEYoh+V3D/dzkF1I7vfDpu7
 tEwftXKW/8MvZCIxhI/Vl2hbU6vjAVdpVGgb+B2r5L68PtB3n2hrXwMBvAYd1dtxG267Lpi
 KojHTuFuBbilTMF2xI5jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bQLXA/Vtssg=;CT9Pwn50BiNYHjGT7XPhvyIqIlS
 RLcj0xxPfT5Zl4y8pjH1MTwZNBe106baIhBQAr/6JLnw0kW9yrIyJwva1dWUkC30SmMknrrgk
 Avb06p0ol5JJcQcDujMSS3HkNE8ZvbzhRoxkgFM+QfhVVHtbK1HoARi3HXtbNO0w15KedNDKA
 2mfDXXGKCcUOu7SWviFyPCDIB1xlc2widQHX02Rz1dN2BnSB0ihK+5Lt5DCnkDM8OSf0pGwFL
 y0CiJ025AbgPPw1wNsIfIwHE208Guc5SBVwBpGK45WviGdnGueb4CHwOeRJggs4O+ciD1kNg8
 Pj55RezL3wnm/uIZhdFoMnPcPTSqJs4sySXyALn8pz8AaJl6+JQEL1vYmW+KW7GrI4NSXBqHu
 WW1GROanmMctJEmt2MwS+px2IRyxsAPTZ5dqBj8gEfYIcb0LJoTv4BBnJfEi7KxWmRxUpq5+M
 i3SQ86eHTHxj0IRZtuYRD15ZcSIOYtg91RTLMcEXYbANSFMpuSwXJ9Ef9+/hejelRMdOixjaV
 zDj5zGIebqwKhRyHmnC41ZThzyFBb/UPHeIKLGeXmyB/fQzx62Kle6MRk9FMTGeXMt6flyZ1a
 KUiHQtOvbNqxoeeT8iJFx3ZMPjkPYlzv8UKOQaFfTB/yHl1Nmk7eeyNOlSe5bQ/umkwBMn3K7
 dbr5BhpbQQdkQ4DdbHzp8R7wtMgRUKAS5GBT12fl2AcJ1LROgDMU6FYXPrN+aG/7aXeXo+Y4Z
 1cIYqOfjJReTAvs39r06Zz4E23bG1tWfkZ0Nb4RaY+WtCEK3EIX09f5sKKolh8s05WIldDMKb
 hgwYVzCwVruadiP+0KwWjaNUV2htBi7aNkIV5M6BsugcM=

Am 09.03.24 um 18:41 schrieb Kuppuswamy Sathyanarayanan:

> On 3/8/24 1:05 PM, Armin Wolf wrote:
>> If an error code other than EINVAL, ENODEV or ETIME is returned
>> by ec_read()/ec_write(), then AE_OK is wrongly returned.
>>
>> Fix this by only returning AE_OK if the return code is 0, and
>> return AE_ERROR otherwise.
>>
>> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/wmi.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index d9bf6d452b3a..84d1ccf6bc14 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -1218,8 +1218,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_phy=
sical_address address,
>>   		return AE_NOT_FOUND;
>>   	case -ETIME:
>>   		return AE_TIME;
>> -	default:
>> +	case 0:
>>   		return AE_OK;
>> +	default:
>> +		return AE_ERROR;
>>   	}
> After checking the callers of acpi_wmi_ec_space_handler() it looks like =
there is no benefit in returning different ACPI status per error values. I=
t is not being used. why no just return for result < 0 AE_ERROR and return=
 for other cases?

Hi,

those handler functions are being called in acpi_ev_address_space_dispatch=
(), which uses the return value to print error messages.
So it makes sense to return different ACPI error values here.

Thanks,
Armin Wolf

>>   }
>>
>> --
>> 2.39.2
>>
>>

