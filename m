Return-Path: <linux-kernel+bounces-40716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ACB83E49A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A1AB219DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC755786;
	Fri, 26 Jan 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNqAh1NY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C354BCE;
	Fri, 26 Jan 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306731; cv=none; b=Ez7Uc3oSRYZLyvUGf9W6iun5yHGXXygfIj5yDKLNJIqTNl8Jf1X+N7mG2+Mp8R0k4Sqosdun5tMZfef+/kOQbxjJrOnCYXgIY9hjrNXhKa2YYJ+xAjLz4ghfRyK3fVtrxKh2t4WDc/5EOMznMJs2cXu/8KdTFmmUr/yfiRDAfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306731; c=relaxed/simple;
	bh=F4Fwrn+By4jMIBia9EfldqCIL2L4ksI+J1FUUAaupy8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HIxsmRNv9iQZJyOqM4QxZq6JETM/in3iNg5qjlmS5ha3ol9jhUCfLqSGWUv0WFLxSQ3y6sge3KOfwimKDphGamcJipz3nM11zgGKuKWcvyd8FWmhsREplQeRyH+ljkjNOM0MEnUisAf0bFfiI+/ZARoHargmMbGl6OwS88ewXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNqAh1NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 922FCC433F1;
	Fri, 26 Jan 2024 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306731;
	bh=F4Fwrn+By4jMIBia9EfldqCIL2L4ksI+J1FUUAaupy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NNqAh1NY4a5qXkIJu9L3wd6pQlATJNKSUAKScaptgNh9GJRzCMcYU3Mg+FPRY1iA8
	 os26qVqxxg8PhJ9QKHcRltW48akusXpK11yYQV6mrygNMGVGTpWBSJkghu9N0NjN4u
	 Sh62Mt7dCYOTG+VNWGvypMgRB+DBXlErACdAEnN7qgEHhPCnHF2ttvflxH6u0Kihfz
	 UWMy1obZjyT9w8SP2q3AwqIRpQn9BVNmnycq+zMVl9BWGvvpiX1/Kwy9MgAanml1RL
	 Gaj0am87Szb5TTd5i/RdxwohZLq8oFxzYkgSFsHIFoNfQaOEMt9X6U0qtpyoNk6xVC
	 N5NP06fOJnyCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 739C2DFF765;
	Fri, 26 Jan 2024 22:05:31 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240126173821.05BA0C433C7@smtp.kernel.org>
References: <20240126173821.05BA0C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240126173821.05BA0C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc1
X-PR-Tracked-Commit-Id: 8c2ae772fe08e33f3d7a83849e85539320701abd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48fa8ec61569efe122ac92694ce6ff4324b61bd8
Message-Id: <170630673146.20742.5703610997284516942.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 22:05:31 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 17:38:11 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48fa8ec61569efe122ac92694ce6ff4324b61bd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

