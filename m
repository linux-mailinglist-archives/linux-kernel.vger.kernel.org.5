Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02427EC42B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjKON4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjKON4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:56:31 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC902E1;
        Wed, 15 Nov 2023 05:56:27 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c788f5bf53so78432861fa.2;
        Wed, 15 Nov 2023 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700056586; x=1700661386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzgHXk908oWBPw+MYYi5rg03v0Vm6ncWzqNrtjGiwyM=;
        b=HAnb+1dzCudRmS9tQG25YIxOn3CKY3N3wf2fyWACbDHPSVZHhiyCKr7iIafBFFAWu9
         /jELEofULDZYY3BH5shLCH0cHdjse8/XVz8WkDJAIazlE4YqVXzbbx5jx8DN3u2ZcoEF
         VVFs2oaQpmryDsbHUX1INpymfLHTlAF4OzTA6DScPyc5CCfjtVT+zol1KjzXbVKx07fQ
         zh1BnBkrtEzsG4bcH/uLdvOwgvRhXYzL142vZsqAypfXXuWv/SmjQ5xyuMy5I8twM3wT
         Wt1vte2XHz5p4iVMrdeETlJYBoLvrUocGvLZm/3y91m2utDTyiJ8mPlRSnvuxIrGXxoK
         zHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056586; x=1700661386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzgHXk908oWBPw+MYYi5rg03v0Vm6ncWzqNrtjGiwyM=;
        b=qy33dAldtl6E8mROqJ9gLCABfTuykamOxpiWqCBz2peeqlB/TB7oGWCmN8XovEFWDd
         ojz2uNZ/i2xBRdoGUGJv71AqxK/rkcpLeh6N1ceP6AF5Wk6gCHAQPylWX7wldMXs5f0D
         DkUTOcWQuKLtNlMQWiyxrYNLuLAS05cyLdVYo6GqU5i/hV1GFe2JyFeaJWEZIYN6CLm0
         cw34L6KhxjXXqIcEmXazibbXa5oou9dLtnFX0G1yD54ti5rGehau9QdFyuD3lY8Tr2uN
         v5HQnXYR/FRcxB/LeLR0lFSJqA0VtdkDLzqmUQfRQnGOVIbGZY9oZKo7oL3dXji+Bt55
         MNfg==
X-Gm-Message-State: AOJu0YxfdCAdRdOu2UOoNjnuhEcDwnVgjQBtHSBEo+e7KvDGLSZsDyVA
        2e5J45HyANplTWe6dVzmPpA=
X-Google-Smtp-Source: AGHT+IFWd8R+CeHKZgVN07woDmZGKwFW/fSViGqEl9rM5aVnTMzjSsEp/U3dLZ4jSSUPz4VqGQ35qw==
X-Received: by 2002:a05:6512:a96:b0:507:b9db:61dc with SMTP id m22-20020a0565120a9600b00507b9db61dcmr12387035lfu.48.1700056585655;
        Wed, 15 Nov 2023 05:56:25 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id um27-20020a170906cf9b00b009de467a25d5sm7178088ejb.13.2023.11.15.05.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 05:56:24 -0800 (PST)
Message-ID: <a7d9697c-c83e-4ef0-bd8d-025e79e34c3c@gmail.com>
Date:   Wed, 15 Nov 2023 14:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hwmon: (core) Add support for humidity min/max
 alarm
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-2-f5c325966fdb@gmail.com>
 <44f1eaa3-a90d-42cf-9808-4f39aacbf270@roeck-us.net>
 <25059951-ca50-4b19-8f74-5631b34c719b@gmail.com>
 <1ef7a10c-d9cf-4042-a198-f72dbdf9d05a@roeck-us.net>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <1ef7a10c-d9cf-4042-a198-f72dbdf9d05a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.23 14:25, Guenter Roeck wrote:
> On Thu, Nov 09, 2023 at 07:24:00AM +0100, Javier Carrasco wrote:
>> Hello,
>>
>> On 09.11.23 01:02, Guenter Roeck wrote:
>>> On 11/8/23 07:37, Javier Carrasco wrote:
>>>> Add min_alarm and max_alarm attributes for humidityX to support devices
>>>> that can generate these alarms.
>>>> Such attributes already exist for other magnitudes such as tempX.
>>>>
>>>> Tested with a ChipCap 2 temperature-humidity sensor.
>>>>
>>>
>>> No objection, but the new attributes also need to be added to the ABI
>>> documentation at
>>> Documentation/ABI/testing/sysfs-class-hwmon and
>>> Documentation/hwmon/sysfs-interface.rst
>>>
>>> Which made me notice that humidityX_alarm isn't documented either.
>>> Please document that attribute as well while you are at it.
>>>
>>> Thanks,
>>> Guenter
>>>
>> Actually there are several attributes without ABI documentation or at
>> least the attributes enum is much larger than the objects in the ABI
>> documentation (in testing/sysfs-class-hwmon).
>> For humidity there is only input, enable, rated_min and rated_max. Are
>> some attributes not described for a good reason or should all be
>> documented? the current humidity_attributes contains:
>>
>> hwmon_humidity_enable -> documented in sysfs-class-hwmon
>> hwmon_humidity_input -> documented in sysfs-class-hwmon
>> hwmon_humidity_label
>> hwmon_humidity_min
>> hwmon_humidity_min_hyst
>> hwmon_humidity_max
>> hwmon_humidity_max_hyst
>> hwmon_humidity_alarm
>> hwmon_humidity_fault
>> hwmon_humidity_rated_min -> documented in sysfs-class-hwmon
>> hwmon_humidity_rated_max -> documented in sysfs-class-hwmon
>>
>> I could not find the temperature counterparts of my new additions
>> (temp_min_alarm and temp_max_alarm).
>>
>> Should all be added to sysfs-class-hwmon or am I missing some other
>> document? I am alright adding the ones I mentioned.
>>
> 
> They should all be documented. It would be great if you volunteer
> to add the missing ones, but that won't be a mandate. I just don't want
> the situation to get worse.
> 
> Thanks,
> Guenter

I will document them in a separate series, so the (probably) long review
of the original device driver will not have any effect on this task,
which has nothing to do with the ChipCap 2 anyways.
I will start asap.

Best regards,
Javier Carrasco
