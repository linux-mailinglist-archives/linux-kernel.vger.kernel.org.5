Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3307E63CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:24:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAF19A5;
        Wed,  8 Nov 2023 22:24:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso721158a12.1;
        Wed, 08 Nov 2023 22:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699511043; x=1700115843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFc9wQ4/Iy4PKdImLLDNhJ0n+o/UegEm1+YAiGXRu/I=;
        b=ZAwL1C0awC3N5mH8oJe1R0PBt0rDt0vj5S7RO1z09sLpFyWsQPzOkOCG0QzJHO/3Sl
         MoCdBb/0WObcJBRdjgremGqpOQTIPoIqptXtnoU0XktVyj3QKs6XkW82/CdmHhMNV4zb
         /IoynoPSTbBmi8ZnO7d1q/kW9pGaVZXPwWpPAq4e+k/P3rKmwSJ0+w5U/zD3qTZG6p+s
         VmckaZddrfuArUv2gyIswuCTe5MkDvcPQ2+YQyZzkTM8m/RUg1iRw8nCw/7KdQmZm3Si
         KdX1ZrMSk4plPIbjdJCrWnfvq92Y4lbfC5Dkn7ZzlhLDr6XJwWypUopzswVoXQPSk1pd
         BSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511043; x=1700115843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFc9wQ4/Iy4PKdImLLDNhJ0n+o/UegEm1+YAiGXRu/I=;
        b=WLK6+FiJcIPfkEqxVUHrVtWMHX3uDLNQjJWQ5oaqT/VprYewYg1Qtp3iVMlZPB1Tm7
         ol6sTl4p4o6IaTpWM+yj4raLHi7lcUEzfciQly/JNgYXtbw6PKgUt/CMX/RVcUCiMsmZ
         iHZeN2LYmtJDZ9DhCAH3QNkrQgNI+jsA8IGMpPPE//ewfFliXSRem6yqi3i+XfyjwsEv
         HPmdjCl/fd4crfYVfAtYwcyUYCT6Y0NrKTZYsvWuGnRb76Cfh4sN2NmzfPR1DT3LiGEb
         MmZaoXVoquyLFoeLHpyxqJgOEaag26GuDxkm+8Lr/6bi6kB3WcaNFI7aD9MERdaaeZ3d
         hD9A==
X-Gm-Message-State: AOJu0Yy0UXWXfYOxsbXHvWdRuIwZ1Ftvcmzq1VXNvwMRaNVxRaR1Phn9
        mDpjstngkoc3fVWpb7wLhuk=
X-Google-Smtp-Source: AGHT+IE3cZ3DuOosirJu/INcFn53+KMAee5oRE7ari9VJt9LqcTKD/HTiWbXWDDQb1upLYWEojsleQ==
X-Received: by 2002:a17:907:7294:b0:9e2:b250:98ca with SMTP id dt20-20020a170907729400b009e2b25098camr2948628ejc.28.1699511042727;
        Wed, 08 Nov 2023 22:24:02 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906694700b0099293cdbc98sm2122227ejs.145.2023.11.08.22.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 22:24:02 -0800 (PST)
Message-ID: <25059951-ca50-4b19-8f74-5631b34c719b@gmail.com>
Date:   Thu, 9 Nov 2023 07:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hwmon: (core) Add support for humidity min/max
 alarm
To:     Guenter Roeck <linux@roeck-us.net>,
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
 <20231020-topic-chipcap2-v2-2-f5c325966fdb@gmail.com>
 <44f1eaa3-a90d-42cf-9808-4f39aacbf270@roeck-us.net>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <44f1eaa3-a90d-42cf-9808-4f39aacbf270@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 09.11.23 01:02, Guenter Roeck wrote:
> On 11/8/23 07:37, Javier Carrasco wrote:
>> Add min_alarm and max_alarm attributes for humidityX to support devices
>> that can generate these alarms.
>> Such attributes already exist for other magnitudes such as tempX.
>>
>> Tested with a ChipCap 2 temperature-humidity sensor.
>>
> 
> No objection, but the new attributes also need to be added to the ABI
> documentation at
> Documentation/ABI/testing/sysfs-class-hwmon and
> Documentation/hwmon/sysfs-interface.rst
> 
> Which made me notice that humidityX_alarm isn't documented either.
> Please document that attribute as well while you are at it.
> 
> Thanks,
> Guenter
> 
Actually there are several attributes without ABI documentation or at
least the attributes enum is much larger than the objects in the ABI
documentation (in testing/sysfs-class-hwmon).
For humidity there is only input, enable, rated_min and rated_max. Are
some attributes not described for a good reason or should all be
documented? the current humidity_attributes contains:

hwmon_humidity_enable -> documented in sysfs-class-hwmon
hwmon_humidity_input -> documented in sysfs-class-hwmon
hwmon_humidity_label
hwmon_humidity_min
hwmon_humidity_min_hyst
hwmon_humidity_max
hwmon_humidity_max_hyst
hwmon_humidity_alarm
hwmon_humidity_fault
hwmon_humidity_rated_min -> documented in sysfs-class-hwmon
hwmon_humidity_rated_max -> documented in sysfs-class-hwmon

I could not find the temperature counterparts of my new additions
(temp_min_alarm and temp_max_alarm).

Should all be added to sysfs-class-hwmon or am I missing some other
document? I am alright adding the ones I mentioned.

>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   drivers/hwmon/hwmon.c | 2 ++
>>   include/linux/hwmon.h | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index c7dd3f5b2bd5..7f92984c37d9 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -579,8 +579,10 @@ static const char * const
>> hwmon_humidity_attr_templates[] = {
>>       [hwmon_humidity_input] = "humidity%d_input",
>>       [hwmon_humidity_label] = "humidity%d_label",
>>       [hwmon_humidity_min] = "humidity%d_min",
>> +    [hwmon_humidity_min_alarm] = "humidity%d_min_alarm",
>>       [hwmon_humidity_min_hyst] = "humidity%d_min_hyst",
>>       [hwmon_humidity_max] = "humidity%d_max",
>> +    [hwmon_humidity_max_alarm] = "humidity%d_max_alarm",
>>       [hwmon_humidity_max_hyst] = "humidity%d_max_hyst",
>>       [hwmon_humidity_alarm] = "humidity%d_alarm",
>>       [hwmon_humidity_fault] = "humidity%d_fault",
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index 8cd6a6b33593..154de35e34ac 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -286,8 +286,10 @@ enum hwmon_humidity_attributes {
>>       hwmon_humidity_input,
>>       hwmon_humidity_label,
>>       hwmon_humidity_min,
>> +    hwmon_humidity_min_alarm,
>>       hwmon_humidity_min_hyst,
>>       hwmon_humidity_max,
>> +    hwmon_humidity_max_alarm,
>>       hwmon_humidity_max_hyst,
>>       hwmon_humidity_alarm,
>>       hwmon_humidity_fault,
>> @@ -299,8 +301,10 @@ enum hwmon_humidity_attributes {
>>   #define HWMON_H_INPUT            BIT(hwmon_humidity_input)
>>   #define HWMON_H_LABEL            BIT(hwmon_humidity_label)
>>   #define HWMON_H_MIN            BIT(hwmon_humidity_min)
>> +#define HWMON_H_MIN_ALARM        BIT(hwmon_humidity_min_alarm)
>>   #define HWMON_H_MIN_HYST        BIT(hwmon_humidity_min_hyst)
>>   #define HWMON_H_MAX            BIT(hwmon_humidity_max)
>> +#define HWMON_H_MAX_ALARM        BIT(hwmon_humidity_max_alarm)
>>   #define HWMON_H_MAX_HYST        BIT(hwmon_humidity_max_hyst)
>>   #define HWMON_H_ALARM            BIT(hwmon_humidity_alarm)
>>   #define HWMON_H_FAULT            BIT(hwmon_humidity_fault)
>>
> 
Best regards,
Javier Carrasco
