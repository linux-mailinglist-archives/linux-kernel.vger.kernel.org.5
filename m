Return-Path: <linux-kernel+bounces-21113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D65828A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946AD1F22025
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4963A8E5;
	Tue,  9 Jan 2024 16:35:53 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEC3A8D5;
	Tue,  9 Jan 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed5d2ad18so2430809276.0;
        Tue, 09 Jan 2024 08:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704818149; x=1705422949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Qa9DWnbwjx/k7ugqNI+qU1geD+bJA8DnKdzTNuHsJk=;
        b=SqybFPX06k5o6oQM6d0G0vMTeNqE33fyNfhSCdq0P+6f9+a1Pf9PPFJvt1Lf+H5Prq
         aDLfh5J74KYQaJcOzmhGLhmIfamWF7pCV1ewhB/w0rtOtyIeWvVt/ydiS+dZCwQlAnoq
         IBsepypffZOapHSYN2cxaox8KSaj0ydtOkUislJc08zenB35XG+OHI2z1aaAFJ188DTR
         9UTdcKmVuGa1JzNFQ9USd3ZfUmyAT6UXg4SZ5su6s3c5AiLrEIxyPVHoKUgP+rZ5pnXc
         LRWb6wjDmnhSjVoTO9iGFVSDpMJTSMaLlb2RDPkB1FbD086icZ03GVcwCxnL7BK8EQ3n
         U4Uw==
X-Gm-Message-State: AOJu0YxHnZOzixEpQhg8QP/jaDuv7JvjuymxrH/WR9s1JMHCvtGjZJNV
	waliDEbzbo5Jg4PrIYnJSYV+fS3kZfZDfsD3
X-Google-Smtp-Source: AGHT+IER1TZ6/6cZ6ZKlFfeXE6n50e/uF5QAVTD2rzp6CxVt73t5JgKva3ZV61KE5Wv2YHsTTO6jHQ==
X-Received: by 2002:a25:7448:0:b0:dbd:bc3e:55e3 with SMTP id p69-20020a257448000000b00dbdbc3e55e3mr2891316ybc.69.1704818149346;
        Tue, 09 Jan 2024 08:35:49 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id n7-20020a258087000000b00dbdb03e146bsm787681ybk.51.2024.01.09.08.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:35:48 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e7bb1e0db8so25448437b3.0;
        Tue, 09 Jan 2024 08:35:48 -0800 (PST)
X-Received: by 2002:a0d:c407:0:b0:5e2:5d71:56c with SMTP id
 g7-20020a0dc407000000b005e25d71056cmr4209408ywd.32.1704818148221; Tue, 09 Jan
 2024 08:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229074916.53547-1-andrea.righi@canonical.com>
