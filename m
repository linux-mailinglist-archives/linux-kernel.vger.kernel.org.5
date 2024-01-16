Return-Path: <linux-kernel+bounces-28257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B4482FC32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0B28F0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB11E522;
	Tue, 16 Jan 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkMJ+vKL"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55567249EA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437633; cv=none; b=cerE0VEjg4dwnFRNnjXcTh8hdMgO+02pUACEMZfcW6Tb8rrYHl2h9BhJnu1iQuEclJCrDAV2tuuVeE1ZPF3VuDkSbh7nr2b++4+/WHAI1pH3JhlEVOppiHYbN15fMc8lt2VzKu1CEPpsiBpdlXnt4bvJfnsRsq36cqi3kphW3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437633; c=relaxed/simple;
	bh=MSHlYLWRQl+mWZwNFYzinNuD3LkGBF1lxEXmti4jhvM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=FE/FYhHCkJIWnB+/tKFVUxlU3p0JJ2rmAG00Q+CSyv2BoGAAcJy0bU+qMc/Il8GRwmO4teKZ5XBFTc8u74nGnPJIdqWFFPpPycF1G8g+Xpb6R0uqXGQMdrL4nX9m19D97MU05FIiLlNF7AfMairAZE562oG3hTepRNcIXiro/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkMJ+vKL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559c1396ecfso651009a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705437629; x=1706042429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caSMH0DTCcoqPExT0LFbM7z63Ghju0LAG8/JNTpJTAA=;
        b=mkMJ+vKLz6pTZZ8/UKdaead0fV9iS8BQrz0E8vMsMzMUHwQYm93tXKt5pP6m1Nm/Oh
         e7D/kCuHfHFBOR6surwAD9tevxhvNaBrMfOl/FAzsJk53qYfMjq5wUQMwl6yQc9G4ZQt
         JpiqhLhPaN31uSoGeOBK7SR3dDbfPBWlpY+efZ2ereYfQEdn0rtP1SVQ4EJyR6bL8gRo
         D6xqAFX0BR7V6LqjkLQ8ABetYRgSyyFiGQg+0TdtrR+rd556Vl+GDzcPiWV0OywnlDot
         vkvUD8kMgrmCWvqsP/YrY/2fcvvXNK9gMDzejMrWKjfTUgEWz1wP/ssKq13wAPwjkS5e
         d1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437629; x=1706042429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caSMH0DTCcoqPExT0LFbM7z63Ghju0LAG8/JNTpJTAA=;
        b=Yw1PfhzhjZjhbITefxKuJ66wEJopv9/c1gHVellIW28WeQ/5NPScfWUTBnexoRU9r/
         eFOFuL+O2xZE6xUn1su0JHZopOdPMQw3C0dahfzA45vefS6kJ7IpR35GHm42GvjFWAjI
         cAroOfHhtF9RsEKRaXyMSkMShX7krKnInGPMQIpznWin7uHv23xjK8ZnaFaGjDKKhYMr
         2YB1/cIXwwaK6dvcf21fVkaSWUmtEfscpxMUXOzYLZIPiyhyWD52sgFMnJ9ExESGOQ23
         LhA1bmbyKRtnC06fC0/bZNWwFn5vvjkd2UgHvLW+MUzTvjsQ4bp+23ZK6NBpHi+2lRhK
         VXVw==
X-Gm-Message-State: AOJu0Yy+DElnkPuIwOSHGr3G4Co6IntcTu0egDdLdW+dK0ghuMS3x/aL
	PyUcCZmxCeiEHx5MB6/t3Bu8WUf5cXQRLQ==
X-Google-Smtp-Source: AGHT+IGi66AmHHHWyBZcPZuNMb9hyzMjZzzdjuiLqd/BOyAnOLueo+5aC285ckk/RshztmJjmIc35A==
X-Received: by 2002:a17:907:910e:b0:a2a:23b6:fb2a with SMTP id p14-20020a170907910e00b00a2a23b6fb2amr2769888ejq.106.1705437628921;
        Tue, 16 Jan 2024 12:40:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ot8-20020a170906ccc800b00a28a8a7de10sm6904562ejb.159.2024.01.16.12.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:40:28 -0800 (PST)
Message-ID: <018fc173-edf3-4490-8f29-4059bd17268e@linaro.org>
Date: Tue, 16 Jan 2024 21:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 6/8] dt-bindings: clock: npcm845: replace reg with
 syscon property
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-7-tmaimon77@gmail.com>
 <171300da-3d49-4e1f-8969-9a454ecdd698@linaro.org>
 <CAP6Zq1hifi7CY=tYaDY_o82AXhbS5P9=MZBb-bqmvNCLZk3O2g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1hifi7CY=tYaDY_o82AXhbS5P9=MZBb-bqmvNCLZk3O2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 20:37, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> As explained in my [PATCH v22 4/8] dt-bindings: soc: nuvoton: add
> binding for clock and reset registers mail.
> 
> In the NPCM8XX SoC, the reset and the clock register modules are
> scrambled in the same memory register region.
> The NPCM8XX Clock driver is still in the upstream process (for a long
> time) but the NPCM8XX reset driver is already upstreamed.

First of all, the drivers itself don't matter here, we talk about
bindings. I assume though they were going together, so that's why you
mentioned driver... but just to clarify: we talk here only about drivers.

If reset bindings were accepted, then why they aren't referenced?

If clock bindings were not accepted, then what is this patch and this
file about?

> 
> On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/01/2024 14:54, Tomer Maimon wrote:
>>> Replace reg with syscon property since the clock registers handle the
>>> reset registers as well.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 22 +++++++++----------
>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>> index 0b642bfce292..c6bf05c163b4 100644
>>> --- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>>> @@ -18,8 +18,9 @@ properties:
>>>      enum:
>>>        - nuvoton,npcm845-clk
>>>
>>> -  reg:
>>> -    maxItems: 1
>>> +  nuvoton,sysclk:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: phandle to access clock registers.
>>
>> NAK. Not explained, not justified, not reasonable, breaking ABI.
> Should I explain more in the commit message or/and the nuvoton,sysclk property?

Let's try to explain here first. I really do not understand why do you
change this binding. Your device did not change, so your binding should
not. Now, if you say "but I changed drivers", then it does not matter.
Bindings do not change because you did something in the drivers, in
general. At least they should not.

Best regards,
Krzysztof


