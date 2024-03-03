Return-Path: <linux-kernel+bounces-89891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F786F6F4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460B1B2105A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2F79DC2;
	Sun,  3 Mar 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNN7a6Gr"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2279DAB;
	Sun,  3 Mar 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709496336; cv=none; b=SkJ2EUk/BILo6CmASihYSHuzLEAixR4iNnHwAYWQNStv/5fzREkxBVBBb4+LDs9LcY8w3YFuW0mOaLigsL4AlH6oYf3r26p+YyPIvuA+qS2nY3T9WLtoGTKNmsH9XU+n4SW+YQNMKRRYlqIBgnzX3RMypNbSiCjg0Bk8/h55c0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709496336; c=relaxed/simple;
	bh=mSc6/9DZ5vAhGlhAM+TSNJtNJSKbaDlFsVdJobh767k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKJ6DFLzBxPsTTPhSYzC9kE/6A6pmJpizW9th8Nhq3evHMpdnlWo09iZnR+XGJctuo10ax4uTMsN9e/VKP28+PjuwsOq9Qm+VCQh+eRcwQx0G9wUWyvk26G3sEdp/D53NWlRC2rBEoC3iPI6voJ78DxyfW/ED7am9mwE91QhImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNN7a6Gr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4554d4cb62so12083166b.2;
        Sun, 03 Mar 2024 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709496332; x=1710101132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htSk0pROujaKN4qxYLFUMLnC6DIqzsYsrcCbXo4CNs0=;
        b=YNN7a6GrzUdC9t1zbESnvWpP5KXLhdhuPcinWPawt72rQQmnlGyozOwx5mo9m0jkF1
         nlt+Fz+Ac2GErcmtCBuslsE0iIlOU+es67D0gi/cUXyK2gc4GrzEZh5AYET6gCm7S8C2
         48rUBzyYnSAlP5JLQhsTgHbtM8c2k9LZgCqEerkTVGadsKPF/KzuzLuyvTqYY1pvxcn5
         Uec15PKe0BA3DIdWtkSjcoChc5sz3w8rZaZkr/Unk8Hk1Mg7OOhTdyb4E8aqrpn+nbHs
         vZOA0Yqxkn3IsBGCjxmHhAC01GKnGzfaGrWbEO8qhu8KhIlQ/VpcDhadpDVr3lpqg75L
         45jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709496332; x=1710101132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htSk0pROujaKN4qxYLFUMLnC6DIqzsYsrcCbXo4CNs0=;
        b=LydBnBZR4fPNlUUf4EAOj7ICRGmMEN15JARr8pBX0NJeEGeAolhsWci/VI6ZHtSVku
         hDcl6pP7If9r31+ueZ+76wPzwNkFraE2Ad3+wuiHWzxQPBrN9NCgOPsr4LbNlj6OGMAG
         AtPBGbUbYmptCkn9Vc59XeTTB5rz3Foxes4/nsHdsEbp9V0U1WeqyaQb7WU+HZisXrq7
         Z8ZdbEEnAI2jCPRriPrPi+vzuJuUJsnqzoFqj6tq/jJ15h/BKNvq4tu7wi4ZvK5FMtuE
         y5z/dvDnBgyii0AHyJjljdrwSaAIPlgYP3QqtKhJsBQ8ijyfJSyKR1DwB3K8ZRBpq5fw
         yngw==
X-Forwarded-Encrypted: i=1; AJvYcCXOBLo8VaMajuZp/0pKSJ6+371p2aPKZVP+jZOye4/ABHVbM7XTaPF/I3Xa53MRsRspPNzpBuuCXsoscu/rQvyiaMoDlH7RvpUi7SK+RXFauzTX9uePl7v2A1y0QMoBgoYTu9Bphh97Syh6iAUeh6wb4jXKwmfTQpnuWqxY7J/2nkty0A==
X-Gm-Message-State: AOJu0YwLnNk7g+zsr9r6xf9iBwZRWNrSLHUZTwMU/XCkpI5Nb5G/VBzy
	vNRyR17SMUo04nju1/b/53oXvbUnSnOYg4DaGTxH5SgRsaN297TW
