Return-Path: <linux-kernel+bounces-49848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E631E84706B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B491298371
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918315BA;
	Fri,  2 Feb 2024 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iACj6IjV"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2215A5;
	Fri,  2 Feb 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877300; cv=none; b=RzKyNKzsWsNzvWBhEAQIyDkL/QQG4y8oOx1Osj/Fj3s2PSBP26gP5vP00BEjmEr54u6sI8hEfXQ0E779O6goxgFkEl4rCXxHC65GRUUqa8eIPDJrlVyYUyGrPpdfqWU0a40t+32ddoDDoVFTBfZZJM66KDujCmnv/n70xVNejXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877300; c=relaxed/simple;
	bh=r88cJgVhpj6TeaxjYBf9I++lPTZO6VVmG4yTbPt3Ags=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1GyRBVTmtAf6RKzbS3bnJEmzyAgCvmx5eBz1tcaadoocCw2eaPXbWApPvq8yTwRcz+seOLTmRrFr4aV7JGYwZ83auAety4TSpMwl+MBJOVkwQbABER85JKVo/EjmtOfYZPieJixWxB+fvCuv4vov9Q0MgoMM3WoHHLAHrCx4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iACj6IjV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c66c6a234so10647636d6.2;
        Fri, 02 Feb 2024 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706877298; x=1707482098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM4xSHqIsnx0I1gONKxIz//gK+bKpKTAUWovzvTJPxw=;
        b=iACj6IjVXJBvcNnSDT6ZQDkJ/RwFVYexMuOx9ybp6PlMs6Fub2rNagffte0m/C0I3U
         0y8+LfSF3LREMQaZuWxYFXSRfJYIBjQdoP73tXVFRmW9WbnW7SuGeUgAmm8J7sTark8E
         xkXNWpomF9TgUs4yg0Q51tGRj7EncMABhiMo++PVLORdCnMKPiKNTxVjk3i0StQw+VAB
         mBl6YxRecUqrCWXFNjaS4XMQEy7DdlhfczL2jdNOWG9Wji7fJJfFxX+S1ZBD4IomVRsc
         8Ykf1CIzmtby1S203yoro6BHvI6oY8RuVKickc0qSvjfyWJjaPKj99d6bgBT7L6TrwJQ
         Kodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877298; x=1707482098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM4xSHqIsnx0I1gONKxIz//gK+bKpKTAUWovzvTJPxw=;
        b=j6x9usQPHNlowLQowdzjSozJWyuIOD8/m+iPAA9/UJm+E+WYFcXMdiMJeOPZKcBKPh
         fqKYLCZS5/YmWznzGTZEhG9LYHLDS9FVJWTBuAf6hnWwWJAzle7Sh9BUmCM2XnoDtQP8
         RhntHJ+Q8hyHzRRuvh016R/cF/s5uRDcakON2maonuHCckHsBT9tBgXv/d3wlNIEQJl1
         vndt8GVfOWpcLuZipnOIh9vAtCdmT3+mh5ZofrqbTBiVISOhGgI4kzz+0LOSlMxBnRfP
         NdMfPRYnJFMpZG1lsXdi9FTbEdnfvnKygk2mgXqSmOAmFw5v8lOgq97on1LUCNe6ON6m
         rWvw==
X-Gm-Message-State: AOJu0YxDEduGEkOcErihFpDMCRh0wk/UzILawkmIFmQK/BcrcNRW5IcR
	SZqZEGvba+0OPQxUuzjVG7mvZxv5vJbVXZww5a5UwnKyHse13SHEpBVvT6k4JstY9rKk1nx9pF2
	5rbi6RZQfGe1OI0RhspkotH8ynnyVVRWG9EQ=
X-Google-Smtp-Source: AGHT+IE3E2ASYMDtWedqhzrJNdHIyJdgvXl0gmoCss/OfnoTkJbNjfjEfikfv2Itfw8+2FFXnA/AlHHYDjhEcLL7F5Y=
X-Received: by 2002:a0c:f245:0:b0:68c:8a2a:af12 with SMTP id
 z5-20020a0cf245000000b0068c8a2aaf12mr546530qvl.38.1706877298238; Fri, 02 Feb
 2024 04:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLxOc6fTOEX4C_=0t4_+Qv9VrUTJUg4g6+JSAg+v34UaRg@mail.gmail.com>
