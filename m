Return-Path: <linux-kernel+bounces-1198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A6814B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663D21F24275
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566943BB33;
	Fri, 15 Dec 2023 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDxSEGaY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057639FEA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702653398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=asun5SQoVzNEadbgSuV5IwpyX4NIYMVVqDbKSzKYW00=;
	b=CDxSEGaYharFCt1KmwdQZkbQRNyAVU91NG1j8RXPUJbudHmafmhBhG6B6lApKS0fByBTQh
	mEE5lPzuk+TAOesxfr3QNmem/M9JgbBpWNPKIk8aA76H6cLzyBiLD+E3YwazErtBKe0AhT
	WF7bhJC3jAq4AmE3ciu2Mb4X+ECGuWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-gRcCPN76MXqRoXAuWmDdXg-1; Fri, 15 Dec 2023 10:16:37 -0500
X-MC-Unique: gRcCPN76MXqRoXAuWmDdXg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c2c6f0893so5658305e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653395; x=1703258195;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asun5SQoVzNEadbgSuV5IwpyX4NIYMVVqDbKSzKYW00=;
        b=YXEC8bDVM8US34CM0dGij02cNdAegXW8QNc6K8KMhSCzw4u/dDzT1byygJb6LqFayK
         RJQ1Jyx6wyN+YKAclWKRIcZ8S5PBfanSdndhJjebckQflFlTBDFAyujFcKPS0cq8FJQ8
         txXlkUP2SzcHtCOoh2Anl0D8CjB2eBgsK9VyERi8pXKSbZxlB+BnJTEQaqOzrgiadmTm
         PmILBqBQYI492iB18y/MgU+Z9/tCync6gBJod18fF47uKZ8ekPTBUFYGl8ez45EiPwR3
         vRSBlrFBbIQWFZ8gtNbi+2LcqUa5bJAQykJ5sTAko+h4lC9sHJ83D805yf9pl34x2hLF
         IGzg==
X-Gm-Message-State: AOJu0Yzj/kQO1FCYpz216BV6dd0I6XlczI62XeY/ajEUP383bMkpjvTt
	WkEil0oRh9XMUpyntG2rgC5/WQJHuvzZwKyMfyYCT6OKxXGPapdKk1McrDgecsj0BRq1kkSTuYa
	p1YN4rcKJbIV8lui++A88MhuS
X-Received: by 2002:a05:600c:20d:b0:40c:37e9:dcb2 with SMTP id 13-20020a05600c020d00b0040c37e9dcb2mr6170745wmi.74.1702653395607;
        Fri, 15 Dec 2023 07:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQf3IjuNDtC3izg4zYeAl77WfHRboOn7Tw13yf8yN5k+5/Ue7l5vXvCrR84LEtzS9NMOigbw==
X-Received: by 2002:a05:600c:20d:b0:40c:37e9:dcb2 with SMTP id 13-20020a05600c020d00b0040c37e9dcb2mr6170733wmi.74.1702653395075;
        Fri, 15 Dec 2023 07:16:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:2c00:5a30:a88d:5f06:da45? (p200300cbc7082c005a30a88d5f06da45.dip0.t-ipconnect.de. [2003:cb:c708:2c00:5a30:a88d:5f06:da45])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b0040c44b4a282sm21572071wmq.43.2023.12.15.07.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 07:16:34 -0800 (PST)
Message-ID: <4ac7912e-724a-448b-b396-960956a46b37@redhat.com>
Date: Fri, 15 Dec 2023 16:16:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/39] mm/rmap: introduce
 folio_add_anon_rmap_[pte|ptes|pmd]()
To: "Yin, Fengwei" <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-15-david@redhat.com>
 <941c2269-98f0-43a7-a516-cb5b4909ae7f@intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <941c2269-98f0-43a7-a516-cb5b4909ae7f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.12.23 03:26, Yin, Fengwei wrote:
> 
> 
> On 12/11/2023 11:56 PM, David Hildenbrand wrote:
>> Let's mimic what we did with folio_add_file_rmap_*() so we can similarly
>> replace page_add_anon_rmap() next.
>>
>> Make the compiler always special-case on the granularity by using
>> __always_inline.
>>
>> Note that the new functions ignore the RMAP_COMPOUND flag, which we will
>> remove as soon as page_add_anon_rmap() is gone.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> 
> With a small question below.
> 

Thanks!

[...]

>> +	if (flags & RMAP_EXCLUSIVE) {
>> +		switch (mode) {
>> +		case RMAP_MODE_PTE:
>> +			for (i = 0; i < nr_pages; i++)
>> +				SetPageAnonExclusive(page + i);
>> +			break;
>> +		case RMAP_MODE_PMD:
>> +			SetPageAnonExclusive(page);
>> +			break;
>> +		}
>> +	}
>> +	for (i = 0; i < nr_pages; i++) {
>> +		struct page *cur_page = page + i;
>> +
>> +		/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
>> +		VM_WARN_ON_FOLIO((atomic_read(&cur_page->_mapcount) > 0 ||
>> +				  (folio_test_large(folio) &&
>> +				   folio_entire_mapcount(folio) > 1)) &&
>> +				 PageAnonExclusive(cur_page), folio);
>> +	}
> This change will iterate all pages for PMD case. The original behavior
> didn't check all pages. Is this change by purpose? Thanks.

Yes, on purpose. I first thought about also separating the code paths 
here, but realized that it makes much more sense to check each 
individual subpage that is effectively getting mapped by that PMD, 
instead of only the head page.

I'll add a comment to the patch description.

-- 
Cheers,

David / dhildenb


