Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8058C7C021C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjJJRBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjJJRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:01:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3494
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:01:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3231dff4343so29385f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696957285; x=1697562085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UedTWOigHlMvbjw9L2/ZKDZgaAgA7T2ZbalaNnedvY=;
        b=lOBGGzoTOmZiDcu7T6V9z17eLGS5QFwvx1n5nNotXEAPTu86nKWrCEZTzxW6vVEKge
         mwcUAMoo2LL6sCyAgEavmxb2xd2gCWHJiwOiTEQc22sXt53jOZoliZih45nN0bYQxujg
         ztBTLGf5luws9Ny8XnxO+Ox7lDsHbs2jR938zmFUHIsIdRIMWADAs+sz81t3vILeKjD4
         F1F4eOjyKIs/+xBFrWnNbDLjBU/SSCV2REYNBmoY7x4eIeHUW2LVnY1B0KY3/uRMT1eu
         dQhMZTHfdjQbt/nuPM01X17b+MQZqmZJfRgvy1+tsYTdpk1wmamoVO0iM+aEb807D+Qw
         Ec0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957285; x=1697562085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UedTWOigHlMvbjw9L2/ZKDZgaAgA7T2ZbalaNnedvY=;
        b=LHT7dH+djTbd5NZUm3Z1E2L8UEhBdpVMeHXsu+kKrtxJOoiAn5k4yQXBs8gOwu21ef
         L2EtBia2DNLuwj++FeJPVBmdyFzJHsKM6LWxDTLGuRzoJ9CYhMl9lffPWk9uwekNhrho
         PLTEdd67mn3EMRr/q6k8ihQmMaC0/KZM8OC6i2zM561mAi1Xoacjpri38u46r0zSc3DZ
         cq/BWI7pUCiRQUCxxBjcV9fw03OI1hrp7t0LEqLfb0MSVmy78OPCwxHsPamoYvpUxN4U
         4U5Ar5j6MCSuSNkNxr48UDWwh6buNvtEeOAuRLrd/GUHpLSADYZ/RfveYb2XP4HkYvf4
         WOvw==
X-Gm-Message-State: AOJu0Yx5wpipPEl9FrZxbeqDAJNVvX4IWH9DgHs5KU6TqcY/0PT225Fa
        F8b/ia20Gc0tzzzQgQoNxCybYNcr/gM+G0Msssw=
X-Google-Smtp-Source: AGHT+IFSeO9aC0SmT/p48t7Ny0Ng06fLg3I9jSu7tyfPX7GoKbPaa/NmSpZTA8FDU2RqIFgvVJqjDg==
X-Received: by 2002:adf:ec4d:0:b0:323:3336:b6ea with SMTP id w13-20020adfec4d000000b003233336b6eamr13612018wrn.27.1696957284844;
        Tue, 10 Oct 2023 10:01:24 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b5c7:0:4c48:be29:750e:6e92? ([2a02:6b6a:b5c7:0:4c48:be29:750e:6e92])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc7c5000000b00401bbfb9b2bsm954wmk.0.2023.10.10.10.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 10:01:24 -0700 (PDT)
Message-ID: <6b1d9860-3581-0b99-4fb7-4c1f5a2a05f3@bytedance.com>
Date:   Tue, 10 Oct 2023 18:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH] mm: hugetlb: Only prep and add allocated
 folios for non-gigantic pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
Content-Language: en-US
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20231010012345.GA108129@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 02:23, Mike Kravetz wrote:
> On 10/09/23 15:56, Usama Arif wrote:
>> Calling prep_and_add_allocated_folios when allocating gigantic pages
>> at boot time causes the kernel to crash as folio_list is empty
>> and iterating it causes a NULL pointer dereference. Call this only
>> for non-gigantic pages when folio_list has entires.
> 
> Thanks!
> 
> However, are you sure the issue is the result of iterating through a
> NULL list?  For reference, the routine prep_and_add_allocated_folios is:
> 

