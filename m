Return-Path: <linux-kernel+bounces-48225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D5C8458C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D561F228EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBB5337F;
	Thu,  1 Feb 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwETjeiI"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432E86621;
	Thu,  1 Feb 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793776; cv=none; b=kbdytWw9noin1Pnvlr8yEBhlO1C+Po844yeUgwkNu5ZR4GnEAU9rXvP1cMfF9qI1sQUOPaw1e652TLn535NgaOzWm3qq/n9gsUQYD6u4nRo8NJvsXYQ6g8x3zBJqBLn7PhqX1cYhGNx7a8kkk1BQ8BjJOVnKYk6B7nTqF3M+h3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793776; c=relaxed/simple;
	bh=vokLkeIidowuajHipMR4mkfqPi0pW5c7oROD0jamceE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjVZztgC1l9aHiOIhtl+NvXcB8iJApLj+qaHdAoB/afd9xpZHF+yDAZOuRMZFrbQe1NpM5xzMWby1yNCd8eTb82I39ec3aNJCf/k187/F2L8k08euWTlOfWdgZyf2ZcKUNgU57m9tIvT8ZR656llNnb5w4fuoGHyOFPpWjP0Frg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwETjeiI; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd72353d9fso727637b6e.3;
        Thu, 01 Feb 2024 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706793774; x=1707398574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a8m6p4R/qWa3Oc2CGmk5cl/vlFYK+h6Kdog3tpCIG6g=;
        b=SwETjeiI4LyuJPEsepSaHp/c/xdazcIzRb0SOyPaad4KZtKHeF0D4N79lxALo1HxQ3
         0r8gHhHBU2rM3IHJMeLHY+S4Y0wZFbKWkhLmcn+CVtT2Q++SVwtyBV4Yl8wJiIuJ9M1f
         W3YATnztl3qi/dtny04Kter0VZvomzngXxastivowQeIbsddCpG0OGuuCmspfuFbsom9
         NF1PWDY2zea1iL+G/+03gShnR8WF13iMVsZPRJmoVFuiRJnNOZ/oQQey4ew1hFJKFRrM
         kX7ibXNK7Aqn7EONYHV9iSjPUuXfm/YlFgc+bTTAEC4oPHhBOyZO/NnCm5SCakJI9aHa
         fx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793774; x=1707398574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8m6p4R/qWa3Oc2CGmk5cl/vlFYK+h6Kdog3tpCIG6g=;
        b=Mazqkex0rKOk3sYzd14a4pOwy7tqe1pkwXqAV9XAWyp0UG41cDE+GHSiDBGhDqK/3P
         otjIiOY65XFIWlPCkoe0rOjZebR4C3ZVgSrfiM+smzmq9yLVhYK4Q7TWLMdLwPbmFn8U
         PxCfIUISZeDpXi457sHz/L5S4nw0tr9gKbWpFwtjUwPKqM34ZuDHeAP9R2U+4j5qFUrK
         FD5CD+CrxzA5eyJ6Ydn/6A4Lrv/S2AOg33NiennN/CCPQ/YNkkHenOBpI3SE0A+ZHb5v
         DxVOhgZneoHcoW8Ci8B2EmZOu4dgPRvKA/vGTIrqrDVGEeR67TRdaMQtpsq2O/Gjjuso
         /I6A==
X-Gm-Message-State: AOJu0YxgGO4pdYIknvBIBJCmVeJjSRpm1foPtlV9CC2SvyPxPSgZY6hQ
	BL/s4Jp0YM2XkKiInxAJawQWAjp19HCglDRzzz8EOe+XwACkfJHXsZg/O5ua
X-Google-Smtp-Source: AGHT+IG//RlcARoXzzYrUPT30jU6og+rZzratBuOsQOc4Yw0DGpYr2z1SandCteDDuAOYFM7aIXMrQ==
X-Received: by 2002:a05:6808:3a16:b0:3bd:1fdc:eeaa with SMTP id gr22-20020a0568083a1600b003bd1fdceeaamr6721385oib.55.1706793774133;
        Thu, 01 Feb 2024 05:22:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQllq7NVzKCcR+kt25sXV1hJ1we+Dv2XW8zfuk/XShVOXZNbzp7Sf/KE4bNwJR/tuZqpQMlCFkRRtKJyaPqhl7pblV/CUmGnaXli5Jieff+Ice6Wv2r74uqCii2rux4sYE4WnRTFWI9S/PKB5caMumPD9WZCoLa/+iMZ4BzpA6BdPodFp2NnmV1vcPfUdDITgeNYXZB31S8+GTJoGG+6Zk3Q/9Pr5zQ7QDZfhUX/3d7j/30lu0Tfd2CB/u8IAEYA2zjfm48Qu12fekjJkgX+8ZkNtg9cMy7BbL+5qpMTLZuyXvPQMeR9RsQ/1B14+AzZcnOnd8TlVWr+8f+G6avbkjjt4=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a654182000000b005d748902a01sm11070862pgq.43.2024.02.01.05.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:22:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22b75ad9-b702-47a3-a8df-7a207ca152c7@roeck-us.net>
Date: Thu, 1 Feb 2024 05:22:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>, Charles Hsu <ythsu0511@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, Delphine_CC_Chiu@wiwynn.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
 <20240131055526.2700452-2-ythsu0511@gmail.com>
 <20240131-eraser-given-8381a44f41a4@spud>
 <c67ebf90-cb40-4595-8015-45d2a86f6c7d@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c67ebf90-cb40-4595-8015-45d2a86f6c7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 23:52, Krzysztof Kozlowski wrote:
> On 31/01/2024 16:41, Conor Dooley wrote:
>> On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
>>> Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
>>>
>>> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
>>> ---
>>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> index 79dcd92c4a43..088b23ed2ae6 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> @@ -129,6 +129,8 @@ properties:
>>>             - mps,mp2975
>>>               # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
>>>             - mps,mp5990
>>> +            # Monolithic Power Systems Inc. synchronous step-down converter mpq8785
>>> +          - mps,mpq8785
>>
>> q sorts before 2, otherwise
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> I will sort the file and my patch should go via Rob's tree, I guess, so
> maybe this one could go as well?
> 

Sure, fine with me. I applied the patch to the hwmon tree, but I have no problems
dropping it from there. Sorry, I never know if I should take .yaml patches or not.

Guenter


