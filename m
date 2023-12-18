Return-Path: <linux-kernel+bounces-2892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EF08163E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8601F21BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE81C35;
	Mon, 18 Dec 2023 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGodwGpQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3B17F2;
	Mon, 18 Dec 2023 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-464811e5b3cso1440292137.1;
        Sun, 17 Dec 2023 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702861033; x=1703465833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua44E5BPl9HAD03zlKri6iZKBMMrJl8SjoqsOHlHZhs=;
        b=UGodwGpQpjx305+szrdgcxrSq/jYhjo4nYDN2TNVpxK2+0KWy3CfcoHLbV2GL8DRxO
         Rg3uwcWZQ8ptz0wSBGOlf4ll15aRk6RYUmrmnXzMKI55YB9H6CIouFWI3WL6MNp0ih65
         /jxfuOabhvTljvyc8ohDNMTbp93e1z87UJ6TIvDWTXVxVQSHOKT2v8DmaIyTW5DZ+Krw
         yGZFv77z3CkZccLbrSVmh/WuoErzU7hFoiHxjoh58X6750c7IFsO7I/PFxMZWeKS4NoD
         XgWO+hLyyw4WDGyNAYCUSUntDZwDf5BLucfgGVOPHx97eEhAemQ4zgfyWlTQhATGPllz
         0Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861033; x=1703465833;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ua44E5BPl9HAD03zlKri6iZKBMMrJl8SjoqsOHlHZhs=;
        b=DjfjcVS6us2/SnuETmQzjZmarMf107EPLMgvNfN3Txfuu79Vex1GNA2lwQIVYlTlWK
         xw2/A1EupZ/DDCNTV9beqbjfnfkCIkQBJsc4MJowyGxrUr09Rpb23EOLnKkOqPrVaNKQ
         3wBzxHH/uIsvET06mOIX0jCt/HKO+a75IHIQURihqyS7d5tmHgnmZ8wmz4FKJRL65e87
         7CDXEcCvssEiwyW0njdQTjNbmTakdAOFjWEyw3d8UMmostZyy6q2v4J3ur9Qu2httczm
         uegqJ77SDcScxhiI2GTazFcXd4VuT14iCBk3ZuAxsAT9FUR7rEeo/RJIXqxbI7tNpbx4
         mu9A==
X-Gm-Message-State: AOJu0YzRB5tKzMNDwvWC50smiS+3g7orMZSy/NTH/Nr0eR/ywaeoTYXx
	LzmuXFvgBbwQzyAaJKMkCCeLW6pKafs=
X-Google-Smtp-Source: AGHT+IFa/5bsWypJvjqnNbXaIQ1NmmoRv+s8QtibPCHYKw8CzNSGPSZkMudE7sGfdyyxrbKqCCCVfg==
X-Received: by 2002:a05:6102:4188:b0:464:5eac:c249 with SMTP id cd8-20020a056102418800b004645eacc249mr13650235vsb.0.1702861033411;
        Sun, 17 Dec 2023 16:57:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13-20020a056102150d00b0046699e9815bsm65359vsv.0.2023.12.17.16.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 16:57:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd337fdb-ca91-46f3-890a-2362a85580f9@roeck-us.net>
Date: Sun, 17 Dec 2023 16:57:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add AMS AS6200 temperature sensor
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Abdel Alkuor <alkuor@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
 <20231217-enlarged-mule-a594e472d007@spud>
 <fb0973e5-0249-4616-ad8a-0b19d8b73094@roeck-us.net>
 <20231217-disregard-buckshot-772429f0be34@spud>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231217-disregard-buckshot-772429f0be34@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/23 13:44, Conor Dooley wrote:
> On Sun, Dec 17, 2023 at 01:39:37PM -0800, Guenter Roeck wrote:
>> On 12/17/23 12:58, Conor Dooley wrote:
>>> On Sat, Dec 16, 2023 at 11:39:29AM -0500, Abdel Alkuor wrote:
>>>> as6200 is a temperature sensor with a range between -40°C to
>>>> 125°C degrees and an accuracy of ±0.4°C degree between 0
>>>> and 65°C and ±1°C for the other ranges.
>>>>
>>>> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
>>>
>>> Is this not v3?
>>
>> FWIW, I don't recall seeing it.
> 
> Ah, I think this was originally submitted to iio, went through 2
> iterations and then ended up here on Jonathan's advice.
> 

Hmm, yes, that would have been a duplicate. If iio support for lm75
compatible sensors is needed for some reason, a hwmon -> iio bridge
would make more sense.

Thanks,
Guenter

>>
>>> Either way,
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>
>> As I pointed out in my reply to the other patch, this chip is mostly
>> compatible to lm75 and almost register-compatible to tmp112, the only
>> difference being some configuration register bits.
>>
>> Bindings for this chip should be added to
>> Documentation/devicetree/bindings/hwmon/lm75.yaml.
> 
> Ah. In that case, I would expect my tag not to be picked up by Abdel.


