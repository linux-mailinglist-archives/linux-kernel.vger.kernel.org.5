Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1715A7E5675
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbjKHMly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbjKHMlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:41:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF571BF2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:41:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso4183449f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699447309; x=1700052109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vZdC7GdLu/0Hb1oRLbPpjyFdu8EteQYyZxPIVLp/GU=;
        b=kbuBJgZ072X2hYVtjGWtuqtRVrm9kFlYyHleksnf9LUu1wIoODjkMIshxRjIfB6/wU
         kBaEv2b0fUBYoz9vJdOauxcucr3ivxHeZWC0fqOVjY47QrZFaZDVVKAwFCf3au/iCp0z
         edwPVcOanH+wStM9ZfGN4eqmgY02TcWMWVdv2pKhSPqIYffmEyhcA3zuk0LhDYLio8Gd
         VoxdpjIE1WXq6Yn7VF4b5QGTJxOqkBpGDnYrPPRfNQtfXJg7MVJAYTJYtjeExDL2ulLG
         j8EIXJwRMwBItKL2KzBQqEZ4Dw4VVXaHiVoR8d8KhHBtnJX7vw0hh650FAIz6BzI+EVI
         +eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699447309; x=1700052109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vZdC7GdLu/0Hb1oRLbPpjyFdu8EteQYyZxPIVLp/GU=;
        b=U/9cgrRtA6XpmGKz4PaXF0MfMXYieMCVvigEn5xCYRzkz6b+zVdwpHwBRSRae/urkv
         ttfEfmSXoGIM6l9PtkLmVrGbPPWcfy+Iq5E/naRUIVSusIisaOQPPrCkXkDsLcZQWLwO
         eS7oqgL0IJEkcMOfG+P5HagdWR2JkCuDdRpWnhLVBONHk/FEco8WrWE4GUp6yUgAqDru
         xX+U5lEwQiSbmWHE6khJpcyaqdt3j5bFPeTIp+hFwk4eIs/mIy+4WY3y5rZ1BDhDH46+
         TCQHKaS/iJJYbCU51Kx/lVV9Vlavs+lHbZUlq2+mD9+tFpYNvHUrS8bPz/FEK8xc7453
         d+0w==
X-Gm-Message-State: AOJu0YwUk/pp0cs+6gQrvnXuZR/7I7qrKDsO7p5pehEB1EOniW4j7X1S
        QS2f5qLLXcFyZ3AdUq3ONcrYVQ==
X-Google-Smtp-Source: AGHT+IH5KR11m8+U6TjXmNr5i0zw59fCq8AKvy1BT7X8H0fwOTdLMOooNh5UutHxks8+TzhoXl+vVA==
X-Received: by 2002:adf:fd91:0:b0:32d:884b:7403 with SMTP id d17-20020adffd91000000b0032d884b7403mr1488604wrr.66.1699447309514;
        Wed, 08 Nov 2023 04:41:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe345000000b0032f7cc56509sm4888258wrj.98.2023.11.08.04.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 04:41:48 -0800 (PST)
Message-ID: <e58cdedb-1825-4713-9d3f-5239bb182230@linaro.org>
Date:   Wed, 8 Nov 2023 13:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hwmon: Add support for Amphenol ChipCap 2
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231020-topic-chipcap2-v1-3-087e21d4b1ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 13:29, Javier Carrasco wrote:
> The Telaire ChipCap 2 is a capacitive polymer humidity and temperature
> sensor with an integrated EEPROM and minimum/maximum humidity alarms.
> 
> All device variants offer an I2C interface and depending on the part
> number, two different output modes:
> - CC2D: digital output
> - CC2A: analog (PDM) output

Thank you for your patch. There is something to discuss/improve.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..63361104469f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21572,6 +21572,14 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
>  F:	drivers/media/i2c/ds90*
>  F:	include/media/i2c/ds90*
>  
> +TI CHIPCAP 2 HUMIDITY-TEMPERATURE IIO DRIVER

Why this is TI?

Bindings say Amphenol. Subject as well. Commit msg says Telaire. Here
you write Texas Instruments.

Three different companies used. How possibly we could understand this?


> +M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained

...

> +
> +/* Command mode is only accessible in the first 10 ms after power-up, but the
> + * device does not provide any kind of reset. In order to access the command
> + * mode during normal operation, a power cycle must be triggered.
> + */


Please use full comment style, as described in Coding Style document.

...

> +
> +static const struct hwmon_ops cc2_hwmon_ops = {
> +	.is_visible = cc2_is_visible,
> +	.read = cc2_read,
> +	.write = cc2_write,
> +};
> +
> +static const struct hwmon_chip_info cc2_chip_info = {
> +	.ops = &cc2_hwmon_ops,
> +	.info = cc2_info,
> +};
> +
> +static const struct cc2_config cc2dxx_config = {
> +	.measurement = cc2dxx_meas,
> +};
> +
> +static const struct cc2_config cc2dxxs_config = {
> +	.measurement = cc2dxxs_meas,
> +};
> +
> +static const struct of_device_id cc2_of_match[] = {
> +	{ .compatible = "amphenol,cc2dxx",
> +	  .data = &cc2dxx_config,
> +	},
> +	{ .compatible = "amphenol,cc2dxxs",

Format it as in other sources. Don't introduce your own codings style.

> +	  .data = &cc2dxxs_config,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cc2_of_match);

Keep ID tables together.

> +
> +static int cc2_probe(struct i2c_client *client)
> +{
> +	struct cc2_data *data;
> +	struct device *dev = &client->dev;
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	mutex_init(&data->i2c_lock);
> +	mutex_init(&data->alarm_lock);
> +
> +	data->client = client;
> +
> +	match = i2c_of_match_device(cc2_of_match, client);
> +	if (!match)
> +		return -ENODEV;
> +
> +	data->config = match->data;
> +
> +	ret = cc2_request_ready_irq(data, dev);
> +	if (ret)
> +		return ret;
> +
> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
> +	if (!IS_ERR(data->regulator)) {
> +		ret = cc2_retrive_alarm_config(data);
> +		if (ret)
> +			goto cleanup;
> +	} else {
> +		/* No access to EEPROM without regulator: no alarm control */

Test your code with deferred probe. Are you sure you handle it
correctly? To me, it looks like you handle deferred probe the same as
any error.

> +		goto dev_register;
> +	}
> +
> +	ret = cc2_request_alarm_irqs(data, dev);
> +	if (ret)
> +		goto cleanup;
> +
> +dev_register:
> +	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
> +							   data, &cc2_chip_info,
> +							   NULL);
> +	if (IS_ERR(data->hwmon))
> +		return dev_err_probe(dev, PTR_ERR(data->hwmon),
> +				     "Unable to register hwmon device\n");
> +
> +	return 0;
> +
> +cleanup:
> +	if (cc2_disable(data))
> +		dev_dbg(dev, "Failed to disable device");
> +
> +	return ret;
> +}
> +
> +static void cc2_remove(struct i2c_client *client)
> +{
> +	struct cc2_data *data = i2c_get_clientdata(client);
> +	int ret = cc2_disable(data);
> +
> +	if (ret)
> +		dev_dbg(&client->dev, "Failed to disable device");
> +}
> +
> +static const struct i2c_device_id cc2_id[] = { { "chipcap2", 0 }, {} };

Use style like in other files.
git grep i2c_device_id

BTW, having mismatched entries looks error-prone. Why do you even need
i2c_device_id if it is not matching of_device_id?

Best regards,
Krzysztof

