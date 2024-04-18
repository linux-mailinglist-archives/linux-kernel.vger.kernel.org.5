Return-Path: <linux-kernel+bounces-150868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F38AA607
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658081F224E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA579949;
	Thu, 18 Apr 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHzz0lqB"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C329CEF;
	Thu, 18 Apr 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713484091; cv=none; b=Ni8fSaZ8xBw8rlvtk8Eygb4yQ2DhRrgeExveY5cQu4T1Nt+Ha6L6Q+OJ++iGx26mjqOkOjbTpjsG5EjKrOjJAD5HpcT+Ynhbu0h0sbvAopV2cTiL23AsXijpkbgJbb9TB8daFi586qBpJdo9Ly2d9vPyXEjS/7pn2aC6fHrWyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713484091; c=relaxed/simple;
	bh=57Np717K4I4KqtlkBtE6WgtJrhVZMKWMg914ZwvSkUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LH/pnK1aQVl26wFI3aAV/k4vF6UOJm2Vi15zbh2j77whZyUUHPx59GxkqZqtFXwthUBe+oqYRnhQX178hD8KiHtuziCkMkNBNcRHZAcSIDvDIRgbTQYXY/YcFmHWJet8DWrgLwmn1EGeI/eXiDsyZBBIAG0xK6EzwMXbW36v9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHzz0lqB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2abf9305afcso773028a91.1;
        Thu, 18 Apr 2024 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713484089; x=1714088889; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+K9hen2L8ySBS0PPv8txFhb7gijrCCVm9+09/nYtBg=;
        b=YHzz0lqBOxYVq61pDaDbm2bSAz4JfGqn5wTENODKT0JXS1M7SU8kn3AHorwCNbk4jz
         oJOK0Ai0N02wbqFJ6pYsq0tfAd7EXy9V7I3dwhqdLsQMIkvvawgW5fZcofIJoBpYq3rX
         zXHoLe3yxnh22wcWp+yadccBonarw6/Fr+cJe1BSc1e+bnygSHOlEXBMf/qpNqDV414t
         CJWME5DJpGNyLnpPna5PRgtwuI9Thd+dQ8aOCsYc/GXy5+QaecNqPPF23TUCNidFy2Ol
         15HB/KnH6mntoiA1DG3XPdHGA6fSQzwFHtsvkFQmgkh9WtlWlYyTjSzk+qAzoSQprFxX
         mbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713484089; x=1714088889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+K9hen2L8ySBS0PPv8txFhb7gijrCCVm9+09/nYtBg=;
        b=G8VE/cEq+pmxOHTskzDaRAHnE9xATwEsZBFO+JT39EobWeYoQCrkVUh94XE6fPm60r
         E/0DLrhm1f1V7mJdofuVmUNnJ3ok18h1ABl+XAUZZd4VASh3Tyj5NJPmqIpFJzAgRr09
         uN7gsjzJrYPU4RH6E3XAQbXGirLdbWDBDfm3pNGX9o0xN0rEkY7WRSEZLLtuFSrnvxi9
         5LISd8NVRUn51MbxUikmSZf218Wrp/1Y51aF1jq0ER7LZ9fF+nBh7GytftVVzDjYk/Rw
         7HMvF8Jzx4iT2lm8LwJtA3kW3q6L7jybYEnlBpMcIIhaCQE/X/YOjeoRdm74jLsLInkz
         DJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzSDOztG0eaAdieL/RXcAHJNSRRZwl+eyooPyGn0Fp7jWIbv3h8DRTxyXKcAV0n387CMcDALG6CFwB4HPXca7LJVp/YHBi
X-Gm-Message-State: AOJu0Yz5JBSv0BQDH/NukQLuxuiCUOXlRq0/iFmY4TFcUGO2rLnx4ZZI
	2Q+KnBpVa6s/vHHskrrd8OWufP3Z7N4TLCNn6FrF0vWAoOX6Rh16
X-Google-Smtp-Source: AGHT+IEbbzUNtoOGcGZmv6VbbEwiQEAIUy1hPSWKA3AeufzMlk/Eswk0uRjVpnPG+vW06VMdSE4HzQ==
X-Received: by 2002:a17:90a:9291:b0:2a5:7e31:5030 with SMTP id n17-20020a17090a929100b002a57e315030mr667224pjo.15.1713484089131;
        Thu, 18 Apr 2024 16:48:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm2041896pjb.22.2024.04.18.16.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:48:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D85E218462BBF; Fri, 19 Apr 2024 06:48:05 +0700 (WIB)
Date: Fri, 19 Apr 2024 06:48:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
	j51569436@gmail.com
Subject: Fwd: UAF in sl_sync due to race condition
Message-ID: <ZiGxNQudF1nYkOmQ@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zq/5TwPUDfRF2Kdb"
Content-Disposition: inline


--Zq/5TwPUDfRF2Kdb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

<j51569436@gmail.com> reported on Bugzilla race bug on SLIP driver, which is
found with syzkaller [1].

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218713

