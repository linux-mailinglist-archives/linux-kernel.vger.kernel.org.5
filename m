Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03117FE139
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjK2Uiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjK2Uiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:38:50 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDFD67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:38:56 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c51c5bc44fso43068241.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701290335; x=1701895135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06AuxLZ/sNf65GGJNy2PvCvvtYPHOzAkgOG09b2VhAE=;
        b=PZe42By/RdS/NF++H3WTxzeJlaPpRPBd10wcxkIWFMvrLiRiJPIuJD41eZ6VNFPLap
         er8P31G7DhjEzZN2xU+IOtTnL9Dc9zo4z3LV3EoOVKLcE73llYhpMv8AtpyWhJ4UryBa
         cmbQoG6mg53qBzjv10n0eog0x0aN8+w9fBL2PC1FI1XgwmdhZW/5gmUHrMPIMe0OyRsX
         weuOAI87GXElpJAG9ZUam7w3mUzSDMIS1iqhNXYG/pC4bdCMTjD3I6vOGVaTK7NTyCxD
         ZEZ+jMtg2EaysAoIhKuzO/6/0GOII3UTUss6FFptNWwm28aoZbt1IMGDQFMInEjEQ689
         6//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290335; x=1701895135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06AuxLZ/sNf65GGJNy2PvCvvtYPHOzAkgOG09b2VhAE=;
        b=MKV2kcThuA9YkR+A8BhMffIeRvcItYFSTAVpgpLUYETDazS10XSHpUOfUIgRYHc1Ob
         WBaah7NesAX3MNN1cAONtI9J1T5UudT7LLyrg95KGb3MdxoeAiBAhNsgicmXwrVqkJaG
         rb/tLi3uB+g8Z8zENJBk5zQDC7+iMN3Wl1AG9o8UiielxUOOCT2Ob3DpH6f1pXVBnThq
         uRtVXrE/pq6aAKVcmlH6v2Z0nt5XUgFhpS2+rtZcz5NdifKZM/pEbj4zIPqAuz4d5h7/
         weXmxFpCNUHd3DrPfQdkP5Phngbe2s4VAXWEFvKbSbZcTXBfRZOFB1HdfrtXqUz8tTOw
         3Kgw==
X-Gm-Message-State: AOJu0YyINLB9SN+/zdcnFvadA7S2NnC4oAqdKm6HIPa+icDF/BZwVpTh
        5tn9heA+nIhAs3Q7YqH2HWCCpWYzk3rU4TffOhw=
X-Google-Smtp-Source: AGHT+IEHVJGZHYun74LZbxEhoCO6kpuna43oPePL5nhtRxMZFhLhhWLWRaeJHOjUaYFutQhMxF00gbRdMAnr8IfvXmM=
X-Received: by 2002:a67:b34d:0:b0:464:5109:a338 with SMTP id
 b13-20020a67b34d000000b004645109a338mr1562541vsm.35.1701290335350; Wed, 29
 Nov 2023 12:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20231129074741.15682-1-v-songbaohua@oppo.com>
 <db4c7beb-ed80-445f-b6f4-0c4cf3f0e6be@arm.com>
In-Reply-To: <db4c7beb-ed80-445f-b6f4-0c4cf3f0e6be@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 30 Nov 2023 09:38:43 +1300
Message-ID: <CAGsJ_4zyhqwUS26bbx0a95rSO0jVANfC_RWdyTFbJQQG5KJ_cg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Swap-out small-sized THP without splitting
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 1:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 29/11/2023 07:47, Barry Song wrote:
> >> Hi All,
> >>
> >> This is v3 of a series to add support for swapping out small-sized THP=
 without
> >> needing to first split the large folio via __split_huge_page(). It clo=
sely
> >> follows the approach already used by PMD-sized THP.
> >>
> >> "Small-sized THP" is an upcoming feature that enables performance impr=
ovements
> >> by allocating large folios for anonymous memory, where the large folio=
 size is
