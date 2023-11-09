Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96487E65AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjKIIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjKIIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:52:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7D111
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:52:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f78dcf036so1053691f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699519972; x=1700124772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvehk1fV53gG9nJW7yH/BIf42Uaj50NUcQqqGKhqkzY=;
        b=cg28cd8m1c7NlKBNLJaI3rW2x4fRntoFlWQa1bPQZ/PLmkO7iQzXUW0V2uZAnqwwWA
         eOOluKq6PDoPtbDQ1LiIWj0WHVO1ll4rBujJQd7dvb2m0iObU6ZYHD2q8p3ZlTmyr2C8
         HaJaJHcpLfO9HzzEpWb6G5bQfMxx23VCDfT2nRB5ExcjtDu1XYvHSmoVOtO5WZ+OfQWh
         n8TzCXK4mDVzno3LB26o4OB8iMgF4anakakkIr+IEQCkr5TcD83xdQ4n4JQoZ1AlU19V
         sfbbyxz9IzAMLcu/rRotUS2HYd0mAbyyZT8K4BWUCRR+uHLjZ92ysqJGgtsjCb/aODOI
         qdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699519972; x=1700124772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvehk1fV53gG9nJW7yH/BIf42Uaj50NUcQqqGKhqkzY=;
        b=u55yOVjwvqAf6XVVHQub0olH888dcgr7z7lGTcr5lL0jfv/s7QemImUwqNJnLQ7Qit
         abi9CLRkyHXYN7WE2h/GQ47rU7wuxfh28m5cyTncfQWbf8Hlo4mhDKYMID0yLcgUe5N5
         rzdHWKXfR+iNF3Qpvcja2EhIs0cxWs6dEdjFqbicAaxtvXSkyKAr+I6gRxMTxNKsyqxp
         196PVVl9TW2PBcnyj6sjHqPUPgOVUgRR4ILkYSQNGkWJ4EkeMSczhrLrLQq+4pZMcwGD
         ry2DEZBYO8SVO+BrsRSgeyaM1VpRKw8cuT4VlJQjdWzmjZWiIUqdpDdXlQGv3XZDark+
         8Hng==
X-Gm-Message-State: AOJu0Yz7Gp7JoJHTCU3fo5A1ublKwG4DjYNtH0Xz7tB3ajTpbN+DWzin
        py4VKKzSEHMJOh4maq/PBzT2Nw==
X-Google-Smtp-Source: AGHT+IHRP2KQj+lro9Fdgd1KyWHS2BorRdoSM6MNLlcFvlh4i9ZdelA+7ithKcjFQGx9EUJxZJTpWQ==
X-Received: by 2002:a05:6000:11ca:b0:32f:92ca:9e5a with SMTP id i10-20020a05600011ca00b0032f92ca9e5amr5122894wrx.15.1699519971812;
        Thu, 09 Nov 2023 00:52:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id v5-20020adfa1c5000000b0032d81837433sm6944964wrv.30.2023.11.09.00.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 00:52:51 -0800 (PST)
Message-ID: <30ccb0a9-c0bd-491e-817f-def0aeda11c6@linaro.org>
Date:   Thu, 9 Nov 2023 09:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hwmon: Add support for Amphenol ChipCap 2
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
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-3-f5c325966fdb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231020-topic-chipcap2-v2-3-f5c325966fdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 16:37, Javier Carrasco wrote:
> The Amphenol ChipCap 2 is a capacitive polymer humidity and temperature
> sensor with an integrated EEPROM and minimum/maximum humidity alarms.
> 
> All device variants offer an I2C interface and depending on the part
> number, two different output modes:
> - CC2D: digital output
> - CC2A: analog (PDM) output
> 
> This driver adds support for the digital variant (CC2D part numbers),
> which is also divided into two subfamilies [1]:
> - CC2DXX: non-sleep measurement mode
> - CC2DXXS: sleep measurement mode

...

> +
> +static int cc2_probe(struct i2c_client *client)
> +{
> +	struct cc2_data *data;
> +	struct device *dev = &client->dev;
> +	enum cc2_ids chip;
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
> +	if (client->dev.of_node)
> +		chip = (uintptr_t)of_device_get_match_data(&client->dev);
> +	else
> +		chip = i2c_match_id(cc2_id, client)->driver_data;
> +
> +	data->config = &cc2_config[chip];
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
> +		goto dev_register;

Nothing improved here.

Do not send new version of patchset before discussion finishes.

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
> +	if (IS_ERR(data->hwmon)) {
> +		ret = PTR_ERR(data->hwmon);
> +		goto cleanup;
> +	}
> +
> +	return 0;
> +
> +cleanup:
> +	if (cc2_disable(data))
> +		dev_dbg(dev, "Failed to disable device");
> +
> +	return dev_err_probe(dev, ret,
> +			     "Unable to register hwmon device\n");

Drop or move to each error path.



Best regards,
Krzysztof

