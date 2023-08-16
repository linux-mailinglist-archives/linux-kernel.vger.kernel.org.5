Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7655777E0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbjHPL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbjHPL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:57:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE9A110
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:57:22 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a800814122so2371594b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692187042; x=1692791842;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECJlIO/6X+Pq0Ru6+xgHtKmmcWycq6LlbP0Bph224Yc=;
        b=HRXW6crYAaHqDI/FSqlzb6aeEfhOIDWtR3UaQ6MS6PvGYo7kMwhLwHvWIthhBJW419
         6LUzHz5SBWXFMm0Qfw60AyCQKYz+33uiXTgYSJr9GZLP+5Qh7RYoG4rVBf1aSyc3o2vX
         7LvbLZW1NOJJVF+qzfLEKayHf6DpU8UqGJhv52/kr5yyX5iYu1Yu14WC8Qyqfi7Q216A
         PDvQXJbZazx9yTFBRx83MW7k1VMmsK2riBsyFxEeTggO5q1bAOH2e5qnuN6yR/Y6xGge
         wtVfw299rmTJZpN4ObOTofqF9NZQvHJKNb5n7rOCg3XKKyNs4YoXvrdR1Fdupe8Yi2F0
         vwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692187042; x=1692791842;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECJlIO/6X+Pq0Ru6+xgHtKmmcWycq6LlbP0Bph224Yc=;
        b=VG1luvItEAzN/tZKOFla013G8Zjnm0w9ZHsEN3KM3S6RiCv+sKDAKTKxI49iSTcFdu
         tzkCI6wAd+UmkTBJDQ4tIX2ZgFjhfon8fp7JyGlEUDj2lVT+sncC74jDFv0ADj06nPah
         BaihnvL5z1DdfGplz5mVULjj5aQt3WNCD5ypZOtoNB3QEetvGbGhZy7/DNCGeiqILhl0
         EWdjf2RXpAtzCO9kYIbvHb+6Iw78+f23Nmwzef7agaGed3gnCFDpnsNfICUcNCe39bBI
         d/BtSVNfQQR2LrqBR7Jxd3QQq7G7mck7kxxDSAskLSO5XjGX3V/mPwNZu7ya5s2Smdu2
         iohQ==
X-Gm-Message-State: AOJu0YwxWOumj17wEx69abbgvrkHwRMhe8hRDR448lHBD8MS26VZiT5g
        9lmzw9l8xLIwsX7pTuRKIrA=
X-Google-Smtp-Source: AGHT+IHwUyDdcJJDkGVFilyiGwroMhv1qT0g8fhl8vzPGP6sKSz4afgQH32TWPK0jraGCswdEmuOJw==
X-Received: by 2002:aca:220c:0:b0:3a7:8e2a:6173 with SMTP id b12-20020aca220c000000b003a78e2a6173mr1908248oic.2.1692187042017;
        Wed, 16 Aug 2023 04:57:22 -0700 (PDT)
Received: from smtpclient.apple (pdcd3f62f.hyognt01.ap.so-net.ne.jp. [220.211.246.47])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b00565009a97f0sm11662252pgd.17.2023.08.16.04.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:57:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Itaru Kitayama <itaru.kitayama@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 0/5] variable-order, large folios for anonymous memory
Date:   Wed, 16 Aug 2023 20:57:09 +0900
Message-Id: <6DEE431A-1089-4DB4-8BE3-152569576E53@gmail.com>
References: <3a0ada31-0ec5-4a7a-ab9d-d59c3684b662@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
In-Reply-To: <3a0ada31-0ec5-4a7a-ab9d-d59c3684b662@intel.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
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



