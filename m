Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B77BC23A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjJFW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjJFW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:28:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CEC8F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:28:39 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-419768e69dfso112061cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696631318; x=1697236118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNXo4Ck+cb5kMjLZ1w1gFPLnQ9WFu3luQ6DdPjjydeM=;
        b=ntg9VMDVvnvOMQNunf8XVbum8pcXhm/XdTBaA+t4spIJp+4uH4umzoatHglzkFoM3P
         nJpKgzTCMe97ZotWGb+TjdLyC6c7i0ADVZawtnbBoBMTskuU3UkjtpjRNQQFC4V0kLJO
         cshyDnmgCS3YI3+xsIlnpMXT/87MJtb693/KRh/BAnDJoCt4xQu8zTar3P7wp3QfnUfm
         SHuU1YLexwOMDXQtWFmz5iJK/AuEENpQJOW//4SS86zNXQ2qJaem+Ye5rMz0q2psfLzU
         fktjOzuBSb7F5k5QcVnS4NpoI/mgQBX90CK+m5YQo63x5vW6WMk5cdoAmygFPCkHXxGI
         FKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696631318; x=1697236118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNXo4Ck+cb5kMjLZ1w1gFPLnQ9WFu3luQ6DdPjjydeM=;
        b=eBTj/kbSHcpiIZu+kxRjkGNwQw7yhxcrqPV6KQm+VK4x3eii3NqOdyzTg0LqwOV/E7
         NR4Jrs/J+ffZSgJV/i8GSyLjw5ey4LsvMjCq9DQVO78eLhKYoIhl+uSvFvvLCBPfh7Nv
         T9oD8hPnj6KfRBVpadEN0iowRUXOOedQpIJMAFLpdIOKZ05WjS3jYXpsL9urjbf4ehX5
         yKFhAMDGhNQQp/xxAxEuHjqmKDMlEQfOW6cmAAuiNn7Ivjohi9GFJa7NRJTPbFCaP8mu
         0RS3feH+2ZYk7MGp5yTaOfpm58QjYwyZM/6FVFJHar+LlzAmJwSBIrbOF9lG7GWW7Ulc
         Y3ow==
X-Gm-Message-State: AOJu0YzPfgR5Vfri0fqvh8oMAWOJYSTaauLDGdHJIS6Zq73JBRLqb339
        wn1BWJtprxs9ZwiA9X5IRYLeDbjcmJsh24Bxk3junQ==
X-Google-Smtp-Source: AGHT+IFttWebdUSxJpbaQyrtnuXc6BVLXJiiyF08oBFcvtqaVZRda+96rYta3bQaMl8pMHaJou6x8IrBmegXGYQj1sg=
X-Received: by 2002:ac8:5981:0:b0:3e0:c2dd:fd29 with SMTP id
 e1-20020ac85981000000b003e0c2ddfd29mr513044qte.4.1696631318364; Fri, 06 Oct
 2023 15:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-7-ryan.roberts@arm.com> <2f64809e-0d0d-cc61-71ac-8d9b072efc3a@redhat.com>
