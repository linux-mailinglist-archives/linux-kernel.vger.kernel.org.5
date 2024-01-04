Return-Path: <linux-kernel+bounces-17249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE1824A65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59454B246A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77D02C842;
	Thu,  4 Jan 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0aNsNps"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20C2C86B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704404208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sDCSnK9oBUZzQTdNBUQHlzH3HqFpw6GuGMSwazspHUg=;
	b=X0aNsNpsdOV8dG6z2lSO5QUN/hN6+BlPqybhwXe26+jNHTYXov5lmfKbEHW+YLI6yNNP5j
	BA0d+WfBWaZG3S4wULu1oBZef9wsDtVRWEuCDWo7+5Z2kLdfyz5SfoYlXg6TWYeuqDCuk6
	tQ+JoK41pdW5vHZmj9/lPv38qCFinQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Ssa7qb_UNaS8tti_QoMq-g-1; Thu, 04 Jan 2024 16:36:47 -0500
X-MC-Unique: Ssa7qb_UNaS8tti_QoMq-g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33749dee29aso542585f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704404206; x=1705009006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDCSnK9oBUZzQTdNBUQHlzH3HqFpw6GuGMSwazspHUg=;
        b=aEdY9PNJWcvgDqMeVvkULXpZqYKoJfHPljAplu09rgK39NgVmbhnuDLVqsSF021DWh
         ShPRQMJgdytYUg7JoVl/ATnRfnVUmvgjxjH/Z4N8+DpOfXo6iNpNc6/fPCFhP+xT2NXp
         wVBlkKRHC1l3YtUr95g1i2UPC/IYcZLf9a+veF71ojvl1eOQhYBz/64PzHTM2DCEySGK
         JRLSUbvV89KuZaktCqxYqvHnu7OuiYr8qDXf+DccEO/aZr/xKfMfm0aKef35aLJ5NYx5
         Gb76lVHC31iat1QEmadPsCPNxKsD2a5MpoJ3SQhJOsmLWcgXSv3rIQZaNh8x83gjLj8h
         TEEA==
X-Gm-Message-State: AOJu0YweA2F8yxwXwK5ROuHHsUBChxqanvaMatwjdoa6jf6X5q8hR0ZM
	giw8e5z63K3DE50pMV32xIMNz2Krl9Z30NO1aSlgzmfaRKCs18+sm8PP0iN0lyoza7ad1Q0/Oqz
	RLHa+0YOiMCyyu3wR5aGgRZRZnvLkFLCL
X-Received: by 2002:a5d:4a45:0:b0:336:6dba:e092 with SMTP id v5-20020a5d4a45000000b003366dbae092mr566067wrs.3.1704404206461;
        Thu, 04 Jan 2024 13:36:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaX9w/7fjz6d++4D4EWnyo5CqA7AwWpIHFKxCu2P2XSf4LDMWJRoO1jlBVVbSLXcBabLQ4ng==
X-Received: by 2002:a5d:4a45:0:b0:336:6dba:e092 with SMTP id v5-20020a5d4a45000000b003366dbae092mr566062wrs.3.1704404206006;
        Thu, 04 Jan 2024 13:36:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c720:6400:963d:9726:6d56:aa61? (p200300cbc7206400963d97266d56aa61.dip0.t-ipconnect.de. [2003:cb:c720:6400:963d:9726:6d56:aa61])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d53c3000000b00336751cd4ebsm133342wrw.72.2024.01.04.13.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 13:36:45 -0800 (PST)
Message-ID: <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
Date: Thu, 4 Jan 2024 22:36:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-US
To: "Yin, Fengwei" <fengwei.yin@intel.com>,
 syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, syzkaller-bugs@googlegroups.com,
 Matthew Wilcox <willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.01.24 15:16, Yin, Fengwei wrote:
> 
> 
> On 1/3/2024 8:13 PM, David Hildenbrand wrote:
>> On 03.01.24 12:48, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    ab0b3e6ef50d Add linux-next specific files for 20240102
>>> git tree:       linux-next
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17be3e09e80000
>>> kernel config:
>>> https://syzkaller.appspot.com/x/.config?x=a14a6350374945f9
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=50ef73537bbc393a25bb
>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
>>> for Debian) 2.40
>>> syz repro:
>>> https://syzkaller.appspot.com/x/repro.syz?x=14e2256ee80000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b57db5e80000
>>>
>>> Downloadable assets:
>>> disk image:
>>> https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6e.raw.xz
>>> vmlinux:
>>> https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b3e6e.xz
>>> kernel image:
>>> https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b3e6e.xz
>>>
>>> The issue was bisected to:
>>>
>>> commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
>>> Author: David Hildenbrand <david@redhat.com>
>>> Date:   Wed Dec 20 22:44:31 2023 +0000
>>>
>>>       mm/rmap: convert folio_add_file_rmap_range() into
>>> folio_add_file_rmap_[pte|ptes|pmd]()
>>>
>>> bisection log:
>>> https://syzkaller.appspot.com/x/bisect.txt?x=10b9e1b1e80000
>>> final oops:
>>> https://syzkaller.appspot.com/x/report.txt?x=12b9e1b1e80000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14b9e1b1e80000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the
>>> commit:
>>> Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
>>> Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range()
>>> into folio_add_file_rmap_[pte|ptes|pmd]()")
>>>
>>>    kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
>>>    __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
>>>    kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>>    slab_post_alloc_hook mm/slub.c:3813 [inline]
>>>    slab_alloc_node mm/slub.c:3860 [inline]
>>>    kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
>>>    vm_area_alloc+0x1f/0x220 kernel/fork.c:465
>>>    mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
>>>    do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>    vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>    ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>    __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>    do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>    entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202
>>> __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>> Modules linked in:
>>> CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted
>>> 6.7.0-rc8-next-20240102-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>> BIOS Google 11/17/2023
>>> RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>> Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff
>>> e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b
>>> 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
>>> RSP: 0018:ffffc900038df978 EFLAGS: 00010293
>>> RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
>>> RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
>>> RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
>>> R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
>>> R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
>>> FS:  0000555556508380(0000) GS:ffff8880b9900000(0000)
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>    <TASK>
>>>    __folio_add_rmap mm/rmap.c:1167 [inline]
>>>    __folio_add_file_rmap mm/rmap.c:1452 [inline]
>>>    folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
>>>    insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
>>>    insert_page mm/memory.c:1900 [inline]
>>>    vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
>>>    packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
>>>    call_mmap include/linux/fs.h:2090 [inline]
>>>    mmap_region+0x745/0x2a90 mm/mmap.c:2819
>>>    do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>    vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>    ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>    __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>    do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>    entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>
>> If I am not wrong, that triggers:
>>
>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>            !folio_test_large_rmappable(folio), folio);
>>
>> So we are trying to rmap a large folio that did not go through
>> folio_prep_large_rmappable().
>>
>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed
>> in the "struct packet_ring_buffer". No idea where that comes from, but I
>> suspect it's simply some compound allocation.
> Looks like:
>    alloc_pg_vec
>      alloc_one_pg_vec_page
>           gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>                             __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
> 
>           buffer = (char *) __get_free_pages(gfp_flags, order);
> So you are right here... :).

Hm, but I wonder if this something that's supposed to work or is this 
one of the cases where we should actually use a VM_PFN mapping?

It's not a pagecache(file/shmem) page after all.

We could relax that check and document why we expect something that is 
not marked rmappable. But it fells wrong. I suspect this should be a 
VM_PFNMAP instead (like recent udmabuf changes).

-- 
Cheers,

David / dhildenb


