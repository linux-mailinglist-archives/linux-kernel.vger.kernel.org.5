Return-Path: <linux-kernel+bounces-122417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B788F709
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04C71F25018
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336F405FC;
	Thu, 28 Mar 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAqHRhnZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF43418026;
	Thu, 28 Mar 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602919; cv=none; b=GYG2gkotPT7EhY8sS5Tvc71ygcc6aqXwnNkkWJVX5+HvXnhUMlln5XwBpzJGL3yyACYSzWS78Oc6mZNwGefVjlHNZzSkOUDJ5bg8QwyckWoxKn2Or+gVVSqfD65pUy/ABz30JmF5nmKmnp+7egTYpf08R1vMbrInIGnKQ58riZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602919; c=relaxed/simple;
	bh=SDm1WUJOozAhagrXoYdXg9RSn/CTnbRjqTHIIL8O57I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXQLjN4rzZx2pz5LHupLr+VQx+1W7IXaeTqJfd3+qo/tLBQXwvsIoq8JzgGb8YG7mbw8CYEmCKlIuPE2ymm544+zgwbupFzNs+heHQ2PkfUJWKXArZUIpX50SLiMdYIjaj5cY9TRQGdzWzPShTQlEVjIqQOwREn/VyZQNPpLCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAqHRhnZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so6577001fa.0;
        Wed, 27 Mar 2024 22:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711602916; x=1712207716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWrmw61dLt1m0KvK8rpCl4hVDCE+Bi3t+dQ5mux0DuE=;
        b=dAqHRhnZ+WJTLFtXNhEaCu6EmESM+JDbmusW2M/iY2kKqdsQOKv4nnIxqYKs8X+6Zl
         pJVqqMd6aouSrfhQ8PfdKk/FTbaYH2dWdY5DkGDVcSUGp3q8UTXdLYsYXy136saUqKU9
         glQ13pAU588SsIS51S7pC0unWe7t/BKYPFW1nv7OEWaPg/MmqBIxyg4PwFGjw9TlSo7s
         G77IhaPVe2+8Ty6jDPf+xA9uDe4Ncv0oNjNG3igGLjx6VI0xxfR0DvvlYMi6WtwBO4wl
         /8mF8RfDTBkh6sLHpyA/GiT7W5YRTb1ik6RC1CzWXVsEJCbf9GkZg5eJF3hO9hCIQo/w
         X7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711602916; x=1712207716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWrmw61dLt1m0KvK8rpCl4hVDCE+Bi3t+dQ5mux0DuE=;
        b=ipZecEIlmpMAVd01EwG+mPW5n98khsI/j9loM+xlk6zPzD883YBsIcUMDHh4bWFhXZ
         HQsc+V7aYB/biqyLhwMwtZ0ICKNf7FdQzbmmfnbgiWXerhUGGrsuUVoJ8uK2WRh9TCNG
         DRL2HwJaiIF1f82BsDVrfx0u2gUPtOBPf49fb2p5tSKf9TzTpvj+DnB+OyfG5hMdtmy4
         pfOW+uRhLs7WNT6IgWB1p1fgtgSWW7VfVfLskTnqFheUx2NLnEvJZr0UgdrJDGJIXKtI
         VWZ0B5putwv1AIgB6Mu4EF556QAPVzyfoxCdE5cHoP9966vNh2cbzMNpmrZ5SJ80R9se
         7oYw==
X-Forwarded-Encrypted: i=1; AJvYcCXANovr7T/4vubmureK0vefkDDrQ7/aLxfksNx8TJKHS/eu+cusdpyeIyFBpRnOAvgU+e5U/asroRm8T9YEKr0RvI8AssQvBMvQMzckGJdeZDwPu0vOaRYgTDFEcrJcr2Aq9T5qbSKYOw==
X-Gm-Message-State: AOJu0Yx6EHdU1FTQErGogNgtnepP0UvdyiDOMbfUdtgkjC2FPWjePWpO
	6rA6/hgdosprBqV99iAIXGbDw6y9Z9aAAnlibO8lGCvuZtKESsti