> >> smaller than the traditional PMD-size. See [3].
> >>
> >> In some circumstances I've observed a performance regression (see patc=
h 2 for
> >> details), and this series is an attempt to fix the regression in advan=
ce of
> >> merging small-sized THP support.
> >>
> >> I've done what I thought was the smallest change possible, and as a re=
sult, this
> >> approach is only employed when the swap is backed by a non-rotating bl=
ock device
> >> (just as PMD-sized THP is supported today). Discussion against the RFC=
 concluded
> >> that this is probably sufficient.
> >>
> >> The series applies against mm-unstable (1a3c85fa684a)
> >>
> >>
> >> Changes since v2 [2]
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>  - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
> >>    allocation. This required some refactoring to make everything work =
nicely
> >>    (new patches 2 and 3).
> >>  - Fix bug where nr_swap_pages would say there are pages available but=
 the
> >>    scanner would not be able to allocate them because they were reserv=
ed for the
> >>    per-cpu allocator. We now allow stealing of order-0 entries from th=
e high
> >>    order per-cpu clusters (in addition to exisiting stealing from orde=
r-0
> >>    per-cpu clusters).
> >>
> >> Thanks to Huang, Ying for the review feedback and suggestions!
> >>
> >>
> >> Changes since v1 [1]
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>  - patch 1:
> >>     - Use cluster_set_count() instead of cluster_set_count_flag() in
> >>       swap_alloc_cluster() since we no longer have any flag to set. I =
was unable
> >>       to kill cluster_set_count_flag() as proposed against v1 as other=
 call
> >>       sites depend explicitly setting flags to 0.
> >>  - patch 2:
> >>     - Moved large_next[] array into percpu_cluster to make it per-cpu
> >>       (recommended by Huang, Ying).
> >>     - large_next[] array is dynamically allocated because PMD_ORDER is=
 not
> >>       compile-time constant for powerpc (fixes build error).
> >>
> >>
> >> Thanks,
> >> Ryan
> >
> >> P.S. I know we agreed this is not a prerequisite for merging small-siz=
ed THP,
> >> but given Huang Ying had provided some review feedback, I wanted to pr=
ogress it.
> >> All the actual prerequisites are either complete or being worked on by=
 others.
> >>
> >
> > Hi Ryan,
> >
> > this is quite important to a phone and a must-have component, so is lar=
ge-folio
> > swapin, as i explained to you in another email.
>
> Yes understood; the "prerequisites" are just the things that must be merg=
ed
> *before* small-sized THP to ensure we don't regress existing behaviour or=
 to
> ensure that small-size THP is correct/robust when enabled. Performance
> improvements can be merged after the initial small-sized series.

I completely agree. I didn't mean small-THP swap out as a whole  should be
a prerequisite for small-THP initial patchset, just describing how importan=
t
it is to a phone :-)

And actually we have done much further than this on phones by optimizing
zsmalloc/zram and allow a large folio compressed and decompressed
as a whole,  we have seen compressing/decompressing a whole large folio
can significantly improve compression ratio and decrease CPU consumption.

so that means large folios can not only save memory but also decrease
CPU consumption.

>
> > Luckily, we are having Chuanhua Han(Cc-ed) to prepare a patchset of lar=
gefolio
> > swapin on top of your this patchset, probably a port and cleanup of our
> > do_swap_page[1] againest yours.
>
> That's great to hear - welcome aboard, Chuanhua Han! Feel free to reach o=
ut if
> you have questions.
>
> I would guess that any large swap-in changes would be independent of this
> swap-out patch though? Wouldn't you just be looking for contiguous swap e=
ntries
> in the page table to determine a suitable folio order, then swap-in each =
of
> those entries into the folio? And if they happen to have contiguous swap =
offsets
> (enabled by this swap-out series) then you potentially get a batched disk=
 access
> benefit.

I agree. Maybe we still need to check if the number of contiguous swap entr=
ies
is one of those supported large folio sizes?

>
> That's just a guess though, perhaps you can describe your proposed approa=
ch?

