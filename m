Return-Path: <linux-kernel+bounces-132435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A99528994E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A041F237AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9022619;
	Fri,  5 Apr 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtnvZWkT"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AD224EF;
	Fri,  5 Apr 2024 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712296890; cv=none; b=gv5z2yGQr0qxb6LyN6yjWYO/iffb5kkwOZ0cx2P0Fku8SJ8z1krTLVn+1OgIWJ/cLZ1cjsgETC1qTexL30bfX4C5j6nKofCRMXFHNODYECK4lkaE7AH8Mco2mAFKt/LERVAfOe3615fkK7lm94D9LZ5bTviDp4GPAiguYStVrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712296890; c=relaxed/simple;
	bh=AEz91L3w4/BpWSBDQDJsIDJt7JVxo4Ob0QsD7kPva/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNolyCzkqbLeF6XVyE9lRe87Ktvzyyt3U1sv1FE9t0zYitnlaIZEbPY+J8YZ7YVJd4aak5QHRvm/0H0HktBL7J+uEcIJtwVHK8d65jIkgiaREiSOQ6jHCEOJsDvF2sGpR0UTX+wgyRR34o+gBts0itBcNMXKe34i/n+0fDla8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtnvZWkT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51381021af1so2822445e87.0;
        Thu, 04 Apr 2024 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712296887; x=1712901687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUbJzYH8/GjAOeHJC0H+nvPY2BdnYIwFHY5/SfgrKT8=;
        b=QtnvZWkT6szqnvXIvCNPttGikK+lmsfM/VNDu6Svbvwn8b2jTDZghhZ04kp1//L79e
         r+iw8v5daWvGE7KKNnhrGw/AhBjVEzY26UZsTRubtpb2KD+WWlzo1ozBvDMLXE32UUMZ
         3v+A044Ca/cFk7/OyLO2VB7CxfyW3UPci5Qb+mxgpymnjleJfm1D/Y4y559LI8gLIHnk
         weTXr9ugsAxNSTAZ++wjKpaaG4k0JMP9t0focPGCtd7/SHoUsTknHQ4bIor7IGDIo8HC
         LRxezdNF9ahwz7vnlecM3Rp4spH501qpDF9FL1NhR6xCVG0Ywt80Y+Gdgs6PrNz63rqI
         YytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712296887; x=1712901687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUbJzYH8/GjAOeHJC0H+nvPY2BdnYIwFHY5/SfgrKT8=;
        b=rVRpPvys2jR3Cl+eaGZ1BS/NotwTGxPZ0S6o1IkKRLEbisVEoI8fkpRnMlrBfd8otr
         Rh4FgY6tdz7oNFbjyj+2j+YsO6DDyWcsvS5jK9uZH7Zpw5eYHiEHOEiAaKjZTrfayz+R
         xKHEMTKIZ/w9XyGKU+PE74vCQiqJdMrbkla22EIJRaxobUB4rquUi3xgXol/aqOXIrYj
         T7doJDV5yswva0ThpLJ81N4OYuFXeIqFNq+HjNXWa6Fk0APQsO9vQgWxgBnFXvnczIoZ
         RU7r8KcqTWbTDmV8LR4gSaj63WCHVjBy4dgNk1Xq3hU/WHlPRt6wdaWeZcGjJam88VvO
         vT1g==
X-Forwarded-Encrypted: i=1; AJvYcCVOBadzZwMevCyXfRDROAIRzBcDkFBtS1Z1wePvdp1GvP52AsQRlBuNRLEhYfXv5MWaIgAgIF9qyL5bOrVafvzBFQSShUKMYcCWDM7NSPJQwYYQ1dzgxmCXDbaHKlBLWPgHvxEyutmPUg==
X-Gm-Message-State: AOJu0YwhoNafNcfyfvXOu6wDj3vmSlkH+1mJGHuNwaetgHBqNYf4JDq4
	poQM+9i51uCAGDJyHdIm/mXoD1izGiqizI/XEQmchDIdadp/rl1+
X-Google-Smtp-Source: AGHT+IHKLgYZfyGzkcUB0B7vve2jsQjKlZ7oe4oYMeYQQGuhr4OytF9qE9DF5KJ5fuPHpjPeoa9l5g==
X-Received: by 2002:a19:641c:0:b0:516:c44a:657d with SMTP id y28-20020a19641c000000b00516c44a657dmr370940lfb.64.1712296886429;
        Thu, 04 Apr 2024 23:01:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::6? (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id f23-20020ac251b7000000b00513e24c304fsm99344lfk.193.2024.04.04.23.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:01:26 -0700 (PDT)
Message-ID: <0295c8db-b01e-45e7-b44e-79d36d81cd48@gmail.com>
Date: Fri, 5 Apr 2024 09:01:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-2-andreas@kemnade.info>
 <6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
 <20240404123010.69454fda@aktux>
 <8f37211a-57ed-48ab-8de8-cd5a0d4c6609@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <8f37211a-57ed-48ab-8de8-cd5a0d4c6609@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 15:04, Krzysztof Kozlowski wrote:
> On 04/04/2024 12:30, Andreas Kemnade wrote:
>> On Thu, 4 Apr 2024 08:59:54 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> On 02/04/2024 21:35, Andreas Kemnade wrote:
>>>> As this chip was seen in several devices in the wild, add it.
>>>>
>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>> index 0b62f854bf6b..e4df09e8961c 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>> @@ -17,7 +17,9 @@ description: |
>>>>   
>>>>   properties:
>>>>     compatible:
>>>> -    const: rohm,bd71828
>>>> +    enum:
>>>> +      - rohm,bd71828
>>>> +      - rohm,bd71879
>>>
>>> In your second commit you claim they are compatible, so why they are not
>>> marked as such?
>>>
>> so you mean allowing
>>
>> compatible = "rohm,bd71828"
>> and
>> compatible = "rohm,bd71879", "rohm,bd71828"


This makes me slightly nervous. It wouldn't be the first time when I've 
been told "they are similar", and later the reality has turned out to be 
"they are similar, except...". Furthermore, even if these devices seem 
similar to software (which is what the comment in the MFD driver is 
referring to), it does not mean these devices are 100% electrically 
compatible so that they could be used as a "drop-in" replacement to each 
others. I wouldn't guarantee that.

Furthermore, my current understanding is that the BD71828 was a model 
that was used for a limited purposes. So, maybe creating an dt-entry like:
compatible = "rohm,bd71879", "rohm,bd71828"

might not prove to be too useful. (But I'm not 100% certain on this).

> Yes. If there are reasons against, please briefly mention them in commit
> msg.

I would like to understand the rationale for allowing:
compatible = "rohm,bd71879", "rohm,bd71828".

Is the intention to:
1) allow boards which tell the software that "the hardware may be 
bd71828 or bd71879", or
2) to tell a binding reader that these ICs are likely to be usable as 
replacements to each others?
(Or, is there some other rationale beyond these?)

If it's 1), then I see limited sense in doing so, while I expect that 
not so many bd71828 variants will be seen out there - and at least not 
in that many different products. If it's the 2), then I wouldn't say we 
have the facts to do this.
And, as always, if there is 3), 4), ... - I am keen to learn :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


