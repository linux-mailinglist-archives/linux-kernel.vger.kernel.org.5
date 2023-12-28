Return-Path: <linux-kernel+bounces-12784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C561281FA08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F081C22A08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED5F514;
	Thu, 28 Dec 2023 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZxQe0o4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25FF508;
	Thu, 28 Dec 2023 16:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57305C433C7;
	Thu, 28 Dec 2023 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703782051;
	bh=eEPrkCoBmJGFeF8k8PZ0nch647vPFgYklt+GE6KJF8c=;
	h=From:Date:Subject:To:Cc:From;
	b=oZxQe0o4z4py/g/JAnU2bXpaDz67VjjF4qVI9eF1Sbnd+2UbPtPFUTKfJIJv/aEoc
	 AoPnqUZ1Jqou7m9NI+ROtYiE12vGTxqAcBdaWoc+iQ4mUvbczp3WH6CZPj+QVuq0VB
	 vELdLFliSNO89M7qouKX19wCIee/TNAX4JGZzfB23VxU+D1cn1RyjtPCwZKdag1M3e
	 dJqyJEVTmxkMXibNSy9yPJPlwK0GXTzfd28SDrJDa8E1+Bj7BlwA9lPTfMiy9+o4I0
	 pHNxApaTODAzHo7SyaIEXNmXhGu6mPX73oJBgrmsdrhLjRHV328I8EMXpAwc8hTfdU
	 jYfJdNyww3pnQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-594cad5f69fso707776eaf.1;
        Thu, 28 Dec 2023 08:47:31 -0800 (PST)
X-Gm-Message-State: AOJu0Yzz3f5AhEyQsKR3X+w1GbhYHjNHghrPD//ncTR0s9IRRdTh56Zy
	AB3abQTpIROAw87D2QOC9dtAA3WhkKlMxlINsCM=
X-Google-Smtp-Source: AGHT+IH+96iI1AiBrU8satRMtbxv+G7Ll1c+rRR8i/DvMUjaf8UQIww7dEUcXGozV2xLv4RIiTqYiCyvOBwPPxjjgHU=
X-Received: by 2002:a05:6870:1490:b0:204:ccc:b419 with SMTP id
 k16-20020a056870149000b002040cccb419mr4644191oab.2.1703782050678; Thu, 28 Dec
 2023 08:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Dec 2023 01:46:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASh0Y0qyi+vJGbNvvEnGW3-hH=QBf=aEpbtxE2N9JSodg@mail.gmail.com>
Message-ID: <CAK7LNASh0Y0qyi+vJGbNvvEnGW3-hH=QBf=aEpbtxE2N9JSodg@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.7-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Linus,


Please pull Kbuild fixes for v6.7-rc8.
Thanks.




The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.7-2

for you to fetch changes up to 753547de0daecbdbd1af3618987ddade325d9aaa:

  linux/export: Ensure natural alignment of kcrctab array (2023-12-29
01:25:58 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.7 (2nd)

 - Revive proper alignment for the ksymtab and kcrctab sections

 - Fix gen_compile_commands.py tool to resolve symbolic links

 - Fix symbolic links to installed debug VDSO files

 - Update MAINTAINERS

----------------------------------------------------------------
Helge Deller (2):
      linux/export: Fix alignment for 64-bit ksymtab entries
      linux/export: Ensure natural alignment of kcrctab array

Jialu Xu (1):
      gen_compile_commands.py: fix path resolve with symlinks in it

Masahiro Yamada (1):
      kbuild: fix build ID symlinks to installed debug VDSO files

Nathan Chancellor (1):
      MAINTAINERS: Add scripts/clang-tools to Kbuild section

 MAINTAINERS                                 | 1 +
 include/linux/export-internal.h             | 6 +++++-
 scripts/Makefile.vdsoinst                   | 2 +-
 scripts/clang-tools/gen_compile_commands.py | 6 +++---
 4 files changed, 10 insertions(+), 5 deletions(-)


--
Best Regards
Masahiro Yamada

