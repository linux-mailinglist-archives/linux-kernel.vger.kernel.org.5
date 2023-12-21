Return-Path: <linux-kernel+bounces-7746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC981AC8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC21283B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6571FA0;
	Thu, 21 Dec 2023 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJdJxtyl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709E5239;
	Thu, 21 Dec 2023 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d03f03cda9so1025585ad.0;
        Wed, 20 Dec 2023 18:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703124858; x=1703729658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WL++AB9fEIg1cmTcH4bF69I0i+DU0llPfZn2l0Zd/Hg=;
        b=CJdJxtylFdG3wbewoQG+3LqW9frrHZE0w94JMaNb70KbkwKSVXV4v5rVLk44p4GtB2
         W2+7IfjxobIERVDzFOGOUojArLxwjZ67OtssYJzpg/KXPSsWakGsO7dFrOXrFn8FU7n4
         Nkrt4cgwBpQRh4RLxjJM9dQrOsRyOUPQRvxAkHzHWeuzFkNVW5MghjaPwzTvztWF7WPv
         yS0+FDwqfY7Pqv+2zPpFBYYX+fgKPUyYbPzDdr+hQZKow+6rlJ1Z6uVOTCKzC0u8CMDA
         n5DDBGXru1MUykM0Ugt8bGPLgt7jMpExhKFJCjOTD6v6V4N2AWdm0I57dD6fitxkHjd9
         kF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703124858; x=1703729658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL++AB9fEIg1cmTcH4bF69I0i+DU0llPfZn2l0Zd/Hg=;
        b=IWjhl1gDSTBBSxvrPV/KNgNLCalzUQrOhiwu4YbIOAhLt53Cwn0pKSYcVSQi+iI/tD
         /qvuVct+1jnWE9v57baJWypYkGAdZaWKdiXKZSR/+8v4a9aN5F5cZB/RD05y27GQ7m/T
         SouHfj73zN9RPLjsa+SNSUCLlUbADfEUTSfABTbYXVYOQEyXpcSWpB4tm/LjdDgIKwYw
         420YGjZn9aPmisFGcJ88B8VSaS8tNTkf+3R4ekt6uMgbRg0rpTs8/vXc3ReqIfg89xN0
         LJTQTn9KDOdkwfQfO7f9VWr3BiAUIh7NTBbIya6k0mdgaRWA9kJQTyl2ZuFKIfNub/u0
         fZoQ==
X-Gm-Message-State: AOJu0YzNFXi7XX1WQ2MPDzu/D1WNl8/7ukUysPUP/KzKWK2SX73QkVLB
	rZH/Qjfjbk5E4g03XoUf1xE=
X-Google-Smtp-Source: AGHT+IGwFP91a18RpuxtpHPd7L2kZvYwl+quhbkCGdcqcS1J4Q94aNm2kW9YRAmUNgaF3AZtl0Ma8g==
X-Received: by 2002:a17:902:d2cb:b0:1d3:99c9:5454 with SMTP id n11-20020a170902d2cb00b001d399c95454mr17688921plc.4.1703124857671;
        Wed, 20 Dec 2023 18:14:17 -0800 (PST)
Received: from [127.0.0.1] (061239074230.ctinets.com. [61.239.74.230])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902bc4900b001d3aafd228dsm397249plz.75.2023.12.20.18.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 18:14:17 -0800 (PST)
Message-ID: <a2634a6e-6630-4db7-8b66-81b315038f9e@gmail.com>
Date: Thu, 21 Dec 2023 10:14:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: em_text: fix possible memory leak in
 em_text_destroy()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tgraf@suug.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220030838.11751-1-hbh25y@gmail.com>
 <CAM0EoMnPgKFK5uyx5YJUYc1F7U0058aYOQb6H6ewcz9Y8OouAw@mail.gmail.com>
 <CAM0EoM=4ZRteGbjAdBuLGtbM_qpnJoUuky-Yj+i+3FOqXXra+Q@mail.gmail.com>
Content-Language: en-US
From: Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <CAM0EoM=4ZRteGbjAdBuLGtbM_qpnJoUuky-Yj+i+3FOqXXra+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 00:05, Jamal Hadi Salim wrote:
> On Wed, Dec 20, 2023 at 6:55 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> Hi Hangyu,
>> While the fix looks correct - can you please describe how you came
>> across this issue? Was it a tool or by inspection? Do you have a text
>> case that triggered something etc, etc.

I discovered this accidentally when I used gdb to debug a program that 
uses em_text. And I think putting the code in the commit log will will 
make it too bulky.

>>
>> On Tue, Dec 19, 2023 at 10:09 PM Hangyu Hua <hbh25y@gmail.com> wrote:
>>>
>>> m->data needs to be freed when em_text_destroy is called.
>>>
>>> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>> ---
>>>   net/sched/em_text.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
>>> index 6f3c1fb2fb44..b9d5d4dca2c9 100644
>>> --- a/net/sched/em_text.c
>>> +++ b/net/sched/em_text.c
>>> @@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *data, int len,
>>>
>>>   static void em_text_destroy(struct tcf_ematch *m)
>>>   {
>>> -       if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
>>> +       if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
>>>                  textsearch_destroy(EM_TEXT_PRIV(m)->config);
>>> +               kfree(m->data);
>>> +       }
>>>   }
>>>
>>
> 
> the bot just complained about needing a cast, use this:
> struct text_match *

I see. I will send a v2 later.

Thanks,
Hangyu

> 
> cheers,
> jamal
>> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>> cheers,
>> jamal
>>
>>>   static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>>> --
>>> 2.34.1
>>>

