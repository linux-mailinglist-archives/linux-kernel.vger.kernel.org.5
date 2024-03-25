Return-Path: <linux-kernel+bounces-117371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61788AA88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87C02E3C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB013DDC9;
	Mon, 25 Mar 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzMby9rp"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F6745D6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380666; cv=none; b=huHGASNX5jhhhcVkuO67mEfBJYuHZsk45j9MMjR0Qba0qA3OBK36S6bB4huKJgvs4OpNiLoNJxf2Dl2Fx/3gGvTpcyykm2MhJckms7yDXUS13N6jPmE8HXRNIecb5sIwFK6PreH3Rj8hxKfcDdU+CAKuoiEtZn9EalHlzypp0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380666; c=relaxed/simple;
	bh=EdbdTAVrXotBWugykfbvOTP6D1m4fp4q6nIvAxd5/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMOG0ScAZmSaOk5oqKSrdjrHOaOies1+YoLCZ7C3ptOA6jl+2SwEXnu8t+lQAxBO/ETXP5LfOZAQ2D0qIQvBwKD42nsaJNFRWMD5dmVy2EFRhpqHP9uWdPAt6bsGqcJkhoR561YJEMvZ3ymFxgxw5ulWhkzanOAHB3kcISX6eeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzMby9rp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so3080088b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380664; x=1711985464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqgJi7FJtx5f8IEZJih5W+2rfYum9Kip4GxC1XX7BDY=;
        b=hzMby9rp5sppemVyagOGq/5PRBl6naIyORtOhvY+YfAAaUkqvQnwvobY/yhrsMkJ/B
         POuH9qopICrNZ7t0l2imHuOIQF3zypVLG1YEoEhEGY63ifW6A9cOamMUd40Ye6B5D79F
         UrLL79RfPtp/TN2ONkYBaFzs2uB8Va6OxQqQVCOpTiLkZ3cIhFdaUWV7MJwWu6k/VUze
         xlNof7plb4coIP4Ilp6aKI9wSBUa+LQrVYog8InFZBSYmBGnsxK5g4ArpGrRSr2pWnn0
         HwPkZTV4CMNcQRbePgJBqOdVsgJ+jFk/iyPmHwsFUrnxZTxXAkWNAgRbiXCBaLbLSQBv
         VCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380664; x=1711985464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqgJi7FJtx5f8IEZJih5W+2rfYum9Kip4GxC1XX7BDY=;
        b=WU4Re82wOt3Vj46tISJU99hzsoKcdVadoIKg+Gc7V0prBp1HTH95mqJs2gqv4ih+SW
         0t/xbgmZFqI0jV0xIWdIbL+DRUZvs3fBshy8zq//LumDdiz7MTeiTQICNrkArM2v26fz
         M+Rj19Gu4kwNCEk1qj+sUJjG6zXTY2lj3Odnoxdyy4EMLcRMp+YwSoQ67wT5lqwie63g
         2g6c7fUJMM7u9nHK0nM0SdPVRK8h6r7xJ3lqmf/z4s2wkZgMSY6MVERuPzeDWgxlfSlg
         Ps/M2IaOFseITuep26Y/FdRgnNgnsr5SfwLREPj3R1iRmrazBrX3JdAO/4R4riObEFXj
         Ypyg==
X-Gm-Message-State: AOJu0YxbqIBXUvLvL2TrWMLgDXtG7h+OwISqk8tmV9Zg8rBm2YuH1/8r
	ByA3Wwdxww5RsUPQdp1GWCTdzUytwbDC7/A93PIPDuYY2lyCYDDzrcyHi5CA
X-Google-Smtp-Source: AGHT+IEJos8p5RWO1AvnhpMIuUCFcE5ieMfqT1Ix0DrK0WC9UHAEUq8XL2fVgpqiV+hxiUW0TboxIQ==
X-Received: by 2002:a05:6a20:4f9d:b0:1a3:3cc3:b251 with SMTP id gh29-20020a056a204f9d00b001a33cc3b251mr5275205pzb.26.1711380663501;
        Mon, 25 Mar 2024 08:31:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020aa78715000000b006e6f1eab2f9sm4220559pfo.159.2024.03.25.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:31:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 08:31:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.9-rc1
Message-ID: <43f6d800-be93-41e9-874c-2b4acefc508b@roeck-us.net>
References: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com>

On Sun, Mar 24, 2024 at 02:56:37PM -0700, Linus Torvalds wrote:
[ ... ]
> 
> Please commence testing,
> 

Build results:
	total: 158 pass: 153 fail: 5
Failed builds:
	i386:allyesconfig
	i386:allmodconfig
	mips:allmodconfig
	sparc64:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 549 pass: 547 fail: 2
Unit test results:
	pass: 227557 fail: 236

The patches below aree from my "testing" branch and fix the problems
reported above, including some runtime warnings.

Guenter

