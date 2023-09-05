Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B01792E07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjIES6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjIES6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:58:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D641726;
        Tue,  5 Sep 2023 11:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD96060C38;
        Tue,  5 Sep 2023 17:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221BCC433C7;
        Tue,  5 Sep 2023 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693934095;
        bh=GlYSbca724476V8pA36oOnzEzNX5fMuhiVbjv4HYyPE=;
        h=From:Date:Subject:To:Cc:From;
        b=l2C9sQB5a9Qt01bnOGl6sK9kBttWcZUUsMPEpMbfp7ePSRAGStliFZw0ovxPy11LL
         G4ZiY0vY9bYj50HaRSyvkG++jiojyNnlp1iYWbo8RfWx7OgFtPZHBNrXfdwLpEzjR3
         B9B+HoYxydnSQoznqfkJjaMOoZ4KZ39cPVxyBv6ifYpOjHvYZVEK4JsLyyZ5SCzWWc
         T9ZkI/z8zg9c2ZI214Y8dl2Jg5OQiuIfETtJVewg8JNLvN/ZCz7g9MyioXLm/D+W+d
         jk6WrRABAiG1jhvBeIQ01DHqY5Spgh3YleRWUs7uQtfVjXr/DO5cptGAqFWctnn0Ev
         /9IHGaqdbhDnw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a76d882052so2040631b6e.0;
        Tue, 05 Sep 2023 10:14:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YxsiX8HSRTa7SV5sE9B6FAc6VJ9drkSdXAKAQRuXvlTkhpAXj63
        1iBDv9OQw6jsXMkUxh7AnYKi0vJ69EdeWTvD+b0=
X-Google-Smtp-Source: AGHT+IEagUf4IYzOaVdBU1+YumuvpFKsUoKnbGWsUu9QCxk1dBk4R5Ro0uOFJCxhw9Uk4JD04CGpv2fFZR7dB7gWMyE=
X-Received: by 2002:a05:6808:13d3:b0:3a9:cfb5:4641 with SMTP id
 d19-20020a05680813d300b003a9cfb54641mr17366299oiw.48.1693934094363; Tue, 05
 Sep 2023 10:14:54 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 Sep 2023 02:14:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASaAwVGhOFnpGWrUhYu2uXPi3Oc0zAfnoTswmjYb7k=1Q@mail.gmail.com>
Message-ID: <CAK7LNASaAwVGhOFnpGWrUhYu2uXPi3Oc0zAfnoTswmjYb7k=1Q@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild updates for v6.6-rc1.
Thank you.


The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.6

for you to fetch changes up to a3b7039bb2b22fcd2ad20d59c00ed4e606ce3754:

  kconfig: fix possible buffer overflow (2023-09-06 02:00:02 +0900)

----------------------------------------------------------------
Kbuild updates for v6.6

 - Enable -Wenum-conversion warning option

 - Refactor the rpm-pkg target

 - Fix scripts/setlocalversion to consider annotated tags for rt-kernel

 - Add a jump key feature for the search menu of 'make nconfig'

 - Support Qt6 for 'make xconfig'

 - Enable -Wformat-overflow, -Wformat-truncation, -Wstringop-overflow, and
   -Wrestrict warnings for W=1 builds

 - Replace <asm/export.h> with <linux/export.h> for alpha, ia64, and sparc

 - Support DEB_BUILD_OPTIONS=parallel=N for the debian source package

 - Refactor scripts/Makefile.modinst and fix some modules_sign issues

 - Add a new Kconfig env variable to warn symbols that are not defined anywhere

 - Show help messages of config fragments in 'make help'

----------------------------------------------------------------
Arnd Bergmann (4):
      kbuild: consolidate warning flags in scripts/Makefile.extrawarn
      kbuild: avoid duplicate warning options
      extrawarn: enable format and stringop overflow warnings in W=1
      extrawarn: move -Wrestrict into W=1 warnings

Boris Kolpackov (1):
      kconfig: port qconf to work with Qt6 in addition to Qt5

Borislav Petkov (AMD) (1):
      kbuild: Enable -Wenum-conversion by default

Denis Nikitin (1):
      modpost: Skip .llvm.call-graph-profile section check

Jesse Taube (2):
      kconfig: nconf: Add search jump feature
      docs: kbuild: Document search jump feature

Jiri Slaby (1):
      kbuild: dummy-tools: make MPROFILE_KERNEL checks work on BE

Kees Cook (1):
      kbuild: Show marked Kconfig fragments in "help"

