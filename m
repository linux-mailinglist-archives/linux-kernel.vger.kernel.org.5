Return-Path: <linux-kernel+bounces-60935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52065850B56
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8301C21918
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5E5F47E;
	Sun, 11 Feb 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sikNkRL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3695D72B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707681618; cv=none; b=K8MGf1+TRN1JMng9JfV5AtgfxMrLF85v584c9RRV+1w4RyuPKPe+TY1nCpht8YdfFJiYtkNN4r5MZL1WQM40iI6tnrcySIfRqGaHIioEtSgMqXcQmmejR5fwrQTFoyFbSF9OCsmtS+s2kzK+vhzwIkx1VjTR/4KbdsX+Bbi5O1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707681618; c=relaxed/simple;
	bh=wOCCmEqn3fZ+ZTH5YL2DOhtt+YntU/gJe/5bJlIpr9c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WDwjd5cGiwmbnIh7pRrwuzYyM/3a3DO+PHdVERjJdy3TKLniWXxN5bb2LqcU44Oa2ILcsV9PP4/tgHv4/0wyE6G8xV11VoguldbdIYahxRZLuehf3tNGacB5P8v/gOjnUvA4WOtGu1KO5SgjpF8UfAgrQCCupQlfTxCacgL+xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sikNkRL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C792C43390;
	Sun, 11 Feb 2024 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707681618;
	bh=wOCCmEqn3fZ+ZTH5YL2DOhtt+YntU/gJe/5bJlIpr9c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sikNkRL1FXbLOpoDPhcwhaUiZBAYhe0mF1ogqFwZObRge5FxAvjk8IZwforO1Y1nA
	 XXlYjeqKElCxGin7gYrgY/nvpNj7G0u8OUIb4E98F3chbbizj0POfqz/6GRF3+Q9PV
	 KmDHE3D6RdwW9FHr6SWyYS4W+sNCHa0F3L6VjRqXopr18+5lWWA1dJePVUf6mOXBy3
	 wqqHMymYF4lHIw99tUzLo7wKetRHR16HF8lHRYvN9clE8Mr5CSplgmvfkQDA+9wjMf
	 6I3mTITsCfNl+PiR/OtQGDAzQCXK582iizlbOFK5SpOYmKEJWokAjIivRuAlrFpwtb
	 OEI4lrOI8Nf/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAD55E2F30C;
	Sun, 11 Feb 2024 20:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240211105013.GAZcimZVIzw1_iPMKe@fat_crate.local>
References: <20240211105013.GAZcimZVIzw1_iPMKe@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240211105013.GAZcimZVIzw1_iPMKe@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.8_rc4
X-PR-Tracked-Commit-Id: dad6a09f3148257ac1773cd90934d721d68ab595
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2766f59ca44e517a1d6226979c784b026f0e89c2
Message-Id: <170768161788.6576.3341198084939173364.pr-tracker-bot@kernel.org>
Date: Sun, 11 Feb 2024 20:00:17 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Feb 2024 11:50:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.8_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2766f59ca44e517a1d6226979c784b026f0e89c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

