Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45379D585
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjILQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjILQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:01:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F810EC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:01:07 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a9f87adfe1so4460342b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534467; x=1695139267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syxnbBGsoOeBXpse3OW+r1GVcvCXzUeqkMjuqo6yekM=;
        b=mB8i2Qs8IxSEGQvPRXCKR+zWJrOoS7Ls15FbxEgkuDHwwTuTuD0wIMJ6drTuFiuX3a
         5GALkZ0OClNynxGVHn3VsdFyNlqZ1OW84dhywVhYgsmbGoEQKqy7Srfu5oZtqryYy0hM
         +ZLUQCartbM+o4tCRzfY65KB6HACLTmRKvj35JZyab/uULb0puflKrnK4IPtI9I7pCK4
         DsMCqG4ib0DdlaRDgw2l5+1JHkiSQFqcLCk/vzxAOViEokg6yCxQwnl697e3h5oHn0vu
         X5yZU9qmpsPKTAbPQgmP2dktuqrwhnp1aQXYdSlteCCHuK5XGlvUcioPvG52sDbf2GcD
         qiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534467; x=1695139267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syxnbBGsoOeBXpse3OW+r1GVcvCXzUeqkMjuqo6yekM=;
        b=DhjGNtuGoRzoRme8PK66G8J6KVUD85fKHxpU9ifoGmse1c6MMqwRn0r7b6Dx7ETuyV
         e57AfmManMBbmJYBsjaqxZU8gUK11wKyeNCTYlSpHccewoCHy9ds4iwlwze9EfRsKXjj
         xyiVZVFqquHmfY+41ptrxFMegHBE/yNCuWBb0E0GgoKtAQwBe9ltOmK/1v2EIKW/Dcoi
         k+KeTifaFpFLWfrW85mtXsKod7A2ffjUTbXgdkOpNNVsWnGBv8nHyottJKzqaAhmYSQn
         keD1SKhzhzVsiXBm1EzF4Q9SToDG3WQfc4v/TJ4A5Aei9E5/+oNF7WtNQtldAGu+Uw8q
         hoPA==
X-Gm-Message-State: AOJu0YwEVFGzBd/GUpv/yT/KHDj82xrK0MAIVQoJdVIt0ZkOdHXXU5Dt
        28KQGYuxQhfnkdxh8yiLsAgGC43qfc2yrMY0Un2JDA==
X-Google-Smtp-Source: AGHT+IEPb29YqbZ7PWp/Jc6Ra95sT//dYJ4AYylnr28PZ+ojW0cReoL2plSjy1SSmqxxfinmFH6vxVBj5967PgbAJ6s=
X-Received: by 2002:a05:6808:b33:b0:3a7:2390:3583 with SMTP id
 t19-20020a0568080b3300b003a723903583mr131929oij.38.1694534466928; Tue, 12 Sep
 2023 09:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
In-Reply-To: <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Sep 2023 09:00:53 -0700
Message-ID: <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 8:03=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Sep 12, 2023 at 7:55=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Sep 12, 2023 at 06:30:46AM +0100, Matthew Wilcox wrote:
> > > On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    a47fc304d2b6 Add linux-next specific files for 2023=
0831
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16502dd=
ba80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ecd2a7=
4f20953b9
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db591856e0=
f0139f83023
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D120e7=
d70680000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1523f9c=
0680000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/b2e8f42175=
27/disk-a47fc304.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09339/=
vmlinux-a47fc304.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/bd9b2475=
bf5a/bzImage-a47fc304.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
> > >
> > > #syz test
> > >
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 42b5567e3773..90ad5fe60824 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start, unsig=
ned long len,
> > >       vma_iter_init(&vmi, mm, start);
> > >       prev =3D vma_prev(&vmi);
> > >       for_each_vma_range(vmi, vma, end) {
> > > +             vma_start_write(vma);
> > >               err =3D mbind_range(&vmi, vma, &prev, start, end, new);
> > >               if (err)
> > >                       break;
> >
> > Suren, can you take a look at this?  The VMA should be locked by the
> > call to queue_pages_range(), but by the time we get to here, the VMA
> > isn't locked.  I don't see anywhere that we cycle the mmap_lock (which
> > would unlock the VMA), but I could have missed something.  The two
> > VMA walks should walk over the same set of VMAs.  Certainly the VMA
> > being dumped should have been locked by the pagewalk:

Yeah, this looks strange. queue_pages_range() should have locked all
the vmas and the tree can't change since we are holding mmap_lock for
write. I'll try to reproduce later today and see what's going on.

>
> Sure, I'll look into this today. Somehow this report slipped by me
> unnoticed. Thanks!
>
> >
> >  vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000 mm ff=
ff8880258a8980
> >  prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
> >  pgoff 20c2a file 0000000000000000 private_data 0000000000000000
> >  flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|soft=
dirty)
> >
> >   syscall(__NR_mbind, /*addr=3D*/0x20400000ul, /*len=3D*/0xc00000ul, /*=
mode=3D*/4ul,
> >           /*nodemask=3D*/0ul, /*maxnode=3D*/0ul, /*flags=3D*/3ul);
> >
> > 20400000 + c00000 should overlap 20c2a000-21000000
