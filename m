Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F67769301
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGaKV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGaKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:21:38 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC701721
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:21:12 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4864928ce7fso1370418e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690798871; x=1691403671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO4YP+z4WMJqE5RYqhT1g/1uHKez6CCD1v5scqmSYRs=;
        b=BHg2KigSzxjM8O+0pSQB4U/kMfbZ/7YxZeU8oKQ9KKb9FcBg4qcN0K2eIpc3JXjoZj
         ZThQoYbt1+OJlW5BiejOFwmOtoRQ9enWBLDpreFpUGE6k4ap2Otx8TNTrYNejQ2cMDHI
         i0BdNUfmiKprdXVMjp0Qa57wraiMYEG7MUCjT/kY470ln8PAgB4tlRVplAL0aDzeBpLz
         lgI5MELtuDb/oMko+/1LmyCDGkrmc0//TvBCvZZ8dnmCqfCE88Bp+urqibbQo/LmTKug
         ijCPrfXpJQ5UbizeUg/BYC7yNwqfJDCXfndKAlGhYFWOY4ASD+wVQAc5a2w4Tdc0cphH
         7QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690798871; x=1691403671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO4YP+z4WMJqE5RYqhT1g/1uHKez6CCD1v5scqmSYRs=;
        b=iQ3aIyXEDT6xUKDoUtqt802aR+zzNWChghC0TeIJ7o1Ak+RD7ChOcOBQaC3BhSVDIX
         ExwvIQ2U5Ftd/pNs2ToTMV/zsdBU8tD1xVnSxg6nmXbBewS70DJxsMzEUe4SNweKMH8g
         mgLuHA5fzQh2y22/0gi0gziH0SY/OCKwuE4PjsIimi9d6M53rnarUL5fgj1i+sxVy0QB
         UFddiH/d8G7Pk5FOrXCIGKne9EpzP45NCvcI0yZ4gU+W2bEOkoMxtEJan1b4vmqlANTR
         iDQiRIrsnDISM/BW+zHrvG2TiTZvyJGrAXM9LXPwCopKmIo7t/isPIUEo+W4fWZa7yl+
         DiRQ==
X-Gm-Message-State: ABy/qLZ/7d9mwwpibzMDK4iG+zJE1nFlKaWiBVJe9F8Bq90+pt0syShw
        zbpjqYMVmeXfRNStR9nlWs5v9Cd28aZvmoU44AU=
X-Google-Smtp-Source: APBJJlGlHxRyNyhgZEE5VQhEpKE8Dnte26FH1K/UrL4l3cyC1ubSlkAlLkMMLs8utfzsY5Iee8xOtCxsPCzCEJxgISw=
X-Received: by 2002:a1f:bf0c:0:b0:47e:30a:c7bc with SMTP id
 p12-20020a1fbf0c000000b0047e030ac7bcmr4427521vkf.12.1690798871539; Mon, 31
 Jul 2023 03:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-5-wangkefeng.wang@huawei.com> <CAGsJ_4xvSyvskcKMptiwm+8eV-sgSWsJYgBEYpwQ2n=cHHNZ7Q@mail.gmail.com>
 <CAGsJ_4yrsgJAzKq_-rPTnnr-AFXzgDK94m+WYxiAw4vq+TfGdA@mail.gmail.com> <d9694393-d916-0d7f-8fce-ac656de544de@huawei.com>
In-Reply-To: <d9694393-d916-0d7f-8fce-ac656de544de@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 31 Jul 2023 18:21:00 +0800
Message-ID: <CAGsJ_4xbV9AN=79H_jox5uf1w7ENd5x9vJZER+uUkahNbzAF_A@mail.gmail.com>
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

On Mon, Jul 31, 2023 at 5:29=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
>
>
> On 2023/7/31 16:43, Barry Song wrote:
> > On Mon, Jul 31, 2023 at 4:33=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Mon, Jul 31, 2023 at 4:14=E2=80=AFPM Kefeng Wang <wangkefeng.wang@h=
uawei.com> wrote:
> >>>
> >>> It is better to use huge_page_size() for hugepage(HugeTLB) instead of
> >>> PAGE_SIZE for stride, which has been done in flush_pmd/pud_tlb_range(=
),
> >>> it could reduce the loop in __flush_tlb_range().
> >>>
> >>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>> ---
> >>>   arch/arm64/include/asm/tlbflush.h | 21 +++++++++++----------
> >>>   1 file changed, 11 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/a=
sm/tlbflush.h
> >>> index 412a3b9a3c25..25e35e6f8093 100644
> >>> --- a/arch/arm64/include/asm/tlbflush.h
> >>> +++ b/arch/arm64/include/asm/tlbflush.h
> >>> @@ -360,16 +360,17 @@ static inline void __flush_tlb_range(struct vm_=
area_struct *vma,
> >>>          dsb(ish);
> >>>   }
> >>>
> >>> -static inline void flush_tlb_range(struct vm_area_struct *vma,
> >>> -                                  unsigned long start, unsigned long=
 end)
> >>> -{
> >>> -       /*
> >>> -        * We cannot use leaf-only invalidation here, since we may be=
 invalidating
> >>> -        * table entries as part of collapsing hugepages or moving pa=
ge tables.
> >>> -        * Set the tlb_level to 0 because we can not get enough infor=
mation here.
> >>> -        */
> >>> -       __flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
> >>> -}
> >>> +/*
> >>> + * We cannot use leaf-only invalidation here, since we may be invali=
dating
> >>> + * table entries as part of collapsing hugepages or moving page tabl=
es.
> >>> + * Set the tlb_level to 0 because we can not get enough information =
here.
> >>> + */
> >>> +#define flush_tlb_range(vma, start, end)                            =
   \
> >>> +       __flush_tlb_range(vma, start, end,                           =
   \
> >>> +                               ((vma)->vm_flags & VM_HUGETLB)       =
   \
> >>> +                               ? huge_page_size(hstate_vma(vma))    =
   \
> >>> +                               : PAGE_SIZE, false, 0)
> >>> +
> >>
> >> seems like a good idea.
> >>
> >> I wonder if a better implementation will be MMU_GATHER_PAGE_SIZE,  in =
this case,
> >> we are going to support stride for other large folios as well, such as=
 thp.
> >>
> >
> > BTW, in most cases we have already had right stride:
> >
> > arch/arm64/include/asm/tlb.h has already this to get stride:
>
> MMU_GATHER_PAGE_SIZE works for tlb_flush, but flush_tlb_range()
> directly called without mmu_gather, see above 3 patches is to
> use correct flush_[hugetlb/pmd/pud]_tlb_range(also there are
> some other places, like get_clear_contig_flush/clear_flush on arm64),
> so enable MMU_GATHER_PAGE_SIZE for arm64 is independent thing, right?
>

You are right. I was thinking of those zap_pte/pmd_range cases especially
for those vmas where large folios engage. but it is not very relevant.
In that case, one vma might have mixed different folio sizes.
your patch, for sure, will benefit hugetlb with arm64 contiguous bits.

Thanks
Barry
