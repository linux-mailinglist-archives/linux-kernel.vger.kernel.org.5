Return-Path: <linux-kernel+bounces-89071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9086EA31
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6822DB25272
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B23D38D;
	Fri,  1 Mar 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVkCU4D5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409A3D0AB;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324247; cv=none; b=W514p44bXtzJK63eNP9JOb01bcDY0mBojpmJ9Ad7Jgbroe72p3m6IvOW6+hyS9u4/RvjFiy02RDyw5PTfyfKjt0dDFlMxr8syQYOItToms85i/CniVrqzkJTDmno0az83JMpTC07UKq+5UMzO/aW3ZOZ9sFeMUmIx9ErCM4AsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324247; c=relaxed/simple;
	bh=u66KCKZlxVizY/XMuPbTaejzZ/ZmbtwKzO1HReQDr5I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZxfLMyNeyD5kJUCHd2+wajf3hg93RvskQWmdVIPJBitT3OG92u83nZ08XcbLuj91hHIPnHZ4rXOWd9A8fuKxlqPtyafubJZy5ytaqck9WB+9bpvrDwKn10Dszq6ScaReOZcoFD8P2bMtx/2JJxMRQPrHfSzYjV3ySak1j5aKQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVkCU4D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DCBAC43601;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324247;
	bh=u66KCKZlxVizY/XMuPbTaejzZ/ZmbtwKzO1HReQDr5I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dVkCU4D5/loaOYSA3QBxoHRwN5xIaoDSPTm1KmLkzsC4NwDML5AZYz2HzNsjmKOie
	 0LAKGWGUxGj0X3gnpu/zSC6MNf+Tyzfh73g8k3vhiV546PoIDPzInSYegYwIUV4Ybx
	 y2A0anoeiZQL3T6MZFIGZDgWfhe2nk/JXYI6B38dixuLjfAPhUF3hgQljNeDmX1q73
	 2uYRZAHrkfHBSgz8jO3rmlCLeEPHjVQ4qsra66s22HIrposrK7BIh7MSbMM/bQ7zGR
	 pB5BFIeSxJLrTCFww5W4NMpzjRo4s2bAIebJVDmsXReQY/1Ubs7ZdOpjfRbHpFywr5
	 HaQT8QqIWXF8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 434FBD84BBA;
	Fri,  1 Mar 2024 20:17:27 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h6hq5jd0.wl-tiwai@suse.de>
References: <87h6hq5jd0.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h6hq5jd0.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc7
X-PR-Tracked-Commit-Id: 17c6a0c986fbea2c09010c39ef4b44334f06e390
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbf9e3b6978bbd350f2a4c81e112431610dd065c
Message-Id: <170932424726.25962.2013727115675520845.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:27 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 01 Mar 2024 11:36:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbf9e3b6978bbd350f2a4c81e112431610dd065c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

