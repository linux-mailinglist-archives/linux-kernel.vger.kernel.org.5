Return-Path: <linux-kernel+bounces-3807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3280817240
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B5D2808CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E33A1DC;
	Mon, 18 Dec 2023 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DD3BsfGa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96471D144
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702908288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X9xufoJq3r2B0O7H1m+byYovL1TiHBedF6yf9/U8WPw=;
	b=DD3BsfGatJH0eNnB7zRIoBRbaLxvEXUqNaN31QnFKiVFRtyFQlgqa9rqiPpwZR5jNT2+Co
	3clYrLmPwkqAG4qEBydhehmltE6zHbFc9/wIoJCr6P8Jw1kOialh7f0+rXwCNyGFSrMs3P
	NCFDeLul+91K5labKmEkeoEMsSK4Dec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-FB8ZwiPyPcGrobnPdats_Q-1; Mon, 18 Dec 2023 09:04:47 -0500
X-MC-Unique: FB8ZwiPyPcGrobnPdats_Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c299d1e36so25083685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908286; x=1703513086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9xufoJq3r2B0O7H1m+byYovL1TiHBedF6yf9/U8WPw=;
        b=ueqqhqQYd0G5WGd1F9ZQaOozgCTbA3ppx1oTO5dsus/+C7AWDnnbpOnIVjLQ9xifXS
         XZRYX4ez99i9mBDyORgnNx7AwaVPkOOePNtWRPt80p+XZcDObmcoqETTrwBBmOYbij9U
         5iVGKtwSp3IEo11ySKPiXzP32EKZ96X5fj4+zFj+plfdchvoUytXJShtQ17Q+DgNY7/g
         LOCZYSGeWgJcydc8uBK0RZfrR2/QU+gVhVnS8zbGRXJdoBL03WCG4bPCeufjDJ07KjK7
         TmVxy89EVWBLcB8C6uLNc8qvNDov0DzEH1qnSif80PDJvvnMgCATJj4n0h77q/nvNWnP
         xOLw==
X-Gm-Message-State: AOJu0Ywayk1K9FeAb8nPUOVOmsik5XRMULIa+E1P8HH5UEPwqltiClgs
	GrHp8VSRTvhFT1BVgeF0lTsffJgBqp9ifYB6iVRt1cVBnPZdWtB/bC1bbKXHEedIH4fwEHjJSuq
	8UMjRO/hAX48eTcn+YC03pS5uVKNylNNY
X-Received: by 2002:a05:600c:1553:b0:40d:1778:c839 with SMTP id f19-20020a05600c155300b0040d1778c839mr800478wmg.141.1702908286035;
        Mon, 18 Dec 2023 06:04:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcEe4oxIKdoWGJpNNgct2Y7QUZNBaHPed36CrMgdRYdzYq01y0NjIDBP2vA8dNftPuSdKBGQ==
X-Received: by 2002:a05:600c:1553:b0:40d:1778:c839 with SMTP id f19-20020a05600c155300b0040d1778c839mr800468wmg.141.1702908285537;
        Mon, 18 Dec 2023 06:04:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm42693165wmb.4.2023.12.18.06.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 06:04:45 -0800 (PST)
Message-ID: <944d990f-3c98-4ade-8176-4e4b25eae0b8@redhat.com>
Date: Mon, 18 Dec 2023 15:04:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH WIP v1 07/20] mm/rmap_id: track if one ore multiple MMs
 map a partially-mappable folio
Content-Language: en-US
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Yang Shi <shy828301@gmail.com>, Ying Huang <ying.huang@intel.com>,
 Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20231124132626.235350-1-david@redhat.com>
 <20231124132626.235350-8-david@redhat.com>
 <F5EF2C8E-2902-447C-BD97-05AF6FF8832D@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <F5EF2C8E-2902-447C-BD97-05AF6FF8832D@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.12.23 20:13, Nadav Amit wrote:
> 
>> On Nov 24, 2023, at 3:26 PM, David Hildenbrand <david@redhat.com> wrote:
>>
>> 5. sub-IDs
>> ==========
>>
>> To achieve (2), we generate sub-IDs that have the following property,
>> assuming that our folio has P=folio_nr_pages() pages.
>>   "2 * sub-ID" cannot be represented by the sum of any other *2* sub-IDs
>>   "3 * sub-ID" cannot be represented by the sum of any other *3* sub-IDs
>>   "4 * sub-ID" cannot be represented by the sum of any other *4* sub-IDs
>>   ...
>>   "P * sub-ID" cannot be represented by the sum of any other *P* sub-IDs
>>
>> The sub-IDs are generated in generations, whereby
>> (1) Generation #0 is the number 0
>> (2) Generation #N takes all numbers from generations #0..#N-1 and adds
>>     (P + 1)^(N - 1), effectively doubling the number of sub-IDs
>>
>> Consequently, the smallest number S in gen #N is:
>>   S[#N] = (P + 1)^(N - 1)
>>
>> The largest number L in gen #N is:
>>   L[#N] = (P + 1)^(N - 1) + (P + 1)^(N - 2) + ... (P + 1)^0 + 0.
>>   -> [geometric sum with "P + 1 != 1"]
>>         = (1 - (P + 1)^N) / (1 - (P + 1))
>>         = (1 - (P + 1)^N) / (-P)
>>         = ((P + 1)^N - 1) / P
> 
> David, as you know it took me a while to understand your impressive work.
> 

Hi Nadav,

thanks a bunch for digging into the details of the solution and trying 
to verify the correctness!

And thanks a lot for highlighting the special case below that I 
intuitively used for the "intuition" :)


> I think that part of what made it hard for me is the presentation and the
> formulation of sub-IDs in arithmetic means instead of bit manipulations.

Yes, that needs more work to make it all easier to understand.

> 
> Basically, IIUC, you want for order-K pages to add K-1 “0” bits between
> each rmap-id bits.
> 
> In this case, in x86-64 (with BMI2) there is the PDEP instruction that can
> generate these values rather easily with little overhead.

Partially, yes.

What you describe here is a special case that is easier to "grasp", 
likely a bit faster to calculate, but ends up being less-optimal in 
space consumption for some cases (especially, order-2 and order-9 folios).

You are describing the special case where "P+1" is a power of two.

Let me explain using the example (P = 3) from the "intuition" further 
down in this patch description, highlighting the mapping:

RMAP-ID |       |Subid |
-----------------------------------
  0       | 0000 | 0    | 0000 0000
  1       | 0001 | 1    | 0000 0001
  2       | 0010 | 4    | 0000 0100
  3       | 0011 | 5    | 0000 0101
  4       | 0100 | 16   | 0001 0000
  5       | 0101 | 17   | 0001 0001
  6       | 0110 | 20   | 0001 0100
  7       | 0111 | 21   | 0001 0101
  8       | 1000 | 64   | 0100 0000
  9       | 1001 | 65   | 0100 0001
  10      | 1010 | 68   | 0100 0100
  11      | 1011 | 69   | 0100 0101
  12      | 1100 | 80   | 0101 0100
  13      | 1101 | 81   | 0101 0001
  14      | 1110 | 84   | 0101 0100
  15      | 1111 | 85   | 0101 0101

So going from e.g., 11 -> 69 means adding one zero for each bit, just 
like you said.

But adding 1 "0" bit is not sufficient for handling order-2 folios (P = 
4), only for handling order-1 folios. So what the current approach does 
is the following (P = 4):

RMAP-ID |       | Subid |
-----------------------------------
  0       | 0000 | 0     | 0000 0000
  1       | 0001 | 1     | 0000 0001
  2       | 0010 | 5     | 0000 0101
  3       | 0011 | 6     | 0000 0110
  4       | 0100 | 25    | 0001 1001
  5       | 0101 | 26    | 0001 1010
  6       | 0110 | 30    | 0001 1110
  7       | 0111 | 31    | 0001 1111
  8       | 1000 | 125   | 0111 1101
  9       | 1001 | 126   | 0111 1110
  10      | 1010 | 130   | 1000 0010
  11      | 1011 | 131   | 1000 0011
  12      | 1100 | 150   | 1001 0110
  13      | 1101 | 151   | 1001 0111
  14      | 1110 | 155   | 1001 1011
  15      | 1111 | 156   | 1001 1100

Which is not just adding "0"s.

To handle it using your simplification we'd have to add one more "0" bit 
to be able to use it for order-2 folios. So I'll refine your statement to:
	for order-K pages to add K “0” bits between each rmap-id bits.

Then, it's easy to see how going from 24 RMAP-ID bits for an order-2 
page would require with that simplification 3*24 = 72bit and would no 
longer fit into a single 64bit value.

To summarize, with the optimized (currently implemented) scheme, we achieve:
  * == order-2:  1x 64bit rmap values
  * <= order-5:  2x 64bit rmap values
  * <= order-9:  3x 64bit rmap values
  * <= order-10: 4x 64bit rmap values
  * <= order-12: 5x 64bit rmap values
  * <= order-15: 6x 64bit rmap values
  * ...

I think, going with the simplification above (to be double-checked), 
we'd achieve [essentially, subtracting 1 from all orders]:
  * == order-1:  1x 64bit rmap values
  * <= order-4:  2x 64bit rmap values
  * <= order-8:  3x 64bit rmap values
  * <= order-9:  4x 64bit rmap values
  * <= order-11: 5x 64bit rmap values
  * <= order-14: 6x 64bit rmap values
  * ...

So especially for order-9 folios we would require 4 instead of 3  64bit 
values.


Now, going with this simplification as first step makes absolute sense, 
because it's much more intuitive and eventually a bit easier to 
implement (although really not significantly IMHO).

One can then easily add the optimization on top later.

> 
> I think that besides the easier generation of sub-ids values in this
> manner, discussing the matter without the “generations" also makes it
> easier to understand the correctness (at least for me).

Yes, that presentation certainly needs improvement. Generating the magic 
numbers recursively makes it easier to proof the correctness using 
induction, that's how I started to use that whole "generation" terminology.

-- 
Cheers,

David / dhildenb


