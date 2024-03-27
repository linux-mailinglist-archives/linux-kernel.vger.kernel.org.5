Return-Path: <linux-kernel+bounces-120166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05988D39A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D71F35AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9501CD23;
	Wed, 27 Mar 2024 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rul+llgw"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45518FBF3;
	Wed, 27 Mar 2024 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711501670; cv=none; b=RHWCap2r1bpGmzSdrvyV5mKCHBVhO/Ou5ix32G+WgfjXZdERhSl9+t1FlJhzt5+ZyO3vbspzTYwA7PaW/5VVml4tgYUaTBxVnpC1nTYJ0KbIv/+cOf+FmL2f9vu0l03zlaghjpig75wPa/43lZaCbm0ipy/O2i2+B2dfDF99G1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711501670; c=relaxed/simple;
	bh=hD2cjHS/Tqt9C0VCpflFTu+0Yjy8Iey2SCgJPXIV95M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eou2owHpK00Q0FzHx7wHKhNuJhETAuHKMSB0FwO3CKLAk2V/RBwG38KzQNteoRFU4KUAZsahLgN83p5uL8l0D7WXz/jEm2ZDB6r0lIV1B+FO8Bj+L67RAVaIwtIZEka1U0SDm/grGK7vix0zEaFVfX972Zvmuv4JVsBnMkFpctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rul+llgw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so4411961f8f.0;
        Tue, 26 Mar 2024 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711501666; x=1712106466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mkHEfMse9h6YXI+Og+/iiUhyCAWdI4OdWFAFndX8Dc=;
        b=Rul+llgwDnI5YJUapt/UrkroJO9FqNu0V/ZpneoySkZEE1FIwM59+3dPBAQgl2pTbM
         HBEv3d1pC33ISzx3gy98iLQRNCeE5qAY7UNOravTaEhc6hljiBkavO1JRIzh66K/Vwf1
         OWL42JVquv2FybZSy0HHp/K0psqih1/i4oKC1rU3C78mnbj4YfF5Qz0OmSqs59YrIh42
         7b+5uZt4awXnZXciVv/nbxUdX4afcSKr5B7c2xZCfIf6/R5riSE2UIo42kARQr1f11ud
         V0NFgEPN6s1x1g4GeqgizPb2x0Uw//wxylSSImhdNO9BQPxYdJanhs29mKI+VrjTXrIX
         X8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711501666; x=1712106466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mkHEfMse9h6YXI+Og+/iiUhyCAWdI4OdWFAFndX8Dc=;
        b=PMAmZYi4FlyoPIFMe+AT9oPd8YyGg137GxNKAjSmrC3XB9OrdlZJQaYebjkKAB8tyN
         1Rfz2b/EJiZrmTYg7bZ5DhzYJpJgBNUKwszScJu9MLxfDZZ8Gt4LWOb4mcPfNZJ13Vrv
         yG7LT5zVDc3svjQ0xVj0QvxHLHfp6dGidYdYJ2MMnwrYG/WkBl3YefV/EjpqbfQzVv6N
         SVY7dSgHUHSo6TVEJbHKop8EwSUvwtj3crstuWNujqkjVNbBj3v5wXR77B5WYncRD7OZ
         rILV5TmqZFeGsgdvWD6a36LSyx7hd1jPuHlrEve1r51LU1cDuk6lBH2VP2RpYzpfNJEP
         q89A==
X-Forwarded-Encrypted: i=1; AJvYcCW0wOCL9p3vujXM3EytX0kW5XRagOfndeifNb6g+/26mYuy06IPZXovmPuwDkEY8aEIzA0/MBieD++IkfyriXI5SyJa66qxcbHgZ2Pn127rYIy4Qsb1zO9vhJwT2zchOQDBggqGh37Kbdtwjp7BTsehQJiS3QhXJPwP
X-Gm-Message-State: AOJu0YzuD1C0KbNh3H38Gpfu6+5IQtQgyOLWCeJVdya1xtUXtXTp533s
	p+lhyRF/th3SK+c+YLBKJ+zQPOT0a+TBKDl/OV7qSwA10pGizoEe5oqoazdMKaqSCqC99/544jB
	St+HCNSoEKdQjCmh9qLmXi0MkAAw=
X-Google-Smtp-Source: AGHT+IHKO+MI/cRpXRx4nUYx8wr8uD46Z/chGaNxpSsow+FmjTz97oaonbfR4Qj7TvEixYtGIRtUb/VYncXMxmY+ark=
X-Received: by 2002:a5d:5090:0:b0:341:c2a9:ceb with SMTP id
 a16-20020a5d5090000000b00341c2a90cebmr1812475wrt.42.1711501666313; Tue, 26
 Mar 2024 18:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000006f876b061478e878@google.com> <a402206e-a9c9-40bd-bf78-710054506071@linux.dev>
In-Reply-To: <a402206e-a9c9-40bd-bf78-710054506071@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Mar 2024 18:07:34 -0700
Message-ID: <CAADnVQLXyQ_o5hSA0OpHYj231WKPFNRNMyr0NePMr2ypusiLmg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>, 
	bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eddy Z <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 5:54=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/25/24 2:36 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5e74df2f8f15 Merge tag 'x86-urgent-2024-03-24' of git:/=
/gi..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D148872a5180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De6bd769cb79=
3b98a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1a3cf6f08d688=
68f9db3
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15921a6e1=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12e081f1180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1a82880723a7/d=
isk-5e74df2f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/fd3046ac43b9/vmli=
nux-5e74df2f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2097be59cbc1=
/bzImage-5e74df2f.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:4=
41 [inline]
> > BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/d=
evmap.c:796
> >   __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
> >   dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
> >   ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
> >   bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
> >   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
> >   __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
>
> It should be in the interpreter mode.
>
> The C reproducer is trying to run the following bpf prog:
>
>     0: (18) r0 =3D 0x0
>     2: (18) r1 =3D map[id:49]
>     4: (b7) r8 =3D 16777216
>     5: (7b) *(u64 *)(r10 -8) =3D r8
>     6: (bf) r2 =3D r10
>     7: (07) r2 +=3D -229
>             ^^^^^^^^^^
>
>     8: (b7) r3 =3D 8
>     9: (b7) r4 =3D 0
>    10: (85) call dev_map_lookup_elem#1543472
>    11: (95) exit
>
> I think this KMSAN report (and a few others related to lookup/delete_elem=
)
> should only happen in the interpreter mode.
>
> Does it worth to suppress it by always initializing the stack in the inte=
rpreter
> mode considering the interpreter is not very speed sensitive ?

Maybe we can mark it as initialized from kmsan pov ?
There are kasan_poison/unpoison helpers that may fit ?

