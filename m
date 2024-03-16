Return-Path: <linux-kernel+bounces-105251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE9087DB13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9114A1C21601
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D91BF2B;
	Sat, 16 Mar 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evGO440P"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076501CA82;
	Sat, 16 Mar 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610094; cv=none; b=FIl4r+3hJ/1dSdDq0RlEWW5mQUiXIyPILMmylAGWDlG3x/6xqFA6+pLCG3cnYhytQcgnxyglgxa1cMDgv/+0AkR8skp7bKURfoFV7vIqcHX1IKEnaISLk83zggfbSHOeR4zvWp+X5wzz1tVUDi6S/4FgnnzbWGfHWFpIAOT1SY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610094; c=relaxed/simple;
	bh=cjMrzIK3A3GK4ocpb4wGvm+ToDWgy2tz7vSO2aQaK5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8957ct5xewQgVZZmsjNnLk0wcQVaaQFE18N4o448yZ1Ye8U8M+elXOgea9SpgqVqN2JPYweAJ/ZInCcs5K8unHtsYvvDnJP0b3HWKKpGqHPxdMTqUoKR8UbaJz7AwtWEQZKNx4xaLK6kqRg6acpF681qD4yOkF2lOA8mWmX1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evGO440P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a466c85ae5fso27733866b.0;
        Sat, 16 Mar 2024 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710610091; x=1711214891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spcfTWXjA2X48vafZucRsKf/vF9L2dt52hvSePI2WpU=;
        b=evGO440PcC+SDXy1XderlysVZR9u5FGidBy+smgdqp6sXlQ1URICK6UqfwkmSXawAa
         FA6ekuyqGalO0E9j1tQelNyzHHt+Y0hHjdl0Npr45Oa8WdQsvAw4UXKUYRylqTNJyVqD
         lRc5Z9dwpEMA8p2rR0771tzI9mbToRuJme4TfLbLc5uqBe8tjpO3OYWUmqGBiXWdLgRB
         7EFPlRtD0hJnKDLXUjHm93EFXJjQveQV44PDwmaam0aSE6bPi0ytxzcuIV2yIRvd2tbm
         yQh+Cu6iLHBgtQHdT7qDMnnqGH82H3MjfsOtPhyiL8xnUa1RM8DYvD8qtOUyOPxXhuWj
         3EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710610091; x=1711214891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spcfTWXjA2X48vafZucRsKf/vF9L2dt52hvSePI2WpU=;
        b=EE3VbnjrK2zDcDY3pdjwdOL6HKycXPWG9KJGa/HYEbhy5jWOXiXOb2x7hib63gP/uP
         HdhvTYJJWt2V93OuvKp8s/zh+u4twBKgV+e4qAi/9JiyqxQTDX4gS2a8Bu9xCKfdVz7a
         3F2hPtVRtW8B0OAf//L/4de2fMR1Pvkea6mSaOW5nIQq5tq0SDxCWDVw/3voJ9wFh1dd
         c5gRt9W5FesPgdND3PgZaQpKoHRJ3JZ9MUdeDeoaBtKKMkhtS+GLlFNulXXLHbhzDVlw
         nomAHgnYt//FKQ+n9Fn5sDCOAJ1D/TZX4QRAFKDbF+4et5YaVPG0OptFWtWrVElHMPBb
         x9EA==
X-Forwarded-Encrypted: i=1; AJvYcCUe92qWGQhtPWagiW9UojYKZrOFW1vknXcvHr4bowmaX83VQMlW/2ybIhscnexghXfV+BG6GXFESs8O6U2fcBsciZ0ADWQ7Fs0gx1sNzZMzfNh3w9miky4OOXmYJ2fupW7SWEL9ThySy4VQR6uUyoU=
X-Gm-Message-State: AOJu0Ywh1IY3azbgq8YZhxj1Rq6TuygEKeGbjifkOIoof2urh03RpqmI
	7YRudhX61H5FWEMHpFAQQab7KWXj8fc3JzY61hjfGXGZIvstz0N+
