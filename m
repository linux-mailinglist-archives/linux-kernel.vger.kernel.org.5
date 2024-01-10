Return-Path: <linux-kernel+bounces-22742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5B82A264
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E971F22A63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07724EB35;
	Wed, 10 Jan 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWDOoiej"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418B4F616
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccec119587so54997801fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704919010; x=1705523810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vF5tupcUeWkTYyiJxCJd6V7g3X/1lq74f/KLJG4DSME=;
        b=RWDOoiejsAFcdf8v1ZYntNf1rd6XfTEBytbDRiC6MfM3OcatmvV2LIv2plTkzTTU7b
         axYxjFbUiVO+8NqDpN4FovfmHaE8C+yl8VjXbNJaAUzSevEhcvCf18Ql1seBvZezKsca
         whCxd1opn0mVa0RtBCnf3MLPlcR7x5a5aPQOywq54AiB5q+VRDn+GtKScKu3XJJmJSRa
         nxrvYo5PMuqwrJu8CVz0Ft5ZradpN/rCm6ICaU/n7vQ/nJeS02LXSwZZ9I1U3jeadqZD
         Kn+pXJ01APUuEwi4y5lVv+3kUeAtddclSrYupbYDSYwHRqf69wcIFd+wHTAUuJ0jQteM
         0/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704919010; x=1705523810;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vF5tupcUeWkTYyiJxCJd6V7g3X/1lq74f/KLJG4DSME=;
        b=nfgId+SaSDMseik5+m4HSnLhiQCpfvS8Oudx/8o18FzUdPyMiuCmL/kA3CG3mwcfzm
         b//opl9HG3BX7pn8nhqbhdU5VBnf7MibhZspHWjOzyObnB9QF0/J7SM7N1ja/8e3O+h0
         D7zpDl8YQ2bz2HFpDB5VNTI8pbs9hQU7zlQljiZFwWBWVupx9C8CeZdO8LE1C2nTL1cF
         13sDwNOmWUtQccx/La8BsC4Ts5tjkO3wvXZgjTvFhvGYZbKnafs1m1nfU7m12iko490p
         jtNEVk3bnF49Q/Ust8BmSseRZLOC+g+bzQqeBwJvVeta7ofZIHmXfot0NouekXfUjlSy
         3dnA==
X-Gm-Message-State: AOJu0YzFPquH9u9pmLE3vYNg2eLg2HgT3yLilemEW2MYoIxcMq6Ga6d8
	lW/G8rIo/iAr8+kH8eM8dMJQbb8VRj068Q==
X-Google-Smtp-Source: AGHT+IF5zSjWoDPn7CNER2fBW1ddHR+9FT1AiH7W996NoEg1yiOxXBFr3ZSsVpapQPPyOnMTjKVqGA==
X-Received: by 2002:a2e:8205:0:b0:2cd:690d:5d37 with SMTP id w5-20020a2e8205000000b002cd690d5d37mr76802ljg.29.1704919009786;
        Wed, 10 Jan 2024 12:36:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d391000000b00556cf695da0sm2310685edq.78.2024.01.10.12.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:36:48 -0800 (PST)
Message-ID: <eef0aa5a-a9bb-43e4-9066-febf48fce46d@linaro.org>
Date: Wed, 10 Jan 2024 21:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>, Ninad Palsule <ninad@linux.ibm.com>,
 Conor Dooley <conor@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
 tony.luck@intel.com, gpiccoli@igalia.com, johannes.holland@infineon.com,
 broonie@kernel.org, patrick.rudolph@9elements.com, vincent@vtremblay.dev,
 peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
 naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
 festevam@denx.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-hardening@vger.kernel.org, geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
 <20240109-pep-coerce-2a86ae88753d@spud>
 <01974929-dfbf-4989-ba39-369e521827d0@linux.ibm.com>
 <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
 <2dd37d2b-28da-4e73-9047-61ec5d64bdb5@linux.ibm.com>
 <edbefdfd-eb59-4d86-ad07-feb066a21082@linaro.org>
 <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>
 <d56b1e3e-72c4-427f-937d-8c8146bf5b28@linaro.org>
 <3830c26d-96be-4084-a04d-8edb9ccbab5e@roeck-us.net>
 <32d46b64-d4a5-437a-8737-c2d172608559@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <32d46b64-d4a5-437a-8737-c2d172608559@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 21:34, Krzysztof Kozlowski wrote:
>>>>>>>>>> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad@linux.ibm.com/
>>>>>>>>> Why did you do that? It now just adds undocumented compatibles to the
>>>>>>>>> driver. Please, as Rob requested, work with Lukas on his series to make
>>>>>>>>> sure that these devices are documented.
>>>>>>>> I think krzysztof kozlowski suggested to send these patches separately:
>>>>>>>> https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org/
>>>>>>>>
>>>>>>>> Did I misunderstood it? Do you guys want me to include that commit again?
>>>>>>> My comment was in DTS thread under specific DTS patch. How did you
>>>>>>> figure out it applies to driver and bindings? This does not make sense.
>>>>>> Sorry for the misunderstanding. Where do you want me to add driver
>>>>>> patch? Before all DTS patches or after all DTS patches?
>>>>> Does not matter, why do you insist on combining them with DTS? Drivers
>>>>> and bindings are going together. DTS better separate, although depending
>>>>> on the case can be together.
>>>>>
>>>> I have combined DTS and Driver because DTS was using compatibility
>>>> string which is not upstream yet hence I thought it is logical to send
>>>> it under same patchset.
>>>
>>> Sometimes yes, sometimes not. DTS must not go via driver subsystem, so
>>> sending it in the same patchset has implications on maintainers applying
>>> it. Some like it, some don't and you will be nagged for combining them.
>>>
>>
>> "DTS must not go via driver subsystem"
>>
>> I always thought the guideline was to submit separate _patches_ for dts
>> and driver changes, but as part of a single series. I didn't know that
>> there is a rule to submit separate patch _series_. I also didn't know
>> (and as far as I know no one called me on it) that I am not supposed
>> to _apply_ dts changes. So far, I typically applied dts changes together
>> with driver patches after receiving an Acked-by: or Reviewed-by:
>> from a devicetree maintainer.
> 
> I did not notice you applying them, but such guideline - DTS must go via
> respective SoC tree - was always repeated by me and SoC maintainers.
> Just like gazillion other things probably was not documented... or even
> if it was documented, it would be so deep among hundreds of other rules
> nobody would find it. :)
> 
>>
>> This exchange suggests that I did it all wrong. Should I reject devicetree
>> patches submitted as part of a driver patch series going forward ?
> 
> I propose: just ignore them. The SoC maintainer will pick them up.
> 
>> Should I not apply dts patches submitted as part of a patch series ?
> 
> No, please do not apply them.

Eh, English can be confusing. Let's make it easier to grasp:
"Please do not apply DTS patches to a driver subsystem."

Best regards,
Krzysztof


