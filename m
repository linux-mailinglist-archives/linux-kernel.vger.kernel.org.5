Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B37E6722
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjKIJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjKIJwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:52:19 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C92726;
        Thu,  9 Nov 2023 01:52:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d267605ceeso105169466b.2;
        Thu, 09 Nov 2023 01:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699523535; x=1700128335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyS8DtOu76hKJM8U9iOb6KlcCppdmmmIn9mic1VECzg=;
        b=GGft0JbM5rxOQDBSq7O+NJlY5UlZRV8bGj8llBLvfuz8DxoGAGBqWlS2/07MSobryg
         wB7B/OHsx7sZtd45CP0CQ0BhZlqPEoOcCwxSTSEN1B8mLG6JXSWuklvFXQp5AAxPdQj5
         RQYlfQcoq9VYRDOaIehdqTTP14ZCIeWMrDAC4GoKBWtKB0KVMoepQgn5e+YjZJY+YQWQ
         /Hjr8sz7kYc/+EfLMcwKhq+x+eVKkBYhcO5Q++w0qWEcg0uHReu8qteRfAe2ouEXWYBG
         5bfrMzKJHQ61GQHKT5tmEu5jt6+V4vDHBN9rJdKjbWZDmzNwKVW1AN6/yKn8Z5Vyu5Ro
         MDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699523535; x=1700128335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyS8DtOu76hKJM8U9iOb6KlcCppdmmmIn9mic1VECzg=;
        b=ZI53jy8d0zJNF4FaTSElvwqXCxO3UjvKkzyTHmnpKcV93Ffa+ZqDeDkjPCdkQNhPtH
         d6UtK3wvvWwQEeAKmswXITnkxORWYXodzF82b6P9dTZp6p4BrG6ODMwj+suPIybmayEU
         lgcubowJuD8tf5RKSu4rfOmyTWT3pdRS4QZJsYHztxD1clyMGMi2NbcRgUastToxW+CX
         UgmT/ff3r+208uYfoTx7S6Dab6t3XAdwskUIh1Ze9eXKN6QcwhdYIMfHD24cnRZ9Wl77
         jnkKkelhmkRLEfHy96YkY3GqrBLKnR62Zu39uiFurBrij3ntKacLG9nBI3RquJYP+DpR
         cJwQ==
X-Gm-Message-State: AOJu0YyyUcSfZukgT6tuKoyu6XgDC0GFaV8rHtbrbHcvn8T7jU6MnYq6
        56dpSqqFp18OdF/MvW2A5Wl2noyNLKLsjQ==
X-Google-Smtp-Source: AGHT+IFXieEJ7rWnHwFIcuQX3LAG2VmKFBAL+uQEuCkz2H/rM2eTQk6v6KvWDaR/FcxFiepDS2Liqw==
X-Received: by 2002:a17:906:478b:b0:9c7:5667:5648 with SMTP id cw11-20020a170906478b00b009c756675648mr3455100ejc.51.1699523535338;
        Thu, 09 Nov 2023 01:52:15 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id ha12-20020a170906a88c00b0099d804da2e9sm2307418ejb.225.2023.11.09.01.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 01:52:14 -0800 (PST)
Message-ID: <1a7adaca-7971-4739-8a0b-04429c08f683@gmail.com>
Date:   Thu, 9 Nov 2023 10:52:13 +0100
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
 <f1c6efd3-fad1-453a-b922-41485495385b@gmail.com>
 <037f44d9-7240-4daf-9fe1-ac89fae9499c@linaro.org>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <037f44d9-7240-4daf-9fe1-ac89fae9499c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.23 10:35, Krzysztof Kozlowski wrote:
> On 09/11/2023 09:59, Javier Carrasco wrote:
>>
>>
>> On 09.11.23 09:40, Krzysztof Kozlowski wrote:
>>> On 08/11/2023 17:35, Javier Carrasco wrote:
>>>>>> +
>>>>>> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
>>>>>> +	if (!IS_ERR(data->regulator)) {
>>>>>> +		ret = cc2_retrive_alarm_config(data);
>>>>>> +		if (ret)
>>>>>> +			goto cleanup;
>>>>>> +	} else {
>>>>>> +		/* No access to EEPROM without regulator: no alarm control */
>>>>>
>>>>> Test your code with deferred probe. Are you sure you handle it
>>>>> correctly? To me, it looks like you handle deferred probe the same as
>>>>> any error.
>>>>>
>>>> The -EPROBE_DEFER is propagated to the probe function and it is the
>>>> returned value. I clarified the error path in v2 so no error messages
>>>
>>> Really?
>>>
>>> I see:
>>> if (!IS_ERR(data->regulator)) {
>>> 	// so you do not go here
>>> } else {
>>> 	goto dev_register;
>>> }
>>> dev_register is not error path. So how do you return EPROBE_DEFER?
>>>
>>> Which line of code does it?
>>>
>> EPROBE_DEFER is returned if the command window was missed, which is
> 
> How "command window was missed" is related to the place I commented?
> 
it is right below the comment you added and hence the misunderstanding.
But focusing on the line where your comment is, there is no probe
deferring in that case. This is why I asked if you were talking about
devm_regulator_get_optional() failing, which is not covered by the
deferring mechanism in the current form.

I have never experienced the case where the regulator was still not
available, but I suppose there is no reason why that should never happen.
The regulator is not mandatory and there is no reason to retry if it is
not defined. But in case it is defined and not available, the deferring
would make sense. I could consider that case as well.
>> checked in cc2_retrieve_alarm_config() (there is a typo I just corrected
>> -> cc2_retrive_alarm_config() in the current version). It could then
>> happen where you added a comment, but not because
>> devm_regulator_get_optional() failed.
>>
>> Are you expecting a probe deferring if devm_regulator_get_optional()
>> fails as well? Like if the regulator is still not ready when the
>> function is called.
> 
> We talk only about this place. Not others.
> 
> 
> Best regards,
> Krzysztof
> 
Best regards,
Javier Carrasco
