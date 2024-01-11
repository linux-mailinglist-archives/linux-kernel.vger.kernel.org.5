Return-Path: <linux-kernel+bounces-24129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E182B7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A4428A25D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193959146;
	Thu, 11 Jan 2024 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GmqWfsUt"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98958112
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so61128687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705015419; x=1705620219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/2c/q3CBvBFI+OFez7rYBbZUMG36kUjDthdO2cC1Iw=;
        b=GmqWfsUtJwSU5kxY/TS+SKy4PFIA9AHJfGN0ZSM4P19AuG29JwkX9tbheUPXsf7etw
         iXdEeIiWvyarTZfSxlrtoE5zDZ4WXOYaZg4NnWjMMJzNnRoBgllVbw6Stch4x+p4rMGl
         PwlYL2LvjmqNWOpaYrF3RGTsOc7tjGbabSNAHn8etrDUX9AR7t4ZKa/ga8vUrL7dDZtx
         cCFREO4/UhiN2TwuXSfEocK9XyCTNivtYcakzZcfAXqiAI/lH3vv/ItW0/GyZ7HVwcf2
         m1Ul5Wf9C1Mxp1tpkxXebAK53kV7CbZjAhAC+vMNl82vfkInx9BZYpLaK5awJWQroo25
         kemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705015419; x=1705620219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/2c/q3CBvBFI+OFez7rYBbZUMG36kUjDthdO2cC1Iw=;
        b=tOT3y8s86T0fwGX/S/h/3q1ZSAyBNTZydAb3SO5tyeyUAGTH4r2jG3dpQjVr+8ImZV
         0nxn9eOpNYtegekUYl36hF9C+YLLN0P8U3nei6S1Y/aXsRgCdcBRQB1eMdpxiC+qZ5Dk
         CNemkNfKH4WifKZJqjpCSDoHoBwnUJqll/Xi0gWuYi4P5sSV4lKmRt3tNnHzh83UbYdN
         7y5hP582V9br/vwZC1bcCH+wX3hjsrda0nOL8RRhjiVQs/R8IpuRFL7WFysXyMg/AHSP
         ZaPbXT0h36JkUHy3dqNN6rMZOcYlW8/PamPtlTA9mDyvMTvm96pY6kjRj2j4QI2UlqPk
         MFWA==
X-Gm-Message-State: AOJu0YyaN95RmMjW7iPjOUC1OPhVEb4Y225+IBjljAYKBylOBVwCWdmy
	+r1tg4IXP9iMXA/sM/gmqojCQN5Q0RxtMCk37DmvRniXIAO0PJZwGrWsIm9XeGfK
X-Google-Smtp-Source: AGHT+IFW049Ciaek6MLXkM6yns9ULFYBY0oYlSBwi9vJA/vwZqYKUccputGMMZPW4gdxCl8JracxooyfmSYw/4xLKO8=
X-Received: by 2002:a0d:eb96:0:b0:5fb:503:7f40 with SMTP id
 u144-20020a0deb96000000b005fb05037f40mr639128ywe.3.1705015419321; Thu, 11 Jan
 2024 15:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000011d709060eadffd3@google.com> <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
 <CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
 <CAJuCfpHTAAPEjMLrcxyG8zW7HA47EinB8CQfKGmBw7gGxqQ=vA@mail.gmail.com>
 <5ed23cf3-eedd-44aa-a498-d2a9ab046535@redhat.com> <CAJuCfpG5T71Sc46pB2eGpV7TreMZX2VZ-kDfaNmtn+etP0q9JA@mail.gmail.com>
 <bf9dbc58-35c4-4a35-b194-6d8d9e7e4923@redhat.com> <CAJuCfpGRA7KJhMBneqAj+dw=rQReU7PyR1r34yqrNSoa-RUKbg@mail.gmail.com>
 <15ce90cd-ff0b-4bc3-bee4-880bee3200ae@redhat.com> <CAJuCfpFcjxX4RkcYyzLWMBqPw4amzbiJCZx8UdmM1H2_QkoOqA@mail.gmail.com>
In-Reply-To: <CAJuCfpFcjxX4RkcYyzLWMBqPw4amzbiJCZx8UdmM1H2_QkoOqA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 23:23:27 +0000
Message-ID: <CAJuCfpFQaKMh9c8e4YMvqh5ZDoX91C3RWYaB-vsX5YgwC=wvcg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>, aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:13=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jan 11, 2024 at 1:06=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 11.01.24 22:04, Suren Baghdasaryan wrote:
> > > On Thu, Jan 11, 2024 at 9:00=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > >>
> > >> On 11.01.24 21:20, Suren Baghdasaryan wrote:
> > >>> On Thu, Jan 11, 2024 at 6:58=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> > >>>>
> > >>>> On 11.01.24 19:34, Suren Baghdasaryan wrote:
> > >>>>> On Thu, Jan 11, 2024 at 8:44=E2=80=AFAM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > >>>>>>
> > >>>>>> On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <sure=
nb@google.com> wrote:
> > >>>>>>>
> > >>>>>>> On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> > >>>>>>> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
> > >>>>>>>>
> > >>>>>>>> Hello,
> > >>>>>>>>
> > >>>>>>>> syzbot found the following issue on:
> > >>>>>>>>
> > >>>>>>>> HEAD commit:    e2425464bc87 Add linux-next specific files for=
 20240105
> > >>>>>>>> git tree:       linux-next
> > >>>>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14=
941cdee80000
> > >>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D40=
56b9349f3da8c9
> > >>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7052=
09281e36404998f6
> > >>>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Bin=
utils for Debian) 2.40
> > >>>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D=
125d0a09e80000
> > >>>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15=
bc7331e80000
> > >>>>>>>>
> > >>>>>>>> Downloadable assets:
> > >>>>>>>> disk image: https://storage.googleapis.com/syzbot-assets/2f738=
185e2cf/disk-e2425464.raw.xz
> > >>>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4=
ea46/vmlinux-e2425464.xz
> > >>>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/a99=
45c8223f4/bzImage-e2425464.xz
> > >>>>>>>>
> > >>>>>>>> The issue was bisected to:
> > >>>>>>>>
> > >>>>>>>> commit adef440691bab824e39c1b17382322d195e1fab0
> > >>>>>>>> Author: Andrea Arcangeli <aarcange@redhat.com>
> > >>>>>>>> Date:   Wed Dec 6 10:36:56 2023 +0000
> > >>>>>>>>
> > >>>>>>>>        userfaultfd: UFFDIO_MOVE uABI
> > >>>>>>>>
> > >>>>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=
=3D11cb6ea9e80000
> > >>>>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=
=3D13cb6ea9e80000
> > >>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15=
cb6ea9e80000
> > >>>>>>>>
> > >>>>>>>> IMPORTANT: if you fix the issue, please add the following tag =
to the commit:
> > >>>>>>>> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail=
com
> > >>>>>>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > >>>>>>>>
> > >>>>>>>>     do_one_initcall+0x128/0x680 init/main.c:1237
> > >>>>>>>>     do_initcall_level init/main.c:1299 [inline]
> > >>>>>>>>     do_initcalls init/main.c:1315 [inline]
> > >>>>>>>>     do_basic_setup init/main.c:1334 [inline]
> > >>>>>>>>     kernel_init_freeable+0x692/0xc30 init/main.c:1552
> > >>>>>>>>     kernel_init+0x1c/0x2a0 init/main.c:1442
> > >>>>>>>>     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >>>>>>>>     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > >>>>>>>> ------------[ cut here ]------------
> > >>>>>>>> kernel BUG at include/linux/page-flags.h:1035!
> > >>>>>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > >>>>>>>> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-n=
ext-20240105-syzkaller #0
> > >>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Eng=
ine, BIOS Google 11/17/2023
> > >>>>>>>> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [i=
nline]
> > >>>>>>>
> > >>>>>>>    From a quick look, I think the new ioctl is being used again=
st a
> > >>>>>>> file-backed page and that's why PageAnonExclusive() throws this=
 error.
> > >>>>>>> I'll confirm if this is indeed the case and will add checks for=
 that
> > >>>>>>> case. Thanks!
> > >>>>>>
> > >>>>>> Hmm. Looking at the reproducer it does not look like a file-back=
ed
> > >>>>>> memory... Anyways, I'm on it.
> > >>>>>
> > >>>>> Looks like the test is trying to move the huge_zero_page. Wonder =
how
> > >>>>> we should handle this. Just fail or do something else? Adding Dav=
id
> > >>>>> and Peter for feedback.
> > >>>>
> > >>>> You'll need some special-casing to handle that. But it should be f=
airly
> > >>>> easy.
> > >>>
> > >>> Ok, so should we treat zeropage the same as PAE and map destination
> > >>> PTE/PMD to zeropage while clearing source PTE/PMD?
> > >>
> > >> Likely yes. So it's transparent for user space what we are moving. (=
this
> > >> sounds like an easy case to not require a prior write access just to
> > >> move it)
> > >
> > > Ok, working on it. split_huge_pmd() already knows how to split
> > > huge_zero_page but I think I'll need special handling in both
> > > move_pages_pte() and move_pages_huge_pmd().
> >
> > A PTE-mapped huge zeropage is just a page table populated with the
> > ordinary shared zeropage. Are you moving the ordinary shared zeropage a=
s
> > well? If not, you should do so for consistency (or not do either :) ).
>
> Yes, I think I should move ordinary zeropages as well.

I have a version that seems to work but I want to test it more and
it's too heavy to be considered a quick fix for linux-next. I'll post
a simple one-line fix which takes care of this crash and keeps the
behavior for zeropages the same (ioctl returns -EBUSY). Later will
post a separate patch to move huge and ordinary zeropages.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