The full stack trace was:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in sl_sync drivers/net/slip/slip.c:732 [i=
nline]
> BUG: KASAN: slab-use-after-free in slip_open+0xed9/0x1210 drivers/net/sli=
p/slip.c:806
> Read of size 4 at addr ffff88801a5fa0a8 by task syz-executor.1/296035
>=20
> CPU: 0 PID: 296035 Comm: syz-executor.1 Not tainted 6.8.0-rc5-dirty #283
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x37/0x50 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:488
>  kasan_report+0xb0/0xe0 mm/kasan/report.c:601
>  sl_sync drivers/net/slip/slip.c:732 [inline]
>  slip_open+0xed9/0x1210 drivers/net/slip/slip.c:806
>  tty_ldisc_open+0x9f/0x120 drivers/tty/tty_ldisc.c:432
>  tty_set_ldisc+0x2e7/0x680 drivers/tty/tty_ldisc.c:557
>  tiocsetd drivers/tty/tty_io.c:2439 [inline]
>  tty_ioctl+0x5c0/0x1590 drivers/tty/tty_io.c:2739
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x12d/0x1a0 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc0/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fc365c9128f
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 4=
4 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00=
 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> RSP: 002b:00007fc366a68f90 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000006900000000 RCX: 00007fc365c9128f
> RDX: 00007fc366a68ff4 RSI: 0000000000005423 RDI: 000000000000006a
> RBP: 000000000000006a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fc365dee040 R15: 00007fc366a49000
>  </TASK>
>=20
> Allocated by task 296005:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:3981 [inline]
>  __kmalloc_node+0x208/0x540 mm/slub.c:3988
>  kvmalloc include/linux/slab.h:728 [inline]
>  kvzalloc include/linux/slab.h:736 [inline]
>  alloc_netdev_mqs+0x5f/0x11d0 net/core/dev.c:10826
>  sl_alloc drivers/net/slip/slip.c:756 [inline]
>  slip_open+0x371/0x1210 drivers/net/slip/slip.c:817
>  tty_ldisc_open+0x9f/0x120 drivers/tty/tty_ldisc.c:432
>  tty_set_ldisc+0x2e7/0x680 drivers/tty/tty_ldisc.c:557
>  tiocsetd drivers/tty/tty_io.c:2439 [inline]
>  tty_ioctl+0x5c0/0x1590 drivers/tty/tty_io.c:2739
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x12d/0x1a0 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc0/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
>=20
> Freed by task 296004:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
>  poison_slab_object mm/kasan/common.c:241 [inline]
>  poison_slab_object+0x102/0x190 mm/kasan/common.c:212
>  __kasan_slab_free+0x37/0x80 mm/kasan/common.c:257
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2121 [inline]
>  slab_free mm/slub.c:4299 [inline]
>  kfree+0xfb/0x350 mm/slub.c:4409
>  device_release+0x97/0x210 drivers/base/core.c:2499
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x143/0x3f0 lib/kobject.c:737
>  netdev_run_todo+0x535/0xd40 net/core/dev.c:10581
>  slip_close drivers/net/slip/slip.c:906 [inline]
>  slip_hangup+0x165/0x1c0 drivers/net/slip/slip.c:912
>  tty_ldisc_hangup+0x1dd/0x700 drivers/tty/tty_ldisc.c:699
>  __tty_hangup.part.0+0x4d4/0x9b0 drivers/tty/tty_io.c:630
>  __tty_hangup drivers/tty/tty_io.c:585 [inline]
>  tty_vhangup+0x21/0x30 drivers/tty/tty_io.c:700
>  pty_close+0x3a3/0x4f0 drivers/tty/pty.c:79
>  tty_release+0x3a2/0x1390 drivers/tty/tty_io.c:1760
>  __fput+0x1fb/0xa90 fs/file_table.c:376
>  __do_sys_close fs/open.c:1554 [inline]
>  __se_sys_close fs/open.c:1539 [inline]
>  __x64_sys_close+0x78/0xd0 fs/open.c:1539
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc0/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
>=20
> The buggy address belongs to the object at ffff88801a5fa000
>  which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 168 bytes inside of
>  freed 4096-byte region [ffff88801a5fa000, ffff88801a5fb000)
>=20
> The buggy address belongs to the physical page:
> page:ffffea0000697e00 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x1a5f8
> head:ffffea0000697e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> memcg:ffff888026f825c1
> flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000840 ffff888010c4e500 ffffea00005eb600 0000000000000002
> raw: 0000000000000000 0000000000040004 00000001ffffffff ffff888026f825c1
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0=
(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|_=
_GFP_HARDWALL), pid 5568, tgid 5568 (systemd-udevd), ts 937169338299, free_=
ts 937110171114
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2dd/0x350 mm/page_alloc.c:1533
>  prep_new_page mm/page_alloc.c:1540 [inline]
>  get_page_from_freelist+0xd0a/0x3570 mm/page_alloc.c:3311
>  __alloc_pages+0x21f/0x1f30 mm/page_alloc.c:4567
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  alloc_slab_page mm/slub.c:2190 [inline]
>  allocate_slab mm/slub.c:2354 [inline]
>  new_slab+0xd3/0x3b0 mm/slub.c:2407
>  ___slab_alloc+0x679/0xba0 mm/slub.c:3540
>  __slab_alloc mm/slub.c:3625 [inline]
>  __slab_alloc_node mm/slub.c:3678 [inline]
>  slab_alloc_node mm/slub.c:3850 [inline]
>  __do_kmalloc_node mm/slub.c:3980 [inline]
>  __kmalloc_node+0x39e/0x540 mm/slub.c:3988
>  kvmalloc include/linux/slab.h:728 [inline]
>  seq_buf_alloc fs/seq_file.c:38 [inline]
>  seq_read_iter+0x6b0/0x10c0 fs/seq_file.c:210
>  call_read_iter include/linux/fs.h:2079 [inline]
>  new_sync_read fs/read_write.c:395 [inline]
>  vfs_read+0x4e9/0x8c0 fs/read_write.c:476
>  ksys_read+0xec/0x1c0 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc0/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> page last free pid 0 tgid 0 stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1140 [inline]
>  free_unref_page_prepare+0x5b8/0xbd0 mm/page_alloc.c:2346
>  free_unref_page+0x33/0x360 mm/page_alloc.c:2486
>  rcu_do_batch kernel/rcu/tree.c:2190 [inline]
>  rcu_core+0xe20/0x1930 kernel/rcu/tree.c:2465
>  __do_softirq+0x1a2/0x629 kernel/softirq.c:553
>=20
> Memory state around the buggy address:
>  ffff88801a5f9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88801a5fa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88801a5fa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                   ^
>  ffff88801a5fa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88801a5fa180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

