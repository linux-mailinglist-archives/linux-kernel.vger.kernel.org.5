Return-Path: <linux-kernel+bounces-111861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D318871D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482E21F23880
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A05FDDA;
	Fri, 22 Mar 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQNfUMaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45F5FDAD;
	Fri, 22 Mar 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127769; cv=none; b=nmO2pYhK2OnOkk4vP1JiU3v2mgU3Abd+x4LrRXjGagYGt1ur9fmdFjBjcq44Klhu9rhqHc0Gj8uZq3SzCbVZB1Lq2cW2/c2QNUUrQSP7LxhbMmxC+ZJCxDEAPTTCQwusxdehb0N16hn9Xki6MOvzKz4S0StRwQ5FKYQExIP2iT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127769; c=relaxed/simple;
	bh=KKoeyKRYu5EF+/QOOH2RSCdR3edkxNlUGzD549tBiD0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q2vwHJPA6JGty2U78igBGD2FgZsaZqGkm12sRDWK4P1WGLn9wM4ZsW2tzstsn3HEoBkxQ7DDMyTsEUL6y/1WBt79gw1O1oM0YkBa1Ou2zKXM7zsBC/mjJlAfSTBF2+mAWFVRLbwuOhvl3Ua2aYGlMOQtfoc3a/j2HWygYpYaXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQNfUMaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8405C43390;
	Fri, 22 Mar 2024 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711127768;
	bh=KKoeyKRYu5EF+/QOOH2RSCdR3edkxNlUGzD549tBiD0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sQNfUMaR4Gm0a604FPRGoepa2HH6tdNkAmo/ANURf3Pv3ttu6vbMvNJ1AyP4HMMpL
	 tA6tJI4HEGZtRCebZFw5hd+GESC0Agq53btKNpOUoC2eq+0q7RlrKjmHXAHFRuvJOr
	 Q11r90y24212olCb2XyYNDKQZTEAIDC//AbjFc1qryy1zgl5ta8Xgu9IbEt3lIEZxf
	 KzUYO7VBkFRP1XCJoChNsQ5H9dXJ8KhyPE38TTpEAlswb52zi8/qs0oKwrQydftUbA
	 nBDE4AQgahV2K2du1jVz37EfPKTPV566WI/UAvACLmLlhOlNu+l5WENFkGmv9jVGx8
	 sr8knxcnPTkkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B572FD95056;
	Fri, 22 Mar 2024 17:16:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.9-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240322143210.054E6C433F1@smtp.kernel.org>
References: <20240322143210.054E6C433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240322143210.054E6C433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-merge-window
X-PR-Tracked-Commit-Id: a20ad45008a7c82f1184dc6dee280096009ece55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4073195aff08a62c364057bdaaf17a35d7338803
Message-Id: <171112776873.8613.10943522886612338627.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 17:16:08 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 14:32:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4073195aff08a62c364057bdaaf17a35d7338803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