Konstantin Meskhidze (1):
      kconfig: fix possible buffer overflow

Masahiro Yamada (44):
      linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
      kconfig: menuconfig: simplify global jump key assignment
      kconfig: menuconfig: remove jump_key::index
      kbuild: rpm-pkg: define _arch conditionally
      kbuild: rpm-pkg: remove unneeded '-f $srctree/Makefile' in spec file
      kbuild: rpm-pkg: do not hard-code $MAKE in spec file
      kbuild: rpm-pkg: use %{makeflags} to pass common Make options
      kbuild: rpm-pkg: record ARCH option in spec file
      kbuild: rpm-pkg: replace $__KERNELRELEASE in spec file with %{version}
      kbuild: rpm-pkg: replace $KERNELRELEASE in spec file with %{KERNELRELEASE}
      kbuild: add a phony target to run a command with Kbuild env vars
      kbuild: refactor kernel-devel RPM package and linux-headers Deb package
      kbuild: rpm-pkg: derive the Version from %{KERNELRELEASE}
      kbuild: rpm-pkg: use a dummy string for _arch when undefined
      kbuild: rpm-pkg: invoke the kernel build from rpmbuild for binrpm-pkg
      kbuild: rpm-pkg: run modules_install for non-modular kernel
      kbuild: rpm-pkg: introduce %{with_devel} switch to select devel package
      kbuild: rpm-pkg: split out the body of spec file
      kbuild: rpm-pkg: rename binkernel.spec to kernel.spec
      kbuild: rpm-pkg: build the kernel in-place for rpm-pkg
      kbuild: rpm-pkg: refactor *rpm-pkg targets
      kbuild: rpm-pkg: skip build dependency check on non-rpm systems
      modpost: change return type of addend_*_rel()
      modpost: pass r_type to addend_*_rel()
      modpost: clean up MIPS64 little endian relocation code
      modpost: remove ElF_Rela variables from for-loop in section_rel(a)
      kbuild: deb-pkg: use Debian compliant shebang for debian/rules
      kbuild: deb-pkg: split debian/rules
      kbuild: remove include/ksym from CLEAN_FILES
      sparc: replace #include <asm/export.h> with #include <linux/export.h>
      sparc: remove <asm/export.h>
      ia64: replace #include <asm/export.h> with #include <linux/export.h>
      ia64: remove <asm/export.h>
      alpha: replace #include <asm/export.h> with #include <linux/export.h>
      alpha: remove <asm/export.h>
      kbuild: deb-pkg: support DEB_BUILD_OPTIONS=parallel=N in debian/rules
      kbuild: do not run depmod for 'make modules_sign'
      kbuild: add modules_sign to no-{compiler,sync-config}-targets
      kbuild: move depmod rule to scripts/Makefile.modinst
      kbuild: remove $(MODLIB)/source symlink
      kbuild: reduce the number of mkdir calls during modules_install
      kbuild: move more module installation code to scripts/Makefile.modinst
      kbuild: support 'make modules_sign' with CONFIG_MODULE_SIG_ALL=n
      kbuild: support modules_sign for external modules as well

Michal Suchanek (1):
      Revert "kbuild: Hack for depmod not handling X.Y versions"

Nick Desaulniers (1):
      Documentation/llvm: refresh docs

Nicolas Schier (1):
      MAINTAINERS: Add usr/ (initramfs generation) to KBUILD

Rasmus Villemoes (2):
      scripts/setlocalversion: clean up stale comment
      scripts/setlocalversion: also consider annotated tags of the
form vx.y.z-${file_localversion}

Sergey Senozhatsky (1):
      kconfig: add warn-unknown-symbols sanity check

 .gitignore                                 |   2 +-
 Documentation/kbuild/kconfig.rst           |  17 ++++
 Documentation/kbuild/llvm.rst              | 124 +++++++++++++++++----------
 MAINTAINERS                                |   1 +
 Makefile                                   | 172
