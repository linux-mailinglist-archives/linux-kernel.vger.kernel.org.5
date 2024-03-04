Return-Path: <linux-kernel+bounces-90006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0286F8DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A5528148D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C724A3E;
	Mon,  4 Mar 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikcIF4hB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AD3D6D;
	Mon,  4 Mar 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522433; cv=none; b=HVxuSG25b9ayi3cINQPumd+I4xuLXD/Etm8uuziIrJVVAV0C/mzLHaOlnTsbR9TfTCdsNiap+8HgT+E3UzUX85ZT0eMyEzg5tt2OLP2lIua34F7/LQNbgeJHGKQOhKmb8fu4VcwHHM2aDbr7lmK+pE7EVvckw0lAa9h+cBUd2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522433; c=relaxed/simple;
	bh=unZ5pH5Vat+193wTsQ4UMHnA2tAtkmL1s97+V9DyjwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqViDoWoEBjYjvFpXFydyHE2HUZK2xKWYCgKJR2kucIZi8LZtxl0Ja/n3DmbCOPINhXqXf3dMVewVUyiBtiiHlG7pfJJ8JZUa6TGE7qgdDYVo7Sm4NBZSbDpMG9DpUxlnTWUQR0HiqHLWsCroJU+maHh7WD2dLvbSWuwhMWXlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikcIF4hB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4554d4cb62so37351766b.2;
        Sun, 03 Mar 2024 19:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709522429; x=1710127229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49lhx3xPmnbWziQJHmwq4JUdh1Pf+xDaTKNLuJmhOe4=;
        b=ikcIF4hBFVDPP4MTMRNw+Krw3lxv67u46+GbEYCeLxf6lCpawjnmXW7p8oXeNUZl5f
         KAn9ezs7LBVWeGcRS5NmagcKlxM+yYlMiAxHm0wIy26j67/xpltLS5ykaapdnPKWEtNY
         kGFceYxZYRpDqiXE62P4tVEShcRm7sfEVm0BZEQKv6BS2Eol0VorOR3CJvNchzXY+IG3
         l8OL0KFKVFLAVuno7YzK/DpEQs5OyNbi0inz5j7QIlKhf6+utIMO+Q9gYqt+Ypau59V/
         Y9ChxY6sIe+kn1MN75cKEt9Tth0NX01K+yREafXcFysQ/mwNekmmTs2NgX7h/QjJ6oje
         W3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709522429; x=1710127229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49lhx3xPmnbWziQJHmwq4JUdh1Pf+xDaTKNLuJmhOe4=;
        b=fWsOQr5HSzyD+Ypt2vseATQcO31HBQSIznkK0aTDE+Su3pLCWgtKWeUvxo02eXGCFE
         Yt7Y5LKlEq8F0RJh4NLCKg5dh0HyOfdMYexcWoj8RX7ykAliEYV7k9kd8LyyS/pt+qy8
         cNPdqbc5XPbtqehCGtMsWhbrzo3nsYiZqoFeFNL6E/bHpwbFujknGHwW2fJwKgETqNTx
         mBB8gyF6UHBgH1paCL/HbBjfnAlghLvYC3BKdAC4xhHuOpvT2Vhl+SEVH+gEvWcDYdXE
         OfiOorh98xLhjEzwhioQx2ZhwD5Maow4PJsTO6AMeBYiKtGwmCIJ2FuN0ddFHcx0Zz9m
         nUIg==
X-Forwarded-Encrypted: i=1; AJvYcCXBYcYk9hB9JZrqPMxVd7bsjUIyjEmKMvxvtM3F9vj7OgL6jrjHy+1vdeamkjWggS3Pbw6l9SInOGS4vjhBHfANQuPwzF4XQM6zvEqMvQgnpAbxFV2UxzIWMkG6YzzHI/ANHsIE
X-Gm-Message-State: AOJu0YxLarqQkdc6sVGn7eAKY/55nf0F2fNuWiFrE+8fAGp8gAolGXRG
	Pta9sQ9hoM3hIL8fDiliaobdGNXklvivfZ4yq/Wmydo1698NyQinmx5EqlUxv1I/QHyl317JxAe
	957eS7uUswMcFOprZ0irzVt0SWFNq+pVt0tc=
