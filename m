Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9E784009
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjHVLtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjHVLtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:49:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFEBE42
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:49:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d748d8cf074so3531335276.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692704956; x=1693309756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnkSOchAykgmuLN4U3TSGjFgL9Uj0OcvtXZ0L3nkmls=;
        b=M+QZ3IZYbaW9VT0juEBOMrByNp3PoahO2AFBKtWy6sIbhIBMN2vaUa4OILaoEQkj9Y
         hDjeJiOsof+5b0qbk3lp/3U8cQfwud2POus1oOsr7JT+l5Ojq/wn+o+hYEETLDChSTPA
         iUiv99hYyIV9PIHIiaxNaYHEGyNc1rrKyKrfjiCRAfkSSIgr4SsckS5QMJYLn0JKgTXK
         9MzQlDmUyll9TRxGXRt5m4OnYHXSloa4z5Sgq1/giVtIFlA/OGi6wYvTJosqyX2JWZC7
         l+97b5AM3ZLuUZy0Jl1T97s5bNIzFexQ0xENGQJ1k9xZu/CJR/k5bexzG+Mt1H3i50+k
         jNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704956; x=1693309756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnkSOchAykgmuLN4U3TSGjFgL9Uj0OcvtXZ0L3nkmls=;
        b=gsdI3B7AsgbGBXTNHD3gBUH7ag/tZ/WjUL1fgQxXaH2Ap2V4sw9R8811y4e4XDBw+1
         TlC5EE8BW4lIxIpP91hO8U9EuavUXgSkZHrBFQzHke4Dd2cfhzmIXKVczZwvOSzYsZZ8
         EqVkrhoH5caIDR75Konnmyh/3NKtFi0MblNmdq6YlqcwRjMjFS/prUymKLpIN1+JwkTG
         23A31oQMOOsVaQ/LE+bS+1uiY+E8/IagprDqOg61P13texJDCMa5JvRH/1k1maQXbsx8
         Y7n300A0MITvIo1kE+7ae3OcP3YNzRFSqEIRcviD8e9PmKsok1r1qYQg8+RxqpNFU2nv
         ypIA==
X-Gm-Message-State: AOJu0Yzrzr+4O2dNilUUq0EkY76Qh54qWiWuRPW5Z1LM1+7AWGH9v6uC
        bmjLcQvH80Gt775PIR4mOuYdnjCElcP8f9/su34=
X-Google-Smtp-Source: AGHT+IFvUkjp9Mr1ETGQ84flNE4HGHxASyHx07nqyD2nR6dxOh4T8VS7wCmrqwBMtgja+2xSt05UGV5IGU6bH0O644I=
X-Received: by 2002:a25:6842:0:b0:d45:af57:edfe with SMTP id
 d63-20020a256842000000b00d45af57edfemr8206076ybc.26.1692704955656; Tue, 22
 Aug 2023 04:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACZJ9cUXiWxDb6hF4JFhWe7Np82k6LopVQ+_AoGFOccN4kjJqA@mail.gmail.com>
 <20230814155911.GN2607694@kernel.org>
In-Reply-To: <20230814155911.GN2607694@kernel.org>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Tue, 22 Aug 2023 19:49:05 +0800
Message-ID: <CACZJ9cU5g5wD=qEg7tbr-Gk4EADDORSG-=U1_c7nq=fO9XhJ0Q@mail.gmail.com>
Subject: Re: [RESEND PATCH V3] NUMA:Improve the efficiency of calculating
 pages loss
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, zhoubinbin@loongson.cn,
        chenfeiyang@loongson.cn, jiaxun.yang@flygoat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        luto@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@xen0n.name, chenhuacai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 00:00, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Fri, Aug 04, 2023 at 11:32:51PM +0800, Liam Ni wrote:
> > Optimize the way of calculating missing pages.
> >
> > In the previous implementation, We calculate missing pages as follows:
> > 1. calculate numaram by traverse all the numa_meminfo's and for each of
> > them traverse all the regions in memblock.memory to prepare for
> > counting missing pages.
> >
> > 2. Traverse all the regions in memblock.memory again to get e820ram.
> >
> > 3. the missing page is (e820ram - numaram )
> >
> > But,it's enough to count memory in =E2=80=98memblock.memory=E2=80=99 th=
at doesn't have
> > the node assigned.
> >
> > V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmai=
l.com/
> > V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gma=
il.com/
> >
> > Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> > ---
> >  arch/loongarch/kernel/numa.c | 23 ++++++++---------------
> >  arch/x86/mm/numa.c           | 26 +++++++-------------------
> >  include/linux/mm.h           |  1 +
> >  mm/mm_init.c                 | 20 ++++++++++++++++++++
> >  4 files changed, 36 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.=
c
> > index 708665895b47..0239891e4d19 100644
> > --- a/arch/loongarch/kernel/numa.c
> > +++ b/arch/loongarch/kernel/numa.c
> > @@ -262,25 +262,18 @@ static void __init node_mem_init(unsigned int nod=
e)
> >   * Sanity check to catch more bad NUMA configurations (they are amazin=
gly
> >   * common).  Make sure the nodes cover all memory.
> >   */
> > -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo=
 *mi)
> > +static bool __init memblock_validate_numa_coverage(const u64 limit)
>
> There is no need to have arch specific memblock_validate_numa_coverage().
> You can add this function to memblock and call it from NUMA initializatio=
n
> instead of numa_meminfo_cover_memory().

Remove implementation of numa_meminfo_cover_memory function?

