Return-Path: <linux-kernel+bounces-56688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4AA84CD9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00FDB24327
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157027F481;
	Wed,  7 Feb 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTjmrwb8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B41095A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318330; cv=none; b=I4yaOWfV8edo8u8ptBUvyJjuzHsGFTMGj59dQcVdeVRwTnzyEESjSymO8DSoNRPXd1I0amukeZOXl77OPiAEZUn8XhRRiGc+kBI43lMz5SNiFvkFd+mwCyruf0fA+QFCEDZvrKeJr5rFI+1TdPaNgabrqRNhtNkie/IXlegE/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318330; c=relaxed/simple;
	bh=nQCqZN1M7jS6nlAFAJeHjMhCCAzl4s0EU+vsfwTbNFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0lqwKHzZaBX2geyw67n1XT48uqgXrq4NYYMY7lMN+hLQDsnJo6ehzpW13k7K7K/NWoOWFatE66441fyGtlgQzHGeUdwNNzkyu5OroClVeA+MbcP9CAHhn5571+F6zw3bY5/iYju7x/fqxIUN6uCaoyP76zjoICKsog4fQ5sD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTjmrwb8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so10847275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707318325; x=1707923125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfJNW7Px5n93mi1+mThAoBi6YIbkzwJpqqJDpysXpAA=;
        b=mTjmrwb8v7qnae5xgPqEUJw9cgT0wL12YPUW8zRDcN5JFL2jXUFk8XCbrpQKbpuJQi
         4UcI1S5+SI25skg4Wu2ZU6zn3ozma2n0t9DXII0WQjG6pTISdCG0ShEHocRlCG7jMJrk
         vfyJ5ly2eig7lOgYepA6AhLOpEClwCATOJQTuNHGBEu6NPxNP6oH6fWjB8FDzQf6Upt4
         Hld/HpoLZ6DQKwCIf6iMYoo4elF6tMgWAfwwP1hhVESFYRKMJHv4yG6acqgaRPg90HOk
         8//T5WrOmyBVDmAqDXedW5sDf+/91YUCzBABUUZLjjj/5FsE2bbWfnZ7TTkqdomqi+Ms
         l9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318325; x=1707923125;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfJNW7Px5n93mi1+mThAoBi6YIbkzwJpqqJDpysXpAA=;
        b=cHMz9ITByv0lnEPaCDeqWF9hQkIAV1BhVEvGHIYT2TxOFCQJHzJDbYJCVBjlDY/GfL
         kho2agoo/9GunOIjPCB0oyo2vL7siy1AhGnlveyauHYzsuGtAO6N1+fQnPsMWmS7o0OD
         IwXyTOvP2UH330vzbSglcvablGQJ6NtAwGz/LBsOkeBwdgfsf7bp3p10ZXy+YysluKOx
         O4mgQfiPWgdZfmb8DO/hQzRh35MiNHrrOFt3sW934lE5iRB0BCQeThoa91AZQkb7rxE9
         xhs6zy9n6WogRICH6NECnmZimRpyEqrNxk5LqK+Pu8/ZGUYkKm3hCGGRmPWIEq2xl+wJ
         HHBg==
X-Forwarded-Encrypted: i=1; AJvYcCXhLn7eHI0jgS8PNJzFZW70Cg6db7B8g1cIgtYcZZ7QO8l2Z/IiY1yaQaGM/69RDzU4eAxE1hPQx8LXaAhk9LlW7HBkj3q7FF4yj4Zb
X-Gm-Message-State: AOJu0Yw3vbNvAhV89rJ5Yyf5Pl/fuf4mG2diECvNNqnDmvYOwP7sUPiY
	fwOORLs9sMt0JMklIoLE9PN9ljcu8YJ/HnlFKvDYpst5Yauub8kg5FqqKsDKmbM=
X-Google-Smtp-Source: AGHT+IFTDgu16oVML/Aqbv2KuuaJF8P+GWtWTG0DfBhJu/HgdFG03HXMmc43fVWoL4GwFrVEeV9y2Q==
X-Received: by 2002:a05:600c:4f51:b0:40e:9fd3:6b75 with SMTP id m17-20020a05600c4f5100b0040e9fd36b75mr4928012wmq.2.1707318325142;
        Wed, 07 Feb 2024 07:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUOxf7oHZlTfRSgNMPwMCjSGvD9EvX0EIiPGHbnxACdKX/QJS+vQT1+h2a8OBO/b9zEFwFYXxiF4lTjZkTsz3125PQFJo3POv9LDU4IejfnpQ80y9LaWv3Ac8jRCndehjXvroNgprMqVF2IID8GvzvDs9erVZhPL7NRSRNc3OBPa36LUv9sRKPyAi1qvNiBKtPTq3Rn1iuicNlTjwPRRmflo4pkgXSBgriSbqTUkaScYPAml0pj9AXRSvqpHmT6XaZ/EE2rgvgvtP/B8HzK9JWxcKath7dbRAfjJf4XvMJiQZihwgmdTL5wX4VxoyXh9nqP+eh6c/8GXx41HJnJqfodYr9HZML/yXWvkOCvLKYc+Y0lRJzOETTerzs6UNYSuVGOZAjR9Tuba3jeYdm0qtUBngYjHZjaj9WKWmC5CUUaPpljh50Qv/rCHSkoJG8aJGAU4ZcDKfQE91Vn3VZyfh9Azl6m3K+ZJcKezyxQlY5gTC2u9EJGrORGQt5+5+Uyhn8mCZaAqavzucoPYlIZbhREhiMiNkTAsIc50T4202z6+dKrLGi8PlMB0P0YhRsO+BVd6yRX4zU2lPADq14ks65rOBkMqRVd2b5S2X82/iLbiahxcFo
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c348b00b0040e541ddcb1sm2373509wmq.33.2024.02.07.07.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:05:24 -0800 (PST)
Message-ID: <b7fbbf3e-1e53-46a9-b26c-8acb5f9ccde7@linaro.org>
Date: Wed, 7 Feb 2024 16:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: exynos: gs101: add chipid node
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, alim.akhtar@samsung.com,
 linux-samsung-soc@vger.kernel.org, semen.protsenko@linaro.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, klimov.linux@gmail.com,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 saravanak@google.com, willmcvicker@google.com, arnd@arndb.de
