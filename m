Return-Path: <linux-kernel+bounces-52902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D544F849E0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EFF1F23FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88782D606;
	Mon,  5 Feb 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYWw0o6V"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0673FE48
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146774; cv=none; b=lY5MlQ8Zwdm55UJT5BgqERGNibk1Zlp6waRx+mzj/FejKFOtYOTSVexAFcQWcWl243avsTVm6wJivfQbBo1jmsgb9ctcTpag+DdeiHTgl6WKlejCDLIlzNsOJD3lqbIZKEHBLuUBJONyKUiQj0kjVRvPYs89r6LprIDEcm3ySLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146774; c=relaxed/simple;
	bh=Zh7YmdcD/XiEFed/G00TDlfa4Yku1WeI8x2qLeLS7eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX/r0DetGar92JUmzRW4l6sNdxkMfk/kALxY8LoFZejIWHknnHihWBdtPrcD3NcwgSXoWhGE7CcGfpij6qmdZ7XjosCOapakALloERZeU8yiIwReaA6glDXVodpVTv4dU70GWVcXZxXF5ShGdokMQUzxDX4SLOxNJoiczxCVySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYWw0o6V; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b29b5eab5so1436599f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146771; x=1707751571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XGvwJO/HN7NttDxW0V6QgrgtBtfHzeWu2WrNAsllBg=;
        b=XYWw0o6Vze3mO+cPqzv5RpwcB/1ngv4TFs5sjYPX2A8tmkj94nvUmtQlks3/a4blu0
         F9lXrVYQJoeLUMUjiZZQmz6871hUsf9TfPK99H7t4eijUKf1FTDIsrtx7HX1EeZp2hpg
         Sj7fpG3e6jkTEhJ+FK/DM4qgJxkIC1EZzB4e/QMnsPEOxLMI89lGWB39GyVJZGolpyUM
         n/7/rd351AXZY8VFv89vTHneLXkMyWhilCUmNG2ytUQ5bxOqIx1SYycmSHRtOjotuOrX
         e6c/tkm0GW1QlJQ0ugIdcrtsDoUdGskxBVz6u8daZxE2DiUmU3kzmyDfUkq5Tul6H81b
         F8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146771; x=1707751571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XGvwJO/HN7NttDxW0V6QgrgtBtfHzeWu2WrNAsllBg=;
        b=ugf38EeLrBH3WM18vNpSXlShr2cKZgOvwpsoGds7PDoWow6B4UpK0907pipa/Pn8dY
         5STwpGSXgnmNIjpDNgU/YPvudMZCUeSVuxC5bc5YS7ipzzQ9NnVOHdZI578U15WZlASe
         zYVXTNYubI3UQ2YjtFHdY+YGckhbT6lbSad5oyh6B1AFYZwWUlWpsq8m+fOKgdoFqcm0
         eNAHRFuIji6UT+2J98oJLU8qYF4I/Z3ogQQ6SARKgmF+f8bJs8JJce5HDwmo1Smjwbpv
         7iaYkVRsK1cDU5m4RE2jKN5yNagCYEW7S8JL+D/Z3ACNbHfo2jtyDhkeI3Ff144upj2T
         vGpQ==
X-Gm-Message-State: AOJu0YxarrGP3L4cnOsSpzXcxOYBS5SLHofUKiKQNlS/W/Pw9nk1jkPm
	1pzZpu8nNYQ8WwgiOE19k7BF9IV5wAvolKMJ/6IOAp7Zl7joXiRnKMTyYocVP/E=
