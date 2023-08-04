Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B4770838
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHDSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHDSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:54:04 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F9A9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:54:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40c72caec5cso42791cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691175240; x=1691780040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Iv3ZbFZXxTn6bj3cpgPipysojN6fAh0+JwwOE06Kw=;
        b=wjGo7rSj+i6Bs/UNtdlde/sd1Mq9mp37tmiUvBSnceyDyZKN846Kzcs00eYcJ9I+ph
         S3N9cZb5nkwGXCaAOjwDm9+ZBNuIRarQz0AmtHSUojcwpobgGUOS+ewUuOBcNrAW5VL6
         xKLcTAfDms49dF635hPobBU4ZvnPAG7vnJFRdIvc+6LSWCMuLFTM2tn5oAqD7tkR6k+v
         RrzHKRfYLbQBRz3Mes/q21ToOH/+7EmAyqNTiXvcsuMG/Wjfux1WGGjRFLpFAFQ+W8ro
         ihXnpROYcaFgnleIrOIDSOvTAS39NNazazWpUKEIrF5QeYe0bnRHOncsHnuckVsgxRr+
         0tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691175240; x=1691780040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4Iv3ZbFZXxTn6bj3cpgPipysojN6fAh0+JwwOE06Kw=;
        b=lilj06e7o2w3Bnd8Pi4UwSUGRj7PRdsse6Ty5YNX4/9Z0sBxnRd6+96sWcs/AANdf6
         hWKGrlg5Yos+vu510UoXv4brsrEbYKGjQWg8N6Yph/VNxr1x4pQuOTweumscA6QV/5Up
         bP0ZdSZ0IuJP0LWyP7FyXMuRPvhkBfiVD5VuGA35gnJdmktQoCStmkhPJ/xTSqx0ptF6
         vmILn3ptdCitJaoomxP1zaCL0pJzzAwDZJpUL4IBCxkuAya5ou/Qdoeiq87i0epkbrG1
         c4iEw09PHwzEKod8/eC0Vrn89bcZkymhjrebPpKxSh7gc1k8BqauNk40OIjPSwN0lqqS
         p/Ew==
X-Gm-Message-State: AOJu0YzW/OEhpXZpGHfPi+1gExLgwzUbGgIveeAi1jqypHv8huLSBTMs
        MVhCipW/1mGdp64fzEnkTozS1NAi5TQTHJUw1FKGqA==
X-Google-Smtp-Source: AGHT+IF4kBqrD0Jx9hYyNBB552STJTQlldRK8pML3S52aFJ7LecDujCj07InXaFAR4pVwMfwjtz2C0jUqCPnvutsm9k=
X-Received: by 2002:ac8:4e89:0:b0:3fa:3c8f:3435 with SMTP id
 9-20020ac84e89000000b003fa3c8f3435mr24678qtp.27.1691175239661; Fri, 04 Aug
 2023 11:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <20230803142154.nvgkavg33uyn6f72@box.shutemov.name> <CAOUHufZWTdpF0vdPkyOafVNFOOY7Wui+Q-O83=SZcfv4KZcHbg@mail.gmail.com>
 <b98b0f69-f469-b445-2c51-aa2f85da07b6@arm.com>
In-Reply-To: <b98b0f69-f469-b445-2c51-aa2f85da07b6@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 4 Aug 2023 12:53:23 -0600
Message-ID: <CAOUHufYQTcOdKU=1mPq-fdLV7a66sHx1=EJpPpMVogciCNKO9A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 4, 2023 at 3:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/08/2023 01:19, Yu Zhao wrote:
> > On Thu, Aug 3, 2023 at 8:27=E2=80=AFAM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >>
> >> On Thu, Aug 03, 2023 at 01:43:31PM +0100, Ryan Roberts wrote:
> >>> + Kirill
> >>>
> >>> On 26/07/2023 10:51, Ryan Roberts wrote:
> >>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to=
 be