In-Reply-To: <20231229074916.53547-1-andrea.righi@canonical.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jan 2024 17:35:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com>
Message-ID: <CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com>
Subject: Re: [PATCH] kernfs: convert kernfs_idr_lock to an irq safe raw spinlock
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Fri, Dec 29, 2023 at 8:56=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
> bpf_cgroup_from_id() is basically a wrapper to cgroup_get_from_id(),
> that is relying on kernfs to determine the right cgroup associated to
> the target id.
>
> As a kfunc, it has the potential to be attached to any function through
> BPF, particularly in contexts where certain locks are held.
>
> However, kernfs is not using an irq safe spinlock for kernfs_idr_lock,
> that means any kernfs function that is acquiring this lock can be
> interrupted and potentially hit bpf_cgroup_from_id() in the process,
> triggering a deadlock.
>
> For example, it is really easy to trigger a lockdep splat between
> kernfs_idr_lock and rq->_lock, attaching a small BPF program to
> __set_cpus_allowed_ptr_locked() that just calls bpf_cgroup_from_id():
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>  WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>  6.7.0-rc7-virtme #5 Not tainted
>  -----------------------------------------------------
>  repro/131 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  ffffffffb2dc4578 (kernfs_idr_lock){+.+.}-{2:2}, at: kernfs_find_and_get_=
node_by_id+0x1d/0x80
>
>  and this task is already holding:
>  ffff911cbecaf218 (&rq->__lock){-.-.}-{2:2}, at: task_rq_lock+0x50/0xc0
>  which would create a new lock dependency:
>   (&rq->__lock){-.-.}-{2:2} -> (kernfs_idr_lock){+.+.}-{2:2}
>
>  but this new dependency connects a HARDIRQ-irq-safe lock:
>   (&rq->__lock){-.-.}-{2:2}
>
>  ... which became HARDIRQ-irq-safe at:
>    lock_acquire+0xbf/0x2b0
>    _raw_spin_lock_nested+0x2e/0x40
>    scheduler_tick+0x5d/0x170
>    update_process_times+0x9c/0xb0
>    tick_periodic+0x27/0xe0
>    tick_handle_periodic+0x24/0x70
>    __sysvec_apic_timer_interrupt+0x64/0x1a0
>    sysvec_apic_timer_interrupt+0x6f/0x80
>    asm_sysvec_apic_timer_interrupt+0x1a/0x20
>    memcpy+0xc/0x20
>    arch_dup_task_struct+0x15/0x30
>    copy_process+0x1ce/0x1eb0
>    kernel_clone+0xac/0x390
>    kernel_thread+0x6f/0xa0
>    kthreadd+0x199/0x230
>    ret_from_fork+0x31/0x50
>    ret_from_fork_asm+0x1b/0x30
>
>  to a HARDIRQ-irq-unsafe lock:
>   (kernfs_idr_lock){+.+.}-{2:2}
>
>  ... which became HARDIRQ-irq-unsafe at:
>  ...
>    lock_acquire+0xbf/0x2b0
>    _raw_spin_lock+0x30/0x40
>    __kernfs_new_node.isra.0+0x83/0x280
>    kernfs_create_root+0xf6/0x1d0
>    sysfs_init+0x1b/0x70
>    mnt_init+0xd9/0x2a0
>    vfs_caches_init+0xcf/0xe0
>    start_kernel+0x58a/0x6a0
>    x86_64_start_reservations+0x18/0x30
>    x86_64_start_kernel+0xc5/0xe0
>    secondary_startup_64_no_verify+0x178/0x17b
>
>  other info that might help us debug this:
>
>   Possible interrupt unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(kernfs_idr_lock);
>                                 local_irq_disable();
>                                 lock(&rq->__lock);
>                                 lock(kernfs_idr_lock);
>    <Interrupt>
>      lock(&rq->__lock);
>
>   *** DEADLOCK ***
>
> Prevent this deadlock condition converting kernfs_idr_lock to a raw irq
> safe spinlock.
>
> The performance impact of this change should be negligible and it also
> helps to prevent similar deadlock conditions with any other subsystems
> that may depend on kernfs.
>
> Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Thanks for your patch, which is now commit c312828c37a72fe2
("kernfs: convert kernfs_idr_lock to an irq safe raw spinlock")
in driver-core/driver-core-next.

