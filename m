Return-Path: <linux-kernel+bounces-132472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A788E899570
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE7C1C21A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9821A19;
	Fri,  5 Apr 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMDauoXf"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29B17BB7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298911; cv=none; b=V/vN/EEGVq8kIqT6hrZRP3QpB2iexcftkdY6aCRmzdUHmjGqKEqh75IiuvBTWnyHMYaATuYYQvSjyCJm/DLQDiYukh5LSt2EUrkx2/I6NC5ixVa+TwYD/2CtBqTifQ2WCj90JWs4rw6mtdlSTzW3xEdUlLiey/vG4hgl7qPWy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298911; c=relaxed/simple;
	bh=zAXQTFk3dy9rFz7UMA2GsewKzaPbcvQOql0O9wmtpTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PviFihRmBju40Do6ohtWzqqKARc5SlgDIxB8gtD5Xjm3BJAW4fe1HBtd42jNBBpRXdV5PfVZudnhHETlrquxSVnyZ+samyLVfxYMpvK45ggGXbYX6O0iImh5EYVpnvCcBVifx2hDZUz1cRti3OK9I5csZG3CBpFqmcMH9xk9VQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XMDauoXf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e2119cffeso1588614a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712298908; x=1712903708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jb82oO4v/gE5dt/L7sWdzMxzPuWBfCDcdpN0mGWj7o=;
        b=XMDauoXfF2ZvpsGAfcSOnSpFnKC/Tme4iaStXYUVV/Qte4ROCRQSn77k2/6VGFUQ32
         PaOjYhU5gF/r/HZcSA6//5Tvv4dp4QBWeFgDXRrSQMGW+6jniL17nLaKIySTBM/uayIc
         3M/37vtyT1B7jzuz2SLyp94LsfDjuauOnkL10TE+MMHvdPSzPBH/Smnfzjhm37GgAq5y
         Hipy3pEWJq5RVlXMI0E9JcIiuflmv1vOmURdSKvpTqMsJXGRjq5vbIDWtfuoguIjToei
         EpB/FD5M4rU0TaWUpPF/rjfqMsNBWdgawc5c+u4yQ1hXzzEhEADcIzPZwU/KHDJx/oQJ
         wEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712298908; x=1712903708;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jb82oO4v/gE5dt/L7sWdzMxzPuWBfCDcdpN0mGWj7o=;
        b=fQJufSW+h0th0WKA4MBtjf+fmzU/mrPi5ioYUG46G0Bn/KviUpZmMXzPdK4j2oIq0k
         xKgO3p9FoRcV0D+8gXNGWKTTOMb7S4KkvyUkUQwjvPTIX36diXfQkA4LJVLU82jnXP2z
         Cp7pPQroQ8GyDRZmfBwlxjl2USiKscYVNXfkuHW4HRgOy04KATZYXvhQibnqUaQzOktx
         P4guT2sJmjDkEUwQUnaInm5oRbXeRQIc6hClCRC9fjEiw6QgdwCNnB8L8cl3Lpy5bbhv
         RWmS5V2Qipj1Y6p1juynppjGl+ABS9Od2906awgIQEDpl0Z7inSpccyPwxNSU/qmkXa5
         UIWw==
X-Forwarded-Encrypted: i=1; AJvYcCUFAcaNZK0ofgEDdeyPkR2FZKYDtcgkWTtR7vasF8vyVzZzJbkpekHZVN+J/F+LbkNcJyfga4LheWsZ51Eajqa/Bk/rOUkOULtWI+D0
X-Gm-Message-State: AOJu0YxD3x+3NDQ1oy+7Eq0cvCdT+uUT2eOv/ZeaI2Eu/r3LWQXH26ma
	ZY0Qc/cHoT6rHdPa0bP2BNlmLx3UAFAyIZvAufpCVm6zVCAfDdTpirqduKAUM2A=
X-Google-Smtp-Source: AGHT+IGFEBXPvcuNq7rbcI62N4JFmmdauGzYoC8eMyXhYzG9QRxKvU1QsAPNIgdUu1dwma2lPFkMjg==
X-Received: by 2002:a50:8e03:0:b0:56e:2356:bce4 with SMTP id 3-20020a508e03000000b0056e2356bce4mr343903edw.31.1712298907825;
        Thu, 04 Apr 2024 23:35:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0056c2d0052c0sm451543edc.60.2024.04.04.23.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:35:07 -0700 (PDT)
Message-ID: <35a9399e-819a-400c-b321-099f8bc9df90@linaro.org>
Date: Fri, 5 Apr 2024 08:35:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-2-andreas@kemnade.info>
 <6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
 <20240404123010.69454fda@aktux>
 <8f37211a-57ed-48ab-8de8-cd5a0d4c6609@linaro.org>
 <0295c8db-b01e-45e7-b44e-79d36d81cd48@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0295c8db-b01e-45e7-b44e-79d36d81cd48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 08:01, Matti Vaittinen wrote:
> On 4/4/24 15:04, Krzysztof Kozlowski wrote:
>> On 04/04/2024 12:30, Andreas Kemnade wrote:
>>> On Thu, 4 Apr 2024 08:59:54 +0200
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 02/04/2024 21:35, Andreas Kemnade wrote:
>>>>> As this chip was seen in several devices in the wild, add it.
>>>>>
>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>>> index 0b62f854bf6b..e4df09e8961c 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>>> @@ -17,7 +17,9 @@ description: |
>>>>>   
>>>>>   properties:
>>>>>     compatible:
>>>>> -    const: rohm,bd71828
>>>>> +    enum:
>>>>> +      - rohm,bd71828
>>>>> +      - rohm,bd71879
>>>>
>>>> In your second commit you claim they are compatible, so why they are not
>>>> marked as such?
>>>>
>>> so you mean allowing
>>>
>>> compatible = "rohm,bd71828"
>>> and
>>> compatible = "rohm,bd71879", "rohm,bd71828"
> 
> 
> This makes me slightly nervous. It wouldn't be the first time when I've 
> been told "they are similar", and later the reality has turned out to be 
> "they are similar, except...". Furthermore, even if these devices seem 
> similar to software (which is what the comment in the MFD driver is 
> referring to), it does not mean these devices are 100% electrically 
> compatible so that they could be used as a "drop-in" replacement to each 
> others. I wouldn't guarantee that.

compatibility does not mean that. It is only about software interface.

> 
> Furthermore, my current understanding is that the BD71828 was a model 
> that was used for a limited purposes. So, maybe creating an dt-entry like:
> compatible = "rohm,bd71879", "rohm,bd71828"
> 
> might not prove to be too useful. (But I'm not 100% certain on this).
> 
>> Yes. If there are reasons against, please briefly mention them in commit
>> msg.
> 
> I would like to understand the rationale for allowing:
> compatible = "rohm,bd71879", "rohm,bd71828".
> 
> Is the intention to:
> 1) allow boards which tell the software that "the hardware may be 
> bd71828 or bd71879", or
> 2) to tell a binding reader that these ICs are likely to be usable as 
> replacements to each others?
> (Or, is there some other rationale beyond these?)

None of these. Compatibility means that software can use fallback
compatible as matching mechanism and everything will work fine or with
reduced set of features, but still working.

> 
> If it's 1), then I see limited sense in doing so, while I expect that 
> not so many bd71828 variants will be seen out there - and at least not 
> in that many different products. If it's the 2), then I wouldn't say we 
> have the facts to do this.
> And, as always, if there is 3), 4), ... - I am keen to learn :)
> 


Best regards,
Krzysztof


