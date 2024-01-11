Return-Path: <linux-kernel+bounces-24069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D4882B65D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E56B21C03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71B5811C;
	Thu, 11 Jan 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RCucMcQV"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14656B80
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7c1012a42so55023557b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705007058; x=1705611858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZBM9DHTMRa5r9o/EOHYBsOH+N+oJgezGzR9/BcPyBA=;
        b=RCucMcQVSqfQFlmmPdKzjKcHChkEzqq1eGhDOueJV5NOYXx/dCBwjTBUDsu8rDzSpa
         GTwmuK4xuahgPNPs4C+Hlrm5sL61/3YSMpKFBwlNkwvX9o2UgBKcoxKdKWzYgtIfddz/
         lus4eKgPBN+Ezv3YWsQolBD0bI/nuuOIhUxk2H9V9KiUmDMIlK85a6hf0sW81/iXnJqr
         kGLnAxnLKWDIXdoUhG9Q4CHJA1Wapzt6AkoEXQ3rbVgsCII+aY79RUde15FR46pb4+4z
         PWMp7NP1QLIHQxTbrjl4faBZajV7CoBRVW5wPii+a2oj1VmtipnpDH5vG1exMjEQqH6X
         /0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705007058; x=1705611858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZBM9DHTMRa5r9o/EOHYBsOH+N+oJgezGzR9/BcPyBA=;
        b=rJBFnKkjXE1avEO+HM00ntJMdgDNdIRZlBD6YpLmZSbglXKYf1vgqVYqeSRoZHkFcl
         px60OqizkSxCUO89bRG5qpbWDGs5wcnYuUqIpg0rUfKGf1SKV5HKAhm1NM666+wesj+T
         NVAx5NQIPT3fkf9HEr02dcDy/o5s+ACw1sL5B/d6LzkgJ7qOVVAeJ5BBMBboB5Yl8baw
         t625h6xlz21NmwFm+aJtLdbaH4vR6oH4gYSZ5BYJcTjUe1qncRfNcBtbzmTUbdBT3tdW
         FZaHv5kWLIHejx3NQqZyusQT5d2xUfm55u+2mqEmIg2RgvqGNopHHm8KcE6vHO1dqsxk
         fsfw==
X-Gm-Message-State: AOJu0YwYG1CXCh0eMwqT4J208nz/SEAaTYVxHglLv/tlVuDgyu7CNzxb
	Q+9FocqvTVWb2x9HF+kwnTNTVTM/lStjnXuB4xaVH0mZ10eN
X-Google-Smtp-Source: AGHT+IFU4vD3qg9bo1/N+GrmostDVqHnqU0mqNePYQwXjQmDgut8e6ATb+n1Jg+lw2BRcgjE9YjbaH/XiOpxGxGcl3s=
X-Received: by 2002:a81:c80e:0:b0:5f1:e1f:fe7a with SMTP id
 n14-20020a81c80e000000b005f10e1ffe7amr399574ywi.10.1705007057927; Thu, 11 Jan
 2024 13:04:17 -0800 (PST)
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
 <bf9dbc58-35c4-4a35-b194-6d8d9e7e4923@redhat.com>
In-Reply-To: <bf9dbc58-35c4-4a35-b194-6d8d9e7e4923@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 21:04:06 +0000
Message-ID: <CAJuCfpGRA7KJhMBneqAj+dw=rQReU7PyR1r34yqrNSoa-RUKbg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>, aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:00=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.01.24 21:20, Suren Baghdasaryan wrote:
> > On Thu, Jan 11, 2024 at 6:58=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 11.01.24 19:34, Suren Baghdasaryan wrote:
> >>> On Thu, Jan 11, 2024 at 8:44=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> >>>>
> >>>> On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> >>>>>
> >>>>> On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> >>>>> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    e2425464bc87 Add linux-next specific files for 202=
40105
> >>>>>> git tree:       linux-next
> >>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14941c=
dee80000
> >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4056b9=
349f3da8c9
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D70520928=
1e36404998f6
> >>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutil=
s for Debian) 2.40
> >>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125d=
0a09e80000
> >>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bc73=
31e80000
> >>>>>>
> >>>>>> Downloadable assets:
> >>>>>> disk image: https://storage.googleapis.com/syzbot-assets/2f738185e=
2cf/disk-e2425464.raw.xz
> >>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea46=
/vmlinux-e2425464.xz
> >>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/a9945c8=
223f4/bzImage-e2425464.xz
> >>>>>>
> >>>>>> The issue was bisected to:
> >>>>>>
> >>>>>> commit adef440691bab824e39c1b17382322d195e1fab0
> >>>>>> Author: Andrea Arcangeli <aarcange@redhat.com>
> >>>>>> Date:   Wed Dec 6 10:36:56 2023 +0000
> >>>>>>
> >>>>>>       userfaultfd: UFFDIO_MOVE uABI
> >>>>>>
> >>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11c=
b6ea9e80000
> >>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13c=
b6ea9e80000
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cb6e=
a9e80000
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to t=
he commit:
> >>>>>> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> >>>>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >>>>>>
> >>>>>>    do_one_initcall+0x128/0x680 init/main.c:1237
> >>>>>>    do_initcall_level init/main.c:1299 [inline]
> >>>>>>    do_initcalls init/main.c:1315 [inline]
> >>>>>>    do_basic_setup init/main.c:1334 [inline]
> >>>>>>    kernel_init_freeable+0x692/0xc30 init/main.c:1552
> >>>>>>    kernel_init+0x1c/0x2a0 init/main.c:1442
> >>>>>>    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>>>>>    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >>>>>> ------------[ cut here ]------------
> >>>>>> kernel BUG at include/linux/page-flags.h:1035!
> >>>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >>>>>> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-next-=
20240105-syzkaller #0
> >>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,=
 BIOS Google 11/17/2023
> >>>>>> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inlin=
e]
> >>>>>
> >>>>>   From a quick look, I think the new ioctl is being used against a
> >>>>> file-backed page and that's why PageAnonExclusive() throws this err=
or.
> >>>>> I'll confirm if this is indeed the case and will add checks for tha=
t
> >>>>> case. Thanks!
> >>>>
> >>>> Hmm. Looking at the reproducer it does not look like a file-backed
> >>>> memory... Anyways, I'm on it.
> >>>
> >>> Looks like the test is trying to move the huge_zero_page. Wonder how
> >>> we should handle this. Just fail or do something else? Adding David
> >>> and Peter for feedback.
> >>
> >> You'll need some special-casing to handle that. But it should be fairl=
y
> >> easy.
> >
> > Ok, so should we treat zeropage the same as PAE and map destination
> > PTE/PMD to zeropage while clearing source PTE/PMD?
>
> Likely yes. So it's transparent for user space what we are moving. (this
> sounds like an easy case to not require a prior write access just to
> move it)

Ok, working on it. split_huge_pmd() already knows how to split
huge_zero_page but I think I'll need special handling in both
move_pages_pte() and move_pages_huge_pmd().

>
> --
> Cheers,
>
> David / dhildenb
>

