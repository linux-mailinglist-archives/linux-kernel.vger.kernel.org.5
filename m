Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCD79EF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjIMQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjIMQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242A430E1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:47:04 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d78328bc2abso29378276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694623623; x=1695228423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/fKO5Dxav/6Iiha3n/xM7kTti7BA+0tFs3aXe7sDXI=;
        b=ITzx1mcZlYnSDkx9YivLZ0HrgAZWtFvPnaFI2+iI94T7cIG6FgAultVTU6pQhLWp2H
         hB2UrGlLfby5TKrHSpOU8sXqfem1BJS0Ek7QzuY1bUTLvJFDCkNZU6aL9E519dlG67re
         hXAiVWtCDWfPRVu1oID2lWBEfSpK+XDNYD/1j0eRrFDMqARn+qKUiIsB3HADURO4JaFS
         j6OOK/cRF26uL7HCdHbHvHFCVceN4c820KQdjlo3frPwYF4w2acvrkC533Ej/msvEXgw
         JlYmSNaFeyM5ewsFqWTAiMslIJmxM1Z8j4KvdjNbzkClFIPvzEEzESXKbnZg2sh37uVb
         h9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623623; x=1695228423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/fKO5Dxav/6Iiha3n/xM7kTti7BA+0tFs3aXe7sDXI=;
        b=LJdpil53B8vjUcY3hNMOrUF0cnhSECBrdZccLnTrU1+8f1B6AUh6T4AH0016/2ZSfk
         7rwLNaoi8qyKMekFWoJ/y4k/ewL/0XFGBlw1BCLOnR86KBTZH1LKD7UW9aKa4UnKxNuD
         3Yj+M33pM4W2cOUPBnajzb3p1ZkuJGke7fFfZ5uIwuhMu3R5DtUogAjFFZZ23kPwqNyl
         Cd8xQiIQGYgDCUk0CG6Hr67qFfUF/xzRDUorjP1PtGDtAdWScGk87CeuFtkP+tXAIjqw
         WY04cu4rrQd32mplw3sfM+L4J9OHohuUIMegSgTUDlujBmkYgxy0bEhRwJmVRz11yLZu
         /zeQ==
X-Gm-Message-State: AOJu0Yz41pJ7hV7RT6ZfFvDBJNd+S1YZKsqht8aijuDOvhtdJRcFh3bc
        cl71Q/prM7V5PlQDTm+KnRgpulC2EOsxrRBIwdabHg==
X-Google-Smtp-Source: AGHT+IHmrJRZT+aRCAvNCloGokg7CwtZcm89bQx5f0T8EbdqoKmuIOQzjWRwgBnln2xOnZCjjy0MkP1bXVTsu4lZBaI=
X-Received: by 2002:a25:6852:0:b0:d7b:95ff:14f with SMTP id
 d79-20020a256852000000b00d7b95ff014fmr2813017ybc.61.1694623623073; Wed, 13
 Sep 2023 09:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com> <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
In-Reply-To: <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Sep 2023 16:46:50 +0000
Message-ID: <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Sep 12, 2023 at 4:00=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 8:03=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 7:55=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Tue, Sep 12, 2023 at 06:30:46AM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    a47fc304d2b6 Add linux-next specific files for =
20230831
> > > > > > git tree:       linux-next
> > > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D165=
02ddba80000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ec=
d2a74f20953b9
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db5918=
56e0f0139f83023
> > > > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binu=
tils for Debian) 2.40
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1=
20e7d70680000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D152=
3f9c0680000
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image: https://storage.googleapis.com/syzbot-assets/b2e8f4=
217527/disk-a47fc304.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09=
339/vmlinux-a47fc304.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/bd9b=
2475bf5a/bzImage-a47fc304.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.=
com
> > > > >
> > > > > #syz test
> > > > >
> > > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > > index 42b5567e3773..90ad5fe60824 100644
> > > > > --- a/mm/mempolicy.c
> > > > > +++ b/mm/mempolicy.c
> > > > > @@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start, u=
nsigned long len,
> > > > >       vma_iter_init(&vmi, mm, start);
> > > > >       prev =3D vma_prev(&vmi);
> > > > >       for_each_vma_range(vmi, vma, end) {
> > > > > +             vma_start_write(vma);
> > > > >               err =3D mbind_range(&vmi, vma, &prev, start, end, n=
ew);
> > > > >               if (err)
> > > > >                       break;
> > > >
> > > > Suren, can you take a look at this?  The VMA should be locked by th=
e
> > > > call to queue_pages_range(), but by the time we get to here, the VM=
A
> > > > isn't locked.  I don't see anywhere that we cycle the mmap_lock (wh=
ich
> > > > would unlock the VMA), but I could have missed something.  The two
> > > > VMA walks should walk over the same set of VMAs.  Certainly the VMA
> > > > being dumped should have been locked by the pagewalk:
> >
> > Yeah, this looks strange. queue_pages_range() should have locked all
> > the vmas and the tree can't change since we are holding mmap_lock for
> > write. I'll try to reproduce later today and see what's going on.
>
> So far I was unable to reproduce the issue. I tried with Linus' ToT
> using the attached config. linux-next ToT does not boot with this
> config but defconfig boots and fails to reproduce the issue. I'll try
> to figure out why current linux-next does not like this config.

Ok, I found a way to reproduce this using the config and kernel
baseline reported on 2023/09/06 06:24 at
https://syzkaller.appspot.com/bug?extid=3Db591856e0f0139f83023. I
suspect mmap_lock is being dropped by a racing thread, similar to this
issue we fixed before here:
https://lore.kernel.org/all/CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=3DuD+BK6-oYX=
=3DysQv5qQ@mail.gmail.com/
Anyway, I'm on it and will report once I figure out the issue.

>
> >
> > >
> > > Sure, I'll look into this today. Somehow this report slipped by me
> > > unnoticed. Thanks!
> > >
> > > >
> > > >  vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000 m=
m ffff8880258a8980
> > > >  prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
> > > >  pgoff 20c2a file 0000000000000000 private_data 0000000000000000
> > > >  flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|=
softdirty)
> > > >
> > > >   syscall(__NR_mbind, /*addr=3D*/0x20400000ul, /*len=3D*/0xc00000ul=
, /*mode=3D*/4ul,
> > > >           /*nodemask=3D*/0ul, /*maxnode=3D*/0ul, /*flags=3D*/3ul);
> > > >
> > > > 20400000 + c00000 should overlap 20c2a000-21000000
