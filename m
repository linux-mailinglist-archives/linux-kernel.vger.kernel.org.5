Return-Path: <linux-kernel+bounces-136415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D489D3D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C2AB20E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6BE7E11E;
	Tue,  9 Apr 2024 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM2HZjsO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1869DF4;
	Tue,  9 Apr 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650274; cv=none; b=BXWnyPBAYKg8reZjWlTXX6XXpnh4xlIPHepnWbYAuwaki8BENSRV/QOBm2y0zx+iPhjBqwD/CxCLfF0v5PPcVyycktGssMl1KFyzxbRIAAR24KCEkRzZ1iv10kF4i3D8M/BoL7bri8zASS5nNryiftkqrHy4PINEILRDYDjQQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650274; c=relaxed/simple;
	bh=mpZ9WvBxBftWU2nvlxYc6ybVCBhBaZGYOJfzFuCKWdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itYWn23ozpv4feBEQFjTfAoDsXI8cQvD9JP6GaXfvM6Yiul2v2+j8Ff3wCbg9x8TffVi/8+g6+b2z8FGKTtgqefX692lXs7sEbY8Oo2B03V+LORtNkZkblfe4/AZ/7Oh8lX4BtWHsREOaQDEBI5VF2KLM9yvtBy/vXxHR+IinVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM2HZjsO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so4630753e87.2;
        Tue, 09 Apr 2024 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712650271; x=1713255071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=297Emwb2i0jClNV8FtJNZax66Kj4bzhkdODvVgQa0x0=;
        b=hM2HZjsOySFvE34mJlCU8eyspqiQzqd+PNxuwOI7zCscAPwBNE91/OAYIrKcELPnRY
         2UCiWEEJve5QEnKJqhfGv4/CGU0DzQ2ex6dlvYgfawJpd3RbRLATz9SidNSSHAFDeF+V
         dGYS2W9cVR2i3tdfHaoaTHqcCTbvZaBBuwEk2f20ww5MJXoEH838EdZwSwFc/dzxKBDb
         Jov8G4bqRO5bQrHhKbmAsY419Txa+r7chk7qCgmgJX4RROU6TRJDo8brQZE7WLv7sPLr
         5CaCwIv4LLcWZIyPw5I1VZMLmVhKiRkrCY90lMYcqJtW0Ms0UJQp1YW/gmVuqDowTzKq
         m8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712650271; x=1713255071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=297Emwb2i0jClNV8FtJNZax66Kj4bzhkdODvVgQa0x0=;
        b=Gn28kW61KXBicmNKas8f5jeQZblOnt7gDrmVfQCgAkjxT+s9mFDV/lHau3T6wQHEid
         zWzYA+t7/sB9Ze1wH9ma7nAfTjkAk+9GHHXwfDftNtD4dmzZRTWSi3ejmGdUWhoZ6Qnb
         xJbeyKVC/jP56gHS6OSwne6f2lL/nYlGlrExrfcB8yuOmid1eOOrGYvzA7QB8bIOM04w
         fDm99W4RkShaMBSwhY2q1+8vKpxKcIMOTzKwik7wXm6cJJM6rSXT3hdcIUx68ToUeixi
         LLPyB57yE7Q1N6dEwIhsl4OXvW/64Ny9dADHUF7IeKZ69a8b6feuQYt5VTG/LaAaTOi5
         OlNw==
X-Forwarded-Encrypted: i=1; AJvYcCUrw1l1IK9lhg5TOPSNG9113bBTtx4cPv+Sq+xZA/GTx9w28JdGXjCmqKL4LizjyIDLeTd3XnMymVTDWP013tz1ryXYSEKD/J84xTN1UrVcZWJ4gf+VtsT/ERiGUuMrXwEKfS7SYL63K10RPKd/HJjmyrpT3W49mS+NmQlBOcS3hbQ2NA==
X-Gm-Message-State: AOJu0Yw7bD9wIGrjipYMftZXo6WcU/uAghTYeIed1EZcn9cLN1ZDLI/W
	Xw1wfCDASRlA4qxaZVoxUsP/zRTzW3y5QFrOn60I+Jk+M0xB1DndxDMSwQ9NDShgkg==
X-Google-Smtp-Source: AGHT+IHQocxne5E8JOSSq+Hfi93thAi+YTnQQjQ+sc9yYHH5ggWVu3E+hrTwyp3gx8SwetYpZNSARw==
X-Received: by 2002:ac2:42c9:0:b0:516:d538:35a4 with SMTP id n9-20020ac242c9000000b00516d53835a4mr7448893lfl.7.1712650270754;
        Tue, 09 Apr 2024 01:11:10 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id s17-20020a195e11000000b00515d55b66acsm1469486lfb.64.2024.04.09.01.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 01:11:10 -0700 (PDT)
