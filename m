Return-Path: <linux-kernel+bounces-30675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAA8322E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C83A1F22F14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9C63CF;
	Fri, 19 Jan 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKqvJAmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFA4691;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626526; cv=none; b=lgqOe1cZfJK2UuKID9kp8h1B4BgwSgFt76pQG7YhsnW65NYU3CC0vN0khSTis1dA43MwkSCLq4JbQV1Un/vxyd933p4gMEgO5wqSqO0WZwPk82ogaW7TazDZxwjAKhEleDDRJnzKjbE/Oe+jJqKe6ZZ1yeR8rWJYC+YwIxjmYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626526; c=relaxed/simple;
	bh=2tESuBeyqSxy8aethgzap4Gqlhz6DuXSuVSWl0PK90o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SMPkgpRMerWs4cSbT3Qaf7j2qDrKVWnouWCZFS/1rmUTcww9Kp6/41WNh+JVeuxlbzk/7TcuwpA7+Nu5kwyPH262z5Kt+6qd7n3v+Eq3SyBMZLxzdJEia8UecRA1rG+F1JGkP1DU+yPc0Y4gGnt/vw7LIGMavsU8J8N0J8Q1qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKqvJAmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE39DC43394;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626526;
	bh=2tESuBeyqSxy8aethgzap4Gqlhz6DuXSuVSWl0PK90o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DKqvJAmoJij3SmrgIHjcbnFKalosArFY4niH0yAGIDWgQu8WudC6gI0dOz7girzk2
	 yDCVV/wDLCvSu0mMx48al28gFGSvebmfaIX2inQRPm4/fqv7g/CN1jHrcX82iCtAbW
	 EyxWmnvTnTerir6noPAyi2f/+RshTXRTCeCMOKIk+VPOksjD1Jy5sC/5H7oEA3gMHJ
	 51QgRmc7w9G7GYH4KDUz8ui+UmhJL/aSr59eIz7zpixIcDpuago7iKdroRdSlcZXha
	 QgUd2ITYSy1kNV1IfeDnDcMeft8ReCxbeJ/QfhCMkJ3p5YvFzvPT4BGT/VCXfRbHYo
	 K4QsbS/RQugew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EB1FDFC697;
	Fri, 19 Jan 2024 01:08:46 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240118125315.16778-1-brgl@bgdev.pl>
References: <20240118125315.16778-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240118125315.16778-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc1
X-PR-Tracked-Commit-Id: efb8235bfdbe661c460f803150b50840a73b5f03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 345513583974110107300824375a91ff602d72ba
Message-Id: <170562652664.16604.8253258055428087382.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:46 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 13:53:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/345513583974110107300824375a91ff602d72ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

