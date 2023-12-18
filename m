Return-Path: <linux-kernel+bounces-4123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9BB817822
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A5A2849EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127185A870;
	Mon, 18 Dec 2023 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKvRvqy4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A7498BF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702919166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iVvdutZG3yZUqHC+xhXI/b3cSdWqGk7davUIB07uI+M=;
	b=UKvRvqy4b2sZRmqQChCn83yMJ/okFE7m2ELecVDJvSidwoEQfDBDAi47FWBp4rOOLJsjwT
	2NyaOSZb4sM91oEVh2k2ag3bmyxtQ0fsX3E1pyeCnXWm7Hk8eyPqhwC0PhGPiws8KALJHV
	Da/VLKx6QMQ1pBfky5+mo7joaP5Cjy0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Y-CPHqVfPSq0ttG7lt5vaA-1; Mon, 18 Dec 2023 12:06:04 -0500
X-MC-Unique: Y-CPHqVfPSq0ttG7lt5vaA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3366b71bcf6so622683f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919163; x=1703523963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVvdutZG3yZUqHC+xhXI/b3cSdWqGk7davUIB07uI+M=;
        b=jzjgZRtLxiTq338waoUdFeyFgydoVOVX982Q0Yj1EfeDcj6KJF2mYExoViaQQ7oR30
         QxLMb91AcTHqDrdPW+mCR2IBj0SCgKDkAKM9Z2qhsGMgVEdoibG0csR1yNiMiKqZXJUW
         tReiblY5Tk2rPg7mXMyueS3L6gYsvGy2kyWLOTSe5kO9Z0tiF2GXQK83wrCdzxiLApug
         1fwhn5vrG3c2zXpsZKv2xB73+mtMJxwC0dzieTXS7s68UchUm6Gpxarzk+DDWxoKMqhj
         nXE9g8s+LdiJHNmlxkNW+kfqjCECUrhI2GxHySi5cnaUrxQziDDztbuBv/B+OuGBYcQY
         kDuQ==
X-Gm-Message-State: AOJu0YwyLfyLXo5MORXZt0zuMlef3epDhU5vTI42qSLUmTOf97VgSkGt
	dUm4B1+MZVxL9CHaBm9/o3OtKtpfuoNnmKorp0saFCm6NrU3lzHcm9mrWkN6mBwlzTNMdiASwTL
	VdtzE1MZRGiR5I9ePWgrZ52yR
X-Received: by 2002:a5d:595a:0:b0:336:5bd1:71b9 with SMTP id e26-20020a5d595a000000b003365bd171b9mr3119260wri.3.1702919162867;
        Mon, 18 Dec 2023 09:06:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3+ZaSit36+BldUyyUT4PFopZ34LmGd9eMrX0kgvxGsyk91QCGJXK0Q/pTvostsXvYjQquxQ==
X-Received: by 2002:a5d:595a:0:b0:336:5bd1:71b9 with SMTP id e26-20020a5d595a000000b003365bd171b9mr3119244wri.3.1702919162417;
        Mon, 18 Dec 2023 09:06:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b003366224319csm5554623wrx.53.2023.12.18.09.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:06:02 -0800 (PST)
Message-ID: <b36d6ee0-7ba9-4d4a-847f-85d7765fc7e0@redhat.com>
Date: Mon, 18 Dec 2023 18:06:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/39] mm/rmap: factor out adding folio mappings into
 __folio_add_rmap()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-14-david@redhat.com>
 <e5b69854-2bb3-4df4-92cc-3101e9691615@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e5b69854-2bb3-4df4-92cc-3101e9691615@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.12.23 17:07, Ryan Roberts wrote:
> On 11/12/2023 15:56, David Hildenbrand wrote:
>> Let's factor it out to prepare for reuse as we convert
>> page_add_anon_rmap() to folio_add_anon_rmap_[pte|ptes|pmd]().
>>
>> Make the compiler always special-case on the granularity by using
>> __always_inline.
>>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/rmap.c | 81 ++++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 45 insertions(+), 36 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2ff2f11275e5..c5761986a411 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1157,6 +1157,49 @@ int folio_total_mapcount(struct folio *folio)
>>   	return mapcount;
>>   }
>>   
>> +static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>> +		struct page *page, int nr_pages, enum rmap_mode mode,
>> +		unsigned int *nr_pmdmapped)
>> +{
>> +	atomic_t *mapped = &folio->_nr_pages_mapped;
>> +	int first, nr = 0;
>> +
>> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>> +
>> +	/* Is page being mapped by PTE? Is this its first map to be added? */
> 
> I suspect this comment is left over from the old version? It sounds a bit odd in
> its new context.

In this patch, I'm just moving the code, so it would have to be dropped 
in a previous patch.

I'm happy to drop all these comments in previous patches.

> 
>> +	switch (mode) {
>> +	case RMAP_MODE_PTE:
>> +		do {
>> +			first = atomic_inc_and_test(&page->_mapcount);
>> +			if (first && folio_test_large(folio)) {
>> +				first = atomic_inc_return_relaxed(mapped);
>> +				first = (first < COMPOUND_MAPPED);
>> +			}
>> +
>> +			if (first)
>> +				nr++;
>> +		} while (page++, --nr_pages > 0);
>> +		break;
>> +	case RMAP_MODE_PMD:
>> +		first = atomic_inc_and_test(&folio->_entire_mapcount);
>> +		if (first) {
>> +			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
>> +			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
>> +				*nr_pmdmapped = folio_nr_pages(folio);
>> +				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
>> +				/* Raced ahead of a remove and another add? */
>> +				if (unlikely(nr < 0))
>> +					nr = 0;
>> +			} else {
>> +				/* Raced ahead of a remove of COMPOUND_MAPPED */
>> +				nr = 0;
>> +			}
>> +		}
>> +		break;
>> +	}
>> +	return nr;
>> +}
>> +
>>   /**
>>    * folio_move_anon_rmap - move a folio to our anon_vma
>>    * @folio:	The folio to move to our anon_vma
>> @@ -1380,45 +1423,11 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>>   		struct page *page, int nr_pages, struct vm_area_struct *vma,
>>   		enum rmap_mode mode)
>>   {
>> -	atomic_t *mapped = &folio->_nr_pages_mapped;
>> -	unsigned int nr_pmdmapped = 0, first;
>> -	int nr = 0;
>> +	unsigned int nr, nr_pmdmapped = 0;
> 
> You're still being inconsistent with signed/unsigned here. Is there a reason
> these can't be signed like nr_pages in the interface?

I can turn them into signed values.

Personally, I think it's misleading to use "signed" for values that have 
absolutely no meaning for negative meaning. But sure, we can be 
consistent, at least in rmap code.

-- 
Cheers,

David / dhildenb


