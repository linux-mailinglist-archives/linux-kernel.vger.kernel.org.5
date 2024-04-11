Return-Path: <linux-kernel+bounces-140420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D188A142D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BEDB23884
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06114D282;
	Thu, 11 Apr 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Mq+Qdu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885414AD3F;
	Thu, 11 Apr 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837688; cv=none; b=Llymngn9zNe0t49BC/SsFs0Uj3wBIQxHdUkfrdCugM5zkGidjZVY0mRYEeqd8YD/2z471+BcksODPaXLbXS1Tdyifu6JuOv/Yssgt1C1uBOYVNI09DqIcADUij82ELzLCdjjwNoBvecUoY3G5x71Mnx9sshUoYCERncQlw4HQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837688; c=relaxed/simple;
	bh=RUl+QWd8enSSvh6ykwOTsBnREkBzg1M3uBmYrds8Jjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1B/Udw5/JqqsBX0sSP+CbmQt5HfYoiKeb+/SrV6ai3HbZM7JWCKhL7xgVgj1zLLp22QVmzUSu6JTbRDT+nZVWn7INCjtFMVIrfpc/czSbJ1iugk90WeBjGLAIFhBlmpZE9tX+j2tNsZRkFI9W0e/BLM/oVh7JtcMy3rkX//PHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4Mq+Qdu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516cdb21b34so9958716e87.1;
        Thu, 11 Apr 2024 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712837685; x=1713442485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysFeYDwZfdBP6eAJyjL7pl3NewUWcv21Q9BY6HZV9Y4=;
        b=l4Mq+QduCrVhfftKYEMXJha3SN+3Uu8sotU08gFFatZGXJ/dE1a15U++u/pvsq2WBe
         seF0fY7DHwLFUPDbXEhBhSxhFhnhqX5O9rWKOnCnldKJKYN8uJc9x40Y4Tl0B3Hkh+I9
         c3etfnc/LGuPoEq+AyJRXR8/Q5lT9E8FPGPnlTrlKJufWUX1bvNaJw9QM6ptgdAI5KsX
         E0xpCK1TefmwikZ5KUN4gDKxPjSgN9n4FLNinsm4D758/RNJO5dR1toUHN/r+5GkDN4v
         ILgP8mJ6j5UWG3lt8kL+iqWjKlcoNoA/vhtWvnGQMpvcM8sw6Za8vRiXv4mAhhOEroYl
         +3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837685; x=1713442485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysFeYDwZfdBP6eAJyjL7pl3NewUWcv21Q9BY6HZV9Y4=;
        b=YP5kBLDO20DgJpD9qU2N/tVevkxcxPigdRr8R4NtiAEIUTn5WFxMfmLzPzHMcNEG+W
         II5ezvvHN2qyc92GpnXCtdQ6+uUNHRDg4n4qMXMyy2a5UJCpWZo+EYvIfJQEFvhALdj7
         0eP4NvaSftN3oi8/W1AZ3F6XbNwmZxK3GTN2YwWLQJUGotPjB+Rhula7eB4+hGuPinQp
         lp8gLHad9ey2Q+dFbHl6yAsUQPb3gnUHeXXEWwgwKnH9SIY5OZknStx4menb+nYA1vna
         vw01BzGQlrfMFQa0M9SMbdW0pQGFxAtUPN/4OsUJ5CPgaeRyt2Ju85AzjYKaxTLgrMsd
         DD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhhO8jisCmKltj7j+wX3SJQOhQe9xdjRuu6YJ+YvDr494wf+lXwAsc283h0AAQfED+IlFiG0i78mezVGaG85OeRMLFje5SbIzrMWHUIqUx8vJY/lhrUqZKGzA0/xDYinE0/4sqWnG9rw==
X-Gm-Message-State: AOJu0YyR7d/yQEysKgqE05Q91kvme4hrRcgVNLV4WYS4SQB00fqcNw+s
	FAOV916Re6F4j1+HGvZDoCnU06z2lJlCm4m758kHZW9YTFcP1e83kKjcZA==
X-Google-Smtp-Source: AGHT+IGhmqiyGGfGnpTGQ2sUSdzrGNKWg+Q/IP3OfsnffpvoUxBTIde1JnbAwpbLxmT5iwKj2kJTgQ==
X-Received: by 2002:a05:6512:ba0:b0:518:69c5:c027 with SMTP id b32-20020a0565120ba000b0051869c5c027mr933115lfv.18.1712837684844;
        Thu, 11 Apr 2024 05:14:44 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j5-20020ac25505000000b00517374e92ecsm194300lfk.93.2024.04.11.05.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 05:14:44 -0700 (PDT)