Yes, you are right, it wasnt an issue with the list, but the lock. If I 
do the below diff it boots.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 73803d62066a..f428af13e98a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2178,18 +2178,19 @@ static struct folio 
*alloc_fresh_hugetlb_folio(struct hstate *h,
  static void prep_and_add_allocated_folios(struct hstate *h,
                                         struct list_head *folio_list)
  {
+       unsigned long flags;
         struct folio *folio, *tmp_f;

         /* Send list for bulk vmemmap optimization processing */
         hugetlb_vmemmap_optimize_folios(h, folio_list);

         /* Add all new pool pages to free lists in one lock cycle */
-       spin_lock_irq(&hugetlb_lock);
+       spin_lock_irqsave(&hugetlb_lock, flags);
         list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
                 __prep_account_new_huge_page(h, folio_nid(folio));
                 enqueue_hugetlb_folio(h, folio);
         }
-       spin_unlock_irq(&hugetlb_lock);
+       spin_unlock_irqrestore(&hugetlb_lock, flags);
  }

  /*


FYI, this was an x86 VM with kvm enabled.

Thanks,
Usama

> static void prep_and_add_allocated_folios(struct hstate *h,
> 					struct list_head *folio_list)
> {
> 	struct folio *folio, *tmp_f;
> 
> 	/* Add all new pool pages to free lists in one lock cycle */
> 	spin_lock_irq(&hugetlb_lock);
> 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
> 		__prep_account_new_huge_page(h, folio_nid(folio));
> 		enqueue_hugetlb_folio(h, folio);
> 	}
> 	spin_unlock_irq(&hugetlb_lock);
> }
> 
> If folio_list is empty, then the only code that should be executed is
> acquiring the lock, notice the list is empty, release the lock.
> 
> In the case of gigantic pages addressed below, I do see the warning:
> 
> [    0.055140] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
> [    0.055149] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4345 lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055153] Modules linked in:
> [    0.055155] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc4+ #40
> [    0.055157] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> [    0.055158] RIP: 0010:lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055160] Code: 00 85 c0 0f 84 5e ff ff ff 8b 0d a7 20 74 01 85 c9 0f 85 50 ff ff ff 48 c7 c6 48 25 42 82 48 c7 c7 70 7f 40 82 e8 18 10 f7 ff <0f> 0b 5b e9 e0 d8 af 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [    0.055162] RSP: 0000:ffffffff82603d40 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
> [    0.055164] RAX: 0000000000000000 RBX: ffffffff827911e0 RCX: 0000000000000000
> [    0.055165] RDX: 0000000000000004 RSI: ffffffff8246b3e1 RDI: 00000000ffffffff
> [    0.055166] RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
> [    0.055166] R10: ffffffffffffffff R11: 284e4f5f4e524157 R12: 0000000000000001
> [    0.055167] R13: ffffffff82eb6316 R14: ffffffff82603d70 R15: ffffffff82ee5f70
> [    0.055169] FS:  0000000000000000(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
> [    0.055170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.055171] CR2: ffff88847ffff000 CR3: 000000000263a000 CR4: 00000000000200b0
> [    0.055174] Call Trace:
> [    0.055174]  <TASK>
> [    0.055175]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055177]  ? __warn+0x81/0x170
> [    0.055181]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055182]  ? report_bug+0x18d/0x1c0
> [    0.055186]  ? early_fixup_exception+0x92/0xb0
> [    0.055189]  ? early_idt_handler_common+0x2f/0x40
> [    0.055194]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055196]  trace_hardirqs_on+0x10/0xa0
> [    0.055198]  _raw_spin_unlock_irq+0x24/0x50
> [    0.055201]  hugetlb_hstate_alloc_pages+0x311/0x3e0
> [    0.055206]  hugepages_setup+0x220/0x2c0
> [    0.055210]  unknown_bootoption+0x98/0x1d0
> [    0.055213]  parse_args+0x152/0x440
> [    0.055216]  ? __pfx_unknown_bootoption+0x10/0x10
> [    0.055220]  start_kernel+0x1af/0x6c0
> [    0.055222]  ? __pfx_unknown_bootoption+0x10/0x10
> [    0.055225]  x86_64_start_reservations+0x14/0x30
> [    0.055227]  x86_64_start_kernel+0x74/0x80
> [    0.055229]  secondary_startup_64_no_verify+0x166/0x16b
> [    0.055234]  </TASK>
> [    0.055235] irq event stamp: 0
> [    0.055236] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.055238] hardirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.055239] softirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.055240] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.055240] ---[ end trace 0000000000000000 ]---
> 
> This is because interrupts are not enabled this early in boot, and the
> spin_unlock_irq() would incorrectly enable interrupts too early.  I wonder
> if this 'warning' could translate to a panic or NULL deref under certain
> configurations?
> 
> Konrad, I am interested to see if this addresses your booting problem.  But,
> your stack trace is a bit different.  My 'guess' is that this will not address
> your issue.  If it does not, can you try the following patch?  This
> applies to next-20231009.
