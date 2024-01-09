Return-Path: <linux-kernel+bounces-21143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AEF828AAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460D4B24867
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A53A8E2;
	Tue,  9 Jan 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pmanODW3"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154F3A8CA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A5A0D3F286
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704819914;
	bh=mvuBAN5vY5BSs05ydQn6t4RSmM2z+OLVW9ZETHmicAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=pmanODW3aK8J0KUM/0SMeXOzPjf4BiuOhf2Z8RsGaL32JOoYVToLEOufEkvwsEVoZ
	 0Fz0/KEoCSLd5oAwT4OGOIY7G0Du7Hizos/xgc5AhTzYZIBe0q4wbizog6yIbjYqP5
	 PJCQ1u70dtCXGvN2jhoXsBviD5gjrdczn3cYSLoW/719aATfw/YXJ5gz7zXJJpYgdv
	 9V5diejmsxxT89rNUXLpS/1DVo93TTG8ksZxyfKjkTTSbeq7mid9dTykwljz+qRp4P
	 222l2JPLRyC2ALfF5ls9xfYVw15agZefygmEhJpBgiDyRleC8Zx9VAE9rshklN92rg
	 QDo1PifGE/JPg==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e81d186e2so2666413e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 09:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819914; x=1705424714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvuBAN5vY5BSs05ydQn6t4RSmM2z+OLVW9ZETHmicAA=;
        b=myraUqAYFa8qwTsAF3Cvcqjc7WJEpTiCIvfCD6p2NYcw7DYx78M8feDPGBtM8rH8Ob
         ErCmzpVl1ewcBs64xsqCV/lqiC4GlQpyHG2HEWH2LhniQ6whZBQBHKEod+w4Iv+b9B6m
         leEfvujYy3FYPa8VljQh/iTBxhxLldlXLSu5ZD2bVqfn6OPY7i6tUouy68TwXmQUvlZY
         Ii9DrYfbk74+OmZRKf9qA60s4f8iBJNBRkKRc8CazTvxMcmLsPh8I84fx0lQaKmu8dCa
         3pQZo8IW4l/Gw7DRmoBeTGA+b7YdzEfsImJ+2xt8FphnZgk6NaBrrKnvgsurpPs6aCbf
         tUdg==
X-Gm-Message-State: AOJu0YwvtzfhP1MMDp8zT3+03YQf+kZu3fbRzZQIsuDowWMqGWY7M0HD
	AlVL4bQWTRhIZ6iKu2I42LfjJfcBDR8x9lYm6zpfvkowBWyEsk185q+GhdISblpsn4z9NyqEg12
	9/tQu908SqpaZSI0XjKyXtsz4q/bZP+uy+7QnmXoXThVn6suxLcDNXMxT
X-Received: by 2002:a05:6512:31d6:b0:50e:7f67:b465 with SMTP id j22-20020a05651231d600b0050e7f67b465mr2829829lfe.81.1704819914039;
        Tue, 09 Jan 2024 09:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhaHCdJfN8iU/N41WmGuZJIfMnik+AGyk03qIRzCbPKB5k2jNvlV9MfKQ/KDyW405HOP1eyQ==
X-Received: by 2002:a05:6512:31d6:b0:50e:7f67:b465 with SMTP id j22-20020a05651231d600b0050e7f67b465mr2829818lfe.81.1704819913519;
        Tue, 09 Jan 2024 09:05:13 -0800 (PST)
Received: from localhost (host-87-18-244-72.retail.telecomitalia.it. [87.18.244.72])
        by smtp.gmail.com with ESMTPSA id gv2-20020a170906f10200b00a26a80a58fcsm1209076ejb.196.2024.01.09.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:05:13 -0800 (PST)
Date: Tue, 9 Jan 2024 18:05:09 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] kernfs: convert kernfs_idr_lock to an irq safe raw
 spinlock
Message-ID: <ZZ18xVq4GtQsTC8Z@gpd>
References: <20231229074916.53547-1-andrea.righi@canonical.com>
 <CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com>