X-Google-Smtp-Source: AGHT+IHZrk3NvoOarVuBPv99GazyJl67C0TJk3R85D0i5hqPXN5zJz2QSCsKKJqIZdXnQifvK/3Liw==
X-Received: by 2002:a17:906:38f:b0:a46:4be4:2aac with SMTP id b15-20020a170906038f00b00a464be42aacmr4307096eja.77.1710610090995;
        Sat, 16 Mar 2024 10:28:10 -0700 (PDT)
Received: from [192.168.50.244] (83.8.206.203.ipv4.supernova.orange.pl. [83.8.206.203])
        by smtp.gmail.com with ESMTPSA id qw37-20020a1709066a2500b00a4131367204sm2925892ejc.80.2024.03.16.10.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 10:28:10 -0700 (PDT)
Message-ID: <fa241568-32f1-4135-aacb-e94020d99c66@gmail.com>
Date: Sat, 16 Mar 2024 18:28:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: exynos4212-tab3: limit usable memory range
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240217-tab3-limit-usable-memory-range-v1-1-49cc9c86a5cc@gmail.com>
 <15ab6aa6-fb30-4970-9c50-546afb933e03@linaro.org>
 <c2fde69d-48c2-446f-ac56-876651c06b51@gmail.com>
 <5d67441e-df61-4894-ba52-2bed8a1143d6@linaro.org>
 <d41b7281-5f44-4de0-9ea6-5dcae26ac295@linaro.org>
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <d41b7281-5f44-4de0-9ea6-5dcae26ac295@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.2024 16:55, Krzysztof Kozlowski wrote:
> On 21/02/2024 09:26, Krzysztof Kozlowski wrote:
>> On 19/02/2024 20:49, Artur Weber wrote:
>>> On 19.02.2024 08:44, Krzysztof Kozlowski wrote:
>>>> On 17/02/2024 20:02, Artur Weber wrote:
>>>>> The stock bootloader on the Samsung Galaxy Tab 3 8.0 provides an
>>>>> incorrect available memory range over ATAG_MEM. Limit the usable
>>>>> memory in the DTS to prevent it from doing so, without having to
>>>>> disable ATAG support.
>>>>>
>>>>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>>>> ---
>>>>>    arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
>>>>> index e5254e32aa8f..9bc05961577d 100644
>>>>> --- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
>>>>> +++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
>>>>> @@ -45,6 +45,12 @@ chosen {
>>>>>    		/* Default S-BOOT bootloader loads initramfs here */
>>>>>    		linux,initrd-start = <0x42000000>;
>>>>>    		linux,initrd-end = <0x42800000>;
>>>>> +
>>>>> +		/*
>>>>> +		 * Stock bootloader provides incorrect memory size in ATAG_MEM;
>>>>> +		 * override it here
>>>>> +		 */
>>>>> +		linux,usable-memory-range = <0x40000000 0x3fc00000>;
>>>>
>>>> Applied and dropped:
>>>>    chosen: linux,usable-memory-range:0: [4611686019496935424] is too short
>>>
>>> This seems to be a binding issue; the DT schema expects a 64-bit memory
>>> address and size, and doesn't allow a 32-bit range. I've tested the DTS
>>> on my device and this property seems to be handled fine, so I think this
>>> should allow 32-bit values as well.
>>
>> Regardless where is the issue: please test before sending.
>>
>>>
>>> I've opened a PR[1] against devicetree-org/dt-schema (where the schema
>>> for the chosen node is stored) to try and fix this. If my approach is
>>> incorrect, feel free to comment there as well.
>>
>>
>> According to Rob's comments, the DTS is the issue.
> 
> With updated dtschema I still see the same warning. Is something else
> missing?

My bad, turns out I didn't test my dt-schemas patch correctly... looks
like this has been *properly* fixed now in latest dt-schema[1][2], and I
no longer get warnings about the linux,usable-memory-range property.
(There are some new warnings though, for some nodes in exynos4.dtsi that
have 2 reg values, but that's out of scope for this patch.)

Sorry for the general confusion, I'll make sure to double-check my
patches next time...

Best regards
Artur

[1] https://github.com/devicetree-org/dt-schema/commit/08eff8e6167e9e0bc1694af6c298b4584105a057
[2] https://github.com/devicetree-org/dt-schema/commit/c95c9ad63c51f8d9cfb258e6f17a8001efab6d64


