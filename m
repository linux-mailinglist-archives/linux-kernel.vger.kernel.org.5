Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94276F67C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjHDATq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDATo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:19:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF73AB1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:19:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so72601cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691108382; x=1691713182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA32fM9ZbOqMt7s1gfEqOlzSy+fN/PuS60CGam21os0=;
        b=PbTefRq9UzzDT25XxODA4kLZgtaubzDeg4foCwvMb2f8nS81Fq6JsW+YfaeyIooskj
         uvLYsfRkzXBTKPVf8djXijxIxNs5Rcdp9iGQZWSpIpQt+Dz9MbUjuI54cYFjv1G27Hto
         Iwl1It6sezNLVkHog+E+G5pB9EIIjZiwQt6gBw9dHbvw50bO8O38KjOLDgvDG4JaRevO
         0Yi2L/SYMLEoJp87kkQrg8T/Ac0ukjeu7tMcYI5Hp++5WqeQuANjkR36khbSmbrn3NI8
         EogsNIQXLWaufdp9TiBIE7KDcx6ah8Q65+ywMWIKeaQnbMyX+2q5rL9Gb7NNeBJch6Hl
         lbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691108382; x=1691713182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA32fM9ZbOqMt7s1gfEqOlzSy+fN/PuS60CGam21os0=;
        b=FSBk6tLg7d8u1e2/DApG5EAEvDy5bsVq1NGulPOHLC39zJmyoC8E8oY1ZSo7/xQjhc
         aE6gcz/JcEAvxPMqBPSNaSC56aTdas4Zc1jdXIBtYCqrFJWA8m0XfCnGFIXsp9YElOiV
         iOu9k8UbqA031y9FmUYPEuyQJ4edbQMOTnJaGBQZF4s/TPoYCyvg5mCPQxUeE8CQ5X35
         4uVQ4zBK0/Kwa/ibQhWTVdMv0oviDbWe3ceY+F0DsflQGkbdEPHrIf44QaALzArzpwNU
         BWab5NdkcLCv8jal3onZ4KAxlpFxWNyBZ0y206KgQyW2f483xjVmIzGUYyr9mrF9juDu
         kq+A==
X-Gm-Message-State: AOJu0Yzh9NNvL8KUf/G28+/T2G7idUb27OREgKRsRvWBgoQre6B9j/8K
        3zmUIBgtZnygbO0z0HggFJKQSYsvxMyljPFbhr9iKQ==
X-Google-Smtp-Source: AGHT+IFy6SfL78iO/AoS+JkTZxkf9rSPiwDIAvWe4E9K9Ho7qgFmfL+RvoLDrQE4H/giQawLq7h21Dn16OgTMQqU3iw=
X-Received: by 2002:a05:622a:15d4:b0:3f9:a770:7279 with SMTP id
 d20-20020a05622a15d400b003f9a7707279mr41199qty.9.1691108382007; Thu, 03 Aug
 2023 17:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <20230803142154.nvgkavg33uyn6f72@box.shutemov.name>
In-Reply-To: <20230803142154.nvgkavg33uyn6f72@box.shutemov.name>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Aug 2023 18:19:05 -0600
Message-ID: <CAOUHufZWTdpF0vdPkyOafVNFOOY7Wui+Q-O83=SZcfv4KZcHbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 8:27=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Aug 03, 2023 at 01:43:31PM +0100, Ryan Roberts wrote:
> > + Kirill
> >
> > On 26/07/2023 10:51, Ryan Roberts wrote:
> > > Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to =
be
> > > allocated in large folios of a determined order. All pages of the lar=
ge
> > > folio are pte-mapped during the same page fault, significantly reduci=
ng
> > > the number of page faults. The number of per-page operations (e.g. re=
f
> > > counting, rmap management lru list management) are also significantly
> > > reduced since those ops now become per-folio.
> > >
> > > The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> > > which defaults to disabled for now; The long term aim is for this to
> > > defaut to enabled, but there are some risks around internal
> > > fragmentation that need to be better understood first.
> > >
> > > When enabled, the folio order is determined as such: For a vma, proce=
ss
> > > or system that has explicitly disabled THP, we continue to allocate
> > > order-0. THP is most likely disabled to avoid any possible internal
> > > fragmentation so we honour that request.
> > >
> > > Otherwise, the return value of arch_wants_pte_order() is used. For vm=
as
> > > that have not explicitly opted-in to use transparent hugepages (e.g.
> > > where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> > > arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> > > bigger). This allows for a performance boost without requiring any
> > > explicit opt-in from the workload while limitting internal
> > > fragmentation.
> > >
> > > If the preferred order can't be used (e.g. because the folio would
> > > breach the bounds of the vma, or because ptes in the region are alrea=
dy
> > > mapped) then we fall back to a suitable lower order; first
> > > PAGE_ALLOC_COSTLY_ORDER, then order-0.
> > >
> >
> > ...
> >
> > > +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> > > +           (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SH=
IFT)
> > > +
> > > +static int anon_folio_order(struct vm_area_struct *vma)
> > > +{
> > > +   int order;
> > > +
> > > +   /*
> > > +    * If THP is explicitly disabled for either the vma, the process =
or the
> > > +    * system, then this is very likely intended to limit internal
> > > +    * fragmentation; in this case, don't attempt to allocate a large
> > > +    * anonymous folio.
> > > +    *
> > > +    * Else, if the vma is eligible for thp, allocate a large folio o=
f the
> > > +    * size preferred by the arch. Or if the arch requested a very sm=
all
> > > +    * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDE=
R,
> > > +    * which still meets the arch's requirements but means we still t=
ake
> > > +    * advantage of SW optimizations (e.g. fewer page faults).
> > > +    *
> > > +    * Finally if thp is enabled but the vma isn't eligible, take the
> > > +    * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHIN=
TED.
> > > +    * This ensures workloads that have not explicitly opted-in take =
benefit
> > > +    * while capping the potential for internal fragmentation.
> > > +    */
> > > +
> > > +   if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > > +       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> > > +       !hugepage_flags_enabled())
> > > +           order =3D 0;
> > > +   else {
> > > +           order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_O=
RDER);
> > > +
> > > +           if (!hugepage_vma_check(vma, vma->vm_flags, false, true, =
true))
> > > +                   order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTE=
D);
> > > +   }
> > > +
> > > +   return order;
> > > +}
> >
> >
> > Hi All,
> >
> > I'm writing up the conclusions that we arrived at during discussion in =
the THP
> > meeting yesterday, regarding linkage with exiting THP ABIs. It would be=
 great if
