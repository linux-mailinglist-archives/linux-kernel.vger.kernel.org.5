Return-Path: <linux-kernel+bounces-9003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B78481BF28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F06283AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE0651B5;
	Thu, 21 Dec 2023 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2djKotT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72C651AC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d7609cb6d2so766912b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703187108; x=1703791908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJYWaKMWlPWX97f2qeaiw6ZVBBad2oJe+BJ9C0VEsB0=;
        b=G2djKotTB+tNFUnloXzi9JCUGSyihmeLACraDPzcthcTc/5jUm6md0N6fQzzT+8Fqs
         Mn5EJtC3t9VUarBJEd2dcEzzUpg/jAVEgbUfR9S81EsjtKaAwsMXEZ8lQ4IhJ0yXCHNv
         sdCp7fF6T0ylnlb79G+aMSWVM/P1TO7FBA+ntV90WrUe+/PYQ6IIjqFx1uCVtAT2dIl6
         H8Zu3YrClL0Chp3gh6XTD3eRatUOjwq/lFDu5P9vklWilX8zKVIr2r0mzDpW0o5r7YhU
         2rCYbpopzpIdTlQanofKeciKnDUvHvKsvnOraOgii7hvra0oG1V6umNEJscoPJBnlT42
         kxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187108; x=1703791908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJYWaKMWlPWX97f2qeaiw6ZVBBad2oJe+BJ9C0VEsB0=;
        b=lrrmiNU/Pa+nW35EHHe4HXOnbtsKTeY4eOyyxWTXDN/kualRAUhXNegVuKMjfMPv2c
         NA+bg+cjxYzoMhrBRs5Tv39BoUGSDGyLAxiBm2mXuat54TQl9rgzYd63+uo6JmKEyflw
         VdYBa7hOG2hsaAFAVfouuALXheAvpXkUlfIcWjLVX0yd/O7/LrmIDgK+Uvjsanz0olLb
         QdidLimMEDzrigu49FIcRVqwZyabIgeYgnMoNMlHdo7lr1VwIzjf75SA+bEtTP42CkDr
         NxmixmhQ4axO/xoB8dwJWgCKMKtYjDXOXWr9ZPvecGFAJCvxoewVXI+EmG+sZVvy85Ni
         FL0g==
X-Gm-Message-State: AOJu0YxL6gAMIlyRz6kOl5cHBOIZaPDgH84M+Z5sDuuba1U8rjAPNzvK
	wsXuRqCvfv2jYanOzkH8YqTuYwT21gblIngAQG7+BmsmjFM=
X-Google-Smtp-Source: AGHT+IF1nSEyK+v7jFyDMyGt7xnp/BX7BfxF1dJtoL9nqSxt83vxJI4pZry6n5b36QuxaxBn1qEBSZokGGtz5KKOltw=
X-Received: by 2002:a05:6a20:4ca2:b0:194:dafc:d7ca with SMTP id
 fq34-20020a056a204ca200b00194dafcd7camr161710pzb.41.1703187107667; Thu, 21
 Dec 2023 11:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220054123.1266001-1-maskray@google.com> <CAHbLzkpZomZBHVkSpCiK-hZUoZi4x2N6MB=PtFj-cBHOVhYs7Q@mail.gmail.com>
 <CAFP8O3+5fKcGS8xEY5=DHqsN0YdybEY178nM+cXRY1bbQXV4WQ@mail.gmail.com>
