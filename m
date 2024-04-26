Return-Path: <linux-kernel+bounces-160569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BE8B3F47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84CA1F25359
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52AF63CB;
	Fri, 26 Apr 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E875Mywz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD394687;
	Fri, 26 Apr 2024 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156264; cv=none; b=r4RuuoN2JXve2kkZvsMLlCrTX76zSoWq6ImQ1gIs49G25VRYEfLDGpmS5qM6tStgfCDGqqLPTaSZKoidmJjZqBB4QE3W3imbS5rM0TPQXp8XWaPYWJNzvHN1h+8p4xAARQqm5w/MAg58zPOus9Ph/TCm+EU4BZoL30xpzX0L5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156264; c=relaxed/simple;
	bh=8i+/2ouwDRFdsyYtF+LgdNL4RjHrkFdz3G2OnYCmtvA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e5rJS4IJRqhkq3x8fqF8jSv5F1Mzet2uMMQO46Ueg7BANz/5OijvQsu/zb32eCYnue5HjCqYu+cz5gaTKQ5nNb5BkyapXn8/jKMaaWoOwCNK0lsGq23svCAyBBX1buXPE42WMGfKWTDgS6h8FLyCNz7gG6i+e1HFyU5dFb9KW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E875Mywz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D5AC113CE;
	Fri, 26 Apr 2024 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714156263;
	bh=8i+/2ouwDRFdsyYtF+LgdNL4RjHrkFdz3G2OnYCmtvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E875Mywz4pGwfYJj5H2ERgiyFRfyztRLQyouXB2jBj0mElAutdu0zARJyuVSVTDuL
	 XWV6hcTDiuojuM6bU+XfHysaUxvfpm5AXzDAuQbwf3a/KMAqXUNgGTjEWc6VHK67/b
	 Zz62kV7drMVunmRWz/IXAXe1dqfRgo6i8BVIfz+yQPj3uqzQxHBeRX1MUenax6KaWW
	 0377DRmQZiaW88UG4ZUyUVk+dPLQVUlx8JeWJ3/+X6wQlujHCQYcJuQe84VIu9kPSl
	 ykgIIlr8MSuRZYpnNVyr6XBIFmDUGXV61/uUBMaG7SAiPQbu00dGbOPVrDM2woritf
	 SDqIa87ICU5WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA693DF3C9B;
	Fri, 26 Apr 2024 18:31:03 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240426174058.28301-1-brgl@bgdev.pl>
References: <20240426174058.28301-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240426174058.28301-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.9-rc6
X-PR-Tracked-Commit-Id: c714fcdf5b75f63ab27cb5071747194e5ada2433
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3022bf37da50ce0ee3ba443ec5f86fa8c28aacd0
Message-Id: <171415626369.22135.16541190813873821059.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 18:31:03 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 19:40:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3022bf37da50ce0ee3ba443ec5f86fa8c28aacd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

