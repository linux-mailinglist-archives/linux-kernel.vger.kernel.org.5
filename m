Return-Path: <linux-kernel+bounces-106687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE387F1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB81C20C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26458222;
	Mon, 18 Mar 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KztRh7Gc"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D558137
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796878; cv=none; b=E1NnEKZ2B50R0XSuv9NE4hQwl8QXxVQYDkFrbZjJosA/2QU3n7LPeEAp05uYQZjkgVPfvJb4+dtc9tXu1aFYwLGWd8B2jtLg70DjfbRLAAeQkGB+AHaHoKJwu8Iix7/LqmCfVKQSm3j+yo4asxkoYlRzgkwGxeHZZUvC83WVzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796878; c=relaxed/simple;
	bh=nKQo4G79qf7egA48uAJNolqFYQAVIzSYoBENi5I5TXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arpE35F13KEUZo9eagrbuRI17cw14g5UHfxiaSpjoCHZHzw5p4fth4fKY5MSemuuoHBYWUSdAwTmM+w6JUP1jilLY9jz3cd+fSfJlo4OozR7e2c86wzhrDix7WQIZvVzZR8sTNBo9ryezgvQ5bOzs+5oDqbpWjr6V7EUZ9qaIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KztRh7Gc; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e06168551eso535037241.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796875; x=1711401675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjOD7mDy02hE6NnUhEBpDyYj8qQdTdU84108fxqZo54=;
        b=KztRh7GcppxbOgaEPRa/UWaxEHdIKTf7J2tdpxPYiKNMCITLwF6kq9lB6O1QL0ApLn
         WzVrfNIzDWmtl7qOsXFRXpINYzm8PzZdjUeqy0I5hgLv039HrunqmqXFyUYi4+RZVVXh
         hWi7raVmu6ATYmAaBy01TTLSe2JeC0VwEFb4tsbFdGbQdlU4+gPcLw/7RY7A5AEDbrvi
         f+ycjOlHzSCORTDBkdogumamZZoFT13UR+7gb8rzqZX9HHeJD6Y1NjbN8N9wkIbjKVHC
         9M2HMncU5S1AytvjsKCZVpG1WQQVlO/niwEJusrVAAMG3W7VVNw0dNuOY/zI5ETgrpVS
         DE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796875; x=1711401675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjOD7mDy02hE6NnUhEBpDyYj8qQdTdU84108fxqZo54=;
        b=Yd3kuGgMlhF/1mguYm4WJZQycQ0K463clzMDIoxS0E3AMR3sjIJFVkXkn/hZ3tkH0q
         aRVOMMYPh7VsF7XaLu9TTIxG/ppxma0D2OELUANB9cBTZ7X0PvdyPlwemdmISuvQ1GbX
         /aadxXK/yXKQS0hARjC5jQ1p4w9N/WK7Ug96R+f3TiX2OwTpdLL89gjMIcSXVRq/5JSm
         Aix1YFe/X+qs1nqhghySmTOdvp7I4S8ngKwXmli/RwV1ZLOFHFLAA/pf+EFQ0iAzDGoN
         +CqlyS8T9b8yGTrqgptkxdEn1wtCUYhwmgIFyYl+uWeeBKDdbZIcmEYnrDU3cgm3Xd0q
         Borg==
X-Forwarded-Encrypted: i=1; AJvYcCVq/nO9Q6HoFGGu0u/hAMMlBn90GFrtHraFWjuj5JVcs3FDfVpHkGH3YX9igrch9d+BECfw0Z5IOFarX287rp2p/mTwpMO17P4uEv1U
X-Gm-Message-State: AOJu0YzwVpt4FG9n1qvlYTvc1hWaogopVxgstpyJ8DQmh+w57K4nrfyX
	2xC2ZU2co1LM+sdOTq/RqQIxUNS1h+WJOtE8LjmqWWkRhLrwc++K72gF+v+BfhVDj32jJB9Czfm
	MLT/zxXWZYHw3UdiMnxB9+6RBk0o=
