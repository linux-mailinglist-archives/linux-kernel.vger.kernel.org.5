Return-Path: <linux-kernel+bounces-31575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3786833043
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BB51F23C36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFC15A103;
	Fri, 19 Jan 2024 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBrksAes"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842515A0FC;
	Fri, 19 Jan 2024 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699652; cv=none; b=P3z/K6ZUpeMf88wQ8J6lcEJ6dkDi1qMn1wgrrr01SjJmO7W+s27rasyCx4JGhpTUBRhc7/XnMcidg7hhDH/nni6JGNMhHg9KMkHJjFmiNnygrDuPCtZBB/H/I06cQhaQKnR4WHll8hUZEQRLzlPMADbzCSBYjXss4D8LtojQ+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699652; c=relaxed/simple;
	bh=T334S9SnGeJYV1sT5w/JaZHRqzOFCM2N93MbL9Z3PyI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IEYvE3f8XZa9JInLgstGvaRjqRku+K52x9eHpEPQrkpdLFWu9nB9CNFDnoH/PusuCqKdVz4d3fLfTtGi5xEg+IiACixlYdLZW1qfO+WE/jWFV7oWREJ0X65hCBwBCHdS1HV3Jqabc8EhjPnFONZaeu2kcuT+QyvyIpWPvEUPdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBrksAes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D39EC43399;
	Fri, 19 Jan 2024 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699652;
	bh=T334S9SnGeJYV1sT5w/JaZHRqzOFCM2N93MbL9Z3PyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CBrksAesiw8rESvRFl68lQwfIirk0lau+IdgP9g+Wgi0VCOVZiIGDdiw2NxWDhRX0
	 7WoMhTuFlvdelGf97Z1U4ZoaoOIxxs82I/eOpN5Bnc5eafdTmhmEM/iNLZSI95FhvB
	 uHzn1oAOIr0rndENj5NoYux3mJXkVSrK9OgzzuFU7XRnmngmD4xYW2y6ve/BFobFzV
	 ti8PwBRBDGlHi9jeAO93KiGvI2Xzq0VkK6xTzdzBWuqPsbR4ZJMBicfQT96pv9IiA4
	 OX6XxB9jVXF4dqg8D8R/orQJtHhfABBohpytD70CjCofm5DpxykHFjc/R8MutBFZtk
	 fWbuvknkKaHLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E502D8C96C;
	Fri, 19 Jan 2024 21:27:32 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <875xzps3f0.wl-tiwai@suse.de>
References: <875xzps3f0.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <875xzps3f0.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.8-rc1
X-PR-Tracked-Commit-Id: fb3c007fde80d9d3b4207943e74c150c9116cead
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1fe5b6d0dce12893f40f0f3cc4e3885456155fb
Message-Id: <170569965231.21908.13717268739359800811.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:32 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 17:17:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1fe5b6d0dce12893f40f0f3cc4e3885456155fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

