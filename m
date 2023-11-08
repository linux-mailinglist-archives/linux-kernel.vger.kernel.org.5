Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F127E5B54
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjKHQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:35:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D741BD5;
        Wed,  8 Nov 2023 08:35:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso11924815a12.0;
        Wed, 08 Nov 2023 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699461339; x=1700066139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvouIN0YpD/yy/djLXDg6nn9IovU0Wm0hli2iufjcKA=;
        b=m+MXCZUV/8bOZKKOunH60EhC6c/t4JNJblQPCseqsc4HdNMO6tdu10Z/CZwH9pslkC
         Xc2AgC8GS1cgXIBJ2/A94o6j/KwMxlnFLu8tR/DTQkVa2V82BLL6D76D98HThoHaUQmp
         EvJAUDpqDB79F+p6SutGKCYrdQtTeUnrupPWRzSYK14zFk+yJlRAINzempMj+WOu+5e+
         orqlXimlK+hi/9/cXaqPVXXNhbsFN2LSAhHiqEEsUp0aQ6P8kJyzxIeULmiAiqeCsHsj
         vSU+ZTErARn4ve2jnd6MJcC0U6rC0wsb8SkovY/cALcS9EC/6KyiP7ikh2+Ard5C/HOV
         oxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699461339; x=1700066139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvouIN0YpD/yy/djLXDg6nn9IovU0Wm0hli2iufjcKA=;
        b=C+qD5HFURKrIdcxtG8lfU/UKGoYJ1nRrbpQoKKiddyNglta0u2z4gW33i4ir1Uijnu
         hNyoB14qen8GDaBJzoS5EWd7lEkg3PUinQ9XnnINnINh7Dr5bdgKOKGU5RiFmhS1F8CI
         O0n3r23fF96zD4GyL4PP91LF/Zlp8amv4heW6lXeOugKg2hIYAMViUZYpkx5khcbxAhG
         o9YddsVOxMsgtRNNSBkNTnUMBiwMDuhnpmxV3Yzx/Gxwkwg/vkNCdjM+Cr/Kyl10fIEq
         dibzBeq0jQRAQ6grEjfGjN85z4zhh5Zwurlt/PWgstyFv3fP52tjp0J5t5sJlvGJmaIL
         jzHw==
X-Gm-Message-State: AOJu0YyeNChJ7kH/yNs2pSx+gjpbZ2fnb2YaOu/LprQInqOmBEDZ8+xE
        X6/F5NDNy3+KWoJTpD9WCWo=
X-Google-Smtp-Source: AGHT+IFd/I774pG5xdTfFweEK6MrxA5t/byqxrO/VrHSbCnaAaaskp1vo/lKOiFn0N8EOXvliS+oUw==
X-Received: by 2002:a50:ab10:0:b0:540:346c:7b2f with SMTP id s16-20020a50ab10000000b00540346c7b2fmr1836190edc.40.1699461338679;
        Wed, 08 Nov 2023 08:35:38 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:840c:82c6:68fb:9a49? (2a02-8389-41cf-e200-840c-82c6-68fb-9a49.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:840c:82c6:68fb:9a49])
        by smtp.gmail.com with ESMTPSA id i14-20020aa7c9ce000000b0053fa13e27dcsm6869714edt.48.2023.11.08.08.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 08:35:38 -0800 (PST)
Message-ID: <285ec1d8-d277-403c-961f-3de523fc799f@gmail.com>
Date:   Wed, 8 Nov 2023 17:35:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hwmon: Add support for Amphenol ChipCap 2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com>
 <20231020-topic-chipcap2-v1-3-087e21d4b1ed@gmail.com>
 <e58cdedb-1825-4713-9d3f-5239bb182230@linaro.org>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <e58cdedb-1825-4713-9d3f-5239bb182230@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.11.23 13:41, Krzysztof Kozlowski wrote:
