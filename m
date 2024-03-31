Return-Path: <linux-kernel+bounces-126061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA9C893193
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51333282119
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871114431D;
	Sun, 31 Mar 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqAqjMTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6F2869A;
	Sun, 31 Mar 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711887807; cv=none; b=Zkpzo4V1GUnNv8b9o0u2ggVf3dzEaoIMSfq1AEebavMrjgkO1trKBTgpaqrnqJtjvVPLiAHmBfjLwwJNGksAxAnOccDxx5xUNN72LtEAxVmaq2Ogvts1LEwRcb9iZ/HwMSETc+vrEnG1VTCiPfXvu3zV3J1o0pNERDaXMURz+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711887807; c=relaxed/simple;
	bh=cBpurtTfu/q2YxV2xdWusFpGseTHI9CmDjpyi/TnKeI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WGSVha73Immk0c34Pkd2Z/S32qjldtwiqMOduE/vDAy+LOagASOnbFUkcf/Klf1D5Ip6LkCWR3Fs0nOzo9Y7wECvO3HlCEPk2nj2e1Dp1JE3BXvTbBHp+4Aa7ExLQMfuE/2TnszkqX/9kNHUc1CMC4l+/jkcxo97b9s/JJUGJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqAqjMTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F504C433F1;
	Sun, 31 Mar 2024 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711887806;
	bh=cBpurtTfu/q2YxV2xdWusFpGseTHI9CmDjpyi/TnKeI=;
	h=From:Date:Subject:To:Cc:From;
	b=IqAqjMTLWeTBSdsVP7j7n8F1I7gP+9MaqmqCHAP4bqDF3lCN65xtjPSDOD04YKQVC
	 7vpNQAZ5G1KRwp4+OBsspIGAzEw03iUxXXx5udWE1UXSIP9hqxH4t9C2ZuE4Lfz75o
	 2wmzzvSRMuQC1Mdk5UHoBPdjsTcheXLhBUwrAoqk9NHHWxWHr/E7bCThItBeY2GV8h
	 5LJbLhApjIMi6P181SJhkCc5Q+CU0baChT8edGZ/UCWwMncjAJtlhOlhJui+Q/bdoz
	 /vWeHC/0oXPezh7QcFli8xUaw/SXzXTiB5zklSrx8HCq43S7YjZK3xO6lYrwmVOG5G
	 6LP7PEqfjaJAA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so40884401fa.3;
        Sun, 31 Mar 2024 05:23:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEDAcgec6bxzZq/eJ7yvgrOQKrbCJ7TrsHLKsJzIUplN+cEqxqrSaTfhLKgyJq4GySbyWqcLqsrsM1YvsdCQ7h5SpawKllr6IqDzUd
X-Gm-Message-State: AOJu0YwJt11b1fa82Cw2ccfy70C1Wouiw8+M5BaWy9bnXSGK179Xnuio
	naxMNJ3o67il+60OMRRQWiuUyD9Fv4BUF+WhF726+ACzTqMSAvDukKGZ0eo8jI7jbEUollzOZzp
	HOdk3SfFMsJIO/7reVQFK2ozEDog=
X-Google-Smtp-Source: AGHT+IF8Ze4qhZyBxcRz48XVGb7Amedka95o7kNYTDTgH5afS9C+Xv+IIoAinSUGMunsT2V/3OUYi/OmhvROOXoQOa8=
X-Received: by 2002:a05:651c:1044:b0:2d4:6532:f449 with SMTP id
 x4-20020a05651c104400b002d46532f449mr5077654ljm.20.1711887805218; Sun, 31 Mar
 2024 05:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 31 Mar 2024 21:22:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTLAtXYZEfmQg8dLsu3A0e5songZrEayo3ateQ6dTmJw@mail.gmail.com>
Message-ID: <CAK7LNATTLAtXYZEfmQg8dLsu3A0e5songZrEayo3ateQ6dTmJw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.9-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Linus,


Please pull Kbuild fixes for v6.9-rc2.
Thanks.




The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.9

for you to fetch changes up to 89e5462bb5aee1e634a3d5bd41125809a929a486:

  kconfig: Fix typo HEIGTH to HEIGHT (2024-03-31 21:09:50 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.9

 - Deduplicate Kconfig entries for CONFIG_CXL_PMU

 - Fix unselectable choice entry in MIPS Kconfig, and forbid this
   structure

 - Remove unused include/asm-generic/export.h

 - Fix a NULL pointer dereference bug in modpost

 - Enable -Woverride-init warning consistently with W=1

 - Drop KCSAN flags from *.mod.c files

----------------------------------------------------------------
Arnd Bergmann (1):
      kbuild: make -Woverride-init warnings more consistent

Borislav Petkov (AMD) (1):
      kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries

Isak Ellmer (1):
      kconfig: Fix typo HEIGTH to HEIGHT

Masahiro Yamada (5):
      cxl: remove CONFIG_CXL_PMU entry in drivers/cxl/Kconfig
      MIPS: move unselectable FIT_IMAGE_FDT_EPM5 out of the "System type" choice
      kconfig: do not reparent the menu inside a choice block
      export.h: remove include/asm-generic/export.h
      modpost: do not make find_tosym() return NULL

Nathan Chancellor (1):
      Documentation/llvm: Note s390 LLVM=1 support with LLVM 18.1.0 and newer

 Documentation/kbuild/llvm.rst                  |  2 +-
 arch/mips/Kconfig                              | 18 +++++++++---------
 drivers/cxl/Kconfig                            | 13 -------------
 drivers/gpu/drm/amd/display/dc/dce110/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce112/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce120/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile  |  2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile  |  2 +-
 drivers/gpu/drm/i915/Makefile                  |  6 +++---
 drivers/gpu/drm/xe/Makefile                    |  4 ++--
 drivers/net/ethernet/renesas/sh_eth.c          |  2 +-
 drivers/pinctrl/aspeed/Makefile                |  2 +-
 fs/proc/Makefile                               |  2 +-
 include/asm-generic/export.h                   | 11 -----------
 kernel/bpf/Makefile                            |  2 +-
 mm/Makefile                                    |  3 +--
 scripts/Makefile.extrawarn                     | 10 +++-------
 scripts/Makefile.modfinal                      |  2 +-
 scripts/kconfig/conf.c                         |  5 -----
 scripts/kconfig/lkc.h                          |  2 +-
 scripts/kconfig/lxdialog/checklist.c           |  2 +-
 scripts/kconfig/lxdialog/dialog.h              | 12 ++++++------
 scripts/kconfig/lxdialog/inputbox.c            |  2 +-
 scripts/kconfig/lxdialog/menubox.c             |  2 +-
 scripts/kconfig/lxdialog/textbox.c             |  2 +-
 scripts/kconfig/lxdialog/util.c                |  2 +-
 scripts/kconfig/lxdialog/yesno.c               |  2 +-
 scripts/kconfig/mconf.c                        |  4 ++--
 scripts/kconfig/menu.c                         | 22 ++++++++++++++++------
 scripts/kconfig/parser.y                       |  2 +-
 scripts/mod/modpost.c                          |  7 +++++--
 31 files changed, 66 insertions(+), 87 deletions(-)
 delete mode 100644 include/asm-generic/export.h


-- 
Best Regards
Masahiro Yamada