X-Google-Smtp-Source: AGHT+IG3NloPvcL/kxLp6eoTg4DKD5SAG7srDEOTqfEhcoP23DGKX7sSVZG5ypsnckEdo0eia+Ffa5j1kIVW3jyS0sU=
X-Received: by 2002:a17:906:714f:b0:a3f:4596:c3c8 with SMTP id
 z15-20020a170906714f00b00a3f4596c3c8mr4992457ejj.53.1709522429377; Sun, 03
 Mar 2024 19:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPz+xZvczwEnsv1eGsNmv8rtLmyw5WV_rDz_Zui0cNd4Q@mail.gmail.com>
 <CANn89iJt1Ke=chUSd7JSNSdCEN4ghjivg2j902Wqa5pSQdrdeQ@mail.gmail.com> <CAEkJfYM9PZ7Py6aeHOf5YgD8KiczthM5_opEOXDjp2rE=3ry+Q@mail.gmail.com>
In-Reply-To: <CAEkJfYM9PZ7Py6aeHOf5YgD8KiczthM5_opEOXDjp2rE=3ry+Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 4 Mar 2024 11:19:52 +0800
Message-ID: <CAL+tcoAM-xnf2d+btrW3cjz49T1fhcg3XJQPc9S2PUaUuJJ3cQ@mail.gmail.com>
Subject: Re: [Kernel bug] KASAN: slab-out-of-bounds Read in in4_pton
To: Sam Sun <samsun1006219@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Fri, Mar 1, 2024 at 11:23=E2=80=AFPM Sam Sun <samsun1006219@gmail.com> w=
rote:
>
> On Fri, Mar 1, 2024 at 4:18=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Mar 1, 2024 at 3:41=E2=80=AFAM Sam Sun <samsun1006219@gmail.com=
> wrote:
> > >
> > > Dear developers and maintainers,
> > >
> > > We found a bug through our modified Syzkaller. Kernel version is b401=
b621758,
> > > Linux 6.8-rc5. The C reproducer and kernel config are attached.
> > >
> > > KASAN report is listed below
> > >
> > > ```
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> > >
> > > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> > >  print_address_description mm/kasan/report.c:364 [inline]
> > >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
> > >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> > >  strlen+0x7d/0xa0 lib/string.c:418
> > >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
> > >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
> > >  bond_option_arp_ip_targets_set+0xc2/0x910 drivers/net/bonding/bond_o=
ptions.c:1201
> > >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> > >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:=
792
> > >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:8=
17
> > >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs=
c:156
> > >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> > >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> > >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> > >  call_write_iter include/linux/fs.h:2020 [inline]
> > >  new_sync_write fs/read_write.c:491 [inline]
> > >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> > >  ksys_write+0x122/0x250 fs/read_write.c:637
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > RIP: 0033:0x7f797835cfcd
> > > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffff464ffb8 EFLAGS: 00000246 ORIG_RAX: 000000000000000=
1
> > > RAX: ffffffffffffffda RBX: 00007ffff46501b8 RCX: 00007f797835cfcd
> > > RDX: 00000000000000f5 RSI: 0000000020000140 RDI: 0000000000000003
> > > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff46501b8
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > R13: 00007ffff46501a8 R14: 00007f79783da530 R15: 0000000000000001
> > >  </TASK>
> > >
> > > All
> >
> >
> > >
> > > We analyzed the cause of this bug. In the function "bond_option_arp_i=
p_targets_set" in
> > > drivers/net/bonding/bond_options.c, newval->string can be controlled =
by users. If string
> > >
> > > is empty, newval->string+1 points to the address after newval->string=
, causing potential
> > >
> > > info leak.
> > >
> > > One possible fix is to check before calling in4_pton, whether strnlen=
(newval->string) > 1.
> > >
> > > If you have any questions or require more information, please feel
> > > free to contact us.
> > >
> > > Reported by Yue Sun <samsun1006219@gmail.com>
> > >
> >
> > Thanks for the report and analysis.
> >
> > Are you willing to provide a patch ?
> >
> > You would get more credits than a "Reported-by:" tag :)
> >
> > Thanks
>
> Dear Eric,
>
> Thanks for letting me provide a patch! One possible patch
> is listed below.
>
> diff --git a/drivers/net/bonding/bond_options.c
> b/drivers/net/bonding/bond_options.c
> index f3f27f0bd2a6..a6d01055f455 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1198,7 +1198,7 @@ static int bond_option_arp_ip_targets_set(struct
> bonding *bond,
>      __be32 target;
>
>      if (newval->string) {
> -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
> +        if (!strlen(newval->string) || !in4_pton(newval->string+1,
> -1, (u8 *)&target, -1, NULL)) {
>              netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
>                     &target);
>              return ret;

You could submit the patch targetting at the latest net tree on your
own instead of replying to this thread. And then people will review it
soon :)

Thanks,
Jason

>
> This patch was tested on kernel commit b401b621758,
> tag Linux 6.8-rc5 against the C repro listed in previous
> email.
>
> If you have any questions, please contact us.
>
> Best Regards,
> Yue
>

