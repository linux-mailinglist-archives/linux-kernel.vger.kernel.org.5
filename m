Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A473C7BEB2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378508AbjJIUFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376628AbjJIUFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:05:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DB94
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:05:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4195fe5cf73so600171cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696881909; x=1697486709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RmUseYDBSAK6ld4te5RZdIrDezIy+kRo+tEZernjK0=;
        b=pfCrYpzxqs/BUYc4bggKnDkaW2yNdeAU5ZtGvJkQOrvwqsaCOJfTGEsLWdMgJv2UK0
         16r9PZdpNXi+xE7e5qTOJ66Sg3qux5gXMVDq+YVsD9Jyd6gzJzfHJ650BzAc0W2R2Flr
         hVbbKkxoijXjTsLi3APgE7oxY8Nn6RBOcRQJBpBhuQ78dm8cXGFvo/41OIf11uoof136
         dBOh8FS/SNSWyOKNhKyr+ovyXWfNa79dpVxaMfZvXqikbZoAzj3X9QktnAfEDcTz97T+
         5tpj3NLj2pj40cSPTb2Utb1mYIOkNx4mwv6iraMK9ySHbKhCMWs996mFZSsDG5QQgUuC
         cTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881909; x=1697486709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RmUseYDBSAK6ld4te5RZdIrDezIy+kRo+tEZernjK0=;
        b=luIYc/ajzVuGiNu5Qly4YXxZSSRXzgy3hJyBpmI7wmdNoDS8apxGrhD25gHIjcoP9i
         fKyaneWda6S0fwxkSe+oRGbDTGjzV3h0FfBSz7VFCsQcynaM7yV3tyNFUBfcvqjg/mW+
         7/5Xia9UH34Wyb8HCNMTuDucY9uHVpFMvutJgmdjhNlfsVdQMcghmqlXfxfQaBORDbSB
         UOfDbXfRrE/P/A+rVr6w0HJG0hABtce+bAuWrpwTcFYDGFtgjOPvAg7n6YiyU4nNj8hx
         yEz5NFRynct7Co8jKyQRZQZTmc8GGnsS4m4RyCXQpcM4Q9j1JhzO8MeVy5xx6ulD7uK2
         aI1Q==
X-Gm-Message-State: AOJu0YyM0qoJMGSqS2o1oGTooBLeVPRiQnCmRWwE4d/M75TxEUofDVYN
        bP+qRoWVTNjLEReyeZbK9s3LTjWAqHLhr1fkAia4Qg==
X-Google-Smtp-Source: AGHT+IGuPKApUxVXeX87MEU5C5RGG7tpaE3pkFUsYZuECjF/GvRH8xUtxcnStjwfiI4PbDzwvmONgLQQENsV7Ph6E/M=
X-Received: by 2002:a05:622a:1452:b0:410:88a5:92f with SMTP id
 v18-20020a05622a145200b0041088a5092fmr1185590qtx.0.1696881909137; Mon, 09 Oct
 2023 13:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-7-ryan.roberts@arm.com> <2f64809e-0d0d-cc61-71ac-8d9b072efc3a@redhat.com>
 <CAOUHufb=qurWDFaX2TPQrsmUpEz+VRwm=SxivYuuDiJ4D-f0+g@mail.gmail.com> <25d1cdee-3da8-4728-aa0d-dc07eb28ea95@arm.com>
In-Reply-To: <25d1cdee-3da8-4728-aa0d-dc07eb28ea95@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 9 Oct 2023 14:04:31 -0600
Message-ID: <CAOUHufbHRVPyu7uSWwPzU6eYF1xhOS_amZsUzX5__2=2bc3XRQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] mm: thp: Add "recommend" option for anon_orders
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suren Baghdasaryan <surenb@google.com>
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

