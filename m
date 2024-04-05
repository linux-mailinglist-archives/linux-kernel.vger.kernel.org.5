Return-Path: <linux-kernel+bounces-133425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D561389A37D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EAC1C218C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B762171670;
	Fri,  5 Apr 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EXzvZofc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE116132B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338168; cv=none; b=YXFkzq303/6FPkE2tVwEsaThlUcqAeL+Tr3YKel5uWfwD8w2bdZeZZZIjpT22YasTOV4trbRSkZnRYNQjJBaxoD2O9jta5j2L8KLN5p+YQpTtnegCrdz0HfYDplvz6016fybK3U0GmTyJKNJbjbdrB+Ab8aIAkBwjVVC8bN+J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338168; c=relaxed/simple;
	bh=zoreA7+EyQxV5EiqdfcGtZK0hxIoElLFckq7qdRiMuw=;
	h=Date:Subject:CC:From:To:Message-ID; b=RqxtzoUu8jpPgGyHNZSXc/qlTT/yFdGTzO1lxkkl2Z8/7CKnZeWPt2A3g4e6T3lh9+tHbxpa6hcvXaH821G8ZVOHcHuxjgtIHwrf4g/cXW28TN/UqDUigchpR5j/infIDNek6DAFCEHlJa7uGvrwynxbbpf0Ru4eOAD7x49yyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EXzvZofc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so2137315b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712338166; x=1712942966; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO5f4h758dBNmiDAJhldDYKOhisPvEGqSyQ4iiERmME=;
        b=EXzvZofcI4hCzwaxDDEfZ3M1u8Z8ff/vBSrz+AC9oqiStce/U7olR15KzFbWEQr82O
         QhwYsDzGO0M9ycoYu0m4fGV/xlY5AbTfXuNv8Nzd90j9GWk5zyrhXTye1WfWM6WY1hrT
         43wzKbtthTxks4vNC+04Epx8FA0uNkg3tcHVNFJv6hlI0cCf1EGiZQeTSLl0C1GPeVrb
         andpF8xlaHBk8tMJ3oi487fhBPboqo3YbRhNlbFy9qvCzArFpQduX4N3ofINmL1vCxRE
         sIC7rKanfyU9DJFCp4+NDTcIau6ur/URKUnMF9qchMt5tugvb8MSMn/NqbaQwoiO8CMj
         GqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338166; x=1712942966;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO5f4h758dBNmiDAJhldDYKOhisPvEGqSyQ4iiERmME=;
        b=t5aqLtz8uQh/hMpfYZx+XwUu5AEnGMQbhk4JhPkFtsayIlY+PWsF7T+bu/2CCWCOIe
         +9OIIhyz19fdolgqQOU/MylAs+p+ngQsHgIBAH8+opcJjpV32GpNA8X9+N7z67nIKiYP
         ifJHZSLt6W99At3goGoTXkAmKOrZUKNqKCrfLoFTjClFM6c3GfKzwo4eNw5wGjjFEtWk
         TJ58rVPh1fY+liV/H0UOPv/wvjQxTSVHPt+2MBMcHpA3ZWzK1O4pXS6dJnaOif1abMXk
         V9dCuTXQw4mZcwP3mwVUN6RMrQU3NtHA7GFRWGPm7sxyfwKC4vejkk7proBd7uexNXwr
         B6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUOnCS9miJFt9VaknhAm9Xu50wyPep8ac9IlJ8QvbMRFLEKDoC+vtrRKyWmZHkQ6r8tdVuzfQpNJVZ90q+W5I1DRzyI/glvs/TlddZf
X-Gm-Message-State: AOJu0YyBCuCmEFfS6NbHqQuWpWDTLS1bzeplb264D/iRVnIiwCFDaRXH
	jFwcH3f5sbrpf+ZA3geYajpVcPD2hUDYKx9Nj4EzPpcx9nIh61Iyl4JMyrCNTRt/FHhdM0AaLZY
	t