In-Reply-To: <2f64809e-0d0d-cc61-71ac-8d9b072efc3a@redhat.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 6 Oct 2023 16:28:02 -0600
Message-ID: <CAOUHufb=qurWDFaX2TPQrsmUpEz+VRwm=SxivYuuDiJ4D-f0+g@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] mm: thp: Add "recommend" option for anon_orders
To:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 2:08=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 29.09.23 13:44, Ryan Roberts wrote:
> > In addition to passing a bitfield of folio orders to enable for THP,
> > allow the string "recommend" to be written, which has the effect of
> > causing the system to enable the orders preferred by the architecture
> > and by the mm. The user can see what these orders are by subsequently
> > reading back the file.
> >
> > Note that these recommended orders are expected to be static for a give=
n
> > boot of the system, and so the keyword "auto" was deliberately not used=
,
> > as I want to reserve it for a possible future use where the "best" orde=
r
> > is chosen more dynamically at runtime.
> >
> > Recommended orders are determined as follows:
> >    - PMD_ORDER: The traditional THP size
> >    - arch_wants_pte_order() if implemented by the arch
> >    - PAGE_ALLOC_COSTLY_ORDER: The largest order kept on per-cpu free li=
st
> >
> > arch_wants_pte_order() can be overridden by the architecture if desired=
.
> > Some architectures (e.g. arm64) can coalsece TLB entries if a contiguou=
s
> > set of ptes map physically contigious, naturally aligned memory, so thi=
s
> > mechanism allows the architecture to optimize as required.
> >
> > Here we add the default implementation of arch_wants_pte_order(), used
> > when the architecture does not define it, which returns -1, implying
> > that the HW has no preference.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst |  4 ++++
> >   include/linux/pgtable.h                    | 13 +++++++++++++
> >   mm/huge_memory.c                           | 14 +++++++++++---
> >   3 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 732c3b2f4ba8..d6363d4efa3a 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -187,6 +187,10 @@ pages (=3D16K if the page size is 4K). The example=
 above enables order-9
> >   By enabling multiple orders, allocation of each order will be
> >   attempted, highest to lowest, until a successful allocation is made.
> >   If the PMD-order is unset, then no PMD-sized THPs will be allocated.
> > +It is also possible to enable the recommended set of orders, which
> > +will be optimized for the architecture and mm::
> > +
> > +     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
> >
> >   The kernel will ignore any orders that it does not support so read th=
e
> >   file back to determine which orders are enabled::
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index af7639c3b0a3..0e110ce57cc3 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -393,6 +393,19 @@ static inline void arch_check_zapped_pmd(struct vm=
_area_struct *vma,
> >   }
> >   #endif
> >
> > +#ifndef arch_wants_pte_order
> > +/*
> > + * Returns preferred folio order for pte-mapped memory. Must be in ran=
ge [0,
> > + * PMD_ORDER) and must not be order-1 since THP requires large folios =
to be at
> > + * least order-2. Negative value implies that the HW has no preference=
 and mm
> > + * will choose it's own default order.
> > + */
> > +static inline int arch_wants_pte_order(void)
> > +{
> > +     return -1;
> > +}
> > +#endif
> > +
> >   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >                                      unsigned long address,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index bcecce769017..e2e2d3906a21 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -464,10 +464,18 @@ static ssize_t anon_orders_store(struct kobject *=
kobj,
> >       int err;
> >       int ret =3D count;
> >       unsigned int orders;
> > +     int arch;
> >
> > -     err =3D kstrtouint(buf, 0, &orders);
> > -     if (err)
> > -             ret =3D -EINVAL;
> > +     if (sysfs_streq(buf, "recommend")) {
> > +             arch =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_OR=
DER);
> > +             orders =3D BIT(arch);
> > +             orders |=3D BIT(PAGE_ALLOC_COSTLY_ORDER);
> > +             orders |=3D BIT(PMD_ORDER);
> > +     } else {
> > +             err =3D kstrtouint(buf, 0, &orders);
> > +             if (err)
> > +                     ret =3D -EINVAL;
> > +     }
> >
> >       if (ret > 0) {
> >               orders &=3D THP_ORDERS_ALL_ANON;
>
> :/ don't really like that. Regarding my proposal, one could have
> something like that in an "auto" setting for the "enabled" value, or a
> "recommended" setting [not sure].

Me either.

Again this is something I call random --  we only discussed "auto",
and yes, the commit message above explained why "recommended" here but
it has never surfaced in previous discussions, has it?

If so, this reinforces what I said here [1].

[1] https://lore.kernel.org/mm-commits/CAOUHufYEKx5_zxRJkeqrmnStFjR+pVQdpZ4=
0ATSTaxLA_iRPGw@mail.gmail.com/
