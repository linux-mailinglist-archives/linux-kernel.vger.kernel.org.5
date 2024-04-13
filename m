Return-Path: <linux-kernel+bounces-143878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C38A3EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9EB281D23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C195644F;
	Sat, 13 Apr 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJXsBlq/"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7442901
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042832; cv=none; b=ttfh8BskMQ5BbLYSBg0vsP4rNzkKNiHScSe4cjnW4ZGhjkFBTzgJXH1jk7B3bqK0c63IXWwXG672cZivGrdx3MmCcbnKSiv8dkpGmYDy+hWgqlo899I52ZfvYMgmo4mKlrAKDed0ILWzVKDmEi/2UKjrgLpPiLFH6j9MIyzJVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042832; c=relaxed/simple;
	bh=XGReRWz7u7T8neea9WRts0ekrqtCQCSHyQ6+MlKIXXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzPGX3yNQN2ccpLT3kLhv7y5WmM6eEuNGPgxHnhfTAPCr6pPzg1r+GNAGtNeGWXhTHRYEDzMvKaoJDbBiP+6MmNP909N4cM+omyAZxKwviGl8loTM/TIzGfPQKm8vfTJzVYUUFNTkHq4WTz1jRHMvUCfTYoi5HP8dxOOUrsRp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJXsBlq/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51beae2f13so230190166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713042829; x=1713647629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/QcS7aKqLvfcOrAHC9t/RNGgAG9N/gh7FrnnJ0LyKg=;
        b=cJXsBlq/JeLE7Ese/v1yubDNkfEyxFt82pC4IYjwxB1dIyTmXNFHo4h29l3qx7ATaA
         LROdhCCAV7MAwUC2thQ3SLjZL8qphaJrrqGbHd5skOd1l2Jr93YP7Bn0Q8cJea2MHsaG
         bzlxBjERZCDjPoqGw8yjpJmjNGWePvoM38HhifLaTOMC/aneCG5NPxeBicDpvQ1tghPQ
         RvAjGI7xSQwPG7IXMbMSdL0rI1iJ/yVtn4nwaEnyGI5if3tkdH+hTC3nzhRx3uOXhoSm
         XfYVaq9jRlF8Ea3+ABtKeo26FY8IRcx0wkSwPQp1uwpTsh03OOz5M0XtpvTLfKhQRvAl
         h92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713042829; x=1713647629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/QcS7aKqLvfcOrAHC9t/RNGgAG9N/gh7FrnnJ0LyKg=;
        b=dcfejmbwZFg/wGSRYznYLYVsNcAlwgwG8IAJZWByzfxuqc+S7NlmD/rXm6kTD4VBoo
         bdm5XE6JDG7fr+oXh4FnkPJ/gp/8Rb8ugECMajdlXlmkYU5Ob/gI5jsg2E+Xqvz7iLnh
         oQ+Y6KXDhjzruFh+ncPBebV8NvAMZqhXs7ltnlqtz1YgqCylxf2tVbaGNPHxJCixh0Kj
         Ka859qNS01Pf6LuAKyZ++YPovECRkfQPL3vrfTivWGk93mZPqChtESjySrFZ4J85gEw9
         VBFM4pyVkgnyxbwp0MExSJc1gsw04yZsUoeMA0Z0NTl1B/XaUJG+BROrHO48sPO3aAfp
         FHNw==
X-Forwarded-Encrypted: i=1; AJvYcCWbX3wtLFrDACmB3qk4eBXjjjxrpykRFaUv3wh3eWJcHElZj0u083H2xyBevc9gCoGzTppU2la/WMsOytSUAGaYOWHofhIHiztP18Yy
X-Gm-Message-State: AOJu0YxqRZ19NN+bs1lNFUc0/m9sVl270oD546gjlLLNNdnTET3gJU4x
	EuC+2rGc8G+xopdsrvfd8fS4zFC+jH7K9X8um7VPX9YlLSqQ4Fuh7+TiAnmqY6A=
X-Google-Smtp-Source: AGHT+IFWuvfsMgahGLa+kTIMnUfbUbWCZlLRSzZJcSHFDWPdBB6rJ0uf0VK89rG+ntQXqMTNChKoaw==
X-Received: by 2002:a17:906:b7d1:b0:a51:c747:531d with SMTP id fy17-20020a170906b7d100b00a51c747531dmr3671963ejb.64.1713042829092;
        Sat, 13 Apr 2024 14:13:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090630d800b00a4e781bd30dsm3387480ejb.24.2024.04.13.14.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:13:48 -0700 (PDT)
Message-ID: <08ec46be-971f-4234-b65c-96992b5b0a87@linaro.org>
Date: Sat, 13 Apr 2024 23:13:46 +0200
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
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "krzk@kernel.org" <krzk@kernel.org>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "robh@kernel.org"
 <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "lukas@wunner.de" <lukas@wunner.de>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <9634ac9e-23ad-4bb9-aecf-d46c875f8d2f@kernel.org>
 <85fa06dfb9bb69443ce86e10b8c4619317cccb3e.camel@siemens.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <85fa06dfb9bb69443ce86e10b8c4619317cccb3e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 22:26, Haener, Michael wrote:
> On Sat, 2024-04-13 at 10:38 +0200, Krzysztof Kozlowski wrote:
>> On 13/04/2024 09:15, M. Haener wrote:
>>> From: Michael Haener <michael.haener@siemens.com>
>>>
>>> Add the ST chip st33ktpm2xi2c to the supported compatible strings
>>> of the
>>> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client
>>> TPM
>>> Profile specification.
>>>
>>> For reference, a datasheet is available at:
>>> https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf
>>>
>>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>>> Signed-off-by: Michael Haener <michael.haener@siemens.com>
>>> ---
>>
>>
>> Not tested...
> 
> I was only able to verify and test the conformity of the ST chip
> st33ktpm2xi2c with kernel 6.1, so I left out the test-by tag.

I don't mean your tag. Your SoB means you tested it, but I meant you did
not send the binding for testing via automation.

> Unfortunately, there is no newer kernel for my embedded hardware.
> 
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary
>> people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>> people, so fix your workflow. Tools might also fail if you work on
>> some
>> ancient tree (don't, instead use mainline), work on fork of kernel
>> (don't, instead use mainline) or you ignore some maintainers (really
>> don't). Just use b4 and everything should be fine, although remember
>> about `b4 prep --auto-to-cc` if you added new patches to the
>> patchset.
>>
>> You missed at least devicetree list (maybe more), so this won't be
>> tested by automated tooling.
> 
> I called the script scripts/get_maintainer.pl on the latest kernel
> version for each of the two patches and added the output list to the
> individual patches accordingly. And only for the cover-letter I linked
> the two lists together.
> I understand now that I should have sent the whole series to both
> lists.
> 

No, that's not the case. You did not Cc output of get_maintainer.pl.
Read *AGAIN* my message..

Best regards,
Krzysztof


