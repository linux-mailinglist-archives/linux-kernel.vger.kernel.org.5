Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2039E7E6CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjKIOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:55:29 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF72325B;
        Thu,  9 Nov 2023 06:55:26 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7dd65052aso11900107b3.0;
        Thu, 09 Nov 2023 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699541726; x=1700146526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bG8SxMPJCjkka3R2BtI4xsviL/neqgOy30fTWVbevYU=;
        b=m1dPtdkqmbYDrlrV0nOTTNtkaxdUggqcRSrQPK3F33X1srCE8MFWBEL2qZ7LjoDfL8
         TsapkeSXFfE2O1QC03arpZdwwaUXw6skxoAMSLe5FyzCHdpgm8+YopkpSkJe0ow8yxG1
         qBxyGJV1KDeglV8L4zhRs0DN8Y9Dslf3Wjr0m7tS3PX9E3itoaTAXyYhYnXeXH/3yG9s
         mWWI0uzGtCkWYLqJKtZ+yAJNnuqP0p52k1hxxHN2mDF3BA7+Me0PVvoeFVmYce1eRXe4
         IiDACxnpHccPtHOIO1/7AQnv9gJhWJtxyop0ge6dzOJMyAkEg1gnqfkIS94gHMd1J3w8
         djSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699541726; x=1700146526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bG8SxMPJCjkka3R2BtI4xsviL/neqgOy30fTWVbevYU=;
        b=gIna58SnjYMijhN+aQ3gYy/TVW6BeAVJ93VM3DF7bo2147OxSX7ZgkUaX5MK4JkB7z
         jqqqXB2KZpVSq+wxGnG/X9jYLtQ4Ea3mxF6npZdnUbt4tdsyWuGBtZZfozdPp1FpH8F2
         aD3BC2YExriYypS4mAbN1iQ6UD2eLsnnUFdJOYN+8MriZvHz5Nl0aWN4YMKMjb1Ap7nu
         sdVO6i5frlJS6j7JsAHDuanurpBKQgw9U6djDg16Qo8Ra4m0PnkhgaPgIf82tB4TNmEW
         ecpUA5P1dLFI7ajmSbMwmp9qDe9FcIzwSr8zQzhaf31+a3x9EYcW0GN/Vk753EWJKLnJ
         SSQg==
X-Gm-Message-State: AOJu0YwCCwuoEs/MDdTQwMbYTqoP6tqVTK/YEoBWkTWGx+OvrI3nT9XG
        csDSw8OA9nikhxX9T4T1XyrQi14O5Z0=
X-Google-Smtp-Source: AGHT+IFp6OopAvQN0Db1VUA78vdNCVvMth/yDWisq4joQocnTzVfsQbViTeFYq2EBGzxjuGwYSeE4g==
X-Received: by 2002:a0d:d7c8:0:b0:59b:5170:a0f3 with SMTP id z191-20020a0dd7c8000000b0059b5170a0f3mr5314115ywd.36.1699541725948;
        Thu, 09 Nov 2023 06:55:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z127-20020a814c85000000b005a7db2a0dddsm7993446ywa.3.2023.11.09.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 06:55:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d5692ab7-6d11-41f3-89ec-246a2fc045a8@roeck-us.net>
Date:   Thu, 9 Nov 2023 06:55:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hwmon: Add support for Amphenol ChipCap 2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-3-f5c325966fdb@gmail.com>
 <30ccb0a9-c0bd-491e-817f-def0aeda11c6@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <30ccb0a9-c0bd-491e-817f-def0aeda11c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 00:52, Krzysztof Kozlowski wrote:
> On 08/11/2023 16:37, Javier Carrasco wrote:
>> The Amphenol ChipCap 2 is a capacitive polymer humidity and temperature
>> sensor with an integrated EEPROM and minimum/maximum humidity alarms.
>>
>> All device variants offer an I2C interface and depending on the part
>> number, two different output modes:
>> - CC2D: digital output
>> - CC2A: analog (PDM) output
>>
>> This driver adds support for the digital variant (CC2D part numbers),
>> which is also divided into two subfamilies [1]:
>> - CC2DXX: non-sleep measurement mode
>> - CC2DXXS: sleep measurement mode
> 
> ...
> 
>> +
>> +static int cc2_probe(struct i2c_client *client)
>> +{
>> +	struct cc2_data *data;
>> +	struct device *dev = &client->dev;
>> +	enum cc2_ids chip;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>> +		return -EOPNOTSUPP;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, data);
>> +
>> +	mutex_init(&data->i2c_lock);
>> +	mutex_init(&data->alarm_lock);
>> +
>> +	data->client = client;
>> +
>> +	if (client->dev.of_node)
>> +		chip = (uintptr_t)of_device_get_match_data(&client->dev);
>> +	else
>> +		chip = i2c_match_id(cc2_id, client)->driver_data;
>> +
>> +	data->config = &cc2_config[chip];
>> +
>> +	ret = cc2_request_ready_irq(data, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
>> +	if (!IS_ERR(data->regulator)) {
>> +		ret = cc2_retrive_alarm_config(data);

fwiw, s/retrive/retrieve/g

>> +		if (ret)
>> +			goto cleanup;
>> +	} else {
>> +		/* No access to EEPROM without regulator: no alarm control */
>> +		goto dev_register;
> 
> Nothing improved here.
> 
> Do not send new version of patchset before discussion finishes.
> 

This driver will take a while to review due to its complexity.

As for the code above: Error handling goes first. Something like
the above, where the error case is just a goto, is unacceptable and
just increases indentation level for the other code and makes it
more difficult to read. Also, the above code _will_ have to handle
error cases other than -ENODEV. Besides deferred probe, it is
completely inappropriate to ignore -EINVAL or -ENOMEM or any other
error codes other than -ENODEV.

>> +	}
>> +
>> +	ret = cc2_request_alarm_irqs(data, dev);
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +dev_register:
>> +	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
>> +							   data, &cc2_chip_info,
>> +							   NULL);
>> +	if (IS_ERR(data->hwmon)) {
>> +		ret = PTR_ERR(data->hwmon);
>> +		goto cleanup;
>> +	}
>> +
>> +	return 0;
>> +
>> +cleanup:
>> +	if (cc2_disable(data))
>> +		dev_dbg(dev, "Failed to disable device");
>> +
>> +	return dev_err_probe(dev, ret,
>> +			     "Unable to register hwmon device\n");
> 
> Drop or move to each error path.
> 
This actually follows Documentation/process/coding-style.rst, chapter 7
(Centralized exiting of functions).

Guenter