On Tue, Jan 09, 2024 at 05:35:36PM +0100, Geert Uytterhoeven wrote:
..
> Thanks for your patch, which is now commit c312828c37a72fe2
> ("kernfs: convert kernfs_idr_lock to an irq safe raw spinlock")
> in driver-core/driver-core-next.
> 
> Unfortunately this interacts badly with commit 4eff7d62abdeb293 ("Revert
> "mm/kmemleak: move the initialisation of object to __link_object"")
> in v6.7-rc5.
> 
> driver-core/driver-core-next is still at v6.7-rc3, so it does not
> yet have commit 4eff7d62abdeb293, and thus still triggers:
> 
>     =============================
>     [ BUG: Invalid wait context ]
>     6.7.0-rc3-kzm9g-00052-gc312828c37a7 #576 Not tainted
>     -----------------------------
>     swapper/0 is trying to lock:
>     c0c6e3c4 (&zone->lock){....}-{3:3}, at: __rmqueue_pcplist+0x358/0x3c8
>     other info that might help us debug this:
>     context-{5:5}
>     3 locks held by swapper/0:
>      #0: c0bf35a0 (slab_mutex){....}-{4:4}, at:
> kmem_cache_create_usercopy+0xc8/0x2d0
>      #1: c0bfab0c (kmemleak_lock){....}-{2:2}, at: __create_object+0x2c/0x7c
>      #2: dfbc8c90 (&pcp->lock){....}-{3:3}, at:
> get_page_from_freelist+0x1a0/0x684
>     stack backtrace:
>     CPU: 0 PID: 0 Comm: swapper Not tainted
> 6.7.0-rc3-kzm9g-00052-gc312828c37a7 #576
>     Hardware name: Generic SH73A0 (Flattened Device Tree)
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x68/0x90
>      dump_stack_lvl from __lock_acquire+0x3cc/0x168c
>      __lock_acquire from lock_acquire+0x274/0x30c
>      lock_acquire from _raw_spin_lock_irqsave+0x50/0x64
>      _raw_spin_lock_irqsave from __rmqueue_pcplist+0x358/0x3c8
>      __rmqueue_pcplist from get_page_from_freelist+0x3bc/0x684
>      get_page_from_freelist from __alloc_pages+0xe8/0xad8
>      __alloc_pages from __stack_depot_save+0x160/0x398
>      __stack_depot_save from set_track_prepare+0x48/0x74
>      set_track_prepare from __link_object+0xac/0x204
>      __link_object from __create_object+0x48/0x7c
>      __create_object from kmemleak_alloc+0x2c/0x38
>      kmemleak_alloc from slab_post_alloc_hook.constprop.0+0x9c/0xac
>      slab_post_alloc_hook.constprop.0 from kmem_cache_alloc+0xcc/0x148
>      kmem_cache_alloc from kmem_cache_create_usercopy+0x1c4/0x2d0
>      kmem_cache_create_usercopy from kmem_cache_create+0x1c/0x24
>      kmem_cache_create from kmemleak_init+0x58/0xfc
>      kmemleak_init from mm_core_init+0x244/0x2c8
>      mm_core_init from start_kernel+0x274/0x528
>      start_kernel from 0x0
> 
> After merging driver-core/driver-core-next into a tree based on
> v6.7-rc5, or after cherry-picking commit 4eff7d62abdeb293 into
> driver-core/driver-core-next, the above BUG is gone, but a different
> one appears:
> 
>     =============================
>     [ BUG: Invalid wait context ]
>     6.7.0-rc5-kzm9g-00251-g655022a45b1c #578 Not tainted
>     -----------------------------
>     swapper/0/0 is trying to lock:
>     dfbcd488 (&c->lock){....}-{3:3}, at: local_lock_acquire+0x0/0xa4
>     other info that might help us debug this:
>     context-{5:5}
>     2 locks held by swapper/0/0:
>      #0: dfbc9c60 (lock){+.+.}-{3:3}, at: local_lock_acquire+0x0/0xa4
>      #1: c0c012a8 (kernfs_idr_lock){....}-{2:2}, at:
> __kernfs_new_node.constprop.0+0x68/0x258
>     stack backtrace:
>     CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.7.0-rc5-kzm9g-00251-g655022a45b1c #578
>     Hardware name: Generic SH73A0 (Flattened Device Tree)
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x68/0x90
>      dump_stack_lvl from __lock_acquire+0x3cc/0x168c
>      __lock_acquire from lock_acquire+0x274/0x30c
>      lock_acquire from local_lock_acquire+0x28/0xa4
>      local_lock_acquire from ___slab_alloc+0x234/0x8a8
>      ___slab_alloc from __slab_alloc.constprop.0+0x30/0x44
>      __slab_alloc.constprop.0 from kmem_cache_alloc+0x7c/0x148
>      kmem_cache_alloc from radix_tree_node_alloc.constprop.0+0x44/0xdc
>      radix_tree_node_alloc.constprop.0 from idr_get_free+0x110/0x2b8
>      idr_get_free from idr_alloc_u32+0x9c/0x108
>      idr_alloc_u32 from idr_alloc_cyclic+0x50/0xb8
>      idr_alloc_cyclic from __kernfs_new_node.constprop.0+0x88/0x258
>      __kernfs_new_node.constprop.0 from kernfs_create_root+0xbc/0x154
>      kernfs_create_root from sysfs_init+0x18/0x5c
>      sysfs_init from mnt_init+0xc4/0x220
>      mnt_init from vfs_caches_init+0x6c/0x88
>      vfs_caches_init from start_kernel+0x474/0x528
>      start_kernel from 0x0
> 
> Reverting commit c312828c37a72fe2 fixes that.
> I have seen this issue on several Renesas arm32 and arm64 platforms.
> 
> Also, I am wondering if the issue fixed by commit c312828c37a72fe2
> can still be reproduced on v6.7-rc5 or later?

Yep, I can still reproduce it (this is with v6.7):

[    3.082273] 
[    3.082822] =====================================================
[    3.084543] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[    3.086252] 6.7.0-virtme #4 Not tainted
[    3.087002] -----------------------------------------------------
[    3.087385] swapper/5/0 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[    3.087768] ffffffff8f9c5378 (kernfs_idr_lock){+.+.}-{2:2}, at: kernfs_find_and_get_node_by_id+0x1d/0x80
[    3.088335] 
[    3.088335] and this task is already holding:
[    3.088685] ffff8a83becbf758 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0xda/0xef0
[    3.089128] which would create a new lock dependency:
[    3.089435]  (&rq->__lock){-.-.}-{2:2} -> (kernfs_idr_lock){+.+.}-{2:2}
[    3.089827] 
[    3.089827] but this new dependency connects a HARDIRQ-irq-safe lock:
[    3.090296]  (&rq->__lock){-.-.}-{2:2}
[    3.090297] 
[    3.090297] ... which became HARDIRQ-irq-safe at:
[    3.090885]   lock_acquire+0xcb/0x2c0
[    3.091108]   _raw_spin_lock_nested+0x2e/0x40
[    3.091374]   scheduler_tick+0x5b/0x3d0
[    3.091607]   update_process_times+0x9c/0xb0
[    3.091867]   tick_periodic+0x27/0xe0
[    3.092089]   tick_handle_periodic+0x24/0x70
[    3.092351]   timer_interrupt+0x18/0x30
[    3.092585]   __handle_irq_event_percpu+0x8b/0x240
[    3.092865]   handle_irq_event+0x38/0x80
[    3.093095]   handle_level_irq+0x90/0x170
[    3.093340]   __common_interrupt+0x4a/0xf0
[    3.093586]   common_interrupt+0x83/0xa0
[    3.093820]   asm_common_interrupt+0x26/0x40
[    3.094080]   _raw_spin_unlock_irqrestore+0x36/0x70
[    3.094381]   __setup_irq+0x441/0x6a0
[    3.094602]   request_threaded_irq+0xe5/0x190
[    3.094862]   hpet_time_init+0x3a/0x60
[    3.095090]   x86_late_time_init+0x1b/0x40
[    3.095344]   start_kernel+0x53a/0x6a0
[    3.095569]   x86_64_start_reservations+0x18/0x30
[    3.095849]   x86_64_start_kernel+0xc5/0xe0
[    3.096097]   secondary_startup_64_no_verify+0x178/0x17b
[    3.096426] 
[    3.096426] to a HARDIRQ-irq-unsafe lock:
[    3.096749]  (kernfs_idr_lock){+.+.}-{2:2}
[    3.096751] 
[    3.096751] ... which became HARDIRQ-irq-unsafe at:
[    3.097372] ...
[    3.097372]   lock_acquire+0xcb/0x2c0
[    3.097701]   _raw_spin_lock+0x30/0x40
[    3.097925]   __kernfs_new_node.isra.0+0x83/0x280
[    3.098205]   kernfs_create_root+0xf6/0x1d0
[    3.098463]   sysfs_init+0x1b/0x70
[    3.098670]   mnt_init+0xd9/0x2a0
[    3.098872]   vfs_caches_init+0xcf/0xe0
[    3.099105]   start_kernel+0x58a/0x6a0
[    3.099334]   x86_64_start_reservations+0x18/0x30
[    3.099613]   x86_64_start_kernel+0xc5/0xe0
[    3.099862]   secondary_startup_64_no_verify+0x178/0x17b
[    3.100175] 
[    3.100175] other info that might help us debug this:
[    3.100175] 
[    3.100652]  Possible interrupt unsafe locking scenario:
[    3.100652] 
[    3.101049]        CPU0                    CPU1
[    3.101323]        ----                    ----
[    3.101641]   lock(kernfs_idr_lock);
[    3.101909]                                local_irq_disable();
[    3.102473]                                lock(&rq->__lock);
[    3.102854]                                lock(kernfs_idr_lock);
[    3.103171]   <Interrupt>
[    3.103308]     lock(&rq->__lock);
[    3.103492] 
[    3.103492]  *** DEADLOCK ***

I'm wondering if using a regular spinlock instead of a raw spinlock
could be a reasonable compromise.

We have a GFP_ATOMIC allocation in __kernfs_new_node():

	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
	...
        raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);

That should become valid using a
spin_lock_irqsave/spin_unlock_irqrestore(), right?

Thanks,
-Andrea

> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

