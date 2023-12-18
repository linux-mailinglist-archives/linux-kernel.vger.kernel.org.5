Return-Path: <linux-kernel+bounces-4051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC681773F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5A1C25D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8631B498A2;
	Mon, 18 Dec 2023 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMyt6E+6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA149888;
	Mon, 18 Dec 2023 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4665fb8a7e9so451301137.2;
        Mon, 18 Dec 2023 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702916310; x=1703521110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HQFk8KSk4ImJwtsGcFEdS5YHLbNQQV6HJ8e8flUomYs=;
        b=DMyt6E+6uzq3CjV+VKy8ZhywdEbFlft4BQj6jgg+GTgZiOvedttf4E8usDvbGitkkO
         37fyUg5EahhqhjyZaNxVyaqvdagQ+jVJ734O1xKG/wdAMUCRHMIZt4OCWv2vv/XbDg61
         97bjK7m+zpfxCBvswCt8nhlZc1v+HbAh8ROsW7AEnWzfGK/5na+IbyFIEJeTicw7WTuF
         y4mHiw9ltraPbg5dUlzvbZiJPqr/JHS7bwmYIZVzsxDH2Vh0YJ/LlRTm6wU8uuonpWYa
         AgUZAXYmqkY0ranh27LN/oAXtS9x+rWD+r1FgsOL4GMfYSBoA9Xm/j5DxYONSWwl5/hC
         m/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916310; x=1703521110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQFk8KSk4ImJwtsGcFEdS5YHLbNQQV6HJ8e8flUomYs=;
        b=SJRM7POatPLgMr7N+ZTr1sr4lF/dy4M6uGFhZSK788cS5I+q1yr+ikj8nBSXlKlfli
         rrd8Wbv1t0St/F+l5LbzHPsiLdf5eGgKSJf6lJC14FI7+Le5MbyA1opkdvT/XclMd5pw
         k31m2cumyHmuHxE6AyVoc3Cd1tGPYXlgAQJY+8vOZlA6N3N1+MeUtRlshoyqMjvpmF48
         pn93k1oOlmERZ4i8hx34rY3/KWc/TyrOQZ3WedaG+SzQr18IO/2I7jP+bDqS1/LUZF8a
         IE33J+jOAtURCJ9DT33eJbzj4VBYAtLMHREdsK1OolefSb0szzuTPygeXp04Eqv/ExP3
         Ggjg==
X-Gm-Message-State: AOJu0Yyfts5IdvBO8RQnw5+uRfEgnw3h5DLLiw/qGw2a7Jck/zHo9d97
	uZQMVFYEsXl/Nm0cLhA5n0I=
X-Google-Smtp-Source: AGHT+IEBCN+vu2mcLWnHo8dUB9qyeVGDkKSGsVOKOhRcQPSwmAFvWMrLe0ovrF65qWtdn7KsY5JymA==
X-Received: by 2002:a05:6102:c15:b0:464:4518:ba73 with SMTP id x21-20020a0561020c1500b004644518ba73mr10334637vss.8.1702916310005;
        Mon, 18 Dec 2023 08:18:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id by10-20020a056102504a00b004669c17b944sm84085vsb.11.2023.12.18.08.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:18:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6732bd18-2157-4ccb-b02c-43f3350e89cb@roeck-us.net>
Date: Mon, 18 Dec 2023 08:18:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: max31827: Add PEC support
Content-Language: en-US
To: "Matyas, Daniel" <Daniel.Matyas@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <2e0bf1cf-824d-40c6-9450-7ed4740f2f46@roeck-us.net>
 <PH0PR03MB6771AD7164ABEEB02650CA908993A@PH0PR03MB6771.namprd03.prod.outlook.com>
 <8b6fc14f-28a5-4caf-80b6-747ff485dcef@roeck-us.net>
 <SJ0PR03MB6764A464744E3A8CE18C17238990A@SJ0PR03MB6764.namprd03.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <SJ0PR03MB6764A464744E3A8CE18C17238990A@SJ0PR03MB6764.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 01:12, Matyas, Daniel wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Saturday, December 16, 2023 3:33 AM
>> To: Matyas, Daniel <Daniel.Matyas@analog.com>
>> Cc: Jean Delvare <jdelvare@suse.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
>> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-doc@vger.kernel.org
>> Subject: Re: [PATCH 1/3] hwmon: max31827: Add PEC support
>>
>> [External]
>>
>> On 12/15/23 12:28, Matyas, Daniel wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter
>> Roeck
>>>> Sent: Thursday, December 14, 2023 6:10 PM
>>>> To: Matyas, Daniel <Daniel.Matyas@analog.com>
>>>> Cc: Jean Delvare <jdelvare@suse.com>; Rob Herring
>>>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>>>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>>>> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
>>>> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; linux-doc@vger.kernel.org
>>>> Subject: Re: [PATCH 1/3] hwmon: max31827: Add PEC support
>>>>
>>>> [External]
>>>>
>>>> On 12/14/23 06:36, Daniel Matyas wrote:
>>>>> Removed regmap and used my functions to read, write and update
>> bits.
>>>>> In these functions i2c_smbus_ helper functions are used. These check
>>>>> if there were any PEC errors during read. In the write function, if
>>>>> PEC is enabled, I check for PEC Error bit, to see if there were any
>> errors.
>>>>>
>>>>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>>>>
>>>> The "PEC" attribute needs to be attached to the I2C device.
>>>> See lm90.c or pmbus_core.c for examples.
>>>>
>>>
>>> I added pec_show() and pec_store() functions and created the pec file
>> within the max31827_groups.
>>> I did not set the flags, because I want them to be set only in pec_store.
>> By default the PEC flag should not be set.
>>>
>>
>> That is not the point. Again,
>>
>>   >> The "PEC" attribute needs to be attached to the I2C device.
>>   >> See lm90.c or pmbus_core.c for examples.
>>
>> That is not about regmap, it is about the location of the "pec" attribute.
>>
> 
> I understand that this is not about regmap. Still, I would argue, that when I am registering the device with groups, the "pec" attribute is attached.
> 

Sure. To the hwmon device. I asked you to attach it to the i2c device, as
implemented all other hwmon drivers supporting this attribute. I am not
inclined to make an exception for this driver, and I do not see a reason
to do so.

Guenter


