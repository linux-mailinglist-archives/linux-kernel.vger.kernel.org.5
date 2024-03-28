Return-Path: <linux-kernel+bounces-123141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE68902DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BB31F23F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21712EBDD;
	Thu, 28 Mar 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1cgr2Oq"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F50199BC;
	Thu, 28 Mar 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639206; cv=none; b=JmJl4C/vVpsfuXS0N7A6Ptk6BoL2ru580yY27JIMFYj0e4eK8LOhTMS0ZuZk+2hzHmJGHZO+e9K0ZH7KlIsNjBU2GOuJpB7MBblIbuIeJPO8jjNndqFgzbposhZJ1b2cFHDUjMg4Gbt8FrxSYOWGlkOmT4qKmBs6u5unTHRfGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639206; c=relaxed/simple;
	bh=HwbPY3jeUMYWWEnpfO1UCtVg49OhuXLDecjbGHww9a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBkTeouSqfRbAth85Eu7YwKbwIrA2TSSDK6ZCms1BD4mDOQwD2Jmxws5WWC+HLIu1VkHMVtdTNlCy38obhYrS0be3l2+AYAkVcvPLFQ98A5DhWgfZHKq7hILhTyTI0WKdb9o8h7Iftoq1LoNPdjZzqiX8geVbQM2BQlQQFF3T9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1cgr2Oq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0d82d441bso10083325ad.3;
        Thu, 28 Mar 2024 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639204; x=1712244004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wP9XDSz3beDmB4MkZT4uxEi0warODrL0TB+LR7vpVbc=;
        b=S1cgr2Oqq09bNNLmm59NEbkroMOyASUwcKoRnLrBIkwhq5jOwUj6tq/i2evofD1dBz
         vFibSKOxU7uea5IINcgYw19osOp5hesmB9GTurMf1nbOraQxNnLTGExiGZczIhShcd19
         9Yt/53a2fhqKNdIcHMnKRFwYhForqllRpOC1Hx0cxUF4cfxUSn1i2ZH97oxEbis7f0Fh
         4g8hA/I+aBQLVZHWEsj4o7MelU+Wc6TfYyqkGbydZmlObo0uSXD9Jac+dTZTLDAZC5Gc
         poOZdyeYP5F9V/2sPZh453dmqsyI4RtwWmeVAhH/MBm+OTunfBVvoLhjkh3MwCegFWv0
         v6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639204; x=1712244004;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP9XDSz3beDmB4MkZT4uxEi0warODrL0TB+LR7vpVbc=;
        b=B/zLqkFyyG+h0zaFwUJT0I3tQmuDMaMBYB6RJIho8mtM82yc5xrDEykO7lvH4DmHED
         2p0ErDRuJe7pSs8kmidjhAOht9UW8eSUcsMEbIqFJvH3Q2FaHtcCUDOJLfp+UPGsnMxt
         r/hrhAqYNYtOLY3hpHc1A8rv/32Tb/V5K0poPj2Th5TE0RYBlDGnRQqWvrHk8psv59n9
         vS82tPesIQmttpNbvc17wBP+fmRMEJZigcOOcMzouxqsPKGt2Y2DN4E8n8hdn0eeWMDT
         ih7wqLa9BzPlmhLyMfOhWIbzKHNJzummjdz1sOmfqL832ulFtptMfwTtuPOB6Ngjm1JQ
         xX/w==
X-Forwarded-Encrypted: i=1; AJvYcCXhlg7DjOra1znWMtCAnzT/sZZwht8eJfrxvYx4tQDiYrGnZbUNdHsdmgB82pO9imA8ISRD9RsBOj5E1mkFS/SpSWSbUvti+si/Ye01Yn2qR9srCQmpEf3hyyrXXJzqmsnQM0kAzXD6idrx/P6LG+wShD5u6s3jvJs102O8/GSGG8yzQHIZWkO10Xav4q6mkT5fyIaj4/zywKtsGNNkbyU51XBYOwcOrVulXprNXr2EfKXiqUnS6vC6bjZnlg==
X-Gm-Message-State: AOJu0YwnNDTLVlochwamMOCEkVLxCVpU+LY//W8PFDWnS2UmRmquRzw0
	KK96Tbpb/LZfZ6i2QBWTzi9cCgLRkumx6BEPelPrVgbVQpE+gtHs
