Return-Path: <linux-kernel+bounces-164382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E58B7CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A13A1C2295D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41017A93B;
	Tue, 30 Apr 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdqyy9LN"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F452B660;
	Tue, 30 Apr 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494709; cv=none; b=Su21bLtsFjrooZLVyrMKSeyVkp67w3af0w3E+35ji4yxeaJtwUu2AE1J3s7k8NVGEkNFQqYLs32aJvbxzC6VNMd9kpR4hkIajFSNKqwcMpiit1ED9yASZGTjcpqlSkX9OvyKOtyvKq0ypOYEukSTTVqBcXwPrOPyC/4kt+PJRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494709; c=relaxed/simple;
	bh=Qlj+LZXf2VoaxgRG3XS+GJ3XCSH0Ydr5hRABBdqxBDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehk7eUxQRxyjPYG2apgcwn//u0tQGJk6dr1N8ber7ErP+VOgggt0IwGgdhlS5eJ7zMWVNylRUzkmZDN/rM9pPfZ8xbhpD1ELDZOVIAKRktVQnNT8Yx1eyk2q2MHMvel4Zxh011m43u3PRXoxR9tvV/iX3bIhUY/rIu5LUTC0PVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdqyy9LN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b27c660174so795895a91.1;
        Tue, 30 Apr 2024 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494708; x=1715099508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WQN4KbcxjV5fEP83EPXO6Wtm42S0d0QxDy7zu6p3kS8=;
        b=fdqyy9LN9AKQpvdgM3PrV1/ievn1P8+H4uFYNuafkkXMQr3y0jKXD27vJL34Ayv3tk
         ZdxSca2EtR3tUhdnykSyK1xQJ/rTL2SeKJvvOV+rtuPMK1+1BWU6d7fToPTUuDPiGQkr
         b7PiuEcsMnbDPWmxSHgJuNW+PTVW7go3vIhqvqYVilSr45OqbHPvOYfr8nftK91Vu6s1
         aGUCnmlsygCw8w5WUd9BznW5FdpCtaYi9JnwMFxtBIDLbsegS3svL16GxMEzmOVQSjp6
         vEDenLkS7wva8hyP15ZA5e+y17qI2nwF+H+I9rt3y6Knvzw8oXsAAnIXA+t2bVOb1Ys5
         36IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494708; x=1715099508;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQN4KbcxjV5fEP83EPXO6Wtm42S0d0QxDy7zu6p3kS8=;
        b=vV2kyDnSg5s5yHIa+nfiAp0nia968gMTBu/gojxYNrctZOUT4EUSdstrOt2MknJAJd
         Hvcb7RG1RIf4UklcYjYhAb7COvC//LYiFu0KlyKtBI0rWeIp0BjpZYIWSI3a8MpvsGMp
         mDEVUCfL8eYQrWrrFyMkIwgotCP3nf+PfOTjs1QuZW2Ei+8VkvyQOESPsiefXEef9zme
         CrKoeGeltN2UH2cPMVzIWX8bUiPLP8EEszPbOFJVZ/D/cUVfnjFiDh6S8kZxEULYICU0
         sAvdBOgLCcibNtVgO5DcitImPf8YnYTlOS0ZFHl20xhYSQ91v4X4Cm1mlSqzbBQXW0hk
         iKWw==
X-Forwarded-Encrypted: i=1; AJvYcCVVKapwC2K839zp8rmww88HSbIZTVLxpHui9gS0heFecwVUdL0eZnUyhqUfdDE0QJXo1DzwqOCyUC7svFX3tTVR8A0mP3ljtT9BTI7vN8miTJMRPAQfXmQUJ96GsSULiH6JwRPXuozYfsf4bl7yic2qa8iT5OBQbx+7r21YdFhPHnYO7i6AVOhmfqJz+pwR1sNY9ckOVMNVap15YkN/J7oHe0O1q4Z5ttHhRLjSOvta/UcCm/nJ+o25OSmsJg==
X-Gm-Message-State: AOJu0YyTheXzIWobOfSF292EJ5tIakISQ9Gf/a/Ldb+DQu6D+5/OInS3
	nXasHSLHugqD+Y/5dmcDPuhOClkYe4zDoIcXQYQzM0N+oyZVn3SQ
X-Google-Smtp-Source: AGHT+IG0yCT0xYb1tKd+62Xy29JHRr1NLJOo6Huz8MNBkEhwOt6j9FCtyvd0drfG76Yj0Rkc017wXw==
X-Received: by 2002:a17:90a:a582:b0:2a2:eb67:b20a with SMTP id b2-20020a17090aa58200b002a2eb67b20amr9431121pjq.42.1714494707489;
        Tue, 30 Apr 2024 09:31:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qb13-20020a17090b280d00b002b1581a0fccsm4902669pjb.44.2024.04.30.09.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:31:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <39248b1f-f8ef-413d-87ff-62404f1effb5@roeck-us.net>
Date: Tue, 30 Apr 2024 09:31:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] hwmon: (adc128d818) Use
 devm_regulator_get_enable_read_voltage()
To: David Lechner <dlechner@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Support Opensource <support.opensource@diasemi.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-input@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
 <20240429-regulator-get-enable-get-votlage-v2-2-b1f11ab766c1@baylibre.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-2-b1f11ab766c1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 16:40, David Lechner wrote:
> We can reduce boilerplate code and eliminate the driver remove()
> function by using devm_regulator_get_enable_read_voltage().
> 
> A new external_vref flag is added since we no longer have the handle
> to the regulator to check if it is present.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Nit below in case you resend, otherwise

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v2 changes:
> * rename to devm_regulator_get_enable_read_voltage()
> * use vref instead of err for return value
> * simplify last error check to return PTR_ERR directly
> ---
>   drivers/hwmon/adc128d818.c | 57 ++++++++++++++--------------------------------
>   1 file changed, 17 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
> index 46e3c8c50765..2a35acb011eb 100644
> --- a/drivers/hwmon/adc128d818.c
> +++ b/drivers/hwmon/adc128d818.c
> @@ -58,7 +58,6 @@ static const u8 num_inputs[] = { 7, 8, 4, 6 };
>   
>   struct adc128_data {
>   	struct i2c_client *client;
> -	struct regulator *regulator;
>   	int vref;		/* Reference voltage in mV */
>   	struct mutex update_lock;
>   	u8 mode;		/* Operation mode */
> @@ -389,7 +388,7 @@ static int adc128_detect(struct i2c_client *client, struct i2c_board_info *info)
>   	return 0;
>   }
>   
> -static int adc128_init_client(struct adc128_data *data)
> +static int adc128_init_client(struct adc128_data *data, bool external_vref)
>   {
>   	struct i2c_client *client = data->client;
>   	int err;
> @@ -408,7 +407,7 @@ static int adc128_init_client(struct adc128_data *data)
>   		regval |= data->mode << 1;
>   
>   	/* If external vref is selected, configure the chip to use it */
> -	if (data->regulator)
> +	if (external_vref)
>   		regval |= 0x01;
>   
>   	/* Write advanced configuration register */
> @@ -430,9 +429,9 @@ static int adc128_init_client(struct adc128_data *data)
>   static int adc128_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> -	struct regulator *regulator;
>   	struct device *hwmon_dev;
>   	struct adc128_data *data;
> +	bool external_vref;
>   	int err, vref;
>   
>   	data = devm_kzalloc(dev, sizeof(struct adc128_data), GFP_KERNEL);
> @@ -440,20 +439,15 @@ static int adc128_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	/* vref is optional. If specified, is used as chip reference voltage */
> -	regulator = devm_regulator_get_optional(dev, "vref");
> -	if (!IS_ERR(regulator)) {
> -		data->regulator = regulator;
> -		err = regulator_enable(regulator);
> -		if (err < 0)
> -			return err;
> -		vref = regulator_get_voltage(regulator);
> -		if (vref < 0) {
> -			err = vref;
> -			goto error;
> -		}
> -		data->vref = DIV_ROUND_CLOSEST(vref, 1000);
> -	} else {
> +	vref = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (vref == -ENODEV) {
> +		external_vref = false;
>   		data->vref = 2560;	/* 2.56V, in mV */
> +	} else if (vref < 0) {
> +		return vref;
> +	} else {
> +		external_vref = true;
> +		data->vref = DIV_ROUND_CLOSEST(vref, 1000);
>   	}
>   
>   	/* Operation mode is optional. If unspecified, keep current mode */
> @@ -461,13 +455,12 @@ static int adc128_probe(struct i2c_client *client)
>   		if (data->mode > 3) {
>   			dev_err(dev, "invalid operation mode %d\n",
>   				data->mode);
> -			err = -EINVAL;
> -			goto error;
> +			return -EINVAL;
>   		}
>   	} else {
>   		err = i2c_smbus_read_byte_data(client, ADC128_REG_CONFIG_ADV);
>   		if (err < 0)
> -			goto error;
> +			return err;
>   		data->mode = (err >> 1) & ADC128_REG_MASK;
>   	}
>   
> @@ -476,31 +469,16 @@ static int adc128_probe(struct i2c_client *client)
>   	mutex_init(&data->update_lock);
>   
>   	/* Initialize the chip */
> -	err = adc128_init_client(data);
> +	err = adc128_init_client(data, external_vref);
>   	if (err < 0)
> -		goto error;
> +		return err;
>   
>   	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>   							   data, adc128_groups);
> -	if (IS_ERR(hwmon_dev)) {
> -		err = PTR_ERR(hwmon_dev);
> -		goto error;
> -	}
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
>   
>   	return 0;

	return PTR_ERR_OR_ZERO(hwmon_dev);

> -
> -error:
> -	if (data->regulator)
> -		regulator_disable(data->regulator);
> -	return err;
> -}
> -
> -static void adc128_remove(struct i2c_client *client)
> -{
> -	struct adc128_data *data = i2c_get_clientdata(client);
> -
> -	if (data->regulator)
> -		regulator_disable(data->regulator);
>   }
>   
>   static const struct i2c_device_id adc128_id[] = {
> @@ -522,7 +500,6 @@ static struct i2c_driver adc128_driver = {
>   		.of_match_table = of_match_ptr(adc128_of_match),
>   	},
>   	.probe		= adc128_probe,
> -	.remove		= adc128_remove,
>   	.id_table	= adc128_id,
>   	.detect		= adc128_detect,
>   	.address_list	= normal_i2c,
> 


