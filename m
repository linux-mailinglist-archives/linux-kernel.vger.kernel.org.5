Return-Path: <linux-kernel+bounces-51488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1ED848BCE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D84285043
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD14BE6F;
	Sun,  4 Feb 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMzN0m+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C198C1B;
	Sun,  4 Feb 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031117; cv=none; b=ABLIjVaYt9fDELkWbJkJsJuqrbNhHf/+v2Xtma92NzHR83+q3QmdM1Xv/VUiUqgr/5pwxkQ8biR0U0rNEViGsi4QkFGTg3k9jU4jks2E82gFbGJwH5VQ4gW17jxbEhZ4SZ/N60GmslxaQFXj7vmjIc04n3+jmil0uLPrhiUw2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031117; c=relaxed/simple;
	bh=B4fhnVthxiZQ0dVJdl2GGx0a+RKL+QH/PMaRY12nKtE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N0nxpMab07Kda06x1mcdKTJo0HZ7ieIipCkXaBxNmSG3IemLt2ohZCo6rlz5Vf1+s5oELsc1ynel32rkDslKoL0/uhzoa39ZtozKIwchXWrm+9Xe/EQfSMKvIyzl/fiSYk4RymcOxXlWL105VgEccHC3Pl/Af3nf6Br9aiyGG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMzN0m+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F07B1C43399;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707031117;
	bh=B4fhnVthxiZQ0dVJdl2GGx0a+RKL+QH/PMaRY12nKtE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RMzN0m+BKsOmUeuakxrw8d6EVNGMnBVWd5K7jO4K+HgRKJZHGvdvo3O+/h5QgrU4w
	 bsd1uz8IEN5e9oysTDpBM7YuOMsFJQg/Eaiys8JkSSrZlWbYQ/A2xldBX46jF+5duf
	 YITmxaKeVUt97c73B1Axl0wp5LA1VFPHRXTqfeUl5oPhNxteSxGYqs2KQgqEbsuojz
	 x2PBxf/xAF36dqiqZicN/xjGwaF5cRxUh6K/vi+VSvyzHKS52XY668XhJ5naIoeHdr
	 QPdmKCNyJhEvZJc4HrCzxM5TuziHiyxUKvuYT2aDy4hcituC+8FVot4+1mfuiNuW5Y
	 EuK1+U/eVtLIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6D4DDC99EA;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zb609YTmtyjUEwhc@kroah.com>
References: <Zb609YTmtyjUEwhc@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zb609YTmtyjUEwhc@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc3
X-PR-Tracked-Commit-Id: b35f8dbbce818b02c730dc85133dc7754266e084
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0214960971939697f1499239398874cfc3a52d69
Message-Id: <170703111687.23816.17679510281277946350.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:18:36 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Feb 2024 13:49:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0214960971939697f1499239398874cfc3a52d69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

