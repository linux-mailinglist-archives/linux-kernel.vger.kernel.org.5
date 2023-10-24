Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D57D5E94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjJXXQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJXXQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:16:52 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4857C10C9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:16:49 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b7205bc5a3so1797239241.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698189408; x=1698794208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOu+GUGt5bf45brXFu8qbvUcorQRuKU9cK9mjz8tCvw=;
        b=JFCgmwK5PRupk7IkG62GPTIpYVaYbExLzbuYr+cG9q2eewmPCXmFpYijV9tvTZ+Ukw
         fBVjdqAmyHzZfkKhqep5f2hfbDF2mOxR7Bz8LC+HOTzBoGA4PJ+AHxvsFt3iRdlZjKJ8
         AUqVSFfIdNE6Ax/qhSq80joyY3fVJu+ecVWYPaapGcPgQF14nKCu7BEq+oANdNIkleGq
         Gw2RfYjiPfGRqEc0HwtDxR0W8awsqMSiTEp40rXz9+SFKwqh7Q2hIO9r0gN9NkdOnBYr
         i5pnIgBB9T8lf4zb4uMBvikFSZjT8GJS97JaFcjbZcjVN7nv+Uwk/8mUb5CHQnYnSeJ/
         zNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698189408; x=1698794208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOu+GUGt5bf45brXFu8qbvUcorQRuKU9cK9mjz8tCvw=;
        b=Ekp/suRhruXfb6FrMFl9LF8QbvFuzsxKDm3Yg8uHZ3miCQCrnI0boe4ZFjw9877zTm
         RqfbkTJR/jwBuUE2Gg2NO8TNKbnLw4aPpFX1z+pVPtQaWi7pP30rTKqxUcc8asv5vuAn
         CieHrq6k+Mvx0bWbjMyZy11VrJOk6ZwJpa70bU6l37wBF5BJLjShckOct6dweZOr20wu
         u2eTit0o7pBmkpO/ybS7i92U6hB/8IoAztmFSs3LGLaR8Sb/RakRh/RIWn2D1bU0CRXz
         Urp/paTvIloRjLphcY0Em3KAkNuTbVYh7GC+OtaAiMkEFWA2EmHCE9zCZganqJLEl6aS
         EAJw==
X-Gm-Message-State: AOJu0YwkTvHZNlg7T/N7Fwi9EeqbDtHWT1zKwhxH1Hc4F451LESgWgqk
        trxkx1p1g6k18d6iJRNYiCPJGLLcX3dpQKva8M7WnAuNLQv/CA==
X-Google-Smtp-Source: AGHT+IFUhISub6RvDgagu1NeIrq/YwoFByzkIenUrghjxImmwcBRQQXlc1x+4E33oYimKOg/OqtJXARn26JO99YQRlk=
X-Received: by 2002:a05:6102:20dc:b0:452:66a7:1ac with SMTP id
 i28-20020a05610220dc00b0045266a701acmr13577539vsr.6.1698189408226; Tue, 24
 Oct 2023 16:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Oct 2023 07:16:36 +0800
Message-ID: <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
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

On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Now ptep_clear_flush_young() is only called by folio_referenced() to
> check if the folio was referenced, and now it will call a tlb flush on
> ARM64 architecture. However the tlb flush can be expensive on ARM64
> servers, especially for the systems with a large CPU numbers.
>
> Similar to the x86 architecture, below comments also apply equally to
> ARM64 architecture. So we can drop the tlb flush operation in
> ptep_clear_flush_young() on ARM64 architecture to improve the performance=
.
> "
> /* Clearing the accessed bit without a TLB flush
>  * doesn't cause data corruption. [ It could cause incorrect
>  * page aging and the (mistaken) reclaim of hot pages, but the
>  * chance of that should be relatively low. ]
>  *
>  * So as a performance optimization don't flush the TLB when
>  * clearing the accessed bit, it will eventually be flushed by
>  * a context switch or a VM operation anyway. [ In the rare
>  * event of it not getting flushed for a long time the delay
>  * shouldn't really matter because there's no real memory
>  * pressure for swapout to react to. ]
>  */
> "
> Running the thpscale to show some obvious improvements for compaction
> latency with this patch:
>                              base                   patched
> Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
> Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
> Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
> Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
> Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
> Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
> Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
> Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
> Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>                        base       patched
> Duration User         167.78      161.03
> Duration System      1836.66     1673.01
> Duration Elapsed     2074.58     2059.75
>
> Barry Song submitted a similar patch [1] before, that replaces the
> ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
> folio_referenced_one(). However, I'm not sure if removing the tlb flush
> operation is applicable to every architecture in kernel, so dropping
> the tlb flush for ARM64 seems a sensible change.
>
> Note: I am okay for both approach, if someone can help to ensure that
> all architectures do not need the tlb flush when clearing the accessed
> bit, then I also think Barry's patch is better (hope Barry can resend
> his patch).
>

