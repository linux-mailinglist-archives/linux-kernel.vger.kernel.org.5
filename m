Return-Path: <linux-kernel+bounces-90389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604D86FE94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF813281920
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248C22636;
	Mon,  4 Mar 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vOr0Aal7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEYEBAtK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D22261A;
	Mon,  4 Mar 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547141; cv=none; b=USareSguTBzStbH2q6QHFgtJzNH9CbEW0gO8Y9DSUIbJrccCeRS4TgIB2XD1Yx2iPCjQQRCyhPcGnyU7kdTm+f7biZSHoJUDEjJK5K0l5NIvJczgRBHWToSYbVmUhx5ciG21n/QrgMP8lf5vNeLVIfyyPZglg/K3KsX7s3vxMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547141; c=relaxed/simple;
	bh=o0R91Zk5Z/NMZsUmJYgThkIKIfpc/uoli84r/bMbblU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=egLHY1N6qMakmjeLIEFnaoybr/8e6Jn4zEW/du8wTahHom/HzLGRrXFIEXJQwAAIR5xWUJa1DwfRwHFgUq/w8x3GW5+fMLFnxwT8Suj89OR1E6ZroVaic6Cn0jH2CV4OOM4S/PIW96ZQkyWGemeAN0shuXTIErlJZusJV/5RQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vOr0Aal7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEYEBAtK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240303235029.555787150@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=NB439uWftAZPMVdfvqzBSs1vW6nfM8dMMT/geSlX3oI=;
	b=vOr0Aal7qbjW0uxzuQzJLYj4ey3sOocI/PVDGgQCaaj0LHjpN7UMoc6VuJzJ83523L/Q2A
	yZHg6+sKzCI4hQVmBEtah0Jalul3dqwn0qf28dKKd5JgbkMm5KJcQ4NCdFeY1lbnkwd1wB
	a7bR4IPQ2YbnazWiqzeZGCnh+3FO8oNO/4n3SiZe6EBUqShYSFdTQJAYrjwg6GrWvngUBB
	L52uK1+NIURIP6LeUk6mBZgvdAae9lbSdygtHHsjIAHjq7D6TYg4ZGvkY9Sp6nH6PHS1Xs
	BB/DwYRFn/oVnoYcAQvRbIz1CaxlgVUSTSjgkwcCFmatGjVjO2b35nlvdpOR9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=NB439uWftAZPMVdfvqzBSs1vW6nfM8dMMT/geSlX3oI=;
	b=gEYEBAtKIXvZe400HpX9olYmjxa8LlRL77U6zhjIaLfadxH0Qv8v+ZtR5v9dZJ8fzWu2nC
	pT1kivqHRYNAKQAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 0/9] x86: Cure tons of sparse warnings (mostly __percpu)
Date: Mon,  4 Mar 2024 11:12:16 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A recent 0-day report about new __percpu related sparse warnings made me
look deeper into it after I dismissed the report as bogus initially.

It turned out that sparse is actually right and all of these warnings (not
only the most recent ones) are valid and got ignored. Some of them for many
years.

The worst offender is an UP build because that maps the per CPU cpu_info to
boot_cpu_data, which is regular data.

As a consequence all per CPU accessors which look like legit code and are
legit code in the SMP build are causing sparse to emit warnings.

This series addresses this by:

     - Adding the missing __percpu annotations all over the place

     - Curing the UP madness by exposing a proper per CPU cpu_info for the
       price of wasting 320 byte of memory.

       Even if the size police will hate me for that, this cures most of
       the madness in one go and avoids to add more hideous macro mess
       similar to the completely bogus cpu_data() one which should have
       never been there in the first place.

       I know that there are people who think that size matters, but the
       only things which really matter in software are correctness and
       maintainability. The latter simply forbids to add more hideous macro
       mess just to avoid wasting 320 bytes of memory for something which
       is mostly a reminiscence of the good old days...
       
     - Fixing a few obvious non __percpu related warnings which stood out
       prominently.

