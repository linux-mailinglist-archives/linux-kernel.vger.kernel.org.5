Return-Path: <linux-kernel+bounces-18415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A82825D20
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED13B23031
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D38360BA;
	Fri,  5 Jan 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Di+3X3rw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2C364A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbb7d80df8so37681a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 15:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704496879; x=1705101679; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbvHLRvdq2cIFEOMx0YJzw29ePai9PZ8ok9NLe6X4Pc=;
        b=Di+3X3rwWKX9rsa9cLxLZwRmeRJ07UlFOG21wnxGKd538WeXXZhbYcqs+IHyFJeySo
         5g7txwarIAuQU0yL2UThDx02fFVqEY7BNM6MKKVwYgq1AgawS/aK9wfXQroBUansSzjT
         BO/tF+6GRyykAT3FHE9u7C4s8ovjgxP7DEP9VJgwxFEr0k1wfDrP6W+dNdRBFp+9ql5Z
         753kzJMwp1CaO/yDWfKYKVzkBqzs3h84CJekcN+lSxyATvUVWKA0W1N/5j3ewrqxLUHc
         mmJ5ABWvt0IKoDlYBbK541FwxuDqa7rwFPRwOvSHL9j+4Y8U50cd/g/FEVQjyQVXLejY
         fGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704496879; x=1705101679;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbvHLRvdq2cIFEOMx0YJzw29ePai9PZ8ok9NLe6X4Pc=;
        b=Quf84RiYPvUBetpp76+WSuG89uxSsPx35eeRZNtVydsiMcBhx1NhtpNYPbYtbTX2L/
         SpkTwMXUInqKF3yddCEgRz+tz8jNAi3IrzbqK7R3hMQmp46T+Kj2lt9QtERKtUbd1B5Q
         CE3V6T1PigBIR8M1n3RKg6PiXk+3vAlWXE+n5c7XAC4jCxROwl81ScdtKboOD1QmplYs
         E2kkd4lVHPvkhXScUu6jSG0l/6T9FAyE/yMsQr9L3ZAJOlKSKthsFBSDXgwmks05on1t
         iv8hqYyg6/44yJaz/ccSZAXrMJgSUhtyvak7X+ht4aI25/M+ZMl9VlbAJbXUUei8wlXj
         6Xag==
X-Gm-Message-State: AOJu0YylouGJ9/h+rBFLhPZRg4RBOB4GEDwDI5Ytghf004mGRqjvQbiD
	ON/8rlKJiBOqY1+4n2kVwlzBti3zwhU5
X-Google-Smtp-Source: AGHT+IGWe4QYUPHR/usQUs8emRvz+xwh5dBFs2z4vIGZOO+XCHts6hRH5+KDAtjilDUa7m2pMLv7PQ==
X-Received: by 2002:a9d:6a94:0:b0:6d9:d815:f399 with SMTP id l20-20020a9d6a94000000b006d9d815f399mr127987otq.66.1704496879579;
        Fri, 05 Jan 2024 15:21:19 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bz25-20020a05622a1e9900b00419732075b4sm1143730qtb.84.2024.01.05.15.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:21:19 -0800 (PST)
Date: Fri, 05 Jan 2024 18:21:18 -0500
Message-ID: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240105
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Linus,

I realize this is a little early, but my network access is expected to
be a little spotty the first half of next week so I wanted to get the
Linux v6.8 pull requests out now.  The hightlights of the LSM pull
request are below, but before we get to that I want to mention that I
expect you will hit merge conflicts in the arch-specific syscall
tables as well as in the doc userspace-api documentation index.  Some
of these conflicts exist in your tree now (syscall tables), with some
others likely depending on what is submitted from linux-next and the
order in which you merge things.  All of the conflicts that I've seen
have been rather trivial and easily resolved, but I wanted to give you
a heads-up; if you want me to resolve any of these let me know.