He also posted C reproducers:

> slip_open calls sl_sync.=20
>=20
> ```c
> static int slip_open(struct tty_struct *tty)
> {
> 	struct slip *sl;
> 	int err;
>=20
> 	if (!capable(CAP_NET_ADMIN))
> 		return -EPERM;
>=20
> 	if (tty->ops->write =3D=3D NULL)
> 		return -EOPNOTSUPP;
>=20
> 	/* RTnetlink lock is misused here to serialize concurrent
> 	   opens of slip channels. There are better ways, but it is
> 	   the simplest one.
> 	 */
> 	rtnl_lock();
>=20
> 	/* Collect hanged up channels. */
> 	sl_sync();
> ...
>=20
> ```
>=20
> sl_sync declares the dev variable by referencing the global variable slip=
_devs. There is no lock to safely access the global variable.=20
>=20
> ```c
>=20
> /* Collect hanged up channels */
> static void sl_sync(void)
> {
> 	int i;
> 	struct net_device *dev;
> 	struct slip	  *sl;
>=20
> 	for (i =3D 0; i < slip_maxdev; i++) {
> 		dev =3D slip_devs[i];
> 		if (dev =3D=3D NULL)
> 			break;
>=20
> 		sl =3D netdev_priv(dev);
> 		if (sl->tty || sl->leased)//[1]
> 			continue;
> 		if (dev->flags & IFF_UP)
> 			dev_close(dev);
> 	}
> }
> ```
>=20
>=20
> slip_close call netdev_run_todo.=20
> [1] : call __rtnl_unlock
> [2] : call  sl_free_netdev. sl_free_netdev set slip_devs[i] to NULL;
> [3] : free slip_devs[i]
> ```c
> void netdev_run_todo(void)
> {
> 	struct net_device *dev, *tmp;
> 	struct list_head list;
> #ifdef CONFIG_LOCKDEP
> 	struct list_head unlink_list;
>=20
> 	list_replace_init(&net_unlink_list, &unlink_list);
>=20
> 	while (!list_empty(&unlink_list)) {
> 		struct net_device *dev =3D list_first_entry(&unlink_list,
> 							  struct net_device,
> 							  unlink_list);
> 		list_del_init(&dev->unlink_list);
> 		dev->nested_level =3D dev->lower_level - 1;
> 	}
> #endif
>=20
> 	/* Snapshot list, allow later requests */
> 	list_replace_init(&net_todo_list, &list);
>=20
> 	__rtnl_unlock();//[1]
>=20
> 	while (!list_empty(&list)) {
> ...
> 		if (dev->priv_destructor)//[2]
> 			dev->priv_destructor(dev);
> 		if (dev->needs_free_netdev)
> 			free_netdev(dev);
>=20
> 		if (atomic_dec_and_test(&dev_net(dev)->dev_unreg_count))
> 			wake_up(&netdev_unregistering_wq);
>=20
> 		/* Free network device */
> 		kobject_put(&dev->dev.kobj);//[3]
> 	}
> }
> ```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Zq/5TwPUDfRF2Kdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZiGxMQAKCRD2uYlJVVFO
oyISAQDjeYb40sKofPlG2A3Tq/SOvkpL66UanqW7NHbSuK8EKgD/RyIyTKl9u54Y
8bsL6ozSA0fPt0OnXujSgtXO6gQv7gw=
=BkXJ
-----END PGP SIGNATURE-----

--Zq/5TwPUDfRF2Kdb--

