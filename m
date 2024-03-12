Return-Path: <linux-kernel+bounces-99795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E11878D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652BEB222B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169BBA46;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKZJH9YZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F332B641
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214356; cv=none; b=q9pHWb5YyHkD4KBhjpgrE0xx3NsTGNAbbbUzVZ89J3ijz8VUYAx6FCRL+LnKAkiC8dqPlZ75AxB/T/SNYn6E+oN87yJj4N+uYuacRbxoRQshI3Qbjoc4ZhuLawLDF53wDAgeM3khrrP1x16LZKaAqyHbSd2TfIl5XcVRD3JifXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214356; c=relaxed/simple;
	bh=h9rupl/6sUppLNKITMrcpccaL34yeN0PZHc9V61rud0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sGK3NgVrQv3tr4n8b5xd8MVaP0JkWkKejFuNUMlarJnhN7qKBYlfV5Ee/4uByl581lJaMEloSGtVuj+l1maV9Vbjo+1W3yZPGztHpRTs1FqJuNPinJOwuYrgOMw/Mz1A9hrfmoZqbaEkz3EXjfb/69Pl3tJyNhI5hwLrTR+ZDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKZJH9YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01F1C43399;
	Tue, 12 Mar 2024 03:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214355;
	bh=h9rupl/6sUppLNKITMrcpccaL34yeN0PZHc9V61rud0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GKZJH9YZ38OmD70fr7MXpNpaeutYty5QZmP0ocAc2VxM4QabVzqVirSTXdbhjGvg/
	 /PqS16UVddAtc6WXOOg+RzzB8zsr5mcM+FdjGlExYRTN93VQVdwXLz9QcBkboISU5G
	 +NgcG+wGPHnRhqcrgFjcUaeuS6QGWnq+03Q58RprzCrcBEHVgv2ueGvQAU1sr6lnVr
	 dda0Ie3K3kpLmHXoJUpEhdsp7yfLUDGXxPUuJ350FTl6b5hPF/hrnRO7SM18z4NkR/
	 3CLZFdp0BzxlfqfzzkbmMCqnpzI8FQevfh8AJc5itt6XAIkiKuNKl7XigNvCqo7maH
	 VYvmwQzHp8wOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAACDD95056;
	Tue, 12 Mar 2024 03:32:35 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze72bF17UQpj7ZZy@gmail.com>
References: <Ze72bF17UQpj7ZZy@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze72bF17UQpj7ZZy@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-03-11
X-PR-Tracked-Commit-Id: 54de442747037485da1fc4eca9636287a61e97e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89c572e2f30c4555da59c4d66dff62f30fb057fd
Message-Id: <171021435576.8573.533990195137162983.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:35 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:17:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89c572e2f30c4555da59c4d66dff62f30fb057fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

