Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83F67AB6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjIVRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIVRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:09:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5B192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:09:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso294500866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695402587; x=1696007387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZMr1kN15ref1wUYr4E6kS3JTBkLGuuuWxsn4v7voMQ=;
        b=OX56MkhYo96iSH/9jTtGmowa0IWzk2k5Qm+D9h7oPJOjJ/+Zsko+SIn9DNNw33kZ0F
         a1NC0h7yfuFZekYPR50aSDIkD/lyzGW/pcJUXLxVvGnqplA4AxTwoqqe3X31dVef8StM
         KDrBAEzwp5I0HqGKrSRHFTrrhWlf+5wls8mZbwjU5eL8dwNEsaFxZPt/KoDmdFuIDvDv
         Tx4RYM0g/D0MzcS75yveTi1qJZgbvpkfBEEYorNb4I9V0T260/jrCtnzyVlHRd4yHkxz
         HsjgZgFPTKZB0LrQb3QDGf6/RebAJi30u5vWLYIsZtjfFNLmia/XD09ljRrFSAI8tIZC
         4/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695402587; x=1696007387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZMr1kN15ref1wUYr4E6kS3JTBkLGuuuWxsn4v7voMQ=;
        b=UkUNrkfd5UQOPokM11O37ZLMVSoWaWIzWXkQCOZjdL9Z91HHxq+HqIpr2LAtNXvw2S
         LvyS7BG5b7L2D6F7OMdHwt5fQ9HqXYfxk1FgjheKszNOSZriism6NUMoLJcYvq9NJ7rZ
         tShasc4DDSPqoZJPkhe5PZghJ5/oSovek0RFrTO6Em87j15mAf4lja1n0lqy3YBsnbV+
         atPFwpGxFpoLvSPozFNJ9KpTg7Qjxz64HXjSv76CdN9I6AWujboaQEljy+Rntkq6w2ZZ
         bYUpNaRPzt6dLpuYr4w8h2SW54xh/V8LErF7tRUuSInwsfn22PRPXEubxMJziiVCvwjT
         XXBQ==
X-Gm-Message-State: AOJu0YwWNKVRLkYx+ksS/ZACK3aBL5JJ2hp1WpGsx9DsaVABXS5z+h0i
        Q4Sz0Ib29byHjJFt02rFBk+3/k4bY62Lo8023ImmbQ==
X-Google-Smtp-Source: AGHT+IH4/kuj4pc7LLnOeIo2zssiCuHuC210f94Y24I1r6FA5L9LiUH2koVLT71RUpM7wLJf6p3XQNKYGbF6emeCse8=
X-Received: by 2002:a17:907:985b:b0:9a2:1ce5:1243 with SMTP id
 jj27-20020a170907985b00b009a21ce51243mr7710566ejc.60.1695402586369; Fri, 22
 Sep 2023 10:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230922115804.2043771-1-ryan.roberts@arm.com>
 <20230922115804.2043771-3-ryan.roberts@arm.com> <20230922161404.GA23332@willie-the-truck>
 <32052cb7-91f1-461d-a226-2cd2fcf34ad2@arm.com>
