Return-Path: <linux-kernel+bounces-21477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C2828FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD1B23E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7473D984;
	Tue,  9 Jan 2024 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEXtuD5d"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1033E462;
	Tue,  9 Jan 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed788aad4so2583108276.3;
        Tue, 09 Jan 2024 14:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704839563; x=1705444363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V3WR/SHQG478Xeflj8pSua9cAsvlBn7aGh3gDmTNJdc=;
        b=eEXtuD5dOYjUe9kewtMbNVS9yw1zH5Rt1uIyoWEjytpQqkJrk/B922dtHxF3CTrfsG
         XcYvYw9MkSikI1tBeLvw4eKxl6Aq9QZqVh3YLycPrzfG2wikoyI8NunpHfNXm4XsMUJO
         SuYCACALtV/UGohqlVdf8Q/wcwxWSkakkTJONH0GdfMD0UPUU6BEm1NRUMclfqpUyDeC
         uViEiyzRYAj1eWAA7LJx5sUqJIwz9lf1TevWrj4XujL9jUumizKbonDMk8PWo4JQe17A
         ewgPVxWH3/cFt3vRoUi3ayiU856tWoAJd4nq0jpNBlwWXaGD5ThGn7zppqQIKGAYSYQn
         V/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839563; x=1705444363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3WR/SHQG478Xeflj8pSua9cAsvlBn7aGh3gDmTNJdc=;
        b=xTk0ET7utmrNtF/F7VHSnJpo1n4vqESDU5oEvRI+5J/8YBhOTtKdUQeHj0/pBCYPCk
         77/NdNuXi/2TeGung1RPuAacvW5QwyqgUQnCx6pNL0sUsvhMrvoMDbhHxXcraXQ1e9Kf
         0vBC56EPzf6oY1kxJ6ep5CkUASmQE3UId1Nf/4pjXzYMMxYsOjiaH6KlxGpqYYKK6pEO
         mmiIEr9PmZOggkUhR0DAruaI/TZDTa02NyMLo4ib2MhuyVLeGRWxFoEiLI3PSGMML6D5
         sJRlhunKooG+heenoCYQmxrqNbZa0WBdEbLZCUbqJ+YUlNP0gEHDpfH5h7cZpnKHbcu3
         UbBg==
X-Gm-Message-State: AOJu0YzLJgQYFTYowwDp3tL6qM/8kKI87vHZ33r6xC4DY6EFYw7xLN3Z
	Bhr0IdWAoe/yTXiO4KwMZ4M=
X-Google-Smtp-Source: AGHT+IEI28h8I5G2e4AZlxsQfPzQ6u3R6Rrm4LrsWYo1IlW+G+0it9wKcw+sTemNMOrdNYlmkPAUUg==
X-Received: by 2002:a25:9344:0:b0:dbe:346b:ba6 with SMTP id g4-20020a259344000000b00dbe346b0ba6mr97627ybo.27.1704839563538;
        Tue, 09 Jan 2024 14:32:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12-20020a25804c000000b00dbd22f14840sm995715ybn.13.2024.01.09.14.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 14:32:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e090d7f5-208a-4a4d-8162-7202ad6b0183@roeck-us.net>
Date: Tue, 9 Jan 2024 14:32:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Content-Language: en-US
To: minyard@acm.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
 <20240109041218.980674-2-kai.heng.feng@canonical.com>
 <1b8ff82e-ff26-410e-a37e-0d818494bac3@roeck-us.net>
 <ZZ26ea5KV9Xg1MDc@mail.minyard.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZZ26ea5KV9Xg1MDc@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 13:28, Corey Minyard wrote:
> On Tue, Jan 09, 2024 at 07:23:40AM -0800, Guenter Roeck wrote:
>> On 1/8/24 20:12, Kai-Heng Feng wrote:
>>> The following error can be observed at boot:
>>> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
>>> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
>>>
>>> [    3.717936] No Local Variables are initialized for Method [_GHL]
>>>
>>> [    3.717938] No Arguments are initialized for method [_GHL]
>>>
>>> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
>>> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
>>> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
>>>
>>> On Dell systems several methods of acpi_power_meter access variables in
>>> IPMI region [0], so wait until IPMI space handler is installed by
>>> acpi_ipmi and also wait until SMI is selected to make the space handler
>>> fully functional.
>>>
>>> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> v4:
>>>    - No change.
>>>
>>> v3:
>>>    - Use helper.
>>>    - Use return value to print warning message.
>>>
>>> v2:
>>>    - Use completion instead of request_module().
>>>
>>>    drivers/hwmon/acpi_power_meter.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>> index 703666b95bf4..33fb9626633d 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -883,6 +883,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
>>>    	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>>>    	device->driver_data = resource;
>>> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
>>> +	    acpi_dev_get_first_match_dev("IPI0001", NULL, -1)) {
>>> +		if (acpi_wait_for_acpi_ipmi())
>>> +			dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
>>> +	}
>>> +
>>
>> What a hack :-(.
>>
>> This needs a comment in the driver explaining the rationale for this change, and
>> also a comment explaining why, for example, using late_initcall() does not help.
>>
>> If CONFIG_IPMI_SI=n, acpi_wait_for_acpi_ipmi() will return 0, indicating success.
>> I can only imagine that this will result in a failure since the whole point
>> of this code is to wait until that driver is loaded. Please explain how and why
>> the code works with CONFIG_IPMI_SI=n. Similar, if the function returns an error,
>> I can not imagine how it would make sense to instantiate the driver. If it does
>> make sense to continue in this situation, a comment is needed in the code
>> describing the rationale.
> 
> I'm trying to figure out where CONFIG_IPMI_SI comes in here.  It's
> nowhere in these patches or in drivers/acpi.  ACPI_IPMI depends on
> IPMI_HANDLER, but that's all I found.  However, ACPI_IPMI can be "m" as
> you mention and SENSOR_ACPI_POWER is only under the ACPI config, which
> is a problem.
> 

The patch above is looking for IPI0001, which is instantiated in

drivers/char/ipmi/ipmi_si_platform.c:   { "IPI0001", 0 },
drivers/char/ipmi/ipmi_ssif.c:  { "IPI0001", 0 },

Are you saying that the above code doesn't depend on it ? In that case,
why does it need to check for the IPI0001 device in the first place ?

That will need another comment/explanation in the code because people
(or maybe dummies) like me won't understand the non-dependency (i.e.,
the need to look for IPI0001 but not requiring the associated code).

More specifically, unless I really don't understand the acpi code,
acpi_dev_get_first_match_dev() will return NULL if there is no matching
device. In that case, the above code won't call acpi_wait_for_acpi_ipmi().
Fine, but why would this driver have to wait for ipmi if and only if there
is a device (and thus a driver) for IPI0001 ?

Thanks,
Guenter

> I do think there are other issues with this patch, though.  The IPMI
> handler code decouples the user from the driver from a dependency point
> of view.  It seems to be fairly common to see IPMI_HANDLER and
> ACPI_IPMI as "y" and IPMI_SI (and IPMI_SSIF, and others) as "m".  That
> means this code will run but will wait for the IPMI device to appear,
> which may not be until the module gets loaded, which may be far more
> than 2 seconds later.
> 
> I'm not quite sure how to fix this.  Really, the add call for this
> driver shouldn't be called until the IPMI device is present.  Doesn't
> ACPI have mechanisms to handle this sort of thing?  If so, the hack may
> need to be in the handling of that ACPI data (this field is not there
> but should be), not here, which as Guenter says, is a big hack.
> 
> -corey
> 
>>
>> Third, the new symbol is declared with CONFIG_ACPI, but defined with
>> CONFIG_IPMI_SI. I can not imagine how this would compile with CONFIG_ACPI=y
>> and CONFIG_IPMI_SI={m,n} and/or CONFIG_ACPI_IPMI={m,n}.
>>
>> On top of that, IPMI_SI and ACPI_IPMI are is tristate, as is SENSORS_ACPI_POWER.
>> This means that SENSORS_ACPI_POWER=y combined with CONFIG_IPMI_SI={m,n} or
>> CONFIG_ACPI_IPMI={m,n} will result in a compile failure.
>>
>> Please make sure that this code compiles with all possible symbol combinations.
>>
>> Thanks,
>> Guenter
>>
>>>    	res = read_capabilities(resource);
>>>    	if (res)
>>>    		goto exit_free;
>>
>>
> 