we have an ugly hack if we are swapping in from the dedicated zRAM for
large folios,
we assume we have a chance to swapin as a whole, but we do also handle corn=
er
cases in which some entries might have been zap_pte_range()-ed.

My current proposal is as below,
A1. we get the number of contiguous swap entries with PTL and find it
is a valid large folio size
A2. we allocate large folio without PTL
A3. after getting PTL again, we re-check PTEs if the situation in A1
have been changed,
if no other threads change those PTEs, we set_ptes and finish the swap-in

but we have a chance to fail in A2, so in this case we still need to
fall back to basepage.

considering the MTE thread[1] I am handling, and MTE tag life cycle is
the same with swap
entry life cycle. it seems we will still need a page-level
arch_swap_restore even after
we support large folio swap-in for the below two reasons

1. contiguous PTEs might be partially dropped by madvise(DONTNEED) etc
2. we can still fall back to basepage for swap-in if we fail to get
large folio even PTEs are all
contiguous swap entries

Of course,  if we succeed in setting all PTEs for a large folio in A3,
we can have
a folio-level arch_swap_restore.

To me, an universal folio-level arch_swap_restore seems not sensible
to handle all kinds of
complex cases.

[1] [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for large fol=
ios
https://lore.kernel.org/linux-mm/20231114014313.67232-1-v-songbaohua@oppo.c=
om/

>
> >
> > Another concern is that swapslots can be fragmented, if we place small/=
large folios
> > in a swap device, since large folios always require contiguous swapslot=
, we can
> > result in failure of getting slots even we still have many free slots w=
hich are not
> > contiguous.
>
> This series tries to mitigate that problem by reserving a swap cluster pe=
r
> order. That works well until we run out of swap clusters; a cluster can't=
 be
> freed until all contained swap entries are swapped back in and deallocate=
d.
>
> But I think we should start with the simple approach first, and only solv=
e the
> problems as they arise through real testing.

I agree.

>
>  To avoid this, [2] dynamic hugepage solution have two swap devices,
> > one for basepage, the other one for CONTPTE. we have modified the prior=
ity-based
> > selection of swap devices to choose swap devices based on small/large f=
olios.
> > i realize this approache is super ugly and might be very hard to find a=
 way to
> > upstream though, it seems not universal especially if you are a linux s=
erver (-_-)
> >
> > two devices are not a nice approach though it works well for a real pro=
duct,
> > we might still need some decent way to address this problem while the p=
roblem
> > is for sure not a stopper of your patchset.
>
> I guess that approach works for your case because A) you only have 2 size=
s, and
> B) your swap device is zRAM, which dynamically allocate RAM as it needs i=
t.
>
> The upstream small-sized THP solution can support multiple sizes, so you =
would
> need a swap device per size (I think 13 is the limit at the moment - PMD =
size
> for 64K base page). And if your swap device is a physical block device, y=
ou
> can't dynamically parition it the way you can with zRAM. Nether of those =
things
> scale particularly well IMHO.

right.

>
> >
> > [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/on=
eplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L4648
> > [2] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/on=
eplus/sm8550_u_14.0.0_oneplus11/mm/swapfile.c#L1129
> >
> >>
> >> [1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.rob=
erts@arm.com/
> >> [2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.rob=
erts@arm.com/
> >> [3] https://lore.kernel.org/linux-mm/15a52c3d-9584-449b-8228-1335e0753=
b04@arm.com/
> >>
> >>
> >> Ryan Roberts (4):
> >>   mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
> >>   mm: swap: Remove struct percpu_cluster
> >>   mm: swap: Simplify ssd behavior when scanner steals entry
> >>   mm: swap: Swap-out small-sized THP without splitting
> >>
> >>  include/linux/swap.h |  31 +++---
> >>  mm/huge_memory.c     |   3 -
> >>  mm/swapfile.c        | 232 ++++++++++++++++++++++++------------------=
-
> >>  mm/vmscan.c          |  10 +-
> >>  4 files changed, 149 insertions(+), 127 deletions(-)
> >

Thanks
Barry
