Return-Path: <linux-kernel+bounces-110138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2756885A88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C319B1C21460
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60985274;
	Thu, 21 Mar 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5tZQB+H"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03E85266;
	Thu, 21 Mar 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030709; cv=none; b=RARS/objt+EXKqzfVucyHq3D4nhATkLh2kTnV6zSI1ESvx36zQZTGVbWn+n7xhKY1ZRnqmtCcG4QlaFgkAznkToKy8zdB9hX6ncb4pY9aVyIzaGvfMAYxY2ntam8O86rMVghccU8vTpql8JoSSXQg2Ffhahup29KdebhDla4Gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030709; c=relaxed/simple;
	bh=LK9bZldvR+ngaQivv+IKBbWKyKxbTmRgd4BDWj/uL+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jalzhoUW1Xi2kT/T97BZXFSAD1kLjMYqBXAkgl1fMl8LsBascfhtTM0QUxkN+loMsQuulxVDePowhk6eH8yxtcd2QXSNBsfNWyJogPeBaiY/LK+a9AjYeJlbH7u1ByTrn1TaHBafOvfrnwUytu1USlpARfrdWQJeTd5NALdRHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5tZQB+H; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso1203043a12.3;
        Thu, 21 Mar 2024 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711030705; x=1711635505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/lpdfUCtz0lBv2riTPfCkmgSeNw1YenoxhxVGp5mxc=;
        b=W5tZQB+HBV86rGfqg+L5Ty3ZsBIWL+d1VThvlUvcwIxMSCJV+O1NALi9brn/JCBR3C
         eK9kJa9hBF1ZqtaRRK1QIAOLam+gOO59hUgwAs8hmLGhuk3CQnb/bV/uPTAaA4fD1Y2z
         sZsgq++93Spbe5YXRPJUjt93GXUwn+EbBdhFKb1ZYKbatEQ0biYLJslbv6kZr2d8smlV
         IkscmbYQadO56GGf0gCNVwMyuomSgyn0JEUiCs+ryowwH6Zw4bHQ9m78x40U5eP8uHE/
         RPQIW8ptFHEo7Zei4kwjUV5NA14pes2g+Q47ggSuhOyAe//dNyfwuYu2GstnemPYebxA
         JABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030705; x=1711635505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/lpdfUCtz0lBv2riTPfCkmgSeNw1YenoxhxVGp5mxc=;
        b=ZGKiW8eR835kohR/dtZKoKTsyJTEb9UnSM2cePX17P5YDE2x+MHkuM1KH0XO8DoJuq
         Y7BbTBlggRDmcr4T3D89ZBVAP1tECL8pB3jxVbXJHJCBxg3Z0zd9Lk6ok0irwVyQdTC8
         2ZcnitO2ANy9Oty/spb1wx7ynMnyMBf9PdrKN4MEKMoDHiOVbGyItcvK6h2koMBNWmSU
         FLzJa1wNsdgt8J+7+FGAjyDhmkd+5i5WSL9FGhjO0S8nYOzB4P/TS3Hj7OB6ROGQYfgS
         8kgy8BWUVuGhlWMinHkOJ5CTXj8PXrRt1D0JpZxSRHZSunIhWH9XaVhld/1B8OrPM1ab
         T4RA==
X-Forwarded-Encrypted: i=1; AJvYcCVjyxDn/o3dpaMiDFp/BU8ttzsxM/E+C+LT4D16G+ZqojzUZNZ/fO1xCLcVRCyyfFOJNGROKGGljXqVwDlBV7jfMr2dssRfWEHoaaXMApjIGyyMgL+C5MIaQ0lzmgTf1BaLyVjak9o2jai1N52kKh0BJjVUMfGkhr3RE3vfli3nvXOJ/ZgS
X-Gm-Message-State: AOJu0YwlizPiHzcdCAichtoI38UjMqbBu59iTXjCxsbP33uTtSUdN++5
	6Nc5ZM0v82XyYjmA1DszemWwtzgi3Euxslj2cN4qNwsY/dNOBNSb
