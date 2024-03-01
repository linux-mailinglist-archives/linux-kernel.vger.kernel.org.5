Return-Path: <linux-kernel+bounces-88617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DA86E43D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035871F233F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A06EB69;
	Fri,  1 Mar 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzDfJPgx"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9F1E502;
	Fri,  1 Mar 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306587; cv=none; b=NqihhBPZnTvOKK7rFyTFqoPhQQC3OmizAw3i84+RdvitY4pNNvH4eeWx+4DwWwhVzrfMFfp/e8+PA2BHU36D1eFbVV9M6e/fNycwmZNKTgoplI7dmwWOkk8wryGyAQzeHuXcTYzSQ1LgxbUee1rwiaTEwITKUc0A4c0X//Lydao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306587; c=relaxed/simple;
	bh=ykhuC16a76yujuSJcnRYVP2DAtHkeVZK76VXBYnaUCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2u27mBnbF8atyqhg1YVl/TbgGYg4m6Ee+Goc4kMdC53JfgEnApZDmym+TsEtpzDj5X47+Po2Hjw0F/quT78eQ1MCwwWeodwpwyD4XFYesOa+tW3dpphxLNI4Q2kjmN3hin69Wigunc/VouNlTt2KDFKrWqvWCIbOaTCmiJNvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzDfJPgx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so3444012a12.1;
        Fri, 01 Mar 2024 07:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709306584; x=1709911384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGYGLhQjLfLZEOyb1D9gwK3Rj1wkJrl/wQOZICqbfXA=;
        b=AzDfJPgxZ/4BmwfFcxxAqboy6KTHo2bczWT+LNrrBlG0F4pFvpxIwds2dciU1OJvhQ
         ZY4ooWv3xIuyotjSDD0VPaBDs/VeeRCzLnOx+aKn5Tnax1aY6taXevtvFJ4R81hxt2hY
         SIkXU5BzCH4wMsyUq574na+VrXj21s2vPygAHJNOhgyTO5h4V3gA4+/bamHombHxqWt/
         07ju7eXAcEv/wDhxg98XnerzfeIrNIvEoXJbjLcPLfIMV1SeXv8oqhuSsw9jp0USqshk
         l/yC10QxH0YroTXUW93kjy15smJVOXXUDd2vSPFVvBeG9btpU4AZOaBdNILvQPq3SDns
         bDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306584; x=1709911384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGYGLhQjLfLZEOyb1D9gwK3Rj1wkJrl/wQOZICqbfXA=;
        b=H9QM0AsbOGEyGDB/8YZ+6weeAFV3wmrUxMIddCDtk0qv8LRDlZlJgrY3JA79ICuDct
         4zj+Sf2PNqgPQ991sLJXTKeFR5o8HaX0+sC2qxMjX6N6mDbyXhzbpHTH2CBdIiJNYkkd
         p19nwbTfQoyYgka4GXtfFYNfWkh2I5JNP9crNKynWuF+uxMff2GEeSrtV3dcHjbCfd50
         WGkAMC6ZdtcC7O/QBO9+aKD2UMplNZmX+di/H00huOuump3FW+RpzMYdIc3dQayHv/Nm
         NY2OKK8PoDTQGTYlKtlWv0ICYqjUcHv0jsf8Pg7tot8cQx2qKMwehoVFpTbgH9RB9Y1Z
         i6mw==
X-Forwarded-Encrypted: i=1; AJvYcCVk8YJFUEBqDxY5TA7eQH5Senv/BlRjUnATcLEUW7unn3mgyfTqksEpbUb/P+cdkpPNF2l5M11i+0sLTh0ccvoNUREc0cUBZ/0PT3l0
X-Gm-Message-State: AOJu0YzL2jJ/D15RApWkZFoIBBhFiGr+5HuHswrqNKlPhNK1Dq0aFY7Z
	411c8loT9eW8VRor0CdDusFCRAMs2BVLGc6uvOvKllbvZTRAzXMZXrIGdLPvHSwvtIcZNwDjTaP
	3EDQcX0xWTg/nGT6ZL6cgSZ0TXDY=