> >>>> allocated in large folios of a determined order. All pages of the la=
rge
> >>>> folio are pte-mapped during the same page fault, significantly reduc=
ing
> >>>> the number of page faults. The number of per-page operations (e.g. r=
ef
> >>>> counting, rmap management lru list management) are also significantl=
y
> >>>> reduced since those ops now become per-folio.
> >>>>
> >>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >>>> which defaults to disabled for now; The long term aim is for this to
> >>>> defaut to enabled, but there are some risks around internal
> >>>> fragmentation that need to be better understood first.
> >>>>
> >>>> When enabled, the folio order is determined as such: For a vma, proc=
ess
> >>>> or system that has explicitly disabled THP, we continue to allocate
> >>>> order-0. THP is most likely disabled to avoid any possible internal
> >>>> fragmentation so we honour that request.
> >>>>
> >>>> Otherwise, the return value of arch_wants_pte_order() is used. For v=
mas
> >>>> that have not explicitly opted-in to use transparent hugepages (e.g.
> >>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> >>>> bigger). This allows for a performance boost without requiring any
> >>>> explicit opt-in from the workload while limitting internal
> >>>> fragmentation.
> >>>>
> >>>> If the preferred order can't be used (e.g. because the folio would
> >>>> breach the bounds of the vma, or because ptes in the region are alre=
ady
> >>>> mapped) then we fall back to a suitable lower order; first
> >>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>>>
> >>>
> >>> ...
> >>>
> >>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >>>> +           (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_S=
HIFT)
> >>>> +
> >>>> +static int anon_folio_order(struct vm_area_struct *vma)
> >>>> +{
> >>>> +   int order;
> >>>> +
> >>>> +   /*
> >>>> +    * If THP is explicitly disabled for either the vma, the process=
 or the
> >>>> +    * system, then this is very likely intended to limit internal
> >>>> +    * fragmentation; in this case, don't attempt to allocate a larg=
e
> >>>> +    * anonymous folio.
> >>>> +    *
> >>>> +    * Else, if the vma is eligible for thp, allocate a large folio =
of the
> >>>> +    * size preferred by the arch. Or if the arch requested a very s=
mall
> >>>> +    * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORD=
ER,
> >>>> +    * which still meets the arch's requirements but means we still =
take
> >>>> +    * advantage of SW optimizations (e.g. fewer page faults).
> >>>> +    *
> >>>> +    * Finally if thp is enabled but the vma isn't eligible, take th=
e
> >>>> +    * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHI=
NTED.
> >>>> +    * This ensures workloads that have not explicitly opted-in take=
 benefit
> >>>> +    * while capping the potential for internal fragmentation.
> >>>> +    */
> >>>> +
> >>>> +   if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >>>> +       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >>>> +       !hugepage_flags_enabled())
> >>>> +           order =3D 0;
> >>>> +   else {
> >>>> +           order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_=
ORDER);
> >>>> +
> >>>> +           if (!hugepage_vma_check(vma, vma->vm_flags, false, true,=
 true))
> >>>> +                   order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINT=
ED);
> >>>> +   }
> >>>> +
> >>>> +   return order;
> >>>> +}
> >>>
> >>>
> >>> Hi All,
> >>>
> >>> I'm writing up the conclusions that we arrived at during discussion i=
n the THP
> >>> meeting yesterday, regarding linkage with exiting THP ABIs. It would =
be great if
> >>> I can get explicit "agree" or disagree + rationale from at least Davi=
d, Yu and
> >>> Kirill.
> >>>
> >>> In summary; I think we are converging on the approach that is already=
 coded, but
> >>> I'd like confirmation.
> >>>
> >>>
> >>>
> >>> The THP situation today
> >>> -----------------------
> >>>
> >>>  - At system level: THP can be set to "never", "madvise" or "always"
> >>>  - At process level: THP can be "never" or "defer to system setting"
> >>>  - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
> >>>
> >>> That gives us this table to describe how a page fault is handled, acc=
ording to
> >>> process state (columns) and vma flags (rows):
> >>>
> >>>                 | never     | madvise   | always
> >>> ----------------|-----------|-----------|-----------
> >>> no hint         | S         | S         | THP>S
> >>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
> >>> MADV_NOHUGEPAGE | S         | S         | S
> >>>
> >>> Legend:
> >>> S     allocate single page (PTE-mapped)
> >>> LAF   allocate lage anon folio (PTE-mapped)
> >>> THP   allocate THP-sized folio (PMD-mapped)
> >>>>     fallback (usually because vma size/alignment insufficient for fo=
lio)
> >>>
> >>>
> >>>
> >>> Principles for Large Anon Folios (LAF)
> >>> --------------------------------------
> >>>
> >>> David tells us there are use cases today (e.g. qemu live migration) w=
hich use
> >>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly =
faulted"
> >>> and these use cases will break (i.e. functionally incorrect) if this =
request is
> >>> not honoured.
> >>>
> >>> So LAF must at least honour MADV_NOHUGEPAGE to prevent breaking exist=
ing use
> >>> cases. And once we do this, then I think the least confusing thing is=
 for it to
> >>> also honor the "never" system/process state; so if either the system,=
 process or
