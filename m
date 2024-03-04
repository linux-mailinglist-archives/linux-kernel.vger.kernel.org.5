Return-Path: <linux-kernel+bounces-90429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9164E86FF03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B7A28390A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF722F0C;
	Mon,  4 Mar 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDYGfaRH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68820B33
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548044; cv=none; b=Fi+GST7j8NpORyFlg6SvEjlW5aHkWkvo/ft56osnAwyrQX/oCQKDnHjTiXqRZbt0Hm533MTHcAEtGw013crKzujRLxZB4xLsn4F+qo+77MRgcNI1SjlJ5kob4qI+eWfBW9uoGkiAz44WBFfo//sVGYaCH8Wz/qFwH6BLqnJh4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548044; c=relaxed/simple;
	bh=1C1H96qOM9mwECPmaDtXMse5qweT0bacBYxCqfYJU6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piCXBDdywW8wafvpHvzg/yGbgQIcXIAB9EVkhXAJBixBTBqxYFRpO1sRjLWhAlhdqsC3aVdNqOrhFG1Mym4I+A9pLExYTLJ3lxDLaDKhhsknsoR7f1zQASMIzhrnTfuFvlMN08IrV+qKq8OcGkyOpCyay/L7l7dTGtDG6JONBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDYGfaRH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d146737e6so3187435f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709548041; x=1710152841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VRHksjEJRgpRJ54Kzj9MQUEll21nALPKdN0xNfWjwo=;
        b=DDYGfaRHGGF8lz6HhCO1eEefoUmO6LYB5IqHHUlkonYcH+mNZSRqfxlRfmqTPpmVVk
         L/zONmoaZ/xh3WESzq4d+qTpLutYj7XTAkvo9BOB2YgV36sWgpfp5SSWrNSHmH3/CTaG
         64d3kvnnLpTvzlLjIANXWluYgC1gMIZdfGzOYn3UOQBzv2XQXhX+N2ByCYqPxQViOWaJ
         CUfPuoprYQ5H2aA6P8tZ06Ub6WJ7GqlAWAJ7XRdOqRK97PypU99M6YooNIhFlEoP0f3B
         lSGADDtZctkKC80ShNnXWG4lVHp3Be1sQ5d3IILuLiBlLxysE0dSXVKUCgLM7t10sWqG
         Qk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548041; x=1710152841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VRHksjEJRgpRJ54Kzj9MQUEll21nALPKdN0xNfWjwo=;
        b=VrTWQTAbNJQa2Uo1rkCvHg+5NjJ5yOg01xfPKPAChdFKXiRc7RzWkwGbUfAoulRt8L
         SJ6IVyYsOK8eka9Mk8KjW6Z+OzNvbfeBdhCQbq7YzUBZJoJNEHLvc2lcCMztpbyj3f/B
         UItjLQ/hKePFI4yUAU8OYh/avD4QECVaqzH7qYVnqQc2TR3k9WkEHQI/9vvEd0jMjgQF
         dpXJr+pAsskVyHTSbgDUQ1NhdCJnVWJcVNxWTatMeUr6/whMxc8oOo/eoF3PIk+ZZ6Hh
         r8vw97SbUvfKlo0PS6y11XfZlE33HflTV4y4Aesqi+wpNY4wp7of2gs4ZqvDe1u/gwdT
         tLDA==
X-Forwarded-Encrypted: i=1; AJvYcCUK4wRyxhoVp6OJ8Nraog0yGXEKDXDx1DEvfIwbVu4YZ634Xmx2U90BeT75tunnlHnPMdbZUCNuAyJVu+AIkfvG4OE0pcoYNlNe2HEe
X-Gm-Message-State: AOJu0YyGCXuCDTc+aM0gYVA40P++Oox4D9L/l1H3MyGEKYeFVtvNT0bm
	IfyctMedRILKYJwGQmH5/D4D4B2/bb6M5qHqlkcdZ3iFbaMEwgyFo3l18KMjvjs=
X-Google-Smtp-Source: AGHT+IHt7Zd2k+hFzTOidzoi79RLJvkZffvdWquLn5rABypzFsoKwHuVYvLNqORqWKY3MslGeNS9DA==
X-Received: by 2002:a5d:6646:0:b0:33d:bb9e:9713 with SMTP id f6-20020a5d6646000000b0033dbb9e9713mr6464401wrw.44.1709548041438;
        Mon, 04 Mar 2024 02:27:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l15-20020adfa38f000000b0033e03d37685sm11865548wrb.55.2024.03.04.02.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:27:20 -0800 (PST)
Message-ID: <5cec7a58-a14f-45d7-bd61-45baaa31a94d@linaro.org>
Date: Mon, 4 Mar 2024 11:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: add Canaan K230 boards compatible
 strings
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_D5188EA5B85A31AC21588DBD7C7482ACDA08@qq.com>
 <7c3c578a-d662-4485-ad15-47250ad0e935@linaro.org>
 <tencent_BF607C338244DA7F8EB2B8F2314A218B8D08@qq.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <tencent_BF607C338244DA7F8EB2B8F2314A218B8D08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 09:51, Yangyu Chen wrote:
> On 2024/3/4 16:11, Krzysztof Kozlowski wrote:
>> On 03/03/2024 14:26, Yangyu Chen wrote:
>>> Since K230 was released, K210 is no longer the only SoC in the Kendryte
>>> series, so remove the K210 string from the description. Also, add two
>>> boards based on k230 to compatible strings to allow them to be used in the
>>> dt.
>>>
>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>> ---
>>>   Documentation/devicetree/bindings/riscv/canaan.yaml | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
>>> index 41fd11f70a49..444758db964e 100644
>>> --- a/Documentation/devicetree/bindings/riscv/canaan.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
>>> @@ -10,7 +10,7 @@ maintainers:
>>>     - Damien Le Moal <dlemoal@kernel.org>
>>>   
>>>   description:
>>> -  Canaan Kendryte K210 SoC-based boards
>>> +  Canaan Kendryte SoC-based boards
>>>   
>>>   properties:
>>>     $nodename:
>>> @@ -42,6 +42,17 @@ properties:
>>>         - items:
>>>             - const: canaan,kendryte-k210
>>>   
>>> +      - items:
>>> +          - const: canaan,k230-usip-lp3-evb
>>> +          - const: canaan,kendryte-k230
>>> +
>>> +      - items:
>>> +          - const: canaan,canmv-k230
>>
>> Why this is not part of previous entry in an enum?
>>
>>> +          - const: canaan,kendryte-k230
>>> +
>>> +      - items:
>>> +          - const: canaan,kendryte-k230
>>
>> Usually you cannot run SoCs alone. What does it represent (in real life)?
>>
> 
> I'm not sure what it means.
> 
> If you wonder why should I add a compatible string for soc, that is 
> although we cannot run SoCs alone, adding a soc compatible will allow 
> some bootloaders or SBI on RISC-V to choose an errata for a soc. Such as 
> this opensbi patch. [1]

No, this piece of code will not allow this. They choose errata
regardless of this change.

> 
> If you wonder why I should allow a soc-compatible string with soc alone, 
> that is because k210 did it previously. And provide a k210_generic.dts 

I don't remember background behind k210_generic. Any SoC-compatible
alone is exception, so needs serious justification. Drop it or provide
proper rationale.

> to use it. I haven't provided generic dts now but allowing only 
> soc-compatible string alone would also be acceptable I think.

No, it is not. Stop making own rules.


Best regards,
Krzysztof


