Return-Path: <linux-kernel+bounces-128434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B111895AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC5728855C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143215A4A9;
	Tue,  2 Apr 2024 17:35:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336D15A4AA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079335; cv=none; b=OR4KCgdxNzaGlFxHeejioTDSaLzaeNtEVBOrwja2cNI/REihtaSTVUXm3KrjYt010y4ki8b/xkkf1+difL6ipU+7y1sDMozw5EyBfo45HcCkYXp+Kfibv5NTWtOYHzMtncl8zCq7HVY4TOInztM2zT8wY0xZgcInjTOiud4kWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079335; c=relaxed/simple;
	bh=56UAHv8y3y6GP4YfMfLteKYYm0Uiz6eGDfiEcIERjik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFO30H5fRNAsF6eV32kX1OBASEaknFHf0mK6E61Iez++2o9MPz1v+YuU0Ojrhd9s9zsyld3hc0iFai717D+D4qODZKKPGoBL24tMiwG1uxXrNUXX4qAw1EjuoILhhqb6lgAM861V+TFIITxsz7W1heZGeLgfSwTU6NDObdQYG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC6A11007;
	Tue,  2 Apr 2024 10:36:04 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3A83F766;
	Tue,  2 Apr 2024 10:35:30 -0700 (PDT)
Date: Tue, 2 Apr 2024 18:35:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Paul =?us-ascii?Q?Heidekr=22uger?= <paul.heidekrueger@tum.de>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Subject: Re: [linus:master] [kasan]  4e76c8cc33:
 BUG:KASAN:slab-out-of-bounds_in_kasan_atomics_helper
Message-ID: <ZgxB4PZ8N6QjRqLA@FVFF77S0Q05N>
References: <202403310849.3bb9f3d2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403310849.3bb9f3d2-lkp@intel.com>

On Sun, Mar 31, 2024 at 10:18:17AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_kasan_atomics_helper" on:
> 
> commit: 4e76c8cc3378a20923965e3345f40f6b8ae0bdba ("kasan: add atomic tests")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This is expected; it's the point of the test...

Is there something this should depend on such that the test robot doesn't build
this? Otherwise, can we please avoid reporting KASAN splates from this KASAN test module?

Mark.

