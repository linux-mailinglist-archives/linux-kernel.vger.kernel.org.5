Return-Path: <linux-kernel+bounces-106682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA1887F1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4011C214A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959485821B;
	Mon, 18 Mar 2024 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5OchTer"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4B5811A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796557; cv=none; b=ndHC7ShP4Vw64ksB5R6McN6HA/7wfZzI/XC+j8Sh2kdLAPSACKCAB3IocxaGHuc18oDw2jigmaBqlbMTWzRDIzsu2fhQJ4VyjFUtpy2hEJxqUI9JxFfWEt3SjcGe6WL1eerb6TXmngFTUnyGj6uLttCEENcKCjQLuWVmEtuM56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796557; c=relaxed/simple;
	bh=WmYHSx4FqfX4IilaWmjP4lO8uM63Tc0g42D4oYpEoOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpwhHvxq0sw4/V70q3hM9eB5WYnq3Fh9uH42hLco/UZ85DEBK0hogkJ15JLJqt//cIGO9eu3PLVIjcuWwari65QFGZTWYe+lGw6U8PcOJPDLsHUrQbwjlqtccHnDUkBq4YJrtBgSrzvaAj7XuxoR0Kowm7eAzckmB7MflAUpvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5OchTer; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d523586a59so68595e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796555; x=1711401355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNvrtsGjVTtu6R10uTVM8kPeIVOJpDjIQh7MdUQaOu8=;
        b=c5OchTerkAopYuqt3WJ+EOArxDQDVMtqfKW7g49d/wMlz0yYjHaIvzGqkulte9CZjO
         dnpOLekNWNXwcSY0FYiAuwpiSr2SVYuoBIF/t5p7lnJyV1kFegLALp8i5J64NhXIg6Fd
         g+lilB5ugi1i32JmCuwn/U9D8r+IRktjKfJ3gQVZXrXo4V5fexo9SnARQ3GI2a4HeYbK
         V7MzymJZwAGIPr6AeaavFidA+wdKUf7Z7nWE1u71+gWLXjWvfO1Bn3AwIVXIVZl85Idi
         c2XGfP7bJB2gNe1+nkvrZiqumMZ+4bXrMIsIXZoXq1jpbZaHt36gZ/zkfpMAFgNy6Hcq
         qU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796555; x=1711401355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNvrtsGjVTtu6R10uTVM8kPeIVOJpDjIQh7MdUQaOu8=;
        b=mghTv1hpC8cQBsx6F7Jr64I/Fi0qo/fDEDcUYxEEEhsUX9ucX/rEchYalg0/kJVJic
         uX/eDVLwoFJhKi08Y1aQZD1rydmi1tsSmVzB99ecSSVMUPT0bPrA00yBrjLBEso52i+W
         q55Nuyo6+po/21CAPwbFJsRME2o1KN3r9Q8HWK3D79otIjWKgEKnPzi1TiKHEABCXIe8
         08qb1+ObA1Qf/Nwig9wVeTfPdfHzRI/CHzcRUpGkHsACy6L+kuZ1Xt6fH9CdUWuiBjqK
         Ilujw3y/KiYBiLG54jawC4GrqLO9KmU3q/2TQOo774RLKvvoIASoAuqSOME4dok5DUqA
         fqKA==
X-Forwarded-Encrypted: i=1; AJvYcCUPflbGz+uW4JV/GKMb+7502LlM+xGpk3ZKi2UG1P5YGPHNg2o6GDbM5ogNS0EdinRsey5sHBJscUnFlZddSvDv4OSALROWmz11eRbH
X-Gm-Message-State: AOJu0Yzf6Y3F8dRG1pebLAX27YYxdOl1kotKpLgmrUUoKqCOvBLSbEqu
	nfGLKbpqRcIVearOAZWpSJFp0iIY8w+rCtu0xP653lOLhycqEHVuWmL8dim7WzeBnTX6JK8ItPa
	R9tXyqGpnydV9bNRqwQzSsoe7pKA=
X-Google-Smtp-Source: AGHT+IFmYQMKApHO/ktNoo3RDcDuEbq/bJLEEAHMN6ZUPVI+ASpbKfIxUcIaLVFgE8DmvO37qMZVP5Kn4XFr2z0cA0M=
X-Received: by 2002:a1f:7dcf:0:b0:4d3:4aad:22d4 with SMTP id
 y198-20020a1f7dcf000000b004d34aad22d4mr8349994vkc.0.1710796555068; Mon, 18
 Mar 2024 14:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com> <20240318210917.GA4210@cmpxchg.org>
In-Reply-To: <20240318210917.GA4210@cmpxchg.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 10:15:43 +1300
Message-ID: <CAGsJ_4wEjgAscao4BiLbNFChfF7aTpFFdXXozWC45_j+vADdPw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:10=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Mar 18, 2024 at 01:17:19PM -0700, Yosry Ahmed wrote:
> > On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-=
09-36' ..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043ab=
e180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c=
23dffc38e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1=
588b7805de3
> > > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GN=
U ld (GNU Binutils for Debian) 2.40
> > > > userspace arch: arm
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d=
231180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba795=
9180000
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/=
vmlinux-e5eb28f6.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b=
4add/zImage-e5eb28f6.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > kernel BUG at include/linux/scatterlist.h:187!
> > >
> > > Looks like the provided buffer is invalid:
> > >
> > > #ifdef CONFIG_DEBUG_SG
> > > BUG_ON(!virt_addr_valid(buf));
> > > #endif
> > >
> > > which is "src" from:
> > >
> > > sg_init_one(&input, src, entry->length);
> > >
> > > Looking at the surrounding code and recent history, there's this
> > > commit that stands out:
> > >
> > > mm/zswap: remove the memcpy if acomp is not sleepable
> > > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> > >
> > > which has the effect of, IIUC, using the zpool mapped memory directly
> > > as src, instead of acomp_ctx->buffer (which was previously the case,
> > > as zsmalloc was not sleepable).
> > >
> > > This might not necessarily be a bug with that commit itself, but migh=
t
> > > have revealed another bug elsewhere.
> > >
> > > Anyway, cc-ing the author, Barry Song, to fact check me :) Will take =
a
> > > closer look later.
> >
> > I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=3Dy,
> > and it seems like zs_map_object() may return a highmem address if the
> > compressed object is entirely in a single page to avoid copying to a
> > buffer:
> >
> > if (off + class->size <=3D PAGE_SIZE) {
> >    /* this object is contained entirely within a page */
> >    area->vm_addr =3D kmap_atomic(page);
> >    ret =3D area->vm_addr + off;
> >    goto out;
> > }
> >
> > The virt_addr_valid() check seems to indicate that we expect a direct
> > map address in sg_init_one(), right?
>
> If the page is highmem, kmap_atomic() establishes a temporary mapping
> to it in the direct map, such that we have a legit kernel pointer to
> the memory. Otherwise the memcpy() in zswap also wouldn't work... Am I
> missing something?

Right, we built a map but it is not a linear mapping. so we can't use
virt_to_page
on this kind of non-linear mapping.
kmap_to_page can handle both linear and non-linear, but  Ira's commit
added a WARN_ON_ONCE in it for non-linear mapping case.

