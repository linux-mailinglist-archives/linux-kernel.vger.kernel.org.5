Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D976909C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGaIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGaIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:45:25 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B309127
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:44:07 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-486518f0ed4so1505018e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690793046; x=1691397846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r18jhhWoKmGAEeggGFCS+IEIfqajuENPnaVmIm75UL8=;
        b=H1dHmR4jWtu8kb3DPgCWGa1RmtkcCk6HzdcYf7ay04AB6dxdagGOH9Kzgy0NvSwozK
         yOnTCJ8eTDMG6yd5Jm4TLC9rthA7NCMe5+Nj/t2wNz4mBI+hKrcwNQGglEgLDH6Wcjq0
         UwnRu5PR2BC7K156kyjshOItozObwQOHxWJp4iyTrY5wLbn9Lq5QiiYspFqjcQ2FikZy
         w/shpcFbFmyTch37zlGqMQsqMXyzzB+ekiQjj4+xkWBwDxybjUCOcplMex21MuWvDfqo
         AA5phC124mJVdN9Sa4+qJd4xTOnKC7jGNrprtkkd8OcQD0HWEgyE0phs9f2nNx2Vkl5i
         Q8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793046; x=1691397846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r18jhhWoKmGAEeggGFCS+IEIfqajuENPnaVmIm75UL8=;
        b=DogE8ynSMRAYd+qn6UFysLYNxiC0u3M5PsUebR1K4Tzd5pfUvvZmEqElpVZpxhwgfF
         3ubeNdzRVWeV7cHVp3OIr2cA8Plrz+NLYArZffL3MHx4+mSrej1rV9ERU1SvkRxXHiU3
         4mFHhvd381OcnpF8nhAbNdPtj4dBQ5VA6UOiwlBGCSRb2+hgXYSiwcxOPcBZXZiVb/mB
         GEwISnUzRejhxywMMhCWO6TIu2bBV1GXL7b0x7BmTUZMhbMzQihOiFwpYmw4GWeRjQVI
         gGVFw4njW1GhoZoupsKU+NLNmznc1L7wWltNy57nPTTMF2C2SLFwPmq8YDVyVrt2dmPM
         jQMA==
X-Gm-Message-State: ABy/qLYN3HwksjuWE6JroGES79lmeq1bmp9aafVw9tCrXODrM601yh9e
        uG04pYoTSC1ecYtWzrJCIrpwO5O7WWNf5524SRY=
X-Google-Smtp-Source: APBJJlG8e+qI8QNAcosXZ3z3fAXYcapIo1K+d6cwFVVnDMsJV+SfFjxe9TyLi82bx2QRpFvRQQgnvdn62vyp/1ZE2AI=
X-Received: by 2002:a1f:c14b:0:b0:486:6cd7:95f2 with SMTP id
 r72-20020a1fc14b000000b004866cd795f2mr4599786vkf.8.1690793046602; Mon, 31 Jul
 2023 01:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-5-wangkefeng.wang@huawei.com> <CAGsJ_4xvSyvskcKMptiwm+8eV-sgSWsJYgBEYpwQ2n=cHHNZ7Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4xvSyvskcKMptiwm+8eV-sgSWsJYgBEYpwQ2n=cHHNZ7Q@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 31 Jul 2023 16:43:55 +0800
Message-ID: <CAGsJ_4yrsgJAzKq_-rPTnnr-AFXzgDK94m+WYxiAw4vq+TfGdA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: tlb: set huge page size to stride for hugepage
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 31, 2023 at 4:33=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Jul 31, 2023 at 4:14=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huaw=
ei.com> wrote:
> >
> > It is better to use huge_page_size() for hugepage(HugeTLB) instead of
> > PAGE_SIZE for stride, which has been done in flush_pmd/pud_tlb_range(),
> > it could reduce the loop in __flush_tlb_range().
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  arch/arm64/include/asm/tlbflush.h | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm=
/tlbflush.h
> > index 412a3b9a3c25..25e35e6f8093 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -360,16 +360,17 @@ static inline void __flush_tlb_range(struct vm_ar=
ea_struct *vma,
> >         dsb(ish);
> >  }
> >
> > -static inline void flush_tlb_range(struct vm_area_struct *vma,
> > -                                  unsigned long start, unsigned long e=
nd)
> > -{
> > -       /*
> > -        * We cannot use leaf-only invalidation here, since we may be i=
nvalidating
> > -        * table entries as part of collapsing hugepages or moving page=
 tables.
> > -        * Set the tlb_level to 0 because we can not get enough informa=
tion here.
> > -        */
> > -       __flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
> > -}
> > +/*
> > + * We cannot use leaf-only invalidation here, since we may be invalida=
ting
> > + * table entries as part of collapsing hugepages or moving page tables=
.
> > + * Set the tlb_level to 0 because we can not get enough information he=
re.
> > + */
> > +#define flush_tlb_range(vma, start, end)                              =
 \
> > +       __flush_tlb_range(vma, start, end,                             =
 \
> > +                               ((vma)->vm_flags & VM_HUGETLB)         =
 \
> > +                               ? huge_page_size(hstate_vma(vma))      =
 \
> > +                               : PAGE_SIZE, false, 0)
> > +
>
> seems like a good idea.
>
> I wonder if a better implementation will be MMU_GATHER_PAGE_SIZE,  in thi=
s case,
> we are going to support stride for other large folios as well, such as th=
p.
>

BTW, in most cases we have already had right stride:

arch/arm64/include/asm/tlb.h has already this to get stride:

static inline void tlb_flush(struct mmu_gather *tlb)
{
   struct vm_area_struct vma =3D TLB_FLUSH_VMA(tlb->mm, 0);
   bool last_level =3D !tlb->freed_tables;
   unsigned long stride =3D tlb_get_unmap_size(tlb);
   int tlb_level =3D tlb_get_level(tlb);

   /*
    * If we're tearing down the address space then we only care about
    * invalidating the walk-cache, since the ASID allocator won't
    * reallocate our ASID without invalidating the entire TLB.
  */
  if (tlb->fullmm) {
      if (!last_level)
           flush_tlb_mm(tlb->mm);
       return;
  }

   __flush_tlb_range(&vma, tlb->start, tlb->end, stride,
    last_level, tlb_level);
}

> >
> >  static inline void flush_tlb_kernel_range(unsigned long start, unsigne=
d long end)
> >  {
> > --
> > 2.41.0
> >
>
> Thanks
> Barry
