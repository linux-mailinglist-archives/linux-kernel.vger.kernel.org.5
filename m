Return-Path: <linux-kernel+bounces-57701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2F84DC87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5CB1F2203B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962D46BB58;
	Thu,  8 Feb 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQ5Ju95+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959F339BF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383555; cv=none; b=tHLOrRMmtIe5Xc3Zgdj3zLowNec4KIeitTR9VBtNgn/91hnsNDfvrpcNG0bHoQ0hZnTb1e7kA6VGkHk8M4slZOtT+ZD6QejqmbT2uhEIitXx3oSolwTNWgd0IrUgRYmDenOPnzUqBwXGqVdU4YEBCm9d+5BU4WV0Od4zfyIgNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383555; c=relaxed/simple;
	bh=e5f5GRj9rwLD/m3HqFj8t/1npzy9Xt+rj3nQlCMLK9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEnsOYVGxkhW/m8JL3Q2/jYrTVCYQGkimZhp0BQpFjaxTGuU4/nj/ww24OdAT4mR6kge9CRjhu25svO4Lk9ewjpXBDKeTSv1bOGGG2TX2GU7D+d5JiKKAbuXWD+RBI4bzFrmqqbswNv40zBlOxZ9CqoRjsQBu7F+F03Ifp7E/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQ5Ju95+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-339289fead2so1109102f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707383551; x=1707988351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5eybrynvjns/Wtq7b/PZsWmH5mdyHyY+UrR2V8V3g4=;
        b=gQ5Ju95+RRhuEh7pLqWFjwKTDBxJz4FlHzJ0JF/U2Nf5zSBNnNew3ZiwzenKORXzin
         fuNmZgeY6rxWu4kNjExn5oju1HtcxXCyUe7oGSR+mQ0o84SecUo6Rhvo/eoEYNpAD55B
         1O/2fp/iOavn240CbrQbJ0gFgDoTj5DWYfcizyjfSCfzWKfRqv4gGl7hdwahpH2elrdS
         njC82+Q9IEjlWOBR9QyLYgyXhi8MndBDzpuAUFOQATTSve4dHW2kPjyWky6cGFvXeSH7
         gDHtpeNc0PPIBNZY50gcb1Brem/awsMNO1cw8G6g9hFwO11eq4LWOBWSYA7zNogT99dn
         kDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383551; x=1707988351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5eybrynvjns/Wtq7b/PZsWmH5mdyHyY+UrR2V8V3g4=;
        b=bNsUOt6kp55jDsWfu8JZLNNI3fQL9EH7kjcvmo0ao4oryOJviVpxqm/ugT6ymKnyFs
         ijV0HSiqmyECP2j6c8nVVTGxfapPd80JPoriA/eWwB5ZDNkF4lJXQe7FEw5w918MrAC2
         oPO2GpmAJHe33HbnW8lL12G+MkIR4NiM6AJuDtBMvCo1EnVFFkptl1ZnumweVM6nFRJT
         3NoFD5iLhY8iv7R7ZbBNcRQejegrm1PMyqcHesgonmxo0nXMAbau69kaan41JdpB1qcE
         57qkeBLKyWQymubaaCyq5mOtYVic7++j9zaGrZkRF5UfvPYGZRVVy+gd2+X8J+O44Vjw
         asuQ==
X-Gm-Message-State: AOJu0YzUtWwwCAb4jsqXiXK7gDcP3gF2k9VJtq32iNUBufjlbe4ygQm3
	Bf5ySlvUv1TQTzWosrDMAEAWGa0YI2uATLx4zUnAxDyO5ni+dZUmUGijWfYLmuo=
