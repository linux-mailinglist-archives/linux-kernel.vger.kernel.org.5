Return-Path: <linux-kernel+bounces-28253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6B82FC25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9F1C2785D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0623744;
	Tue, 16 Jan 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBhgCnPJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5D22F1E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437188; cv=none; b=jEd+SSapuD0IH6zI1UniJCbKVFpQFEeV2yW4lzpaXEWSdhmrI5Y8WnF4ioZQnYcQWOqFAWoaDUv5ao3wgzrVF9UFX00Lll3j62wEt+kgF6cR/zicWh/RlNZGo/Of6Yb5OI67WEMxj/i7lmib2ocT8K5tnSMG5lBU9pwBxTS1nnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437188; c=relaxed/simple;
	bh=UZhOUcuw6c3yvY8HwUWiMiTNnqgekRGrbmejXm0Luak=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=N8pxhellDEMnLZJqGbZNArgn6Pfvw7NPuz8pOV3QXjRPjqxokKduys516Uw8OK5EXFivn5k5Y3w6idRI2W9NWW2jaMQw4MS4tnqNsd868o95+CSdN+pbIYfnMVvDJuQXyZTFyQZ5ivPO+ENFEqMac/dHj2dfN0M41qLUkaxROd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBhgCnPJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd8b64a52dso60257591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705437184; x=1706041984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkUyeDtILM4j0A8ZkydaXWgJFrv0AfuF4OsKct4FSs=;
        b=WBhgCnPJxome+VxxYB1BXZW3+/f8DyekeyrBYo3SHwkYEcHLMNnFPz6StNq9ZDmS6s
         rRcmNGERGsAWNjvBdxJxZ6JW7UsT4TDknAQYfy5ZNe3pPHOn4kTe7WrlQzn40e4fMl5i
         X69AMW4JZb4YGmLJ0k+/g22L3PFVxGPhsRBCY/NNPgQ3018cvgWgdA5p+WMTUANASUJm
         WIctiBotC3WXi7dyU+iYzkE1kwazGlIZ3DJdtAanMheNP46F5wr/wOmy/bCKdniMyfnu
         DFmFqZDyK8h+pdidaxA8o43mgOFqWNLGCzO/GC1AHvBjFZeGCfKi8fs4m3FWtlezUxTy
         /cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437184; x=1706041984;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkUyeDtILM4j0A8ZkydaXWgJFrv0AfuF4OsKct4FSs=;
        b=sNsPk7H60ehCMWKunLmjPSdSYr6XviU4wbELtVubDr4ob9367ADYEPaddDiVRv8VKJ
         k9wXM1ClGYOpjSpgdDE4J53GOVYcP1iDPmzusUy97DPkZWXzW60tpF4CHbYCOH2wRM1n
         Y8Lpot7PHxVeFnzMtxaJNVkXdyW+SRchYw6indIKwyprktUHzcF9aROogfiSYLg4Pdp3
         BIauxhvHNGB4hifcJVLTm4rsKQADAjYfBtSAzkrDOmpGBKKXzWVWK8WMIH754HhhCAxO
         3tdggz4aquq3k9l5czqOiDAbMOALaFeoYuPSuw2cEwyka4pOfrY+7mJxgXrzAI9AJ38u
         ubRQ==
X-Gm-Message-State: AOJu0YyS6HKwBaNFyNMdbd7GEczrMHLBYAgtGHaYnyO9Wln+/Ky39owN
	j+qgultnwDKtB/tIFszvLWV86YuwxvpLSA==
X-Google-Smtp-Source: AGHT+IHty6zoQlN4MzUQdFwDQqOaZ5jVeEehJLQl61Fuew+N/AVC7g0NQu7WEcIq2Nlaz4zp5JQNBw==
X-Received: by 2002:a2e:3208:0:b0:2cc:d4d9:905 with SMTP id y8-20020a2e3208000000b002ccd4d90905mr3424013ljy.11.1705437184624;
        Tue, 16 Jan 2024 12:33:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ig12-20020a056402458c00b00559c3cbba3bsm469440edb.37.2024.01.16.12.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:33:04 -0800 (PST)
Message-ID: <52697bd3-01a6-4522-a0fc-e9e6f027cff2@linaro.org>
Date: Tue, 16 Jan 2024 21:33:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 3/8] arm: dts: nuvoton: npcm7xx: modify rst syscon
 node
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-4-tmaimon77@gmail.com>
 <99eca166-7d78-4ada-ac0a-ad67f3d8eb33@linaro.org>
 <CAP6Zq1g7NoLVbAUyeQ8jm3qZvjLV6HSVZB+r-X7dxvVNtvddPg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1g7NoLVbAUyeQ8jm3qZvjLV6HSVZB+r-X7dxvVNtvddPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 20:51, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comment.
> 
> On Wed, 10 Jan 2024 at 23:01, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/01/2024 14:54, Tomer Maimon wrote:
>>> rst node name and compatible property modified since clock and reset are
>>> handled in the same memory region.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
>>> index 868454ae6bde..f72c5a03d04c 100644
>>> --- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
>>> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
>>> @@ -93,8 +93,8 @@ gcr: gcr@800000 {
>>>                       reg = <0x800000 0x1000>;
>>>               };
>>>
>>> -             rst: rst@801000 {
>>> -                     compatible = "nuvoton,npcm750-rst", "syscon", "simple-mfd";
>>> +             clk_rst: syscon@801000 {
>>> +                     compatible = "nuvoton,npcm750-clk-rst", "syscon", "simple-mfd";
>>
>> NAK. This breakes the users, is not justified, is not explained.
> Sorry, I didn't understand, which user it is breaking? there isn't a
> device tree node that uses the rst node.

Any user of this DTS.

> Should I explain it better in the commit message?

I doubt that you can find proper reason, because "I want different name"
is not valid. It's just compatible, it cannot be changed just because
you add new property.

Best regards,
Krzysztof


