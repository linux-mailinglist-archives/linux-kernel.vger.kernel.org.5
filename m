Return-Path: <linux-kernel+bounces-126818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5E893D04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44395280FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D746551;
	Mon,  1 Apr 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/HSUtqD"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150643AD6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986137; cv=none; b=PxkqGeh9Mq4aJSH6Hvc147yB8SHcgWJ/uiwR96bJbfpnbercwcK2tJJs7D4z3Jnz0w4Ks+O50tCtGofUnv6y31le6bWcJF/Yd1cdWccaASOCAbw/rlZU8kjhnD40dCYd8KomUVNUImqTKwDUIC6M5/w5LABnUj78jDqTaZ0PL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986137; c=relaxed/simple;
	bh=+kQPxI/4RHl486ZgrlG7pII1SlPzsVryoaETuocLo0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtHT1xhkY+evpOd9loMLX5lt+smd0rQ9AJLWf0mdJ/EyJVIgjeytOlWYxGdBZFNYyhCblNGdFx5G1FnhkYGdP6k51lpVag+phJJ3AoyMxjkEFWODDmf43fKrlKmtDbTPu0oob8XU657YwQvWZLMWAUsfsPmPw/Y09Tks+KZblvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/HSUtqD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0b889901bso32234105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711986135; x=1712590935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WxhPu0Op3B4BOpA1DIRcJgPgm8zZjzjZ6yp1VpFs5I=;
        b=G/HSUtqDZRO54iUPf4eVNp7WcTQyCDJ0LW4C5Ofo9OZu+0DKq7h7Hhv+OMSyaK40MM
         oItS7NDpG5doZE9A3oIVH/gD3hfEWPmojCSgi5LvSG6CUCgw8z3V3Bf/8grvK+mVoJLj
         E9cLgc2stAk6RLe9K49KOqzJ/8JoyTpS+5gc5Y111yQl8lZHX7cgcJTVndNj5itxQwQx
         lwPAquDaqOoOz4FxgxgZtLKS1dH22xwSnGCXiGfT62NktcY9rbtqcIdTDJYZwwMJdXZA
         IWiL16oIomNCBcr/ElTTEkpXCgvV97hLTirLWVqu8QsSFBfjwhyMh7vsD/vK/BzPYp73
         vW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986135; x=1712590935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WxhPu0Op3B4BOpA1DIRcJgPgm8zZjzjZ6yp1VpFs5I=;
        b=BNzPLL60GtDkf/BgIOKztkBnWKMpnOQ2UPJ0tPAEF0Ecl58ThS9LqX2hVkwS5AEBT3
         XhNXnLm6g4QY2OBKZbGGb/RAALScQlfUbW/dQDubbqTkKQrBvY6IA/tilJ/iOq6v5qFf
         dZHKXKDp9yAGJu/yspmg7Gwjb1/8XAdH9lBDIaa0tbzVLIWYCqqiXXKrcbYyGaxXgHpC
         r/K5KvPtkdN7BUp3b/hZn6mtjVWFfaBHY+b/3Mc02odz6eh2+i3WYfFRjEon1sDoJhIP
         Y6N5bLpNed22xt7uoACAuk36CLgGuGqVOAHjJutUPJvnMCWaHQXGOywVqLASUyidTm8x
         aHVQ==
X-Gm-Message-State: AOJu0YwUKrOxGIodPLcj1GrTvqyD862wAz1XAYJOVATyB120kdVJSqf6
	LuwiVHPANZkgP4rLrtXHwVWhxqCzzLko5i1ZziCmtitGy8q5d3ZYp1IhKM93
X-Google-Smtp-Source: AGHT+IHf9pntKRQT7sU9wq7JenGtnKIDiuXnWkN8YgWTfaTUQYxhXbJmP3oWeBdrFDsl15X0FH/Gdg==
X-Received: by 2002:a17:902:7847:b0:1e0:e650:5bd with SMTP id e7-20020a170902784700b001e0e65005bdmr8237418pln.45.1711986134669;
        Mon, 01 Apr 2024 08:42:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902e89000b001dd635551f1sm9081169plg.255.2024.04.01.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:42:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 1 Apr 2024 08:42:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.9-rc2