In-Reply-To: <CABOYnLxOc6fTOEX4C_=0t4_+Qv9VrUTJUg4g6+JSAg+v34UaRg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 14:34:46 +0200
Message-ID: <CAOQ4uxiqoP95=BpG2x=s2vr4mriBk1R76NgDFCuvXFRz=qr+Wg@mail.gmail.com>
Subject: Re: WARNING in ovl_copy_up_file
To: xingwei lee <xrivendell7@gmail.com>
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:09=E2=80=AFPM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello I found a bug in latest upstream titled "WARNING in
> ovl_copy_up_file" with modified syzkaller and maybe is related with
> overlays, and I also reproduce it with repro.c and repro.txt
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
>
> kernel: upstream 021533194476035883300d60fbb3136426ac8ea5
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
457249c250b93697
> with KASAN enabled
> compiler: gcc (Debian 12.2.0-14) 12.2.0
>
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 77145 at fs/overlayfs/copy_up.c:239
> ovl_copy_up_file+0x6ca/0x6f0 fs/overlayfs/copy_up.c:332
> Modules linked in:
> CPU: 3 PID: 77145 Comm: syz-executor.0 Not tainted
> 6.8.0-rc1-00208-g6af191034c8f-dirty #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:ovl_verify_area fs/overlayfs/copy_up.c:239 [inline]
> RIP: 0010:ovl_copy_up_file+0x6ca/0x6f0 fs/overlayfs/copy_up.c:332
> Code: ff e8 6a 62 47 ff 0f 0b 41 bc fb ff ff ff 48 8b 5c 24 18 e9 7c
> ff ff ff 31 ff e8 51 62 47 ff 0f 0b eb 14 31 ff e8 46 62 47 ff <0f> 0b
> eb 09 31 ff e8 3b 62 47 ff 0f 0b 41 bc fb ff ff ff e9 1d fb
> RSP: 0018:ffff88804417f440 EFLAGS: 00010246
> RAX: ffffffff81fb8c4a RBX: 0000000000800000 RCX: ffffc9000c04c000
> RDX: ffffffff81fb8c4a RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88804417f570 R08: 000000000000a4dd R09: 000000000000a4de
> R10: ffffed102063f949 R11: ffffed102063f949 R12: ffff8881031fca40
> R13: 0000000000800000 R14: ffff88804417f4c0 R15: ffffffffffeac000
> FS:  00007fd4f579c6c0(0000) GS:ffff888135d00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc0bff9d988 CR3: 0000000013cc4000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
> ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:865 [inline]
> ovl_do_copy_up fs/overlayfs/copy_up.c:978 [inline]
> ovl_copy_up_one fs/overlayfs/copy_up.c:1170 [inline]
> ovl_copy_up_flags+0x1717/0x2cc0 fs/overlayfs/copy_up.c:1225
> ovl_copy_up+0x20/0x30 fs/overlayfs/copy_up.c:1265
> ovl_setattr+0xc1/0x370 fs/overlayfs/inode.c:41
> notify_change+0x8d2/0x960 fs/attr.c:499
> chmod_common+0x1d5/0x330 fs/open.c:648
> do_fchmodat fs/open.c:696 [inline]
> __do_sys_fchmodat fs/open.c:715 [inline]
> __se_sys_fchmodat fs/open.c:712 [inline]
> __x64_sys_fchmodat+0xea/0x180 fs/open.c:712
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fd4f647cc29
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd4f579c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
> RAX: ffffffffffffffda RBX: 00007fd4f659c1f0 RCX: 00007fd4f647cc29
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
> RBP: 00007fd4f64c847a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007fd4f659c1f0 R15: 00007ffc819fff88
> </TASK>
> ---[ end trace 0000000000000000 ]---
>
[...]

> =3D* repro.txt =3D*
> syz_mount_image$fuse(0x0, &(0x7f0000001040)=3D'./file2\x00', 0x0, 0x0,
> 0x0, 0x0, 0x0)
> syz_mount_image$fuse(0x0, &(0x7f0000002080)=3D'./file0\x00', 0x0, 0x0,
> 0x0, 0x0, 0x0)
> mount$overlay(0x0, &(0x7f0000000040)=3D'./file0\x00', &(0x7f0000000000),
> 0x0, &(0x7f0000000100)=3D{[{@workdir=3D{'workdir', 0x3d, './file0'}},
> {@lowerdir=3D{'lowerdir', 0x3d, '.'}}, {@upperdir=3D{'upperdir', 0x3d,
> './file2'}}], [], 0x2c})
> r0 =3D openat(0xffffffffffffff9c, &(0x7f0000000040)=3D'./file1\x00', 0xa4=
2, 0x0)
> write$P9_RXATTRCREATE(r0, &(0x7f0000000000)=3D{0xfffffffffffffe98}, 0x800=
600)
> openat$dir(0xffffff9c, &(0x7f0000000080)=3D'./file1\x00', 0x20200, 0x0)
> write$P9_RLCREATE(r0, &(0x7f0000000300)=3D{0x18}, 0x18)
> r1 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\x00', =
0x0, 0x0)
> fchmodat(r1, &(0x7f00000000c0)=3D'./file1\x00', 0xd00)
>
>
> See aslo https://gist.github.com/xrivendell7/86a9486e8e1e703c4f4453abec06=
4fb5
>
> I hope it helps.

There are no details about how this repro was run like there are in
syzkaller reports , e.g.:

{"threaded":true,"repeat":true,"procs":5,"slowdown":1,...

I assume this was run in concurrent threads that write to a file that
is an underlying
file for some ovl mounts (because they all mount over the same path).

The only way I see this WARN_ON() get hit:

if (WARN_ON_ONCE(pos < 0 || len < 0 || totlen < 0))
                return -EIO;

is if len < 0, after a seek over a hole did:
                len -=3D hole_len;

If racing to grow the underlying lower file under overlayfs this might happ=
en -
not sure if this was the case here.

If that happens it falls well under the category of:
https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-fi=
lesystems

Perhaps a WARN_ON is a bit too harsh for this case, but since it is
a WARN_ON_ONCE it is not a big issue IMO.

Then again, my analysis may be wrong.
Please check if the assertion is indeed about len < 0
and whether it really did get to be negative after seeking a hole
to an offset beyond the original file size (when copy up started).

Thanks,
Amir.

