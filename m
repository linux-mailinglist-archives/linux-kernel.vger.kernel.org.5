Return-Path: <linux-kernel+bounces-58526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3584E79B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B011C2514E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25118612E;
	Thu,  8 Feb 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="G7RzSa8p"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5102E3FB;
	Thu,  8 Feb 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416586; cv=none; b=TyGFswecM1OJDIxDNgLEoSSj2tEQ/f/mKzMAAtZc9xB4bx9yanAu7LqGxM/RtPa2cXNHkywjanphokWsB+PQcCf5jC1qv/EjN5W9ZJY1ofEaKk3mbSLJhUzRnjut6LCStkhXL8GWIcSgNkrQSo/qSFa+Z1NIhqu7Dz67GZuVTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416586; c=relaxed/simple;
	bh=Z3M9OU1xg9hICr5Cd1CNiNl49J/c4bxrT2EwVHqITHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXPmNL24igmK1iV2hhfdGE+cXOugzw8e3AD7h/Hotn6ZwRox6EdYQsbaz8Jc/eAi7wlKME2kr2N9UaX0eUSTkoySGCPvlSSM1AdRxJeoycAVfYHMeT4CIOXj+6pIDaQQeQUjOA46EYVCv/JkpLN/Kaya02mR48eB76gaO5s1PMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=G7RzSa8p; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707416574; x=1708021374; i=w_armin@gmx.de;
	bh=Z3M9OU1xg9hICr5Cd1CNiNl49J/c4bxrT2EwVHqITHc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=G7RzSa8pw0zfKQ+t54d5XNtwqX6aXz7YXTRFMse9fAXsm0hW/o6bEZvOjcW+PY1s
	 KSKePHAgnCnVBQECLbI5Uw+a6Q1GiQEZVxLpLCvGfdn5b/LMxSLwF27cu0xdAp+5o
	 UuKUHJ8nu1rIyP30fqW3q455C8tZ6Uc5Lc/M2I2EHYXEZPoBh2Zi2PIcKahPU6YeA
	 smjrWDQa0PnGNZvNRRnC09eqsIgLOBDOHP7civWji8lOpySqFnfChAsywIqVsMvDv
	 HmkXrRLdoHw/TFsmVfoaNEk/aZOYLdiSvFjDdj65MRGR0nSpavIhBHbosmcxJrvLl
	 A9qvpvA9BzhE/ui2Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1rGt0o42YV-00IYBq; Thu, 08
 Feb 2024 19:22:54 +0100
Message-ID: <d82f47fa-a126-4242-b4c3-83ba2c37fd95@gmx.de>
Date: Thu, 8 Feb 2024 19:22:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Make input buffer madatory when
 evaulating methods
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207202012.3506-1-W_Armin@gmx.de>
 <6360f90f-1aca-4355-aa19-661c2925dd24@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6360f90f-1aca-4355-aa19-661c2925dd24@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7UPQzYOQx2ZRG1jce0S5xgoUoU14Bm1KLTiGsaVWK4ua6s75QSF
 3CwsdFuu2EFLqOYSjoUnZLUat/KPii+j1VJ+YK0sKANpQDHuzBTxvY3zjdCQnG8ssLkeHSi
 W57vs+dg+laj+nzX4+UqGkxRTy9FaNXnzVuJAPXFEuRA4ljayl9MnoHJZRM+AW4jOMlYE3m
 KY6G7G6gkmw9fHpFM5TLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A8B7UDJo+kc=;4AstgXv6B2AcLkizu9bLEnXU+A6
 DNW2zwgGZA5ngDuLPsAukxx81WzfMum/NCPd4hHzI2QjUEUbs7LKOf3+ABDYe0bNdzVxgqejb
 qhJG0uUyDLdwSDBbWTdJnKthdaHStoDoQEWqP1egbIBzb6QyDAIESB9QkjnWEla/203zfr7Xq
 Jqao5YEQcrEpczuGAFU1SqK60ItjQF9QJb3hD2mmrqu/DEENh9XONsEOVzIKpIdBunSO7tVPG
 BVbAu328Vw8putOApHfuRij/aEUBrTPHx7/K1cpbHaVXCiBKh5r7WgX+ExsfcrFC+1sJnZm1m
 hfMe/P22IC5lWZWe/H5qKgDelksMmPOicfN+NhLMB+ODF3Oeb9vFLBwUp2HOVORY0z+RIrhwp
 kJpwHxOVRmin/XeCcxbMJfkIigHE/kriouUzICRd+KikU5ZE7y1dju8dA1+RjQZcpseJ5TKVG
 VAX537pTgisohwt7vKvTeQRIBf6VVl6xoMgHLkSEo0Ig0lq5oHYnht+zm9Y9+zjscFJgu3auL
 j6fZH00gI6pmEYnfc/JNeyXYrBBYHBtBKLonznXUNuts1Lu3QDkOv1bVcHjPqVdPzGGppEwEN
 RMpFTULk7U9+WnEegtCO/c7mESf0/XqDs11SUgAFtV/3QFHsrDziOn4ixppJTgEuI6aKgXOKP
 ufd5McR4rjcXlXBJ7/D6V9yLojxZxgRzWaiGHqDK85r0JgW8sSSHavnvMllJQhZeArmiPgyhh
 Gdj3enEpX0EUPCO8dlrJTqSJ9U1HEOr72bFMY9gnxg+zfZydD5bVZMY8XTS+ePRAVUVxPb43t
 1khYDVuj6VeAHN/LFOoLMsEUXV2H0F8E2Mpzw/iJEu+iQ=