Message-ID: <f89d63ca-1db2-47fa-8d66-943fc7454643@gmail.com>
Date: Thu, 11 Apr 2024 15:14:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mfd: rohm-bd71828: Add power off functionality
Content-Language: en-US, en-GB
To: Lee Jones <lee@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402111700.494004-1-andreas@kemnade.info>
 <20240402111700.494004-3-andreas@kemnade.info>
 <20240411115047.GI1980182@google.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240411115047.GI1980182@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 14:50, Lee Jones wrote:
> On Tue, 02 Apr 2024, Andreas Kemnade wrote:
> 
>> Since the chip can power off the system, add the corresponding
>> functionality.
>> Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
>>
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/mfd/rohm-bd71828.c       | 36 +++++++++++++++++++++++++++++++-
>>   include/linux/mfd/rohm-bd71828.h |  3 +++
>>   2 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
>> index 594718f7e8e1..4a1fa8a0d76a 100644
>> --- a/drivers/mfd/rohm-bd71828.c
>> +++ b/drivers/mfd/rohm-bd71828.c
>> @@ -464,6 +464,27 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
>>   				  OUT32K_MODE_CMOS);
>>   }
>>   
>> +static struct i2c_client *bd71828_dev;
>> +static void bd71828_power_off(void)
>> +{
>> +	while (true) {
>> +		s32 val;
>> +
>> +		/* We are not allowed to sleep, so do not use regmap involving mutexes here. */
>> +		val = i2c_smbus_read_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1);
>> +		if (val >= 0)
>> +			i2c_smbus_write_byte_data(bd71828_dev,
>> +						  BD71828_REG_PS_CTRL_1,
>> +						  BD71828_MASK_STATE_HBNT | (u8)val);
>> +		mdelay(500);
>> +	}
>> +}
>> +
>> +static void bd71828_remove_poweroff(void *data)
>> +{
>> +	pm_power_off = NULL;
>> +}
>> +
>>   static int bd71828_i2c_probe(struct i2c_client *i2c)
>>   {
>>   	struct regmap_irq_chip_data *irq_data;
>> @@ -542,7 +563,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
>>   	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
>>   				   NULL, 0, regmap_irq_get_domain(irq_data));
>>   	if (ret)
>> -		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
>> +		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
>> +
>> +	if (of_device_is_system_power_controller(i2c->dev.of_node) &&
>> +	    chip_type == ROHM_CHIP_TYPE_BD71828) {
>> +		if (!pm_power_off) {
>> +			bd71828_dev = i2c;
>> +			pm_power_off = bd71828_power_off;
>> +			ret = devm_add_action_or_reset(&i2c->dev,
>> +						       bd71828_remove_poweroff,
>> +						       NULL);
>> +		} else {
>> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
>> +		}
>> +	}
>>   
>>   	return ret;
>>   }
>> diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
>> index 3b5f3a7db4bd..9776fde1262d 100644
>> --- a/include/linux/mfd/rohm-bd71828.h
>> +++ b/include/linux/mfd/rohm-bd71828.h
>> @@ -4,6 +4,7 @@
>>   #ifndef __LINUX_MFD_BD71828_H__
>>   #define __LINUX_MFD_BD71828_H__
>>   
>> +#include <linux/bits.h>
>>   #include <linux/mfd/rohm-generic.h>
>>   #include <linux/mfd/rohm-shared.h>
>>   
>> @@ -41,6 +42,8 @@ enum {
>>   #define BD71828_REG_PS_CTRL_2		0x05
>>   #define BD71828_REG_PS_CTRL_3		0x06
>>   
>> +#define BD71828_MASK_STATE_HBNT		BIT(1)
>> +
>>   //#define BD71828_REG_SWRESET		0x06
> 
> How did this get in here?

Don't blame me, blame git... Errm... :)
[mvaittin@fedora linux]$ git blame include/linux/mfd/rohm-bd71828.h 
|grep \/\/
1c743ad523bb2 (Matti Vaittinen 2020-01-20 15:43:28 +0200  44) //#define 
BD71828_REG_SWRESET		0x06
1c743ad523bb2 (Matti Vaittinen 2020-01-20 15:43:28 +0200 136) //#define 
BD71828_REG_LDO6_VOLT		0x4

I can send a clean-up patch unless you want to do it while applying 
other stuff...

Yours,
	Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