X-Google-Smtp-Source: AGHT+IEFH/Jy5ULJDduNo75nbO6sOQ5MrFRQJ7zmT79iZdRCBF1lus9zpFK9O2+292nH1b8gY9DTbA==
X-Received: by 2002:a2e:3615:0:b0:2d6:c94d:94c2 with SMTP id d21-20020a2e3615000000b002d6c94d94c2mr1427438lja.46.1711602915799;
        Wed, 27 Mar 2024 22:15:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::6? (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id p18-20020a2eb992000000b002d0f0f5e395sm99427ljp.47.2024.03.27.22.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 22:15:15 -0700 (PDT)
Message-ID: <dec94ef3-5c5f-4b7f-baba-f76ac36b9627@gmail.com>
Date: Thu, 28 Mar 2024 07:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mfd: rohm-bd71828: Add power off functionality
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326192258.298143-1-andreas@kemnade.info>
 <20240326192258.298143-3-andreas@kemnade.info>
 <815e1cdc-145e-4880-96a0-d9c21308b9b3@gmail.com>
 <20240327140451.65ff8e18@aktux>
 <c6f5a515-61a1-4d87-a029-4000fa96f10e@gmail.com>
 <20240327230252.0535e895@aktux>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240327230252.0535e895@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Morning Andreas,

On 3/28/24 00:02, Andreas Kemnade wrote:
> Hi Matti,
> 
> On Wed, 27 Mar 2024 16:11:36 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 3/27/24 15:04, Andreas Kemnade wrote:
>>> Hi,
>>>
>>> On Wed, 27 Mar 2024 09:32:29 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> It's worth noting that there is another PMIC, BD71879, which, from the
>>>> driver software point of view, should be (almost?) identical to the
>>>> BD71828. I believe the BD71828 drivers should work with it as well - if
>>>> not out of the box, at least with very minor modifications.
>>>> Unfortunately I don't know products where the BD71879 is used or if it
>>>> is sold via distributors - so I don't know if adding a DT
>>>> compatible/chip type define for it would be beneficial.
>>>
>>> yes, you already told we thet the BD71828 drivers are compatible with
>>> the BD71879 and I am using the latter.
>>> But that at least should be commented somewhere, so that
>>> people do not raise questions, like: Do I have some strange board revision,
>>> etc?
>>> The most terse form to comment it is a separate dt compatible so we are
>>> prepare any "almost identical" surprises.
>>
>> I agree. Reason why I haven't done this already is that I don't always
>> (like in this case) know which of the variant are eventually sold. So,
>> it's balancing dance between adding compatibles for ICs that will never
>> been seen by large audience, and missing compatibles for some of the
>> variants.
>>
>> This is also why I was interested in knowing which variant you had, and
>> where was it used.
>>
> I have found it in the Kobo Clara 2E ebook reader.
> Kobo seems to switch from RC5T619 to BD71879.
> The Kobo Nia rev C also has that one.
> Kobo Libra 2 has several hardware revs out in the wild, some of them
> with the BD71879.

Thanks for the info :) It's a shame we so rarely know where things we 
work for are used. I always find news like this interesting.

>> But yes, I think that as the BD71879 has obviously been found by a
>> community linux kernel user - it would make sense to add a compatible
>> for it!
>>
>> Do you feel like adding the compatible 'rohm,bd71879' in
>> rohm,bd71828-pmic.yaml as part of this series(?)
> 
> Do we want a separate chip_type now? Or do we want to add it later if
> we ever see a difference. My personal opinion is to wait until there is
> really a need.

Using the BD71828 chip_id for BD71879 in the MFD driver is fine to me. A 
comment saying they seem "functionally equivalent" can be added to 
explain this choice.

> If we do not need it, then it is a different series I think but sure
> I will produce such a patch.

Great, thanks! I think it's clearer to have it as own patch, but I think 
it fits in the same series - what suits you best. (Don't know if Lee or 
DT peeps have different opinion.)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


