Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE27E0709
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345811AbjKCQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbjKCQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:53:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F01BF;
        Fri,  3 Nov 2023 09:53:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1FAC433C9;
        Fri,  3 Nov 2023 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699030404;
        bh=kCzStcz7CoMutFcDAU184FL4PCQg1iWiTdGyamRM7WY=;
        h=From:Date:Subject:To:Cc:From;
        b=dQrjqNPQdo/dHg+4PM28mBvTJZhWYd0E9eWFblLf/jx82vlWPTIDf0rZNH7yLVpJH
         gNGQdNKQ/PRSn4nexm3tBRrj3y7eDOXNzJ/+LwJOgUeMMGUfySB39tmovXAnoClZbn
         gv6007vbOoxnfT4qWx2WVP9wZzc76nuNc/ungIKDI4eIunSreIzo0v7TgjU50j/1D8
         ncUOy7AkhKBFj/zHXyf8QhLfZNhJv67hWQxbAkqynFat20/isvNuxhiL4dMWxtHQZv
         scjDhob4necNbf3nzkN2yTn20MeoHhEyHfnn8J+FQKUtZModjm1zqR+VgqEuFlnIm9
         G8qqFV8/w2apA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c6ec78a840so31077751fa.1;
        Fri, 03 Nov 2023 09:53:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz54LeZxTmHFDzsdKKQ8MomvFx+vVTHA60pkatabOVmjx5kd7tg
        IyWysx9VB6PWsYwlJxpIKCx3clyPZvWiHTlZz/M=
X-Google-Smtp-Source: AGHT+IGGiypPxQRwtotTkJhzKO3049gaZIIrBT+TiH0MG55EJXYjr9BKM1QeQwUKH80RPOnECjqb1vB2E6v7NcTp1D4=
X-Received: by 2002:a2e:3207:0:b0:2c6:f136:96bb with SMTP id
 y7-20020a2e3207000000b002c6f13696bbmr4469096ljy.17.1699030402446; Fri, 03 Nov
 2023 09:53:22 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 4 Nov 2023 01:52:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATanSD3N_dmwKAGEqEkCLUb7TL2cp67pP-WBWFOWBxG1g@mail.gmail.com>
Message-ID: <CAK7LNATanSD3N_dmwKAGEqEkCLUb7TL2cp67pP-WBWFOWBxG1g@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,


Please pull Kbuild updates for v6.7.
Thanks.


You will see a conflict in modpost.

The fix is available in linux-next.



The reason for the conflict is the following commit
that got in via the module tree.


commit 04311b9b306388288f72cf6ebde659274b06ffd6
Author: Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Fri Jun 16 09:51:33 2023 +0800

    module: Make is_valid_name() return bool




My pull request moved is_valid_name()
from scripts/mod/modpost.c to scripts/mod/modpost.h





The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.7

for you to fetch changes up to 5f56cb030e4bcf14be2233332d5cd83fff62a376:

  kbuild: support 'userldlibs' syntax (2023-11-01 23:26:01 +0900)

----------------------------------------------------------------
Kbuild updates for v6.7

 - Implement the binary search in modpost for faster symbol lookup

 - Respect HOSTCC when linking host programs written in Rust

 - Change the binrpm-pkg target to generate kernel-devel RPM package

 - Fix endianness issues for tee and ishtp MODULE_DEVICE_TABLE

 - Unify vdso_install rules

 - Remove unused __memexit* annotations

 - Eliminate stale whitelisting for __devinit/__devexit from modpost

 - Enable dummy-tools to handle the -fpatchable-function-entry flag

 - Add 'userldlibs' syntax

----------------------------------------------------------------
Jack Brennen (1):
      modpost: Optimize symbol search from linear to binary search

Jiri Slaby (SUSE) (1):
      kbuild: dummy-tools: pretend we understand -fpatchable-function-entry

