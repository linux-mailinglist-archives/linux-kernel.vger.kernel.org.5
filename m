Return-Path: <linux-kernel+bounces-144332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D0D8A44B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195BA282158
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9087137741;
	Sun, 14 Apr 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7lDfga4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D68136E0D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120484; cv=none; b=blOSFTMxojN0u1SZmiindn7msc7B4EhIiPVZHUg4KgUaDclkFrWJGnR8zV92VbuTn55EopVkSjUiWAtiqj2aX2JqedKbrCOoKP6l9oZuvGrQWxzWWmrkAxP8bxPIwcXxOXitSpW+HllcBXwS/09GzV1vGrCSkbXyA71d/R2Q3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120484; c=relaxed/simple;
	bh=bkJud75dWCLelFlJTjQ9ZIkxHg+RRc9VtyY6fsh39q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G9MzRjoHanPAnwuIH7xhPxigItKrCEwXTMutVo2o65qRYLND50T2+Tndh5aTKnzuCLb9QBD9UKtANlH9VMx+YhCs/vAbMi9d0fIlUN8GF3PIihkvFRieJUJTVunF57h2fInBiVbKZz9SgcjczI975nf6+xbi7vMxrlXazyqGpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7lDfga4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6AAAC4AF0E;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120483;
	bh=bkJud75dWCLelFlJTjQ9ZIkxHg+RRc9VtyY6fsh39q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E7lDfga49X2CtWhOraYDsd4Cl5/x/pxLwcZ+qhcJ41VJ1OJMqTgqaiiGSXeN3c1fh
	 uR2I+oVCUEaMtg0xA/4hv28rDhPT3Man2q9t51XIszbS0ok7wRa6sQHCb14VS1CBke
	 czzb6J3YMDUmcYGh899nfBrsLAJ51Hcrz3ihw7qwoc/zmpdqHhqV70VIBgDJY/TAxU
	 4TjJxfCxZ0btf52Y5XyH3SlfwRUjd/W4K53uBX3qJuwM1WsQoZsUIkdBDiocMKVN9L
	 AMrf5VRVurC4ufAFrdM5LTwFYNnu2FdBAotcQBIwCSLsqZOZI76FqZeu5rDPryYWcq
	 IlCjx/nti7HtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD366C43140;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhudAcrqVdnwUjKN@gmail.com>
References: <ZhudAcrqVdnwUjKN@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhudAcrqVdnwUjKN@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-14
X-PR-Tracked-Commit-Id: 7211274fe0ee352332255e41ab5e628b86e83994
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27fd80851dc1e47b2facaa11b5b52c7dbc6b0718
Message-Id: <171312048383.2589.14932754811018409329.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 18:48:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 11:08:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27fd80851dc1e47b2facaa11b5b52c7dbc6b0718

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

