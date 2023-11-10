Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341437E77E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbjKJDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:13:56 -0500
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE6044B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:13:53 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-4a-654d9ff040e6
Date:   Fri, 10 Nov 2023 12:13:47 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231110031347.GA62514@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <20231108041208.GA40954@system.software.com>
 <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
 <20231110010201.GA72073@system.software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110010201.GA72073@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnoe6H+b6pBnvvK1rMWb+GzeLzhn9s
        Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
        2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
        jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXxpxX
        h9kKTkhXNG9+zdzA+FK4i5GTQ0LAROLWlglsMPbJX1cYQWwWAVWJ47s3gMXZBNQlbtz4yQxi
        iwgoShzafw+shlngHavE90+aILawQLTEp72v2EFsXgELiaeLj7J0MXJxCAlcY5JY+7eJFSIh
        KHFy5hMWiGZ1iT/zLgEN5QCypSWW/+OACMtLNG+dDbaLU8BS4lrvMrCZogLKEge2HWcCmSkh
        sI1d4mDPaxaIoyUlDq64wTKBUXAWkhWzkKyYhbBiFpIVCxhZVjEKZeaV5SZm5pjoZVTmZVbo
        JefnbmIERu2y2j/ROxg/XQg+xCjAwajEw3vhuk+qEGtiWXFl7iFGCQ5mJRHeCyZAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYxNjYbl//kLDX4zKNwU
        l/at681orb/xaP6n7CwxiY3ty34d4E/RXjfzrV/FzC07Nh26y2wQPdt6+1cZ+3nbVr+4bq91
        9NPyyBkKBxPPBaZd+pZa/j84sMjyn6XIpTv7+PfzCLTvmsG0ieMai4fjgU27dk71V9q643vp
        N9aLCz8URZRKy7Ls6jJXYinOSDTUYi4qTgQAZbBX49YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC5WfdrPthvm+qwbSv/BZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
        HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
        Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2wei198YPLY+svO4/MmOY9389+yBfBHcdmkpOZk
        lqUW6dslcGXMeXWYreCEdEXz5tfMDYwvhbsYOTkkBEwkTv66wghiswioShzfvYENxGYTUJe4
        ceMnM4gtIqAocWj/PbAaZoF3rBLfP2mC2MIC0RKf9r5iB7F5BSwkni4+ytLFyMUhJHCNSWLt
        3yZWiISgxMmZT1ggmtUl/sy7BDSUA8iWllj+jwMiLC/RvHU22C5OAUuJa73LwGaKCihLHNh2
        nGkCI98sJJNmIZk0C2HSLCSTFjCyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAiMwWW1fybu
        YPxy2f0QowAHoxIP74XrPqlCrIllxZW5hxglOJiVRHgvmACFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGFlPRPgkJkdffv73SeLkpT/NlzOs0vOx/Lh2
        hnpDnVx2GM/Hnj15Vx6mezDP1Hxf1SB86M+/lfY1+o8U5jH93VcS73A+ff2OOTOnnc4N7fRQ
        qQk4/rjHMaQw6UjEtNkM7Epyrbsa2G+dKs7SSTu9XfCq18aMNFk9qV3qzq//HqnfaVrb/Gxq
        lRJLcUaioRZzUXEiAAtQmiu9AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 10:02:01AM +0900, Byungchul Park wrote:
> On Thu, Nov 09, 2023 at 10:16:57AM +0000, Nadav Amit wrote:
> > 
> > 
> > > On Nov 8, 2023, at 6:12 AM, Byungchul Park <byungchul@sk.com> wrote:
> > > 
> > > !! External Email
> > > 
> > > On Mon, Oct 30, 2023 at 09:51:30PM +0900, Byungchul Park wrote:
> > >>>> diff --git a/mm/memory.c b/mm/memory.c
> > >>>> index 6c264d2f969c..75dc48b6e15f 100644
> > >>>> --- a/mm/memory.c
> > >>>> +++ b/mm/memory.c
> > >>>> @@ -3359,6 +3359,19 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > >>>>  if (vmf->page)
> > >>>>          folio = page_folio(vmf->page);
> > >>>> 
> > >>>> + /*
> > >>>> +  * This folio has its read copy to prevent inconsistency while
> > >>>> +  * deferring TLB flushes. However, the problem might arise if
> > >>>> +  * it's going to become writable.
> > >>>> +  *
> > >>>> +  * To prevent it, give up the deferring TLB flushes and perform
> > >>>> +  * TLB flush right away.
> > >>>> +  */
> > >>>> + if (folio && migrc_pending_folio(folio)) {
> > >>>> +         migrc_unpend_folio(folio);
> > >>>> +         migrc_try_flush_free_folios(NULL);
> > >>> 
> > >>> So many potential function calls… Probably they should have been combined
> > >>> into one and at least migrc_pending_folio() should have been an inline
> > >>> function in the header.
> > >> 
> > >> I will try to change it as you mention.
> > >> 
> > >>>> + }
> > >>>> +
> > >>> 
> > >>> What about mprotect? I thought David has changed it so it can set writable
> > >>> PTEs.
> > >> 
> > >> I will check it out.
> > > 
> > > I found mprotect stuff is already performing TLB flushes needed for it.
> > > So some redundant TLB flushes might happen by migrc but it's not that
> > > harmful I think. Thanks.
> > 
> > Let me explain the scenario I am concerned with. Assume page P is RO, and
> > moves from Psrc to Pdst. Pointer “p” points to P. Initially (*p == 0).
> > 
> > Let’s also assume we also have an atomic variable “a”. Initially (a == 0).
> > 
> > I hope I got the migration function names right, but I hope the problem
> > itself can be clear regardless. 
> > 
> > CPU0			CPU1			CPU2		CPU3
> > ----			----			----		----
> > 			(user-mode)		(user-mode)		
> > 
> > 			Access *p
> > 			[Psrc cached in TLB]
> >  
> > migrate_pages_batch()
> > -> migrate_folio_unmap()
> > 
> > [ PTE updated, 
> >   still no flush ]
> > 
> > 								mprotect(p,
> > 									RW)
> 
> Here,
> 
> mprotect()
>    do_mprotect_pkey()
>       tlb_finish_mmu()
>          tlb_flush_mmu()
> 
> I thought TLB flush for mprotect() is performed by tlb_flush_mmu() so
> any cached TLB entries on other CPUs can have chance to update. Could
> you correct me if I get it wrong? Thanks.

I guess you tried to inform me that x86 mmu automatically keeps the
consistancy based on cached TLB entries. Right? If yes, I should do
something on that path. If not, it's not problematic. Thoughts?

	Byungchul

> 	Byungchul
> 
> > 
> > 								[ Psrc is
> > 								  RW ]
> > 
> > 								[ flush
> > 								  deferred]
> > 
> > 
> > 						*p = 1  # Pdst
> > 						
> > 						xchg(&a, 1)
> > 			mfence
> > 			if (a == 1)
> > 			  assert(*p == 1);
> > 
> > 
> > 				
> > Now at this point the assertion might fail. CPU2 wrote into Pdst, whereas
> > CPU1 reads from Psrc. But based on x86 memory model, userspace might not
> > expect this scenario to be possible, hence leading to bugs.