* Add three new syscalls: lsm_list_modules(), lsm_get_self_attr(), and
lsm_set_self_attr().  The first syscall simply lists the LSMs enabled,
while the second and third get and set the current process' LSM
attributes.  Yes, these syscalls may provide similar functionality to
what can be found under /proc or /sys, but they were designed to
support multiple, simultaneaous (stacked) LSMs from the start as
opposed to the current /proc based solutions which were created at a
time when only one LSM was allowed to be active at a given time.  We
have spent considerable time discussing ways to extend the existing
/proc interfaces to support multiple, simultaneaous LSMs and even our
best ideas have been far too ugly to support as a kernel API; after
+20 years in the kernel, I felt the LSM layer had established itself
enough to justify a handful of syscalls.  Support amongst the
individual LSM developers has been nearly unanimous, with a single
objection coming from Tetsuo (TOMOYO) as he is worried that the
LSM_ID_XXX token concept will make it more difficult for out-of-tree
LSMs to survive.  Several members of the LSM community have
demonstrated the ability for out-of-tree LSMs to continue to exist
by picking high/unused LSM_ID values as well as pointing out that
many kernel APIs rely on integer identifiers, e.g. syscalls (!), but
unfortunately Tetsuo's objections remain.  My personal opinion is that
while I have no interest in penalizing out-of-tree LSMs, I'm not going
to penalize in-tree development to support out-of-tree development,
and I view this as a necessary step forward to support the push for
expanded LSM stacking and reduce our reliance on /proc and /sys which
has occassionally been problematic for some container users.  Finally,
we have included the linux-api folks on (all?) recent revisions of
the patchset and addressed all of their concerns.

* Add a new security_file_ioctl_compat() LSM hook to handle the 32-bit
ioctls on 64-bit systems problem.  This patch includes support for all
of the existing LSMs which provide ioctl hooks, although it turns out
only SELinux actually cares about the individual ioctls.  It is worth
noting that while Casey (Smack) and Tetsuo (TOMOYO) did not give
explicit ACKs to this patch, they did both indicate they are okay with
the changes.

* Fix a potential memory leak in the CALIPSO code when IPv6 is
disabled at boot.  While it's good that we are fixing this, I doubt
this is something users are seeing in the wild as you need to both
disable IPv6 and then attempt to configure IPv6 labeled networking
via NetLabel/CALIPSO; that just doesn't make much sense.  Normally
this would go through netdev, but Jakub asked me to take this patch
and of all the trees I maintain, the LSM tree seemed like the best
fit.

* Update the LSM MAINTAINERS entry with additional information about
our process docs, patchwork, bug reporting, etc.  I also noticed that
the Lockdown LSM is missing a dedicated MAINTAINERS entry so I've
added that to the pull request.  I've been working with one of the
major Lockdown authors/contributors to see if they are willing to
step up and assume a Lockdown maintainer role; hopefully that will
happen soon, but in the meantime I'll continue to look after it.

* Add a handful of mailmap entries for Serge Hallyn and myself.

Thanks,
-Paul

--
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240105

for you to fetch changes up to f1bb47a31dff6d4b34fb14e99850860ee74bb003:

  lsm: new security_file_ioctl_compat() hook (2023-12-24 15:48:03 -0500)

----------------------------------------------------------------
lsm/stable-6.8 PR 20240105

----------------------------------------------------------------
Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Casey Schaufler (11):
      LSM: Identify modules by more than name
      LSM: Maintain a table of LSM attribute data
      proc: Use lsmids instead of lsm names for attrs
      LSM: syscalls for current process attributes
      LSM: Create lsm_list_modules system call
      LSM: wireup Linux Security Module syscalls
      LSM: Helpers for attribute names and filling lsm_ctx
      Smack: implement setselfattr and getselfattr hooks
      AppArmor: Add selfattr hooks
      SELinux: Add selfattr hooks
      LSM: selftests for Linux Security Module syscalls

Gavrilov Ilia (1):
      calipso: fix memory leak in netlbl_calipso_add_pass()

Mark Brown (1):
      lsm: Add a __counted_by() annotation to lsm_ctx.ctx

