Return-Path: <linux-kernel+bounces-25365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EA482CE66
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47C31C21097
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9914F6D;
	Sat, 13 Jan 2024 20:38:37 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0465DF70
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6129064103FF;
	Sat, 13 Jan 2024 21:38:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QIpaonAs35a3; Sat, 13 Jan 2024 21:38:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 03BA163434F8;
	Sat, 13 Jan 2024 21:38:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y492wK1HQJKy; Sat, 13 Jan 2024 21:38:24 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E13A164103FF;
	Sat, 13 Jan 2024 21:38:24 +0100 (CET)
Date: Sat, 13 Jan 2024 21:38:24 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for v6.8-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: idAAwHz3fxN2fDnKC6CSXjTnRbLUJQ==
Thread-Topic: UML updates for v6.8-rc1

Linus,

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082=
:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-=
linus-6.8-rc1

for you to fetch changes up to 83aec96c631e0fa75cfe6d6a1b113a32151aaa88:

  um: Mark 32bit syscall helpers as clobbering memory (2024-01-05 16:28:57 =
+0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Clang coverage support
- Many cleanups from Benjamin Berg
- Various minor fixes

----------------------------------------------------------------
Anton Ivanov (2):
      um: Fix naming clash between UML and scheduler
      um: document arch_futex_atomic_op_inuser

Benjamin Berg (11):
      um: Drop support for hosts without SYSEMU_SINGLESTEP support
      um: Drop NULL check from start_userspace
      um: Make errors to stop ptraced child fatal during startup
      um: Don't use vfprintf() for os_info()
      um: Do not use printk in SIGWINCH helper thread
      um: Reap winch thread if it fails
      um: Do not use printk in userspace trampoline
      um: Always inline stub functions
      um: Rely on PTRACE_SETREGSET to set FS/GS base registers
      um: Remove unused register save/restore functions
      um: Mark 32bit syscall helpers as clobbering memory

Johannes Berg (2):
      um: mmu: remove stub_pages
      um: time-travel: fix time corruption

Micha=C5=82 Winiarski (2):
      arch: um: Add Clang coverage support
      Documentation: kunit: Add clang UML coverage example

Nathan Chancellor (1):
      um: net: Fix return type of uml_net_start_xmit()

Vincent Whitchurch (1):
      um: virt-pci: fix platform map offset

 Documentation/dev-tools/kunit/running_tips.rst |  11 +++
 arch/um/Makefile-skas                          |   5 ++
 arch/um/drivers/chan_user.c                    |  42 +++++----
 arch/um/drivers/line.c                         |  13 +--
 arch/um/drivers/net_kern.c                     |   2 +-
 arch/um/drivers/virt-pci.c                     |   2 +-
 arch/um/include/asm/mmu.h                      |   1 -
 arch/um/include/asm/processor-generic.h        |   1 -
 arch/um/include/shared/kern_util.h             |   5 +-
 arch/um/include/shared/os.h                    |   3 -
 arch/um/include/shared/ptrace_user.h           |  41 ---------
 arch/um/include/shared/registers.h             |   2 -
 arch/um/kernel/process.c                       |  14 +--
 arch/um/kernel/ptrace.c                        |   2 -
 arch/um/kernel/signal.c                        |  12 ---
 arch/um/kernel/skas/uaccess.c                  |   4 +-
 arch/um/kernel/time.c                          |  32 +++++--
 arch/um/os-Linux/helper.c                      |   6 +-
 arch/um/os-Linux/registers.c                   |  20 -----
 arch/um/os-Linux/skas/process.c                | 117 ++++++++-------------=
----
 arch/um/os-Linux/start_up.c                    | 111 ++++-----------------=
--
 arch/um/os-Linux/util.c                        |  19 +++-
 arch/x86/um/asm/elf.h                          |   4 +-
 arch/x86/um/asm/processor_64.h                 |   3 -
 arch/x86/um/os-Linux/Makefile                  |   1 -
 arch/x86/um/os-Linux/prctl.c                   |  12 ---
 arch/x86/um/ptrace_32.c                        |  24 -----
 arch/x86/um/ptrace_64.c                        |  26 ------
 arch/x86/um/shared/sysdep/ptrace_32.h          |   4 -
 arch/x86/um/shared/sysdep/ptrace_user.h        |  12 ++-
 arch/x86/um/shared/sysdep/stub_32.h            |  39 +++++----
 arch/x86/um/shared/sysdep/stub_64.h            |  17 ++--
 arch/x86/um/syscalls_64.c                      |  62 +++----------
 arch/x86/um/tls_64.c                           |   2 +-
 34 files changed, 212 insertions(+), 459 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/prctl.c