References: <20240201172224.574238-1-alexey.klimov@linaro.org>
 <20240201172224.574238-2-alexey.klimov@linaro.org>
 <CADrjBPpqHx1uoVZCYDX51kW+JdOr_-+4oryOjXcUMFkmLGTBLw@mail.gmail.com>
 <b199ba24-403b-44fa-b807-9b98f9e98913@linaro.org>
 <CADrjBPpNukp+YQ0AmsZAE1f=MEk_auPPZit=tV8gk4szQ8MqRg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPpNukp+YQ0AmsZAE1f=MEk_auPPZit=tV8gk4szQ8MqRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 15:11, Peter Griffin wrote:
> Hi Krzysztof,
> 
> Thanks for your feedback.
> 
> On Tue, 6 Feb 2024 at 10:10, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/02/2024 15:36, Peter Griffin wrote:
>>> Hi Alexey & Krysztof,
>>>
>>> On Thu, 1 Feb 2024 at 17:22, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>>>>
>>>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>>> index d838e3a7af6e..156fec2575bc 100644
>>>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>>> @@ -283,6 +283,11 @@ soc: soc@0 {
>>>>                 #size-cells = <1>;
>>>>                 ranges = <0x0 0x0 0x0 0x40000000>;
>>>>
>>>> +               chipid@10000000 {
>>>> +                       compatible = "google,gs101-chipid";
>>>> +                       reg = <0x10000000 0xd000>;
>>>> +               };
>>>> +
>>>
>>> I was wondering about the 0xd000 size here, as most upstream platforms
>>> use a chipid size of 0x100 or 0x24. I see the downstream gs101 kernel
>>> also uses 0xd000. Looking a bit more, that is because gs-chipid.c also
>>> has support for dumping other areas of the OTP SFR bank like asv table
>>> (offset 0x9000) hpm_asv (offset 0xa000) and hw_tune (0xc000).
>>>
>>> I checked Exynos850 and that also has ASV tables at those same offsets
>>> above, but it currently uses a chipid size of 0x100 upstream.
>>> Exynos-asv.c driver is part of exynos-chipid.c upstream so it seems
>>> reasonable to have the increased size including those SFR registers.
>>> Currently exynos-asv.c driver only supports Exynos5422 upstream.
>>>
>>> @Krzysztof - From a process PoV what is the best/correct thing to do
>>> here? Have the increased size in DT that includes ASV parts of the OTP
>>> bank from the get-go?
>>
>> ChipID so far had only size of 0x30 or something like that. What you
>> refer to does not look like old ChipID but full blown OTP, which also
>> includes ChipID.
> 
> OK so in some previous Exynos SoCs chipid had its own separate memory
> mapped SFRs as well as being present in the OTP area?

None of the Exynos I know, have OTP area. There was only chipid. It
seems that few newer designs come with OTP, in entirely separate address
space. Exynos850 looks like the first which comes with integrated chipid
into OTP, so OTP is not separate address.

> 
>>  Although I am not entirely sure about that, either.
>> Depends whether they share clocks, for example.
> 
> This address is the OTP area, and I can't see chipid regs mentioned
> anywhere else in the memory map other than OTP. Unfortunately there
> are lots of separate docs for different IP blocks, so it isn't just a
> case of searching a giant SoC TRM pdf.
> 
> e850 though looks to be the same (the address defined in DT is the otp
> area), that is one large PDF and the chipid regs aren't mentioned
> anywhere else, Given the chipid reg offset is the same (0x10000000)
> for exynosautov9.dtsi, exynosautov920.dtsi, exynos850.dtsi, exynos7885
> and exynos5433 I suspect this could be the same for all those SoCs as
> well.
> 
>>
>> I don't have any GS101 information so I don't know what's there. It
>> seems you ask me to give you decision based on guessing... If you have
>> one block, so if there is OTP, which contains ChipID, then define OTP.
> 
> I believe there is one block that contains ChipID, therefore based on
> the above info we should define full OTP size?
> 
>> Not ChipID+OTP.
>>
>> I think Exynos850 DTSI is wrong here. That's OTP block, not ChipID.
> 
> Yes agreed, and quite possibly the other Exynos SoCs as well.

If ChipID and OTP are in the same block (in OTP), then assume they both
might need the same clocks or some other resources. Therefore we should
not model them as two separate device nodes ChipID and OTP. Instead
there should be one device node with entire OTP address space, which
should not use ChipID compatible to avoid confusion.

Best regards,
Krzysztof