> > I can get explicit "agree" or disagree + rationale from at least David,=
 Yu and
> > Kirill.
> >
> > In summary; I think we are converging on the approach that is already c=
oded, but
> > I'd like confirmation.
> >
> >
> >
> > The THP situation today
> > -----------------------
> >
> >  - At system level: THP can be set to "never", "madvise" or "always"
> >  - At process level: THP can be "never" or "defer to system setting"
> >  - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
> >
> > That gives us this table to describe how a page fault is handled, accor=
ding to
> > process state (columns) and vma flags (rows):
> >
> >                 | never     | madvise   | always
> > ----------------|-----------|-----------|-----------
> > no hint         | S         | S         | THP>S
> > MADV_HUGEPAGE   | S         | THP>S     | THP>S
> > MADV_NOHUGEPAGE | S         | S         | S
> >
> > Legend:
> > S     allocate single page (PTE-mapped)
> > LAF   allocate lage anon folio (PTE-mapped)
> > THP   allocate THP-sized folio (PMD-mapped)
> > >     fallback (usually because vma size/alignment insufficient for fol=
io)
> >
> >
> >
> > Principles for Large Anon Folios (LAF)
> > --------------------------------------
> >
> > David tells us there are use cases today (e.g. qemu live migration) whi=
ch use
> > MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly fa=
ulted"
> > and these use cases will break (i.e. functionally incorrect) if this re=
quest is
> > not honoured.
> >
> > So LAF must at least honour MADV_NOHUGEPAGE to prevent breaking existin=
g use
> > cases. And once we do this, then I think the least confusing thing is f=
or it to
> > also honor the "never" system/process state; so if either the system, p=
rocess or
> > vma has explicitly opted-out of THP, then LAF should also be bypassed.
> >
> > Similarly, any case that would previously cause the allocation of PMD-s=
ized THP
> > must continue to be honoured, else we risk performance regression.
> >
> > That leaves the "madvise/no-hint" case, and all THP fallback paths due =
to the
> > VMA not being correctly aligned or sized to hold a PMD-sized mapping. I=
n these
> > cases, we will attempt to use LAF first, and fallback to single page if=
 the vma
> > size/alignment doesn't permit it.
> >
> >                 | never     | madvise   | always
> > ----------------|-----------|-----------|-----------
> > no hint         | S         | LAF>S     | THP>LAF>S
> > MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> > MADV_NOHUGEPAGE | S         | S         | S
> >
> > I think this (perhaps conservative) approach will be the least surprisi=
ng to
> > users. And is the policy that is already implemented in this patch.
>
> This looks very reasonable.
>
> The only questionable field is no-hint/madvise. I can argue for both LAF>=
S
> and S here. I think LAF>S is fine as long as we are not too aggressive
> with allocation order.
>
> I think we need to work on eliminating reasons for users to set 'never'.
> If something behaves better with 'never' kernel has failed user.
>
> > Downsides of this policy
> > ------------------------
> >
> > As Yu and Yin have pointed out, there are some workloads which do not p=
erform
> > well with THP, due to large fault latency or memory wastage, etc. But w=
hich
> > _may_ still benefit from LAF. By taking the conservative approach, we e=
xclude
> > these workloads from benefiting automatically.
>
> Hm. I don't buy it. Why THP with order-9 is too much, but order-8 LAF is
> fine?

No, it's not. And no one said order-8 LAF is fine :) The starting
order for LAF that we have been discussing is at most 64KB (vs 2MB
THP). For my taste, it's still too large. I'd go with 32KB/16KB.

However, the same argument can be used to argue against the policy
Ryan listed above: why order-10 LAF is ok for madvise but not order-11
(which becomes "always")?

I'm strongly against this policy for two practical reasons I learned
from tuning THPs in our data centers:
1. By doing the above, we are blurring the lines between those values
and making real-world performance tuning extremely hard if not
impractice.
2. As I previously pointed out: if we mix LAFs with THPs, we actually
risk causing performance regressions because giving smaller VMAs LAFs
can deprive large VMAs of THPs.
