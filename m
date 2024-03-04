Return-Path: <linux-kernel+bounces-90046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F786F948
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E2B281314
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CCB6ABF;
	Mon,  4 Mar 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI08V3/8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265517C8;
	Mon,  4 Mar 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527346; cv=none; b=j+Vq99yuMRX3euv5IGxKBddf7LmervWJGD6SIZQv1G+8UXt+F3fiOHs5+1+mEpOnO49KvBSSa1aUNfJpcWSi2fbCT0eEkT6+7zPmunCtb5a6cRHzEDWrPvbzS010//C6Wj3xRIY1gDgJGDVjp989ukBu8ypmGTceHtJaB0YKIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527346; c=relaxed/simple;
	bh=b9PGM8FqCwlg8sxVp44vM/ykXAQzOJufl+9en8YQ3ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK64qLYzKCOavO36zFA8be3cvztq+onFqAHXyBKupw84EbOd6xZdgp7x2YySKuekWr4C0zIrMBXpXuyfsw+fV0wIgKvsAKv689pDeCXxXsPY6IYxqanSeGcRrKmN/cLdLLzl+sizlZicgBONyDkKbSPbgkiwXX1y6d2c2PUdiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI08V3/8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so600774766b.2;
        Sun, 03 Mar 2024 20:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709527343; x=1710132143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgCb7iXd8J0BRB0u/H3HN+uMdSTfhHTZg+YKFQ7z3Hs=;
        b=UI08V3/8yjZqp5MAjce+fF3B+X9Y+aHuBNjME0vvVMD0O35t+po8f4JjI1nC3cqXwt
         vOlIGnJt+Np9PUd1S1wzLwLy9l6nAeIOWvRtBB/4jJdOFYNxvCgNCE0GWxHtTw+9rQXX
         Zm37MBnn9z4xLfA/87j0i+Ve/0nuTgIxfNQK0Kbq49EJkqUOjJnaxfKD1tGa42BDFPbt
         xrKSpzR9WNenzLzQy44nrVNVtv154HJSpMFN4StoUyX/vJMre+obMQlQLYL3HnLMlvA1
         kF3gyzPRrjnq002ToVZTg65PfuOI5SyuDqOiwPWfxfKwkNSbveM0mk4Yk6l4+qH0S3yq
         6scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709527343; x=1710132143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgCb7iXd8J0BRB0u/H3HN+uMdSTfhHTZg+YKFQ7z3Hs=;
        b=tb6mbgmrdWetvJaSfgalFDiP+IlCh6sF8hrqcX2owRGzLK8izKVJurGXt6hKGPrphq
         uYG9WskZepVJs21coVXs6YBbDQKAq/gqaZNZDuREwGmVsg2f6hez05XNYpl1FqtdPetd
         ztRu7fTvWOfZr8EKeeUiVmewFsks78ZL2a41sExyjN63X9TsdW7g7xihOepAxba9pS9p
         jHopNHqgSUOP8fk4I4xYhwYsQwsAx5ukXbpc1fNjyhzMCB/L9iRUwVpLvx0xrAAdLuij
         4dkT74nrc15JkqAr3wq7zUza5fvYyXNlQLGayCyChvAyKsIzIDBx6s8ZQvMwP0tpMdFV
         7fSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX44RdN7wdbil0hZ3evJfeuvpmv120BptuhxPuzOW0nUX0OMv/rQndhpgHt5ts6R9IxhiLkp3j2QrDkyZlmqY6LOGdpncIsmDC4o9aWV4zn/yVQTPBeHUfix9NdcYuIupnxw9Nw
X-Gm-Message-State: AOJu0Yy/qsMo1eW2y5g0NJMYM+eYLFB9icfbz61JmBD22dxGhM+dDslL
	FnMg7HHx6+lOuF/2UmYmb09rkl+7UkkX8Fi+43PnTuqgCSb2rQloCdMlXtzhm/h9+O0s6Ug2f7I
	NSjzzmsj+A2yR8F6Ek3rX1fxIuv4=
X-Google-Smtp-Source: AGHT+IE+tUNGgb09wdNCP93nVhfHjOPpP1yWFJCuhLYc4SuSqAtpOTnqCN8ccoxrVZIBuxz+Dwcr6u1PTZRjFSOY6UI=
X-Received: by 2002:a17:906:54c7:b0:a44:44ff:5dd5 with SMTP id
 c7-20020a17090654c700b00a4444ff5dd5mr5537789ejp.21.1709527342847; Sun, 03 Mar
 2024 20:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPz+xZvczwEnsv1eGsNmv8rtLmyw5WV_rDz_Zui0cNd4Q@mail.gmail.com>
 <CANn89iJt1Ke=chUSd7JSNSdCEN4ghjivg2j902Wqa5pSQdrdeQ@mail.gmail.com>
 <CAEkJfYM9PZ7Py6aeHOf5YgD8KiczthM5_opEOXDjp2rE=3ry+Q@mail.gmail.com> <CAL+tcoAM-xnf2d+btrW3cjz49T1fhcg3XJQPc9S2PUaUuJJ3cQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAM-xnf2d+btrW3cjz49T1fhcg3XJQPc9S2PUaUuJJ3cQ@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 4 Mar 2024 12:42:11 +0800
