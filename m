Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB69B757542
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGRHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGRHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:25:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B9D1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:25:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so7533508a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689665133; x=1692257133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnChA2abQJj2t20iF0rmM2KRjUtf8yEoGrz0epdwIwA=;
        b=s3KXxn3UjfmySXlb9R13dXwt2vOxldjL+SFerhMavt8UY5Bg4Ap33PKmouxryfUBUL
         pSsnwc4xPzjpDKC6//dbnxjyd1V9y1wwohrpHJcDqWBqXZtlKTP+q7ElaSrsDN6FNiTt
         OZ0FxmJjFbNL9+XjsjM9L5WJQ3/AN+Cvc+XGkq3MKZLbqPekyFh+wbG/Elf40koE617j
         9fWJpVLvHSAZFn1I8XRTs3Q5iFGZbemwwMhyu7YXMnf40jgKJaKCHFOrK2rlrXmob27d
         E3pB7+hoV/O6S3T6PYN5e8DepW4/IsU9o2CEAba/UTjCYuzypD6cuB9Khf2bBoCqc1Ev
         wrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665133; x=1692257133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnChA2abQJj2t20iF0rmM2KRjUtf8yEoGrz0epdwIwA=;
        b=hr27kfmujIddbrx5vEod8V03778CW4nrLYI2Ai4uYtX/CJg1KzlZ8Igp1nSH2ssH/P
         2JTR582Flhha5BfBpfWmOvtrQoT41XfvkHrL2YJZ5IIt4z4bbLZ1krs2hi9rUUoSTrAb
         R8+D5T8DJC+qJBYKfvbLoz5ITTFG4IYV8fGdP+5OZ2pvsrmK9aUzYfbCkKeVali59zGC
         q41OAgfP0LRna5885FBlEZZoI9LKc9vwoSJGGJJ+CyMWitEPZgQnsnL+M1bsydoS++yp
         1nHnhAmBZFRvXSZwUi++fXyd1urkQOXbvSiVzB/c5TFQbol9omGJqjscG4Q7K4oALPr+
         jxWQ==
X-Gm-Message-State: ABy/qLZWLfp764sBRgz1vWcHpRMutghd4AWnF3+M5JcDDHx/PRJ35/mx
        MsvLKN4sxD8fl4okEEPA44Q7mw==
X-Google-Smtp-Source: APBJJlHNIgdPzuJuy0x0YY6gCWMzF3fXiWlCo1CLf7hC2EVud/HeJbKo3c+l/iBnVk4NT6FJHwhTSw==
X-Received: by 2002:aa7:d986:0:b0:51e:1638:e52f with SMTP id u6-20020aa7d986000000b0051e1638e52fmr11323553eds.40.1689665132900;
        Tue, 18 Jul 2023 00:25:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7d6cb000000b0051e0bf5807bsm769716edr.49.2023.07.18.00.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:25:32 -0700 (PDT)
Message-ID: <fb19946c-b95c-cfd1-1034-7542d38e554e@linaro.org>
Date:   Tue, 18 Jul 2023 09:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] hwmon: (hs3001) Add driver for Renesas HS3001
Content-Language: en-US
To:     Andre Werner <werneazc@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
References: <20230718070114.3871-1-andre.werner@systec-electronic.com>
 <20230718070114.3871-2-andre.werner@systec-electronic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718070114.3871-2-andre.werner@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 09:01, Andre Werner wrote:
> Add base support for Renesas HS3001 temperature
> and humidity sensors and its compatibles HS3002,
> HS3003 and HS3004.
> 
> The sensor has a fix I2C address 0x44. The resolution
> is fixed to 14bit (ref. Missing feature).
> 

> Missing feature:
> - Accessing non-volatile memory: Custom board has no
>   possibility to control voltage supply of sensor. Thus,
>   we cannot send the necessary control commands within
>   the first 10ms after power-on.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> 
> Changelog:
> v1: Initial version
> v2: Extensive refactoring following recommendations of reviewers:
>  - Delete unused defines and device properties. These are added in
>    the initial version because the device supports a programming mode,
>    but I was not able to implement it, because the custom board was
>    not able to control the power supply of the device and so I cannot
>    enter the programming mode of the device.
>  - Correct missunderstanding comments for defines.
>  - Delete mutexes for data and I2C bus accesses.
>  - Replace attributes with recommented chip-info structure. In the
>    initial version I followed the sth3x.c implementation that uses
>    files and attributes in sysfs. The show functions are replaced by
>    is_visible and read callbacks from the HWMON ABI. I also  delete pointless
>    function argument checks.
>  - Correct Yoda programming.
>  - Refactor probe function and delete sleep and measurement of humidity
>    and temperature in probe function. I kept an initial I2C
>    communication to ensure that the device is accessible during probe.
>  - Reduce the number of atteributes to humidity and temperature input.

Also wrong placement of SoB and changelog.

> ---
>  Documentation/hwmon/hs3001.rst |  37 +++++
>  MAINTAINERS                    |   6 +
>  drivers/hwmon/Kconfig          |  10 ++
>  drivers/hwmon/Makefile         |   1 +
>  drivers/hwmon/hs3001.c         | 261 +++++++++++++++++++++++++++++++++
>  5 files changed, 315 insertions(+)
>  create mode 100644 Documentation/hwmon/hs3001.rst
>  create mode 100644 drivers/hwmon/hs3001.c

...

> +/* Definitions for Status Bits of A/D Data */
> +#define HS3001_DATA_VALID	0x00	/* Valid Data */
> +#define HS3001_DATA_STALE	0x01	/* Stale Data */
> +
> +#define LIMIT_MAX	0
> +#define LIMIT_MIN	1
> +
> +enum hs3001_chips {
> +	hs3001,

Drop, not effectively used.

> +};

...

> +
> +/* device ID table */
> +static const struct i2c_device_id hs3001_ids[] = {
> +	{ "hs3001", hs3001 },

Drop match data

> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, hs3001_ids);
> +
> +static const struct of_device_id hs3001_of_match[] = {
> +	{.compatible = "renesas,hs3001",
> +	 .data = (void *)hs3001

Drop

> +	},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, hs3001_of_match);
> +
> +static int hs3001_probe(struct i2c_client *client)
> +{
> +	struct hs3001_data *data;
> +	struct device *hwmon_dev;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +
> +	if (client->dev.of_node)
> +		data->type = (enum hs3001_chips)of_device_get_match_data(&client->dev);
> +	else
> +		data->type = i2c_match_id(hs3001_ids, client)->driver_data;

This is useless and dead code. You have only one type of device. Don't
over-complicate simple things.



Best regards,
Krzysztof

