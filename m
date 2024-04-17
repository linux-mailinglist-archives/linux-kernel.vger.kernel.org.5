Return-Path: <linux-kernel+bounces-147799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A38A79CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645F21F21F94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A664C;
	Wed, 17 Apr 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEr3pz7H"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA11196
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313377; cv=none; b=n5iwgOjt9oAG5EszFkMYvVSclvFuL/edS9Rs3trPS4EL8JAZ1VzLAlVn9FOzUIPqv7P5/PyDVc48i4CQdoLIyKBFrpMiVFM5fEuctKW04mT6Hy7v3DqKSnqtYKq1BZGOKO+96uYwRhJQu2Mpm0ASZFylUiu4YZJ1QX2GVc9mODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313377; c=relaxed/simple;
	bh=2YsrEfUcLkTb+yR2Bg5aBj4KZxNF8BwqywMdL4lt7xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obrdBsVftSG38DHQY8zofqPMB59dEcVExkX2QahchyZNrEmcgh1NgNaCPGlry8rRilbb/EUZ3Brw7DJckDhABoyPeSRW2Th2vjb7++aUaFlV9miWgu3Ziidtv/xTxoVyAXH0HAs4oXaMZR3/UgcJZhmZkLbpIhD8nLiXyus+SEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEr3pz7H; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa17c29ba0so2937499eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713313375; x=1713918175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP26FrywztgVkfzE2tfyTzU9hcB6QnE7fDvry2nRPDE=;
        b=jEr3pz7HGQQFII4fnHMtxQl3O2qxnbw2LgfEgkFR0T5kgjBIJ+kYTD47vm+K5qcJJ7
         TrCj4N1KoHQVfJgNvvc1eYv/oykGsbC59x46Hajl+L4PBHtgJFMqsWVs0allapTUxDA2
         VNWlVs8uEwT0gW1oiWS/c5dhEgEoC7qADx2j5b6SxHkQg0j5a5ntZrtU7gnHfrgA+qs7
         5O1gyp6+kGz2oSHYJTBRVoGZ56t0yRMGDCv1IlPszF4bFxYQjNCEAXuiPVBkhqwuGn6T
         ctDlyGLNWXlPY/OGRHQnVywq00gqBsLUUiaeBqAGM/wrJOWx4KoQmJpiEJ37uc+h+lIw
         BlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313375; x=1713918175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP26FrywztgVkfzE2tfyTzU9hcB6QnE7fDvry2nRPDE=;
        b=QuU7aFOjgMrtPfkZ6fgrdCfFCp7MRiKs8oPTW1wzt24fkG0Qh5uf/os1OFNeADoE4s
         Z7VQwd7BXaiBJmem/pMMbI/htkqlvN3Ae/ohgWBcIKu0Edb4yKHIpjD0YD0T47JyQDD5
         hbk/ksKN+3TXPDma0qnAYZ0xpLzG6OCOGgfe5I5udMY2gWMXhgJ/23Fh9fvm8RBaBq0v
         z3OyNQf7LGk/KdPYTlBBDYgjHskE0yykg9Njld8TVZ+pknLY+3sNoGzsGnzHgOjpODKm
         KpVWKiRYgZ+Yu3xSy5Cn0dYJM1GXsfblExVbM7foMvb3s31dcKB9gGbMbJbDtT12LlqM
         hF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVyWXnbxDYD3tGUELrBc60SQWPmUX2tHTJpry5buo6eE1HiHTzFAOBnfhPq+6CgnvxCwhBjlj0YyFNu1T07ofWZZhKyFSepVDKAmZW2
X-Gm-Message-State: AOJu0Ywjan3+cv0WtuUiPu4y/ohSV/TLNRciM8KDkgckIGeGrSw72KyH
	4WJMwrEwo/EE3PmQOJPv2DK95WiH/pe+US/OZ4c8VdPBcFlAX+TYKBZwnIPlogups+lS/4kXVKG
	XXJ5DjsPk/jXVIbaG3Qf+FtSxA5s=