Message-ID: <CAEkJfYPcz1XSgqQQEzR+P6mVOh8vNzdcA_NfTAy9JDfLXi4N0g@mail.gmail.com>
Subject: Re: [Kernel bug] KASAN: slab-out-of-bounds Read in in4_pton
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:20=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hi Sam,
>
> On Fri, Mar 1, 2024 at 11:23=E2=80=AFPM Sam Sun <samsun1006219@gmail.com>=
 wrote:
> >
> > On Fri, Mar 1, 2024 at 4:18=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Fri, Mar 1, 2024 at 3:41=E2=80=AFAM Sam Sun <samsun1006219@gmail.c=
om> wrote:
> > > >
> > > > Dear developers and maintainers,
> > > >
> > > > We found a bug through our modified Syzkaller. Kernel version is b4=
01b621758,
> > > > Linux 6.8-rc5. The C reproducer and kernel config are attached.
> > > >
> > > > KASAN report is listed below
> > > >
> > > > ```
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > > > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/810=
7
> > > >
> > > > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-=
1 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> > > >  print_address_description mm/kasan/report.c:364 [inline]
> > > >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
> > > >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> > > >  strlen+0x7d/0xa0 lib/string.c:418
> > > >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
> > > >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
> > > >  bond_option_arp_ip_targets_set+0xc2/0x910 drivers/net/bonding/bond=
_options.c:1201
> > > >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> > > >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.=
c:792
> > > >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c=
:817
> > > >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sys=
fs.c:156
> > > >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> > > >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> > > >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> > > >  call_write_iter include/linux/fs.h:2020 [inline]
> > > >  new_sync_write fs/read_write.c:491 [inline]
> > > >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> > > >  ksys_write+0x122/0x250 fs/read_write.c:637
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > > RIP: 0033:0x7f797835cfcd
> > > > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007ffff464ffb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
001
> > > > RAX: ffffffffffffffda RBX: 00007ffff46501b8 RCX: 00007f797835cfcd
> > > > RDX: 00000000000000f5 RSI: 0000000020000140 RDI: 0000000000000003
> > > > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff46501b8
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > > R13: 00007ffff46501a8 R14: 00007f79783da530 R15: 0000000000000001
> > > >  </TASK>
> > > >
> > > > All
> > >
> > >
> > > >
> > > > We analyzed the cause of this bug. In the function "bond_option_arp=
_ip_targets_set" in
> > > > drivers/net/bonding/bond_options.c, newval->string can be controlle=
d by users. If string
> > > >
> > > > is empty, newval->string+1 points to the address after newval->stri=
ng, causing potential
> > > >
> > > > info leak.
> > > >
> > > > One possible fix is to check before calling in4_pton, whether strnl=
en(newval->string) > 1.
> > > >
> > > > If you have any questions or require more information, please feel
> > > > free to contact us.
> > > >
> > > > Reported by Yue Sun <samsun1006219@gmail.com>
> > > >
> > >
> > > Thanks for the report and analysis.
> > >
> > > Are you willing to provide a patch ?
> > >
> > > You would get more credits than a "Reported-by:" tag :)
> > >
> > > Thanks
> >
> > Dear Eric,
> >
> > Thanks for letting me provide a patch! One possible patch
> > is listed below.
> >
> > diff --git a/drivers/net/bonding/bond_options.c
> > b/drivers/net/bonding/bond_options.c
> > index f3f27f0bd2a6..a6d01055f455 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -1198,7 +1198,7 @@ static int bond_option_arp_ip_targets_set(struct
> > bonding *bond,
> >      __be32 target;
> >
> >      if (newval->string) {
> > -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) =
{
> > +        if (!strlen(newval->string) || !in4_pton(newval->string+1,
> > -1, (u8 *)&target, -1, NULL)) {
> >              netdev_err(bond->dev, "invalid ARP target %pI4 specified\n=
",
> >                     &target);
> >              return ret;
>
> You could submit the patch targetting at the latest net tree on your
> own instead of replying to this thread. And then people will review it
> soon :)
>
> Thanks,
> Jason
>
Hi Jason,

Thanks for replying! Since it is my first time committing a patch, I
don't know the standard procedure of patch submission. I saw people
discuss patches through emails so I replied to the thread. I will
check kernel documentation on submitting patches.

Best Regards,
Sam

