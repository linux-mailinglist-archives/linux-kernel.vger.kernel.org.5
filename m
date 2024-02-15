Return-Path: <linux-kernel+bounces-67611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03F856E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64A0288D95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EE13AA47;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbynkWgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C313A895
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026607; cv=none; b=Sf+Vtw1apqvPKiEkIp2MlIoM1JMx8T+FCAg7sRXt+OrQO06ThVdm8zKqb+Eb59bWy3xuab0AV/VYdBoXfhaOuhuqn0nAmgWd8lkswGLTLwYehe/LdQ9w1Q7HDI8WbXwvJWwl0w5U504qvMpnGJ3bEPefleRoOaLd4S90SwiDQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026607; c=relaxed/simple;
	bh=dYG3ZJdb1V/Ktyl5Eml5x37N/Z+k7Tqs1pUPFJ1zkWw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cPRD7YVatAPXJXqwTnMD7JvxKZmReSP5sQSG2YLgQvTMwpHwS1cVa1ylJtwCo/ED7Vr+yMpYxrDA6XTYV9dOV/d6S4z4XzY8jBN3aR89uXsuyrhGFyxnIwivxaWNyjpITbXoiGOllksokWl40AYBLvB+Wv3vhoASno2iRQAWIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbynkWgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EA3CC433A6;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708026607;
	bh=dYG3ZJdb1V/Ktyl5Eml5x37N/Z+k7Tqs1pUPFJ1zkWw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AbynkWgYYGbqxtjxaFZBHd++Mc8Qb0ySMGOmFZ1SpPbX+JcESEe64VJHAU7z+vQQk
	 G8z9bWyxi1QvSZHQG3o2CSwcPlFNFYwArbN26V0aO1S0FeT+fxUicoWfht+HxskhuB
	 VYSFdBT2RIon3xGhAgXjsMawx80pwB5ieIqKVKt3Kd+XrTTi5tgjGwtj4d5zR92Ufv
	 DwGJiu+FXYGU5NCld+z1sePz8Yo5ERhH8lSUwIFKqhjL82HM5zHkylAUTP+yD/psCT
	 pj7l7YZBS906+EBTL4fht9LVAHUZM9WL79pz3f+ydOjlr9zAc/3TSoxQVter8Z7T0L
	 zaRXNu0uVWp5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 078B5DCB6EC;
	Thu, 15 Feb 2024 19:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240215152426.1114-1-jgross@suse.com>
References: <20240215152426.1114-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240215152426.1114-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.8a-rc5-tag
X-PR-Tracked-Commit-Id: fa765c4b4aed2d64266b694520ecb025c862c5a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc9c4f0b3113d513a94bcf489f2fa8cb9cc7c679
Message-Id: <170802660702.17476.18029040592555930591.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 19:50:07 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Feb 2024 16:24:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.8a-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc9c4f0b3113d513a94bcf489f2fa8cb9cc7c679

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

