Return-Path: <linux-kernel+bounces-78265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471218610F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9785C1F25DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104E7A71E;
	Fri, 23 Feb 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FwLbV96S"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CED29B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689725; cv=none; b=rPgrekwmRRwkyEzs3m9bkwanYMIuOmHMRSDijVK5/VT2uwEftr+CNIs6nv0sUK2D7oyC52FqyMUL18hIzEz8lfUswy8TPOTMRy9Y6UKaVzWT5BYBU3OIqBWF/a8T2m9HqEp7wXZd6DeuViyb1iH0twn1Si+tvTxgxISj9Z3TZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689725; c=relaxed/simple;
	bh=5w8yqXJc/5c6eB5UuqIm9nDWMaqLako4c4bX6plPrh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVSnc82jWzo69xOKnUAtEPAMAV0EnY+yLFDb4Xwlch4zMq7K3PsvnZvsRfD+bFiuIVpGjekgu1bXRca+LcOUpmxiGlwpOKO/i9YqN5ZYHmabMG4l6pJ1a2YCqLXaIMPJr4shPUmAv6Nc1Y6ZseKBFZP3lSfiscAj3hCXN2uOWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FwLbV96S; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so911384a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708689722; x=1709294522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1OhZyNr6Hf/2Z/hs3KCLjCpawXJvz5KHcuvXVs0zfA=;
        b=FwLbV96SOYOS6zmYxL6h9OON5KVU3f18WUXSx7KpRaL7xt/3EMxsvU+cP1AHmP9CGA
         nx7MbnWzt1KzexqWa4GF6i7uZUw8vldUbP4Y+/yQzdGP8UA28vffusOOWvYyIbp/JoIy
         2BhBGpgCVWq6xqTMVQR/h1bRcacx82HbvTknWZmU9tpvTynKu5SkCjj6bOPLVrcGn1Qr
         JIpGpd3GfkS4PRty0ViggQkJY1+YW9udGEdevGCz5yqGjkitD6ud3GBn8mwwYUJ80cem
         LBJlxwuEzqlPZOCR2z/2giqZvetgEGt8/weH2y/W8cv5AJErB9hjAAtLNaheYjUKM/2M
         u0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689722; x=1709294522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1OhZyNr6Hf/2Z/hs3KCLjCpawXJvz5KHcuvXVs0zfA=;
        b=tra49nDSpaY/FiZIiXyYPV7dlpD99rk0EisjT/Njw6bHWo8ePcPDXafPIGuBzP7CsQ
         Ub7qmHY/0jBwgb3eG3hmRQ/dKdKi+svA1JxFBOXGjuG9X+GhDkdO1ZyLQd1RGKvHBMti
         e484G4mpScE9VXxA251oEvGCFpRsl++ltb9C0jPbLXB/mnZCswP1m5nJSF3XB/dd0vzA
         9nHN0FOXG4NQ0XyRFjg/WFb+I4tgERCw0dzXTHEOOKyPIhiIxvsSubsv1tktFPo1Zh4t
         qzScRW8YhD2Or6CO9L7U9JgO3/9pGdcuV7m1FI/+tY/R9DFBm8C5YTTH/ObrwCVKuoDp
         C78g==
X-Forwarded-Encrypted: i=1; AJvYcCVfzbtVuU6NKfvbmpgQDQhPbaUIYQqzHEnnD9o/5zNvpqTJpGrKoObo3C+g+4fp7Q475LkzCs3g74urBpK+/PzthyaPY4dLUEi5HTVt
X-Gm-Message-State: AOJu0YzZDUne38RrdzXGbhH5iX/mF1CKDVCc40IpJrRhIbVgR/vygVo4
	REkoNlAmjIWBi3g2ysoYgNHsBEoCUquBPVRmmSCp746An18ATby5RG0ecyD18lM=
X-Google-Smtp-Source: AGHT+IGDsOwWz62+n5suxOR58mHGxxa6NaZuXgShnJKIAkQXjGiyXC5ubvbw5g0Th2weZDGQgWPcbQ==
X-Received: by 2002:a05:6402:8ce:b0:565:8339:5758 with SMTP id d14-20020a05640208ce00b0056583395758mr333821edz.40.1708689721602;
        Fri, 23 Feb 2024 04:02:01 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id cs12-20020a0564020c4c00b00564e9746fdasm2635624edb.28.2024.02.23.04.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 04:02:01 -0800 (PST)
