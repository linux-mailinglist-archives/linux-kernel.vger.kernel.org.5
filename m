Return-Path: <linux-kernel+bounces-89547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221A86F1DA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6069B23336
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778C36B16;
	Sat,  2 Mar 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQbwShuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F236AEF;
	Sat,  2 Mar 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403740; cv=none; b=GKFHqQZbwaYpQcsP5NDaraK+Z32N55j20x8Ot6vAKutR1p6reFB/md5mEmvQ86axvOWYiUGF8mFZAsrDD/nff0jrZw2644UHwYsgBC9MdJ0nkkupSP1BW36/qGZiq2Ngik35NBO0fcpZHUT9a2E3RK2OCsWtP38eyNFeQNF3kNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403740; c=relaxed/simple;
	bh=EEBj1zdMva9LX6TZaViZ2X57np1ryAMGwfbZwuXXZkE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AnM1iv/lZ3r2D14imIYGVcmvQXkhldO/1vgZ0q87YDC0Vt2/YLIadCe6m5BZfgRRNpzwPzsmL2tWcX+JQrLR6YN+qxKAWhN857PEA7nWlBgqHgjZ4LWwsiftPepZjMvXo7Gygg0A/OteqQDopr4d01HWuX1JKAajno4BC1xJG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQbwShuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81B7BC43142;
	Sat,  2 Mar 2024 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709403739;
	bh=EEBj1zdMva9LX6TZaViZ2X57np1ryAMGwfbZwuXXZkE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GQbwShuBVQHEb2dHmYW1bnRq7YRDHdbVn9vG/KmBEtNgN/EvYUabkAt5Pvtgb93bQ
	 qNAuvtEwd/i8Eo3uYZLRDK1Os4AYx4E6kHk2VnsKwyQxkFcHV8qzqRT+PFnTA/T6AC
	 Jh9n6d+2LJox81xGHzs4P4T7GrAHuqaZiATWkF5X8aLH7EoBOJ7d5IBLWXF6EJYKum
	 qctJL7FbycVPhPAby5qxMGbJEsu49o+v0eG7KPLEhIGTTdGiH59jaeU56M7qvqRgWt
	 or6sjGdH7KEEqP+tqgXxVsh7HKY4u/gcdO0DdncweeeHcYcfj+MM8uF3jPO2SHUwU9
	 L9mJrrpFTpU2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FB7DC595D1;
	Sat,  2 Mar 2024 18:22:19 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.8-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240302103449.4313-1-brgl@bgdev.pl>
References: <20240302103449.4313-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240302103449.4313-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc7
X-PR-Tracked-Commit-Id: ec5c54a9d3c4f9c15e647b049fea401ee5258696
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 705c72567be6a31a73ce57fa6a2441498479dd71
Message-Id: <170940373945.2799.1277110762014734687.pr-tracker-bot@kernel.org>
Date: Sat, 02 Mar 2024 18:22:19 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  2 Mar 2024 11:34:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/705c72567be6a31a73ce57fa6a2441498479dd71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