X-Google-Smtp-Source: AGHT+IHPeOEjW3CWQFxd/XLJq8qJPFkU5qMwUhzNhzxbDfFmPIA6OivpUbhtSkdtppzYywKwTXT7JA==
X-Received: by 2002:a05:6000:118e:b0:33a:df1f:c18d with SMTP id g14-20020a056000118e00b0033adf1fc18dmr8405851wrx.50.1707146771391;
        Mon, 05 Feb 2024 07:26:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVuLW0bkDzVoKu+Mano7UEgymGlonqruvWcHCUZDODQ7S+Ip/4+cvUXK+dqIRBO3Fn1BWcCzHVlGR7v4OOqhrtul1U/55xIq5Ao+9xd5hhAPlbBtDFpgu67Y4/xBWmEGYzevbsYLMAecjjRnxh3rVq7ovmQ/1m9epKMGO7hEDcLAZuQ6GYve1IvGOc4GSbcx52fSSxyw5UwJ0wjwG1FOGMThBJETBNSayvQKyOPs4yBuT6Beo1ZtGyTU23X/9WAd/wxoQnABG11wc5eK0aw1i1yYA9vwXXSisrxitukJ20MLnSJJKmH2Ys0nokBXnW9sa/v2BKHbfzXHIcVr0+cmTvGH6k/Z2VZq57BUXgaGfYmjxp1FfoXZHcXkZTvm4vJ8rEUA7GU4SVMPLAo3wDu7e58jDkhwrbPhbNJa2GQ7ZI13tfvXiaUSsiU4w6Qx+bi5QO0q5FM0y50C9+/U0A3wKdMzONoRT6LBT+TXlLGfHMrDMpIJidITFxNGY5QJB4fo891IIf8+KcIqISZzDxUX8ornxRDSy/4X/s0gLl9OSODeHFpmRrtFoZIM+zPlA03nWGaZMHLJueSib9IMn1Nj99auORotQpqwhh9ycS3amvTG4vhyP2P4NEmpLhI5PfGtdrYf8lwt9XpXNbxP4pSGt3I3JSGgVcXlCRN9aSVNiEhkddhLCszALYpTOP+X9lVg8HgRQmpxJ9GFSTHGXMxsDf9MBwwKqxi980aemGt7OLtaPViRVII9G4XcwzU1D7ttLRS5N3l/xuqIGYnD0/n9gLR2FUICR09nNoprIDGqRLME29593Vwd7e2Ie9G5d8NXXrZP08=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b0033afc875fd5sm8194486wrj.49.2024.02.05.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 07:26:10 -0800 (PST)
Message-ID: <99a1a309-41d6-448f-b622-b62dbabb2c52@linaro.org>
Date: Mon, 5 Feb 2024 16:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Content-Language: en-US
To: Cosmo Chou <chou.cosmo@gmail.com>, linux@roeck-us.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org,
 naresh.solanki@9elements.com, vincent@vtremblay.dev,
 patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com,
 bhelgaas@google.com, festevam@denx.de, alexander.stein@ew.tq-group.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, macromorgan@hotmail.com,
 forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 cosmo.chou@quantatw.com
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205152013.3833940-2-chou.cosmo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 16:20, Cosmo Chou wrote:
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
> 
> This driver implementation originates from the CSDK available at
> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> The communication protocol utilized is based on the I2C/SMBus standard.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/pt5161l.rst |  42 ++
>  MAINTAINERS                     |   7 +
>  drivers/hwmon/Kconfig           |  10 +

...

> +
> +static int pt5161l_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct pt5161l_data *data;
> +
> +	data = devm_kzalloc(dev, sizeof(struct pt5161l_data), GFP_KERNEL);

sizeof(*)

> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	mutex_init(&data->lock);
> +	pt5161l_init_dev(data);
> +	dev_set_drvdata(dev, data);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 data,
> +							 &pt5161l_chip_info,
> +							 NULL);
> +
> +	pt5161l_init_debugfs(data);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static void pt5161l_remove(struct i2c_client *client)
> +{
> +	struct pt5161l_data *data = i2c_get_clientdata(client);
> +
> +	debugfs_remove_recursive(data->debugfs);
> +}
> +
> +static const struct of_device_id __maybe_unused pt5161l_of_match[] = {
> +	{ .compatible = "asteralabs,pt5161l" },

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pt5161l_of_match);
> +
> +static const struct acpi_device_id __maybe_unused pt5161l_acpi_match[] = {
> +	{ "PT5161L", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, pt5161l_acpi_match);
> +
> +static const struct i2c_device_id pt5161l_id[] = {
> +	{ "pt5161l", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pt5161l_id);
> +
> +static struct i2c_driver pt5161l_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "pt5161l",
> +		.of_match_table = of_match_ptr(pt5161l_of_match),
> +		.acpi_match_table = ACPI_PTR(pt5161l_acpi_match),
> +	},
> +	.probe = pt5161l_probe,
> +	.remove = pt5161l_remove,
> +	.id_table = pt5161l_id,
> +};
> +
> +static int __init pt5161l_init(void)
> +{
> +	pt5161l_debugfs_dir = debugfs_create_dir("pt5161l", NULL);

Drivers don't need initcalls. For sure any debugfs should not be handled
here but in probe.


Best regards,
Krzysztof


