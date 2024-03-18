Return-Path: <linux-kernel+bounces-106713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E887F251
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9094B21752
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602845A4CD;
	Mon, 18 Mar 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+bet1t7"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6245A113
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797866; cv=none; b=C5KJ4QRVpStCs8jksDfgUkUq1S7R9hfo4J60pRYgC4vM4cGLLY1bg9rtRfVyMGCSQxcCtgQebAfbSxu1Jk3VVELhDw3/AjWTpxFD0gALKkmakkkmTK7ztFngVKM1B1+hxYd0laGQ3AIXVq3VWGkPSu0vz6+P6QBUGNHclRLm4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797866; c=relaxed/simple;
	bh=IVgx0pQqjlV7lIuVPFnMP2wogzuZvwN0h2VRIIOy15E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nS++fcx0vZR03tJbgPt/t+chSQ687Vv7z7wtDbOyHZr4uVJ8m5AQCeOoomVEP5F6LhJi9RbC93FrrK18/i+ZlLjw7xyAyGgP/EFFEeQdOorrw7pzxJZM+lQjTOpedcfnyAk8WBk1vqwNqzlQ2k8DHT8mHUopHQJRHb1436Yd5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+bet1t7; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d43df40579so667561e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710797864; x=1711402664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISfCadt2VgNt6/h3A04UiF5MTEGK7Lrl50I2y0DXkrU=;
        b=B+bet1t7xL4fqWDhhyPGsln4T0sjWfgw1fla2kmD2gwoD0uTijpZRVS9Jq5j4+XGl3
         2+QuXl25+H3HMU3YWuc16xi5JbTlzWdQTvCMmXcPWKvngLiti2+CeKDBVjiuhqd8v7Xo
         26zLbSxbZoF+eGCT9ZejuK/o+AR7LExyv1lcD8DtCsrP/mdUIIHTAjf4h689Sj2zXcEA
         rMZN2lX3Lv2dRRQ+2nLK3Zo5Hdad/u658hZimuNfwIYZFoENLjoO/Jzlh5+7XCicZJKK
         aCZw6BOwDB51xWTet0iLkEA+zIwac+7ujMGdJmPbPcdLjeQ1YyDP+ruzcw9oamk7BMRa
         qKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797864; x=1711402664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISfCadt2VgNt6/h3A04UiF5MTEGK7Lrl50I2y0DXkrU=;
        b=qtiP8OtCkGpoCFlTJWmxvB4mTzO4SG6ffiaq6dI2rku619bRHn2KV6QAdd27lynJU+
         QI8qtoBuCU8BJOYZkzW9tvt/t2l3YdPcPDmxR9fggT69WakraTaFm2oAjtXktCdBMVLw
         MlzVwP8Um0XZhXhtckokYoeQdpB12KpH9ny+FbSVU4BreRAeBsZayojZOnzKctxczUWY
         ST0nLogrsQAv/90vZ8rZu3lNzRahzj58YAvtWa5gqNjCauHxrcRMGCua4UnBFImw7ZDt
         B9OOrEUSmoB9g5Lz63+Zjb5UChB3+yXPGvrZAyIPs7ah9Du6Igx6bwO19Mx1PfFsRiaB
         sMWw==
X-Forwarded-Encrypted: i=1; AJvYcCX+woIkoPb6HpDmyz396p5j5Pqk0xtR6ERHK7eeyvMygwdHlHBNegntyrQyBW3mgTA1NnuEoXgd1uLFnKDwveydomt51gLmgL3RFDuP
X-Gm-Message-State: AOJu0YylQ6xX5ghqz9ar4o5TZGWsNPTFQ2/z0mB2gyf2CBvxb79Uncuv
	g95dFopqMvoyRc8uQt1u6FYHYY4vjo+FUZunMEROoMxi5/6B1G5NMEkf+Dk77uIJUNCUzNSmddY
	0mwLPx+zx7QY+3+YTfLxx7RUD/1c=
X-Google-Smtp-Source: AGHT+IHVV+/P3FdLgHRN+PA5jA0FdCHz88S9BLXeFMBXLcJyCCwZCcVjA4rK5rWQARJf1YBUg6qAI8+atuOMy3WNLz4=
X-Received: by 2002:a1f:f446:0:b0:4c8:ee1:5a0b with SMTP id
 s67-20020a1ff446000000b004c80ee15a0bmr9876864vkh.15.1710797863691; Mon, 18
 Mar 2024 14:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com>
 <20240318210917.GA4210@cmpxchg.org> <CAGsJ_4wEjgAscao4BiLbNFChfF7aTpFFdXXozWC45_j+vADdPw@mail.gmail.com>
 <20240318213257.GB4210@cmpxchg.org>
