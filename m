Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B507E67D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjKIKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:23:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C96A2584
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:23:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408425c7c10so4737795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699525427; x=1700130227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abqWbKoJvRUeVNOukLsY6JyZVWc7/K+e07P4bm1fqIQ=;
        b=KxI8Z5hSGwOcPU5ncTuVj+7Dyhw2INrRjEOY1YyfKHV6lNulP8Lo6RutiKXRLZaU5p
         LU3W+IaLKtOh90O4kFLMXdc5S4FuZo8GoTTHfprAGGEdFKf/PYhvifycr+my6W0gLUTh
         h+BCF/4aBSct7dT8JJ5EY+KebJ1EbCYcPkriVRm3ngDTptcvHkpaLX+SkK1x2SdCq5nz
         muXUcqven469/t9J5e1N7d8POT1qDvOkwpa6joQxu6gjFbSS3EMBOHbOeRCoBe0KePd1
         vULmxOkqHR7k1EQjmVCOu8vZlADMdxu4PcvGIZzroZtReeXpjMpGoyr0mX6kGH3X6YGr
         oE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699525427; x=1700130227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abqWbKoJvRUeVNOukLsY6JyZVWc7/K+e07P4bm1fqIQ=;
        b=K1DucSKD0E67872H2nOPjgiwJM0ehvqhWv9ftFtm1quNGrzgnQEAOKgdok2HHiLsCl
         r7FZ4N6KeOUAVFSCg22u+TIt9PKJTTB42kzvkgNsxAh91KQTINROl1ZVx+SGwdknh47P
         tB4f++LU2yRq0GUD7ZCYkz6UTyVT225XrPvuusEvg0ik8QqFc/aMfTkQQfJfiUW+3zOi
         sW0S4HPluc4/eZkh1OS4pCmQIkkNYYqLpZMBU4wwtNIV2NKpyBEomjkRXligypHoYXNF
         TuVOcrzrioY1KysrPky6LjNdC00THiN5/gL4V2VxxhsR5qVbD1uG+FV20cT8orYIjdXo
         a+OQ==
X-Gm-Message-State: AOJu0YzJzLpQUbSJDSDPOqpWmjOhDG861dMLsDl2r0CIy0L1a2T3JMmY
        yeN0WyngkvzU+AOPgclWkuxKLA==
X-Google-Smtp-Source: AGHT+IGmY55gJMxKush80aN1LgQ1fO7f8p1GzdPHjal1IkKOXJ4zpKUZHPMzk28dHOeAxpE2avGMAQ==
X-Received: by 2002:a05:600c:524e:b0:402:bcac:5773 with SMTP id fc14-20020a05600c524e00b00402bcac5773mr4106560wmb.38.1699525426990;
        Thu, 09 Nov 2023 02:23:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4cc7000000b0032fa66bda58sm7074001wrt.101.2023.11.09.02.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:23:46 -0800 (PST)
Message-ID: <3af60fa2-bcf3-4e38-952d-ad14253c415a@linaro.org>
Date:   Thu, 9 Nov 2023 11:23:45 +0100
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
 <e58cdedb-1825-4713-9d3f-5239bb182230@linaro.org>
 <285ec1d8-d277-403c-961f-3de523fc799f@gmail.com>
 <a5b63eb4-4168-425e-a235-15cc7a6f2df3@linaro.org>
 <f1c6efd3-fad1-453a-b922-41485495385b@gmail.com>
 <037f44d9-7240-4daf-9fe1-ac89fae9499c@linaro.org>
 <1a7adaca-7971-4739-8a0b-04429c08f683@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1a7adaca-7971-4739-8a0b-04429c08f683@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 10:52, Javier Carrasco wrote:
> On 09.11.23 10:35, Krzysztof Kozlowski wrote:
>> On 09/11/2023 09:59, Javier Carrasco wrote:
>>>
>>>
>>> On 09.11.23 09:40, Krzysztof Kozlowski wrote:
>>>> On 08/11/2023 17:35, Javier Carrasco wrote:
>>>>>>> +
>>>>>>> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
>>>>>>> +	if (!IS_ERR(data->regulator)) {
>>>>>>> +		ret = cc2_retrive_alarm_config(data);
>>>>>>> +		if (ret)
>>>>>>> +			goto cleanup;
>>>>>>> +	} else {
>>>>>>> +		/* No access to EEPROM without regulator: no alarm control */
>>>>>>
>>>>>> Test your code with deferred probe. Are you sure you handle it
>>>>>> correctly? To me, it looks like you handle deferred probe the same as
>>>>>> any error.
>>>>>>
>>>>> The -EPROBE_DEFER is propagated to the probe function and it is the
>>>>> returned value. I clarified the error path in v2 so no error messages
>>>>
>>>> Really?
>>>>
>>>> I see:
>>>> if (!IS_ERR(data->regulator)) {
>>>> 	// so you do not go here
>>>> } else {
>>>> 	goto dev_register;
>>>> }
>>>> dev_register is not error path. So how do you return EPROBE_DEFER?
>>>>
>>>> Which line of code does it?
>>>>
>>> EPROBE_DEFER is returned if the command window was missed, which is
>>
>> How "command window was missed" is related to the place I commented?
>>
> it is right below the comment you added and hence the misunderstanding.
> But focusing on the line where your comment is, there is no probe
> deferring in that case. This is why I asked if you were talking about
> devm_regulator_get_optional() failing, which is not covered by the
> deferring mechanism in the current form.
> 
> I have never experienced the case where the regulator was still not
> available, but I suppose there is no reason why that should never happen.

Defer on regulators, just like several other resources, is quite likely,
so all code must be ready for this.

> The regulator is not mandatory and there is no reason to retry if it is
> not defined. But in case it is defined and not available, the deferring
> would make sense. I could consider that case as well.

Your code should consider it always.


Best regards,
Krzysztof

