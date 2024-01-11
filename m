Return-Path: <linux-kernel+bounces-24076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6AD82B677
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B469B20FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA258208;
	Thu, 11 Jan 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qxz6Eh8d"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CF58200
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e76948cda7so56989527b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705007631; x=1705612431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+xq1TtNnp/gjdjiyMqlvepkDkjpAkmL94vcnwd59ac=;
        b=qxz6Eh8dJ4tFqORQWmW6J6uxdezFoa44DcXjoYBzoOMsOciZlIBZKXkcKr0XGEFn9b
         nZE13t4gPWtmkEa4gg97SvgDuUYitZvbpbUsJ+OZFV1brbltAV49Dyw7Nawmj6juZ2WV
         iJSLuioOSsr1b7CRbEkBeYPJNlNkJAm9Eg2cZM2VO7UpW7jR/zWhv2BtNE7Q/Xi/cVD4
         mjvN7BYRelq3Gmc72WOY6MHqv9Jb908wCSB05zjO0BozfLSWNqIwXQv0LOrasyU6iQk6
         6DDXelWkePxFlWA57qF2MY2I3c4oyh0ZlKICg5QEG2AVlgXLeOGPJNBp+wvqcTzXtjQV
         EABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705007631; x=1705612431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+xq1TtNnp/gjdjiyMqlvepkDkjpAkmL94vcnwd59ac=;
        b=v2+BJLeknukYrGTl745R3mClqdb3kb8qhvYGK/qA0Zj5ndH9lwxVTRPsEgUEpVcQL7
         +o0QEHTvL3qGFamW9w+LAuJb8Cyfz1QhvDt8L7dx3+RYvDbvO2VFYwsqGy0VI5JKdpuR
         /Sxc+EZj6LotR/OfOUlRUyLZTqUZAk9ATbU1ttY7Y1GfbxJVtfo++lfM/2BtAIiM4iki
         oMG7Pcbxx7UsshqgpGT+VelJ4jzUmAyuinyMZGldHqvcBeLGrpzc1MS9ZKPGN5Rmow5w
         75q3ja6eo3Ah53wziPezSRtAiP0wSI2tcikiwNzxnuvb0yzx7tq5/TAGgheU5R8fuMj0
         rNEQ==
X-Gm-Message-State: AOJu0Yzlm7ooiNXki153ohrvl8Uq5V6hz64LXr3JyrkL8R5gxWrClEv5
	ZlYGyWlfp5rfEPCuFnAw0ntLhq5K9BWJTZ0DbbKtJqPq8p9D
X-Google-Smtp-Source: AGHT+IHILrutT2/eQmrr2s79qeIc3WjC8/Moy6OGTbSSGmdU44d/ZhXjSyGZI8OltlzGi28+6US+BuB9FVHvLo1lUYE=
X-Received: by 2002:a81:5dd5:0:b0:5f8:c3a:6989 with SMTP id
 r204-20020a815dd5000000b005f80c3a6989mr472875ywb.34.1705007631145; Thu, 11
 Jan 2024 13:13:51 -0800 (PST)
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
 <15ce90cd-ff0b-4bc3-bee4-880bee3200ae@redhat.com>
