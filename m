Return-Path: <linux-kernel+bounces-4118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB84817815
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD48328425E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0767C4FF68;
	Mon, 18 Dec 2023 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYcO4UFx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36C1D148
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702919024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a1/7t6cQcrzxvpHhfftSNzokpdVhRAbUJhaMG54Yj08=;
	b=fYcO4UFxQFaXOrmkVokMXTzIFmIZB690o9/AvipswI9QHRjiC+QQVF5UmgeClww27q3G1b
	GmIYoHaW2pL7N0TY9VZbfml+hy7DsPWNyo/fMY8vY1n1B7kcuETzvlkn67Lpt5GbdUZRzS
	HF9Eb4qcyFVdEcpNirceYGjPxOgy0DQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-p3LMhtWtMMyo4r1sM9bj0w-1; Mon, 18 Dec 2023 12:03:42 -0500
X-MC-Unique: p3LMhtWtMMyo4r1sM9bj0w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3366d1d9cf1so392546f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919021; x=1703523821;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1/7t6cQcrzxvpHhfftSNzokpdVhRAbUJhaMG54Yj08=;
        b=upOKwFPqZDjdH+FLOG9n72125VaVvC9DRaSjB4S/2rSW5OX2rT0TDtQqM1XO7R1T8x
         uRfXwOo+8qFe3gv5q7Vyi0kFf95uc1IsAzocsdKgeYjljvTa+HWp70gJwWqDTEgwI7Mx
         8nMFG4lm8ISU6RhxqkZ/1zRm0vxS7RUDOEET+Fzf1SCFVvVCtbeE4cw7RWVyoNOlEfqg
         fBj3TYb6zE41FKXuBC6RK3tEYsc/SHRymujRig3vNL6AzAuxw7lxQOChXg755/E1c9Se
         zkdm1tph9S6s/k9ELwLwZRfgHqzoXsunvmVX5zcY0xfaQgWcTgVKUihwrJG1yb9caXKT
         8l/g==
X-Gm-Message-State: AOJu0YxnMkxe3RyjOcSL3pMOkQvE0XxpzC9H7xGnEAwdz4D5dJFUXiem
	0QZkyrYL6VT7Nrx6fDIktMwMK15bCKUj8Mcm+mrmyH/lJqbSvzOcNw28Y2mO/qeITAryZ3//tMZ
	YVxBQPlXhAdmGlsmgR9uaumFJ9j7c98T+
X-Received: by 2002:adf:e88f:0:b0:336:60fd:868b with SMTP id d15-20020adfe88f000000b0033660fd868bmr1116423wrm.3.1702919021164;
        Mon, 18 Dec 2023 09:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGseZumO/8A3NxSiCtv4EoxypVf8q/kSqckDBUBtr1Gt5IQkbH87Sdjhl9l5G3W7yPmZOQjqQ==
X-Received: by 2002:adf:e88f:0:b0:336:60fd:868b with SMTP id d15-20020adfe88f000000b0033660fd868bmr1116409wrm.3.1702919020289;
        Mon, 18 Dec 2023 09:03:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe7ca000000b003335ddce799sm13919144wrn.103.2023.12.18.09.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:03:39 -0800 (PST)
Message-ID: <652f143e-1547-4ded-892f-1216ce689c9b@redhat.com>
Date: Mon, 18 Dec 2023 18:03:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/39] mm/huge_memory: batch rmap operations in
 __split_huge_pmd_locked()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-16-david@redhat.com>
 <c3984854-0e39-475b-822d-773097d86f50@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c3984854-0e39-475b-822d-773097d86f50@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.12.23 17:22, Ryan Roberts wrote:
> On 11/12/2023 15:56, David Hildenbrand wrote:
>> Let's use folio_add_anon_rmap_ptes(), batching the rmap operations.
>>
>> While at it, use more folio operations (but only in the code branch we're
>> touching), use VM_WARN_ON_FOLIO(), and pass RMAP_EXCLUSIVE instead of
>> manually setting PageAnonExclusive.
>>
>> We should never see non-anon pages on that branch: otherwise, the
>> existing page_add_anon_rmap() call would have been flawed already.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/huge_memory.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1f5634b2f374..82ad68fe0d12 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2398,6 +2398,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>   		unsigned long haddr, bool freeze)
>>   {
>>   	struct mm_struct *mm = vma->vm_mm;
>> +	struct folio *folio;
>>   	struct page *page;
>>   	pgtable_t pgtable;
>>   	pmd_t old_pmd, _pmd;
>> @@ -2493,16 +2494,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>   		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>   	} else {
>>   		page = pmd_page(old_pmd);
>> +		folio = page_folio(page);
>>   		if (pmd_dirty(old_pmd)) {
>>   			dirty = true;
>> -			SetPageDirty(page);
>> +			folio_set_dirty(folio);
>>   		}
>>   		write = pmd_write(old_pmd);
>>   		young = pmd_young(old_pmd);
>>   		soft_dirty = pmd_soft_dirty(old_pmd);
>>   		uffd_wp = pmd_uffd_wp(old_pmd);
>>   
>> -		VM_BUG_ON_PAGE(!page_count(page), page);
>> +		VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
>> +		VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> 
> Is this warning really correct? file-backed memory can be PMD-mapped with
> CONFIG_READ_ONLY_THP_FOR_FS, so presumably it can also have the need to be
> remapped as pte? Although I guess if we did have a file-backed folio, it
> definitely wouldn't be correct to call page_add_anon_rmap() /
> folio_add_anon_rmap_ptes()...

Yes, see the patch description where I spell that out.

PTE-remapping a file-back folio will simply zap the PMD and refault from 
the page cache after creating a page table.

So this is anon-only code.

-- 
Cheers,

David / dhildenb


