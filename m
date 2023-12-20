Return-Path: <linux-kernel+bounces-7176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9581A2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5A2B2506A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C840BF7;
	Wed, 20 Dec 2023 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6lTqOUg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF640BE4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703086537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9JJWc/0Dt3mRK8kgHQBJVv4Q0WmbTy5cvSBXBAUh/Q=;
	b=g6lTqOUgla2vSRxpcUDRXRVY+0UKaPKzbOEwwbQPX0oWcC7FiQTD4+aJmh3Tt29uGWcdZg
	yWN/BvVdRYluCncGou2M/q0iJfnCTTYAdJDoNNxiKloghSPz5UQYKVK1CgRo9asX9eHE0w
	zbD6Qb8f44keLpFsSt8kYrwvpho8bas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-LkKRqU8tNJ66hNcZhYMJcQ-1; Wed, 20 Dec 2023 10:35:34 -0500
X-MC-Unique: LkKRqU8tNJ66hNcZhYMJcQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c3cea4c19so48230635e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086533; x=1703691333;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9JJWc/0Dt3mRK8kgHQBJVv4Q0WmbTy5cvSBXBAUh/Q=;
        b=ac5LXA8xY1DZdbSssqhxjb0a3aFz6nKgGIAO29iFf2pFP6R+ewnj0RMlJZLEm/iaYU
         hgnU+Ctk4GPNtPFo5jE7aySnZMWfwCQ4uQVhEB/9c4PSWG54hc2LeddlN178i06vTbuc
         JbvVymm0QLVFiMbA3Ar4jLATDrbxxcMxcGez/ii0N74wNaCqx+8EHtZttHFCAHO7Z9qO
         TSRSMu0ODqVT2jOqcxrCLQN1jPBDRDIY702YPksY+3L3Qf4Hhy/+E0TNXP/jQJc6wAhJ
         UK3tOnmbDAJ0xgVA+NnnekQO3tliYO27VY780SlmGIcBUxrlwNCUlhijA30uuQ2Xn/81
         JApA==
X-Gm-Message-State: AOJu0YyEqKdzqL4f+IpvsReYbs3WWiFIL66q2yXZM2jKZOIoQ9cSSnRC
	Eh1J3E++nEcnUwuUBkHP8Ud4scIz4qgaEKgE81IeE+bZz9pXyqzMr5Phd6KrIQBfDucYoDpBpWW
	Gm0ldW7+giVEtOneO4n7b2w43
X-Received: by 2002:a05:600c:204f:b0:40c:32f2:2c18 with SMTP id p15-20020a05600c204f00b0040c32f22c18mr9257680wmg.143.1703086533212;
        Wed, 20 Dec 2023 07:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb/3gssiXAASAQzIz6NDOhyX/A6RgWeFW9MnMvdxhI05Dm3VZI6wO6/dsB4CxhSwDB5WmOqw==
X-Received: by 2002:a05:600c:204f:b0:40c:32f2:2c18 with SMTP id p15-20020a05600c204f00b0040c32f22c18mr9257645wmg.143.1703086532782;
        Wed, 20 Dec 2023 07:35:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:eb00:8e25:6953:927:1802? (p200300cbc73beb008e25695309271802.dip0.t-ipconnect.de. [2003:cb:c73b:eb00:8e25:6953:927:1802])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05600c1e0e00b0040c6ab53cd2sm17372wmb.10.2023.12.20.07.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 07:35:32 -0800 (PST)
Message-ID: <cfd88172-1624-4966-92c6-5197b26a820b@redhat.com>
Date: Wed, 20 Dec 2023 16:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <dd227e51-c4b2-420b-a92a-65da85ab4018@arm.com>
 <7c0236ad-01f3-437f-8b04-125d69e90dc0@redhat.com>
 <9a58b1a2-2c13-4fa0-8ffa-2b3d9655f1b6@arm.com>
 <28968568-f920-47ac-b6fd-87528ffd8f77@redhat.com>
 <10b0b562-c1c0-4a66-9aeb-a6bff5c218f6@arm.com>
 <8f8023cb-3c31-4ead-a9e6-03a10e9490c6@redhat.com>
 <da16a7e5-76dd-4150-9ade-54b0d227a1e1@arm.com>
 <699cb1db-51eb-460e-9ceb-1ce08ca03050@redhat.com>
 <da29a4c6-61f6-4203-9c82-9ce6e1c32552@arm.com>
 <2a8c5b6c-f5ae-43b2-99aa-6d10e79b76e1@redhat.com>
 <ade26f27-03af-4ad7-ad81-38b482f7572c@arm.com>
 <3194b8a5-3f72-4d9e-a267-fbdad32ad864@redhat.com>
 <f2f420cf-678d-466d-ac30-bc8251f16632@arm.com>
 <9f99a3ca-051e-4b1b-81e9-8456d8e422ad@redhat.com>
 <c1913fa2-d313-4f05-a649-da69b6d31d2a@arm.com>
 <c244707c-8c0c-4593-ab45-d8f165dbc5ee@redhat.com>
 <ba6a5c11-34fb-40ca-b24a-f51a207464f2@arm.com>
 <5fcbf405-7e62-4b38-acc4-a9dd8cc91214@redhat.com>
 <396cae5d-70e4-449f-af6c-2348b720d3a3@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <396cae5d-70e4-449f-af6c-2348b720d3a3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.12.23 16:05, Ryan Roberts wrote:
> On 20/12/2023 14:00, David Hildenbrand wrote:
>> [...]
>>
>>>>>
>>>>
>>>> gcc version 13.2.1 20231011 (Red Hat 13.2.1-4) (GCC)
>>>>
>>>>   From Fedora 38. So "a bit" newer :P
>>>>
>>>
>>> I'll retry with newer toolchain.
>>>
>>> FWIW, with the code fix and the original compiler:
>>>
>>> Fork, order-0, Apple M2:
>>> | kernel                |   mean_rel |   std_rel |
>>> |:----------------------|-----------:|----------:|
>>> | mm-unstable           |       0.0% |      0.8% |
>>> | hugetlb-rmap-cleanups |       1.3% |      2.0% |
>>> | fork-batching         |       4.3% |      1.0% |
>>>
>>> Fork, order-9, Apple M2:
>>> | kernel                |   mean_rel |   std_rel |
>>> |:----------------------|-----------:|----------:|
>>> | mm-unstable           |       0.0% |      0.8% |
>>> | hugetlb-rmap-cleanups |       0.9% |      0.9% |
>>> | fork-batching         |     -37.3% |      1.0% |
>>>
>>> Fork, order-0, Ampere Altra:
>>> | kernel                |   mean_rel |   std_rel |
>>> |:----------------------|-----------:|----------:|
>>> | mm-unstable           |       0.0% |      0.7% |
>>> | hugetlb-rmap-cleanups |       3.2% |      0.7% |
>>> | fork-batching         |       5.5% |      1.1% |
>>>
>>> Fork, order-9, Ampere Altra:
>>> | kernel                |   mean_rel |   std_rel |
>>> |:----------------------|-----------:|----------:|
>>> | mm-unstable           |       0.0% |      0.1% |
>>> | hugetlb-rmap-cleanups |       0.5% |      0.1% |
>>> | fork-batching         |     -10.4% |      0.1% |
>>>
>>
>> I just gave it another quick benchmark run on that Intel system.
>>
>> hugetlb-rmap-cleanups -> fork-batching
>>
>> order-0: 0.014114 -> 0.013848
>>
>> -1.9%
>>
>> order-9: 0.014262 -> 0.009410
>>
>> -34%
>>
>> Note that I disable SMT and turbo, and pin the test to one CPU, to make the
>> results as stable as possible. My kernel config has anything related to
>> debugging disabled.
>>
> 
> And with gcc 13.2 on arm64:
> 
> Fork, order-0, Apple M2 VM:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      1.5% |
> | hugetlb-rmap-cleanups |      -3.3% |      1.1% |
> | fork-batching         |      -3.6% |      1.4% |
> 
> Fork, order-9, Apple M2 VM:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      1.8% |
> | hugetlb-rmap-cleanups |      -5.8% |      1.3% |
> | fork-batching         |     -38.1% |      2.3% |
> 
> Fork, order-0, Ampere Altra:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      1.3% |
> | hugetlb-rmap-cleanups |      -0.1% |      0.4% |
> | fork-batching         |      -0.4% |      0.5% |
> 
> Fork, order-9, Ampere Altra:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      0.1% |
> | hugetlb-rmap-cleanups |      -0.1% |      0.1% |
> | fork-batching         |     -13.9% |      0.1% |
> 
> 
> So all looking good. Compiler was the issue. Sorry for the noise.

No need to be sorry, good that we figured out what's going wrong here.

Weird that the compiler makes such a difference here.

> 
> So please go ahead with you rmap v2 stuff, and I'll wait for you to post the
> fork and zap batching patches properly, then rebase my arm64 contpte stuff on
> top and remeasure everything.

Yes, will get rmap v2 out soon, then start working on fork, and then try 
tackling zap. I have some holiday coming up, so it might take some time 
-- but there is plenty of time left.

-- 
Cheers,

David / dhildenb


