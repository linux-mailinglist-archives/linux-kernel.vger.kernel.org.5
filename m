Return-Path: <linux-kernel+bounces-109840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262FF885659
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880C32828A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED104E1D5;
	Thu, 21 Mar 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+VAzNbE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D30446DC;
	Thu, 21 Mar 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012949; cv=none; b=VcJOKCcXHtOyYWraAs3pR3VrPaFcylzmTC8MWjPrrfl6UQYyD0xmSYAixagow6RmtPtL4rP5WTRYTHl8HKANmUNjN2AZ7KYoa8rZqjLdcx3EVQ+DhSuflAbcze1zp33wLnaQ8fzGpQ2GSfLD/gQRbEnU+IlX0yjSRUDVOsl/cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012949; c=relaxed/simple;
	bh=UeP78wcePkB4Mdcub1yYcZ92w8+JN0YhyH/xS6fOg38=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=IFEgPid+lMuYbY6YrOR/OxBs+0H6i7Ax56o124ljhVwCeROs/dw49HOkFyc8x/N/ig/ZeXz+DcC2rCLVQjcJ3BJoNVGU9IHH5s7VGx72R99iGP0BmcpKUbvYJ5xxatp5eSIDpq1bsR7PLkGR/B6VRt5HG82uUYlKhzaZjusoybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+VAzNbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F34C433F1;
	Thu, 21 Mar 2024 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711012949;
	bh=UeP78wcePkB4Mdcub1yYcZ92w8+JN0YhyH/xS6fOg38=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=K+VAzNbEGS0PF+tB82MlrkdIMhVpzfiqu8KEAXGCDcjJ1x1C15CL3ifaOwEo8JaF9
	 qfTYb4eqVtGS68e2wbEwbm7DHyc/yHNTq7Wb9vKwQs130LnwOinQBqkwgvsnHRPMyj
	 tkoJKKD+bOrCnvt6rRxhvWfFPrBmZpgdoKgMp5FhRVDgO8apkO+gX2Y916KoA2Nj+v
	 Ksq1tutl4Ldb2704vq1ztB6bSWnBaqzfCGe68uOAcqbC+VvoRDI4zts+7dquZ6hpdI
	 RpCohGrSkyeUI1IJSyiPfi/qznEvoCNWYVCmL2/8+LvVNlS9+v3Pfxqli2bPMsIZ3/
	 W4I+XTLqnC8qw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANn89iKnOzz_Bs_ygLWZGjsTw=266p8KALv=QWheTanoHYj+nw@mail.gmail.com>
References: <0000000000009485160613eda067@google.com> <CANn89iKnOzz_Bs_ygLWZGjsTw=266p8KALv=QWheTanoHYj+nw@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in register_nexthop_notifier (3)
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
To: Eric Dumazet <edumazet@google.com>, syzbot <syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com>
Date: Thu, 21 Mar 2024 10:22:25 +0100
Message-ID: <171101294595.5492.6904692183666798713@kwain>

Quoting Eric Dumazet (2024-03-18 15:46:37)
> On Mon, Mar 18, 2024 at 12:26=E2=80=AFPM syzbot
> <syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com> wrote:
> >
> > INFO: task syz-executor.3:6975 blocked for more than 143 seconds.
> >       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:syz-executor.3  state:D stack:20920 pid:6975  tgid:6975  ppid:1   =
   flags:0x00004006
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5400 [inline]
> >  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
> >  __schedule_loop kernel/sched/core.c:6802 [inline]
> >  schedule+0x149/0x260 kernel/sched/core.c:6817
> >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
> >  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> >  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
> >  register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3863
> >  nsim_fib_create+0x8a6/0xa70 drivers/net/netdevsim/fib.c:1587
> >  nsim_drv_probe+0x747/0xb80 drivers/net/netdevsim/dev.c:1582
> >  really_probe+0x29e/0xc50 drivers/base/dd.c:658
> >  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
> >  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
> >  __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
> >  bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
> >  __device_attach+0x333/0x520 drivers/base/dd.c:1030
> >  bus_probe_device+0x189/0x260 drivers/base/bus.c:532
> >  device_add+0x8ff/0xca0 drivers/base/core.c:3639
> >  nsim_bus_dev_new drivers/net/netdevsim/bus.c:442 [inline]
> >  new_device_store+0x3f2/0x890 drivers/net/netdevsim/bus.c:173
> >  kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
>=20
> So we have a sysfs handler ultimately calling register_nexthop_notifier()=
 or any
> other network control path requiring RTNL.
>=20
> Note that we have rtnl_trylock() for a reason...

Mentioning the below in case that gives some ideas; feel free to
disregard.

When I looked at similar issues a while ago the rtnl deadlock actually
happened with the kernfs_node refcount; haven't looked at this one in
details though. The mutex in there was just preventing concurrent
writers.

> Or maybe the reason is wrong, if we could change kernfs_fop_write_iter()
> to no longer hold a mutex...

At the time I found a way to safely drop the refcount of those
kernfs_node which then allowed to call rtnl_lock from sysfs handlers,
https://lore.kernel.org/all/20231018154804.420823-1-atenart@kernel.org/T/

Note that this relied on how net device are unregistered (calling
device_del under rtnl and later waiting for refs on the netdev to drop
outside of the lock; and a few other things), so extra modifications
would be needed to generalize the approach. Also it's a tradeoff between
fixing those deadlocks without rtnl_trylock and maintaining a quite
complex logic...

Antoine

