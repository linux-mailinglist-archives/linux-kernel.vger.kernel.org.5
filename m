Return-Path: <linux-kernel+bounces-104617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C4E87D10B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4881C22761
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4E45979;
	Fri, 15 Mar 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6VpuuzC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FA1773D;
	Fri, 15 Mar 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519441; cv=none; b=SLJMRgorjAGrurOLCe0zoxUovuVCKOy7E1j+v21c/142QYSjR9cQXdUqeYdIo5SpGTpfx00xD/s398EGoTer1viDeQnKZxGoaU0SyCqzafWxjMqwCXht2dyrea/uXkuTNc91Tt2G2zhuuGm7K9NZRnri4WdSFxlplPTQjhUTC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519441; c=relaxed/simple;
	bh=+siEWXHFz2psbXNoaXiWPftLm9zhkkWUSF8L5Mc+7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhIeWwor/fbm8K361MO67Em9bl3txFix2hkahGAWYCiMQa7pH0J193Zti4zd4PiqQw9ol3wU+1lQ7O3dDYORLvj0gUnmoeoYGPYpK3/tupa6JgSRhrhZj7RCiZ23yWbNQl/SPO6JqWpG5B1hx4zZzoROg/z8H85RUDKN+BW7AhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6VpuuzC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1def2a1aafaso5123685ad.3;
        Fri, 15 Mar 2024 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710519437; x=1711124237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvTc5Nmq7ya0vJkhA/LyUC5oHHVwCe9apA49fvP71+A=;
        b=h6VpuuzCgn0VWqRYlIL6EyOxghZc+qh/IxW0QrY6XXnnQqeqs4B2M5m9VEWTCTnd/2
         LMw8KrHTPYwqq8kUqBephrBRoHu30KRkXeVGMy4Iv4e7asUhZplYbkBhMeb0ux4Ih4rH
         TvTEkW/cuk/GkKe9htULqJIKdH+nD/Z2UPrW4jlVDRaNhE4OOVdtirEYVTMVlCQO5Nyb
         Krm1zSoofDZ8oanw9dqM8d+JVUFXXZpYVXqSSxE9IkknKJbgqSoEjQufOtA+RjrogfXw
         PAr88M/ETkP8GTJwzRlJyosdV5Zq+bviF2PIV0Yirg+TNjH2FZcy2usgwYQhUtVbC/NM
         gxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519437; x=1711124237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvTc5Nmq7ya0vJkhA/LyUC5oHHVwCe9apA49fvP71+A=;
        b=rzBn5O5MuO/VviE9FSe1ZLzHlIb5hNUzw7lXy0ZvNKC1Xc8XOwuTec6JaNiVD0DRa/
         H1G0/oQwMAyDIdlXadZ68+/SgknxMyDCQLPrMKt8Hymz2vlgBBqHeIFCMOIBWieKQjpg
         92Nb/lOFUEZc71BDN6T1oQL93nRFYzK6FneDYWdfCshX95YcuUTE+FXmiOLFib5e/lkL
         CbKwk/7rFYRutR0LabtrCwNfTvtspKVM0EHwg1RHZ18AtljeYVuENQWgM+y3pU/a1y43
         EtVQDcPYLvgKgp3xncn/HzHy/YeYaYJZrs6faI3rq1LzVY0whOY0nAtGi4ssM9QyhPs7
         nliA==
X-Forwarded-Encrypted: i=1; AJvYcCUCUdsU3QhjoluAGFDnJe2nn+hurOtxMmyA2VWN/WKLR3HbUkpQnDn5iVQfEG2+1J2+SEdxg1pLBlfHEpeVNLq9creCkaXTmxa2TM3C
X-Gm-Message-State: AOJu0YxXO61s5JUX8sAmWv6M+DCctt981a29w1Fc5EqFuqSrxMwVJwuQ
	hog9ngjn60jyIQg4/tlgQKk8rNysLgXlQD1KU7H7EMuy0DZFLQ8S
