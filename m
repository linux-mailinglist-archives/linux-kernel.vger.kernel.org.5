Return-Path: <linux-kernel+bounces-108240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBBB880848
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70858B220B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468295FBAC;
	Tue, 19 Mar 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDklg0bK"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0E5FBA2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892083; cv=none; b=kubMumRplPqEl0Nbm+HgM31qJiVKezBcGqrDKMMyJ/yMv1Hj9Ityj54jMyPpvU/Y4Lt77ZKo7P/GC5bnl92F8vLZnsAI2qVvTwhQ934u3Fz+MXbxTfGDDsRp+zueIIGejCn4dnUrCqvNETZ+UuS2pKCRPx89/9nO7yHkhHaRrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892083; c=relaxed/simple;
	bh=En7Zm9vveSmFCSyC51DiaULzkk+aQO3WBk1q2xCUNuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d96v2xQ6VagUFqDWtwe7GFn1iHsKDmvb1YfSrtfUxRTPc6c67qEPFeGNWQh8xK3AJTSPAvR0PKcOK7ofdOC8uNRha3+enl+16c2QMU27e1FmBD8N7H8SXu3MUdwfDFycaPdDoCTm1aC23ykmG6tlA9qF0U2RlFNH0DF9tCMa9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDklg0bK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3416df43cabso1633850f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710892079; x=1711496879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF+vHPHEf9YeLahZZShgwv2v9ZcnZC7w66VWnUTwgHE=;
        b=NDklg0bKaPo6IwIW46UYrO0adGIlnREDWWomQKOgAY6apY3gc31gl/VzMmSD75O81D
         SF96Pm1nR22C+EIxv55ZmBvLMJJnN9tvI3pMGtcDuLIdW0y/umkwIyBEX2ZdOhS0CYmX
         F90MVpnpv1wOI1yq7Hak4hYIqGucVTCR0TdbOZ8s8OVCaKXDf0SHnoqTjbydAzj4wvg9
         NV9anTOTnzrP12bEOL8WeObwkr2LGoe2jM4giV+CF6i/aLl+CuRWnq+tKB9yxJvtaTdL
         5x6MO9cVdzsStxCIADByOhdBVK1/bfVmxRZqXHHszJHa3CZ1GJ/HKy9kCIIpyDwzihJk
         1TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710892079; x=1711496879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lF+vHPHEf9YeLahZZShgwv2v9ZcnZC7w66VWnUTwgHE=;
        b=PoyvLxK4WoivUnkIfHUEBgkQ4dOvW+6kvsLy3H1e/+IXyNakHu+dBrYlmGui68xSnd
         9Lh8ojMiFyFPZQ2NCoq30PGiCXT/oDX+2WjTXQKtChFFclHY5Sfgu8HMUc+7/5s4B049
         S48aBBoMdtX8NB0yDgaF1FS4QOYHscR7uaqOxOD80YD1D3biGS4BG8PyOpLPHyGajKSK
         m/z9hLy/phAOHd+h5T6IZ+WDS4LfhHhDj1mD2PBL3rkd+cW0+22rPJ3a5E61ahT2drH+
         FOpumNBNXWQXV5TcO784UsEPlIOZTTukEGbTwXY9574ShHUfXsb9L1fyH1rJhV0wrqyG
         OWKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+bvfv1OAGd6zGjKYgLWgYlGJT4YDbL1PaaocwQ2aPotvI9ZI83eMjWcdbotNv076mKOvB2+POnbGNxj5DLTgRyxCNnEaFjaUOYPw7
X-Gm-Message-State: AOJu0YwpvAPX9AolB3dS+x0xUudfpkUoK1/cjkqKdiiZ99H9gpvXuaSB
	CRD8CvnVp6zRaZCx2je3kbzeaDqZ7iEYOC0h9Ktcvbr80C1Wn2iD62+Vmc6Wzpc3y25KgeK9FPb
	QRTn1ELCV2ru0fAir8ZudGCoDRz0fD3oedV7p
X-Google-Smtp-Source: AGHT+IF9YKylMKz4B+jT2x2r5YCy/s9u9lrBYM1Z3JFq6TC7eET5atpYROjdVKvqda5/Md5JxqQTtWIgnHCaKm8cIWQ=
X-Received: by 2002:a05:6000:d04:b0:33d:8c86:e859 with SMTP id
 dt4-20020a0560000d0400b0033d8c86e859mr10469946wrb.60.1710892079417; Tue, 19
 Mar 2024 16:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e97f090614006d76@google.com> <b2a158a7-e0f1-42dc-9620-1d1d511d566f@redhat.com>
 <CA+EESO7zV9+yh-M23L_-e5SFUMptSoucBqOWvhoD_yVY4kXK5w@mail.gmail.com>
