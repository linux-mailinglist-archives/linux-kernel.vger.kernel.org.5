Return-Path: <linux-kernel+bounces-30674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B578322E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AA81F22D92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCD53AA;
	Fri, 19 Jan 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASK+XrzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B253C39;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626526; cv=none; b=qrWKqEnJC8ZXeH1/p9ssUrr5cGTIn5H7InU8R2Q61pDTbKEFR1rus4pg1mmAZ009qYJu2TC8uj3MRWQzQWKdmYZQDBSX9gwNnrsAHJPI/6xT9pSCclIE/Z4DSuBnrE/yKD2QqzF1cX/WraYW44OpamAi16Kp9Jitm76W7vdWtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626526; c=relaxed/simple;
	bh=AEUJrzOE9p7H0fEtl5uEGx7HNFtNdbNWoj6DowuaGK0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f5y6W1jGGXUk18FhcZzG1LmzZARXIAPFwmSLDdOHHp0sbaB4lkEqkTYNjyzFBzv3yCrpTM/5K95uzB95W04wOOWPG+37hLMNZ7xr+/YXzqOuJBvzTMeaOgrvUylI3vdfplmM3rz9EcqdSfj7l02UQdJYd6PQM5d9e6Jtt8H4Fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASK+XrzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80825C43330;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626526;
	bh=AEUJrzOE9p7H0fEtl5uEGx7HNFtNdbNWoj6DowuaGK0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ASK+XrzPNgxAWZc0YxW2o/JydzN3ZaEnOA2zNt+8p7f5sJhtzoTpwGd7bOTuBMo01
	 z64RjqCIerQobwvpZv33hhZQmK1M9BX9HK+buTm4iNiEbM3pTQt2w7jQSlRx/3pbEf
	 Q6gRoJxIiJC/yLlxrTqzNUcqOypMmPkxiR/JqkCMuEAr/YU7ooLGa3wFJtsH+LPXwB
	 jmofaURdirRPJ6zK+AxVgJSYlq0ZnaFVCC+5ZGgkTTgXN6ncU/mO7L757eq6hmU78C
	 ViEVU3387rqaC444ZZoBvO3FEd0s08Q6kh98V/CoF5hwERGQ3vjo+q2OdhFVyJ8yiW
	 kdnhrAWg+3ZQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E956D8C970;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.8-rc1, take 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <sbjugedbn2pyqcskybmxj2evju74ldyiwugnjpu4u5ln7ufrfj@m7hi2ie63aai>
References: <sbjugedbn2pyqcskybmxj2evju74ldyiwugnjpu4u5ln7ufrfj@m7hi2ie63aai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <sbjugedbn2pyqcskybmxj2evju74ldyiwugnjpu4u5ln7ufrfj@m7hi2ie63aai>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/ukleinek/linux tags/pwm/for-6.8-2
X-PR-Tracked-Commit-Id: 9320fc509b87b4d795fb37112931e2f4f8b5c55f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c93506983626419fb8719a7301b53faea1e0bb3
Message-Id: <170562652643.16604.12780670274036663422.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:46 +0000
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Young <sean@mess.org>, kernel@pengutronix.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 09:29:10 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/ukleinek/linux tags/pwm/for-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c93506983626419fb8719a7301b53faea1e0bb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

