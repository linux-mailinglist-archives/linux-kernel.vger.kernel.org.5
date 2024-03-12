Return-Path: <linux-kernel+bounces-100154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE88792AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCABF1C2294E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522D79B67;
	Tue, 12 Mar 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZN0sQzB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945F76997E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241459; cv=none; b=qwmna6RfWPQlQ1IBZUdt5n8WM7oPtIHrl+iWYtXu1b9mPXb64qRRPrTkpS45rJj0eaGYd48nUV2Thh0w7o2e3mV7YoBNgtRiUrAdIDlgDwGF+6+BDgDuyFmrQkFECLTBaQHpWbBcBP1F47xnPXkI0tiCUrtDPkuWyt4pbaDzdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241459; c=relaxed/simple;
	bh=pLHlfjqZrAjvbkvSlj5qpzs5K5Lppb9UXKcsKcDGhoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxtBaUiLVR3j4LaxOY6iwQTg5hAgYQ359XjJpppijZAA5LHG43AgR+fUUmo4XL+6/XJT0pDR2dX4pNozEqvBfKWn7IJXMg4SjUhgawZyICzjqCJP/gJvFmv3PP6NyHuIJP7a3VuwSqQv4GdEKSyvXZmspQ86r1HSG23waQlxWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TZN0sQzB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413318a3a29so5494665e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710241456; x=1710846256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEGWOujdW89Dpl1fCi0Jc9+UKMnXm1pN5XkS4ijg4qg=;
        b=TZN0sQzBzoFtj3Q4i/XgBUUlWAGyVoDUaqycZIzX4kv6JPyC1bZ0UhzI9PEXEA77It
         c/SkKaZdNiSzBKZX8thAj/GQECp8+Ycn0+hSnxRESibR/xTg1uIq5itxKXPAeGteQx4x
         f5OB+dzQmhoiKcqPgna4NXceVEgdNbwiiqFL9kPlfbS16f8/ksBOrYVpSzB53DljQ7wK
         lpdJqHaUx5nSDEvn/xCHqJ3flacyKMBEzc8g70QPF31QY+DT37VCiSdyUpokCW1joYdT
         cv5r8NueiSfYDjABCmHEhfLGC+EFjKqEeajmtTSf+b/g3MgQ8+1kJm4yAqxeJkJfMuGm
         LX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710241456; x=1710846256;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEGWOujdW89Dpl1fCi0Jc9+UKMnXm1pN5XkS4ijg4qg=;
        b=L1ZsyPF/fCI3Qq34XgrB92gMdHIe5hcazaTcePrB30OM0+xI6zEjpILMNoelWeSxel
         dfgPR1QQowHyYYupa3ZpYDSSxNg9uj8ZbXYaIKkJa2W9ItDkvlCjhs7hhmlRTuLSG4oT
         7ePDdU6bmA3ks0Fesjpfz6Vf6M2tZFu5F5HutnU4f+hvxu8fJG6QQ9asnPwPwDsb4W8q
         JQjE0QvqnXSwUkBuIwiIswWl9qoJIjb4W3GKW8e4IOTgoVwgQrJSrdzQFEVJDlpN3d9W
         +uK4FzjvUk+0vCYyQNrhP7b2jdoTgvxbEWw/qtD9+lFrAWdwCppqXINiVQ7Pco7HTnrA
         uFpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5BTxA9Y4k7NsltidiRHiPgHEncEPYc19X+mqU0lBzfkZx57m11pAVs92A7Hmm4P3Yit9kMSWnmOI//pMkmh27ELTflIRwDsRLL5QJ
X-Gm-Message-State: AOJu0YyOPwm3+fM5C/qPt4svDNKsDNLBWTIUnxtlMpQ9hqZqY5aMpvr5
	AUTdTzz5pKqFp/m5YOkh866bzS6AckYxNkZd/IOlJZ/k6xyrSatIwttbAW9YAbY=
X-Google-Smtp-Source: AGHT+IE/CWZrrlfUgpOEFHEzDDracpQOTZTNmW40XGuZXUWwarlCf4ysh4GTtSMO6ky8704ESTBV4g==
X-Received: by 2002:a05:600c:4f51:b0:413:2489:d194 with SMTP id m17-20020a05600c4f5100b004132489d194mr5032001wmq.27.1710241455939;
        Tue, 12 Mar 2024 04:04:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b004130c1dc29csm12089953wmq.22.2024.03.12.04.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 04:04:15 -0700 (PDT)
