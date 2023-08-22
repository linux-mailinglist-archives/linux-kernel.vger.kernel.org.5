Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34804784971
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHVSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHVSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:34:33 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD6CD8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:34:31 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d40c2debeso53744717b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692729270; x=1693334070;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WMcORuWW+xF6gY7IBQ8Ihi596ledfzVY2HvWzF69bs=;
        b=bVTuVrcGgDo+SJA4P/hqb5H6xSd8MjD7Ssb+fMuazzFA3RYDdO+Fd9IJECACVc1jxX
         McaUm35ext3KtxZ81I4e0oJUZiIMsJMFUj/dISIy8Z74mU6Fv2f80D9ACZ/qgstEp8C3
         dz/3aairaENuzDbobljPrqtuBskwI56lb5nqo3i2CLhXIBQlC0YZY23Jv356UjgetMia
         NHGQqBKQ20oaS2gVAT2pZYOwN8E7FExt8MbK/p05hoSd1swhCWvI5WPhdTLMWUQY4Nk5
         ZcyYBss0xQeF26Dv7c2xX0FJXsI2PMUhWahmGyRBaLEDB8wNdKrE3OKxjNgMxLnHwhf1
         7PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692729270; x=1693334070;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WMcORuWW+xF6gY7IBQ8Ihi596ledfzVY2HvWzF69bs=;
        b=NMPsjkRViIN/sX4h4qdfHlz1O4I0qadNMcxfauMxcK0r+6YSMU+zblZXukl8ZOGGwx
         puXZrJfrqmOZ5Oouny9/fFepSu2mBu/QmkyGUeiIjxliO0J4sxMJz+KFX9Pcz0Ua+kb6
         LI+puGOi2FaitlROSOIBqiHacomJkTl1iBBBghE6IXujAH6Y2vOco87m94kcUhHO/y8E
         thKkAY8LsAwmk5TSaHJxtm+vpSaf3Cz0V70hE8uKY8Lmgbh1VqpSpW+QtmC9G57VpNNV
         9EDyd6nOWkEXzuoV8pVSJK9BYO2yS83AezwkEFctFP4Lv+JoCSdPmdyRb8a1Rpb0L86T
         umPQ==
X-Gm-Message-State: AOJu0Yx3Km0BGiXAq2xQD9SDMNmHhxB6NK70YeJcTVKu9W/ujR06SAqO
        JFt1T4HuutjVhA3O/B8nMmzJJA==
X-Google-Smtp-Source: AGHT+IHKsobp5e7zqoup7VzvHJTcsGRbS8zrGrBX3SoF5xm7qcy+ngOpN9zqdPkzqj75WfGQt5eHpQ==
X-Received: by 2002:a81:6009:0:b0:582:5527:ddc with SMTP id u9-20020a816009000000b0058255270ddcmr10163921ywb.34.1692729270534;
        Tue, 22 Aug 2023 11:34:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j1-20020a0dc701000000b0058ddb62f99bsm2956436ywd.38.2023.08.22.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:34:29 -0700 (PDT)
Date:   Tue, 22 Aug 2023 11:34:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
In-Reply-To: <ZOTGvfO31pleXrPF@x1n>
Message-ID: <1b7c7056-d742-86bf-fec-fdb024b2381@google.com>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com> <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com> <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com> <ZOTGvfO31pleXrPF@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023, Peter Xu wrote:
> On Mon, Aug 21, 2023 at 07:51:38PM -0700, Hugh Dickins wrote:
> > On Mon, 21 Aug 2023, Jann Horn wrote:
...
> > > 
> > > I guess an alternative would be to use a spin_trylock() instead of the
> > > current pmd_lock(), and if that fails, temporarily drop the page table
> > > lock and then restart from step 2 with both locks held - and at that
> > > point the page table scan should be fast since we expect it to usually
> > > be empty.
> > 
> > That's certainly a good idea, if collapse on userfaultfd_armed private
> > is anything of a common case (I doubt, but I don't know).  It may be a
> > better idea anyway (saving a drop and retake of ptlock).
> > 
> > I gave it a try, expecting to end up with something that would lead
> > me to say "I tried it, but it didn't work out well"; but actually it
> > looks okay to me.  I wouldn't say I prefer it, but it seems reasonable,
> > and no more complicated (as Peter rightly observes) than the original.
> > 
> > It's up to you and Peter, and whoever has strong feelings about it,
> > to choose between them: I don't mind (but I shall be sad if someone
> > demands that I indent that comment deeper - I'm not a fan of long
> > multi-line comments near column 80).
> 
> No strong opinion here, either.  Just one trivial comment/question below on
> the new patch (if that will be preferred)..

I'm going to settle for the original v1 for now (I'll explain why in reply
to Jann next) - which already has the blessing of your Acked-by, thanks.

(Yes, the locking is a bit confusing: but mainly for the unrelated reason,
that with the split locking configs, we never quite know whether this lock
is the same as that lock or not, and so have to be rather careful.)

> > [PATCH mm-unstable v2] mm/khugepaged: fix collapse_pte_mapped_thp() versus uffd
...
> > @@ -1572,9 +1572,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> >  				haddr, haddr + HPAGE_PMD_SIZE);
> >  	mmu_notifier_invalidate_range_start(&range);
> >  	notified = true;
> > -	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
> > -	if (!start_pte)		/* mmap_lock + page lock should prevent this */
> > -		goto abort;
> > +	spin_lock(ptl);
> 
> .. here will the ptl always be valid?
> 
> That comes from the previous round of pte_offset_map_lock(), and I assume
> after this whole "thp collapse without write lock" work landed, it has the
> same lifecycle with the *pte pointer, so can be invalid right after the rcu
> read lock released; mmap read lock isn't strong enough to protect the ptl,
> not anymore.
> 
> Maybe it's all fine because the thp collapse path is the solo path(s) that
> will release the pte pgtable page without write mmap lock (so as to release
> the ptl too when doing so), and we at least still hold the page lock, so
> the worst case is the other concurrent "thp collapse" will still serialize
> with this one on the huge page lock. But that doesn't look as solid as
> fetching again the ptl from another pte_offset_map_nolock().  So still just
> raise this question up.  It's possible I just missed something.

It is safe, as you say because of us holding the hpage lock, which stops
any racing callers of collapse_pte_mapped_thp() or retract_page_tables():
and these are the functions which (currently) make the *pmd transition
which pte_offset_map_lock() etc. are being careful to guard against.

[In future we can imagine empty page table removal making that transition
too: and that wouldn't even have any hpage to lock.  Will it rely on
mmap_lock for write? or pmd_lock? probably both, but no need to design
for it now.]

But I agree that it does *look* more questionable in this patch: there was
a reassuring pte_offset_map_lock() there before, and now I rely more on
the assumptions and just use the "previous" ptl (and that's why I chose
to make the !start_pte case a VM_BUG_ON a few lines later).

I expect, with more time spent, I could cast it back into more reassuring
form: but it's all a bit of a con trick - if you look further down (even
before v2 or v1 fixes) to "step 4", there we have "if (ptl != pml)" which
is also relying on the fact that ptl cannot have changed.  And no doubt
that too could be recast into more reassuring-looking form, but it
wouldn't actually be worthwhile.

Thanks for considering these, Peter: I'll recommend v1 to Andrew.

Hugh