X-Google-Smtp-Source: AGHT+IEYhL+PYbacV6FuQPjcTY17ENffDRKWoIKew08brb57avG7xvZxHD8eHh2ZZskqsTGaagdBwQ==
X-Received: by 2002:a05:6402:c4e:b0:565:59a:a103 with SMTP id cs14-20020a0564020c4e00b00565059aa103mr6534311edb.33.1711030705280;
        Thu, 21 Mar 2024 07:18:25 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e8300b0056b8dcdaca5sm3507204eda.73.2024.03.21.07.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 07:18:24 -0700 (PDT)
Message-ID: <8d809c67-8a12-4411-86dc-4918073891dd@gmail.com>
Date: Thu, 21 Mar 2024 15:18:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: max6650: convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
 <20240320-hwmon_yaml-v1-2-a349ca21ccab@gmail.com>
 <20240321140336.GA1648289-robh@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240321140336.GA1648289-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 15:03, Rob Herring wrote:
> On Wed, Mar 20, 2024 at 06:04:58PM +0100, Javier Carrasco wrote:
>>  Convert existing bindings to dtschema to support validation.
>>
>>  This is a straightforward conversion with no new properties.
> 
> Why the indentation?
> 

Will be fixed for v2

>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
>>  .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 68 ++++++++++++++++++++++
>>  2 files changed, 68 insertions(+), 28 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/max6650.txt b/Documentation/devicetree/bindings/hwmon/max6650.txt
>> deleted file mode 100644
>> index f6bd87d8e284..000000000000
>> --- a/Documentation/devicetree/bindings/hwmon/max6650.txt
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
>> -Bindings for MAX6651 and MAX6650 I2C fan controllers
>> -
>> -Reference:
>> -[1]	https://datasheets.maximintegrated.com/en/ds/MAX6650-MAX6651.pdf
>> -
>> -Required properties:
>> -- compatible : One of "maxim,max6650" or "maxim,max6651"
>> -- reg        : I2C address, one of 0x1b, 0x1f, 0x4b, 0x48.
>> -
>> -Optional properties, default is to retain the chip's current setting:
>> -- maxim,fan-microvolt : The supply voltage of the fan, either 5000000 uV or
>> -			12000000 uV.
>> -- maxim,fan-prescale  : Pre-scaling value, as per datasheet [1]. Lower values
>> -			allow more fine-grained control of slower fans.
>> -			Valid: 1, 2, 4, 8, 16.
>> -- maxim,fan-target-rpm: Initial requested fan rotation speed. If specified, the
>> -			driver selects closed-loop mode and the requested speed.
>> -			This ensures the fan is already running before userspace
>> -			takes over.
>> -
>> -Example:
>> -	fan-max6650: max6650@1b {
>> -		reg = <0x1b>;
>> -		compatible = "maxim,max6650";
>> -		maxim,fan-microvolt = <12000000>;
>> -		maxim,fan-prescale = <4>;
>> -		maxim,fan-target-rpm = <1200>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
>> new file mode 100644
>> index 000000000000..1b33b5fb606d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6650.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX6650 and MAX6651 I2C Fan Controllers
>> +
>> +maintainers:
>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> +
>> +description: |
>> +  The MAX6650 and MAX6651 regulate and monitor the speed
>> +  of 5VDC/12VDC burshless fans with built-in tachometers.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX6650-MAX6651.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max6650
>> +      - maxim,max6651
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  maxim,fan-microvolt:
>> +    description:
>> +      The supply voltage of the fan, either 5000000 uV or
>> +      12000000 uV.
> 
> Looks like constraints. Please add them.
> 

Will add enum: [5000000, 12000000]

>> +
>> +  maxim,fan-prescale:
>> +    description:
>> +      Pre-scaling value, as per datasheet. Lower values
>> +      allow more fine-grained control of slower fans.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 4, 8, 16]
>> +
>> +  maxim,fan-target-rpm:
>> +    description:
>> +      Initial requested fan rotation speed. If specified, the
>> +      driver selects closed-loop mode and the requested speed.
>> +      This ensures the fan is already running before userspace
>> +      takes over.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Constraints? I'm sure no fan RPM is higher than 10000 and probably much 
> less than that.
> 
> Rob

According to the datasheet (page 9, table 3. Fan Speed), the highest fan
speed that can be achieved is 30000 RPM (which does not mean that fans
actually reach that speed). I could use that as the maximum value, though.

Thanks for the review and best regards,
Javier Carrasco


