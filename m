Return-Path: <linux-kernel+bounces-71857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C885ABD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA40B210F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A950276;
	Mon, 19 Feb 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="infU0N78"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100C47F7E;
	Mon, 19 Feb 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370222; cv=none; b=mRmczOQTjkVa3Vf7F3Bi1H13XwVXgOn+5QknxMjsE+4CK2tkq8uLSAddIX5zTubl4TuCKCh0sq4f7krhv1/fhJL8CRb9/lT19Y6woTKQ6jgAY6xtBvLnG6osVwU7Fyqyn91zTtQS0t+uYveY9iUgxMeuoNfx7tolLZ/op9PcwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370222; c=relaxed/simple;
	bh=tgd4xTpsKTVwdJAs1nlzhessmlc2qH5syjqxzJpGSgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuPVzcmS4SH3ApVheQ7DVWzSXSIzJ1Bhey/POck7yQLMxgfiOvkUwBv9GMP0Sr9I+K88e22D4GAz4jTK6tKVL1MTdNraglTbqXYaO82wh5xBRPFh/AnsNfSvxCXaHjZGJZmvOxrQYlyXWh8oZO7wwI2rwjc/HEgjBniH+IYINWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=infU0N78; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410e820a4feso32162565e9.1;
        Mon, 19 Feb 2024 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708370219; x=1708975019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JODCiIHBRedGuJ2FLPsHoYCAgjMYY/51ruceAsFJZzY=;
        b=infU0N78L0PLhR9SG1kAnBhkVvaQ7G/lmUOIIkByq+QZUWlJUAaZVT83k7t9+h9fLe
         aZfRvykp1NDtAEUdOie24I2GbhppuONa16TKNWZ6ASnqRa8CMX3AjhW9A6JO+YC71V0Z
         nAP4gfr6bTAltAgPO73Se4YlUjV2yHz+ad0iKqzNpZUiSR45EVIKZbHNxJAul0YflSqr
         QzxTx4Yta59cri5ZhrxMYQHayYlX80eTsFG7ADoKyEp1C3ix0O/qqXrz2OdBXLUilLig
         QL6NsijO3mhKK9GxMpYpmau49H4pVy+jrjtHc7CGnI3cDaPSjCY07Gv56ZzXTMU/j0Ka
         lhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708370219; x=1708975019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JODCiIHBRedGuJ2FLPsHoYCAgjMYY/51ruceAsFJZzY=;
        b=TVCR9m0GIEhBuRfSnapOSYs9PLjjDg3kt1dt5pbQvSNHVM4vQkya1Py3XXQveNVxMN
         1z0UQZsckg5o+dWVel5L1Vk30cigSb9XcOMkGYkaDk3grQxKbHjazwqEjmDotAbtkHWJ
         X5Zsa7Wp7uiFnoKFZmf94/bbgNklp5bTPBhayQsGg/LqyB332bJOrtGGdeH99uhV24RJ
         sk15RJoxA0eCCV5TkXfsOC/ycoCt0N0fMPXOw04DbQNPZORxmhOjZ7AKNcHUSMcsutUC
         rLYC9zTDTPCLYA+WlSWnq+lmONGLOZ7KdofFwZ1beNYhX9nSkP9Oz/w2b9EApAGgZdha
         pLbw==
X-Forwarded-Encrypted: i=1; AJvYcCXnTllMWqufNb5y8DTrx7Z92GpPNed7ROFKuAi5EB1iMzBvIoQnjZMqLGNzN9pGg5+8ZU3e9UM5g+aZZtwcTRm6wjs4o01xEVIFCWQriQd+18KooV2eQi5KyqY2lHNDZodEpiXVoxBV
X-Gm-Message-State: AOJu0YyAdDjlSs/LwHALdUR9A7NioxYEpdnODivBhvAP+2HHj3ivEN2N
	rzQDlxDPXEBQ+XibzzRr7p8jDCFlEpgWMEhHdKHmHYOZ/9zJNQ2W
