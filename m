Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F197F9DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjK0Kfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjK0Kfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:35:42 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FB183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:35:48 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-462a0e1245bso1457530137.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701081347; x=1701686147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN2NHS0ADz42vQgBk5jmGpz9KoJL/tRq0nS2+wspS0I=;
        b=hB8eqnWBmHTNBKKeGxq4iZyip84TB4nhc3T74ljiMy5jPWdGwxgYUSPMwfLMiuskRZ
         iVu/bN+ZQkLBUMLkicThfeWTe546fOp12pe+1N8dOVqdwqL7GV58oIv6b3ieBI6jwPJw
         QyZ9EIU69ihgYHM4Kjw4iScJBfgYTHRNyBF5/Bf+oeBgHvQYarRSF/p+p7oQz29+Guge
         SOlbeWaMW4aHsHgLQWkbroDdT0QArKohZSZyQSLJ8UQZecjdLUW/qGcLAax6BAyLoCdO
         FTdHQ6WLtSX3/aGIAb5S0okSEpJCcZbjkWJUOwOsTFsO1sleFKnVDC4LAqX1741jsFyb
         FqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081347; x=1701686147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN2NHS0ADz42vQgBk5jmGpz9KoJL/tRq0nS2+wspS0I=;
        b=bLdnC6cmi99pLuwt49yx+UoIoC12c1RP9uoIDwCe8CZRGe8/0TujXCwsoLNX4ti534
         1z2hbEaxhH4LN8AkC1QyXFWqonOFecr473bteJja26cK6w9rwtQ3MfFEy7/W0j/eqzdL
         DrKIhCBqb+DThakk7HPGALwzf0hyJuGjloWbcJ/Sl1uHZntmmtS1J8nj5FuGki6nGxW6
         Y8NIQlf1G4WsXK90gUvFP4ZYBzwELVIuZArGmua9SmDKHyOUUeyuysT7Cr99df1OadHF
         6kr0Vajgj6L3NTCGWRN3Pm/hAn0/d+ZAxuFz/uR0BYTISuWGe1r/BjHYGKbtzi0BagMN
         Y2OQ==
X-Gm-Message-State: AOJu0YwFhncbeZZP2wDU6YYDKJp0vWtbHMxwyoKZDJFMnKbFBJT0zfkx
        Wbf/XtiTYzd1b9JeRrJpVPSMLybYAfj+WRKKPg8=
X-Google-Smtp-Source: AGHT+IGNqLxrdpuDVZuDBdZvRc0DGZ+sapq9bI1ucbL3A67bCeygEGVywRqbAdJU8SE8CN+G+VEewgfYqtFxTdwpCp0=
X-Received: by 2002:a67:b107:0:b0:462:ba4d:ccd4 with SMTP id
 w7-20020a67b107000000b00462ba4dccd4mr10287500vsl.30.1701081347189; Mon, 27
 Nov 2023 02:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com> <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
In-Reply-To: <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 27 Nov 2023 23:35:35 +1300
Message-ID: <CAGsJ_4w3nGSO+CF-PQaHOVtzpb-RkZiWTqkg51ibT6dDo_EeJA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:15=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
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

I don't think it is safe to keep CONTPTE folded in a split_vma case. as
otherwise, copy_ptes in your other patch might only copy a part
of CONTPES.
For example,  if page0-page4 and page5-page15 are splitted in split_vma,
in fork, while copying pte for the first VMA, we are copying page0-page4,
this will immediately cause inconsistent CONTPTE. as we have to
make sure all CONTPTEs are atomically mapped in a PTL.

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

Thanks
 Barry
