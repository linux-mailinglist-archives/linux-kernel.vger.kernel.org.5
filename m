Return-Path: <linux-kernel+bounces-24039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4F82B5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67941C23A54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4E5822E;
	Thu, 11 Jan 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7Zd6Nxq"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5855821D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed729a51eso4858228276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705004434; x=1705609234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xPybHcp93lzwM1bLAUfynUVuWNEPwDOj9925UdBh2g=;
        b=G7Zd6Nxq2MAvje5Tt1doaRan6DlIUezhLYgyj0vV8oTnb/p54LGtWR00ceaIio4Ku/
         Sr8w6AJWJd4OTrgjDiEl6pA7k8VfYIvbJ5FMdovn9DY5TX4+SeSZo99262t6V+Sj/Ifx
         iHBhUTRDKxoIcPAo+FH7hHFSEWnGDqaMDcABCbdhdyYfhlTJsNo8d7fpKN3ouAgpT3yP
         gdqwKrvsZJB1YuapBgRqrxq5Ok0RVjWPuJ0kq/WQVncjA0WUL8S8U11cTDwZTnl/YDQI
         cXka5XXcKJ4yF3RLR0VMjNaa+2XD4IMQvk4cljTnDQiRFDRoc/RUHurQUeieZTcjBW73
         eJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004434; x=1705609234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xPybHcp93lzwM1bLAUfynUVuWNEPwDOj9925UdBh2g=;
        b=CKJbPrRYZR65d6+xCtzc0PN0c9fv+YyBHdtpaf4RvRi5CYfk8KbiEA3Tjg1+jfOaRl
         8ilFs96WK8EyuClAQM8T7Xgg1Hs0pq85A9M52MRoFOXC8ypq4io2FUr4rhO5th0BGrNe
         Wh45/dMA2ZCihYK+Z6Bi6zjRzmcxDKHIe2X/7Te7Egv8Rl9i6WL9vY4QeqrVOlWHU1HL
         91WK2q9e636T3BjLh3EjDYkzXq3EZFjzslTV+oZ9gJj4mGh3SgmyVuHwv8dr5DBEVW90
         i+HHXm6IFectjWnlcrl3dzCaWlUsf4ClWA1SBKfUY0tpC9N5DEBmf76ogF7lykTdgZFs
         IbLA==
X-Gm-Message-State: AOJu0Yy/phSlNaAS2lYVR7cqOGjEE/cmcmibjJWrFLIyuj2nTk1v4COb
	/WIfr8fXo/tlNCHK0yy+R7+y5uZzKWQ1EFYUdKmLyiLNnen0
X-Google-Smtp-Source: AGHT+IFnf5K7jXL040LPP1QXXMkEv7U2vIEPXfF0Y7eHkd0/aPJhkMirhvKAcUmn6SzJk+VHGF8BndNyZGcLusKsAgI=
X-Received: by 2002:a25:2e06:0:b0:dbd:c2bf:a622 with SMTP id
 u6-20020a252e06000000b00dbdc2bfa622mr194548ybu.23.1705004433532; Thu, 11 Jan
 2024 12:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000011d709060eadffd3@google.com> <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
 <CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
 <CAJuCfpHTAAPEjMLrcxyG8zW7HA47EinB8CQfKGmBw7gGxqQ=vA@mail.gmail.com> <5ed23cf3-eedd-44aa-a498-d2a9ab046535@redhat.com>
In-Reply-To: <5ed23cf3-eedd-44aa-a498-d2a9ab046535@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 20:20:22 +0000
Message-ID: <CAJuCfpG5T71Sc46pB2eGpV7TreMZX2VZ-kDfaNmtn+etP0q9JA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>, aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:58=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.01.24 19:34, Suren Baghdasaryan wrote:
> > On Thu, Jan 11, 2024 at 8:44=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>>
> >>> On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> >>> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> syzbot found the following issue on:
> >>>>
> >>>> HEAD commit:    e2425464bc87 Add linux-next specific files for 20240=
105
> >>>> git tree:       linux-next
> >>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14941cde=
e80000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4056b934=
9f3da8c9
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D705209281e=
36404998f6
> >>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils =
for Debian) 2.40
> >>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125d0a=
09e80000
> >>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bc7331=
e80000
> >>>>
> >>>> Downloadable assets:
> >>>> disk image: https://storage.googleapis.com/syzbot-assets/2f738185e2c=
f/disk-e2425464.raw.xz
> >>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea46/v=
mlinux-e2425464.xz
> >>>> kernel image: https://storage.googleapis.com/syzbot-assets/a9945c822=
3f4/bzImage-e2425464.xz
> >>>>
> >>>> The issue was bisected to:
> >>>>
> >>>> commit adef440691bab824e39c1b17382322d195e1fab0
> >>>> Author: Andrea Arcangeli <aarcange@redhat.com>
> >>>> Date:   Wed Dec 6 10:36:56 2023 +0000
> >>>>
> >>>>      userfaultfd: UFFDIO_MOVE uABI
> >>>>
> >>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11cb6=
ea9e80000
> >>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13cb6=
ea9e80000
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cb6ea9=
e80000
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
> >>>> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> >>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >>>>
> >>>>   do_one_initcall+0x128/0x680 init/main.c:1237
> >>>>   do_initcall_level init/main.c:1299 [inline]
> >>>>   do_initcalls init/main.c:1315 [inline]
> >>>>   do_basic_setup init/main.c:1334 [inline]
> >>>>   kernel_init_freeable+0x692/0xc30 init/main.c:1552
> >>>>   kernel_init+0x1c/0x2a0 init/main.c:1442
> >>>>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>>>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >>>> ------------[ cut here ]------------
> >>>> kernel BUG at include/linux/page-flags.h:1035!
> >>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >>>> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-next-20=
240105-syzkaller #0
> >>>> Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 11/17/2023
> >>>> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
> >>>
> >>>  From a quick look, I think the new ioctl is being used against a
> >>> file-backed page and that's why PageAnonExclusive() throws this error=
.
> >>> I'll confirm if this is indeed the case and will add checks for that
> >>> case. Thanks!
> >>
> >> Hmm. Looking at the reproducer it does not look like a file-backed
> >> memory... Anyways, I'm on it.
> >
> > Looks like the test is trying to move the huge_zero_page. Wonder how
> > we should handle this. Just fail or do something else? Adding David
> > and Peter for feedback.
>
> You'll need some special-casing to handle that. But it should be fairly
> easy.

Ok, so should we treat zeropage the same as PAE and map destination
PTE/PMD to zeropage while clearing source PTE/PMD?

>
> --
> Cheers,
>
> David / dhildenb
>

