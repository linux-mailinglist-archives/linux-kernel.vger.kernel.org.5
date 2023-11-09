Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156277E65D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKII7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKII7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:59:10 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E2E8;
        Thu,  9 Nov 2023 00:59:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c2a0725825so97775466b.2;
        Thu, 09 Nov 2023 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699520346; x=1700125146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uzc4V7BrS20tlNbV5DAPRtu4ZLIGpGnAwPtYOJmYc7M=;
        b=YBJKCpmf2Md+xPnGfkVC8tXmz8x+hxMQGl9s6S8KcF77MRj1YP8bK6gRnfN5KAkGYu
         jms6I7TZpKXmzfhJalnekF9O/sjOXeO6ds1yx0lmNW7imYzOMg+f7HC1Pylk08DK5aKi
         K0bcGa6/CF9a6OCPRCpD/ZP0o52AeICew8ZLraeSnbjGgtuXrUddywVcsUgbmYq+pN9c
         BA6MH28zqxCx5XqgbOgzqDjv0yrCUfdvEYGLcVsIyoyujS1qGF14kfuFdCvFGY+J+TI3
         WZjISGJY88mK6J4Jc0aXI9NL6g2J41Hf6lWLLkqixNL5ViwXgW2Jn3wHJDcb/vrEGgB/
         UeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520346; x=1700125146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzc4V7BrS20tlNbV5DAPRtu4ZLIGpGnAwPtYOJmYc7M=;
        b=TIwEg6yEY0rKN5y7vD3XY9D2/aKehDcIrWuVhwW00aYn8pNpySlIPzdEBUgQHzauml
         clzLG9dgl2hVrDBgQ62D3m+vdr6VoWmuam2pnBxBMJaWZAXDfn2Ez0MjnOEh8BMZz/QL
         NKOekDqEir/zLoyiTbKCBlWaHjnkZR4Z3CPMfc0ZZOctkR/qz4xnK3c3nLCRLwADoEJx
         vxdwa4xlqmRgSnFWi6l1pssMFsaJ6r1L+6JbSg6McXcwxSdN85qvpOAcsBS0BvVORhiD
         bfgiOWze7B4HTa5wYta8uyKirldyu1b9CyOLtsTaLIf5IvqZxR1q0fUhSb3awHblIAa1
         rUBQ==
X-Gm-Message-State: AOJu0Yxd1QeJruGpn6Xr1sJ3FcB+3GzJUTMpvsgEd/TjpaBSrA+I6uRn
        kp/9A9ldeIZ6kzgz2E9pJrE=
X-Google-Smtp-Source: AGHT+IFhND4GNRMGcGvrQn41NMuJSV2K9baNGb1RLGYlHPe1Ek7/RlZ55X6y7W9MvFpVMbMTVI7LMg==
X-Received: by 2002:a17:907:3107:b0:9e3:fc27:9356 with SMTP id wl7-20020a170907310700b009e3fc279356mr2102346ejb.51.1699520346280;
        Thu, 09 Nov 2023 00:59:06 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906c00600b00992e94bcfabsm2231879ejz.167.2023.11.09.00.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 00:59:05 -0800 (PST)
Message-ID: <f1c6efd3-fad1-453a-b922-41485495385b@gmail.com>
Date:   Thu, 9 Nov 2023 09:59:04 +0100
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
 <285ec1d8-d277-403c-961f-3de523fc799f@gmail.com>
 <a5b63eb4-4168-425e-a235-15cc7a6f2df3@linaro.org>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <a5b63eb4-4168-425e-a235-15cc7a6f2df3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.11.23 09:40, Krzysztof Kozlowski wrote:
> On 08/11/2023 17:35, Javier Carrasco wrote:
>>>> +
>>>> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
>>>> +	if (!IS_ERR(data->regulator)) {
>>>> +		ret = cc2_retrive_alarm_config(data);
>>>> +		if (ret)
>>>> +			goto cleanup;
>>>> +	} else {
>>>> +		/* No access to EEPROM without regulator: no alarm control */
>>>
>>> Test your code with deferred probe. Are you sure you handle it
>>> correctly? To me, it looks like you handle deferred probe the same as
>>> any error.
>>>
>> The -EPROBE_DEFER is propagated to the probe function and it is the
>> returned value. I clarified the error path in v2 so no error messages
> 
> Really?
> 
> I see:
> if (!IS_ERR(data->regulator)) {
> 	// so you do not go here
> } else {
> 	goto dev_register;
> }
> dev_register is not error path. So how do you return EPROBE_DEFER?
> 
> Which line of code does it?
> 
EPROBE_DEFER is returned if the command window was missed, which is
checked in cc2_retrieve_alarm_config() (there is a typo I just corrected
-> cc2_retrive_alarm_config() in the current version). It could then
happen where you added a comment, but not because
devm_regulator_get_optional() failed.

Are you expecting a probe deferring if devm_regulator_get_optional()
fails as well? Like if the regulator is still not ready when the
function is called.
>> are displayed in that case, going directly to the dev_err_probe in the
>> probe cleanup.
>> When the EPROBE_DEFER error is returned, the probe function is deferred
>> and called again later on, which is the desired behavior.
>>
> 
> 
> Best regards,
> Krzysztof
> 
Best regards,
Javier Carrasco