On Mon, Oct 9, 2023 at 5:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 06/10/2023 23:28, Yu Zhao wrote:
> > On Fri, Oct 6, 2023 at 2:08=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 29.09.23 13:44, Ryan Roberts wrote:
> >>> In addition to passing a bitfield of folio orders to enable for THP,
> >>> allow the string "recommend" to be written, which has the effect of
> >>> causing the system to enable the orders preferred by the architecture
> >>> and by the mm. The user can see what these orders are by subsequently
> >>> reading back the file.
> >>>
> >>> Note that these recommended orders are expected to be static for a gi=
ven
> >>> boot of the system, and so the keyword "auto" was deliberately not us=
ed,
> >>> as I want to reserve it for a possible future use where the "best" or=
der
> >>> is chosen more dynamically at runtime.
> >>>
> >>> Recommended orders are determined as follows:
> >>>    - PMD_ORDER: The traditional THP size
> >>>    - arch_wants_pte_order() if implemented by the arch
> >>>    - PAGE_ALLOC_COSTLY_ORDER: The largest order kept on per-cpu free =
list
> >>>
> >>> arch_wants_pte_order() can be overridden by the architecture if desir=
ed.
> >>> Some architectures (e.g. arm64) can coalsece TLB entries if a contigu=
ous
> >>> set of ptes map physically contigious, naturally aligned memory, so t=
his
> >>> mechanism allows the architecture to optimize as required.
> >>>
> >>> Here we add the default implementation of arch_wants_pte_order(), use=
d
> >>> when the architecture does not define it, which returns -1, implying
> >>> that the HW has no preference.
> >>>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>   Documentation/admin-guide/mm/transhuge.rst |  4 ++++
> >>>   include/linux/pgtable.h                    | 13 +++++++++++++
> >>>   mm/huge_memory.c                           | 14 +++++++++++---
> >>>   3 files changed, 28 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentati=
on/admin-guide/mm/transhuge.rst
> >>> index 732c3b2f4ba8..d6363d4efa3a 100644
> >>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>> @@ -187,6 +187,10 @@ pages (=3D16K if the page size is 4K). The examp=
le above enables order-9
> >>>   By enabling multiple orders, allocation of each order will be
> >>>   attempted, highest to lowest, until a successful allocation is made=
.
> >>>   If the PMD-order is unset, then no PMD-sized THPs will be allocated=
.
> >>> +It is also possible to enable the recommended set of orders, which
> >>> +will be optimized for the architecture and mm::
> >>> +
> >>> +     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
> >>>
> >>>   The kernel will ignore any orders that it does not support so read =
the
> >>>   file back to determine which orders are enabled::
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index af7639c3b0a3..0e110ce57cc3 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -393,6 +393,19 @@ static inline void arch_check_zapped_pmd(struct =
vm_area_struct *vma,
> >>>   }
> >>>   #endif
> >>>
> >>> +#ifndef arch_wants_pte_order
> >>> +/*
> >>> + * Returns preferred folio order for pte-mapped memory. Must be in r=
ange [0,
> >>> + * PMD_ORDER) and must not be order-1 since THP requires large folio=
s to be at
> >>> + * least order-2. Negative value implies that the HW has no preferen=
ce and mm
> >>> + * will choose it's own default order.
> >>> + */
> >>> +static inline int arch_wants_pte_order(void)
> >>> +{
> >>> +     return -1;
> >>> +}
> >>> +#endif
> >>> +
> >>>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>>                                      unsigned long address,
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index bcecce769017..e2e2d3906a21 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -464,10 +464,18 @@ static ssize_t anon_orders_store(struct kobject=
 *kobj,
> >>>       int err;
> >>>       int ret =3D count;
> >>>       unsigned int orders;
> >>> +     int arch;
> >>>
> >>> -     err =3D kstrtouint(buf, 0, &orders);
> >>> -     if (err)
> >>> -             ret =3D -EINVAL;
> >>> +     if (sysfs_streq(buf, "recommend")) {
> >>> +             arch =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_=
ORDER);
> >>> +             orders =3D BIT(arch);
> >>> +             orders |=3D BIT(PAGE_ALLOC_COSTLY_ORDER);
> >>> +             orders |=3D BIT(PMD_ORDER);
> >>> +     } else {
> >>> +             err =3D kstrtouint(buf, 0, &orders);
> >>> +             if (err)
> >>> +                     ret =3D -EINVAL;
> >>> +     }
> >>>
> >>>       if (ret > 0) {
> >>>               orders &=3D THP_ORDERS_ALL_ANON;
> >>
> >> :/ don't really like that. Regarding my proposal, one could have
> >> something like that in an "auto" setting for the "enabled" value, or a
> >> "recommended" setting [not sure].
> >
> > Me either.
> >
> > Again this is something I call random --  we only discussed "auto",
> > and yes, the commit message above explained why "recommended" here but
> > it has never surfaced in previous discussions, has it?
>
> The context in which we discussed "auto" was for a future aspiration to
> automatically determine the order that should be used for a given allocat=
ion to
> balance perf vs internal fragmentation.
>
> The case we are talking about here is completely different; I had a pre-e=
xisting
> feature from previous versions of the series, which would allow the arch =
to
> specify its preferred order (originally proposed by Yu, IIRC). In moving =
the
> allocation size decision to user space, I felt that we still needed a mec=
hanism
> whereby the arch could express its preference. And "recommend" is what I =
came up
> with.
>
> All of the friction we are currently having is around this feature, I thi=
nk?
> Certainly all the links you provided in the other thread all point to
> conversations skirting around it. How about I just drop it for this initi=
al
> patch set? Just let user space decide what sizes it wants (per David's in=
terface
> proposal)? I can see I'm trying to get a square peg into a round hole.

Yes, and I think I've been fairly clear since the beginning: why can't
the initial patchset only have what we agreed on so that it can get
merged asap?

Since we haven't agreed on any ABI changes (sysfs, stats, etc.),
debugfs (Suren @ Android), boot parameters, etc., Kconfig is the only
mergeable option at the moment. To answer your questions [1][2], i.e.,
why "a compile time option": it's not to make *my testing* easier;
it's for *your series* to make immediate progress.

[1] https://lore.kernel.org/mm-commits/137d2fc4-de8b-4dda-a51d-31ce6b29a3d0=
@arm.com/
[2] https://lore.kernel.org/mm-commits/316054fd-0acb-4277-b9da-d21f0dae2d29=
@arm.com/
