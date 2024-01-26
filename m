Return-Path: <linux-kernel+bounces-40715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B183E498
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8648C1F2197D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56751024;
	Fri, 26 Jan 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy3Qt/4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44752F96;
	Fri, 26 Jan 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306731; cv=none; b=b+XCKCq1sojdNmWmjekr48D/B6lB3cwYnnATKnlSS5fzhdwd7IQ5WinfYVc3J+Ghow5bYvRnElJa8tIgNNzv6hpfS2tutUFiSU8WpS6Wdbk+t2eOHFLpmQ5TWmvfOYqdY7wQAtMR6dGWNppchPbI4X/n8/y6mNuArUqsP8dmtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306731; c=relaxed/simple;
	bh=kRiK8lfwsy9lh9OLwGQZZQfczyEtM/lSnRydeOYhHZw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ftXghF9GCroG/aMyQCfUNlSGfZKTiYkjxxMmFSukwsPYNsq0b0vIABgm7H4x3waG8mrc9jRWUlveOU6ZPUR2z1LbW8gVGyfVblw5JIsZbbQQo8C3sPvSqrOYRnyQi9cNH+4I27umqZ6ZWeUbsHkkmsbP4CL72j25NzNYwCOFadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy3Qt/4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6278C43390;
	Fri, 26 Jan 2024 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306730;
	bh=kRiK8lfwsy9lh9OLwGQZZQfczyEtM/lSnRydeOYhHZw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zy3Qt/4C2dwL1ay2VLBRYL7xG6J8rNfd/hbxF2AQTjxQ3AjrImfhMbUl2yboHjIBh
	 9i++qoYoNzPkgU0jFbbQHpteBwNGBc+6bdupI19lFAAMJSNX/IG/yEm2twFrxVcGyZ
	 w4acEqporEbm7aSJhm5NDLhvRC6r4FWAgH6FhKjZeapGo2ddBGtVMA6QETVCeW09Gt
	 EDje+YN2hb+zALMG68zuncjtGcfb8NNeY1H8542l4RBkBlDXuXwX4FzQkMoxx6Lj4O
	 ug+jDqSpPLLDF5jTobcGVJ7Yspaskk9nIeoJ3Ayyl9kttmr/xvd+4xjpNsHGq10NNL
	 h6gBr/rBRMmsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B638BDFF760;
	Fri, 26 Jan 2024 22:05:30 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240126123405.35367-1-brgl@bgdev.pl>
References: <20240126123405.35367-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240126123405.35367-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc2
X-PR-Tracked-Commit-Id: 84aef4ed59705585d629e81d633a83b7d416f5fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f91b9ba5acada5e56c874af82660d29a7f84e25
Message-Id: <170630673074.20742.5206425869654337908.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 22:05:30 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 13:34:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f91b9ba5acada5e56c874af82660d29a7f84e25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