X-Google-Smtp-Source: AGHT+IE2251VrHWLZ0prAu7SSHn+DVyi5u3CH3BVvNzid0hoXLca2RkLGi9W3l4saSgMej+DT+662w==
X-Received: by 2002:a05:6a00:22d1:b0:6ec:fdcc:3cce with SMTP id f17-20020a056a0022d100b006ecfdcc3ccemr2388441pfj.5.1712338165463;
        Fri, 05 Apr 2024 10:29:25 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00188700b006ecfe20d38csm1759033pfh.30.2024.04.05.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:29:24 -0700 (PDT)
Date: Fri, 05 Apr 2024 10:29:24 -0700 (PDT)
X-Google-Original-Date: Fri, 05 Apr 2024 10:18:39 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.9-rc3
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-28e73e09-0100-4e0e-8c4a-490552b42c6f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-rc3

for you to fetch changes up to d14fa1fcf69db9d070e75f1c4425211fa619dfc8:

  riscv: process: Fix kernel gp leakage (2024-04-04 12:35:05 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.9-rc3

* A fix for an __{get,put}_kernel_nofault to avoid an uninitialized
  value causing spurious failures.
* compat_vdso.so.dbg is now installed to the standard install location.
* A fix to avoid initializing PERF_SAMPLE_BRANCH_*-related events, as
  they aren't supported and will just later fail.
* A fix to make AT_VECTOR_SIZE_ARCH correct now that we're providing
  AT_MINSIGSTKSZ.
* pgprot_nx() is now implemented, which fixes vmap W^X protection.
* A fix for the vector save/restore code, which at least manifests as
  corrupted vector state when a signal is taken.
* A fix for a race condition in instruction patching.
* A fix to avoid leaking the kernel-mode GP to userspace, which is a
  kernel pointer leak that can be used to defeat KASLR in various ways.
* A handful of smaller fixes to build warnings, an overzealous printk,
  and some missing tracing annotations.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Fix warning by declaring arch_cpu_idle() as noinstr
      riscv: Disable preemption when using patch_map()

Andreas Schwab (1):
      riscv: use KERN_INFO in do_trap

Björn Töpel (1):
      riscv: Fix vector state restore in rt_sigreturn()

Jisheng Zhang (1):
      riscv: mm: implement pgprot_nx

Masahiro Yamada (2):
      riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
      riscv: compat_vdso: align VDSOAS build log

Pu Lehui (1):
      drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Sami Tolvanen (1):
      riscv: Mark __se_sys_* functions __used

Samuel Holland (2):
      riscv: mm: Fix prototype to avoid discarding const
      riscv: Fix spurious errors from __get/put_kernel_nofault

Stefan O'Rear (1):
      riscv: process: Fix kernel gp leakage

Victor Isaev (1):
      RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ

Vladimir Isaev (1):
      riscv: hwprobe: do not produce frtace relocation

 arch/riscv/Makefile                      |  2 +-
 arch/riscv/include/asm/pgtable.h         |  6 ++++++
 arch/riscv/include/asm/syscall_wrapper.h |  3 ++-
 arch/riscv/include/asm/uaccess.h         |  4 ++--
 arch/riscv/include/uapi/asm/auxvec.h     |  2 +-
 arch/riscv/kernel/compat_vdso/Makefile   |  2 +-
 arch/riscv/kernel/patch.c                |  8 ++++++++
 arch/riscv/kernel/process.c              |  5 +----
 arch/riscv/kernel/signal.c               | 15 ++++++++-------
 arch/riscv/kernel/traps.c                |  2 +-
 arch/riscv/kernel/vdso/Makefile          |  1 +
 arch/riscv/mm/tlbflush.c                 |  4 ++--
 drivers/perf/riscv_pmu.c                 |  4 ++++
 13 files changed, 38 insertions(+), 20 deletions(-)