X-Google-Smtp-Source: AGHT+IEgv+VBtTzddHrTMKDE0PKfZUgzWlXW0fWbmGnKKrKIrcro7zKXBSaeiSu6H9JTeoRoecWJN2dQPIoSqyAc+Q0=
X-Received: by 2002:a67:f785:0:b0:476:302:d94d with SMTP id
 j5-20020a67f785000000b004760302d94dmr9710309vso.2.1710796875396; Mon, 18 Mar
 2024 14:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com>
 <20240318210917.GA4210@cmpxchg.org> <CAJD7tkZhCt_r1uULbfe4eg=zo7=o7muJ787wyEw1yN7x+ijYGA@mail.gmail.com>
In-Reply-To: <CAJD7tkZhCt_r1uULbfe4eg=zo7=o7muJ787wyEw1yN7x+ijYGA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 10:21:04 +1300
Message-ID: <CAGsJ_4zy14_hLxqkP=ka8AwLx1=H1MD4B-70G_+gp8SF_FOwHg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:19=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Mon, Mar 18, 2024 at 2:09=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Mon, Mar 18, 2024 at 01:17:19PM -0700, Yosry Ahmed wrote:
> > > On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com=
> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> > > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-1=
4-09-36' ..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043=
abe180000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb5=
7c23dffc38e
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983=
a1588b7805de3
> > > > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, =
GNU ld (GNU Binutils for Debian) 2.40
> > > > > userspace arch: arm
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D170=
6d231180000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba7=
959180000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-=
assets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff=
2/vmlinux-e5eb28f6.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/753944=
1b4add/zImage-e5eb28f6.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.co=
m
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at include/linux/scatterlist.h:187!
> > > >
> > > > Looks like the provided buffer is invalid:
> > > >
> > > > #ifdef CONFIG_DEBUG_SG
> > > > BUG_ON(!virt_addr_valid(buf));
> > > > #endif
> > > >
> > > > which is "src" from:
> > > >
> > > > sg_init_one(&input, src, entry->length);
> > > >
> > > > Looking at the surrounding code and recent history, there's this
> > > > commit that stands out:
> > > >
> > > > mm/zswap: remove the memcpy if acomp is not sleepable
> > > > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> > > >
> > > > which has the effect of, IIUC, using the zpool mapped memory direct=
ly
> > > > as src, instead of acomp_ctx->buffer (which was previously the case=
,
> > > > as zsmalloc was not sleepable).
> > > >
> > > > This might not necessarily be a bug with that commit itself, but mi=
ght
> > > > have revealed another bug elsewhere.
> > > >
> > > > Anyway, cc-ing the author, Barry Song, to fact check me :) Will tak=
e a
> > > > closer look later.
> > >
> > > I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=3Dy,
> > > and it seems like zs_map_object() may return a highmem address if the
> > > compressed object is entirely in a single page to avoid copying to a
> > > buffer:
> > >
> > > if (off + class->size <=3D PAGE_SIZE) {
> > >    /* this object is contained entirely within a page */
> > >    area->vm_addr =3D kmap_atomic(page);
> > >    ret =3D area->vm_addr + off;
> > >    goto out;
> > > }
> > >
> > > The virt_addr_valid() check seems to indicate that we expect a direct
> > > map address in sg_init_one(), right?
> >
> > If the page is highmem, kmap_atomic() establishes a temporary mapping
> > to it in the direct map, such that we have a legit kernel pointer to
> > the memory. Otherwise the memcpy() in zswap also wouldn't work... Am I
> > missing something?
>
> IIUC kmap_atomic() establishes a mapping in the kernel portion of the
> address space, but not a direct map mapping (i.e. not a linear
> mapping), right?
>
> Does virt_addr_valid() check for addresses being in the kernel portion
> of the address space, or it being a linear mapping? I thought it
> checks for the latter.

the latter, right.

>