X-Google-Smtp-Source: AGHT+IFfzg5+j8Pd1ccg/DNJiXDPOAn9VJsCUGN78HHF1NINXncqxHsQQ8eVbSFDTxHD9kHorfuTIQ==
X-Received: by 2002:a17:906:c411:b0:a44:e3c:c4dd with SMTP id u17-20020a170906c41100b00a440e3cc4ddmr4923065ejz.48.1709496332197;
        Sun, 03 Mar 2024 12:05:32 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:b3d8:5b4b:5188:4373? (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id pv18-20020a170907209200b00a44b90abb1dsm2347509ejb.110.2024.03.03.12.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 12:05:31 -0800 (PST)
Message-ID: <fc81f249-7996-48f4-8573-5e20509c796c@gmail.com>
Date: Sun, 3 Mar 2024 21:05:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: humidity: hdc3020: add power management
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
 <20240226-hdc3020-pm-v2-1-cec6766086e8@gmail.com>
 <20240303163106.25dbf4e5@jic23-huawei>
Content-Language: en-US, en-GB
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240303163106.25dbf4e5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 03.03.24 17:31, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 22:25:55 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The HDC3020 sensor carries out periodic measurements during normal
>> operation, but as long as the power supply is enabled, it will carry on
>> in low-power modes. In order to avoid that and reduce power consumption,
>> the device can be switched to Trigger-on Demand mode, and if possible,
>> turn off its regulator.
>>
>> According to the datasheet, the maximum "Power Up Ready" is 5 ms.
>>
>> Add resume/suspend pm operations to manage measurement mode and
>> regulator state.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Hi Javier,
> 
> I think you leave the power on in a bunch of error paths in the probe()
> 
> Thanks,
> 
> Jonathan
> 
> 
>> ---
>>  drivers/iio/humidity/hdc3020.c | 89 ++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 73 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
>> index 1e5d0d4797b1..6848be41e1c8 100644
>> --- a/drivers/iio/humidity/hdc3020.c
>> +++ b/drivers/iio/humidity/hdc3020.c
>> @@ -20,6 +20,8 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/pm.h>
>> +#include <linux/regulator/consumer.h>
>>  #include <linux/units.h>
>>  
>>  #include <asm/unaligned.h>
>> @@ -68,6 +70,7 @@
>>  
>>  struct hdc3020_data {
>>  	struct i2c_client *client;
>> +	struct regulator *vdd_supply;
>>  	/*
>>  	 * Ensure that the sensor configuration (currently only heater is
>>  	 * supported) will not be changed during the process of reading
>> @@ -551,9 +554,45 @@ static const struct iio_info hdc3020_info = {
>>  	.write_event_value = hdc3020_write_thresh,
>>  };
>>  
>> -static void hdc3020_stop(void *data)
>> +static int hdc3020_power_off(struct hdc3020_data *data)
>>  {
>> -	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
>> +	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
>> +
>> +	return regulator_disable(data->vdd_supply);
>> +}
>> +
>> +static int hdc3020_power_on(struct hdc3020_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = regulator_enable(data->vdd_supply);
>> +	if (ret)
>> +		return ret;
>> +
>> +	fsleep(5000);
>> +
>> +	if (data->client->irq) {
>> +		/*
>> +		 * The alert output is activated by default upon power up,
>> +		 * hardware reset, and soft reset. Clear the status register.
>> +		 */
>> +		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
>> +		if (ret) {
>> +			hdc3020_power_off(data);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
>> +	if (ret)
>> +		hdc3020_power_off(data);
>> +
>> +	return ret;
>> +}
>> +
>> +static void hdc3020_exit(void *data)
>> +{
>> +	hdc3020_power_off(data);
>>  }
>>  
>>  static int hdc3020_probe(struct i2c_client *client)
>> @@ -569,6 +608,8 @@ static int hdc3020_probe(struct i2c_client *client)
>>  	if (!indio_dev)
>>  		return -ENOMEM;
>>  
>> +	dev_set_drvdata(&client->dev, (void *)indio_dev);
> No need for casting to void *

Then I plagiarised the wrong driver :D I will remove it for v3.

> 
>> +
>>  	data = iio_priv(indio_dev);
>>  	data->client = client;
>>  	mutex_init(&data->lock);
>> @@ -580,6 +621,16 @@ static int hdc3020_probe(struct i2c_client *client)
>>  	indio_dev->info = &hdc3020_info;
>>  	indio_dev->channels = hdc3020_channels;
>>  	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
>> +
>> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
>> +	if (IS_ERR(data->vdd_supply))
>> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
>> +				     "Unable to get VDD regulator\n");
>> +
>> +	ret = hdc3020_power_on(data);
>> +	if (ret)
>> +		return dev_err_probe(&client->dev, ret, "Power on failed\n");
> 
> Any error after this point needs to power down the regulator and stop the device.
> So the devm_add_action_or_reset needs to be here, not down below.
> 
> When adding this sort of automated handling walk through the various paths
> to check where they diverge.  If you can put the cleanup code right after
> what it cleans up, then you get much less divergence where (in this case)
> the power gets left on.
> 

If I am not mistaken, the only case where the regulator will not be
powered down is if an irq is defined and the threaded irq request fails,
because the next action is a call to devm_add_action_or_reset. A single
case is still greater than zero, so I will move the
devm_add_function_or_reset up to be the next action after powering up.

Thanks and best regards,
Javier Carrasco

