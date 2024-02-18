Return-Path: <linux-kernel+bounces-70129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE08593C5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3912C1C20BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA422EBB;
	Sun, 18 Feb 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geix2cuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5F634
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708218305; cv=none; b=b9U2ZRYVvvPVQGrIqQABsSrs91ico7Pj2Yv3jnUCZD4w899WsHJQGbrnjUvsZywN5mEC+umkBwqdhBrATgC5CPz5t2OZh0XGGBFLsq6tDPUr+S+7dnLw/hiCZ+vAHEVAj8kfSKdS+h0xwlGYaaN3YDKmV5e0a8PS583NJIz6eUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708218305; c=relaxed/simple;
	bh=1zMeX2lPq2uHqO30zf3bV0zHNDk+kqy8XXaghomNDJk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KM4uVBUu6HD9JOBoYAbYQZxnqa0K3hs5LtG8U4wq3xeXiVAdj7BTMkM+Ac5wul9WXmZADrWW22LNBaLxC3rQwU4ZacBdRkS4DAUdvR3lms5jJlXyXQBvbFBfrD0dsu8uVoS16dHc0kajz025OKlxpZwAgu8UUzQ6oj4LBfS8xIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geix2cuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AB2EC433F1;
	Sun, 18 Feb 2024 01:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708218304;
	bh=1zMeX2lPq2uHqO30zf3bV0zHNDk+kqy8XXaghomNDJk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=geix2cuCqSZ39+DQ451YYEMJmi1TZ1KTfkoP2e5cjnHgoQFCsScDvuje1oozrc37W
	 RvyWGNVWiz3X9xOax/GGsGTKZ6Q4f2WS1xUfGa7ckR7IJuAmmVbRoEZ06yeRT39nL5
	 Q7sVZXSwlrJWoMmKy3B95yeqBgM4xITgkCKql9ylUrBc/rgcDq2e41MRped9tDCCwH
	 cq2z0W6v+E1W46FsyytJ2qtPFciTy8259eOYfprVxd92UXVJCcDeUm1L/tXdaTrcMx
	 BLv3XOPShRidzGCAmuRIncvgocb5kaKJ74iBmEzMpOcKCVJy5Sgz9H8o6LJyP1WcI4
	 b6LY5upr45gNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67276DCB6DD;
	Sun, 18 Feb 2024 01:05:04 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87cysu1vap.fsf@mail.lhotse>
References: <87cysu1vap.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cysu1vap.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-3
X-PR-Tracked-Commit-Id: 0846dd77c8349ec92ca0079c9c71d130f34cb192
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c02197fc9076e7d991c8f6adc11759c5ba52ddc6
Message-Id: <170821830441.19458.14910563235489562479.pr-tracker-bot@kernel.org>
Date: Sun, 18 Feb 2024 01:05:04 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de, david.engraf@sysgo.com, gbatra@linux.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, matthias.schiffer@ew.tq-group.com, nathanl@linux.ibm.com, naveen@kernel.org, rnsastry@linux.ibm.com, sbhat@linux.ibm.com, sshegde@linux.ibm.com, xiaojiangfeng@huawei.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Feb 2024 11:16:14 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c02197fc9076e7d991c8f6adc11759c5ba52ddc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