In-Reply-To: <CAFP8O3+5fKcGS8xEY5=DHqsN0YdybEY178nM+cXRY1bbQXV4WQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 21 Dec 2023 11:31:35 -0800
Message-ID: <CAHbLzkpTKcceY19EASdDu=yhm+mFCzEAfhwX338hCxPAjpOPtw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove VM_EXEC requirement for THP eligibility
To: Fangrui Song <maskray@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Song Liu <songliubraving@fb.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	linux-kernel@vger.kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 8:53=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> On Wed, Dec 20, 2023 at 3:42=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Tue, Dec 19, 2023 at 9:41=E2=80=AFPM Fangrui Song <maskray@google.co=
m> wrote:
> > >
> > > Commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> > > checking in transparent_hugepage_enabled()") introduced the VM_EXEC
> > > requirement, which is not strictly needed.
> > >
> > > lld's default --rosegment option and GNU ld's -z separate-code option
> > > (default on Linux/x86 since binutils 2.31) create a read-only PT_LOAD
> > > segment without the PF_X flag, which should be eligible for THP.
> > >
> > > Certain architectures support medium and large code models, where
> > > .lrodata may be placed in a separate read-only PT_LOAD segment, which
> > > should be eligible for THP as well.
> >
> > Yeah, it doesn't have to be VM_EXEC. The original implementation was
> > restricted to VM_EXEC to minimize the blast radius and the targe use
> > case is for large text segments. Out of curiosity, did you see any
> > noticeable improvement with this change?
>
> Hi Yang,
>
> Thanks for the comment. Frankly, I am not familiar with huge pages...
> I noticed this VM_EXEC condition when I was writing this
> hugepage-related section in
> https://maskray.me/blog/2023-12-17-exploring-the-section-layout-in-linker=
-output#transparent-huge-pages-for-mapped-files
> (Thanks to Alexander Monakov's comment about
> CONFIG_READ_ONLY_THP_FOR_FS in
> https://mazzo.li/posts/check-huge-page.html).

Thanks for sharing the article, learnt something about linker and loader.

>
> As dTLB for read-only data is also an important optimization of
> file-backed THP, it seems straightforward that we should drop the
> VM_EXEC condition :)

Yeah, as long as the use case is valid, it is definitely fine to lift
the restriction.

>
> On my Arch linux machine, the r--p page gets split if I invoke
> madvise(__ehdr_start, HPAGE_SIZE, MADV_HUGEPAGE) I haven't figured out
> why it behaves so in the presence of the VM_EXEC check.

What do you mean about "split"? THP got split into small pages? It
depends on the address of __ehdr_start. If it is in the middle of a
VMA, the VMA is going to be split due to the different huge page
attributes.

>
> % g++ test.cc -o ~/tmp/test -O2 -fuse-ld=3Dlld
> -Wl,-z,max-page-size=3D2097152 && sudo ~/tmp/test
> __ehdr_start: 0x55f3b1c00000
> 55f3b1c00000-55f3b1e00000 r--p 00000000 103:03 555277119
>   /home/ray/tmp/test
> 55f3b1e00000-55f3b1e01000 r--p 00200000 103:03 555277119
>   /home/ray/tmp/test
> 55f3b2000000-55f3b2002000 r-xp 00200000 103:03 555277119
>   /home/ray/tmp/test
> 55f3b2201000-55f3b2202000 r--p 00201000 103:03 555277119
>   /home/ray/tmp/test
> 55f3b2401000-55f3b2402000 rw-p 00201000 103:03 555277119
>   /home/ray/tmp/test
> 55f3b3a9a000-55f3b3abb000 rw-p 00000000 00:00 0                          =
[heap]
>
>
> It'd be greatly appreciated if someone familiar with
> CONFIG_READ_ONLY_THP_FOR_FS could provide some notes on how to use
> this feature:)

I think your blog covered all the points. If you don't mind, you could
add some notes in Documentation/admin-guide/mm/transhuge.rst.

>
> > >
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > ---
> > >  include/linux/huge_mm.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index fa0350b0812a..4c9e67e9000f 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -126,7 +126,6 @@ static inline bool file_thp_enabled(struct vm_are=
a_struct *vma)
> > >         inode =3D vma->vm_file->f_inode;
> > >
> > >         return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
> > > -              (vma->vm_flags & VM_EXEC) &&
> > >                !inode_is_open_for_write(inode) && S_ISREG(inode->i_mo=
de);
> > >  }
> > >
> > > --
> > > 2.43.0.472.g3155946c3a-goog
> > >
>
>
>
> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF

