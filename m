Return-Path: <linux-kernel+bounces-14371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA955821C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30601C22019
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D382FBE5;
	Tue,  2 Jan 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJHGEaWc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22211FBEF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704200634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZHQeFJ9+xDphJ1W1jwrdA5rb3EEwtQxlJ+SLsFMF2s=;
	b=dJHGEaWcH87JP/luJuuoyk1+tjEHe5MyuNu1NE0xOqHDIU8W/n2tGbhBKHgcJ4Tj0M3ryz
	OxXILBYX4Cbjm3DebSQ9qSwhSwg96tS7JttOC+z+D5JRU8Olbqg2AsC8nwqY8JaVMv4++s
	Y7JFCzc8fYrYh5Ppx0xhP+hbnObSypY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-XFHhkFobPsGRgotFM2HCjA-1; Tue, 02 Jan 2024 08:03:52 -0500
X-MC-Unique: XFHhkFobPsGRgotFM2HCjA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d2f7007e6so89837585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200631; x=1704805431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZHQeFJ9+xDphJ1W1jwrdA5rb3EEwtQxlJ+SLsFMF2s=;
        b=t2VjKMWoTc1YUuFBU7YhmR7W/UmfafCb79MLdXpvvYRaVWdBhDiNjGaVNO653VD077
         qzUkGE5DgbJrRB3cR5Qcfe6YRaMn7NjZwapojKxtCBFO1mfeqN4oB/MlGKMTqsn1/QJW
         cyelIPngGEP5TLZtHtGCa9gK6D9U7nJ0dQ3JYJpAtNxeicK6zYv+ZrdE6ypr/xfWeVxG
         PaEnEzAEnH5hRBPE63EyMxofAMN9u1TEVxdvMsnzhsopptpexFp6iCtOVdsZx6oj/Q/K
         UQYBEpos7R4IQ6vop9BDToD7JoMzbB1Wo8caYjb2HZWYwTfMjAvlnrJ6Ft1Hl94Q31T5
         kD7Q==
X-Gm-Message-State: AOJu0Yzok/OGDPtucj5mPSfMMHHZ1fgYYmxUP680Hf7BiXDfWgz7OujC
	YwMISmJ/UgHToYEkk1H30dYH5cfF0Iih4vVd9ApBAECDY/Q0S4Cd+9L105nRW2xGekaVH5m56/G
	HGDyj7N9POrIwYIw+ba1wluMuoAOkKJ4N
X-Received: by 2002:a05:600c:2941:b0:40d:60ce:1697 with SMTP id n1-20020a05600c294100b0040d60ce1697mr4857031wmd.38.1704200631081;
        Tue, 02 Jan 2024 05:03:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo1FnV9NbSBWDpYi/MCasU0ypmWC6DuBkYNBful7AvntB6YLW0s7/hA1vBDTNeGVKryCyDxQ==
X-Received: by 2002:a05:600c:2941:b0:40d:60ce:1697 with SMTP id n1-20020a05600c294100b0040d60ce1697mr4857022wmd.38.1704200630729;
        Tue, 02 Jan 2024 05:03:50 -0800 (PST)
Received: from redhat.com ([2.52.0.21])
        by smtp.gmail.com with ESMTPSA id a15-20020adfed0f000000b00336673a4153sm28382839wro.80.2024.01.02.05.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:03:50 -0800 (PST)
Date: Tue, 2 Jan 2024 08:03:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, bonzini@redhat.com, stefanha@redhat.com
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Message-ID: <20240102080315-mutt-send-email-mst@kernel.org>
References: <000000000000fd588e060de27ef4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fd588e060de27ef4@google.com>

On Mon, Jan 01, 2024 at 05:38:24AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=173df3e9e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
> dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1300b4a1e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b0379e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
> BUG: KMSAN: uninit-value in virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
> BUG: KMSAN: uninit-value in virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
>  vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
>  virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
>  virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
>  virtqueue_add_sgs+0x186/0x1a0 drivers/virtio/virtio_ring.c:2244
>  __virtscsi_add_cmd drivers/scsi/virtio_scsi.c:467 [inline]
>  virtscsi_add_cmd+0x838/0xad0 drivers/scsi/virtio_scsi.c:501
>  virtscsi_queuecommand+0x896/0xa60 drivers/scsi/virtio_scsi.c:598
>  scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1516 [inline]
>  scsi_queue_rq+0x4874/0x5790 drivers/scsi/scsi_lib.c:1758
>  blk_mq_dispatch_rq_list+0x13f8/0x3600 block/blk-mq.c:2049
>  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
>  blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
>  __blk_mq_sched_dispatch_requests+0x10af/0x2500 block/blk-mq-sched.c:309
>  blk_mq_sched_dispatch_requests+0x160/0x2d0 block/blk-mq-sched.c:333
>  blk_mq_run_work_fn+0xd0/0x280 block/blk-mq.c:2434
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
>  worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
>  kthread+0x3ed/0x540 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> Uninit was created at:
>  __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
>  alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
>  alloc_pages mm/mempolicy.c:2204 [inline]
>  folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
>  filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
>  __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
>  ext4_da_write_begin+0x7f8/0xec0 fs/ext4/inode.c:2891
>  generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
>  ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
>  ext4_file_write_iter+0x20f/0x3460
>  __kernel_write_iter+0x329/0x930 fs/read_write.c:517
>  dump_emit_page fs/coredump.c:888 [inline]
>  dump_user_range+0x593/0xcd0 fs/coredump.c:915
>  elf_core_dump+0x528d/0x5a40 fs/binfmt_elf.c:2077
>  do_coredump+0x32c9/0x4920 fs/coredump.c:764
>  get_signal+0x2185/0x2d10 kernel/signal.c:2890
>  arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
>  exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
>  irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
>  irqentry_exit+0x16/0x40 kernel/entry/common.c:412
>  exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1564
>  asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570
> 
> Bytes 0-4095 of 4096 are uninitialized
> Memory access of size 4096 starts at ffff88812c79c000
> 
> CPU: 0 PID: 997 Comm: kworker/0:1H Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Workqueue: kblockd blk_mq_run_work_fn
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