> >>> vma has explicitly opted-out of THP, then LAF should also be bypassed=
.
> >>>
> >>> Similarly, any case that would previously cause the allocation of PMD=
-sized THP
> >>> must continue to be honoured, else we risk performance regression.
> >>>
> >>> That leaves the "madvise/no-hint" case, and all THP fallback paths du=
e to the
> >>> VMA not being correctly aligned or sized to hold a PMD-sized mapping.=
 In these
> >>> cases, we will attempt to use LAF first, and fallback to single page =
if the vma
> >>> size/alignment doesn't permit it.
> >>>
> >>>                 | never     | madvise   | always
> >>> ----------------|-----------|-----------|-----------
> >>> no hint         | S         | LAF>S     | THP>LAF>S
> >>> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> >>> MADV_NOHUGEPAGE | S         | S         | S
> >>>
> >>> I think this (perhaps conservative) approach will be the least surpri=
sing to
> >>> users. And is the policy that is already implemented in this patch.
> >>
> >> This looks very reasonable.
> >>
> >> The only questionable field is no-hint/madvise. I can argue for both L=
AF>S
> >> and S here. I think LAF>S is fine as long as we are not too aggressive
> >> with allocation order.
> >>
> >> I think we need to work on eliminating reasons for users to set 'never=
'.
> >> If something behaves better with 'never' kernel has failed user.
> >>
> >>> Downsides of this policy
> >>> ------------------------
> >>>
> >>> As Yu and Yin have pointed out, there are some workloads which do not=
 perform
> >>> well with THP, due to large fault latency or memory wastage, etc. But=
 which
> >>> _may_ still benefit from LAF. By taking the conservative approach, we=
 exclude
> >>> these workloads from benefiting automatically.
> >>
> >> Hm. I don't buy it. Why THP with order-9 is too much, but order-8 LAF =
is
> >> fine?
> >
> > No, it's not. And no one said order-8 LAF is fine :) The starting
> > order for LAF that we have been discussing is at most 64KB (vs 2MB
> > THP). For my taste, it's still too large. I'd go with 32KB/16KB.
>
> Its currently influenced by the arch. If the arch doesn't have an opinion=
 then
> its currently 32K in the code. The 64K size is my aspiration for arm64 if=
/when I
> land the contpte mapping work.

Just to double check: this discussion covers the long term/permanente
solution/roadmap, correct? That's what Kirill and I were arguing
about. Otherwise, the order-8/9 concern above is totally irrelevant,
since we don't have them in this series.

For the short term (this series), what you described above looks good
to me: we may regress but will not break any existing use cases, and
we are behind a Kconfig option.

> > However, the same argument can be used to argue against the policy
> > Ryan listed above: why order-10 LAF is ok for madvise but not order-11
> > (which becomes "always")?
>
> Sorry I don't understand what you are saying here. Where has order-10 LAF=
 come from?

I pushed that rhetoric a bit further: order-11 is the THP size (32MB)
with 16KB base page size on ARM. Confusing, isn't it? And there is
another complaint from Fengwei here [1].

[1] https://lore.kernel.org/linux-mm/CAOUHufasZ6w32sHO+Lq33+tGy3+GiO0_dd6mN=
YwfS_5gqhzYbw@mail.gmail.com/

> > I'm strongly against this policy

Again, just to be clear: I'm strongly against this policy to be
exposed to userspace in any way and become a long-term/permanent thing
we have to maintain/change in the future, since I'm assuming that's
the context.

> Ugh, I thought we came to an agreement (or at least "disagree and commit"=
) on
> the THP call. Obviously I was wrong.

My impression is we only agreed on one thing: at the current stage, we
should respect things we absolutely have to. We didn't agree on what
"never" means ("never 2MB" or "never >4KB"), and we didn't touch on
how "always" should behave at all.

> David is telling us that we will break user space if we don't consider
> MADV_NOHUGEPAGE to mean "never allocate memory to unfaulted addresses". S=
o tying
> to at least this must be cast in stone, no? Could you lay out any policy
> proposal you have as an alternative that still follows this requirement?

If MADV_NOHUGEPAGE falls into the category of things we have to
absolutely respect, then we will. But I don't think it does, because
the UFFD check we have in this series already guarantees the KVM use
case. I can explain how it works in detail if it's still not clear to
you: long story short, the UFFD check precedes the MADV_NOHUGEPAGE
check in alloc_anon_folio().

Here is what I recommend for the medium and long terms:
https://lore.kernel.org/linux-mm/CAOUHufYm6Lkm4tLRbyKOc3-NYU-8d6ZDMNDWHo=3D=
e=3DE16oasN8A@mail.gmail.com/

For the short term, hard-coding two orders (hw/sw preferred), putting
them behind a Kconfig and not exposing this info to the userspace are
good enough for me.
