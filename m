Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAAE7E6D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjKIPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKIPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:36:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130CD30D3;
        Thu,  9 Nov 2023 07:36:07 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e213f198dfso171574966b.2;
        Thu, 09 Nov 2023 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699544165; x=1700148965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wi1QpsAJgHUTB4YFMyuEyqEplHtXIeaZSET719WZmlw=;
        b=kzMGmkHRyQcJYdL73ZjHXmkXhDet2Af3hEO0cNiRTIt1GoB/mSVA4Z+afItzjfohCl
         RmMEVfIqW8rzsVQPgslD26p5uko0v9SouYXKGy+yZI3ZTUt7X7xqKaGIGR0mvlNFYueA
         cHlFGHSohHwBEyiqDDNd/sBn3RfjCjH4Mu8H/MEdml/HYzutXkfMmFBqHoSa1ZWLSPUa
         U7hBq3Cpp9RybHPGjuunI+fsiXsEn6O+x9itbYP4jCxJR5wuvattgtM9hsAVG+QPI2jp
         WuNoB9zmmBQm0E9dbDwJbbK40JMTadSCtZd+s5JIXd8qan26YTmyIpk91RhMkdZE85oF
         Sadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699544165; x=1700148965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wi1QpsAJgHUTB4YFMyuEyqEplHtXIeaZSET719WZmlw=;
        b=gUINNlZgAHRn4Seak8vbNMyavZdhsjLeZ/pzwOwUV41O/2YcJHgFZQqDhiR5D6cHxb
         hMo3Pj52qWB8jxJdCPqRzrsHxfM6pM+N4RhvdgAHy8xLD4jKWY1/pcMebbRB32SGDYqA
         0iNP/Vvyu8GkV1l0XMRKP3fTk7JTcINATAFfmTpJIG9+7SV9W6TnVK8UXpOwCu3iHXAW
         eO0B/5nFMNOc4UjSuy7s9198BsGHuAIlmo5iRpxOlUECWtvXhVW24FHFl+1XaFE1tdX8
         gsumxaHKlICi+EFcGXl4bOtBE2A3jnWfTHXWeEXUAPyFGtG2iFASekBkPcoaU7d4GfRm
         nmhw==
X-Gm-Message-State: AOJu0YzzuFncSASzbD+y3TF4EK0ntM2/YkQ5w05Ly84NWpkPpneeb7Z0
        CQAsScijOmyPPO4ZrcM0YAo=
X-Google-Smtp-Source: AGHT+IFbOVY6fsmj2hkbcNOUMKkyN6BOqaHSSpWwITRx/8cZ3c6X7LtCsDYKBVixxOl9OZltWZkK1A==
X-Received: by 2002:a17:906:4796:b0:9bf:10f3:e435 with SMTP id cw22-20020a170906479600b009bf10f3e435mr5055466ejc.1.1699544165234;
        Thu, 09 Nov 2023 07:36:05 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709065acd00b00992b8d56f3asm2669896ejs.105.2023.11.09.07.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 07:36:04 -0800 (PST)
Message-ID: <a04cc8d1-5239-486a-8c1d-e9bd8bd7868d@gmail.com>
Date:   Thu, 9 Nov 2023 16:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hwmon: Add support for Amphenol ChipCap 2
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <d5692ab7-6d11-41f3-89ec-246a2fc045a8@roeck-us.net>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <d5692ab7-6d11-41f3-89ec-246a2fc045a8@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.23 15:55, Guenter Roeck wrote:
> On 11/9/23 00:52, Krzysztof Kozlowski wrote:
>> On 08/11/2023 16:37, Javier Carrasco wrote:
>>> The Amphenol ChipCap 2 is a capacitive polymer humidity and temperature
>>> sensor with an integrated EEPROM and minimum/maximum humidity alarms.
>>>
>>> All device variants offer an I2C interface and depending on the part
>>> number, two different output modes:
>>> - CC2D: digital output
>>> - CC2A: analog (PDM) output
>>>
>>> This driver adds support for the digital variant (CC2D part numbers),
>>> which is also divided into two subfamilies [1]:
>>> - CC2DXX: non-sleep measurement mode
>>> - CC2DXXS: sleep measurement mode
>>
>> ...
>>
>>> +
>>> +static int cc2_probe(struct i2c_client *client)
>>> +{
>>> +    struct cc2_data *data;
>>> +    struct device *dev = &client->dev;
>>> +    enum cc2_ids chip;
>>> +    int ret;
>>> +
>>> +    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>> +    if (!data)
>>> +        return -ENOMEM;
>>> +
>>> +    i2c_set_clientdata(client, data);
>>> +
>>> +    mutex_init(&data->i2c_lock);
>>> +    mutex_init(&data->alarm_lock);
>>> +
>>> +    data->client = client;
>>> +
>>> +    if (client->dev.of_node)
>>> +        chip = (uintptr_t)of_device_get_match_data(&client->dev);
>>> +    else
>>> +        chip = i2c_match_id(cc2_id, client)->driver_data;
>>> +
>>> +    data->config = &cc2_config[chip];
>>> +
>>> +    ret = cc2_request_ready_irq(data, dev);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    data->regulator = devm_regulator_get_optional(dev, "vdd");
>>> +    if (!IS_ERR(data->regulator)) {
>>> +        ret = cc2_retrive_alarm_config(data);
> 
> fwiw, s/retrive/retrieve/g
ack.
> 
>>> +        if (ret)
>>> +            goto cleanup;
>>> +    } else {
>>> +        /* No access to EEPROM without regulator: no alarm control */
>>> +        goto dev_register;
>>
>> Nothing improved here.
>>
>> Do not send new version of patchset before discussion finishes.
>>
> 
> This driver will take a while to review due to its complexity.
That is absolutely ok. I will wait for a few days to gather more
feedback and hopefully send less versions.
> 
> As for the code above: Error handling goes first. Something like
> the above, where the error case is just a goto, is unacceptable and
> just increases indentation level for the other code and makes it
> more difficult to read. Also, the above code _will_ have to handle
> error cases other than -ENODEV. Besides deferred probe, it is
> completely inappropriate to ignore -EINVAL or -ENOMEM or any other
> error codes other than -ENODEV.
> 
The probe function will return from errors other than -ENODEV directly
with no goto and checking them first.
I just need to skip the alarm registration for -ENODEV and do the
cleanup if an error occurs after enabling the regulator to keep
enable/disable parity.
>>> +    }
>>> +
>>> +    ret = cc2_request_alarm_irqs(data, dev);
>>> +    if (ret)
>>> +        goto cleanup;
>>> +
>>> +dev_register:
>>> +    data->hwmon = devm_hwmon_device_register_with_info(dev,
>>> client->name,
>>> +                               data, &cc2_chip_info,
>>> +                               NULL);
>>> +    if (IS_ERR(data->hwmon)) {
>>> +        ret = PTR_ERR(data->hwmon);
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +cleanup:
>>> +    if (cc2_disable(data))
>>> +        dev_dbg(dev, "Failed to disable device");
>>> +
>>> +    return dev_err_probe(dev, ret,
>>> +                 "Unable to register hwmon device\n");
>>
>> Drop or move to each error path.
>>
> This actually follows Documentation/process/coding-style.rst, chapter 7
> (Centralized exiting of functions).
> 
> Guenter
> 
Thanks for your comments.

Best regards,
Javier Carrasco