> On 08/11/2023 13:29, Javier Carrasco wrote:
>> The Telaire ChipCap 2 is a capacitive polymer humidity and temperature
>> sensor with an integrated EEPROM and minimum/maximum humidity alarms.
>>
>> All device variants offer an I2C interface and depending on the part
>> number, two different output modes:
>> - CC2D: digital output
>> - CC2A: analog (PDM) output
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dd5de540ec0b..63361104469f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21572,6 +21572,14 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
>>  F:	drivers/media/i2c/ds90*
>>  F:	include/media/i2c/ds90*
>>  
>> +TI CHIPCAP 2 HUMIDITY-TEMPERATURE IIO DRIVER
> 
> Why this is TI?
> 
> Bindings say Amphenol. Subject as well. Commit msg says Telaire. Here
> you write Texas Instruments.
> 
> Three different companies used. How possibly we could understand this?
> 
> 
>> +M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> +L:	linux-hwmon@vger.kernel.org
>> +S:	Maintained
> 
> ...
> 
>> +
>> +/* Command mode is only accessible in the first 10 ms after power-up, but the
>> + * device does not provide any kind of reset. In order to access the command
>> + * mode during normal operation, a power cycle must be triggered.
>> + */
> 
> 
> Please use full comment style, as described in Coding Style document.
> 
> ...
> 
>> +
>> +static const struct hwmon_ops cc2_hwmon_ops = {
>> +	.is_visible = cc2_is_visible,
>> +	.read = cc2_read,
>> +	.write = cc2_write,
>> +};
>> +
>> +static const struct hwmon_chip_info cc2_chip_info = {
>> +	.ops = &cc2_hwmon_ops,
>> +	.info = cc2_info,
>> +};
>> +
>> +static const struct cc2_config cc2dxx_config = {
>> +	.measurement = cc2dxx_meas,
>> +};
>> +
>> +static const struct cc2_config cc2dxxs_config = {
>> +	.measurement = cc2dxxs_meas,
>> +};
>> +
>> +static const struct of_device_id cc2_of_match[] = {
>> +	{ .compatible = "amphenol,cc2dxx",
>> +	  .data = &cc2dxx_config,
>> +	},
>> +	{ .compatible = "amphenol,cc2dxxs",
> 
> Format it as in other sources. Don't introduce your own codings style.
> 
>> +	  .data = &cc2dxxs_config,
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, cc2_of_match);
> 
> Keep ID tables together.
> 
>> +
>> +static int cc2_probe(struct i2c_client *client)
>> +{
>> +	struct cc2_data *data;
>> +	struct device *dev = &client->dev;
>> +	const struct of_device_id *match;
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
>> +	match = i2c_of_match_device(cc2_of_match, client);
>> +	if (!match)
>> +		return -ENODEV;
>> +
>> +	data->config = match->data;
>> +
>> +	ret = cc2_request_ready_irq(data, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
>> +	if (!IS_ERR(data->regulator)) {
>> +		ret = cc2_retrive_alarm_config(data);
>> +		if (ret)
>> +			goto cleanup;
>> +	} else {
>> +		/* No access to EEPROM without regulator: no alarm control */
> 
> Test your code with deferred probe. Are you sure you handle it
> correctly? To me, it looks like you handle deferred probe the same as
> any error.
> 
The -EPROBE_DEFER is propagated to the probe function and it is the
returned value. I clarified the error path in v2 so no error messages
are displayed in that case, going directly to the dev_err_probe in the
probe cleanup.
When the EPROBE_DEFER error is returned, the probe function is deferred
and called again later on, which is the desired behavior.

>> +		goto dev_register;
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
>> +	if (IS_ERR(data->hwmon))
>> +		return dev_err_probe(dev, PTR_ERR(data->hwmon),
>> +				     "Unable to register hwmon device\n");
>> +
>> +	return 0;
>> +
>> +cleanup:
>> +	if (cc2_disable(data))
>> +		dev_dbg(dev, "Failed to disable device");
>> +
>> +	return ret;
>> +}
>> +
>> +static void cc2_remove(struct i2c_client *client)
>> +{
>> +	struct cc2_data *data = i2c_get_clientdata(client);
>> +	int ret = cc2_disable(data);
>> +
>> +	if (ret)
>> +		dev_dbg(&client->dev, "Failed to disable device");
>> +}
>> +
>> +static const struct i2c_device_id cc2_id[] = { { "chipcap2", 0 }, {} };
> 
> Use style like in other files.
> git grep i2c_device_id
> 
> BTW, having mismatched entries looks error-prone. Why do you even need
> i2c_device_id if it is not matching of_device_id?
> 
> Best regards,
> Krzysztof
> 