Message-ID: <e530d504-dfa3-4d39-b903-b2570bb8b014@suse.com>
Date: Fri, 23 Feb 2024 13:02:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Content-Language: en-US, ca-ES, es-ES
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Chester Lin <chester62515@gmail.com>, krzysztof.kozlowski+dt@linaro.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
References: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
 <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
 <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
 <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
 <bcb79af4-56d9-4204-9503-cff996f1ba41@oss.nxp.com>
 <e6f6070e-8355-4a0b-a904-1a24970f249b@linaro.org>
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <e6f6070e-8355-4a0b-a904-1a24970f249b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/02/2024 12:13, Krzysztof Kozlowski wrote:
> On 21/02/2024 18:00, Ghennadi Procopciuc wrote:
>> On 2/21/24 17:43, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 16:19, Ghennadi Procopciuc wrote:
>>>> On 2/21/24 16:45, Krzysztof Kozlowski wrote:
>>>>> On 21/02/2024 15:42, Krzysztof Kozlowski wrote:
>>>>>> On 21/02/2024 13:01, Ghennadi Procopciuc wrote:
>>>>>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>>>>
>>>>>>> Add myself as a maintainer of the NXP S32G DT files.
>>>>>>
>>>>>> No need for cover letters for single patches. OTOH, this commit msg is
>>>>>> empty...
>>>> Thank you, I can correct that.
>>>>
>>>>>> Plus your patch looks corrupted (wrong encoding): F??rber
>>>>
>>>> Indeed, it is due to 'Content-Type: text/plain; charset="us-ascii"'.
>>>> I can fix this as part of v2.
>>>>
>>>>>> BTW, did you contribute anything to the upstream Linux kernel? Do you
>>>>>> know the process? Downstream does not really matter.
>>>>>
>>>>> I found the answer:
>>>>>
>>>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>>>>>
>>>>> Does not look like. Please get some upstream work experience first.
>>>>>
>>>>> https://lore.kernel.org/all/?q=f%3Aghennadi.procopciuc%40oss.nxp.com
>>>>
>>>> Although I am new to upstream communities and may make mistakes, I am
>>>> eager to learn and improve.
>>>>
>>>> After leaving SuSe[0], the current maintainer of the NXP S32G DT files
>>>> became inactive[1]. As a result, this area is not currently being
>>>> maintained. This is the actual reason why I attempted to add myself as a
>>>> maintainer of that area. Although I acknowledge that I may not have
>>>> enough experience to become a maintainer, I am concerned that the NXP
>>>> S32G DT patch submission may be blocked for everyone due to the current
>>>> situation.
>>>
>>> I would be just happy to see first actual contributions or any sort of
>>> activity, like reviewing, before taking over something.
>>>
>>> You do not need to become maintainer to provide reviews. By reviewing
>>> patches you already reduce burden/work from the maintainers.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> I fully understand and agree with your perspective on this matter and
>> accept the fact that I will not be a maintainer as initially intended.
>> Furthermore, I am very willing to participate in any reviews related to
>> S32G SoCs.
> 
> Just give it some time...
> 
>>
>> Patches, including those I have created ([0], [1]), will likely be
>> submitted for this area. This is because each enabled driver for S32G
>> SoCs is expected to have at least one node in the device tree. These
>> patches will undergo review and receive feedback. However, the upstream
>> process will come to a halt at this point since there are no maintainers
>> to apply and integrate them.
> 
> Indeed that's a problem.
> 
>>
>> I do not know how this situation should be handled, given my lack of
>> experience in upstreaming maintenance. The documentation for the Linux
>> kernel is insufficient in providing guidance [2] on how to handle
>> inactive maintainers and it is unclear who should take over their
>> responsibilities. This is likely not the first time this has happened in
>> the kernel's history.
>>
>> Could you please guide me on how these patches should be integrated into
>> a maintainer's  tree and by whom?
> 
> Chester left Suse, so maybe this also means less interest in maintaining
> it? Stepping up in such case, so your proposal, is reasonable, so in
> general I agree and thank you for trying to do something here.
> 
> Andreas or Matthias,
> Maybe you could change your R: into M: and take s32g patches?
> 
> If not, then I will ack this patch making Ghennadi the maintainer.
> 

Normal process would be that Arnd would contact Chester to see if he is not able 
to do the maintainer work any more. In that case maybe Arnd could take over.

I agree with you that some one should get maintainer for a SoC because he is 
involved in the Linux kernel community and not because he is working on 
downstream patches for the same silicon. Especially being paid by the company 
that produces the silicon can quickly get you into dificult situation. Think for 
example that NXP, which pays you, wants something to be added in the upstream 
kernel, but the code is not in a shape to be part of Linux kernel. That can 
generate conflict and for the upstream community it is important that the only 
criteria to accept something upstream is the fact that it is in a good shape for 
that, not any comercial roadmap by a company.

I'm not saying that Ghennadi won't be able to defend this, if it ever occurs. 
Basically because I don't have a good track record of him due to missing 
upstream collaboration.

I would prefer that Arnd (or Andreas) step up to take the maintainer role. I 
already have one and it's difficult for me to find the time to do it in an 
acceptable way.

Regards,
Matthias