X-Google-Smtp-Source: AGHT+IHr7VOi3yAOcZydge4+g5vfQ3rGPgeEq42SLoi5c87OORqbVObUEpabG425dNBSs8TGAVVGXeJtNkY5HuAwxOo=
X-Received: by 2002:a17:906:130a:b0:a44:2278:7a62 with SMTP id
 w10-20020a170906130a00b00a4422787a62mr1729019ejb.41.1709306583678; Fri, 01
 Mar 2024 07:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPz+xZvczwEnsv1eGsNmv8rtLmyw5WV_rDz_Zui0cNd4Q@mail.gmail.com>
 <CANn89iJt1Ke=chUSd7JSNSdCEN4ghjivg2j902Wqa5pSQdrdeQ@mail.gmail.com>
In-Reply-To: <CANn89iJt1Ke=chUSd7JSNSdCEN4ghjivg2j902Wqa5pSQdrdeQ@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 1 Mar 2024 23:22:52 +0800
Message-ID: <CAEkJfYM9PZ7Py6aeHOf5YgD8KiczthM5_opEOXDjp2rE=3ry+Q@mail.gmail.com>
Subject: Re: [Kernel bug] KASAN: slab-out-of-bounds Read in in4_pton
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, j.vosburgh@gmail.com, 
	andy@greyhouse.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Mar 1, 2024 at 3:41=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> =
wrote:
> >
> > Dear developers and maintainers,
> >
> > We found a bug through our modified Syzkaller. Kernel version is b401b6=
21758,
> > Linux 6.8-rc5. The C reproducer and kernel config are attached.
> >
> > KASAN report is listed below
> >
> > ```
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> >
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
> >  bond_option_arp_ip_targets_set+0xc2/0x910 drivers/net/bonding/bond_opt=
ions.c:1201
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
> > RIP: 0033:0x7f797835cfcd
> > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffff464ffb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 00007ffff46501b8 RCX: 00007f797835cfcd
> > RDX: 00000000000000f5 RSI: 0000000020000140 RDI: 0000000000000003
> > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff46501b8
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffff46501a8 R14: 00007f79783da530 R15: 0000000000000001
> >  </TASK>
> >
> > All
>
>
> >
> > We analyzed the cause of this bug. In the function "bond_option_arp_ip_=
targets_set" in
> > drivers/net/bonding/bond_options.c, newval->string can be controlled by=
 users. If string
> >
> > is empty, newval->string+1 points to the address after newval->string, =
causing potential
> >
> > info leak.
> >
> > One possible fix is to check before calling in4_pton, whether strnlen(n=
ewval->string) > 1.
> >
> > If you have any questions or require more information, please feel
> > free to contact us.
> >
> > Reported by Yue Sun <samsun1006219@gmail.com>
> >
>
> Thanks for the report and analysis.
>
> Are you willing to provide a patch ?
>
> You would get more credits than a "Reported-by:" tag :)
>
> Thanks

Dear Eric,

Thanks for letting me provide a patch! One possible patch
is listed below.

diff --git a/drivers/net/bonding/bond_options.c
b/drivers/net/bonding/bond_options.c
index f3f27f0bd2a6..a6d01055f455 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1198,7 +1198,7 @@ static int bond_option_arp_ip_targets_set(struct
bonding *bond,
     __be32 target;

     if (newval->string) {
-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
+        if (!strlen(newval->string) || !in4_pton(newval->string+1,
-1, (u8 *)&target, -1, NULL)) {
             netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
                    &target);
             return ret;

This patch was tested on kernel commit b401b621758,
tag Linux 6.8-rc5 against the C repro listed in previous
email.

If you have any questions, please contact us.

Best Regards,
Yue

