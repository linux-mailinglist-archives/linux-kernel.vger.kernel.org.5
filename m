Return-Path: <linux-kernel+bounces-110191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AD885B56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D561E1F21F70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D378613B;
	Thu, 21 Mar 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZXFv63e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B355792;
	Thu, 21 Mar 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033395; cv=none; b=efVRa+CFeroFb0hqh26KYJvmUzR48BFYuKWZBhu4RElwN3ETGDW244jfU3OiEKmiunQVgUYiUP1RnNbeaAhGFete5mJQyJZuRKovaVWF2rRo4Hy+Udhqv51OjMwAXmxEDq1JNqBHnJq3YyrJ3Zfx3j/3YF9Xi2HIv+DXhLx1VAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033395; c=relaxed/simple;
	bh=EaUT4D6pVOUWu+wHYtf2B+XExmshgaJ7s6k6C9bNrRk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kv86xPQm/mrenHPdcfqgH6Q+KM7SlcPyDHxsvrBQIj0tW696hinYZCKcullkJzhpPUtqkns2OTTlB/qpEa1rZZyctMXdP94Ns0wZUN57yF3jAKfqQEpvFtqoO5B7jyNlrdsuYXqsNlF+X62JEnurAoo7vDuWjT6yn9DDmQAYOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZXFv63e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D5FC43390;
	Thu, 21 Mar 2024 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033395;
	bh=EaUT4D6pVOUWu+wHYtf2B+XExmshgaJ7s6k6C9bNrRk=;
	h=From:Date:Subject:To:Cc:From;
	b=cZXFv63eVpTLgTex2vKpwu6WREJUaILW4uPw0lZOGNK09gUk5KR1i07g39W6JffAZ
	 0utTfzB3uFLXmJGpvVL3qnDxz7IP86ddBPZeLdxpHpKbr1+b4Mpraat0OcqEU1mWPY
	 btT2U44QgS7XAlVWGrzABJh+JrdG5W/t+5P+WOM81ubA9LGFC9oNReg7uFK4gByvE4
	 sz4zW+b3cjWb61Zo4Wpi19FIvQ8h2mjgUjlmEo85NmPAyEEThCaOlcArqJb4vBKJch
	 rmJdhlgfsuzyPQO+nZGGcTpubyOd+yF+3mBnqqex52nnrShOGu8Csp5EdjCinUldSk
	 hV4qfA/ECiItQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so18702011fa.1;
        Thu, 21 Mar 2024 08:03:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCCI5Np5K6FCCUMGLG0mrnxdPr5Svo1O1RXYULHgGjdeU+DH24xuHin4CFVtmMgi8CI2T00LC8f5hGF859C4/37h4QeA/rh0v0iXLu
X-Gm-Message-State: AOJu0YxOigGx0q5AU9NVyZifFUy7TJj2V4pieqmvt1RS190OsP6j/xUl
	Mlr42xyPHKvdT9dC22ZCpE7jfQsu3zHZTzubaQQy6Ql+SuXUK0+wZ6E9f48wESktBdv3ZVRBL+Z
	8NDmTEBNaD6mYsyhYnEDoLSdOitg=
X-Google-Smtp-Source: AGHT+IHrij8ZXr+ThG623XbXR37qNwrI3vP1o7674x/HUn7vQKxy2bvLZAIN4WlSTd2x4Cz3DcnFqm9/caizYTxNy8o=
X-Received: by 2002:a05:651c:2109:b0:2d4:a232:757 with SMTP id
 a9-20020a05651c210900b002d4a2320757mr10219019ljq.7.1711033393986; Thu, 21 Mar
 2024 08:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Mar 2024 00:02:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXef6Myb_Gd4jyGfwujoBAjmjzLZBzgkm4T1KmfHP0MQ@mail.gmail.com>
Message-ID: <CAK7LNARXef6Myb_Gd4jyGfwujoBAjmjzLZBzgkm4T1KmfHP0MQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Linus,

Please pull Kbuild updates for v6.9-rc1.


You will see conflicts in two files.


- arch/hexagon/Kconfig
  (commit 6b1c2a19cb30 vs commit ba89f9c8ccba)

- scripts/Makefile.lib
  (commit 557f8c582a9b vs commit bf48d9b756b9)


The resolution is available in linux-next.

Thank you



The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.9

for you to fetch changes up to f2fd2aad1908554fbc4ad6e8ef23bad3086bebd1:

  kconfig: tests: test dependency after shuffling choices (2024-03-21
02:40:39 +0900)