Message-ID: <47175ff9-8b05-4b6a-8689-a3d0722d7571@gmail.com>
Date: Tue, 9 Apr 2024 11:10:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com>
 <0a72de29-6d25-4d2d-9824-ca407af69153@gmail.com>
 <CAMknhBHhxi7mN88+peU7BGkzSP2vtipCuvM-XfQzgusqKvARsg@mail.gmail.com>
 <aa84a3c5-a3e6-4c76-9b67-624ed8d8c704@gmail.com>
 <20240406152637.5d53c34f@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240406152637.5d53c34f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/04/2024 17:26, Jonathan Cameron wrote:
> On Thu, 4 Apr 2024 16:08:56 +0300
> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> 
>> On 03/04/2024 18:22, David Lechner wrote:
>>> On Wed, Apr 3, 2024 at 2:50 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:  
>>>> On 02/04/2024 00:16, David Lechner wrote:  
>>>>> On Mon, Apr 1, 2024 at 2:37 PM David Lechner <dlechner@baylibre.com> wrote:  
>>>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:  
>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>>>>  
>>>> ...
>>>>  
>>>>>>>      properties:
>>>>>>>        reg:
>>>>>>> +        description:
>>>>>>> +          Reg values 16-19 are only permitted for ad4111/ad4112 current channels.
>>>>>>>          minimum: 0
>>>>>>> -        maximum: 15
>>>>>>> +        maximum: 19  
>>>>>> This looks wrong. Isn't reg describing the number of logical channels
>>>>>> (# of channel config registers)?
>>>>>>
>>>>>> After reviewing the driver, I see that > 16 is used as a way of
>>>>>> flagging current inputs, but still seems like the wrong way to do it.
>>>>>> See suggestion below.
>>>>>>  
>>>>>>>        diff-channels:
>>>>>>> +        description:
>>>>>>> +          For using current channels specify only the positive channel.
>>>>>>> +            (IIN2+, IIN2−) -> diff-channels = <2 0>  
>>>>>> I find this a bit confusing since 2 is already VIN2 and 0 is already
>>>>>> VIN0. I think it would make more sense to assign unique channel
>>>>>> numbers individually to the negative and positive current inputs.
>>>>>> Also, I think it makes sense to use the same numbers that the
>>>>>> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
>>>>>> positive).
>>>>>>
>>>>>> So: (IIN2+, IIN2−) -> diff-channels = <13 10>  
>>>>> Thinking about this a bit more...
>>>>>
>>>>> Since the current inputs have dedicated pins and aren't mix-and-match
>>>>> with multiple valid wiring configurations like the voltage inputs, do
>>>>> we even need to describe them in the devicetree?
>>>>>
>>>>> In the driver, the current channels would just be hard-coded like the
>>>>> temperature channel since there isn't any application-specific
>>>>> variation.  
>>>>  Sure, but we still need to offer the user a way to configure which
>>>> current inputs he wants and if they should use bipolar or unipolar coding.  
>>> From the datasheet, it looks like only positive current input is
>>> allowed so I'm not sure bipolar applies here. But, yes, if there is
>>> some other variation in wiring or electrical signal that needs to be
>>> describe here, then it makes sense to allow a channel configuration
>>> node for it.  
>>
>> AD4111 datasheet pg.29:
>> When the ADC is configured for bipolar operation, the output
>> code is offset binary with a negative full-scale voltage resulting
>> in a code of 000 … 000, a zero differential input voltage resulting in
>> a code of 100 … 000, and a positive full-scale input voltage
>> resulting in a code of 111 … 111. The output code for any
>> analog input voltage can be represented as
>> Code = 2^(N – 1) × ((V_IN × 0.1/V REF) + 1)
>> The output code for any input current is represented as
>> Code = 2^(N − 1) × ((I_IN × 50 Ω/V REF) + 1)
>>
>> I would say bipolar applies here, not a great idea because of the limitation on
>>  the negative side (Input Current Range min:−0.5 max:+24 mA) so still, the option
>>  is available.
> Just to check I am correct in thinking you 'might' use bipolar if you want
> to be able to measure small negative currents, but the range is much larger
> in the positive direction?
> 
> J

Yes, exactly




