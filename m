Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80357937CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjIFJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIFJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:12:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDD4E5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:11:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31977ace1c8so3029303f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693991506; x=1694596306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FRe7ZqsNTAoDqqmat7zXdkTAVIWG/sthvOCRdId5kc=;
        b=Lg8uv/ilsutXHVOv5Jr3TpSuIzomqZpugZxXWUqwu1DrzAjd+5qz0+ADMDe8Rqsz12
         MpOn0xfPyLBQ1HaWh/iOt0A1o2VfxvMI/fkOXRYW1cLmt4tLQJG00xJzJTwR2ScRWoxo
         AbX9re8sdpsQo5al3z1UPOdr/wfk/J1o4f2AdeOl9kMWI2Pr0Imp/zGP5wdtD8pywK+t
         BOTjGwztTExJS9fwB9P2zVY20Wo/5nDqdkwx/NmiejjPo+jH+OcKf0kAEyPD2b9ONAb9
         iXCuysmr6nHWjweWZnGc3x8dyJV3PEKwB84Mc26qR2tQS3KDq1w9ucgiZF76gVDIzr7J
         vw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693991506; x=1694596306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FRe7ZqsNTAoDqqmat7zXdkTAVIWG/sthvOCRdId5kc=;
        b=GwgXnrpahvefYwPUjWyL7LeDhdn39+gpvmlXZjjX8Ws3Z7midz3yUMU509uMEtJ1uk
         HhIDOmGmp479GelPONiIPZUn4kZP5ZTw3MJNiLrdYxyn0RK107Mh4hsaDOETh2KexrLH
         figj5r5XDhZThHU/f2TOCu6Tm/PyGSZZR1OW7LOjSU5nlxC/C4v3fsPSxabL09InaAo5
         DUhnB5hG6xHsMx/Jf8sreX70eGSl7ffb8Q8xBEi7QhSnwQESXOijUx9HEvtAOjJiDbT4
         N75DNP0mar6e0Rz+QcL6K96XXpFojpguTxfe0zGrUOduFf24f4Tuowf3QctTB23PA5r2
         pTxw==
X-Gm-Message-State: AOJu0YyVshawx/dKvCWAl9XvFMbNtDLCNcL5gQlcgBBgEoiF7CxdAIVO
        8+/tS21H6eFj/iTrnVMooZsuHaN0oAeEjsn5Ue+/+Q==
X-Google-Smtp-Source: AGHT+IGw6jebFyIO+mXrth+2h9iuIdIaKkoeQAHvE/0M3w2G1mf/prtarQ+LsjUSRPDXzlepZqil9zLFkY1m4KYS/9o=
X-Received: by 2002:adf:f84d:0:b0:319:6ce2:e5a3 with SMTP id
 d13-20020adff84d000000b003196ce2e5a3mr1720147wrq.26.1693991505663; Wed, 06
 Sep 2023 02:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-10-mike.kravetz@oracle.com> <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
In-Reply-To: <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 6 Sep 2023 17:11:08 +0800
Message-ID: <CAMZfGtU2HX4UR1T2HW75xY70ZMSOdzNZ2py=EggoBYqP_1+QFg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 09/11] hugetlb: batch PMD split for bulk
 vmemmap dedup
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 4:25=E2=80=AFPM Muchun Song <muchun.song@linux.dev> =
wrote:
>
>
>
> On 2023/9/6 05:44, Mike Kravetz wrote:
> > From: Joao Martins <joao.m.martins@oracle.com>
> >
> > In an effort to minimize amount of TLB flushes, batch all PMD splits
> > belonging to a range of pages in order to perform only 1 (global) TLB
> > flush.
> >
> > Rebased and updated by Mike Kravetz
> >
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 72 +++++++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 68 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index a715712df831..d956551699bc 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
> >       struct list_head        *vmemmap_pages;
> >   };
> >
> > -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
> > +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, boo=
l flush)
> >   {
> >       pmd_t __pmd;
> >       int i;
> > @@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigne=
d long start)
> >               /* Make pte visible before pmd. See comment in pmd_instal=
l(). */
> >               smp_wmb();
> >               pmd_populate_kernel(&init_mm, pmd, pgtable);
> > -             flush_tlb_kernel_range(start, start + PMD_SIZE);
> > +             if (flush)
> > +                     flush_tlb_kernel_range(start, start + PMD_SIZE);
> >       } else {
> >               pte_free_kernel(&init_mm, pgtable);
> >       }
> > @@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned=
 long addr,