X-Google-Smtp-Source: AGHT+IFEVSjU54mXWQNKgdwLchAZkMEQQmVLOMO4sUAlJHwkGiVK5NVODPQN1MRg66rCkEtDhDDW8w==
X-Received: by 2002:a05:6000:ce:b0:33b:5b90:f62a with SMTP id q14-20020a05600000ce00b0033b5b90f62amr325224wrx.17.1707383550696;
        Thu, 08 Feb 2024 01:12:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx3rY+59XE52vIbPHrU4E5vT1UjVE0bm4rYjHlOZiLI6VlVcMWKIZ83ubcvWdBbFc76L7Q42ItPf7G2xEHQMmrUn5Un2sLNQ2B4E2TE1q1I4AyLz4HvMAK/stJUQNnqKnN5XWIrfp3WSIYrhDxZ9nwTr4/rhM6rt+Z4pY2Cae7FFQ9OOXA2YfOkFyD2B9s3cSt0b6Kqf9fumsb/R0k97/DteQrTNupkqznzj0ugdXuXsWkFRI2Z3u56Nmw/UZUqtG1pA9BP1S7bln7qtt8j54Ys5yspLEeWr9LTJIXbQXd68MyCL5wzkFxpRJuzfZnUJ7ObkiEDrIjHAzj0sIyJO2e1SDrfjDp8gft9yJmfOcsnAEnENA9IwYAtcDuvB/CJyat56F4BW5KJbNjxKi+JuYzoOHxyHRCmi+6sjOhlAvf8aZHWikUCahWBCOgg7S7TVSEv6Kz50sQEa65GrpjhdLiLRkS2+GPUYJJ+UEO0IlXfoWptfk/BoULOQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b0033b3c03053esm3174687wrx.78.2024.02.08.01.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:12:30 -0800 (PST)
Message-ID: <cb7b7f91-5fcc-4efe-9066-2eb3de836361@linaro.org>
Date: Thu, 8 Feb 2024 10:12:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: dp83826: support TX data voltage
 tuning
Content-Language: en-US
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
 "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <a4949983-f6ba-4d98-b180-755de6b11d0f@linaro.org>
 <83f00386-e741-4bde-bcfb-462fadde1519@leica-geosystems.com>
 <2c4e76f5-0a13-44b5-8ece-3deb957dd260@linaro.org>
 <f35e239d-3f78-40e1-8d5b-4d7b949f08aa@leica-geosystems.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f35e239d-3f78-40e1-8d5b-4d7b949f08aa@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/02/2024 10:08, POPESCU Catalin wrote:
> On 08.02.24 09:50, Krzysztof Kozlowski wrote:
>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>
>>
>> On 08/02/2024 09:48, POPESCU Catalin wrote:
>>> On 08.02.24 08:35, Krzysztof Kozlowski wrote:
>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>>>
>>>>
>>>> On 07/02/2024 18:58, Catalin Popescu wrote:
>>>>> Add properties ti,cfg-dac-minus-one-milli-percent and
>>>>> ti,cfg-dac-plus-one-milli-percent to support voltage tuning
>>>>> of logical levels -1/+1 of the MLT-3 encoded TX data.
>>>>>
>>>>> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>    - squash the 2 DT bindings patches in one single patch
>>>>>    - drop redundant "binding" from the DT bindings patch title
>>>>>    - rename DT properties and define them as percentage
>>>>>    - add default value for each new DT property
>>>>> ---
>>>>>    .../devicetree/bindings/net/ti,dp83822.yaml    | 18 ++++++++++++++++++
>>>>>    1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>>> index db74474207ed..6bbd465e51d6 100644
>>>>> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>>> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>>> @@ -62,6 +62,24 @@ properties:
>>>>>           for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
>>>>>           to transmit data.
>>>>>
>>>>> +  ti,cfg-dac-minus-one-milli-percent:
>>>>> +    description: |
>>>>> +       DP83826 PHY only.
>>>>> +       Sets the voltage ratio (with respect to the nominal value)
>>>>> +       of the logical level -1 for the MLT-3 encoded TX data.
>>>>> +    enum: [50000, 56250, 62500, 68750, 75000, 81250, 87500, 93750, 100000,
>>>>> +           106250, 112500, 118750, 125000, 131250, 137500, 143750, 150000]
>>>> I see all values being multiple of basis points, so why not using -bp
>>>> suffix?
>>> I can read :
>>>
>>>     "-bp$":
>>>       $ref: types.yaml#/definitions/int32-array
>>>       description: basis points (1/100 of a percent)
>>>
>>> In my case it's 1/1000 of a percent. As I'm not sure exactly what the
>>> author meant by "basis points", would this apply to my patch as well?
>> So please show me the value which does not fit in -bp.
> 
> "Basis points" doesn't mean anything to me, that's why I was asking for 
> confirmation :)
> I don't have any issue to use "-bp" at all, I'm not pusing against.

https://en.wikipedia.org/wiki/Basis_point

Looks like all your values fit there, at least for these devices. Maybe
you would need to be sure other devices do not require mpercent after all.

Best regards,
Krzysztof


