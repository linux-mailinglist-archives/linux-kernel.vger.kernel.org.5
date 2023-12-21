Return-Path: <linux-kernel+bounces-8574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5F81B996
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF659B21AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52E1D6BD;
	Thu, 21 Dec 2023 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UF4OojNF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF213608D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12959a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703169123; x=1703773923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ2azlvSqFCZX8jb2QITC8fbT5+vgCFvbH7RV3zxDzc=;
        b=UF4OojNFQ4HWe9YK+pwWgyE5PDsB0NrSiXLqTR0Qnj2Ri088RxNmJSGExoxQdZWiUC
         DZi5yOlnWk8nKoJ8oJpwdHmtCgWhQQRwlPuSdASNDGN0hVPysShCka5syfXEttchvqM/
         tMgP/isZ9MV+T4oDtwPkSbuQtGqc+fLzSPI2y8v4BLte5qKjk2ktDA+0rFgCrR5wKeu7
         koSpN2Clv/F9M/J7JYgg4TZwfly6OZJ0erkT7SbelHeCGBfK4kBckR2Ni5CljbtI2p2k
         as9fvnN+4JChoBFrKFw3uP34/XXHYf8V3JABxDU2g+speGa++V//0ZRA5WadVRcvhI5K
         4UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703169123; x=1703773923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ2azlvSqFCZX8jb2QITC8fbT5+vgCFvbH7RV3zxDzc=;
        b=bmVpa+ZlC1OP4tN/SHRiRl7h25J72tSX9BWIYQJbgQ5VK23MUrwEAY2B0r8npRCu+1
         PCW2VxeNy1IanxLuec18bs3qNjG9hgLNXABGggeydKAbmkstiKQ4l41i8Fh5QZBNClsy
         FeeXvFzsSTack316uqtrhxcIH/jwFEYzr1//bRxyv/dLjuHYiWN8IV2mzfMq3bxkhK3v
         DIpaIGTkOcyg/YiJg+wfLNnHwq5p2DkMstyZHtUM2fGWcYNFUXcepfESsb48H4b19WAR
         ozz88mYBXQvMrT3WcCuGx4xeEJeWomAg6yfvMVoX0zTyf3H1dLWJMqs1y/YE98vFh52q
         Q8BA==
X-Gm-Message-State: AOJu0YwycF5brAFUUI5qhCKxq/aIwsiXMBFzR8WR+D8Lv7gjomVJsh+V
	kTHUYuhmPFrLnkjrgpcUJdo4tYFEDpaylEX5N0TGAn9yLsFs
X-Google-Smtp-Source: AGHT+IHMWzYEbgP04SLDFsLT0lc+p/y3I3VmZDVD0uJFDXWiJxfT5AF9q9m7VvwlOsfQ5IWzPYUDWQX0j2s3riUqbYA=
X-Received: by 2002:a50:8e08:0:b0:553:5578:2fc9 with SMTP id
 8-20020a508e08000000b0055355782fc9mr90879edw.5.1703169122494; Thu, 21 Dec
 2023 06:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023192217.426455-1-dima@arista.com> <20231023192217.426455-2-dima@arista.com>
