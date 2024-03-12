Return-Path: <linux-kernel+bounces-100870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB293879E72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DCD28411B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE314402E;
	Tue, 12 Mar 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n87115ES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14F14375A;
	Tue, 12 Mar 2024 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282243; cv=none; b=ZVod/i8UD5YBOsmvYCKPwBJsSWj1Sv7FFqmp3s2sTyLVbFuczvx/zO9vxD8ldovkqjU8aCM41sHzwmCELgc16TvfeRIAJuWBSPa4S+FeSVrvuxRG2sFZW/82R1/FLce3twpkuvHBk3Xr31/OUDhpWy51oTHlOlkCqmY6BBVnVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282243; c=relaxed/simple;
	bh=sVJXME02Eu6eBM/W+6bAl2txUWT5DlFFqAiPiAJlsAw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y0cNLXIatgBA+1CKzDHk6wUs1UvSMueSd8lu/7FFbKa7o7trP6LQehROIeUf85HMjfuZx3aKzoPKAWTcydDJmLVvRcE4BkwRhHkrYSgzbLjEX5LANoqTVoTH4TvBuje0IdGRK56shez1+L2iqE2lWzIpI1kOpNq3AjaU6zPQYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n87115ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C073C433C7;
	Tue, 12 Mar 2024 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282243;
	bh=sVJXME02Eu6eBM/W+6bAl2txUWT5DlFFqAiPiAJlsAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n87115ESNuqRdxF+ZRhkyQgwmCz8hfzcSU1dBt1s/ibxe3EUsSvwDUbtbUMhub27H
	 FIMDxq8X5gwBDA/aWJEYQ3IIbVKzW6clt82Oc5DUKl78yvvy/DvX2iNT9IstLknraL
	 NDylQnonCUNF9KrARS+MmexfXzrLDbOeurg3SXubouvDofeLcT78CO/di8isC2Jyty
	 Ie2h+Arh4uUI96JMbzcXim16EKeeqFRPu1INUmhFZllp7VUpN3fkezDa9XzQUIQyws
	 F7ntAk8r7FDvpLSrF0ZJZsAGyGqidp+P2YL/wVUCJN0IY0TigHF3JW8mAxuz4M94mu
	 7qEV1PH4PGMYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F0FFD95053;
	Tue, 12 Mar 2024 22:24:03 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202403111702.828C918E55@keescook>
References: <202403111702.828C918E55@keescook>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <202403111702.828C918E55@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc1
X-PR-Tracked-Commit-Id: 3fe1eb4dd2e4b872ffb7b9b081b34ffcfa934ba7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 216532e147b2fee6ee830f4a844bbc3cbb9137af
Message-Id: <171028224303.16151.15003389057998252941.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:03 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Fangrui Song <maskray@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guixiong Wei <guixiongwei@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jani Nikula <"ja ni.nikula"@intel.com>,
	Jingzi Meng <mengjingzi@iie.ac.cn>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, Nicolas Schier <n.schier@avm.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>,
	Sachin Sant <sachinp@linux.ibm.com>, Sam Ravnborg <sam@ravnborg.org>,
	syzkaller <syzkaller@googlegroups.com>,
	Tanzir Hasan <tanzirh@google.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 18:18:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/216532e147b2fee6ee830f4a844bbc3cbb9137af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

