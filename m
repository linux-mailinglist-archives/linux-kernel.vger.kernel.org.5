Return-Path: <linux-kernel+bounces-143987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BFB8A4070
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24243281ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66E1BF50;
	Sun, 14 Apr 2024 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehZV8xsd"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED11B94F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713073934; cv=none; b=uifE6FI4F87+iGIWnHJo8Qfpe8rbDwOzd5XAhVH8ZO5VusXfJnabrQbZjV4DXQOJ5TmsZ24qhNq8zZ0V5OahMoH8c4tlBmT2+QqGEsrwdJW/ys4nI4iDvtoeQZj5tQbTyOAh2F4CA/GKnG3cSY5syfq+S9HuXGV6P8bbRBwkOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713073934; c=relaxed/simple;
	bh=gkFjdp4a1rNpx/+zlzyEZoGADjSfZU3nNZhtvmvrq3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xje32592FOgSmGjMrNZ052Qr1RI07n6kCotJLnLrGlsioToG6DTVraCF+hRwe5/NDfXczFTGnVj1unIEc7VA+H7vht7ZikyKsCdsGwpFQgUegBOqoqUlwy/NI5i5L34FKDIm0XB+eBLAhfv29b4tn8KIkRl6y+niwCULXs18n34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehZV8xsd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5367134a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713073931; x=1713678731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+BIcKwkF8WH4Du8nK3Cmra0ZAndhivR3Sa8HBz2YQiQ=;
        b=ehZV8xsd3ixjCCzalP1Q2su0Pb1iW/ni1oOSvfC4rb2zJktYeM+7zOJS2MXmh/mIDt
         3Ec9jMnWd0wpSxGUSCV/s9xN2AqpeYDmodzt8UiOIXx1H2cKofw31JpZgSmsUnTSMrgI
         dXWlU+N5JQz1/laxFO7wKbrkpaea9Rg5o7gDNTFFdSu1fEJo5g0B+y84n1qkSEP6+nJQ
         XBIp770lEX2VsmREuEdxHHQ0INegPI6px46z5AXMfp7tR/zXteQMr0JJDXrACX8BOI85
         B4dnU3InFdZZaexcR5E7K8xfuoqYb3kX2HZ5Xuzy3sUJ0LsT9bo1jZ43GXcQkRJb25DK
         H03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713073931; x=1713678731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BIcKwkF8WH4Du8nK3Cmra0ZAndhivR3Sa8HBz2YQiQ=;
        b=ftUkeFTLJvmzwYv+LzSavMzrVSOYuITVsbxQrZ+cD9WUOvYqpKvpzoOb6pzuuL4AII
         HiMGmW8ZG34wKC/ET1iWwEWzmc/rzmdG0y1jUyyQsnJ+GeU9oV3w+4U9OQSoH2JtDLD7
         HYPAEzpxVMmNL1EE503Rm4AOx7ulStjDRsqtsMe8EJ7RuEwg2tvzukmDZzNmkr9192O4
         dSI8fU7v5Q984JRMEbkjrY7SE6L3xEMvA6DDigAtDCZrCkcrGzhYctuTzKJw+VOhYCq4
         CepcPHvU5pNhBauwawgFaabYMfyQ9jow+qP5roLMaK55kfyFtlvzFvKBpMKOhu8k1iA/
         q1kw==
X-Forwarded-Encrypted: i=1; AJvYcCX00NmT7rssFmMno4kEehzXM2qqK7qRvW0xwAMiiEFBqp2bseqHFEcEizHUo8ukSeFb6z+YyoigOGNm0yxyEjbitn1VUO+b8BLM6JFP
X-Gm-Message-State: AOJu0YyqxCS9Pmn3vpHhzbmLyXEkSyFbqrNYh13cqChhkKsHct5xI+0F
	WAKahNH00W1xWctXuEJxzYTqU2H/t1G/2eRHoGnc+QuEmwuzQpo/HnrBIPuzZoA=