Unfortunately this interacts badly with commit 4eff7d62abdeb293 ("Revert
"mm/kmemleak: move the initialisation of object to __link_object"")
in v6.7-rc5.

driver-core/driver-core-next is still at v6.7-rc3, so it does not
yet have commit 4eff7d62abdeb293, and thus still triggers:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
    [ BUG: Invalid wait context ]
    6.7.0-rc3-kzm9g-00052-gc312828c37a7 #576 Not tainted
    -----------------------------
    swapper/0 is trying to lock:
    c0c6e3c4 (&zone->lock){....}-{3:3}, at: __rmqueue_pcplist+0x358/0x3c8
    other info that might help us debug this:
    context-{5:5}
    3 locks held by swapper/0:
     #0: c0bf35a0 (slab_mutex){....}-{4:4}, at:
kmem_cache_create_usercopy+0xc8/0x2d0
     #1: c0bfab0c (kmemleak_lock){....}-{2:2}, at: __create_object+0x2c/0x7=
c
     #2: dfbc8c90 (&pcp->lock){....}-{3:3}, at:
get_page_from_freelist+0x1a0/0x684
    stack backtrace:
    CPU: 0 PID: 0 Comm: swapper Not tainted
6.7.0-rc3-kzm9g-00052-gc312828c37a7 #576
    Hardware name: Generic SH73A0 (Flattened Device Tree)
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x68/0x90
     dump_stack_lvl from __lock_acquire+0x3cc/0x168c
     __lock_acquire from lock_acquire+0x274/0x30c
     lock_acquire from _raw_spin_lock_irqsave+0x50/0x64
     _raw_spin_lock_irqsave from __rmqueue_pcplist+0x358/0x3c8
     __rmqueue_pcplist from get_page_from_freelist+0x3bc/0x684
     get_page_from_freelist from __alloc_pages+0xe8/0xad8
     __alloc_pages from __stack_depot_save+0x160/0x398
     __stack_depot_save from set_track_prepare+0x48/0x74
     set_track_prepare from __link_object+0xac/0x204
     __link_object from __create_object+0x48/0x7c
     __create_object from kmemleak_alloc+0x2c/0x38
     kmemleak_alloc from slab_post_alloc_hook.constprop.0+0x9c/0xac
     slab_post_alloc_hook.constprop.0 from kmem_cache_alloc+0xcc/0x148
     kmem_cache_alloc from kmem_cache_create_usercopy+0x1c4/0x2d0
     kmem_cache_create_usercopy from kmem_cache_create+0x1c/0x24
     kmem_cache_create from kmemleak_init+0x58/0xfc
     kmemleak_init from mm_core_init+0x244/0x2c8
     mm_core_init from start_kernel+0x274/0x528
     start_kernel from 0x0

After merging driver-core/driver-core-next into a tree based on
v6.7-rc5, or after cherry-picking commit 4eff7d62abdeb293 into
driver-core/driver-core-next, the above BUG is gone, but a different
one appears:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
    [ BUG: Invalid wait context ]
    6.7.0-rc5-kzm9g-00251-g655022a45b1c #578 Not tainted
    -----------------------------
    swapper/0/0 is trying to lock:
    dfbcd488 (&c->lock){....}-{3:3}, at: local_lock_acquire+0x0/0xa4
    other info that might help us debug this:
    context-{5:5}
    2 locks held by swapper/0/0:
     #0: dfbc9c60 (lock){+.+.}-{3:3}, at: local_lock_acquire+0x0/0xa4
     #1: c0c012a8 (kernfs_idr_lock){....}-{2:2}, at:
__kernfs_new_node.constprop.0+0x68/0x258
    stack backtrace:
    CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.7.0-rc5-kzm9g-00251-g655022a45b1c #578
    Hardware name: Generic SH73A0 (Flattened Device Tree)
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x68/0x90
     dump_stack_lvl from __lock_acquire+0x3cc/0x168c
     __lock_acquire from lock_acquire+0x274/0x30c
     lock_acquire from local_lock_acquire+0x28/0xa4
     local_lock_acquire from ___slab_alloc+0x234/0x8a8
     ___slab_alloc from __slab_alloc.constprop.0+0x30/0x44
     __slab_alloc.constprop.0 from kmem_cache_alloc+0x7c/0x148
     kmem_cache_alloc from radix_tree_node_alloc.constprop.0+0x44/0xdc
     radix_tree_node_alloc.constprop.0 from idr_get_free+0x110/0x2b8
     idr_get_free from idr_alloc_u32+0x9c/0x108
     idr_alloc_u32 from idr_alloc_cyclic+0x50/0xb8
     idr_alloc_cyclic from __kernfs_new_node.constprop.0+0x88/0x258
     __kernfs_new_node.constprop.0 from kernfs_create_root+0xbc/0x154
     kernfs_create_root from sysfs_init+0x18/0x5c
     sysfs_init from mnt_init+0xc4/0x220
     mnt_init from vfs_caches_init+0x6c/0x88
     vfs_caches_init from start_kernel+0x474/0x528
     start_kernel from 0x0

Reverting commit c312828c37a72fe2 fixes that.
I have seen this issue on several Renesas arm32 and arm64 platforms.

Also, I am wondering if the issue fixed by commit c312828c37a72fe2
can still be reproduced on v6.7-rc5 or later?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

