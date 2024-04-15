Return-Path: <linux-kernel+bounces-144789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC488A4ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F868B267EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6273A29A;
	Mon, 15 Apr 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9J160ZM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07839856;
	Mon, 15 Apr 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170800; cv=none; b=WF/lTAGLb1z8PqcPG5PszJErRfImsBNYQ7Br/sbrZTbh4iVx2q+4s+ETV0qiAdlrrD4iq15DjvIE8kvwjrdLh/5y0erAiTNsD19TpHA2ldgaXXteomsX58oqptavLbD//58qjytdM7qGcoa0pLIKaEIWWfe01l5TmPnVUNeT7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170800; c=relaxed/simple;
	bh=hNjwK61PymYGMym9JB2yblANAf//SgH2Jxb5etpvbwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9BGiq87D3yC5eqVRSKh+qkAkanxG92Vn+wt4xOsybF4LrXUyR54B/QnZWzJV/3nn4NIMUq6twefM2BZC4oFkklDr6zZnvfifNlHfBnj5tEXABPzOjIGAwsUH/OHnoubSrYdj5s+aL9YPImHr8dx7usdefYE2ZDuv3XJReK1NFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9J160ZM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so469175766b.1;
        Mon, 15 Apr 2024 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713170797; x=1713775597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyOplWo1OhQ7jIS9GC6myR7jZ2q+QwmocYxZHOEBOww=;
        b=g9J160ZM0hMWRLqBA/1OpbCW/+yyQBOL3zDIWCPn4nVakMKYDcWn5OAVGPMSmJmH4s
         gCNpOvnrb9zwNhg911g8YgHtsSwS6pPol2s6ibp9bKnJ3EfyYiby6Gj3dqRscYvVCkbX
         eYqV3OoeweQ2MQyf/DAw7uQpTkxR4zq2M8XLp5uTPOhoCEpufOabJ9UoZGMthsMJcRZF
         A1x7nInQQk6tSdUai5xknQTjkiGBeuS0K3ucimCavx44zVt+kAgAxI1+UM7BTA1LzCY6
         fDTRO3xlbgvWAcYzCqQznSW9ChPWlVjwzKG2KDJACAYyh/2S4WEEK4GwEECkEjD2EXPt
         xMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170797; x=1713775597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyOplWo1OhQ7jIS9GC6myR7jZ2q+QwmocYxZHOEBOww=;
        b=CsHsaGaXSG1Vsq+8+K7IKNG7H3aEDJWQrxIbOMOkpCbQpID1uR9gheYq7kuWOj3P8X
         gPlxY9y5LdS2cK5TLmJJ3K0z7ZMNxCvh1WZVOzbvnhHWGuE8Zya0sjHVMMRlakB1Kt2f
         vuGnc+5Vg93OlUVxoxW3ObeZdP2AOzu0FSED8jlBxKiYr4v6bZWvzSz3mLPp063fTStn
         Qy1WK5l3SNJZZpv3SA1mLZqy6CQHblsXKhvJGYW9Vi8K9AT1qtU8w415yDlu9Bo6GjsK
         n6yHZnpfkzFhcHnkXmLGSOu5zAHp0mdPx2sRTfRvLv2xPFHQVi9WEc2pbr4KsutZzO4S
         hbMw==
X-Forwarded-Encrypted: i=1; AJvYcCV4W2vKzRN0QAc7dxfwa50qHUwpgrDGNiV/ULXQ7EKZHoYKRSpMH7cxCE5NZxl1hi7ax83E/9ksRZsobVBwHsrJA0T5OIep
X-Gm-Message-State: AOJu0YwOC3FQjQ/3WUSwqT9kpVDBVB43PRmUQNs+7A1QaFj5/CLZ3DDb
	ybi+F5EG5vXQdLj5tNJxFT6HVkURHJCC7viEBhprcyyBF3ZJQ2H9c3jzAfx3DmEUUL1JN5WsZif
	3E6eCkL+G4gXAmaE/dt8iiKMzKvg=
X-Google-Smtp-Source: AGHT+IHqdMvIxs/inPslV4MHpewRNPeg8c79P8yGPObfWab8REKuhNGr+8S/hKaSWAe7bykMi7l/THd96lqjXbUub4g=
X-Received: by 2002:a17:906:f2cb:b0:a52:5b0f:7f99 with SMTP id
 gz11-20020a170906f2cb00b00a525b0f7f99mr3006372ejb.6.1713170796627; Mon, 15
 Apr 2024 01:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com>
 <ZhzYCZyfsWgYWxIe@Laptop-X1>
In-Reply-To: <ZhzYCZyfsWgYWxIe@Laptop-X1>
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 15 Apr 2024 16:46:24 +0800
Message-ID: <CAEkJfYOebGdmKLtn4HXHJ2-CMzig=M+Sc7T0d6ghZcXY_iY5YA@mail.gmail.com>
Subject: Re: [PATCH net v1] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, j.vosburgh@gmail.com, 
	andy@greyhouse.net, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:32=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Mon, Apr 15, 2024 at 11:40:31AM +0800, Sam Sun wrote:
> > In function bond_option_arp_ip_targets_set(), if newval->string is an
> > empty string, newval->string+1 will point to the byte after the
> > string, causing an out-of-bound read.
> >
> > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:364 [inline]
> >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
> >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> >  strlen+0x7d/0xa0 lib/string.c:418
> >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
> >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
> >  bond_option_arp_ip_targets_set+0xc2/0x910
> > drivers/net/bonding/bond_options.c:1201
> >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:79=
2
> >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
> >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c=
:156
> >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> >  call_write_iter include/linux/fs.h:2020 [inline]
> >  new_sync_write fs/read_write.c:491 [inline]
> >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> >  ksys_write+0x122/0x250 fs/read_write.c:637
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > ---[ end trace ]---
> >
> > Fix it by adding a check of string length before using it.
> >
> > Reported-by: Yue Sun <samsun1006219@gmail.com>
>
> Not sure if there is a need to add Reported-by yourself if you are the au=
thor.
>
> Also you need a Fixes tag if the patch target is net tree.

Sorry for missing the Fixes tag, I will add it to patch. I am also not
sure if I should add Reported-by here, since it's my first time to
commit a patch for linux.

> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > ---
> >  drivers/net/bonding/bond_options.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/bonding/bond_options.c
> > b/drivers/net/bonding/bond_options.c
> > index 4cdbc7e084f4..db8d99ca1de0 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -1214,7 +1214,8 @@ static int bond_option_arp_ip_targets_set(struct
> > bonding *bond,
> >      __be32 target;
> >
> >      if (newval->string) {
> > -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) =
{
> > +        if (!(strlen(newval->string)) ||
> > +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)=
) {
> >              netdev_err(bond->dev, "invalid ARP target %pI4 specified\n=
",
> >                     &target);
>
> Do we need to init target first if !(strlen(newval->string)) ?
>
Good question. I think we don't need to init target first, since in
original logic in4_pton() also leave target untouched if any error
occurs. If !(strlen(newval->string)), bond_option_arp_ip_targets_set()
just ret and target is still untouched. But I am not sure about it.

If anyone finds other problems, please let me know.

Thanks,
Yue
> Thanks
> Hangbin
> >              return ret;
> > --
> > 2.34.1