That reduces the sparse warnings in arch/x86 significantly. The remaining
ones are less trivial to address:

     - The non-x86 specific warning vs. sighand::lock:

       sparse: warning: incorrect type in argument 1 (different address spaces)
       sparse:    expected struct lockdep_map const *lock
       sparse:    got struct lockdep_map [noderef] __rcu *

     - A bunch of lock scope false positives which are non-trivial to solve

     - A gazillion of __iomem warnings with the vast majority in the HPE/UV
       code which are _all_ legit because neither UV nor the other places
       care about the name space annotations at all. Pointer is pointer
       after all.

     - Tons of truncation warnings like this:

       sparse: warning: cast truncates bits from constant value (20002 becomes 2)

       mostly in the hypervisor space (kvm, hyperv). I did not look at
       those at all so I don't know whether they matter or not.

I really think sparse is valuable, but all of us should spend more time on
this to weed out false positives or at least have some filtering of things
which are simply not solvable at the sparse level.

Coming back to __percpu. As I mentioned in the original thread it's a sad
state of affairs that the only way to detect the __percpu fails is sparse
or some other static checker:

      https://lore.kernel.org/all/87bk7vuldh.ffs@tglx

But that's a different problem to solve and does not invalidate the fixes
which come with this series in any way.

If the compiler people would have provided a way to utilize the anyway
non-standard name space support in a useful way, I could have spared the
time to bang my head agaist the wall simply because this would have failed
to build in the first place long ago. That just makes me sad.

After wading through this, I really ask the 0-day people to push hard on
any sparse fallout which involves __percpu. The resulting failures can be
truly subtle and not necessarily fatal right away.

The series is based on Linus tree and also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/core

Thanks,

	tglx
---
 arch/alpha/kernel/smp.c              |    5 -----
 arch/arc/kernel/smp.c                |    5 -----
 arch/csky/kernel/smp.c               |    4 ----
 arch/hexagon/kernel/smp.c            |    4 ----
 arch/openrisc/kernel/smp.c           |    4 ----
 arch/riscv/kernel/smpboot.c          |    4 ----
 arch/sparc/kernel/smp_64.c           |    4 ----
 arch/x86/events/amd/uncore.c         |    2 +-
 arch/x86/events/intel/core.c         |    1 +
 arch/x86/events/intel/ds.c           |    1 +
 arch/x86/include/asm/debugreg.h      |   24 ++++++++++++++++++++++++
 arch/x86/include/asm/fsgsbase.h      |    2 +-
 arch/x86/include/asm/msr.h           |   26 ++++++++++++++------------
 arch/x86/include/asm/processor.h     |   28 ----------------------------
 arch/x86/include/asm/smp.h           |    5 -----
 arch/x86/include/asm/spec-ctrl.h     |    2 ++
 arch/x86/include/asm/special_insns.h |    4 ++--
 arch/x86/include/asm/tsc.h           |    3 ++-
 arch/x86/include/asm/uaccess_64.h    |    7 ++++---
 arch/x86/kernel/callthunks.c         |    4 ++--
 arch/x86/kernel/cpu/bugs.c           |    2 +-
 arch/x86/kernel/cpu/common.c         |    3 +++
 arch/x86/kernel/cpu/intel_pconfig.c  |    2 ++
 arch/x86/kernel/cpu/rdrand.c         |    1 +
 arch/x86/kernel/fpu/bugs.c           |    2 ++
 arch/x86/kernel/setup.c              |   10 ++++++++++
 arch/x86/kernel/smpboot.c            |    9 +++++----
 arch/x86/kernel/step.c               |    2 ++
 arch/x86/kvm/mmu/mmu.c               |    3 +--
 arch/x86/lib/msr-smp.c               |   12 +++++-------
 arch/x86/lib/msr.c                   |    6 +++---
 include/linux/smp.h                  |   13 ++++++-------
 init/main.c                          |    4 ++++
 33 files changed, 99 insertions(+), 109 deletions(-)

