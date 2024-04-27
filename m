Return-Path: <linux-kernel+bounces-161128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0748B4770
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CFC1C20C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A914535E;
	Sat, 27 Apr 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+HAZ9Gk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A2143C59
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242490; cv=none; b=DnmLb/Rmx3+rlSt+3Htu5gcJ54JwXlZa1DbMZ8Grudb9prPQCHuqylWTgjbDpZX6982Q+4YGfYH7k+nd7DOviTexeqUfzZoSZVH4kmbnOsWs2xRi3yo6ea6ABZrNpG21jweXtuc9yl+mryRQM8mZNiMWACqbE2pYD0+eGIFzu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242490; c=relaxed/simple;
	bh=GX7YkXipqVvNhapHqOCOlqcYy8wJxMpuPUZiPlNALwY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ddGgoOiqsYH900RI9ACNB5VLvyTF4WQmwrTXk4LzRq6G8F9WloSQ6uZQnv+5gOvVonrb1C5aEhMR+W9zEQj+u0vy194OrN4BvBNMMgSqH93fbsSbBxbLH+aF+sddGk2VYjZdXe9k7lm1RAoOhf3Lm8Fu9pMHV3H9hM2sJSpAq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+HAZ9Gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B819FC32782;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714242490;
	bh=GX7YkXipqVvNhapHqOCOlqcYy8wJxMpuPUZiPlNALwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A+HAZ9Gk5EAgN4jvi09arXDE5YjN+Q2DRHv3lRvsg25c34gfN7QdFwmJK5GWZWMRA
	 GWvsE4Kp/Pao7+LTwOgyXHDzK6o8PAWIuRjLuYkxfoT2hoJRXnqCPZSNo1W5KkOQFF
	 hcGhj/WcI2MjPQ8bBVedJ+Z94kW2TqUE32D3ANhudjX5mRliyNBYBfnTMq/zZUUVMK
	 xQ0Rv1BHQgwEh7q9UyAGzUrSEqsZYruf1AdtC/bFn5H1l4GJWJQmgz1gdKpYGISb13
	 JjkOQagGcaeXbLcldilAPEUfg0VN7BBcE9z71HfJwKdNpW3QrsUPCAy69VZoBhe5pJ
	 57mgfTDUtDOtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9B63C433F2;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiyOGDeHrj9d4r80@matsya>
References: <ZiyOGDeHrj9d4r80@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiyOGDeHrj9d4r80@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.9-fixes
X-PR-Tracked-Commit-Id: 63dc588e7af1392576071a1841298198c9cddee3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a5c3ef7dbf3f271cd4cb8f603dba749f0720651
Message-Id: <171424249069.21148.15670611428959239469.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 18:28:10 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 11:03:12 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.9-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a5c3ef7dbf3f271cd4cb8f603dba749f0720651

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