+++++++------------------------------
 arch/alpha/include/asm/Kbuild              |   1 -
 arch/alpha/lib/callback_srm.S              |   2 +-
 arch/alpha/lib/clear_page.S                |   2 +-
 arch/alpha/lib/clear_user.S                |   2 +-
 arch/alpha/lib/copy_page.S                 |   2 +-
 arch/alpha/lib/copy_user.S                 |   2 +-
 arch/alpha/lib/csum_ipv6_magic.S           |   2 +-
 arch/alpha/lib/divide.S                    |   2 +-
 arch/alpha/lib/ev6-clear_page.S            |   2 +-
 arch/alpha/lib/ev6-clear_user.S            |   2 +-
 arch/alpha/lib/ev6-copy_page.S             |   2 +-
 arch/alpha/lib/ev6-copy_user.S             |   2 +-
 arch/alpha/lib/ev6-csum_ipv6_magic.S       |   2 +-
 arch/alpha/lib/ev6-divide.S                |   2 +-
 arch/alpha/lib/ev6-memchr.S                |   2 +-
 arch/alpha/lib/ev6-memcpy.S                |   2 +-
 arch/alpha/lib/ev6-memset.S                |   2 +-
 arch/alpha/lib/ev67-strcat.S               |   2 +-
 arch/alpha/lib/ev67-strchr.S               |   2 +-
 arch/alpha/lib/ev67-strlen.S               |   2 +-
 arch/alpha/lib/ev67-strncat.S              |   2 +-
 arch/alpha/lib/ev67-strrchr.S              |   2 +-
 arch/alpha/lib/memchr.S                    |   2 +-
 arch/alpha/lib/memmove.S                   |   2 +-
 arch/alpha/lib/memset.S                    |   2 +-
 arch/alpha/lib/strcat.S                    |   2 +-
 arch/alpha/lib/strchr.S                    |   2 +-
 arch/alpha/lib/strcpy.S                    |   2 +-
 arch/alpha/lib/strlen.S                    |   2 +-
 arch/alpha/lib/strncat.S                   |   2 +-
 arch/alpha/lib/strncpy.S                   |   2 +-
 arch/alpha/lib/strrchr.S                   |   2 +-
 arch/alpha/lib/udiv-qrnnd.S                |   2 +-
 arch/arm/configs/dram_0x00000000.config    |   1 +
 arch/arm/configs/dram_0xc0000000.config    |   1 +
 arch/arm/configs/dram_0xd0000000.config    |   1 +
 arch/arm/configs/lpae.config               |   1 +
 arch/arm64/configs/virt.config             |   1 +
 arch/ia64/include/asm/Kbuild               |   1 -
 arch/ia64/kernel/entry.S                   |   3 +-
 arch/ia64/kernel/esi_stub.S                |   2 +-
 arch/ia64/kernel/head.S                    |   3 +-
 arch/ia64/kernel/ivt.S                     |   3 +-
 arch/ia64/kernel/pal.S                     |   2 +-
 arch/ia64/lib/clear_page.S                 |   2 +-
 arch/ia64/lib/clear_user.S                 |   2 +-
 arch/ia64/lib/copy_page.S                  |   2 +-
 arch/ia64/lib/copy_page_mck.S              |   2 +-
 arch/ia64/lib/copy_user.S                  |   2 +-
 arch/ia64/lib/flush.S                      |   3 +-
 arch/ia64/lib/idiv32.S                     |   2 +-
 arch/ia64/lib/idiv64.S                     |   2 +-
 arch/ia64/lib/ip_fast_csum.S               |   2 +-
 arch/ia64/lib/memcpy.S                     |   2 +-
 arch/ia64/lib/memcpy_mck.S                 |   2 +-
 arch/ia64/lib/memset.S                     |   2 +-
 arch/ia64/lib/strlen.S                     |   2 +-
 arch/ia64/lib/strncpy_from_user.S          |   2 +-
 arch/ia64/lib/strnlen_user.S               |   2 +-
 arch/ia64/lib/xor.S                        |   2 +-
 arch/powerpc/configs/disable-werror.config |   1 +
 arch/powerpc/configs/security.config       |   4 +-
 arch/riscv/configs/32-bit.config           |   1 +
 arch/riscv/configs/64-bit.config           |   1 +
 arch/s390/configs/btf.config               |   1 +
 arch/s390/configs/kasan.config             |   1 +
 arch/sparc/include/asm/Kbuild              |   1 -
 arch/sparc/kernel/entry.S                  |   2 +-
 arch/sparc/kernel/head_32.S                |   2 +-
 arch/sparc/kernel/head_64.S                |   2 +-
 arch/sparc/lib/U1memcpy.S                  |   2 +-
 arch/sparc/lib/VISsave.S                   |   2 +-
 arch/sparc/lib/ashldi3.S                   |   2 +-
 arch/sparc/lib/ashrdi3.S                   |   2 +-
 arch/sparc/lib/atomic_64.S                 |   2 +-
 arch/sparc/lib/bitops.S                    |   2 +-
 arch/sparc/lib/blockops.S                  |   2 +-
 arch/sparc/lib/bzero.S                     |   2 +-
 arch/sparc/lib/checksum_32.S               |   2 +-
 arch/sparc/lib/checksum_64.S               |   2 +-
 arch/sparc/lib/clear_page.S                |   2 +-
 arch/sparc/lib/copy_in_user.S              |   2 +-
 arch/sparc/lib/copy_page.S                 |   2 +-
 arch/sparc/lib/copy_user.S                 |   2 +-
 arch/sparc/lib/csum_copy.S                 |   2 +-
 arch/sparc/lib/divdi3.S                    |   2 +-
 arch/sparc/lib/ffs.S                       |   2 +-
 arch/sparc/lib/fls.S                       |   2 +-
 arch/sparc/lib/fls64.S                     |   2 +-
 arch/sparc/lib/hweight.S                   |   2 +-
 arch/sparc/lib/ipcsum.S                    |   2 +-
 arch/sparc/lib/locks.S                     |   2 +-
 arch/sparc/lib/lshrdi3.S                   |   2 +-
 arch/sparc/lib/mcount.S                    |   2 +-
 arch/sparc/lib/memcmp.S                    |   2 +-
 arch/sparc/lib/memcpy.S                    |   3 +-
 arch/sparc/lib/memmove.S                   |   2 +-
 arch/sparc/lib/memscan_32.S                |   2 +-
 arch/sparc/lib/memscan_64.S                |   2 +-
 arch/sparc/lib/memset.S                    |   2 +-
 arch/sparc/lib/muldi3.S                    |   2 +-
 arch/sparc/lib/multi3.S                    |   2 +-
 arch/sparc/lib/strlen.S                    |   2 +-
 arch/sparc/lib/strncmp_32.S                |   2 +-
 arch/sparc/lib/strncmp_64.S                |   2 +-
 arch/sparc/lib/xor.S                       |   2 +-
 arch/x86/Makefile                          |   4 -
 include/linux/export.h                     |   4 +-
 kernel/configs/debug.config                |   2 +
 kernel/configs/kvm_guest.config            |   1 +
 kernel/configs/nopm.config                 |   2 +
 kernel/configs/rust.config                 |   1 +
 kernel/configs/x86_debug.config            |   1 +
 kernel/configs/xen.config                  |   2 +
 scripts/Makefile.extrawarn                 | 115 +++++++++++++++++++++++--
 scripts/Makefile.modinst                   |  55 ++++++++++--
 scripts/Makefile.modpost                   |   1 +
 scripts/Makefile.package                   |  57 +++++++------
 scripts/depmod.sh                          |  39 ++-------
 scripts/dummy-tools/gcc                    |   3 +-
 scripts/kconfig/Makefile                   |  15 +++-
 scripts/kconfig/confdata.c                 |  21 ++++-
 scripts/kconfig/expr.h                     |   1 -
 scripts/kconfig/lkc.h                      |   1 +
 scripts/kconfig/lxdialog/dialog.h          |  10 +--
 scripts/kconfig/lxdialog/textbox.c         |  68 ++++++---------
 scripts/kconfig/mconf.c                    |  89 ++++++++++++--------
 scripts/kconfig/menu.c                     |  30 ++++---
 scripts/kconfig/nconf.c                    | 113 ++++++++++++++++++++++---
 scripts/kconfig/nconf.gui.c                |  37 ++++++--
 scripts/kconfig/nconf.h                    |   5 ++
 scripts/kconfig/preprocess.c               |   3 +
 scripts/kconfig/qconf-cfg.sh               |  25 ++++--
 scripts/kconfig/qconf.cc                   |  40 ++++++---
 scripts/mod/modpost.c                      | 173
++++++++++++++++++--------------------
 scripts/mod/modpost.h                      |  22 -----
 scripts/package/builddeb                   |  29 +------
 scripts/package/debian/rules               |  33 ++++++++
 scripts/package/install-extmod-build       |  39 +++++++++
 scripts/package/kernel.spec                | 117 ++++++++++++++++++++++++++
 scripts/package/mkdebian                   |  33 ++------
 scripts/package/mkspec                     | 148
++------------------------------
 scripts/remove-stale-files                 |   2 +
 scripts/setlocalversion                    |  38 ++++++---
 149 files changed, 1076 insertions(+), 825 deletions(-)
 create mode 100755 scripts/package/debian/rules
 create mode 100755 scripts/package/install-extmod-build
 create mode 100644 scripts/package/kernel.spec

-- 
Best Regards
Masahiro Yamada
