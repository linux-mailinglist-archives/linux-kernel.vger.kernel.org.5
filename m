Return-Path: <linux-kernel+bounces-29396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D173830DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FC21C21AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D628DA9;
	Wed, 17 Jan 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9OtCyvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A56288DD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521837; cv=none; b=Ch/cBB1QXQN315XGif045XYWbJTcCXDl8he3Zt+85u1veOlH+e6eO0fJ9sWWkqPEJNhhWgq4fQ4mm1ddVbUTxSdqfUhuTPuGYdQTVyq64Bx/Prynm1XTge/eIHJcjRuiQlXQhhbnYG/YNf4HiaVoSuj6V4VqUDeYdITDTSNXiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521837; c=relaxed/simple;
	bh=ch9LcvUO8w+f3wSlFgSi/nabINESEwXpx7bPIxm2mUY=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=Q4NPBUohxF0wvsfJLtlsugE583b4hnIu0lEs1MPGtXIbG+F4H45l4vhk/1IBqAlN4YY8myBf1ZpHNfoT1qiUEpQxCLUcU4e23hr0/FSLlVvTllLj3TZC+fprkg9czxODGryuzWZEG3vzR2pW8ttsi+p+qybvATzWcqtA0oP0RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9OtCyvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1978C433F1;
	Wed, 17 Jan 2024 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521836;
	bh=ch9LcvUO8w+f3wSlFgSi/nabINESEwXpx7bPIxm2mUY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L9OtCyvDrsNjNOfmrMSIP+3tE1n0p+L49L/1BKP0qZopEuSonn7lbeXdDw/7YVkUU
	 mNsm1vCjh86/5MU87ysWS+QH2iLXaSLefew13uQ4lnJnLcgSbpUc+AARMb/7c2h8uh
	 SWSdz7Bfy7gfs2hh//gL3kWAnSbee9rcgqL0g708MavCl3wfRx5JE9gBHxNVywBMNG
	 7pxg+eOg11qTswwzcQJCwM3vCYlGtKEnZdQxT+mIWf2tc/fxdGpB5o+dWZS1PjMG3v
	 VA99x4AtZ+99Jkyz2uh6LNGofUFf6Kf3Sm9g+wI1Rn/Rgn8uGWm+13mABGUIsJ857W
	 g9hitUx/fmz3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F1C5D8C96C;
	Wed, 17 Jan 2024 20:03:56 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <adcaeddc-1bee-4e5d-bf1e-d1cc93d08a01@monstr.eu>
References: <adcaeddc-1bee-4e5d-bf1e-d1cc93d08a01@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <adcaeddc-1bee-4e5d-bf1e-d1cc93d08a01@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.8
X-PR-Tracked-Commit-Id: ffb0399437ef582b035089d1617bbb0ea174cd0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 284a4ddeed35091a356fb8274d91d2dded62136c
Message-Id: <170552183657.2985.4863347448488661085.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:56 +0000
To: Michal Simek <monstr@monstr.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 13:23:20 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/284a4ddeed35091a356fb8274d91d2dded62136c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