X-Google-Smtp-Source: AGHT+IEjegsX44p9cqszfgX3j2cAN6QCSyKnJxqZGg+ZKFi24Svb8e4VoBu+OKuBt7WdGRrUpeaMug==
X-Received: by 2002:a17:902:d510:b0:1de:f230:4bd1 with SMTP id b16-20020a170902d51000b001def2304bd1mr2078165plg.10.1710519436599;
        Fri, 15 Mar 2024 09:17:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001defa97c6basm806766plk.235.2024.03.15.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 09:17:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 15 Mar 2024 09:17:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Message-ID: <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304005104.622511517@linutronix.de>

Hi,

On Mon, Mar 04, 2024 at 11:12:23AM +0100, Thomas Gleixner wrote:
> On UP builds sparse complains rightfully about accesses to cpu_info with
> per CPU accessors:
> 
> cacheinfo.c:282:30: sparse: warning: incorrect type in initializer (different address spaces)
> cacheinfo.c:282:30: sparse:    expected void const [noderef] __percpu *__vpp_verify
> cacheinfo.c:282:30: sparse:    got unsigned int *
> 
> The reason is that on UP builds cpu_info which is a per CPU variable on SMP
> is mapped to boot_cpu_info which is a regular variable. There is a hideous
> accessor cpu_data() which tries to hide this, but it's not sufficient as
> some places require raw accessors and generates worse code than the regular
> per CPU accessors.
> 
> Waste sizeof(struct x86_cpuinfo) memory on UP and provide the per CPU
> cpu_info unconditionally. This requires to update the CPU info on the boot
> CPU as SMP does. (Ab)use the weakly defined smp_prepare_boot_cpu() function
> and implement exactly that.
> 
> This allows to use regular per CPU accessors uncoditionally and paves the
> way to remove the cpu_data() hackery.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This patch results in crashes when running the mainline kernel in qemu
with nosmp builds and Intel CPUs. The problem is _not_ seen on tag
x86-cleanups-2024-03-11; it is only seen in the mainline kernel. I didn't
check all of them, but it looks like AMD CPUs are not affected. The
initial bisect points to the merge of x86-cleanups-2024-03-11 into the
mainline kernel. I rebased x86-cleanups-2024-03-11 on top of the mainline
kernel; the second bisect uses that rebase as base. Reverting this patch
from the mainline kernel fixes the problem.

I don't know the code well enough to determine what is wrong.
Please let me know what I can do to help debugging the problem.

Thanks,
Guenter

----
crash log:

[    3.291087] BUG: unable to handle page fault for address: ffff9cd801f3f2a0
[    3.291087] #PF: supervisor write access in kernel mode
[    3.291087] #PF: error_code(0x0002) - not-present page
[    3.291087] PGD 60201067 P4D 60201067 PUD 0
[    3.291087] Oops: 0002 [#1] PREEMPT PTI
[    3.291087] CPU: 0 PID: 1 Comm: swapper Not tainted 6.8.0-06619-ge5e038b7ae9d #1
[    3.291087] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    3.291087] RIP: 0010:rapl_cpu_online+0xf2/0x110
[    3.291087] Code: 05 ff 8e 07 03 40 42 0f 00 48 89 43 60 e8 56 5f 12 00 8b 15 b4 84 61 02 48 8b 05 01 8f 07 03 48 c7 83 90 00 00 00 e0 84 80 b6 <48> 89 9c d0 38 01 00 00 e9 2b ff ff ff b8 f4 ff ff ff e9 47 ff ff
[    3.291087] RSP: 0018:ffffa3d54001fdd0 EFLAGS: 00000246
[    3.291087] RAX: ffff9cd001f3f200 RBX: ffff9cd001fb34a8 RCX: 0000000000000000
[    3.291087] RDX: 00000000ffffffed RSI: 0000000000000001 RDI: ffff9cd001fb3550
[    3.291087] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[    3.291087] R10: 0000000000000001 R11: 0000000000018001 R12: 0000000000000000
[    3.291087] R13: 000000000000009e R14: ffffffffb6808180 R15: ffffffffb86710e5
[    3.291087] FS:  0000000000000000(0000) GS:ffffffffb8ab0000(0000) knlGS:0000000000000000
[    3.291087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.291087] CR2: ffff9cd801f3f2a0 CR3: 000000005e6a2000 CR4: 00000000001506f0
[    3.291087] Call Trace:
[    3.291087]  <TASK>
[    3.291087]  ? __die+0x1f/0x60
[    3.291087]  ? page_fault_oops+0x148/0x460
[    3.291087]  ? search_exception_tables+0x37/0x50
[    3.291087]  ? fixup_exception+0x21/0x320
[    3.291087]  ? exc_page_fault+0xca/0x150
[    3.291087]  ? asm_exc_page_fault+0x26/0x30
[    3.291087]  ? __pfx_rapl_cpu_online+0x10/0x10
[    3.291087]  ? rapl_cpu_online+0xf2/0x110
[    3.291087]  cpuhp_invoke_callback.constprop.0+0x117/0x3e0
[    3.291087]  __cpuhp_setup_state_cpuslocked+0x1b7/0x280
[    3.291087]  ? __pfx_rapl_cpu_online+0x10/0x10
[    3.291087]  rapl_pmu_init+0x189/0x2e0
[    3.291087]  ? __pfx_rapl_pmu_init+0x10/0x10
[    3.291087]  do_one_initcall+0x4f/0x210
[    3.291087]  kernel_init_freeable+0x166/0x290
[    3.291087]  ? __pfx_kernel_init+0x10/0x10
[    3.291087]  kernel_init+0x15/0x1b0
[    3.291087]  ret_from_fork+0x2f/0x50
[    3.291087]  ? __pfx_kernel_init+0x10/0x10
[    3.291087]  ret_from_fork_asm+0x19/0x30
[    3.291087]  </TASK>
[    3.291087] Modules linked in:
[    3.291087] CR2: ffff9cd801f3f2a0
[    3.291087] ---[ end trace 0000000000000000 ]---
[    3.291087] RIP: 0010:rapl_cpu_online+0xf2/0x110
[    3.291087] Code: 05 ff 8e 07 03 40 42 0f 00 48 89 43 60 e8 56 5f 12 00 8b 15 b4 84 61 02 48 8b 05 01 8f 07 03 48 c7 83 90 00 00 00 e0 84 80 b6 <48> 89 9c d0 38 01 00 00 e9 2b ff ff ff b8 f4 ff ff ff e9 47 ff ff
[    3.291087] RSP: 0018:ffffa3d54001fdd0 EFLAGS: 00000246
[    3.291087] RAX: ffff9cd001f3f200 RBX: ffff9cd001fb34a8 RCX: 0000000000000000
[    3.291087] RDX: 00000000ffffffed RSI: 0000000000000001 RDI: ffff9cd001fb3550
[    3.291087] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[    3.291087] R10: 0000000000000001 R11: 0000000000018001 R12: 0000000000000000
[    3.291087] R13: 000000000000009e R14: ffffffffb6808180 R15: ffffffffb86710e5
[    3.291087] FS:  0000000000000000(0000) GS:ffffffffb8ab0000(0000) knlGS:0000000000000000
[    3.291087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.291087] CR2: ffff9cd801f3f2a0 CR3: 000000005e6a2000 CR4: 00000000001506f0
[    3.291087] note: swapper[1] exited with irqs disabled
[    3.306047] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

---
1st bisect:

