Return-Path: <linux-kernel+bounces-111858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643748871CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965B61C212EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523A5FBA5;
	Fri, 22 Mar 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6gOCMrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08785EE78;
	Fri, 22 Mar 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127751; cv=none; b=O1+Q1hzX0CtTyPXvyDv5xiis7vVXk1kuaQwmx8gp7dpyW5WrUBinLnP+UhkZW19jqC6E+DfJ2FS2NVL6jpADDBFE98fsqTODftsUtUxlhBoIHn0wdKBsowcLJAGfFGjf3Em1BNCw12ZEZRwjnBkJVVU7UOCiZJBn+NM3dCrtnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127751; c=relaxed/simple;
	bh=VGAtW9BmMYY7brh3dqFNfHuDTNFnNhf7D4jZ+WyAnXA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MnePbUJeeJ+5eXnNhFzHeZsn13Y37eFUWT+D35LOaRj3kizBuXgidsJPzk+1Si/EVYsx6NYiB+rMDjQ606YE43N9EkltovxHnCTOqCMklTp072I3MM/wuolQhx67c3/ht3tQPpFspyDiEGbqUuPBpBGHSmG2NrYsswxTy5r1tng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6gOCMrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A79FDC433F1;
	Fri, 22 Mar 2024 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711127751;
	bh=VGAtW9BmMYY7brh3dqFNfHuDTNFnNhf7D4jZ+WyAnXA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i6gOCMrdHDY8Ho2avFbBMUsTsKkGARMAI2wEVzQpoqIgnG5NQctkZFiNUpPjufqmb
	 ZfDuEWroqYNTO9D7qHIc0oqj0ea+rKqJdE0PF0bvYdsfhNSbgpsmZTlIBLipyLLEAs
	 /LbD6koJf39ZwgPICU4e4bVocqaRabX4mBl5mbbovn6hHdCJfvg5MN/BFZTLydkHx2
	 NN3H1Ienal9zmRuwUt/aMa1u9wS0EvrSGVBGij9Q+qXY+50+BYADveEdtXtatcX1r6
	 2j3aYC/08cUVipk2vL1h3SXsLbTbgfBdGcKPi+E7QoKC9Xp00v/liK4ny7aSqCyRj6
	 d0Wm23DSaTVsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F2B1D95058;
	Fri, 22 Mar 2024 17:15:51 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes #2 for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a5mqzmvn.wl-tiwai@suse.de>
References: <87a5mqzmvn.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5mqzmvn.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix2-6.9-rc1
X-PR-Tracked-Commit-Id: 9f2347842b526cbc2655068591fb0166362d2999
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b571e2676c8c2100c3395cdcb471c5ec6f8f98a
Message-Id: <171112775164.8613.665637922352036674.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 17:15:51 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 09:33:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix2-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b571e2676c8c2100c3395cdcb471c5ec6f8f98a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

