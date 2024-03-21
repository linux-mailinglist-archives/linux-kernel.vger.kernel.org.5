Return-Path: <linux-kernel+bounces-110136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619F885A80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1247C282932
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA88526D;
	Thu, 21 Mar 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksrh5gh/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90D84FCC;
	Thu, 21 Mar 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030652; cv=none; b=HjnfTZ7k5rq/FySC97WFCquLf81ZbrO9lEwd4jbJk0WpThXrn5AGOojmTS2jlkuwpFiEiqZZGZ/ueL53c+3rXgtljILIH1PFvcK/5wgDyWThqYrPPMUUHWuQUfGUYxaW/xEL5luaaGa8MYPRLNK1f2AVob3nlKUn+OLZ4PjOTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030652; c=relaxed/simple;
	bh=Ni0tmWCL1hA2kINuC9haUQw7IfddFdgyM9ihmYsSCDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/XtSYRKUnAOp4lnQRR/GCJ2/l5jpkWaRU05HsV06bMqBhD5+T245fleX80PeG/MOSM0tSL3trFMjh85BvWH7KXvV+q8e26V37vm8J5CFz6FLEgG2VxsV2flw0OO3xL9tz3bR/hMMvbNKVPGtSTuMJ2vDiiL69h6PRjBPXuCEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksrh5gh/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e07cd7b798so3400815ad.2;
        Thu, 21 Mar 2024 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711030650; x=1711635450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H731sFXJHRN+U6FhoZgkf7hLKrG+XElaabkVAhLVh2I=;
        b=ksrh5gh/itwciEUZ8vswRHc9ZmynXL6OdAiqpLZg04kOmK8p3c+IO5AWsNJfCZdYdG
         JiPmGyo6szT29OI1yV3so8UQboWOoKuewxY1i5VWC2klLqNQmjeZQuqlplzEmj5Wrp+L
         DfYfNH2+Di76JqC13qKCsqnGZOFhVRI+OvQXUvHYB4Ca26yyG9qdNFs8oULMPQQIGrLL
         ulWwtbOEgfsujkp/W5wrkjnXzbZvdvwSiE4kaZ6AcfrCWlHo+bT2e+HhWyYO57bku/XQ
         sltaBZddjrOwkT9+zp+sgUttpdhfjkguD1NACSDcO77ZthaUv63tFz4NIj8LJccSEWEw
         eW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030650; x=1711635450;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H731sFXJHRN+U6FhoZgkf7hLKrG+XElaabkVAhLVh2I=;
        b=monr/Ftopb1Lzs9Px/zhPMjg2X9zkmWS2T/iUBto08HuBlSKIXVtd3sNAuSiGDQcXC
         3ziPmJXNJHrFJz9uRzIlJgmPkpf7rWmaWXMlnwWjpEuUpbQk4VYzlq8/Q8fYsfO9m54w
         niogmfC8uwl/0huUSbiBfOz6sAwhJkFdb/bbEZQMTyEEK39uGHIkFSEkeFt2bNVRWRbO
         AhdmCrzesRnB84hPZSNtbj3Tsb4rO6SypRUj2QkWS3G1ykp3hn2Cyf9uNuMlWYTteEw/
         LHNb4HnJaqZ1vJFwAWA42AKFz7DiZSJ+0BSgiD3UK4KjZAIPn8aFN7wtVKw6tr74ot9x
         aYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb0Zuucd2seSmTrmJ+ukjn0TH+BKztBpyhGLZQccHnNjryu05trWRD+IxPAwx929MwIyNmcIOPkbGafl0TS0SJLrbr2T8TA/2CBESRz1142bfTsTMKBXWhct0HTU0zhOJd5eMULwSpg7n9yrD4zQNsOM9KkZl/bhXjijqNUGHWTNtYpolF
X-Gm-Message-State: AOJu0YwcCYVsn/9eSC5MxDghRsGP3dXDKxTdJ7uOYc6bN44gt8aW5vsC
	DYLs43yy9Tu4i6JW8z2mjkL4GpE4G7c9QONOXhhz45GBaDpa+MWkw4N46HyY
X-Google-Smtp-Source: AGHT+IG1Tj41Rl8D3VY1vXme2ZcXyMlGDaoWFG7F42KCXLbE/aXwYp4DS2PRAbM0+Ks0KYyDtbv1Bw==
X-Received: by 2002:a17:902:6848:b0:1dd:e13d:6834 with SMTP id f8-20020a170902684800b001dde13d6834mr1915471pln.41.1711030649737;
        Thu, 21 Mar 2024 07:17:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d04200b001ddd6ba8113sm15970022pll.207.2024.03.21.07.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 07:17:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f3235950-fdec-481e-a4db-9cd4146c19b0@roeck-us.net>
Date: Thu, 21 Mar 2024 07:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: max6650: convert to dtschema
Content-Language: en-US
To: Rob Herring <robh@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
 <20240320-hwmon_yaml-v1-2-a349ca21ccab@gmail.com>
 <20240321140336.GA1648289-robh@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240321140336.GA1648289-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 07:03, Rob Herring wrote:
> On Wed, Mar 20, 2024 at 06:04:58PM +0100, Javier Carrasco wrote:
>>   Convert existing bindings to dtschema to support validation.
>>
>>   This is a straightforward conversion with no new properties.
> 
> Why the indentation?
> 
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
>>   .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 68 ++++++++++++++++++++++
>>   2 files changed, 68 insertions(+), 28 deletions(-)
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

There are industrial fans with much higher rpm. mouser.com lists one
with more than 60,000 rpm, but I am sure I have seen some with more than
100k rpm.

Guenter


