Return-Path: <linux-kernel+bounces-166688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C08B9E30
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A29B2515A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4D15E1F0;
	Thu,  2 May 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNmzK4Px"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D3153BEA;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666081; cv=none; b=bFm0L4qcwUqC3NWgNMBFAJvTHJbDD+xtw6mBUFn5pYoZCAsScmevveRKdifAMkVklugNewqN+pNZl3NElSHGCAE3EZzRyjEIRW3FcSyeBVQBQ5shuHWKco0+zdQ/QhJkwpjqkosoFXZNkAnpgqI4XpvdC2Swd7fGJ+7xs6jADno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666081; c=relaxed/simple;
	bh=ZwI6nEVR7BqXY36f6C9tL0Zq4+6qkVCiqXA+LQGtIKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W00iA19dPjdTEJDaTd1TLPX6qZtrkJl9TqRlAqjUU0mPgHxA56zIqJk0+aMjzX0znETPZzvosw69TMp6hLnBoEMeY/c/6za0e6r4EbPMvLGtfB3hTYwjuKtRZHfIXEc0GXBpu/DKXTLw21PCUDF9mwJjV4xO/mNXMAA+GVecVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNmzK4Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C124C113CC;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666081;
	bh=ZwI6nEVR7BqXY36f6C9tL0Zq4+6qkVCiqXA+LQGtIKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aNmzK4PxaXsRdn9JWP63ZFE4zz0Bj7PDKTLmIbGJbce/0fNXCxFX8nEoDIb+pzZZv
	 PSQmLBKB+ZX8evqLvcL0uqERyZ5QCjwLt2gsFaNWMWpI7i/wwJB2cMg2Tw7vNDhX0X
	 mlc9fLxLYosN0FyX61UTC9XSC32gSk8wzw/J1PD/5Tk6FCeOo1WiyRsZuCRS2IWCFr
	 TmTLyIpMjqSznIUzNa6lVujgi2lQuo91raLcEE89U4koc5BYYS+zBu0ZfyAgl9zYzZ
	 6ZAeZizwVaC+Z1UTsxyQtHllFX2wBe4ssrunTmm06dcTSrkBL+vNVSdskXB5DlQ2vS
	 FpF11wh743ngg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 244D5C4333B;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gqRGw3NEOVXH4vwERcy-kO+tihXBmP74UJGEhsTMc_BA@mail.gmail.com>
References: <CAJZ5v0gqRGw3NEOVXH4vwERcy-kO+tihXBmP74UJGEhsTMc_BA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gqRGw3NEOVXH4vwERcy-kO+tihXBmP74UJGEhsTMc_BA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc7
X-PR-Tracked-Commit-Id: d351eb0ab04c3e8109895fc33250cebbce9c11da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aed7b97fc6ec84fd4f86b53199df64a1ab42bab
Message-Id: <171466608113.26603.5163096004372195114.pr-tracker-bot@kernel.org>
Date: Thu, 02 May 2024 16:08:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 May 2024 13:08:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aed7b97fc6ec84fd4f86b53199df64a1ab42bab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