Paul Moore (11):
      lsm: drop LSM_ID_IMA
      lsm: cleanup the size counters in security_getselfattr()
      lsm: correct error codes in security_getselfattr()
      lsm: consolidate buffer size handling into lsm_fill_user_ctx()
      lsm: align based on pointer length in lsm_fill_user_ctx()
      lsm: convert security_setselfattr() to use memdup_user()
      lsm: mark the lsm_id variables are marked as static
      mailmap: update/replace my old email addresses
      MAINTAINERS: update the LSM entry
      MAINTAINERS: add an entry for the lockdown LSM
      selftests: remove the LSM_ID_IMA check in lsm/lsm_list_modules_test

Roberto Sassu (1):
      lsm: don't yet account for IMA in LSM_CONFIG_COUNT calculation

Serge Hallyn (1):
      mailmap: add entries for Serge Hallyn's dead accounts

 .mailmap                                           |   4 +
 Documentation/userspace-api/index.rst              |   1 +
 Documentation/userspace-api/lsm.rst                |  73 ++++++
 MAINTAINERS                                        |  17 +-
 arch/alpha/kernel/syscalls/syscall.tbl             |   3 +
 arch/arm/tools/syscall.tbl                         |   3 +
 arch/arm64/include/asm/unistd.h                    |   2 +-
 arch/arm64/include/asm/unistd32.h                  |   6 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   3 +
 arch/s390/kernel/syscalls/syscall.tbl              |   3 +
 arch/sh/kernel/syscalls/syscall.tbl                |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   3 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   3 +
 fs/ioctl.c                                         |   3 +-
 fs/proc/base.c                                     |  29 +--
 fs/proc/internal.h                                 |   2 +-
 include/linux/lsm_hook_defs.h                      |   6 +
 include/linux/lsm_hooks.h                          |  17 +-
 include/linux/security.h                           |  56 ++++-
 include/linux/syscalls.h                           |   6 +
 include/uapi/asm-generic/unistd.h                  |   9 +-
 include/uapi/linux/lsm.h                           |  90 +++++++
 kernel/sys_ni.c                                    |   3 +
 net/netlabel/netlabel_calipso.c                    |  49 ++--
 security/Makefile                                  |   1 +
 security/apparmor/include/procattr.h               |   2 +-
 security/apparmor/lsm.c                            |  90 ++++++-
 security/apparmor/procattr.c                       |  10 +-
 security/bpf/hooks.c                               |   9 +-
 security/commoncap.c                               |   8 +-
 security/landlock/cred.c                           |   2 +-
 security/landlock/fs.c                             |   2 +-
 security/landlock/net.c                            |   2 +-
 security/landlock/ptrace.c                         |   2 +-
 security/landlock/setup.c                          |   6 +
 security/landlock/setup.h                          |   1 +
 security/loadpin/loadpin.c                         |   9 +-
 security/lockdown/lockdown.c                       |   8 +-
 security/lsm_syscalls.c                            | 120 +++++++++
 security/safesetid/lsm.c                           |   9 +-
 security/security.c                                | 273 +++++++++++++++-
 security/selinux/hooks.c                           | 173 ++++++++++---
 security/smack/smack_lsm.c                         |  93 ++++++-
 security/tomoyo/tomoyo.c                           |  10 +-
 security/yama/yama_lsm.c                           |   8 +-
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   3 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   3 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   3 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/lsm/.gitignore             |   1 +
 tools/testing/selftests/lsm/Makefile               |  17 ++
 tools/testing/selftests/lsm/common.c               |  89 +++++++
 tools/testing/selftests/lsm/common.h               |  33 +++
 tools/testing/selftests/lsm/config                 |   3 +
 .../testing/selftests/lsm/lsm_get_self_attr_test.c | 275 +++++++++++++++++
 .../testing/selftests/lsm/lsm_list_modules_test.c  | 137 ++++++++++
 .../testing/selftests/lsm/lsm_set_self_attr_test.c |  74 ++++++
 66 files changed, 1776 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/.gitignore
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/common.c
 create mode 100644 tools/testing/selftests/lsm/common.h
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

--
paul-moore.com

