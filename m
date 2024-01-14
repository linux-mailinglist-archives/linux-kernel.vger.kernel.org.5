Return-Path: <linux-kernel+bounces-25520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D742C82D1BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AECA1F215C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB967EAED;
	Sun, 14 Jan 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFQvSsn5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4ECD313
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705253641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SNH4k9dC42HH6xYr+8ddODNas5GAjbPz5EIg8VG6/Rw=;
	b=AFQvSsn5V3nZoD/njsvmdFD5ygPuGTJhSZ2BWKV0QhVo3Fo0FJbU637N1jx8rjK8sSvBZB
	0z7i7yWCsEXESf81CIlGjFemLOYjk86m9NqerYVHKsW+uHUljwUIUn7RcHL6uXqZuQLX0X
	/z4DxzuD5VU34ndpp9wiC8HLSM3tPi4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-A7SCmvjMNK-S8CSAFnvpVA-1; Sun, 14 Jan 2024 12:34:00 -0500
X-MC-Unique: A7SCmvjMNK-S8CSAFnvpVA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e530b7596so44051635e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 09:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705253639; x=1705858439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNH4k9dC42HH6xYr+8ddODNas5GAjbPz5EIg8VG6/Rw=;
        b=FHhke2lehi8tWsVpPTK8yCWSchv1F0ahmEDkYXMeSAd8J2RQ8Tgs9zefz+XJhlNOSb
         Q/ihwLa5soRugBFvnF7stBpi3WGREI9fBSI6KecsylP2KpRqQL9eHSINuVW4Nku1lAlA
         4sdNTU9UohotFjkxR83MkHhlYcXpt4WwfLsbSj2/2rH14ftQXaBv7hr9l0gskcYqm9Ml
         CTOUUxxpkTYe95UGu2uO7/aD1Yh8oEDbqAhIb2E5AhYjRSwZpH0Zzl1JZiG8i3T6qyt/
         6JyrZJRruy53AsR03R7ovu7tSPkmbqzbwKIeby4INXu+5yNfwJZTzUXVo/6DQkWzxKua
         W0IQ==
X-Gm-Message-State: AOJu0Yw7ZwkfbddLxh/hb5pJyEvFQYPOWbXLwpBmqSsy6pYk2cyHa9dk
	BAEF7jNX8MTS/y1J4ULaZSbpCvG/Cwjs3AoCobDJko5+WawZS950LvWgfog6OBfu/1NhL3J3FPk
	GZsKBWTM2fzF50QiOB1f1To6QaEK1A3x0
X-Received: by 2002:a7b:c40c:0:b0:40e:52e2:f5d2 with SMTP id k12-20020a7bc40c000000b0040e52e2f5d2mr2588171wmi.40.1705253639098;
        Sun, 14 Jan 2024 09:33:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdLxk9K8a+S+nAmtEfSAPtsM8ZqxSoO8zMB2YjbYqqChW6Xdnpg+3LDDtzlcbEdSzlJf8HZg==
X-Received: by 2002:a7b:c40c:0:b0:40e:52e2:f5d2 with SMTP id k12-20020a7bc40c000000b0040e52e2f5d2mr2588152wmi.40.1705253638638;
        Sun, 14 Jan 2024 09:33:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c715:7200:c26a:bd3d:e8e4:c3e6? (p200300cbc7157200c26abd3de8e4c3e6.dip0.t-ipconnect.de. [2003:cb:c715:7200:c26a:bd3d:e8e4:c3e6])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4cd2000000b0033740e109adsm9634174wrt.75.2024.01.14.09.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 09:33:58 -0800 (PST)
Message-ID: <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>
Date: Sun, 14 Jan 2024 18:33:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
To: Jiri Olsa <olsajiri@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZaMR2EWN-HvlCfUl@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.24 23:42, Jiri Olsa wrote:
> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
>> In preparation for supporting anonymous multi-size THP, improve
>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>> passed to it. In this case, all contained pages are accounted using the
>> order-0 folio (or base page) scheme.
>>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/rmap.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2a1e45e6419f..846fc79f3ca9 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>    * This means the inc-and-test can be bypassed.
>>    * The folio does not have to be locked.
>>    *
>> - * If the folio is large, it is accounted as a THP.  As the folio
>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>    * is new, it's assumed to be mapped exclusively by a single process.
>>    */
>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>   		unsigned long address)
>>   {
>> -	int nr;
>> +	int nr = folio_nr_pages(folio);
>>   
>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> 
> hi,
> I'm hitting this bug (console output below) with adding uprobe
> on simple program like:
> 
>    $ cat up.c
>    int main(void)
>    {
>       return 0;
>    }
> 
>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
> 
>    $ ./up
> 
> it's on top of current linus tree master:
>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> 
> before this patch it seems to work, I can send my .config if needed

bpf only inserts a small folio, so no magic there.

It was:
	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
And now it is
	VM_BUG_ON_VMA(address < vma->vm_start || address + (nr << PAGE_SHIFT) > vma->vm_end, vma);

I think this change is sane. As long as the address is aligned to full pages
(which it better should be)

Staring at uprobe_write_opcode, likely vaddr isn't aligned ...

Likely (hopefully) that is not an issue for __folio_set_anon(), because linear_page_index()
will mask these bits off.


Would the following change fix it for you?

 From c640a8363e47bc96965a35115a040b5f876c4320 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sun, 14 Jan 2024 18:32:57 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  kernel/events/uprobes.c | 2 +-
  mm/rmap.c               | 1 +
  2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 485bb0389b488..929e98c629652 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -537,7 +537,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
  		}
  	}
  
-	ret = __replace_page(vma, vaddr, old_page, new_page);
+	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
  	if (new_page)
  		put_page(new_page);
  put_old:
diff --git a/mm/rmap.c b/mm/rmap.c
index f5d43edad529a..a903db4df6b97 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1408,6 +1408,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
  {
  	int nr = folio_nr_pages(folio);
  
+	VM_WARN_ON_FOLIO(!IS_ALIGNED(address, PAGE_SIZE), folio);
  	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
  	VM_BUG_ON_VMA(address < vma->vm_start ||
  			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
-- 
2.43.0



-- 
Cheers,

David / dhildenb


