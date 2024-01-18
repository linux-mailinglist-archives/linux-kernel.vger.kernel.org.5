Return-Path: <linux-kernel+bounces-30616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA80C832214
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AA1F238D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71442E848;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0g09crx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7F28E35
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618911; cv=none; b=mqeVva26yePp8M0b3+NUQBrmfS5+IEGeEVqnwTpEyAf7aCqfemrL128/2f/i9MFu2NucBLeQX4xoqdQLlRIuT6pyK7FehJzYuo/rNsa0+P6tg6FQxODx9DVJfQqHanmSGgpVQ/xLQq51rkNJj0Tlow31aC/8Iov3Dqlu9Df4CJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618911; c=relaxed/simple;
	bh=6ZyDs6K7t0mtNhMMUuPTdUUAHAs0GDGKAtl9bSvNorM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nzSoC3Ub2T1/0zFjgussGJ1mJCgN6gaKfb1UIX2dAo+Mg/QDD5zgI2emsZGUQ8c0pcAbdwEnKC4PjWhJzPosh1z3FiRULd0bBLeCgCwm+5qSgdTBLmcCtK6L1a6Pzoflrv4cZWb1qfY9MXlogG4aJRqosZpbu7Gji7yAPsFitms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0g09crx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04EFBC43394;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618911;
	bh=6ZyDs6K7t0mtNhMMUuPTdUUAHAs0GDGKAtl9bSvNorM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q0g09crxE188Ejg7o8l08eK0B/Z3aQafstjJ5A9Y7+Qo5NvBLexChV2s+C1h7fF2J
	 PaoJL+DgLuDV/kQYbc7tMFSe6h8MrVSb3fIY1hKyok8XNNLVmLjSD2Yflw5NlJF2cu
	 1LILNcpkdfGZ5GMm5cFzNhkrzUJXmeOI/kKv5LxU3GOuRW1CFlYRgTYgm4oVEME9wv
	 6PH7nHupYf0qmHCI3RJefdkEefhqgxSDHDDLJDcxcVkZCdSAjPP8U9nDYSZN2zSQuS
	 sXatJnHZQeEjOFu1oe/lVHvVSaoZapk0LwLBixuoh5ioWvE/vQQnj3LhI0zJxSuS1N
	 3wau44QDNCAvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B07D8C970;
	Thu, 18 Jan 2024 23:01:50 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110205124.3007385-1-dave.hansen@linux.intel.com>
References: <20240110205124.3007385-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110205124.3007385-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.8
X-PR-Tracked-Commit-Id: 981cf568a8644161c2f15c02278ebc2834b51ba6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba7dd8570dc8ad4daa3d1c49a137a7b8479eae07
Message-Id: <170561891094.14039.35849796582908359.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:50 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 12:51:24 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba7dd8570dc8ad4daa3d1c49a137a7b8479eae07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