X-Google-Smtp-Source: AGHT+IFn4iXE20yPNxhNmTGeEwmEqivQnTCqqF+lbczSroqVrG41U3nbTCfc9BmBjSQtefmnE+r4+EIVmpDdOA47A9k=
X-Received: by 2002:a05:6358:690d:b0:17f:5797:b0ee with SMTP id
 d13-20020a056358690d00b0017f5797b0eemr18856500rwh.10.1713313374643; Tue, 16
 Apr 2024 17:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com> <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
In-Reply-To: <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 16 Apr 2024 17:22:43 -0700
Message-ID: <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
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

On Tue, Apr 16, 2024 at 4:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Apr 16, 2024 at 3:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Tue, Apr 16, 2024 at 5:19=E2=80=AFAM Christian Heusel <christian@heu=
sel.eu> wrote:
> > >
> > > Hello everyone,
> >
> > Thanks for the report, Christian! Looking at it now.
> >
> > >
> > > while rebuilding a few packages in Arch Linux we have recently come
> > > across a regression in the linux kernel which was made visible by a t=
est
> > > failure in libguestfs[0], where the booted kernel showed a Call Trace
> > > like the following one:
> > >
> > > [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1=
-mainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
> >
> > Is this one of the kernel versions that was broken? That looks a bit
> > odd, as zswap shrinker landed on 6.8...
>
> Ah ignore this - I understand the versioning now...
>
> >
> > > [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS Arch Linux 1.16.3-1-1 04/01/2014^M
> > > [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
> > > [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 =
00 <48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
> > > [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
> > > [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 00000=
00000000002^M
> > > [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 00000=
00000000000^M
> > > [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 00000=
00000000000^M
> > > [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9=
766ffffe780^M
> > > [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff9=
76682204d80^M
> > > [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) =
knlGS:0000000000000000^M
> > > [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> > > [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 00000=
00000750ef0^M
> > > [  218.743494] PKRU: 55555554^M
> > > [  218.743593] Call Trace:^M
> > > [  218.743733]  <TASK>^M
> > > [  218.743847]  ? __die+0x23/0x70^M
> > > [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
> > > [  218.744056]  ? free_unref_page+0xf6/0x180^M
> > > [  218.744458]  ? exc_page_fault+0x7f/0x180^M
> > > [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
> > > [  218.744684]  ? memcg_page_state+0x9/0x30^M
> > > [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
> > > [  218.744896]  do_shrink_slab+0x3a/0x360^M
> > > [  218.744990]  shrink_slab+0xc7/0x3c0^M
> > > [  218.745609]  drop_slab+0x85/0x140^M
> > > [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
> > > [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
> > > [  218.745912]  vfs_write+0x23d/0x400^M
> > > [  218.745998]  ksys_write+0x6f/0xf0^M
> > > [  218.746080]  do_syscall_64+0x64/0xe0^M
> > > [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
> > > [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
> > >

Actually, inspecting the code a bit more - can memcg be null here?

Specifically, if mem_cgroup_disabled() is true, can we see null memcg
here? Looks like in this case, mem_cgroup_iter() can return null, and
the first iteration of drop_slab_node() can have null memcg if it's
returned by mem_cgroup_iter().

shrink_slab() will still proceed and call do_shrink_slab() if the
memcg is null - provided that mem_cgroup_disabled() holds:

if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
      return shrink_slab_memcg(gfp_mask, nid, memcg, priority);

Inside zswap_shrink_count(), all the memcg accessors in this area seem
to always check for null memcg (mem_cgroup_lruvec,
mem_cgroup_zswap_writeback_enabled), *except* memcg_page_state, which
is the one line that fail.

If this is all to it, we can simply add a null check or
mem_cgroup_disabled() check here, and use pool stats instead?

