Return-Path: <linux-kernel+bounces-22828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAE82A37C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E281F23B34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218C4F883;
	Wed, 10 Jan 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz/HacDN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D82AE69;
	Wed, 10 Jan 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3ed1ca402so42090065ad.2;
        Wed, 10 Jan 2024 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704922909; x=1705527709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HId8f3hkvGtnDismZhBcVXhWd29HmilwtOOYjG3JP0w=;
        b=Kz/HacDNbt/0Q6FD3hgLYDM22yMP5h0bcCn8b12Ebr9YMjn2ZvxtsXJFvz5ocUVc4Q
         sSwWln1I2SAL/D7kue/ad3AtE6EJ3bdvLYddOXoR8UYKBkPIuhc1kb/ww+od/mvo0am0
         qi3HxJO+D8/gBvQK768A3jCAlliuTGgxIy7FaZFNNSdsGOfD8VbhGDJ1Gjui/hvLiECa
         8rY4QbtFeJbnP4JVvPiWtviGMPouLNpMMBxeExPeJtSrSlnthqwK/ar26rbh8jKERiV0
         /DNPhPHdBBM0+bK5UOipcaGbzg03kpM9nEMV1Rad/273kZ6eT1T5eWlG1FvIWG+SDoET
         ftBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704922909; x=1705527709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HId8f3hkvGtnDismZhBcVXhWd29HmilwtOOYjG3JP0w=;
        b=jnX39YKR5RQhph7yTuXE9Ke++ID3VQMk3JjxyiuCMqRjN1tc+s09L1YAuaZdBF0cFp
         cieSXAvWlMGzP7wWeW0wqplC/GE+SXri+lr/vCI+7f9ew1ohPth4DanlWbt1kzttr3oy
         PZym7yqKReLqNgi8V9SBTxsBT5k2DHTtcPXcR1yFVf7QTk7gO9XAe4C+Spaka3JJgsUD
         mU0704ZVilJUlT32mzlxXdIUP1BDw1tq3nPW27R0Xm/rPE0xBYUebLHl+7KwxLtmOkUY
         ASMMumFSEZKin1jlQFTv6OenpmGngzT+3k3uo0P1TuYC+MimLibQUq6OJ5fLnA3K/Pyo
         elrg==
X-Gm-Message-State: AOJu0YwSpIoJ60i9w2zi8kZREA4A1jvqjj2dBN+hFwxICx3PF2gPKeVE
	iAxwZzalMnhQMttkm8lSl4U=
X-Google-Smtp-Source: AGHT+IEUyQyYeicmT88yj9ZQjWF+5ZnzsbxcWV9NwQBfyw8mdjrtSspcwIBzY9L+4XjDdlhnLm20WQ==
X-Received: by 2002:a17:902:f54a:b0:1d0:7535:8b94 with SMTP id h10-20020a170902f54a00b001d075358b94mr231266plf.97.1704922908844;
        Wed, 10 Jan 2024 13:41:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902789600b001cfcc10491fsm4121526pll.161.2024.01.10.13.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 13:41:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <92625821-d79d-4aba-9bef-148f154be427@roeck-us.net>
Date: Wed, 10 Jan 2024 13:41:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ninad Palsule <ninad@linux.ibm.com>, Conor Dooley <conor@kernel.org>
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
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <32d46b64-d4a5-437a-8737-c2d172608559@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/24 12:34, Krzysztof Kozlowski wrote:
> On 10/01/2024 20:06, Guenter Roeck wrote:
>> On 1/10/24 09:54, Krzysztof Kozlowski wrote:
>>> On 10/01/2024 16:54, Ninad Palsule wrote:
>>>> Hello Krzysztof,
>>>>
>>>>
>>>> On 1/10/24 09:37, Krzysztof Kozlowski wrote:
>>>>> On 10/01/2024 15:31, Ninad Palsule wrote:
>>>>>> Hello Krzysztof,
>>>>>>
>>>>>>
>>>>>>
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
> 
>> If so, it would help to have some documentation I can point to to explain
>> the rationale to submitters (and myself). Also, in that case, how is the
> 
> Yes, it would. I can try to create something.
> 
>> synchronization between device tree patches and driver patches supposed
>> to happen ?
> 
> There should not be synchronization. Just to remind: we talk about DTS
> (so also DTSI and DTSO), thus everything being in arch/*/boot/dts/. We
> do not talk about DT bindings, right? The bindings are obvious (and
> documented): preferably go via driver subsystem, with fallback/special
> cases via SoC tree and fallback to Rob.
> 

Sorry, misunderstanding on my side. I do not and never did apply patches
in arch/*/boot/dts/. I referred to patches in Documentation/devicetree/

Sorry, I though you also referred to bindings. My bad.

Guenter


