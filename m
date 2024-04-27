Return-Path: <linux-kernel+bounces-161076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2588B46C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02120B23865
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B41366;
	Sat, 27 Apr 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZAIumUeG"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DA15A5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229819; cv=none; b=TsQqt5iq6PmXOKGcXtwh9C3HMXUQruedFvYGa1T1aVeKLAwLqXKC/7ZfahK9HIY8JhEqqe6kfuPt6VnT4QG05PHYr8R4Gr2XBgtpNnsHlLFiu2aOx6F7D4klh8lc1k354irnT73gO31Xb1hFop37wldeszks1NShAAOZmlvR+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229819; c=relaxed/simple;
	bh=oJrd1SLun3RtHRcWjhjEnuNFUEel7bd/8bdkLkjnXb4=;
	h=Date:Subject:CC:From:To:Message-ID; b=GezorPiZbEXSXV7JL9m+IRswkqbxKxeO56hMT48P4//Y0kkUNXZO8lVcqON4XUBKjwyFY7pem0LKpBKgj44rnpsAkh2H/zmTUxECrHeRW8e0q+cgfg2nHvgrbzUdU3GeCilSKMMHSeMVOJR4xuS7/7A1NLLa6cVRqqZweeN5QBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZAIumUeG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecff9df447so3090778b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714229816; x=1714834616; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+kE8hkHGsVsGGS/xS7RahbuA7ku3TuLmh7h46vKCVg=;
        b=ZAIumUeGCMr3swNpG/72wqLdAa/0/8CrJnBI0dj84Ec5AGBbLIU96X7UjHKPsXpoNw
         055M4iYtDhpAxLPGLymQMKoRPZwih/y+3Aef2qaGcNhQCQ3XJ1YPu4mx2irf8dgG8xCF
         uvjDftgrhPidhDS2r/rXZ+7AbFouR4ykl/vZdww57rhKQabHzOyEELP8flpMWk9ebcn0
         YXV86ZQ7R9N0ol2vyzwOln+TsJtuCRC67DW83zB8U5GhXhutirfL0AetzReGIEnGEeLC
         unwP5VWIIa81IeOS/hI8XrR49H3vePNBYY67LEV72L2413xyBG+CVtvEPdlKYW5YEN4M
         5qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714229816; x=1714834616;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+kE8hkHGsVsGGS/xS7RahbuA7ku3TuLmh7h46vKCVg=;
        b=ifWAWtqqz0sOFTK7HITnAchoHqzhhEciee3g9AfhbG6MGtqySrdbzWEyus6zjpeIti
         SSocNY5eCzxOFHsZbBFE0tRLPqMumySf6SVJolyf5nQnbeo2ocV6psqcfgp2fXbBIeLS
         c+vCXGofjwnWkoeoQuveMVfFcFZlXqzx3+KH6/CooviGkDb7t9qJ+Pcux9SP7Ix51xc4
         v1qA+DyWtU5IaM3+mFtaUrUYIuC4fAij85/9BlPoKuPOOyOo/sNW1zTjJxerprGtijP9
         NTf2z1kA6cC7MLtv9R2HQCg4Fl9AhqoMyb/ywvnojDkMNK2MyiLwHOse+6fekiHQK6jf
         TPbQ==
X-Gm-Message-State: AOJu0YwA9XgC4ghTv/FwZQHbO9OolrHkCIAzAlMr5D5bzJjgON5nyK09
	vr+45Gl94htTt0iISYgVHLczBz2wQeOGgXN8US9R+ZOYEPjphPnfIJ2S1c9cbvxh92x2EPNlYYZ
	w
X-Google-Smtp-Source: AGHT+IHUyuQ5y6Tgjxg/K1ZD3Qr4sheNZDTKePMieGzn0RANAkQ44r2juHsrJbrehev1WQgcV4qbgg==
X-Received: by 2002:a05:6a00:114d:b0:6ed:1c7:8c5d with SMTP id b13-20020a056a00114d00b006ed01c78c5dmr7428855pfm.12.1714229815703;
        Sat, 27 Apr 2024 07:56:55 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id h17-20020aa79f51000000b006e71aec34a8sm16450224pfr.167.2024.04.27.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 07:56:54 -0700 (PDT)