X-Google-Smtp-Source: AGHT+IFr3sMSlS0w7sqj1Zvpz3WJKCfOx9Zh4bRu5T7ATZy7Dt2XN+fj93fGbzN8GCaMHBg8eslEQg==
X-Received: by 2002:a17:907:7da4:b0:a52:5827:fb9 with SMTP id oz36-20020a1709077da400b00a5258270fb9mr1347004ejc.27.1713073930868;
        Sat, 13 Apr 2024 22:52:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x26-20020a170906711a00b00a521591ffacsm3798407ejj.34.2024.04.13.22.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 22:52:10 -0700 (PDT)
Message-ID: <8de8590f-0ed3-4fd1-82a3-96b5fb767e48@linaro.org>
Date: Sun, 14 Apr 2024 07:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
To: "Haener, Michael" <michael.haener@siemens.com>,
 "lukas@wunner.de" <lukas@wunner.de>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "jarkko@kernel.org" <jarkko@kernel.org>,
 "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
 <ZhpfwaIUc0HpfZP1@wunner.de>
 <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
 <ZhpjozjbeWrb0OTl@wunner.de>
 <bbe365cd-698e-4507-b5e6-d7dd4dcc7a75@linaro.org>
 <ZhpkzWhOdW3OaJfn@wunner.de>
 <548b7a66-9a56-4971-89eb-1a147d658f0f@linaro.org>
 <ca685f5b60ac676a72b80b65b73b33d532617acd.camel@siemens.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ca685f5b60ac676a72b80b65b73b33d532617acd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/04/2024 07:42, Haener, Michael wrote:
> On Sat, 2024-04-13 at 13:01 +0200, Krzysztof Kozlowski wrote:
>> On 13/04/2024 12:56, Lukas Wunner wrote:
>>> On Sat, Apr 13, 2024 at 12:53:25PM +0200, Krzysztof Kozlowski
>>> wrote:
>>>> On 13/04/2024 12:51, Lukas Wunner wrote:
>>>>> The binding requires two entries in the compatible string used
>>>>> in the DT,
>>>>> the chip name followed by the generic string:
>>>>>
>>>>>         items:
>>>>>           - enum:
>>>>>               - infineon,slb9673
>>>>>               - nuvoton,npct75x
>>>>>           - const: tcg,tpm-tis-i2c
>>>>>
>>>>> This allows us to deal with device-specific quirks, should they
>>>>> pop up
>>>>> (e.g. special timing requirements, hardware bugs).  We don't
>>>>> know in
>>>>> advance if they will be discovered, but if they are, it's
>>>>> cumbersome
>>>>> to determine after the fact which products (and thus DTs) are
>>>>> affected.
>>>>> So having the name of the actual chip used on the board has
>>>>> value.
>>>>
>>>> So you say devices are compatible. Then the second patch is
>>>> wrong.
>>>>
>>>> I cannot respond to it, though... so NAK-here-for-second-patch.
>>>
>>> I disagree.  It's ugly to have inconsistencies between the DT
>>> bindings
>>> and the driver.  So I think patch [1/2] in this series is fine.
>>
>> You are mixing different things. This patchset creates inconsistency.
>> You even refer here to bindings while we discuss the driver...
>>
>> Why this one driver is different than all other Linux drivers? Why do
>> you keep pushing here entirely different behavior?
>>
>> The devices are compatible, so growing match table is both redundant
>> and
>> confusing. That's everywhere. TPM is not different.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Sorry for the mistakes made (kernel noob).
> I made the patch for the driver analogous to the i2c-tpm of
> infineon,slb9673 and nuvoton,npct75x. In the discussion I realize that
> the compatibility is a duplication and should not be extended.
> 
> I now adjust the following in the series:
> - correct cc receiver list
> - delete driver patch with compatibility extension
> - change commit title to "dt-bindings: tpm: Add st,st33ktpm2xi2c"

Thanks.

Best regards,
Krzysztof


