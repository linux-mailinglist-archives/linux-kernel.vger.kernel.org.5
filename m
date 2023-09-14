Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46FB7A0CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjINSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjINSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:21:14 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2E1FD7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:21:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6befdb1f545so793198a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694715669; x=1695320469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r14viLFdjZlr5qs/ZwW+ippwaGuAbVYT3KOmYlUCcNo=;
        b=1xQpo/A3jQo75R+YewJ25HSdp8qW0g35s8oDj+YWfrUcPt5wpoOM5IObFNEJnEUCQ8
         wvLsp2zSlpLcK/LyzqnpSmIA5EL46OV6OoMzcbrN+gf6HzFSyD+9NMx0Qoe3wgAKyHmD
         PzNeqZk8jjKlkORAjBXR3Ayq9ROthsvjRZEdcvscKcVpQL30Heb3Hw+/sduBmQwbgxkl
         AzHLHljZxKJv6YM428++vHEgldi/8nhMuWV2gnU6SfvCYr/GK0bxKlzS6/tXr6267cee
         cC7jD7T8VG5CJV3ArwZhYgMFz35z6G5KoUI7dm3WmJOC60FSBu649Zx0o/W6sRxIxp1o
         qcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715669; x=1695320469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r14viLFdjZlr5qs/ZwW+ippwaGuAbVYT3KOmYlUCcNo=;
        b=MVE9K4jp/vjOQ2XE+oCrNf77PC9XGRgAKc0z+aM6kOKa13qvIxuNeVC6PZ4XnQMZ1H
         ledi8/dCXGJY6FqopaqvISwUkLgAFz0hFaPmQCjd4YTvNtv7CjcGZF0Rgo74eG+2Sp/i
         1nG7m9T89VRPFOqcG+aHTOZEOeUYGYMdZ9zKHyocQkHIvkxGpn2yWqcKx9JzTSGEhtrv
         LvQE4/iwKFjjGE4zXeqbMeA8lBn/QijNZnsc0ANgNei6c5Rg6I0GL0pyYA8pPxE2lpf0
         qp89Bf5Ytle2g0+3bUcp2hv9ZFzMotx8P5i/VFqsyMaJUDOt0OPFa4+1ELJsLjNiBU6g
         Qs7A==
X-Gm-Message-State: AOJu0Yw5GEdaCZk0BrN/W5y31Xag5b+KIOwc4CeoKM8kbcI4efdCnbOU
        oDMbvRY7Mi2c0MNfMxPDa29mYnKPaDfi8RObj6zHkCA+HJCwjmNYRL8LKQ==
X-Google-Smtp-Source: AGHT+IFqR2FxLVaE4WCj9ke8MpZJew4TgvR+yFLFOCL/SSpFtMiCbSV346KAy8ngKjHeyUIg1vbMVOD9Nf72nqiJgHo=
X-Received: by 2002:a9d:4d84:0:b0:6bf:1fed:95ce with SMTP id
 u4-20020a9d4d84000000b006bf1fed95cemr6895607otk.22.1694715669318; Thu, 14 Sep
 2023 11:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com> <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
In-Reply-To: <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 18:20:56 +0000
Message-ID: <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 4:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Sep 13, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 4:00=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 8:03=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Sep 12, 2023 at 7:55=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Tue, Sep 12, 2023 at 06:30:46AM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    a47fc304d2b6 Add linux-next specific files fo=
r 20230831
> > > > > > > git tree:       linux-next
> > > > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1=
6502ddba80000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6=
ecd2a74f20953b9
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db59=
1856e0f0139f83023
> > > > > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Bi=
nutils for Debian) 2.40
> > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=
=3D120e7d70680000
> > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1=
523f9c0680000
> > > > > > >
> > > > > > > Downloadable assets:
> > > > > > > disk image: https://storage.googleapis.com/syzbot-assets/b2e8=
f4217527/disk-a47fc304.raw.xz
> > > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc=
09339/vmlinux-a47fc304.xz
> > > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/bd=
9b2475bf5a/bzImage-a47fc304.xz
> > > > > > >
> > > > > > > IMPORTANT: if you fix the issue, please add the following tag=
 to the commit:
> > > > > > > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmai=
l.com
> > > > > >
> > > > > > #syz test
> > > > > >
> > > > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > > > index 42b5567e3773..90ad5fe60824 100644
> > > > > > --- a/mm/mempolicy.c
> > > > > > +++ b/mm/mempolicy.c
> > > > > > @@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start,=
 unsigned long len,
> > > > > >       vma_iter_init(&vmi, mm, start);
> > > > > >       prev =3D vma_prev(&vmi);
> > > > > >       for_each_vma_range(vmi, vma, end) {
> > > > > > +             vma_start_write(vma);
> > > > > >               err =3D mbind_range(&vmi, vma, &prev, start, end,=
 new);
> > > > > >               if (err)
> > > > > >                       break;
> > > > >
> > > > > Suren, can you take a look at this?  The VMA should be locked by =
the
> > > > > call to queue_pages_range(), but by the time we get to here, the =
VMA
> > > > > isn't locked.  I don't see anywhere that we cycle the mmap_lock (=
which
> > > > > would unlock the VMA), but I could have missed something.  The tw=
o
> > > > > VMA walks should walk over the same set of VMAs.  Certainly the V=
MA
> > > > > being dumped should have been locked by the pagewalk:
> > >
> > > Yeah, this looks strange. queue_pages_range() should have locked all
> > > the vmas and the tree can't change since we are holding mmap_lock for
> > > write. I'll try to reproduce later today and see what's going on.
> >
> > So far I was unable to reproduce the issue. I tried with Linus' ToT
> > using the attached config. linux-next ToT does not boot with this
> > config but defconfig boots and fails to reproduce the issue. I'll try
> > to figure out why current linux-next does not like this config.
>
> Ok, I found a way to reproduce this using the config and kernel
> baseline reported on 2023/09/06 06:24 at
> https://syzkaller.appspot.com/bug?extid=3Db591856e0f0139f83023. I
> suspect mmap_lock is being dropped by a racing thread, similar to this
> issue we fixed before here:
> https://lore.kernel.org/all/CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=3DuD+BK6-oYX=
=3DysQv5qQ@mail.gmail.com/
> Anyway, I'm on it and will report once I figure out the issue.

I think I found the problem and the explanation is much simpler. While
walking the page range, queue_folios_pte_range() encounters an
unmovable page and queue_folios_pte_range() returns 1. That causes a
break from the loop inside walk_page_range() and no more VMAs get
locked. After that the loop calling mbind_range() walks over all VMAs,
even the ones which were skipped by queue_folios_pte_range() and that
causes this BUG assertion.

Thinking what's the right way to handle this situation (what's the
expected behavior here)...
I think the safest way would be to modify walk_page_range() and make
it continue calling process_vma_walk_lock() for all VMAs in the range
even when __walk_page_range() returns a positive err. Any objection or
alternative suggestions?


>
> >
> > >
> > > >
> > > > Sure, I'll look into this today. Somehow this report slipped by me
> > > > unnoticed. Thanks!
> > > >
> > > > >
> > > > >  vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000=
 mm ffff8880258a8980
> > > > >  prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
> > > > >  pgoff 20c2a file 0000000000000000 private_data 0000000000000000
> > > > >  flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|accoun=
t|softdirty)
> > > > >
> > > > >   syscall(__NR_mbind, /*addr=3D*/0x20400000ul, /*len=3D*/0xc00000=
ul, /*mode=3D*/4ul,
> > > > >           /*nodemask=3D*/0ul, /*maxnode=3D*/0ul, /*flags=3D*/3ul)=
;
> > > > >
> > > > > 20400000 + c00000 should overlap 20c2a000-21000000
