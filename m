Return-Path: <linux-kernel+bounces-31570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8062583303A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F421F24067
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304B58235;
	Fri, 19 Jan 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+dMg9oL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB858217;
	Fri, 19 Jan 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699641; cv=none; b=sre+o01WO2NsA24CN8O8BupKLg498s84CXadqOyZjHQRL4ePSx3SCd+NYzEl3RpqjQOO4eB4F3yGd4x6M35xk8l2QUAetf3XYcAt7A0Vjb6RlYYTd1qbsVzGm+gtpi3MdgfbmjpZI9LyPUSLUUTELMCVINlQP5YXqtfbv79j/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699641; c=relaxed/simple;
	bh=LJftIOKGRLxBSJGdrDM1bRTCkKxyUo9WOJlz9wX0cb8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bjfwoOHCyAac46SjyZJ0wSotgCZxlYnY/XFjLl4kkW3IRY+DcGzyNrb+6SIHfNnne6lc0q/7Jna7h+7idEmZYgLwsFXAgDAY82cDePlE644vw47H3qfodHXh56EH3ekD4dp8PbLiF7ayVJIkFvLw7WjRzVPSYUfi8xphg8w3ndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+dMg9oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C262FC43394;
	Fri, 19 Jan 2024 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699640;
	bh=LJftIOKGRLxBSJGdrDM1bRTCkKxyUo9WOJlz9wX0cb8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g+dMg9oLAcJAuXzaps4iPjyTlBklaF7pb71NLT4ayVKcfI7Gl+wzA8JnVGoFKab+0
	 RW1+/AEDr2NinoZG2K73Izf8iEe+fx6e3fm6tSqR0W7ZGqTRz5nXDUKak8740GmQKi
	 Nq+CffnX4vh6B+06kJaxJEfzzPf8dmn17ufcK34/nUksmN4CoEi90E6DQ+Ta74MO1c
	 G09uez5P2UMSzhoVQV3bwZtX0V4Vh4YXm5iZ84ZPYjuiA4AmEbDK6ovYUSkOn+dHli
	 uKtOt27ICHTLkFSR98B2TXaElK4cMB/veV6aUhljw6AOAdV+QONHJQoqCOtcIWF9HS
	 /eDyqGHtlsaRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD39FD8C96C;
	Fri, 19 Jan 2024 21:27:20 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.8-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <b4ca66ae22c11d163170c92db6c2470a.broonie@kernel.org>
References: <b4ca66ae22c11d163170c92db6c2470a.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <b4ca66ae22c11d163170c92db6c2470a.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-merge-window
X-PR-Tracked-Commit-Id: 17dc11a02d8dacc7e78968daa2a8c16281eb7d1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a638bfbfa1f8e8fbf36d84679916c60c1382a2ef
Message-Id: <170569964070.21908.2992608654119923168.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 13:29:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.8-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a638bfbfa1f8e8fbf36d84679916c60c1382a2ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