In-Reply-To: <32052cb7-91f1-461d-a226-2cd2fcf34ad2@arm.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 22 Sep 2023 10:09:08 -0700
Message-ID: <CAJHvVcgq9mJFgy=M1J546XboTu2=SWMdbQM457xUtD1kba4xew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: hugetlb: Fix set_huge_pte_at() to work with
 all swap entries
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks correct to me - thanks for the fix!

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Fri, Sep 22, 2023 at 9:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 22/09/2023 17:14, Will Deacon wrote:
> > On Fri, Sep 22, 2023 at 12:58:04PM +0100, Ryan Roberts wrote:
> >> When called with a swap entry that does not embed a PFN (e.g.
> >> PTE_MARKER_POISONED or PTE_MARKER_UFFD_WP), the previous implementatio=
n
> >> of set_huge_pte_at() would either cause a BUG() to fire (if
> >> CONFIG_DEBUG_VM is enabled) or cause a dereference of an invalid addre=
ss
> >> and subsequent panic.
> >>
> >> arm64's huge pte implementation supports multiple huge page sizes, som=
e
> >> of which are implemented in the page table with multiple contiguous
> >> entries. So set_huge_pte_at() needs to work out how big the logical pt=
e
> >> is, so that it can also work out how many physical ptes (or pmds) need
> >> to be written. It previously did this by grabbing the folio out of the
> >> pte and querying its size.
> >>
> >> However, there are cases when the pte being set is actually a swap
> >> entry. But this also used to work fine, because for huge ptes, we only
> >> ever saw migration entries and hwpoison entries. And both of these typ=
es
> >> of swap entries have a PFN embedded, so the code would grab that and
> >> everything still worked out.
> >>
> >> But over time, more calls to set_huge_pte_at() have been added that se=
t
> >> swap entry types that do not embed a PFN. And this causes the code to =
go
> >> bang. The triggering case is for the uffd poison test, commit
> >> 99aa77215ad0 ("selftests/mm: add uffd unit test for UFFDIO_POISON"),
> >> which causes a PTE_MARKER_POISONED swap entry to be set, coutesey of
> >> commit 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for
> >> hugetlbfs") - added in v6.5-rc7. Although review shows that there are
> >> other call sites that set PTE_MARKER_UFFD_WP (which also has no PFN),
> >> these don't trigger on arm64 because arm64 doesn't support UFFD WP.
> >>
> >> Arguably, the root cause is really due to commit 18f3962953e4 ("mm:
> >> hugetlb: kill set_huge_swap_pte_at()"), which aimed to simplify the
> >> interface to the core code by removing set_huge_swap_pte_at() (which
> >> took a page size parameter) and replacing it with calls to
> >> set_huge_pte_at() where the size was inferred from the folio, as
> >> descibed above. While that commit didn't break anything at the time, i=
t
> >> did break the interface because it couldn't handle swap entries withou=
t
> >> PFNs. And since then new callers have come along which rely on this
> >> working. But given the brokeness is only observable after commit
> >> 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs"),
> >> that one gets the Fixes tag.
> >>
> >> Now that we have modified the set_huge_pte_at() interface to pass the
> >> huge page size in the previous patch, we can trivially fix this issue.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for huget=
lbfs")
> >> Cc: <stable@vger.kernel.org> # 6.5+
> >> ---
> >>  arch/arm64/mm/hugetlbpage.c | 17 +++--------------
> >>  1 file changed, 3 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >> index a7f8c8db3425..13fd592228b1 100644
> >> --- a/arch/arm64/mm/hugetlbpage.c
> >> +++ b/arch/arm64/mm/hugetlbpage.c
> >> @@ -241,13 +241,6 @@ static void clear_flush(struct mm_struct *mm,
> >>      flush_tlb_range(&vma, saddr, addr);
> >>  }
> >>
> >> -static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t e=
ntry)
> >> -{
> >> -    VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry)=
);
> >> -
> >> -    return page_folio(pfn_to_page(swp_offset_pfn(entry)));
> >> -}
> >> -
> >>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> >>                          pte_t *ptep, pte_t pte, unsigned long sz)
> >>  {
> >> @@ -257,13 +250,10 @@ void set_huge_pte_at(struct mm_struct *mm, unsig=
ned long addr,
> >>      unsigned long pfn, dpfn;
> >>      pgprot_t hugeprot;
> >>
> >> -    if (!pte_present(pte)) {
> >> -            struct folio *folio;
> >> -
> >> -            folio =3D hugetlb_swap_entry_to_folio(pte_to_swp_entry(pt=
e));
> >> -            ncontig =3D num_contig_ptes(folio_size(folio), &pgsize);
> >> +    ncontig =3D num_contig_ptes(sz, &pgsize);
> >>
> >> -            for (i =3D 0; i < ncontig; i++, ptep++)
> >> +    if (!pte_present(pte)) {
> >> +            for (i =3D 0; i < ncontig; i++, ptep++, addr +=3D pgsize)
> >>                      set_pte_at(mm, addr, ptep, pte);
> >
> > Our set_pte_at() doesn't use 'addr' for anything and the old code didn'=
t
> > even bother to increment it here! I'm fine adding that, but it feels
> > unrelated to the issue which this patch is actually fixing.
>
> True. I agree its not strictly necessary and will presumably be optimized=
 out.
> But I'm not sure that having knowledge that the implementation doesn't us=
e it is
> a good reason not to call the interface correctly. I'll leave it as I've =
done it
> if that's ok.
>
> >
> > Either way:
> >
> > Acked-by: Will Deacon <will@kernel.org>
>
> Thanks!
>
> >
> > Will
>