> >       do {
> >               int ret;
> >
> > -             ret =3D split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
> > +             ret =3D split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
> > +                             walk->remap_pte !=3D NULL);
>
> It is bettter to only make @walk->remap_pte indicate whether we should go
> to the last page table level. I suggest reusing VMEMMAP_NO_TLB_FLUSH
> to indicate whether we should flush the TLB at pmd level. It'll be more
> clear.
>
> >               if (ret)
> >                       return ret;
> >
> >               next =3D pmd_addr_end(addr, end);
> > +
> > +             /*
> > +              * We are only splitting, not remapping the hugetlb vmemm=
ap
> > +              * pages.
> > +              */
> > +             if (!walk->remap_pte)
> > +                     continue;
> > +
> >               vmemmap_pte_range(pmd, addr, next, walk);
> >       } while (pmd++, addr =3D next, addr !=3D end);
> >
> > @@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long start,=
 unsigned long end,
> >                       return ret;
> >       } while (pgd++, addr =3D next, addr !=3D end);
> >
> > -     flush_tlb_kernel_range(start, end);
> > +     if (walk->remap_pte)
> > +             flush_tlb_kernel_range(start, end);
> >
> >       return 0;
> >   }
> > @@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, unsign=
ed long addr,
> >       set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> >   }
> >
> > +/**
> > + * vmemmap_remap_split - split the vmemmap virtual address range [@sta=
rt, @end)
> > + *                      backing PMDs of the directmap into PTEs
> > + * @start:     start address of the vmemmap virtual address range that=
 we want
> > + *             to remap.
> > + * @end:       end address of the vmemmap virtual address range that w=
e want to
> > + *             remap.
> > + * @reuse:     reuse address.
> > + *
> > + * Return: %0 on success, negative error code otherwise.
> > + */
> > +static int vmemmap_remap_split(unsigned long start, unsigned long end,
> > +                             unsigned long reuse)
> > +{
> > +     int ret;
> > +     struct vmemmap_remap_walk walk =3D {
> > +             .remap_pte      =3D NULL,
> > +     };
> > +
> > +     /* See the comment in the vmemmap_remap_free(). */
> > +     BUG_ON(start - reuse !=3D PAGE_SIZE);
> > +
> > +     mmap_read_lock(&init_mm);
> > +     ret =3D vmemmap_remap_range(reuse, end, &walk);
> > +     mmap_read_unlock(&init_mm);
> > +
> > +     return ret;
> > +}
> > +
> >   /**
> >    * vmemmap_remap_free - remap the vmemmap virtual address range [@sta=
rt, @end)
> >    *                  to the page which @reuse is mapped to, then free =
vmemmap
> > @@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct hstate=
 *h, struct page *head)
> >       free_vmemmap_page_list(&vmemmap_pages);
> >   }
> >
> > +static void hugetlb_vmemmap_split(const struct hstate *h, struct page =
*head)
> > +{
> > +     unsigned long vmemmap_start =3D (unsigned long)head, vmemmap_end;
> > +     unsigned long vmemmap_reuse;
> > +
> > +     if (!vmemmap_should_optimize(h, head))
> > +             return;
> > +
> > +     vmemmap_end     =3D vmemmap_start + hugetlb_vmemmap_size(h);
> > +     vmemmap_reuse   =3D vmemmap_start;
> > +     vmemmap_start   +=3D HUGETLB_VMEMMAP_RESERVE_SIZE;
> > +
> > +     /*
> > +      * Split PMDs on the vmemmap virtual address range [@vmemmap_star=
t,
> > +      * @vmemmap_end]
> > +      */
> > +     vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
> > +}
> > +
> >   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_he=
ad *folio_list)
> >   {
> >       struct folio *folio;
> >       LIST_HEAD(vmemmap_pages);
> >
> > +     list_for_each_entry(folio, folio_list, lru)
> > +             hugetlb_vmemmap_split(h, &folio->page);
>
> Maybe it is reasonable to add a return value to hugetlb_vmemmap_split()
> to indicate whether it has done successfully, if it fails, it must be
> OOM, in which case, there is no sense to continue to split the page table
> and optimize the vmemmap pages subsequently, right?

Sorry, it is reasonable to continue to optimize the vmemmap pages
subsequently since it should succeed because those vmemmap pages
have been split successfully previously.

Seems we should continue to optimize vmemmap once hugetlb_vmemmap_split()
fails, then we will have more memory to continue to split. But it will
make hugetlb_vmemmap_optimize_folios() a little complex. I'd like to
hear you guys' opinions here.

Thanks.

>
> Thanks.
>
> > +
> > +     flush_tlb_all();
> > +
> >       list_for_each_entry(folio, folio_list, lru)
> >               __hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_page=
s);
> >
>
