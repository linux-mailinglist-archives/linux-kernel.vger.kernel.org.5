Return-Path: <linux-kernel+bounces-48249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C6C84591C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BF8293CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BC5CDEB;
	Thu,  1 Feb 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp/sY+LZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16D5336C;
	Thu,  1 Feb 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794824; cv=none; b=TKKF4tn4NACmghW7sjIdVwNKGkHGiGCIGldv9Bmz1+BH0/vyqC/yxM6SmFVJvqQ330Mx9syNI6hUWQmngrSaQxKgEADrK2kdJb8okiCJuelw9ysu88tDW6tbG/+ZEYceL5IsDPkaWeTKxlfZ/1hJkTPKHqk/vZgcXf9g1tKpHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794824; c=relaxed/simple;
	bh=oAxNGUG5YGYpd4b7bdL9kU50O/b9yXAgFrSQl/Gwvm0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X8J0SuPR9Hc9FkIgEG8VGYgTrMXVDSgJQ67AoTMYs5qFpCgJT+Widftm1iZUP2sZhKlfg5aPoQv2ET48F99SfXro4ioiiXlLH2JjXV39mkiAsH1tbZy1tCR+DgIR1M76/COal4HeNo7hmSgtkQLWUdt1MF7d6MFMI7QxugHUDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp/sY+LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35B6C43390;
	Thu,  1 Feb 2024 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794823;
	bh=oAxNGUG5YGYpd4b7bdL9kU50O/b9yXAgFrSQl/Gwvm0=;
	h=From:Date:Subject:To:Cc:From;
	b=hp/sY+LZdEB4EEqoIvqBGwBjRZEE+p7I5yA7vsb7EMv2IU9Qprzs+KyvJ0LwCQc2X
	 1EtrGfrA46KUGcrTzRYJy7eJaaWgQM1nqb/TrY8KLVyaz9kBx3VbHfi5K8FRRL5+ZD
	 0Xqr8+DNOGRnmGTvb9Vc5iFuShgypPHwvFnmp+6VQcyHi6pMIID5U5kXnkW56/W0J6
	 2N6sGuPFXQPfHgwdVRxDJuiYPmSyffPdyHunEwIqKbdcmkPraVS2GwiXnc07zNoGoA
	 v8o7+T4qXFU6CuYTRohCMYFw5zMs2H+CGqPJorGjZuG63ktmaXlI2MB5PeThTesinc
	 xFctkTNYlXAeQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5112a04c7acso1413846e87.3;
        Thu, 01 Feb 2024 05:40:23 -0800 (PST)
X-Gm-Message-State: AOJu0YydDAMQ8QIHTqXVm9+e1Z0rEm+Iqk/QN6qvHh7bJ2FFtGsDbzu+
	jBr3iO8wDjldSXwVNE7hYApVWWeEdwce7svZ4pwxyBkAxnmTvfSSzA4IEVzzP5VH0L4PV68E4j2
	DFiLfUn5RJA25FhYQZ+zDYwPvNQU=
X-Google-Smtp-Source: AGHT+IGSPrBscaai4AJ+eQh21ctAxSM5b6ZbRbe11LFDx9qDxNmj4JsOxHenLzRaPq5CEA8QNKB2wNLVyvQQ5J+a28g=
X-Received: by 2002:a05:6512:32b8:b0:50e:378b:5187 with SMTP id
 q24-20020a05651232b800b0050e378b5187mr1803005lfe.41.1706794822293; Thu, 01
 Feb 2024 05:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 1 Feb 2024 22:39:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
Message-ID: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.8-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Linus,


Please pull Kbuild fixes for v6.8-rc3.
Thanks.


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.8

for you to fetch changes up to bfef491df67022c56aab3b831044f8d259f9441f:

  kconfig: initialize sym->curr.tri to 'no' for all symbol types again
(2024-01-31 23:59:42 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.8

 - Fix UML build with clang-18 and newer

 - Avoid using the alias attribute in host programs

 - Replace tabs with spaces when followed by conditionals for
   future GNU Make versions

 - Fix rpm-pkg for the systemd-provided kernel-install tool

 - Fix the undefined behavior in Kconfig for a 'int' symbol used in a
   conditional

----------------------------------------------------------------
Dmitry Goncharov (1):
      kbuild: Replace tabs with spaces when followed by conditionals

Jose Ignacio Tornos Martinez (1):
      kbuild: rpm-pkg: simplify installkernel %post

Masahiro Yamada (3):
      kbuild: fix W= flags in the help message
      modpost: avoid using the alias attribute
      kconfig: initialize sym->curr.tri to 'no' for all symbol types again

Nathan Chancellor (2):
      um: Fix adding '-no-pie' for clang
      modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS

Zhang Bingwu (1):
      kbuild: defconf: use SRCARCH to find merged configs

 Makefile                    | 14 +++++++-------
 arch/m68k/Makefile          |  4 ++--
 arch/parisc/Makefile        |  4 ++--
 arch/um/Makefile            |  4 +++-
 arch/x86/Makefile           | 10 +++++-----
 scripts/Makefile.defconf    |  8 ++++----
 scripts/kconfig/symbol.c    |  4 +++-
 scripts/mod/modpost.c       | 15 +++------------
 scripts/mod/modpost.h       |  6 +-----
 scripts/package/kernel.spec | 22 +++++++++++-----------
 10 files changed, 41 insertions(+), 50 deletions(-)


-- 
Best Regards
Masahiro Yamada