X-Google-Smtp-Source: AGHT+IGgDAM/XeuzcR5C58plhHHexD9nQyQw8PC9y8yVmsnzndoLRzxUoEm98+KkeLAs66oZE77ZRA==
X-Received: by 2002:a17:902:c204:b0:1e0:1bb2:b38f with SMTP id 4-20020a170902c20400b001e01bb2b38fmr2482444pll.59.1711639204181;
        Thu, 28 Mar 2024 08:20:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001ddddc8c41fsm1701345plg.157.2024.03.28.08.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:20:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13405bc9-3c97-4063-87b3-45a7e686fa50@roeck-us.net>
Date: Thu, 28 Mar 2024 08:20:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/7] hwmon: (da9052) Use
 devm_regulator_get_enable_get_voltage()
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-input@vger.kernel.org
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
 <20240327-regulator-get-enable-get-votlage-v1-3-5f4517faa059@baylibre.com>
 <20240328142038.33ad68bc@jic23-huawei>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240328142038.33ad68bc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 07:20, Jonathan Cameron wrote:
> On Wed, 27 Mar 2024 18:18:52 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> We can reduce boilerplate code by using
>> devm_regulator_get_enable_get_voltage().
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> A few comments inline, but nothing substantial.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/hwmon/da9052-hwmon.c | 33 +++++++--------------------------
>>   1 file changed, 7 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
>> index 2bd7ae8100d7..70e7bc72e980 100644
>> --- a/drivers/hwmon/da9052-hwmon.c
>> +++ b/drivers/hwmon/da9052-hwmon.c
>> @@ -26,7 +26,6 @@ struct da9052_hwmon {
>>   	struct mutex		hwmon_lock;
>>   	bool			tsi_as_adc;
>>   	int			tsiref_mv;
>> -	struct regulator	*tsiref;
>>   	struct completion	tsidone;
>>   };
>>   
>> @@ -414,32 +413,19 @@ static int da9052_hwmon_probe(struct platform_device *pdev)
>>   		device_property_read_bool(pdev->dev.parent, "dlg,tsi-as-adc");
>>   
>>   	if (hwmon->tsi_as_adc) {
>> -		hwmon->tsiref = devm_regulator_get(pdev->dev.parent, "tsiref");
>> -		if (IS_ERR(hwmon->tsiref)) {
>> -			err = PTR_ERR(hwmon->tsiref);
>> -			dev_err(&pdev->dev, "failed to get tsiref: %d", err);
>> +		err = devm_regulator_get_enable_get_voltage(pdev->dev.parent,
>> +							    "tsiref");
>> +		if (err < 0)
>>   			return err;
>> -		}
>> -
>> -		err = regulator_enable(hwmon->tsiref);
>> -		if (err)
>> -			return err;
>> -
>> -		hwmon->tsiref_mv = regulator_get_voltage(hwmon->tsiref);
>> -		if (hwmon->tsiref_mv < 0) {
>> -			err = hwmon->tsiref_mv;
>> -			goto exit_regulator;
>> -		}
>>   
>>   		/* convert from microvolt (DT) to millivolt (hwmon) */
>> -		hwmon->tsiref_mv /= 1000;
>> +		hwmon->tsiref_mv = err / 1000;
>>
> 
> Using a variable called err for a good value is a bit ugly but fair enough if that
> is precedence in this driver.
> 

It isn't. The existing code assigns the return value from regulator_get_voltage()
to hwmon->tsiref_mv and then evaluates it. I would not oppose introducing a variable
such as tsiref_uv, but not the misuse of 'err'. I am not going to accept the code
as suggested. It is bad style, and it would invite others to use it as precedent
when trying to introduce similar code.

>>   }
>> @@ -483,10 +466,8 @@ static void da9052_hwmon_remove(struct platform_device *pdev)
>>   {
>>   	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
>>   
>> -	if (hwmon->tsi_as_adc) {
>> +	if (hwmon->tsi_as_adc)
>>   		da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);
> Superficially looks like devm_da9052_request_irq could be added that
> uses devm_request_threaded_irq() to allow dropping this remaining handling.
> 

That should be a separate series of patches. A local solution might be
to use devm_add_action_or_reset(), but that should also be a separate patch.

Thanks,
Guenter


