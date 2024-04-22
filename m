Return-Path: <linux-kernel+bounces-153075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0ED8AC8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA91C20CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E9454FB8;
	Mon, 22 Apr 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB7+TtK2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709B52F96;
	Mon, 22 Apr 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777561; cv=none; b=BG7AFpvL2GnPql6rXIXKl+5KOGPzZRl0rH3mefEE8jDoUJIIv7/zb6GYKjcT0/Ob2mDkKgxDXUQvTPK6Ta7Pi+hpPDZ2+GV3CJhqJMW2QjJoXOW6L4ldrcINrJcox/Qjpww6iK4/KxACteEJYpRWoVyRe2oGHH0QENWFTlNdBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777561; c=relaxed/simple;
	bh=0SzAzbO9mizr1+31aiP0iXs3Mw2nXgbrlKRbnEyHEV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rheRBvpvKkL5nSLZAbNkdlmGBhEJKbubAPd6jk973SZTYXdhzFvoEy84r6ilM/yG+CdJiqlbZitT9j8MzkK66NC5UV9x8b/3yj35aoZye/Zs+z3F4RGdWDJv/kaNS9JYs6HvEQXRyYltts+Pl8jRkAdkZ36wOFfB9dPQGVjnxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB7+TtK2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so3355823b3a.0;
        Mon, 22 Apr 2024 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713777560; x=1714382360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ep3MhmTtFiF+uEKgR3YsV/c0mK0RSR4QMExWC1N258=;
        b=BB7+TtK2f+1fzz655IBMEY4ZiVKijlzOuw1U/AG1taNme8BQQ8nqit8YPF3wT8zN+x
         Bcl6QaDiRy2UYCfwTP2ESJyFfR7M7H52KK0WOqlzarUZQ4xtL/S47dfPmV60iKc3ZVXW
         ycy2lvcGZ0747q00IoAsd59CUN3ZqkHTUPA6FmvFgpFfMgSae8LJt7JA3KgWkHZCOZXh
         soK2v5DwqPgj1Flc2xsKjJ8nm8UKRyqRCGYikPpzyWmL/uRLdcj8FPkw8Kfw3bRh5zxX
         zzJBrTvOXMtb1rXNAajhEvHEwschzndG2Gkfe/siHU/gtgfxvcYEPVp5JVw6Nc4cBk6Z
         swCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777560; x=1714382360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ep3MhmTtFiF+uEKgR3YsV/c0mK0RSR4QMExWC1N258=;
        b=pwe8D8OsAVutTDB1e5n7L4wmYnQQMFNJ7vj3zdnWrooak8V5Hl/1z/bsTFXLKlqlMJ
         XRcWLZQ5Q9tBs3UpDrViPvfgBvSrhdBFy1n8X+KF3FcDPMsjk9Jeqestogrk8ilnH6W7
         QfYqlYJXKyChQUExkhC7mYerEXaBFkMKlHq9X1E3pcXiE5cN1wonNJgsPn9U/gy+ngTV
         PoORWAtB9DnpaWMtrADXDP+lIDcCtOawRo/9mhvNzt6idBz1zbJiwmBiCvS67x2Xfvba
         6M6/8pI6v7jBVF54q8oQDM/rzMFsPrFf59M915beB2rJBRqaQKRxoN3rCGPAok+Uaklu
         y2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuCWQS/tYmXbXVR5hssVBMudQGy2ZO0VH4MHinKpq4aAxd4v93g4hv+dTQ9BX+8bSYpupj/QuK+gRDnASI3v8QzrCEMIS584arS+dJICbiWZBp0I/3H5mKR+eMw8ImMe7SwJKTF8LHaI1uKpfN/ICg/iAGqN6q6QGS+3YQTiwAqEMd1+c=
X-Gm-Message-State: AOJu0YymS7G+OD4b72Pc97UZIVBPOjYlMQ8G6oVS9CXA5D1ffddzhJ22
	Pa42sdGqWZ93CSbgdoR9own2jm0Fw3rI3uaLiHPea1/SaukyBXel
