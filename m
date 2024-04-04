Return-Path: <linux-kernel+bounces-131489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898BF89888F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA2A283BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F07126F3B;
	Thu,  4 Apr 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3huWUUd"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC61EB56;
	Thu,  4 Apr 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236142; cv=none; b=AVU048JsiRAkuj5Hi5wf9EyDefxS3AS/dRKueU38TzFEZS0igfNYjH41xx7/BEcU2giYZUXXm6JSPEsUcdclQgIwlEK8bXopl+B5HO0Jg2rtVgumphZJfuhKXO+4XU4OC10m8GR73RNH2uWUVbIqmkai1GLstPu3iRWj/sGxkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236142; c=relaxed/simple;
	bh=h2UbZkyXiaKgL6uH4uuNeFsZ2ez34zgm0Oisdg5vyqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkzsQrfmSR+4EIJUaEX5jzbp+PgT2eMwI3MVdE0OQBON4PYPHnbLAq92S5b8HzK3IWWied6YKShn7u99kWgvH07cNP7YdLvorutcFr4dmH7b/U3VXEmeFzXL7+hK2KjFVNZ55mQ0igHW2yBHv24q+WjedVvQFZSbemL9z9DQW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3huWUUd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343b7c015a8so602455f8f.1;
        Thu, 04 Apr 2024 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712236139; x=1712840939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pv/Qi7KoaOEOMUmjC6u59B8rww1PLzXdvZJxWlohLyk=;
        b=f3huWUUdFHC7NF9ANT4gubAf+iqJR/pAReY2bjZ+as2hwd0/2BPlw33ppR7PkjZIbU
         ZgwqQ0KQGOsRZwdZE3bf+BFa/CtEi/a4XGGTHahqNltMxlk/kDu5BRfDgJj4KmK2y+0n
         C2CLCG+68FgmCkh2dB188r/KkKRaNz4DcKnSV1NABTubyhBlDMDJW4XcAvwHm7eof+Vc
         JHDfARukpwPZjsLnzGmmQqN0FWkN0OHqJzMuk9OZF5I2uM3rFecFny75R73CosfTFujX
         kPFT4/CHSydNDObMLAPJpdUHwHbEiE4xFjRZxHAyYa4wC6e46iZzhavVSfD8f6WToekJ
         hECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236139; x=1712840939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pv/Qi7KoaOEOMUmjC6u59B8rww1PLzXdvZJxWlohLyk=;
        b=QNtloPSqHN7rpr3jh86Liuv67KvfeyX8QaaYnBIwSOR3scEcjYQ8zJN7gW4kkWvLQE
         pPM3lQPo5cQKgK+8/PrqZS2+QTTIOltP6ZCHl520jGZbYpyyXrbeLhUqF5ab+yyNEKNr
         JuxvKNiPmkFwbgJTCmmfZVk7zckfUVBUPOyAIHrIBeHnQcx+7PanBEjgOSOj3Ak9IqYj
         64XdsaTpOyePIR2H8U3xD2DeU2R2ZzIXNFrGEvgDagSoOfbAxOnEPZfYA3lfMVB1oYH1
         bBtbCrAPsiOilInfK1cjmRfDYPyN8uiopfRLP/C3WBK7IL5lPn2H7Dx8Cxtr2dfCP1/n
         OH7g==
X-Forwarded-Encrypted: i=1; AJvYcCVML4LvNX3uahFclvqCZ0OjqhISoikpWEgpFk46eq5fU0q7f4ayXOHgYZofzqOGbh3XobE2l+u1wTVAXAYzi/N/uc4XuOad4BWdT533TiTVSFEpyth8fSC5D/JYp2Io6QiMU8fO3InaCI2qdF+G9hnTi5xrq79hUfGATMAU+jZVE9d6uQ==
X-Gm-Message-State: AOJu0YwL+Y5vcogsAJrAI12J2dAUbpWmKYx0YixTCBMfHVsIuTOqrjGu
	KqfEM6KnzK4rYXH4FXifMICMXUCA9k6jKujMi/z0qqzABeoyjh7t
X-Google-Smtp-Source: AGHT+IHZ5ilaONhEc/8resaz7bIMJaPEbNbv2CtcO8bEWOzL11rySsrX3HZyWDX2SNIHxZNkYKa9/w==
X-Received: by 2002:a5d:4a8e:0:b0:343:98ee:524 with SMTP id o14-20020a5d4a8e000000b0034398ee0524mr1825796wrq.36.1712236138600;
        Thu, 04 Apr 2024 06:08:58 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id y17-20020a056000109100b00341de3abb0esm19986243wrw.20.2024.04.04.06.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 06:08:57 -0700 (PDT)
Message-ID: <aa84a3c5-a3e6-4c76-9b67-624ed8d8c704@gmail.com>
Date: Thu, 4 Apr 2024 16:08:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: David Lechner <dlechner@baylibre.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com>
 <0a72de29-6d25-4d2d-9824-ca407af69153@gmail.com>
 <CAMknhBHhxi7mN88+peU7BGkzSP2vtipCuvM-XfQzgusqKvARsg@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBHhxi7mN88+peU7BGkzSP2vtipCuvM-XfQzgusqKvARsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/04/2024 18:22, David Lechner wrote:
> On Wed, Apr 3, 2024 at 2:50 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:
>> On 02/04/2024 00:16, David Lechner wrote:
>>> On Mon, Apr 1, 2024 at 2:37 PM David Lechner <dlechner@baylibre.com> wrote:
>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>>
>> ...
>>
>>>>>      properties:
>>>>>        reg:
>>>>> +        description:
>>>>> +          Reg values 16-19 are only permitted for ad4111/ad4112 current channels.
>>>>>          minimum: 0
>>>>> -        maximum: 15
>>>>> +        maximum: 19
>>>> This looks wrong. Isn't reg describing the number of logical channels
>>>> (# of channel config registers)?
>>>>
>>>> After reviewing the driver, I see that > 16 is used as a way of
>>>> flagging current inputs, but still seems like the wrong way to do it.
>>>> See suggestion below.
>>>>
>>>>>        diff-channels:
>>>>> +        description:
>>>>> +          For using current channels specify only the positive channel.
>>>>> +            (IIN2+, IIN2−) -> diff-channels = <2 0>
>>>> I find this a bit confusing since 2 is already VIN2 and 0 is already
>>>> VIN0. I think it would make more sense to assign unique channel
>>>> numbers individually to the negative and positive current inputs.
>>>> Also, I think it makes sense to use the same numbers that the
>>>> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
>>>> positive).
>>>>
>>>> So: (IIN2+, IIN2−) -> diff-channels = <13 10>
>>> Thinking about this a bit more...
>>>
>>> Since the current inputs have dedicated pins and aren't mix-and-match
>>> with multiple valid wiring configurations like the voltage inputs, do
>>> we even need to describe them in the devicetree?
>>>
>>> In the driver, the current channels would just be hard-coded like the
>>> temperature channel since there isn't any application-specific
>>> variation.
>>  Sure, but we still need to offer the user a way to configure which
>> current inputs he wants and if they should use bipolar or unipolar coding.
> From the datasheet, it looks like only positive current input is
> allowed so I'm not sure bipolar applies here. But, yes, if there is
> some other variation in wiring or electrical signal that needs to be
> describe here, then it makes sense to allow a channel configuration
> node for it.

AD4111 datasheet pg.29:
When the ADC is configured for bipolar operation, the output
code is offset binary with a negative full-scale voltage resulting
in a code of 000 … 000, a zero differential input voltage resulting in
a code of 100 … 000, and a positive full-scale input voltage
resulting in a code of 111 … 111. The output code for any
analog input voltage can be represented as
Code = 2^(N – 1) × ((V_IN × 0.1/V REF) + 1)
The output code for any input current is represented as
Code = 2^(N − 1) × ((I_IN × 50 Ω/V REF) + 1)

I would say bipolar applies here, not a great idea because of the limitation on
 the negative side (Input Current Range min:−0.5 max:+24 mA) so still, the option
 is available.