> On Aug 16, 2023, at 18:25, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 8/16/2023 4:11 PM, Itaru Kitayama wrote:
>>=20
>>=20
>>>> On Aug 10, 2023, at 23:29, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>=20
>>> =EF=BB=BFHi All,
>>>=20
>>> This is v5 of a series to implement variable order, large folios for ano=
nymous
>>> memory. (currently called "LARGE_ANON_FOLIO", previously called "FLEXIBL=
E_THP").
>>> The objective of this is to improve performance by allocating larger chu=
nks of
>>> memory during anonymous page faults:
>>>=20
>>> 1) Since SW (the kernel) is dealing with larger chunks of memory than ba=
se
>>>  pages, there are efficiency savings to be had; fewer page faults, batch=
ed PTE
>>>  and RMAP manipulation, reduced lru list, etc. In short, we reduce kerne=
l
>>>  overhead. This should benefit all architectures.
>>> 2) Since we are now mapping physically contiguous chunks of memory, we c=
an take
>>>  advantage of HW TLB compression techniques. A reduction in TLB pressure=

>>>  speeds up kernel and user space. arm64 systems have 2 mechanisms to coa=
lesce
>>>  TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>>=20
>>> This patch set deals with the SW side of things (1). (2) is being tackle=
d in a
>>> separate series. The new behaviour is hidden behind a new Kconfig switch=
,
>>> LARGE_ANON_FOLIO, which is disabled by default. Although the eventual ai=
m is to
>>> enable it by default.
>>>=20
>>> My hope is that we are pretty much there with the changes at this point;=

>>> hopefully this is sufficient to get an initial version merged so that we=
 can
>>> scale up characterization efforts. Although they should not be merged un=
til the
>>> prerequisites are complete. These are in progress and tracked at [5].
>>>=20
>>> This series is based on mm-unstable (ad3232df3e41).
>>>=20
>>> I'm going to be out on holiday from the end of today, returning on 29th
>>> August. So responses will likely be patchy, as I'm terrified of posting
>>> to list from my phone!
>>>=20
>>>=20
>>> Testing
>>> -------
>>>=20
>>> This version adds patches to mm selftests so that the cow tests explicit=
ly test
>>> large anon folios, in the same way that thp is tested. When enabled you s=
hould
>>> see something similar at the start of the test suite:
>>>=20
>>> # [INFO] detected large anon folio size: 32 KiB
>>>=20
>>> Then the following results are expected. The fails and skips are due to e=
xisting
>>> issues in mm-unstable:
>>>=20
>>> # Totals: pass:207 fail:16 xfail:0 xpass:0 skip:85 error:0
>>>=20
>>> Existing mm selftests reveal 1 regression in khugepaged tests when
>>> LARGE_ANON_FOLIO is enabled:
>>>=20
>>> Run test: collapse_max_ptes_none (khugepaged:anon)
>>> Maybe collapse with max_ptes_none exceeded.... Fail
>>> Unexpected huge page
>>>=20
>>> I believe this is because khugepaged currently skips non-order-0 pages w=
hen
>>> looking for collapse opportunities and should get fixed with the help of=

>>> DavidH's work to create a mechanism to precisely determine shared vs exc=
lusive
>>> pages.
>>>=20
>>>=20
>>> Changes since v4 [4]
>>> --------------------
>>>=20
>>> - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
>>>   now uses the default order-3 size. I have moved this patch over to
>>>   the contpte series.
>>> - Added "mm: Allow deferred splitting of arbitrary large anon folios" ba=
ck
>>>   into series. I originally removed this at v2 to add to a separate seri=
es,
>>>   but that series has transformed significantly and it no longer fits, s=
o
>>>   bringing it back here.
>>> - Reintroduced dependency on set_ptes(); Originally dropped this at v2, b=
ut
>>>   set_ptes() is in mm-unstable now.
>>> - Updated policy for when to allocate LAF; only fallback to order-0 if
>>>   MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer rel=
y on
>>>   sysfs's never/madvise/always knob.
>>> - Fallback to order-0 whenever uffd is armed for the vma, not just when
>>>   uffd-wp is set on the pte.
>>> - alloc_anon_folio() now returns `strucxt folio *`, where errors are enc=
oded
>>>   with ERR_PTR().
>>>=20
>>> The last 3 changes were proposed by Yu Zhao - thanks!
>>>=20
>>>=20
>>> Changes since v3 [3]
>>> --------------------
>>>=20
>>> - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
>>> - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded th=
at a
>>>   sysctl is preferable but we will wait until real workload needs it.
>>> - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
>>> - Added mm selftests for large anon folios in cow test suite.
>>>=20
>>>=20
>>> Changes since v2 [2]
>>> --------------------
>>>=20
>>> - Dropped commit "Allow deferred splitting of arbitrary large anon folio=
s"
>>>     - Huang, Ying suggested the "batch zap" work (which I dropped from t=
his
>>>       series after v1) is a prerequisite for merging FLXEIBLE_THP, so I'=
ve
>>>       moved the deferred split patch to a separate series along with the=
 batch