In-Reply-To: <20231023192217.426455-2-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Dec 2023 15:31:49 +0100
Message-ID: <CANn89i+Uwg87xAS9m8fm1f1daQj-YyugperN3HnvgbB6g+hOuw@mail.gmail.com>
Subject: Re: [PATCH v16 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for TCP-AO
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>, 
	David Laight <David.Laight@aculab.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Donald Cassidy <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	"Gaillardetz, Dominik" <dgaillar@ciena.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ivan Delalande <colona@arista.com>, 
	Leonard Crestez <cdleonard@gmail.com>, "Nassiri, Mohammad" <mnassiri@ciena.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, 
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org, 
	Steen Hegelund <Steen.Hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 9:22=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> TCP-AO, similarly to TCP-MD5, needs to allocate tfms on a slow-path,
> which is setsockopt() and use crypto ahash requests on fast paths,
> which are RX/TX softirqs. Also, it needs a temporary/scratch buffer
> for preparing the hash.
>
> Rework tcp_md5sig_pool in order to support other hashing algorithms
> than MD5. It will make it possible to share pre-allocated crypto_ahash
> descriptors and scratch area between all TCP hash users.
>
> Internally tcp_sigpool calls crypto_clone_ahash() API over pre-allocated
> crypto ahash tfm. Kudos to Herbert, who provided this new crypto API.
>
> I was a little concerned over GFP_ATOMIC allocations of ahash and
> crypto_request in RX/TX (see tcp_sigpool_start()), so I benchmarked both
> "backends" with different algorithms, using patched version of iperf3[2].
> On my laptop with i7-7600U @ 2.80GHz:
>
>                          clone-tfm                per-CPU-requests
> TCP-MD5                  2.25 Gbits/sec           2.30 Gbits/sec
> TCP-AO(hmac(sha1))       2.53 Gbits/sec           2.54 Gbits/sec
> TCP-AO(hmac(sha512))     1.67 Gbits/sec           1.64 Gbits/sec
> TCP-AO(hmac(sha384))     1.77 Gbits/sec           1.80 Gbits/sec
> TCP-AO(hmac(sha224))     1.29 Gbits/sec           1.30 Gbits/sec
> TCP-AO(hmac(sha3-512))    481 Mbits/sec            480 Mbits/sec
> TCP-AO(hmac(md5))        2.07 Gbits/sec           2.12 Gbits/sec
> TCP-AO(hmac(rmd160))     1.01 Gbits/sec            995 Mbits/sec
> TCP-AO(cmac(aes128))     [not supporetd yet]      2.11 Gbits/sec
>
> So, it seems that my concerns don't have strong grounds and per-CPU
> crypto_request allocation can be dropped/removed from tcp_sigpool once
> ciphers get crypto_clone_ahash() support.
>
> [1]: https://lore.kernel.org/all/ZDefxOq6Ax0JeTRH@gondor.apana.org.au/T/#=
u
> [2]: https://github.com/0x7f454c46/iperf/tree/tcp-md5-ao
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Acked-by: David Ahern <dsahern@kernel.org>
>

...

> +int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size)
> +{
> +       int i, ret;
> +
> +       /* slow-path */
> +       mutex_lock(&cpool_mutex);
> +       ret =3D sigpool_reserve_scratch(scratch_size);
> +       if (ret)
> +               goto out;
> +       for (i =3D 0; i < cpool_populated; i++) {
> +               if (!cpool[i].alg)
> +                       continue;
> +               if (strcmp(cpool[i].alg, alg))
> +                       continue;
> +
> +               if (kref_read(&cpool[i].kref) > 0)
> +                       kref_get(&cpool[i].kref);

This sequence is racy.

You must use kref_get_unless_zero().

> +               else
> +                       kref_init(&cpool[i].kref);
> +               ret =3D i;
> +               goto out;
> +       }
> +
> +

syzbot reported:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 2 PID: 31702 at lib/refcount.c:25
refcount_warn_saturate+0x1ca/0x210 lib/refcount.c:25
Modules linked in:
CPU: 2 PID: 31702 Comm: syz-executor.3 Not tainted
6.7.0-rc6-syzkaller-00044-g1a44b0073b92 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ca/0x210 lib/refcount.c:25
Code: ff 89 de e8 58 a3 25 fd 84 db 0f 85 e6 fe ff ff e8 1b a8 25 fd
c6 05 9a 88 a1 0a 01 90 48 c7 c7 00 9d 2e 8b e8 b7 ec eb fc 90 <0f> 0b
90 90 e9 c3 fe ff ff e8 f8 a7 25 fd c6 05 75 88 a1 0a 01 90
RSP: 0018:ffffc900296df850 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002c40a000
RDX: 0000000000040000 RSI: ffffffff814db526 RDI: 0000000000000001
RBP: ffffffff92b5b7b0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000010
R13: ffffffff92b5b7b0 R14: 0000000000000001 R15: 0000000000000000
FS: 0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:00000000f7efdb40
CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7354000 CR3: 0000000050ee3000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
__refcount_add include/linux/refcount.h:199 [inline]
__refcount_inc include/linux/refcount.h:250 [inline]
refcount_inc include/linux/refcount.h:267 [inline]
kref_get include/linux/kref.h:45 [inline]
tcp_sigpool_alloc_ahash+0x9cb/0xce0 net/ipv4/tcp_sigpool.c:166
tcp_md5_alloc_sigpool+0x1b/0x40 net/ipv4/tcp.c:4379
tcp_md5_do_add+0x192/0x460 net/ipv4/tcp_ipv4.c:1403
tcp_v6_parse_md5_keys+0x68d/0x860 net/ipv6/tcp_ipv6.c:676
do_tcp_setsockopt+0x1302/0x2880 net/ipv4/tcp.c:3644
tcp_setsockopt+0xd4/0x100 net/ipv4/tcp.c:3726
do_sock_setsockopt+0x222/0x470 net/socket.c:2311
__sys_setsockopt+0x1a6/0x270 net/socket.c:2334
__do_sys_setsockopt net/socket.c:2343 [inline]
__se_sys_setsockopt net/socket.c:2340 [inline]
__ia32_sys_setsockopt+0xbc/0x150 net/socket.c:2340
do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
__do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:321
do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
entry_SYSENTER_compat_after_hwframe+0x70/0x7a
RIP: 0023:0xf7f02579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00
00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a
59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7efd5ac EFLAGS: 00000292 ORIG_RAX: 000000000000016e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000006
RDX: 000000000000000e RSI: 0000000020000000 RDI: 00000000000000d8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

