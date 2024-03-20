Return-Path: <linux-kernel+bounces-108673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569AB880E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DFCB214C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AC3B78E;
	Wed, 20 Mar 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHbgCDEb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5913AC01
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925535; cv=none; b=ZWDqwhdbU7dLnU4RuLDu2Z7Mdmxd9J2ErwCCRqPL1A+iile3sJmY2t2F7ZKDcHWa2npSAP/LJ2P1IQdYbdX7jGJEvD5e138SLAh9klQVwRlmk+V3ap2bWaHw2auCXVT6W1xCZYxkXnFO5LGO0LjETniTfT6uF04kf6220Zkl0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925535; c=relaxed/simple;
	bh=CZqW0SANkHrHUbk3+lBZfjPR+ooDxCrNYjscq7Y1A1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cVeT3QXPqlCU8i9SqUm3lakDdKAOco9YOQ2kVuax6wsHxqhinQS+nd0NK1s0nwga3u3oRzY+MmK4AqXclrNsLYrpkux6VvdLGdE9wFiMPqFTuv6KPFLK6eWj0+RfBQzUJU0I7/opnsljE48GYS9RUiFffROEGi7JVPCvGi26kE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHbgCDEb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dddbeac9f9so44751405ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710925533; x=1711530333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOl5FJq1jF6A4kdSR20ohjox802dBiYkdAwfXGs190Y=;
        b=BHbgCDEbdrkClb8xHn2irOJBoRkXsbRglDzDjVQTT5GQH/Z54+T+S7yr4B/GB6Mjkh
         sfViMt93DWfY9tY/iKneaeFsGYWV05h990J7wiePZ8yzXkCALczWLg/iWwV7FN+vFG+M
         RTZzo2tKVk233Dvy9+8y7lt/upjLaBm18cJGInQ3W257vXNKy+CLYU838wTpiaIsSbBm
         rKfj1XZIePVWP0u9VEExCyIxHq6IuPUqdBdu8MvuGfrPPKEplUDY6lfK8KAllquHTKCB
         5GKOv/at1++CCrDCsYUTM55F7tvXanVoOu2PC71yEU0kVlUgHA2zOdAq7yxOvSZ6DIGn
         IaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925533; x=1711530333;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOl5FJq1jF6A4kdSR20ohjox802dBiYkdAwfXGs190Y=;
        b=HQ5EBKymJ4VTSk6+Oxp6TDitkxGSxMZS9Cs/QmjEKrVu8iZX6cVa2A6xZ/U9yYUdfm
         Tf6ZUGKP0lZj7/IBYxlkIWJsGSFnl1hTLFGkm/70MPRps9wx0cF8j4O2aNvoKr4pcV2B
         bLVfYC9qf5vDJnrq56cmpgSTCt92dXZhZ7La1GdLpHgisT8Uq9n0ob/e4HfE/q+x2Wgb
         0nmBOALILDtPjwfPNriCLFmY556eG5qu7cPoz4FBKeWn8cy3tLsD44GE5KoWQIj9m9XG
         VNxzOTjtTbtL8iiLgjo3rKj7C2cUsKKnfNd8aIIoHONMh/ry2vO47kQGW1iPJnTvrkOq
         XsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcRF1rWVvIiG9jEbTzqHLHCRTMRhfFw8EInkAmAVoiJw8T2Xm53sItjvk3Odp9QOpgiZWVz0fKN7X9SjI4VcwJCTkHxdFYj5T6QJKj
X-Gm-Message-State: AOJu0Yx1aOzJoe+nnrbieG+12ffupL7Lk2/OrGKnUTfla9+7fnrn7vJq
	pvG6inWqngsw6ikkFDe4l00GEtgw464673wL6MSoigOUIrwFW9Fw
X-Google-Smtp-Source: AGHT+IGIjIr/BC0UGlwJERHJDfupOBUPN7oxWvwBJmJVqtmIJ3uz3YdttYX2qR6r5icsC0/2gshLwQ==
X-Received: by 2002:a17:903:1251:b0:1dc:696d:ec6e with SMTP id u17-20020a170903125100b001dc696dec6emr18695368plh.21.1710925532844;
        Wed, 20 Mar 2024 02:05:32 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bi5-20020a170902bf0500b001e039a22e6asm4144772plb.65.2024.03.20.02.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:05:32 -0700 (PDT)
Message-ID: <54a8ec22-ce00-425c-bb58-54cf8606a362@gmail.com>
Date: Wed, 20 Mar 2024 17:05:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] mm/ksm: catch tail page abnormal in
 page_stable_node
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240318121443.3991104-1-alexs@kernel.org>
 <7a0d7d0e-d241-4942-b6c1-e60d597b3dd6@redhat.com>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <7a0d7d0e-d241-4942-b6c1-e60d597b3dd6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/18/24 8:25 PM, David Hildenbrand wrote:
> On 18.03.24 13:14, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> commit 19138349ed59 ("mm/migrate: Add folio_migrate_flags()") change the
>> meaning of func page_stable_node() to check the compound head for tail
>> 'page' instead of tail page self.
>> But seems both semantics are same at results, the func always return NULL
>>   for tail page. So adding a bug monitor here in case of abnormal.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> To: linux-kernel@vger.kernel.org
>> To: linux-mm@kvack.org
>> To: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>   mm/ksm.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 8c001819cf10..3ff469961927 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1091,7 +1091,12 @@ static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
>>     static inline struct ksm_stable_node *page_stable_node(struct page *page)
>>   {
>> -    return folio_stable_node(page_folio(page));
>> +    struct ksm_stable_node *node;
>> +
>> +    node = folio_stable_node(page_folio(page));
>> +    VM_BUG_ON_PAGE(PageTail(page) && node, page);
> 
> I don't really understand why we would want this.
> 
> Only KSM folios can have a node in the stable tree. KSM folios cannot be large folios. At that is precisely what folio_stable_node() checks.
> 
> If we'd have a large folio identify as a KSM folio we'd be in much bigger trouble.
> 
> 
> Besides, I'm sure you read "22) Do not crash the kernel" in Documentation/process/coding-style.rst
> 

Hi David, 

Thanks for comments!
Forgive my stupidity, I understand KSM stable tree has no compound pages, but when searching a tail page in ksm_do_scan(), why we couldn't be in a race, that another VM doing THP collapse on the same contents pages, while the 3rd vm is doing hugepage spliting?

Best regards!
Alex

