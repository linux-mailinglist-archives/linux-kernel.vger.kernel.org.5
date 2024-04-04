Return-Path: <linux-kernel+bounces-130966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F23898142
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47AB1C215FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9248788;
	Thu,  4 Apr 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVRlZdYl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFB3E498
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211191; cv=none; b=NSTpctdqW7O9obZ0A6IPSU3qHdbyy0GQhKNozBndWnznDF5P5TxzQbzCrIio0vJazC5Vdoz5VUPO32nSvEHj62Nlst0bQEkq7tYRjr2lNEUOMbTYt/jJA7WtgiJ4x3/glrbTdxeIvkL7GwMcTxt2xk7NXKwL/u5p4wVBwV9bQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211191; c=relaxed/simple;
	bh=rHmTkYpIBqSyVHb4G2+ckKwMZTeB4ETzUbEMu6gP++g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QpDB+yUoIoHuvj4kdwrgb0OyHPkdegoqBOJK+O2Qb6x0cmNIK7oxBdUnjs/modMDbJdrEBR5dElQKsnu/ZbqSKIv/n1kRjxVVOidTco0HDo6vJz3lH5GunC4Y6ZSXPRx/OTDXIMw6bqKiFjKr4E9aNqPqVPpXL+erPo+vfAj2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVRlZdYl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51799456e9so86717266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712211187; x=1712815987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1DVSsv7THCi6XQHrrg2cA1+xOVbZs1gNs2CPHL9fNGE=;
        b=FVRlZdYlEx9Z8vMDy4r3fz0sJiCxmrjJyima7Y2xymT/IVh32N8yILsvnWnvvH80vk
         1Dx49B5sQkzbRWUow7wjQIYKf2LwsgczDNVqYW/eKtz3EgRzLlUvI7PtKKUI5XeQSZW7
         aNQcCjHahjN4XG7l+erzzq5L8YrGruAZV0/xaKYsGSvQfN+3R9F5eic4s5w9kGwpxf3n
         2DHp84/V8NSGaYR8Wk1DIHjbVSn6sGATHeFYmESjRNqAk2RexTIUnCvIoUCGLOdv8nHw
         RYor9tyivFUHe3i3Ik65IZQ9S9PMYGsWB+7jnbiAD/pMpP5aDvwCzjOZEvKgRoKsRBme
         +I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712211187; x=1712815987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DVSsv7THCi6XQHrrg2cA1+xOVbZs1gNs2CPHL9fNGE=;
        b=v53S4v3Ym4weMWE4qlte3fvMDQoGLT7EGnGcoFke3N0WL9iIL0JNvlkme1bjaVAJlS
         w3r85AtBCmf4weI/dWC2ROn/hYcaJYXgAdpNzv72xX/txm7ZVqDILWLqrtgKj4zfPY7I
         EPR83wqooFGNoYztgbxYpXUISzF1dnxisAZWQi2M5op5/tU/9TMWklSt9FrIH8SYK3m+
         S5WdVRo6SICr6HTR1D1QsUcfDeIlJ3TUnKDfdxDF1l9AmrspzVnEOz+vEmqv4sjl/FPF
         Ohvbmd6m+XcghiulGQLXFL3CtFXwGKW7VxkkEdaQg5OsphXl611XvwT9xQayc3JAVRf9
         UPig==
X-Forwarded-Encrypted: i=1; AJvYcCVnoHQhN3GTF1/TPOvBgeBuzTczBBsu8hejkdSBASpFZyMwlJ9UYWzoKJhD8qnsD0/MYE+B1dPvY2mzZhqTOqLR57M9iJY6g3OzuSFl
X-Gm-Message-State: AOJu0YyhE4SrpPGQZkNZ12sjUdxvUC0xoypgufBelCWDQwoh14hjh9+u
	TySSuqeOam/TeONnCcUsYQEslP3mQ64u8nhyNLFqudROQ1q3Y0eujOGiMWf0TnS071kjedDuY99
	H
X-Google-Smtp-Source: AGHT+IEnMWo3Ix2WIjHU21kRXOIGK/LiNiLJ3XFQIu2+0T7hCs0JKp5egQL4YfTWd2wmbONdZMLNbg==
X-Received: by 2002:a17:906:4ad5:b0:a4e:2532:ae9 with SMTP id u21-20020a1709064ad500b00a4e25320ae9mr1019030ejt.27.1712211187582;
        Wed, 03 Apr 2024 23:13:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906581000b00a4a3807929esm8554214ejq.119.2024.04.03.23.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 23:13:06 -0700 (PDT)
Message-ID: <c3902c6e-c38e-4604-b79e-2b5406274d8f@linaro.org>
Date: Thu, 4 Apr 2024 08:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
 <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
 <8610e0a8aa5c2916fa04292a10e8a843862ff0ee.camel@codeconstruct.com.au>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8610e0a8aa5c2916fa04292a10e8a843862ff0ee.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 03:41, Andrew Jeffery wrote:
> On Wed, 2024-04-03 at 12:04 +0200, Krzysztof Kozlowski wrote:
>> On Sat, 09 Dec 2023 11:44:09 +0100, Krzysztof Kozlowski wrote:
>>> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
>>>
>>>
>>
>> These wait for ~4 months and they were not picked up. Let me know if anyone
>> else wants to take these.
>>
>> Applied, thanks!
>>
>> [1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/7da85354c4fa35b862294dbbb450baeb405b5a92
>> [2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/e515719c17beb9625a90039f6c45fa36d58bdda2
>> [3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/af3deaf9bcb4571feb89a4050c7ad75de9aa8e1e
>> [4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
>>       https://git.kernel.org/krzk/linux-dt/c/cac1c1dda6130771e06ace030b1b0ed62096a912
>>
>> Best regards,
> 
> Ah, my apologies. Joel's on leave and I'm accumulating patches in a
> tree for him in the mean time. I've had some things going on
> professionally (changed jobs) and personally, and these fell into a bit
> of a hole.
> 
> I'm okay for these patches to be integrated through your tree, given
> you've already applied them. Feel free to add acks if your branch
> allows:
> 
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 
> I'm working to stay on top of things a bit more now than I have in the
> recent past, so hopefully I won't miss patches again in the future.

Stephen reported conflict, although trivial, but maybe better if you
take them? I can rebase and resend.

Best regards,
Krzysztof