In-Reply-To: <15ce90cd-ff0b-4bc3-bee4-880bee3200ae@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 13:13:40 -0800
Message-ID: <CAJuCfpFcjxX4RkcYyzLWMBqPw4amzbiJCZx8UdmM1H2_QkoOqA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>, aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:06=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.01.24 22:04, Suren Baghdasaryan wrote:
> > On Thu, Jan 11, 2024 at 9:00=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 11.01.24 21:20, Suren Baghdasaryan wrote:
> >>> On Thu, Jan 11, 2024 at 6:58=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 11.01.24 19:34, Suren Baghdasaryan wrote:
> >>>>> On Thu, Jan 11, 2024 at 8:44=E2=80=AFAM Suren Baghdasaryan <surenb@=
google.com> wrote:
> >>>>>>
> >>>>>> On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <surenb=
@google.com> wrote:
> >>>>>>>
> >>>>>>> On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> >>>>>>> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> syzbot found the following issue on:
> >>>>>>>>
> >>>>>>>> HEAD commit:    e2425464bc87 Add linux-next specific files for 2=
0240105
> >>>>>>>> git tree:       linux-next
> >>>>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1494=
1cdee80000
> >>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4056=
b9349f3da8c9
> >>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D705209=
281e36404998f6
> >>>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binut=
ils for Debian) 2.40
> >>>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12=
5d0a09e80000
> >>>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bc=
7331e80000
> >>>>>>>>
> >>>>>>>> Downloadable assets:
> >>>>>>>> disk image: https://storage.googleapis.com/syzbot-assets/2f73818=
5e2cf/disk-e2425464.raw.xz
> >>>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea=
46/vmlinux-e2425464.xz
> >>>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/a9945=
c8223f4/bzImage-e2425464.xz
> >>>>>>>>
> >>>>>>>> The issue was bisected to:
> >>>>>>>>
> >>>>>>>> commit adef440691bab824e39c1b17382322d195e1fab0
> >>>>>>>> Author: Andrea Arcangeli <aarcange@redhat.com>
> >>>>>>>> Date:   Wed Dec 6 10:36:56 2023 +0000
> >>>>>>>>
> >>>>>>>>        userfaultfd: UFFDIO_MOVE uABI
> >>>>>>>>
> >>>>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1=
1cb6ea9e80000
> >>>>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1=
3cb6ea9e80000
> >>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cb=
6ea9e80000
> >>>>>>>>
> >>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to=
 the commit:
> >>>>>>>> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.c=
om
> >>>>>>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >>>>>>>>
> >>>>>>>>     do_one_initcall+0x128/0x680 init/main.c:1237
> >>>>>>>>     do_initcall_level init/main.c:1299 [inline]
> >>>>>>>>     do_initcalls init/main.c:1315 [inline]
> >>>>>>>>     do_basic_setup init/main.c:1334 [inline]
> >>>>>>>>     kernel_init_freeable+0x692/0xc30 init/main.c:1552
> >>>>>>>>     kernel_init+0x1c/0x2a0 init/main.c:1442
> >>>>>>>>     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>>>>>>>     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >>>>>>>> ------------[ cut here ]------------
> >>>>>>>> kernel BUG at include/linux/page-flags.h:1035!
> >>>>>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >>>>>>>> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-nex=
t-20240105-syzkaller #0
> >>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engin=
e, BIOS Google 11/17/2023
> >>>>>>>> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inl=
ine]
> >>>>>>>
> >>>>>>>    From a quick look, I think the new ioctl is being used against=
 a
> >>>>>>> file-backed page and that's why PageAnonExclusive() throws this e=
rror.
> >>>>>>> I'll confirm if this is indeed the case and will add checks for t=
hat
> >>>>>>> case. Thanks!
> >>>>>>
> >>>>>> Hmm. Looking at the reproducer it does not look like a file-backed
> >>>>>> memory... Anyways, I'm on it.
> >>>>>
> >>>>> Looks like the test is trying to move the huge_zero_page. Wonder ho=
w
> >>>>> we should handle this. Just fail or do something else? Adding David
> >>>>> and Peter for feedback.
> >>>>
> >>>> You'll need some special-casing to handle that. But it should be fai=
rly
> >>>> easy.
> >>>
> >>> Ok, so should we treat zeropage the same as PAE and map destination
> >>> PTE/PMD to zeropage while clearing source PTE/PMD?
> >>
> >> Likely yes. So it's transparent for user space what we are moving. (th=
is
> >> sounds like an easy case to not require a prior write access just to
> >> move it)
> >
> > Ok, working on it. split_huge_pmd() already knows how to split
> > huge_zero_page but I think I'll need special handling in both
> > move_pages_pte() and move_pages_huge_pmd().
>
> A PTE-mapped huge zeropage is just a page table populated with the
> ordinary shared zeropage. Are you moving the ordinary shared zeropage as
> well? If not, you should do so for consistency (or not do either :) ).

Yes, I think I should move ordinary zeropages as well.

>
> --
> Cheers,
>
> David / dhildenb
>