Am 08.02.24 um 03:41 schrieb Kuppuswamy Sathyanarayanan:

> On 2/7/24 12:20 PM, Armin Wolf wrote:
>> The ACPI-WMI specification declares that a WMxx control method takes
>> 3 arguments: instance, method id and argument buffer. This is also
>> the case even when the underlying WMI method does not have any
>> input arguments.
> It would be better if you include specification version and section
> title for reference.

The ACPI-WMI specification is not part of the ACPI specification. It
consists of a single whitepaper published by Microsoft:

https://github.com/microsoft/Windows-driver-samples/blob/main/wmi/wmiacpi/wmi-acpi.htm

The section describing the ACPI control methods is called
"ACPI Control Method Naming Conventions and Functionality for Windows 2000 Instrumentation".

I do not thing that mentioning this in the commit message would be of any use.

>> So if a WMI driver evaluates a WMI method without passing an input
>> buffer, ACPICA will log a warning complaining that the third argument
>> is missing.
> I assume it is a compile warning. Can you copy the warning message?

Its not a compiler warning.

The ACPI control method is being evaluated at runtime, so the warning message
will also be generated at runtime (when interpreting the AML bytecode).

Thanks,
Armin Wolf

>> Prevent this by checking that a input buffer was passed, and return
>> an error if this was not the case.
>>
>> Tested on a Asus PRIME B650-Plus.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>
> With above fixed,
>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
>>   drivers/platform/x86/wmi.c | 21 ++++++++++-----------
>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index 63906fdd0abf..f9e23d491dd9 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(wmidev_instance_count);
>>    * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>>    * @instance: Instance index
>>    * @method_id: Method ID to call
>> - * @in: Buffer containing input for the method call
>> + * @in: Mandatory buffer containing input for the method call
>>    * @out: Empty buffer to return the method results
>>    *
>>    * Call an ACPI-WMI method, the caller must free @out.
>> @@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
>>    * @wdev: A wmi bus device from a driver
>>    * @instance: Instance index
>>    * @method_id: Method ID to call
>> - * @in: Buffer containing input for the method call
>> + * @in: Mandatory buffer containing input for the method call
>>    * @out: Empty buffer to return the method results
>>    *
>>    * Call an ACPI-WMI method, the caller must free @out.
>> @@ -347,26 +347,25 @@ acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance, u32 met
>>   	block = &wblock->gblock;
>>   	handle = wblock->acpi_device->handle;
>>
>> +	if (!in)
>> +		return AE_BAD_DATA;
>> +
>>   	if (!(block->flags & ACPI_WMI_METHOD))
>>   		return AE_BAD_DATA;
>>
>>   	if (block->instance_count <= instance)
>>   		return AE_BAD_PARAMETER;
>>
>> -	input.count = 2;
>> +	input.count = 3;
>>   	input.pointer = params;
>> +
>>   	params[0].type = ACPI_TYPE_INTEGER;
>>   	params[0].integer.value = instance;
>>   	params[1].type = ACPI_TYPE_INTEGER;
>>   	params[1].integer.value = method_id;
>> -
>> -	if (in) {
>> -		input.count = 3;
>> -
>> -		params[2].type = get_param_acpi_type(wblock);
>> -		params[2].buffer.length = in->length;
>> -		params[2].buffer.pointer = in->pointer;
>> -	}
>> +	params[2].type = get_param_acpi_type(wblock);
>> +	params[2].buffer.length = in->length;
>> +	params[2].buffer.pointer = in->pointer;
>>
>>   	get_acpi_method_name(wblock, 'M', method);
>>
>> --
>> 2.39.2
>>
>>

