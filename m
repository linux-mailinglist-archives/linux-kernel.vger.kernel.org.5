Return-Path: <linux-kernel+bounces-70458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D6859820
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464B2B20CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF796EB68;
	Sun, 18 Feb 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSkzjjYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A7335D8;
	Sun, 18 Feb 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277118; cv=none; b=odOlJk9u6mD60zkAedEfkNSPEZfk8jX8XixwvaGdufQEb/DJwn9Qx6XZ0pvcMGzTcH/tucQeYsRP7au7wSsHyLbNaOmcsa+bw/0AGF/teYuwYW6GRrZiULApGPlV8I3Foh08K8oq+zx+jc0jNG/AoN5O6sLfknxxaDYO8u0/xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277118; c=relaxed/simple;
	bh=TayFFF3CJoEPn5X7FFYamhZj0Qw5LziHBwT4xB5XRSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pthRUYFquRMT1F2QyoN1pHSKSp17RM+GIZ6Sk5N3gadgGmhVPcSURAAncrNuEqFZZOKgSxEGkVTjN2v3ru85qda/mpYLk+ROddoG5Qn1MojRFyU5XWcieRfG7Rh4OjvRD9b/nsPMPOO7bN5KazisPDb0GvLwszyhv/nEVeP0SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSkzjjYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15620C433C7;
	Sun, 18 Feb 2024 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277118;
	bh=TayFFF3CJoEPn5X7FFYamhZj0Qw5LziHBwT4xB5XRSk=;
	h=From:Date:Subject:To:Cc:From;
	b=fSkzjjYKLQA8pin3nrJiTn0oSUrrpqkQiKca453gsQAJuCWV1QqMnwTjqoMDlDiti
	 DsKiDPQtxONfMrO/gx0po8XdgEytd7B4rEbPy3fGb54fs/GR56ziezku5u4PUU8s94
	 gpTgITv2Zk+9mT5TeMMrVukLI6qjb3X17EsbRB0UURS2XZD3hLUOgEGwLOuyA9/DiT
	 nofkAB1wvhjuhiS2ONdXx2QwySaE9gV/h6y7i8aCqBrWTnjE3Lh34eG8AO37InuiXz
	 AJItzQZbrCrCRoAgMjUMSCopWdAIVKnDM8U9U8piqoJNf3aPtuelXBOq4PiIHl3LGf
	 auz3jHkrPSVPA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso1758965e87.3;
        Sun, 18 Feb 2024 09:25:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZSWdXf5v92+pTt22YU1tAUAl2gIiQjNPdX3jvT2fJv6y8JJUjmeBN2bcZz7unPEGX/hX78w8eRVu+RebIsLylmxYFk2MALT3HEQxN
X-Gm-Message-State: AOJu0YztB6F+MyX9n5UHXkUBupa9AEENEW8jQG42lBUgZ8Nx2NjSbOuC
	dZM/u9Z1TPpEN3+nAkCKLqPKDGpyE2yETj4zmxsR1vcvBLiUkPgvSpuZJdPNBb6vzT7wwYxHiL/
	rDprgUznUh9oPDuVPF0zPSybK4YA=
X-Google-Smtp-Source: AGHT+IH/fGQsV8zviBVRao4IcqIPeNwPCNDF8qYJtltSgvnpvDrQQWSXiK3Z7JyOhuFh7K25WPnkabdUsrNgTF10xus=
X-Received: by 2002:ac2:58ed:0:b0:512:a061:846f with SMTP id
 v13-20020ac258ed000000b00512a061846fmr2475314lfo.41.1708277116590; Sun, 18
 Feb 2024 09:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 19 Feb 2024 02:24:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQShtLfRkfXhy7+avfzbgR+4c86H6sLq=x+9F3GGdsv1Q@mail.gmail.com>
Message-ID: <CAK7LNAQShtLfRkfXhy7+avfzbgR+4c86H6sLq=x+9F3GGdsv1Q@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.8-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Linus,


Please pull Kbuild fixes for v6.8-rc5.
Thanks.



The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.8-2

for you to fetch changes up to a951884d82886d8453d489f84f20ac168d062b38:

  kallsyms: ignore ARMv4 thunks along with others (2024-02-15 22:44:56 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.8 (2nd)

 - Reformat nested if-conditionals in Makefiles with 4 spaces

 - Fix CONFIG_DEBUG_INFO_BTF builds for big endian

 - Fix modpost for module srcversion

 - Fix an escape sequence warning in gen_compile_commands.py

 - Fix kallsyms to ignore ARMv4 thunk symbols

----------------------------------------------------------------
Andrew Ballance (1):
      gen_compile_commands: fix invalid escape sequence warning

Arnd Bergmann (1):
      kallsyms: ignore ARMv4 thunks along with others

Masahiro Yamada (1):
      kbuild: use 4-space indentation when followed by conditionals

Nathan Chancellor (1):
      kbuild: Fix changing ELF file type for output of gen_btf for big endian

Radek Krejci (1):
      modpost: trim leading spaces when processing source files list

Thorsten Blum (1):
      docs: kconfig: Fix grammar and formatting

 Documentation/kbuild/Kconfig.recursion-issue-01 |  6 +++---
 Makefile                                        | 12 ++++++------
 arch/m68k/Makefile                              |  4 ++--
 arch/parisc/Makefile                            |  4 ++--
 arch/x86/Makefile                               |  8 ++++----
 scripts/clang-tools/gen_compile_commands.py     |  2 +-
 scripts/link-vmlinux.sh                         |  9 +++++++--
 scripts/mksysmap                                | 13 ++-----------
 scripts/mod/sumversion.c                        |  7 ++++++-
 9 files changed, 33 insertions(+), 32 deletions(-)


--
Best Regards
Masahiro Yamada