>
> The memblock_validate_numa_coverage() will count all the pages without no=
de
> ID set and compare to the threshold provided by the architectures.
>
> >  {
> > -       int i;
> > -       u64 numaram, biosram;
> > +       u64 lo_pg;
> >
> > -       numaram =3D 0;
> > -       for (i =3D 0; i < mi->nr_blks; i++) {
> > -               u64 s =3D mi->blk[i].start >> PAGE_SHIFT;
> > -               u64 e =3D mi->blk[i].end >> PAGE_SHIFT;
> > +       lo_pg =3D max_pfn - calculate_without_node_pages_in_range();
> >
> > -               numaram +=3D e - s;
> > -               numaram -=3D __absent_pages_in_range(mi->blk[i].nid, s,=
 e);
> > -               if ((s64)numaram < 0)
> > -                       numaram =3D 0;
> > +       /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> > +       if (lo_pg >=3D limit) {
> > +               pr_err("NUMA: We lost 1m size page.\n");
> > +               return false;
> >         }
> > -       max_pfn =3D max_low_pfn;
> > -       biosram =3D max_pfn - absent_pages_in_range(0, max_pfn);
> >
> > -       BUG_ON((s64)(biosram - numaram) >=3D (1 << (20 - PAGE_SHIFT)));
> >         return true;
> >  }
> >
> > @@ -428,7 +421,7 @@ int __init init_numa_memory(void)
> >                 return -EINVAL;
> >
> >         init_node_memblock();
> > -       if (numa_meminfo_cover_memory(&numa_meminfo) =3D=3D false)
> > +       if (memblock_validate_numa_coverage(SZ_1M) =3D=3D false)
> >                 return -EINVAL;
> >
> >         for_each_node_mask(node, node_possible_map) {
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..14feec144675 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -451,30 +451,18 @@ EXPORT_SYMBOL(__node_distance);
> >   * Sanity check to catch more bad NUMA configurations (they are amazin=
gly
> >   * common).  Make sure the nodes cover all memory.
> >   */
> > -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo=
 *mi)
> > +static bool __init memblock_validate_numa_coverage(const u64 limit)
> >  {
> > -       u64 numaram, e820ram;
> > -       int i;
> > +       u64 lo_pg;
> >
> > -       numaram =3D 0;
> > -       for (i =3D 0; i < mi->nr_blks; i++) {
> > -               u64 s =3D mi->blk[i].start >> PAGE_SHIFT;
> > -               u64 e =3D mi->blk[i].end >> PAGE_SHIFT;
> > -               numaram +=3D e - s;
> > -               numaram -=3D __absent_pages_in_range(mi->blk[i].nid, s,=
 e);
> > -               if ((s64)numaram < 0)
> > -                       numaram =3D 0;
> > -       }
> > -
> > -       e820ram =3D max_pfn - absent_pages_in_range(0, max_pfn);
> > +       lo_pg =3D max_pfn - calculate_without_node_pages_in_range();
> >
> >         /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> > -       if ((s64)(e820ram - numaram) >=3D (1 << (20 - PAGE_SHIFT))) {
> > -               printk(KERN_ERR "NUMA: nodes only cover %LuMB of your
> > %LuMB e820 RAM. Not used.\n",
> > -                      (numaram << PAGE_SHIFT) >> 20,
> > -                      (e820ram << PAGE_SHIFT) >> 20);
> > +       if (lo_pg >=3D limit) {
> > +               pr_err("NUMA: We lost 1m size page.\n");
> >                 return false;
> >         }
> > +
> >         return true;
> >  }
> >
> > @@ -583,7 +571,7 @@ static int __init numa_register_memblks(struct
> > numa_meminfo *mi)
> >                         return -EINVAL;
> >                 }
> >         }
> > -       if (!numa_meminfo_cover_memory(mi))
> > +       if (!memblock_validate_numa_coverage(SZ_1M))
> >                 return -EINVAL;
> >
> >         /* Finally register nodes. */
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0daef3f2f029..b32457ad1ae3 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3043,6 +3043,7 @@ unsigned long __absent_pages_in_range(int nid,
> > unsigned long start_pfn,
> >                                                 unsigned long end_pfn);
> >  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
> >                                                 unsigned long end_pfn);
> > +extern unsigned long calculate_without_node_pages_in_range(void);
> >  extern void get_pfn_range_for_nid(unsigned int nid,
> >                         unsigned long *start_pfn, unsigned long *end_pf=
n);
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 3ddd18a89b66..13a4883787e3 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1132,6 +1132,26 @@ static void __init
> > adjust_zone_range_for_zone_movable(int nid,
> >         }
> >  }
> >
> > +/**
> > + * @start_pfn: The start PFN to start searching for holes
> > + * @end_pfn: The end PFN to stop searching for holes
> > + *
> > + * Return: Return the number of page frames without node assigned
> > within a range.
> > + */
> > +unsigned long __init calculate_without_node_pages_in_range(void)
> > +{
> > +       unsigned long num_pages;
> > +       unsigned long start_pfn, end_pfn;
> > +       int nid, i;
> > +
> > +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &=
nid) {
> > +               if (nid =3D=3D NUMA_NO_NODE)
> > +                       num_pages +=3D end_pfn - start_pfn;
> > +       }
> > +
> > +       return num_pages;
> > +}
> > +
> >  /*
> >   * Return the number of holes in a range on a node. If nid is MAX_NUMN=
ODES,
> >   * then all holes in the requested range will be accounted for.
> > --
> > 2.25.1
>
> --
> Sincerely yours,
> Mike.
