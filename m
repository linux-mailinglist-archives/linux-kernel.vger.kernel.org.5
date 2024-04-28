Return-Path: <linux-kernel+bounces-161553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3968B4DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88E51C20A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B896745EF;
	Sun, 28 Apr 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwY3GbNo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6B33C8
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714332496; cv=none; b=kywhJRHxDX9res5eMVreNjBKyb6ynjSqNZgyxRpSmaNa/RYd7lAStNzKovdg8VOpgOQlPq1vfzaulx+qngeJ0xqmaKwIXg9vC8fCGS+CMwB8/adti63zLcHzZM1wipQzvgGTYPC16gQMU/TTAF8Vq95UZ2ttQZ19VZ/u8pG8tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714332496; c=relaxed/simple;
	bh=ql0J0nd4llOx0q+PWkXUSJoBT3ncr/CKAsFtGNTXYew=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ONrdQqQJOEgMhOPHUE6pNIQSore+NHb7nT47vI7LLLPdfwTB7uNz6izirMcX8WoUlC41wAwdWTIjRpK3fPuoUGmsh6Xa/YJQVsUreL0CfQZ5NEYEh+c9l+RqpX1tuZRj8H3kZvw4rX7uhg8jVQ/9WwDGR3jhYGGFIN158Aa7Q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwY3GbNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43156C113CC;
	Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714332496;
	bh=ql0J0nd4llOx0q+PWkXUSJoBT3ncr/CKAsFtGNTXYew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EwY3GbNo4iZvh/oqQLbCO43hbv6x4ms2FHHsxqjN+WHTHz0G1As+XRp7MEgrNCuWf
	 HRWdueTkF/KxkhaiXkYjoPPSA58XjRSFcDyxIBxL3gfzc7TrHBORubw7AhIY261NEj
	 WwN7dLcb1t7ZA654b4qFTavYL2RYlWkwgf2SlOQ4FPF4E4+xIniUQdQfKsAQec4wIG
	 SND5gnggu6HtdxrelePvj1M3LNlIWMxPGIOI4z9/e1U9TxLDwttXC5Pp5BB1eIC5x+
	 I/lSAUFfSKr9m1ZtLlj+GBR0nBUmjisxrEGkWy8Coux4nqUxWzd1AggXoRIOs15lRB
	 VO0tj6msuS+iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36242DF3C9D;
	Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zi4DS9dFnKE45Huc@gmail.com>
References: <Zi4DS9dFnKE45Huc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zi4DS9dFnKE45Huc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-04-28
X-PR-Tracked-Commit-Id: c26591afd33adce296c022e3480dea4282b7ef91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d62e9bf287588c839b67e567c8b2b548e849b00
Message-Id: <171433249620.9908.7261599293276791817.pr-tracker-bot@kernel.org>
Date: Sun, 28 Apr 2024 19:28:16 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Apr 2024 10:05:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d62e9bf287588c839b67e567c8b2b548e849b00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