Message-ID: <b04f9c39-9797-40b8-a25b-8154ad559cd5@linaro.org>
Date: Tue, 12 Mar 2024 12:04:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: i2c: renesas,riic: Document R9A09G057
 support
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Chris Brandt <chris.brandt@renesas.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240308172726.225357-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240308172726.225357-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <7082ed3b-d6d0-4228-b7a6-7c0e0e46b8e2@linaro.org>
 <CA+V-a8tM29h10DULurMJtBZBnLK_ZF7pH_Y0bhZTvWO0O7-G-Q@mail.gmail.com>
 <2974085a-d9b4-4a66-b60f-c02a06a74647@linaro.org>
 <CAMuHMdVgp_vFnWr5ruzdyc1vNQKoCdM=pLZmgmkDjmUHvQBJJw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdVgp_vFnWr5ruzdyc1vNQKoCdM=pLZmgmkDjmUHvQBJJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 10:00, Geert Uytterhoeven wrote:
>>>>> -          - renesas,riic-r9a07g054  # RZ/V2L
>>>>> -      - const: renesas,riic-rz      # generic RIIC compatible
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - renesas,riic-r7s72100   # RZ/A1H
>>>>> +              - renesas,riic-r7s9210    # RZ/A2M
>>>>> +              - renesas,riic-r9a07g043  # RZ/G2UL and RZ/Five
>>>>> +              - renesas,riic-r9a07g044  # RZ/G2{L,LC}
>>>>> +              - renesas,riic-r9a07g054  # RZ/V2L
>>>>> +          - const: renesas,riic-rz      # generic RIIC compatible
>>>>> +
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - renesas,riic-r9a09g057  # RZ/V2H(P)
>>>>
>>>> No, that does not look right. If you added generic compatible for all
>>>> RIIC then how can you add a new RIIC compatible which does not follow
>>>> generic one?
>>>>
>>> The generic compatible above which was added previously was for the
>>> RZ/(A) SoCs and not for all the RIICs. The RZ/G2L family was also
>>
>> No, it said: "generic RIIC compatible". It did not say "RIIC RZ/A". It
>> said RIIC RZ
> 
> At the time the original bindings were written, only RZ/A1, RZ/T1,
> and RZ/N1 existed, and all RIIC modules present in these SoCs were
> identical.  Later, we got RZ/A2, which also included a compatible
> RIIC block.
> 
> Somewhere along the timeline, the marketing department became creative,
> and we got RZ/G1 (RZ/G1[HMNEC]) and RZ/G2 (RZ/G2[HMNE]), which were
> unrelated to earlier RZ series :-(  When marketing started smoking
> something different, we got RZ/G2L, which is unrelated to RZ/G2,
> but reuses some parts from RZ/A.  Recently, we got RZ/G3S, which is
> similar to RZ/G2L...

That's fine, but then the comment "generic RIIC compatible" is confusing
for anyone not knowing this. Commit msg could also mention why the
generic compatible covers actually entirely different hardware. The
commit msg so far focused on the differences between these hardwares,
thus my questions - why do you create generic compatibles which are not
generic?

> 
>>> compatible hence they fallback to the generic RZ one.
>>
>> riic-r9a09g057 is also RIIC RZ, isn't it?
> 
> Yes, as in "it comes from the division that calls its products
> RZ/something". But...
> 
>>>> This shows the ridiculousness of these generic compatibles. They are
>>>> generic till you figure out the truth: oh crap, it's not generic.
>>>>
>>> Sorry I lack skills to predict the future of upcoming IP blocks which
>>> fit in the SoC.
>>
>> So don't use generic compatibles as fallbacks. That's the point.
> 
> It's indeed difficult to predict the future. So SoC-specific compatible
> values are safer.
> At the same time, we want to avoid having to add compatible values for
> each and every SoC to each driver, so we try to group SoCs per family.
> For R-Car that worked out reasonably well, however, for RZ...

I did not propose that. Nothing changes in your driver with my proposal.
Use SoC-compatibles only: for fallbacks and for specific(frontbacks?) parts.

To give you some sort of guidance for any future submission:
1. Use SoC-like fallback compatible, prepended with SoC-specific compatible.
2. If you insist on generic fallback compatible, its usage should be
limited to the cases where you can guarantee for 99.9% that future
devices will be compatible with this. I doubt anyone can guarantee that,
thus we keep repeating on mailing lists the same: go to point (1).

Best regards,
Krzysztof


