Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DC77DBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjHPILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242809AbjHPILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A83EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:11:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bda9207132so49491405ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692173482; x=1692778282;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ge3/AeXRJddBHQ7s/xkI1nEQCp8JZ9ysjNq/9S8Le0=;
        b=rGrE2CTdAqffTWT7UiWLA1bVQj5d9anoYhuJ6uuuMiXgn9U6RYXjllhW6+/0U9S8B8
         xP/qxVbrqCXFFG+4d/tAghXjdjY2luwenFdw6ZTgGPEOoo26O6oYhBOsh/YwhLsEDBvv
         /x/7ou1nbD0iEDQXSMHx1ULeUzNUPI9Vh4UoRqWT51+/84UYm9s+6Agh2hmebm1XTSqE
         DLWmMZo0DmiJNFqDzFxS3jr3/6X6B4ztI3QV5uFdSI5bLYtYL8FQVmoJ5BsPezo6ZNx9
         CT9qDJoFAMO6hQQuJRtLyqxBE7W8tlwXqOFGKLsprBUx1Cesp03EOIbRsgIxBW/bm4RC
         m8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173482; x=1692778282;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ge3/AeXRJddBHQ7s/xkI1nEQCp8JZ9ysjNq/9S8Le0=;
        b=aF5m/03CWhF5e+5Ly4nmReNQrfgngU8uotevtAatfnWr/7I2H2yhppdScu4yKRYOMS
         wU/6M7DxdfHSA896/AV7A51ExcbjGItPC6M4OGwJZHgBL+anKqyFlKSUUX3T5ZaGnLgP
         g8y/0U228ldqJz8PSFm4H1/rHxAzIzLXEeJtfiINQk+nUMnK8ZQwMc5je/DsIfTuzBh0
         e7H9kCMdJSce2b5a/5oc4NlQtyCo20N3z0b0Ldn5bfiXnGH5NyOA8ySWJXcbztbMpdLj
         sgF16+KNplETHGzf31xPzPuSNmfWZh4nC8Wu6nTOyheP9tr/olKA2gA9r140YE7Wy+Z+
         Fg7Q==
X-Gm-Message-State: AOJu0Yw75AulEUH/hmybGmsRv808nh20+LdkQvqDh6RczmXTl7IpoTtp
        cUVj4CIm9ON5l3X3VhoSziY=
X-Google-Smtp-Source: AGHT+IFFYdVka9Dkv350sy79zA/Bl8g1g1zvFfmUwpi0P/KvaZDN/Td0U9NBmWbOCKs6ZyvUVfRlVg==
X-Received: by 2002:a17:903:26d6:b0:1bb:e71f:793c with SMTP id jg22-20020a17090326d600b001bbe71f793cmr1000878plb.44.1692173481612;
        Wed, 16 Aug 2023 01:11:21 -0700 (PDT)
Received: from smtpclient.apple (pdcd3f62f.hyognt01.ap.so-net.ne.jp. [220.211.246.47])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b001bba669a7eesm12503943plg.52.2023.08.16.01.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:11:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Itaru Kitayama <itaru.kitayama@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 0/5] variable-order, large folios for anonymous memory
Date:   Wed, 16 Aug 2023 17:11:09 +0900
Message-Id: <EFC00B0B-CB45-40F0-A55E-0F110961A5B9@gmail.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230810142942.3169679-1-ryan.roberts@arm.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 10, 2023, at 23:29, Ryan Roberts <ryan.roberts@arm.com> wrote:
>=20
> =EF=BB=BFHi All,
>=20
> This is v5 of a series to implement variable order, large folios for anony=
mous
> memory. (currently called "LARGE_ANON_FOLIO", previously called "FLEXIBLE_=
THP").
> The objective of this is to improve performance by allocating larger chunk=
s of
> memory during anonymous page faults:
>=20
> 1) Since SW (the kernel) is dealing with larger chunks of memory than base=

>   pages, there are efficiency savings to be had; fewer page faults, batche=
d PTE
>   and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel=

>   overhead. This should benefit all architectures.
> 2) Since we are now mapping physically contiguous chunks of memory, we can=
 take
>   advantage of HW TLB compression techniques. A reduction in TLB pressure
>   speeds up kernel and user space. arm64 systems have 2 mechanisms to coal=
esce
>   TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>=20
> This patch set deals with the SW side of things (1). (2) is being tackled i=
n a
> separate series. The new behaviour is hidden behind a new Kconfig switch,
> LARGE_ANON_FOLIO, which is disabled by default. Although the eventual aim i=
s to
> enable it by default.
>=20
> My hope is that we are pretty much there with the changes at this point;
> hopefully this is sufficient to get an initial version merged so that we c=
an
> scale up characterization efforts. Although they should not be merged unti=
l the
> prerequisites are complete. These are in progress and tracked at [5].
>=20
> This series is based on mm-unstable (ad3232df3e41).
>=20
> I'm going to be out on holiday from the end of today, returning on 29th
> August. So responses will likely be patchy, as I'm terrified of posting
> to list from my phone!
>=20
>=20
> Testing
> -------
>=20
> This version adds patches to mm selftests so that the cow tests explicitly=
 test