Masahiro Yamada (25):
      kbuild: rpm-pkg: generate kernel.spec in rpmbuild/SPECS/
      kbuild: make binrpm-pkg always produce kernel-devel package
      modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host
      modpost: fix ishtp MODULE_DEVICE_TABLE built on big-endian host
      modpost: define TO_NATIVE() using bswap_* functions
      modpost: refactor check_sec_ref()
      modpost: factor out the common boilerplate of section_rel(a)
      csky: remove unused cmd_vdso_install
      UML: remove unused cmd_vdso_install
      kbuild: unify vdso_install rules
      kbuild: unify no-compiler-targets and no-sync-config-targets
      kbuild: remove ARCH_POSTLINK from module builds
      kbuild: avoid too many execution of scripts/pahole-flags.sh
      kbuild: simplify cmd_ld_multi_m
      modpost: remove ALL_EXIT_DATA_SECTIONS macro
      linux/init: remove __memexit* annotations
      modpost: disallow *driver to reference .meminit* sections
      modpost: remove more symbol patterns from the section check whitelist
      modpost: remove MEM_INIT_SECTIONS macro
      modpost: remove EXIT_SECTIONS macro
      modpost: disallow the combination of EXPORT_SYMBOL and __meminit*
      modpost: use ALL_INIT_SECTIONS for the section check from DATA_SECTIONS
      modpost: merge sectioncheck table entries regarding init/exit sections
      modpost: squash ALL_{INIT,EXIT}_TEXT_SECTIONS to ALL_TEXT_SECTIONS
      kbuild: support 'userldlibs' syntax

Matthew Maurer (1):
      rust: Respect HOSTCC when linking for host

Ricardo B. Marliere (1):
      docs: kbuild: add INSTALL_DTBS_PATH

Simon Glass (1):
      kbuild: Correct missing architecture-specific hyphens

 .gitignore                             |   1 -
 Documentation/kbuild/kbuild.rst        |   6 +
 Documentation/kbuild/makefiles.rst     |  11 ++
 MAINTAINERS                            |   2 +-
 Makefile                               |  38 +++---
 arch/arm/Makefile                      |   7 +-
 arch/arm/vdso/Makefile                 |  25 ----
 arch/arm64/Makefile                    |   9 +-
 arch/arm64/kernel/vdso/Makefile        |  10 --
 arch/arm64/kernel/vdso32/Makefile      |  10 --
 arch/csky/kernel/vdso/Makefile         |  10 --
 arch/loongarch/Makefile                |   4 +-
 arch/loongarch/vdso/Makefile           |  10 --
 arch/mips/Makefile.postlink            |   3 -
 arch/parisc/Makefile                   |   8 +-
 arch/powerpc/Makefile.postlink         |   3 -
 arch/riscv/Makefile                    |   9 +-
 arch/riscv/Makefile.postlink           |   3 -
 arch/riscv/kernel/compat_vdso/Makefile |  10 --
 arch/riscv/kernel/vdso/Makefile        |  10 --
 arch/s390/Makefile                     |   6 +-
 arch/s390/kernel/vdso32/Makefile       |  10 --
 arch/s390/kernel/vdso64/Makefile       |  10 --
 arch/sparc/Makefile                    |   5 +-
 arch/sparc/vdso/Makefile               |  27 -----
 arch/x86/Makefile                      |   7 +-
 arch/x86/Makefile.postlink             |   3 -
 arch/x86/entry/vdso/Makefile           |  27 -----
 arch/x86/um/vdso/Makefile              |  12 --
 include/asm-generic/vmlinux.lds.h      |   6 -
 include/linux/init.h                   |   3 -
 rust/Makefile                          |   2 +
 scripts/Makefile.btf                   |  19 +++
 scripts/Makefile.build                 |   2 +-
 scripts/Makefile.host                  |   2 +
 scripts/Makefile.modfinal              |   5 +-
 scripts/Makefile.package               |  10 +-
 scripts/Makefile.userprogs             |   6 +-
 scripts/Makefile.vdsoinst              |  45 +++++++
 scripts/dummy-tools/gcc                |  10 ++
 scripts/mod/Makefile                   |   4 +-
 scripts/mod/file2alias.c               |  14 +--
 scripts/mod/modpost.c                  | 201 ++++++++------------------------
 scripts/mod/modpost.h                  |  50 +++++---
 scripts/mod/symsearch.c                | 199 +++++++++++++++++++++++++++++++
 scripts/package/mkspec                 |   6 +
 scripts/pahole-flags.sh                |  30 -----
 scripts/remove-stale-files             |   2 +-
 48 files changed, 443 insertions(+), 469 deletions(-)
 create mode 100644 scripts/Makefile.btf
 create mode 100644 scripts/Makefile.vdsoinst
 create mode 100644 scripts/mod/symsearch.c
 delete mode 100755 scripts/pahole-flags.sh


--
Best Regards
Masahiro Yamada
