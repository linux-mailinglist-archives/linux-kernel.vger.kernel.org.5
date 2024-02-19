Return-Path: <linux-kernel+bounces-71912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961C85AC71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC83B24A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F05822F;
	Mon, 19 Feb 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCcwxNIG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB265822D;
	Mon, 19 Feb 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372191; cv=none; b=f+jbpaEnIKOEy5i9gtTykLpa1eP1dC17TX6A/BKQrlxedS6id3rgZGGj42o38jFOimfTs9nivoifzWXhO+QiV5JSTXekuLv1xXt2cWhFt0WLX4Ldu79SEAXlRMtOkq9LNiad9wZIA7SQI5sUhpEBDTbx4x4X9+N1WqDjdUB+a5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372191; c=relaxed/simple;
	bh=2BFGhy1GoGAZQrg+qot76orHOK5E0hhM9ZPKjpWs0L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnh5UEbRb6T3YqkM5nY/pcGsmPgf855BUDHbK8VrGsPQuAa3CYikS3vOXxFLY6s8DBWaI0ojL2iQFYbLOAqCbyVew1BmkZMcVMDUrOPiXg4ky4C81PW8byo7x6phj3vHD6RpWHSXSOpStRrQAkyQDVBBXlkK11rgS/Mkxv/tO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCcwxNIG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso29294761fa.2;
        Mon, 19 Feb 2024 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708372188; x=1708976988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+Mxj6oL3njy7wYXA6Pewj5A5hfEOxX2yUvAWo5Ne8Y=;
        b=QCcwxNIGTB7hAr5jM8+nlA13qyCz7fi/DIt9SzF0EPOK9N1V5VnNC6HYmBTi23N1vO
         4BpiDr76lg7K3ucRS4yBHnIAH4ZbiRU6RAr0mWaUWtOmQbQwGIXhuhRNXk+VIcS6wQJn
         MDsU9lXoRDPvAhHPer5K7RnCaMEDEj5r8MfHbyVeCKeEBFLLuBBeGbi5k/uOkkmPIfzc
         dUnLv7Xds80aSitjv8/xeqIyDWBXitFH0GPy1fRGPujgrvXSJCYJpMBntF8mrYQ+djKK
         v2QRphZnloiiX02qD75JhAqSYGH5VllvOkqPDDNY6N4A4weZ7JxuUfFfGW7OTh+Ir1UY
         DNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372188; x=1708976988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+Mxj6oL3njy7wYXA6Pewj5A5hfEOxX2yUvAWo5Ne8Y=;
        b=AoD2bZMfIZEdsbTo9/zyePhjYqhQNemxIlvatQw1w5as6Ve73CuAsrp89qNcLUgBDF
         qamz+sRurVwyxD6Vi6RXq6CYXci3mULwr7Ky2W7vgWXXVg8a2anqSpjqQxwARbcD9dS8
         6mt8VSQ8uTpgaQUukt45T1fGlmYVRt6YVupXpzpKV+IrmJF6j1c4iXqyBTf8KyaMlziG
         nrmzIieLE5BAUYqbQyqKRpyAn7S66vme7OifNpOubSbsVa0qTywQxWptSqj4EFWfSZQX
         JT2nkgEaRbaBJrjz35bDczNjTqd2ST0y6b6DCL6qGnI4DC+7mG4La5jMpdkaDM9gMDcI
         WUOw==
X-Forwarded-Encrypted: i=1; AJvYcCVJqj9v2LDU0DOkllAe9NQca/6DvUA5+5Q7ewMvrvn4y4IX+5xcRklatHeuL7Ak9WtKHN6DsFZg9Pf94deTmemlGvvOnCL6p5KP8krwZS2GNWufiexmiSKiksV4pOnIPuMqLwzD8yy975/jPRZmiP8=
X-Gm-Message-State: AOJu0YwPXQM6IBOFJBz1bzHhDCXieB+fIq9XxolM+6Hzbdh+NpgI+Kww
	r1yq6qOFSzSk3TSbv8273FvdivqFqZmI9YppSt7sA1J0Pd4y4iLM
X-Google-Smtp-Source: AGHT+IFih7GdrQAufuteLL8qMR0G4/2b7CwVADm2kPBGSrjoEY1liwkNr8A7UP7zROTWMCWm0iPUfA==
X-Received: by 2002:a05:651c:b21:b0:2d2:35e6:7a7f with SMTP id b33-20020a05651c0b2100b002d235e67a7fmr3898833ljr.0.1708372188047;
        Mon, 19 Feb 2024 11:49:48 -0800 (PST)
Received: from [192.168.50.244] (83.8.201.110.ipv4.supernova.orange.pl. [83.8.201.110])
        by smtp.gmail.com with ESMTPSA id d5-20020aa7c1c5000000b00564775edd4esm1224313edp.35.2024.02.19.11.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 11:49:47 -0800 (PST)
Message-ID: <c2fde69d-48c2-446f-ac56-876651c06b51@gmail.com>
Date: Mon, 19 Feb 2024 20:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: exynos4212-tab3: limit usable memory range
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240217-tab3-limit-usable-memory-range-v1-1-49cc9c86a5cc@gmail.com>
 <15ab6aa6-fb30-4970-9c50-546afb933e03@linaro.org>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <15ab6aa6-fb30-4970-9c50-546afb933e03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.2024 08:44, Krzysztof Kozlowski wrote:
> On 17/02/2024 20:02, Artur Weber wrote:
>> The stock bootloader on the Samsung Galaxy Tab 3 8.0 provides an
>> incorrect available memory range over ATAG_MEM. Limit the usable
>> memory in the DTS to prevent it from doing so, without having to
>> disable ATAG support.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>>   arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
>> index e5254e32aa8f..9bc05961577d 100644
>> --- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
>> +++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
>> @@ -45,6 +45,12 @@ chosen {
>>   		/* Default S-BOOT bootloader loads initramfs here */
>>   		linux,initrd-start = <0x42000000>;
>>   		linux,initrd-end = <0x42800000>;
>> +
>> +		/*
>> +		 * Stock bootloader provides incorrect memory size in ATAG_MEM;
>> +		 * override it here
>> +		 */
>> +		linux,usable-memory-range = <0x40000000 0x3fc00000>;
> 
> Applied and dropped:
>   chosen: linux,usable-memory-range:0: [4611686019496935424] is too short

This seems to be a binding issue; the DT schema expects a 64-bit memory 
address and size, and doesn't allow a 32-bit range. I've tested the DTS 
on my device and this property seems to be handled fine, so I think this 
should allow 32-bit values as well.

I've opened a PR[1] against devicetree-org/dt-schema (where the schema 
for the chosen node is stored) to try and fix this. If my approach is 
incorrect, feel free to comment there as well.

Best regards
Artur

[1] https://github.com/devicetree-org/dt-schema/pull/128

> 
> Does not look you tested the bindings.
> 
> Please observe that we have dedicated subsystem profile since a release:
> https://www.kernel.org/doc/html/latest/process/maintainers.html#arm-samsung-s3c-s5p-and-exynos-arm-architectures
> 
> Best regards,
> Krzysztof
> 


