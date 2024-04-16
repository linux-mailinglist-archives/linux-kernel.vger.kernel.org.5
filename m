Return-Path: <linux-kernel+bounces-147751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBE8A7896
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DCF1F22B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9913A889;
	Tue, 16 Apr 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma53oj7G"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5F6EB44
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310193; cv=none; b=iOr6JTF2GKgIG3OlTEvB3vEOsStBbY+V0+1EfBLQSYDxt/KgKKieUIjp6lHfOXWdnpfZtUx+5UYxzC0zz9d9quJk7OSWPmEsPLFGnAgmmNHO37HKnnWy9guYK4065nlQFV5MNw28WsskY5zhctyWuYmRzkUSAqheTj3R67y1FVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310193; c=relaxed/simple;
	bh=y15kkh/UzNlt8PyzGY6czdnu89oxFroFanLzwhfD0N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHh4DEXpn5VujyecKxbNH7ZQT/+NkscXCCvXQGczllOt8LK5vQNE589vvupjt6kNu4Bzd2nd5ubu339xngy872NkQJY3fZaEmFvMFexNLBou93zgR10dwVENtlkL/rgha/LXlaICkazuG1m/g0WzaMgmlc4Nl+6y/2EcXDRO8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma53oj7G; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6969388c36fso22917606d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713310191; x=1713914991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLy1Ua1b77r4qsxuukriMKLfQ+NQtqpcoJqaT5UdrRA=;
        b=ma53oj7GQt0ugRc59D4dVHzcSavxwmJ5qa2S+hmTqwJ4YJ5b62kGz5Moxe2uckKcr+
         Zf5JL4IjTyuNVTF3rAQ+wOtAaJQJUIn6mQUXksv1f05fyjNFQ6OB+cyE+ffQwE+TtYmn
         zQJe3lzjjDyF2pHmLYiNBIcOUDJjEDDUgLfu0zwmqEFfhbzOLVQMioBlmXOtsyia2Iou
         9BHaOEfioH7LEv+bYTb1riz5L3q53rTrf7t9Dfu6VXYCdFrIO2kxAxtGqnBPbHz2BajT
         oHXPE3EcWRaELRvcq+o2yHof5O9L5XbaO/zNE46TP/eInochbcqsmyD3PgkyUbf1ppS+
         l0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713310191; x=1713914991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLy1Ua1b77r4qsxuukriMKLfQ+NQtqpcoJqaT5UdrRA=;
        b=ShJ8+AamT8fO1MABma/yGQLEBZg/xwsPx2EP0XBWJOGJB81dE1PcNEyiFsHooIGnd2
         icSolhw2wZSnyAHDQHW8e0yIKo85UWXyCf0CAGNi8T7iYqYUqHH1/cRdZLnW7ia/4l8G
         0QPVMK6SWGyaKS0RkyKuqIagNv3tNYmQV2hecQ+s2YBls4eYTXnUTIOTogzR06Le1MvN
         Qh98/8cr7Gp70aYu09RL6fk4e6WEwAzwZpXfzJjwQ/Aj/qX1FO0DmLX8wI/pcx2bweSH
         6VitwAYdD6DswUyMsq7hxgHAgMIPsy6mA9XCapFfBYjCS+m/QdSZF0QH48/Je0bZE1uE
         Uxhg==
X-Forwarded-Encrypted: i=1; AJvYcCWLXZXDnYBZIp17iE4S1sLwmvnI7dSGZJvKOFZdRdytyWXXB2nTmeRgSI+ndDDgHgthVRYzXSP1FVaPagE0Byf8DYFlyLXP6CKs1pgq
X-Gm-Message-State: AOJu0Ywg08c7+NDqBC4aRKuywEUIdnJySQ7G9gMQbv7fHWejGuu2JwTR
	LJdmfDzqqq1b5d1xNwywuvh/uh2od2UPxndUjVIlkRy21mecOe2T0yBAAW6v8dkMqKi3shs8fGq
	Fb7J1W6liegfetrkIA2FAWGfFqDg=
X-Google-Smtp-Source: AGHT+IF+EtI1xd1QjYng9Ds05N6w9StWVfIdI1Sei5Hyuup1KvXrmFZUzese74UopTTaLAlxrHD/vxCIeP/TAVL0fGI=
X-Received: by 2002:a0c:ea33:0:b0:69b:7c1e:ac02 with SMTP id
 t19-20020a0cea33000000b0069b7c1eac02mr6282293qvp.18.1713310191203; Tue, 16
 Apr 2024 16:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2> <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
In-Reply-To: <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 16 Apr 2024 16:29:39 -0700
Message-ID: <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
To: Christian Heusel <christian@heusel.eu>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>, 
	"Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>, regressions@lists.linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Apr 16, 2024 at 5:19=E2=80=AFAM Christian Heusel <christian@heuse=
l.eu> wrote:
> >
> > Hello everyone,
>
> Thanks for the report, Christian! Looking at it now.
>
> >
> > while rebuilding a few packages in Arch Linux we have recently come
> > across a regression in the linux kernel which was made visible by a tes=
t
> > failure in libguestfs[0], where the booted kernel showed a Call Trace
> > like the following one:
> >
> > [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-m=
ainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
>
> Is this one of the kernel versions that was broken? That looks a bit
> odd, as zswap shrinker landed on 6.8...

Ah ignore this - I understand the versioning now...

>
> > [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 Arch Linux 1.16.3-1-1 04/01/2014^M
> > [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
> > [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90=
 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00=
 <48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
> > [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
> > [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 0000000=
000000002^M
> > [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 0000000=
000000000^M
> > [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 0000000=
000000000^M
> > [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff976=
6ffffe780^M
> > [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff976=
682204d80^M
> > [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) kn=
lGS:0000000000000000^M
> > [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> > [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 0000000=
000750ef0^M
> > [  218.743494] PKRU: 55555554^M
> > [  218.743593] Call Trace:^M
> > [  218.743733]  <TASK>^M
> > [  218.743847]  ? __die+0x23/0x70^M
> > [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
> > [  218.744056]  ? free_unref_page+0xf6/0x180^M
> > [  218.744458]  ? exc_page_fault+0x7f/0x180^M
> > [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
> > [  218.744684]  ? memcg_page_state+0x9/0x30^M
> > [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
> > [  218.744896]  do_shrink_slab+0x3a/0x360^M
> > [  218.744990]  shrink_slab+0xc7/0x3c0^M
> > [  218.745609]  drop_slab+0x85/0x140^M
> > [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
> > [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
> > [  218.745912]  vfs_write+0x23d/0x400^M
> > [  218.745998]  ksys_write+0x6f/0xf0^M
> > [  218.746080]  do_syscall_64+0x64/0xe0^M
> > [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
> > [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
> >
> > The regression is present in the mainline kernel and also was
> > independently reported to the redhat bugtracker[1].
> >
> > I have bisected (see log[2]) the regression between v6.9-rc4 and v6.6
> > and have landed on the following results (removed unrelated test commit=
)
> > as remainders since some of the commits were not buildable for me:
> > - 7108cc3f765c ("mm: memcg: add per-memcg zswap writeback stat")
> > - a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > - b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")

Hmmm, this smells like a memcg reference counting bug to me. The memcg
was successfully accessed just a couple of LoCs above, but failed
after the stats flushing.

My suspicion right now is the new memcg refcnt dance to select an
memcg for the global, capacity-based, shrinker, introduced in this
patch series. That dance looks solid to me tho - not sure where it
goes wrong. And, if it's a reference counting issue, that should pop
up in different places (i.e other mysterious memcg traces)...

