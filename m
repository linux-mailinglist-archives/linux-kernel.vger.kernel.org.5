Return-Path: <linux-kernel+bounces-17627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D64825053
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA551C22B50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20F0224FE;
	Fri,  5 Jan 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POpWpGTo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B275224C3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704444999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xdS9zmsmBpcGPs+kLiFZ+pYoB8vBAvOUp4pwwBWRKww=;
	b=POpWpGTowl+vTymWedWfBv0u9qTM2iX1dLAsQBqOHoz2+J2Rv5o20A+9vBaThAlCWO8Xpy
	FN+2rpThsBsU7jAieUtnoToulO711qH24FWjZ1kgOqKpKChzk1tzqKqT61s1UlnLOuSqAo
	5d/fujH7c/xG9+q2kidC2SXX5/yBYSk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-tcQMbQr7P3yWs5gjwYUrjw-1; Fri, 05 Jan 2024 03:56:32 -0500
X-MC-Unique: tcQMbQr7P3yWs5gjwYUrjw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3367657a290so839384f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704444991; x=1705049791;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdS9zmsmBpcGPs+kLiFZ+pYoB8vBAvOUp4pwwBWRKww=;
        b=hM6FunGLUdhfWtuVxUebU9N+9rlfoblQWJnnaJgYf0zG0xCCx1DfdoaaOgyhJd6mt3
         HpmgKlJeO8rUV7jZLfI6R9T3dC960uEYwD4xTVrBvfweXahnFvRKGYmstYhTQ55wTDAr
         /LjO+ntR6tHvz7vEFvBE1XTcE9Lfb00vL0aeVrF2E6Jv7EosabyX3DTuu7kPz1EFXJcX
         TdWoVGyXqW7a4VfYWYpE0pZXW/9LW4FHibrn/KU28po4sSuw93cbXHRwtJ9iwjgeta5Y
         AddBeH73r4HlA7hRV0OWdtgPXbEA45o3TdwZI1OhCD9GnJgg8WRiVGdoA7KzJ8XQcoIG
         rAYQ==
X-Gm-Message-State: AOJu0Yw81eU3d6CEjdxKsFMfgt6+9GnpzUKTs8lzdeqHPdTSvlsvoFse
	a3LzCMMZrSD95214GN3CdzRFSetvhuGO1V8sXc2KNVG8L5JpHYAouLmFHKQFP9i+EEWC3ZyRb7X
	nDc2QNXlgxvq3cVs3uY6Tano0zcUu11nr
X-Received: by 2002:adf:ce04:0:b0:333:4bd9:8e with SMTP id p4-20020adfce04000000b003334bd9008emr973629wrn.25.1704444991618;
        Fri, 05 Jan 2024 00:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRxX7/gA1BphIYQxJK7kg3vvnZ3EpGxtBjqBgpcMH3EPeqfef9juAbWw4XqQ7O+d490pd1jw==
X-Received: by 2002:adf:ce04:0:b0:333:4bd9:8e with SMTP id p4-20020adfce04000000b003334bd9008emr973618wrn.25.1704444991123;
        Fri, 05 Jan 2024 00:56:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:fb00:4bb9:5362:8a63:a97d? (p200300cbc705fb004bb953628a63a97d.dip0.t-ipconnect.de. [2003:cb:c705:fb00:4bb9:5362:8a63:a97d])
        by smtp.gmail.com with ESMTPSA id l3-20020adff483000000b0033719111458sm992009wro.36.2024.01.05.00.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 00:56:30 -0800 (PST)
Message-ID: <556f8a4f-c739-41e0-85ec-643a0b32a2ce@redhat.com>
Date: Fri, 5 Jan 2024 09:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>> If I am not wrong, that triggers:
>>>>>
>>>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>>>             !folio_test_large_rmappable(folio), folio);
>>>>>
>>>>> So we are trying to rmap a large folio that did not go through
>>>>> folio_prep_large_rmappable().
> 
> Would someone mind explaining the rules to me for this? As far as I can see,
> folio_prep_large_rmappable() just inits the _deferred_list and sets a flag so we
> remember to deinit the list on destruction. Why can't we just init that list for
> all folios order-2 or greater? Then everything is rmappable?

I think we much rather want to look into moving all mapcount-related 
stuff into folio_prep_large_rmappable(). It doesn't make any sense to 
initialize that for any compound pages, especially the ones that will 
never get mapped to user space.

> 
>>>>>
>>>>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed
>>>>> in the "struct packet_ring_buffer". No idea where that comes from, but I
>>>>> suspect it's simply some compound allocation.
>>>> Looks like:
>>>>     alloc_pg_vec
>>>>       alloc_one_pg_vec_page
>>>>            gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>>>>                              __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>>>>
>>>>            buffer = (char *) __get_free_pages(gfp_flags, order);
>>>> So you are right here... :).
>>>
>>> Hm, but I wonder if this something that's supposed to work or is this one of
>>> the cases where we should actually use a VM_PFN mapping?
>>>
>>> It's not a pagecache(file/shmem) page after all.
>>>
>>> We could relax that check and document why we expect something that is not
>>> marked rmappable. But it fells wrong. I suspect this should be a VM_PFNMAP
>>> instead (like recent udmabuf changes).
>>
>> VM_PFNMAP looks correct.
> 
> And why is making the folio rmappable and mapping it the normal way not the
> right solution here? Because the folio could be order-1? Or something more profound?
> 

Think about it: we are adding/removing a page from rmap handling that 
can *never* be looked up using the rmap because there is no rmap for 
these pages, and folio->index is just completely unexpressive. 
VM_MIXEDMAP doesn't have any linearity constraints.

Logically, it doesn't make any sense to involve rmap code although it 
currently might work. validate_page_before_insert() blocks off most 
pages where the order-0 mapcount would be used for other purposes and 
everything would blow up.

Looking at vm_insert_page(), this interface is only for pages the caller 
allocated. Maybe we should just not do any rmap accounting when 
mapping/unmapping these pages: not involve any rmap code, including 
mapcounts?

vm_normal_page() works on these mappings, so we'd also have to skip rmap 
code when unmapping these pages etc. Maybe that's the whole reason we 
have the rmap handling here: to not special-case the unmap path.

Alternatively, we can:

(1) Require the caller to make sure large folios are rmappable. We
     already require allocations to be compound. Should be easy to add.
(2) Allow non-rmappable folios in rmap code just for mapcount tracking.
     Confusing but possible.

>>
>> I do have another question: why do we just check the large folio
>> rmappable? Does that mean order0 folio is always rmappable?
>>

We didn't really have a check for that I believe. We simply reject all 
pages in vm_insert_page() that are problematic because the pagecount is 
overloaded.

>> I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
>> and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.

Right, similar problem.

-- 
Cheers,

David / dhildenb