>>>       zap changes. I plan to submit this series early next week.
>>> - Changed folio order fallback policy
>>>     - We no longer iterate from preferred to 0 looking for acceptable po=
licy
>>>     - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and 0=
 only
>>> - Removed vma parameter from arch_wants_pte_order()
>>> - Added command line parameter `flexthp_unhinted_max`
>>>     - clamps preferred order when vma hasn't explicitly opted-in to THP
>>> - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is dis=
abled
>>>   for process or system).
>>> - Simplified implementation and integration with do_anonymous_page()
>>> - Removed dependency on set_ptes()
>>>=20
>>>=20
>>> Changes since v1 [1]
>>> --------------------
>>>=20
>>> - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>>> - replaced with arch-independent alloc_anon_folio()
>>>     - follows THP allocation approach
>>> - no longer retry with intermediate orders if allocation fails
>>>     - fallback directly to order-0
>>> - remove folio_add_new_anon_rmap_range() patch
>>>     - instead add its new functionality to folio_add_new_anon_rmap()
>>> - remove batch-zap pte mappings optimization patch
>>>     - remove enabler folio_remove_rmap_range() patch too
>>>     - These offer real perf improvement so will submit separately
>>> - simplify Kconfig
>>>     - single FLEXIBLE_THP option, which is independent of arch
>>>     - depends on TRANSPARENT_HUGEPAGE
>>>     - when enabled default to max anon folio size of 64K unless arch
>>>       explicitly overrides
>>> - simplify changes to do_anonymous_page():
>>>     - no more retry loop
>>>=20
>>>=20
>>> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.rober=
ts@arm.com/
>>> [2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.rober=
ts@arm.com/
>>> [3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.rober=
ts@arm.com/
>>> [4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.rober=
ts@arm.com/
>>> [5] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd7=
3@arm.com/
>>>=20
>>>=20
>>> Thanks,
>>> Ryan
>>>=20
>>> Ryan Roberts (5):
>>> mm: Allow deferred splitting of arbitrary large anon folios
>>> mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
>>> mm: LARGE_ANON_FOLIO for improved performance
>>> selftests/mm/cow: Generalize do_run_with_thp() helper
>>> selftests/mm/cow: Add large anon folio tests
>>>=20
>>> include/linux/pgtable.h          |  13 ++
>>> mm/Kconfig                       |  10 ++
>>> mm/memory.c                      | 144 +++++++++++++++++--
>>> mm/rmap.c                        |  31 +++--
>>> tools/testing/selftests/mm/cow.c | 229 ++++++++++++++++++++++---------
>>> 5 files changed, 347 insertions(+), 80 deletions(-)
>>>=20
>>> --
>>> 2.25.1
>>>=20
>>=20
>> I know Ryan is away currently, but as I can=E2=80=99t find the base commi=
t mentioned in the cover letter to be based off of can anybody point me to i=
t so I can use b4 for applying the series and test?
>>=20
> Ryan mentioned: This series is based on mm-unstable (ad3232df3e41).

Couldn=E2=80=99t find the commit in the mm-unstable branch I checked out tod=
ay. I=E2=80=99m trying to use Andrew=E2=80=99s mm tree for the first time in=
 a decade so I=E2=80=99m doing something wrong though.

>=20
> I believe you can apply the patchset to latest mm-unstable.

Okay. Will try that.

Thanks,
Itaru.

>=20
>=20
> Regards
> Yin, Fengwei
>=20
>> Thanks,
>> Itaru.
