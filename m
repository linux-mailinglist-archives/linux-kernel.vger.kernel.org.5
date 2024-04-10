Return-Path: <linux-kernel+bounces-138975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913A989FCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39161C21062
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771F17B4E5;
	Wed, 10 Apr 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0YV2VQv"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57015ADBF;
	Wed, 10 Apr 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766573; cv=none; b=UgiV6Q+OqbSoRH/51GAeU7YM+CdmnR6PXt5AwmwAOQ46K6COXUe7JUUIACXV7pqX9J9+3H13AaPISupoD145OZ+4xAYqnzprLVA00dqDHqvYP1dDeBMj8sAO9DYDOWtd7+QLG3f9U6O8mCphcZtRSagHVt6XP4hJyPBaPKXhhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766573; c=relaxed/simple;
	bh=zU6EoLzA9ND2k2GwUtAWWPZWYMcRfLKo9XZgSUcivHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4t7ZXW3b1IpOT3telTWehf412+quM0R1YSAQYsz2cetsaqR3N8b3GtYfsNeBn8s0ZxDVVb9+6o9ynzYtdxTgi8yhWJy/SAU5PUFYWKp9KnyRC7VFaEPUYVmIg4bP3yVDvwMNoL1jm2C78tUbjUc/J21cP0AuZMghVk0Jeg7AMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0YV2VQv; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa27dba8a1so2338538eaf.0;
        Wed, 10 Apr 2024 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712766570; x=1713371370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgDPsrKG9EevuxlKOblcDWf11bMcM6CUXzFHUYOd2k4=;
        b=V0YV2VQva3tKYUy4AEf7ExRmnngGm1iOHy5x1u3ngPUOZmgD3O/AmUWrx2sohLGWj4
         +eLFch9YILtCKE65B8OOd+bvyHb/1+/FcuJ3zigPZ5wvtnpacUdZ+L6sJ+Rq6PYg4plZ
         e7Rj5BW+ClDH/C7mqgkcAb5gO+Uwc6wpd1UaBU1AyH3lYBRkgQjfvF9u3/s4E72HgxCa
         KJ2Dw/heuDdb7CNnGoiF103QNk7HZjVpIdCQzlqPsMRpP6pmJA7Bmx7vQVrdiCYjtJIh
         xxMeKsAcjLd+QKYTIy4T5FEO400fvu35rcgNrfTl+k4bg747mRc9anqxpeVxgQEQ6qTu
         /Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766570; x=1713371370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgDPsrKG9EevuxlKOblcDWf11bMcM6CUXzFHUYOd2k4=;
        b=niOhtBZBgwfjrCW4/2A3TU2XpcMn1cvrvmwnEnLUOm1k/zXvhHJfVRy9yE8W00Kmew
         p1t7SRq1w9l2ypC2ZTaf/GKVIVlUXJjjW+fvcYjJwXSOmVo0VtRQ5fIJ8pV7Jf6D0UA/
         94jVXI3OrTnpEGihsb/btiv6COj4FTKHD2PRvbACUHy1ZMCdEuADuPLRjg/A8DKm+oCX
         BrZuCLfKReTYeF5GmA9vyM4ghsp6KSnHhLthTISx7+YOKyJ0j9tjygKrvc7/OkU24dZk
         jbif84nNlI99OCUjES6vmNpYcT725/BYIczRKG/Q2eIKDlWhESPn/GkR9Sxe2cjK3DFp
         EeAg==
X-Forwarded-Encrypted: i=1; AJvYcCVKaYcKh2zSMZGhS5A7V9cKfm25pvPDW/X7gTLjaP+E1xtuKI0rEZnH6qaOD+Rq/3fQF3jePTObjqh9veUv57qxxI4j51NvEk8NP2DGeSP3HAW6IyJqUOjFqcBXLC7LLgBDzGFHHA97vg==
X-Gm-Message-State: AOJu0YxsbM3TjLkffTeoCBQU3uOhjpjgTlnH4eSJ2YUxya26SiuN0VJ9
	CUi/Eo0IV+QgpihDeoT061Ps9Dtp3SdaGDZx7KRCGhFc88GK+FD9
X-Google-Smtp-Source: AGHT+IEPlZrsmJWFrIAvb9AUpyItAnZ4CMRc+H3s1py7MlHCUYPp89XFxN37H1gOS3LY7OpU6Ftj8g==
X-Received: by 2002:a05:6820:308d:b0:5a5:16e1:beb3 with SMTP id eu13-20020a056820308d00b005a516e1beb3mr3617702oob.0.1712766569914;
        Wed, 10 Apr 2024 09:29:29 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id v12-20020a4a8c4c000000b005a46c933653sm2480792ooj.1.2024.04.10.09.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:29:29 -0700 (PDT)
Message-ID: <d827ec3c-84fd-9352-b321-79bdc4bdcd40@gmail.com>
Date: Wed, 10 Apr 2024 11:29:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-6-mr.nuke.me@gmail.com>
 <019180df-67b9-438b-a10d-f92fd4ddec03@linaro.org>
 <33461c22-21a3-023b-4750-c69304471ea8@gmail.com>
 <2379377e-ca1c-453f-bb74-186ab738ce39@linaro.org>
 <a23adb9c-6377-467b-ac3c-0ec51fc97253@linaro.org>
From: mr.nuke.me@gmail.com
In-Reply-To: <a23adb9c-6377-467b-ac3c-0ec51fc97253@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 02:02, Krzysztof Kozlowski wrote:
> On 10/04/2024 08:59, Krzysztof Kozlowski wrote:
>> On 09/04/2024 22:19, mr.nuke.me@gmail.com wrote:
>>>>
>>>>
>>>>>    
>>>>>      clock-names:
>>>>>        items:
>>>>>          - const: aux
>>>>>          - const: cfg_ahb
>>>>>          - const: pipe
>>>>> +      - const: anoc
>>>>> +      - const: snoc
>>>>
>>>> OK, you did not test it. Neither this, nor DTS. I stop review, please
>>>> test first.
>>>
>>> I ran both `checkpatch.pl` and `make dt_binding_check`. What in this
>>> patch makes you say I "did not test it", and what test or tests did I miss?
>>>
>>
>> ... and no, you did not. If you tested, you would easily see error:
>> 	clock-names: ['aux', 'cfg_ahb', 'pipe'] is too short
>>
>> When you receive comment from reviewer, please investigate thoroughly
>> what could get wrong. Don't answer just to get rid of reviewer. It's
>> fine to make mistakes, but if reviewer points to issue and you
>> immediately respond "no issue", that's waste of my time.
> 
> To clarify: "no issue" response is waste of my time. If you responded
> "oh, I see the error, but I don't know how to fix it", it would be ok, I
> can clarify and help in this.

I apologize if I gave you this impression. I tried to follow the testing 
process, it did not turn out as expected. Obviously, I missed something. 
I tried to ask what I missed, and in order for that question to make 
sense, I need to describe what I tried.

It turns out what I missed was "make check_dtbs". I only found that out 
after an automated email from Rob describing some troubleshooting steps.

If I may have a few sentences to rant, I see the dt-schema as a hurdle 
to making an otherwise useful change. I am told I can ask for help when 
I get stuck, yet I manage to insult the maintainer by aking for help. I 
find this very intimidating.

Alex

