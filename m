Return-Path: <linux-kernel+bounces-126343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2089355B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A904285336
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53E146592;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO3W27OD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695D145B3F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909251; cv=none; b=u//AWC6Qi380PuHzYuCY/HXNHp0nxUBjx4LxU2T+r3Nr2a0HigqHz4JiZh/uvf4ClljKd3d9eM+JLMaaUoFKeGYHgMMDNdww+hgiEGGM/zKvxpbe/QEuIUxcW8jRZ+xHHjPDZ8dagwSMi80jwWySmbG39oWaUaPhS37h16Fm378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909251; c=relaxed/simple;
	bh=SI8SPFeHNqLleVsV6bAfgmZUSMMotvJiClyuhWOm0nA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PvDQuWU4uBNAVKcjlXGe7ZPq80GTqNHD4Xm4nN5I/6bGVCZzJ/2IOEI+8ft8jnlTtBmo6f4vJu6oQVGwP/Q+ISTN7BIIS+0WQChO/OrReIG3ysfvu2vSMQ7YWMNGKms2qBgIQf+6/Wdc8oU7hNik1NHHkPKPUIuvM7tX2utrN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO3W27OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 051BAC433B1;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711909251;
	bh=SI8SPFeHNqLleVsV6bAfgmZUSMMotvJiClyuhWOm0nA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FO3W27ODT7k7R1G/kkyqdGUPgiTSjs19EFZi1+j/cRlKbL9z/DzJGTop78BgNBp2m
	 5yBjlGmQuJQAAxdn1q3lute1hCeL39SBE3QUQd59ZI59TAMjLxnAztJA2aA2249b0A
	 AXaK8ScbM2Lvxr8Qn0mPotKnoKaWThctBu0hYHeoLjlWOX/n6idAh0ULkQgcydMtiW
	 9zp8MNKmWrvzCwfgD64alvt92qY2LQFO3suDFZPyGRgjbiEF88Hp/qrcOb5NAkraMY
	 +lk++G5xCUKXQdViHH8SQ1rcovxm+8U2h1EGtX65sWBXbwRX0JsQn52QLL+HxtGPRQ
	 jcfKBql69wsrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE995D2D0E1;
	Sun, 31 Mar 2024 18:20:50 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240331112344.GAZglHwOp8M9XR1akK@fat_crate.local>
References: <20240331112344.GAZglHwOp8M9XR1akK@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240331112344.GAZglHwOp8M9XR1akK@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.9_rc2
X-PR-Tracked-Commit-Id: 68cdf1e6e8f2ce78ed7d8f5d80844fd75a9c54ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 448f828feb495c93fc78f5bb15716968a64fe6f8
Message-Id: <171190925097.27603.9750114724672071227.pr-tracker-bot@kernel.org>
Date: Sun, 31 Mar 2024 18:20:50 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Mar 2024 13:23:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.9_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/448f828feb495c93fc78f5bb15716968a64fe6f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

