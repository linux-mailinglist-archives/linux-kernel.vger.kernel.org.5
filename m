Return-Path: <linux-kernel+bounces-9009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568681BF39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C731C244BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0D745DA;
	Thu, 21 Dec 2023 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQz/dE9r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479C651AC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdc159034eso683479a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703187963; x=1703792763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FKILjwnffsZ2mmqJQPrrhUAU5h2ZycGnJTVyIPfkMY=;
        b=VQz/dE9rQBPGeIala2+eV7nF1AbXs+7Huk3A60MjVkC3dJcZo3pm8hM7sSxcz4Ws1a
         9akwDYlu2sUFu/044HfDVunhySH8XIdHypn54X5rLj991JYAPwhpODnhb2ACJWKkN9nd
         cz11atOW2OVwsecXwtDfXJ8iaph33YdHnl4yUKm3osWU/Xk2ADyC7N97CIkdAFwHHFlP
         j4qSpzz0FfBqyrbxExXSHQO5bWdA6mcFANR3osmSC+RFbkjNZJCNyS5jN4ppDPheAhta
         zD9DNC4Bu661AIWzlMFNQn9lqM8lWvSxL+AKb/GMH/V02DYLKCgMZyFRVziSPrOK2ojL
         T5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187963; x=1703792763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FKILjwnffsZ2mmqJQPrrhUAU5h2ZycGnJTVyIPfkMY=;
        b=I3TJIm/XnM5Ywjqa3VT7VW0mhl89djJT8JOfcaLTPYgsnBHdc8Ko99AcmXJdwR2goP
         f05bbNFU8Z/O176oZbeGqXga6VzK7pG5xTPStujp7cJbliWP5KimY5Rad7vI2WfwkJO9
         Ss4kY9UQRbflV7dkgpFsUrmCDn7xI7lMBExju6QEv0gRuOwMjb0ULv6eOumGl/VjKWZx
         APBkFuGaW29Wlp4UDny+U1AT1paD8R9ylp+wtPVna61gZxVE2Gze7ujmnzyZ3sNJwZMq
         spaGqsXcuPD2pHhITOxNfOap96BvopmWekRVbqnbtgOmTciLQw5dCaEUEVZV/qzN/L6U
         Qw3Q==
X-Gm-Message-State: AOJu0YzwU/C8W7f8XH7ecyHUQrdpv5BndkGvEDCzcsvvrFrU5uEyIhiP
	v5M9XGrzRTWWlk8ClN6h+Gx/5CnW+HX9wGI9DVY=
X-Google-Smtp-Source: AGHT+IHAj/A6aU4UWkIU8f4/Octn90lN03mujVgsSVLECUZw8Qs8yxIQskBPpmpPBW7sqhMDhoELhTs/OpbBxHxDDpI=
X-Received: by 2002:a17:90a:7504:b0:28b:b6fa:82ec with SMTP id
 q4-20020a17090a750400b0028bb6fa82ecmr260414pjk.52.1703187963396; Thu, 21 Dec
 2023 11:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220054123.1266001-1-maskray@google.com> <CAHbLzkpZomZBHVkSpCiK-hZUoZi4x2N6MB=PtFj-cBHOVhYs7Q@mail.gmail.com>
 <CAFP8O3+5fKcGS8xEY5=DHqsN0YdybEY178nM+cXRY1bbQXV4WQ@mail.gmail.com> <CAHbLzkpTKcceY19EASdDu=yhm+mFCzEAfhwX338hCxPAjpOPtw@mail.gmail.com>
In-Reply-To: <CAHbLzkpTKcceY19EASdDu=yhm+mFCzEAfhwX338hCxPAjpOPtw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 21 Dec 2023 11:45:51 -0800
Message-ID: <CAHbLzkpLBb_0vO1ZPgZBbNvbvCTBRTjNRqmxBf1cyD_eGjnGbA@mail.gmail.com>
Subject: Re: [PATCH] mm: remove VM_EXEC requirement for THP eligibility
To: Fangrui Song <maskray@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Song Liu <songliubraving@fb.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	linux-kernel@vger.kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:31=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Wed, Dec 20, 2023 at 8:53=E2=80=AFPM Fangrui Song <maskray@google.com>=
 wrote:
> >
> > On Wed, Dec 20, 2023 at 3:42=E2=80=AFPM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Tue, Dec 19, 2023 at 9:41=E2=80=AFPM Fangrui Song <maskray@google.=
com> wrote:
> > > >
> > > > Commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> > > > checking in transparent_hugepage_enabled()") introduced the VM_EXEC
> > > > requirement, which is not strictly needed.
> > > >
> > > > lld's default --rosegment option and GNU ld's -z separate-code opti=
on
> > > > (default on Linux/x86 since binutils 2.31) create a read-only PT_LO=
AD
> > > > segment without the PF_X flag, which should be eligible for THP.
> > > >
> > > > Certain architectures support medium and large code models, where
> > > > .lrodata may be placed in a separate read-only PT_LOAD segment, whi=
ch
> > > > should be eligible for THP as well.
> > >
> > > Yeah, it doesn't have to be VM_EXEC. The original implementation was
> > > restricted to VM_EXEC to minimize the blast radius and the targe use
> > > case is for large text segments. Out of curiosity, did you see any
> > > noticeable improvement with this change?
> >
> > Hi Yang,
> >
> > Thanks for the comment. Frankly, I am not familiar with huge pages...
> > I noticed this VM_EXEC condition when I was writing this
> > hugepage-related section in
> > https://maskray.me/blog/2023-12-17-exploring-the-section-layout-in-link=
er-output#transparent-huge-pages-for-mapped-files
> > (Thanks to Alexander Monakov's comment about
> > CONFIG_READ_ONLY_THP_FOR_FS in
> > https://mazzo.li/posts/check-huge-page.html).
>
> Thanks for sharing the article, learnt something about linker and loader.

BTW, kernel should try to map the segments (the size has to be >=3D 2M)
to 2M aligned address even though the loading address is not 2M
aligned for ext4/xfs/btrfs since v5.18. See commit 1854bc6e2420
("mm/readahead: Align file mappings for non-DAX"). Did you see this
behavior?

>
> >
> > As dTLB for read-only data is also an important optimization of
> > file-backed THP, it seems straightforward that we should drop the
> > VM_EXEC condition :)
>
> Yeah, as long as the use case is valid, it is definitely fine to lift
> the restriction.
>
> >
> > On my Arch linux machine, the r--p page gets split if I invoke
> > madvise(__ehdr_start, HPAGE_SIZE, MADV_HUGEPAGE) I haven't figured out
> > why it behaves so in the presence of the VM_EXEC check.
>
> What do you mean about "split"? THP got split into small pages? It
> depends on the address of __ehdr_start. If it is in the middle of a
> VMA, the VMA is going to be split due to the different huge page
> attributes.
>
> >
> > % g++ test.cc -o ~/tmp/test -O2 -fuse-ld=3Dlld
> > -Wl,-z,max-page-size=3D2097152 && sudo ~/tmp/test
> > __ehdr_start: 0x55f3b1c00000
> > 55f3b1c00000-55f3b1e00000 r--p 00000000 103:03 555277119
> >   /home/ray/tmp/test
> > 55f3b1e00000-55f3b1e01000 r--p 00200000 103:03 555277119
> >   /home/ray/tmp/test
> > 55f3b2000000-55f3b2002000 r-xp 00200000 103:03 555277119
> >   /home/ray/tmp/test
> > 55f3b2201000-55f3b2202000 r--p 00201000 103:03 555277119
> >   /home/ray/tmp/test
> > 55f3b2401000-55f3b2402000 rw-p 00201000 103:03 555277119
> >   /home/ray/tmp/test
> > 55f3b3a9a000-55f3b3abb000 rw-p 00000000 00:00 0                        =
  [heap]
> >
> >
> > It'd be greatly appreciated if someone familiar with
> > CONFIG_READ_ONLY_THP_FOR_FS could provide some notes on how to use
> > this feature:)
>
> I think your blog covered all the points. If you don't mind, you could
> add some notes in Documentation/admin-guide/mm/transhuge.rst.
>
> >
> > > >
> > > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > > ---
> > > >  include/linux/huge_mm.h | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > index fa0350b0812a..4c9e67e9000f 100644
> > > > --- a/include/linux/huge_mm.h
> > > > +++ b/include/linux/huge_mm.h
> > > > @@ -126,7 +126,6 @@ static inline bool file_thp_enabled(struct vm_a=
rea_struct *vma)
> > > >         inode =3D vma->vm_file->f_inode;
> > > >
> > > >         return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
> > > > -              (vma->vm_flags & VM_EXEC) &&
> > > >                !inode_is_open_for_write(inode) && S_ISREG(inode->i_=
mode);
> > > >  }
> > > >
> > > > --
> > > > 2.43.0.472.g3155946c3a-goog
> > > >
> >
> >
> >
> > --
> > =E5=AE=8B=E6=96=B9=E7=9D=BF