----------------------------------------------------------------
Kbuild updates for v6.9

 - Generate a list of built DTB files (arch/*/boot/dts/dtbs-list)

 - Use more threads when building Debian packages in parallel

 - Fix warnings shown during the RPM kernel package uninstallation

 - Change OBJECT_FILES_NON_STANDARD_*.o etc. to take a relative path to
   Makefile

 - Support GCC's -fmin-function-alignment flag

 - Fix a null pointer dereference bug in modpost

 - Add the DTB support to the RPM package

 - Various fixes and cleanups in Kconfig

----------------------------------------------------------------
Jose Ignacio Tornos Martinez (1):
      kbuild: rpm-pkg: add dtb files in kernel rpm

Masahiro Yamada (61):
      kconfig: remove unneeded buffer allocation in zconf_initscan()
      kconfig: fix line number in recursive inclusion detection
      kbuild: create a list of all built DTB files
      kbuild: simplify dtbs_install by reading the list of compiled DTBs
      kbuild: deb-pkg: show verbose log for direct package builds
      kbuild: deb-pkg: make debian/rules quiet for 'make deb-pkg'
      kbuild: deb-pkg: build binary-arch in parallel
      kbuild: deb-pkg: call more misc debhelper commands
      kbuild: rpm-pkg: do not include depmod-generated files
      kbuild: rpm-pkg: mark installed files in /boot as %ghost
      Revert "kbuild/mkspec: support 'update-bootloader'-based systems"
      Revert "kbuild/mkspec: clean boot loader configuration on rpm removal"
      kconfig: fix infinite loop when expanding a macro at the end of file
      kconfig: fix off-by-one in zconf_error()
      kconfig: remove orphan lookup_file() declaration
      kconfig: remove compat_getline()
      kconfig: remove unneeded sym_find() call in conf_parse()
      kconfig: write Kconfig files to autoconf.cmd in order
      kconfig: call env_write_dep() right after yyparse()
      kconfig: split preprocessor prototypes into preprocess.h
      kconfig: replace current_pos with separate cur_{filename,lineno}
      kconfig: remove zconf_curname() and zconf_lineno()
      kconfig: associate struct menu with file name directly
      kconfig: associate struct property with file name directly
      kconfig: replace file->name with name in zconf_nextfile()
      kconfig: do not delay the cur_filename update
      kconfig: replace remaining current_file->name with cur_filename
      kconfig: move the file and lineno in struct file to struct buffer
      kconfig: make file::name a flexible array member
      kconfig: change file_lookup() to return the file name
      kconfig: split list_head into a separate header
      kconfig: resync list.h
      kconfig: import more list macros and inline functions
      kconfig: add macros useful for hashtable
      kconfig: move ARRAY_SIZE to a header
      kconfig: move strhash() to util.c as a global function
      kconfig: convert linked list of files to hash table
      kconfig: do not imply the type of choice value
      kconfig: print recursive dependency errors in the parsed order
      kconfig: use generic macros to implement symbol hashtable
      treewide: replace or remove redundant def_bool in Kconfig files
      hexagon: select FRAME_POINTER instead of redefining it
      hexagon: select GENERIC_IRQ_PROBE instead of redefining it
      kbuild: remove EXPERT and !COMPILE_TEST guarding from TRIM_UNUSED_KSYMS
      kbuild: change tool coverage variables to take the path relative to $(obj)
      kbuild: change DTC_FLAGS_<basetarget>.o to take the path
relative to $(obj)
      alpha: merge two entries for CONFIG_ALPHA_EV4
      alpha: merge two entries for CONFIG_ALPHA_GAMMA
      kbuild: fix inconsistent indentation in top Makefile
      kconfig: link menus to a symbol
      kconfig: use linked list in get_symbol_str() to iterate over menus
      kconfig: remove named choice support
      kbuild: unexport abs_srctree and abs_objtree
      kbuild: remove GCC's default -Wpacked-bitfield-compat flag
      kconfig: lxdialog: fix button color for blackbg theme
      kconfig: lxdialog: remove unused dialog colors
      kconfig: check prompt for choice while parsing
      kconfig: remove unneeded menu_is_visible() call in conf_write_defconfig()
      kconfig: tests: support KCONFIG_SEED for the randconfig runner
      kconfig: tests: add a test for randconfig with dependent choices
      kconfig: tests: test dependency after shuffling choices

Matthew Bystrin (1):
      kconfig: lxdialog: fix cursor render in checklist

Max Kellermann (1):
      modpost: fix null pointer dereference

Nathan Chancellor (1):
      kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1

Petr Pavlu (1):
      kbuild: Use -fmin-function-alignment when available

Vegard Nossum (1):
      docs: kbuild/kconfig: reformat/cleanup

 .gitignore                                               |   1 +
 Documentation/kbuild/kconfig-language.rst                |   6 +-
 Documentation/kbuild/kconfig.rst                         | 363
++++++++++++++++++++++--------------------------
 Makefile                                                 |  49 ++++---
 arch/Kconfig                                             |  12 ++
 arch/alpha/Kconfig                                       |  15 +-
 arch/hexagon/Kconfig                                     |  12 +-
 arch/parisc/Kconfig                                      |   4 +-
 arch/riscv/kernel/tests/Kconfig.debug                    |   2 +-
 arch/x86/entry/vdso/Makefile                             |   2 +
 arch/x86/kvm/Kconfig                                     |   2 +-
 arch/x86/kvm/Makefile                                    |   3 +-
 arch/x86/xen/Kconfig                                     |   1 -
 drivers/acpi/Kconfig                                     |   1 -
 drivers/iommu/intel/Kconfig                              |   2 +-
 drivers/md/Kconfig                                       |   1 -
 include/linux/compiler_types.h                           |  10 +-
 init/Kconfig                                             |   2 +-
 kernel/module/Kconfig                                    |   3 +-
 lib/Kconfig.debug                                        |   2 +-
 mm/Kconfig                                               |   7 +-
 net/dccp/ccids/Kconfig                                   |   2 +-
 rust/Makefile                                            |   4 +-
 scripts/Kbuild.include                                   |   6 -
 scripts/Makefile.build                                   |  22 +--
 scripts/Makefile.dtbinst                                 |  32 +++--
 scripts/Makefile.extrawarn                               |   3 +-
 scripts/Makefile.lib                                     |  24 ++--
 scripts/Makefile.package                                 |   2 +-
 scripts/kconfig/array_size.h                             |  11 ++
 scripts/kconfig/conf.c                                   |  12 +-
 scripts/kconfig/confdata.c                               |  96 +++----------
 scripts/kconfig/expr.h                                   |  29 ++--
 scripts/kconfig/hashtable.h                              |  48 +++++++
 scripts/kconfig/internal.h                               |  12 ++
 scripts/kconfig/lexer.l                                  | 128
++++++++---------
 scripts/kconfig/list.h                                   | 254
++++++++++++++++++++++++---------
 scripts/kconfig/list_types.h                             |  17 +++
 scripts/kconfig/lkc.h                                    |   6 +-
 scripts/kconfig/lkc_proto.h                              |  15 --
 scripts/kconfig/lxdialog/checklist.c                     |   5 +-
 scripts/kconfig/lxdialog/dialog.h                        |   4 -
 scripts/kconfig/lxdialog/util.c                          |  20 +--
 scripts/kconfig/mconf.c                                  |   1 +
 scripts/kconfig/menu.c                                   |  48 +++----
 scripts/kconfig/nconf.c                                  |   1 +
 scripts/kconfig/parser.y                                 | 125
++++++++++-------
 scripts/kconfig/preprocess.c                             |  23 +--
 scripts/kconfig/preprocess.h                             |  19 +++
 scripts/kconfig/qconf.cc                                 |   2 +-
 scripts/kconfig/symbol.c                                 |  49 +++----
 scripts/kconfig/tests/choice_randomize/Kconfig           |  22 +++
 scripts/kconfig/tests/choice_randomize/__init__.py       |  34 +++++
 scripts/kconfig/tests/choice_randomize/expected_config0  |   6 +
 scripts/kconfig/tests/choice_randomize/expected_config1  |   8 ++
 scripts/kconfig/tests/choice_randomize/expected_config2  |   8 ++
 scripts/kconfig/tests/choice_randomize2/Kconfig          |  32 +++++
 scripts/kconfig/tests/choice_randomize2/__init__.py      |  18 +++
 scripts/kconfig/tests/choice_randomize2/expected_config0 |   8 ++
 scripts/kconfig/tests/choice_randomize2/expected_config1 |   7 +
 scripts/kconfig/tests/choice_randomize2/expected_config2 |   6 +
 scripts/kconfig/tests/conftest.py                        |  16 ++-
 scripts/kconfig/tests/err_recursive_dep/expected_stderr  |  24 ++--
 scripts/kconfig/util.c                                   |  47 +++++--
 scripts/mod/modpost.c                                    |   4 +-
 scripts/package/builddeb                                 |  48 ++-----
 scripts/package/debian/rules                             |  63 +++++++--
 scripts/package/kernel.spec                              |  48 +++++--
 tools/lib/bpf/Makefile                                   |   2 +-
 69 files changed, 1131 insertions(+), 790 deletions(-)
 create mode 100644 scripts/kconfig/array_size.h
 create mode 100644 scripts/kconfig/hashtable.h
 create mode 100644 scripts/kconfig/list_types.h
 create mode 100644 scripts/kconfig/preprocess.h
 create mode 100644 scripts/kconfig/tests/choice_randomize/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_randomize/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_randomize/expected_config0
 create mode 100644 scripts/kconfig/tests/choice_randomize/expected_config1
 create mode 100644 scripts/kconfig/tests/choice_randomize/expected_config2
 create mode 100644 scripts/kconfig/tests/choice_randomize2/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_randomize2/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_randomize2/expected_config0
 create mode 100644 scripts/kconfig/tests/choice_randomize2/expected_config1
 create mode 100644 scripts/kconfig/tests/choice_randomize2/expected_config2

-- 
Best Regards
Masahiro Yamada

