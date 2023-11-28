Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825797FB07F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjK1DNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjK1DNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:13:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C021A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:13:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2859551886cso2750496a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701141233; x=1701746033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfP5mMSfLJ6WwJw6W2yDqYJjxBNmPJwPrm2m/+Ywi/Q=;
        b=F85aA4Ajl5IvZkiDOHK08YIkNzS547acVnF3q+T9K0iViDmbnmjFG35Pn4c+86W41m
         cTAnDDA6OCCDbQKHDYJtCk2+1AEa5an3uZTqAHdzaiXIKUfu2PyCn0drGu+ZFbxBodkh
         VlwCWjakmtvMEeLQOZK/YC7vkpXnO+I+2ppt3oALYTtc1V7W8k7JYlvDTUxvhJFAn3kL
         2oQpZqIpCPwFtPPt+I66HLIwcczdtIsVHYg1nhMPYYMOHY6YHhPesMW7+hitLsgXAPP2
         gSqi1WjF+3Tug8B6A6XXD3N/WMFuFN0/k3IW64Y7lLBzl2HgPhzmYQmczFt97MbI0wob
         w32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701141233; x=1701746033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfP5mMSfLJ6WwJw6W2yDqYJjxBNmPJwPrm2m/+Ywi/Q=;
        b=hs6E5+c1UQgKg1bJdCkvQrs1oaX1pPnwZ+Fz7lfRFaZB1l5B/6YQZ42mSNbJ3Jlbo/
         OIQYHNB9mAunrapHeRpmyK3apSXJfzGMgOevys+quJRI4d8a9xvoCgvLASqlSlJ+txql
         XoMySOtb0fcZHzsCIuB9hBgKqTE/Bxk1ukXppuuMD2WA6szCsh60Cb9vwhve4Pwn5bzA
         s+SgJoj93OLTvvf3Y8sWNq/D2QWn1sshDj62MFiOrpWnTTPplhJWxPfl6vy4SqwulTmy
         Q0Wo/4VeGUVWXxU77l8OycxKdQSaeGHe0Hiby38buIBDrYyFIiBIAbmKMulbtLSpVYwv
         Pm8Q==
X-Gm-Message-State: AOJu0Yy/YxdNMZ3lO+MZYYNWZUHIc+oYFFcKYfmTcUiJ/B+vWTq0a8Nb
        JXnapjrFgUfhJVMIwcpytkSOl4RHDLRf95qlNQ8=
X-Google-Smtp-Source: AGHT+IEdzP5roOA0rdkzFKM7yNebk6ltpIEeaVjg/gI5b0YNqA0av2Bbqdk6vjLx8g+gaaDjZfRum0qi+Y/2kKcibHQ=
X-Received: by 2002:a17:90b:1809:b0:27d:b244:cd28 with SMTP id
 lw9-20020a17090b180900b0027db244cd28mr15031170pjb.42.1701141233551; Mon, 27
 Nov 2023 19:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com> <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
In-Reply-To: <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 27 Nov 2023 19:13:41 -0800
Message-ID: <CAHbLzkpbKwM9gjaeAnvEXwNCYsnMJO7JyjyFxxfnJOwMxDPBSw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        andreyknvl@gmail.com, anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 1:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/11/2023 03:18, Barry Song wrote:
> >> Ryan Roberts (14):
> >>   mm: Batch-copy PTE ranges during fork()
> >>   arm64/mm: set_pte(): New layer to manage contig bit
> >>   arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
> >>   arm64/mm: pte_clear(): New layer to manage contig bit
> >>   arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
> >>   arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bi=
t
> >>   arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
> >>   arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
> >>   arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
> >>   arm64/mm: ptep_get(): New layer to manage contig bit
> >>   arm64/mm: Split __flush_tlb_range() to elide trailing DSB
> >>   arm64/mm: Wire up PTE_CONT for user mappings
> >>   arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
> >>   arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
> >
> > Hi Ryan,
> > Not quite sure if I missed something, are we splitting/unfolding CONTPT=
ES
> > in the below cases
>
> The general idea is that the core-mm sets the individual ptes (one at a t=
ime if
> it likes with set_pte_at(), or in a block with set_ptes()), modifies its
> permissions (ptep_set_wrprotect(), ptep_set_access_flags()) and clears th=
em
> (ptep_clear(), etc); This is exactly the same interface as previously.
>
> BUT, the arm64 implementation of those interfaces will now detect when a =
set of
> adjacent PTEs (a contpte block - so 16 naturally aligned entries when usi=
ng 4K
> base pages) are all appropriate for having the CONT_PTE bit set; in this =
case
> the block is "folded". And it will detect when the first PTE in the block
> changes such that the CONT_PTE bit must now be unset ("unfolded"). One of=
 the
> requirements for folding a contpte block is that all the pages must belon=
g to
> the *same* folio (that means its safe to only track access/dirty for thec=
ontpte
> block as a whole rather than for each individual pte).
>
> (there are a couple of optimizations that make the reality slightly more
> complicated than what I've just explained, but you get the idea).
>
> On that basis, I believe all the specific cases you describe below are al=
l
> covered and safe - please let me know if you think there is a hole here!
>
> >
> > 1. madvise(MADV_DONTNEED) on a part of basepages on a CONTPTE large fol=
io
>
> The page will first be unmapped (e.g. ptep_clear() or ptep_get_and_clear(=
), or
> whatever). The implementation of that will cause an unfold and the CONT_P=
TE bit
> is removed from the whole contpte block. If there is then a subsequent
> set_pte_at() to set a swap entry, the implementation will see that its no=
t
> appropriate to re-fold, so the range will remain unfolded.
>
> >
> > 2. vma split in a large folio due to various reasons such as mprotect,
> > munmap, mlock etc.
>
> I'm not sure if PTEs are explicitly unmapped/remapped when splitting a VM=
A? I
> suspect not, so if the VMA is split in the middle of a currently folded c=
ontpte
> block, it will remain folded. But this is safe and continues to work corr=
ectly.
> The VMA arrangement is not important; it is just important that a single =
folio
> is mapped contiguously across the whole block.

Even with different permissions, for example, read-only vs read-write?
The mprotect() may change the permission. It should be misprogramming
per ARM ARM.

>
> >
> > 3. try_to_unmap_one() to reclaim a folio, ptes are scanned one by one
> > rather than being as a whole.
>
> Yes, as per 1; the arm64 implementation will notice when the first entry =
is
> cleared and unfold the contpte block.
>
> >
> > In hardware, we need to make sure CONTPTE follow the rule - always 16
> > contiguous physical address with CONTPTE set. if one of them run away
> > from the 16 ptes group and PTEs become unconsistent, some terrible
> > errors/faults can happen in HW. for example
>
> Yes, the implementation obeys all these rules; see contpte_try_fold() and
> contpte_try_unfold(). the fold/unfold operation is only done when all
> requirements are met, and we perform it in a manner that is conformant to=
 the
> architecture requirements (see contpte_fold() - being renamed to
> contpte_convert() in the next version).
>
> Thanks for the review!
>
> Thanks,
> Ryan
>
> >
> > case0:
> > addr0 PTE - has no CONTPE
> > addr0+4kb PTE - has CONTPTE
> > ....
> > addr0+60kb PTE - has CONTPTE
> >
> > case 1:
> > addr0 PTE - has no CONTPE
> > addr0+4kb PTE - has CONTPTE
> > ....
> > addr0+60kb PTE - has swap
> >
> > Unconsistent 16 PTEs will lead to crash even in the firmware based on
> > our observation.
> >
> > Thanks
> > Barry
> >
> >
>
>