> [test failed on linus/master 8d025e2092e29bfd13e56c78e22af25fac83c8ec]
> [test failed on linux-next/master a6bd6c9333397f5a0e2667d4d82fef8c970108f2]
> 
> in testcase: kunit
> version: 
> with following parameters:
> 
> 	group: group-00
> 
> 
> 
> compiler: gcc-12
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202403310849.3bb9f3d2-lkp@intel.com
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240331/202403310849.3bb9f3d2-lkp@intel.com
> 
> 
> 
> [  306.028382][ T4480] ==================================================================
> [  306.047117][ T4480] BUG: KASAN: slab-out-of-bounds in kasan_atomics_helper+0x25d0/0x26b0 [kasan_test]
> [  306.057673][ T4480] Read of size 4 at addr ffff888168de7330 by task kunit_try_catch/4480
> [  306.067074][ T4480] 
> [  306.070605][ T4480] CPU: 2 PID: 4480 Comm: kunit_try_catch Tainted: G S  B            N 6.8.0-rc5-00151-g4e76c8cc3378 #1
> [  306.082834][ T4480] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
> [  306.093195][ T4480] Call Trace:
> [  306.097725][ T4480]  <TASK>
> [  306.101846][ T4480]  dump_stack_lvl+0x36/0x50
> [  306.107696][ T4480]  print_address_description+0x2c/0x3a0
> [  306.115489][ T4480]  ? kasan_atomics_helper+0x25d0/0x26b0 [kasan_test]
> [  306.123367][ T4480]  print_report+0xba/0x2b0
> [  306.129115][ T4480]  ? kasan_addr_to_slab+0xd/0x90
> [  306.135383][ T4480]  ? kasan_atomics_helper+0x25d0/0x26b0 [kasan_test]
> [  306.143412][ T4480]  kasan_report+0xe7/0x120
> [  306.149087][ T4480]  ? kasan_atomics_helper+0x25d0/0x26b0 [kasan_test]
> [  306.157076][ T4480]  kasan_atomics_helper+0x25d0/0x26b0 [kasan_test]
> [  306.164966][ T4480]  ? kmalloc_oob_right+0x3e0/0x3e0 [kasan_test]
> [  306.172608][ T4480]  ? kasan_save_track+0x14/0x30
> [  306.178787][ T4480]  kasan_atomics+0xeb/0x190 [kasan_test]
> [  306.185724][ T4480]  ? kasan_bitops_generic+0x140/0x140 [kasan_test]
> [  306.193520][ T4480]  ? ktime_get_ts64+0x83/0x1b0
> [  306.199669][ T4480]  kunit_try_run_case+0x1ab/0x480
> [  306.206017][ T4480]  ? kunit_try_run_case_cleanup+0xe0/0xe0
> [  306.213174][ T4480]  ? _raw_read_unlock_irqrestore+0x50/0x50
> [  306.220337][ T4480]  ? set_cpus_allowed_ptr+0x85/0xb0
> [  306.226821][ T4480]  ? migrate_enable+0x2a0/0x2a0
> [  306.232966][ T4480]  ? kunit_try_catch_throw+0x80/0x80
> [  306.239549][ T4480]  ? kunit_try_run_case_cleanup+0xe0/0xe0
> [  306.246540][ T4480]  kunit_generic_run_threadfn_adapter+0x4e/0xa0
> [  306.254054][ T4480]  kthread+0x2dd/0x3c0
> [  306.259312][ T4480]  ? kthread_complete_and_exit+0x30/0x30
> [  306.266147][ T4480]  ret_from_fork+0x31/0x70
> [  306.271775][ T4480]  ? kthread_complete_and_exit+0x30/0x30
> [  306.278575][ T4480]  ret_from_fork_asm+0x11/0x20
> [  306.284413][ T4480]  </TASK>
> [  306.288653][ T4480] 
> [  306.292149][ T4480] Allocated by task 4480:
> [  306.297686][ T4480]  kasan_save_stack+0x33/0x50
> [  306.303495][ T4480]  kasan_save_track+0x14/0x30
> [  306.309255][ T4480]  __kasan_kmalloc+0xa2/0xb0
> [  306.314945][ T4480]  kasan_atomics+0x8c/0x190 [kasan_test]
> [  306.321745][ T4480]  kunit_try_run_case+0x1ab/0x480
> [  306.327860][ T4480]  kunit_generic_run_threadfn_adapter+0x4e/0xa0
> [  306.335239][ T4480]  kthread+0x2dd/0x3c0
> [  306.340469][ T4480]  ret_from_fork+0x31/0x70
> [  306.346020][ T4480]  ret_from_fork_asm+0x11/0x20
> [  306.351815][ T4480] 
> [  306.355163][ T4480] The buggy address belongs to the object at ffff888168de7300
> [  306.355163][ T4480]  which belongs to the cache kmalloc-64 of size 64
> [  306.371174][ T4480] The buggy address is located 0 bytes to the right of
> [  306.371174][ T4480]  allocated 48-byte region [ffff888168de7300, ffff888168de7330)
> [  306.387688][ T4480] 
> [  306.390884][ T4480] The buggy address belongs to the physical page:
> [  306.398313][ T4480] page:000000005ccb3a22 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x168de7
> [  306.409549][ T4480] flags: 0x17ffffc0000800(slab|node=0|zone=2|lastcpupid=0x1fffff)
> [  306.418339][ T4480] page_type: 0xffffffff()
> [  306.423762][ T4480] raw: 0017ffffc0000800 ffff888100042640 dead000000000100 dead000000000122
> [  306.433384][ T4480] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
> [  306.443077][ T4480] page dumped because: kasan: bad access detected
> [  306.450608][ T4480] 
> [  306.454016][ T4480] Memory state around the buggy address:
> [  306.460748][ T4480]  ffff888168de7200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  306.469821][ T4480]  ffff888168de7280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> [  306.478894][ T4480] >ffff888168de7300: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> [  306.488019][ T4480]                                      ^
> [  306.494672][ T4480]  ffff888168de7380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  306.503812][ T4480]  ffff888168de7400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  306.512946][ T4480] ==================================================================
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 