In-Reply-To: <CA+EESO7zV9+yh-M23L_-e5SFUMptSoucBqOWvhoD_yVY4kXK5w@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 19 Mar 2024 16:47:47 -0700
Message-ID: <CA+EESO61dygnJyDLbXi=mf7H44+XTv+dQrkssJFaWpZrO8n1xw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in move_pages
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:24=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Tue, Mar 19, 2024 at 6:37=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 19.03.24 10:52, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09=
-36' ..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D160dc26e1=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4ffb85460=
6e658d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D49056626fe4=
1e01f2ba7
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10f467b=
9180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D173b7ac91=
80000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/7bc7510fe41f/non_bootable_disk-e5eb28f6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/a5c7ad05d6b2/vm=
linux-e5eb28f6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/531cb19176=
12/bzImage-e5eb28f6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > WARNING: possible recursive locking detected
> > > 6.8.0-syzkaller-09791-ge5eb28f6d1af #0 Not tainted
> > > --------------------------------------------
> > > syz-executor258/5169 is trying to acquire lock:
> > > ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_loc=
k mm/userfaultfd.c:1447 [inline]
> > > ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0x=
bab/0x4970 mm/userfaultfd.c:1583
> > >
> > > but task is already holding lock:
> > > ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_loc=
k mm/userfaultfd.c:1445 [inline]
> > > ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0x=
b6f/0x4970 mm/userfaultfd.c:1583
> > >
> > > other info that might help us debug this:
> > >   Possible unsafe locking scenario:
> > >
> > >         CPU0
> > >         ----
> > >    lock(&vma->vm_lock->lock);
> > >    lock(&vma->vm_lock->lock);
> > >
> > >   *** DEADLOCK ***
> > >
> > >   May be due to missing lock nesting notation
> > >
> > > 2 locks held by syz-executor258/5169:
> > >   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lo=
ck include/linux/mmap_lock.h:146 [inline]
> > >   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: uffd_move_lo=
ck mm/userfaultfd.c:1438 [inline]
> > >   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: move_pages+0=
x8df/0x4970 mm/userfaultfd.c:1583
> > >   #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_mo=
ve_lock mm/userfaultfd.c:1445 [inline]
> > >   #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pa=
ges+0xb6f/0x4970 mm/userfaultfd.c:1583
> > >
> > > stack backtrace:
> > > CPU: 2 PID: 5169 Comm: syz-executor258 Not tainted 6.8.0-syzkaller-09=
791-ge5eb28f6d1af #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debia=
n-1.16.2-1 04/01/2014
> > > Call Trace:
> > >   <TASK>
> > >   __dump_stack lib/dump_stack.c:88 [inline]
> > >   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> > >   check_deadlock kernel/locking/lockdep.c:3062 [inline]
> > >   validate_chain kernel/locking/lockdep.c:3856 [inline]
> > >   __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
> > >   lock_acquire kernel/locking/lockdep.c:5754 [inline]
> > >   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
> > >   down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
> > >   uffd_move_lock mm/userfaultfd.c:1447 [inline]
> > >   move_pages+0xbab/0x4970 mm/userfaultfd.c:1583
> > >   userfaultfd_move fs/userfaultfd.c:2008 [inline]
> > >   userfaultfd_ioctl+0x5e1/0x60e0 fs/userfaultfd.c:2126
> > >   vfs_ioctl fs/ioctl.c:51 [inline]
> > >   __do_sys_ioctl fs/ioctl.c:904 [inline]
> > >   __se_sys_ioctl fs/ioctl.c:890 [inline]
> > >   __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
> > >   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > RIP: 0033:0x7fd48da20329
> > > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffd1244f8e8 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 00007ffd1244fab8 RCX: 00007fd48da20329
> > > RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
> > > RBP: 00007fd48da93610 R08: 00007ffd1244fab8 R09: 00007ffd1244fab8
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > R13: 00007ffd1244faa8 R14: 0000000000000001 R15: 0000000000000001
> > >   </TASK>
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >
> >
> > Possibly
> >
> > commit 867a43a34ff8a38772212045262b2c9b77807ea3
> > Author: Lokesh Gidra <lokeshgidra@google.com>
> > Date:   Thu Feb 15 10:27:56 2024 -0800
> >
> >      userfaultfd: use per-vma locks in userfaultfd operations
> >
> >      All userfaultfd operations, except write-protect, opportunisticall=
y use
> >      per-vma locks to lock vmas.  On failure, attempt again inside mmap=
_lock
> >      critical section.
> >
> >      Write-protect operation requires mmap_lock as it iterates over mul=
tiple
> >      vmas.
> >
> > and
> >
> > commit 5e4c24a57b0c126686534b5b159a406c5dd02400
> > Author: Lokesh Gidra <lokeshgidra@google.com>
> > Date:   Thu Feb 15 10:27:54 2024 -0800
> >
> >      userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
> >
> >      Increments and loads to mmap_changing are always in mmap_lock crit=
ical
> >      section.  This ensures that if userspace requests event notificati=
on for
> >      non-cooperative operations (e.g.  mremap), userfaultfd operations =
don't
> >      occur concurrently.
> >
> >      This can be achieved by using a separate read-write semaphore in
> >      userfaultfd_ctx such that increments are done in write-mode and lo=
ads in
> >      read-mode, thereby eliminating the dependency on mmap_lock for thi=
s
> >      purpose.
> >
> >      This is a preparatory step before we replace mmap_lock usage with =
per-vma
> >      locks in fill/move ioctls.
> >
> > might responsible.
> >
I tried reproducing the issue with the provided reproducer locally and
with few additional checks:

down_read(&(*dst_vmap)->vm_lock->lock);
if (*dst_vmap !=3D *src_vmap) {
            BUG_ON((*src_vmap)->vm_lock =3D=3D (*dst_vmap)->vm_lock);
            BUG_ON(&(*src_vmap)->vm_lock->lock =3D=3D &(*dst_vmap)->vm_lock=
->lock);
            BUG_ON(rwsem_is_locked(&(*src_vmap)->vm_lock->lock));
            down_read(&(*src_vmap)->vm_lock->lock);
}

None of the BUG_ONs are causing pani but the following down_read() is
reporting the deadlock as above. Even if I change the if condition to

if (&(*dst_vmap)->vm_lock->lock !=3D &(*src_vmap)->vm_lock->lock)

I still get the deadlock trace. Possibly a bug in lockdep?




> > CCin Lokesh
>
> Thanks for looping me in. Taking a look.
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

