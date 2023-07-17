Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE3F7569D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGQRIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGQRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:08:38 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1D198
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:08:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40371070eb7so10221cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689613714; x=1692205714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTmM0HfzwvB/Vdx9NPFotbq1yDAXwvaKOMLW0DYioWk=;
        b=RKUz0mp7peFUWJaRfVmMeTPUwJiwWg2RRd6xfybhZi0aoV3uCuL5V9ayqhg+aCktIa
         /evz4tT9RgsyK9/uiAQAZ8nKzDwzBsBEYRRU0dIJMxbYnw3j6HUec9UF/zL8OzeKcwHa
         yFVONWk6iL3/VO2e1PHzJNAYAwhcwP7c1mxxZH9dg8xKmBxbF6jlCZYXGH9p/oZbTM/8
         1cwtMYiDqKzG6BYu+iPfDeezrwKSjobrJfs60KkC0DP35iNLDYJDjLrwmZJjDjHHXiCM
         xgYNzPfPxyxxYQLNjABUXyqQgRngivn2l8q3K7EsJwrtvJ+fYPPczJgrEsF2M9Ww8v5c
         pm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689613714; x=1692205714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTmM0HfzwvB/Vdx9NPFotbq1yDAXwvaKOMLW0DYioWk=;
        b=FdvghmENbE9bf6QXfbYzLUHgHXD/d4Iiy3jQWiDnvz4M9cPjxOQ22k6GIe/OLx2ff5
         W3kGY1pX8EPSdmPJFQRKTTaMkLuPu7zqMmeBvdEDxDZi74MH5jS7wiGt75rMi9JcI9lH
         NdjwdhLzvI+ngRL0M+qm47n1SzNm/Ygd4IcS/G4SQd9T6OJTZuWA9K1fhafxz32S4Af2
         0B8bPbviDAz8mXPBbthXgSqeexcHYObSMqUrF0xQkWswfbya1phvbtjZmZKh45GXT0mF
         f6CdI6nD0QBfBaIUrEfBP2vKyhPWKj4NYVlu5Cs8EjhS1SJc7RjzNZk3vMR9D9W0Wyyc
         8ZXA==
X-Gm-Message-State: ABy/qLYgyMeXJo0s9ABpXcxcdxzeadlAXktrxs6HYlcOetBhTVdZ+pu4
        zlfs1L0o3cgmHwiaW6T/nNvZxGgJE57CT9UVvwbmOg==
X-Google-Smtp-Source: APBJJlEn61y9q4oc3cU7MwZEoRh5a/dJxfP/5I+e8iyg+Ggc7cLgubAm/MLcxlfkG6JbwoDESNcLo+mFPBYlARCt4ik=
X-Received: by 2002:a05:622a:1009:b0:403:b3ab:393e with SMTP id
 d9-20020a05622a100900b00403b3ab393emr1352364qte.18.1689613714249; Mon, 17 Jul
 2023 10:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com> <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <82c934af-a777-3437-8d87-ff453ad94bfd@redhat.com>
In-Reply-To: <82c934af-a777-3437-8d87-ff453ad94bfd@redhat.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 17 Jul 2023 11:07:57 -0600
Message-ID: <CAOUHufYnVdxoKgvxFmk7e0KqtOV9=zWQ-vjVX7JOLNM-cRKR9Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Jul 17, 2023 at 7:06=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.23 19:17, Yu Zhao wrote:
> > On Fri, Jul 14, 2023 at 10:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> >> allocated in large folios of a determined order. All pages of the larg=
e
> >> folio are pte-mapped during the same page fault, significantly reducin=
g
> >> the number of page faults. The number of per-page operations (e.g. ref
> >> counting, rmap management lru list management) are also significantly
> >> reduced since those ops now become per-folio.
> >>
> >> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
> >> defaults to disabled for now; The long term aim is for this to defaut =
to
> >> enabled, but there are some risks around internal fragmentation that
> >> need to be better understood first.
> >>
> >> When enabled, the folio order is determined as such: For a vma, proces=
s
> >> or system that has explicitly disabled THP, we continue to allocate
> >> order-0. THP is most likely disabled to avoid any possible internal
> >> fragmentation so we honour that request.
> >>
> >> Otherwise, the return value of arch_wants_pte_order() is used. For vma=
s
> >> that have not explicitly opted-in to use transparent hugepages (e.g.
> >> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >> arch_wants_pte_order() is limited by the new cmdline parameter,
> >> `flexthp_unhinted_max`. This allows for a performance boost without
> >> requiring any explicit opt-in from the workload while allowing the
> >> sysadmin to tune between performance and internal fragmentation.
> >>
> >> arch_wants_pte_order() can be overridden by the architecture if desire=
d.
> >> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguo=
us
> >> set of ptes map physically contigious, naturally aligned memory, so th=
is
> >> mechanism allows the architecture to optimize as required.
> >>
> >> If the preferred order can't be used (e.g. because the folio would
> >> breach the bounds of the vma, or because ptes in the region are alread=
y
> >> mapped) then we fall back to a suitable lower order; first
> >> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>   .../admin-guide/kernel-parameters.txt         |  10 +
> >>   mm/Kconfig                                    |  10 +
> >>   mm/memory.c                                   | 187 ++++++++++++++++=
--
> >>   3 files changed, 190 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index a1457995fd41..405d624e2191 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -1497,6 +1497,16 @@
> >>                          See Documentation/admin-guide/sysctl/net.rst =
for
> >>                          fb_tunnels_only_for_init_ns
> >>
> >> +       flexthp_unhinted_max=3D
> >> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. Th=
e maximum
> >> +                       folio size that will be allocated for an anony=
mous vma
> >> +                       that has neither explicitly opted in nor out o=
f using
> >> +                       transparent hugepages. The size must be a powe=
r-of-2 in
> >> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size=
 improves
> >> +                       performance by reducing page faults, while a s=
maller
> >> +                       size reduces internal fragmentation. Default: =
max(64K,
> >> +                       PAGE_SIZE). Format: size[KMG].
> >> +
> >
> > Let's split this parameter into a separate patch.
> >
>
> Just a general comment after stumbling over patch #2, let's not start
> splitting patches into things that don't make any sense on their own;
> that just makes review a lot harder.

Sorry to hear this -- but there are also non-subjective reasons we
split patches this way.

Initially we had minimum to no common ground, so we had to divide and
conquer by smallest steps.

if you look at previous discussions: there was a disagreement on patch
2 in v2 -- that's the patch you asked to be squashed into the main
patch 3. Fortunately we've resolved that. If that disagreement had
persisted, we would leave patch 2 out rather than let it bog down
patch 3, which would work indifferently for all arches except arm and
could be merged separately.

> For this case here, I'd suggest first adding the general infrastructure
> and then adding tunables we want to have on top.
>
> I agree that toggling that at runtime (for example via sysfs as raised
> by me previously) would be nicer.
