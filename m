Return-Path: <linux-kernel+bounces-88607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C586E416
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B12B285CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D26A8C1;
	Fri,  1 Mar 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wMaD8Kc7"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2373FB88
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305991; cv=none; b=cI/k5yc8o5L4ECD+18wZE4k2ZZ+EzUE7+hTUTJaTdqXVv+gDER7UMJhyEQPA9ztGZQHNmU+lmHqnyh9lJynM3LHu3bRhb7ljs8zqLHop2ysB5/Z2fmj7P+gApygVCKVUvI0C+1kMvC0L8/+iaMRjFCIbbuDI5Pli83mbzHk9jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305991; c=relaxed/simple;
	bh=pryREyFPVxQez0Vhm3NxebtIsITZi3W7CjRb1vVOLks=;
	h=Date:Subject:CC:From:To:Message-ID; b=nqRF2dSxbvJRJbMjSHYbIrs5hKPMpuvH5iVVskHBY4fH5w3BYmhkxI8yJsBxBTGj+UTZkLxAmcqN8L5RDyGhd2IQWK0jRe5CfZvQaeHzxRYcQGC6l1YWmtLaaBVIOk6rB1gUlbbatHV2VDelHvji7+GwqBEuQ5vZy6skksD3dTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wMaD8Kc7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5ce1de109so344266b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709305988; x=1709910788; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMVK9+p+tkA+fohUNY71dFJvaJ/Hs/TdoD21E/6FbxQ=;
        b=wMaD8Kc7RVp4Jhj/6x8gzbCpwXKx+PF7nZTmwFmvDrKwRhOMTH5NWDYFei9q+7pFXx
         dwU/A9ug+QYfEEFPH4N/idtgRYJGPM6B8au0tpO7VriYteqJ8gI4arJZ+22ymRKfOYpY
         PEXhltgOOjU9VMsBug7HSxgAGFcyVzESQmqc+PPRkFQsdAhCtL0ebxWpM+Hm0oJW+h1Q
         CUqBw/RJGRfRLMvvLRGf2O3DMZXItcS+rdynbsb7QvklIyBooKjo3evoQLyRb4B1lPjj
         P2PcCHuZkZ0Wm6E/cHV6/luVOHFoA88cJOSmp+ZLxDB0r6ZCSBQgiOliK3AmApgpM4Oh
         EMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305988; x=1709910788;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMVK9+p+tkA+fohUNY71dFJvaJ/Hs/TdoD21E/6FbxQ=;
        b=iQK5cc/EGQrq+tyVuZyP3JRtAJ4uH0D13TRsvnyLZ8MdeOh9NChWoJsEIHtRllb4Ou
         egzyLVBY/liqpQANAzoz2QmGMbCSLKpJwHqzS5/wE2W20alWFlv1xNAwzIRHN9YEGFgf
         2JfATZdmha44me82qwiCTW8/wwMSQ5CHiNNjjH58BMr1TGKm99yY9zsKY4QJ8HLRBMvT
         ijWJca+ZiEhfA8eieUq5PD+i/ZlvhX4bx9Mz4IbAiJKDvbo1V2u+PTCpM2XdDOcVAkDg
         ng61rGgqcbeu9oSvGR9LIaKi/c8tc7bjz8IjzF1epR2fCe1eo9xYiAEbeXfcVr98CZ6y
         CthA==
X-Forwarded-Encrypted: i=1; AJvYcCUfK/M/cvkqtuRRCG0hGMPnHxww/cReUQUAAbjoinIXh8wxZw15HwJN/MWstN2SG5kGEiBw1uVcZ7/8ZmwTGxF8NZfjAv25Q8cE0EnN
X-Gm-Message-State: AOJu0Yx1r3EQtkV65ptLTHOA1AuBveR3adVM2Zh06J5nRhYmR3uo2m/T
	d00lXw4tXITBpvIH26OkR0Dzc4Y8KrN/VJIrmE/Vx2l6joWpyzzQZvv7kf6Nmndx/EOSiqqdn7n
	p
X-Google-Smtp-Source: AGHT+IGGb89ySbuv4ZT1f5mSZidSaCgG1DqN2pG1O4LijsieItM5uUQOPBJf9JXkYUi8mjuawf81Lw==
X-Received: by 2002:a05:6a21:189:b0:19e:cf1a:5369 with SMTP id le9-20020a056a21018900b0019ecf1a5369mr2333877pzb.24.1709305988298;
        Fri, 01 Mar 2024 07:13:08 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id ff11-20020a056a002f4b00b006e57b37a932sm3084044pfb.9.2024.03.01.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:13:07 -0800 (PST)
