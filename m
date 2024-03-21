Return-Path: <linux-kernel+bounces-110755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D3886340
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5C31F230E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F29136997;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmkJeFNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14312136676;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059922; cv=none; b=jIuakf58LswHLDXvK+E4LiWPU5ovi7l3MzwcbRJamFChlEjZGR+bjlmuylC2aEqw3wMPNheVCiPGivIBJOkmq3v02mmrmyqqKT8+g639CGcoosLwnxNmW1y3G4uNNFKoHXAflBI2xqLbrG+Fqg8/w2SGXXdRUqrP1oO5FTK4Wew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059922; c=relaxed/simple;
	bh=FbC+Z4ar0Eyslh7DePrwrGbUNQ8gk+cAMEUHdiHXg4k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LmNFCTMFl686R/d/L6SJlBkoiTzbIUg2OQdQ9oxoAGSOqM+5bMHWzj1CToL4YdGkwx3TvgVeEIici8Wc+TREccE9wGouFzry/o3ysBRz1fn5FnCynwOzRC6BVA0Xgk72C8Se6zgjZRNE8wQaFQHEhjsWoCOo9nkvHKXXfWYg04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmkJeFNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA6DEC433C7;
	Thu, 21 Mar 2024 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059922;
	bh=FbC+Z4ar0Eyslh7DePrwrGbUNQ8gk+cAMEUHdiHXg4k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mmkJeFNNp3PLqoSL4pyHWDNF7tDZcobtBExkBs5cfVGBTCwbpi50UCHEGIvxGeyDX
	 2kNFWuomEk2FzwDMGPKVnV0O1aY3gp2l/EXBSTicGy6ZOFH58BKdGyGJ9RC+oy51og
	 pmQToWfI6WPT5Eblr8aoVmkVukoGLxJHvKaKIOUKsgZTQ2FZRfkf5BPE8y6/xSkhOB
	 TCzenKG5EbhOxCDyEk7Bc7Eaz8dXMEtLQWz7OGyPOfWvCViyBHFYKTZVJy7fumv76w
	 8yqlUqlCivFnPej9SJ6x0lXJb6tv2CERftuqXZVefXSghwlez8gnUw4e1zkuszD7pN
	 WFSWU/UYJSQBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE713D84BA9;
	Thu, 21 Mar 2024 22:25:21 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARXef6Myb_Gd4jyGfwujoBAjmjzLZBzgkm4T1KmfHP0MQ@mail.gmail.com>
References: <CAK7LNARXef6Myb_Gd4jyGfwujoBAjmjzLZBzgkm4T1KmfHP0MQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARXef6Myb_Gd4jyGfwujoBAjmjzLZBzgkm4T1KmfHP0MQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.9
X-PR-Tracked-Commit-Id: f2fd2aad1908554fbc4ad6e8ef23bad3086bebd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d35aae78ffe739bf46c2bf9dea7b51a4eebfbe0
Message-Id: <171105992190.29795.5852363316408995831.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 22:25:21 +0000
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 00:02:37 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d35aae78ffe739bf46c2bf9dea7b51a4eebfbe0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

