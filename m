Return-Path: <linux-kernel+bounces-69392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C96858861
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCB61F22A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA8148314;
	Fri, 16 Feb 2024 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc7tf0Gv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137812CDBC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121398; cv=none; b=ppQajCoj+06nANKdMvfh+xS/PiRj5UktwjT81b4mXGEALPd3z3doi3VRo692tG5osGQufnIvEeA5MpgH2qhbsDSW0lYL8teo1V0q1RENrzy2GBjhjloMdqfkudjP4MSDjUU6UnXrbklWaTPFPayu0qhPUS5Ixv/eGoN+mKXoiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121398; c=relaxed/simple;
	bh=hLsVDz11kOvowhJinmUipU0nF3DYPUZq4fnI6lYsz3Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MkKjQMVJBAR97P4vRf68BoS81BjfbW0TLyMnTFBFGY6P1qVmBm8bqmS+WecCxtoiE03oR4vsmMEIGcxBcfShrBe9DhWjXex8BFE/d9HvwooY86SuMZmY81YVoJE7pfbkTdeynYcTzL2w7a9QRpuqNd4YwbMnTY0wRYerd3oYrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc7tf0Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5474BC43390;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708121398;
	bh=hLsVDz11kOvowhJinmUipU0nF3DYPUZq4fnI6lYsz3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uc7tf0GvDt6lxrb4cECyxdCjQaxOn1QIhkxy803iOTFZOW3DBA0HAdiZyedgsSapB
	 +ttf5wf+Xp867/9EBHJmO/aOfFp9VDhoxz+xLXNPXmN1aSi3VJ8QIl0/rnxTcfk55T
	 7r2rjaAinpuIWKnGv/35kCpyDnk5ZygZYpNLWoat/aNiMl0ktRKRogKoZOSU8+cPeH
	 88gM2xjlIztzI9X4cOerdk7nmhdz2EPMrD2Txp5zDMLRuoRvN0kbtrA+QIkIPqtZHb
	 7auU1DVe8dLFWKR2EiGm71F1a8BW2HYkbAkmjm6zhTWftwP6VEAlgyZQ+4vgCgGBqO
	 5RHmnLd8U0ydw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40BCBD8C968;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zc_VR5qdSuLcmL3Y@slm.duckdns.org>
References: <Zc_VR5qdSuLcmL3Y@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zc_VR5qdSuLcmL3Y@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.8-rc4-fixes
X-PR-Tracked-Commit-Id: aac8a59537dfc704ff344f1aacfd143c089ee20f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 975b26ab307e30e7ccec2a83eae6c017622a9125
Message-Id: <170812139826.30067.17385439079567388529.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 22:09:58 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 11:36:07 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.8-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/975b26ab307e30e7ccec2a83eae6c017622a9125

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