# bad: [1bbeaf83dd7b5e3628b98bec66ff8fe2646e14aa] Merge tag 'perf-tools-for-v6.9-2024-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect start 'HEAD' 'v6.8'
# bad: [9187210eee7d87eea37b45ea93454a88681894a4] Merge tag 'net-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 9187210eee7d87eea37b45ea93454a88681894a4
# bad: [a01c9fe32378636ae65bec8047b5de3fdb2ba5c8] Merge tag 'nfsd-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect bad a01c9fe32378636ae65bec8047b5de3fdb2ba5c8
# bad: [691632f0e86973604678d193ccfa47b9614581aa] Merge tag 's390-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad 691632f0e86973604678d193ccfa47b9614581aa
# good: [8ede842f669b6f78812349bbef4d1efd0fbdafce] Merge tag 'rust-6.9' of https://github.com/Rust-for-Linux/linux
git bisect good 8ede842f669b6f78812349bbef4d1efd0fbdafce
# good: [bfdb395a7cde12d83a623949ed029b0ab38d765b] Merge tag 'x86_mtrr_for_v6.9_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good bfdb395a7cde12d83a623949ed029b0ab38d765b
# bad: [685d98211273f60e38a6d361b62d7016c545297e] Merge tag 'x86-core-2024-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 685d98211273f60e38a6d361b62d7016c545297e
# good: [b0402403e54ae9eb94ce1cbb53c7def776e97426] Merge tag 'edac_updates_for_v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras
git bisect good b0402403e54ae9eb94ce1cbb53c7def776e97426
# good: [cb81deefb59de01325ab822f900c13941bfaf67f] x86/idle: Sanitize X86_BUG_AMD_E400 handling
git bisect good cb81deefb59de01325ab822f900c13941bfaf67f
# good: [73f0d1d7b4abb4a46bae1a0d8caf66e23d1138d0] Merge tag 'x86-asm-2024-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 73f0d1d7b4abb4a46bae1a0d8caf66e23d1138d0
# good: [65efc4dc12c5cc296374278673b89390eba79fe6] x86/cpu: Provide a declaration for itlb_multihit_kvm_mitigation
git bisect good 65efc4dc12c5cc296374278673b89390eba79fe6
# good: [d69ad12c786f0a4593c48c0658043aa4a5116b09] Merge tag 'x86-build-2024-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good d69ad12c786f0a4593c48c0658043aa4a5116b09
# good: [35ce64922c8263448e58a2b9e8d15a64e11e9b2d] x86/idle: Select idle routine only once
git bisect good 35ce64922c8263448e58a2b9e8d15a64e11e9b2d
# good: [774a86f1c885460ade4334b901919fa1d8ae6ec6] x86/nmi: Drop unused declaration of proc_nmi_enabled()
git bisect good 774a86f1c885460ade4334b901919fa1d8ae6ec6
# bad: [fcc196579aa1fc167d6778948bff69fae6116737] Merge tag 'x86-cleanups-2024-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad fcc196579aa1fc167d6778948bff69fae6116737
# first bad commit: [fcc196579aa1fc167d6778948bff69fae6116737] Merge tag 'x86-cleanups-2024-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

---
2nd bisect:

# bad: [6d70929c7019e265425f7a89cf72163a639d462e] x86/nmi: Drop unused declaration of proc_nmi_enabled()
# good: [d69ad12c786f0a4593c48c0658043aa4a5116b09] Merge tag 'x86-build-2024-03-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start 'HEAD' 'fcc196579aa1fc167d6778948bff69fae6116737~1'
# good: [5c157d25918ef15454c2a9a9262f7b763d9c9add] x86/msr: Add missing __percpu annotations
git bisect good 5c157d25918ef15454c2a9a9262f7b763d9c9add
# bad: [f5a6b1e2d92d825a0f73ca11e960795da336d99e] x86/uaccess: Add missing __force to casts in __access_ok() and valid_user_address()
git bisect bad f5a6b1e2d92d825a0f73ca11e960795da336d99e
# bad: [68907233f6d26a214bb79f892db8d999b15dda97] x86/percpu: Cure per CPU madness on UP
git bisect bad 68907233f6d26a214bb79f892db8d999b15dda97
# good: [053df18ceb928c8631042317a884b2842a457f1b] smp: Consolidate smp_prepare_boot_cpu()
git bisect good 053df18ceb928c8631042317a884b2842a457f1b
# first bad commit: [68907233f6d26a214bb79f892db8d999b15dda97] x86/percpu: Cure per CPU madness on UP