Date: Sat, 27 Apr 2024 07:56:54 -0700 (PDT)
X-Google-Original-Date: Sat, 27 Apr 2024 07:56:42 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.9-rc6
CC:        linux-kernel@vger.kernel.org,         linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-2f5e2c44-3944-4a0e-9669-12967d8e6f15@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit d14fa1fcf69db9d070e75f1c4425211fa619dfc8:

  riscv: process: Fix kernel gp leakage (2024-04-04 12:35:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-rc6

for you to fetch changes up to 6beb6bc5a81e1433a1534e75173f67d42a6f225a:

  Merge patch series "RISC-V: Test th.sxstatus.MAEE bit before enabling MAEE" (2024-04-26 10:21:57 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.9-rc6

* A fix for TASK_SIZE on rv64/NOMMU, to reflect the lack of user/kernel
  separation.
* A fix to avoid loading rv64/NOMMU kernel past the start of RAM.
* A fix for RISCV_HWPROBE_EXT_ZVFHMIN on ilp32 to avoid signed integer
  overflow in the bitmask.
* The sud_test kselftest has been fixed to properly swizzle the syscall
  number into the return register, which are not the same on RISC-V.
* A fix for a build warning in the perf tools on rv32.
* A fix for the CBO selftests, to avoid non-constants leaking into the
  inline asm.
* A pair of fixes for T-Head PBMT errata probing, which has been renamed
  MAE by the vendor.

----------------------------------------------------------------
Sorry this is late, but I found an issue in one of the patches as I was looking
through yesterday and dropped it, so I wanted to make sure everything got a
chance to make it through linux-next.

No big deal if this doesn't make it to rc6, nothing is super critical.  They're
all fixes, though, so I figured it'd be better to just send this now rather
than waiting for next week.

----------------------------------------------------------------
Andrew Jones (1):
      RISC-V: selftests: cbo: Ensure asm operands match constraints, take 2

Ben Zong-You Xie (1):
      perf riscv: Fix the warning due to the incompatible type

Christoph Müllner (2):
      riscv: thead: Rename T-Head PBMT to MAE
      riscv: T-Head: Test availability bit before enabling MAE errata

Clément Léger (2):
      riscv: hwprobe: fix invalid sign extension for RISCV_HWPROBE_EXT_ZVFHMIN
      selftests: sud_test: return correct emulated syscall value on RISC-V

Palmer Dabbelt (2):
      Merge patch the fixes from "riscv: 64-bit NOMMU fixes and enhancements"
      Merge patch series "RISC-V: Test th.sxstatus.MAEE bit before enabling MAEE"

Samuel Holland (2):
      riscv: Fix TASK_SIZE on 64-bit NOMMU
      riscv: Fix loading 64-bit NOMMU kernels past the start of RAM

 arch/riscv/Kconfig.errata                          |  8 ++++----
 arch/riscv/errata/thead/errata.c                   | 24 ++++++++++++++--------
 arch/riscv/include/asm/errata_list.h               | 20 +++++++++---------
 arch/riscv/include/asm/page.h                      |  2 +-
 arch/riscv/include/asm/pgtable.h                   |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h              |  2 +-
 arch/riscv/mm/init.c                               |  2 +-
 tools/perf/arch/riscv/util/header.c                |  2 +-
 tools/testing/selftests/riscv/hwprobe/cbo.c        |  2 +-
 tools/testing/selftests/riscv/hwprobe/hwprobe.h    | 10 +++++++++
 .../selftests/syscall_user_dispatch/sud_test.c     | 14 +++++++++++++
 11 files changed, 59 insertions(+), 29 deletions(-)

