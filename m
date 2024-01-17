Return-Path: <linux-kernel+bounces-29397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D790830DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E5AB24E03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278C28DB4;
	Wed, 17 Jan 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9aaT8lP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C328DA0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521837; cv=none; b=TfiC+Fahuaigk9sTVvDUfAerpI9Z6geHcde+I8CKupgP1cQIY1DJFe75MPz5EUugUEweGHEqkQsKo3rbMnXx1SQZ0R8zDCAQPkXLXVCdtle6Pr7y74fRJph5ZR2rgpJEVQlXwk9aIio35oDqRCEawjdWpqMhTODV3BD/goQGbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521837; c=relaxed/simple;
	bh=fHpO/eFLMaHEoilwWrstKgvf4ZVa3JO7a3zprxvJnBE=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=aA0jZ3HuPGWwNMJy5R0e7voEGNUr1/mtguEI150YZPOuy3pF5rAxOVSXJqd2lKRt+3GharP5HtrDmO5Nr3JEepKqXJxYpSjnmRjSLnJweONx4Xtk69mkfH0s1NOUyJ42egTDjGZXuxAMTZBcwY1dj6l0yMIQWkNVgoSgqDp/gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9aaT8lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C65C43390;
	Wed, 17 Jan 2024 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521837;
	bh=fHpO/eFLMaHEoilwWrstKgvf4ZVa3JO7a3zprxvJnBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D9aaT8lPkDNuQlaCMB4KSMTv7Roc112T5Z1G1uyYPthYCCc6iqhzUKSw4u/72neGX
	 IAd6sXUgrutTYNGmPsTlubJPoGXztpaLuZZsnI/38si5KxFkRWo/sxJ7/RK+UqGM+v
	 nyi0G5BFazz4FO9mIhMOzwtYqz42QSpMIesCa01fkmNg4OFXEoLGOlAkiY5Iob6/gJ
	 9PKEiSajYGNp94qEgjbtiep2AhCZz6pcwueICd0Spf6EjQ9swJr3pZuNB5bCHD27Qm
	 3bzMk12ZLsI0anWz0CA/iAGV1GK/JfPilWeDLHoJHlq7kw/W4c53uX4329XY7p7XEO
	 PIcJiCNSY489Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2C7BD8C96C;
	Wed, 17 Jan 2024 20:03:56 +0000 (UTC)
Subject: Re: [PULL 0/4] xtensa updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240117112933.303593-1-jcmvbkbc@gmail.com>
References: <20240117112933.303593-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240117112933.303593-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20240117
X-PR-Tracked-Commit-Id: a03cd7602a090eae277d2b79d43925661e7fbe9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47ce834fbb6ce6cb9e802f651b647b8030c5fc7f
Message-Id: <170552183692.2985.12185900710054151267.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:56 +0000
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jan 2024 03:29:33 -0800:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20240117

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47ce834fbb6ce6cb9e802f651b647b8030c5fc7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

