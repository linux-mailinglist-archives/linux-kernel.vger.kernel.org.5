Return-Path: <linux-kernel+bounces-85587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09386B806
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD646B240E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE037442A;
	Wed, 28 Feb 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk0vw04W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A471EB3;
	Wed, 28 Feb 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148098; cv=none; b=ZAWzsLEcMbhT3dyckZB39kHjRRq3e6+cyeVzHh0NIUWga7MtyHg8HVKkTl80j6UFzuG449DnIivzKANNyGLbMRl/6PM2gbj255Z0tg/eh9wobpIhHAGCzkqkSjVlLnDpVfetoKG+csjPKR4DTrbPIxd3HcVOzRHLSTdbVP5Yk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148098; c=relaxed/simple;
	bh=1zUk8GN1rTSUaW+6rW4tts4ETzpcq7/TCg9O+DiRrbo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UmPGO9NqJvxMbqjMulQKHbZvl9rl1TxluBxobg0liMPEIDwTMHg368EJGReNkTG6MuUepa0vJkvI61t6qxNExxWu34eHayVvMqif45jfTJSoCRtke7ya26wwsDzNS8RA7EmqN/TrRsWr43MnHN0PczivMMnz2poMCGk+Addh14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk0vw04W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D9BC43390;
	Wed, 28 Feb 2024 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709148097;
	bh=1zUk8GN1rTSUaW+6rW4tts4ETzpcq7/TCg9O+DiRrbo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fk0vw04W/KxJrVFY09qKlGIp07RdqtlbSnpC4QagG6P+4UwozCw2CEBskiBm8EBjz
	 lkGr5NiFVhWfwfm85JComgjk8uoypr8KxaqNdf1GpRSMT56vSh8ooOQ0dAnqQFNJjM
	 4WHC2oWLuGQS4KalQt7x+qLboMLyngXf3rTiKQfM92QZYei7BpmaNhXgl1focl126r
	 jmZchkEOXhl+EX9/eWe8afMFIva2tkfGJcHCkD4Vdjrzr+zg4Elm8fyv89m15RnpRm
	 BUG51EueyRavwhySxkv4YkRWojoI/fn33wbzdhIZ4l8t5kjY8dWb25ZWZyMT3q50pl
	 M5qY9Th3HQHdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98911D88FAF;
	Wed, 28 Feb 2024 19:21:37 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240228180309.1C6DAC43390@smtp.kernel.org>
References: <20240228180309.1C6DAC43390@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240228180309.1C6DAC43390@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc5
X-PR-Tracked-Commit-Id: 6415c7fe7cf420fa469095a34d9153f991391116
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cf7ebef02e434c75bf8dc72e89dfc50c5bb41b0
Message-Id: <170914809761.8490.6386615919766086332.pr-tracker-bot@kernel.org>
Date: Wed, 28 Feb 2024 19:21:37 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Feb 2024 18:02:58 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cf7ebef02e434c75bf8dc72e89dfc50c5bb41b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