> large anon folios, in the same way that thp is tested. When enabled you sh=
ould
> see something similar at the start of the test suite:
>=20
>  # [INFO] detected large anon folio size: 32 KiB
>=20
> Then the following results are expected. The fails and skips are due to ex=
isting
> issues in mm-unstable:
>=20
>  # Totals: pass:207 fail:16 xfail:0 xpass:0 skip:85 error:0
>=20
> Existing mm selftests reveal 1 regression in khugepaged tests when
> LARGE_ANON_FOLIO is enabled:
>=20
>  Run test: collapse_max_ptes_none (khugepaged:anon)
>  Maybe collapse with max_ptes_none exceeded.... Fail
>  Unexpected huge page
>=20
> I believe this is because khugepaged currently skips non-order-0 pages whe=
n
> looking for collapse opportunities and should get fixed with the help of
> DavidH's work to create a mechanism to precisely determine shared vs exclu=
sive
> pages.
>=20
>=20
> Changes since v4 [4]
> --------------------
>=20
>  - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
>    now uses the default order-3 size. I have moved this patch over to
>    the contpte series.
>  - Added "mm: Allow deferred splitting of arbitrary large anon folios" bac=
k
>    into series. I originally removed this at v2 to add to a separate serie=
s,
>    but that series has transformed significantly and it no longer fits, so=

>    bringing it back here.
>  - Reintroduced dependency on set_ptes(); Originally dropped this at v2, b=
ut
>    set_ptes() is in mm-unstable now.
>  - Updated policy for when to allocate LAF; only fallback to order-0 if
>    MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer rely=
 on
>    sysfs's never/madvise/always knob.
>  - Fallback to order-0 whenever uffd is armed for the vma, not just when
>    uffd-wp is set on the pte.
>  - alloc_anon_folio() now returns `strucxt folio *`, where errors are enco=
ded
>    with ERR_PTR().
>=20
>  The last 3 changes were proposed by Yu Zhao - thanks!
>=20
>=20
> Changes since v3 [3]
> --------------------
>=20
>  - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
>  - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded tha=
t a
>    sysctl is preferable but we will wait until real workload needs it.
>  - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
>  - Added mm selftests for large anon folios in cow test suite.
>=20
>=20
> Changes since v2 [2]
> --------------------
>=20
>  - Dropped commit "Allow deferred splitting of arbitrary large anon folios=
"
>      - Huang, Ying suggested the "batch zap" work (which I dropped from th=
is
>        series after v1) is a prerequisite for merging FLXEIBLE_THP, so I'v=
e
>        moved the deferred split patch to a separate series along with the b=
atch
>        zap changes. I plan to submit this series early next week.
>  - Changed folio order fallback policy
>      - We no longer iterate from preferred to 0 looking for acceptable pol=
icy
>      - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and 0=
 only
>  - Removed vma parameter from arch_wants_pte_order()
>  - Added command line parameter `flexthp_unhinted_max`
>      - clamps preferred order when vma hasn't explicitly opted-in to THP
>  - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is disa=
bled
>    for process or system).
>  - Simplified implementation and integration with do_anonymous_page()
>  - Removed dependency on set_ptes()
>=20
>=20
> Changes since v1 [1]
> --------------------
>=20
>  - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>  - replaced with arch-independent alloc_anon_folio()
>      - follows THP allocation approach
>  - no longer retry with intermediate orders if allocation fails
>      - fallback directly to order-0
>  - remove folio_add_new_anon_rmap_range() patch
>      - instead add its new functionality to folio_add_new_anon_rmap()
>  - remove batch-zap pte mappings optimization patch
>      - remove enabler folio_remove_rmap_range() patch too
>      - These offer real perf improvement so will submit separately
>  - simplify Kconfig
>      - single FLEXIBLE_THP option, which is independent of arch
>      - depends on TRANSPARENT_HUGEPAGE
>      - when enabled default to max anon folio size of 64K unless arch
>        explicitly overrides
>  - simplify changes to do_anonymous_page():
>      - no more retry loop
>=20
>=20
> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts=
@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts=
@arm.com/
> [3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts=
@arm.com/
> [4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts=
@arm.com/
> [5] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@=
arm.com/
>=20
>=20
> Thanks,
> Ryan
>=20
> Ryan Roberts (5):
>  mm: Allow deferred splitting of arbitrary large anon folios
>  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
>  mm: LARGE_ANON_FOLIO for improved performance
>  selftests/mm/cow: Generalize do_run_with_thp() helper
>  selftests/mm/cow: Add large anon folio tests
>=20
> include/linux/pgtable.h          |  13 ++
> mm/Kconfig                       |  10 ++
> mm/memory.c                      | 144 +++++++++++++++++--
> mm/rmap.c                        |  31 +++--
> tools/testing/selftests/mm/cow.c | 229 ++++++++++++++++++++++---------
> 5 files changed, 347 insertions(+), 80 deletions(-)
>=20
> --
> 2.25.1
>=20

I know Ryan is away currently, but as I can=E2=80=99t find the base commit m=
entioned in the cover letter to be based off of can anybody point me to it s=
o I can use b4 for applying the series and test?

Thanks,
Itaru.=
