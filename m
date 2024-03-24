Return-Path: <linux-kernel+bounces-112801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E1887E53
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93792B20E81
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B813BB37;
	Sun, 24 Mar 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+YUfL4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07643B295
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304762; cv=none; b=fIaW2GzTsTKeHOTgd+tOE23e9CLyimRNnWehDhsAH/TJmGyW2QJ7P03lk72HI9JZ7uFYArrIaQfnRMRy3odqXVjUijZtAV2Mvk71hDKKQzZYaJ8FH9RMAdohyH4XyxGo8SMBXUP19MQmVWOGY40R7dIBjdCIgc9sd99Mn30Qws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304762; c=relaxed/simple;
	bh=arjb4ZiGsZQy/SuGDHamr8pTDik4dK3SxpTuHodjuZ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GaAQGKpUKItLV7pK6p4Jvaie+Ql6dRrmjmZEXKPTtutb6/4xXZJ6ywRWd1cLocv5jCkDDXsJHncQcm8W46Xmz3fn7JFtzP6cxhbngk+502eQ8rkHs8JGKJ0ijcv4+5k7OXb+wu2I4PMhXV/Omc6LolV3yu+fBs2OyDeQfB9XW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+YUfL4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90D32C43399;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711304762;
	bh=arjb4ZiGsZQy/SuGDHamr8pTDik4dK3SxpTuHodjuZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N+YUfL4EP3ql/pl8CwZjyEgQqi2/CQe+oeQjiDPrZThE1EKm+5bbptLAbzz6lzwlD
	 g3Q6AMa3nreA5ExyZiZPuppdQgIcTQh+u/E2hPj+K+Fg3WNqfzg/3w7tAM6RdtJKaC
	 0PuA3O8NJiiTrV51lNjIrJZCJI9fovXA0jE9leh2rwrigRi1DhTydiFMD0hk83Cdkw
	 zRUZhligK/ZBXHWJCNpfuufA/g/qKEBpkScfmfAMk3/I+PIcojRzb1Tv5PQKyYu82n
	 Y1RuY4XF6Wgcu77tMwEfGhoI+QAyA42rFL41jOT3WW2oCTieUMP4Iib1a5l73LDEZH
	 Ghdl+ZSph2KuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 800BBD8BCE2;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171129691660.2804823.9714349244324963954.tglx@xen13>
References: <171129691660.2804823.9714349244324963954.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171129691660.2804823.9714349244324963954.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-03-24
X-PR-Tracked-Commit-Id: a26979377bf34534ce5ee2712d2a46157ec61498
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b136f68eb00d898e8f5549d86cc87e8a9e4185f2
Message-Id: <171130476251.9900.13970828129143282341.pr-tracker-bot@kernel.org>
Date: Sun, 24 Mar 2024 18:26:02 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Mar 2024 17:15:32 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b136f68eb00d898e8f5549d86cc87e8a9e4185f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