Thanks!

ptep_clear_flush_young() with "flush" in its name clearly says it needs a
flush. but it happens in arm64, all other code which needs a flush has
called other variants, for example __flush_tlb_page_nosync():

static inline void arch_tlbbatch_add_pending(struct
arch_tlbflush_unmap_batch *batch,
 struct mm_struct *mm, unsigned long uaddr)
{
 __flush_tlb_page_nosync(mm, uaddr);
}

so it seems folio_referenced is the only left user of this
ptep_clear_flush_young().
The fact makes Baolin's patch look safe now.

but this function still has "flush" in its name, so one day, one person mig=
ht
call it with the understanding that it will flush tlb but actually it
won't. This is
bad smell in code.

I guess one side effect of not flushing tlb while clearing the access
flag is that
hardware won't see this cleared flag in the tlb, so it might not set this b=
it in
memory even though the bit has been cleared before in memory(but not in tlb=
)
while the page is accessed *again*.

next time, someone reads the access flag in memory again by folio_reference=
d,
he/she will see the page is cold as hardware has lost a chance to set
the bit again
since it finds tlb already has a true access flag.

But anyway, tlb is so small, it will be flushed by context switch and
other running
code soon. so it seems we don't actually require the access flag being inst=
antly
updated. the time gap, in which access flag might lose the new set by hardw=
are,
seems to be too short to really affect the accuracy of page reclamation. bu=
t its
cost is large.

(A). Constant flush cost vs. (B). very very occasional reclaimed hot
page,  B might
be a correct choice.

> [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail.co=
m/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 0bd18de9fd97..2979d796ba9d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct =
vm_area_struct *vma,
>  static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>                                          unsigned long address, pte_t *pt=
ep)
>  {
> -       int young =3D ptep_test_and_clear_young(vma, address, ptep);
> -
> -       if (young) {
> -               /*
> -                * We can elide the trailing DSB here since the worst tha=
t can
> -                * happen is that a CPU continues to use the young entry =
in its
> -                * TLB and we mistakenly reclaim the associated page. The
> -                * window for such an event is bounded by the next
> -                * context-switch, which provides a DSB to complete the T=
LB
> -                * invalidation.
> -                */
> -               flush_tlb_page_nosync(vma, address);
> -       }
> -
> -       return young;
> +       /*
> +        * This comment is borrowed from x86, but applies equally to ARM6=
4:
> +        *
> +        * Clearing the accessed bit without a TLB flush doesn't cause
> +        * data corruption. [ It could cause incorrect page aging and
> +        * the (mistaken) reclaim of hot pages, but the chance of that
> +        * should be relatively low. ]
> +        *
> +        * So as a performance optimization don't flush the TLB when
> +        * clearing the accessed bit, it will eventually be flushed by
> +        * a context switch or a VM operation anyway. [ In the rare
> +        * event of it not getting flushed for a long time the delay
> +        * shouldn't really matter because there's no real memory
> +        * pressure for swapout to react to. ]
> +        */
> +       return ptep_test_and_clear_young(vma, address, ptep);
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> --
> 2.39.3
>

Thanks
Barry
