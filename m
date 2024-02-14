Return-Path: <linux-kernel+bounces-65834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC185529F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5FE28F676
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A9513B78B;
	Wed, 14 Feb 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMD3EN5D"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC351384A0;
	Wed, 14 Feb 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936537; cv=none; b=jhNUkEJ3bTb8Ce5091VQ4Qg4hJSEX6EUsy8B6KTOLwDmwXwoIA/itBvA5xSmQCJLQsd1JkqrSoNDTK8M/zYJ1MuRNDTXRqPQFzC9KwzLf6f+DxiEOuCY8gY7eEiYKwsOWUALfLOHhBIN1N8EgPAXWsD2HjZWmbf2yp8Gw6kESgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936537; c=relaxed/simple;
	bh=pOVKRebWhV7n7m4ZjObIAKwB3b8dCEfxe4PRxe/KDWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGTQHtHZHv5SgIHZvoTlvYhJsM70tpctnjNptdO+gS1qEkqEws1OY+m30eX9p7hOeNxEq4uhpqfbLVJT6r67wDTexxSgqeAKJ6mNskHq4DD2I1mfPmvmA5O1qQ8jys8aomTKc5WmIsr2AJzi3oFI/WngiMUiUO+tO1Zyp3eMW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMD3EN5D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d780a392fdso285715ad.3;
        Wed, 14 Feb 2024 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707936535; x=1708541335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hyo3Q/IbcVovj8JwO9KyJKtXx6qvAjxBHeXSsK94osc=;
        b=SMD3EN5DBoLYrKSD4caUgmQpR3nbJM8RrCrJAic+UKz7Zti4HneX2sA1AmK+vl680r
         UYph3Evvx/GdVrku3REc6N62mFcAlTxgPUO9eRQOxeNnCxKSjE+CwH4aJXmBVCSdZTg4
         U21OajX5w5r6c67+H16Xz2yExQ3kspglpEwHfPJOcVIKGlVkrCMXEaLAlEQY51gmtvtj
         ZT301SyqN409htCJGiaoJPQCYoppCPn8yd72mxzcu4dIdANBBwlU70Xkl/oHe2udeMOz
         luUOLz9fhDZpE7aElqJrUMFgBZcg30Qw9nSuCGvMBDKGuKJ4/RzKO8GLmCbttapPgZa4
         oMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936535; x=1708541335;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyo3Q/IbcVovj8JwO9KyJKtXx6qvAjxBHeXSsK94osc=;
        b=qeoQoRmnv0vdrY1PXlYUajpsb9+qDB7ab8gYnVJEQomNy/lGvh7SnPrnq9VvaUYYNW
         eks4rnL0bAgZj6FAe5yJ3yxuIsi5uGRxdDegO8xAwC49WAHPI0IeJ5Y0Ht5Ld4zhhgsT
         aLIWSGpfEzVemqkt9OOVRpMncA/t3GEMTaNqv5XuOawWonu3llUddirOwX5ML+3GUyUX
         DF/ppp+BieJ+IMn8H3OKQojCzTEE30jyEgSX0Uo4EQA8cttvJ4DSTLLEXnGJtLsQJPN3
         aN/sRjmwVSHpP3RTcxpBLUKLkyUbB8M3Y9+oPv+1fsXnFtFCdhduMMGI3jNk9eSHGUXV
         YiEw==
X-Forwarded-Encrypted: i=1; AJvYcCURZBKqg/E6V7tViakpc8rpX3u7OUJi3ajCHdKDyszm37o2qWzvfOSbIRTHF2yYdRDvguAUNG4QcOviIkN+SfdqEC5YA0K3NnAPK9rjPV+DzO5ONw5FpCWxw1w+rQQOqDRNVjTkCqLENhpc6aHFw1eSN/ZpBUlBy4C7rLwUcS3IGcS2a2UQ
X-Gm-Message-State: AOJu0Yxqu1zUEMoiOOQpJZt8C7pe+kF90ec17UUa1bAAkyrh/UPltBS2
	do1aUB7Y662aCp4APi1GPGqMgPJesN1TaW7hj1XOzkRVLdhRI9sA
X-Google-Smtp-Source: AGHT+IGOp5/gKa4jFCwSvovA+CzTsjNgQ2Ix0P9SR9c7PV1Mzjvgeg3t3A/qTlQeC4Y7kV1QfFoybA==
X-Received: by 2002:a17:903:11d2:b0:1db:4c96:b578 with SMTP id q18-20020a17090311d200b001db4c96b578mr4400337plh.59.1707936534828;
        Wed, 14 Feb 2024 10:48:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPtIqTF4L1Wb8UmMEzGPnARDHbfqYTpjW9PzMQscNefsWqgi6rM99NpvK7FtNTmi5nEWUJhtdPvu/NVWyzFIH04LB6tg8KD+1VAjoiIlLcjhZ7ng6dEY682AdxlMc4MT1qYEi6MW6oxyrQ/dTnt8qChOIXqB3AGxwTu3gmkfjesewlc/MnjE9DUa8GQmfCnW893wTqODJMJFuS7AQY5DahpxGr+5+A6C6NDGVhbHUtpUivFWzk8PvPbXepM9fFrPEssxuUE4txV/HQjydj7EbsxUlxEJlih013beQaXlXL0LR+FsD1W2EXLgx5E1napGXpGzvj
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001db2ff16acasm3418170plb.128.2024.02.14.10.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:48:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>
Date: Wed, 14 Feb 2024 10:48:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
 <20240214-trinity-delouse-6dcd0b046895@spud>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240214-trinity-delouse-6dcd0b046895@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 09:51, Conor Dooley wrote:
> On Wed, Feb 14, 2024 at 02:55:03PM +0530, Naresh Solanki wrote:
>> Add properties for interrupt & regulator.
>> Also update example.
> 
> I feel like a broken record. Your patches need to explain _why_ you're
> doing what you're doing. I can read the diff and see this, but I do not
> know what the justification for it is.
> 
> /30 seconds later
> I really am a broken record, to quote from v1:
> | Feeling like a broken record, given I am leaving the same comments on
> | multiple patches. The commit message needs to explain why you're doing
> | something. I can read the diff and see what you did!
> 
> https://lore.kernel.org/all/20240126-fleshed-subdued-36bae813e2ba@spud/
> 
> The patch itself does look better than the v1, with one minor comment
> below.
> 
> Thanks,
> Conor.
> 
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>
>> ---
>> Changes in v2:
>> 1. Remove TEST=..
>> 2. Update regulator subnode property as vout0
>> 3. Restore commented line in example
>> 4. blank line after interrupts property in example.
>> ---
>>   .../hwmon/pmbus/infineon,tda38640.yaml        | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>> index ded1c115764b..a93b3f86ee87 100644
>> --- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>> @@ -30,6 +30,23 @@ properties:
>>         unconnected(has internal pull-down).
>>       type: boolean
>>   
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  regulators:
>> +    type: object
>> +    description:
>> +      list of regulators provided by this controller.
>> +
>> +    properties:
>> +      vout0:
> 
> Why "vout0" if there's only one output? Is it called that in the
> documentation? I had a quick check but only saw it called "vout".
> Are there other related devices that would have multiple regulators
> that might end up sharing the binding?
> 

Primarily because that is what the PMBus core generates for the driver
because no one including me was aware that this is unacceptable
for single-output drivers. We now have commit 88b5970e92d0 ("hwmon:
(pmbus/core) Add helper macro to define single pmbus regulator").
I guess we can update the tda38640 driver to use the new macro
to register vout instead of vout0.

Guenter