Date: Fri, 01 Mar 2024 07:13:07 -0800 (PST)
X-Google-Original-Date: Fri, 01 Mar 2024 07:12:59 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.8-rc7
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-17aa05c6-25a6-481d-ab1e-cd01d8b4da43@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 3951f6add519a8e954bf78691a412f65b24f4715:

  riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask (2024-02-07 10:19:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-rc7

for you to fetch changes up to a11dd49dcb9376776193e15641f84fcc1e5980c9:

  riscv: Sparse-Memory/vmemmap out-of-bounds fix (2024-02-29 12:24:31 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.8-rc7

* A fix for detecting ".option arch" support on not-yet-released LLVM
  builds.
* A fix for a missing TLB flush when modifying non-leaf PTEs.
* A handufl of fixes for T-Head custom extensions.
* A fix for systems with the legacy PMU, that manifests as a crash on
  kernels built without SBI PMU support.
* A fix for systems that clear *envcfg on suspend, which manifests as
  cbo.zero trapping after resume.
* A pair of fixes for Svnapot systems, including removing Svnapot
  support for huge vmalloc/vmap regions.

----------------------------------------------------------------
Alexandre Ghiti (3):
      riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
      Revert "riscv: mm: support Svnapot in huge vmap"
      riscv: Fix pte_leaf_size() for NAPOT

Conor Dooley (1):
      RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs

Dimitris Vlachos (1):
      riscv: Sparse-Memory/vmemmap out-of-bounds fix

Fei Wu (1):
      perf: RISCV: Fix panic on pmu overflow handler

Jisheng Zhang (1):
      riscv: tlb: fix __p*d_free_tlb()

Nathan Chancellor (2):
      kbuild: Add -Wa,--fatal-warnings to as-instr invocation
      RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH

Palmer Dabbelt (5):
      Merge patch series "RISC-V: Fix CONFIG_AS_HAS_OPTION_ARCH with tip of tree LLVM"
      Merge commit '8246601a7d391ce8207408149d65732f28af81a1' into fixes
      Merge patch series "drivers: perf: fix crash with the legacy riscv driver"
      Merge patch series "riscv: cbo.zero fixes"
      Merge patch series "NAPOT Fixes"

Samuel Holland (4):
      MAINTAINERS: Update SiFive driver maintainers
      riscv: Fix enabling cbo.zero when running in M-mode
      riscv: Add a custom ISA extension for the [ms]envcfg CSR
      riscv: Save/restore envcfg CSR during CPU suspend

Vadim Shakirov (2):
      drivers: perf: added capabilities for legacy PMU
      drivers: perf: ctr_get_width function for legacy is not defined

Yangyu Chen (1):
      riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly

Zong Li (1):
      riscv: add CALLER_ADDRx support

 MAINTAINERS                         | 29 +++---------------
 arch/riscv/Kconfig                  |  1 -
 arch/riscv/include/asm/csr.h        |  2 ++
 arch/riscv/include/asm/ftrace.h     |  5 +++
 arch/riscv/include/asm/hugetlb.h    |  2 ++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/pgalloc.h    | 20 ++++++++++--
 arch/riscv/include/asm/pgtable-64.h |  2 +-
 arch/riscv/include/asm/pgtable.h    |  6 +++-
 arch/riscv/include/asm/suspend.h    |  1 +
 arch/riscv/include/asm/vmalloc.h    | 61 +------------------------------------
 arch/riscv/kernel/Makefile          |  2 ++
 arch/riscv/kernel/cpufeature.c      | 31 +++++++++++++++++--
 arch/riscv/kernel/return_address.c  | 48 +++++++++++++++++++++++++++++
 arch/riscv/kernel/suspend.c         |  4 +++
 arch/riscv/mm/hugetlbpage.c         |  2 ++
 drivers/perf/riscv_pmu.c            | 18 +++--------
 drivers/perf/riscv_pmu_legacy.c     | 10 +++++-
 drivers/perf/riscv_pmu_sbi.c        |  8 ++---
 scripts/Kconfig.include             |  2 +-
 scripts/Makefile.compiler           |  2 +-
 21 files changed, 145 insertions(+), 113 deletions(-)
 create mode 100644 arch/riscv/kernel/return_address.c