X-Google-Smtp-Source: AGHT+IHn+udNP6WvcfyEsGx7Veelfez2vdMifCpRVkbA+8vRWBAA3CWtk4RKTaA7qGg83CqlYj+7aw==
X-Received: by 2002:a5d:4e4d:0:b0:33d:1fc3:68ed with SMTP id r13-20020a5d4e4d000000b0033d1fc368edmr9355456wrt.2.1708370218569;
        Mon, 19 Feb 2024 11:16:58 -0800 (PST)
Received: from [192.168.101.144] (i577B6BA4.versanet.de. [87.123.107.164])
        by smtp.gmail.com with ESMTPSA id cc3-20020a5d5c03000000b0033d5e3c6835sm2233398wrb.5.2024.02.19.11.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 11:16:58 -0800 (PST)
Message-ID: <cc053eda-3839-4ed4-8fec-525cee752a09@gmail.com>
Date: Mon, 19 Feb 2024 20:16:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
To: Jonathan Cameron <jic23@kernel.org>
Cc: andriy.shevchenko@linux.intel.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZcOLql2RGmPP10EY@smile.fi.intel.com>
 <20240207195549.37994-2-jesusmgh@gmail.com>
 <20240210160210.65bb2c95@jic23-huawei>
Content-Language: es-ES, de-DE, en-US
From: Jesus Miguel Gonzalez Herrero <jesusmgh@gmail.com>
In-Reply-To: <20240210160210.65bb2c95@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please excuse the late answer.

Thank you both, Mr. Cameron and Mr. Shevchenko, for guiding me through this.

I'll keep an eye on git, and make sure to remember your advice on any 
future submissions.

Best regards,

Jesus Gonzalez

>> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
>> probably others) in their ACPI table as the ID for the bmi160 IMU. This
>> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
>> to the user. Manufacturers have been approached on several occasions to
>> try getting a BIOS with a fixed ID, mostly without actual positive
>> results, and since affected devices are already a few years old, this is
>> not expected to change. This patch enables using the bmi160_i2c driver for
>> the bmi160 IMU on these devices.
>>
>> Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
>> model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
>> with the argument of the device working with the Windows drivers.
>>
>> 	Device (BMA2)
>> 	{
>> 	    Name (_ADR, Zero)  // _ADR: Address
>> 	    Name (_HID, "10EC5280")  // _HID: Hardware ID
>> 	    Name (_CID, "10EC5280")  // _CID: Compatible ID
>> 	    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>> 	    Name (_UID, One)  // _UID: Unique ID
>> 	    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>> 	    {
>> 		Name (RBUF, ResourceTemplate ()
>> 		{
>> 		    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>> 		        AddressingMode7Bit, "\\_SB.I2CC",
>> 		        0x00, ResourceConsumer, , Exclusive,
>> 		        )
>> 		})
>> 		Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>> 	    }
>> 	
>> 	    ...
>> 	
>> 	}
>>
>> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
> For future reference don't send a new version in reply to the old one.
> It makes a big mess in many people's email clients
> if we get lots of versions.  The patch naming is enough to associate
> the different versions.
>
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to take a look at it.
>
> Thanks,
>
> Jonathan
>
>> ---
>> v4: Moved comment back to relevant position inside function
>>
>>   drivers/iio/imu/bmi160/bmi160_i2c.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
>> index 81652c08e644..a081305254db 100644
>> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
>> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
>> @@ -43,6 +43,15 @@ static const struct i2c_device_id bmi160_i2c_id[] = {
>>   MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
>>   
>>   static const struct acpi_device_id bmi160_acpi_match[] = {
>> +	/*
>> +	 * FIRMWARE BUG WORKAROUND
>> +	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
>> +	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
>> +	 * available as of Feb 2024 after trying to work with OEMs, and
>> +	 * this is not expected to change anymore since at least some of
>> +	 * the affected devices are from 2021/2022.
>> +	 */
>> +	{"10EC5280", 0},
>>   	{"BMI0160", 0},
>>   	{ },
>>   };