Message-ID: <036cb53d-9bb6-496c-8a5a-4cfee9e6de41@roeck-us.net>
References: <CAHk-=wjf=8JusO9TgkMfNziLjjSHdMOUpes_6f5m9_w+7taeBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjf=8JusO9TgkMfNziLjjSHdMOUpes_6f5m9_w+7taeBA@mail.gmail.com>

On Sun, Mar 31, 2024 at 03:05:35PM -0700, Linus Torvalds wrote:
> Neither snow nor rain nor heat nor gloom of night stays kernel rc releases.
> 
> Nor does Easter.
> 
> So here we are. Another week has passed, and rc2 is out. Nothing here
> look all that remarkable, and the fixes are fairly evenly spread out
> (so mostly drivers, because that's the bulk of the code).
> 
> Outside of the driver fixes (see shortlog below for details), we've
> got some more selftest work (mostly networking and bpf but also some
> random fixes), some architecture fixes (mostly x86), some filesystem
> work (xfs and btrfs) and random noise in other parts (mm, core kernel,
> networking, Kbuild..).
> 
> Nothing stands out to me or looks unusual.
> 

Build results:
	total: 158 pass: 157 fail: 1
Failed builds:
	xtensa:allmodconfig
Qemu test results:
	total: 549 pass: 548 fail: 1
Failed tests:
	nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts
Unit test results:
	pass: 227522 fail: 236

Failed unit tests:
	- mean_and_variance_test_2, mean_and_variance_test_4 for all
	  architectures/platforms
	- sh4: IP checksum tests

On top of that, there are still some warning backtraces when booting.

Details of known fixes are in the patch log below. Most but not all
of the patches are in maintainer branches.

For those interested, the patches are available in the 'testing' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.

Guenter

---
commit 797f85a623ffdb2ea8af900590d20a20ac351189
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Mon Mar 25 15:21:21 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:40 2024 -0700

    nios2: Call handle_mm_fault() with interrupts enabled
    
    The following log message is reported at each boot if
    CONFIG_DEBUG_ATOMIC_SLEEP is enabled.
    
    BUG: sleeping function called from invalid context at mm/rmap.c:194
    in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 23, name: modprobe
    preempt_count: 0, expected: 0
    CPU: 0 PID: 23 Comm: modprobe Not tainted 6.9.0-rc1-00033-g5afc2860dc51 #1
    
    Fix by enabling local interrupts while calling handle_mm_fault().
    
    Note: I don't really know what I am doing here.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 98780f117c51c8ef45315a64063485f5c7ff0199
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Thu Mar 21 11:44:11 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:40 2024 -0700

    nios2: Only use built-in devicetree blob if configured to do so
    
    Starting with commit 7b937cc243e5 ("of: Create of_root if no dtb provided
    by firmware"), attempts to boot nios2 images with an external devicetree
    blob result in a crash.
    
    Kernel panic - not syncing: early_init_dt_alloc_memory_arch:
            Failed to allocate 72 bytes align=0x40
    
    For nios2, a built-in devicetree blob always overrides devicetree blobs
    provided by ROMMON/BIOS. This includes the new dummy devicetree blob.
    Result is that the dummy devicetree blob is used even if an external
    devicetree blob is provided. Since the dummy devicetree blob does not
    include any memory information, memory allocations fail, resulting in
    the crash.
    
    To fix the problem, only use the built-in devicetree blob if
    CONFIG_NIOS2_DTB_SOURCE_BOOL is enabled.
    
    Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware")
    Cc: Frank Rowand <frowand.list@gmail.com>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Rob Herring <robh@kernel.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 90d4fe6154473787654ed9f33bfce0cac30e44bd
Author:     Huacai Chen <chenhuacai@kernel.org>
AuthorDate: Thu Mar 28 15:32:34 2024 +0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:39 2024 -0700

    LoongArch: Make __virt_addr_valid() work with KFENCE
    
    When enabling both CONFIG_KFENCE and CONFIG_DEBUG_SG, I get the
    following backtraces when running LongArch kernels.
    
    [    2.496257] kernel BUG at include/linux/scatterlist.h:187!
    ...
    [    2.501925] Call Trace:
    [    2.501950] [<9000000004ad59c4>] sg_init_one+0xac/0xc0
    [    2.502204] [<9000000004a438f8>] do_test_kpp+0x278/0x6e4
    [    2.502353] [<9000000004a43dd4>] alg_test_kpp+0x70/0xf4
    [    2.502494] [<9000000004a41b48>] alg_test+0x128/0x690
    [    2.502631] [<9000000004a3d898>] cryptomgr_test+0x20/0x40
    [    2.502775] [<90000000041b4508>] kthread+0x138/0x158
    [    2.502912] [<9000000004161c48>] ret_from_kernel_thread+0xc/0xa4
    
    The backtrace is always similar but not exactly the same. It is always
    triggered from cryptomgr_test, but not always from the same test.
    
    Analysis shows that with CONFIG_KFENCE active, the address returned from
    kmalloc() and friends is not always below vm_map_base. It is allocated
    by kfence_alloc() which at least sometimes seems to get its memory from
    an address space above vm_map_base. This causes __virt_addr_valid() to
    return false for the affected objects.
    
    Let __virt_addr_valid() return 1 for kfence pool addresses, this make
    __virt_addr_valid() work with KFENCE.
    
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Suggested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
    (cherry picked from commit 49f579ddf50f98f92acb20e5d8ecd8a237625eee)
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 0eee3ace51a8ad317a516795a5bcadfa0d880a8e
Author:     Huacai Chen <chenhuacai@kernel.org>
AuthorDate: Wed Mar 27 20:27:22 2024 +0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:39 2024 -0700

    LoongArch: Make virt_to_phys() work with KFENCE
    
    KFENCE changes virt_to_page() to be able to translate tlb mapped virtual
    addresses, but forget to change virt_to_phys() as well. This patch fix
    it, otherwise some drivers (such as virtio-blk) cannot work with KFENCE.
    
    BTW, define a simple version of virt_to_page() for !CONFIG_KFENCE.
    
    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
    (cherry picked from commit 0489e95919896d8ee3ffce020135c1297038fa9c)
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 146264009861f68947364f630cbdc175eef2cc5d
Author:     Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate: Sat Mar 23 15:15:44 2024 +0100
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:39 2024 -0700

    mm: vmalloc: Bail out early in find_vmap_area() if vmap is not init
    
    During the boot the s390 system triggers "spinlock bad magic" messages
    if the spinlock debugging is enabled:
    
    [    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
    [    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
    [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
    [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
    [    0.466270] Call Trace:
    [    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
    [    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
    [    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
    [    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
    [    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
    [    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
    [    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
    [    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
    [    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
    [    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40
    
    it happens because such system tries to access some vmap areas
    whereas the vmalloc initialization is not even yet done:
    
    [    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
    [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
    [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
    [    0.466270] Call Trace:
    [    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
    [    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
    [    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
    [    0.466572] find_vm_area (mm/vmalloc.c:3150)
    [    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
    [    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
    [    0.466651] paging_init (arch/s390/mm/init.c:97)
    [    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
    [    0.466702] start_kernel (init/main.c:899)
    [    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
    [    0.466811] INFO: lockdep is turned off.
    ...
    [    0.718250] vmalloc init - busy lock init 0000000002871860
    [    0.718328] vmalloc init - busy lock init 00000000028731b8
    
    Some background. It worked before because the lock that is in question
    was statically defined and initialized. As of now, the locks and data
    structures are initialized in the vmalloc_init() function.
    
    To address that issue add the check whether the "vmap_initialized"
    variable is set, if not find_vmap_area() bails out on entry returning NULL.
    
    Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Link: https://lore.kernel.org/r/20240323141544.4150-1-urezki@gmail.com
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit d12e5de57569567a8e54cc118fdd31b777017a51
Author:     Kemeng Shi <shikemeng@huaweicloud.com>
AuthorDate: Sat Mar 23 00:55:18 2024 +0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:39 2024 -0700

    ext4: implement filesystem specific alloc_inode in unit test
    
    We expect inode with ext4_info_info type as following:
    mbt_kunit_init
      mbt_mb_init
        ext4_mb_init
          ext4_mb_init_backend
            sbi->s_buddy_cache = new_inode(sb);
            EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
    
    Implement alloc_inode ionde with ext4_inode_info type to avoid
    out-of-bounds write.
    
    Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Link: https://lore.kernel.org/r/20240322165518.8147-1-shikemeng@huaweicloud.com
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit b4c66d4a04bcb6d4ff54d5da877581071c6cca15
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sun Feb 25 07:29:30 2024 -0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:38 2024 -0700

    mean_and_variance: Drop always failing tests
    
    mean_and_variance_test_2 and mean_and_variance_test_4 always fail.
    The input parameters to those tests are identical to the input parameters
    to tests 1 and 3, yet the expected result for tests 2 and 4 is different
    for the mean and stddev tests. That will always fail.
    
         Expected mean_and_variance_get_mean(mv) == mean[i], but
            mean_and_variance_get_mean(mv) == 22 (0x16)
            mean[i] == 10 (0xa)
    
    Drop the bad tests.
    
    Fixes: 65bc41090720 ("mean and variance: More tests")
    Closes: https://lore.kernel.org/lkml/065b94eb-6a24-4248-b7d7-d3212efb4787@roeck-us.net/
    Cc: Kent Overstreet <kent.overstreet@linux.dev>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 84085c2d41a686b429b39a9097c7b96d151c497b
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Feb 10 06:46:12 2024 -0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:38 2024 -0700

    Revert "sh: Handle calling csum_partial with misaligned data"
    
    This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
    
    Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
    data") causes bad checksum calculations on unaligned data. Reverting
    it fixes the problem.
    
        # Subtest: checksum
        # module: checksum_kunit
        1..5
        # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
        Expected ( u64)result == ( u64)expec, but
            ( u64)result == 53378 (0xd082)
            ( u64)expec == 33488 (0x82d0)
        # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
        not ok 1 test_csum_fixed_random_inputs
        # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
        Expected ( u64)result == ( u64)expec, but
            ( u64)result == 65281 (0xff01)
            ( u64)expec == 65280 (0xff00)
        # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
        not ok 2 test_csum_all_carry_inputs
        # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
        Expected ( u64)result == ( u64)expec, but
            ( u64)result == 65535 (0xffff)
            ( u64)expec == 65534 (0xfffe)
        # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
        not ok 3 test_csum_no_carry_inputs
        # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
        ok 4 test_ip_fast_csum
        # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
        ok 5 test_csum_ipv6_magic
     # checksum: pass:2 fail:3 skip:0 total:5
     # Totals: pass:2 fail:3 skip:0 total:5
    not ok 22 checksum
    
    Fixes: cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned data")
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 396b02a55fe04128f80586dff15d04e8a1c1538d
Author:     Barry Song <v-songbaohua@oppo.com>
AuthorDate: Tue Mar 19 14:09:20 2024 +1300
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Mon Apr 1 07:42:38 2024 -0700

    xtensa: remove redundant flush_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
    
    xtensa's flush_dcache_page() can be a no-op sometimes. There is a
    generic implementation for this case in include/asm-generic/
    cacheflush.h.
     #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
     static inline void flush_dcache_page(struct page *page)
     {
     }
    
     #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
     #endif
    
    So remove the superfluous flush_dcache_page() definition, which also
    helps silence potential build warnings complaining the page variable
    passed to flush_dcache_page() is not used.
    
       In file included from crypto/scompress.c:12:
       include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
       include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
          76 |                 struct page *page;
             |                              ^~~~
       crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
    >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
         174 |                         struct page *dst_page = sg_page(req->dst);
             |
    
    The issue was originally reported on LoongArch by kernel test
    robot (Huacai fixed it on LoongArch), then reported by Guenter
    and me on xtensa.
    
    This patch also removes lots of redundant macros which have
    been defined by asm-generic/cacheflush.h.
    
    Cc: Huacai Chen <chenhuacai@loongson.cn>
    Cc: Herbert Xu <herbert@gondor.apana.org.au>
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
    Reported-by: Barry Song <v-songbaohua@oppo.com>
    Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com/
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net/
    Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem")
    Signed-off-by: Barry Song <v-songbaohua@oppo.com>
    Link: https://lore.kernel.org/r/20240319010920.125192-1-21cnbao@gmail.com
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

