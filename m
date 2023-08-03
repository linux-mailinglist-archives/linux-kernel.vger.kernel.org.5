Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D5676F64A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHCXvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHCXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:51:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27561BF1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:51:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40c72caec5cso134411cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691106675; x=1691711475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJFHaRySOlD5+a75VyE5azWXSPuX0PJG9XGQ53FQ3Lw=;
        b=wUM8MPQ32uXwz3fhBveoBzB4MSc3nb+xSYnFwiMVtMT116Gx7b4Gp1ut0DoOkIxFEj
         xM1Akj5uVYqYx34KrckhuAyPCV25r0cUtJE+5h01i6vPlSzaF+bnjvOwhuT1HEDkOOm9
         YSveugrLIckIvPeEkS3dGaPt/gga4Q5y2DP+uG8Gr7SyGcV0Xh0B00kXeR/6fTGK4xGm
         zVCeIXx7O1umMGV8FqnpWIe++Z4tjNcCofUxs/rIKccLAq8aWq7oZCMb+weIxedqB6UO
         nldsXD34wL0Do4xLgEsJtOAiTu3IH9NDCE0s8Gu5e9SDTV9zJSnWMSzqYhr8+lkZe3U7
         jyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691106675; x=1691711475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJFHaRySOlD5+a75VyE5azWXSPuX0PJG9XGQ53FQ3Lw=;
        b=i1QDeQSeB0bBaA7XcCLyoHiELnsN77xmhTzGpHk4S/FSwYtkWyKW/lfsxA7DI4QJAh
         KRscj6fZbrjXkjQ+HYXttmtnsP4Dt3X0mSifRqJcEc9NaVvgviitHaEvW4b0j69gji77
         c31v7heTemZhUHv3w3jNq34qenpm/NLZbl8F9YSShCfr0ak+iAwWtv6e5nFIE6k2DRUl
         sL8LR9EODYaOnAyVbnCl0MoitYCFsV1wum3MHO3qymh447rrfOgqHWbQ5xpkYDrxgsY2
         DgKbtDgSw/qnXXnxOImqAhtdaD+Wj7vpbgF0SmbOkPaDucYoYaGr6Jr6YODJi7HQdS6N
         Oyiw==
X-Gm-Message-State: AOJu0Yzvx1rSZGOkvm2i8t+q2zej4zHBBAjKwMsslQMh2RIXX79HoSzD
        ecwVvFr4sX4sxBcx/KJ0nqumzP3MRtThVSQKuAtd1w==
X-Google-Smtp-Source: AGHT+IE+dqL2ZYo2ZYC6cXNfApDKg7uqt+XXLsJQBM7jB05LXsXiEvBvTk2p0r7CXfK4YVay33RCkgkWmFdawhiPqCE=
X-Received: by 2002:ac8:7dcd:0:b0:405:3a65:b3d6 with SMTP id
 c13-20020ac87dcd000000b004053a65b3d6mr34987qte.13.1691106675498; Thu, 03 Aug
 2023 16:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
In-Reply-To: <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Aug 2023 17:50:38 -0600
Message-ID: <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 6:43=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> + Kirill
>
> On 26/07/2023 10:51, Ryan Roberts wrote:
> > Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
> > allocated in large folios of a determined order. All pages of the large
> > folio are pte-mapped during the same page fault, significantly reducing
> > the number of page faults. The number of per-page operations (e.g. ref
> > counting, rmap management lru list management) are also significantly
> > reduced since those ops now become per-folio.
> >
> > The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> > which defaults to disabled for now; The long term aim is for this to
> > defaut to enabled, but there are some risks around internal
> > fragmentation that need to be better understood first.
> >
> > When enabled, the folio order is determined as such: For a vma, process
> > or system that has explicitly disabled THP, we continue to allocate
> > order-0. THP is most likely disabled to avoid any possible internal
> > fragmentation so we honour that request.
> >
> > Otherwise, the return value of arch_wants_pte_order() is used. For vmas
> > that have not explicitly opted-in to use transparent hugepages (e.g.
> > where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> > arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> > bigger). This allows for a performance boost without requiring any
> > explicit opt-in from the workload while limitting internal
> > fragmentation.
> >
> > If the preferred order can't be used (e.g. because the folio would
> > breach the bounds of the vma, or because ptes in the region are already
> > mapped) then we fall back to a suitable lower order; first
> > PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >
>
> ...
>
> > +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> > +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SH=
IFT)
> > +
> > +static int anon_folio_order(struct vm_area_struct *vma)
> > +{
> > +     int order;
> > +
> > +     /*
> > +      * If THP is explicitly disabled for either the vma, the process =
or the
> > +      * system, then this is very likely intended to limit internal
> > +      * fragmentation; in this case, don't attempt to allocate a large
> > +      * anonymous folio.
> > +      *
> > +      * Else, if the vma is eligible for thp, allocate a large folio o=
f the
> > +      * size preferred by the arch. Or if the arch requested a very sm=
all
> > +      * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDE=
R,
> > +      * which still meets the arch's requirements but means we still t=
ake
> > +      * advantage of SW optimizations (e.g. fewer page faults).
> > +      *
> > +      * Finally if thp is enabled but the vma isn't eligible, take the
> > +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHIN=
TED.
> > +      * This ensures workloads that have not explicitly opted-in take =
benefit
> > +      * while capping the potential for internal fragmentation.
> > +      */
> > +
> > +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> > +         !hugepage_flags_enabled())
> > +             order =3D 0;
> > +     else {
> > +             order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_O=
RDER);
> > +
> > +             if (!hugepage_vma_check(vma, vma->vm_flags, false, true, =
true))
> > +                     order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTE=
D);
> > +     }
> > +
> > +     return order;
> > +}
>
>
> Hi All,
>
> I'm writing up the conclusions that we arrived at during discussion in th=
e THP
> meeting yesterday, regarding linkage with exiting THP ABIs. It would be g=
reat if
> I can get explicit "agree" or disagree + rationale from at least David, Y=
u and
> Kirill.
>
> In summary; I think we are converging on the approach that is already cod=
ed, but
> I'd like confirmation.
>
>
>
> The THP situation today
> -----------------------
>
>  - At system level: THP can be set to "never", "madvise" or "always"
>  - At process level: THP can be "never" or "defer to system setting"
>  - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>
> That gives us this table to describe how a page fault is handled, accordi=
ng to
> process state (columns) and vma flags (rows):
>
>                 | never     | madvise   | always
> ----------------|-----------|-----------|-----------
> no hint         | S         | S         | THP>S
> MADV_HUGEPAGE   | S         | THP>S     | THP>S
> MADV_NOHUGEPAGE | S         | S         | S
>
> Legend:
> S       allocate single page (PTE-mapped)
> LAF     allocate lage anon folio (PTE-mapped)
> THP     allocate THP-sized folio (PMD-mapped)
> >       fallback (usually because vma size/alignment insufficient for fol=
io)
>
>
>
> Principles for Large Anon Folios (LAF)
> --------------------------------------
>
> David tells us there are use cases today (e.g. qemu live migration) which=
 use
> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly faul=
ted"
> and these use cases will break (i.e. functionally incorrect) if this requ=
est is
> not honoured.

I don't remember David saying this. I think he was referring to UFFD,
not MADV_NOHUGEPAGE, when discussing what we need to absolutely
respect.
