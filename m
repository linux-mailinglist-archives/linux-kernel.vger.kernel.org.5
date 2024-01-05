Return-Path: <linux-kernel+bounces-18042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CA8257A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18899B25629
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECA2E831;
	Fri,  5 Jan 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTDYjIzL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F42E821
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704470727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UI3q0a+ZQndGiwSM+buYY7rScrs7DtaOhjIVCFxTag8=;
	b=CTDYjIzLQJVutWiq7VDXrPq7/CzRAZ0GIkQLLWYvlS554lEdoX+FjvRFYAn4T9l2ovrhLl
	ix1rGRcmGWuoo58IydhcU0j3u2vowWrVWPzL1HIiUH6UYaWFNgguopWFhi0IEn62aFQ9op
	SDrck5itPmQTDklZEZdhKSXCOT78kFM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-4MGFXnxhPU-_11zD9zjPXQ-1; Fri, 05 Jan 2024 11:05:26 -0500
X-MC-Unique: 4MGFXnxhPU-_11zD9zjPXQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d54db2ab5so15460025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470725; x=1705075525;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI3q0a+ZQndGiwSM+buYY7rScrs7DtaOhjIVCFxTag8=;
        b=utLerrzPaygT61cfg9cBYLN6w1ePvjxDOIX7e5Np4r5G6EdJjN3BcNVP3Xw6HCTwes
         8nVf7Q7dstDRda2X3mJ0tQ524f4FZ04+gR3IbPya9PVmhYVM962wVsStTx1txFuCm8xl
         2EgjIzeca1CX7hbw10y3qGSJrwbhc1VEUXNyAhaeROIj5idVsDW6lXKrvM0iYG2EuEqI
         e0ttPi52jvrZ7spHFEvqeASuhnRdIg9cYS5AXoQ2fwT1xGxqu7gVbRELThPTmaFB/Zl4
         +GDPHEO7zeyJRuG9SYzv5eIwPEpym5hTjwirEcYAPI+Cc/V+AGxAH2BsXW8XtRb/hqdG
         uD6A==
X-Gm-Message-State: AOJu0Yyyx91WacR9jLa7Qsb85Na1EHKPFoBFI0IgSN7CQuHukH2M2HXz
	daVcX1gVJgPu6W58VRlv2aw7v67cvmoca3tbUycnAJ4k9d69ZJT9SLn0lrpl1iiJC7glFLlG0g1
	Iyrkiwl9LBn5R/0g1Lf7Nn3dkG4Rb8CCM
X-Received: by 2002:a7b:c399:0:b0:40d:6293:fc73 with SMTP id s25-20020a7bc399000000b0040d6293fc73mr1213589wmj.99.1704470724835;
        Fri, 05 Jan 2024 08:05:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJssyq4HfBsD2ttpSw06stsvYiKOf0AZpmxlSSG+6RGBHuY42yzjGqUgyurg6J0mRu2x2psQ==
X-Received: by 2002:a7b:c399:0:b0:40d:6293:fc73 with SMTP id s25-20020a7bc399000000b0040d6293fc73mr1213580wmj.99.1704470724398;
        Fri, 05 Jan 2024 08:05:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:fb00:4bb9:5362:8a63:a97d? (p200300cbc705fb004bb953628a63a97d.dip0.t-ipconnect.de. [2003:cb:c705:fb00:4bb9:5362:8a63:a97d])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0040d79907acasm1981546wmq.26.2024.01.05.08.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:05:24 -0800 (PST)
Message-ID: <793c5cee-d5fc-4eb1-86a2-39e05686233d@redhat.com>
Date: Fri, 5 Jan 2024 17:05:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Yin Fengwei <fengwei.yin@intel.com>,
 syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
 <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
 <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
 <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
 <556f8a4f-c739-41e0-85ec-643a0b32a2ce@redhat.com>
 <63eda2bc-6791-454d-b43e-20d73c7e9843@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <63eda2bc-6791-454d-b43e-20d73c7e9843@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> Think about it: we are adding/removing a page from rmap handling that can
>> *never* be looked up using the rmap because there is no rmap for these pages,
>> and folio->index is just completely unexpressive. VM_MIXEDMAP doesn't have any
>> linearity constraints.
> 
> I guess I was assuming treating it the same way as anon folios. But I guess that
> would be VeryBad (TM) because these aren't anon pages and we don't want to swap,
> etc? OK got it.