X-Google-Smtp-Source: AGHT+IEXrDILus4aNiNBVg1PEwpG5j2RHHDlxnvL7ic9sqQK7z3m47SHTbboBcgfTF53l9Ffs1/HzA==
X-Received: by 2002:a05:6a00:10c3:b0:6ed:2fb8:467b with SMTP id d3-20020a056a0010c300b006ed2fb8467bmr9424598pfu.26.1713777559764;
        Mon, 22 Apr 2024 02:19:19 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y8-20020aa78048000000b006f2e10b00d6sm1283814pfm.41.2024.04.22.02.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:19:19 -0700 (PDT)
Message-ID: <843c3c2a-2f46-4d49-aed4-ad07ebcb7b27@gmail.com>
Date: Mon, 22 Apr 2024 17:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240409095637.2135-1-ychuang570808@gmail.com>
 <20240409095637.2135-4-ychuang570808@gmail.com>
 <ZhZTsV3RKpuyeUr4@surfacebook.localdomain>
 <643a0d80-3d99-420e-9e77-acc67728fbe7@gmail.com>
 <CAHp75VfMb_=XKoQNbbVphLg-eQgc6eJbZOW36g_hU=-iK2bSOQ@mail.gmail.com>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <CAHp75VfMb_=XKoQNbbVphLg-eQgc6eJbZOW36g_hU=-iK2bSOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,


On 2024/4/22 下午 04:16, Andy Shevchenko wrote:
> On Mon, Apr 22, 2024 at 7:10 AM Jacky Huang <ychuang570808@gmail.com> wrote:
>> On 2024/4/10 下午 04:54, Andy Shevchenko wrote:
> ...
>
>>>> +#define MA35_GP_MODE_MASK_WIDTH              2
>>>> +
>>>> +#define MA35_GP_SLEWCTL_MASK_WIDTH   2
>>> I looked at the code how you use these... Oh, please switch to FIELD_GET() /
>>> FIELD_PREP() (don't forget to include bitfield.h)
>>>
>>> ...
>>>
>>> ...
>>>> +             regval &= ~GENMASK(setting->shift + MA35_MFP_BITS_PER_PORT - 1,
>>>> +                                setting->shift);
>>> This will generate an awful code. Use respective FIELD_*() macros.
>>>
>>> ...
>>>
>>>> +     regval &= ~GENMASK(gpio * MA35_GP_MODE_MASK_WIDTH - 1,
>>>> +                        gpio * MA35_GP_MODE_MASK_WIDTH);
>>>> +     regval |= mode << gpio * MA35_GP_MODE_MASK_WIDTH;
>>> Ditto.
>>>
>>> ...
>>>
>>>> +     regval &= GENMASK(gpio * MA35_GP_MODE_MASK_WIDTH - 1,
>>>> +                       gpio * MA35_GP_MODE_MASK_WIDTH);
>>>> +
>>>> +     return regval >> gpio * MA35_GP_MODE_MASK_WIDTH;
>>> Ditto.
> ...
>
>> Allow me to remove irrelevant parts.
>>
>> I attempted to follow your advice and use FIELD_GET() and FIELD_PREP(),
>> but found
>> it impractical. The reason is that these two macros require their 'mask'
>> argument
>> to be a constant, otherwise compilation errors occur, which is the issue
>> I encountered.
>> Since the mask here is calculated and not a constant, compilation errors
>> occur.
>>
>> Taking MA35_GP_REG_MODE as an example, within 32 bits, every 2 bits
>> represent
>> the mode of a GPIO pin, and the mask is obtained by GENMASK(gpio * 2 -1,
>> gpio * 2),
> This is not good for the compiler, it can't figure out (at least in
> some _supported_ by Linux kernel versions on some architectures) that
> GENMASK can be constant here just left-shifted by arbitrary bits.
>
>> where the 'gpio' argument is a variable, not a constant, leading to
>> compilation
>> errors.
>>
>> Due to this reason, I will leave this part unchanged, or do you have any
>> other suggestions?
> If you need non-constant field_get()/field_prep(), add a new patch
> that moves them from drivers/iio/temperature/mlx90614.c (and there are
> more custom implementations:
> https://elixir.bootlin.com/linux/latest/A/ident/field_get) to the
> bitfield.h and use them in your code.
>

Thank you. It works for me. I will adopt the approach used in mlx90614.c.


Best Regards,
Jacky Huang


