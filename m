Return-Path: <linux-kernel+bounces-24216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6744382B938
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1136E28987E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD04A21;
	Fri, 12 Jan 2024 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qDAUU0wm"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD768469F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e89ba9810aso51438427b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705023910; x=1705628710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwfKNFvm8QyzmQofKZ8aVlq1/QWvi0cu1esaAtwrFUo=;
        b=qDAUU0wmVpfQeiqu0CTx50QKOouyS0slQC/cB7QQOg2T+onnwBtO8AHXnx2E+WAXeC
         o/5UpmgLXsvJ2mMFXoopQ3jg3NhzeXK8bcLZm7vnY7DrUgYKQxoROrRyy0QaWqM9u7x8
         iipHcwUfZEX2gUpAK+esa7ZOgn/Pdp/qYyv/jr4dO0Q4BrH+sIsbcaT31DqJEEz5yaA2
         4n4vspdl/t61CvolTWkLRbR5+4m/6bJMNrXWVjh08v5nXCMM9zV8EU+7v4K9vN2/UxBL
         PUQjy3xFvDNnhwDtASobIVIEVwGxzq/AU7VASqRBh1JmL3oW5zwKN5tuHdU2dufdXht8
         Vh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705023910; x=1705628710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwfKNFvm8QyzmQofKZ8aVlq1/QWvi0cu1esaAtwrFUo=;
        b=CTOj8NLGhzrZeGTxB5Jfs4llfwWaZCpiAP8M3w0dn6L2BxfieITg/OlKCqZRBOwa0F
         qa2Y09Kfd1J/xNkEjK/tJqGW6vwxa0IuC2kJ2A7LiHFJM80Sjw37CKGQ/ecdsdV/OoxE
         HYYQt/xDhVgQkh/9+t2Rcqmg/cKNNJm8vZ/7mdTbhaJDRx9tp22KcHfCaCZTvWtoUBwy
         uSzMNtoMOZrkPrnM+cd5VFIou0Nr9XwPBh0Bh3pw7CjOibKJdr8QtfmYmu4C2HFpFkr5
         ANkUr+tMoV4jdC3EecnmpyGg3I0b4LLFKNeZuWonNVxvf6yBgkeDvnejsS+b62gueL4a
         vJbw==
X-Gm-Message-State: AOJu0Ywa5llQI7m604k+SSTnuA1UZsOtD7F46yXmhPgP7zeDJkuHswC0
	F4/M/fE80naxR/c+R2A+SKUIirvaqlrAnxLuDS7eAXMLXIa2
X-Google-Smtp-Source: AGHT+IFAsCOpo+2v4dWFZPCTajTA6UTDPtSXWSL2urXkzvdbQCrm4msG36fdjr9pKizgskUhBp49zrNYMYRbfm2MWC4=
X-Received: by 2002:a81:8396:0:b0:5f8:9702:4040 with SMTP id
 t144-20020a818396000000b005f897024040mr636949ywf.52.1705023910394; Thu, 11
 Jan 2024 17:45:10 -0800 (PST)
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
 <CAJuCfpFQaKMh9c8e4YMvqh5ZDoX91C3RWYaB-vsX5YgwC=wvcg@mail.gmail.com>
In-Reply-To: <CAJuCfpFQaKMh9c8e4YMvqh5ZDoX91C3RWYaB-vsX5YgwC=wvcg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 17:44:57 -0800
Message-ID: <CAJuCfpFxoDzQ_MBQe127pdWBRxugN2c7QsoemvHp+qCnfir+JQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org
Cc: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, aarcange@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 3:23=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jan 11, 2024 at 9:13=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Thu, Jan 11, 2024 at 1:06=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> > >
> > > On 11.01.24 22:04, Suren Baghdasaryan wrote:
> > > > On Thu, Jan 11, 2024 at 9:00=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> > > >>
> > > >> On 11.01.24 21:20, Suren Baghdasaryan wrote:
> > > >>> On Thu, Jan 11, 2024 at 6:58=E2=80=AFPM David Hildenbrand <david@=
redhat.com> wrote:
> > > >>>>
> > > >>>> On 11.01.24 19:34, Suren Baghdasaryan wrote:
> > > >>>>> On Thu, Jan 11, 2024 at 8:44=E2=80=AFAM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > >>>>>>
> > > >>>>>> On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <su=
renb@google.com> wrote:
> > > >>>>>>>
> > > >>>>>>> On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> > > >>>>>>> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote=
:
> > > >>>>>>>>
> > > >>>>>>>> Hello,
> > > >>>>>>>>
> > > >>>>>>>> syzbot found the following issue on:
> > > >>>>>>>>
> > > >>>>>>>> HEAD commit:    e2425464bc87 Add linux-next specific files f=
or 20240105
> > > >>>>>>>> git tree:       linux-next
> > > >>>>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D=
14941cdee80000
> > > >>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D=
4056b9349f3da8c9
> > > >>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D70=
5209281e36404998f6
> > > >>>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU B=
inutils for Debian) 2.40
> > > >>>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=
=3D125d0a09e80000
> > > >>>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D=
15bc7331e80000
> > > >>>>>>>>
> > > >>>>>>>> Downloadable assets:
> > > >>>>>>>> disk image: https://storage.googleapis.com/syzbot-assets/2f7=
38185e2cf/disk-e2425464.raw.xz
> > > >>>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fc=
f4ea46/vmlinux-e2425464.xz
> > > >>>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/a=
9945c8223f4/bzImage-e2425464.xz
> > > >>>>>>>>
> > > >>>>>>>> The issue was bisected to:
> > > >>>>>>>>
> > > >>>>>>>> commit adef440691bab824e39c1b17382322d195e1fab0
> > > >>>>>>>> Author: Andrea Arcangeli <aarcange@redhat.com>
> > > >>>>>>>> Date:   Wed Dec 6 10:36:56 2023 +0000
> > > >>>>>>>>
> > > >>>>>>>>        userfaultfd: UFFDIO_MOVE uABI
> > > >>>>>>>>
> > > >>>>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=
=3D11cb6ea9e80000
> > > >>>>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=
=3D13cb6ea9e80000
> > > >>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D=
15cb6ea9e80000
> > > >>>>>>>>
> > > >>>>>>>> IMPORTANT: if you fix the issue, please add the following ta=
g to the commit:
> > > >>>>>>>> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotma=
il.com
> > > >>>>>>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > >>>>>>>>
> > > >>>>>>>>     do_one_initcall+0x128/0x680 init/main.c:1237
> > > >>>>>>>>     do_initcall_level init/main.c:1299 [inline]
> > > >>>>>>>>     do_initcalls init/main.c:1315 [inline]
> > > >>>>>>>>     do_basic_setup init/main.c:1334 [inline]
> > > >>>>>>>>     kernel_init_freeable+0x692/0xc30 init/main.c:1552
> > > >>>>>>>>     kernel_init+0x1c/0x2a0 init/main.c:1442
> > > >>>>>>>>     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > > >>>>>>>>     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:24=
2
> > > >>>>>>>> ------------[ cut here ]------------
> > > >>>>>>>> kernel BUG at include/linux/page-flags.h:1035!
> > > >>>>>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > >>>>>>>> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8=
-next-20240105-syzkaller #0
> > > >>>>>>>> Hardware name: Google Google Compute Engine/Google Compute E=
ngine, BIOS Google 11/17/2023
> > > >>>>>>>> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 =
[inline]
> > > >>>>>>>
> > > >>>>>>>    From a quick look, I think the new ioctl is being used aga=
inst a
> > > >>>>>>> file-backed page and that's why PageAnonExclusive() throws th=
is error.
> > > >>>>>>> I'll confirm if this is indeed the case and will add checks f=
or that
> > > >>>>>>> case. Thanks!
> > > >>>>>>
> > > >>>>>> Hmm. Looking at the reproducer it does not look like a file-ba=
cked
> > > >>>>>> memory... Anyways, I'm on it.
> > > >>>>>
> > > >>>>> Looks like the test is trying to move the huge_zero_page. Wonde=
r how
> > > >>>>> we should handle this. Just fail or do something else? Adding D=
avid
> > > >>>>> and Peter for feedback.
> > > >>>>
> > > >>>> You'll need some special-casing to handle that. But it should be=
 fairly
> > > >>>> easy.
> > > >>>
> > > >>> Ok, so should we treat zeropage the same as PAE and map destinati=
on
> > > >>> PTE/PMD to zeropage while clearing source PTE/PMD?
> > > >>
> > > >> Likely yes. So it's transparent for user space what we are moving.=
 (this
> > > >> sounds like an easy case to not require a prior write access just =
to
> > > >> move it)
> > > >
> > > > Ok, working on it. split_huge_pmd() already knows how to split
> > > > huge_zero_page but I think I'll need special handling in both
> > > > move_pages_pte() and move_pages_huge_pmd().
> > >
> > > A PTE-mapped huge zeropage is just a page table populated with the
> > > ordinary shared zeropage. Are you moving the ordinary shared zeropage=
 as
> > > well? If not, you should do so for consistency (or not do either :) )=
.
> >
> > Yes, I think I should move ordinary zeropages as well.
>
> I have a version that seems to work but I want to test it more and
> it's too heavy to be considered a quick fix for linux-next. I'll post
> a simple one-line fix which takes care of this crash and keeps the
> behavior for zeropages the same (ioctl returns -EBUSY). Later will
> post a separate patch to move huge and ordinary zeropages.

I posted a quick fix for this issue here:
https://lore.kernel.org/all/20240112013935.1474648-1-surenb@google.com/
It cleanly applies over linux-next, mm-stable and mm-unstable. Andrew,
Stephen, could you please pull the fix into your branches?
Thanks,
Suren.


>
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >

