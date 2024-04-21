Return-Path: <linux-kernel+bounces-152540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0A8AC042
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE97281766
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2C376FC;
	Sun, 21 Apr 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCLiDRQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D632C683
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720226; cv=none; b=BRI5CUYseWXUwnOWrY86h297vGEu6yzfXeUtZf9RULwUoUNG5n/TtXd3aDA3DZtOVg2jqJpLejTeQ0unM+TOlA7a2bcZ6zmb5N8UJ17GfFldNWDTWlglFA6JLMkna+izKBM0cRYlRuPCbzC5OTYbeMXl9JnbPYP/a3RVGckpR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720226; c=relaxed/simple;
	bh=uWrSK6tdkO7dcQBWNFKmkB8+EWYVC6CBvxbRdYeW+Uo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TcWAz9T7ZdIU1KmRGfE8en8kqbP3sUIm5XlrKHmkGI3FfbgtvZQxu/dZTW+GsTVsfGz8MEoEEJ1T9dcMTZ402wsIVfpuQYxFPtT0JoRUABaIM0NT29omvpHojNKYigh8zyO3zGGZzA5AOJ2wkT8b4cF32bA0GTGPv6mwZIbxGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCLiDRQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51ED2C2BD11;
	Sun, 21 Apr 2024 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713720225;
	bh=uWrSK6tdkO7dcQBWNFKmkB8+EWYVC6CBvxbRdYeW+Uo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YCLiDRQmVnt7kr+0JvMpA4z9jaNrwxn87i/iGkURl/MMCLgV/3drLULxzdJBVUQvt
	 TIezgqPgSYZCywt70gxXpZs6sjbNH1zQqfQ1ESHH5c4xsxdtj1J2suKqRchMJ0BCe5
	 AE0yyGbK6OVFDO53fsJQ/uyQ9mLz69mvqpz1LwguIAZxpxd/NjtYPMbEJ1vHHIdRTX
	 abfbkOgWhLLWV393Dckfa4D3v2A5l9tY9x1c0QxrAQGo3O440sNZt5Uhf4ln0ZcRlX
	 kiOlgee6D4yqu2wxumbzRlOz3vcKG0QvNYDQUcAGEsJXxicYhJhQwoINsPntv5r1ot
	 NszjwCQis+TUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43F7FC433E9;
	Sun, 21 Apr 2024 17:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240421085237.GAZiTT1fEGnBzUS55m@fat_crate.local>
References: <20240421085237.GAZiTT1fEGnBzUS55m@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240421085237.GAZiTT1fEGnBzUS55m@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.9_rc5
X-PR-Tracked-Commit-Id: fe90f3967bdb3e13f133e5f44025e15f943a99c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b68086599f86f4be244ec7d1928c8a74cb9538d
Message-Id: <171372022527.8168.15973046886029757884.pr-tracker-bot@kernel.org>
Date: Sun, 21 Apr 2024 17:23:45 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Apr 2024 10:52:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.9_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b68086599f86f4be244ec7d1928c8a74cb9538d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

