Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67279EDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIMQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjIMQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:05:35 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA790
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:05:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59be6605e1dso927537b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694621130; x=1695225930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0FEOtK8upVX9062rGQwvkLr47mtWsuxzkFYa37bMGk=;
        b=SK1mY16SIODJk0khKdty1B0KtaswAN3aXHbAtZrDCLyI7PQGJWRpNotQbR5623OzpR
         y9JN9vMsZTSdar7ss8rzdZj65ZtfNFKJmvgXLZDv/gYTHpBAfeJPLcidROVqPFAyrwHf
         KQFq2+6YMCDnjAydIvwrL4W9sXK3iOxq9DFSfp4BdwkrmJseL6tO6LVRCGYCz6Vud0i3
         bdoeYsv/dwec89OqI7r3UJSLUSFFqc363SpO/kp9yKXH8GZEou+9Csxjzdg3vjbmFood
         f1+dWglISE4FpiKaSy3L4THk/zyb5KVPMW5lKDKRwrfdR3rjp3Vgndzsk+I5xECALXZi
         bI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621130; x=1695225930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0FEOtK8upVX9062rGQwvkLr47mtWsuxzkFYa37bMGk=;
        b=kVC4z642tgd27HX/CehD1mgLHYu2yKOQSPxffJ8BtHEgFllvADhg8sF+QO4jtnj4P4
         X6+dRWW+okX7zWSzZv6RCYXagD5Nkyk3liXO87kn4fYBe+qUP+w9vLPeaMb3zzUCFHRG
         VOBHxCrqmun8iLNtMpfi2AZk63v3gnC4PTx2sHmtZYPf9+xs0N3qqWjnnFUz2kmQBJux
         zGoR53/5mKD/XSF/htLn1L0pth1PBb7mhYnAah/94yGZ54dj+sQxVuQsn7uPlHAin0tg
         GIRN3NDy7UxPvAwC4MAjCjB1YYvLKEX4uBl6e2YsUO+pDLClS6Qf30P0v8AfNXCdW4iS
         t4JQ==
X-Gm-Message-State: AOJu0Yw5e/Lwasl5YhMo/k2UFpsjeoeyRUgquojYuFlHEziIKRqDWy2A
        eaLwDCiqOPkHncwO1xIusA1v2SojMmMV+IQidlw65bSQrhsnkPJMGDE=
X-Google-Smtp-Source: AGHT+IGo1ehGwiEn6OUWA2bjwwy7j0JZaPAvQLqsKcx6c0Wve83SsYcwavDNx6L6hT11eXA5Q0SStm7CV5L8PBL8bXs=
X-Received: by 2002:a5b:9c8:0:b0:d4b:ab7b:17ed with SMTP id
 y8-20020a5b09c8000000b00d4bab7b17edmr2668350ybq.4.1694621129992; Wed, 13 Sep
 2023 09:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Sep 2023 16:05:17 +0000
Message-ID: <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
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

On Tue, Sep 12, 2023 at 4:00=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Sep 12, 2023 at 8:03=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 7:55=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 06:30:46AM +0100, Matthew Wilcox wrote:
> > > > On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20=
230831
> > > > > git tree:       linux-next
> > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16502=
ddba80000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ecd2=
a74f20953b9
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db591856=
e0f0139f83023
> > > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binuti=
ls for Debian) 2.40
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D120=
e7d70680000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1523f=
9c0680000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/b2e8f421=
7527/disk-a47fc304.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc0933=
9/vmlinux-a47fc304.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/bd9b24=
75bf5a/bzImage-a47fc304.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.co=
m
> > > >
> > > > #syz test
> > > >
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 42b5567e3773..90ad5fe60824 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start, uns=
igned long len,
> > > >       vma_iter_init(&vmi, mm, start);
> > > >       prev =3D vma_prev(&vmi);
> > > >       for_each_vma_range(vmi, vma, end) {
> > > > +             vma_start_write(vma);
> > > >               err =3D mbind_range(&vmi, vma, &prev, start, end, new=
);
> > > >               if (err)
> > > >                       break;
> > >
> > > Suren, can you take a look at this?  The VMA should be locked by the
> > > call to queue_pages_range(), but by the time we get to here, the VMA
> > > isn't locked.  I don't see anywhere that we cycle the mmap_lock (whic=
h
> > > would unlock the VMA), but I could have missed something.  The two
> > > VMA walks should walk over the same set of VMAs.  Certainly the VMA
> > > being dumped should have been locked by the pagewalk:
>
> Yeah, this looks strange. queue_pages_range() should have locked all
> the vmas and the tree can't change since we are holding mmap_lock for
> write. I'll try to reproduce later today and see what's going on.

So far I was unable to reproduce the issue. I tried with Linus' ToT
using the attached config. linux-next ToT does not boot with this
config but defconfig boots and fails to reproduce the issue. I'll try
to figure out why current linux-next does not like this config.

>
> >
> > Sure, I'll look into this today. Somehow this report slipped by me
> > unnoticed. Thanks!
> >
> > >
> > >  vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000 mm =
ffff8880258a8980
> > >  prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
> > >  pgoff 20c2a file 0000000000000000 private_data 0000000000000000
> > >  flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|so=
ftdirty)
> > >
> > >   syscall(__NR_mbind, /*addr=3D*/0x20400000ul, /*len=3D*/0xc00000ul, =
/*mode=3D*/4ul,
> > >           /*nodemask=3D*/0ul, /*maxnode=3D*/0ul, /*flags=3D*/3ul);
> > >
> > > 20400000 + c00000 should overlap 20c2a000-21000000