In-Reply-To: <20240318213257.GB4210@cmpxchg.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 10:37:32 +1300
Message-ID: <CAGsJ_4xTx_FRCrh0KQ4dGAyHisWaK9kUa5UPETWcLnqPwxPkkg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:33=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Mar 19, 2024 at 10:15:43AM +1300, Barry Song wrote:
> > On Tue, Mar 19, 2024 at 10:10=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 01:17:19PM -0700, Yosry Ahmed wrote:
> > > > On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.c=
om> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> > > > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03=
-14-09-36' ..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D130=
43abe180000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19b=
b57c23dffc38e
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc9=
83a1588b7805de3
> > > > > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0=
, GNU ld (GNU Binutils for Debian) 2.40
> > > > > > userspace arch: arm
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1=
706d231180000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13b=
a7959180000
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image (non-bootable): https://storage.googleapis.com/syzbo=
t-assets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63=
ff2/vmlinux-e5eb28f6.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/7539=
441b4add/zImage-e5eb28f6.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.=
com
> > > > > >
> > > > > > ------------[ cut here ]------------
> > > > > > kernel BUG at include/linux/scatterlist.h:187!
> > > > >
> > > > > Looks like the provided buffer is invalid:
> > > > >
> > > > > #ifdef CONFIG_DEBUG_SG
> > > > > BUG_ON(!virt_addr_valid(buf));
> > > > > #endif
> > > > >
> > > > > which is "src" from:
> > > > >
> > > > > sg_init_one(&input, src, entry->length);
> > > > >
> > > > > Looking at the surrounding code and recent history, there's this
> > > > > commit that stands out:
> > > > >
> > > > > mm/zswap: remove the memcpy if acomp is not sleepable
> > > > > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> > > > >
> > > > > which has the effect of, IIUC, using the zpool mapped memory dire=
ctly
> > > > > as src, instead of acomp_ctx->buffer (which was previously the ca=
se,
> > > > > as zsmalloc was not sleepable).
> > > > >
> > > > > This might not necessarily be a bug with that commit itself, but =
might
> > > > > have revealed another bug elsewhere.
> > > > >
> > > > > Anyway, cc-ing the author, Barry Song, to fact check me :) Will t=
ake a
> > > > > closer look later.
> > > >
> > > > I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=3D=
y,
> > > > and it seems like zs_map_object() may return a highmem address if t=
he
> > > > compressed object is entirely in a single page to avoid copying to =
a
> > > > buffer:
> > > >
> > > > if (off + class->size <=3D PAGE_SIZE) {
> > > >    /* this object is contained entirely within a page */
> > > >    area->vm_addr =3D kmap_atomic(page);
> > > >    ret =3D area->vm_addr + off;
> > > >    goto out;
> > > > }
> > > >
> > > > The virt_addr_valid() check seems to indicate that we expect a dire=
ct
> > > > map address in sg_init_one(), right?
> > >
> > > If the page is highmem, kmap_atomic() establishes a temporary mapping
> > > to it in the direct map, such that we have a legit kernel pointer to
> > > the memory. Otherwise the memcpy() in zswap also wouldn't work... Am =
I
> > > missing something?
> >
> > Right, we built a map but it is not a linear mapping. so we can't use
> > virt_to_page
> > on this kind of non-linear mapping.
> > kmap_to_page can handle both linear and non-linear, but  Ira's commit
> > added a WARN_ON_ONCE in it for non-linear mapping case.
>
> Ah, I misread what virt_addr_valid() does. It actually excludes
> kmap. Which, yes, makes sense, if the next line does virt_to_page()...
>
> Sorry about the noise.

no worries. I just wonder why Ira's commit ef6e06b2ef870 has added a
WARN_ON_ONCE
in kmap_to_page() given we still have many users :-)

drivers/fpga/fpga-mgr.c:                        pages[index] =3D
kmap_to_page((void *)p);
drivers/spi/spi.c:                              vm_page =3D kmap_to_page(bu=
f);
drivers/vfio/pci/pds/lm.c:                      pages[i] =3D
kmap_to_page((void *)p);
fs/erofs/data.c:                        .page =3D kmap_to_page(ptr),
fs/smb/server/transport_rdma.c:                 page =3D kmap_to_page(buf);
net/9p/trans_virtio.c:                          (*pages)[index] =3D
kmap_to_page(p);

