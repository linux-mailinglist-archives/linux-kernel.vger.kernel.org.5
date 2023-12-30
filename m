Return-Path: <linux-kernel+bounces-13450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC38206C3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D22820A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B9F945A;
	Sat, 30 Dec 2023 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi+bZ1Ws"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739F8F44
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5ae89c7bso29639855e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703946121; x=1704550921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWcrHQUcAcYaLbM7fZ2AepXLu2WNUV5dOqY0bUDUUrg=;
        b=gi+bZ1WsvWP8GiG51CagVZoGuTVi94M4chol1UXwfV7+7otEbksyYZBSauJu2dJyML
         ELMjd3G1AHnA0vRXSjY4FPPVFZKppH22JF9/95YmhKmtF7zN08ySOrQhG2tepaaf6Qii
         Yt6C/150X1U0BEH+1l68b4V4CZTe7EDp24Nazlra9xdT/Xr3NmnnQMtOuAwtvDp5QgVJ
         B0tJhiIds2bf6JBzolixr/tLqp7JxxFQgcU+y7+Uru8TInsQ56VTozfUiE6yCUA3H54Z
         kZ54St+EZb6OoxSbADc8aLvYwS/Qmyl42HAQhLsL5xGRN0jugF5J3jDO6v9Z1Xt52usw
         J2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703946121; x=1704550921;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWcrHQUcAcYaLbM7fZ2AepXLu2WNUV5dOqY0bUDUUrg=;
        b=q+gzbeVPrh8fZa8mAAWnX6dhKBo+LBrxZAm/pnxzdydLSSeUhTAjEBCyH+/Jy9Z1/b
         K0LmdG9g8nm8VkB/I+U4ooXfPfVyTBbRL9GSdyoi64SPHfOclX1nET4mWhihbO/5UAFk
         tsKPUNmPyVCs3NquATnBSYaWrMkO1t001iZNK2FUpjgTdVIzsgWJgmTFVy99aqxqHUFP
         9IJ+Sx4jSnKJ+fLIQJtltIzn7jXOGWKBXY29ID0YUNV1uYgHqKghBEONWZBRI0wLId+m
         GPAzTZCyl7EgfGxH9izm0FKv/8UfislPn66qtYJc4GDe34E2bUcJ/5Hu5JwU4UJD52DI
         H7RA==
X-Gm-Message-State: AOJu0YyztBxS+8hDOKkYFOwwlv7J5avHYLtYYB44vPr16pic6QeYVXGz
	SGtUpyGzr3q8Wed5IoymdSaHg2IbCbwEMA==
X-Google-Smtp-Source: AGHT+IFooxihoErjBcxLzzB6fg0RiaonXP2L4PWQ2qTT5vu04+b8n42IQiCcek3m6uSme6GFNwFzCw==
X-Received: by 2002:a05:600c:3ac6:b0:40d:7d83:d98f with SMTP id d6-20020a05600c3ac600b0040d7d83d98fmr1057772wms.94.1703946121011;
        Sat, 30 Dec 2023 06:22:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b0040d5ab35657sm15783233wms.4.2023.12.30.06.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 06:22:00 -0800 (PST)
Message-ID: <09b7b9c9-a746-44e1-b504-c684d2e0eeaa@linaro.org>
Date: Sat, 30 Dec 2023 15:21:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: crypto: Add Tegra Security Engine
Content-Language: en-US
To: Akhil R <akhilrajeev@nvidia.com>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, Mikko Perttunen
 <mperttunen@nvidia.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk@kernel.org" <krzk@kernel.org>
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
 <20231219125614.33062-2-akhilrajeev@nvidia.com>
 <fe87e220-560b-4d47-bc7f-cc7104d40921@linaro.org>
 <SJ1PR12MB63397127C6E6D1289FA7E464C09EA@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <662833e4-fd2a-481c-9d40-5e691d9a0cfa@linaro.org>
 <SJ1PR12MB6339008197C4E7F8FEA3C783C09DA@SJ1PR12MB6339.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SJ1PR12MB6339008197C4E7F8FEA3C783C09DA@SJ1PR12MB6339.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/12/2023 08:11, Akhil R wrote:
>> On 28/12/2023 10:33, Akhil R wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: nvidia,tegra234-se4-hash
>>>>
>>>> What is se4?
>>>>
>>>> Anyway, filename like compatible.
>>> Similar to the above, the hardware name is SE4.
>>>
>>> nvidia,tegra234-se-aes and nvidia,tegra234-se-hash does look good to
>>> me. But I am a bit concerned about the ABI breakage in case, we need a
>> different compatible for the remaining instance.
>>
>> Isn't this a new device? What ABI breakage? What would be affected?
> 
> I meant a scenario where we need to support SE1 instance as well.
> 
> There is one more SE instance in Tegra, which is very similar to SE2 AES Engine.
> But right now, it does not have a good use case in Linux. Now if we add 
> nvidia,tegra234-se-aes and nvidia,tegra234-se-hash, when SE1 needs to be
> supported, I guess it would be confusing to find the right compatible for it.

Hm, I still do not see possibility of breaking of ABI, but sure, se4
makes sense if instances are really different. Otherwise could be one
compatible with some property. It kind of depends on the differences.

Anyway, name the file based on the compatible.

Best regards,
Krzysztof