---
commit 1cc1b94e2faa13eac5f3f0998461ad4c64e5c8d2
Author:     Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate: Sat Mar 23 15:15:44 2024 +0100
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:16:29 2024 -0700

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

commit 5c6d83c2e83a73bdae7c6948cf9f60b9d96e3409
Author:     Kemeng Shi <shikemeng@huaweicloud.com>
AuthorDate: Sat Mar 23 00:55:18 2024 +0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:16:29 2024 -0700

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

commit ae182ad0dbe6d3ce00bf108765d2ab92087bb3c5
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sun Feb 25 07:29:30 2024 -0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:16:29 2024 -0700

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

commit 29af3963a3b18ada336bc4f7a037f38c614f5d56
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Feb 10 06:46:12 2024 -0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:16:28 2024 -0700

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

commit de73ec05feb6b76362aafb48a1d23fa65197a669
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Thu Mar 21 11:44:11 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:02 2024 -0700

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

commit f53a0580548eacc752e8ae6faecb1f36a6558fff
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Mar 23 07:36:47 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:02 2024 -0700

    uio_pruss: Fix build failure on 32 bit builds with 64 bit physaddr
    
    Builds on 32-bit systems with 64 bit physical address fail with
    
    drivers/uio/uio_pruss.c: In function 'pruss_probe':
    drivers/uio/uio_pruss.c:194:34: error:
            cast from pointer to integer of different size
    
    The conversion itself is safe since sizeof(phys_addr_t) it in general equal
    to or larger than sizeof(void *). Solve the problem by double-casting the
    conversion.
    
    Fixes: 7722151e4651 ("uio_pruss: UIO_MEM_DMA_COHERENT conversion")
    Cc: Chris Leech <cleech@redhat.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 0200396155014a86dafba516a280f76eb7cd4c84
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Mar 23 07:31:50 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:02 2024 -0700

    uio: Fix build failure on 32 bit builds with 64 bit physaddr
    
    Builds on 32-bit systems with 64 bit physical address fail with
    
    drivers/uio/uio.c: In function 'uio_mmap_dma_coherent':
    drivers/uio/uio.c:795:16: error:
            cast to pointer from integer of different size
    
    The conversion itself is safe since sizeof(phys_addr_t) it in general equal
    to or larger than sizeof(void *). Solve the problem by double-casting the
    conversion.
    
    Fixes: 576882ef5e7f ("uio: introduce UIO_MEM_DMA_COHERENT type")
    Cc: Chris Leech <cleech@redhat.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit d7c0966df3bd2eeba5f383823b1ce2feacbdf989
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Mar 23 07:28:03 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:01 2024 -0700

    uio_dmem_genirq: Fix build failure on 32 bit builds with 64 bit physaddr
    
    Builds on 32-bit systems with 64 bit physical address fail with
    
    drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
    drivers/uio/uio_dmem_genirq.c:63:39: error:
            cast from pointer to integer of different size
    
    drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
    drivers/uio/uio_dmem_genirq.c:92:43: error:
            cast to pointer from integer of different size
    
    The conversion itself is safe since sizeof(phys_addr_t) it in general equal
    to or larger than sizeof(void *). Solve the problem by double-casting the
    conversion.
    
    Fixes: 019947805a8d ("uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion")
    Cc: Chris Leech <cleech@redhat.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit c66e58ffac99d7d8f3bd38af9ba513d004b27ce4
Author:     Lucas De Marchi <lucas.demarchi@intel.com>
AuthorDate: Thu Mar 21 15:17:25 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:00 2024 -0700

    drm/xe: Fix END redefinition
    
    mips declares an END macro in its headers so it can't be used without
    namespace in a driver like xe.
    
    Instead of coming up with a longer name, just remove the macro and
    replace its use with 0 since it's still clear what that means:
    set_offsets() was already using that implicitly when checking the data
    variable.
    
    Closes: http://kisskb.ellerman.id.au/kisskb/buildresult/15143996/
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
    Link: https://lore.kernel.org/r/20240321221726.102193-2-lucas.demarchi@intel.com
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 1a74fc1f82835e86fa33016c3a028c65369ed60f
Author:     Ken Raeburn <raeburn@redhat.com>
AuthorDate: Wed Mar 20 17:44:05 2024 -0400
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:00 2024 -0700

    dm vdo: use kernel byteswapping routines instead of GCC ones
    
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Ken Raeburn <raeburn@redhat.com>
    Signed-off-by: Matthew Sakai <msakai@redhat.com>
    Link: https://lore.kernel.org/r/fe10f7bf2332c868deb88bb59967fa1880b1b34f.1710970229.git.msakai@redhat.com
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 1ab86f67b7085b99576d95989e6951220e741cc2
Author:     Barry Song <v-songbaohua@oppo.com>
AuthorDate: Tue Mar 19 14:09:20 2024 +1300
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Mar 24 16:05:00 2024 -0700

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

