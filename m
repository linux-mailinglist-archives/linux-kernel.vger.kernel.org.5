Return-Path: <linux-kernel+bounces-7846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016281AE28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155711F23BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D109463;
	Thu, 21 Dec 2023 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S79BkpdH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D560945A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso3990a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703134433; x=1703739233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uys1j6YEzRq4wq9YfSmj6G3Wty+wABOKW/AhAfFFgQk=;
        b=S79BkpdHOE5a09P6i+8fMKDHoLTHtXIdTlQWCdg68nJPwr4H7Gvn8cIMpVOndOp3B0
         EUwoxD/uoKBVJINZMlTetnmexciy2tFBAvjaLAXVxT3Va73xbVeJNf8fFunOVyFRtxzA
         1+QwpvIC8ZHKMAd77jPa1lrhhBwMnbswW2LIfBJu2YA2RFYqSG/70GTQRjj+ZVznlYqw
         aR8ZZyEpyaVmKOvoif2aCd4hZy0Y+NkkvYSzFO2/woSjJKflXqg7bg4uzdbtbrtG1GZM
         t6tE7gueGZRo1GEDKoqK/x3RaE0UyLHqS6C9W142/iQGQQsejw7kSTjX+mwUCn3+t+xS
         tPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703134433; x=1703739233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uys1j6YEzRq4wq9YfSmj6G3Wty+wABOKW/AhAfFFgQk=;
        b=YsOejKedy/PSfJytaIIrp7IGRaytAOAD9B8lZOPdctMgbiyMZYBdjirtPuJ/srLdAn
         zEw+iTUDYEP/2g2YKgf0gNrZYyrFTvsD+NwL87Rsf5GoLgKBI60OZkM90beEnfs/me8N
         g9WHYCouYD6StnekOOPL5Qa7QvyMNknrWHvuxbV1Ae//oW2NK46YKXPN5ldxEIPQTQpn
         joSIk2K/oaRksQv2qQXgjM/KJJ4hnGAGLI6FQ5nFqQJfOg8eVR80CQ9hytbj2P7W6WX0
         j7ntmaNL5J0oBQ6NM4jqYxGJplj7YBrDc1V0aF2S3IgV5V5DnvDVMAidyZM6kPmsbd+j
         DdfQ==
X-Gm-Message-State: AOJu0Yz7Rjv94AlWcrYg4ytJ4zQIgW0ZS1eYVo4xv4pL+OQ0npv+XrMK
	r5KHOV6kbQbN1fyl8JGXdi2uJK79y7NPXBXbuGVog8/nMzDRPTnq2XA6MObJ9Xmy
X-Google-Smtp-Source: AGHT+IHIMe06nh3kOPxV/Mn61oNP8wf4HjXiELznDUOlvm5Pf3goyvdWbUSubyhjsXrKMbkotEYZPEKxifZ/99QGcxA=
X-Received: by 2002:a50:c109:0:b0:551:9870:472 with SMTP id
 l9-20020a50c109000000b0055198700472mr11677edf.1.1703134433161; Wed, 20 Dec
 2023 20:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220054123.1266001-1-maskray@google.com> <CAHbLzkpZomZBHVkSpCiK-hZUoZi4x2N6MB=PtFj-cBHOVhYs7Q@mail.gmail.com>
In-Reply-To: <CAHbLzkpZomZBHVkSpCiK-hZUoZi4x2N6MB=PtFj-cBHOVhYs7Q@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 20 Dec 2023 20:53:38 -0800
Message-ID: <CAFP8O3+5fKcGS8xEY5=DHqsN0YdybEY178nM+cXRY1bbQXV4WQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove VM_EXEC requirement for THP eligibility
To: Yang Shi <shy828301@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Song Liu <songliubraving@fb.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	linux-kernel@vger.kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:42=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Tue, Dec 19, 2023 at 9:41=E2=80=AFPM Fangrui Song <maskray@google.com>=
 wrote:
> >
> > Commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> > checking in transparent_hugepage_enabled()") introduced the VM_EXEC
> > requirement, which is not strictly needed.
> >
> > lld's default --rosegment option and GNU ld's -z separate-code option
> > (default on Linux/x86 since binutils 2.31) create a read-only PT_LOAD
> > segment without the PF_X flag, which should be eligible for THP.
> >
> > Certain architectures support medium and large code models, where
> > .lrodata may be placed in a separate read-only PT_LOAD segment, which
> > should be eligible for THP as well.
>
> Yeah, it doesn't have to be VM_EXEC. The original implementation was
> restricted to VM_EXEC to minimize the blast radius and the targe use
> case is for large text segments. Out of curiosity, did you see any
> noticeable improvement with this change?

Hi Yang,

Thanks for the comment. Frankly, I am not familiar with huge pages...
I noticed this VM_EXEC condition when I was writing this
hugepage-related section in
https://maskray.me/blog/2023-12-17-exploring-the-section-layout-in-linker-o=
utput#transparent-huge-pages-for-mapped-files
(Thanks to Alexander Monakov's comment about
CONFIG_READ_ONLY_THP_FOR_FS in
https://mazzo.li/posts/check-huge-page.html).

As dTLB for read-only data is also an important optimization of
file-backed THP, it seems straightforward that we should drop the
VM_EXEC condition :)

On my Arch linux machine, the r--p page gets split if I invoke
madvise(__ehdr_start, HPAGE_SIZE, MADV_HUGEPAGE) I haven't figured out
why it behaves so in the presence of the VM_EXEC check.

% g++ test.cc -o ~/tmp/test -O2 -fuse-ld=3Dlld
-Wl,-z,max-page-size=3D2097152 && sudo ~/tmp/test
__ehdr_start: 0x55f3b1c00000
55f3b1c00000-55f3b1e00000 r--p 00000000 103:03 555277119
  /home/ray/tmp/test
55f3b1e00000-55f3b1e01000 r--p 00200000 103:03 555277119
  /home/ray/tmp/test
55f3b2000000-55f3b2002000 r-xp 00200000 103:03 555277119
  /home/ray/tmp/test
55f3b2201000-55f3b2202000 r--p 00201000 103:03 555277119
  /home/ray/tmp/test
55f3b2401000-55f3b2402000 rw-p 00201000 103:03 555277119
  /home/ray/tmp/test
55f3b3a9a000-55f3b3abb000 rw-p 00000000 00:00 0                          [h=
eap]


It'd be greatly appreciated if someone familiar with
CONFIG_READ_ONLY_THP_FOR_FS could provide some notes on how to use
this feature:)

> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > ---
> >  include/linux/huge_mm.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index fa0350b0812a..4c9e67e9000f 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -126,7 +126,6 @@ static inline bool file_thp_enabled(struct vm_area_=
struct *vma)
> >         inode =3D vma->vm_file->f_inode;
> >
> >         return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
> > -              (vma->vm_flags & VM_EXEC) &&
> >                !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode=
);
> >  }
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
> >



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

