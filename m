Return-Path: <linux-kernel+bounces-17204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4C8249BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4132FB22816
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9E1E52B;
	Thu,  4 Jan 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwKJoJtw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4E1E517
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704401137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JTU9XHak2ephYeTO61ZRd9/X4Vs2q0I/imNuUJpI0mI=;
	b=VwKJoJtwsMT2lb0o+msKi/0wjv8wZOzHPx/c0DXogymzAIyDQhSJAZgfIK+10iCv8qHGW4
	GyDUc5dbohPBAM9CYLjsL8ITPkH22+uB7jb9VY+JounPhfIaE/TMgl/80VvAlMnm9NDFWp
	5lU7ltz+GJrh6R8FKFixJ34RbIkT87M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-PUDaQFKpPSqLFziw-JD2ZA-1; Thu,
 04 Jan 2024 15:45:33 -0500
X-MC-Unique: PUDaQFKpPSqLFziw-JD2ZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621A729AA3BB;
	Thu,  4 Jan 2024 20:45:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B12931C060AF;
	Thu,  4 Jan 2024 20:45:32 +0000 (UTC)
Date: Thu, 4 Jan 2024 15:45:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, bonzini@redhat.com,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Message-ID: <20240104204531.GB954424@fedora>
References: <000000000000fd588e060de27ef4@google.com>
 <20240102080315-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8gbDFBVP1Dpt5/+r"
Content-Disposition: inline
In-Reply-To: <20240102080315-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


--8gbDFBVP1Dpt5/+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 08:03:46AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 01, 2024 at 05:38:24AM -0800, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.=
org..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D173df3e9e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078a6b9=
01aa3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e3841e=
d075a42
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1300b4a1e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D130b0379e80=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/d=
isk-fbafc3e6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmli=
nux-fbafc3e6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4=
/bzImage-fbafc3e6.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Hi Alexander,
Please take a look at this KMSAN failure. The uninitialized memory was
created for the purpose of writing a coredump. vring_map_one_sg() should
have direction=3DDMA_TO_DEVICE.

I can't easily tell whether this is a genuine bug or an issue with
commit 88938359e2df ("virtio: kmsan: check/unpoison scatterlist in
vring_map_one_sg()"). Maybe coredump.c is writing out pages that KMSAN
thinks are uninitialized?

Stefan

> > BUG: KMSAN: uninit-value in vring_map_one_sg drivers/virtio/virtio_ring=
=2Ec:380 [inline]
> > BUG: KMSAN: uninit-value in virtqueue_add_split drivers/virtio/virtio_r=
ing.c:614 [inline]
> > BUG: KMSAN: uninit-value in virtqueue_add+0x21c6/0x6530 drivers/virtio/=
virtio_ring.c:2210
> >  vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
> >  virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
> >  virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
> >  virtqueue_add_sgs+0x186/0x1a0 drivers/virtio/virtio_ring.c:2244
> >  __virtscsi_add_cmd drivers/scsi/virtio_scsi.c:467 [inline]
> >  virtscsi_add_cmd+0x838/0xad0 drivers/scsi/virtio_scsi.c:501
> >  virtscsi_queuecommand+0x896/0xa60 drivers/scsi/virtio_scsi.c:598
> >  scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1516 [inline]
> >  scsi_queue_rq+0x4874/0x5790 drivers/scsi/scsi_lib.c:1758
> >  blk_mq_dispatch_rq_list+0x13f8/0x3600 block/blk-mq.c:2049
> >  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
> >  blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
> >  __blk_mq_sched_dispatch_requests+0x10af/0x2500 block/blk-mq-sched.c:309
> >  blk_mq_sched_dispatch_requests+0x160/0x2d0 block/blk-mq-sched.c:333
> >  blk_mq_run_work_fn+0xd0/0x280 block/blk-mq.c:2434
> >  process_one_work kernel/workqueue.c:2627 [inline]
> >  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
> >  worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
> >  kthread+0x3ed/0x540 kernel/kthread.c:388
> >  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >=20
> > Uninit was created at:
> >  __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
> >  alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
> >  alloc_pages mm/mempolicy.c:2204 [inline]
> >  folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
> >  filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
> >  __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
> >  ext4_da_write_begin+0x7f8/0xec0 fs/ext4/inode.c:2891
> >  generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
> >  ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
> >  ext4_file_write_iter+0x20f/0x3460
> >  __kernel_write_iter+0x329/0x930 fs/read_write.c:517
> >  dump_emit_page fs/coredump.c:888 [inline]
> >  dump_user_range+0x593/0xcd0 fs/coredump.c:915
> >  elf_core_dump+0x528d/0x5a40 fs/binfmt_elf.c:2077
> >  do_coredump+0x32c9/0x4920 fs/coredump.c:764
> >  get_signal+0x2185/0x2d10 kernel/signal.c:2890
> >  arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
> >  exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
> >  exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
> >  irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
> >  irqentry_exit+0x16/0x40 kernel/entry/common.c:412
> >  exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1564
> >  asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570
> >=20
> > Bytes 0-4095 of 4096 are uninitialized
> > Memory access of size 4096 starts at ffff88812c79c000
> >=20
> > CPU: 0 PID: 997 Comm: kworker/0:1H Not tainted 6.7.0-rc7-syzkaller-0000=
3-gfbafc3e621c3 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 11/17/2023
> > Workqueue: kblockd blk_mq_run_work_fn
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >=20
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >=20
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >=20
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >=20
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >=20
> > If you want to undo deduplication, reply with:
> > #syz undup
>=20

--8gbDFBVP1Dpt5/+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWXGOsACgkQnKSrs4Gr
c8h//ggAykBGZ2OvGmuAvcSR+aFZJK1ce+2BUgvlfCbRz1rB2SuKASaH3gqoiet1
6wNUTpJoGbcXGJi/Vzw1mv8NmYwasf+UwJAN5dtl2ZL34a+QzszKHUpFjExxAU6C
TesfrMLBWTB4/chi1+ZKE36YOin6SeQZ8FqDnDFJ/DyGGR9A8LuebK2Y9UGM2shh
u1M/Jmpty1gYMiAtCJcQTJYZb5q/ZgB/IofK5UAK0Tjk2pXSJD1RsGaJCoe8lZVC
6o5IllaMgK9vVq7t1jmpsmV0mFbfA3hHpQ2LPp31O90lc4vXb9hueDybcsk5jx+m
5tyc4eqtcUaT4R5CKFfI7/+7V08c8g==
=mScI
-----END PGP SIGNATURE-----

--8gbDFBVP1Dpt5/+r--