Yes, there can't and never will be an rmap walk. No rmap chains are involved.
There is no rmap concept for these folios.

That's the ugly part about all this :)

> 
>>
>> Logically, it doesn't make any sense to involve rmap code although it currently
>> might work. validate_page_before_insert() blocks off most pages where the
>> order-0 mapcount would be used for other purposes and everything would blow up.
>>
>> Looking at vm_insert_page(), this interface is only for pages the caller
>> allocated. Maybe we should just not do any rmap accounting when
>> mapping/unmapping these pages: not involve any rmap code, including mapcounts?
>>
>> vm_normal_page() works on these mappings, so we'd also have to skip rmap code
>> when unmapping these pages etc. Maybe that's the whole reason we have the rmap
>> handling here: to not special-case the unmap path.
> 
> Right. I guess it depends what vm_insert_page() is spec'ed to expect; is the bug
> in the implementation or is the caller providing the wrong type of folio? I
> guess there will be many callers providing non-rmappable folios (inc out of tree?).

I would assume that *all* are providing non-pagecache pages. And if they would
be pagecache pages, likely it would be a BUG because the rmap does not work with
VM_MIXEDMAP and we'd be breaking folio unmapping etc. (we had such a BUG recently
with udmabuf that rightfully switched to VM_PFNMAP)

As vm_insert_page() documents:

"This allows drivers to insert individual pages they've allocated into a user vma."

> 
>>
>> Alternatively, we can:
>>
>> (1) Require the caller to make sure large folios are rmappable. We
>>      already require allocations to be compound. Should be easy to add.
> 
> I'm not sure this is practical given vm_insert_page() is exported?

We could fixup all in-tree users. out-of-tree have to fixup their stuff themselves.

> 
>> (2) Allow non-rmappable folios in rmap code just for mapcount tracking.
>>      Confusing but possible.
>>
>>>>
>>>> I do have another question: why do we just check the large folio
>>>> rmappable? Does that mean order0 folio is always rmappable?
>>>>
>>
>> We didn't really have a check for that I believe. We simply reject all pages in
>> vm_insert_page() that are problematic because the pagecount is overloaded.
>>
>>>> I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
>>>> and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.

Just to comment on that: I think they don't want VM_PFNMAP for some reason.
For example, because GUP has to work on these pages.


To summarize my thoughts: Using "rmap" code for these folios doesn't make
any sense. mapping/unmapping these folios shouldn't call into rmap code.

If we want to adjust the mapcount/counters, we should mimic what rmap
map/unmap does separately, special-cases for VM_MIXEDMAP mappings.

For the time being, it's probably easiest to do the following:

 From 9ff752e9b82991b55813dbf1088cf5b573577bdd Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 5 Jan 2024 16:57:29 +0100
Subject: [PATCH] mm/rmap: silence VM_WARN_ON_FOLIO() in
  __folio_rmap_sanity_checks()

Unfortunately, vm_insert_page() and friends and up passing
driver-allocated folios into folio_add_file_rmap_pte() using
insert_page_into_pte_locked().

While these driver-allocated folios can be compound pages (large
folios), they are not proper "rmappable" folios.

In these VM_MIXEDMAP VMAs, there isn't really the concept of a reverse
mapping, so long-term, we should clean that up and not call into rmap
code.

For the time being, document how we can end up in rmap code with large
folios that are not marked rmappable.

Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap_[pte|ptes|pmd]()")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/rmap.h | 11 +++++++++--
  1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index fd6fe16fa3583..b7944a833668a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -199,8 +199,15 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
  {
  	/* hugetlb folios are handled separately. */
  	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
-			 !folio_test_large_rmappable(folio), folio);
+
+	/*
+	 * TODO: we get driver-allocated folios that have nothing to do with
+	 * the rmap using vm_insert_page(); therefore, we cannot assume that
+	 * folio_test_large_rmappable() holds for large folios. We should
+	 * handle any desired mapcount+stats accounting for these folios in
+	 * VM_MIXEDMAP VMAs separately, and then sanity-check here that
+	 * we really only get rmappable folios.
+	 */
  
  	VM_WARN_ON_ONCE(nr_pages <= 0);
  	VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);
-- 
2.43.0


-- 
Cheers,

David / dhildenb


