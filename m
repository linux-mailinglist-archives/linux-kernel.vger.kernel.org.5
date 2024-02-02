Return-Path: <linux-kernel+bounces-49355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44484691E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459E7B254D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63517999;
	Fri,  2 Feb 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gj89uc2b"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E017BAC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858235; cv=none; b=JIxordWN6LWQ+JzoUkD1fubJgLS4ZzzmEp6fCIF3UVoAWK4XsS4JeNscnchnjJgtL16l2jVcpEadAatQMpAT9ZRkVnzXORs0anzylGcX3eRLd5XYv5vvGVw9XMExB8TXFa6fHOJSlWSTlccYCe+RG3vfflF/h6AR9q6/7vVfzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858235; c=relaxed/simple;
	bh=MlP30iiUF7AbDtIcAQzDUz/4RQblnnFeFWnTQ4VygrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZb3MJbGOCfTU2CKKdD8MpfS+VAwAe48fPDhTspA+PMEsG8nINIEf5uAMIzlpuUsE75ouR31FbHgvOPV2lLVgU7myAqrdJaAD7fZcDQEsuaftEIv+rm6hCrKpvSWQuIg/maO9/IlkskcYNM101AUDrQGTi8Bwjp/ZHxLh6u3UdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gj89uc2b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35e9161b8cso243096566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706858231; x=1707463031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RSy8eeTLHLxTS0EEmvDC0Ukq1RLkz6dvGJJ5c6GskD0=;
        b=gj89uc2bvLyGAxHRE+rhMtdCk7XHOccMzYvXYWA0jFEFhwh1OoFKVtz5QbBtk8vRDN
         Tm4ZBRQQIz1jj7mgLIWk7c1HFbRd58LxRP1Whsp913KbCivnKOHSjpTMtMWmsBYRkq/I
         ZVUIlkipJhWax73j6+4LSGABjnn653rDHehndB/O6XDrNzN3BseG3jaLKdpzd2BtE+gL
         dRDhiBHgUJBYzfyI5onLEFBJvTVyDRvaWXhVBZFSH1R4yvsfoNrw91uMtYy7GxSvZg6q
         pUL/hpLwcKoCPerUqf37ypkIm7tnHERKA7R2QYOkISLGTWqhsVk4GqoNxMmjZqU81rjz
         +7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858231; x=1707463031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSy8eeTLHLxTS0EEmvDC0Ukq1RLkz6dvGJJ5c6GskD0=;
        b=kklZIt7UqhMWoGhERZxRVvRvxRlz8FCM6mWiejKYV+H+g1PqYVHABGkOjY3OjacGnr
         TW87mq4v5p9JaUxCziQj2w+UJSqccvvdF83sJaJIlETUwDD1fzGPwArGpFeea3PEeJAo
         aqjGvjj+8zjFYpo8d/86lcXixOVbY917yLIVUG1FKMmVWmcTK9O74QqmMVd0MCJRscDC
         dHoEfQ9RMdPormW3m1GM2zC0MGDssvLqxMQD+HPWD3GixT9ll3f3mrPar724mmQA1Zbh
         bMq1bTMSePeI68bbddConPGv66rRsxWuJp0wS7IceC+08CUHVmPsHJ9j8EVGjFzhzRVj
         zjpQ==
X-Gm-Message-State: AOJu0YyGulHuv/bQGGEMysvmIuoOQ88D6irZS33/6fXn8kWTEBTH+lEG
	hvjWsGf8NkYYK/K0UeQE+QmqwadQX2TFpR52xcN9dh0sXJBpnZlZczF9ynDXuGQ=
X-Google-Smtp-Source: AGHT+IHWuhdy6LLE1Xo3TlX6nhPhnkiNXNsKPTmcri8k5ArOCoZQ2K/eZboIbPUYbRG7dbUGGLl9bw==
X-Received: by 2002:a17:906:1f07:b0:a35:34c0:e1bd with SMTP id w7-20020a1709061f0700b00a3534c0e1bdmr824480ejj.67.1706858231462;
        Thu, 01 Feb 2024 23:17:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcTcXsIBtq81BlVw6d2+yV4wP8EWysPfly8LHIwJzcGQ2SoP6zw/A8v/cqnjp3h5aNZznnFPiBfEGrFxSnFmLEF2LRXm15ZnHqSm1tjUdIYsRPQQvPiMOiZ2yJMqafOtUlB2mkLNEtvkTeVIIAlJEtBkX/C9nDbqHzCfwQDKkQUyYcXXZsvmLbFJ2pgwCN9zIEsjbKqL/FKNGuHYo2Sgp2Ud26aHVcommSkDdeHrCl6bvpQS5wiQ0=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id hw16-20020a170907a0d000b00a36f0e2f3d8sm575116ejc.7.2024.02.01.23.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:17:11 -0800 (PST)
Message-ID: <636c626e-118c-475f-909d-4f6cdbfb07eb@linaro.org>
Date: Fri, 2 Feb 2024 08:17:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: memory: additional compatible strings
 for Broadcom DPFE
To: Markus Mayer <mmayer@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
References: <20240119215231.758844-1-mmayer@broadcom.com>
 <20240119215231.758844-4-mmayer@broadcom.com>
 <f46951b9-36b0-4155-b6ac-3d3f7cc8ef37@linaro.org>
 <CAGt4E5taqv2kgK4ZF6R+otKwrVYiaNNkeCu5Qv7xW8cyBvv3Fw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGt4E5taqv2kgK4ZF6R+otKwrVYiaNNkeCu5Qv7xW8cyBvv3Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 23:36, Markus Mayer wrote:
> On Tue, 23 Jan 2024 at 13:27, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 19/01/2024 22:52, Markus Mayer wrote:
>>> Add versioned compatible strings for Broadcom DPFE. These take the form
>>> brcm,dpfe-cpu-v<N> where <N> is a number from 1 to 4.
>>>
>>> The chip-specific strings have been kept for compatibility purposes
>>> (hardware is in the field). For new chips, the properly versioned
>>> compatible string should be used.
>>>
>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>> ---
>>>  .../memory-controllers/brcm,dpfe-cpu.yaml     | 21 ++++++++++++++++++-
>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>>> index 3f00bc2fd3ec..42c8160d95d1 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>>> @@ -10,9 +10,28 @@ maintainers:
>>>    - Krzysztof Kozlowski <krzk@kernel.org>
>>>    - Markus Mayer <mmayer@broadcom.com>
>>>
>>> +description: |
>>> +
>>
>> Drop blank line.
> 
> Will do.
> 
>>> +  The DCPU (DDR PHY Front End CPU) interfaces directly with the DDR PHY
>>> +  chip on Broadcom STB SoCs. An API exists for other agents to retrieve
>>> +  or set certain DDR PHY chip parameters by JEDEC.
>>> +
>>> +  Different, incompatible versions of this API have been created over
>>> +  time. The API has changed for the some chips as development progressed
>>> +  and features were added or changed.
>>> +
>>> +  We rely on the boot firmware (which already knows the API version
>>> +  required) to populate Device Tree with the corresponding compatible
>>> +  string.
>>> +
>>>  properties:
>>>    compatible:
>>>      items:
>>> +      - enum:
>>> +          - brcm,dpfe-cpu-v1
>>> +          - brcm,dpfe-cpu-v2
>>> +          - brcm,dpfe-cpu-v3
>>> +          - brcm,dpfe-cpu-v4
>>
>> I don't see my comment resolved - except more unusual order of
>> compatibles - and nothing in commit msg explains my previous concerns.
> 
> I am confused. What about ordering them in alphabetically ascending
> order is unusual?

Order of entire list - you just added everything to the beginning of the
list. This does not make sense.

> 
> Which concerns, specifically, are you referencing? I promise I am not

That you claim here that bcm7271 is both v1, v2, v3 and v4. Nothing in
the commit msg explains this.

Nothing from my message here:
https://lore.kernel.org/all/3fff866f-fbe8-4d23-87f3-275380adf3d4@linaro.org/
is resolved or addressed.


> deliberately ignoring concerns as there would be no point in doing so.
> I have nothing to gain from it. I am trying to get code accepted into
> the kernel. I am not trying to "win any battles" or "prove that I can
> be more stubborn" or anything of that nature. If it is possible to
> integrate concerns raised by the maintainer, I will gladly do so. And
> if not, I'd like to find a way that works for both sides.
> 
> BTW, I once used to be on the Linaro Landing Team for Broadcom. You'll
> find some commits from me in the kernel that carry a linaro.org e-mail
> address. Most are from over a decade ago. Yikes, time flies!
> 
> The reason I am mentioning this is to point out that
> 
> * I am not new to this.
> * I am respecting the Open Source community and so is the rest of the team.
> * We are trying to do the right thing and be "good citizens".
> * We upstream whatever we can to the relevant project, not just the kernel.
> * We aren't on some kind of power-trip or unwilling to listen to feedback.

OK, I see you sent the almost same patch with no improvements in the
code and in commit msg, so that was the assumption. I made quite clear
concerns last time and asked several questions.

> 
> I am not saying this because I think any of the above makes me special
> or particularly accomplished. However, I do think that some things may
> need to be clarified as there does seem to be a certain attitude at
> play here, with certain assumptions, that is far from constructive.
> Hopefully, this has now been cleared up, and we can move forward with
> addressing the outstanding concerns regarding our DPFE compatible
> strings.
> 
>> I think my final comment was pretty clear yet ignored completely. There
>> was no follow up:
>> https://lore.kernel.org/all/3fff866f-fbe8-4d23-87f3-275380adf3d4@linaro.org/
> 
> Unfortunately, it may not be as clear as you think. I did my best to
> incorporate what I thought you meant. Clearly that didn't work out so
> well.
> 
> So, please clarify in more detail, and maybe showing some examples,
> what it is you would like to see. For instance, I have no idea what
> "(e.g. bcm7271 + v1 + generic fallback)" is actually supposed to mean.

This means: List of three compatibles, SoC specific, your versioned one,
generic compatible used as fallback.

> Is that shorthand for 3 compatible strings (brcm,bcm7271-dpfe-cpu,
> brcm,dpfe-cpu-v1, brcm,dpfe-cpu). If so, how is that different from
> what we already had?

If something is unclear in that message, please continue that message.
There was no further explanation, no further comments on my email, so I
assume you agree or understand it.

> 
>> so with ignored comments: NAK

Also - missing device prefix in subject:

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.


Best regards,
Krzysztof


