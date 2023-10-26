Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BF7D7C95
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJZFym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjJZFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:54:39 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275A1A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:54:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-457d9ffc9d2so336722137.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299672; x=1698904472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45UXuM2P3WPMuxY2JWYfx99wJ2INudmhZ7TG9Hdnc2s=;
        b=ckRxFZf1XGu5TZA8aNaKzG7lEtjroqy9zsrvmQlUtQZm5gDygIoF+ZDISp0UdEyrQH
         MmrOOAB4MKXYVi6VveMzf/0DR59LE1Uy6L2jMyFXxrP9/fqrkMDWd/GA6zsp3YZanP9O
         HgJNNFpr8sATlugRSzsJqnymHXf+RZuoD8kgm1eSiF1VQZIttMZp6OR/eH5Jlc79uRi+
         cd+DKL5sy9zFLq0kgaZKbhYmRZLPjTjDWv5tpc53IRNP7RfphCBezKOUZydpO1DtQZVK
         yq4BvPXujpQKr6hLcAqG13g0u3MzHpu9JVb2ak1R0+usI1yn8R5wJXfZaXEf0wt0mh5e
         /FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299672; x=1698904472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45UXuM2P3WPMuxY2JWYfx99wJ2INudmhZ7TG9Hdnc2s=;
        b=vyPWZvGgU3nGy4PRoD3KwGrgfuUUSHcaEzGkyFvlyuItvBGYLKpBnT4d333+YxdHWh
         oV5TJnrDLfGSv+jfF7TFNrKKcDdYbpgAmi6WPcrJv7iLSL3LcDu0+sORyOouK4UdM7I9
         Lo1cqOlojB/+JUTw7hl9GbYmilMtrNs/GIJ6NqjKw9BQN1rLSFGmMHLWM7gOc3IdN3vj
         SmT7/b64NhlYucG1wVcjQ3baFLF0t3UyEHl+KLPmiwQkRxbEqAoskZzYl4sgGYG7Xse6
         NENVDvVj8r0QbCWydKG56TCuU2g0pgif5azOdJIhL+czYnZWcVuSc1B5Xa4VXiY8cuy7
         R72Q==
X-Gm-Message-State: AOJu0Yw1WDyvbVGkgw+Fd2G8lxl2ZoZiuPhJOCyEi1FyCODT79MQ7bWr
        oaGGt0dfHiAQx1od/TGBYTQDxnBtgNLTaew6Cpg=
X-Google-Smtp-Source: AGHT+IGzx8+MJHNaJIX3ZzoPMyVBD6h6GTZ59voKrLxouXBcB3JpBl5ekWfYJGvTAcP3/wftECBcXqmaX5IqCBPfiV8=
X-Received: by 2002:a05:6102:10de:b0:457:c425:a696 with SMTP id
 t30-20020a05610210de00b00457c425a696mr1016115vsr.4.1698299672234; Wed, 25 Oct
 2023 22:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <2f55f62b-cae2-4eee-8572-1b662a170880@arm.com>
