Return-Path: <linux-kernel+bounces-25810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F6982D62A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DA6280CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C53D308;
	Mon, 15 Jan 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iomzGtkP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C0E549
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705311494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=04z7be3ydmxMBIN88g4q9MNYi7AnUXEkoQiujmM8AuE=;
	b=iomzGtkPSc1QfbxztkRmHSLOsQ+GQeJbNyRRFIINYvD96LUi1roV+2R4au0dhb3VhdR6tF
	oX6wAK1ChUANQ4Rxro69trl4LM064A7hLAnhPn1uc4qMXksVX0M7b7Mhra4bUDslUqH6PZ
	C5zC0YE6Or+65mX3P61Lg0zf0shGQeg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-XmOAIB44ORuXyZoTBrs3Tw-1; Mon, 15 Jan 2024 04:38:12 -0500
X-MC-Unique: XmOAIB44ORuXyZoTBrs3Tw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d6e7334cfso77619815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311491; x=1705916291;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04z7be3ydmxMBIN88g4q9MNYi7AnUXEkoQiujmM8AuE=;
        b=b7OP5ZIdqLBP4H/Qo3b/zIhKX0//gdxUKAIYNQmSKp9Fm2InRNUwOVDtSXsUZ4Tvcg
         wrILUpfZ/SKElCNIy3kB33JK4IRDgRfDzgCu3r9urtWez9RhF//dpZf2WJeSmb627o1x
         Q2QRhr0SSQG7Zgj2RvXEcOZx0nCXEfxRI4LsUlP0NRTLpRmmEA+QIz/cW0Mlw/49yjG6
         zEDw6H/XKWRq62127E+bc7hRlnsfGUdWnilD3ZOXYdeB0z4HiB0e8nTVu6h6efsYBG6h
         Js00bL80un16ujCaNe+7fqtAlCTdfdRzh62Eq5U3Bp8UNvC/k6nkS/4N0mB+70BnYodI
         xs+g==
X-Gm-Message-State: AOJu0YwziP7bDby/GyQSNI/4cPdpiqC9V/2vfm4fzvVcyl5WTnjPJ2o/
	8Jxwcsgjm0REnfSdNyg2bs9WcaSTVKiL86rhEV8R6FqLM+4RMqyHFbRjBHvKCoTXSfGG4OQcNs8
	vIOvCG2DhAwikKAOHgGUKFkTGzMqC1q4w
X-Received: by 2002:a05:600c:5251:b0:40e:490a:ed59 with SMTP id fc17-20020a05600c525100b0040e490aed59mr2695307wmb.114.1705311491331;
        Mon, 15 Jan 2024 01:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFiMsyiLeZVc6pfCmCIBpNcg+aDQLzuKDWbKQWq7uu0ZIUyzoCXOg2hmRk3LmRmziY/x9F7g==
X-Received: by 2002:a05:600c:5251:b0:40e:490a:ed59 with SMTP id fc17-20020a05600c525100b0040e490aed59mr2695292wmb.114.1705311490957;
        Mon, 15 Jan 2024 01:38:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c71e:fb00:b32e:3358:38cf:3cbc? (p200300cbc71efb00b32e335838cf3cbc.dip0.t-ipconnect.de. [2003:cb:c71e:fb00:b32e:3358:38cf:3cbc])
        by smtp.gmail.com with ESMTPSA id b6-20020adfee86000000b00337478efa4fsm11298366wro.60.2024.01.15.01.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:38:10 -0800 (PST)
Message-ID: <03ee2bda-2c4d-49e1-b897-dd89042fc112@redhat.com>
Date: Mon, 15 Jan 2024 10:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
To: Ryan Roberts <ryan.roberts@arm.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yin Fengwei <fengwei.yin@intel.com>,
 Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Yang Shi
 <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
 Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Itaru Kitayama <itaru.kitayama@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 John Hubbard <jhubbard@nvidia.com>, David Rientjes <rientjes@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com> <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com> <ZaRKMwKJIBmh8-lD@krava>
 <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>>> index 485bb0389b488..929e98c629652 100644
>>> --- a/kernel/events/uprobes.c
>>> +++ b/kernel/events/uprobes.c
>>> @@ -537,7 +537,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>>   		}
>>>   	}
>>> -	ret = __replace_page(vma, vaddr, old_page, new_page);
>>> +	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
>>>   	if (new_page)
>>>   		put_page(new_page);
>>>   put_old:
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index f5d43edad529a..a903db4df6b97 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1408,6 +1408,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>   {
>>>   	int nr = folio_nr_pages(folio);
>>> +	VM_WARN_ON_FOLIO(!IS_ALIGNED(address, PAGE_SIZE), folio);
> 
> nit: Is it worth also adding this to __folio_add_anon_rmap() so that
> folio_add_anon_rmap_ptes() and folio_add_anon_rmap_pmd() also benefit?
> 

Yes, same thoughts. Just included it so we would catch if still 
something goes wrong here.

I'll split that change out either way.


> Regardless:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks!

-- 
Cheers,

David / dhildenb


