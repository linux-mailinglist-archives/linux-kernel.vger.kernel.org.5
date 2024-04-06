Return-Path: <linux-kernel+bounces-133737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A608289A7ED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E771C211B8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CF17C9;
	Sat,  6 Apr 2024 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnzJrivt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2A80B;
	Sat,  6 Apr 2024 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363338; cv=none; b=agkM1Zo8+NZqpg7uGr+YrMKNcJLSSmBD5qAyfyfg8wES+kVqOl8eOzet9ZEh7J2wTNnJ/nEhOnwMdAO/zR6bgLM9FJPA2LKUc4kbMz/b3LGt3ZbE7YnnUaU3/ZvV67nLYDyvdNd+gKM/0rq6/S4dZvuDFBrjxNiwCCJIX1857XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363338; c=relaxed/simple;
	bh=pSDYshKyWaBQjaOUqt5Xf6dNd6whkhBZknPvcEGQmQg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=so2KWMbQgSEPJHyfW2/643JUXYbIGQkvirhZfqlgBOfS+YcpIy2To+NiUjX7rI+R4uVKiE9K+wDSJkh3tx71kgE7jEbfQvGniudcCUqApZUXELl+vutaIH1rs3s3Gyf3O7EhBdOg27bfPUeLSk0VosfiwgHOyReWWMMHuZ3JhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnzJrivt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A19C433C7;
	Sat,  6 Apr 2024 00:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712363338;
	bh=pSDYshKyWaBQjaOUqt5Xf6dNd6whkhBZknPvcEGQmQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WnzJrivtZbR1ZvjoI1rz3gTPJkf1oYgI1eD8uu0PwIHXt83ARPRe1KhYo5TCp9cLD
	 h8CzAQb41IN+JQjcz3cRPERM+0vfoMXQJM0CnzUVQW8/C0QX2g8gIFPFoEtaG0WYrE
	 WiLvzEKFsZTyfmeALKVo+G3/f291E/jP16F5o8WPXwNzdekOXOxR2sL9Z7rfJJA2Bs
	 V4XuNnKAdtFEd6BH3SoUSzM3xc1T9V7++e7MV3KBInQvAf1yNxO36XwN+wEH50glQM
	 S+mmP3bSaGhgVIBOFGAxB+aQAUklC7OQ/8cNCsot8qlzM69c+uqOFT3ClvlsE4JE1H
	 FoR4wfAmbOmLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87E6DD8A100;
	Sat,  6 Apr 2024 00:28:58 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405222106.6E94CC433F1@smtp.kernel.org>
References: <20240405222106.6E94CC433F1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405222106.6E94CC433F1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc2
X-PR-Tracked-Commit-Id: 1f886a7bfb3faf4c1021e73f045538008ce7634e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 104db052b62d3320fd30b23416dd0b2a4ff3b85f
Message-Id: <171236333854.12657.12086117721672488474.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 00:28:58 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Apr 2024 23:20:57 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/104db052b62d3320fd30b23416dd0b2a4ff3b85f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