In-Reply-To: <2f55f62b-cae2-4eee-8572-1b662a170880@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 26 Oct 2023 13:54:19 +0800
Message-ID: <CAGsJ_4xuH_mftf_8fV12o_Xuvp9gG8ySQq_P0JAyZH=6c66hEA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:55=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 10/24/23 18:26, Baolin Wang wrote:
> > Now ptep_clear_flush_young() is only called by folio_referenced() to
> > check if the folio was referenced, and now it will call a tlb flush on
> > ARM64 architecture. However the tlb flush can be expensive on ARM64
> > servers, especially for the systems with a large CPU numbers.
>
> TLB flush would be expensive on *any* platform with large CPU numbers ?
>
> >
> > Similar to the x86 architecture, below comments also apply equally to
> > ARM64 architecture. So we can drop the tlb flush operation in
> > ptep_clear_flush_young() on ARM64 architecture to improve the performan=
ce.
> > "
> > /* Clearing the accessed bit without a TLB flush
> >  * doesn't cause data corruption. [ It could cause incorrect
> >  * page aging and the (mistaken) reclaim of hot pages, but the
> >  * chance of that should be relatively low. ]
> >  *
> >  * So as a performance optimization don't flush the TLB when
> >  * clearing the accessed bit, it will eventually be flushed by
> >  * a context switch or a VM operation anyway. [ In the rare
> >  * event of it not getting flushed for a long time the delay
> >  * shouldn't really matter because there's no real memory
> >  * pressure for swapout to react to. ]
> >  */
>
> If always true, this sounds generic enough for all platforms, why only
> x86 and arm64 ?
>
> > "
> > Running the thpscale to show some obvious improvements for compaction
> > latency with this patch:
> >                              base                   patched
> > Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
> > Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
> > Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
> > Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
> > Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
> > Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
> > Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
> > Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
> > Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
> >                        base       patched
> > Duration User         167.78      161.03
> > Duration System      1836.66     1673.01
> > Duration Elapsed     2074.58     2059.75
>
> Could you please point to the test repo you are running ?
>
> >
> > Barry Song submitted a similar patch [1] before, that replaces the
> > ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
> > folio_referenced_one(). However, I'm not sure if removing the tlb flush
> > operation is applicable to every architecture in kernel, so dropping
> > the tlb flush for ARM64 seems a sensible change.
>
> The reasoning provided here sounds generic when true, hence there seems
> to be no justification to keep it limited just for arm64 and x86. Also
> what about pmdp_clear_flush_young_notify() when THP is enabled. Should
> that also not do a TLB flush after clearing access bit ? Although arm64
> does not enable __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH, rather depends on
> the generic pmdp_clear_flush_young() which also does a TLB flush via
> flush_pmd_tlb_range() while clearing the access bit.
>
> >
> > Note: I am okay for both approach, if someone can help to ensure that
> > all architectures do not need the tlb flush when clearing the accessed
> > bit, then I also think Barry's patch is better (hope Barry can resend
> > his patch).
>
> This paragraph belongs after the '----' below and not part of the commit
> message.
>
> >
> > [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail.=
com/
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 0bd18de9fd97..2979d796ba9d 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struc=
t vm_area_struct *vma,
> >  static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> >                                        unsigned long address, pte_t *pt=
ep)
> >  {
> > -     int young =3D ptep_test_and_clear_young(vma, address, ptep);
> > -
> > -     if (young) {
> > -             /*
> > -              * We can elide the trailing DSB here since the worst tha=
t can
> > -              * happen is that a CPU continues to use the young entry =
in its
> > -              * TLB and we mistakenly reclaim the associated page. The
> > -              * window for such an event is bounded by the next
> > -              * context-switch, which provides a DSB to complete the T=
LB
> > -              * invalidation.
> > -              */
> > -             flush_tlb_page_nosync(vma, address);
> > -     }
> > -
> > -     return young;
> > +     /*
> > +      * This comment is borrowed from x86, but applies equally to ARM6=
4:
> > +      *
> > +      * Clearing the accessed bit without a TLB flush doesn't cause
> > +      * data corruption. [ It could cause incorrect page aging and
> > +      * the (mistaken) reclaim of hot pages, but the chance of that
> > +      * should be relatively low. ]
> > +      *
> > +      * So as a performance optimization don't flush the TLB when
> > +      * clearing the accessed bit, it will eventually be flushed by
> > +      * a context switch or a VM operation anyway. [ In the rare
> > +      * event of it not getting flushed for a long time the delay
> > +      * shouldn't really matter because there's no real memory
> > +      * pressure for swapout to react to. ]
> > +      */
> > +     return ptep_test_and_clear_young(vma, address, ptep);
> >  }
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
> There are three distinct concerns here
>
> 1) What are the chances of this misleading existing hot page reclaim proc=
ess
> 2) How secondary MMU such as SMMU adapt to change in mappings without a f=
lush
> 3) Could this break the architecture rule requiring a TLB flush after acc=
ess
>    bit clear on a page table entry

In terms of all of above concerns,  though 2 is different, which is an
issue between
cpu and non-cpu,
i feel kernel has actually dropped tlb flush at least for mglru, there
is no flush in
lru_gen_look_around(),

static bool folio_referenced_one(struct folio *folio,
                struct vm_area_struct *vma, unsigned long address, void *ar=
g)
{
        ...

                if (pvmw.pte) {
                        if (lru_gen_enabled() &&
                            pte_young(ptep_get(pvmw.pte))) {
                                lru_gen_look_around(&pvmw);
                                referenced++;
                        }

                        if (ptep_clear_flush_young_notify(vma, address,
                                                pvmw.pte))
                                referenced++;
                }

        return true;
}

and so is in walk_pte_range() of vmscan.  linux has been surviving with
all above concerns for a while, believing it or not :-)

Thanks
Barry
