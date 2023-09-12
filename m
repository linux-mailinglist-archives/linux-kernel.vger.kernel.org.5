Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67079D43D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjILPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjILPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:03:26 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC0115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:03:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c0bbbbad81so3505322a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694531001; x=1695135801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaB7HH0dQJ7CpwPFo5lVORGeh+RIfRfhSTGN+9z/Csg=;
        b=LTPdOyRCwWPifxI1s8JRjnQl2shJ11o9/RpfnvNU6slNtC0Q1P/DTm18Nxq0wWscPA
         J20NPwQx+06FijJNZC320Zq2vTSW4dz3UOrAuqHEgt+IbSuMxo6AdqRVXTYlbkMP1xnj
         lJBi5rYUylMZin7uJMgwE2JeSUGTsciBy+OuTBX+hTuUz346R+29yzg0xMLlnTi9sMuJ
         iW0zg3b8c18az4Lhq8owIhmbacEbpIiaM0zNfU3ssgAJu2nf4vDn9m18Y3T84/rbCNeC
         dTkJanM+sKdXVeLtBlNf7/YQxc3B8Pm+DS08Ff5lz+fppdXaEa8hnZtC1HooOaQ0khNI
         Ffxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531001; x=1695135801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaB7HH0dQJ7CpwPFo5lVORGeh+RIfRfhSTGN+9z/Csg=;
        b=cZlZhZL2dqdTSJ3oUmOJ6vAS1YU2l+0k0Ay8cDqqt1ld50ovrprKv3dpHrmhb3uIE4
         cNSsOY6WXKwEkQ4hVDIr3uNRaBfoubDhgPkaIeDNvAVuAkH7HRwqPgBMOYQagf7YoboE
         fxq+L74a6vgMUIoNcHJkAZQmrUeZxIw24jrLv2EhdXvlvLU+JO4wg3AkIANFOUZtL/l5
         9zpzf+J2Bd4Kg5wGn7/mF7VqlAAifQCnyt10dBVNwa9axAdnVarNE8ZhvkmpDbL/R46u
         4dmmBo4Pns1Jvew0DuWNhlPkX8Q6ZWXbPZwsH/1M8/WUT6hLmGjjcqBd4HR1vEASeDz9
         zZqA==
X-Gm-Message-State: AOJu0YwdY1f24CY+Yw3tYzHb5+g6T5RiVeUuOyJtiryuZ7xAJYySdYXw
        ZBHgE8jXoobftxebKwtw62XEpQ0y0TSbexL+XjaWizK/4w3sNDRV7Xc=
X-Google-Smtp-Source: AGHT+IG3ZscNIixhDWDTxnaO7oI6pgrWIJRItPByJO4MUOaVyzHZ86PaCL0Q84+HfJqUNs4oEPlzUoS5jIqeow7la+I=
X-Received: by 2002:a05:6830:114a:b0:6b9:e3b0:1433 with SMTP id
 x10-20020a056830114a00b006b9e3b01433mr13552803otq.37.1694531001364; Tue, 12
 Sep 2023 08:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org>
In-Reply-To: <ZQB76G/6NxVgoE9u@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Sep 2023 08:03:08 -0700
Message-ID: <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
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

On Tue, Sep 12, 2023 at 7:55=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Sep 12, 2023 at 06:30:46AM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    a47fc304d2b6 Add linux-next specific files for 202308=
31
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16502ddba=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ecd2a74f=
20953b9
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db591856e0f0=
139f83023
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D120e7d7=
0680000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1523f9c06=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/b2e8f4217527=
/disk-a47fc304.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09339/vm=
linux-a47fc304.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/bd9b2475bf=
5a/bzImage-a47fc304.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
> >
> > #syz test
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 42b5567e3773..90ad5fe60824 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start, unsigne=
d long len,
> >       vma_iter_init(&vmi, mm, start);
> >       prev =3D vma_prev(&vmi);
> >       for_each_vma_range(vmi, vma, end) {
> > +             vma_start_write(vma);
> >               err =3D mbind_range(&vmi, vma, &prev, start, end, new);
> >               if (err)
> >                       break;
>
> Suren, can you take a look at this?  The VMA should be locked by the
> call to queue_pages_range(), but by the time we get to here, the VMA
> isn't locked.  I don't see anywhere that we cycle the mmap_lock (which
> would unlock the VMA), but I could have missed something.  The two
> VMA walks should walk over the same set of VMAs.  Certainly the VMA
> being dumped should have been locked by the pagewalk:

Sure, I'll look into this today. Somehow this report slipped by me
unnoticed. Thanks!

>
>  vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000 mm ffff=
8880258a8980
>  prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
>  pgoff 20c2a file 0000000000000000 private_data 0000000000000000
>  flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|softdi=
rty)
>
>   syscall(__NR_mbind, /*addr=3D*/0x20400000ul, /*len=3D*/0xc00000ul, /*mo=
de=3D*/4ul,
>           /*nodemask=3D*/0ul, /*maxnode=3D*/0ul, /*flags=3D*/3ul);
>
> 20400000 + c00000 should overlap 20c2a000-21000000
